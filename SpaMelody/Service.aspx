<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Service.aspx.cs" Inherits="MelodySpa.Service" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        /* Your existing styles */
        .auto-style1 {
            text-align: right;
        }

        .auto-style2 {
            text-align: center;
        }

        .gridViewContainer {
            text-align: center;
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .gridViewHeader {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
            text-align: center;
            padding: 15px;
        }

        .gridViewRow {
            text-align: center;
            border-bottom: 1px solid #e6e6e6;
        }

            .gridViewRow:hover {
                background-color: #f9f9f9;
            }

        .img-thumbnail {
            max-width: 100px;
            max-height: 100px;
            border-radius: 50%;
            display: block;
            margin: 0 auto;
        }

        .btn-primary {
            background-color:darkgoldenrod;
            color: #fff;
            border: 1px solid darkgoldenrod;
            padding: 8px 15px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block;
            margin: 10px auto;
        }

            .btn-primary:hover {
                background-color: #218838;
                border: 1px solid #28a745;
                border: 1px solid #218838;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="auto-style2">SPA Melody Services</h1>
    <table style="width: 100%;">
        <tr>
            <td>&nbsp;</td>
            <td class="auto-style12">&nbsp;</td>
            <td class="auto-style1">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search with service name..." Width="218px" Height="22px"></asp:TextBox>
                <asp:Button ID="Search" runat="server" Text="Search" BackColor="#D4C19A" Height="27px" OnClick="Button1_Click" />
                <asp:Button ID="Clear" runat="server" Text="Refresh" BackColor="#D4C19A" Height="27px" OnClick="Clear_Click" />
            </td>
        </tr>
    </table>
    <hr />

    <table style="width: 100%;">
        <tr>
            <td>
                <div class="auto-style1">
                    <asp:GridView ID="GridView1" runat="server" EmptyDataText="No records found." CssClass="gridViewContainer" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" DataKeyNames="serviceID" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <Columns>
                            <asp:BoundField DataField="serviceName" HeaderText="Service Name" SortExpression="serviceName" />
                            <asp:TemplateField HeaderText="Service Image">
                                <ItemTemplate>
                                    <asp:Image ID="imgService" runat="server" ImageUrl='<%# Eval("serviceImage") %>' AlternateText='<%# Eval("serviceName") %>' CssClass="img-thumbnail" Style="max-width: 100px; max-height: 100px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="serviceDescription" HeaderText="Service Description" SortExpression="serviceDescription" />
                            <asp:BoundField DataField="duration" HeaderText="Duration" SortExpression="duration" />
                            <asp:BoundField DataField="servicePrice" HeaderText="Service Price" SortExpression="servicePrice" DataFormatString="{0:C}" />
                            <asp:TemplateField HeaderText="Booking Service">
                                <ItemTemplate>
                                    <asp:Button runat="server" Text="Book Now" CommandName="BookNow" CommandArgument='<%# Eval("serviceID") %>' CssClass="btn-primary" OnClick="BookNow_Click"/>
                                </ItemTemplate>
                            </asp:TemplateField>
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

                </div>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT serviceID, serviceName, serviceImage, serviceDescription, duration, servicePrice, status FROM [service] WHERE status = 'Available';"></asp:SqlDataSource>

            </td>
        </tr>
    </table>

    <p class="auto-style10">
        &nbsp;
    </p>
    <hr />
</asp:Content>
