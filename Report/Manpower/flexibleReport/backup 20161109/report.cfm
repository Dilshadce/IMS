<cfset dts_p = replace(dts,'_i','_p')>
<cfset filterlist = "Customer,Employee,Pay Period,Placement No,Assignment No,Contract Signed Date,Contract Start Date,Contract End Date,Consultant,Project,Job Code,User ID">

<cfquery name="getReport" datasource="#dts#">
	select * 
    from flexireport
    where id = "#url.reportid#"
</cfquery>

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>#getReport.reporttitle#</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getColumn" datasource="#dts#">
	select * 
    from selcolumn a 
    left join avacolumn b on a.column = b.column
    where a.uuid = "#getReport.uuid#"
    order by a.position*1
</cfquery>

<cfset exceptionColumn = "Employee Total Monthly Billable Amount,Employer Total Monthly Billable Amount,Employer Total Reimbursement,Employer Total Deduction,Employee Total Reimbursement,Employee Total Deduction">

<cfif getColumn.recordcount gt 0 and (getreport.fcustomer eq 'y' or getreport.fplacement eq 'y' or getreport.fassignment eq 'y' or getreport.finvoice eq 'y' or getreport.femployee eq 'y')>
	<cfset table = "">
    <cfset condition = "WHERE 1=1 ">
    <cfset sorting = "ORDER BY ">
	<cfset realgroupby = "">
    
    <!---table--->
    <cfif getreport.fassignment eq 'y'>
    	<cfset table = table & " assignmentslip c">
    </cfif>
    <cfif getreport.finvoice eq 'y' and getreport.fassignment eq 'y'>
    	<cfset table = table & " left join"> 
    </cfif>
    <cfif getreport.finvoice eq 'y'>
    	<cfset table = table & " artran d">
    </cfif>          
    <cfif getreport.finvoice eq 'y' and getreport.fassignment eq 'y'>
    	<cfset table = table & " on c.refno = d.refno"> 
    </cfif>         
    <cfif getreport.fassignment eq 'y' and getreport.fplacement eq 'y'>
    	<cfset table = table & " left join"> 
    </cfif>       		 
    <cfif getreport.fplacement eq 'y'>
    	<cfset table = table & " placement b">
    </cfif>            
    <cfif getreport.fplacement eq 'y' and getreport.fassignment eq 'y'>
    	<cfset table = table & " on b.placementno = c.placementno">
    </cfif>
    <cfif (getreport.fassignment eq 'y' or getreport.fplacement eq 'y') and getreport.fcustomer eq 'y'>
    	<cfset table = table & " left join"> 
    </cfif>
    <cfif getreport.fcustomer eq 'y'>
    	<cfset table = table & " #target_arcust# a">
    </cfif>          
    <cfif getreport.fcustomer eq 'y' and getreport.fassignment eq 'y'>
    	<cfset table = table & " on c.custno = a.custno"> 
    <cfelseif getreport.fcustomer eq 'y' and getreport.fplacement eq 'y'>
    	<cfset table = table & " on b.custno = a.custno">  
    </cfif>            
    <cfif (getreport.fassignment eq 'y' or getreport.fplacement eq 'y') and getreport.femployee eq 'y'>
    	<cfset table = table & " left join"> 
    </cfif>
    <cfif getreport.femployee eq 'y'>
    	<cfset table = table & " #dts_p#.pmast e">
    </cfif>          
    <cfif getreport.femployee eq 'y' and getreport.fassignment eq 'y'>
    	<cfset table = table & " on c.empno = e.empno"> 
    <cfelseif getreport.femployee eq 'y' and getreport.fplacement eq 'y'>
    	<cfset table = table & " on b.empno = e.empno">  
    </cfif>
    
    <!---condition--->
    <cfloop list="#filterlist#" delimiters="," index="i">
    	<cfif i eq "Customer">
        	<cfif getreport.fassignment eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and c.custno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>
            <cfelseif getreport.fplacement eq 'y'>
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.custno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>
            <cfelseif getreport.fcustomer eq 'y'>
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and a.custno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>  
            </cfif>
        <cfelseif i eq "Employee">
        	<cfif getreport.fassignment eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and c.empno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>
            <cfelseif getreport.fplacement eq 'y'>
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.empno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>
            <cfelseif getreport.femployee eq 'y'>
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and e.empno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif>  
            </cfif>
    	<cfelseif i eq 'Pay Period'>
			<cfif getreport.fassignment eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and c.paydate between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.fr#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>
        <cfelseif i eq "Placement No">
        	<cfif getreport.fassignment eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and c.placementno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif> 
        	<cfelseif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.placementno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>
        <cfelseif i eq "Assignment No">
        	<cfif getreport.fassignment eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and c.refno between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.fr#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>        
        <cfelseif i eq "Contract Signed Date">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset datefr = listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 1, "/")>
                    
                    <cfset dateto = listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 1, "/")>
                
					<cfset condition = condition & "and b.placementdate between '#datefr#' and '#dateto#'">
                </cfif> 
            </cfif>
		<cfelseif i eq "Contract Start Date">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset datefr = listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 1, "/")>
                    
                    <cfset dateto = listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 1, "/")>
                
					<cfset condition = condition & "and b.startdate between '#datefr#' and '#dateto#'">
                </cfif> 
            </cfif>
        <cfelseif i eq "Contract End Date">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset datefr = listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset datefr = datefr & "-" &  listgetat(evaluate("form.fr#replace(i, ' ', '_','all')#"), 1, "/")>
                    
                    <cfset dateto = listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 3, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 2, "/")>
                    <cfset dateto = dateto & "-" &  listgetat(evaluate("form.to#replace(i, ' ', '_','all')#"), 1, "/")>
                
					<cfset condition = condition & "and b.completedate between '#datefr#' and '#dateto#'">
                </cfif> 
            </cfif>
        <cfelseif  i eq "Consultant">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.consultant between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>
        <cfelseif  i eq "Job Code">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.jobcode between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>
		<cfelseif i eq "Job Code">
        	<cfif getreport.fplacement eq 'y'>       	
            	<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
					<cfset condition = condition & " and b.jobcode between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
                </cfif> 
            </cfif>
        <cfelseif i eq "User ID">
			<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
            	<cfif getreport.fassignment eq 'y'>
                	<cfset field = "c.created_by">
                <cfelseif getreport.fplacement eq 'y'>
                	<cfset field = "b.created_by">
                <cfelseif getreport.fcustomer eq 'y'>
                	<cfset field = "a.created_by">
                <cfelseif getreport.employee eq 'y'>
                	<cfset field = "e.created_by">
                </cfif>
				
                <cfset condition = condition & " and #field# between '#evaluate('form.fr#replace(i, ' ', '_','all')#')#' and '#evaluate('form.to#replace(i, ' ', '_','all')#')#'">
            </cfif>
        </cfif> 
    </cfloop>
    
    <!---sorting--->
    <cfif getreport.sort1 neq "">
    	<cfquery name="getrealcolumn" datasource="#dts#">
        	select realcolumn from avacolumn where `column` = "#getreport.sort1#"
        </cfquery>
        
    	<cfset sorting = sorting & "#getrealcolumn.realcolumn# #getreport.sortby#">
        
        <cfif getreport.sort2 neq "">
            <cfquery name="getrealcolumn" datasource="#dts#">
                select realcolumn from avacolumn where `column` = "#getreport.sort2#"
            </cfquery>
            
            <cfset sorting = sorting & ", #getrealcolumn.realcolumn# #getreport.sortby#">
        </cfif>
    <cfelse> 
    	<cfset sorting = sorting & "#getcolumn.realcolumn[1]# #getreport.sortby#">
    </cfif>
    
    <!---groupby--->
	<cfif getreport.groupby neq ''>   	
    	<cfif getreport.groupby eq 'Customer'> 
			<cfif getreport.fassignment eq 'y'>
                <cfset realgroupby = "c.custno">
            <cfelseif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.custno">
            <cfelseif getreport.fcustomer eq 'y'>
                <cfset realgroupby = "a.custno">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'Employee'>
            <cfif getreport.fassignment eq 'y'>
                <cfset realgroupby = "c.empno">
            <cfelseif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.empno">
            <cfelseif getreport.femployee eq 'y'>
                <cfset realgroupby = "e.empno">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'User'>
            <cfif getreport.fassignment eq 'y'>
                <cfset realgroupby = "c.created_by">
            <cfelseif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.created_by">
            <cfelseif getreport.fcustomer eq 'y'>
                <cfset realgroupby = "a.created_by">
            <cfelseif getreport.femployee eq 'y'>
                <cfset realgroupby = "e.created_by">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'Project'>
            <cfif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.source">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'Pay Period'>
            <cfif getreport.fassignment eq 'y'>
                <cfset realgroupby = "c.paydate">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'Consultant'>
            <cfif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.consultant">
            </cfif>
        </cfif>
        <cfif getreport.groupby eq 'Location'>
            <cfif getreport.fplacement eq 'y'>
                <cfset realgroupby = "b.location">
            </cfif>
        </cfif>
    
        <cfquery name="getGroup" datasource="#dts#">
            select distinct #realgroupby# 
            from #table#
            #replace(condition, "''", "'", "all")#
            #sorting#               
        </cfquery>
    </cfif>
    
    <cfset dbtype = "">
