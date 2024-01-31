<%@ page import = "java.io.*,java.util.*" %>
<%	
	response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("max-age", 0);
	response.setDateHeader("Expires", 0);

	String displayUndo = "block";
    if(session.getAttribute("Instructions1") == null){
        response.sendRedirect("index.html");
	}else{
		String Instructions1 = (String) String.valueOf((int)session.getAttribute("Instructions1"));
		String CardSortingStatus = (String) String.valueOf((int)session.getAttribute("CardSortingStatus"));
		displayUndo = "block";
		if(Instructions1.equals("0")){
			response.sendRedirect("index.html");
		}else if( Instructions1.equals("1") && CardSortingStatus.equals("2") ){
			displayUndo = "none";
		}
	}
%>

<html lang="en">

<head>
	<title> Security Label Preferences </title>
    <link rel="icon" href="https://assets.iu.edu/favicon.ico">

	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	
	<style>
	mark { 
	  background-color: #d9de2266;
	  color: black;
	}
	</style>
	<meta http-equiv="Expires" content="-1">
</head>

<body onload="onPageLoad()">
	<!-- body code goes here -->
	<div class="container">
		<div class="alert alert-primary mt-1 text-sm text-left" role="alert">
			<p class="col-12">
				<p>
					<!--<span><b>Device Manufacturer</b>: Here the device manufacturer is defined as the company that manufacturers the device and provides services.</span><br>-->
					<span>
						<b>Please sort the card into one of the four boxes according to how sensitive is it to include this factor as a component of any software or IoT device label.</b>
					</span>
					<div style="display:<%out.print(displayUndo);%>" class="">
						<span id="Dashboard">Please start sorting the cards into one of the 4 boxes!</span>
						<button onclick="undoSort()" id="undo" class="btn btn-secondary btn-sm ml-3" style="visibility: hidden;">Undo</button>
					</div>
				</p>
			</p>
			<div class="progress mt-1 mr-1" style="height: 20px">
				<div id="ProgressBar" class="progress-bar bg-success" role="progressbar" style="width: 0%;"
					aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
			</div>

		</div>
		<div class='row' style="height:900px; width: 1650px;">
			<div class="col-8" id="BoundingBox" style="height:900px; width: 1650px; position: relative;">
				<div id="NotSensitive" class="card border-info small mt-1" style="position: absolute; width: 15rem; height:13rem; left:4%">
					<div class="card-body">
						<h5 class="card-title">Not Sensitive</h5>
					</div>
				</div>
				<div id="LessSensitive" class="card border-info small" style="position: absolute; width: 15rem; height:13rem; top:30%; left:4%">
					<div class="card-body">
						<h5 class="card-title">Less Sensitive</h5>
					</div>
				</div>
				<div id="Sensitive" class="card border-info small mt-1" style="position: absolute; width: 15rem; height:13rem; right:0.1%">
					<div class="card-body">
						<h5 class="card-title">Sensitive</h5>
					</div>
				</div>
				<div id="HighlySensitive" class="card border-info small" style="position: absolute; width: 15rem; height:13rem; top:30%; right:0.1%">
					<div class="card-body">
						<h5 class="card-title">Highly Sensitive</h5>
					</div>
				</div>
				<div id="draggable" class="shadow card border-info small" style="position:absolute; width: 25.5rem; top:10%; left:33%; cursor: move;">
					<div id="CardName" class="card-header" style="font-size: 20px;">
						Data type
					</div>
					<div class="card-body">
						<pre>
  							<code>
								<p id="cardDescription" class="card-text"> Here we will present the participants with the description of the card.</p>
							</code>
						</pre>
					</div>
				</div>
				<div id="doneCard" class="shadow card text-white bg-success small" style="position:absolute; width: 13.5rem; top:15%; left:37%; visibility: hidden;">
					<div class="card-header">You are Done!</div>
					<div class="card-body">
						<p class="card-text">Please move onto the survey.</p>
						<form name="SortingStatus" method="post" action="SortingStatus">
							<input type="submit" class="btn btn-primary btn-sm" value="Continue">
							<input  type="text" name="SortingStatus" value="Done" style="display: none;">
							<input  type="text" name="SortingType" value="Comfort" style="display: none;">
						</form>
					</div>
				</div>
			</div>
			<div class="ml-5 col-sm-3 small list-group">
				<div id="featureDescriptions" class="d-flex w-100 justify-content-between row">
					
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<script src="js/draggable_features.js"></script>
</body>

</html>
