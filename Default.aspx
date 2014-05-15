<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="home" class="section">
        <div class="container">
            <div class="row">
                <div id="box-find-ride" class="col-xs-6 col-md-6">
                    <div class="jumbotron front">
                        <h1>Find a Ride</h1>
                        <p class="lead">Need to go somewhere? Find a ride fast! View available rides near you at your convenience.</p>
                        <p><a href="/rides/lookup" class="btn btn-success btn-large">Learn more &raquo;</a></p>
                    </div>
                </div>
                <div id="box-offer-ride" class="col-xs-6 col-md-6">
                    <div class="jumbotron front">
                        <h1>Offer a Ride</h1>
                        <p class="lead">Have a car? Then why not give a ride! Offer a ride to our users and make a profit!</p>
                        <p><a href="/rides/Offer" class="btn btn-success btn-large">Learn more &raquo;</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="about" class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h2>Getting started</h2>
                    <p>
                        ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
            A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
                    </p>
                    <p>
                        <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>
                    </p>
                </div>
                <div class="col-md-4">
                    <h2>Get more libraries</h2>
                    <p>
                        NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
                    </p>
                    <p>
                        <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
                    </p>
                </div>
                <div class="col-md-4">
                    <h2>Web Hosting</h2>
                    <p>
                        You can easily find a web hosting company that offers the right mix of features and price for your applications.
                    </p>
                    <p>
                        <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
