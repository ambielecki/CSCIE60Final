window.addEventListener('load', formCheck);

function formCheck(){
    if(document.getElementById('addsubmit')){//checks that we are addding a player
        
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
        var address = document.getElementById('address');
        //check for a value, display hint if blank, clear if filled
        address.addEventListener('blur', function(evt){
            if(!evt.target.value){
                document.getElementById('addresshint').style.display = 'inline-block';
            }else{
                document.getElementById('addresshint').style.display = 'none';
            }
        });

        //phone regEx
        var phoneRegEx = /\d{3}-\d{3}-\d{4}/; //matches xxx-xxx-xxxx
        var phoneRegEx2 = /\(\d{3}\)\d{3}-\d{4}/; //matches (xxx)xxx-xxxx
        var phoneRegEx3 = /\d{10}/; //matches xxxxxxxxx
        //I could keep going, but this serves the point

        //get the date field
        var phone = document.getElementById('phone');
        //on exiting the field check the phonenum matches the regEx, if not display hint, clear if match
        if(phone){
            phone.addEventListener('blur', function(evt){
                if(phoneRegEx2.test(evt.target.value)){
                    var str = evt.target.value;
                    var newstr = str.slice(1,4)+'-'+str.slice(5,8)+'-'+str.slice(9);
                    evt.target.value=newstr;
                }else if(phoneRegEx3.test(evt.target.value)){
                    var str = evt.target.value;
                    var newstr = str.slice(0,3)+'-'+str.slice(3,6)+'-'+str.slice(6);
                    evt.target.value=newstr;
                }else if(!phoneRegEx.test(evt.target.value)){
                    document.getElementById('phonehint').style.display = 'inline-block';
                }else{
                    document.getElementById('phonehint').style.display = 'none';
                }
            });
        }
        //simple email RegEx
        var emailRegEx = /\S+@\S+\.\S+/;

        var email = document.getElementById('email');
        //on exiting the field check the email matches the regEx, if not display hint, clear if match
        if(email){
            email.addEventListener('blur', function(evt){
                if(!emailRegEx.test(evt.target.value)){
                    document.getElementById('emailhint').style.display = 'inline-block';
                }else{
                    document.getElementById('emailhint').style.display = 'none';
                }
            });
        }

        //get the submit button
        submit = document.getElementById('addsubmit');
        //before form submit perform same checks and prevent submission if there is a problem
        submit.addEventListener('click', function(evt){
            var phoneVal = phone.value;
            var emailVal = email.value;
            if(!phoneRegEx.test(phoneVal)){
                document.getElementById('phonehint').style.display = 'inline-block';
                evt.preventDefault();
            }else if(!emailRegEx.test(emailVal)){
                document.getElementById('emailhint').style.display = 'inline-block';
                evt.preventDefault();
            }else if(!firstName.value) {
                document.getElementById('firsthint').style.display = 'inline-block';
                evt.preventDefault();
            }else if(!lastName.value) {
                document.getElementById('lasthint').style.display = 'inline-block';
                evt.preventDefault();
            }else if(!address.value) {
                document.getElementById('addresshint').style.display = 'inline-block';
                evt.preventDefault();
            }
        });
    }
}