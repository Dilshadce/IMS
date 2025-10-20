<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen" >
<link href="/stylesheet/app.css" rel="stylesheet" type="text/css" >
<script src="/javascripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
<script type="text/javascript" src="/javascripts/ajax.js"></script>
<title>Leave Approval</title>
<link rel="shortcut icon" href="/PMS.ico" /> 
<script type="text/javascript">
<cfset dts2 = replace(dts,'_p','_i')>
function checkallfield()
{
	var leaveall = document.getElementById('leave_list').value;
	var leavearray = leaveall.split(",");
	var checkid = false;
	if(document.getElementById('checkall').checked == true)
	{
	checkid = true;
	}
	else
	{
	checkid = false;
	}
	
	if(leavearray.length != 0)
	{
	for(var i = 0;i<leavearray.length;i++)
	{
	
		document.getElementById('id'+leavearray[i]).checked = checkid;
	}
	}
}
</script>
<script language="javascript">
function confirmDecline(type,id) {
	var answer = confirm("Confirm Decline?")
	if (answer){
		ColdFusion.Window.show('waitpage');
		var textbox_id = "management_"+id;
		var remark_text = document.getElementById(textbox_id).value;		
		
		window.location = "LeaveApprovalMain.cfm?type="+type+ "&id="+id+"&remarks="+remark_text;
	}
	else{
		
	}
}
function confirmDelete(type,id) {
	
		var answer = confirm("Confirm Delete?")
		if (answer){
			ColdFusion.Window.show('waitpage');
			window.location = "LeaveApprovalMain.cfm?type="+type+"&id="+id;
			}
		else{
			
			}
		}
		

function confirmApprove(type,id) {
	var answer = confirm("Confirm Approve?")
	if (answer){
		ColdFusion.Window.show('waitpage');
		var textbox_id = "management_"+id;
		var remark_text = document.getElementById(textbox_id).value;
		window.location = "LeaveApprovalMain.cfm?type="+type+"&id="+id+"&remarks="+remark_text;
	}
	else{
		
	}
}

function confirmApprove2(type,id) {
    window.location = "LeaveApproval2.cfm?id="+id;
}

function confirmApprove3(type,id) {
    window.location = "LeaveApproval3.cfm?id="+id;
	
}

function comfirmUpdate(id){

	document.getElementById('leave_id').value = id;
	ColdFusion.Window.show('update_leave')
}
</script>
</head> 

<body>

<cfif isdefined("url.type") and isdefined("url.id")>
	<cfif url.type eq "dec">
        <cfquery name="getleavedelete" datasource="#dts2#">
        SELECT empno,leavetype,a.startdate FROM leavelist a
        LEFT JOIN placement b on a.placementno = b.placementno
        WHERE id = "#url.id#"
        </cfquery>
    
<!---        <cfquery name="leave_qry" datasource="#dts2#">
		SELECT entryno FROM pleave WHERE empno='#getleavedelete.empno#' and LVE_TYPE = '#getleavedelete.leavetype#' and 
        LVE_DATE = '#dateformat(getleavedelete.startdate,'yyyy-mm-dd')#' ORDER BY lve_type 
		</cfquery>--->

<!---		<cfquery name="delete_qry" datasource="#dts2#">
		DELETE FROM pleave WHERE entryno = '#leave_qry.entryno#'
		</cfquery>
	--->
		<cfquery name="delete_qry2" datasource="#dts2#">
		UPDATE leavelist SET STATUS = "DECLINED",updated_by = "#HUserName#", <cfif isdefined('url.remarks')>
        mgmtremarks = "#url.remarks#",</cfif> updated_on = now() WHERE id = #url.id#
		</cfquery>
	
		<cfquery name="select_details" datasource="#dts2#">
		SELECT * FROM #dts#.EMP_USERS as a 
        LEFT JOIN placement b on a.empno = b.empno
        LEFT JOIN leavelist c on b.placementno = c.placementno        
        WHERE c.id = #url.id#
		</cfquery>

	<cfelseif url.type eq "app">
    
        <cfquery name="getdate" datasource="#dts_main#">
            SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
        </cfquery>
    
        <cfset finalapprove = 0>
        <cfset status = "">
        
