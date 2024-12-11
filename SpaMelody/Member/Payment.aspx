<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="MelodySpa.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .button-hover {
            padding: 0.5%;
            cursor: pointer;
        }

        .info, .info table, .info th, .info td {
            border-bottom: 1px solid white;
            border-collapse: collapse;
        }
        /* Set styles for even columns in tables with the "custom-table" class and "custom-row" class */
        .custom-table td:nth-child(odd) {
            width: 20%; /* Set the width for even columns in specific rows */
        }

        /* Set styles for odd columns in tables with the "custom-table" class and "custom-row" class */
        .custom-table td:nth-child(even) {
            width: 30%; /* Set the width for odd columns in specific rows */
        }

        td {
            padding: 1%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: #403630; width: 98%; padding: 1%;">

        <table style="width: 100%; background-color: #403630;" class="info" id="tableServiceSelected">
            <tr>
                <td colspan="2">
                    <div style="border-bottom: 1px solid white; width: fit-content;">


                        <asp:Label ID="Label21" runat="server" Text="Booking Detail" Font-Size="26px"></asp:Label>

                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 50%;">
                    <asp:Label ID="Label16" runat="server" Text="Service Date:" Font-Size="20px"></asp:Label>
                    <asp:Label ID="lblBookingDate" runat="server" Font-Size="20px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="Label15" runat="server" Text="Service Time:" Font-Size="20px"></asp:Label>
                    <asp:Label ID="lblBookingTime" runat="server" Font-Size="20px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="Label13" runat="server" Text="Service Booked:" Font-Size="20px"></asp:Label>

                    <br />
                    <div style="padding-left: 2%;">
                        <table style="width: 100%" id="detailTable">
                            <thead>
                                <tr>
                                    <td style="font-size: 20px">Service Name</td>
                                    <td style="text-align: end; font-size: 20px">Price</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%foreach (SERVICE service in serviceList)
                                    {  
                                       %>
                                <tr>
                                    <td style="font-size: 20px"><%= service.name %></td>
                                    <td style="font-size: 20px; text-align: end;"><%=service.price %></td>
                                </tr>
                                <%} %>
                            </tbody>
                        </table>

                    </div>
                </td>
            </tr>
            <tr>
                <td style="border-right: none;">
                    <asp:Label ID="Label17" runat="server" Text="Total Price:" Font-Size="20px"></asp:Label>
                </td>
                <td style="text-align: end; border-left: none;">
                    <asp:Label ID="lblTotalPrice" runat="server" Font-Size="20px"></asp:Label>
                    

                </td>
            </tr>
        </table>
    </div>
    <br />
    <div style="background-color: #403630; width: 98%; padding: 1%;">

        <asp:UpdatePanel ID="panel1" runat="server">
            <ContentTemplate>
                <table style="width: 100%; background-color: #403630;" class="info">
                    <tr>
                        <td colspan="2">
                            <div style="border-bottom: 1px solid white; width: fit-content;">


                                <asp:Label ID="Label22" runat="server" Text="Payment" Font-Size="26px"></asp:Label>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 20.7%;">
                            <asp:Label ID="Label8" runat="server" Text="Payment Method:" Font-Size="20px"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlPaymentMethod" runat="server" AutoPostBack="True" Font-Size="Large" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
                                <asp:ListItem>Online Banking</asp:ListItem>
                                <asp:ListItem>Credit Card</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trOnlineBanking" runat="server">
                        <td colspan="2">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList1" ErrorMessage="Please select an Online Banking Option" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" Width="100%" Font-Size="20px">
                                <asp:ListItem>MayBank</asp:ListItem>
                                <asp:ListItem>Public Bank</asp:ListItem>
                                <asp:ListItem>Hong Leong Bank</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="trCreditCard" runat="server">
                        <td colspan="2">
                            <table style="width: 100%" class="custom-table">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Card Number:" Font-Size="20px"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtCardNumber" runat="server" Width="99.5%" Font-Size="20px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFValidatorCardNumber" runat="server" ErrorMessage="* Card Number can't be empty" ForeColor="Red" ControlToValidate="txtCardNumber" Text="*"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="* Card Number only accept digits " ForeColor="Red" Type="Integer" ControlToValidate="txtCardNumber" Operator="DataTypeCheck">*</asp:CompareValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCardNumber" ErrorMessage="* Please enter 16 digits for Card Number" ForeColor="Red" ValidationExpression="\d{16}">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text="Expiry Date:" Font-Size="20px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtExpiryDate" runat="server" Width="98%" Font-Size="20px"></asp:TextBox>

                                        <asp:RequiredFieldValidator ID="RFValidatorExpiryDate" runat="server" ErrorMessage="* Expiry Date can't be empty" ForeColor="Red" ControlToValidate="txtExpiryDate">*</asp:RequiredFieldValidator>

                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtExpiryDate" ErrorMessage="* Expiry Date should be (month/year) format" ForeColor="Red" ValidationExpression="^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])$">*</asp:RegularExpressionValidator>

                                    </td>
                                    <td>
                                        <asp:Label ID="Label12" runat="server" Text="CCV:" Font-Size="20px"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCCV" runat="server" Width="98%" Font-Size="20px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFValidatorCCV" runat="server" ErrorMessage="* CCV can't be empty" ControlToValidate="txtCCV" ForeColor="Red">*</asp:RequiredFieldValidator>

                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="* CCV only accept digits" ForeColor="Red" Type="Integer" ControlToValidate="txtCCV" Operator="DataTypeCheck">*</asp:CompareValidator>

                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtCCV" ErrorMessage="* Please enter 3 digits for CCV" ForeColor="Red" ValidationExpression="\d{3}">*</asp:RegularExpressionValidator>

                                    </td>
                                </tr>


                                <tr>
                                    <td>
                                        <asp:Label ID="Label11" runat="server" Text="Name on Card:" Font-Size="20px"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtNameOnCard" runat="server" Width="99.5%" Font-Size="20px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFValidatorNasmeOnCard" runat="server" ErrorMessage="* Name on Card can't be empty" ControlToValidate="txtNameOnCard" ForeColor="Red">*</asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>



                    <tr>
                        <td>
                             
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Size="18px" ForeColor="#FF3300" DisplayMode="BulletList"/>
                        </td>
                        <td  style="text-align: end;">
                           

                            <asp:Button ID="btnPayment" runat="server" Text="Pay Now" BackColor="#D4C19A" ForeColor="#403630" Font-Size="18px" Font-Names="'Times New Roman', Times, serif" CssClass="button-hover" OnClick="btnPayment_Click"  />
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlPaymentMethod" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="btnPayment" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

</asp:Content>
