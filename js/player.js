window.addEventListener('load', formCheck);

function formCheck(){
    if(document.getElementById('addsubmit')){//checks that we are addding a player
        //date regEx
        var dateRegEx = /\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
        //get the date field
        var date = document.getElementById('dob');
        //on exiting the field check the date matches the regEx, if not display hint, clear if match
        if(date){
            date.addEventListener('blur', function(evt){
                if(!dateRegEx.test(evt.target.value)){
                    document.getElementById('datehint').style.display = 'inline-block';
                }else{
                    document.getElementById('datehint').style.display = 'none';
                }
            });
        }
        //get fname field
        var firstName = document.getElementById('firstname');
        //check for a value, display hint if blank, clear if filled
        firstName.addEventListener('blur', function(evt){
            if(!evt.target.value){
                document.getElementById('firsthint').style.display = 'inline-block';
            }else{
                document.getElementById('firsthint').style.display = 'none';
            }
        });
        //get lname field
        var lastName = document.getElementById('lastname');
        //check for a value, display hint if blank, clear if filled
        lastName.addEventListener('blur', function(evt){
            if(!evt.target.value){
                document.getElementById('lasthint').style.display = 'inline-block';
            }else{
                document.getElementById('lasthint').style.display = 'none';
            }
        });
        //get the submit button
        submit = document.getElementById('addsubmit');
        //before form submit perform same checks and prevent submission if there is a problem
        submit.addEventListener('click', function(evt){
            var dob = date.value;
            if(!dateRegEx.test(dob)){
                document.getElementById('datehint').style.display = 'inline-block';
            }else if(!firstName.value) {
                document.getElementById('firsthint').style.display = 'inline-block';
            }else if(!lastName.value) {
                document.getElementById('lasthint').style.display = 'inline-block';
            }else {
                document.getElementById("playerForm").submit();
            }
        });
    }
}