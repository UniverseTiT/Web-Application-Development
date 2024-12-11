using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{


    public partial class PaymentSuccess : System.Web.UI.Page
    {
        protected List<SERVICE> serviceList = new List<SERVICE>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }

            if (HttpContext.Current.Session["ddlServiceTime"] == null)
            {
                string script = "alert('You cannot directly access this page.'), "+
                                "window.location.href = 'Booking.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
            }
            else
            {
                lblTotalPrice.Text = "RM "+ Session["totalPrice"];
                CheckBoxList cblService = (CheckBoxList)Session["cblService"];
                TextBox txtServiceDate = (TextBox)Session["txtServiceDate"];
                string ddlServiceTime = Session["ddlServiceTime"].ToString();
                //DropDownList ddlServiceTime = (DropDownList)Session["ddlServiceTime"];
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MelodySpa"].ConnectionString);
                conn.Open();
                string strSelect;
                SqlCommand cmdSelect;
                SqlDataReader dtrSelect;


                foreach (ListItem item in cblService.Items)
                {
                    if (item.Selected)
                    {
                        strSelect = "Select serviceName,servicePrice from service where serviceID = @serviceID";
                        cmdSelect = new SqlCommand(strSelect, conn);
                        cmdSelect.Parameters.AddWithValue("@serviceID", item.Value.ToString());
                        dtrSelect = cmdSelect.ExecuteReader();
                        if (dtrSelect.HasRows)
                        {
                            while (dtrSelect.Read())
                            {
                                SERVICE service = new SERVICE();
                                service.price = Convert.ToDouble(dtrSelect["servicePrice"]);
                                service.name = dtrSelect["serviceName"].ToString();
                                serviceList.Add(service);
                            }
                        }
                        dtrSelect.Close();
                    }

                }
                conn.Close();

                if (txtServiceDate != null)
                {
                    lblBookingDate.Text = txtServiceDate.Text;
                }
                else
                {
                    lblBookingDate.Text = "null";
                }

                if (ddlServiceTime != null)
                {
                    lblBookingTime.Text = ddlServiceTime;
                }
                else
                {
                    lblBookingDate.Text = "null";
                }
            }

        }
        protected class SERVICE
        {
            public double price { get; set; }
            public string name { get; set; }
        }
      

    }

}