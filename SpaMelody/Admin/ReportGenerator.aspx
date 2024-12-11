<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ReportGenerator.aspx.cs" Inherits="MelodySpa.Admin.ReportGenerator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            width: 160px;
        }

        .auto-style4 {
            width: 20px;
        }

        .auto-style6 {
            width: 40em;
        }

        .auto-style7 {
            width: 271px;
        }

        .auto-style8 {
            width: 160px;
            height: 99px;
        }

        .auto-style9 {
            width: 20px;
            height: 99px;
        }

        .auto-style10 {
            width: 271px;
            height: 99px;
        }

        .auto-style11 {
            height: 99px;
        }

        .buttonGenerate {
            background-color: #CC9900;
            color: maroon;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="font-size: 26px;">Sales Report Generator</h1>
    <table class="auto-style6">
        <tr>
            <td class="auto-style3">Start Date</td>
            <td class="auto-style4">:</td>
            <td class="auto-style7">
                <asp:DropDownList ID="drpStartDate" runat="server" DataSourceID="sqlStart" DataTextField="bookingDate" DataValueField="bookingDate" DataTextFormatString="{0:dd/MM/yyyy}" Height="2em" Width="10em">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lblErrStart" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">End Date</td>
            <td class="auto-style4">:</td>
            <td class="auto-style7">
                <asp:DropDownList ID="drpEndDate" runat="server" DataSourceID="sqlEnd" DataTextField="bookingDate" DataValueField="bookingDate" DataTextFormatString="{0:dd/MM/yyyy}" Height="2em" Width="10em">
                </asp:DropDownList>
            </td>
            <td>
                <asp:Label ID="lblErrEnd" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">Services' Status
            </td>
            <td class="auto-style4">:
            </td>
            <td class="auto-style7">
                <asp:RadioButtonList ID="rblServiceStatus" runat="server">
                    <asp:ListItem Value="Avaliable">Services Avaliable Only</asp:ListItem>
                    <asp:ListItem Value="All">All Services</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>
                <asp:Label ID="lblErrorService" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8">Booking Status
            </td>
            <td class="auto-style9">:
            </td>
            <td class="auto-style10">
                <asp:RadioButtonList ID="rblBookingStatus" runat="server">
                    <asp:ListItem Value="Booked">Booked Only</asp:ListItem>
                    <asp:ListItem>Completed</asp:ListItem>
                    <asp:ListItem Value="All ">All Booking</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="auto-style11">
                <asp:Label ID="lblErrBooking" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style3">
                <asp:SqlDataSource ID="sqlStart" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT DISTINCT [bookingDate] FROM booking "></asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlEnd" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT [bookingDate]
FROM [booking]
GROUP BY [bookingDate]
ORDER BY MAX([bookingID]) DESC;"></asp:SqlDataSource>
            </td>
            <td class="auto-style4"></td>
            <td class="auto-style7">
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" OnClick="btnGenerate_Click" CssClass="buttonGenerate" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
