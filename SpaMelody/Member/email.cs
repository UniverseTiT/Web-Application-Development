using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;

namespace MelodySpa
{
   

    public class email
    {
        public static String sendEmail(String receiverEmail, String title, String Content)
        {
            string senderEmail = "tanws-wm21@student.tarc.edu.my";
            string password = "Tqjo xkeo ymfx yfyh";

            MailMessage mail = new MailMessage(senderEmail, receiverEmail);

            mail.Subject = title;
            mail.Body = Content;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new NetworkCredential(senderEmail, password);

            try
            {
                // Send the email
                smtpClient.Send(mail);
                Console.WriteLine("Email sent successfully!");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to send email: " + ex.Message);
                return ex.Message;
            }
            return "OK";
        }

    }
}