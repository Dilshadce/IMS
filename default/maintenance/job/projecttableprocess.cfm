<cfquery datasource="#dts#" name="getgeneral">
	Select lJOB as layer from gsetup
</cfquery>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * FROM #target_project# where source = '#form.source#' 
	</cfquery>
  
	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
	      <h3><font color="##FF0000">Error, This #getgeneral.layer# ("#form.source#") has been created already.</font></h3>
		</cfoutput> 
	    <cfabort>
	</cfif>
	
	<cfif lcase(HcomID) eq "pls_i">
		<cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,<!--- creditsales,cashsales,salesreturn,purchase,purchasereturn, --->DETAIL5,DETAIL6,DETAIL7,DETAIL8,DETAIL9,DETAIL10,DETAIL11,DETAIL12)
			values 
			('#form.source#', '#form.project#', '#form.porj#'<!--- ,  
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">, --->
			'#form.d5#','#form.d6#','#form.d7#','#form.d8#','#form.d9#','#form.d10#','#form.d11#','#form.d12#')
		</cfquery>
        	<cfelseif lcase(HcomID) eq 'taftc_i'>
		<cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,<!--- creditsales,cashsales,salesreturn,purchase,purchasereturn, --->DETAIL5,DETAIL6,DETAIL7,DETAIL8,postingtimes)
			values 
			('#form.source#', '#form.project#', '#form.porj#',<!--- ,  
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">, --->
			'#form.d5#','#form.d6#','#form.d7#','#form.d8#','#val(form.postingtimes)#')
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj<!--- ,creditsales,cashsales,salesreturn,purchase,purchasereturn --->)
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#'<!--- ,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#"> --->
            )
		</cfquery>
	</cfif>
  	<cfset status="The #getgeneral.layer#, #form.source# had been successfully created. ">
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * FROM #target_project# where source='#form.source#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete FROM #target_project# where source='#form.source#'
	  		</cfquery>
	  		<cfset status="The #getgeneral.layer#, #form.source# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">

	  		<cfif lcase(HcomID) eq "pls_i">
			 	<cfquery datasource='#dts#' name="updateproject">
					UPDATE #target_project# 
					set source='#form.source#',project ='#form.project#', porj='#form.porj#',
				 	DETAIL5='#form.d5#', DETAIL6='#form.d6#', DETAIL7='#form.d7#', DETAIL8='#form.d8#', DETAIL9='#form.d9#',
				  	DETAIL10='#form.d10#', DETAIL11='#form.d11#', DETAIL12='#form.d12#'
					where source = '#form.source#'
		  		</cfquery>
                	<cfelseif lcase(HcomID) eq 'taftc_i'>
			 	<cfquery datasource='#dts#' name="updateproject">
					UPDATE #target_project# 
					set source='#form.source#',project ='#form.project#', porj='#form.porj#',
				 	DETAIL5='#form.d5#', DETAIL6='#form.d6#', DETAIL7='#form.d7#', DETAIL8='#form.d8#',postingtimes = '#val(form.postingtimes)#'
					where source = '#form.source#'
		  		</cfquery>
			<cfelse>
		  		<cfquery datasource='#dts#' name="updateproject">
					UPDATE #target_project# 
					set project =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, 
					porj='#form.porj#'<!--- ,
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
                    purchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
                    purchasereturn =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#"> --->
					where source = '#form.source#'
		  		</cfquery>
			</cfif>			
	  		<cfset status="The #getgeneral.layer#, #form.source# had been successfully edited. ">
		</cfif>
  	<cfelse>		
		<cfset status="Sorry, the #getgeneral.layer#, #form.source# was ALREADY removed from the system. Process unsuccessful.">
  	</cfif>
</cfif>
<cfoutput>

<form name="done" action="s_Projecttable.cfm?type=project&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>

<script>
	done.submit();
</script>