function checkAnswers(){
    question_ids = ['consider',
    'represent','undo','attentionSort'];
    
    considerCorrect = false;
    consider = document.getElementsByName('consider');
    for(i=0; i < consider.length; i++){
        if (consider[i].type == 'radio' && consider[i].checked == true){
            if (consider[i].value == 3){
                considerCorrect = true;
                consider[i].classList.add('is-valid');
            }else{
                consider[i].classList.add('is-invalid');
                considerCorrect = false;
            }
        }else{
            consider[i].classList.remove('is-invalid')
            consider[i].classList.remove('is-valid');
        }
    }
    
    representCorrect = false;
    represent = document.getElementsByName('represent');
    for(i=0; i < represent.length; i++){
        if (represent[i].type == 'radio' && represent[i].checked == true){
            if (represent[i].value == 1){
                representCorrect = true;
                represent[i].classList.add('is-valid');
            }else{
                represent[i].classList.add('is-invalid');
                representCorrect = false;
            }
        }else{
            represent[i].classList.remove('is-invalid')
            represent[i].classList.remove('is-valid');
        }
    }

    undoCorrect = false;
    undo = document.getElementsByName('undo');
    for(i=0; i < undo.length; i++){
        if (undo[i].type == 'radio' && undo[i].checked == true){
            if (undo[i].value == 2){
                undoCorrect = true;
                undo[i].classList.add('is-valid');
            }else{
                undo[i].classList.add('is-invalid');
                undoCorrect = false;
            }
        }else{
            undo[i].classList.remove('is-invalid')
            undo[i].classList.remove('is-valid');
        }
    }

    attentionSortCorrect = false;
    attentionSort = document.getElementsByName('attentionSort');
    for(i=0; i < attentionSort.length; i++){
        if (attentionSort[i].type == 'radio' && attentionSort[i].checked == true){
            if (attentionSort[i].value == 3){
                attentionSortCorrect = true;
                attentionSort[i].classList.add('is-valid');
            }else{
                attentionSort[i].classList.add('is-invalid');
                attentionSortCorrect = false;
            }
        }else{
            attentionSort[i].classList.remove('is-invalid')
            attentionSort[i].classList.remove('is-valid');
        }
    }

    if( attentionSortCorrect && undoCorrect && representCorrect && considerCorrect){
        document.getElementById('Instructions').disabled = false;
        document.getElementById('status').value = 1;
    }else{
        document.getElementById('Instructions').disabled = true;
        document.getElementById('status').value = -1;
    }
}