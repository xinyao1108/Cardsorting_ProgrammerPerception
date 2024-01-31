function getCardList(){
    $.get(origin+'/SortedList', {SortingType:"Comfort"}, getCardListCallback);
}

function getCardListCallback(data, status){
    if(status=="success"){
        var NotSensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Not Sensitive </b></p>";
        var LessSensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Less Sensitive </b></p>";
        var Sensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Sensitive </b></p>";
        var HighlySensitive = "<p class='list-group-item list-group-item-primary' style='width: 20rem;'><b> Highly Sensitive </b></p>";

        var length = data.length;
        //alert(data);
        for(var i=0; i < length; i++){
            if(data[i].stackName == "Not Sensitive"){
                NotSensitive = NotSensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].stackName == "Less Sensitive"){
                LessSensitive = LessSensitive  + "<p class='list-group-item ' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].stackName == "Sensitive"){
                Sensitive = Sensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }else if(data[i].stackName == "Highly Sensitive"){
                HighlySensitive = HighlySensitive + "<p class='list-group-item' style='width: 20rem;'>"+data[i].name+"</p>";
            }
        }

        document.getElementById("NotSensitive").innerHTML = NotSensitive;
        document.getElementById("LessSensitive").innerHTML = LessSensitive;
        document.getElementById("Sensitive").innerHTML = Sensitive;
        document.getElementById("HighlySensitive").innerHTML = HighlySensitive;
    }
}

function enableNextButton(){
    var nextButton = document.getElementById("NextButton");
    var radioBtnPage = document.getElementById("radioBtnPage").value;
    
   	// Radio Button Validation
    var variableList = ["profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"]
	var radioChecks = true;
	for(var i=(radioBtnPage-1)*20; i<radioBtnPage*20;i++){
		var checked = [...document.getElementsByName(variableList[i])].some(c=>c.checked);
		if(!checked) {
			radioChecks = false
			break
		}
	}
	
	// Radio Button Validation
    if (radioChecks){
        nextButton.disabled = false;
    }else{
        nextButton.disabled = true;
    }
}