<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MelodySpa.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        

        .auto-style6 {
            margin: 50px 104px 50px auto;
            border-collapse: collapse;
            width: 83%;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            height: 874px;
        }

        .auto-style4 {
            padding: 5px;
            text-align: center;
            transition: transform 0.3s;
        }

            .auto-style4:hover {
                transform: scale(1.05);
            }

        .auto-style42 {
            transition: transform 0.3s;
        }

            .auto-style42:hover {
                transform: scale(1.05);
            }

        .auto-style28,
        .auto-style18,
        .auto-style29,
        .auto-style15,
        .auto-style12,
        .auto-style30,
        .auto-style24,
        .auto-style25,
        .auto-style26,
        .auto-style24,
        .auto-style25,
        .auto-style26,
        .auto-style20,
        .auto-style2,
        .auto-style31,
        .auto-style21,
        .auto-style22,
        .auto-style33,
        .auto-style21,
        .auto-style22,
        .auto-style33,
        .auto-style21,
        .auto-style22,
        .auto-style33,
        .auto-style11,
        .auto-style13,
        .auto-style32,
        .auto-style11,
        .auto-style13,
        .auto-style32,
        .auto-style11,
        .auto-style13,
        .auto-style32,
        .auto-style20,
        .auto-style14,
        .auto-style31,
        .auto-style20,
        .auto-style14,
        .auto-style31,
        .auto-style36,
        .auto-style37,
        .auto-style38 {
            padding: 10px;
            text-align: left;
        }

            .auto-style15 label,
            .auto-style24 label,
            .auto-style20 label,
            .auto-style21 label,
            .auto-style21 label,
            .auto-style11 label,
            .auto-style11 label {
                font-weight: bold;
                color: #333;
                display: block;
                margin-bottom: 5px;
            }

            .auto-style12 input,
            .auto-style25 input,
            .auto-style22 input,
            .auto-style13 input,
            .auto-style13 input,
            .auto-style14 input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            .auto-style20 .auto-style2 input {
                width: 156px;
            }

            .auto-style2 input[type="radio"] {
                margin-right: 5px;
            }

            .auto-style22 input[type="number"] {
                width: 80px;
            }

            .auto-style22 input[type="file"] {
                width: 100%;
            }

            .auto-style18 input[type="button"],
            .auto-style37 input[type="button"] {
                background-color: #2ecc71;
                color: #fff;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .auto-style36 input[type="button"] {
                background-color: #e74c3c;
            }

            .auto-style14 input[disabled="disabled"] {
                background-color: #eee;
            }

            .auto-style6 .auto-style13 .error-message,
            .auto-style32 .auto-style13 .error-message,
            .auto-style32 .auto-style13 .error-message {
                color: #e74c3c;
                font-size: 14px;
            }

        .auto-style39 {
            padding: 10px;
            text-align: left;
            width: 448px;
        }

        .btn-back,
        .btn-register {
            background-color: #3498db;
            color: #fff;
            padding: 12px 24px;
            border: 2px solid #3498db;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            transition: background-color 0.3s, border-color 0.3s;
        }

            .btn-back:hover {
                background-color: #2980b9;
                border-color: #2980b9;
            }

            .btn-register:disabled {
                background-color: #bdc3c7;
                color: #ecf0f1;
                border-color: #bdc3c7;
                cursor: not-allowed;
            }
    .auto-style40 {
        text-align: left;
        height: 51px;
        padding: 10px;
    }
    .auto-style41 {
        padding: 10px;
        text-align: left;
        width: 448px;
        height: 51px;
    }
        .auto-style42 {
            padding: 10px;
            text-align: right;
            width: 448px;
        }
        .auto-style44 {
            text-align: center;
            height: 51px;
            padding: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table align="center" class="auto-style6">
        <tr>
            <td class="auto-style4" colspan="3">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="26px" Text="Welcome to register your new account to our system!" ForeColor="#D4C19A"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"></td>
            <td class="auto-style39"></td>
            <td class="auto-style29">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label3" runat="server" Font-Bold="True" ForeColor="White" Text="Username :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:TextBox ID="TextBox1" runat="server" BackColor="White" ForeColor="Black"  Width="428px" Font-Size="20px"></asp:TextBox>
            </td>
            <td class="auto-style30">
                <asp:Label ID="lblName" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style44">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="White" Text="Email Address :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style41">
                <asp:TextBox ID="TextBox2" runat="server" placeholder="Example:abc123@gmail.com" BackColor="White" ForeColor="Black" Font-Size="20px" Width="428px"></asp:TextBox>
            </td>
            <td class="auto-style40">
                <asp:Label ID="lblEmail" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="White" Text="Gender :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" Width="156px" ForeColor="White" Font-Size="20px">
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="auto-style31">
                <asp:Label ID="lblGender" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label6" runat="server" Font-Bold="True" ForeColor="White" Text="Phone Number :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:TextBox ID="TextBox3" runat="server" placeholder="Example:0123456789" BackColor="White" ForeColor="Black" Font-Size="20px" Width="428px"></asp:TextBox>
            </td>
            <td class="auto-style33">
                <asp:Label ID="lblPhoneNo" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label7" runat="server" Font-Bold="True" ForeColor="White" Text="Date of Birth :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#CCCCFF" />
                </asp:Calendar>
            </td>
            <td class="auto-style33">
                <asp:Label ID="lblCalender" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label11" runat="server" Font-Bold="True" ForeColor="White" Text="Profile Picture :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:FileUpload ID="FileUpload1" runat="server" BackColor="White" BorderColor="Black" />
            </td>
            <td class="auto-style33">
                <asp:Label ID="lblProfile" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label8" runat="server" Font-Bold="True" placeholder="Example valid password: P@55words" ForeColor="White" Text="Password :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:TextBox ID="TextBox5" runat="server" placeholder="Example valid password: P@55word" BackColor="White" ForeColor="Black" Font-Size="20px" Width="428px" TextMode="Password"></asp:TextBox>
            </td>
            <td class="auto-style32" rowspan="2">
                <asp:Label ID="lblPassword" runat="server" ForeColor="Red" Font-Size="20px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Label ID="Label9" runat="server" Font-Bold="True" ForeColor="White" Text="Confirm Password :" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style39">
                <asp:TextBox ID="TextBox6" runat="server" BackColor="White" ForeColor="Black" Font-Size="20px" Width="428px" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"></td>
            <td class="auto-style39">
                <asp:Label ID="lblMatchCode" runat="server" ForeColor="White" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style31"></td>
        </tr>
        <tr>
            <td class="auto-style4">
                <asp:Button ID="Button2" runat="server" CssClass="btn-back" Text="Back" PostBackUrl="~/Login.aspx" Font-Bold="True" Font-Size="18px" BackColor="#333333" BorderColor="#333333" ForeColor="#D4C19A"/>
            </td>
            <td class="auto-style42">
                <asp:Button ID="Button3" runat="server" CssClass="btn-register" Text="Register" BackColor="#D4C19A" Font-Bold="True" BorderColor="#D4C19A" Font-Size="18px" ForeColor="Black" OnClick="Button3_Click"/>
            </td>
            <td class="auto-style38"></td>
        </tr>
    </table>
</asp:Content>
