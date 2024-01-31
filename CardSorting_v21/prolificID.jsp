<%@ page import = "java.io.*,java.util.*" %>
<%	
    if(session.getAttribute("SIS") == null){
        response.sendRedirect("index.html");
    }else{
        //check for consent
        String sisStatus = (String) String.valueOf((int)session.getAttribute("SIS"));
		if( sisStatus.equals("0") ){
            response.sendRedirect("index.html");
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
</head>

<body onload="enableNextButton()">
    <div class="container">
        <div class="container row align-items-center justify-content-md-center" style="width:100%; height:100%">

            <div class="col col-md-auto justify-content-center">

                <h4 class="text-center">Please enter your <b>IU email address</b>.</h4>
                
                <h6 class="text-center">We will only use this to confirm that you participated.</h6>

                <form name="ProlificID" method="post" action="PostID">
                    <!--Button is enabled when the input length reaches 24-->
                    <input type="text" onkeyup="enableNextButton()" id="prolificID" name="prolificID" class="form-control text-uppercase text-center" placeholder="Email" maxlength="24">

                    <div class="mt-3" style="display: flex; justify-content: center;">
                        <input id="NextButton" class="btn btn-primary" type="submit" value="Continue">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<script src="js/prolificID.js"></script>
</body>

</html>
