<!--- <cfdump var="#form#">
<cfdump var="#url#"> --->
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfset type=form.tran>
<cfset refno=form.nexttranno>
<cfset itemno=form.itemno>
<cfset qty=form.qty>
<cfset trancode=form.itemcount>
<cfset old_flocation=form.oldtrfrom>
<cfset old_tlocation=form.oldtrto>
<cfset flocation=form.trfrom>
<cfset tlocation=form.trto>
<cfset custno=form.custno>
<cfset fperiod=form.readperiod>
<cfset wos_date=form.nDateCreate>
<cfset status="">
<cfset isFirst=true>

<cfquery name="getgsetup" datasource="#dts#">
    select serialnorun from gsetup
    </cfquery>

<cfif isdefined("form.add_selectedS") OR isdefined("form.del_selectedS")>

<cfquery name="getlocationexistserial" datasource="#dts#">
	SELECT count(serialno) as cnt,serialno FROM iserial 
    where itemno='#variables.itemno#' and location='#variables.tlocation#'
    and type='#variables.type#' and refno='#variables.refno#' and trancode='#variables.trancode#'
    group by serialno
    order by serialno
</cfquery>

<cfset limitqty=getlocationexistserial.recordcount>
<cfset addeditemno=''>
	<cftry>
		<cfif isdefined("form.add_selectedS")>
        <cfif limitqty lt qty>
			<cfquery name="insertSerial" datasource="#dts#">
				insert into iserial (type,refno,trancode,custno,fperiod,wos_date,
				itemno,serialno,location,currrate,sign) values 
				<cfloop list="#form.add_selectedS#" index="add_s">
                <cfif limitqty lt qty>
                <cfif addeditemno eq ''>
                 <cfset addeditemno=variables.add_s>
                <cfelse>
                <cfset addeditemno=addeditemno&","&variables.add_s>
                </cfif>
				<cfif not isFirst>,</cfif>
('TR','#variables.refno#','#variables.trancode#','#variables.custno#','#variables.fperiod#',#variables.wos_date#,
				'#variables.itemno#','#variables.add_s#','#variables.tlocation#','1',1),
				('TR','#variables.refno#','#variables.trancode#','#variables.custno#','#variables.fperiod#',#variables.wos_date#,
				'#variables.itemno#','#variables.add_s#','#variables.flocation#','1','-1')</cfif>
				<cfset isFirst=false>
                <cfset limitqty=limitqty+1>
                
				</cfloop>
			</cfquery>
            </cfif>
			<cfset status="Successfully Insert Serial No.(#addeditemno#).">
		</cfif>
		<cfif isdefined("form.del_selectedS")>
			<cfquery name="deleteSerial" datasource="#dts#">
				delete from iserial 
				where type='TR' and refno='#variables.refno#'  and itemno='#variables.itemno#' 
				and serialno in ('#listChangeDelims(form.del_selectedS,"','")#')
			</cfquery>
			<cfif status eq ""><cfset status="Successfully Delete Serial No.(#form.del_selectedS#).">
			<cfelse><cfset status=status&"<br>Successfully Delete Serial No.(#form.del_selectedS#)."></cfif>
		</cfif>
		<cfcatch type="database">
			<cfset status="Please check with administrator.<br>Error code:"&cfcatch.Detail>
		</cfcatch>
	</cftry>
<cfelse>
	
</cfif>

<cfquery name="getSerial_flocation" datasource="#dts#">
	SELECT * FROM(SELECT count(serialno) as cnt,serialno,sum(sign) as sign FROM iserial where itemno='#variables.itemno#' 
    and location='#variables.flocation#'
    group by serialno

    order by serialno)as a where a.sign>0
</cfquery>

<!--- Added Serial No. --->
<cfquery name="getSerial_tlocation" datasource="#dts#">
	SELECT count(serialno) as cnt,serialno FROM iserial 
    where itemno='#variables.itemno#' and location='#variables.tlocation#'
    and type='#variables.type#' and refno='#variables.refno#' and trancode='#variables.trancode#'
    group by serialno
    order by serialno
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<title>Serial - Transfer</title>
<script language="javascript">
	function getSubmit(buttontype){
		var x=document.inputForm;
		if(buttontype=='save'){x.action="iss_serial.cfm";
		}else if(buttontype=='next'){x.action="../transaction/iss3.cfm?complete=complete";}
		x.submit();
	}
	function ckbxselectall(stype){
		var len=0;var chck=true;
		if(stype=='checkall_del'){
			len=document.inputForm.del_selectedS.length;
			if(document.getElementById(stype).checked){chck=true;}else{chck=false;}
			for(var id=0;id<len;id++){document.inputForm.del_selectedS[id].checked=chck;}
		}else if(stype=='checkall_add'){
			len=document.inputForm.add_selectedS.length;
			if(document.getElementById(stype).checked){chck=true;}else{chck=false;}
			for(var id=0;id<len;id++){document.inputForm.add_selectedS[id].checked=chck;}
		}
	}
	
