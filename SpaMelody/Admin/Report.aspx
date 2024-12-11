<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="MelodySpa.Admin.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .btnPrint {
            background-color: #CC9900;
            color: maroon;
        }
    </style>
    <div runat="server" id="divReport" class="report style">
        <asp:Label ID="lblReport" runat="server" Font-Size="26px"></asp:Label>
        <asp:GridView ID="gridReport" runat="server" AutoGenerateColumns="false" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" CssClass="gridView">
            <Columns>
                <asp:TemplateField HeaderText="Bil.No">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Service ID" DataField="serviceID" SortExpression="serviceID" />
                <asp:BoundField HeaderText="Service Name" DataField="serviceName" SortExpression="serviceName" />
                <asp:BoundField HeaderText="Price(RM)" DataField="servicePrice" SortExpression="servicePrice" />
                <asp:BoundField HeaderText="Booking Times" DataField="bookingTimes" SortExpression="bookingTimes" />
                <asp:BoundField HeaderText="Total Sales(RM)" DataField="total" SortExpression="total" />
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
    <div style="width: 100%; text-align: right;">
        <asp:Button ID="btnPrint" runat="server" Text="Print" OnClick="btnPrint_Click" Height="2em" CssClass="btnPrint" OnClientClick="confirm('Do you want print this report?')" />
    </div>
</asp:Content>
