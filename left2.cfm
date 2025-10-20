<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
.menutitle{
cursor:hand;
margin-bottom: 5px;
background-color:#FFFFFF;
color:#000000;
width:100px;
padding:2px;
text-align:center;
font-weight:bold;
/*/*/border:1px solid #000000;/* */
}

.submenu{
margin-bottom: 0.5em;
}
</style>

<script type="text/javascript">

/***********************************************
* Switch Menu script- by Martial B of http://getElementById.com/
* Modified by Dynamic Drive for format & NS4/IE4 compatibility
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

if (document.getElementById){ //DynamicDrive.com change
document.write('<style type="text/css">\n')
document.write('.submenu{display: none;}\n')
document.write('</style>\n')
}

function SwitchMenu(obj){
	if(document.getElementById){
	var el = document.getElementById(obj);
	var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block"){ //DynamicDrive.com change
			for (var i=0; i<ar.length; i++){
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}else{
			el.style.display = "none";
		}
	}
}

</script>
</head>

<body>
<!-- Keep all menus within masterdiv-->
<div id="masterdiv">

	<div class="menutitle" onclick="SwitchMenu('sub1')">Site Menu</div>
	<span class="submenu" id="sub1">
		- <a href="new.htm">What's New</a><br>
		- <a href="hot.htm">What's hot</a><br>
		- <a href="revised.htm">Revised Scripts</a><br>
		- <a href="morezone/">More Zone</a>
	</span>

	<div class="menutitle" onclick="SwitchMenu('sub2')">FAQ/Help</div>
	<span class="submenu" id="sub2">
		- <a href="notice.htm">Usage Terms</a><br>
		- <a href="faqs.htm">DHTML FAQs</a><br>
		- <a href="help.htm">Scripts FAQs</a>
	</span>

	<div class="menutitle" onclick="SwitchMenu('sub3')">Help Forum</div>
	<span class="submenu" id="sub3">
		- <a href="http://www.codingforums.com">Coding Forums</a><br>
	</span>
	
	<div class="menutitle" onclick="SwitchMenu('sub4')">Cool Links</div>
	<span class="submenu" id="sub4">
		- <a href="http://www.javascriptkit.com">JavaScript Kit</a><br>
		- <a href="http://www.freewarejava.com">Freewarejava</a><br>
		- <a href="http://www.cooltext.com">Cool Text</a><br>
		- <a href="http://www.google.com">Google.com</a>
	</span>

	<img src="about.gif" onclick="SwitchMenu('sub6')"><br>
	<span class="submenu" id="sub6">
		- <a href="http://www.dynamicdrive.com/link.htm">Link to DD</a><br>
		- <a href="http://www.dynamicdrive.com/recommendit/">Recommend Us</a><br>
		- <a href="http://www.dynamicdrive.com/contact.htm">Email Us</a><br>
	</span>

</div>
</body>
</html>
