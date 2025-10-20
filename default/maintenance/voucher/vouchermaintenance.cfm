<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<title>Voucher Maintenance</title>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript">
function validvoucher()
{
if(document.getElementById('vouchernumvoid').value == "")
{
alert("Voucher cannot be empty");
return false
}
if(confirm("Are you sure you want to "+document.getElementById('voidbtn').value+" voucher " + document.getElementById('vouchernumvoid').value))
{
return true;
}
else
{
return false;
}
}

function assignvouchervoid(vcode,vvalue,vtype)
{
if(vtype == "Y")
{
document.getElementById('voidbtn').value = "Unused";
}
else
{
document.getElementById('voidbtn').value = "Used";
}
}

function assignvoucherfrom(vcode,vvalue,vtype)
{
document.getElementById('voucherfromamt').value = vvalue;
}
function assignvoucherto(vcode,vvalue,vtype)
{
document.getElementById('vouchertoamt').value = vvalue;
}

function counttransfer()
{
var tranamt = document.getElementById('transferamount').value * 1;
var frmamt = document.getElementById('voucherfromamt').value * 1;
var toamt = document.getElementById('vouchertoamt').value * 1;
var newfromamt = 0;
var newtoamt = 0;

if (tranamt >= 0)
{
if(tranamt > frmamt)
{
tranamt = frmamt
}
document.getElementById('voucherfrmnewamt').value = frmamt - tranamt;
document.getElementById('vouchertonewamt').value = toamt + tranamt;
}

}

function resetvalue()
{
var tranamt = document.getElementById('transferamount').value * 1;
var frmamt = document.getElementById('voucherfromamt').value * 1;
if(tranamt > frmamt)
{
document.getElementById('transferamount').value = frmamt;
}
if(tranamt < 0)
{
document.getElementById('transferamount').value = 0;
counttransfer();
}
}

function validateform()
{
var msg = "";
if(document.getElementById('vouchernumfrom').value == "")
{
msg = msg + "Please choose voucher transfer from\n";
}
if(document.getElementById('vouchernumto').value == "")
{
msg = msg + "Please choose voucher transfer to\n";
}

if(document.getElementById('transferamount').value == 0)
{
msg = msg + "Transfer amount should not be zero";
}

if(msg == "")
{
return true;
}
else{
alert(msg);
return false;
}

}
</script>
</head>
<body>

<h4>
<a href="voucher.cfm">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a><cfif getpin2.h1R10 eq "T">|<a href="voucherapprove.cfm">Voucher Approval</a></cfif>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix.cfm">Voucher Prefix</a></h4>
<cfquery name="getvoucher" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type,a.used from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.type = "Value" 
            order by a.voucherno
</cfquery>

<cfform name="vouchertransfer" method="post" action="vouchermanprocess.cfm" onsubmit="return validateform();">
<h1>1-Voucher Balance Transfer</h1>
<cfoutput>
<table width="800px" align="center">
<tr>
<th colspan="2">Transfer From Voucher</th><th colspan="2">Transfer To Voucher</th>
</tr>
<tr>
<td width="250px">Voucher From</td>
<td width="150px">  
<select name="vouchernumfrom" id="vouchernumfrom" onChange="assignvoucherfrom(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);counttransfer();ajaxFunction(document.getElementById('voucherto'),'voucherto.cfm?voucherfrom='+this.value);">
			<option value="" id="0">Select a voucher</option>
            <cfloop query="getvoucher">
            <cfif getvoucher.used neq "Y">
            <option value="#getvoucher.voucherno#" id="#getvoucher.value#" title="#getvoucher.type#">
            #getvoucher.voucherno#-$ #numberformat(getvoucher.value,'.__')#
            </option>
            </cfif>
            </cfloop>
            
</select>
</td>
<td width="250px">Voucher To</td>
<td width="150px"> 
<div id="voucherto"> 
<select name="vouchernumto" id="vouchernumto" onChange="assignvoucherto(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);counttransfer();">
			<option value="" id="0">Select a voucher</option>
            <cfloop query="getvoucher">
            <option value="#getvoucher.voucherno#" id="#getvoucher.value#" title="#getvoucher.type#">
            #getvoucher.voucherno#-$ #numberformat(getvoucher.value,'.__')#
            </option>
            </cfloop>
</select>
</div>
</td>      
</tr>
<tr>
<th>Voucher From Balance Amount</th>
<td>
<input type="text" name="voucherfromamt" id="voucherfromamt" value="0" readonly>
</td>
<th>Voucher To Balance Amount</th>
<td>
<input type="text" name="vouchertoamt" id="vouchertoamt" value="0" readonly>
</td>
</tr>
<tr>
<td>
Transfer Amount
</td>
<td colspan="2">
<input type="text" name="transferamount" id="transferamount" onKeyUp="counttransfer();" onBlur="resetvalue();"  value="0" />
</td>
<td></td>
</tr>
<tr>
<th>Voucher From New Amount</th>
<td>
<input type="text" name="voucherfrmnewamt" id="voucherfrmnewamt" value="" readonly>
</td>
<th>Voucher To New Amount</th>
<td>
<input type="text" name="vouchertonewamt" id="vouchertonewamt" value="" readonly>
</td>
</tr>
<tr>
<td colspan="4" align="center">
<input type="submit" name="transferbalancebtn" value="Transfer" >
</td>
</tr>
</table>
</cfoutput>
</cfform>
<br/>
<h2>2-Set/Unset Voucher Used</h2>
<cfoutput>
<cfform name="voidvoucher" action="voidvoucher.cfm" method="post" onsubmit="return validvoucher()" >
<table width="800px" align="center">
<tr>
<th>Voucher No:</th>
<td><select name="vouchernumvoid" id="vouchernumvoid" onChange="assignvouchervoid(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);">
			<option value="" id="0">Select a voucher</option>
            <cfloop query="getvoucher">
            <option value="#getvoucher.voucherno#" id="#getvoucher.value#" title="<cfif getvoucher.used eq "Y">Y</cfif>">
            #getvoucher.voucherno#-$ #numberformat(getvoucher.value,'.__')#<cfif getvoucher.used eq "Y">-Y</cfif>
            </option>
            </cfloop>
            
</select>
</td>
<td><input type="submit" name="voidbtn" id="voidbtn" value="Used" /></td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>
