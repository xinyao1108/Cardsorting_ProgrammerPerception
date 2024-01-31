
var radio_buttons = document.getElementsByTagName('input');
var labels = document.getElementsByTagName('label');

for (var i = 0; i < radio_buttons.length; i++){
    radio_buttons[i].addEventListener("click", updateProgress);
}

for (var i = 0; i < labels.length; i++){
    labels[i].addEventListener("click", updateProgress);
}

document.getElementById("age").addEventListener("keyup",updateProgress)

function updateProgress(){
    var names = ["age","gender","degree","yearsProgExp","progLangUsed","ConsiderTechSec","secVSFuncImporance","secVSSatisfactionImporance"];
    var total = names.length;
    var answered = 0;

    var text = "Please answer the following questions to submit:<br> ";
    var first = true;
    for(var i=0; i < total; i++){
        if (checkIfAnswered(names[i]) == true){
            answered++;
        }else{
          qnumber = i+1;
          if (first){
            text = text + " " + qnumber;
            first = false;
          }else{
            text = text + ", " + qnumber;
          }
        }
    }
    var complete_p = ((answered*100)/total).toFixed(2)
    document.getElementById("ProgressBar").style.width = complete_p+"%";
    document.getElementById("ProgressBar").innerHTML = complete_p+"%";
    if (complete_p == 100){
        document.getElementById("submit").disabled = false;
        document.getElementById("Unansered").innerHTML = "";
    }else{
        document.getElementById("submit").disabled = true;
        document.getElementById("Unansered").innerHTML = text;
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