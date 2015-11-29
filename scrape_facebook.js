/* https://www.facebook.com/groups/boothhacks/members/ */
var resultstring = ""; 
tds = document.getElementsByClassName("fsl fwb fcb"); 
for(var i = 0; i < tds.length; i++) 
{ 
	var current = tds[i].innerHTML;
	var n = 0;  
	n = current.search(">") + 1; 
	current = current.substring(n, current.length);  
	n = current.search("<"); 
	current = current.substring(0, n); 
	resultstring += current + ';\n'; 
} 
console.log(resultstring);