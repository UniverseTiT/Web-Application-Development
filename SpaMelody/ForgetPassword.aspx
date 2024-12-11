<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="MelodySpa.ForgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        table {
            width: 100%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease-in-out;
        }

        tr:first-child {
            color: #fff;
        }

        h1.auto-style2 {
            margin: 20px 0;
            font-size: 24px;
            color: #333;
        }

        td.auto-style9,
        td.auto-style8 {
            padding: 10px;
            font-weight: bold;
        }

        .aaa {
            padding: 15px 30px;
            background: linear-gradient(to right, #4CAF50, #45a049);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .aaa:hover {
                background: linear-gradient(to right, #45a049, #4CAF50);
                transform: scale(1.05);
            }

        .bbb {
            padding: 15px 30px;
            background: linear-gradient(to right, #ff5733, #ff8c33);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position:center;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .bbb:hover {
                background: linear-gradient(to right, #ff8c33, #ff5733);
                transform: scale(1.05);
            }

        .ccc {
            padding: 15px 30px;
            background: linear-gradient(to right, #3498db, #2980b9);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .ccc:hover {
                background: linear-gradient(to right, #2980b9, #3498db);
                transform: scale(1.05);
            }


        tr:not(:first-child) {
            height: 20px;
        }

        .auto-style7 {
            color: red;
            font-style: italic;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @media (max-width: 600px) {
            table {
                width: 80%;
            }
        }
        .auto-style8 {
            text-align: right;
        }
        .auto-style9 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table >
        <tr>
            <td colspan="3">
                <h1 class="auto-style2" style="text-align: center; color: #FFFF00">Forgot Your Password?</h1>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">&nbsp;</td>
            <td class="auto-style6">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9" style="color: #FFFFFF; text-align: right;"><strong>Enter your email to&nbsp; reset the password:</strong></td>
            <td class="auto-style10">
                <asp:TextBox ID="txtEmail" runat="server" Width="303px"></asp:TextBox>
            </td>
            <td class="auto-style10">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="color: #FFFFFF; text-align: right;">&nbsp;</td>
            <td class="auto-style6">
                <asp:Button ID="Button1" runat="server" Height="28px" Text="Confirm Email" CssClass="bbb" OnClick="Button1_Click" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="color: #FFFFFF; text-align: right;">&nbsp;</td>
            <td class="auto-style6">
                <asp:Label ID="resetEmail" runat="server" CssClass="auto-style7" Font-Bold="True"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8" style="color: #FFFFFF; text-align: right;"><strong>Reset Password:</strong></td>
            <td class="auto-style6">
                <asp:TextBox ID="TextBox2" runat="server" Enabled="False" Width="303px" TextMode="Password"></asp:TextBox>
            </td>
            <td rowspan="2">
                <asp:Label ID="resetPassword" runat="server" CssClass="auto-style7" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style8" style="color: #FFFFFF; text-align: right;"><strong>Confirm Password:</strong></td>
            <td class="auto-style6">
                <asp:TextBox ID="TextBox3" runat="server" Enabled="False" Width="303px" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style9"></td>
            <td class="auto-style10"></td>
            <td class="auto-style10"></td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Button ID="Button2" runat="server" PostBackUrl="~/Login.aspx" Text="Back" CssClass="aaa" OnClick="Button2_Click" />
            </td>
            <td class="auto-style9">
                <asp:Button ID="Reset" runat="server" Text="Reset Passwords" CssClass="ccc" Enabled="False" OnClick="Reset_Click" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
