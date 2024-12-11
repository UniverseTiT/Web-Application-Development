<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="MelodySpa.Error_page._404" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Error%20page/styles.css">
    <title>Error Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background-color: #403630;
            color: #D4C19A;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            height: 100vh;
        }

        .error-container {
            display: flex;
            align-items: center;
            position: relative;
        }

        .sphere {
            width: 200px;
            height: 200px;
            background-color: #D4C19A;
            border-radius: 50%;
            position: relative;
            overflow: hidden;
            animation: rotate 5s infinite linear;
        }

        .error-message {
            margin-top: 20px;
            max-width: 400px;
        }

        .rounded-button {
            width: 100px;
            height: 50px;
            background-color: #D4C19A;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            cursor: pointer;
            color: white;
            transition: transform 0.3s;
        }

            .rounded-button:hover {
                color: black;
                transform: scale(1.05);
            }

        .auto-style1 {
            text-align: left;
        }

        .auto-style2 {
            text-align: center;
        }

        .gif-container {
            position: relative;
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }

        .background-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(212, 193, 154, 0.5);
            border-radius: 50%;
        }

        .gif {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        @keyframes rotate {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <form runat="server">
        <div class="auto-style1">
            <div class="error-container">
                <div class="sphere" id="sphere">
                    <div class="gif-container">
                        <div class="background-overlay"></div>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/404.gif" AlternateText="Your GIF" CssClass="gif" />
                    </div>
                </div>
                <div class="error-message">
                    <h1>404 Not Found</h1>
                    <p>Sorry, the page you are looking for might be in another dimension.</p>
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style2">
                                <asp:Button ID="Button1" runat="server" CssClass="rounded-button" Text="Back" BorderColor="Black" OnClick="Button1_Click"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
