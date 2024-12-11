using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class BookingHistory : System.Web.UI.Page
    {
        private string userID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
            else
            {
                LoadUserID();
                SqlDataSource1.SelectParameters.Add("UserID", TypeCode.String, userID);
                GridView1.DataBind();
            }
        }

        private void LoadUserID()
        {
            string userEmail = User.Identity.Name;

            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT userID FROM [user] WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@email", userEmail);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            userID = reader["userID"].ToString();
                        }
                    }
                }
            }
        }

    }
}