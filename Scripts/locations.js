(function ($) {
    var autocomplete, autocomplete_end, start_obj, end_obj, distanceService, tripDistance;
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
    function filterResults(ridesResponse) {
        var destinations = [];
        var avRides = ridesResponse.rides;
        var trueRides = [];
        
        destinations.push(end_obj.formatted_address);
        for (var k = 0; k < avRides.length; k++) {
            destinations.push(avRides[k].address);
        }
        distanceService.getDistanceMatrix({
            origins: [start_obj.formatted_address],
            destinations: destinations,
            travelMode: google.maps.TravelMode.DRIVING,
            avoidHighways: false,
            avoidTolls: false,
            unitSystem: google.maps.UnitSystem.IMPERIAL
        }, function (distanceResponse, status) {
            var distances = distanceResponse.rows[0].elements;
            tripDistance = parseFloat(distances[0].distance.value);
            //we'll remove from start to end by requester
            distances = copyArray(distances, 1);
            destinations = copyArray(destinations, 1);

            var maxCapacity = parseFloat($('#passengers').val());
            for (var i = 0; i < distances.length; i++) {
                if((parseFloat(avRides[i].max_capacity) >= maxCapacity) &&
                   (parseFloat(distances[i].distance.value) + tripDistance) <= parseFloat(avRides[i].max_distance) * 1609.34) {
                    avRides[i].distFromStart = distances[i].distance.text;
                    avRides[i].approxTime = distances[i].duration.text;
                    trueRides.push(avRides[i]);
                }
            }
            showAvRides(trueRides);
        });
    }
    function copyArray(arr, start) {
        var newArr = [];
        for (var k = start; k < arr.length; k++) {
            newArr.push(arr[k]);
        }
        return newArr;
    }
    function showAvRides(rides) {
        var html = "<table class='table'><thead><tr>" +
                    "<th>#</th>" +
                    "<th>User</th>" +
                    "<th>From</th>" +
                    "<th>Rate</th>" +
                    "<th>Away</th>" +
                    "<th>Away Time</th>" +
                    "<th>Willing to travel</th>" +
                    "<th>Action</th>" +
                    "</tr></thead><tbody>";
        for (var k = 0; k < rides.length; k++) {
            html += "<tr>" +
                 "<td class='request-id'>" + rides[k].Id + "</td>" +
                 "<td>" + rides[k].username + "</td>" +
                 "<td>" + rides[k].address + "</td>" +
                 "<td>" + rides[k].rate + "</td>" +
                 "<td>" + rides[k].distFromStart + "</td>" +
                 "<td>" + rides[k].approxTime + "</td>" +
                 "<td>" + rides[k].max_distance + "</td>" +
                 "<td><button type='button' class='btn btn-mini btn-success request'>Request</button></td>" +
                "</tr>";
        }
        if(rides.length < 1){
            html = "<h3>Out of luck! No rides match your criteria.</h3>"
        }
        html += "</tbody></table>";
        $('#search-results').html(html);
    }
    function getAvailableRides() {
        $('#search-results').html("Looking for rides...");
        $.ajax({
            url: '/Api/rides?find=rides',
            success: filterResults,
            error: function (error) {
                $('#search-results').html("Error. Check console.");
                alert('Error finding rides');
            }
        });
    }
    function requestRideOffer(parentEle, offerId) {
        var params = [];
        params.push("from=" + $('#location-start').val());
        params.push("to=" + $('#location-end').val());
        params.push("trip_distance="+tripDistance);
        params.push("offer_id=" + offerId);
        $.ajax({
            url: '/Api/rides?request=ride&' + params.join('&'),
            success: function (response) {
                $(parentEle).remove();
                alert(response.message);
            },
            error: function (err) {
                var obj = $.parseJSON(err.responseText);
                alert(obj.message);
            }
        });
    }
    //dom starts
    $(function () {
        initialize();
        $('#get-a-ride').on('click', function () {
            //findRidesNearBy(start_obj.formatted_address, end_obj.formatted_address, _submitRequest);
            getAvailableRides();

        });
        $('#search-results').on('click','.request', function () {
            var parent = $(this).closest('tr');
            var id = $(parent).find('.request-id').text();
            requestRideOffer(parent, id);
        })
    });
}(jQuery));