<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MelodySpa.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .auto-style12 {
            text-align: center;
        }

        .auto-style14 {
            background-color: #403630;
            width: 57%;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s, transform 0.3s;
        }

            .auto-style14:hover {
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.2);
                transform: scale(1.02);
            }

        .auto-style26,
        .auto-style15 {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

            .auto-style26 img,
            .auto-style15 img {
                margin-right: 10px;
                border-radius: 50%;
                transition: transform 0.3s;
            }

                .auto-style26 img:hover,
                .auto-style15 img:hover {
                    transform: scale(1.1);
                }

        .auto-style28,
        .auto-style24,
        .auto-style25 {
            margin-bottom: 20px;
            transition: transform 0.3s;
        }

            .auto-style28:hover,
            .auto-style24:hover,
            .auto-style25:hover {
                transform: scale(1.02);
            }

        .auto-style22,
        .auto-style13 {
            margin-right: 0;
            text-align: right;
        }

        .Button1 {
            background: #D4C19A;
            font-size: 18px;
            padding: 12px 24px;
            border: 1px solid #D4C19A;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            color: white;
            transition: background 0.3s, color 0.3s, box-shadow 0.3s;
        }

            .Button1:hover {
                background: #D4C19A;
                color: black;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

        .auto-style29 {
            margin-right: 0;
            text-align: right;
            transition: transform 0.3s;
        }

            .auto-style29:hover {
                transform: scale(1.05);
            }

        .auto-style30 {
            transition: transform 0.3s;
        }

            .auto-style30:hover {
                transform: scale(1.05);
            }
        .auto-style31 {
            color: #FFFFFF;
        }
        .auto-style32 {
            text-align: left;
            transition: transform 0.3s;
        }

        .auto-style32:hover {
            transform: scale(1.05);
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%;">
        <tr>
            <td class="auto-style12">
                <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="XX-Large" Font-Underline="True" ForeColor="White" Text="Login" CssClass="auto-style31"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <table align="center" class="auto-style14">
        <tr>
            <td class="auto-style26">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/mail.png" CssClass="auto-style23" Height="23px" Width="31px" />
                &nbsp;<asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="20px" ForeColor="White" Text="Email"></asp:Label>
            </td>
            <td class="auto-style27">
                <asp:Label ID="Label10" runat="server" Font-Bold="True" ForeColor="White" Text=":"></asp:Label>
            </td>
            <td class="auto-style28">
                <asp:TextBox ID="TextBox1" runat="server" Width="235px" placeholder="Please enter your email..."></asp:TextBox>
            </td>
            <td class="auto-style21">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">
                <asp:Image ID="Image3" runat="server" Height="36px" ImageUrl="~/Images/password.png" Width="27px" />
                &nbsp;<asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="20px" ForeColor="White" Text="Password"></asp:Label>
            </td>
            <td class="auto-style16">
                <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="White" Text=":"></asp:Label>
            </td>
            <td class="auto-style24">
                <asp:TextBox ID="TextBox2" runat="server" Width="235px" TextMode="Password" placeholder="Please enter your password..."></asp:TextBox>
            </td>
            <td class="auto-style25"></td>
        </tr>
        <tr>
            <td colspan="3" class="auto-style12">
                <asp:Label ID="lblErrorLogin" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </td>
            <td class="auto-style13">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style30">
                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Aqua" NavigateUrl="~/ForgetPassword.aspx" Font-Bold="True">ForgotPassword?</asp:HyperLink>
            </td>
            <td class="auto-style29">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Register.aspx" ForeColor="Aqua" Font-Bold="True">No account? Let&#39;s register</asp:HyperLink>
            </td>
            <td class="auto-style13">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
            <td class="auto-style17">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2" class="auto-style32">
                <asp:Button ID="Button2" runat="server" Font-Bold="True" Text="Back" CssClass="Button1" PostBackUrl="~/Home.aspx" />
            </td>
            <td class="auto-style29">
                <asp:Button ID="Button1" runat="server" Font-Bold="True" Text="Login" CssClass="Button1" OnClick="Button1_Click" />
            </td>
            <td class="auto-style13">
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <br />
</asp:Content>
