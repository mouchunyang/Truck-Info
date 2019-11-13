<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet,java.sql.SQLException,java.sql.Statement, 
java.util.List, java.util.ArrayList, java.util.StringTokenizer"%>
<!DOCTYPE html>
<%

/* request.getSession().setAttribute("sunday", sunday);
request.getSession().setAttribute("monday", monday);
request.getSession().setAttribute("tuesday", tuesday);
request.getSession().setAttribute("wednesday", wednesday);
request.getSession().setAttribute("thursday", thursday);
request.getSession().setAttribute("friday", friday);
request.getSession().setAttribute("saturday", saturday);
request.getSession().setAttribute("truckname", truckname);
request.getSession().setAttribute("address", address);
request.getSession().setAttribute("lat", latitude);
request.getSession().setAttribute("lon", longitude);
request.getSession().setAttribute("rating", rating);
request.getSession().setAttribute("foodItemArr", foodItems);
request.getSession().setAttribute("bevItemArr", bevItems);
request.getSession().setAttribute("foodPriceArr", foodPrices);
request.getSession().setAttribute("bevPriceArr", bevPrices); */
String truckname = (String)session.getAttribute("truckname");
String address = (String)session.getAttribute("address");
Float latitude = (Float)session.getAttribute("lat");
Float longitude = (Float)session.getAttribute("lon");
Float rating = (Float)session.getAttribute("rating");
String monday = (String)session.getAttribute("monday");
String tuesday = (String)session.getAttribute("tuesday");
String wednesday = (String)session.getAttribute("wednesday");
String thursday = (String)session.getAttribute("thursday");
String friday = (String)session.getAttribute("friday");
String sunday = (String)session.getAttribute("sunday");
String saturday = (String)session.getAttribute("saturday");
/* @SuppressWarnings("unchecked")
List<String> foodItems = (ArrayList<String>)session.getAttribute("foodItemArr"); */
@SuppressWarnings("unchecked")
List<String> foodPrices = (ArrayList<String>)session.getAttribute("foodPriceArr");
@SuppressWarnings("unchecked")

List<String> bevItems = (ArrayList<String>)session.getAttribute("bevItemArr");
@SuppressWarnings("unchecked")
List<String> bevPrices = (ArrayList<String>)session.getAttribute("bevPriceArr");

//List<String> bevItems = new ArrayList<>();
//List<String> hrs = new ArrayList<>();

%>
<html>
<head>
<meta charset="UTF-8">
<title>Edit My Truck Information</title>
<link href="https://fonts.googleapis.com/css?family=Hind|Roboto|Roboto+Condensed&display=swap" rel="stylesheet">
<script>
function logOut(){
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "logOut", false);
	xhttp.send();
	location.href = "homepage.jsp";
}
</script>
<style>
     body{
         background-color: black;
         color: white;
         font-family: 'Roboto Condensed', sans-serif;
         font-size: 20px;
     }
     #title{
         position: relative;
         top: 50px;
         padding: 10px;	
         right: 50px;
         font-size: 50px; 
    
     }
     #info{
         position: relative;
         left: 15%;
         width: 85%;
         top: 50px;
     }
     .text{
         display: inline-block;
         color: yellow;
         padding-right: 10px;
     }
     #hours{
         position: relative;
         left: 30px;
     }
     #hours > .text{
         color: #A1C332;
     }
     #imgbox{
         
         width: 30%;
         position: absolute;
         right: 400px;
         top: 150px;
     }
     topnav {
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
     
</style>
</head>
	<body>	
	    <div class="topnav">
		  <!-- Left-aligned links (default) -->
		  <a href="homepage.jsp">truck<span style="color: red">Findr </span></a>
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
	    <div id = "imgbox">
	        <img src = "truck1.jpg">
	    </div>
		<div id = "title">Truck info is: </div>
	    <div id = "info">
			<p><div class = "text">Name:</div><%=truckname %></p>
			<p><div class = "text">Address: </div><%=address%></p>
			<p><div class = "text">Hours:</div></p>
			<div id = "hours">
				<p><div class = "text">Sunday:</div> <%=sunday%></p>
				<p><div class = "text">Monday:</div><%=monday%></p>
				<p><div class = "text">Tuesday:</div><%=tuesday%></p>
				<p><div class = "text">Wednesday:</div><%=wednesday%> </p>
				<p><div class = "text">Thursday:</div><%=thursday%> </p>
				<p><div class = "text">Friday:</div><%=friday%> </p>
				<p><div class = "text">Saturday:</div><%=saturday%></p>
			</div>
			<%
			@SuppressWarnings("unchecked")
			List<String> foodItems = (ArrayList<String>)session.getAttribute("foodItemArr");
			if(foodItems==null){
			System.out.println("LIST IS NULL");
				
			}
			else
			{
				System.out.println("food items " + foodItems.size());
			}
				for (int i = 0; i < foodItems.size(); i++)
				{
					 if (i%2==0){
			%>
				<p><div class = "text">Food Item: </div><%=foodItems.get(i)%> Price: <%=foodPrices.get(i/2)%></p>
			<%
					 }
				}
				
				for (int i = 0; i < bevItems.size(); i++)
				{
					if (i%2 == 0)
					{
			
			%>
				<p><div class = "text">Beverage Item: </div><%=bevItems.get(i)%> Price: <%=bevPrices.get(i/2)%></p>
				
			<% 
			
					}
				} 
			%>

		</div>	
	
	
	</body>
</html>