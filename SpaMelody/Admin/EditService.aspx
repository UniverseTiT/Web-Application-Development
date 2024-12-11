<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EditService.aspx.cs" Inherits="MelodySpa.EditService" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style6 {
            width: 156px;
        }
        .auto-style7 {
            width: 15px;
        }
        .auto-style8 {
            width: 156px;
            height: 100px;
        }
        .auto-style9 {
            width: 15px;
            height: 100px;
        }
        .auto-style10 {
            height: 100px;
        }
        .auto-style11 {
            width: 156px;
            height: 39px;
        }
        .auto-style12 {
            width: 15px;
            height: 39px;
        }
        .auto-style13 {
            height: 39px;
        }
        #AddForm tr {
            height: 50px;
            max-height: 100px;
        }
        #AddForm td {
            color: white;
            padding: 0;
        }
        .auto-style16 {
            width: 233px;
        }
        .auto-style19 {
            font-size: xx-large;
        }
        .auto-style20 {
            width: 222px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />

    <h3>
        <asp:Label ID="lblAddTitle" runat="server" Text="Edit Service" ForeColor="White" CssClass="auto-style19" Font-Size="26px"></asp:Label>
    </h3>
    <p style="font-size:20px;">Change the data in the following fields.</p>
        <table id="AddForm" style="width:100%;">
            <tr>
                <td class="auto-style6">Service Name</td>
                <td class="auto-style7">:</td>
                <td>
                    <asp:TextBox ID="txtSName" runat="server" Height="30px"></asp:TextBox>
                </td>
                <td>
                    <strong>
                    <asp:Label ID="lblErrorName" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style8">Description</td>
                <td class="auto-style9">:</td>
                <td class="auto-style10">
                    <asp:TextBox ID="txtDesc" runat="server" Height="100%" TextMode="MultiLine" Width="100%"></asp:TextBox>
                </td>
                <td class="auto-style10">
                    <strong>
                    <asp:Label ID="lblErrorDesc" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Duration</td>
                <td class="auto-style7">:</td>
                <td>
                    <asp:TextBox ID="txtHours" runat="server" TextMode="Number" Width="79px" min="0" max="6"></asp:TextBox>
                    hours&nbsp;
                    <asp:TextBox ID="txtMin" runat="server" TextMode="Number" Width="79px" min="00" max="59"></asp:TextBox>
                    minutes
                </td>
                <td>
                    <strong>
                    <asp:Label ID="lblErrorDuration" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">Service Price</td>
                <td class="auto-style12">:</td>
                <td class="auto-style13">RM<asp:TextBox ID="txtPrice" runat="server" Height="30px" OnTextChanged="txtPrice_TextChanged" value="0.00" AutoPostBack="True" pattern="^\d+(?:\.\d{1,2})?$"></asp:TextBox>
                </td>
                <td class="auto-style13">
                    <strong>
                    <asp:Label ID="lblErrorPrice" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" rowspan="2">Service Image</td>
                <td class="auto-style7" rowspan="2">:</td>
                <td class="auto-style16">
                    <asp:FileUpload ID="fupImg" runat="server" />
                </td>
                <td class="auto-style20" rowspan="2">
                    <asp:Label ID="lblImg" runat="server"></asp:Label>
                    <br />
                    <asp:Image ID="serviceImage" runat="server" Height="169px" ImageAlign="Middle" Width="300px" />
                </td>
            </tr>
            <tr>
                <td class="auto-style16">
                    <strong>
                    <asp:Label ID="lblErrorImg" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Button ID="btnEditSubmit" runat="server" Text="Submit" Height="40px" Width="100%" BackColor="#CC9900" ForeColor="Maroon" OnClick="btnEditSubmit_Click" />
                </td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style16">
                    <asp:Button ID="btnReset" runat="server" Text="Clear All" Height="40px" Width="8em" BackColor="#CC9900" ForeColor="Maroon" OnClientClick=" return confirm('Do you want to clear the form?')" OnClick="btnReset_Click" />
                </td>
                <td class="auto-style20">
                    &nbsp;</td>
            </tr>
        </table>
</asp:Content>
