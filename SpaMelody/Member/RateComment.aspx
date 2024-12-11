
<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RateComment.aspx.cs" Inherits="MelodySpa.Member.RateComment" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <div>
            <h1>Comment Form</h1>
            <h2 >Please enter your comment to our website </h2>
            <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" Rows="4" Columns="50"></asp:TextBox>
            <br />
             
            <asp:Button ID="Button1" runat="server" Text="Submit Feedback" BackColor="#D4C19A" ForeColor="#403630" Font-Size="18px" Font-Names="'Times New Roman', Times, serif" CssClass="button-hover" OnClick="btnSubmit_Click"  />
        </div>
</asp:Content>
