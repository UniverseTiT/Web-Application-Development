<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="MelodySpa.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style4 {
            height: 217px;
        }

        .auto-style5 {
            height: 29px;
        }

        .info, .info table, .info th, .info td {
    border-bottom: 1px solid white;
    border-collapse: collapse;
} 

        .auto-style6 {
            height: 28px;
        }
         td {
     padding: 1%;
 }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div style="background-color: #403630; width: 98%; padding: 1%;">

    <table style="width: 100%; background-color: #403630;" class="info">
         <tr>
     <td colspan="2">
         <div style="border-bottom: 1px solid white; width: fit-content;">


             <asp:Label ID="Label21" runat="server" Text="Booking" Font-Size="26px"></asp:Label>

         </div>
     </td>
 </tr>
        <tr>
            <td style="border-right:1px solid white">
                <asp:Label ID="Label2" runat="server" Text="Service:" Font-Size="20px"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT [serviceName], [serviceID] FROM [service]" ></asp:SqlDataSource>



            </td>
            <td>
                <asp:CheckBoxList Font-Size="20px" ID="cblService" runat="server" DataSourceID="SqlDataSource1" DataTextField="serviceName" DataValueField="serviceID" OnSelectedIndexChanged="cblService_SelectedIndexChanged">
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
                        <td style="border-right:1px solid white">

                <asp:Label ID="Label3" runat="server" Text="Date:" Font-Size="20px"></asp:Label>
            </td>

            <td class="auto-style4">
                <asp:Calendar ID="CalendarService" runat="server" OnSelectionChanged="CalendarService_SelectionChanged1" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                    <TodayDayStyle BackColor="#CCCCCC" />
                </asp:Calendar>

                <asp:TextBox ID="txtServiceDate" Font-Size="20px" runat="server" ReadOnly="True" OnTextChanged="txtServiceDate_TextChanged" Height="29px"></asp:TextBox>
            </td>
           
      
            
 
            
        </tr>
        <tr>
                     <td style="border-right:1px solid white">

                <asp:Label ID="Label4" runat="server" Text="Time:" Font-Size="20px"></asp:Label>
            </td>
            <td class="auto-style6">



                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MelodySpa %>" SelectCommand="SELECT SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 9 THEN 1 ELSE 0 END) AS count_9, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 10 THEN 1 ELSE 0 END) AS count_10, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 11 THEN 1 ELSE 0 END) AS count_11, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 12 THEN 1 ELSE 0 END) AS count_12, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 13 THEN 1 ELSE 0 END) AS count_13, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 14 THEN 1 ELSE 0 END) AS count_14, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 15 THEN 1 ELSE 0 END) AS count_15, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 16 THEN 1 ELSE 0 END) AS count_16, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 17 THEN 1 ELSE 0 END) AS count_17, SUM(CASE WHEN DATEPART(HOUR, bookingTime) = 18 THEN 1 ELSE 0 END) AS count_18 FROM booking;"></asp:SqlDataSource>
                <asp:Repeater  ID="Repeater1" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater1_ItemDataBound">
                    <ItemTemplate>

                        <asp:DropDownList Font-Size="20px" ID="ddlServiceTime" runat="server" BackColor="#FFFF66" required>
                         
                        </asp:DropDownList>


                    </ItemTemplate>

                </asp:Repeater>




            </td>
        </tr>
        <tr>
            <td class="auto-style5">
                                            <asp:Button ID="Button1" runat="server"    Text="Book Now" BackColor="#D4C19A" ForeColor="#403630" Font-Size="18px" Font-Names="'Times New Roman', Times, serif" CssClass="button-hover"  OnClick="Button1_Click"  />

            </td>
            <td class="auto-style5"></td>
        </tr>
    </table>
            </div>
    <br />
    <br />

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Find the input with value "s001"
            var inputElement = document.querySelector('input[value="<%= getService() %>"]');
            console.log(inputElement);
            console.log("<%= getService() %>");
            inputElement.checked = true;
        });
    </script>
</asp:Content>
