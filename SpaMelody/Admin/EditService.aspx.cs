using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class EditService : System.Web.UI.Page
    {
        private int error = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["serviceID"] != null)
                {

                    SqlConnection con;
                    con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                    con.Open();
                    string retrieveData = "SELECT * FROM service WHERE serviceID='" + Request.QueryString["serviceID"].ToString() + "'";
                    SqlCommand cmd = new SqlCommand(retrieveData, con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtSName.Text = reader.GetValue(1).ToString();
                        txtDesc.Text = reader.GetValue(3).ToString();
                        txtPrice.Text = reader.GetValue(5).ToString();
                        string durationString = reader.GetValue(4).ToString();
                        int totalMinutes = ExtractMinutes(durationString);
                        if (totalMinutes == -1)
                        {
                            string script = "alert('There is an error has been found.'), "+
                                "window.location.href = 'ServiceManagement.aspx';";
                            ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                        }
                        int hours = totalMinutes / 60;
                        int remainingMinutes = totalMinutes % 60;
                        txtHours.Text = hours.ToString();
                        txtMin.Text = remainingMinutes.ToString();
                        string currentImg = reader.GetValue(2).ToString();
                        lblImg.Text = "The file location: " + currentImg;
                        serviceImage.ImageUrl = currentImg;
                    }
                    else
                    {
                        string script = "alert('There is an error has been found.'), "+
                                "window.location.href = 'ServiceManagement.aspx';";
                        ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                    }
                }
                else
                {
                    string script = "alert('You cannot directly access this page.'), "+
                                "window.location.href = 'ServiceManagement.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                }
            }
        }

        protected bool serviceExisted(string service)
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
            con.Open();
            string query = "SELECT COUNT(*) FROM [service] WHERE serviceName = @serviceName";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@serviceName", service);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0;
            }
        }

        protected bool sameCurrentName(string service)
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
            con.Open();
            string query = "SELECT COUNT(*) FROM [service] WHERE serviceID = @serviceID AND serviceName = @serviceName;";
            using(SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@serviceID", Request.QueryString["serviceID"]);
                cmd.Parameters.AddWithValue("@serviceName", service);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0;
            }
        }

        protected void txtPrice_TextChanged(object sender, EventArgs e)
        {
            if (!decimal.TryParse(txtPrice.Text, out _))
            {
                lblErrorPrice.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                lblErrorPrice.Text = "\u274CPlease ensure that only number can be filled in this field.";
                txtPrice.Text = "0.00";
            }
        }
        protected int ExtractMinutes(string input)
        {
            string numericPart = new string(input.ToCharArray().Where(char.IsDigit).ToArray());
            if (int.TryParse(numericPart, out int result))
            {
                return result;
            }
            else
            {
                return -1;
            }
        }

        protected void btnEditSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
            con.Open();
            string serviceID = Request.QueryString["serviceID"];
            string serviceName = txtSName.Text.Trim();
            int hours = int.Parse(txtHours.Text);
            int minutes = int.Parse(txtMin.Text);
            decimal price = decimal.Parse(txtPrice.Text);
            string description = txtDesc.Text;
            bool durationValid = (hours == 0 && minutes == 0);
            string duration;
            string folderPath = Server.MapPath("/Service_Images/");
            string imageName = serviceImage.ImageUrl;

            if (!sameCurrentName(serviceName))
            {
                ValidateAndHandleError(serviceExisted(serviceName), lblErrorName,
                    "\u274C The service name is already existed.");
            }            
            ValidateAndHandleError(string.IsNullOrEmpty(serviceName), lblErrorName,
                "\u274C Please ensure this field has been filled.");
            ValidateAndHandleError(string.IsNullOrEmpty(description), lblErrorDesc,
                "\u274C Please ensure this field has been filled.");
            ValidateAndHandleError(durationValid, lblErrorDuration,
                "\u274C Please ensure the both hours and minutes cannot be zero.");
            ValidateAndHandleError(price <= 0, lblErrorPrice,
                "\u274C Please ensure the price cannot be zero.");

            if (fupImg.HasFile)
            {
                if (!ImageValidation(fupImg))
                {
                    printErrorMsg(lblErrorImg,
                        "\u274C Please ensure your file format in .jpg, .jpeg and .png.");
                }
                else
                {
                    File.Delete(Path.Combine(folderPath, Path.GetFileName(imageName)));
                    string saveFile = fileRename(serviceID, folderPath, fupImg);
                    fupImg.SaveAs(saveFile);
                }
            }

            if (error == 0)
            {

                if (hours == 0)
                {
                    duration = minutes.ToString() + "minutes";
                }
                else
                {
                    if (minutes == 0)
                    {
                        duration = ((hours*60).ToString()) + "minutes";
                    }
                    else
                    {
                        duration = (((hours*60)+minutes).ToString()) + "minutes";
                    }
                }
                string editService = "UPDATE service " +
                    "SET serviceName = @name, serviceImage = @image, serviceDescription = @description, duration = @duration, servicePrice = @price " +
                    "WHERE serviceID = @id";
                using (SqlCommand cmd = new SqlCommand(editService, con))
                {
                    cmd.Parameters.AddWithValue("@id", serviceID);
                    cmd.Parameters.AddWithValue("@name", serviceName);
                    cmd.Parameters.AddWithValue("@image", imageName);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@duration", duration);
                    cmd.Parameters.AddWithValue("@price", price);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected != 0)
                    {
                        string script = "alert('Data updated successfully.')," +
                            " window.location.href = 'ServiceManagement.aspx';";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", script, true);
                    }
                    else
                    {
                        string script = "alert('Data updated failed. Please try again.');";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Failed", script, true);
                    }
                }
            }
            else
            {
                string script = "alert('Your updated data is failed!');";
                ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
            }
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

        protected string fileRename(string id, string saveFolder, FileUpload uploadFile)
        {
            string newFileName = id + Path.GetExtension(uploadFile.FileName);
            return Path.Combine(saveFolder, newFileName);
        }

        protected void ValidateAndHandleError(bool condition, Label label, string errorMsg)
        {
            if (condition)
            {
                error += 1;
                label.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
                label.Text = errorMsg;
            }
        }

        protected void printErrorMsg(Label label, string errorMsg)
        {
            error += 1;
            label.ForeColor = System.Drawing.ColorTranslator.FromHtml("red");
            label.Text = errorMsg;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSName.Text = "";
            txtDesc.Text = "";
            txtPrice.Text = "0.00";
            txtHours.Text = "0";
            txtMin.Text = "0";
        }
    }
}