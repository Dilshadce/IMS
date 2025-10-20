<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Maintain RD/PH Work</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
	
    <script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	
	<script language="javascript">
	
	function showsa1(row){

	var abc = "r_"+row;
<!--- 	document.getElementById(abc).innerHTML ="<select name='sa2' size='5'  ondblclick=getsa(this.options[this.selectedIndex].value,<cfoutput>#entryno#</cfoutput>);document.getElementById('"+abc+"').style.display = 'none';><cfquery name='get_pc_code' datasource='#dts#'>
            SELECT * FROM pctab2
            </cfquery>
            <cfloop query='get_pc_code'><cfoutput><option value='#get_pc_code.pc_code#'>#get_pc_code.pc_code#</option></cfoutput>
            </cfloop>
			    </select>" --->
	
	if(document.getElementById(abc).style.display=='block'){
		document.getElementById(abc).style.display = 'none';
	}else{
		document.getElementById(abc).style.display = 'block';
	}
	

	}
	
		function showsa(){
	
	if(document.getElementById('sepcailaccount').style.display=='block'){
		document.getElementById('sepcailaccount').style.display = 'none';
	}else{
		document.getElementById('sepcailaccount').style.display = 'block';
	}
	

	}
	
	function getsa(obj,abc){
	var cde = "pc_code__r"+abc;
	document.getElementById(cde).value = obj;
	 
	}
	var row = 0;
	function appendRow()
	{
		//var tbl = document.getElementById(tblId);
		var tbl = document.getElementById('tit');
		var newRow = tbl.insertRow(tbl.rows.length);
		var count = parseInt(document.getElementById('count').value) + 1;
		document.getElementById('count').value = count;
		row=row+1;
		var newCel0 = newRow.insertCell(0);
		newCel0.innerHTML = '<input type="text" name="ndate__r'+row+'" size="18" maxlength="10" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ndate__r'+row+');">';
		var newCel1 = newRow.insertCell(1);
		newCel1.innerHTML = '<input type="text" name="ncode__r'+row+'" size="18" maxlength="12" />';
		var newCel2 = newRow.insertCell(2);
		newCel2.innerHTML = '<input type="text" name="nwork__r'+row+'" size="18" maxlength="12" />';
		var newCel3 = newRow.insertCell(3);
		newCel3.innerHTML = '<input type="text" name="nywork__r'+row+'" size="18" maxlength="12" />';
	}
	
	function confirmDelete(entryno,type,empno) {
	var answer = confirm("Confirm Delete?")
	if (answer){
		window.location = "prwMain_addprocess.cfm?type="+type+ "&entryno="+entryno +"&empno=" + empno ;
		}
	else{
		
		}
	}
	
	</script>
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name FROM pmast
WHERE empno='#url.empno#'
</cfquery>

<cfquery name="getPC_qry" datasource="#dts#">
SELECT * FROM pcwork
WHERE empno='#empno#'
</cfquery>

<cfquery name="get_pc_code" datasource="#dts#">
            SELECT * FROM pctab2
</cfquery>

<body>
<div class="mainTitle">Add Piece Work </div>
<div class="tabber">
	<cfoutput>
	<table>
		<tr>
			<th>Employee No.</th>
			<td><input type="text" size="12" value="#getEmp_qry.empno#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2"><input type="text" size="60" value="#getEmp_qry.name#" readonly="yes"/></td>
		</tr>
	</table>
	</cfoutput>
		
	<form name="eForm" action="/payments/2ndHalf/AddUpdate/TipAndPieceWorkedMaintenance/prwMain_addprocess.cfm?empno=<cfoutput>#url.empno#</cfoutput>" method="post">
	
	<table id="tit" class="form" border="0">
		<input type="hidden" name="count" id="count" value="0" />
		<tr>
			<th width="100px">Date</th>
			<th width="120px">Piece Code</th>
			<th width="120px">No Of Pieces X</th>
			<th width="120px">No Of Pieces Y</th>
            <th width="120px">Actions</th>
		</tr>
        <cfoutput query="getPc_qry">
        	<tr>
			<td>
            <input type="hidden" name="entryno" value="#getPc_qry.entryno#" />
            <input type="text" name="pc_date__r#entryno#" value="#lsdateformat(getPc_qry.WORK_DATE,"dd/mm/yyyy")#" size="18" maxlength="10" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pc_date__r#entryno#);"></td>
			<td><input type="text" name="pc_code__r#entryno#" id="pc_code__r#entryno#" value="#getPc_qry.PC_CODE#" size="18" maxlength="10" />
			  <!--- <img src="/images/down.png" border="0" onClick="showsa();" width="15" height="15" onMouseMove="JavaScript:this.style.cursor='hand'"/> ---><br>
			  <div style="display : none ; position: absolute;" id="sepcailaccount"><select name="sa2" size='5'  ondblclick="getsa(this.options[this.selectedIndex].value, <cfoutput>#entryno#</cfoutput>);document.getElementById('sepcailaccount').style.display = 'none';">  
			
            <cfloop query="get_pc_code">
            <cfoutput><option value="#get_pc_code.pc_code#">#get_pc_code.pc_code#</option></cfoutput>
            </cfloop>
			    </select></div>          </td>
			<td> <input type="text" name="pc_work__r#entryno#" value="#getPc_qry.PC_WORK#" size="18" maxlength="10" />            </td>
			<td>
            <input type="text" name="pc_ywork__r#entryno#" value="#getPc_qry.PC_YWORK#" size="18" maxlength="10" />          	</td>
            <td><a href="##" onclick="confirmDelete(#getPc_qry.entryno#,'del','#url.empno#')">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>	</td>
		</tr>
        </cfoutput>
	</table>
	<br />
	
	<center>
		<input type="reset" name="reset" value="Reset">
		<input type="button" name="add" value="ADD ROW" onClick="appendRow()">
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onclick="window.close()">
	</center>
	
	</form>
</div>	
</body>
</table>