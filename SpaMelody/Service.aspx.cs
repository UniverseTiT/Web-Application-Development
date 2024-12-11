using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class Service : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string searchKeyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchKeyword))
            {
                SqlDataSource1.FilterExpression = "status = 'Available' AND serviceName LIKE '%" + searchKeyword + "%'";
            }
            else
            {
                SqlDataSource1.FilterExpression = "1=0";
            }
            GridView1.DataBind();
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = null;
            SqlDataSource1.SelectCommand = "SELECT serviceID, serviceName, serviceImage, serviceDescription, duration, servicePrice, status FROM [service] WHERE status = 'Available'";
            GridView1.DataBind();
        }

        protected void BookNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string serviceID = btn.CommandArgument;
            Response.Redirect("~/Member/Booking.aspx");
        }
    }
}
