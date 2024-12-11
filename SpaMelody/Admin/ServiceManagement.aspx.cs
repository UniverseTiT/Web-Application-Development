using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class ServiceManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearchID.Attributes.Add("Placeholder", "Please enter the service name...");
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
        }

        protected void gridService_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selected = gridService.SelectedIndex;
            if(selected >= 0)
            {
                string serviceID = gridService.DataKeys[selected]["serviceID"].ToString();
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                SqlCommand cmd;
                using(cmd = new SqlCommand("SELECT * FROM service WHERE serviceID = '" + serviceID + "'", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblDetail.Text = "Details of " + reader["serviceName"].ToString();
                            cellName.InnerText = reader["serviceName"].ToString();
                            cellDesc.InnerText = reader["serviceDescription"].ToString();
                            cellDuration.InnerText = reader["duration"].ToString();
                            cellPrice.InnerText = " RM " + reader["servicePrice"].ToString();
                            imgService.ImageUrl = reader["serviceImage"].ToString();
                            tblDetails.Visible = true;
                        }
                    }       
                }
            }
            else
            {
                tblDetails.Visible = false;
            }
        }
        protected void rowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName == "ChangeStatus")
            {
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                SqlCommand cmd;
                int rowExecuted = 0;
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gridService.Rows[rowIndex];
                string serviceID = row.Cells[0].Text;
                string serviceName = row.Cells[1].Text; 
                string status = row.Cells[2].Text;
                if(status == "Available")
                {
                    string closeQuery = "UPDATE service SET status = @status WHERE serviceID = @id";
                    using (cmd = new SqlCommand(closeQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@status", "Closed");
                        cmd.Parameters.AddWithValue("@id", serviceID);
                        rowExecuted = cmd.ExecuteNonQuery();
                        if(rowExecuted > 0)
                        {
                            string script = "alert('The " + serviceName + " service has been closed.')";
                            ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                        }
                    }
                }
                else if(status == "Closed")
                {
                    string openQuery = "UPDATE service SET status = @status WHERE serviceID = @id";
                    using (cmd = new SqlCommand(openQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@status", "Available");
                        cmd.Parameters.AddWithValue("@id", serviceID);
                        rowExecuted = cmd.ExecuteNonQuery();
                        if (rowExecuted > 0)
                        {
                            string script = "alert('The " + serviceName + " service has been opened.')";
                            ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                        }
                    }
                }
                gridService.DataBind();
            }         
        }

        protected void rowDataBound(object sender, GridViewRowEventArgs e)
        {
            

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = e.Row.Cells[2].Text;
                Button btn = e.Row.FindControl("btnChangeStatus") as Button;
                if (status == "Available")
                {
                    if (btn != null)
                    {
                        btn.Text = "Close";
                    }
                }
                else
                {
                    if (btn != null)
                    {
                        btn.Text = "Open";
                    }
                }
            }
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Admin/ServiceManagement.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if(tblDetails.Visible == true)
            {
                tblDetails.Visible = false;
                lblDetail.Text = string.Empty;
            }
        }
    }
}