using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Newtonsoft.Json;
using Stripe;
using static System.Net.Mime.MediaTypeNames;
using static MelodySpa.email;

namespace MelodySpa
{
    public partial class Payment : System.Web.UI.Page
    {
        private string userID;
        protected List<SERVICE> serviceList = new List<SERVICE>();
        CheckBoxList cblService;
        TextBox txtServiceDate;
        string ddlServiceTime;
        public double totalPrice = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
            else
            {
                LoadUserID();
            }


            if (PreviousPage != null && PreviousPage.IsCrossPagePostBack)
            {

                cblService = (CheckBoxList)Session["cblService"];
                txtServiceDate = (TextBox)Session["txtServiceDate"];
                ddlServiceTime = Session["ddlServiceTime"].ToString();
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MelodySpa"].ConnectionString);
                conn.Open();
                string strSelect;
                SqlCommand cmdSelect;
                SqlDataReader dtrSelect;


                foreach (ListItem item in cblService.Items)
                {
                    if (item.Selected)
                    {
                        strSelect = "Select serviceName,servicePrice from service where serviceID = @serviceID";
                        cmdSelect = new SqlCommand(strSelect, conn);
                        cmdSelect.Parameters.AddWithValue("@serviceID", item.Value.ToString());
                        dtrSelect = cmdSelect.ExecuteReader();
                        if (dtrSelect.HasRows)
                        {
                            while (dtrSelect.Read())
                            {
                                SERVICE service = new SERVICE();
                                service.price = Convert.ToDouble(dtrSelect["servicePrice"]);
                                service.name = dtrSelect["serviceName"].ToString();
                                serviceList.Add(service);
                                totalPrice += service.price;
                            }
                        }
                        dtrSelect.Close();
                    }
                }
                conn.Close();

                lblTotalPrice.Text = "RM " + totalPrice;
                Session["totalPrice"] = totalPrice;


                if (txtServiceDate != null)
                {
                    lblBookingDate.Text = txtServiceDate.Text;
                }
                else
                {
                    lblBookingDate.Text = "null";
                }

                if (ddlServiceTime != null)
                {
                    lblBookingTime.Text = ddlServiceTime;
                }
                else
                {
                    lblBookingDate.Text = "null";
                }

                trCreditCard.Visible = false;
            }
            else
            {
                string script = "alert('You cannot directly access this page.'), "+
                                "window.location.href = 'Booking.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
            }


        }

        private string GenerateNewPaymentId(SqlConnection con)
        {
            SqlCommand readLatestID =
                 new SqlCommand(
                     "SELECT MAX(CAST(SUBSTRING(paymentID, 2, LEN(paymentID)-1) AS INT)) AS max_id FROM payment", con);
            object result = readLatestID.ExecuteScalar();
            if (result != DBNull.Value)
            {
                string latestID = "P" + result.ToString().PadLeft(4, '0');
                int numericPart = int.Parse(latestID.Substring(1)) + 1;
                return "P" + numericPart.ToString().PadLeft(4, '0');
            }
            return "P0001";
        }

        private string GenerateNewBookingId(SqlConnection con)
        {
            SqlCommand readLatestID =
                 new SqlCommand(
                     "SELECT MAX(CAST(SUBSTRING(bookingID, 2, LEN(bookingID)-1) AS INT)) AS max_id FROM booking", con);
            object result = readLatestID.ExecuteScalar();
            if (result != DBNull.Value)
            {
                string latestID = "B" + result.ToString().PadLeft(4, '0');
                int numericPart = int.Parse(latestID.Substring(1)) + 1;
                return "B" + numericPart.ToString().PadLeft(4, '0');
            }
            return "B0001";
        }

