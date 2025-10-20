<html>
<head>
	<title>BEPS Flexbible Report</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
<h1>BEPS Report Query</h1>
<h4><a href="flexiReportDetail.cfm?type=Create">Create New Report</a></h4>

<form action="flexibleReport.cfm" method="post">
	<h1>
    	Search By :
        <select id="searchBy" name="searchBy">
        	<option value="userid">User ID</option>
            <option value="reporttitle">Report ID</option>
            <option value="created_on">Created Date</option>
            <option value="desp">Description</option>
        </select>	
		&nbsp;&nbsp;&nbsp;
		Search for 
		<input type="text" name="searchFor" id="searchFor" value="">
        <input type="submit" name="search" id="search" value="Go">
	</h1>
</form>

<cfif isdefined('form.search')>
	<h1>Search Result</h1>
    <hr/>
    	<table align="center" class="data" width="80%">
            <tr>
                <td colspan="8">
                    <div align="center">
                        <font color="##336699" size="3" face="Arial, Helvetica, sans-serif"><strong>Newest 20 Reports</strong></font>
                    </div>     
                </td>
            </tr>
            <tr>   	
                <th><div align="center">Date</div></th>
                <th><div align="center">User ID</div></th>
                <th><div align="center">Query Name</div></th>
                <th><div align="center">Action</div></th>     
            </tr>
            
            <cfquery name="getflexireport" datasource="#dts#">
                select *
                from flexireport
                where "#form.searchby#" like "%#searchFor#%"
                order by created_on desc;
            </cfquery>
        	
            <cfif getflexireport.recordcount eq 0>
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                     <td colspan="4" align="center"><h3>No Result Found</h3></td>
                </tr>
            <cfelse>
                <cfloop query="getflexireport">
                    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                        <td>#dateformat(getflexireport.created_on, 'yyyy-mm-dd')#</td>
                        <td>#getflexireport.userid#</td>
                        <td>#getflexireport.reporttitle#</td>
                        <td align="center">
                            <a target="_blank" href="reportFilter.cfm?reportid=#getflexireport.id#"><img height="18px" width="18px" src="../../../images/print.png" alt="Print" border="0"> Generate</a>
                            &nbsp;&nbsp;
                            <a onClick="confirmDelete('#getflexireport.id#')"><img height="18px" width="18px" src="../../../images/delete.ICO" alt="Delete" border="0"> Delete</a>
                            <!---&nbsp;&nbsp;
                            <a href="">Create View</a>--->
                            &nbsp;&nbsp;
                            <a href="flexiReportDetail.cfm?type=Edit&reportid=#getflexireport.id#"><img height="18px" width="18px" src="../../../images/edit.ICO" alt="Edit" border="0"> Edit</a>
                        </td>
                    </tr>
                </cfloop>
            </cfif>
        </table>
    <hr/>
</cfif>

<h1>Report</h1>
<hr/>
	<table align="center" class="data" width="80%">
	<tr>
    	<td colspan="8">
            <div align="center">
                <font color="##336699" size="3" face="Arial, Helvetica, sans-serif"><strong>Newest 20 Reports</strong></font>
            </div>     
        </td>
  	</tr>
  	<tr>   	
    	<th><div align="center">Date</div></th>
        <th><div align="center">User ID</div></th>
        <th><div align="center">Report Title</div></th>
        <th><div align="center">Action</div></th>     
  	</tr>
    
    <cfquery name="getflexireport" datasource="#dts#">
    	select *
        from flexireport
        order by created_on desc;
    </cfquery>

	<cfloop query="getflexireport">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td>#dateformat(getflexireport.created_on, 'yyyy-mm-dd')#</td>
            <td>#getflexireport.created_by#</td>
            <td>#getflexireport.reporttitle#</td>
            <td align="center">
                <a target="_blank" href="reportFilter.cfm?reportid=#getflexireport.id#"><img height="18px" width="18px" src="../../../images/print.png" alt="Print" border="0"> Generate</a>
                &nbsp;&nbsp;
                <a onClick="confirmDelete('#getflexireport.id#')"><img height="18px" width="18px" src="../../../images/delete.ICO" alt="Delete" border="0"> Delete</a>
                <!---&nbsp;&nbsp;
                <a href="">Create View</a>--->
                &nbsp;&nbsp;
                <a href="flexiReportDetail.cfm?type=Edit&reportid=#getflexireport.id#"><img height="18px" width="18px" src="../../../images/edit.ICO" alt="Edit" border="0"> Edit</a>
            </td>
        </tr>
    </cfloop>
</table>
<hr/>

<script type="text/javascript">
function confirmDelete(reportid){
	if(confirm('Are you sure want to delete this report?')){
		window.location.href = "reportProcess.cfm?type=Delete&reportid="+reportid;
	}
}
</script>
</body>
</cfoutput>
</html>
