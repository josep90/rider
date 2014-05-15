<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="home" class="section">
        <div class="container" style="height: 100%; position: relative;">
            <div class="row" style="height: 100%;">
                <div id="box-find-ride" class="col-xs-6 col-md-6">
                    <div class="jumbotron front">
                        <h1>Find a Ride</h1>
                        <p class="lead">Need to go somewhere? Find a ride fast! View available rides near you at your convenience.</p>
                        <p><a href="/rides/lookup" class="btn btn-success btn-large">Learn more &raquo;</a></p>
                    </div>
                </div>
                <div id="box-offer-ride" class="col-xs-6 col-md-6" style="right: 0;">
                    <div class="jumbotron front">
                        <h1>Be the Ride</h1>
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
                <div class="col-md-12">
                    <h2>About Rider</h2>
                    <p>Various offerers can offer a ride. You can be a taxi driver, an office commuter or a person who is just free to offer a ride !</p> 
                    <p> As a passenger you can search for the offers and accept an offer</p><br/><br/><br/>
                    <h3>Pay using Paypal</h3>
                    <p>Pay using paypal the estimated ride price ! Then enjoy your ride </p><br/><br/><br/>
                </div>
            </div>
        </div>
    </div>
    <div id="contact" class="section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>Contact</h2>
                    <p> This site is designed by Fairfield University Students of Asp.Net Online Group Students of Spring 2014.
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
