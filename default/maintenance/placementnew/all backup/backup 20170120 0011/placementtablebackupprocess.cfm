
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">
<cfif form.placementdate neq ''>
<cfset ndate = createdate(right(form.placementdate,4),mid(form.placementdate,4,2),left(form.placementdate,2))>
<cfset placementdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset placementdate = '0000-00-00'>
</cfif>
<cfif form.startdate neq ''>
<cfset ndate1 = createdate(right(form.startdate,4),mid(form.startdate,4,2),left(form.startdate,2))>
<cfset startdate = dateformat(ndate1,'yyyy-mm-dd')>
<cfelse>
<cfset startdate = '0000-00-00'>
</cfif>
<cfif form.completedate neq ''>
<cfset ndate2 = createdate(right(form.completedate,4),mid(form.completedate,4,2),left(form.completedate,2))>
<cfset completedate = dateformat(ndate2,'yyyy-mm-dd')>
<cfelse>
<cfset completedate = '0000-00-00'>
</cfif>

<cfif isdefined('form.empno')>
<cfquery name="getempname" datasource="#dts#">
SELECT name FROM #replace(dts,'_i','_p')#.pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
</cfquery>
</cfif>

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from Placement where placementno = '#form.placementno#' 
	</cfquery>
  
	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
	      <h3><font color="##FF0000">Error, This Placement ("#form.placementno#") has been created already.</font></h3>
		</cfoutput> 
	    <cfabort>
	</cfif>
		<cfquery datasource="#dts#" name="insertartran">
			Insert into Placement 
			(placementno,placementdate,placementtype,location,custno,custname,contactperson,consultant,billto,project,jobcode,position,empno,nric,sex,duration,startdate,completedate,clientrate,clienttype,newrate,newtype,allowance1,allowance2,allowance3,allowance4,created_by,created_on,assignmenttype,empname)
			values 
			('#form.placementno#',<cfif form.placementdate eq ''>'0000-00-00'<cfelse>'#placementdate#'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementtype#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactperson#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.consultant#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.position#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#">,'#form.duration#',<cfif form.startdate eq ''>'0000-00-00'<cfelse>'#startdate#'</cfif>,<cfif form.completedate eq ''>'0000-00-00'<cfelse>'#completedate#'</cfif>,'#val(form.clientrate)#','#form.clienttype#','#val(form.newrate)#','#form.newtype#','#val(form.allowance1)#','#val(form.allowance2)#','#val(form.allowance3)#','#val(form.allowance4)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">,<cfif isdefined('getempname.name')><cfqueryparam cfsqltype="cf_sql_varchar" value="#getempname.name#"><cfelse>''</cfif>)
		</cfquery>
        <cfset dts1 = replace(dts,'_i','_p','All')>
        <cfquery name="insertpayrecord" datasource="#dts1#">
        INSERT INTO payrecord (empno,brate,AW101,AW102,AW103,AW104,month,year,realempno,placement)
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno##form.placementno#">,
        '#val(form.newrate)#', 
        '#val(form.allowance1)#',
        '#val(form.allowance2)#',
        '#val(form.allowance3)#',
        '#val(form.allowance4)#',
        <cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'m')#"</cfif>,
		<cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'yyyy')#"</cfif>,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
        )
        </cfquery>

  	<cfset status="The Placement, #form.placementno# had been successfully created. ">
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from Placement where placementno='#form.placementno#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete from Placement where placementno='#form.placementno#'
	  		</cfquery>
            <cfset dts1 = replace(dts,'_i','_p','All')>
            <cfquery name="deleteplacement" datasource="#dts1#">
            DELETE FROM payrecord WHERE placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
            </cfquery>
	  		<cfset status="The Placement, #form.placementno# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">

		  		<cfquery datasource='#dts#' name="updatePlacement">
					Update Placement 
					set 
                    placementdate=<cfif form.placementdate eq ''>'0000-00-00'<cfelse>'#placementdate#'</cfif>,
                    placementtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementtype#">,
                    location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
                    custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                    custname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,
                    contactperson=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactperson#">,
                    consultant=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.consultant#">,
                    billto=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,
                    project=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,
                    jobcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobcode#">,
                    position=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.position#">,
                    empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
                    nric=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#">,
                    sex=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#">,
                    duration='#form.duration#',
					startdate=<cfif form.startdate eq ''>'0000-00-00'<cfelse>'#startdate#'</cfif>,
					completedate=<cfif form.completedate eq ''>'0000-00-00'<cfelse>'#completedate#'</cfif>,                   	clientrate='#val(form.clientrate)#',
                    clienttype='#form.clienttype#',
                    newrate='#val(form.newrate)#',
                    newtype='#form.newtype#',
                    allowance1='#val(form.allowance1)#',
                    allowance2='#val(form.allowance2)#',
                    allowance3='#val(form.allowance3)#',
                    allowance4='#val(form.allowance4)#',
                    updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    updated_on=now(),
                    assignmenttype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">
                    <cfif isdefined('getempname.name')>,empname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getempname.name#"></cfif>
            
					where placementno = '#form.placementno#'
		  		</cfquery>
                 <cfset dts1 = replace(dts,'_i','_p','All')>
                <cfquery name="updateplacement" datasource="#dts1#">
                Update payrecord SET
                empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno##form.placementno#">,
                brate='#val(form.newrate)#',
                AW101='#val(form.allowance1)#',
                AW102='#val(form.allowance2)#',
                AW103='#val(form.allowance3)#',
                AW104='#val(form.allowance4)#',
                month=<cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'m')#"</cfif>,
                year=<cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'yyyy')#"</cfif>,
                realempno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
				WHERE placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
                </cfquery>
                
	  		<cfset status="The Placement, #form.placementno# had been successfully edited. ">
		</cfif>
  	<cfelse>		
		<cfset status="Sorry, the Placement, #form.placementno# was ALREADY removed from the system. Process unsuccessful.">
  	</cfif>
</cfif>
<cfoutput>

<form name="done" action="s_Placementtable.cfm?type=Placement&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>

<script>
	done.submit();
</script>