<html>
<head>
	<title>Maintenance Transfer Limit</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="getitemno" datasource="#dts#">
				select * from icitem order by category,itemno
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
				select * from gsetup
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
				select * from iclocation where location in ('1-WAREHOUSE','1-OFFICE')
</cfquery>

<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getmonthlytransfer" datasource="#dts#">
				select * from monthlytransfer where id='#url.id#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
			<cfset title="Edit Branch">
			<cfset button="Edit">
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
			<cfset title="Delete Branch">
			<cfset button="Delete">
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
			<cfset title="Create Branch">
			<cfset button="Create">
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="monthlytransfertable2.cfm?type=Create">Creating A New Transfer Limit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="monthlytransfertable.cfm">List All Transfer Limit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_monthlytransfer.cfm?type=monthlytransfer">Search For Transfer Limit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_monthlytransfer.cfm">Transfer Limit Listing</a></cfif>
	</h4>

	<cfform name="branchform" action="monthlytransfertableprocess.cfm" method="post">
    	<input type="hidden" name="mode" value="#mode#">
        <cfif mode eq "Delete" or mode eq "Edit">
        <input type="hidden" name="id" id="id" value="#getmonthlytransfer.id#">
        <cfelse>
        <input type="hidden" name="id" id="id" value="">
        </cfif>

		<h1 align="center">Transfer Limit File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Item No :</td>
        		<td colspan="100%">
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="itemno" value="#getmonthlytransfer.itemno#" readonly>
            	<cfelse>
            		<cfselect name="itemno" id="itemno" required="yes" message="Please Choose Item No">
                    <option value="">Choose an item</option>
                    <cfloop query="getitemno">
                    <option value="#getitemno.itemno#">#getitemno.category# - #getitemno.itemno# - #getitemno.desp#</option>
                    </cfloop>
                    </cfselect>
          		</cfif>
				</td>
      		</tr>
            <tr>
            <td>Monthly</td>
            <td>
            <cfif mode eq "Delete" or mode eq "Edit">
            <input type="checkbox" name="monthly" id="monthly" value="Y" <cfif getmonthlytransfer.monthly eq 'Y'>checked</cfif> onClick="if(document.getElementById('monthly').checked==true){document.getElementById('datefrom').value='';document.getElementById('dateto').value='';}">
            <cfelse>
            <input type="checkbox" name="monthly" id="monthly" value="Y" onClick="if(document.getElementById('monthly').checked==true){document.getElementById('datefrom').value='';document.getElementById('dateto').value='';document.getElementById('fperiod').options[0].selected=true;}">
            </cfif>
            </td>
            </tr>
            
      		<tr>
        		<td>Period:</td>
        		<td colspan="100%"><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="fperiod" required="no" value="#getmonthlytransfer.fperiod#" maxlength="40" readonly>
					<cfelse>
                    <select name="fperiod" id="fperiod" onChange="document.getElementById('datefrom').value = this.options[this.selectedIndex].title;document.getElementById('dateto').value = this.options[this.selectedIndex].id;">
				<cfoutput>
                <option value="">Choose a Period</option>
                <cfset nowdate = dateformat(now(),"dd/mm/yyyy")>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
                
				<option value="01" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#" >Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="02" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="03" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#" title="#lasdate2#">Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="04" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="05" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="06" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="07" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="08" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="09" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'dd/mm/yyyy')#>
                <cfset lasdate2 =#dateformat(dateadd('m','-1',dateadd('d','1',lasdate)),'dd/mm/yyyy')#>
				<option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# title="#lasdate2#">Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</cfoutput>
			</select>
                    
                    
                    
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Date From</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="datefrom" required="no" value="#dateformat(getmonthlytransfer.datefrom,'DD/MM/YYYY')#" maxlength="10"  validate="eurodate">
					<cfelse>
						<cfinput type="text" size="10" name="datefrom" required="no" maxlength="40" validate="eurodate" message="Please Key in Date From">
					</cfif>
                    (DD/MM/YYYY)
				</td>
      		</tr>
            
            <tr>
        		<td>Date to</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="dateto" required="no" value="#dateformat(getmonthlytransfer.dateto,'DD/MM/YYYY')#" maxlength="10"  validate="eurodate">
					<cfelse>
						<cfinput type="text" size="10" name="dateto" required="no" maxlength="40" validate="eurodate" message="Please Key in Date To">
					</cfif>
                    (DD/MM/YYYY)
				</td>
      		</tr>
            
            
            <tr>
        		<td>Cluster A Qty</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="qty" required="yes" value="#getmonthlytransfer.qty#" maxlength="40"  validate="integer">
					<cfelse>
						<cfinput type="text" size="40" name="qty" required="yes" maxlength="40" validate="integer" message="Please Key in Qty">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Cluster B Qty</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="qty2" required="yes" value="#getmonthlytransfer.qty2#" maxlength="40"  validate="integer">
					<cfelse>
						<cfinput type="text" size="40" name="qty2" required="yes" maxlength="40" validate="integer" message="Please Key in Qty">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Cluster C Qty</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="qty3" required="yes" value="#getmonthlytransfer.qty3#" maxlength="40"  validate="integer">
					<cfelse>
						<cfinput type="text" size="40" name="qty3" required="yes" maxlength="40" validate="integer" message="Please Key in Qty">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Cluster D Qty</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="qty4" required="yes" value="#getmonthlytransfer.qty4#" maxlength="40"  validate="integer">
					<cfelse>
						<cfinput type="text" size="40" name="qty4" required="yes" maxlength="40" validate="integer" message="Please Key in Qty">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Cluster A1 Qty</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="40" name="qty5" required="yes" value="#getmonthlytransfer.qty5#" maxlength="40"  validate="integer">
					<cfelse>
						<cfinput type="text" size="40" name="qty5" required="yes" maxlength="40" validate="integer" message="Please Key in Qty">
					</cfif>
				</td>
      		</tr>
            
            
      		<tr>
        		<td></td>
        		<td align="right"><cfinput name="submit" type="submit" value="  #button#  "></td>
      		</tr>
		</table>
	</cfform>
</body>
</cfoutput>
</html>