<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CustomerList.aspx.cs" Inherits="MelodySpa.CustomerList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .selectCus {
            text-decoration: none;
            color: brown;
            text-align: center;
            font-family: 'Times New Roman', Times, serif;
        }

            .selectCus:hover {
                color: orange;
                text-decoration: underline;
            }

        .auto-style24 {
            font-size: larger;
        }

        .tblCus {
            width: 50em;
            margin: 10px;
        }

        .lblStyle {
            font-size: 20px;
        }

        .tblStyle {
            padding: 30px;
            margin: 20px;
        }

        [name="tableDetail"] td {
            padding: 20px;
            background-color: saddlebrown;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>
        <asp:Label ID="lblSM" runat="server" Text="Customer List" ForeColor="White" CssClass="auto-style24" Font-Size="26px"></asp:Label>
    </h1>
    <p>
        <asp:TextBox ID="txtSearchID" runat="server" Height="30px" Width="208px"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnSearch_Click" />
        <asp:Button ID="btnReload" runat="server" Text="Refresh" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnReload_Click" />
    </p>
    <asp:GridView ID="gridCustomer" runat="server" CssClass="tblCus" AllowPaging="True" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="userID" DataSourceID="sqlCustomer" PageSize="6" OnSelectedIndexChanged="gridCustomer_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="userID" HeaderText="ID" ReadOnly="True" SortExpression="userID" />
            <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" />
            <asp:BoundField DataField="emailAddress" HeaderText="Email" SortExpression="emailAddress" />
            <asp:BoundField DataField="phoneNum" HeaderText="Phone No." SortExpression="phoneNum" />
            <asp:BoundField DataField="gender" HeaderText="Gender" SortExpression="gender" />
            <asp:BoundField DataField="Age" HeaderText="Age" ReadOnly="True" SortExpression="Age" />
            <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="selectCus" />
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
        <EmptyDataTemplate>
            <p style="color: brown;">No records found.</p>
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT 
    [userID], 
    [username], 
    [emailAddress], 
    [phoneNum], 
    [gender], 
    DATEDIFF(YEAR, dateOfBirth, GETDATE()) AS Age 
FROM 
    [user] 
WHERE 
    role = 'customer';
"
        FilterExpression="[username] LIKE '{0}%'">
        <FilterParameters>
            <asp:ControlParameter Name="Username" ControlID="txtSearchID" PropertyName="Text" />
        </FilterParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    <div class="tblStyle" id="divTbl">
        <strong>
            <asp:Label ID="lblDetail" runat="server" CssClass="lblStyle"></asp:Label>
        </strong>
        <table name="tableDetail" id="tblDetails" visible="false" runat="server">
            <tr>
                <td>Name</td>
                <td>:</td>
                <td runat="server" id="cusName"></td>
            </tr>
            <tr>
                <td>Booking Times</td>
                <td>:</td>
                <td runat="server" id="booking"></td>
            </tr>
            <tr>
                <td>Latest Booking</td>
                <td>:</td>
                <td runat="server" id="latestBooking"></td>
            </tr>
        </table>
    </div>
    <script>
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
