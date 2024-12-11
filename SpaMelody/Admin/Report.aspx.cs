using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MelodySpa.Admin
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.IsInRole("admin"))
            {
                Response.Redirect(ResolveUrl("~/Error/401.aspx"));
            }
            if (!IsPostBack)
            {
                string startDate = Request.QueryString["start"];
                string endDate = Request.QueryString["end"];
                string serviceStatus = Request.QueryString["service"];
                string bookingStatus = Request.QueryString["booking"];
                if (string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate) || string.IsNullOrEmpty(serviceStatus) || string.IsNullOrEmpty(bookingStatus))
                {
                    string script = "alert('You cannot directly access this page.'), "+
                                "window.location.href = 'ReportGenerator.aspx';";
                    ClientScript.RegisterStartupScript(this.GetType(), "Failed", script, true);
                }
                else
                {
                    string query = string.Empty;
                    switch (serviceStatus)
                    {
                        case "Avaliable":
                            switch (bookingStatus)
                            {
                                case "Booked":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "SUM(s.servicePrice) * COUNT(b.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "WHERE " +
                                        "s.status = 'Avaliable' " +
                                        "AND " +
                                        "b.status = 'Confirmed' " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "COUNT(bs.bookingID) DESC;";
                                    break;
                                case "Completed":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "SUM(s.servicePrice) * COUNT(b.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "WHERE " +
                                        "s.status = 'Avaliable' " +
                                        "AND " +
                                        "b.status = 'Confirmed' " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "bookingTimes DESC;";
                                    break;
                                case "All":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "SUM(s.servicePrice) * COUNT(b.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "WHERE " +
                                        "s.status = 'Avaliable' " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "bookingTimes DESC;";
                                    break;
                            }
                            break;

                        case "All":
                            switch (bookingStatus)
                            {
                                case "Booked":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "SUM(s.servicePrice) * COUNT(b.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "WHERE " +
                                        "b.status = 'Confirmed' " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "bookingTimes DESC;";
                                    break;
                                case "Completed":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "SUM(s.servicePrice) * COUNT(b.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "WHERE " +
                                        "b.status = 'Completed' " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "bookingTimes DESC;";
                                    break;
                                case "All":
                                    query = "SELECT " +
                                        "s.serviceID, " +
                                        "s.serviceName, " +
                                        "s.servicePrice, " +
                                        "COUNT(bs.bookingID) AS bookingTimes, " +
                                        "s.servicePrice * COUNT(bs.bookingID) AS total " +
                                        "FROM " +
                                        "service s " +
                                        "JOIN " +
                                        "bookingService bs ON s.serviceID = bs.serviceID " +
                                        "JOIN " +
                                        "booking b ON bs.bookingID = b.bookingID " +
                                        "GROUP BY " +
                                        "s.serviceID, s.serviceName, s.servicePrice " +
                                        "ORDER BY " +
                                        "bookingTimes DESC;";
                                    break;
                            }
                            break;
                    }

                    DateTime.TryParse(startDate, out DateTime start);
                    DateTime.TryParse(endDate, out DateTime end);
                    lblReport.Text = "Top Sales Report from " + start.ToString("dd/MM/yyyy") + " to " + end.ToString("dd/MM/yyyy");
                    SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\SpaMelodyDB.mdf;Integrated Security=True;");
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dataTable = new DataTable();
                        adapter.Fill(dataTable);
                        gridReport.DataSource = dataTable;
                        gridReport.DataBind();
                    }
                }
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            int columnsCount = gridReport.HeaderRow.Cells.Count;
            PdfPTable pdfTable = new PdfPTable(columnsCount);
            foreach (TableCell gridViewHeaderCell in gridReport.HeaderRow.Cells)
            {
                Font font = new Font();
                font.Color = new BaseColor(gridReport.HeaderStyle.ForeColor);
                PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font));
                pdfCell.BackgroundColor = new BaseColor(gridReport.HeaderStyle.BackColor);
                pdfCell.Padding = 10;
                pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;
                pdfTable.AddCell(pdfCell);
            }
            bool skipFirstCell = true;
            foreach (GridViewRow gridViewRow in gridReport.Rows)
            {
                if (gridViewRow.RowType == DataControlRowType.DataRow)
                {
                    Font fontBilNo = new Font();
                    fontBilNo.Color = new BaseColor(gridReport.RowStyle.ForeColor);
                    PdfPCell pdfBilNoCell = new PdfPCell(new Phrase((gridViewRow.DataItemIndex + 1).ToString(), fontBilNo));
                    pdfBilNoCell.BackgroundColor = new BaseColor(gridReport.RowStyle.BackColor);
                    pdfBilNoCell.Padding = 10;
                    pdfBilNoCell.HorizontalAlignment = Element.ALIGN_CENTER;
                    pdfTable.AddCell(pdfBilNoCell);
                    for (int i = 0; i < gridViewRow.Cells.Count; i++)
                    {
                        TableCell gridViewCell = gridViewRow.Cells[i];

                        if (i == 0 && gridReport.Columns[i] is TemplateField)
                        {
                            continue;
                        }

                        Font font = new Font();
                        font.Color = new BaseColor(gridReport.RowStyle.ForeColor);
                        PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));
                        pdfCell.BackgroundColor = new BaseColor(gridReport.RowStyle.BackColor);
                        pdfCell.Padding = 10;
                        pdfCell.HorizontalAlignment = Element.ALIGN_CENTER;
                        pdfTable.AddCell(pdfCell);
                    }
                }
            }


            Document pdfDocument = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfWriter.PageEvent = new PdfWatermark("SPA Melody Report");

            pdfDocument.Open();
            Font fontTitle = new Font();
            fontTitle.SetFamily("Helvetica");
            fontTitle.SetStyle(Font.BOLD);
            Paragraph title = new Paragraph(lblReport.Text.ToString(), fontTitle);
            title.Alignment = Element.ALIGN_CENTER;
            pdfDocument.Add(title);
            pdfDocument.Add(new Paragraph(" "));
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition",
                "attachment;filename=TopSalesReport.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }

        public class PdfWatermark : PdfPageEventHelper
        {
            private string watermarkText;

            public PdfWatermark(string text)
            {
                watermarkText = text;
            }

            public override void OnEndPage(PdfWriter writer, Document document)
            {
                PdfContentByte cb = writer.DirectContentUnder;
                Font font = new Font(Font.FontFamily.HELVETICA, 40, Font.NORMAL, BaseColor.LIGHT_GRAY);
                Phrase watermark = new Phrase(watermarkText, font);
                ColumnText.ShowTextAligned(cb, Element.ALIGN_CENTER, watermark, document.PageSize.Width / 2, document.PageSize.Height / 2, 45);
            }
        }


        public override void VerifyRenderingInServerForm(Control control)
        {
        }

    }
}