</cfif>

<body>
<p align="center"><font color="##000000" size="4" face="Times New Roman, Times, serif"><strong>#getreport.reporttitle#</strong></font></p>
<table width="90%" border="0" align="center">
    <cfloop list="#filterlist#" delimiters="," index="i">
		<cfif isdefined("form.fr#replace(i, ' ', '_', 'all')#") and evaluate("form.fr#replace(i, ' ', '_','all')#") neq "" and evaluate("form.to#replace(i, ' ', '_','all')#") neq "">
        	<tr>
                <td colspan="100%"><div align="center">#i# From #evaluate("form.fr#replace(i, ' ', '_','all')#")# To #evaluate("form.to#replace(i, ' ', '_','all')#")#</div></td>
            </tr>
        </cfif>
    </cfloop>
    <tr>
    	<td colspan="100%"><div align="right">#dateformat(now(), 'dd/mm/yyyy')#</div></td>
    </tr>
 	<cfif getColumn.recordcount gt 0 and (getreport.fcustomer eq 'y' or getreport.fplacement eq 'y' or getreport.fassignment eq 'y' or getreport.finvoice eq 'y' or getreport.femployee eq 'y')>
		<tr>
            <td colspan="100%"><hr /></td>
        </tr>    
        <tr>
            <cfloop query="getColumn">
            	<cfif listcontains(exceptionColumn, getColumn.column, ',') neq 0>
					<cfset getdbtype.type = "double(17,7)">
                <cfelse>
                    <cfquery name = "getdbtype" datasource="#dts#">
                        show columns from <cfif listgetat(getcolumn.realcolumn, 1, '.') eq 'a'>
                                              #target_arcust#
                                          <cfelseif listgetat(getcolumn.realcolumn, 1, '.') eq 'b'>
                                              placement
                                          <cfelseif listgetat(getcolumn.realcolumn, 1, '.') eq 'c'>
                                              assignmentslip
                                          <cfelseif listgetat(getcolumn.realcolumn, 1, '.') eq 'd'>
                                              artran
                                          <cfelseif listgetat(getcolumn.realcolumn, 1, '.') eq 'e'>
                                              #dts_p#.pmast
                                          </cfif>
                        where field = "#listgetat(getcolumn.realcolumn, 2, '.')#"                                                
                    </cfquery>
                </cfif>
                
                          
                <cfset temp2 =Rereplace(Rereplace(getColumn.column, '[&\(\)]', '0', 'ALL'), '/','0','ALL')>
                <cfset var = replace(temp2,' ','0','all')>
                <cfset "grandtotal_#var#" = "">
                <cfset "grouptotal_#var#" = "">
                <cfif getcolumn.currentrow eq 1>
                	<cfset dbtype = "#getdbtype.type#">
                <cfelse>
                	<cfset dbtype = dbtype & ";#getdbtype.type#">   
                </cfif>
                <cfif find("double", listgetat(dbtype, getcolumn.currentrow, ";")) neq 0 
				or find("integer", listgetat(dbtype, getcolumn.currentrow, ";")) neq 0 
				or findnocase("Date", getcolumn.column) neq 0 
				or findnocase("Age", getcolumn.column) neq 0>
                    <td width="#100#"><div align="right">#getcolumn.column#</div></td>
                <cfelse>
                    <td>#getcolumn.column#</td>
                </cfif>
            </cfloop>
        </tr>
        <tr>
            <td colspan="100%"><hr /></td>
        </tr>   
        <cfif getreport.groupby neq ''>
        	<cfloop query="getgroup">
            	<cfloop query="getColumn">
                    <cfset temp2 =Rereplace(Rereplace(getColumn.column, '[&\(\)]', '0', 'ALL'), '/','0','ALL')>
					<cfset var = replace(temp2,' ','0','all')>
                    <cfset "grandtotal_#var#" = "">
                </cfloop>                
                <tr>
                    <td colspan="100%">
                    	<strong>
                        	<u> 
                            	<cfset groupbydisplay = evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')>
                                                                                                    
                     			<cfif getreport.groupby eq 'Customer'> 					
                                	<cfquery name="getcustname" datasource="#dts#">
                                    	select name from #target_arcust# where custno = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                                    </cfquery>
                                    	
                                    <cfset groupbydisplay = groupbydisplay & " - #getcustname.name#">                     
                                </cfif>
                                <cfif getreport.groupby eq 'Employee'>
                                	<cfquery name="getempname" datasource="#dts#">
                                    	select empname from #dts_p#.pmast where empno = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                                    </cfquery>
                                                      
                                    <cfset groupbydisplay = groupbydisplay & " - #getempname.empname#">                             	
                                </cfif>
                                <cfif getreport.groupby eq 'Project'>
                                    <cfquery name="getproject" datasource="#dts#">
                                    	select project from #target_project# where source = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                                    </cfquery>
                                                      
                                    <cfset groupbydisplay = groupbydisplay & " - #getproject.project#">
                                </cfif>
                                <cfif getreport.groupby eq 'Pay Period'>
                                    <cfif evaluate('getgroup.#listgetat(realgroupby, 2, '.')#') eq 'paytra1'>
                                    	<cfset groupbydisplay = groupbydisplay & " - 1st Pay Day">
                                    <cfelseif evaluate('getgroup.#listgetat(realgroupby, 2, '.')#') eq 'paytran'>
                                    	<cfset groupbydisplay = groupbydisplay & " - 2nd Pay Day">
                                    </cfif>
                                </cfif>
                                <cfif getreport.groupby eq 'Consultant'>
                                    <cfquery name="getconsult" datasource="#dts#">
                                    	select agent, desp from #target_icagent# where agent = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                                    </cfquery>
                                    
                                    <cfset groupbydisplay = groupbydisplay & " - #getconsult.desp#">
                                </cfif>
                                <cfif getreport.groupby eq 'Location'>
                                    <cfquery name="getLoc" datasource="#dts#">
                                    	select area, desp from #target_icarea# where area = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                                    </cfquery>
                                    
                                    <cfset groupbydisplay = groupbydisplay & " - #getLoc.desp#">
                                </cfif>
                                
                                #ucase(groupbydisplay)#                                                                       
                            </u>
                        </strong>
                    </td>
                </tr>								
                <cfquery name="getdata" datasource="#dts#">
                	select <cfloop query="getColumn">#getcolumn.realcolumn#<cfif getColumn.currentrow neq getColumn.recordcount>, </cfif></cfloop>
                	from #table#
                    #replace(condition, "''", "'", "all")# and #realgroupby# = "#evaluate('getgroup.#listgetat(realgroupby, 2, '.')#')#"
                    #sorting#
                </cfquery>
                				
                <cfloop query="getdata">
                    <tr>
                    	<cfset count = 1>
                        <cfloop query="getcolumn">
                        	<cfif listcontains(exceptionColumn, getColumn.column, ',') neq 0>			
                                <cfset temp  = listgetat(getColumn.realcolumn, listlen(getColumn.realcolumn, ' '), ' ')>                     
                            <cfelse>
                                <cfset temp = "#listgetat(getcolumn.realcolumn, 2, '.')#">
                            </cfif>
                                                                                                                                                              
                            <cfif isDate("#(evaluate('getdata.#temp#'))#")>
                                <cfif getcolumn.column eq 'Age'>
									<cfset age = datediff('yyyy', "#(evaluate('getdata.#temp#'))#", now())>
                                    <td><div align="right">#age#</div></td> 
                                <cfelse>             
                                    <td><div align="right">#dateformat(evaluate('getdata.#temp#'), 'dd/mm/yyyy')#</div></td>
                                </cfif>
                            <cfelseif find("double", listgetat(dbtype, count, ';')) neq 0 or find("integer", listgetat(dbtype, count, ';')) neq 0>
                                <td><div align="right">#numberformat(evaluate('getdata.#temp#'), ',.__')#</div></td>
                                
                                <cfset "grouptotal_#replace(getColumn.column, ' ', '_', 'all')#" = val(evaluate("grouptotal_#replace(getColumn.column, ' ', '_', 'all')#")) + numberformat(val(evaluate('getdata.#temp#')), '.__')>
                                <cfset "grandtotal_#replace(getColumn.column, ' ', '_', 'all')#" = val(evaluate("grandtotal_#replace(getColumn.column, ' ', '_', 'all')#")) + numberformat(val(evaluate('getdata.#temp#')), '.__')>
                            <cfelse>
                                <td>#ucase(evaluate('getdata.#temp#'))#</td>
                            </cfif>
                            
                            <cfset count += 1>                            
                        </cfloop>
                    </tr>
                </cfloop>
                
                <tr>
                    <td colspan="100%"><hr /></td>
                </tr>
                <tr>
                	<cfloop query="getcolumn"> 
                    	<cfif isnumeric(evaluate("grouptotal_#replace(getColumn.column, ' ', '_', 'all')#"))>
                            <td><div align="right">#numberformat(evaluate("grouptotal_#replace(replace(trim(getColumn.column),'&','and'), ' ', '_', 'all')#"), ',.__')#</div></td>
                        <cfelse>
                            <td>#evaluate("grouptotal_#replace(replace(trim(getColumn.column),'&','and'), ' ', '_', 'all')#")#</td>
                        </cfif> 
                    </cfloop>
                </tr>
                <tr>
                    <td colspan="100%"><br /></td>
                </tr>             
        	</cfloop>
            <tr>
                <td colspan="100%"><br /></td>
            </tr> 
            <tr>
                <td colspan="100%"><br /></td>
            </tr> 
        <cfelse>
        	<cfquery name="getdata" datasource="#dts#">
                select <cfloop query="getColumn">#getcolumn.realcolumn#<cfif getColumn.currentrow neq getColumn.recordcount>, </cfif></cfloop>
                from #table#
                #replace(condition, "''", "'", "all")#
                <cfif listcontains(exceptionColumn, getColumn.column, ',') eq 0>
                #sorting#
                </cfif>
            </cfquery>
                            
            <cfloop query="getdata">
                <tr>
                    <cfset count = 1>
                    <cfloop query="getcolumn">
                    	<cfif listcontains(exceptionColumn, getColumn.column, ',') neq 0>
                            <cfset temp  = listgetat(getColumn.realcolumn, listlen(getColumn.realcolumn, ' '), ' ')>
                        <cfelse>
                            <cfset temp = "#listgetat(getcolumn.realcolumn, 2, '.')#">
                        </cfif>               
                                                                             
                        <cfif isDate("#(evaluate('getdata.#temp#'))#")>
                        	<cfif getcolumn.column eq 'Age'>
                            	<cfset age = datediff('yyyy', "#(evaluate('getdata.#temp#'))#", now())>
                                <td><div align="right">#age#</div></td> 
                            <cfelse>             
                            	<td><div align="right">#dateformat(evaluate('getdata.#temp#'), 'dd/mm/yyyy')#</div></td>
                            </cfif>
                        <cfelseif find("double", listgetat(dbtype, count, ';')) neq 0 or find("integer", listgetat(dbtype, count, ';')) neq 0>                  
                            <td><div align="right">#numberformat(evaluate('getdata.#temp#'), ',.__')#</div></td>
                           <cfset temp2 =Rereplace(Rereplace(getColumn.column, '[&\(\)]', '0', 'ALL'), '/','0','ALL')>
							<cfset var = replace(temp2,' ','0','all')>
                            <cfset "grandtotal_#var#" = "">
                            <cfset "grouptotal_#var#" = "">
                            <cfset "grouptotal_#var#" = val(evaluate("grouptotal_#var#")) + numberformat(val(evaluate('getdata.#temp#')), '.__')>
                            <cfset "grandtotal_#var#" = val(evaluate("grandtotal_#var#")) + numberformat(val(evaluate('getdata.#temp#')), '.__')>
                        <cfelse>
                            <td>#ucase(evaluate('getdata.#temp#'))#</td>
                        </cfif>
                        
                        <cfset count += 1>                            
                    </cfloop>
                </tr>
            </cfloop>       	
        </cfif>
     
        <tr>
            <td colspan="100%"><hr /></td>
        </tr>
        <tr>
            <cfloop query="getcolumn"> 
            		<cfset temp2 =Rereplace(Rereplace(getColumn.column, '[&\(\)]', '0', 'ALL'), '/','0','ALL')>
							<cfset var = replace(temp2,' ','0','all')>
                <cfif isnumeric(evaluate("grandtotal_#var#"))>
                    <td><div align="right">#numberformat(evaluate("grandtotal_#var#"), ',.__')#</div></td>
                <cfelse>
                    <td>#evaluate("grandtotal_#var#")#</td>
                </cfif> 
            </cfloop>
        </tr>
        <tr>
            <td colspan="100%"><hr /></td>
        </tr>       
    <cfelse>
    </cfif>
</table>
</body>
</html>
</cfoutput>