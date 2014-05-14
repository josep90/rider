(function ($) {
    var autocomplete, autocomplete_end, start_obj, end_obj, distanceService;
    function initialize() {
        distanceService = new google.maps.DistanceMatrixService();
        // Create the autocomplete object, restricting the search
        // to geographical location types.
        autocomplete = new google.maps.places.Autocomplete(
            (document.getElementById('location-start')),
            { types: ['geocode'] });
        autocomplete_end = new google.maps.places.Autocomplete(
            (document.getElementById('location-end')),
            {types: ['geocode']});
        google.maps.event.addListener(autocomplete, 'place_changed', function () {
            start_obj = autocomplete.getPlace();
        });
        google.maps.event.addListener(autocomplete_end, 'place_changed', function () {
            end_obj = autocomplete_end.getPlace();
        });
    }
    function findRidesNearBy(start, end, callback) {
        distanceService.getDistanceMatrix({
            origins: [start],
            destinations: [end],
            travelMode: google.maps.TravelMode.DRIVING,
            avoidHighways: false,
            avoidTolls: false,
            unitSystem: google.maps.UnitSystem.IMPERIAL
        }, callback);
    }
    function _submitRequest(distanceResponse, status) {
        console.log(start_obj);
        console.log("from: " + start_obj.formatted_address + " long " + start_obj.geometry.location.A + " lat "+ start_obj.geometry.location.k);
        //longitude
        console.log("to: " + end_obj.formatted_address + " long " + end_obj.geometry.location.A + " lat " + end_obj.geometry.location.k);
        console.log("distance in KM: ");
        console.log(distanceResponse.rows[0].elements[0].distance.value);
        console.log("distance in miles: " + distanceResponse.rows[0].elements[0].distance.value / 1609.34);
        $.ajax({
            url: '/Api/rides?get=locations&start_location=-41.3712283,73.41396209999999&radius=10',
            success: function (response) {
                var obj =response;
                var items = obj.Items;
                var html = "<table class='table'><thead><tr>" +
                    "<th>#</th>" +
                    "<th>User</th>" +
                    "<th>Max</th>" +
                    "<th>Rate</th>" +
                    "<th>Distance</th>" +
                    "<th>Action</th>" +
                    "</tr></thead><tbody>";
                for (var k = 0; k < items.length; k++) {
                    html += "<tr>" +
                         "<td class='request-id'>"+items[k].id+"</td>" +
                         "<td>" + items[k].user + "</td>" +
                         "<td>" + items[k].max + "</td>" +
                         "<td>" + items[k].rate + "</td>" +
                         "<td>" + items[k].distance + "</td>" +
                         "<td><button type='button' class='btn btn-mini btn-success request'>Request</button></td>" +
                        "</tr>";
                }
                html += "</tbody></table>";
                $('#search-results').html(html);
            },
            error: function (err) {
                alert('oops we have an error.');
                console.log(err);
            }
        })
    }
    function requestRideOffer(parentEle, offerId) {
        $.ajax({
            url: '/Api/rides?request=' + offerId,
            success: function (response) {
                alert("Offer was requested.");
                $(parentEle).remove();
            },
            error: function (err) {
                alert("Could not request offer.");
            }
        });
    }
    //dom starts
    $(function () {
        initialize();
        $('#get-a-ride').on('click', function () {
            findRidesNearBy(start_obj.formatted_address, end_obj.formatted_address, _submitRequest);

        });
        $('#search-results').on('click','.request', function () {
            var parent = $(this).closest('tr');
            var id = $(parent).find('.request-id').text();
            requestRideOffer(parent, id);
        })
    });
}(jQuery));