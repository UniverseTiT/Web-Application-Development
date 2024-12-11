using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MelodySpa
{
    public partial class Register : System.Web.UI.Page
    {
        String name;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool IsValidEmail(string email)
        {
            string pattern = @"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
            return Regex.IsMatch(email, pattern);
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

        private bool IsEmailExists(string email)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "SELECT COUNT(*) FROM [user] WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
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

        static string Encrypt(string value)
        {
            using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
            {
                UTF8Encoding utf8 = new UTF8Encoding();
                byte[] bytes = md5.ComputeHash(utf8.GetBytes(value));
                return Convert.ToBase64String(bytes);
            }
        }

        private string GenerateNewUserId(SqlConnection con)
        {
            SqlCommand countCustomers = new SqlCommand(
                "SELECT COUNT(*) FROM [user] WHERE role = 'customer'", con);

            int customerCount = (int)countCustomers.ExecuteScalar();
            string newUserId = "C" + (customerCount + 1).ToString().PadLeft(4, '0');

            return newUserId;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            //Name validation
            if (string.IsNullOrWhiteSpace(TextBox1.Text))
            {
                lblName.Text = "***You are required to fill in username!";
            }
            else
            {
                if (IsUsernameExists(TextBox1.Text))
                {
                    lblName.Text = "***Your username has been taken,try to fill in another username!";
                }
                else
                {
                    lblName.Text = null;
                }
            }

            //Email validation
            if (!string.IsNullOrWhiteSpace(TextBox2.Text))
            {
                if (!IsValidEmail(TextBox2.Text))
                {
                    lblEmail.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                    lblEmail.Text = "Oops, your email format is wrong \u274C";
                }
                else if (IsEmailExists(TextBox2.Text))
                {
                    lblEmail.Text = "***Your email has been registered,try to use another email!";
                }
                else
                {
                    lblEmail.Text = null;
                }
            }
            else
            {
                lblEmail.Text = "***You are required to fill in the email!";
            }

            //Gender validation
            if (string.IsNullOrEmpty(rblGender.SelectedValue))
            {
                lblGender.Text = "***Please select your gender!";
            }
            else
            {
                lblGender.Text = null;
            }

            //Phone Number validation
            if (!string.IsNullOrWhiteSpace(TextBox3.Text))
            {
                if (!IsValidMalaysianPhoneNumber(TextBox3.Text))
                {
                    lblPhoneNo.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                    lblPhoneNo.Text = "Oops, your phoneNO format is wrong \u274C";
                }
                else if (IsPhoneExists(TextBox3.Text))
                {
                    lblPhoneNo.Text = "***This phone number has been used by another account,try to use another!";
                }
                else
                {
                    lblPhoneNo.Text = null;
                }
            }
            else
            {
                lblPhoneNo.Text = "***You are required to fill in the phoneNo!";
            }

            //Date of birth validation
            if (Calendar1.SelectedDate == DateTime.MinValue)
            {
                lblCalender.Text = "***You must selected the date!";
            }
            else if(Calendar1.SelectedDate >= DateTime.Now.Date)
            {
                lblCalender.Text = "***You cannot choose a date in the future.";
            }
            else
            {
                lblCalender.Text = null;
            }

            //Password validation
            if (string.IsNullOrWhiteSpace(TextBox5.Text) || string.IsNullOrWhiteSpace(TextBox6.Text) || TextBox5.Text != TextBox6.Text || !IsValidPassword(TextBox5.Text) || !IsValidPassword(TextBox6.Text))
            {
                lblPassword.Text = "***You must fill in the password and the confirm password must same with your password!\n"
                    + "(Your password should at least 8 character with 1 uppercase, 1 lowercase and 1 symbol)";
            }
            else
            {
                lblPassword.Text = null;
            }

            //Profile validation
            if (!FileUpload1.HasFile)
            {
                lblProfile.Text = "***You must upload your profile picture!";
            }
            else
            {
                if (!ImageValidation(FileUpload1))
                {
                    lblProfile.Text = "***Just support format in '.jpg', '.jpeg' and '.png'.!";
                }
                else
                {
                    lblProfile.Text = null;
                }
            }

            //If all correct (insert),false will show error
            if ((!string.IsNullOrWhiteSpace(TextBox1.Text) && !IsUsernameExists(TextBox1.Text))
                && (!string.IsNullOrWhiteSpace(TextBox2.Text) && IsValidEmail(TextBox2.Text) && !IsEmailExists(TextBox2.Text))
                && (rblGender.SelectedValue != null)
                && (!string.IsNullOrWhiteSpace(TextBox3.Text) && IsValidMalaysianPhoneNumber(TextBox3.Text) && !IsPhoneExists(TextBox3.Text))
                && (FileUpload1.HasFile && ImageValidation(FileUpload1))
                && (Calendar1.SelectedDate != DateTime.MinValue && Calendar1.SelectedDate < DateTime.Now.Date)
                && (!string.IsNullOrWhiteSpace(TextBox5.Text) && !string.IsNullOrWhiteSpace(TextBox6.Text) && TextBox5.Text == TextBox6.Text && IsValidPassword(TextBox5.Text) && IsValidPassword(TextBox6.Text)))
            {
                SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                con.Open();
                string userID = GenerateNewUserId(con);
                string insertUser = "INSERT INTO [user] " +
                    "VALUES (@id, @name, @userImage, @email, @phone, @date, @gender, @role, @password);";
                SqlCommand cmd = new SqlCommand(insertUser, con);
                FileUpload1.SaveAs(Server.MapPath("~/Images/") + System.IO.Path.GetFileName(FileUpload1.FileName));
                string linkPath = "Images/" + System.IO.Path.GetFileName(FileUpload1.FileName);
                cmd.Parameters.AddWithValue("@id", userID);
                cmd.Parameters.AddWithValue("@name", TextBox1.Text);
                cmd.Parameters.AddWithValue("@userImage", linkPath);
                cmd.Parameters.AddWithValue("@email", TextBox2.Text);
                cmd.Parameters.AddWithValue("@phone", TextBox3.Text);
                cmd.Parameters.AddWithValue("@date", Calendar1.SelectedDate);
                cmd.Parameters.AddWithValue("@gender", rblGender.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@role", "customer");
                cmd.Parameters.AddWithValue("@password", Encrypt(TextBox5.Text));
                cmd.ExecuteNonQuery();
                con.Close();

                if (rblGender.SelectedItem.Text == "Male")
                {
                    name = "Mr ";
                }
                else
                {
                    name = "Mrs ";
                }

                string senderEmail = "ansonchin0204@gmail.com";
                string password = "tdly jczg gctu dtrn";
                String receiverEmail = TextBox2.Text;
                string title = "Congratulations! Your Account Registration Was Successful";
                string content = "<html><head><style>" +
                "body { font-family: 'Arial', sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
                ".container { max-width: 600px; margin: 20px auto; padding: 20px; background-color: #ffffff; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 8px; }" +
                "h1 { color: #007bff; text-align: center; }" +
                "p { color: #333; line-height: 1.6; }" +
                ".no-reply { color: #777; margin-top: 20px; text-align: center; }" +
                ".signature { margin-top: 20px; text-align: center; }" +
                ".signature strong { font-family: 'Pacifico', cursive; text-decoration: underline; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<h1>Congratulations, "+ name + TextBox1.Text +"!</h1>" +
                "<p>Your account registration was successful. Welcome to our community!</p>" +
                "<p>Thank you for choosing our platform. If you have any questions, feel free to contact our support team (+60 11-5987 4606).</p>" +
                "<p class='signature'>Best regards,<br /><strong>SPA Melody Boss</strong><br />(Ng Jun Yu)</p>" +
                "<p class='no-reply'>Please note: This is an automated message. Please do not reply to this email.</p>" +
                "</div></body></html>";

                MailMessage mail = new MailMessage(senderEmail, receiverEmail);

                mail.Subject = title;
                mail.Body = content;
                mail.IsBodyHtml = true;
                mail.CC.Add("tanws-wm21@student.tarc.edu.my");
                mail.CC.Add("tancf-wm21@student.tarc.edu.my ");
                mail.CC.Add("jyng-wm21@student.tarc.edu.my");
                mail.CC.Add("siasf-wm20@student.tarc.edu.my");
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, password);
                // Send the email
                smtpClient.Send(mail);
                string script = "alert('Registration successful!'); window.location.href = 'Login.aspx';";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "SuccessMessage", script, true);
            }
            else
            {
                string script = "alert('Registration unsucessful,please check and correct your information!');";
                ClientScript.RegisterStartupScript(this.GetType(), "FailedMessage", script, true);
            }
        }
    }
}