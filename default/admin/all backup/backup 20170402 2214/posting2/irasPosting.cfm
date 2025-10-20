<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>IRAS POSTING</title>
<link rel="stylesheet" href="../../../stylesheet/stylesheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script type="text/javascript">
function check1(){
	//alert(document.getElementById('radio').checked +""+ document.getElementById('radio14').checked);
 if (document.getElementById('radio').checked==true && document.getElementById('radio14').checked==true){
 	alert('Please select Posting type');
 }else if(document.getElementById('radio3').checked==true && document.getElementById('radio14').checked==true){
	alert('Please select Posting type'); 
 }else{
	frames['frame1'].location.href='javascript:document.form1.submit()';
 }
 
}

</script>


<body>
	<h1 align="center">IRAS POSTING</h1>
	<form id="form2" name="form2"  action="irasPosting2.cfm" target="frame1" method="post" >
	<table width="70%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
	    	<td>
		    	<a onClick="document.getElementById('radio').checked='true';document.getElementById('unpost').style.display='none';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
	      		<label><input name="radio" type="radio" id="radio" value="1" style="background-color: CCCCFF; border: 0px inset 0000CC;" checked></label>
        		List bills Not Exported(IRAS)
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio4').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    <label><input type="radio" name="radio4" id="radio4" value="INV" style="background-color: CCCCFF; border: 0px inset 0000CC;">Invoices</label>
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio7').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio4" id="radio7" value="CS"  style="background-color: CCCCFF; border: 0px inset 0000CC;">
	      			Cash Sales
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio10').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio4" id="radio10" value="ALL" checked>All Bills
				</a>
			</td>
	    	<td bgcolor="#FF99FF">
		    	<a onClick="document.getElementById('radio11').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio11" id="radio11" value="1" checked>Replace duplicates with items imported
				</a>
			</td>
      	</tr>
	  	<tr>
	    	<td>
		    	<a onClick="document.getElementById('radio2').checked='true';document.getElementById('unpost').style.display='block';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio" id="radio2" value="2">List bills Exported(IRAS)
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio5').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
		    		<input type="radio" name="radio4" id="radio5" value="CN">Credit Note
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio8').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio4" id="radio8" value="DN">Debit Note
				</a>
			</td>
	    	<td>&nbsp;</td>
	    	<td bgcolor="#FF99FF">
		    	<a onClick="document.getElementById('radio12').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio11" id="radio12" value="2">Do Not import duplicate items
				</a>
			</td>
      	</tr>
	  	<tr>
	    	<td>
		    	<a onClick="document.getElementById('radio3').checked='true';document.getElementById('unpost').style.display='none';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio" id="radio3" value="3" style="background-color: CCCCFF; border: 0px inset 0000CC;">List Exported Transactions
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio6').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio4" id="radio6" value="RC">Received
				</a>
			</td>
	    	<td>
		    	<a onClick="document.getElementById('radio9').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio4" id="radio9" value="PR">Purchase Return
				</a>
			</td>
	    	<td>&nbsp;</td>
	    	<td bgcolor="#FF99FF">
		    	<a onClick="document.getElementById('radio13').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio11" id="radio13" value="3">Clear all and import
				</a>
			</td>
      	</tr>
	  	<tr>
	  	  <td>&nbsp;</td>
	  	  <td>&nbsp;</td>
	  	  <td>&nbsp;</td>
	  	  <td>&nbsp;</td>
	  	  <td bgcolor="#FF99FF" style="display:none" id="unpost">
          <a onClick="document.getElementById('radio14').checked='true';form2.submit();" onMouseMove="JavaScript:this.style.cursor='hand'">
			    	<input type="radio" name="radio11" id="radio14" value="4">Unpost
				</a>
          </td>
  	  </tr>
	</table>
	</form> 
<cfoutput>
	<br>
	<div align="center"><iframe name="frame1" src="irasPosting2.cfm" width="70%" height="360px" scrolling="auto" align="center"></iframe></div>
	<table width="70%" align="center">
		<tr><td colspan="2">&nbsp;</td></tr>
		<tr>
			<td>&nbsp;</td>
			<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="submit2" value="Submit" onClick="check1();"></td>
		</tr>
	</table>
</cfoutput>
</body>
</html>