function trim (str) {
				var	str = str.replace(/^\s\s*/, ''),
					ws = /\s/,
					i = str.length;
				while (ws.test(str.charAt(--i)));
				return str.slice(0, i + 1);
			}
function handleEnter(event){
			var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			if(keyCode==13){
				var getserialnostring = document.getElementById('serialnoselect').value;
				var mySplitResult = getserialnostring.split("    ");
				var spliresult = trim(mySplitResult[0]);
				len=document.inputForm.add_selectedS.length;
				var gotexist = 0
				for(var id=0;id<len;id++)
				{
					if (spliresult==trim(document.inputForm.add_selectedS[id].value)) 
					{
						document.inputForm.add_selectedS[id].checked=true;
						var gotexist = 1
					}
				}
				if (gotexist ==0)
				{
				alert('Serial No for this item doesnt exist')
				}
				document.getElementById('serialnoselect').value='';
			
			return false;}
			return true;
		}
		
		
		function handleEnter2(event){
			var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			if(keyCode==13){
				var getserialnostring = document.getElementById('serialnoselect2').value;
				var mySplitResult = getserialnostring.split("    ");
				var spliresult = trim(mySplitResult[0]);
				len=document.inputForm.del_selectedS.length;
				var gotexist = 0
				for(var id=0;id<len;id++)
				{
					if (spliresult==trim(document.inputForm.del_selectedS[id].value)) 
					{
						document.inputForm.del_selectedS[id].checked=true;
						var gotexist = 1
					}
				}
				
				if (gotexist ==0)
				{
				alert('Serial No for this item doesnt exist')
				}
				document.getElementById('serialnoselect2').value='';
			return false;}
			return true;
		}
		
		function checkserial(){
		for(i=document.getElementById('autoserialnofrom').selectedIndex;i<=document.getElementById('autoserialnoto').selectedIndex;i++)
		{
		document.inputForm.add_selectedS[i].checked=true;
		}
		}
		
		function uncheckserial(){
		for(i=document.getElementById('autoserialnofrom').selectedIndex;i<=document.getElementById('autoserialnoto').selectedIndex;i++)
		{
		document.inputForm.add_selectedS[i].checked=false;
		}
		}
		
		
</script>
</head>

<body onunload="return false">
<h1 align="center">Serial - Transfer</h1>
<cfif variables.status neq ""><h3><cfoutput><pre>#wrap(variables.status,200)#</pre></cfoutput></h3></cfif>
<cfoutput>
<h2>Qty : #qty#</h2>
</cfoutput>
<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i">
<table>
    <tr>
    <th>Add Serial no</th>
    <td><input type="text" name="serialnoselect" id="serialnoselect" value="" onKeyPress="return handleEnter(event)">
			
     </td>
     </tr>
     <tr>
     <td>&nbsp;</td></tr>
     <tr>
    <th>Remove Serial no</th>
    <td><input type="text" name="serialnoselect2" id="serialnoselect2" value="" onKeyPress="return handleEnter2(event)">
			
     </td>
     </tr>
     </table>
    </cfif>

