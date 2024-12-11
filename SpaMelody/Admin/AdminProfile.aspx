<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="MelodySpa.Admin.AdminProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">

        .big-div {
            overflow: hidden;
            opacity: 0;
            transform: translateY(-20px);
            animation: fadeInUp 0.5s ease-in-out forwards;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            
            
        }

        td {
           
            border-bottom: 1px solid #ddd;
            transition: background-color 0.3s ease;
        }

        .info {
            width: 100%;
            height: 100%;
        }

            .info tr {
                height: 20%;
            }

        .auto-style6,
        .auto-style7 {
            text-align: right;
        }

        .ddd {
            padding: 15px 30px;
            background: linear-gradient(to right, #4CAF50, #45a049);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .ddd:hover {
                background: linear-gradient(to right, #45a049, #4CAF50);
                transform: scale(1.05);
            }

        .fff {
            padding: 15px 30px;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .fff:hover {
                transform: scale(1.05);
            }

        .eee {
            padding: 15px 30px;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

            .eee:hover {
                transform: scale(1.05);
            }


        .profile {
            width: 150px;
            height: 150px;
            background-color: #3498db;
            border-radius: 15px;
            overflow: hidden;
            position: relative;
            transition: transform 0.5s ease, filter 0.5s ease, box-shadow 0.5s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

            .profile img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: filter 0.5s ease;
            }

            .profile:hover {
                transform: scale(1.2);
                filter: brightness(1.2) contrast(1.2);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
            }

                .profile:hover img {
                    filter: grayscale(50%) blur(2px);
                }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .auto-style8 {
            text-align: center;
            height: 315px;
        }

        .auto-style9 {
            text-align: left;
        }

        .auto-style10 {
            height: 20%;
        }

        .auto-style11 {
            text-align: center;
        }
        
        .auto-style12 {
            overflow: hidden;
            opacity: 0;
            transform: translateY(-20px);
            animation: fadeInUp 0.5s ease-in-out forwards;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 98%;
            height: 627px;
        }
        .auto-style13 {
            width: 100%;
            height: 672px;
        }
        
    </style>
    <script type="text/javascript">
        function showAlert() {
            alert('Your profile has been updated!');
            // Redirect to the same page to refresh after the alert is closed
            window.location.href = window.location.href;
        }
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div style="background-color: #403630; padding: 1%;" class="auto-style12">

    <table class="auto-style13">
        <tr>
            <td class="auto-style8" style="border-right:1px solid white;">
                <asp:Image ID="Image1" runat="server" CssClass="profile" Height="216px" Width="201px" />
                <br />
                <br />
                <asp:FileUpload ID="profileImage" runat="server" Visible="False" Font-Size="20px" />
                <br />
                                <asp:Label ID="ResetProfile" runat="server"  Font-Size="20px"></asp:Label>
            </td>
            <td rowspan="2" style="">
                <div style="width: 90%; height: 550px; margin: 5%;">
                    <table class="info">
                        <tr style="height: 20%;">
                            <td class="auto-style11" colspan="2">
                                <asp:Label ID="profileTittle" runat="server" Font-Bold="True" Font-Size="XX-Large"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height: 20%;">
                            <td>
                                <asp:Label ID="Label2" runat="server" Text="Name:" Font-Size="20px"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="lblUsername" runat="server" Enabled="False" Font-Size="20px" ReadOnly="True"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="editName" runat="server" Font-Size="20px" Visible="False"></asp:TextBox>
                            &nbsp;<asp:Label ID="ResetName" runat="server"  Font-Size="20px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style10">
                                <asp:Label ID="Label3" runat="server" Text="Email:" Font-Size="20px"></asp:Label>
                            </td>
                            <td class="auto-style10">
                                <asp:TextBox ID="txtEmail" runat="server" Enabled="False" AutoPostBack="True" Font-Size="20px" Width="306px" ReadOnly="True"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                        </tr>
                        <tr style="height: 20%;">
                            <td class="auto-style9">
                                <asp:Label ID="Label4" runat="server" Text="Phone Number:"  Font-Size="20px"></asp:Label>
                            </td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txtPhone" runat="server" Enabled="False" AutoPostBack="True" Font-Size="20px"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="editPhone" runat="server" Font-Size="20px" Visible="False"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="ResetPhoneNo" runat="server"  Font-Size="20px"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height: 20%;">
                            <td class="auto-style9">
                                <asp:Label ID="Label7" runat="server" Text="Date of birth:"  Font-Size="20px"></asp:Label>
                            </td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txtAge" runat="server" Enabled="False" Font-Size="20px"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Calendar ID="Calendar1" runat="server" Height="200px" Visible="False" Width="220px" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399">
                                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                    <OtherMonthDayStyle ForeColor="#999999" />
                                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                    <WeekendDayStyle BackColor="#CCCCFF" />
                                </asp:Calendar>
                                <asp:Label ID="ResetCalendar" runat="server"  Font-Size="20px"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height: 20%;">
                            <td class="auto-style9">
                                <asp:Label ID="Label5" runat="server" Text="Gender:"  Font-Size="20px"></asp:Label>
                            </td>
                            <td class="auto-style6" style="text-align:left;">
                                <asp:TextBox ID="rblGender" runat="server" Enabled="False"  Font-Size="20px"></asp:TextBox>
                                <br />
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" Font-Size="Large" RepeatDirection="Horizontal" Visible="False">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr style="height: 20%;">
                            <td class="auto-style9">
                                <asp:Label ID="Label6" runat="server" Text="Password:"  Font-Size="20px" Visible="False"></asp:Label>
                                <br />
                                <br />
                                <asp:Label ID="Label8" runat="server" Text="Confirm New Password:"  Font-Size="20px" Visible="False"></asp:Label>
                            </td>
                            <td class="auto-style9">
                                <asp:TextBox ID="TextBox5" runat="server"  Font-Size="20px" TextMode="Password" Visible="False"></asp:TextBox>
                            &nbsp;&nbsp;
                                <br />
                                <asp:TextBox ID="TextBox6" runat="server" Font-Size="20px" Visible="False" TextMode="Password"></asp:TextBox>
                            &nbsp;
                                <br />
                                <asp:Label ID="ResetPassword" runat="server"  Font-Size="20px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td class="auto-style11" style="border-right:1px solid white;">
                <asp:Button ID="Button1" runat="server" Text="Edit Profile" EnableTheming="True" OnClick="Button1_Click" CssClass="ddd"  Font-Size="18px" />
                <br />
                <asp:Button ID="Button3" runat="server" Text="Edit" EnableTheming="True" OnClick="Button3_Click" Visible="False" CssClass="fff" Font-Size="18px" BackColor="#00CCFF" />
                <asp:Button ID="Button4" runat="server" Text="Cancel" EnableTheming="True" OnClick="Button4_Click" Visible="False" CssClass="eee" Font-Size="18px" BackColor="Red" />
            </td>
        </tr>
    </table>
            </div>
</asp:Content>

