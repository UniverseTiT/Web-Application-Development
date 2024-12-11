using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa.Admin
{
    public partial class ReportGenerator : System.Web.UI.Page
    {
        private int error = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
        }

        protected void ValidateAndHandleError(bool condition, Label label, string errorMsg)
        {
            if (condition)
            {
                error += 1;
                label.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                label.Text = errorMsg;
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            string startDate = drpStartDate.SelectedValue.ToString();
            string endDate = drpEndDate.SelectedValue.ToString();
            string serviceStatus = rblServiceStatus.SelectedValue.ToString();
            string bookingStatus = rblBookingStatus.SelectedValue.ToString();
            if (DateTime.TryParse(startDate, out DateTime start) && DateTime.TryParse(endDate, out DateTime end))
            {
                ValidateAndHandleError(start > end, lblErrEnd, "\u274c The end date cannot ealier that start date.");
            }

            ValidateAndHandleError(rblServiceStatus.SelectedIndex == -1, lblErrorService, "\u274c Please select a value.");
            ValidateAndHandleError(rblBookingStatus.SelectedIndex == -1, lblErrBooking, "\u274c Please select a value.");
            if(error == 0)
            {
                string url = $"\\Admin\\Report.aspx?start={startDate}&end={endDate}&service={serviceStatus}&booking={bookingStatus}";
                Response.Redirect(url);
            }
            else
            {
                string script = "alert('Report generated failed. Please check the input fields.');";
                ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                
            }
        }
    }
}