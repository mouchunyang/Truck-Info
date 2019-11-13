<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>More Info</title>
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
        margin: 0;
        background-color: black;
        color: white;
        font-family: 'Roboto Condensed', sans-serif;
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
  .topnav-centered a {
    position: relative;
    top: 0;
    left: 0;
    transform: none;
  }
  #everything{
    width: 70%;
    position: absolute;
    left: 10%;
    font-size: 20px;
  }
  #error{
    background-image: 
    position: absolute;
    width: auto;
    bottom: 5%;
    left: 10%;
  }
  .textbox{
    line-height: 20px;
    color : white;
    width: 200px;
    margin-bottom: 20px;
    margin-right: 20px;
  }
  .text{
    display: inline-block;
    width: 200px;
    padding-bottom: 20px; 
  }
  .table{
    line-height: 20px;
    color : white;
    width: 200px;
    margin-bottom: 20px;
    margin-right: 20px;  
  }
  .title{
    font-size: 25px;
    color: yellow;
    padding-bottom: 20px;
  }
  .menu{
   padding-bottom: 5px;
  }
  #registersubmission{
      background-color: pink;
      width:150px;
      height: 50px;
      font-size: 25px;
      margin-top: 20px;
      margin-bottom: 100px;
      border: 1px solid white;
      border-radius: 10px;
  }
  #imgbox1{
      width: 500px;
      position: absolute;
      top: 10%;
      right: 10%;
  }
  #imgbox2{
      width: 500px;
      position: absolute;
      top: 70%;
      right: 10%;
  }
  #imgbox1 img{
      width: 100%;
  }
  #imgbox2 img{
      width: 100%;
  }
}
 
</style>
<script>
    function sendMsg(){
    	var xhttp = new XMLHttpRequest();
    	xhttp.open("GET", "sendMsg?", false);
    	xhttp.send();
    }
