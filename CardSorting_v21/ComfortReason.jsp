<%@ page import = "java.io.*,java.util.*" %>
<%	
    response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("max-age", 0);
    response.setDateHeader("Expires", 0);
	
    if(session.getAttribute("CardSortingStatus") == null){
        response.sendRedirect("index.html");
    }else{
        String ComfortSorting = (String) String.valueOf((int)session.getAttribute("CardSortingStatus"));
        String CardSortingReason = (String) String.valueOf((int)session.getAttribute("CardSortingReason"));
    }
    int i;
    String[] variableList = new String[] {"profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"};
    
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
	
	<style type="text/css">
        .tg  {border-collapse:collapse;border-color:#ccc;border-spacing:0;margin-left:auto;margin-right:auto; }
        .tg td{background-color:#fff;border-color:#ccc;border-style:solid;border-width:1px;color:#333;
            font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg th{background-color:#B2E3FE;border-color:#ccc;border-style:solid;border-width:1px;color:#333;
            font-family:Arial, sans-serif;font-size:14px;font-weight:bold;overflow:hidden;padding:10px 5px;word-break:normal;}
        .tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
        .tg .tg-0lax{text-align:left;vertical-align:top}
    </style>
</head>

<body onload="getCardList();">
    <div class="container" style="margin: auto;">	
        <div class="row mt-5">
            <div class="col-3 small list-group">
                <div id="NotSensitive" class="d-flex w-100 justify-content-between row">
                    
                </div>
            </div>
            <div class="col-3 small list-group">
                <div id="LessSensitive" class="d-flex w-100 justify-content-between row">
                    
                </div>
            </div>
            <div class="col-3 small list-group">
                <div id="Sensitive" class="d-flex w-100 justify-content-between row">
                    
                </div>
            </div>
            <div class="col-3 small list-group">
                <div id="HighlySensitive" class="d-flex w-100 justify-content-between row">
                    
                </div>
            </div>
        </div>
        <div class="mt-5 mb-3">
	        <div class="text-right">
	            <a class="btn btn-primary" href="ComfortReason2.jsp" role="button">Next</a>
	        </div>
        </div>
    </div>
 	
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<script src="js/comfort_reason.js"></script>
</body>

</html>
