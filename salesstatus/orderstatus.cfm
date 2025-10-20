<cfoutput>
<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfif isdefined('url.refno')>
<h1>Update detail</h1>
<cfquery name="getlink" datasource="#dts#">
SELECT refno,wos_date,type FROM iclink WHERE frtype = "#url.tran#" and frrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#"> group by type,refno order by wos_date,type,refno
</cfquery> 
	<cfif getlink.recordcount neq 0>
        <table>
        <cfset billtype = "">
        <cfloop query="getlink">
            <tr>
                <th >#getlink.type# -#dateformat(getlink.wos_date,'YYYY-MM-DD')#- #getlink.refno#</th>
                
                <td >
                    <cfquery name="getdetail" datasource="#dts#">
                    SELECT created_on,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#">
                    </cfquery>
                    Updated On <b>#dateformat(getdetail.created_on,'YYYY-MM-DD')# #dateformat(getdetail.created_on,'HH:MM:SS')#</b> BY <b>#getdetail.created_by#</b><br/>
                    Item updated as below:<br/>
                    <cfquery name="getitemlist" datasource="#dts#">
                    SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#"> order by itemno
                    </cfquery>
                        <table>
                        <tr>
                        <th>No</th>
                        <th>Itemno</th>
                        <th>Desp</th>
                        <th>Qty</th>
                        </tr>
                        <cfloop query="getitemlist">
                        <tr>
                        <td>
                        #getitemlist.currentrow#</td><td>#getitemlist.itemno#</td><td>#getitemlist.desp#</td>
                        <td>#getitemlist.qty#</td>
                        </tr>
                        </cfloop></table>
                    <cfset nodeep = 0>
                    <cfset newno = getlink.refno>
                    <cfset newtype = getlink.type>
                    
                    <cfloop condition="nodeep neq 1">
                    <cfquery name="getdeeper" datasource="#dts#">
                    SELECT refno,wos_date,type FROM iclink WHERE frtype = "#newtype#" and frrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newno#"> group by type,refno order by wos_date,type,refno
                    </cfquery>
                    
						<cfif getdeeper.recordcount eq 0>
                        <cfset nodeep = 1>
                        <cfelse>
                        
                        <table style="left:50px; margin-left:50px">
                            <cfloop query="getdeeper">
                            <tr>
                            <th >#getdeeper.type# -#dateformat(getdeeper.wos_date,'YYYY-MM-DD')#- #getdeeper.refno#</th>
                            <td >
                            <cfquery name="getdetaildeeper" datasource="#dts#">
                            SELECT created_on,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper.type#">
                            </cfquery>
                            Updated On <b>#dateformat(getdetaildeeper.created_on,'YYYY-MM-DD')# #dateformat(getdetaildeeper.created_on,'HH:MM:SS')#</b> BY <b>#getdetaildeeper.created_by#</b><br/>
                            Item updated as below:<br/>
                            <cfquery name="getitemlist" datasource="#dts#">
                            SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#"> order by itemno
                            </cfquery>
                                <table>
                                <tr>
                                <th>No</th>
                                <th>Itemno</th>
                                <th>Desp</th>
                                <th>Qty</th>
                                </tr>
                                <cfloop query="getitemlist">
                                <tr>
                                <td>
                                #getitemlist.currentrow#</td><td>#getitemlist.itemno#</td><td>#getitemlist.desp#</td>
                                <td>#getitemlist.qty#</td>
                                </tr>
                                </cfloop></table>
                                			<cfset nodeep1 = 0>
                    <cfset newno = getdeeper.refno>
                    <cfset newtype = getdeeper.type>
                    
                    <cfloop condition="nodeep1 neq 1">
                    <cfquery name="getdeeper1" datasource="#dts#">
                    SELECT refno,wos_date,type FROM iclink WHERE frtype = "#newtype#" and frrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newno#"> group by type order by wos_date,type
                    </cfquery>
                    
						<cfif getdeeper1.recordcount eq 0>
                        <cfset nodeep1 = 1>
                        <cfelse>
                        
                        <table style="left:100px; margin-left:100px;">
                            <cfloop query="getdeeper1">
                            <tr>
                            <th >#getdeeper1.type# -#dateformat(getdeeper1.wos_date,'YYYY-MM-DD')#- #getdeeper1.refno#</th>
                            <td >
                            <cfquery name="getdetaildeeper" datasource="#dts#">
                            SELECT created_on,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper1.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper1.type#">
                            </cfquery>
                            Updated On <b>#dateformat(getdetaildeeper.created_on,'YYYY-MM-DD')# #dateformat(getdetaildeeper.created_on,'HH:MM:SS')#</b> BY <b>#getdetaildeeper.created_by#</b><br/>
                            Item updated as below:<br/>
                            <cfquery name="getitemlist" datasource="#dts#">
                            SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#"> order by itemno
                            </cfquery>
                                <table>
                                <tr>
                                <th>No</th>
                                <th>Itemno</th>
                                <th>Desp</th>
                                <th>Qty</th>
                                </tr>
                                <cfloop query="getitemlist">
                                <tr>
                                <td>
                                #getitemlist.currentrow#</td><td>#getitemlist.itemno#</td><td>#getitemlist.desp#</td>
                                <td>#getitemlist.qty#</td>
                                </tr>
                                </cfloop></table>
                                			<cfset nodeep2 = 0>
                    <cfset newno = getdeeper1.refno>
                    <cfset newtype = getdeeper1.type>
                    
                    <cfloop condition="nodeep2 neq 1">
                    <cfquery name="getdeeper2" datasource="#dts#">
                    SELECT refno,wos_date,type FROM iclink WHERE frtype = "#newtype#" and frrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newno#"> group by type order by wos_date,type
                    </cfquery>
                    
						<cfif getdeeper2.recordcount eq 0>
                        <cfset nodeep2 = 1>
                        <cfelse>
                        
                        <table style="left:100px; margin-left:100px;">
                            <cfloop query="getdeeper2">
                            <tr>
                            <th >#getdeeper2.type# -#dateformat(getdeeper2.wos_date,'YYYY-MM-DD')#- #getdeeper2.refno#</th>
                            <td >
                            <cfquery name="getdetaildeeper" datasource="#dts#">
                            SELECT created_on,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper2.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper2.type#">
                            </cfquery>
                            Updated On <b>#dateformat(getdetaildeeper.created_on,'YYYY-MM-DD')# #dateformat(getdetaildeeper.created_on,'HH:MM:SS')#</b> BY <b>#getdetaildeeper.created_by#</b><br/>
                            Item updated as below:<br/>
                            <cfquery name="getitemlist" datasource="#dts#">
                            SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#"> order by itemno
                            </cfquery>
                                <table>
                                <tr>
                                <th>No</th>
                                <th>Itemno</th>
                                <th>Desp</th>
                                <th>Qty</th>
                                </tr>
                                <cfloop query="getitemlist">
                                <tr>
                                <td>
                                #getitemlist.currentrow#</td><td>#getitemlist.itemno#</td><td>#getitemlist.desp#</td>
                                <td>#getitemlist.qty#</td>
                                </tr>
                                </cfloop></table>
                                	<cfset nodeep3 = 0>
                    <cfset newno = getdeeper2.refno>
                    <cfset newtype = getdeeper2.type>
                    
                    <cfloop condition="nodeep3 neq 1">
                    <cfquery name="getdeeper3" datasource="#dts#">
                    SELECT refno,wos_date,type FROM iclink WHERE frtype = "#newtype#" and frrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newno#"> group by type order by wos_date,type
                    </cfquery>
                    
						<cfif getdeeper3.recordcount eq 0>
                        <cfset nodeep3 = 1>
                        <cfelse>
                        
                        <table style="left:100px; margin-left:100px;">
                            <cfloop query="getdeeper3">
                            <tr>
                            <th >#getdeeper3.type# -#dateformat(getdeeper3.wos_date,'YYYY-MM-DD')#- #getdeeper3.refno#</th>
                            <td >
                            <cfquery name="getdetaildeeper" datasource="#dts#">
                            SELECT created_on,created_by FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper3.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeeper3.type#">
                            </cfquery>
                            Updated On <b>#dateformat(getdetaildeeper.created_on,'YYYY-MM-DD')# #dateformat(getdetaildeeper.created_on,'HH:MM:SS')#</b> BY <b>#getdetaildeeper.created_by#</b><br/>
                            Item updated as below:<br/>
                            <cfquery name="getitemlist" datasource="#dts#">
                            SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlink.type#"> order by itemno
                            </cfquery>
                                <table>
                                <tr>
                                <th>No</th>
                                <th>Itemno</th>
                                <th>Desp</th>
                                <th>Qty</th>
                                </tr>
                                <cfloop query="getitemlist">
                                <tr>
                                <td>
                                #getitemlist.currentrow#</td><td>#getitemlist.itemno#</td><td>#getitemlist.desp#</td>
                                <td>#getitemlist.qty#</td>
                                </tr>
                                </cfloop></table>
                            </td>
                            </tr>
                            <cfif getdeeper3.recordcount eq getdeeper3.currentrow>
                            <cfset nodeep3 = 1>
							</cfif>
                            </cfloop>
                        </table>
                        
                        </cfif>
                    </cfloop>
                            </td>
                            </tr>
                            <cfif getdeeper2.recordcount eq getdeeper2.currentrow>
                            <cfset nodeep2 = 1>
							</cfif>
                            </cfloop>
                        </table>
                        
                        </cfif>
                    </cfloop>
                            </td>
                            </tr>
                            <cfif getdeeper1.recordcount eq getdeeper1.currentrow>
                            <cfset nodeep1 = 1>
							</cfif>
                            </cfloop>
                        </table>
                        
                        </cfif>
                    </cfloop>
                            </td>
                            </tr>
                            <cfif getdeeper.recordcount eq getdeeper.currentrow>
                            <cfset nodeep = 1>
							</cfif>
                            </cfloop>
                        </table>
                        
                        </cfif>
                    </cfloop>
                </td>
            </tr>
        </cfloop>
        </table>
    <cfelse>
    No Detail
    </cfif>
</cfif>
</body>
</html>

</cfoutput>