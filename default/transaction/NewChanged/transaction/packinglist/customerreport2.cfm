<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfquery name="getdrivername" datasource="#dts#">
	SELECT * FROM driver
</cfquery>

<cfparam name="i" default="1" type="numeric">

<cfquery name="getdeliveredorder" datasource="#dts#">
select * from (
select * from packlist where
(delivery_on <> "0000-00-00" or delivery_on is not null)
<cfif form.datefrom neq "" and form.dateto neq "">
 and delivery_on between '#dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'YYYY-MM-DD')#' and '#dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'YYYY-MM-DD')#'
  </cfif>
    <cfif form.groupfrom neq "" and form.groupto neq "">
	and packid between '#form.groupfrom#' and  '#form.groupto#'
  </cfif>
    <cfif form.groupfrom2 neq "" and form.groupto2 neq "">
	and driver between '#form.groupfrom2#' and '#form.groupto2#'
  </cfif>
 
) as a
left join
(select * from packlistbill) as b
on a.packid=b.packid
<cfif form.custfrom neq "" and form.custto neq "">
	and b.billrefno in (select refno from artran where custno between '#form.custfrom#' and '#form.custto#')
  </cfif>

order by delivery_on
</cfquery>  
		<html>
		<head>
		<title>Driver Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<body>

		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<cfoutput>
            <tr>
				<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> Delivery Report</strong></font></div></td>
			</tr>
            <cfif form.groupfrom neq "" and form.groupto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Pack No #form.groupfrom# - #form.groupto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.custfrom neq "" and form.custto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Customer No #form.custfrom# - #form.custto#</font></div></td>
				</tr>
			</cfif>
				<cfif form.groupfrom2 neq "" and form.groupto2 neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Driver No #form.groupfrom2# - #form.groupto2#</font></div></td>
				</tr>
			</cfif>
                
				<tr>

        
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			  <td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
            			</cfoutput>
</table>

  <cfif #getdeliveredorder.recordCount# neq 0>
    <cfif isdefined("form.skeypage")>
      <cfset noOfPage=round(#getPersonal.recordcount#/20)>
      <cfif #getPersonal.recordcount# mod 20 LT 20 and #getDeliveryAdd.recordcount# mod 20 neq 0>
        <cfset noOfPage=#noOfPage#+1>
      </cfif>
      <cfif form.skeypage gt noofpage OR form.skeypage lt 1>
        <cfabort>
      </cfif>
    </cfif>

    <table width="100%" border="0" class="" align="center">
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      </table>

          <table width="100%" BORDER=0 class="" align="center" >
      <tr>
        <td align="center" width="2%"><strong><font size="2" face="Arial, Helvetica, sans-serif">No</font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Pack No</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer No</cfoutput></font></strong></td>
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif"><cfoutput>Customer Name</cfoutput></font></strong></td>                            
        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Bill No </font></strong></td>


        <td><strong><font size="2" face="Arial, Helvetica, sans-serif">Bill Date</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Driver No</font></strong></td>
<td><strong><font size="2" face="Arial, Helvetica, sans-serif">Delivery On</font></strong></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
          
  <cfoutput query="getdeliveredorder">
  
  <cfquery name="getname" dbtype="query">
  SELECT name FROM getdrivername WHERE driverno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeliveredorder.driver#">
  </cfquery>
  <cfset drivername = getname.name>
  
  <cfquery name="getDeliveryAdd" datasource="#dts#">
  select a.type,a.custno,a.refno,a.wos_date,a.van,a.rem1,a.comm0,a.comm1,a.comm2,a.comm3,rem12,b.custno,b.add1,b.add2,b.add3,b.add4,b.phone,b.name,b.name2,b.postalcode,b.country,c.custno,c.add1 as addd1,c.add2 as addd2,c.add3 as addd3,c.add4 as addd4,c.phone as phone1 from artran as a 
  
  left join <cfif Hlinkams eq "Y">#replacenocase(dts,"_i","_a","all")#.</cfif>arcust as b on a.custno=b.custno
  left join address as c on a.custno=c.custno
  where a.type = "#getdeliveredorder.reftype#"
  and a.refno = "#getdeliveredorder.billrefno#"
  </cfquery>
  <cfif isdefined("form.cbdeliver")>
  <cfif getDeliveryAdd.rem1 eq "">
        <tr>
          <td height="32"><div align="left">#i#</div></td>
          <td>#getdeliveredorder.packID#</td>
          <td>#getDeliveryAdd.custno#</td>
          <td>#getDeliveryAdd.name#<br/> #getDeliveryAdd.name2#</td>
          
         
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#getDeliveryAdd.dateformat(wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="15%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#<cfif getdeliveredorder.trip neq ''>  ( #getdeliveredorder.trip# )</cfif></td>

        </tr>
      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
        <cfelseif getDeliveryAdd.rem1 eq "Profile">
          <tr>
          <td><div align="left">#i#</div></td>
          <td>#getdeliveredorder.packID#</td>
          <td>#getDeliveryAdd.custno#</td>
          <td>#getDeliveryAdd.name#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="15%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#<cfif getdeliveredorder.trip neq ''>  ( #getdeliveredorder.trip# )</cfif></td>

        </tr>      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
                <cfelse>
                          <tr>
          <td><div align="left">#i#</div></td>
          <td>#getdeliveredorder.packID#</td>
          <td>#getDeliveryAdd.custno#</td>
          <td>#getDeliveryAdd.name#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="15%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#<cfif getdeliveredorder.trip neq ''>  ( #getdeliveredorder.trip# )</cfif></td>

        </tr>      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
                
        </cfif>

                <cfelse>     
        <tr>
          <td height="32"><div align="left">#i#</div></td>
          <td>#getdeliveredorder.packID#</td>
          <td>#getDeliveryAdd.custno#</td>
          <td>#getDeliveryAdd.name#<br/> #getDeliveryAdd.name2#</td>
            <td>#getDeliveryAdd.refno#</td>
            <td align="center" width="9%">#dateformat(getDeliveryAdd.wos_date,'DD-MM-YYYY')#</td>
<td align="center" width="9%">#getdeliveredorder.driver#-#drivername#</td>
<td align="center" width="15%">#dateformat(getdeliveredorder.delivery_on,"YYYY-MM-DD")#<cfif getdeliveredorder.trip neq ''>  ( #getdeliveredorder.trip# )</cfif></td>

        </tr>
      <tr>
      <td colspan="10"><hr></td>
      </tr>
        <!--- <cfset i = incrementvalue(#i#)> --->
        <cfset i = incrementvalue(#i#)>
      </cfif> 
	  </cfoutput>
    </table>
    <br>
    <div align="right">
      <!---       <cfif #start# neq 1>
        <cfoutput><a href="l_icitem.cfm">Previous</a> ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="l_icitem.cfm">Next</a> ||</cfoutput>
      </cfif> --->
    </div>
    <cfelse>
    <h3><font size="2" face="Arial, Helvetica, sans-serif">No Records were found.</font></h3>
  </cfif>

	
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>

        
		</html>