<!---        <cfquery name="checkcancellve" datasource="#dts2#">
            SELECT id FROM leavelist WHERE id = '#url.id#'
        </cfquery>
    
        <cfif checkcancellve.recordcount eq 0>--->
            <cfquery name="approve_leave" datasource="#dts2#">
            UPDATE leavelist SET STATUS = "APPROVED",updated_by = "#HUserName#", MGMTREMARKS = "#url.remarks#",
            updated_on = now() WHERE id = #url.id#
            </cfquery>
            <cfset finalapprove = 1>

       <!--- <cfelse>--->
<!---            <cfquery name="cancellve" datasource="#dts2#">
                DELETE FROM leavelist WHERE id = '#url.id#'
            </cfquery>   ---> 
            
<!---            <cfquery name="cancellve" datasource="#dts2#">
                UPDATE leavelist SET STATUS = "DECLINED", updated_by = "#HUserName#", MGMTREMARKS = "#url.remarks#",
                updated_on = now() WHERE id = #url.id#
            </cfquery>   
            
            <cfquery name="select_details" datasource="#dts2#">
        		SELECT * FROM #dts#.EMP_USERS as em 
                LEFT JOIN placement c on em.empno = c.empno
                LEFT JOIN leavelist as LA on em.empno = c.empno 
                WHERE LA.id = #url.id# 
            </cfquery>
            123
        </cfif>--->
    
        <cfif finalapprove eq 1>
       
            <cfset mon = #numberformat(getdate.mmonth,'00')# >
            <cfset yrs = getdate.myear>
            
            <cfquery name="getempno" datasource="#dts2#">
            SELECT empno,leavetype FROM leavelist a LEFT JOIN placement b on a.placementno = b.placementno WHERE id = "#url.id#"
            </cfquery>
            
            <cfif getempno.recordcount eq 0>
            <cfoutput>
            <script type="text/javascript">
            alert('Employee Record Not Found!');
   <!---         history.go(-1);--->
            </script>
            </cfoutput>
            <cfabort>
            </cfif>
        
<!---            <cfquery name="select_emp" datasource="#dts2#">
            SELECT * FROM (
            select sum(a.days) as days,a.leavetype,a.empno from (
                SELECT days,if(leavetype = 'NCL','AL',leavetype) as leavetype,empno FROM leavelist WHERE
                 empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getempno.empno#"> and substr(startdate,1,4)='#yrs#' and 
                 substr(startdate,6,2)='#mon#'  order by startdate desc) as a group by leavetype) as aa where 
                 aa.leavetype =     <cfif getempno.leavetype eq "NCL">
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="AL">
                                     <cfelse>
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getempno.leavetype#">
                                     </cfif>
            </cfquery>
                
            <cfif select_emp.recordcount gt 0> 
                <cfquery name="check1sthalf" datasource="#dts2#">
                SELECT #select_emp.leavetype# as leavec FROM paytra1 WHERE 
                empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getempno.empno#"> and payyes = "Y"
                </cfquery>
            
                <cfif check1sthalf.recordcount neq 0>
                    <cfif val(check1sthalf.leavec) neq 0>
                        <cfif val(select_emp.days) gt val(check1sthalf.leavec)>
                            <cfset select_emp.days = val(select_emp.days) - val(check1sthalf.leavec)>
                        </cfif>
                    </cfif>
                </cfif>

                <cfif select_emp.leavetype eq "TO">
                    <cfset select_emp.leavetype = "toff">
                </cfif>  
    
                <cfif select_emp.leavetype neq "NCL">
                    <cfquery name="approve_leave_paytran" datasource="#dts2#">
                    UPDATE paytran SET #select_emp.leavetype# = "#select_emp.days#" WHERE empno = "#select_emp.empno#"
                    </cfquery>
                </cfif>
            </cfif>--->
	
           <!--- <cfquery name="select_details" datasource="#dts2#">
            SELECT * FROM EMP_USERS as em 
            LEFT JOIN leavelist as LA 
            on (em.empno = LA.empno)
            LEFT JOIN pmast as PM 
             on (em.empno = PM.empno)
            WHERE LA.id = #url.id#
            </cfquery>
	
	    	<cfif #select_details.startampm# neq "">
                <cfset startampm = #timeformat(select_details.startampm, "HH:mm")#>
            <cfelse>
                <cfset startampm = '00:00'>
            </cfif>
            <cfif #select_details.endampm# neq "">
                <cfset endampm = #timeformat(select_details.endampm, "HH:mm")#>
            <cfelse>
                <cfset endampm = '00:00'>
            </cfif>--->
    