<form name="inputForm" method="post">
<cfoutput>
	<input type="hidden" name="tran" value="#variables.type#" />
	<input type="hidden" name="nexttranno" value="#variables.refno#" />
	<input type="hidden" name="itemno" value="#convertquote(variables.itemno)#" />
	<input type="hidden" name="qty" value="#variables.qty#" />
	<input type="hidden" name="itemcount" value="#variables.trancode#" />
	<input type="hidden" name="oldtrfrom" value="#variables.old_flocation#" />
	<input type="hidden" name="oldtrto" value="#variables.old_tlocation#" />
	<input type="hidden" name="trfrom" value="#variables.flocation#" />
	<input type="hidden" name="trto" value="#variables.tlocation#" />
	<input type="hidden" name="custno" value="#variables.custno#">
	<input type="hidden" name="readperiod" value="#variables.fperiod#">
	<input type="hidden" name="nDateCreate" value="#variables.wos_date#">
    <input type="hidden" name="consignment" value="#form.consignment#">
	<!--- Passing Data (Not In Used)--->
	<input type="hidden" name="ttran" value="#form.ttran#">
	<input type="hidden" name="status" value="#form.status#">
	<input type="hidden" name="type" value="#form.type#">				
	<input type="hidden" name="agenno" value="#form.agenno#">
	<input type="hidden" name="name" value="#form.name#">
	<input type="hidden" name="invoicedate" value="#form.invoicedate#">
	<!--- Add on 260808 --->
	<input type="hidden" name="hmode" value="#form.hmode#">
    <table width="50%" class="data">
    <tr>
        <th width="10%">No.</th>
        <th>Selected Serial No.</th>
        <th width="5%"><input type="checkbox" name="checkall_del" onclick="ckbxselectall(this.name)" /><font style="vertical-align:top" color="##FF0000">*</font></th>
    </tr>
    <cfif getSerial_tlocation.recordcount neq 0>
        <cfloop query="getSerial_tlocation">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td>#getSerial_tlocation.currentrow#</td>
            <td>#getSerial_tlocation.serialno#</td>
            <td align="center"><input type="checkbox" name="del_selectedS" value="#getSerial_tlocation.serialno#" /></td>
        </tr>
        </cfloop>
    <cfelse>
        <tr><td align="center" colspan="3">No Record Found</td></tr>
    </cfif>
    </table>
    <br />
    <table width="50%" class="data">
    <tr>
        <th width="10%">No.</th>
        <th>Serial No.</th>
        <th width="5%"><input type="checkbox" name="checkall_add" onclick="ckbxselectall(this.name)" /><font style="vertical-align:top" color="##FF0000">**</font></th>
    </tr>
	<cfif getSerial_flocation.recordcount neq 0>
		<cfloop query="getSerial_flocation">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td>#getSerial_flocation.currentrow#</td>
			<td>#getSerial_flocation.serialno#</td>
			<td align="center"><input type="checkbox" name="add_selectedS" value="#getSerial_flocation.serialno#" /></td>
		</tr>
		</cfloop>
	<cfelse>
        <tr><td align="center" colspan="3">No Record Found</td></tr>
    </cfif>
    </table>
    
     <cfif getgsetup.serialnorun eq 'Y' and form.tran eq "TR">
     <cfset serialcount=0>
        <table class="data">
            <tr>
              <th rowspan="2" width="100px">Serial No</th>     
              <th>Running Number From :</th>
              <td><select name="autoserialnofrom" id="autoserialnofrom">
               <cfloop query="getSerial_flocation">
               <option value="#getSerial_flocation.serialno#">#getSerial_flocation.serialno#</option>
              <cfset serialcount=serialcount+1>
              </cfloop>
              </select>
              </td>
            </tr>
            <tr>
              <th>Running Number To :</th>
              <td><select name="autoserialnoto" id="autoserialnoto">
              <cfloop query="getSerial_flocation">
              <option value="#getSerial_flocation.serialno#">#getSerial_flocation.serialno#</option>
              </cfloop>
              </select></td>
            </tr>
            <tr>
              <th></th>
              <td><input type="hidden" name="serialcount" id="serialcount" size="5" value="#serialcount#" /></td>
              <td><input type="button" name="add_text3" value="Check" onClick="checkserial()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="add_text3" value="Remove Check" onClick="uncheckserial()"></td>
            </tr>
          </table>
		</cfif>
	<br />
    <center>
		<input type="reset" name="reset"  value="Reset" />
		<input type="button" name="save" value="Save" onclick="getSubmit('save')" />
		<input type="button" name="next" value="Next" onclick="getSubmit('next')" />
	</center>
	<font style="vertical-align:top" color="##FF0000">* Delete Selected Serial No.</font><br />
	<font style="vertical-align:top" color="##FF0000">** Add Selected Serial No.</font>
</cfoutput>
</form>
</body>
</html>

<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i">
<script type="text/javascript">
document.getElementById('serialnoselect').focus();
</script>
</cfif>