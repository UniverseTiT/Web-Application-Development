using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa.Member
{
    public partial class RateComment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("customer"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["bookingID"] == null)
                {
                    string script = "alert('Book Again!!.')," +
                           " window.location.href = 'Booking.aspx';";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Fail", script, true);
                }

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string booking = Request.QueryString["bookingID"].ToString();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MelodySpa"].ConnectionString);
            conn.Open();

            // object result = 
            string retrieveData = "SELECT COUNT(ratingID) FROM booking WHERE bookingID = '" + Request.QueryString["bookingID"].ToString() + "'";
            SqlCommand check = new SqlCommand(retrieveData, conn);
            object result = check.ExecuteScalar();
            int count = (result != null) ? Convert.ToInt32(result) : 0;

            string query = string.Empty;
            string ratingID = string.Empty;
            switch (count)
            {
                case 0:
                    ratingID = GenerateNewRatingId(conn);
                    query = "INSERT INTO rating VALUES (@ratingID, @comment);";
                    insertRating(query, ratingID, booking, conn);
                    break;
                default:
                    string getCurrentID = "SELECT ratingID FROM booking WHERE bookingID = '" + Request.QueryString["bookingID"].ToString() + "'";
                    SqlCommand find = new SqlCommand(getCurrentID, conn);
                    SqlDataReader reader = find.ExecuteReader();
                    query = "UPDATE rating SET comment = @comment WHERE ratingID = @ratingID";
                    if (reader.Read())
                    {
                        string currentRatingID = reader.GetValue(0).ToString();
                        reader.Close();
                        insertRating(query, currentRatingID, booking, conn);
                    }    
                    reader.Close();
                    break;
            }


        }


        protected void insertRating(string query, string ratingID, string booking, SqlConnection conn)
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ratingID", ratingID);
                cmd.Parameters.AddWithValue("@comment", txtFeedback.Text);
                int row = cmd.ExecuteNonQuery();
                if (row != 0)
                {
                    updateBooking(ratingID, booking, conn);
                }
                else
                {
                    string script = "alert('Please try again.')," +
                           " window.location.href = 'BookingHistory.aspx';";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Fail", script, true);
                }

            }
        }

        private void updateBooking(string ratingID, string booking, SqlConnection conn)
        {
            using (SqlCommand update = new SqlCommand("UPDATE booking SET ratingID = @ratingID WHERE bookingID = @id", conn))
            {
                update.Parameters.AddWithValue("@ratingID", ratingID);
                update.Parameters.AddWithValue("@id", booking);
                int rows = update.ExecuteNonQuery();
                if (rows != 0)
                {
                    string script = "alert('Data updated successfully.')," +
                    " window.location.href = 'BookingHistory.aspx';";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", script, true);
                }
                else
                {
                    string script = "alert('Data updated Fail.')," +
                    " window.location.href = 'BookingHistory.aspx';";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Fail", script, true);
                }
            }
        }

        private string GenerateNewRatingId(SqlConnection con)
        {
            SqlCommand readLatestID =
                 new SqlCommand(
                     "SELECT MAX(CAST(SUBSTRING(ratingID, 2, LEN(ratingID)-1) AS INT)) AS max_id FROM rating", con);
            object result = readLatestID.ExecuteScalar();
            if (result != DBNull.Value)
            {
                string latestID = "R" + result.ToString().PadLeft(4, '0');
                int numericPart = int.Parse(latestID.Substring(1)) + 1;
                return "R" + numericPart.ToString().PadLeft(4, '0');
            }
            return "R0001";
        }


    }
}