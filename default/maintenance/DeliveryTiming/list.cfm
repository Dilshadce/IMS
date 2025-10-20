
<cfif cgi.HTTP_HOST eq 'ims2.netiquette.com.sg' or cgi.HTTP_HOST eq 'ims.netiquette.com.sg' or cgi.HTTP_HOST eq 'imspro.netiquette.com.sg'>
<cfset imsdts = dts>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfelse>
<cfinclude template="/_dsp/dsp_header.cfm"> 
<cfif not len(getAuthUser())>
	<cfset request.loginmessage = <!--- request.loginmessage &  --->"<br>You must be authorized to access that area ... Please login.">
	<cfinclude template="#Application.webroot#security/login.cfm">
</cfif>
</cfif>
<cfsetting enablecfoutputonly="yes">


<!--- <cfset month_sign = 'now()'> --->
<cfajaximport tags="cfform">
<br/>
<!---2/8/2012--->
<cfquery name="getmemID" datasource="#replace(dts,'_i','_c','all')#">
select memberid from security where username = '#getauthuser()#'
</cfquery>

<cfquery name="getRole" datasource="#replace(dts,'_i','_c','all')#">
select role from securitylink where securityid = '#getmemID.memberid#'
</cfquery>
<!---2/8/2012--->
<cfform name="myform" id="myform">
<input type="hidden" name="hiddentext" id="hiddentext" />
</cfform>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">
<cfif isdefined('searchstr') eq false and isdefined('searchtype') eq false>
<cfset searchstr = "">
<cfset searchtype = "">
</cfif>
<cfquery name="getrecordcount" datasource="#imsdts#">
select count(id) as totalrecord from deliveryTiming
</cfquery>
<br/>
<cfoutput>
<script type="text/javascript">
function callID(comid)
{
document.getElementById("hiddentext").value = comid;

}
</script>

 <table border="0" >
<tr>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="setDeliveryTiming.cfm"><b>Set the Delivery Timing</b></a></td>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="form.cfm?type=Create"><b>Create Delivery Timing</b></a></td>
<!---<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="electrolist.cfm"><b>Production Routing Card List</b></a></td> --->
</tr>
</table>
<h4>Delivery Timing</h4>
</cfoutput>
<cfset pagename = "list.cfm">
<cfoutput>
<cfif getrecordcount.totalrecord neq 0>
	<cfif isdefined("form.skeypage") and val(form.skeypage) neq 0>
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		<cfif getrecordcount.recordcount mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
		
 	</cfif>
	<cfif isdefined("form.skeypage")>
    <cfif val(form.skeypage) eq 0>
    <cfset form.skeypage =1>
    </cfif>
	</cfif>
	<cfform action="#pagename#" method="post" target="_self">
		<div align="left">
        <h1>
        Delivery Timing Option	 : 
        <input type="hidden"  name="searchtype" id="searchtype" value="option1">
       <input type="text" name="searchstr" id="searchstr">        
        &nbsp;&nbsp;
        <input type="submit" name="submitbtn" value="Go" >
        </h1>
    </div>
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
		
			<cfquery datasource='#imsdts#' name="getholiday">
			select * from deliveryTiming 
              WHERE 1=1  
                <cfif searchstr neq "" and searchtype neq "">
 AND #searchtype# like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#searchstr#%">
</cfif> 
ORDER BY created_on,updated_on desc
				limit #start-1#,20;
			</cfquery>

		<cfif start neq 1>
			|| <a target="_self" href="#pagename#?&start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
		  <a target="_self" href="#pagename#?start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>
		<hr>

<table border="0"  align="center" class="data">
  			<tr>
				<td colspan="#3+7#"><div align="center"><font color="336699" size="3" face="Arial, Helvetica, sans-serif"><strong>List Of Delivery Timing</strong></font></div></td>
  			</tr>
            <tr>
            	<th>No</th>
                <th>Delivery Timing Option</th>
                <cfloop list="1:AM,2:PM,3:Night,4:Saturday<!---,5:Thursday ,6:Friday,7:Saturday --->" index="a">
   	 			<th>#Listlast(a,':')#</th>
                </cfloop>
                
             
                <th>Action</th>
 		 	</tr>
		<cfif getholiday.recordcount eq 0>
        <tr>
        <td colspan="100%">
        <h3>No Record Found</h3>
        </td>
        </tr>
        </cfif>
			<cfloop query="getholiday">
			<tr>
            <td>#currentrow#</td>
            <td>#option1#</td>
            <cfloop list="1:Sunday,2:Monday,3:Tuesday,4:Wednesday" index="a">
            <td style="font-size:14px">#timeformat(evaluate('time#Listfirst(a,':')#'), "hh:mm TT" )# <cfif evaluate('totime#Listfirst(a,':')#') neq ''> to</cfif> #timeformat(evaluate('totime#Listfirst(a,':')#'), "hh:mm TT" )#</td>
            </cfloop>
                    <td>
                     <a target="_parent" href="form.cfm?type=Edit&amp;id=#getholiday.id#">
		             <img height="18px" width="18px" src="/images/Edit.png" alt="edit" border="0">Edit
		              </a>
                      &nbsp;
                      <a target="_parent" href="form.cfm?type=Delete&amp;id=#getholiday.id#">
		             <img height="18px" width="18px" src="/images/cancel.png" alt="delete" border="0">Delete
		              </a>
                      &nbsp;         
                    </td>
    			</tr>
  		</cfloop>
		</table>
		<hr>
		<div align="right">
		<cfif start neq 1>
		  <a target="_self" href="#pagename#?start=#prevTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
		  <a target="_self" href="#pagename#?start=#nextTwenty#&searchtype=#urlencodedformat(searchtype)#&searchstr=#urlencodedformat(searchstr)#">Next</a> ||
		</cfif>
		
		Page #page# Of #noOfPage#
		</div>
	</cfform>
<cfelse>
	<h3><center>No Records were found.</center></h3>
</cfif>
</cfoutput>

 <cfwindow center="true" width="600" height="200" name="copy" refreshOnShow="true"
        title="Copy PRC" initshow="false" modal="true"
        source="copy.cfm?no={myform:hiddentext}" />



