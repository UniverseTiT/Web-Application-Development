using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa.Error_page
{
    public partial class _401 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            if (Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Admin/AdminDashboard.aspx"));
            }
            else if (Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Home.aspx"));
            }

        }
    }
}