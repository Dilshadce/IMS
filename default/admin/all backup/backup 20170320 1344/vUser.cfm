<html>
<head>
<title>View IMS Database</title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif husergrpid eq "super">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
function active(sta,custno)
{
var checkfield = "active"+custno;
if(document.getElementById(checkfield).checked == true && sta == "Y")
{
sta = "Y";
}
else if (document.getElementById(checkfield).checked == false && sta == "Y")
{
sta = "N";
}
else if (document.getElementById(checkfield).checked == true && sta == "N")
{
sta = "N";
}
else
{
sta = "Y";
}
  var urlload = '/default/admin/updateactive.cfm?sta='+sta+'&custno='+escape(custno);
	
    new Ajax.Request(urlload,
      {
        method:'get',
        onSuccess: function(flyback){
        },
        onFailure: function(){ 
		alert('Update Failed'); }
      });

}
</script>
</cfif>
</head>

<body>

<h4>
	<cfif husergrpid eq "Muser">
		<a href="/home2.cfm"><u>Home</u></a>
	</cfif>
</h4>

<h1>User Maintenance</h1>

<hr>
	<cfparam name="start" default="1">
	<cfparam name="no" default="1">
	
    <cfquery datasource='main' name="getmulticompany">
	select * from multicomusers where userid='#huserid#' 
	</cfquery>
    <cfset multicomlist=valuelist(getmulticompany.comlist)>
    
    
	<cfif husergrpid eq "super">
		<cfquery datasource='main' name="getUsers">
			select userbranch 
			from users 
			where userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i')
			and userDept not like '%_a'
            and comsta = "Y"
			group by userbranch order by userbranch;
		</cfquery>
    <cfelseif getmulticompany.recordcount neq 0>
    <cfquery datasource='main' name="getUsers">
			select userbranch 
			from users 
			where userbranch in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#multicomlist#">)
			group by userbranch order by userbranch;
	</cfquery>
	<cfelseif husergrpid eq "admin">
		<cfquery datasource='main' name="getUsers">
			select userbranch 
			from users 
			where userbranch='#hcomid#'
			group by userbranch order by userbranch;
		</cfquery>
	<cfelse>
		<cfquery datasource='main' name="getUsers">
			select userbranch 
			from users 
			where userid='#huserid#' 
			and userbranch='#hcomid#';
		</cfquery>
	</cfif>
    
    <cfquery name="getdata" datasource="main">
    SELECT compro,period,lastaccyear,companyid,remark FROM useraccountlimit WHERE 
    companyid  in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getUsers.userbranch)#" list="yes" separator=","> )
    </cfquery>
	
	<cfif isdefined("url.start")>
		<cfset start = url.start>
	</cfif>
    <cfif husergrpid eq "super">
	<table align="center" class="data" width="80%">
		<tr>
			<th onClick="javascript:shoh('transaction_menu_page1');shoh('transaction_menu_page2');">Page 1<img src="/images/d.gif" name="imgtransaction_menu_page1" align="center"></th>
			<th onClick="javascript:shoh('transaction_menu_page2');shoh('transaction_menu_page1');">Page 2<img src="/images/u.gif" name="imgtransaction_menu_page2" align="center"></th>
		</tr>
	</table>
    </cfif>
	<table id="transaction_menu_page1" align="center" class="data" width="80%">
		<tr>
			<th width="10%">No.</th>
            <th>GO</th>				
    		<th width="20%">Company ID</th>
			<th width="40%">Company Name</th>
            <cfif husergrpid eq "super">
            <th width="10%">Remarks</th>
            </cfif>
			<th width="10%">Last A/C Year Closing Date</th>
			<th width="10%">Future A/C Year Closing Date</th>
			<th width="10%">Current Period</th>
            <cfif husergrpid eq "super">
            <th width="10%">Active</th>	
            </cfif>				
		</tr>
		<cfoutput query="getUsers" startrow="#start#">
			<cfset dts = getUsers.userbranch>
			<cfquery name="getcominfo" dbtype="query">
			SELECT compro,lastaccyear,period,remark FROM getdata WHERE UPPER(companyid) =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(dts)#">  
			</cfquery>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="center">#no#.</div></td>	
                <cfif getusers.userbranch neq hcomid>
                <td><cfif getusers.userbranch eq 'net_i' or getusers.userbranch eq 'nett_i' or getusers.userbranch eq 'netm_i' or getusers.userbranch eq 'netsm_i'>
                <cfif huserid eq "ultrairene" or huserid eq "ultrasiong" or huserid eq "ultrasw" or huserid eq "ultraseeyoon" or huserid eq "ultraedwin" or huserid eq "ultralung" or huserid eq "ultracai" or huserid eq "ultrakahyin" or huserid eq "ultrack">
                <input type="button" name="go_btn" id="go_btn" value="GOTO" onClick="if(confirm('Are You Sure You Want To Go To #getusers.userbranch#')){window.location.href='goto.cfm?comid=#getusers.userbranch#'}" />
                <cfelse>
                </cfif>
                <cfelse>
                <input type="button" name="go_btn" id="go_btn" value="GOTO" onClick="if(confirm('Are You Sure You Want To Go To #getusers.userbranch#')){window.location.href='goto.cfm?comid=#getusers.userbranch#'}" />
                </cfif>
                </td>
                <cfelse>
                <td></td>
				</cfif>															
				<td>
					<a href="vuser1.cfm?comid=#getUsers.userbranch#">#ucase(getUsers.userbranch)#</a>
				</td>
				<td>#trim(getcominfo.compro)#</td>
                <cfif husergrpid eq "super">
                <td>#getcominfo.remark#</td>
                </cfif>
				<td align="center"><cfif getcominfo.LastAccYear neq "">#dateformat(getcominfo.LastAccYear,"dd-mm-yyyy")#</cfif></td>
				<td align="center">
					<cfif getcominfo.LastAccYear neq "">
						<cfset futuredate = dateAdd("m",val(getcominfo.Period),getcominfo.LastAccYear)>
						#dateformat(futuredate,"dd-mm-yyyy")#
					</cfif>
				</td>
				<td align="center">
                	<cfif getcominfo.LastAccYear eq '0000-00-00' or getcominfo.LastAccYear eq "">
                    	<cfset lastaccyear = now()>
					<cfelse>	
						<cfset lastaccyear = getcominfo.LastAccYear>
                    </cfif>    
                    
                   
					<cfset period = getcominfo.period>
					<cfset currentdate = lsdateformat(now(),'mm/dd/yyyy')>
		
					<cfset tmpYear = year(currentdate)>
                    
					<cfset clsyear = year(lastaccyear)>

					<cfset tmpmonth = month(currentdate)>
					<cfset clsmonth = month(lastaccyear)>

					<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>

					<cfif intperiod gt 18 or intperiod lte 0>
						<cfset readperiod=99>
					<cfelse>
						<cfset readperiod = numberformat(intperiod,"00")>
					</cfif>
					#readperiod#
				</td><cfif husergrpid eq "super">
                <td>
                <input type="checkbox" name="active#ucase(getUsers.userbranch)#" id="active#ucase(getUsers.userbranch)#" checked onClick="active('Y','#ucase(getUsers.userbranch)#')" />
                </td>			
                </cfif>						
			</tr>
			<cfset no = no + 1>
		</cfoutput>
	</table>
    <cfif husergrpid eq "super">
    <cfquery datasource='main' name="getUsersNo">
			select userbranch 
			from users 
			where userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i')
			and userDept not like '%_a'
            and comsta = "N"
			group by userbranch order by userbranch;
		</cfquery>
        <cfquery name="getdata" datasource="main">
    SELECT compro,period,lastaccyear,companyid,remark FROM useraccountlimit WHERE 
    companyid  in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getUsersNo.userbranch)#" list="yes" separator=","> )
    </cfquery>
        <cfset no = 1>
    	<table id="transaction_menu_page2" style="display:none" align="center" class="data" width="80%">
		<tr>
			<th width="10%">No.</th>				
    		<th width="20%">Company ID</th>
			<th width="40%">Company Name</th>
            <cfif husergrpid eq "super">
            <th width="10%">Remarks</th>
            </cfif>
			<th width="10%">Last A/C Year Closing Date</th>
			<th width="10%">Future A/C Year Closing Date</th>
			<th width="10%">Current Period</th>
            <th width="10%">No Active</th>					
		</tr>
		<cfoutput query="getusersno">
			<cfset dts = getusersno.userbranch>
			<cfquery name="getcominfo" dbtype="query">
			SELECT compro,lastaccyear,period,remark FROM getdata WHERE UPPER(companyid) =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(dts)#">  
			</cfquery>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="center">#no#.</div></td>																
				<td>
					<a href="vuser1.cfm?comid=#getusersno.userbranch#">#ucase(getusersno.userbranch)#</a>
				</td>
				<td>#trim(getcominfo.compro)#</td>
                <cfif husergrpid eq "super">
                <td>#getcominfo.remark#</td>
                </cfif>
                
				<td align="center"><cfif getcominfo.LastAccYear neq "">#dateformat(getcominfo.LastAccYear,"dd-mm-yyyy")#</cfif></td>
				<td align="center">
					<cfif getcominfo.LastAccYear neq "">
						<cfset futuredate = dateAdd("m",val(getcominfo.Period),getcominfo.LastAccYear)>
						#dateformat(futuredate,"dd-mm-yyyy")#
					</cfif>
				</td>
				<td align="center">
                <cftry>
					<cfset lastaccyear = getcominfo.LastAccYear>
					<cfset period = getcominfo.period>
					<cfset currentdate = lsdateformat(now(),'mm/dd/yyyy')>
		
					<cfset tmpYear = year(currentdate)>
					<cfset clsyear = year(lastaccyear)>

					<cfset tmpmonth = month(currentdate)>
					<cfset clsmonth = month(lastaccyear)>

					<cfset intperiod = (tmpyear-clsyear)*12+tmpmonth-clsmonth>

					<cfif intperiod gt 18 or intperiod lte 0>
						<cfset readperiod=99>
					<cfelse>
						<cfset readperiod = numberformat(intperiod,"00")>
					</cfif>
					<cfcatch></cfcatch></cftry>
					#readperiod#
				</td>
                <td>
                <input type="checkbox" name="active#ucase(getusersno.userbranch)#" id="active#ucase(getusersno.userbranch)#" checked onClick="active('N','#ucase(getusersno.userbranch)#')" />
                </td>									
			</tr>
			<cfset no = no + 1>
		</cfoutput>
	</table>
	</cfif>
<br>

</body>
</html>