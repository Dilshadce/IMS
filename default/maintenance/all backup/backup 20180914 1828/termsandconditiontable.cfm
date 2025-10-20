<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<html>
<head>
<title>Terms and Condition Maintenance</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfif isdefined("url.type")>
	<cfquery datasource="#dts#" name="checkgetictermandcondition">
    select * from ictermandcondition;
    </cfquery>
	<cfif checkgetictermandcondition.recordcount eq 0>
    <cfquery datasource="#dts#" name="Savegetictermandcondition">
		insert into ictermandcondition (lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lQUO2,lQUO3,lQUO4,lQUO5,lSO,lSAM) values 
        (<cfqueryparam cfsqltype="cf_sql_char" value="#form.lRC#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lPR#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lDO#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lINV#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lCS#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lCN#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lDN#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lPO#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO2#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO3#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO4#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO5#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lSO#">,
        <cfqueryparam cfsqltype="cf_sql_char" value="#form.lSAM#">)
	</cfquery>
    <cfelse>
	<cfquery datasource="#dts#" name="Savegetictermandcondition">
		update ictermandcondition set 
        lRC=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lRC#">,
        lPR=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lPR#">,
        lDO=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lDO#">,
        lINV=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lINV#">,
        lCS=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lCS#">,
        lCN=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lCN#">,
        lDN=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lDN#">,
        lPO=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lPO#">,
        lQUO=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO#">,
        lQUO2=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO2#">,
        lQUO3=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO3#">,
        lQUO4=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO4#">,
        lQUO5=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lQUO5#">,
        lSO=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lSO#">,
        lSAM=<cfqueryparam cfsqltype="cf_sql_char" value="#form.lSAM#">
	</cfquery>
    </cfif>
</cfif>

<cfquery name="getictermandcondition" datasource="#dts#">
	select * 
	from ictermandcondition;
</cfquery>

<cfset lRC = getictermandcondition.lRC>
<cfset lPR = getictermandcondition.lPR>
<cfset lDO = getictermandcondition.lDO>
<cfset lINV = getictermandcondition.lINV>
<cfset lCS = getictermandcondition.lCS>
<cfset lCN = getictermandcondition.lCN>
<cfset lDN = getictermandcondition.lDN>
<cfset lPO = getictermandcondition.lPO>
<cfset lQUO = getictermandcondition.lQUO>
<cfset lQUO2 = getictermandcondition.lQUO2>
<cfset lQUO3 = getictermandcondition.lQUO3>
<cfset lQUO4 = getictermandcondition.lQUO4>
<cfset lQUO5 = getictermandcondition.lQUO5>
<cfset lSO = getictermandcondition.lSO>
<cfset lSAM = getictermandcondition.lSAM>

<body>

<h1>Terms and Condition Maintenance </h1>
<cfoutput>
<cfform action="termsandconditiontable.cfm?type=save" method="post">
	<table width="500" align="center" class="data" cellspacing="0">
		<tr> 
      		<td colspan="2"><div align="center"><strong>Maintenance</strong></div></td>
    	</tr>
        <tr> 
		  	<th>Purchase Receive</th>
		  	<td><cftextarea name="lRC" id="lRC" cols="160" rows="5">#convertquote(lRC)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Purchase Return</th>
		  	<td><cftextarea name="lPR" id="lPR" cols="160" rows="5">#convertquote(lPR)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Delivery Order</th>
		  	<td><cftextarea name="lDO" id="lDO" cols="160" rows="5">#convertquote(lDO)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Invoice</th>
		  	<td><cftextarea name="lINV" id="lINV" cols="160" rows="5">#convertquote(lINV)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Cash Sales</th>
		  	<td><cftextarea name="lCS" id="lCS" cols="160" rows="5">#convertquote(lCS)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Credit Note</th>
		  	<td><cftextarea name="lCN" id="lCN" cols="160" rows="5">#convertquote(lCN)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Debit Note</th>
		  	<td><cftextarea name="lDN" id="lDN" cols="160" rows="5">#convertquote(lDN)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Purchase Order</th>
		  	<td><cftextarea name="lPO" id="lPO" cols="160" rows="5">#convertquote(lPO)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Quotation</th>
		  	<td><cftextarea name="lQUO" id="lQUO" cols="160" rows="5">#convertquote(lQUO)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Quotation 2</th>
		  	<td><cftextarea name="lQUO2" id="lQUO2" cols="160" rows="5">#convertquote(lQUO2)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Quotation 3</th>
		  	<td><cftextarea name="lQUO3" id="lQUO3" cols="160" rows="5">#convertquote(lQUO3)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Quotation 4</th>
		  	<td><cftextarea name="lQUO4" id="lQUO4" cols="160" rows="5">#convertquote(lQUO4)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Quotation 5</th>
		  	<td><cftextarea name="lQUO5" id="lQUO5" cols="160" rows="5">#convertquote(lQUO5)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Sales Order</th>
		  	<td><cftextarea name="lSO" id="lSO" cols="160" rows="5">#convertquote(lSO)#</cftextarea></td>
		</tr>
        <tr> 
		  	<th>Sample</th>
		  	<td><cftextarea name="lSAM" id="lSAM" cols="160" rows="5">#convertquote(lSAM)#</cftextarea></td>
		</tr>

		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>
</cfoutput>
</body>
</html>