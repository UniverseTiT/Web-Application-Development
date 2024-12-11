using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class CustomerList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearchID.Attributes.Add("Placeholder", "Please enter the name...");
            gridCustomer.RowStyle.Height = Unit.Pixel(50);
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/CustomerList.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (tblDetails.Visible == true)
            {
                tblDetails.Visible = false;
                lblDetail.Text = "";
            }
        }

        protected void gridCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedIndex = gridCustomer.SelectedIndex;
            if (selectedIndex >= 0)
            {
                string userID = gridCustomer.DataKeys[selectedIndex]["userID"].ToString();
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                SqlCommand cmd;
                string getData = "SELECT " +
    "u.username AS cusName, " +
    "CONCAT(FORMAT(MIN(b.bookingDate), 'dd/MM/yyyy'), ' ', CONVERT(varchar, MIN(b.bookingTime), 0)) AS LatestBookingTime, " +
    "COUNT(*) AS bookingTimes " +
    "FROM " +
    "[user] u " +
    "JOIN " +
    "booking b ON u.userID = b.userID " +
    "WHERE " +
    "u.userID = @userID " +
    "GROUP BY " +
    "u.username ";
                using (cmd = new SqlCommand(getData, con))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblDetail.Text = "The booking history of " + reader["cusName"].ToString();
                            cusName.InnerHtml = reader["cusName"].ToString();
                            booking.InnerText = reader["bookingTimes"].ToString();
                            latestBooking.InnerHtml = reader["LatestBookingTime"].ToString();
                            tblDetails.Visible = true;
                        }
                        else
                        {
                            lblDetail.Text = "No booking record found.";
                            tblDetails.Visible = false;
                        }
                    }
                }
            }
        }
    }
}