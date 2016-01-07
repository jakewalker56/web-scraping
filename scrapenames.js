function printData(string)
{
		//format: 
	/*
<a href="https://www.facebook.com/profile.php?id=2536955" 
data-hovercard="/ajax/hovercard/user.php?id=2536955" 
aria-owns="js_10" aria-haspopup="true" id="js_11">Jake Walker</a>
	*/
	var current = string;
	var n = 0;

	n = current.search(">") + 1;
	current = current.substring(n, current.length);

	n = current.search("<");
	current = current.substring(0, n);


	return current;
}

var resultstring = "";
//look in every td
tds = document.getElementsByClassName("fsl fwb fcb");
for(var i = 0; i < tds.length; i++)
{
	resultstring += printData(tds[i].innerHTML) + ';\n';
}
console.log(resultstring);
