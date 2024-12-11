using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                if (Context.User.IsInRole("customer"))
                {
                    string script = "alert('You haven\\'t logout!'); window.location.href = '"
                        + ResolveUrl("~/Home.aspx") + "';";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Logout", script, true);
                }
                else if (Context.User.IsInRole("admin"))
                {
                    string script = "alert('You haven\\'t logout!'); window.location.href = '"
                        + ResolveUrl("~/Admin/AdminDashboard.aspx") + "';";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Logout", script, true);
                }
            }
        }

        static string Encrypt(string value)
        {
            using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
            {
                UTF8Encoding utf8 = new UTF8Encoding();
                byte[] bytes = md5.ComputeHash(utf8.GetBytes(value));
                return Convert.ToBase64String(bytes);
            }
        }

        private bool ValidateUser(string email,string password)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT COUNT(*) FROM [user] WHERE emailAddress = @emailAddress and password = @Password";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@emailAddress", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    con.Open();

                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool ValidateUserRole(string email, string password, out string role)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT role FROM [user] WHERE emailAddress = @emailAddress AND password = @Password";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@emailAddress", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    con.Open();

                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        role = result.ToString();
                        return true;
                    }
                    else
                    {
                        role = null;
                        return false;
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string userEmail = TextBox1.Text;
            string userPassword = Encrypt(TextBox2.Text);

            if (!string.IsNullOrWhiteSpace(TextBox1.Text) && !string.IsNullOrWhiteSpace(TextBox2.Text))
            {
                // Validate the user against the database
                if (ValidateUser(userEmail, userPassword))
                {
                    // Authentication successful
                    ValidateUserRole(userEmail, userPassword, out string userRole);
                    // Create a forms authentication ticket

                    // (This one take reference from http://www.codedigest.com/Articles/ASPNET/176_Using_Roles_in_Forms_Authentication_in_ASPNet_20.aspx)
                    
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                        1,                              // Version
                        userEmail,                      // User name
                        DateTime.Now,                   // Issue time
                        DateTime.Now.AddHours(2),    // Expiration time
                        false,                          // Persistent
                        userRole,                        // User data (e.g., role)
                        FormsAuthentication.FormsCookiePath
                    );

                    // Encrypt the ticket
                    string encryptedTicket = FormsAuthentication.Encrypt(ticket);

                    // Create a forms authentication cookie
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                    string returnUrl = Request.QueryString["ReturnUrl"];
                    if (returnUrl != null)
                    {
                        returnUrl = "/";
                    }

                    // Add the cookie to the response
                    Response.Cookies.Add(authCookie);

                    if (userRole == "customer")
                    {
                        string script = "alert('Login successful!'); window.location.href = 'Home.aspx';";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "SuccessMessage", script, true);
                    }
                    else
                    {
                        string script = "alert('Welcome,admin!'); window.location.href = '"
                    + ResolveUrl("~/Admin/AdminDashboard.aspx") + "';";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "SuccessMessage", script, true);
                    }
                }
                else
                {
                    // Authentication failed
                    lblErrorLogin.Text = "Invalid username or password.";
                }
            }
            else
            {
                lblErrorLogin.Text = "***Username and password must be filled in!";
            }
        }
    }
}