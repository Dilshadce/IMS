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
            
            
            <cfquery name="createble" datasource="#dts#">
            CREATE TABLE if not exists `#dts#`.`flexireport` (
              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
              `userid` varchar(100) DEFAULT '',
              `reportid` varchar(20) DEFAULT '',
              `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
              `desp` varchar(60) DEFAULT '',
              `created_by` varchar(100) DEFAULT '',
              `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
              `updated_by` varchar(100) DEFAULT '',
              `queryname` varchar(500) DEFAULT '',
              `reporttitle` varchar(100) DEFAULT '',
              `fcustomer` varchar(100) DEFAULT '',
              `fplacement` varchar(100) DEFAULT '',
              `fassignment` varchar(100) DEFAULT '',
              `finvoice` varchar(100) DEFAULT '',
              `femployee` varchar(100) DEFAULT '',
              `selcol` varchar(1000) DEFAULT '',
              `sortby` varchar(100) DEFAULT '',
              `sort1` varchar(100) DEFAULT '',
              `sort2` varchar(100) DEFAULT '',
              `groupby` varchar(100) DEFAULT '',
              `uuid` varchar(100) DEFAULT '',
              PRIMARY KEY (`id`)
            ) ENGINE=MYISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
            </cfquery>
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
    
       
    <cfquery name="createtable" datasource="#dts#">
    CREATE TABLE if not exists #dts#.flexireport (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `userid` varchar(100) DEFAULT '',
      `reportid` varchar(20) DEFAULT '',
      `created_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `desp` varchar(60) DEFAULT '',
      `created_by` varchar(100) DEFAULT '',
      `updated_on` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `updated_by` varchar(100) DEFAULT '',
      `queryname` varchar(500) DEFAULT '',
      `reporttitle` varchar(100) DEFAULT '',
      `fcustomer` varchar(100) DEFAULT '',
      `fplacement` varchar(100) DEFAULT '',
      `fassignment` varchar(100) DEFAULT '',
      `finvoice` varchar(100) DEFAULT '',
      `femployee` varchar(100) DEFAULT '',
      `selcol` varchar(1000) DEFAULT '',
      `sortby` varchar(100) DEFAULT '',
      `sort1` varchar(100) DEFAULT '',
      `sort2` varchar(100) DEFAULT '',
      `groupby` varchar(100) DEFAULT '',
      `uuid` varchar(100) DEFAULT '',
      PRIMARY KEY (`id`)
    ) ENGINE=MYISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8
    </cfquery>
    <cfquery name="getflexireport" datasource="#dts#">
        select *
        from flexireport
        order by created_on desc
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
</cfoutput>
</body>
</html>
