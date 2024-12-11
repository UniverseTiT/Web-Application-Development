<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddService.aspx.cs" Inherits="MelodySpa.AddService" %>
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
        .auto-style14 {
            height: 80px;
        }
        .auto-style15 {
            width: 66px;
        }
    .auto-style16 {
        width: 346px;
    }
    .auto-style17 {
        height: 100px;
        width: 346px;
    }
    .auto-style18 {
        height: 39px;
        width: 346px;
    }
        .auto-style19 {
            font-size: xx-large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        <asp:Label ID="lblAddTitle" runat="server" Text="Add Service" ForeColor="White" CssClass="auto-style19" Font-Size="26px"></asp:Label>
    </h3>
    <p style="color:white; font-size:16px;">Please fill in all the mandatory fields.</p>
        <table id="AddForm" style="width:100%;">
            <tr>
                <td class="auto-style6">Service Name</td>
                <td class="auto-style7">:</td>
                <td class="auto-style16">
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
                <td class="auto-style17">
                    <textarea id="txtDesc" runat="server" cols="20" name="S1" class="auto-style14"></textarea></td>
                <td class="auto-style10">
                    <strong>
                    <asp:Label ID="lblErrorDesc" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Duration</td>
                <td class="auto-style7">:</td>
                <td class="auto-style16">
                    <input type="number" runat="server" class="auto-style15" max="6" min="0" id="inputHours" value="0"/>
                    hours
                    <input type="number" runat="server" class="auto-style15" max="59" min="00" id="inputMin" value="0"/>
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
                <td class="auto-style18">RM<asp:TextBox ID="txtPrice" runat="server" Height="30px" OnTextChanged="txtPrice_TextChanged" value="0.00" AutoPostBack="True" pattern="^\d+(?:\.\d{1,2})?$"></asp:TextBox>
                </td>
                <td class="auto-style13">
                    <strong>
                    <asp:Label ID="lblErrorPrice" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Service Image</td>
                <td class="auto-style7">:</td>
                <td class="auto-style16">
                    <asp:FileUpload ID="fupImg" runat="server" />
                </td>
                <td>
                    <strong>
                    <asp:Label ID="lblErrorImg" runat="server" ForeColor="Red"></asp:Label>
                    </strong>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Button ID="btnAddSubmit" runat="server" Text="Submit" Height="40px" Width="100%" BackColor="#CC9900" ForeColor="Maroon" OnClientClick="confirm(&quot;Do you want add this service?&quot;)" OnClick="btnAddSubmit_Click" />
                </td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style16">
                    <asp:Button ID="btnReset" runat="server" Text="Reset" Height="40px" Width="8em" BackColor="#CC9900" ForeColor="Maroon" OnClientClick="return confirm(&quot;Do you want to clear the form?&quot;)" OnClick="btnReset_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
</asp:Content>
