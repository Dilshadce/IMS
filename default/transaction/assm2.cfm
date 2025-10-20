<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1071,1094,1024,1031,1095,58,120,65,482,227,1096,785,1097,1098,592,1099,1100,1101,1102,1103,1104,1105,120,1106,953,1107,1108,1109">
<cfinclude template="/latest/words.cfm">
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<object classid="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" id="feedcontact1" width="0" height="0">
	<param name="FieldDelim" value="|">
    <param name="UseHeader" value="True">
</object>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>
<html>
<head>
<title><cfoutput>#words[1071]#</cfoutput></title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">
	function validate() {
		if(document.form.itemno.value=='') {
			alert("Your Item's No. cannot be blank.");
			document.form.itemno.focus();
			return false;
		}
		if(document.form.bomno.value=='') {
			alert("Your BOM No. cannot be blank.");
			document.form.bomno.focus();
			return false;
		}
		return true;
	}
	function getProduct(type){
		var inputtext = document.invoicesheet.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
	}
	function getProductResult(itemArray){
		DWRUtil.removeAllOptions("itemno");
		DWRUtil.addOptions("itemno", itemArray,"KEY", "VALUE");
	}
	function selectlist(custno,fieldtype) {
		for (var idx=0;idx<document.getElementById('itemno').options.length;idx++) {
			if (custno==document.getElementById('itemno').options[idx].value) {
				document.getElementById('itemno').options[idx].selected=true;
        	}
		} 
		getbomnofunc();
	}
	
	function getbomnofunc(){
		ajaxFunction(document.getElementById('bomnoAjaxfield'),'assmbomnoAjax.cfm?itemno='+escape(encodeURIComponent(document.getElementById('itemno').value)));
		
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
	SELECT lastUsedNo AS tranno, refnoused AS arun 
	FROM refnoset
	WHERE type = 'ASSM' AND counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
</cfquery>
<cfquery name="getgeneral" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>
<cfquery name="getdisplaysetup" datasource="#dts#">
	SELECT * 
	FROM displaysetup;
</cfquery>

<cfif getGeneralInfo.arun eq "1">

	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="nexttranno" />

	<!---<cfset refnocnt = len(getGeneralInfo.tranno)>	
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
	<cfset limit = 12>
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
	</cfif>--->
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
		SELECT refno 
        FROM artran 
        WHERE type = 'RC' AND refno = '#nexttranno#'
	</cfquery>
	<cfif checkexist.recordcount gt 0>
		<h3><cfoutput>#words[1094]#</cfoutput></h3>
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
		UPDATE refnoset 
		SET lastUsedNo=UPPER('#nexttranno#')
		WHERE type = 'ASSM' AND counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery>
</cfif>

<cfquery name="getictran" datasource="#dts#">
	SELECT * 
    FROM ictran 
    WHERE refno = '#nexttranno#' AND type = 'RC' 
    ORDER BY itemcount
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
	SELECT * 
    FROM GSetup
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
	SELECT itemno,(
    	SELECT desp 
        FROM icitem 
        WHERE itemno=a.itemno)AS desp 
    FROM billmat AS a 
    GROUP BY itemno 
    ORDER BY itemno
</cfquery>
<body>
<cfoutput>
<table width="85%" align="center" class="data">
    <tr> 
      	<th width="34%">#words[1024]#: </th>
      	<td width="31%"><strong><font color="##FF0000" size="2" face="Arial, Helvetica, sans-serif">#nexttranno#</font></strong></td>
      	<td width="35%">&nbsp;</td>
    </tr>
    <tr>
		<th>#words[1031]#: </th>
      	<td><font face="Arial, Helvetica, sans-serif">#invoicedate#</font></td>
      	<td>&nbsp;</td>
	</tr>
	<tr>
		<th>#words[1095]#: </th>
    	<td><font face="Arial, Helvetica, sans-serif">Assm/999</font></td>
      	<td>&nbsp;</td>
	</tr>
</table>
<br>
<table width="100%"  align="center" class="data">
	<tr>
    	<th>#words[58]#</th>
		<th>#words[120]#</th>
      	<th>#words[65]#</th>
		<cfif getdisplaysetup.billbody_location eq 'Y'>
            <th>#words[482]#</th>
        </cfif>
      	<th>#words[227]#</th>
      	<th>#words[1096]#&nbsp;</th>
	  	<th>#words[785]#</th>
      	<th>#words[1097]#</th>
    </tr>
    <cfif getictran.recordcount gt 0>
      	<cfloop query="getictran"> 
        <tr> 
        	<td><font face="Arial, Helvetica, sans-serif">#itemcount#</font></td>
          	<td><font face="Arial, Helvetica, sans-serif">#itemno#</font></td>
          	<td><font face="Arial, Helvetica, sans-serif">#desp#</font></td>
			<cfif getdisplaysetup.billbody_location eq 'Y'>
                <td><font face="Arial, Helvetica, sans-serif">#location#</font></td>
            </cfif>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#qty#</font></div></td>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#DecimalFormat(price_bil)#</font></div></td>
          	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#refno3#</font></div></td>
		  	<td><div align="right"><font face="Arial, Helvetica, sans-serif">#DecimalFormat(amt_bil)#</font></div></td>
        </tr>
      	</cfloop> 
    </cfif>
</table>
<hr>
<cfif isdefined ("url.complete")>
	<cfform name="invoicesheet" action="assm3b.cfm" method="post">
		<input type="hidden" name="currrate" value="#currrate#">
  		<input type="hidden" name="tran" value="RC">	
 		<input type="hidden" name="nexttranno" value="#nexttranno#">
  		<cfquery name="getartran" datasource="#dts#">
			SELECT * 
            FROM artran 
            WHERE refno = '#nexttranno#' AND type = "RC"
		</cfquery>
		<cfquery name="getictran" datasource="#dts#">
			SELECT SUM(amt_bil) AS subtotal 
            FROM ictran 
            WHERE refno = '#nexttranno#' AND type = "RC"
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
        		<td>#words[1098]#</td>
        		<td>:</td>
        		<td>
                    <input name="subtotal" type="text" size="10" maxlength="15" value="#numberformat(getictran.subtotal,".__")#" readonly>
				</td>
			</tr>
      		<tr> 
        		<td>#words[592]# (%)</td>
        		<td>:</td>
        		<td nowrap> 
          		<cfinput name="totaldisc"  validate="integer" type="text" size="5" maxlength="3" value="#xdisp1#" required="yes" message="Please input a value for Discount(%)(0-100).">
          		<font color="##FF0000"><strong>OR</strong></font> &nbsp;#words[592]# ($) : 
          		<cfinput name="totalamtdisc" validate="float" type="text" size="10" maxlength="15" value="#xamtdisp1#" required="yes" message="Please input a value for Discount($).">
        		</td>
			</tr>
            <cfquery name="select_tax" datasource="#dts#">
							SELECT * FROM #target_taxtable#
			</cfquery>
            
            
      		<tr> 
        		<td>#words[1099]# (%)</td>
        		<td>:</td>
        		<td><cfinput name="totaltax" id="totaltax" type="text"  validate="integer"size="5" maxlength="3" value="#xtaxp1#" required="yes" message="Please input a value for Tax."> 
          		<select name="selecttax" id="selecttax" onChange="JavaScript:document.getElementById('totaltax').value=this.options[this.selectedIndex].id;">
                	<cfloop query="select_tax">
                    <cfset idrate = select_tax.rate1 * 100>
			                	<option value="#select_tax.code#" id="#idrate#" <cfif xnote eq select_tax.code>selected</cfif>>#select_tax.code#</option>
                    </cfloop>
          		</select>
				</td>
			</tr>
      		<tr> 
        		<td colspan="3" align="left">		
            	<input type="submit" name="Submit" value="#words[1104]#"><font color="##FF0000"> <--#words[1105]#</font></td>
			</tr>
    	</table>
	</cfform>
</cfif>
<br><br><br><br><br><br><br><br><br><br>
<cfform name="form" action="assm3.cfm?type1=Add&ndatecreate=#ndatecreate#" method="post" onsubmit="return validate()">
		<input type="hidden" name="refno3" value="#refno3#">
		<input type="hidden" name="currrate" value="#currrate#">
		<input type="hidden" name="nexttranno" value="#nexttranno#">
		<input type="hidden" name="custno" value="ASSM/999">
		<input type="hidden" name="desp" value="#form.desp#">
		<input type="hidden" name="despa" value="#form.despa#">
		<input type="hidden" name="readperiod" value="#readperiod#">
		<input type="hidden" name="invoicedate" value="#invoicedate#"> 
	<hr>
  	<table width="85%"  align="center" class="data">
    	<tr> 
      		<th width="15%">#words[120]#</th>
      		<td width="20%" nowrap> 
        	<select name="itemno" id="itemno" onChange="getbomnofunc();">
          		<option value="">#words[1106]#</option>
          		<cfloop query="getitem"> 
            		<option value="#itemno#">#itemno# - #getitem.desp#</option>
          		</cfloop >
			</select> 
            
             <cfif getgeneral.filterall eq "1">
        <input type="button" size="10" value="#words[953]#" onClick="ColdFusion.Window.show('finditem');" />
				<!---<input type="text" name="searchitemfr" onKeyUp="getProduct('productfrom');">--->
			</cfif>
      		</td>
      		<th width="13%">#words[1107]#</th>
      		<td width="13%"><!---<input type="text" name="bomno" size="8" maxlength="8">--->
            <div id="bomnoAjaxfield">
            <select name="bomno" id="bomno">
            <option value="">Choose a Bom No.</option>
            </select>
            </div>
            </td>
           	<td>By Moving Average/FIFO Cost<input type="checkbox" name="movingavrg" id="movingavrg" <cfif lcase(hcomid) eq "myfresh_i">checked</cfif>></td>
      		<td width="15%"><input type="submit" name="submit2" value="#words[1109]#"></td>
    	</tr>
  	</table>
</cfform>
</cfoutput>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
title="Find Item" initshow="false"
source="bomfinditem.cfm?type=Product" />
</body>
</html>