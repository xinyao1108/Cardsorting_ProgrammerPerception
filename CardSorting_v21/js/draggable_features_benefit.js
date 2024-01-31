// Make the DIV element draggable:
var draggable_ele = document.getElementById("draggable")
var dashboard = document.getElementById("Dashboard");
var card_name = document.getElementById("CardName");
var card_description = document.getElementById("cardDescription");
//var card_features = document.getElementById("Features");
//var featureDescriptions = document.getElementById("featureDescriptions");
var doneCard = document.getElementById("doneCard");
var undo = document.getElementById("undo");
var origin   = window.location.origin;
var path = []
dragElement(draggable_ele);

function dragElement(elmnt) {
	var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
	var minBoundX = 0, minBoundY = 0, maxBoundX = 0, maxBoundY = 0;
	var box_elmnt = document.getElementById("BoundingBox");
	var obj_SC = document.getElementById("SomewhatBeneficial");
	var obj_NC = document.getElementById("NotBeneficial");
	var obj_C = document.getElementById("Beneficial");
	var obj_VC = document.getElementById("VeryBeneficial");

	var initial_pos_top = elmnt.offsetTop;
	var initial_pos_left = elmnt.offsetLeft;
	// Call dragMouseDown when the participant clicks and holds the card the dragMouseDown function is called
	elmnt.onmousedown = dragMouseDown;
	
	function dragMouseDown(e) {
		e = e || window.event;
		e.preventDefault();

		// get the mouse cursor position at startup:
		pos3 = e.clientX;
		pos4 = e.clientY;

		// When the card is letgo the closeDragElement is function
		document.onmouseup = closeDragElement;

		// the maximum is the bottom right corner of the container
		// or.. the top left (x,y) + the height and width (h,y) - the size of the square
		maxBoundX = box_elmnt.offsetWidth - elmnt.offsetWidth;
		maxBoundY = box_elmnt.offsetHeight - elmnt.offsetHeight;

		// call a function whenever the cursor moves:
		document.onmousemove = elementDrag;
	}
	
	function elementDrag(e) {
		e = e || window.event;
		e.preventDefault();

		// calculate the new cursor position:
		pos1 = pos3 - e.clientX;
		pos2 = pos4 - e.clientY;
		pos3 = e.clientX;
		pos4 = e.clientY;

		// set the element's new position:
		elmnt.style.left = Math.max(minBoundX, Math.min(elmnt.offsetLeft - pos1, maxBoundX)) + "px";
		elmnt.style.top =  Math.max(minBoundY, Math.min(elmnt.offsetTop - pos2, maxBoundY)) + "px";
		cardOverObj(elmnt.offsetLeft,elmnt.offsetTop)
	}
	
	function closeDragElement() {
		// stop moving when mouse button is released:
		document.onmouseup = null;
		document.onmousemove = null;

		obj = getCardDropStack()
		if(obj != null){
			var datatype = card_name.textContent
			var stack = obj.textContent
			var SortedInto = stack.slice(0,stack.indexOf("Beneficial"))
			SortedInto = SortedInto +"Beneficial"
			saveCardSort(datatype, SortedInto)
		}
		elmnt.style.top = (initial_pos_top) +"px";
		elmnt.style.left = (initial_pos_left) +"px";
		resetObjs();
	}

	function getCardDropStack(){
		var rect_card = elmnt.getBoundingClientRect()
		var rect_SC = obj_SC.getBoundingClientRect()
		var rect_NC = obj_NC.getBoundingClientRect()
		var rect_C = obj_C.getBoundingClientRect()
		var rect_VC = obj_VC.getBoundingClientRect()

		if ( checkCollision(rect_card,rect_NC) ){
			return obj_NC
		}
		else if ( checkCollision(rect_card,rect_SC) ){
			return obj_SC
		}
		else if ( checkCollision(rect_card,rect_C) ){
			return obj_C
		}
		else if ( checkCollision(rect_card,rect_VC) ){
			return obj_VC
		}else{
			return null
		}
	}

	function resetObjs(){
		obj_NC.style.backgroundColor = ""
		obj_SC.style.backgroundColor = ""
		obj_C.style.backgroundColor = ""
		obj_VC.style.backgroundColor = ""
		obj_NC.style.color = "Black"
		obj_SC.style.color = "Black"
		obj_C.style.color = "Black"
		obj_VC.style.color = "Black"
	}

	function checkCollision(rect_card, rect_object){
		if ( rect_card.top > rect_object.top && rect_card.left > rect_object.left && rect_card.top < rect_object.bottom && rect_card.left < rect_object.right ){
			return true;
		}else if( rect_card.top > rect_object.top && rect_card.right > rect_object.left && rect_card.top < rect_object.bottom && rect_card.right < rect_object.right ){
			return true;
		}else{
			return false;
		}
	}

	function addToPath(nameOfStack){
		var length = path.length;
		if(length == 0){
			path.push(nameOfStack);
		}else if( path[length-1] != nameOfStack ){
			path.push(nameOfStack);
		}
	}

	function cardOverObj(top, left) {
		var rect_card = elmnt.getBoundingClientRect()
		var rect_SC = obj_SC.getBoundingClientRect()
		var rect_NC = obj_NC.getBoundingClientRect()
		var rect_C = obj_C.getBoundingClientRect()
		var rect_VC = obj_VC.getBoundingClientRect()
		
		if ( checkCollision(rect_card,rect_NC) ){
			obj_NC.style.backgroundColor = "#28A745"
			obj_NC.style.color = "White"
			addToPath("Not Beneficial");
		}else{
			obj_NC.style.backgroundColor = ""
			obj_NC.style.color = "Black"
		}

		if ( checkCollision(rect_card,rect_SC) ){
			obj_SC.style.backgroundColor = "#28A745"
			obj_SC.style.color = "White"
			addToPath("Somewhat Beneficial");
		}else{
			obj_SC.style.backgroundColor = ""
			obj_SC.style.color = "Black"
		}

		if ( checkCollision(rect_card,rect_C) ){
			obj_C.style.backgroundColor = "#28A745"
			obj_C.style.color = "White"
			addToPath("Beneficial");
		}else{
			obj_C.style.backgroundColor = ""
			obj_C.style.color = "Black"
		}

		if ( checkCollision(rect_card,rect_VC) ){
			obj_VC.style.backgroundColor = "#28A745"
			obj_VC.style.color = "White"
			addToPath("Very Beneficial");
		}else{
			obj_VC.style.backgroundColor = ""
			obj_VC.style.color = "Black"
		}
	}
}

