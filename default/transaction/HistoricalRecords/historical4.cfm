<html>
<head>
<title>Historical Records Bills Order</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>
	
	<cfset dd = dateformat(form.dateto, "DD")>	
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>	
</cfif>

<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr> 
		<td colspan="13"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>List Historical Bills Oder</strong></font></div></td>
	</tr>
	<cfif isdefined("form.periodfrom") and form.periodfrom neq "" and form.periodto neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.billtype") and form.billtype neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">BILL TYPE: #form.billtype# </font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
		<tr> 
      		<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
    	</tr>
	</cfif>
	<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">REF NO: #form.reffrom# - #form.refto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.custfrom") and trim(form.custfrom) neq "" and trim(form.custto) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST: #form.custfrom# - #form.custto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.suppfrom") and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">SUPP: #form.suppfrom# - #form.suppto#</font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.agent") and form.agent neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agent# </font></div></td>
		</tr>
	</cfif>
	<cfif isdefined("form.term") and form.term neq "">
		<tr>
			<td colspan="13"><div align="center"><font size="2" face="Times New Roman, Times, serif">TERM: #form.tERM# </font></div></td>
		</tr>
	</cfif>
	
	<tr> 
		<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PD</font></div></td> 
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">VOID</font></div></td>
	 	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF NO</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUST/SUPP NO</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DEBIT</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">CREDIT</font></div></td>
    </tr>
    <tr> 
    	<td colspan="100%"><hr></td>
    </tr>
		
	<cfif isdefined("form.billtype") and form.billtype neq "">
		<cfset typelist = form.billtype>
		<cfset a = listfind(typelist,"PO")>
		
		<cfif a is 0>
			<cfset dofound = "no">	
		<cfelse>
			<cfset dofound = "yes">
		</cfif>
		
		<cfset temp = listtoarray(typelist)>
		
		<cfif listlen(typelist) neq 1>
			<cfset typelist2 = listsort(typelist,"text","asc")>
			<cfif listlen(typelist2) neq 1>
				<cfset type1st = listfirst(typelist2)>
				<cfset typelist2 = listdeleteat(typelist2,1)>
			</cfif>
		</cfif>
	<cfelse>
		<cfset dofound = "yes">
		<cfset temp = arraynew(1)>
		<cfset temp[1] = "PO">
		<cfset temp[2] = "SO">
		<cfset temp[3] = "QUO">
		<cfset temp[4] = "SAM">
	</cfif>
	
	<cfquery name="getresult" datasource="#dts#">
		<cfswitch expression="#dofound#">
			<cfcase value="no">
				(select wos_date,age,type,refno,custno,debitamt,creditamt,term,fperiod,void,agenno from artran where 
				fperiod between "#form.periodfrom#" and "#form.periodto#" <!---and void = ""--->
				<cfif isdefined("form.billtype")>
					and (<cfif listlen(typelist) eq 1>
								type = "#typelist#"
						<cfelseif listlen(typelist) gt 1>
								type = "#type1st#"
									<cfloop index="a" list="#typelist2#">
											or type = "#a#"
									</cfloop>
						</cfif>)
				</cfif>
			
				<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
					and wos_date between "#ndatefrom#" and "#ndateto#"
				<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
				</cfif>
				<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
					and refno between "#form.reffrom#" and "#form.refto#"
				</cfif>
				<cfif isdefined("form.custfrom") and trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between "#form.custfrom#" and "#form.custto#"
				</cfif>
				<cfif form.terms neq "">
					and term = "#form.terms#"
				</cfif>
				<cfif isdefined("form.agent") and form.agent neq "">
					and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
				</cfif>)
				union
				(select wos_date,age,type,refno,custno,debitamt,creditamt,term,fperiod,void,agenno from artran where 
				 fperiod between "#form.periodfrom#" and "#form.periodto#" <!---and void = ""--->
				<cfif isdefined("form.billtype")>
					and (<cfif listlen(typelist) eq 1>
								type = "#typelist#"
						<cfelseif listlen(typelist) gt 1>
								type = "#type1st#"
									<cfloop index="a" list="#typelist2#">
											or type = "#a#"
									</cfloop>
						</cfif>)
				</cfif>
				
				<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
					and wos_date between "#ndatefrom#" and "#ndateto#"
				<cfelse>
					and wos_date > #getgeneral.lastaccyear#
				</cfif>
				<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
					and refno between "#form.reffrom#" and "#form.refto#"
				</cfif>
				<cfif isdefined("form.suppfrom") and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
					and custno between "#form.suppfrom#" and "#form.suppto#"
				</cfif>
				<cfif form.terms neq "">
					and term = "#form.terms#"
				</cfif>
				<cfif isdefined("form.agent") and form.agent neq "">
					and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
					order by #form.sort#
				</cfif>)
			</cfcase>
			
			<cfcase value="yes">
				(select wos_date,age,type,refno,custno,debitamt,creditamt,term,fperiod,void,agenno from artran where 
				fperiod between "#form.periodfrom#" and "#form.periodto#" and type = "po" and toinv="" <!---and void = ""--->
				
				<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
					and wos_date between "#ndatefrom#" and "#ndateto#"
				<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
				</cfif>
				<cfif isdefined("form.dofrom") and form.dofrom neq "" and form.doto neq "">
					and refno between "#form.dofrom#" and "#form.doto#"
				</cfif>
				<cfif isdefined("form.custfrom") and trim(form.custfrom) neq "" and trim(form.custto) neq "">
					and custno between "#form.custfrom#" and "#form.custto#"
				</cfif>
				<cfif isdefined("form.termfrom") and form.termfrom neq "" and form.termto neq "">
					and term between "#form.termfrom#" and "#form.termto#"
				</cfif>
				<cfif isdefined("form.agent") and form.agent neq "">
					and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
				</cfif>)
				
				<cfif arraylen(temp) gt 1>
					union
					(select wos_date,age,type,refno,custno,debitamt,creditamt,term,fperiod,void,agenno from artran where 
					fperiod between "#form.periodfrom#" and "#form.periodto#" <!---and void = ""--->
					<cfif isdefined("form.billtype")>
						and (<cfloop index="w" from="1" to="#arraylen(temp)#">
								<cfif temp[w] neq "do">
									type="#temp[1]#"
									<cfset location = #temp[1]#>
									<cfbreak>
								</cfif>
							</cfloop>
							<cfloop index="a" from="1" to="#arraylen(temp)#">
								<cfif temp[a] neq "do" and temp[a] neq location>
									or type = "#temp[a]#"
								</cfif>
							</cfloop>)
					</cfif>
					
					<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#ndatefrom#" and "#ndateto#"
					<cfelse>
						and wos_date > #getgeneral.lastaccyear#
					</cfif>
					<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
						and refno between "#form.reffrom#" and "#form.refto#"
					</cfif>
					<cfif isdefined("form.custfrom") and trim(form.custfrom) neq "" and trim(form.custto) neq "">
						and custno between "#form.custfrom#" and "#form.custto#"
					</cfif>
					<cfif form.terms neq "">
                        and term = "#form.terms#"
                    </cfif>
					<cfif isdefined("form.agent") and form.agent neq "">
						and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
					</cfif>)
					union
					(select wos_date,age,type,refno,custno,debitamt,creditamt,term,fperiod,void,agenno from artran where 
					fperiod between "#form.periodfrom#" and "#form.periodto#" <!---and void = ""--->
					<cfif isdefined("form.billtype")>
						and (<cfloop index="w" from="1" to="#arraylen(temp)#">
								<cfif temp[w] neq "do">
									type="#temp[1]#"
									<cfset location = #temp[1]#>
									<cfbreak>
								</cfif>
							</cfloop>
							<cfloop index="a" from="1" to="#arraylen(temp)#">
								<cfif temp[a] neq "do" and temp[a] neq location>
									or type = "#temp[a]#"
								</cfif>
							</cfloop>)
					</cfif>
					
					<cfif isdefined("form.datefrom") and form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#ndatefrom#" and "#ndateto#" 
					<cfelse>
						and wos_date > #getgeneral.lastaccyear#
					</cfif>
					<cfif isdefined("form.reffrom") and form.reffrom neq "" and form.refto neq "">
						and refno between "#form.reffrom#" and "#form.refto#"
					</cfif>
					<cfif isdefined("form.suppfrom") and trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
						and custno between "#form.suppfrom#" and "#form.suppto#"
					</cfif>
					<cfif form.terms neq "">
                        and term = "#form.terms#"
                    </cfif>
					<cfif isdefined("form.agent") and form.agent neq "">
						and agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
					</cfif>)
				</cfif>
			</cfcase>
		</cfswitch>
	</cfquery>
	
	<cfquery dbtype="query" name="getresult2">
		select * from getresult
		<cfif isdefined("form.sort")>
			order by #form.sort#
		</cfif>
	</cfquery>

	<cfset debittotal = 0>
	<cfset credittotal = 0>
	
	<cfloop query="getresult2">
		<tr>
			<cfset debittotal = debittotal + val(getresult2.debitamt)>
			<cfset credittotal = credittotal + val(getresult2.creditamt)>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.fperiod#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getresult2.wos_date,"dd-mm-yyyy")#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.void#</font></div></td>
		 	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.type#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.refno#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getresult2.custno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult2.debitamt,stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getresult2.creditamt,stDecl_UPrice)#</font></div></td>
			</tr>
	</cfloop>
	
	<tr> 
		<td colspan="10"><hr></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(debittotal,",___.__")#</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(credittotal,",___.__")#</strong></font></div></td>
	</tr>
	</table>
</cfoutput>

<cfif getresult.recordcount eq 0>
	<h4 style="color:red">Sorry, No records were found.</h4>
</cfif> 

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>