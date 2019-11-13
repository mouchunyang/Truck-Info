<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.util.Vector" %>
<%@ page import= "testing.TruckInfo" %>
<%
Vector<TruckInfo> trucks = (Vector<TruckInfo>)session.getAttribute("TruckInfo");
/* String searchError = (String) session.getAttribute("errorSearch");
if (searchError == null || searchError.trim().length() == 0) {
	out.print("alert('No results found')");
} */
%>
<!DOCTYPE html>
<html>
  <head>
    <script>
    function printNotes(){	
    	//console.log("printNotes function");
    	var xhttp = new XMLHttpRequest();
    	xhttp.open("GET", "printNotes", true);
    	xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    	xhttp.onreadystatechange = function() {
    		if(xhttp.readyState === 4 && xhttp.status === 200) {	
    			if (this.responseText == "burgerKing"){
	    			swal({
	    				title: "A new Food Truck called burgerKing is added nearby.",
	    				text: "Go to the detail page?",
	    				icon: "success",
	    				buttons: {
	    					leave: {text: "Aww yiss!", value : "leave",},
	    					stay: {text:"Nope I will stay.", value:"stay"},
	    				}
	    			})
	    		    .then ((value) => {
	    		    	switch (value){
	    		    	  case "leave" : location.href = "details.jsp"; break;
	    		    	  default: window.reload();
	    		    	}
	    		    });
    			}	
    	    }
    		
    	}
    	xhttp.send();
    }
    </script>
    <title>Discovery Map</title>
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
       /* Optional: Makes the sample page fill the window. */
     /* html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }*/
    </style>
  </head>
  <body>
    <script>printNotes();</script>
    <div id="map"></div>
  <!--   <div id="boxes">
    	<input id="address" type="text" value="Denver, CO">
    	<input type="button" value="Encode" onclick="codeAddress()">
    </div> -->
    <script type = "text/javascript">
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
          center: {lat: -34.397, lng: -180.644},
          zoom: 16, styles: myStyles
        });
     /*    map.addListener('click', function(e) {
      	    placeMarker(e.latLng, map);
      	  }); */
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
            placeMarker(pos, "pink", 'Your location');
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
     //   console.log("about to call function");
        populate();
      }

      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }

    	/* Function places a marker plus infowindow at each food truck location */
    	 function populate() {
    		var j = 0;
        	var location = [];
    		var contentString = [];
    		/* transfer the info from trucks into location and contentString arrays */
    		<%for (int i = 0; i < trucks.size(); i++) {%>
  		   var lat = <%=trucks.get(i).getLatitude()%>
  		   var lon = <%=trucks.get(i).getLongitude()%>
  		   var latLng = new google.maps.LatLng({lat: lat, lng: lon});
  		   location[j] = latLng;
  		   var str = "<%=trucks.get(i).getTruckName()%>";
  		   contentString[j] = '<h1> ' + str + '</h1>';
  		   /* testing for placing links inside infowindow uncomment later with appropriate links 
  		   contentString[j] = '<a href="geocache.jsp" style="text-decoration: none;">' + str + '</a>'; */
  			j++;
  		 <%} %>
    		 var infowindow = new google.maps.InfoWindow();
    		/* set the markers with their corresponding infowindows */
    		for (var i = 0; i < location.length; i++) {
     			 var marker = new google.maps.Marker({
    				position: location[i],
                    map: map
                }); 
                 google.maps.event.addListener(marker, 'click', (function (marker, i) {
                    return function () {
                        infowindow.setContent(contentString[i]);
                        infowindow.open(map, marker);
                    }
                })(marker, i));   
            }
    	}
    	
    	/* places marker with specified color and content inside infoWindow -- used for user's location only */
    	function placeMarker(latLng, color, contentString) {
    		 let url = "http://maps.google.com/mapfiles/ms/icons/";
    	      url += color + "-dot.png";
    	      
    	      let marker = new google.maps.Marker({
    	        map: map,
    	        position: latLng,
    	        icon: {
    	          url: url,
    	          //scaledSize: new google.maps.Size(38, 38)
    	        }
    	      });
    	   var infowindow = new google.maps.InfoWindow({
    	          content: contentString
    	        });
    	      marker.addListener('click', function() {
    	          infowindow.open(map, marker);
    	        }); 
    	}
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBBw0apUKpSBvMd85fMmxvJ2l4IeglNy5g&callback=initMap">
    </script> 
  </body>
</html>