<!---            <cfquery name="insert_leave_pleave" datasource="#dts2#">
                Insert INTO pleave (empno,Lve_Type,lve_date,lve_date_to,lve_day,startampm,endampm,id) 
                values 
                ('#select_details.empno#','<cfif select_details.leavetype eq "NCL">AL<cfelse>#select_details.leavetype#</cfif>',
                "#dateformat(select_details.startdate,'YYYY-MM-DD')#","#dateformat(select_details.enddate,'YYYY-MM-DD')#",
                "#select_details.Days#",'#startampm#','#endampm#','#select_details.id#')
            </cfquery>--->
	    </cfif>
	</cfif>
   <!--- <cfabort>--->
<!---    <cflocation url="leaveapprovalmain.cfm">    
---></cfif>
<!---end--->

<h3>Leave Approval</h3>
<cfoutput>
<cfset datenow = #dateformat(now(), 'yyyymmdd')# >

<div class="tabber">
	<div class="tabbertab" id="refresh1">	
       
	<h3>Waiting Approval Leave</h3>
    
    <form name="updateall" id="updateall" method="post" action="LeaveApprovalProcess.cfm" onsubmit="return confirm('Are You Sure You Want to Approve All Selected Leave?');">
    <table border="0" width="100%">

<cfquery name="getleaveset" datasource="#dts_main#">
SELECT eleaveapp FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfquery name="getsuperid" datasource="#dts_main#">
SELECT * FROM hmusers WHERE userCmpID = "#HcomID#" and entryID = "#HEntryID#"
</cfquery>
        
<cfif getleaveset.eleaveapp eq "adminonly" or getsuperid.userGrpID eq "super">
    <cfquery name="wait_leave" datasource="#dts2#">
        SELECT * FROM leavelist a
        LEFT JOIN placement b on a.placementno = b.placementno
        WHERE STATUS = "IN PROGRESS" 
        or STATUS = "WAITING DEPT APPROVED" 
        order by a.startdate desc
    </cfquery>
        
<cfelseif getleaveset.eleaveapp eq "deptadmin" or  getleaveset.eleaveapp eq "admindept">

<cfquery name="getdept" datasource="#dts2#">
select deptcode from dept where headdept = <cfqueryparam cfsqltype="cf_sql_varchar" value="#HEntryID#">
</cfquery>

<cfif getdept.recordcount eq 0>
        
    <cfquery name="wait_leave" datasource="#dts2#">
    SELECT * FROM leavelist WHERE STATUS = "IN PROGRESS" or STATUS = "WAITING DEPT APPROVED" order by startdate desc
    </cfquery>
		
<cfelse>

    <cfquery name="getempindept" datasource="#dts2#">
    SELECT empno FROM pmast WHERE
    deptcode in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getdept.deptcode)#" separator="," list="yes">)
    order by empno
    </cfquery>
    
    <cfif getempindept.recordcount neq 0>
    
    <cfquery name="wait_leave" datasource="#dts2#">
    SELECT * FROM leavelist WHERE STATUS = "WAITING DEPT APPROVED" and empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempindept.empno)#" list="yes" separator=",">) order by startdate desc
    </cfquery>
    
    <cfelse>
    
    <cfquery name="wait_leave" datasource="#dts2#">
    SELECT * FROM leavelist WHERE STATUS = "WAITING DEPT APPROVED" 
    order by startdate desc
    </cfquery>
    
    </cfif>

