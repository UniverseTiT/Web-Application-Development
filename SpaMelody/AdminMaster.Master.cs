using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {

        }
        protected string getCurrentPage()
        {
            SiteMapNode currNode = SiteMap.CurrentNode;
            if (currNode != null)
            {
                return currNode.Title.ToLower().Replace(" ", "");
            }
            return "";
        }
    }
}