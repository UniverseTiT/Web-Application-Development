<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ServiceManagement.aspx.cs" Inherits="MelodySpa.ServiceManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style7 {
            width: 122px;
            height: 24px;
        }

        #row1 {
            background-color: orange;
        }

        #ServiceList td {
            padding: 0;
        }

        #ServiceList tr {
            height: 50px;
        }

        #ServiceList {
            border-color: darkgoldenrod;
        }

        #row1 td {
            color: saddlebrown;
        }

        .auto-style24 {
            font-size: larger;
        }

        .auto-style38 {
            width: 222px;
            height: 24px;
        }

        .auto-style41 {
            width: 387px;
            height: 24px;
        }

        .auto-style42 {
            height: 24px;
        }

        .buttonStyle {
            width: 100%;
            background-color: maroon;
            font-family: 'Times New Roman', Times, serif;
            border: none;
            color: white;
            padding: 15px 0px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }

        .hyperlink {
            text-decoration: none;
            color: brown;
            text-align: center;
            font-family: 'Times New Roman', Times, serif;
        }

            .hyperlink:hover {
                color: orange;
                text-decoration: underline;
            }

        .buttonStyle:hover {
            background-color: orange;
        }

        .auto-style43 {
            text-align: center;
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
        <asp:Label ID="lblSM" runat="server" Text="Service Management" ForeColor="White" CssClass="auto-style24" Font-Size="26px"></asp:Label>
    </h1>
    <p>
        <asp:TextBox ID="txtSearchID" runat="server" Height="30px" Width="208px"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnSearch_Click" />
        <asp:Button ID="btnReload" runat="server" Text="Refresh" Width="6em" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="30px" OnClick="btnReload_Click" />
    </p>

    <table id="ServiceList" style="width: 100%;" border="1">
        <tr>
            <td colspan="4" class="auto-style43">
                <asp:GridView ID="gridService" runat="server" AllowPaging="True" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" Width="100%" AutoGenerateColumns="False" DataKeyNames="serviceID" DataSourceID="sqlService" OnSelectedIndexChanged="gridService_SelectedIndexChanged"
                    OnRowCommand="rowCommand" OnRowDataBound="rowDataBound" PageSize="6">
                    <Columns>
                        <asp:BoundField DataField="serviceID" HeaderText="Service ID" ReadOnly="True" SortExpression="serviceID" />
                        <asp:BoundField DataField="serviceName" HeaderText="Service Name" SortExpression="serviceName" />
                        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                        <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="hyperlink">
                            <ControlStyle CssClass="hyperlink"></ControlStyle>
                            <FooterStyle CssClass="hyperlink" />
                            <HeaderStyle CssClass="hyperlink" />
                            <ItemStyle CssClass="hyperlink" />
                        </asp:CommandField>
                        <asp:HyperLinkField DataNavigateUrlFields="serviceID" DataNavigateUrlFormatString="/Admin/EditService.aspx?serviceID={0}" Text="Edit">
                            <ControlStyle CssClass="hyperlink" />
                        </asp:HyperLinkField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button CssClass="buttonStyle" ID="btnChangeStatus" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CausesValidation="false" CommandName="ChangeStatus" OnClientClick="return confirmMsg(this);" />
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
                    <EmptyDataTemplate>
                        <p style="color: brown;">No results found.</p>
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
        </tr>
        <tr id="LastRow">
            <td class="auto-style7">
                <asp:SqlDataSource ID="sqlService" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT [serviceID], [serviceName], [status] FROM [service]"
                    FilterExpression="[serviceName] LIKE '{0}%'">
                    <FilterParameters>
                        <asp:ControlParameter Name="Service Name" ControlID="txtSearchID" PropertyName="Text" />
                    </FilterParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style41">
                <asp:SqlDataSource ID="sqlDetails" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT [serviceName], [serviceImage], [serviceDescription], [duration], [servicePrice] FROM [service] WHERE ([serviceID] = @serviceID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gridService" Name="serviceID" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style38"></td>
            <td class="auto-style42">
                <asp:Button ID="btnAdd" runat="server" Text="Add New Service" Width="100%" BackColor="#FF9900" Font-Bold="True" ForeColor="White" Height="60px" PostBackUrl="~/Admin/AddService.aspx" />
            </td>
        </tr>
    </table>
    <div class="tblStyle" id="divTbl">
        <strong>
            <asp:Label ID="lblDetail" runat="server" CssClass="lblStyle"></asp:Label>
        </strong>
        <table name="tableDetail" id="tblDetails" visible="false" runat="server">
            <tr>
                <td>Service Name</td>
                <td>:</td>
                <td runat="server" id="cellName"></td>
            </tr>
            <tr>
                <td>Image</td>
                <td>:</td>
                <td runat="server" id="cellImg">
                    <asp:Image ID="imgService" runat="server" Height="169px" ImageAlign="Middle" Width="300px" />
                </td>
            </tr>
            <tr>
                <td>Description</td>
                <td>:</td>
                <td runat="server" id="cellDesc"></td>
            </tr>
            <tr>
                <td>Duration</td>
                <td>:</td>
                <td runat="server" id="cellDuration"></td>
            </tr>
            <tr>
                <td>Price</td>
                <td>:</td>
                <td runat="server" id="cellPrice"></td>
            </tr>
        </table>
    </div>
    <script>
        function confirmMsg(button) {
            var row = button.parentNode.parentNode;
            var serviceName = row.cells[1].innerHTML;
            var status = row.cells[2].innerHTML;

            var confirmationMessage;

            switch (status) {
                case "Available":
                    confirmationMessage = "Do you sure to close the " + serviceName + " service?\n" +
                        "You can always open it back.";
                    break;
                case "Closed":
                    confirmationMessage = "Do you sure to open the " + serviceName + " service?\n" +
                        "You can always close it back.";
                    break;
            }

            return confirm(confirmationMessage);
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
