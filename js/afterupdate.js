window.addEventListener('load', formCheck);

function formUpdate(){
	if(document.getElementById('newFname')){
		var newFname = document.getElementById('newFname').innerHTML;
		var newLname = document.getElementById('newLname').innerHTML;
		var newDob = document.getElementById('newDob').innerHTML;
		var newSex = document.getElementById('newSex').innerHTML;
		console.log(newFname);
		console.log(newLname);
		console.log(newDob);
		console.log(newSex);
	}
}