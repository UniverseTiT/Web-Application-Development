using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class BookingList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            gridBooking.RowStyle.Height = Unit.Pixel(50);
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/BookingList.aspx");
        }
        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ChangeStatus")
            {
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                SqlCommand cmd;
                int rowExecuted = 0;
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gridBooking.Rows[rowIndex];
                string bookingID = row.Cells[0].Text;
                string username = row.Cells[3].Text;
                string status = row.Cells[4].Text;
                if (status == "Confirmed")
                {
                    string query = "UPDATE booking SET status = @status WHERE bookingID = @bookingID";
                    using (cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@status", "Completed");
                        cmd.Parameters.AddWithValue("bookingID", bookingID);
                        rowExecuted = cmd.ExecuteNonQuery();
                        if (rowExecuted > 0)
                        {
                            string script = "alert('The booking made by "+ username + " is successfully completed.')";
                            ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                        }
                        else
                        {
                            string script = "alert('The status booking made by " + username + " is failed to change.')";
                            ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                        }
                    }
                }
                gridBooking.DataBind();
            }
        }
        protected void rowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = e.Row.Cells[4].Text;
                Button btn = e.Row.FindControl("btnChgStatus") as Button;
                btn.Text = "Completed";
                if (status == "Confirmed")
                {
                    if (btn != null)
                    {
                        btn.BackColor = Color.Maroon;
                    }
                }
                else
                {
                    if (btn != null)
                    {
                        btn.BackColor= Color.Gray;
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblDetail.Text = "";
            tblDetail.Visible = false;
            if (drpDate.SelectedValue == "All")
            {
                sqlBooking.FilterExpression = string.Empty;
            }
            else
            {
                sqlBooking.FilterExpression = "[bookingDate] = '{0:dd/MM/yyyy}'";
                sqlBooking.FilterParameters.Add(new ControlParameter("Date", "drpDate", "SelectedValue"));
                sqlBooking.FilterParameters["Date"].DefaultValue = drpDate.SelectedValue;
            }
            gridBooking.DataBind();
        }

        protected void gridBooking_SelectedIndexChanged(object sender, EventArgs e)
        {
            serviceList.InnerHtml = "";
            int selectedIndex = gridBooking.SelectedIndex;
            if (selectedIndex >= 0)
            {
                string bookingID = gridBooking.DataKeys[selectedIndex]["bookingID"].ToString();
                lblDetail.Text = bookingID;
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                SqlCommand cmd;
                string query = "SELECT " +
                    "b.bookingID, " +
                    "STRING_AGG(s.serviceName, ', ') AS serviceName," +
                    "p.total, " +
                    "CAST(r.comment AS NVARCHAR(MAX)) AS comment " +
                    "FROM " +
                    "booking b " +
                    "INNER JOIN bookingService bs ON b.bookingID = bs.bookingID " +
                    "INNER JOIN service AS s ON bs.serviceID = s.serviceID " +
                    "LEFT JOIN payment AS p ON b.bookingID = p.bookingID " +
                    "LEFT JOIN rating AS r ON b.ratingID = r.ratingID " +
                    "WHERE b.bookingID = @bookingID"+
                    " GROUP BY " +
                    "b.bookingID, p.total, CAST(r.comment AS NVARCHAR(MAX));";
                using (cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@bookingID", bookingID);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblDetail.Text = "The booking details of " + reader["bookingID"].ToString();
                            id.InnerText = reader["bookingID"].ToString();
                            total.InnerText = "RM " + reader["total"].ToString();
                            if (!reader.IsDBNull(reader.GetOrdinal("comment")))
                            {
                                comment.InnerText = reader["comment"].ToString();
                            }
                            else
                            {
                                comment.InnerText = "The user hasn't left a comment.";
                            }
                            string[] serviceNames = new string[0];
                            serviceNames = reader["serviceName"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                            serviceList.InnerHtml += "<ol>";
                            foreach (string serviceName in serviceNames)
                            {
                                serviceList.InnerHtml += $"<li>{serviceName.Trim()}</li>";
                            }
                            serviceList.InnerHtml += "</ol>";
                            tblDetail.Visible = true;
                        }
                        else
                        {
                            lblDetail.Text = "Something error for database.";
                            tblDetail.Visible = false;
                        }
                    }
                }
            }
        }
    }
}