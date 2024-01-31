<%@ page import = "java.io.*,java.util.*" %>
<%	
    response.setHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("max-age", 0);
    response.setDateHeader("Expires", 0);

    String disabled = "";
    String post = "block";
    String link = "none";
    if(session.getAttribute("CardSortingStatus") == null){
        response.sendRedirect("index.html");
    }else{
        String ComfortSorting = (String) String.valueOf((int)session.getAttribute("CardSortingStatus"));
        String CardSortingReason = (String) String.valueOf((int)session.getAttribute("CardSortingReason"));
		if( !ComfortSorting.equals("2") ){
			response.sendRedirect("index.html");
        }
        if(CardSortingReason.equals("1")){
            disabled = "disabled";
            post = "none";
            link = "block";
        }
    }
    int i;
    String[] variableList = new String[] {"profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"};
    session.setAttribute("radioBtnPage",1);
    int radioBtnPage = 1;
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

<body onload="enableNextButton()">
    <div class="container" style="margin: auto;">
        <form name="Reason" method="post" action="Reason">
        	
        	<!-- Hidden field to store page number -->
        	<input type="hidden" id="radioBtnPage" name="radioBtnPage" value="<%out.print(radioBtnPage);%>">
        	
        
        	<div class="mt-5">
		         <ol style="font-weight: bold; padding: 0px;">
		         	<p>Please select the <span class="text-primary">category</span> for each variable. (1/4)</p>
		         </ol>
		    </div>
	    	<div class="row mt-1">
		    	<table class='tg'>
				    <thead>
					    <tr>
					        <th class="mt-5">Variable/Category</th>
					        <th class="tg-01ax">Unique Device ID</th>
					        <th class="tg-01ax">Account/Individual Identifier</th>
					        <th class="tg-0lax">Demographics</th>
					        <th class="tg-0lax">Internet Traffic</th>
					        <th class="tg-0lax">Financial Information</th>
					        <th class="tg-0lax">Biometrics</th>
					        <th class="tg-0lax">Multimedia Data</th>
					        <th class="tg-0lax">Employment</th>
					        <th class="tg-0lax">Location</th>
					    </tr>
				    </thead>
				    <tbody>
					    <%for ( i = 0; i < 10; i++){ %>
				         	<tr>
							     <td class="tg-0lax"><%= variableList[i] %></td>
							     <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Unique Device ID" id="q1" 
							                 title="Unique Device ID" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Account/Individual Identifier" id="q2" 
							                 title="Account/Individual Identifier" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Demographics" id="q3" 
							                 title="Demographics" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Internet Traffic" id="q4"
							                 title="Internet Traffic" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Commercial/Financial Information" id="q5"
							                 title="Commercial/Financial Information" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Biometrics" id="q6"
							                 title="Biometrics" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Multimedia Data" id="q7"
							                 title="Multimedia Data" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Employment" id="q8"
							                 title="Employment" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Location" id="q9"
							                 title="Location" /></td>
						    </tr>
					      <%}%>    
				    </tbody>
			 	</table>
		 	</div>
	    	
	    	<div class="mt-5">
			   <ol style="font-weight: bold; padding: 0px;">
			   <p> Please select the <span class="text-primary">category</span> for each variable. (2/4)</p>
			   </ol>
			</div>
	    	<div class="row mt-1">
		    	<table class='tg'>
				    <thead>
					    <tr>
					        <th class="mt-5">Variable/Category</th>
					        <th class="tg-01ax">Unique Device ID</th>
					        <th class="tg-01ax">Account/Individual Identifier</th>
					        <th class="tg-0lax">Demographics</th>
					        <th class="tg-0lax">Internet Traffic</th>
					        <th class="tg-0lax">Financial Information</th>
					        <th class="tg-0lax">Biometrics</th>
					        <th class="tg-0lax">Multimedia Data</th>
					        <th class="tg-0lax">Employment</th>
					        <th class="tg-0lax">Location</th>
					    </tr>
				    </thead>
				    <tbody>
					    <%for ( i = 10; i < 20; i++){ %>
				         	<tr>
							     <td class="tg-0lax"><%= variableList[i] %></td>
							     <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Unique Device ID" id="q1" 
							                 title="Unique Device ID" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Account/Individual Identifier" id="q2" 
							                 title="Account/Individual Identifier" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Demographics" id="q3" 
							                 title="Demographics" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Internet Traffic" id="q4"
							                 title="Internet Traffic" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Commercial/Financial Information" id="q5"
							                 title="Commercial/Financial Information" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Biometrics" id="q6"
							                 title="Biometrics" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Multimedia Data" id="q7"
							                 title="Multimedia Data" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Employment" id="q8"
							                 title="Employment" /></td>
							      <td><input type="radio" onclick="enableNextButton()" name="<%= variableList[i] %>" value="Location" id="q9"
							                 title="Location" /></td>
						    </tr>
					      <%}%>    
				    </tbody>
			 	</table>
		 	</div>        
        
            <div class="mt-5">
                <div class="text-right" style="display:<%out.print(post);%>">
                    <input id="NextButton" type="submit" class="btn btn-primary" value="Next">
                    <input  type="text" name="SortingType" value="Comfort" style="display: none;">
                </div>
                <div class="text-right" style="display:<%out.print(link);%>">
                    <a class="btn btn-primary" href="ComfortReason3.jsp" role="button">Next</a>
                </div>
            </div>
        </form>

    </div>
 	
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<script src="js/comfort_reason.js"></script>
</body>

</html>
