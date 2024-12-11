using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa
{
    public partial class AddService : System.Web.UI.Page
    {
        private int error = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
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

        private string GenerateNewServiceId(SqlConnection con)
        {
            SqlCommand readLatestID =
                 new SqlCommand(
                     "SELECT MAX(CAST(SUBSTRING(serviceID, 2, LEN(serviceID)-1) AS INT)) AS max_id FROM service", con);
            object result = readLatestID.ExecuteScalar();
            if (result != DBNull.Value)
            {
                string latestID = "S" + result.ToString().PadLeft(4, '0');
                int numericPart = int.Parse(latestID.Substring(1)) + 1;
                return "S" + numericPart.ToString().PadLeft(4, '0');
            }
            return "S0001";
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

        protected bool serviceExisted(string service)
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
            con.Open();
            string query = "SELECT COUNT(*) FROM [service] WHERE serviceName = @serviceName";
            using(SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@serviceName", service);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if(count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        protected void btnAddSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
            con.Open();
            string serviceID = GenerateNewServiceId(con);
            string serviceName = txtSName.Text;           
            int hours = int.Parse(inputHours.Value);
            int minutes = int.Parse(inputMin.Value);
            decimal price = decimal.Parse(txtPrice.Text);
            string description = txtDesc.Value;
            bool durationValid = (hours == 0 && minutes == 0);
            string duration;
            string folderPath = Server.MapPath("/Service_Images/");
            string folderName = "\\Service_Images\\";
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            ValidateAndHandleError(serviceExisted(serviceName), lblErrorName,
                "\u274C The service name is already existed.");

            if (fupImg.HasFile)
            {
                if (!ImageValidation(fupImg))
                {
                    printErrorMsg(lblErrorImg,
                        "\u274C Please ensure your file format in .jpg, .jpeg and .png.");
                }
            }
            else
            {
                printErrorMsg(lblErrorImg,
                    "\u274C Please upload your image file in .jpg, .png and .jpeg format.");
            }

            ValidateAndHandleError(string.IsNullOrEmpty(serviceName), lblErrorName,
                "\u274C Please ensure this field has been filled.");
            ValidateAndHandleError(string.IsNullOrEmpty(description), lblErrorDesc,
                "\u274C Please ensure this field has been filled.");
            ValidateAndHandleError(durationValid, lblErrorDuration,
                "\u274C Please ensure the both hours and minutes cannot be zero.");
            ValidateAndHandleError(price <= 0, lblErrorPrice,
                "\u274C Please ensure the price cannot be zero.");

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
                string saveFile =  fileRename(serviceID, folderPath, fupImg);
                fupImg.SaveAs(saveFile);
                string imageName = fileRename(serviceID, folderName, fupImg);
                string insertService = "INSERT INTO service " +
                    "VALUES (@id, @name, @image, @description, @duration, @price, @status);";
                using (SqlCommand cmd = new SqlCommand(insertService, con))
                {
                    cmd.Parameters.AddWithValue("@id", serviceID);
                    cmd.Parameters.AddWithValue("@name", serviceName);
                    cmd.Parameters.AddWithValue("@image", imageName);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@duration", duration);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@status", "Available");

                    if (con.State != ConnectionState.Open)
                    {
                        con.Open();
                    }
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected != 0)
                    {
                        string script = "if(confirm('The service is inserted successfully! Do you want to continue?'))" +
                            " { window.location.href = 'AddService.aspx';}" +
                            "else{ " +
                            "window.location.href = 'ServiceManagement.aspx';" +
                            "}";
                        ClientScript.RegisterStartupScript(this.GetType(), "Success!", script, true);
                    }
                    else
                    {
                        string script = "alert('Your input data is failed!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                    }
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSName.Text = "";
            txtDesc.Value = "";
            txtPrice.Text = "0.00";
            inputHours.Value = "0";
            inputMin.Value = "0";
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


    }
}