<%@ page import = "java.io.*,java.util.*" %>
<%	
    if(session.getAttribute("CardSortingReason") == null){
        response.sendRedirect("index.html");
    }else{
        String CardSortingReason = (String) String.valueOf((int)session.getAttribute("CardSortingReason"));
		if( !CardSortingReason.equals("1") ){
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>

<body onload="updateProgress()">
    <div class="col-12 container-fluid border-bottom pb-3 border-primary bg-dark pt-3 fixed-top">
        <h4 class="text-center" style="color:white">Survey Questions</h4>
        <div class="progress mt-4 mr-4 ml-4" style="height: 20px">
            <div id="ProgressBar" class="progress-bar bg-success" role="progressbar" style="width: 0%;"
                aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">0.00%</div>
        </div>
    </div>

    <div class="col-12 container-fluid mt-5 pt-5">
        <form name="ParticipantResponse" method="post" action="SubmitSurvey">
            <div class="mt-3">
                <label><strong>1. How old are you?</strong></label>
                <div class="form-check">
                    <input class="form-control col-1" type="text" maxlength="3" name="age" id="age" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>2. What is your gender?</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="gender" id="gender1" value="Female">
                    <label class="form-check-label " for="gender1">Female</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="gender" id="gender2" value="Male">
                    <label class="form-check-label" for="gender2">Male</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="gender" id="gender3" value="Other">
                    <label class="form-check-label" for="gender3">Other</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>3. What is the highest degree you have earned?</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree1" value="NoHighSchool">
                    <label class="form-check-label " for="degree1">No high school degree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree2" value="HighSchool">
                    <label class="form-check-label" for="degree2">High school degree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree3" value="SomeCollege">
                    <label class="form-check-label" for="degree3">Some College</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree4" value="Bachelor">
                    <label class="form-check-label" for="degree4">Bachelor's degree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree5" value="Master">
                    <label class="form-check-label" for="degree5">Master's degree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="degree" id="degree6" value="Doctorate">
                    <label class="form-check-label" for="degree6">Doctorate</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>4. How many years of programming experience do you have?</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="yearsProgExp" id="yearsProgExp1" value="lt_1">
                    <label class="form-check-label " for="yearsProgExp1"> Less than 1 year</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="yearsProgExp" id="yearsProgExp2" value="1to3">
                    <label class="form-check-label" for="yearsProgExp2">1-3</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="yearsProgExp" id="yearsProgExp3" value="3to6">
                    <label class="form-check-label" for="yearsProgExp3">3-6</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="yearsProgExp" id="yearsProgExp4" value="6to10">
                    <label class="form-check-label" for="yearsProgExp4">6-10</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="yearsProgExp" id="yearsProgExp5" value="10+">
                    <label class="form-check-label" for="yearsProgExp5">More than 10 years</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>5. How many programming languages have you used in the past?</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="progLangUsed" id="progLangUsed1" value="1to2">
                    <label class="form-check-label " for="progLangUsed1">1-2</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="progLangUsed" id="progLangUsed2" value="3to5">
                    <label class="form-check-label" for="progLangUsed2">3-5</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="progLangUsed" id="progLangUsed3" value="6to8">
                    <label class="form-check-label" for="progLangUsed3">6-8</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="progLangUsed" id="progLangUsed4" value="9to12">
                    <label class="form-check-label" for="progLangUsed4">9-12</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="progLangUsed" id="progLangUsed5" value="12+">
                    <label class="form-check-label" for="progLangUsed5">More than 12</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>6. I take into consideration a technology's security</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="ConsiderTechSec" id="ConsiderTechSec1" value="1">
                    <label class="form-check-label " for="ConsiderTechSec1">Strongly disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="ConsiderTechSec" id="ConsiderTechSec2" value="2">
                    <label class="form-check-label" for="ConsiderTechSec2">Disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="ConsiderTechSec" id="ConsiderTechSec3" value="3">
                    <label class="form-check-label" for="ConsiderTechSec3">Undecided</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="ConsiderTechSec" id="ConsiderTechSec4" value="4">
                    <label class="form-check-label" for="ConsiderTechSec4">Agree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="ConsiderTechSec" id="ConsiderTechSec5" value="5">
                    <label class="form-check-label" for="ConsiderTechSec5">Strongly agree</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>7. Security is more important than functionality</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSFuncImporance" id="secVSFuncImporance1" value="1">
                    <label class="form-check-label " for="secVSFuncImporance1">Strongly disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSFuncImporance" id="secVSFuncImporance2" value="2">
                    <label class="form-check-label" for="secVSFuncImporance2">Disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSFuncImporance" id="secVSFuncImporance3" value="3">
                    <label class="form-check-label" for="secVSFuncImporance3">Undecided</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSFuncImporance" id="secVSFuncImporance4" value="4">
                    <label class="form-check-label" for="secVSFuncImporance4">Agree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSFuncImporance" id="secVSFuncImporance5" value="5">
                    <label class="form-check-label" for="secVSFuncImporance5">Strongly agree</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="mt-3">
                <label><strong>8. Security is more important than customer satisfaction</strong></label>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSSatisfactionImporance" id="secVSSatisfactionImporance1" value="1">
                    <label class="form-check-label " for="secVSSatisfactionImporance1">Strongly disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSSatisfactionImporance" id="secVSSatisfactionImporance2" value="2">
                    <label class="form-check-label" for="secVSSatisfactionImporance2">Disagree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSSatisfactionImporance" id="secVSSatisfactionImporance3" value="3">
                    <label class="form-check-label" for="secVSSatisfactionImporance3">Undecided</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSSatisfactionImporance" id="secVSSatisfactionImporance4" value="4">
                    <label class="form-check-label" for="secVSSatisfactionImporance4">Agree</label>
                </div>
                <div class="ml-4 form-check">
                    <input class="form-check-input" type="radio" name="secVSSatisfactionImporance" id="secVSSatisfactionImporance5" value="5">
                    <label class="form-check-label" for="secVSSatisfactionImporance5">Strongly agree</label>
                </div>
            </div>
            <hr class="mt-3 mb-3">
            <div class="row ml-1 mr-1 row mt-3 mb-3">
                <label id="Unansered" style="color: red;" class="col-12"></label>
                <input id="submit" class="col btn btn-primary" type="submit" value="Submit" disabled>
            </div>
        </form>
    </div>


    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    <script src="js/PostSorting.js"></script>
</body>

</html>
