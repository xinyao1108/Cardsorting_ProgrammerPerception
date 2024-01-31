function enableNextButton(){
    var id = document.getElementById("prolificID");
    var nextButton = document.getElementById("NextButton");
    var id_value = id.value;
    if (id_value.length >= 3){
        nextButton.disabled = false;
    }else{
        nextButton.disabled = true;
    }
}