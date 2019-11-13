<!DOCTYPE html>
<html>
  <head>
    <title>Geolocation</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
      position: absolute;
      top: 5%;
      height: 100%;
      width: 100%;
      z-index: -1;
      }
      #boxes {
      z-index: 10;
      }
      #testing {
      z-index: 10;
      }
       /* Optional: Makes the sample page fill the window. */
     /* html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      } */
    </style>
  </head>
  <body>
    <div id="map"></div>
    <div id="boxes">
    	<input id="address" type="text" value="Denver, CO">
    	<input type="button" value="Encode" onclick="codeAddress()">
    </div>
    <form name="redirectForm" action="DataServlet" method="GET">
    <input type="submit" id="testing" value="test">
     </form>
    <script>
	// Note: Geolocation requires that user consents to give location when prompted
    // by their browser. If you see the error "The Geolocation service
    // failed.", it means you probably did not give permission for the browser to
    // locate you.
      var map, infoWindow, marker, infowindow;
    
      /* below styles switch google maps to night mode and remove all preset points of interest */
       var myStyles =[
    	    {elementType: 'geometry', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
            {
              featureType: 'administrative.locality',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'geometry',
              stylers: [{color: '#263c3f'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'labels.text.fill',
              stylers: [{color: '#6b9a76'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry',
              stylers: [{color: '#38414e'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry.stroke',
              stylers: [{color: '#212a37'}]
            },
            {
              featureType: 'road',
              elementType: 'labels.text.fill',
              stylers: [{color: '#9ca5b3'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry',
              stylers: [{color: '#746855'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry.stroke',
              stylers: [{color: '#1f2835'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'labels.text.fill',
              stylers: [{color: '#f3d19c'}]
            },
            {
              featureType: 'transit',
              elementType: 'geometry',
              stylers: [{color: '#2f3948'}]
            },
            {
              featureType: 'transit.station',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'water',
              elementType: 'geometry',
              stylers: [{color: '#17263c'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.fill',
              stylers: [{color: '#515c6d'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.stroke',
              stylers: [{color: '#17263c'}]
            },
            {
    	        featureType: "poi",
    	        elementType: "labels",
    	        stylers: [
    	              { visibility: "off" }
    	        ]
            }
    	];
      function initMap() {
    	geocoder = new google.maps.Geocoder();
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 16, styles: myStyles
        });
         map.addListener('click', function(e) {
      	    placeMarker(e.latLng, map);
      	  }); 
        infoWindow = new google.maps.InfoWindow;

        // Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent('Your location');
            infoWindow.open(map);
            map.setCenter(pos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
      }

      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }
      function codeAddress() {
    	    var address = document.getElementById('address').value;
    	    geocoder.geocode( { 'address': address}, function(results, status) {
    	      if (status == 'OK') {
    	        map.setCenter(results[0].geometry.location);
    	        var marker = new google.maps.Marker({
    	            map: map,
    	            position: results[0].geometry.location
    	        });
    	      } else {
    	    	 alert('Address not found');
  
    	      }
    	    });
    	  }
	// place marker where user clicks, only 1 marker can be active at a time
      function placeMarker(location) {
    	  if (!marker || !marker.setPosition) {
    	    marker = new google.maps.Marker({
    	      position: location,
    	      map: map,
    	    });
    	  } else {
    	    marker.setPosition(location);
    	  }
    	  if (!!infowindow && !!infowindow.close) {
    	    infowindow.close();
    	  }
    	  infowindow = new google.maps.InfoWindow({
    	    content: 'Latitude: ' + location.lat() + '<br>Longitude: ' + location.lng()
    	  });
    	  infowindow.open(map, marker);
    	}
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBw0apUKpSBvMd85fMmxvJ2l4IeglNy5g&callback=initMap">
    </script>
  </body>
</html>