</script>
</head>
	<body>
	    <div id = "imgbox1">
	        <img src = "form.jpg">
	    </div>
	    <div id = "imgbox2">
	        <img src = "submitform.jpg">
	    </div>
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
	
		<div id = "moreinfo div">
  		
  		<div id= "everything">
  		  <p>All fields required*</p>
  		  <div class = "title">Basic Info:</div>
	  	  <div class = "text"> Username:</div>
	  	  <input class = "textbox" type="text" name="username" style= "background-color: RGB(255,255,255,0.1)"><br>
          <div class = "text">Food Truck Name:</div>
          <input class = "textbox" type="text" id = "foodtruckname" name="foodtruckname" style= "background-color: RGB(255,255,255,0.1); color: white" /><br>
          <div class = "text">Address:</div>
          <input class = "textbox" type="text" name="food truck address" style= "background-color: RGB(255,255,255,0.1)"/><br>
      	  <div class = "title">Hours: </div>
    	  
          Sun.   <input class = "textbox" type = "text" id = "Sunday" name = "Sunday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)">
          Mon.    <input class = "textbox" type = "text" id = "Monday" name = "Monday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)"><br>
          Tue.   <input class = "textbox" type = "text" id = "Tuesday" name = "Tuesday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)">
          Wed.   <input class = "textbox" type = "text" id = "Wednesday" name = "Wednesday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)"><br>
          Thu.    <input class = "textbox" type = "text" id = "Thursday" name = "Thursday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)">
          Fri.   <input class = "textbox" type = "text" id = "Friday" name = "Friday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)"><br>
          Sat.    <input class = "textbox" type = "text" id = "Saturday" name = "Saturday" placeholder = "9:00am-5:00pm" style= "background-color: RGB(255,255,255,0.1)"></p> 
          
        
		  	<form id = "bigform" action = "getInfo" method = "GET" name = "myform">
		  	    <div class = "title" style = "display: inline-block">Click the blue + to add a food menu item.</div>
		  	    <button id = "plus button" onClick = "return addMenuItem();" style="color:blue;font-size:36px;background-color:black;border:none"> + </button>
		  	    <div class = "menu">Food Menu</div>
	            <table class = "table" style="width: 22%" id = "moreinfotable">	             
	            	<tr>
	            		<td></td>
	            	</tr>
	                <tr>
	                	
	                	 
	                	 
	                </tr>
    
	                <tr>
	                	<td>Name:<input class = "textbox" type = "text" id="fooditem" name = "fooditem" placeholder = "Fish Tacos" style= "background-color: RGB(255,255,255,0.1)"></td>
	                	<td>Price: $<input  class = "textbox" type = "number" id = "price" name = "foodprice" placeholder = "6.99" style= "background-color: RGB(255,255,255,0.1)"></td> 	
	                </tr>
				</table>
				<div class = "title" style = "display: inline-block">Click the red + to add a beverage menu item</div>
				 <button id = "bplus button" onClick = "return addBMenuItem();" style="color:red;font-size:36px;background-color:black;border:none"> + </button>
				 <div class = "menu">Drink Menu</div>
				<table  style="width: 22%" id = "bevtable">
					
	                <tr>
	                	<td>Name:<input class = "textbox" type = "text" id="bevitem" name = "bevitem"  placeholder = "Water" style= "background-color: RGB(255,255,255,0.1)"></td>
	                	<td>Price: $<input class = "textbox" type = "number" id = "bprice" name = "bevprice" placeholder = "1.99" style= "background-color: RGB(255,255,255,0.1)"></td> 
	                </tr>
					
				
				
				
				</table>
	             <button type="submit" id = "registersubmission" name = "registersubmission" onclick = "sendMsg()">Submit Info!</button> 
	          
        	</form>
        	</div>
	  	</div>
	  <%-- <div id = "error" style="text-align:center"><%=session.getAttribute("error")%></div> --%>
	<script>
		function addMenuItem()
		{
			console.log("made it here in addMenuItem");
			var table = document.getElementById("moreinfotable");
			// var table = document.getElementById("moreinfotable");
			
		
			var tablelength = document.getElementById("moreinfotable").rows.length;
			console.log("Status of table is " + tablelength);
			var lastRow = tablelength - 1;
		
	
			var row1 = document.getElementById("moreinfotable").insertRow(lastRow);
			
			row1.innerHTML = "Name:<input class = \"textbox\" type = \"text\" id = \"fooditem\" name = \"fooditem\" placeholder = \"Fish Tacos\" style= \"background-color: RGB(255,255,255,0.1)\">";
			var row2 = row1.insertCell(0);
			row2.innerHTML = "Price: $<input class = \"textbox\" type = \"number\" id = \"price\" name = \"foodprice\" placeholder = \"6.99\" style= \"background-color: RGB(255,255,255,0.1)\">";
			
	
				
			
			return false; 
			/* var table = document.getElementById("moreinfotable");
			var row = table.insertRow(8);
			var dataFI = row.insertCell(0);
			var dataPr = row.insertCell(1);
			dataFI.innerHTML = "Food Item Name:<input type = \"text\" id = \"fooditem\" placeholder = \"Fish Tacos\"><input>";
			dataPr.innerHTML = "Price: $<input type = \"number\" id = \"price\" placeholder = \"6.99\"><input>";
			console.log("hereaosrjoij");
			 */
			
			
			 /* document.getElementById("newrows").innerHTML += 
				"<td>Food Item Name:<input type = \"text\" id = \"fooditem\" placeholder = \"Fish Tacos\"><input></td>"
				+ "<td>Price: $<input type = \"number\" id = \"price\" placeholder = \"6.99\"><input></td>"
				; // + "</tr>";
			 */
			 
			 
		}
		function addBMenuItem()
		{
			var table = document.getElementById("bevtable");
			//ar x = document.getElementById("myTable").rows.length;
			var tablelength = document.getElementById("bevtable").rows.length;
			console.log("Status of bev table is " + tablelength);
			var lastRow = tablelength - 1;
			
			var row1 = document.getElementById("bevtable").insertRow(lastRow);
			row1.innerHTML = "Name:<input class = \"textbox\" type = \"text\" id = \"bevitem\" name = \"bevitem\" placeholder = \"Water\" style= \"background-color: RGB(255,255,255,0.1)\">";
		    row2 = row1.insertCell(0);
			row2.innerHTML = "Price: $<input class = \"textbox\" type = \"number\" id = \"bprice\" name = \"bevprice\" placeholder = \"1.99\" style= \"background-color: RGB(255,255,255,0.1)\">";
			


			return false;
		}
	
	
	</script>
	
	
	
	</body>
</html>