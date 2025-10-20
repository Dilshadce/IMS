
<cfquery name="getInfo" datasource="main">
	SELECT info_remark,info_date,info_desp
	FROM info
	ORDER BY info_date desc
	LIMIT 5;
</cfquery>

<cfquery name="getMasterUser" datasource="main">
    SELECT userID
    FROM masterUser
</cfquery>

<cfloop query="getMasterUser">
    <cfset masterUserList = ValueList(getMasterUser.userID,",")>
</cfloop>

<cfset userID = getauthuser()> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Overview</title>
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/dataTables/dataTables_fullPagination.css" />
    <link rel="stylesheet" href="/latest/css/body/overview.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/body/overview.js"></script>
    <cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
			var huserid='#huserid#';
			var husergrpid='#husergrpid#';
        </script>
    </cfoutput>
    
    <cfif ListFind(masterUserList,HuserID)>
        <cfinclude template="/latest/body/filterCompany.cfm">
        <link rel="stylesheet" href="/latest/css/select2/select2.css" />
        <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
		<script type="text/javascript">
            function changeCompany(newCompany){  
				window.open("/latest/generalSetup/userMaintenance/GOTO.cfm?comid=" +newCompany,'_self');
			}
        </script>
    </cfif>
    
</head>
<body>
<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<div class="containerDiv">
	<cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super">

    <cfsavecontent variable="chart1">
    <cfset url.type="type1">
    <cfinclude template="/latest/body/chart.cfm">
    </cfsavecontent>
        <cfsavecontent variable="chart2">
    <cfset url.type="type2">
    <cfinclude template="/latest/body/chart.cfm">
    </cfsavecontent>
    
	<div class="titleDiv">Overview</div>
	<div class="chartGroupDiv">
		<div class="chartDiv">
			<div class="chartTitleDiv">Last 5 Month Sales</div>
			<div class="chartContentDiv">
          
                 <cfset chart1=replacenocase(chart1,'quality="high"', 'quality="high" wmode="transparent"', "ALL")> 
      <cfset chart1=replacenocase(chart1,'<PARAM NAME="quality" VALUE="high"/>', '<PARAM NAME="quality" VALUE="high"/><PARAM NAME="wmode" VALUE="transparent"/>', "ALL")> 
     #chart1#
<!---      
				<iframe marginwidth="5%" frameborder="0" align="middle" name="list" height="250px" width="500px" src="/latest/body/chart.cfm?type=type1" noresize scrolling="no" style="z-index:-9999999;"></iframe> --->
			</div>
		</div>
		<div class="chartDiv">
			<div class="chartTitleDiv">Top 5 Customers</div>
			<div class="chartContentDiv">
             <cfset chart2=replacenocase(chart2,'quality="high"', 'quality="high" wmode="transparent"', "ALL")> 
      <cfset chart2=replacenocase(chart2,'<PARAM NAME="quality" VALUE="high"/>', '<PARAM NAME="quality" VALUE="high"/><PARAM NAME="wmode" VALUE="transparent"/>', "ALL")> 
     #chart2#
<!--- 				<iframe marginwidth="5%" frameborder="0" align="middle" name="list" height="250px" width="500px" src="/latest/body/chart.cfm?type=type2" noresize scrolling="no"></iframe>	 --->			
			</div>
		</div>
	</div>
    </cfif>

	<cfif ListFind(masterUserList,HuserID)>
        <div class="changeCompany" style="position:absolute;right:323px;top:20px;">
            <input type="hidden" id="changeCompanyID" name="changeCompanyID" class="companyFilter" data-placeholder="Fly me to...." onchange="changeCompany(this.value);"/>
        </div>
    </cfif>

	<div class="infoBoardDiv">
		<div class="infoBoardTitleDiv">Information Board</div>
		<div class="infoBoardContentDiv">
			<cfloop query="getInfo">
			<div class="infoDiv">
				<div class="infoTitleDiv">#info_remark#
					<div class="infoDateDiv">#DateFormat(info_date,"DD/MM/YYYY")#</div>
				</div>
				<div class="infoContentDiv">#info_desp#</div>	
			</div>
			</cfloop>	
		</div>
	</div>
	<div class="loggingHistoryDiv">
		<table id="loggingTable" style="width:100%;">
			<thead>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>

<cfinclude template="/checkyearend/yearend.cfm">



</cfoutput>

</body>
</html>