<%@ page import = "java.io.*,java.util.*" %>
<%	
    if(session.getAttribute("ReceivedID") == null){
        response.sendRedirect("index.html");
    }else{
        //Check if the prolific ID has been set
        String ReceivedID = (String) String.valueOf((int)session.getAttribute("ReceivedID"));
		if( ReceivedID.equals("0") ){
			response.sendRedirect("index.html");
		}
    }
%>

<html lang="en">

<head>
    <title> Data Risk in Code </title>
    <link rel="icon" href="https://assets.iu.edu/favicon.ico">
    
	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body onload="checkAnswers()">
    <div class="container">
        <div class="row col-12 mb-5">
        <h4 class="mt-3 col-12">Activity Instructions</h4>
        <p class="col-12 mt-2">
        In the following activity you will assign sensitivity labels to pieces of source code. 
        The sensitivity label that you assign should be determined by how you regard the sensitivity of data processed by the source code in the activity. 
		<br><br>

            <b>What is Sensitive Data?</b>
        Sensitive data is any data that if released to the public would result in an adverse effect on the individual(s) or entities involved.
        <br>
        You will also assign the source code presented to categories, based on what types of data the code handles. Categories established under the California Consumer Privacy Act (CCPA), and the General Data Protection Regulation (GDPR) include identifiers, biometric information, legally protected characteristics (race, ethnicity, age, gender...), geolocation, internet or network activity, and education information. 
        </p>
        </div>
        <hr>
        <div class="row col-12 mt-5 mb-5">
            <div class="col-8"></div>
            <h6 class="col-4 mb-3"><strong>Card Sorting Interface</strong></h6>
            <img src="Images/sensitive_sample.png" class="img-fluid col-7 border-right" alt="Card Sorting Interface">
            <div class="col-5">
                <img src="Images/1.png" style="max-width: 7%; height: auto;" alt="bullet 1"> Variable Name<br>
                <img src="Images/2.png" style="max-width: 7%; height: auto;" alt="bullet 2"> Code Context<br>
                <img src="Images/3.png" style="max-width: 7%; height: auto;" alt="bullet 3"> Progress Bar<br>
                <img src="Images/4.png" style="max-width: 7%; height: auto;" alt="bullet 4"> Undo button to undo the previous sort<br>
                <img src="Images/5.png" style="max-width: 7%; height: auto;" alt="bullet 5"> Four stacks ranging from "Not Sensitive" to "Highly Sensitive".
                Drag and drop the card in one of the four stacks to indicate how sensitive if the variable name and context suggest that it will be used for sensitive data.
            </div>
        </div>
        <hr>
        <div class="row col-12 mt-5 mb-5">
            <h6 class="col-12 mb-3"><strong>Attention Checks</strong></h6>
            <div class="col-5">
                <img src="Images/a.png" style="max-width: 7%; height: auto;" alt="bullet 1"> This is an attention check card which is used to make sure that you are paying attention when sorting the cards.<br>
                <img src="Images/b.png" style="max-width: 7%; height: auto;" alt="bullet 2"> When you see an attention check card please read the description to place it in the appropriate stack.
            </div>
            <img src="Images/ac_important.png" class="img-fluid col-7 border-left" alt="Attention Check Card">
        </div>
        <hr>
        <div class="mt-5 mb-3">
            <form name="IntroDone" method="post" action="ProgressUpdate" onclick="checkAnswers()">
                <h6 class="text-center"><strong>Please answer the following questions to continue with the study.</strong></h6>

                <div class="mt-3">
                    <label>1. What do you need to consider when sorting the cards?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="consider" id="consider2" value="2">
                        <label class="form-check-label" for="consider2">Size of the card.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="consider" id="consider3" value="3">
                        <label class="form-check-label" for="consider3">If the variable is likely to be used to hold personally identifiable data, or other data that might be privacy sensitive.</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="consider" id="consider4" value="4">
                        <label class="form-check-label" for="consider4">None of the above.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                </div>
                <div class="mt-2">
                    <label>2. What do the four stacks in the above card sorting interface represent?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="represent" id="represent1" value="1">
                        <label class="form-check-label" for="represent1">If you saw this variable in code, is the corresponding data sensitive or private?</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="represent" id="represent2" value="2">
                        <label class="form-check-label" for="represent2">Complexity of the code.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>              
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="represent" id="represent4" value="4">
                        <label class="form-check-label" for="represent4">None of the above.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                </div>
                <div class="mt-2">
                    <label>3. Is it possible to undo a card sort?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="undo" id="undo1" value="1">
                        <label class="form-check-label" for="undo1">Yes, by clicking on the back button on the web browser.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="undo" id="undo2" value="2">
                        <label class="form-check-label" for="undo2">Yes, by clicking on the undo button.</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="undo" id="undo3" value="3">
                        <label class="form-check-label" for="undo3">No</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                </div>  
                <div class="mt-2">
                    <label>4. What do you do when you see an attention check card?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="attentionSort" id="attentionSort1" value="1">
                        <label class="form-check-label" for="attentionSort1">Always sort it into the "Highly Sensitive" stack.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="attentionSort" id="attentionSort2" value="2">
                        <label class="form-check-label" for="attentionSort2">Always sort it into the "Not Sensitive" stack.</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="attentionSort" id="attentionSort3" value="3">
                        <label class="form-check-label" for="attentionSort3">Read the description to identify the stack you need to place it in.</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                </div>                 
                <input id="Instructions" class="btn btn-primary mt-4 col-12" type="submit" value="Continue">
                <input type="text" name="StatusType" value="Instructions1" style="display: none;">
                <input type="text" id="status" name="Status" value="-1" style="display: none;">
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script src="js/instructions.js"></script>
</body>

</html>
