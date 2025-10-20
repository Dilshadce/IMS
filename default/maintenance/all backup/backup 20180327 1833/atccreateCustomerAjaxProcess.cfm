	<cfif isdefined('form.s_prefix') and isdefined('form.s_suffix')>
	<cfset newCustomerNo = #form.s_prefix#&"/"&#form.s_suffix# >
    <cfset form.custno = newCustomerNo>
    <cfelse>
    <cfset newCustomerNo = "#form.custno#">
    
	</cfif>
    <cfset dtslink = dts>
    <cfif hlinkams eq "Y">
			<cfset dtslink = replace(dts,"_i","_a","all")>
		</cfif>
    
    <cfquery name="insertcust" datasource="#dtslink#">
		insert into arcust 
		(
        custno, 
		date,
		name,
		name2,
		add1,
		add2,
		add3,
		add4,
        add5,
        daddr1,
		daddr2,
		daddr3,
		daddr4,
        daddr5,
		attn,
		agent,
		e_mail,
		phone,
        dphone,
		phonea,
		fax,
		contact,
		arrem1,
		arrem2,
        arrem3,
        created_by,
        created_on,
        postalcode,
        d_postalcode,
        dattn,
        arrem4
        )
		values
		( 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#newcustomerno#">,
        <cfqueryparam cfsqltype="cf_sql_date" value="#form.date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dadd1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dadd2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dadd3#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dadd4#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dadd5#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.attn#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.e_mail#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dphone#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contact#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem1#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem2#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem3#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserName#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.postalcode#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_postalcode#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dattn#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.arrem4#">
		)
	</cfquery>
    
	<cfif hlinkams eq "Y">
	<cfset dts1 = replace(dts,"_i","_a","all")>	
	<cfquery name="insertgldata" datasource="#dts1#">
	insert into gldata
	(accno,
	desp,
	desp2,
	id,
	acctype)
	values
	(
	'#newcustomerno#',
	'#form.name#',
	'#form.name2#',
	'1',
	'F'
	) 
	</cfquery>
    </cfif>
    
    <cfif isdefined('newCustomerNo')>
    <cfif form.nexcustno eq 1>
    <cfset lastusedno = right(form.custno,3) >
	<cfelse>
    <cfset lastusedno = form.custno >
	</cfif>
    <cfquery name="updatelastusedno" datasource="#dts#">
    Update refnoset SET lastUsedNo = "#lastusedno#" WHERE type = "CUST"
    </cfquery>
	</cfif>
    
 <cfoutput>
 <h2>Create New Company Success!</h2>
 <input type="button" onClick="ColdFusion.Window.hide('createCustomer');document.getElementById('searchcontact').value='#form.name#';ajaxFunction(document.getElementById('searchmemberajax'),'searchmemberajax.cfm?contact='+escape(document.getElementById('searchcontact').value));" value="Close" >
 </cfoutput>