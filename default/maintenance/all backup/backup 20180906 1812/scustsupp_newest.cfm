<html >
<head>
<cfoutput>
<title>Search #type#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getdealermenu" datasource="#dts#">
select * from dealer_menu
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
select agentlistuserid,lagent,oldcustsupp,locarap from gsetup
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>


<cfset target_table = iif(type eq "customer",DE(target_arcust),DE(target_apvend))>

<cfquery name="getrecordcount" datasource="#dts#">
	select count(custno) as totalrecord 
	from #target_table# where 0=0
	
    <cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or agent in (SELECT agent FROM #target_icagent# WHERE agentid = "#ucase(huserid)#"))  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                    <cfelse>
					<cfif Huserloc neq "All_loc" and getgeneral.locarap eq "Y">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
</cfquery>

<body>

<cfif getrecordcount.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		<cfif getrecordcount.recordcount mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
 	</cfif>
	
	<cfform action="/default/maintenance/scustsupp_newest.cfm?type=#urlencodedformat(type)#" method="post" target="_self">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif isdefined("url.start")>
			<cfset start = url.start>
		</cfif>
		
		<cfif isdefined("form.skeypage")>
			<cfset start = form.skeypage * 20 + 1 - 20>
			<cfif form.skeypage eq "1">
				<cfset start = "1">
			</cfif>
		</cfif>

		<cfset prevTwenty = start -20>
		<cfset nextTwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfif lcase(HcomID) eq "topsteel_i">
			<cfquery datasource='#dts#' name="getjob">
				select a.*,b.desp as businessdesp
				from #target_table# as a
				
				left join business as b on a.business=b.business
                where 0=0
				
                <cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or agent in (SELECT agent FROM #target_icagent# WHERE agentid = "#ucase(huserid)#"))  
					</cfif>
					<cfelse><cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                    
                    <cfelse>
					<cfif Huserloc neq "All_loc" and getgeneral.locarap eq "Y">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
				order by <!---created_on desc,date desc --->#getdealermenu.custSuppSortBy#
				limit #start-1#,20;
			</cfquery>
		<cfelse>
			<cfquery datasource='#dts#' name="getjob">
				select *
				from #target_table# where 0=0
				
                <cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or agent in (SELECT agent FROM #target_icagent# WHERE agentid = "#ucase(huserid)#"))  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                    
                    <cfelse>
					<cfif Huserloc neq "All_loc" and getgeneral.locarap eq "Y">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
				order by <!---created_on desc,date desc --->#getdealermenu.custSuppSortBy#
				limit #start-1#,20;
			</cfquery>
		</cfif>
		<!--- <cfquery datasource='#dts#' name="getjob">
			select *
			from #target_table# 
			<cfif type eq "Customer" and getpin2.h1250 eq 'T'>
			where agent = '#huserid#'
			</cfif>
			order by date desc 
			limit #start-1#,20;
		</cfquery> --->

		<cfif start neq 1>
			|| <a target="_self" href="/default/maintenance/scustsupp_newest.cfm?type=#type#&start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="/default/maintenance/scustsupp_newest.cfm?type=#type#&start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>

		<table align="center" class="data"  >
			<tr>
				<th>No.</th>
                <cfif getdisplaysetup.cust_agent eq 'Y'>
				<cfif lcase(HcomID) neq "topsteel_i"><th>#getgeneral.lagent#</th></cfif>
                </cfif>
                <cfif getdisplaysetup.cust_custno eq 'Y'>
				<th>ID</th>
                </cfif>
                <cfif getdisplaysetup.cust_name eq 'Y'>
				<th>Name</th>
                </cfif>
                <cfif getdisplaysetup.cust_add eq 'Y'>
				<th>Address</th>
                </cfif>
                <cfif getdisplaysetup.cust_tel eq 'Y'>
				<th>Telephone</th>
                </cfif>
                <cfif getdisplaysetup.cust_fax eq 'Y'>
				<th>Fax</th>
                </cfif>
                <cfif getdisplaysetup.cust_attn eq 'Y'>
				<th><cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i">I.C no.<cfelse>Attention</cfif></th>
                </cfif>
                <cfif getdisplaysetup.cust_driver eq 'Y'>
                <th>End User</th>
				</cfif>
                <cfif getdisplaysetup.cust_currcode eq 'Y'>
                <th>Currcode</th>
				</cfif>
                <cfif getdisplaysetup.cust_contact eq 'Y'>
                <th>Contact</th>
				</cfif>
                <cfif getdisplaysetup.cust_term eq 'Y'>
                <th>Term</th>
				</cfif>
                <cfif getdisplaysetup.cust_area eq 'Y'>
                <th>Area</th>
				</cfif>
                <cfif getdisplaysetup.cust_business eq 'Y'>
                <th>Business</th>
				</cfif>
                <cfif getdisplaysetup.cust_createdate eq 'Y'>
                <th>Created Date</th>
				</cfif>
				<cfif type eq "Customer" and getpin2.h1211 eq "T">
					<th>Action</th>
				<cfelseif type eq "Supplier" and getpin2.h1111 eq 'T'>
					<th>Action</th>
				</cfif>
			</tr>
				
			<cfloop query="getjob">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif (url.type eq "Customer" and getpin2.h1211 eq "T") or (url.type eq "Supplier" and getpin2.h1111 eq 'T')>ondblclick="javascript:window.parent.location.href('#url.type#.cfm?type=Edit&custno=#URLEncodedFormat(custno)#');"</cfif>>
					<td nowrap>#getjob.currentrow#</td>
                    <cfif getdisplaysetup.cust_agent eq 'Y'>
					<cfif lcase(HcomID) neq "topsteel_i"><td nowrap>#getjob.agent#</td></cfif>
                    </cfif>
                    <cfif getdisplaysetup.cust_custno eq 'Y'>
           			<td nowrap>#getjob.custno#</td>
                    </cfif>
                    <cfif getdisplaysetup.cust_name eq 'Y'>
					<td nowrap>#getjob.Name#
                    <br>#getjob.Name2#
                    
						<cfif lcase(HcomID) eq "ge_i" or lcase(HcomID) eq "saehan_i" or lcase(HcomID) eq "idi_i" or lcase(HcomID) eq "gwa_i">
							<cfif getjob.web_site neq "">
								<cfif findnocase("http://",getjob.web_site) eq 0>
									<cfset getjob.web_site = "http://"&getjob.web_site>
								</cfif>
								<br><a href="#getjob.web_site#" target="_blank">#getjob.web_site#</a>
							</cfif>
                            </cfif>
						<cfelseif lcase(HcomID) eq "topsteel_i">
							<cfif getjob.businessdesp neq "">
								<br>(#getjob.businessdesp#)
							</cfif>
						</cfif>
					</td>
                    <cfif getdisplaysetup.cust_add eq 'Y'>
					<td nowrap>#getjob.Add1#<br>#getjob.Add2#<br>#getjob.Add3#<br>#getjob.Add4#</td>
                    </cfif>
                    <cfif getdisplaysetup.cust_tel eq 'Y'>
					<td nowrap>(1) #getjob.Phone#<br>(2) #getjob.phonea#</td></cfif>
                    <cfif getdisplaysetup.cust_fax eq 'Y'>
					<td nowrap>#getjob.fax#</td>
                    </cfif>
                    <cfif getdisplaysetup.cust_attn eq 'Y'>
					<td nowrap>#getjob.attn#<br/><font style="background-color:FFFFFF">#getjob.e_mail#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.cust_driver eq 'Y'>
					<td nowrap>#getjob.end_user#</td>
                    </cfif>
                    <cfif getdisplaysetup.cust_currcode eq 'Y'>
                <td nowrap>#getjob.currcode#</td>
				</cfif>
                <cfif getdisplaysetup.cust_contact eq 'Y'>
                <td nowrap>#getjob.contact#</td>
				</cfif>
                <cfif getdisplaysetup.cust_term eq 'Y'>
                <td nowrap>#getjob.term#</td>
				</cfif>
                <cfif getdisplaysetup.cust_area eq 'Y'>
                <td nowrap>#getjob.area#</td>
				</cfif>
                <cfif getdisplaysetup.cust_business eq 'Y'>
                <td nowrap>#getjob.business#</td>
				</cfif>
                <cfif getdisplaysetup.cust_createdate eq 'Y'>
                <td nowrap>#getjob.created_on#</td>
				</cfif>
           			<td nowrap>
						<cfif url.type eq "Customer" and getpin2.h1211 eq "T">
                        <cfif getgeneral.oldcustsupp eq 'Y'>
                        <div align="center">
								<a href="old#url.type#.cfm?type=Delete&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
								<a href="old#url.type#.cfm?type=Edit&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
							</div>
                        <cfelse>
							<div align="center">
								<a href="/default/maintenance/#url.type#.cfm?type=Delete&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
								<a href="/default/maintenance/#url.type#.cfm?type=Edit&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
							</div>
                        </cfif>
						<cfelseif url.type eq "Supplier" and getpin2.h1111 eq 'T'>
                        <cfif getgeneral.oldcustsupp eq 'Y'>
                        	<div align="center">
								<a href="old#url.type#.cfm?type=Delete&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
								<a href="old#url.type#.cfm?type=Edit&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
							</div>
                        <cfelse>
							<div align="center">
								<a href="/default/maintenance/#url.type#.cfm?type=Delete&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
								<a href="/default/maintenance/#url.type#.cfm?type=Edit&custno=#URLEncodedFormat(custno)#" target="_parent"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
							</div>
                        </cfif>

						</cfif>
					</td>
				</tr>
			</cfloop>
		</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
			<a target="_self" href="/default/maintenance/scustsupp_newest.cfm?type=#type#&start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="/default/maintenance/scustsupp_newest.cfm?type=#type#&start=#nextTwenty#">Next</a> ||
		</cfif>
		
		Page #page# Of #noOfPage#
		</div>
	</cfform>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>
</cfoutput> 

</body>
</html>