</cfif>
</cfif>
        <tr>
        <th width="2%">No.</th>
        <th width="10%">Employee</th>
        <th width="10%">Placement No.</th>
        <th width="5%">Date Start</th>
        <th width="5%">Date End</th>
        <th width="2%">Days</th>
		<th width="2%">Type</th>
        <th width="4%">Time Fr</th>
        <th width="4%">Time To</th>
		<th width="7%">Status</th>
        <th width="5%">Apply Date</th>
<!---        <th width="3%">Attachment</th>        --->
        <th width="8%">Applicant Remarks</th>
        <th width="8%">Remarks</th>
        <th width="6%" nowrap="nowrap">Action&nbsp;&nbsp;</th>
        </tr>
<cfset leavelist = "">

<cfloop query="wait_leave">
    <input type="text" name="leaveid" id="leaveid#wait_leave.id#" value="#wait_leave.id#" hidden>
	<cfset leavelist = leavelist&wait_leave.id>
    <cfif wait_leave.recordcount neq wait_leave.currentrow>
		<cfset leavelist = leavelist&",">
    </cfif>

        <tr onMouseOver="this.style.backgroundColor='99FF00';" onMouseOut="this.style.backgroundColor='';">
        <td>#wait_leave.currentrow#</td>
        <td>#wait_leave.empno# | <!---#select_name.name#---></td>
        <td>#wait_leave.placementno#</td>
        <td>#dateformat(wait_leave.startdate,'yyyy-mm-dd')#</td>
        <td>#dateformat(wait_leave.enddate,'yyyy-mm-dd')#</td>
        <td>#wait_leave.Days#</td>
		<td><cfif wait_leave.leavetype eq "NCL">Time Off<cfelse>#wait_leave.leavetype#</cfif></td>
        <td>#timeformat(wait_leave.startampm)#</td>
        <td>#timeformat(wait_leave.endampm)#</td>
		<td>#wait_leave.status#</td>
        <td>#dateformat(wait_leave.submit_date,'yyyy-mm-dd')#</td>

        <td>#wait_leave.remarks#</td>
        <td><textarea name="management_#wait_leave.id#" id="management_#wait_leave.id#" cols="15" rows="3"></textarea></td>
        <td >
        <table>
            <tr>
    <!---		<td><a href="##" onclick="comfirmUpdate('#wait_leave.id#')"><img height="30px" width="30px" src="/images/edit.ico" alt="Approve" border="0"><br/>Edit</a></td>	
    --->
            <cfset apptype = ''>
            <cfif getsuperid.approvaltype eq 2>        
                <cfset apptype = 2>   
            <cfelseif getsuperid.approvaltype eq 3>
                <cfset apptype = 3>
            </cfif>
            <td>
                <a href="##" onclick="confirmApprove#apptype#('app','#wait_leave.id#')"><img height="30px" width="30px" src="/images/1.jpg" alt="Approve" border="0"><br/>Approve</a>
            </td>
            <td>
                <a href="##" onclick="confirmDecline('dec','#wait_leave.id#')"><img height="30px" width="30px" src="/images/2.jpg" alt="Decline" border="0"><br />Decline</a>
            </td>
            <td><!---<input type="checkbox" name="id" id="id#wait_leave.id#" value="#wait_leave.id#" />--->
            </td>            
            </tr>
        </table>
        </td>
        </tr>
        <!--- </form> --->
        </cfloop>
        </table> 
        <input type="hidden" name="leave_list" id="leave_list" value="#leavelist#" /> 
        </form>   
        <form name="eform" id="eform">
			<input type="hidden" name="leave_id" id="leave_id" value="">	
		</form>   

    </div>

        
    <div class="tabbertab" id="refresh2">
       <!---  <form  name="#wait_leave.id#" id="#wait_leave.id#" action="/payments/updateLeave.cfm" method="post">
        ---> 
    <h3>APPROVED LEAVE</h3>
    <cfquery name="wait_leave" datasource="#dts2#">
        SELECT * FROM leavelist a 
        LEFT JOIN placement b 
        ON a.placementno = b.placementno        
        WHERE STATUS = "APPROVED"  
        ORDER BY a.startdate desc
    </cfquery>


    <table border="0" width="100%">
     
        <tr>
        <th width="2%">No.</th>
        <th width="10%">Employee</th>
        <th width="5%">Placement No.</th>
        <th width="5%">Date Start</th>
        <th width="5%">Date End</th>
        <th width="2%">Days</th>
		<th width="2%">Type</th>
        <th width="4%">Time Fr</th>
        <th width="4%">Time To</th>
        <th width="5%">Apply Date</th>
        <th width="8%">Remarks</th>
        <th width="5%">Approved Date</th>
		<th width="5%">Approved By</th>
        <th width="8%">Management Remarks</th>
        <th width="6%"><center>Approval Doc</th>
        <th width="3%">Action</th>
        </tr>
        
        <cfloop query="wait_leave">