        protected class SERVICE
        {
            public string id { get; set; }
            public double price { get; set; }
            public string name { get; set; }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPaymentMethod.SelectedIndex == 0)
            {
                trOnlineBanking.Visible = true;
                trCreditCard.Visible = false;
            }
            else
            {
                trOnlineBanking.Visible = false;
                trCreditCard.Visible = true;
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

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            //////////////////////////////////////////////////////////////////////////////////////creditcard
            if (ddlPaymentMethod.SelectedIndex != 0)
            {
                string cardNumber = txtCardNumber.Text.Trim();
                string expiryDate = txtExpiryDate.Text.Trim();
                string nameOnCard = txtNameOnCard.Text.Trim();
                string cvv = txtCCV.Text.Trim();

                string sanitizedValue = cardNumber.Replace(" ", "").Replace("-", "");
                char firstDigit = sanitizedValue[0];
                int firstDigitValue = int.Parse(firstDigit.ToString());
                

                StripeConfiguration.ApiKey = "sk_test_51OPfe6EQisJclLgVx3wE2YWZwfcGeNn4ZFhAQrv7f2rXdqQDG3FxJVgFJ6Ab4EaqMJA0V2DGBlPv65I269YhCtl200rgQZyiHz";

                // Retrieve the token from the client
                string tokenId = Request.Form["stripeToken"];
                string customerId = "cus_PE7w0ZzAE9IQAR";


                if (decimal.TryParse(Session["TotalPrice"].ToString(), out decimal bookingPrice))
                {
                    int priceCents = (int)(bookingPrice * 100); // Convert to cents

                    // Use the token to perform a charge or save the payment method securely
                    var options = new ChargeCreateOptions
                    {
                        Amount = priceCents, // The payment amount in cents
                        Currency = "myr",
                        Customer = customerId,
                        Description = "Payment for movie tickets"
                    };

                    var service = new ChargeService();
                    service.Create(options);


                }
            }
            /////////////////////////////////////////////////////////////////////////////////

            //sql stuff
            cblService = (CheckBoxList)Session["cblService"];
            txtServiceDate = (TextBox)Session["txtServiceDate"];
            ddlServiceTime = Session["ddlServiceTime"].ToString();
            string bookingTime = ddlServiceTime;
            string bookingDate = txtServiceDate.Text;

            //get service entity
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MelodySpa"].ConnectionString);
            conn.Open();
            string strSelect;
            SqlCommand cmdSelect;
            SqlDataReader dtrSelect;

            //get new bookingID
            string bookingID = GenerateNewBookingId(conn);
            string strCountBookingID = "Select COUNT(*) From Booking";
            SqlCommand cmdCountBookingID = new SqlCommand(strCountBookingID, conn);
            if (cmdCountBookingID.ExecuteScalar() != null)
            {
                int count = (int)cmdCountBookingID.ExecuteScalar();
                string strcount = "" + count;
                bookingID = "B";
                if (strcount.Length < 3)
                {
                    int zero = 3 - bookingID.Length;
                    for (int i = 0; i < zero; i++)
                    {
                        bookingID = bookingID + "0";
                    }
                    bookingID = bookingID + "" + (count + 1);
                }
            }
            else
            {
                btnPayment.Text = "fail";
            }
            

            string content ="Booking Details\nBooking ID: " + bookingID+"\nBooking Date: "+ ddlServiceTime + "\nBooking Time: "+txtServiceDate.Text + "\n\n";
            int n = 1;
            foreach (ListItem item in cblService.Items)
            {
                if (item.Selected)
                {
                    strSelect = "Select serviceID, serviceName,servicePrice from service where serviceID = @serviceID";
                    cmdSelect = new SqlCommand(strSelect, conn);
                    cmdSelect.Parameters.AddWithValue("@serviceID", item.Value.ToString());
                    dtrSelect = cmdSelect.ExecuteReader();
                    if (dtrSelect.HasRows)
                    {
                        while (dtrSelect.Read())
                        {
                            SERVICE service = new SERVICE();
                            service.price = Convert.ToDouble(dtrSelect["servicePrice"]);
                            service.name = dtrSelect["serviceName"].ToString();
                            service.id = dtrSelect["serviceID"].ToString();
         
                            serviceList.Add(service);
                            content += n +". Service Name: " + service.name +"\nService Price: "+ service.price + "\n\n";
                            n++;
                        }
                    }
                    dtrSelect.Close();
                }

            }
            string userEmail = "";
            string strEmail = "Select emailAddress from [user] where userID = @userID";
            cmdSelect = new SqlCommand(strEmail, conn);
            cmdSelect.Parameters.AddWithValue("@userID", userID);
            dtrSelect = cmdSelect.ExecuteReader();
            if (dtrSelect.HasRows)
            {
                while (dtrSelect.Read())
                {
                    userEmail = dtrSelect["EmailAddress"].ToString();
                }
            }
            dtrSelect.Close();






            content += "Total: RM" + Session["totalPrice"];
            btnPayment.Text = email.sendEmail(userEmail, "Booking Details", content);

            

            //insert booking record
            string strInsert;
            SqlCommand cmdInsert;
            strInsert = "Insert into booking (bookingID,bookingDate,bookingTime,userID, status) values (@bookingID,@bookingDate,@bookingTime,@userID, @status);";
            cmdInsert = new SqlCommand(strInsert, conn);
            cmdInsert.Parameters.AddWithValue("@bookingID", bookingID);
            cmdInsert.Parameters.AddWithValue("@bookingDate", DateTime.ParseExact(bookingDate, "dd/M/yyyy", System.Globalization.CultureInfo.InvariantCulture));
            cmdInsert.Parameters.AddWithValue("@bookingTime", (DateTime.ParseExact(bookingTime, "HH:mm", System.Globalization.CultureInfo.InvariantCulture)).ToString("HH:mm"));
            cmdInsert.Parameters.AddWithValue("@userID", userID);
            cmdInsert.Parameters.AddWithValue("@status", " Confirmed");
            int nn  = cmdInsert.ExecuteNonQuery();

            if (nn > 0)
                Response.Write("Booking Service Record is added");
            else
                Response.Write("Ops! Unable to insert record.");

            //insert booking service record
          

            int nnn=0;
            for (int i = 0; i < serviceList.Count; i++)
            {
                strInsert = "Insert into bookingService (bookingID, serviceID) values (@bookingID, @serviceID);";
                cmdInsert = new SqlCommand(strInsert, conn);
                cmdInsert.Parameters.AddWithValue("@bookingID",bookingID);
                cmdInsert.Parameters.AddWithValue("@serviceID", serviceList[i].id);

                nnn = cmdInsert.ExecuteNonQuery();

                if (nnn > 0)
                    Response.Write("Booking Service Record is added");
                else
                    Response.Write("Ops! Unable to insert record.");


            }

            //insert payment
            string paymentID = GenerateNewPaymentId(conn);
            string strCountPaymentID = "Select COUNT(*) From Payment";
            SqlCommand cmdCountPaymentID = new SqlCommand(strCountPaymentID, conn);
            if (cmdCountPaymentID.ExecuteScalar() != null)
            {
                int count = (int)cmdCountPaymentID.ExecuteScalar();
                string strcount = "" + count;
                paymentID = "P";
                if (strcount.Length < 3)
                {
                    int zero = 3 - paymentID.Length;
                    for (int i = 0; i < zero; i++)
                    {
                        paymentID =  paymentID + "0";
                    }
                    paymentID = paymentID + "" + (count + 1);
                }
            }
            else
            {
                btnPayment.Text = "fail";
            }
            strInsert = "Insert into payment (paymentID, total, paymentMethod, bookingID) values(@paymentID, @total, @paymentMethod, @bookingID);";
            cmdInsert = new SqlCommand(strInsert, conn);
            string paymentMethod = "";
            if (ddlPaymentMethod.SelectedIndex==0)
            {
                paymentMethod = "online banking";
            }
            else
            {
                paymentMethod = "credit card";
            }
            cmdInsert.Parameters.AddWithValue("@paymentMethod", paymentMethod);
            cmdInsert.Parameters.AddWithValue("@total", Session["totalPrice"]);
            cmdInsert.Parameters.AddWithValue("@bookingID", bookingID);
            cmdInsert.Parameters.AddWithValue("@paymentID", paymentID);
            nnn = cmdInsert.ExecuteNonQuery();

            if (nnn > 0)
                Response.Write("Payment Record is added");
            else
                Response.Write("Ops! Unable to insert record.");

            conn.Close();
            Response.Redirect("/Member/PaymentSuccess.aspx");
        }

    }
}