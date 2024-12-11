<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PaymentSuccess.aspx.cs" Inherits="MelodySpa.PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .info, .info table, .info th, .info td {
            border-bottom: 1px solid white;
            border-collapse: collapse;
        }


        /* Set styles for even columns in tables with the "custom-table" class and "custom-row" class */
        .custom-table td:nth-child(odd) {
            width: 20%; /* Set the width for even columns in specific rows */
        }

        /* Set styles for odd columns in tables with the "custom-table" class and "custom-row" class */
        .custom-table td:nth-child(even) {
            width: 30%; /* Set the width for odd columns in specific rows */
        }

        td {
            padding: 1%;
        }

        .button-hover {
            padding: 0.5%;
            cursor: pointer;
        }

       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; background-color: #403630; width: 98%; padding: 1%; margin-bottom: 2%;">
        <div style="width: 30%; margin: 0 auto; border-bottom: solid 1px white;">
            <asp:Label ID="Label8" runat="server" Text="Payment Success   " Font-Size="26px"></asp:Label><asp:Image runat="server" ImageUrl="../Icon/check.png"></asp:Image>
        </div>
        <div style="margin-top: 1%;">

<%--            <asp:Label ID="Label9" runat="server" Text="How was your purchase?" Font-Size="20px"></asp:Label>--%>
<%--            <div style="margin-top: 0.5%; margin-bottom: 1%">

                <asp:ImageButton ID="star1" runat="server" ImageUrl="../Icon/star.png" OnClick="star1_Click"></asp:ImageButton>
                <asp:ImageButton ID="star2" runat="server" ImageUrl="../Icon/star.png" OnClick="star2_Click"></asp:ImageButton>
                <asp:ImageButton ID="star3" runat="server" ImageUrl="../Icon/star.png" OnClick="star3_Click"></asp:ImageButton>
                <asp:ImageButton ID="star4" runat="server" ImageUrl="../Icon/star.png" OnClick="star4_Click"></asp:ImageButton>
                <asp:ImageButton ID="star5" runat="server" ImageUrl="../Icon/star.png" OnClick="star5_Click"></asp:ImageButton>


            </div>--%>
            <asp:Button ID="Button1" runat="server" Text="Back To Home" BackColor="#D4C19A" ForeColor="#403630" PostBackUrl="~/Home.aspx" Font-Size="18px" Font-Names="'Times New Roman', Times, serif" CssClass="button-hover" />

        </div>
    </div>
        <div style="background-color: #403630; width: 98%; padding: 1%;">

        <table style="width: 100%; background-color: #403630;" class="info" id="tableServiceSelected">
            <tr>
                <td colspan="2">
                    <div style="border-bottom: 1px solid white; width: fit-content;">


                        <asp:Label ID="Label21" runat="server" Text="Booking Detail" Font-Size="26px"></asp:Label>

                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 50%;">
                    <asp:Label ID="Label16" runat="server" Text="Service Date:" Font-Size="20px"></asp:Label>
                    <asp:Label ID="lblBookingDate" runat="server" Font-Size="20px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label15" runat="server" Text="Service Time:" Font-Size="20px"></asp:Label>
                    <asp:Label ID="lblBookingTime" runat="server" Font-Size="20px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label13" runat="server" Text="Service Booked:" Font-Size="20px"></asp:Label>

                    <br />
                    <div style="padding-left: 2%;">
                        <table style="width: 100%" id="detailTable">
                            <thead>
                                <tr>
                                    <td style="font-size: 20px">Name</td>
                                    <td style="text-align: end; font-size: 20px">Price</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%foreach (SERVICE service in serviceList)
                                    {  %>
                                <tr>
                                    <td style="font-size: 20px"><%= service.name %></td>
                                    <td style="font-size: 20px; text-align: end;"><%=service.price %></td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>

                    </div>
                </td>
            </tr>
            <tr>
                <td style="border-right: none;">
                    <asp:Label ID="Label17" runat="server" Text="Total Price:" Font-Size="20px"></asp:Label>
                </td>
                <td style="text-align: end; border-left: none;">
                    <asp:Label ID="lblTotalPrice" runat="server" Font-Size="20px"></asp:Label>

                </td>
            </tr>
        </table>
    </div>
<%--    <div style="background-color: #403630;width:98%; padding:1%;">--%>
    <%--<table style="width: 100%;" class="info" id="tableServiceSelected">
        <tr>
            <td colspan="2">
              <div style="border-bottom:1px solid white;width:fit-content;">

                  <asp:Label ID="Label20" runat="server" Font-Size="26px" Text="Booking Detail"></asp:Label>

              </div>
                
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="Label16" runat="server" Text="Service Date:" Font-Size="20px"></asp:Label>
                <asp:Label ID="lblBookingDate" runat="server" Font-Size="20px">1/1/2023</asp:Label>
            </td>
            <td class="auto-style2">
                <asp:Label ID="Label15" runat="server" Text="Service Time:" Font-Size="20px"></asp:Label>
                <asp:Label ID="lblBookingTime" runat="server"  Font-Size="20px">9:00AM</asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="Label13" runat="server" Text="Service Booked:" Font-Size="20px"></asp:Label>
                <br />
                <table style="padding-left: 2%;width:100%;">
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectedService" runat="server" Font-Size="20px">Arona Massage</asp:Label>
                        </td>
                        <td style="text-align: end;">
                            <asp:Label ID="Label22" runat="server" Text="RM 65.00" Font-Size="20px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label21" runat="server" Text="Thai Massage" Font-Size="20px"></asp:Label>
                        </td>
                        <td style="text-align: end;">
                            <asp:Label ID="Label23" runat="server" Text="RM 85.00" Font-Size="20px" ></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: end; border-left: none;">
                <asp:Label ID="Label18" runat="server" Text="Total: "  Font-Size="20px"></asp:Label>
                <asp:Label ID="Label19" runat="server" Text="RM100:00"  Font-Size="20px"></asp:Label>
            </td>
        </tr>
    </table>--%>
<%--        </div>--%>
</asp:Content>
