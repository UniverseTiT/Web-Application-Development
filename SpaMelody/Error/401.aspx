<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="401.aspx.cs" Inherits="MelodySpa.Error_page._401" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../Error%20page/styles.css" />
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
            position: relative;
            width: 200px;
            height: 200px;
            background-color: white;
            border-radius: 50%;
            overflow: hidden;
            animation: rotate-planet 5s infinite linear;
        }

        .sphere-content {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .sphere-content img {
            object-fit: contain;
            width: 100%;
            height: 100%;
        }

        .error-message {
            max-width: 400px;
            text-align: center;
        }

        @keyframes rotate-planet {
            0% {
                transform: rotateY(0deg);
            }

            100% {
                transform: rotateY(360deg);
            }
        }

        .rounded-button {
            width: 100px;
            height: 50px;
            background-color: #D4C19A;
            border-radius: 20px;
            margin-top: 20px;
            cursor: pointer;
            color: white;
            border: none;
            outline: none;
            transition: transform 0.3s;
        }

        .rounded-button:hover {
            color: black;
            transform: scale(1.05);
        }
        .auto-style1 {
            text-align: center;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
        <div class="error-container">
            <div class="sphere" id="sphere">
                <div class="sphere-content">
                    <asp:Image ID="imgGif" runat="server" ImageUrl="~/Images/access.png" AlternateText="Your GIF" />
                </div>
            </div>
            <div class="error-message">
                <h1>401 Unauthorized</h1>
                <p>Sorry, you are not allowed to access this page!.</p>
            </div>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Back" CssClass="rounded-button" Font-Bold="True" OnClick="Button1_Click"/>
        </div>
    </form>
</body>
</html>