<!---         <cfquery name="select_name" dbtype="query">
        SELECT empno,name,alall,aladj,albf,mcall,ccall FROM getnameall WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(wait_leave.empno)#">
        </cfquery>--->
        <tr onMouseOver="this.style.backgroundColor='99FF00';" onMouseOut="this.style.backgroundColor='';">
        <td>#wait_leave.currentrow#</td>
        <td>#wait_leave.empno# | <!---#select_name.name#---></td>
        <td>#wait_leave.placementno#</td>
        <td>#dateformat(wait_leave.startdate,'yyyy-mm-dd')#</td>
        <td>#dateformat(wait_leave.enddate,'yyyy-mm-dd')#</td>
        <td>#wait_leave.Days#</td>
         <td><cfif wait_leave.leavetype eq "NCL">Time Off<cfelse>#wait_leave.leavetype#</cfif></td>
        <td>#timeformat(wait_leave.startampm)#</td>
        <td>#timeformat(wait_leave.endampm)#</td>
        <td>#dateformat(wait_leave.submit_date,'dd/mm/yyyy')#</td>
        <td>#wait_leave.remarks#</td>
        <td>#wait_leave.updated_on#</td>
		<td>#wait_leave.updated_by#</td>
        <td>#wait_leave.mgmtremarks#</td>
        <td align="center"> <cfif wait_leave.signdoc neq ''><a href="#wait_leave.signdoc#" target="_blank">View</a></cfif></td>
        <td>
        <a href="##" onclick="confirmDelete('can','#wait_leave.id#')">
				<img height="30px" width="30px" src="/images/2.jpg"  alt="Delete" border="0"><br />Delete</a></td>
        </tr>
            </cfloop>
        </table>    
           <!---   </form> --->
    </div>
    
    <div class="tabbertab" id="refresh3">
    <h3>DECLINED LEAVE</h3>
        <cfquery name="wait_leave" datasource="#dts2#">
        SELECT * FROM leavelist a 
        LEFT JOIN placement b 
        ON a.placementno = b.placementno        
        WHERE STATUS = "DECLINED"  
        ORDER BY a.startdate desc
        </cfquery>

        <table border="0" width="100%">
        <tr>
        <th width="2%">No.</th>
        <th width="10%">Employee</th>
        <th width="5%">Placement No.</th>
        <th width="5%">Date Start</th>
        <th width="5%">Date End</th>
        <th width="2%">Days</th>
		<th width="2%">Leave Type</th>
        <th width="5%">Time From</th>
        <th width="5%">Time To</th>
        <th width="8%">Apply Date</th>
<!---        <th width="3%">Attachment</th>        --->
        <th width="8%">Remarks</th>
        <th width="8%">Declined Date</th>
		<th width="5%">Declined By</th>
        <th width="8%">Management Remarks</th>
        </tr>
        
        
        <cfloop query="wait_leave">
