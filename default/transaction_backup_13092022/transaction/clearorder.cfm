<html>
<head>
<title>Physical Worksheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	function calculate_adjusted_qty(balance,actual)
	{
		var qty_balance=parseFloat(balance);
		var qty_actual=parseFloat(actual);
		var result=qty_balance-qty_actual;
		return result;
	}
	
	function setallzero()
	{
		for (var i=1;i<=document.getElementById('totalitem').value;i++)
		{
			document.getElementById('actualqty'+i).value=0;
			
		}

	}
</script>

</head>


<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lmodel from gsetup;
</cfquery>


<body>
<cfset totalqty=0>
<cfset totalact=0>
<table align="center" class="data" width="100%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="7"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Clear Order Form</strong></font></div></td>
	</tr>
		<tr>
			<td colspan="7"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Reference No: #url.refno#</strong></font></div></td>
		</tr>
	<tr>
		<td colspan="7"><hr/></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM DESCRIPTION</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ORIGINAL QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ACTUAL QTY</font></div></td>
		
	</tr>
	<tr>
		<td colspan="7"><hr/></td>
	</tr>
	
    <cfquery name="getartran" datasource="#dts#">
		select rem49 from artran where type='#url.tran#' and refno='#url.refno#'
        order by trancode
	</cfquery>
    
	<cfquery name="getiteminfo" datasource="#dts#">
		select * from ictran where type=<cfif url.tran eq 'TR'>'TROU'<cfelse>'#url.tran#'</cfif> and refno='#url.refno#'
        order by trancode
	</cfquery>
	
	<cfform name="clearorderform" action="clearorderprocess.cfm" method="post">
		<input type="hidden" name="tran" value="#url.tran#">
		<input type="hidden" name="refno" value="#url.refno#">
        <input type="hidden" name="rem49" value="#getartran.rem49#">
		<cfloop query="getiteminfo">
			<tr onClick="javascript:document.physical_worksheet_adjust.actualqty#getiteminfo.currentrow#.select();" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td nowrap>
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.currentrow#.</font></div>
				</td>
				<td nowrap>
					<input type="hidden" id="itemno#getiteminfo.currentrow#" name="itemno#getiteminfo.currentrow#" value="#convertquote(getiteminfo.itemno)#">
					<input type="hidden" id="trancode#getiteminfo.currentrow#" name="trancode#getiteminfo.currentrow#" value="#getiteminfo.trancode#">
                    <div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div>
				</td>
				<td nowrap>
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.desp#</font></div>
				</td>
				<td nowrap>
					<input type="hidden" id="originalqty#getiteminfo.currentrow#" name="originalqty#getiteminfo.currentrow#" value="#convertquote(getiteminfo.qty)#">
					<div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.qty#</font></div>
				</td>
				<td nowrap>
					<div align="right">
                    <cfif url.tran eq 'RC' and getartran.rem49 eq ''>
                    <cfinput type="text" id="actualqty#getiteminfo.currentrow#" name="actualqty#getiteminfo.currentrow#" value="#getiteminfo.QTY#" size="5" message="Please Enter A Correct Quantity !" required="no" validate="float">
                    <cfelse>
                    <cfinput type="text" id="actualqty#getiteminfo.currentrow#" name="actualqty#getiteminfo.currentrow#" value="#getiteminfo.QTY#" size="5" message="Please Enter A Correct Quantity !" required="no" validate="float" readonly>
                    </cfif>   
                    </div>
				</td>
				
			</tr>
            <cfset totalqty=totalqty+val(getiteminfo.qty)>
		</cfloop>
    <tr><td colspan="100%"><hr></td></tr>
    <tr>
    <td colspan="2"></td>
    <td>Total :</td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalqty#</font></div></td>
    </tr>
		<tr>
			<td colspan="7"><hr/></td>
		</tr>
		<tr align="center">
			<td colspan="7">
				<input type="submit" name="Submit" value="Submit">
				<input type="reset" name="Reset" value="Reset">
			</td>
		</tr>
	</cfform>
</cfoutput>

</table>
</body>
</html>