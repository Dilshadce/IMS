<cfoutput>

<cfif isdefined("form.fulfill")>
	<cfset xlist= form.fulfill>
	<cfset cnt=listlen(xlist)>
	<cfloop from="1" to="#cnt#" index="i">
	<!---	<cfif listgetat(form.fulfill,i) gt listgetat(form.qtytoful,i)>
			<h3>Error. The qty to fulfill is greater than the outstanding qty.</h3>
			<cfabort>
		</cfif>--->

		<cfif listgetat(form.fulfill,i) eq 0>
        <h3>Error. The qty to fulfill cannot be 0.</h3>
        <cfabort>
        </cfif>
	</cfloop>
</cfif>



<cfquery name="getrefno" datasource="#dts#">
	select * from artran where type='#url.t1#' and refno='#url.refno#'
</cfquery>

<cfquery name="getcustdetail" datasource="#dts#">
	select * from #target_arcust# where custno='#getrefno.custno#'
</cfquery>
<cfset incre=0>

<cfif getrefno.agenno neq ''>
<cfset incre=incre+1>
</cfif>
<cfif getrefno.multiagent1 neq ''>
<cfset incre=incre+1>
</cfif>
<cfif getrefno.multiagent2 neq ''>
<cfset incre=incre+1>
</cfif>
<cfif getrefno.multiagent3 neq ''>
<cfset incre=incre+1>
</cfif>
<cfif getrefno.multiagent4 neq ''>
<cfset incre=incre+1>
</cfif>
<cfif getrefno.multiagent5 neq ''>
<cfset incre=incre+1>
</cfif>

<cfset dts2=replace(dts,'_i','_c','all')>

<cfquery name="getRefnoTkt" datasource="#dts2#">
select * from refnoset where type = "tkt"
</cfquery>
<cfinvoke component="cfc.refno" method="processNum" oldNum="#getRefnoTkt.lastusedNo#" returnvariable="newnextNum" />

<cfquery name="updateTkt" datasource="#dts2#">
update refnoset set lastusedno = '#newnextNum#' where type = "tkt"
</cfquery>	

<cfquery name="insertlead" datasource="#dts2#">
insert into lead (
id,date,incre,agent,agent2,agent3,agent4,agent5,
term,leadowner,leadname,phone,email,leadsource,industry,accountno,add1,add2,add3,add4,daddr1,daddr2,daddr3,daddr4,country,postalcode,d_postalcode,e_mail,website,ltype,DESCRIPTION,created_by,created_on,updated_by,updated_on,contact,currency,imstype,imsrefno,ims) values 

(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getRefnoTkt.lastUsedNo#">,
<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(getrefno.wos_date,'yyyy-mm-dd')#">,
'#incre#','#getrefno.agenno#','#getrefno.multiagent1#','#getrefno.multiagent2#','#getrefno.multiagent3#','#getrefno.multiagent4#',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrefno.term#">,
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrefno.name#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.phone#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.e_mail#">,
'',
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.custno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.add1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.add2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.add3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.add4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.daddr1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.daddr2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.daddr3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.daddr4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.country#">,

<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.postalcode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.d_postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.e_mail#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.web_site#">,
'','',
'#huserid#',
now(),
'#huserid#',
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.contact#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.currcode#">,
'#url.t1#',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">,
'Y'
  )

</cfquery>

<cfset mylist= listchangedelims(checkbox,"",",")>
<cfset cnt=listlen(mylist,";")>

<cfset j = 1>

<cfloop from="1" to="#cnt#" index="i" step="+3">
<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' <!---and shippedticket < qty---> and type = '#url.t1#'
			</cfquery>
            
            <cfset newship = val(getbody.shipped) + val(listgetat(form.fulfill,j))>
            
            <cfquery datasource="#dts#" name="updateictran">
					Update ictran set shippedticket = '#newship#'
					where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and ticket = '#val(getbody.ticket)+1#' and type = '#url.t1#'
				</cfquery>
            <!---
			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
            <cfquery name="updateictran" datasource="#dts#">
                update ictran set ticket='Ticket' where type='#url.t1#' and refno='#url.refno#' and itemno='#getbody.itemno#' and trancode='#getbody.trancode#'
            </cfquery>
            </cfif>--->
            
            <cfquery name="gettickettrancode" datasource="#dts#">
            select ifnull(max(trancode),0)+1 as trancode from iclink where frrefno='#url.refno#' and type='TKT' and frtype='#url.t1#'
            </cfquery>
            
            <cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('TKT','#getRefnoTkt.lastUsedNo#','#gettickettrancode.trancode#',
					'#dateformat(now(),"yyyy-mm-dd")#','#url.t1#','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#listgetat(form.fulfill,j)#')
			</cfquery>
     <cfset j = j+1>       

</cfloop>
<!---
<cfquery datasource="#dts#" name="checkupdated">
		Select refno from ictran where refno = '#url.refno#' and type = '#url.t1#' and ticket=''
</cfquery>

<cfif checkupdated.recordcount eq 0>--->
<cfquery name="updateartran" datasource="#dts#">
	update artran set ticket='#val(getrefno.ticket)+1#' where type='#url.t1#' and refno='#url.refno#'
</cfquery>
<!---</cfif>--->



<cfset status="#getrefno.name# had been successfully created.">

<script type="text/javascript">
alert('Ticket Created.');
window.location.href='/default/transaction/transaction.cfm?tran=#url.t1#';
</script>


</cfoutput>
