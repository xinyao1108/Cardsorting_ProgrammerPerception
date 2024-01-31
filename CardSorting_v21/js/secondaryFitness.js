
var radio_buttons = document.getElementsByTagName('input');
var labels = document.getElementsByTagName('label');

for (var i = 0; i < radio_buttons.length; i++){
    radio_buttons[i].addEventListener("click", updateProgress);
}

for (var i = 0; i < labels.length; i++){
    labels[i].addEventListener("click", updateProgress);
}

function updateProgress(){
    var names = ["PublicReportsComfort","PublicReportsSensitive",
                "LawEnforcementComfort","LawEnforcementSensitive",
                "MarketingComfort","MarketingSensitive",
                "Marketing3rdComfort","Marketing3rdSensitive",
                "BusinessDecisionsComfort","BusinessDecisionsSensitive",
                "MaintainServicesComfort","MaintainServicesSensitive",
                "PersonalizedServicesComfort","PersonalizedServicesSensitive",
                "ResearchDevelopmentComfort", "ResearchDevelopmentSensitive"];
    var total = names.length;
    var answered = 0;

    for(var i=0; i < total; i++){
        if (checkIfAnswered(names[i]) == true){
            answered++;
        }
    }
    var complete_p = ((answered*100)/total).toFixed(2)
    document.getElementById("ProgressBar").style.width = complete_p+"%";
    document.getElementById("ProgressBar").innerHTML = complete_p+"%";
    if (complete_p == 100){
        document.getElementById("NextButton").disabled = false;
    }else{
        document.getElementById("NextButton").disabled = true;
    }
}


function checkIfAnswered(elementName){
    x = document.getElementsByName(elementName);
    for(i=0; i < x.length ;i++){
      if(x[i].type == "radio" && x[i].checked == true){
        return true;
      }else if(x[i].type == "text" && x[i].value.length >= 2){
          return true;
      }
    }
    return false
}