<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="MelodySpa.AboutUs" %>

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
    <div class="big-div" style="background-color: #403630; width: 98%; padding: 1%;">
        <div style="width: 100%; display: flex; justify-content: center; align-items: center;">
            <div style="text-align: center; border-bottom: 1px solid white; width: fit-content;">
                <asp:Label ID="Label21" runat="server" Text="About Us" Font-Size="26px"></asp:Label>
            </div>
        </div>


        <div style="width: 100%; text-align: center;">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Welcome to SPA Melody, where tranquility meets rejuvenation in a harmonious blend of soothing experiences. Our journey began with a vision — a vision to create a haven where individuals could escape the hustle and bustle of everyday life, finding solace and renewal in the art of massage and holistic wellness." Font-Size="18px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="At SPA Melody, we believe that true wellness encompasses the body, mind, and spirit. Our team of skilled and certified therapists is dedicated to providing personalized experiences that go beyond traditional spa services. We understand that each individual is unique, and so are their needs for relaxation and restoration. That&#39;s why we offer a diverse range of massages and spa treatments tailored to meet the specific preferences and requirements of our valued clients." Font-Size="18px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Our massage therapies are designed to transport you to a state of bliss, melting away stress and tension. From Swedish and deep tissue massages to aromatherapy and hot stone treatments, each session is crafted to enhance your well-being. The ambiance of SPA Melody is carefully curated to create a serene and calming environment, complementing the therapeutic benefits of our services." Font-Size="18px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Beyond the physical aspects of wellness, we also emphasize the importance of mental and emotional harmony. Our tranquil spaces provide a retreat for introspection and meditation, encouraging a holistic approach to self-care. We believe that the path to true well-being involves the integration of mind, body, and spirit." Font-Size="18px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="At SPA Melody, our commitment extends beyond the treatment room. We strive to cultivate a community that values self-care and embraces a lifestyle of balance. Through educational workshops, wellness events, and personalized consultations, we empower our clients to embark on a journey of sustainable health and tranquility." Font-Size="18px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Come join us at SPA Melody, where every treatment is a symphony of relaxation, and every visit is an opportunity to harmonize your senses. Experience the melody of well-being — your sanctuary for serenity and rejuvenation." Font-Size="18px"></asp:Label>
        </div>
    </div>
</asp:Content>
