function getCardList(){
    $.get(origin+'/SortedList',{SortingType:"Sensitive"}, getCardListCallback);
}

function getCardListCallback(data, status){
    if(status=="success"){
        var NotSensitive= "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Not Sensitive </b></p>";
        var SomewhatSensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Somewhat Sensitive </b></p>";
        var Sensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Sensitive </b></p>";
        var VerySensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Very Sensitive </b></p>";

        var length = data.length;
        for(var i=0; i < length; i++){
            if(data[i].sensitiveStackName == "Not Sensitive"){
                NotSensitive = NotSensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].sensitiveStackName == "Somewhat Sensitive"){
                SomewhatSensitive= SomewhatSensitive  + "<p class='list-group-item ' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].sensitiveStackName == "Sensitive"){
                Sensitive = Sensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].sensitiveStackName == "Very Sensitive"){
                VerySensitive = VerySensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }
        }

        document.getElementById("NotSensitive").innerHTML = NotSensitive;
        document.getElementById("SomewhatSensitive").innerHTML = SomewhatSensitive;
        document.getElementById("Sensitive").innerHTML = Sensitive;
        document.getElementById("VerySensitive").innerHTML = VerySensitive;
    }
}

function enableNextButton(){
    var uncomfort = document.getElementById("UnsensitiveDataWhy");
    var comfort = document.getElementById("SensitiveDataWhy");
    var nextButton = document.getElementById("NextButton");
    var uncomfort_value = uncomfort.value;
    var comfort_value = comfort.value;
    if (uncomfort_value.length >= 2 && comfort_value.length >= 2){
        nextButton.disabled = false;
    }else{
        nextButton.disabled = true;
    }
}