<!---             <cfquery name="select_name" dbtype="query">
        SELECT empno,name,alall,aladj,albf,mcall,ccall FROM getnameall WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(wait_leave.empno)#">
        </cfquery>--->
        <tr onMouseOver="this.style.backgroundColor='99FF00';" onMouseOut="this.style.backgroundColor='';">
        <td>#wait_leave.currentrow#</td>
        <td>#wait_leave.empno# |<!--- #select_name.name#---></td>
        <td>#wait_leave.placementno#</td>
        <td>#dateformat(wait_leave.startdate,'yyyy-mm-dd')#</td>
        <td>#dateformat(wait_leave.enddate,'yyyy-mm-dd')#</td>
        <td>#wait_leave.Days#</td>
        <td><cfif wait_leave.leavetype eq "NCL">Time Off<cfelse>#wait_leave.leavetype#</cfif></td>
        <td>#timeformat(wait_leave.startampm)#</td>
        <td>#timeformat(wait_leave.endampm)#</td>
        <td>#dateformat(wait_leave.submit_date,'dd/mm/yyyy')#</td>
        <td>#wait_leave.remarks#</td>
        <td>#wait_leave.updated_on#</td>
		<td>#wait_leave.updated_by#</td>
        <td>#wait_leave.mgmtremarks#</td>
        </tr>
        </cfloop>
        </table>    
             
    </div>
    
    <div class="tabbertab" id="refresh4">
    <h3>EXPIRED LEAVE</h3>

    <cfquery name="wait_leave" datasource="#dts2#">
        SELECT * FROM leavelist a 
        LEFT JOIN placement b 
        ON a.placementno = b.placementno        
        WHERE enddate <= "#datenow#" 
        AND status != 'WAITING DEPT APPROVED' 
        AND status != 'IN PROGRESS'  
        ORDER BY a.startdate desc
    </cfquery>

    <table border="0" width="100%">
        <tr>
        <th width="2%">No.</th>
        <th width="10%">Employee</th>
        <th width="5%">Placement No.</th>
        <th width="5%">Date Start</th>
        <th width="5%">Date End</th>
        <th width="2%">Days</th>
		<th width="2%">Leave Type</th>
        <th width="4%">Time From</th>
        <th width="4%">Time To</th>
		<th width="5%">Status</th>
        <th width="7%">Apply Date</th>
<!---        <th width="3%">Attachment</th>        --->
        <th width="8%">Remarks</th>
        <th width="8%">Last Updated</th>
        <th width="8%">Management Remarks</th>
        <th width="6%"><center>Approval Doc</th>
        </tr>
        
        <cfloop query="wait_leave">
        <tr onMouseOver="this.style.backgroundColor='99FF00';" onMouseOut="this.style.backgroundColor='';">

        <!--- <cfquery name="select_name" dbtype="query">
        SELECT empno,name,alall,aladj,albf,mcall,ccall FROM getnameall WHERE UPPER(empno) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(wait_leave.empno)#">
        </cfquery>--->
        <td>#wait_leave.currentrow#</td>
        <td>#wait_leave.empno# | <!---#select_name.name#---></td>
        <td>#wait_leave.placementno#</td>
        <td>#dateformat(wait_leave.startdate,'yyyy-mm-dd')#</td>
        <td>#dateformat(wait_leave.enddate,'yyyy-mm-dd')#</td>
        <td>#wait_leave.Days#</td>
        <td><cfif wait_leave.leavetype eq "NCL">Time Off<cfelse>#wait_leave.leavetype#</cfif></td>
		<td>#timeformat(wait_leave.startampm)#</td>
        <td>#timeformat(wait_leave.endampm)#</td>
        <td>#wait_leave.status#</td>
		<td>#dateformat(wait_leave.submit_date,'dd/mm/yyyy')#</td>
        <td>#wait_leave.remarks#</td>
        <td>#wait_leave.updated_on#</td>
        <td>#wait_leave.mgmtremarks#</td>
        <td align="center"> <cfif wait_leave.signdoc neq ''><a href="#wait_leave.signdoc#" target="_blank">View</a></cfif></td>
        </tr> 
        </cfloop>
        </table>     
        </div>
</div>

<cfwindow x="210" y="100" width="570" height="480" name="update_leave"
  		 minHeight="400" minWidth="400" 
   		 title="Update Leave" initshow="false" refreshOnShow="true"
   		 source="edit_leave_maintainace.cfm?id={eform:leave_id}" />
  <cfwindow name="waitpage" title="Under Progress!" modal="true" closable="false" width="350" height="260" center="true" initShow="false" >
<p align="center">Under Process, Please Wait!</p>
<p align="center"><img src="/images/loading.gif" name="Cash Sales" width="30" height="30"></p>
<br />
</cfwindow>        
         
</cfoutput>
</body>
</html> 
