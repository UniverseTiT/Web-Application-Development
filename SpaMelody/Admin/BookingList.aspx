<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="BookingList.aspx.cs" Inherits="MelodySpa.BookingList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            font-size: xx-large;
        }

        #row1 {
            background-color: orange;
        }

            #row1 td {
                color: saddlebrown;
            }

        .auto-style3 {
            text-align: center;
        }

        .tblBook {
            width: 50em;
            margin: 10px;
        }

        .selectBook {
            text-decoration: none;
            color: brown;
            text-align: center;
            font-family: 'Times New Roman', Times, serif;
        }

            .selectBook:hover {
                text-decoration: underline;
            }

        .buttonStyle {
            width: 100%;
            font-family: 'Times New Roman', Times, serif;
            border: none;
            color: white;
            padding: 15px 0px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }

            .buttonStyle:hover {
                background-color: orange;
            }

        .tblDetail td {
            padding: 20px;
            background-color: saddlebrown;
        }

        .tblDetail {
            width: 30em;
        }

        .divTbl {
            padding: 30px;
            margin: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>
        <asp:Label ID="Label8" runat="server" CssClass="auto-style2" Text="Booking List" Font-Size="26px"></asp:Label>
    </h1>
    <p style="font-size: 20px;">
        Please select a date:
    <asp:DropDownList ID="drpDate" runat="server" Width="291px" DataSourceID="sqlDrpDate" DataTextField="bookingDate" DataValueField="bookingDate" DataTextFormatString="{0:dd/MM/yyyy}">
        <asp:ListItem Value="All"></asp:ListItem>
    </asp:DropDownList>
        <asp:Button ID="btnSearch" runat="server" Text="Search" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnSearch_Click" />
        <asp:Button ID="btnReload" runat="server" Text="Refresh" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnReload_Click" />
    </p>
    <div class="auto-style3">
        <asp:GridView ID="gridBooking" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="bookingID" DataSourceID="sqlBooking" PageSize="6"
            OnRowCommand="rowCommand" OnRowDataBound="rowDataBound" CssClass="tblBook" OnSelectedIndexChanged="gridBooking_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="bookingID" HeaderText="Booking ID" ReadOnly="True" SortExpression="bookingID" />
                <asp:BoundField DataField="bookingDate" HeaderText="Date" SortExpression="bookingDate" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="bookingTime" HeaderText="Time" SortExpression="bookingTime" DataFormatString="{0:hh\:mm}" />
                <asp:BoundField DataField="username" HeaderText="Customer" SortExpression="username" />
                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                <asp:CommandField ControlStyle-CssClass="selectBook" ShowSelectButton="True" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnChgStatus" runat="server" CssClass="buttonStyle" CommandName="ChangeStatus" CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return confirmMsg(this)" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="sqlBooking" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT b.bookingID, b.bookingDate, b.bookingTime, u.username, b.status FROM [booking] b JOIN [user] u ON u.userID = b.userID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDrpDate" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT DISTINCT [bookingDate] FROM [booking]"></asp:SqlDataSource>
    <div class="divTbl">
        <strong>
            <asp:Label ID="lblDetail" runat="server" Text=""></asp:Label>
        </strong>
        <table class="tblDetail" runat="server" id="tblDetail" visible="false">
            <tr>
                <td>Booking ID</td>
                <td>:</td>
                <td runat="server" id="id"></td>
            </tr>
            <tr>
                <td>Service Booked</td>
                <td>:</td>
                <td runat="server" id="serviceList"></td>
            </tr>
            <tr>
                <td>Total Fees</td>
                <td>:</td>
                <td runat="server" id="total"></td>
            </tr>
            <tr>
                <td>Comment</td>
                <td>:</td>
                <td runat="server" id="comment"></td>
            </tr>
        </table>
    </div>
    <script>
        function confirmMsg(button) {
            var row = button.parentNode.parentNode;
            var booking = row.cells[0].innerHTML;
            var status = row.cells[4].innerHTML;
            if (status == "Confirmed") {
                var confirmMsg = "Do you sure to complete the " + booking + " booking?\n";
                if (confirm(confirmMsg)) {
                    return true;
                } else {
                    return false;
                }
            } else if (status == "Completed") {
                var confirmMsg = "You cannot change the booking status which is completed.";
                alert(confirmMsg);
            }
        }

        var detailTbl = document.getElementsById("tblDetails");
        var divBackground = document.getElementsById("divTbl");
        function isTableVisible() {
            var tableStyle = window.getComputedStyle(detailTbl);
            return tableStyle.display !== "none";
        }

        function setDivBackgroundColor() {
            if (isTableVisible()) {
                divBackground.style.backgroundColor = "red";
            }
        }

        setDivBackgroundColor();

    </script>
</asp:Content>
