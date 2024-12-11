using iText.Forms.Form.Element;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static iTextSharp.text.pdf.AcroFields;

namespace MelodySpa
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {



            Session["cblService"] = cblService;
            Session["txtServiceDate"] = txtServiceDate;


            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    DropDownList ddl = item.FindControl("ddlServiceTime") as DropDownList;
                    if (ddl != null)
                    {
                        Session["ddlServiceTime"] = ddl.SelectedValue;
                        // Use the selectedValue as needed
                        // For example, you can store it in a database or perform other operations.
                    }
                }
            }

            if (cblService.SelectedIndex == -1)
            {
                string script = "alert('Please try valid selection.')";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Fail", script, true);
                Button1.PostBackUrl = null;
                return;
            }


            if (txtServiceDate.Text == null || txtServiceDate.Text == "")
            {
                string script = "alert('Please enter valid date.')";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Fail", script, true);
                Button1.PostBackUrl = null;
                return;
            }

         




            if (Session["cblService"] != null && Session["txtServiceDate"] != null && Session["ddlServiceTime"] != null)
            {

                Button1.PostBackUrl = "/Member/Payment.aspx";
                ScriptManager.RegisterStartupScript(this, GetType(), "TriggerButtonClick", "document.getElementById('" + Button1.ClientID + "').click();", true);


            }










        }
        protected void CalendarService_SelectionChanged(object sender, EventArgs e)
        {

            txtServiceDate.Text = CalendarService.SelectedDate.ToShortDateString();

        }

        protected void txtServiceDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void CalendarService_SelectionChanged1(object sender, EventArgs e)
        {


            txtServiceDate.Text = CalendarService.SelectedDate.ToShortDateString();


        }

        protected void cblService_SelectedIndexChanged(object sender, EventArgs e)
        {
            //section
        }

        protected string getService()
        {
            if (Session["serviceChosen"] != null)
            {
                return Session["serviceChosen"].ToString();
            }

            return "No Service Found";
        }
 

       

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {  

                
                // Access the data for the current Repeater item
                DataRowView drv = e.Item.DataItem as DataRowView;

                if (drv != null)
                {
                    DropDownList ddlServiceTime = (DropDownList)e.Item.FindControl("ddlServiceTime");
                    // Assuming you want to use a field named "YourDataField" from the Repeater's data source
                    for(int i = 9;  i<19; i++)
                    {
                        string sum = drv["count_" + i].ToString();
                        ListItem item = new ListItem();
                        item.Text = i.ToString("00") + ":00";
                        item.Value = i.ToString("00") + ":00";
                        if (Convert.ToInt32(sum)>= 3 )
                        {
                            item.Enabled=false;
                        }


                        ddlServiceTime.Items.Add(item);  
                    }

                    // Add the data to the DropDownList
                  

                }
            }

        }
    }
}