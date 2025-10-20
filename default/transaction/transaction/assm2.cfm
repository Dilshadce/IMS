<html>
<head>
<title>Item Assembly</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<SCRIPT LANGUAGE="JavaScript">
	function validate()
	{
		if(document.form.itemno.value=='')
		{
			alert("Your Item's No. cannot be blank.");
			document.form.itemno.focus();
			return false;
		}
		if(document.form.bomno.value=='')
		{
			alert("Your BOM No. cannot be blank.");
			document.form.bomno.focus();
			return false;
		}
		return true;
	}
</script>

<!--- REMARK ON 240608 AND REPLACE WITH THE BELOW ONE --->
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select assmno as tranno, assmarun as arun from GSetup
</cfquery--->

<!--- <cfquery datasource="main" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun 
	from refnoset
	where userDept = '#dts#'
	and type = 'ASSM'
	and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
</cfquery> --->

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun 
	from refnoset
	where type = 'ASSM'
	and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
</cfquery>

<cfif getGeneralInfo.arun eq "1">
	<cfset refnocnt = len(getGeneralInfo.tranno)>	
	<cfset cnt = 0>
	<cfset yes = 0>
	
	<cfloop condition = "cnt lte refnocnt and yes eq 0">
		<cfset cnt = cnt + 1>			
		<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>				
			<cfset yes = 1>			
		</cfif>								
	</cfloop>
	
	<cfset nolen = refnocnt - cnt + 1>
	<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
	<cfset nocnt = 1>
	<cfset zero = "">
	
	<cfloop condition = "nocnt lte nolen">
		<cfset zero = zero & "0">
		<cfset nocnt = nocnt + 1>	
	</cfloop>
	
	<cfset limit = 8>
	
	<cfif cnt gt 1>
		<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	<cfelse>
		<cfset nexttranno = numberformat(nextno,zero)> 
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	</cfif>
</cfif>

<cfif isdefined("url.complete")>
	<cfset nexttranno= form.nexttranno>
<cfelse>
	<!--- Comment By Wee Siong
	<cfquery name="check" datasource="#dts#">
		select refno from artran where refno = '#nexttranno#'
	</cfquery>
	
	<cfif check.recordcount gt 0>
		<h3>Sorry, this Reference number have been used.</h3>
		<cfabort>
	</cfif> --->
	<!--- Add By SW --->
	<cfquery name="checkexist" datasource="#dts#">
		select refno from artran where type = 'RC' and refno = '#nexttranno#'
	</cfquery>
	<cfif checkexist.recordcount gt 0>
		<h3>Sorry, this transaction number have been used.</h3>
		<cfabort>
		
	</cfif>
	<!--- REMARK ON 240608 AND REPLACE WITH THE BELOW ONE --->
	<!---cfquery name="updategeneral" datasource="#dts#">
		update gsetup set assmno = '#nexttranno#'
	</cfquery--->	
	
	<!--- <cfquery name="updategsetup" datasource="main">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where userDept = '#dts#'
		and type = 'ASSM'
		and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery> --->
	
	<cfquery name="updategsetup" datasource="#dts#">
		update refnoset 
		set lastUsedNo=UPPER('#nexttranno#')
		where type = 'ASSM'
		and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery>
</cfif>

<cfquery name="getictran" datasource="#dts#">
	select * from ictran where refno = '#nexttranno#' and type = 'RC' order by itemno
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
	Select * from GSetup
</cfquery>

<cfset lastaccyear = dateformat(getGeneralInfo.lastaccyear, "dd/mm/yyyy")>
<cfset period = '#getGeneralInfo.period#'>
<cfset currentdate = dateformat(form.invoicedate,"dd/mm/yyyy")>
<cfset tmpYear = year(currentdate)>
<cfset clsyear = year(lastaccyear)>
<cfset tmpmonth = month(currentdate)>
<cfset clsmonth = month(lastaccyear)>
<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

<cfif intperiod gt 18 or intperiod lte 0>
	<cfset readperiod = 99>
<cfelse>
	<cfset readperiod = numberformat(intperiod,"00")>
</cfif>
	
<cfset dd=dateformat('#form.invoicedate#', "DD")>

<cfif dd greater than '12'>
	<cfset nDateCreate=dateformat('#form.invoicedate#',"YYYYMMDD")>
<cfelse>
	<cfset nDateCreate=dateformat('#form.invoicedate#',"YYYYDDMM")>
</cfif>

<cfquery name="getitem" datasource="#dts#">
	select itemno from billmat group by itemno order by itemno
</cfquery>

<body>
<table width="85%" align="center" class="data">
    <tr> 
      	<th width="34%">Next Assembly No :</th>
      	<td width="31%"><strong><font color="##FF0000" size="2" face="Arial, Helvetica, sans-serif"><cfoutput>#nexttranno#</cfoutput></font></strong></td>
      	<td width="35%">&nbsp;</td>
    </tr>
    <tr>
		<th>Assembly Date :</th>
      	<td><font face="Arial, Helvetica, sans-serif"><cfoutput>#invoicedate#</cfoutput></font></td>
      	<td>&nbsp;</td>
	</tr>
	<tr>
		<th>Customer Code :</th>
    	<td><font face="Arial, Helvetica, sans-serif">Assm/999</font></td>
      	<td>&nbsp;</td>
	</tr>
