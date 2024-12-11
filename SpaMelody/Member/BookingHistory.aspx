<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookingHistory.aspx.cs" Inherits="MelodySpa.BookingHistory" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
        <AlternatingRowStyle BackColor="PaleGoldenrod" />
        <Columns>
            <asp:BoundField DataField="bookingID" HeaderText="bookingID" SortExpression="bookingID" />
            <asp:BoundField DataField="bookingDate" HeaderText="bookingDate" SortExpression="bookingDate" />
            <asp:BoundField DataField="bookingTime" HeaderText="bookingTime" SortExpression="bookingTime" />
            <asp:BoundField DataField="paymentID" HeaderText="paymentID" SortExpression="paymentID" />
            <asp:BoundField DataField="total" HeaderText="total" SortExpression="total" />
            <asp:BoundField DataField="paymentMethod" HeaderText="paymentMethod" SortExpression="paymentMethod" />

            

        
            
            
            <asp:BoundField DataField="comment" HeaderText="comment" SortExpression="comment" />

                     <asp:HyperLinkField DataNavigateUrlFields="bookingID" DataNavigateUrlFormatString="/Member/RateComment.aspx?bookingID={0}" Text="Rate">
     <ControlStyle CssClass="hyperlink" />
 </asp:HyperLinkField>
        </Columns>
        <FooterStyle BackColor="Tan" />
        <HeaderStyle BackColor="Tan" Font-Bold="True" />
        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
        <SortedAscendingCellStyle BackColor="#FAFAE7" />
        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
        <SortedDescendingCellStyle BackColor="#E1DB9C" />
        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT booking.bookingID, booking.bookingDate, booking.bookingTime, payment.paymentID, payment.total, payment.paymentMethod, rating.comment FROM booking INNER JOIN booking AS booking_1 ON booking.bookingID = booking_1.bookingID INNER JOIN payment ON booking.bookingID = payment.bookingID AND booking_1.bookingID = payment.bookingID LEFT JOIN rating ON booking.ratingID = rating.ratingID AND booking_1.ratingID = rating.ratingID WHERE booking.userID = @UserID"></asp:SqlDataSource>
</asp:Content>
