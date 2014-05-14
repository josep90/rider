<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Offer.aspx.cs" Inherits="rides_Offer" MasterPageFile="~/Site.master" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
    <script type="text/javascript">
        (function ($) {
            var autocomplete;
            function _submitRequest() {
                var extra = [];
                extra.push("rate="+$('#rate').val());
                extra.push("passengers=" + $('#passengers').val());
                extra.push("distance=" + $('#distance').val());
                $.ajax({
                    url: '/Api/rides?offer=true&location='+autocomplete.geometry.location.k+","+autocomplete.geometry.A+"&"+extra.join('&'),
                    success: function (response) {
                        alert("You are now offering a ride.");
                        window.location.href = "/";
                    },
                    error: function (err) {
                        alert('oops we have an error.');
                        console.log(err);
                    }
                })
            }
            $(function () {
                autocomplete = new google.maps.places.Autocomplete(
                    (document.getElementById('location')),
                    { types: ['geocode'] });
                $('#get-a-ride').on('click', function () {
                    _submitRequest();
                });
            });
        }(jQuery));
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h1>Offer a ride now</h1>
        <div class="form-group">
            <label for="location">Your Location:</label>
            <input class="form-control" type="text" id="location" placeholder="your location" />
        </div>
        <div class="form-group">
            <label for="rate">Rate</label>
            <input class="form-control" type="text" id="rate" placeholder="How much per mile" />
        </div>
        <div class="form-group">
            <label for="passengers">Passengers:</label>
            <input class="form-control" id="passengers" type="text" placeholder="Max number of passengers" />
        </div>
        <div class="form-group">
            <label for="distance">Max Distance</label>
            <input class="form-control" id="distance" type="text" placeholder="Max distance willing to travel." />
        </div>
        <br />
        <button type="button" id="offer-ride" class="btn btn-success">Offer ride</button>
        <div id="search-results"></div>
    </div>
</asp:Content>