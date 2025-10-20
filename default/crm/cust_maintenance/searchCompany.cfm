<html>
<head>
	<link rel="stylesheet" href="css.css"/>
	
	<style type="text/css">
	.styleAdd{
   		font-size:12px;
   		font-family:Tahoma,sans-serif;
   		font-weight:bold;
   		color:#FF9999;
   		background-color:#33FF66;
   		border-style:outset;
   		border-color:#CCFFCC;
   		border-width:2px;
	}

	.styleEdit{
    	font-size:12px;
   		font-weight:bold;
   		color:#FFFF66;
   		background-color:#FF9966;
   		border-style:ridge;
   		border-color:#CCCCCC;
   		border-width:1px;
	}

	.styleDelete{
   		font-size:12px;
   		font-weight:bold;
   		font-family:Tahoma,sans-serif;
   		color:#DDDDDD;
   		background-color:#FF0099;
   		border-style:ridge;
   		border-color:#CCCC66;
   		border-width:2px;
	}
	
	</style>
	
<script type="text/javascript">
	function confirmdelete(comid){
		if (confirm("Are you sure you want to delete")) {
 			window.location.href='act_company.cfm?type=delete&comid=' + comid;
 		}
	}
</script>

</head>

<body>

<cfquery datasource="net_crm" name="search">
    SELECT a.*,b.custname FROM company as a
    
    left join
    
    (select * from customer) 
    as b on a.custid = b.custid
    
    <cfif type neq "default">
        <cfif type eq "custname">
            WHERE b.custname LIKE '#url.c#%'
        <cfelseif type eq "comid">
        	where a.comid LIKE '#url.c#%'
        <cfelseif type eq "comname">
        	where a.comname LIKE '#url.c#%'
        <cfelseif type eq "status">
        	where a.status = '#url.c#'   
        </cfif>
    </cfif>
</cfquery>

<table border="0" width="100%">
<tr class="style4">
    <th width="15%" align="center">
        Customer Name
    </th>
    <th width="10%" align="center">
        Company ID
    </th>
    <th width="30%" align="center">
        Company Name
    </th>
    <th width="10%" align="center">
        Attn
    </th>
    <th width="10%" align="center">
        Contact No
    </th>
    <th width="10%" align="center">
        Active Status
    </th>
    <th width="15%" align="center">
        Action
    </th>
</tr>
<cfoutput>
<cfloop query="search">	
<tr class="style3">
    <td>
        #search.custname#
    </td>
    <td align="center">
        #search.comid#
    </td>
    <td>
        #search.comname#
    </td>
    <td>
        #search.attn#
    </td>
    <td>
        #search.contactNo#
    </td>
    <td align="center">
        #search.status#
    </td>
    <td align="center">
        <!--- <input type="button" class="styleEdit" value="Edit" onClick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_company.cfm?comid=#search.comid#');">
        <input type="button" class="styleDelete" value="Delete" Onclick="window.location.href='act_company.cfm?type=delete&comid=#search.comid#';"> --->
		<img src="images/iedit.gif" alt="Edit" style="cursor: hand;" onclick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_company.cfm?comid=#search.comid#');">
		<img src="images/idelete.gif" alt="Delete" style="cursor: hand;" onclick="confirmdelete('#search.comid#');">
		<img src="images/archive.gif" alt="Customized Function" style="cursor: hand;" onclick="window.location.href='customized_function.cfm?comid=#search.comid#';">
    	<img src="images/view.gif" alt="View Details" style="cursor: hand;" onclick="window.open('companyinfo.cfm?comid=#search.comid#', 'windowname1', 'width=1200, height=600, left=20,top=100' );">
	</td>
</tr>
</cfloop>
</cfoutput>
</table>
<cfsetting showdebugoutput="no">

</body>
</html>
