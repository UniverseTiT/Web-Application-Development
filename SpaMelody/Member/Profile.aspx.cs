using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class Profile : System.Web.UI.Page
    {
        private int error = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                if (!Context.User.IsInRole("customer"))
                {
                    Response.Redirect(ResolveUrl("~/Error/401.aspx"));
                }
                else
                {
                    LoadUserData();
                }
                
            }
        }

        private void LoadUserData()
        {
            // Get the username from the authentication ticket
            string userEmail = User.Identity.Name;

            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT * FROM [user] WHERE emailAddress = @email";

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
                            string name = "";
                            // Display the retrieved user data
                            lblUsername.Text = reader["username"].ToString();
                            txtEmail.Text = reader["emailAddress"].ToString();
                            txtPhone.Text = reader["phoneNum"].ToString();
                            txtAge.Text = ((DateTime)reader["dateOfBirth"]).ToString("dd-MM-yyyy");
                            rblGender.Text = reader["gender"].ToString();
                            if (rblGender.Text =="Male")
                            {
                                name = "Mr ";
                            }
                            else
                            {
                                name = "Mrs ";
                            }
                            profileTittle.Text = "Welcome, " + name + lblUsername.Text + "!";
                            string userImagePath = reader["userImage"].ToString();
                            Image1.ImageUrl = ResolveUrl("~/" + userImagePath);
                        }
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Button3.Visible = true;
            Button4.Visible = true;
            Button1.Visible = false;
            profileImage.Visible = true;
            lblUsername.Visible = false;
            editName.Visible = true;
            txtPhone.Visible = false;
            editPhone.Visible = true;
            txtAge.Visible = false;
            rblGender.Visible = false;
            Label6.Visible = true;
            Label8.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            Calendar1.Visible = true;
            RadioButtonList1.Visible = true;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(editName.Text))
            {
                if (IsUsernameExists(editName.Text))
                {
                    ResetName.Text = "***This username has been taken,try to fill in another username!";
                    error += 1;
                }
            }

            if (!string.IsNullOrWhiteSpace(editPhone.Text))
            {
                if (IsPhoneExists(editPhone.Text))
                {
                    ResetPhoneNo.Text = "***This phoneNo has been taken!";
                    error += 1;
                }
                else if (!IsValidMalaysianPhoneNumber(editPhone.Text))
                {
                    ResetPhoneNo.Text = "***Invalid phoneNo format!";
                    error += 1;
                }
            }

            if (Calendar1.SelectedDate > DateTime.Now.Date)
            {
                ResetCalendar.Text = "***You cannot choose a date in the future.";
            }
            else if (Calendar1.SelectedDate > DateTime.Now.Date)
            {
                ResetCalendar.Text = "***Cannot selected future date!";
            }

            if (profileImage.HasFile)
            {
                if (!ImageValidation(profileImage))
                {
                    ResetProfile.Text = "***Just support format in '.jpg', '.jpeg' and '.png'.!";
                    error += 1;
                }
            }

            if (!string.IsNullOrWhiteSpace(TextBox5.Text) && !string.IsNullOrWhiteSpace(TextBox6.Text))
            {
                if (TextBox5.Text != TextBox6.Text || !IsValidPassword(TextBox5.Text) || !IsValidPassword(TextBox6.Text))
                {
                    ResetPassword.Text = "***You must fill in the password and the confirm password must same with your password!\n"
                        + "(Password should at least 8 character with 1 uppercase, 1 lowercase and 1 symbol)";
                    error += 1;
                }
            }

            if (error == 0)
            {
                //Name edition
                if (!string.IsNullOrWhiteSpace(editName.Text) && !IsUsernameExists(editName.Text))
                {
                    UpdateNameForUser(User.Identity.Name, editName.Text);
                    ResetName.Text = null;
                }

                //Phone edition
                if (!string.IsNullOrWhiteSpace(editPhone.Text) && !IsPhoneExists(editPhone.Text) && IsValidMalaysianPhoneNumber(editPhone.Text))
                {
                    UpdatePhoneForUser(User.Identity.Name, editPhone.Text);
                    ResetPhoneNo.Text = null;
                }

                //Gender edition
                if (!string.IsNullOrEmpty(RadioButtonList1.SelectedValue))
                {
                    UpdateGenderForUser(User.Identity.Name, RadioButtonList1.SelectedItem.Text);
                }

                //Profile edition
                if (profileImage.HasFile && ImageValidation(profileImage))
                {
                    profileImage.SaveAs(Server.MapPath("~/Images/") + System.IO.Path.GetFileName(profileImage.FileName));
                    string linkPath = "Images/" + System.IO.Path.GetFileName(profileImage.FileName);
                    UpdateProfileForUser(User.Identity.Name, linkPath);
                    ResetProfile.Text = null;
                }

                //Date of Birth edition
                if (Calendar1.SelectedDate != DateTime.MinValue && Calendar1.SelectedDate < DateTime.Now.Date)
                {
                    UpdateDateForUser(User.Identity.Name);
                    ResetCalendar.Text = null;
                }

                //Password edition
                if (!string.IsNullOrWhiteSpace(TextBox5.Text) && !string.IsNullOrWhiteSpace(TextBox6.Text))
                {
                    if (TextBox5.Text == TextBox6.Text && IsValidPassword(TextBox5.Text) && IsValidPassword(TextBox6.Text))
                    {
                        UpdatePasswordForUser(User.Identity.Name);
                        ResetPassword.Text = null;
                    }
                }

                // Show an alert using JavaScript directly in HTML markup
                ScriptManager.RegisterStartupScript(this, this.GetType(), "UpdatedMessage", "showAlert();", true);

                Button3.Visible = false;
                Button4.Visible = false;
                Button1.Visible = true;
                profileImage.Visible = false;
                lblUsername.Visible = true;
                editName.Visible = false;
                txtPhone.Visible = true;
                editPhone.Visible = false;
                txtAge.Visible = true;
                rblGender.Visible = true;
                Label6.Visible = false;
                Label8.Visible = false;
                TextBox5.Visible = false;
                TextBox6.Visible = false;
                Calendar1.Visible = false;
                RadioButtonList1.Visible = false;
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Button3.Visible = false;
            Button4.Visible = false;
            Button1.Visible = true;
            profileImage.Visible = false;
            lblUsername.Visible = true;
            editName.Visible = false;
            txtPhone.Visible = true;
            editPhone.Visible = false;
            txtAge.Visible = true;
            rblGender.Visible = true;
            Label6.Visible = false;
            Label8.Visible = false;
            TextBox5.Visible = false;
            TextBox6.Visible = false;
            Calendar1.Visible = false;
            RadioButtonList1.Visible = false;
        }

        private bool UpdateNameForUser(string email, string editName)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET username = @editName WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@editName", editName);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool UpdatePhoneForUser(string email, string phone)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET phoneNum = @phone WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool UpdateGenderForUser(string email, string editGender)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET gender = @gender WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@gender", editGender);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool UpdateProfileForUser(string email, string editProfile)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET userImage = @editProfile WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@editProfile", editProfile);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool UpdateDateForUser(string email)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET dateOfBirth = @date WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@date", Calendar1.SelectedDate);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool UpdatePasswordForUser(string email)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET password = @password WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@password", Encrypt(TextBox5.Text));
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        private bool IsValidMalaysianPhoneNumber(string phoneNumber)
        {
            string pattern = @"^01[0-9]{8,9}$";
            return Regex.IsMatch(phoneNumber, pattern);
        }

        private bool IsValidPassword(string password)
        {
            string pattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*.])(?=.{8,})";
            return Regex.IsMatch(password, pattern);
        }

        private bool ImageValidation(FileUpload fileName)
        {
            bool validate = false;
            try
            {
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
                string fileExtension = Path.GetExtension(fileName.FileName);
                if (Array.IndexOf(allowedExtensions, fileExtension.ToLower()) != -1)
                {
                    validate = true;
                }
                return validate;
            }
            catch (Exception)
            {
                return validate;
            }
        }

        private bool IsPhoneExists(string phone)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT COUNT(*) FROM [user] WHERE phoneNum = @phone";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@phone", phone);
                    con.Open();

                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool IsUsernameExists(string username)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT COUNT(*) FROM [user] WHERE username = @Username";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    con.Open();

                    int count = (int)cmd.ExecuteScalar();

                    // If count is greater than 0, the username already exists
                    return count > 0;
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
    }
}