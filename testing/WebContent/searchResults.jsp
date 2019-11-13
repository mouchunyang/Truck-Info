<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">

<style>
.table .thead-dark th {
  color: #fff;
  background-color: #620000;
  border-color: #FF8888;
}

.table{
  color: white;
}

body {
  margin: 0;
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
  top: 20%;
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
 border-radius: 10px;
 background: #2f3640;;
 display: flex;
 justify-content: center;
 align-items: center;
 transition: 0.4s;
}
.search-txt {
 border: none;
 background: none;
 outline:none;
 padding:0;
 color: white;
 font-size: 16px;
 transition: 0.4s;
 line-height: 40px;
 width: 0px;
}

#description{
    width: 40%; 
    font-size: 40px;
  color: white;
  position: absolute;
    left: 30%;
    top: 370px;
}
#title {
    width: 50%;
  color: white;
  position: absolute;
    left: 25%;
    text-align: center;
    top: 100px;
    font-size: 200px; 
    font-family: 'Hind', sans-serif;
}
.discover{
  position: absolute;
    left: 40%;
    top: 400px;
}

#discoverButton{
    transition: transform 0.5s;
    font-size: 25px;
    width: 52%;
    position: relative;
    left: 24%;
    padding-top: 5px;
    padding-bottom: 5px;
}
#discoverButton:hover{
    transform: scale(1.5);
}
#myform{
    position: absolute;
    width: 30%;
    top: 60%;
    left: 35%;
}
.container{
  padding-top: 50px;
  width: 50%;
}

.table table-hover{
  border-spacing: 10px;
}

</style>
<script>
function logOut(){
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "logOut", false);
	xhttp.send();
	location.href = "homepage.jsp";
}
</script>
</head>
<body style="background-color:black;  width: 100%;">

<div class="background-img"></div>

<!-- Top navigation -->
<div class="topnav">

  
  <!-- Left-aligned links (default) -->
  <a href="#home">truck<span style="color: red">Findr </span></a>
  <a href="#contact">Contact</a>
  
  <!-- Right-aligned links -->
  <div class="topnav-right">
    <a href="./ftologin.jsp">Login</a>
    <a href="./ftoregister.jsp">Register</a>
  </div>
  
</div>



<div class="container" align="center" >
  <h3 style="text-align: center; color: white;">Search Results</h2>
 
<table width = "70%" class="table table-hover" >
  <thead class="thead-dark">
    <tr>
      <th>#</th>
      <th>Food Truck Name</th>
      <th>Hours</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>
    <tr>
      <th scope="row">3</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>
    <tr>
      <th scope="row">4</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>
    <tr>
      <th scope="row">5</th>
      <td><a href="#" style="color: white">Name</a></td>
      <td>?</td>
    </tr>            
  </tbody>
</table>

</div>
</body>
</html>
    