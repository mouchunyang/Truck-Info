<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.util.Vector" %>
<%@ page import= "testing.TruckInfo" %>
<%
Vector<TruckInfo> trucks = (Vector<TruckInfo>)session.getAttribute("TruckInfo");
 String searchError = (String) session.getAttribute("errorSearch");
if (searchError == null || searchError.trim().length() == 0) {
	searchError = "";
} 
%>
<!DOCTYPE html>

<head>

<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css?family=Hind|Roboto|Roboto+Condensed&display=swap" rel="stylesheet">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script>
    function printNotes(){	
    	//console.log("printNotes function");
    	var xhttp = new XMLHttpRequest();
    	xhttp.open("GET", "printNotes", true);
    	//xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    	xhttp.onreadystatechange = function() {
    		console.log("receive sth");
    		if(xhttp.readyState === 4 && xhttp.status === 200) {	
    			console.log(this.responseText);
    			if (/* this.responseText.includes("burgerKing" */true){
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
	    		    	  case "leave" : location.href = "burgerKing.jsp"; break;
	    		    	  default: location.reload();
	    		    	}
	    		    });
    			}	
    	    }
    		
    	}
    	xhttp.send();
    }
</script>
</head>
<script src="https://kit.fontawesome.com/7177a06548.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="text/css">
body {
  margin: 0;
  font-family: 'Roboto Condensed', sans-serif;
}
::placeholder{
  vertical-align: center;
  font-size: 20px;
}
.topnav {
  position: relative;
  overflow: hidden;
  background-color: #333;
}
.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}
.topnav a:hover {
  background-color: #ddd;
  color: black;
}
.topnav a.active {
  background-color: none;
  color: white;
}
.topnav-centered a {
  float: none;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
.topnav-right {
  float: right;
}
/* Responsive navigation menu (for mobile devices) */
@media screen and (max-width: 600px) {
  .topnav a, .topnav-right {
    float: none;
    display: block;
  }
  
  .topnav-centered a {
    position: relative;
    top: 0;
    left: 0;
    transform: none;
  }
}
#searchType{
  position: absolute;
  float:none; 
  margin: 15px -50px;  
  left:50%;
}
hr {
height: 1px;
color: blue;
background-color: white;
border: none;
}
.search-box{
  position: absolute;
  top: 22%;
  left: 50%;
  transform: translate(-50%,-50%);
  background: #2f3640;
  height: 40px;
  border-radius: 40px;
  padding: 10px;
}
.search-box:hover > .search-txt {
  width: 240px;
  padding:0 6px;
}
.search-box:hover > .search-btn {
  background: white;
}
.search-btn {
 color: #e84118;
 float: right;
 width: 40px;
 height: 30px;
 border-radius: 50%;
 background: #2f3640;;
 display: flex;
 justify-content: center;
 align-items: center;
 transition: 0.4s;
}
.search-txt {
 vertical-align: middle;
 border: none;
 background: none;
 outline:none;
 padding:0;
 color: white;
 font-size: 20px;
 transition: 0.4s;
 line-height: 40px;
 width: 0px;
}

#map {
    position: absolute;
    top: 20%;
    left: 10%;
    height: 70%;
    width: 80%;
    z-index: -1;
	display: none;
}
#errorMsg {
	color: red;
	font-size: 25px;
	position: absolute;
	top: 43%;
	left: 44%;
}
</style>
</head>
<body style="background-color:black;" >
<script>printNotes();</script>
<div class="background-img"></div>


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
      function logOut(){
    		var xhttp = new XMLHttpRequest();
    		xhttp.open("GET", "logOut", false);
    		xhttp.send();
    		location.href = "homepage.jsp";
    	}
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
  		   /* testing for placing links inside infowindow uncomment later with appropriate links */
  		   contentString[j] = '<a href="burgerKing.jsp" style="text-decoration: none;">' + str + '</a>'; 
  		  // contentString[j] = '<h1> ' + str + '</h1>';
  			j++;
  		   <% } %>
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
	<script>
	function displayMap() {
		//	alert("clicked!");
			document.getElementById("map").style.display = "block";
			document.getElementById("searchDiv").style.display = "none";
		}
	function disappearMap() {
		//	alert("disappearing");
			document.getElementById("map").style.display = "none";
			document.getElementById("searchDiv").style.display = "block";
	}
	</script>

<div class="background-img"></div>
<div id="map"></div>
<!-- Top navigation -->
<div class="topnav">

  <!-- Centered link -->
  <div class="topnav-centered">
    <a href="#home" class="active"><h2>Discovery</h2></a>
  </div>
  
  <!-- Left-aligned links (default) -->
  <a href="./homepage.jsp">truck<span style="color: red">Findr </span></a>
  <a href="#contact">Contact</a>
  
  
  <!-- Right-aligned links -->
  <%if (session.getAttribute("currUser") == null){ %>
  <div class="topnav-right">
    <a href="./ftologin.jsp">Login</a>
    <a href="./ftoregister.jsp">Register</a>
  </div>
  <%} else{%>
   <div class="topnav-right">
    <a onclick = "logOut()" style = "color:white">Logout</a>
  </div> 
  <% }%>
  
</div>

<div id = "searchType">
  <button type="button" class="btn btn-danger" onclick="disappearMap()" data-toggle="button" aria-pressed="false" autocomplete="off">Grid</button>
  <button type="button" class="btn btn-light" onclick="displayMap()" data-toggle="button" aria-pressed="false" autocomplete="off">Map</button>
</button>
</div>


<form action="SearchServlet" method="GET">
	<div class="search-box" id="searchDiv"> 
      <input class="search-txt" type="text" name="SearchQuery" placeholder="Type to search...">
      <button class="search-btn" href="SearchServlet"> 
        <i class="fas fa-search"></i>
      </button>
    </div>
 </form>
    
<div id="errorMsg"><% out.println("<p>" + searchError + "</p>"); %></div>
</body>




</html>