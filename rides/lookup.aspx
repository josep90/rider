<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="lookup.aspx.cs" Inherits="rides_lookup" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
    <script src="/Scripts/locations.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
    <div class="search-wrapper">
        <div class="form-group">
            <label for="location-start">From:</label>
            <input class="form-control" type="text" id="location-start" placeholder="your location" />
        </div>
        <div class="form-group">
            <label for="location-end">To:</label>
            <input class="form-control" type="text" id="location-end" placeholder="destination" />
        </div>
        <div class="form-group">
            <label for="passengers">Passengers:</label>
            <input class="form-control" id="passengers" type="text" placeholder="how many people?" />
        </div>
        <br />
        <button type="button" id="get-a-ride" class="btn btn-success">Get a ride</button>
        <br />
        <div id="search-results"></div>
    </div>
</asp:Content>
