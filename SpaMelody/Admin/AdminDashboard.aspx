<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="MelodySpa.AdminDashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style7 {
            font-weight: bold;
        }
    .auto-style8 {
        text-align: left;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="auto-style8">
        <asp:Label ID="lblAdmin" runat="server" Text="Admin Dashboard" ForeColor="White" Font-Size="26px"></asp:Label>
    </h1>
    <p>
        <asp:Label ID="lblToDo" runat="server" ForeColor="White" Text="What do you want to do today?" Font-Size="20px"></asp:Label>
    </p>

    <table style="width:100%;">
        <tr>
            <td>
                <asp:Button ID="btnService" runat="server" Text="Service Management" Width="100%" BackColor="#CC9900" ForeColor="#663300" Height="9em" Font-Bold="True" Font-Size="Small" Font-Strikeout="False" PostBackUrl="~/Admin/ServiceManagement.aspx" />
            </td>
            <td>
                <strong>
                <asp:Button ID="btnCus" runat="server" BackColor="#CC9900" CssClass="auto-style7" ForeColor="#663300" Height="4.5em" Text="Customer List" Width="100%" PostBackUrl="~/Admin/CustomerList.aspx" />
                </strong>
                <asp:Button ID="btnBooking" runat="server" Text="Booking List" Width="100%" BackColor="#CC9900" Height="4.5em" Font-Bold="True" ForeColor="#663300" PostBackUrl="~/Admin/BookingList.aspx" />
            </td>
            <td>
                <asp:Button ID="btnYReport" runat="server" Text="Report Generator" Width="100%" BackColor="#CC9900" Height="9em" Font-Bold="True" Font-Overline="False" ForeColor="#663300" PostBackUrl="~/Admin/ReportGenerator.aspx" />
            </td>
        </tr>
    </table>

</asp:Content>