function getCard(){
	$.get(origin+'/Card', {SortingType:'Benefit', Previous:'0'}, getCardCallback);
}

function saveCardSort(datatype, stackName){
	$.post(origin+"/Card",
	{
		CardName: datatype,
		SortedInto: stackName,
		Path: path.toString(),
		SortingType:'Benefit'
	},
	saveCardSortCallback
	);
}

function saveCardSortCallback(data, status){
	if(status == "success"){
		//alert(data);
		var timeTaken = (parseInt(data.sensitiveEndTime) - parseInt(data.sensitiveStartTime))/60000; 
		dashboard.innerHTML  = "The card <b style:'color: black'>"+ data.name + "</b> was placed in <b style:'color: black'>" + data.sensitiveStackName +"!!</b>";
								//+ " Time taken to sort card is: " + timeTaken.toFixed(4)+" Minutes and it took the following path: "+ data.sensitiveSortPath+".";
		undo.style.visibility = "visible"
		path = [];
		getCard();
	}
}

function getCardCallback(data, status){
	if(status == "success"){
        var card = data.card;
        console.log(card.name)
		if (card.name != "Done"){
			card_name.innerHTML = "<b>"+ card.name + "</b>";
			card_description.innerHTML = card.description;
			/*if(card.name == "Attention Check"){
				card_description.innerHTML = "Please place this card in the beneficial stack.";
			}else{
				card_description.innerHTML = card.description;
			}*/
			//alert("Datatype: " + card.name + " Description: " + card.description + " Features: "+ card.features[0].name);
			var complete_percent = (data.currentCardIndex/data.size)*100;
			document.getElementById("ProgressBar").style.width = complete_percent.toFixed(2)+"%";
			document.getElementById("ProgressBar").innerHTML = complete_percent.toFixed(2)+"%";
		}else{
			draggable_ele.style.visibility='hidden';
			doneCard.style.visibility='visible';
			//card_features.innerHTML = "";
			//featureDescriptions.innerHTML = "";
			document.getElementById("ProgressBar").style.width = 100+"%";
			document.getElementById("ProgressBar").innerHTML = "100%";
		}
	}
}

function getPreviousCard(){
	$.get(origin+'/Card', {SortingType:'Benefit', Previous:'1'}, getPreviousCallback);
}

function getPreviousCallback(data, status){
	if( data != null && status == "success"){
		var card = data.card;
		var timeTaken = (parseInt(card.sensitiveEndTime) - parseInt(card.sensitiveStartTime))/60000; 
		dashboard.innerHTML  = "The card <b style:'color: black'>"+ card.name + "</b> was placed in <b style:'color: black'>" + card.sensitiveStackName +"!!</b>";
								//+ "Time taken to sort card is: " + timeTaken.toFixed(4)+" Minutes and it took the following path: "+ card.sensitiveSortPath+".";
		undo.style.visibility = "visible"
		var complete_percent = (data.currentCardIndex/data.size)*100;
		document.getElementById("ProgressBar").style.width = complete_percent.toFixed(2)+"%";
		document.getElementById("ProgressBar").innerHTML = complete_percent.toFixed(2)+"%";
	}else{
		dashboard.innerHTML = "Please start sorting the cards into one of the 4 boxes!";
		undo.style.visibility = "hidden";
		document.getElementById("ProgressBar").style.width = 0+"%";
		document.getElementById("ProgressBar").innerHTML = "";
	}
}

function undoSort(){
	$.post(origin+"/Undo",{SortingType:'Benefit'}, undoCallback);
}

function undoCallback(data, status){
	var card = data;
	if( status == "success"){
		card_name.innerHTML = "<b>"+ card.name + "</b>";
		card_description.innerHTML = card.description;
		draggable_ele.style.visibility='visible';
		doneCard.style.visibility='hidden';
		getPreviousCard();
	}else{
		alert("An error occured. Unable to undo previous card sort.");
	}
}

function onPageLoad(){
	getCard();
	getPreviousCard();
}