</table>
<br>
<table width="100%"  align="center" class="data">
	<tr>
		<th>Item Code</th>
      	<th>Description</th>
      	<th>Quantity</th>
      	<th>Price&nbsp;</td> 
	  	<th>Curr Code</th>
      	<th>Amount</th>
    </tr>
    <cfif getictran.recordcount gt 0>
      	<cfoutput query="getictran"> 
        <tr> 
          	<td><font face="Arial, Helvetica, sans-serif">#itemno#</font></td>
          	<td><font face="Arial, Helvetica, sans-serif">#desp#</font></td>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#qty#</font></div></td>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#DecimalFormat(price_bil)#</font></div></td>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#refno3#</font></div></td>
		  	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#DecimalFormat(amt_bil)#</font></div></td>
        </tr>
      	</cfoutput> 
    </cfif>
</table>
<hr>
<cfif isdefined ("url.complete")>
	<cfform name="invoicesheet" action="assm3b.cfm" method="post">
		<cfoutput>
		<input type="hidden" name="currrate" value="#currrate#">
  		<input type="hidden" name="tran" value="RC">	
 		<input type="hidden" name="nexttranno" value="#nexttranno#">
		</cfoutput>
 	 
  		<cfquery name="getartran" datasource="#dts#">
			select * from artran where refno = '#nexttranno#' and type = "RC"
		</cfquery>
		
		<cfquery name="getictran" datasource="#dts#">
			select sum(amt_bil) as subtotal from ictran where refno = '#nexttranno#' and type = "RC"
		</cfquery>
		
		<cfif getartran.recordcount gt 0>
			<cfif getartran.disp1 eq "">
				<cfset xdisp1 = 0>		
			<cfelse>
				<cfset xdisp1 = getartran.disp1>
			</cfif>
			
			<cfif getartran.taxp1 eq "">
				<cfset xtaxp1 = 0>		
			<cfelse>
				<cfset xtaxp1 = getartran.taxp1>
			</cfif>
		
			<cfif getartran.disc1_bil eq "">
				<cfset xamtdisp1 = 0>
			<cfelse>	
				<cfset xamtdisp1 = getartran.disc1_bil>
			</cfif>	
		
			<cfset xnote = getartran.note>
		</cfif>
		
		<table width="40%" align="right" border="0">
      		<tr> 
        		<td>Sub Total</td>
        		<td>:</td>
        		<td><cfoutput><input name="subtotal" type="text" size="10" maxlength="15" value="#numberformat(getictran.subtotal,".__")#" readonly></cfoutput></td>
			</tr>
      		<tr> 
        		<td>Discount (%)</td>
        		<td>:</td>
        		<td nowrap> 
          		<cfinput name="totaldisc"  validate="integer" type="text" size="5" maxlength="3" value="#xdisp1#" required="yes" message="Please input a value for Discount(%)(0-100).">
          		<font color="#FF0000"><strong>OR</strong></font> &nbsp;Discount ($) : 
          		<cfinput name="totalamtdisc" validate="float" type="text" size="10" maxlength="15" value="#xamtdisp1#" required="yes" message="Please input a value for Discount($).">
        		</td>
			</tr>
      		<tr> 
        		<td>Tax (%)</td>
        		<td>:</td>
        		<td><cfinput name="totaltax" type="text"  validate="integer"size="5" maxlength="3" value="#xtaxp1#" required="yes" message="Please input a value for Tax."> 
          		<select name="selecttax">
            		<option value="STAX"<cfif xnote eq "STAX">selected</cfif>>STAX</option>
            		<option value="ZR"<cfif xnote eq "ZR">selected</cfif>>Zero Rated</option>
            		<option value="EX"<cfif xnote eq "EX">selected</cfif>>Exempted</option>
            		<option value="OS"<cfif xnote eq "OS">selected</cfif>>Out of Scope</option>
          		</select>
				</td>
			</tr>
      		<tr> 
        		<td colspan="3" align="left">		
            	<input type="submit" name="Submit" value="Accept"><font color="#FF0000"> <--Please Click 'Accept' When You Finished</font></td>
			</tr>
    	</table>
	</cfform>
</cfif>
<br><br><br><br><br><br><br><br><br><br>
<cfform name="form" action="assm3.cfm?type1=Add&ndatecreate=#ndatecreate#" method="post" onsubmit="return validate()">
	<cfoutput>
		<input type="hidden" name="refno3" value="#refno3#">
		<input type="hidden" name="currrate" value="#currrate#">
		<input type="hidden" name="nexttranno" value="#nexttranno#">
		<input type="hidden" name="custno" value="ASSM/999">
		<input type="hidden" name="desp" value="#form.desp#">
		<input type="hidden" name="despa" value="#form.despa#">
		<input type="hidden" name="readperiod" value="#readperiod#">
		<input type="hidden" name="invoicedate" value="#invoicedate#"> 
	</cfoutput>
	<hr>
  	<table width="85%"  align="center" class="data">
    	<tr> 
      		<th width="15%">Item Code</th>
      		<td width="20%" nowrap> 
        	<select name="itemno">
          		<option value="">Choose an Item</option>
          		<cfoutput query="getitem"> 
            		<option value="#itemno#">#itemno#</option>
          		</cfoutput>
			</select> 
      		</td>
      		<th width="13%">Bom No</th>
      		<td width="13%"><input type="text" name="bomno" size="4" maxlength="2"></td>
              <td >By Moving Average Cost<input type="checkbox" name="movingavrg" id="movingavrg"></td>
      		<td width="15%"><input type="submit" name="submit2" value="Add Item"></td>
    	</tr>
  	</table>
</cfform>

</body>
</html>