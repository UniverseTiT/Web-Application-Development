using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

        static string Encrypt(string value)
        {
            using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
            {
                UTF8Encoding utf8 = new UTF8Encoding();
                byte[] bytes = md5.ComputeHash(utf8.GetBytes(value));
                return Convert.ToBase64String(bytes);
            }
        }

        private bool IsValidPassword(string password)
        {
            string pattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.{8,})";
            return Regex.IsMatch(password, pattern);
        }

        private bool UpdatePasswordForEmail(string email, string newPassword)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;";
            string query = "UPDATE [user] SET password = @newPassword WHERE emailAddress = @email";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@newPassword", newPassword);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                if (IsEmailExists(txtEmail.Text))
                {
                    TextBox2.Enabled = true;
                    TextBox3.Enabled = true;
                    Reset.Enabled = true;
                    resetEmail.ForeColor = System.Drawing.ColorTranslator.FromHtml("#00FF99");
                    resetEmail.Text = "***Enter the new password to recovery!";
                }
                else
                {
                    TextBox2.Enabled = false;
                    TextBox3.Enabled = false;
                    Reset.Enabled = false;
                    resetEmail.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                    resetEmail.Text = "***This email doesn't register in our system, please try again!";
                }
            }
            else
            {
                TextBox2.Enabled = false;
                TextBox3.Enabled = false;
                Reset.Enabled = false;
                resetEmail.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                resetEmail.Text = "***Please fill in your email to recover the password!";
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox2.Enabled = false;
            TextBox3.Enabled = false;
            Reset.Enabled = false;
        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(TextBox2.Text) && !string.IsNullOrWhiteSpace(TextBox3.Text) && TextBox2.Text == TextBox3.Text && IsValidPassword(TextBox2.Text) && IsValidPassword(TextBox3.Text))
            {
                UpdatePasswordForEmail(txtEmail.Text, Encrypt(TextBox2.Text));
                resetPassword.Text = null;
                string senderEmail = "ansonchin0204@gmail.com";
                string password = "tdly jczg gctu dtrn";
                String receiverEmail = txtEmail.Text;
                string title = "Password Recovery";
                string content = "<html><head><style>" +
                "body { font-family: 'Arial', sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
                ".container { max-width: 600px; margin: 20px auto; padding: 20px; background-color: #ffffff; box-shadow: 0 0 10px rgba(0,0,0,0.1); border-radius: 8px; }" +
                "h1 { color: #007bff; text-align: center; }" +
                "p { color: #333; line-height: 1.6; }" +
                "a { color: #007bff; text-decoration: none; }" +
                ".no-reply { color: #777; margin-top: 20px; text-align: center; }" +
                ".signature { margin-top: 20px; text-align: center; }" +
                ".signature strong { font-family: 'Pacifico', cursive; text-decoration: underline; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<h1 style='font-size: 24px;'>Password Successfully Recovered</h1>" +
                "<p style='font-size: 16px;'>Your password for the SPA Melody platform has been successfully recovered.</p>" +
                "<p style='font-size: 16px;'>If you did not initiate this action, please contact our support team immediately.</p>" +
                "<p class='signature' style='font-size: 16px;'>Best regards,<br /><strong>SPA Melody Boss</strong><br />(Ng Jun Yu)</p>" +
                "<p class='no-reply' style='font-size: 14px;'>Please note: This is an automated message. Please do not reply to this email.</p>" +
                "</div></body></html>";

                MailMessage mail = new MailMessage(senderEmail, receiverEmail);

                mail.Subject = title;
                mail.Body = content;
                mail.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(senderEmail, password);
                // Send the email
                smtpClient.Send(mail);
                string script = "alert('Success for password recovery!'); window.location.href = 'Login.aspx';";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "SuccessMessage", script, true);
            }
            else
            {
                resetPassword.Text = "***The new password should same with the confirm password!\n"
                    + "(Your password should at least 8 character with 1 uppercase, 1 lowercase and 1 symbol)";
            }
        }
    }
}