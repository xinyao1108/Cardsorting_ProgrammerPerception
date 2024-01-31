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
            In the following activity, you will been asked questions related to basic knowledge of programming
            and you need all correct answers to continue this questionnaire. 
        </p>
        </div>

        <hr>
        <div class="mt-5 mb-3">
            <form name="IntroDone" method="post" action="ProgressUpdate" onclick="checkAnswers()">
                <h6 class="text-center"><strong>Please answer the following questions.</strong></h6>

                <div class="mt-3">
                    <label>1. What is the purpose of an X.509 certificate for websites?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="x509" id="x5091" value="1">
                        <label class="form-check-label" for="consider3">Manage identity and security in Internet communications</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="x509" id="x5092" value="2">
                        <label class="form-check-label" for="consider4">Encryption program that provides cryptographic privacy and authentication for data communication</label>
                        <div class="invalid-feedback">
                            Incorrect.
                        </div>
                    </div>
                </div>
                <div class="mt-2">
                    <label>2. SQL injection is a technique to: </label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="sql" id="sql1" value="1">
                        <label class="form-check-label" for="represent1">attack database in applications</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="sql" id="sql2" value="2">
                        <label class="form-check-label" for="represent2">inject malicious code to the source of application</label>
                        <div class="invalid-feedback">
                            Incorrect.
                        </div>
                    </div>              
                </div>
                <div class="mt-2">
                    <label>3. Which option is correct for the difference between a passive and reactive IDS(Intrusion Detection System)?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="ids" id="ids1" value="1">
                        <label class="form-check-label" for="undo3">Reactive IDS won't take defensive actions to an alert</label>
                        <div class="invalid-feedback">
                            Incorrect.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="ids" id="ids2" value="2">
                        <label class="form-check-label" for="undo2">Passive IDS only reports the suspicious activity</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                </div>
                <div class="mt-2">
                    <label>4. Without any other changes in the default settings of a web server, what can be the motivation to close port 80?</label>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="port" id="port1" value="1">
                        <label class="form-check-label" for="attentionSort1">Prevent people accidently visit your website by HTTP.</label>
                        <div class="invalid-feedback">
                            Incorrect.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="port" id="port2" value="2">
                        <label class="form-check-label" for="attentionSort3">Stop communication over the untrusted HTTP protocol.</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                </div>  
                                <div class="mt-2">
                    <label>5. Please read the following piece of code, what is the name of the variable in this line? </label>
                           <p><i>input_ips =  load_array(args.input_file)</i></p>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="inputip" id="inputip1" value="1">
                        <label class="form-check-label" for="attentionSort1">load_array</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="inputip" id="inputip2" value="2">
                        <label class="form-check-label" for="attentionSort2">args</label>
                        <div class="invalid-feedback">
                            Incorrect. Please read the instructions again.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="inputip" id="inputip3" value="3">
                        <label class="form-check-label" for="attentionSort3">input_ips</label>
                        <div class="valid-feedback">
                            Correct!
                        </div>
                    </div>
                </div> 
                                <div class="mt-2">
                    <label>6. Please read the following piece of code, what is the name of the variable in this line? </label>
                        <p><i>new_empID = request.form[""empID""]</i></p>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="empid" id="empid1" value="1">
                        <label class="form-check-label" for="attentionSort1">request</label>
                        <div class="invalid-feedback">
                            Incorrect.
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="empid" id="empid2" value="2">
                        <label class="form-check-label" for="attentionSort2">new_empID</label>
                        <div class="invalid-feedback">
                            Correct!
                        </div>
                    </div>
                    <div class="ml-4 form-check">
                        <input class="form-check-input" type="radio" name="empid" id="empid3" value="3">
                        <label class="form-check-label" for="attentionSort3">empID</label>
                        <div class="valid-feedback">
                            Incorrect.
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
