window.addEventListener('load', formCheck);

//JS validation for game form
function formCheck() {
    if (document.getElementById('addsubmit')) {
        //date regEx
        var dateRegEx = /\d{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
        //get the date field
        var date = document.getElementById('date');
        //on exiting the field check the date matches the regEx, if not display hint, clear if match

        date.addEventListener('blur', function(evt){
            if(!dateRegEx.test(evt.target.value)){
                document.getElementById('datehint').style.display = 'inline-block';
            }else{
                document.getElementById('datehint').style.display = 'none';
            }
        });
        //get fname field
        var time = document.getElementById('time');
        //check for a value, display hint if blank, clear if filled
        time.addEventListener('blur', function(evt){
            if(!evt.target.value){
                document.getElementById('timehint').style.display = 'inline-block';
            }else{
                document.getElementById('timehint').style.display = 'none';
            }
        });
        //get the home run field
        var homeRuns = document.getElementById('homeruns');
        if(homeRuns){
            homeRuns.addEventListener('blur', function(evt){
                //saw the divide by 1 idea at http://stackoverflow.com/questions/14636536/how-to-check-if-a-variable-is-an-integer-in-javascript
                if(evt.target.value%1!=0){
                    document.getElementById('homerunshint').style.display = 'inline-block';
                }else{
                    document.getElementById('homerunshint').style.display = 'none';
                }
            });
        }
        //away runs
        var awayRuns = document.getElementById('awayruns');
        if(awayRuns){
            awayRuns.addEventListener('blur', function(evt){
                if(evt.target.value%1!=0){
                    document.getElementById('awayrunshint').style.display = 'inline-block';
                }else{
                    document.getElementById('awayrunshint').style.display = 'none';
                }
            });
        }
        
        //get lname field
        submit = document.getElementById('addsubmit');
        //before form submit perform same checks and only submit if there are no problems
        submit.addEventListener('click', function(evt){
            var time = document.getElementById('time').value;
            var ampm = document.getElementById('ampm').value;
            var fullTime = time+ampm;
            document.getElementById('combined').value = fullTime;
            var thisDate = date.value;

            if(document.getElementById('away').value==document.getElementById('home').value){
                 document.getElementById('teamhint').style.display = 'block';
                 console.log('teamhint');
            }else if(!dateRegEx.test(thisDate)){
                document.getElementById('datehint').style.display = 'inline-block';
            }else if(!time) {
                document.getElementById('timehint').style.display = 'inline-block';
            }else if(homeRuns && homeRuns.value%1!=0){
                document.getElementById('homerunshint').style.display = 'inline-block';
            }else if(awayRuns && awayRuns.value%1!=0){
                document.getElementById('awayrunshint').style.display = 'inline-block';
            }else{
                document.getElementById("gameForm").submit();
            }
        });

    }
}