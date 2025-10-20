<cfquery datasource="#dts#" name="getgeneral">
	Select lPROJECT as layer from gsetup
</cfquery>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfparam name="status" default="">

<cfif lcase(HcomID) eq 'taftc_i'>
<cfif isdefined('form.cbdeposit')>
<cfset deposit ="1">
<cfelse>
<cfset deposit ="0">
</cfif>
</cfif>

<cfif form.mode eq "Create">

	<cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
    <cfquery datasource='#dts#' name="checkitemExist">
		Select * FROM #target_project# where porj = "P" and source = '#form.source#' 
        union all
        Select * from weikendecor_i.project where porj = "P" and source = '#form.source#' 
	</cfquery>
    <cfelse>
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * FROM #target_project# where porj = "P" and source = '#form.source#' 
	</cfquery>
  	</cfif>
	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
	      <h3><font color="##FF0000">Error, This #getgeneral.layer# ("#form.source#") has been created already.</font></h3>
		</cfoutput> 
	    <cfabort>
	</cfif>
	
	<cfif lcase(HcomID) eq "pls_i">
		<cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn,DETAIL5,DETAIL6,DETAIL7,DETAIL8,DETAIL9,DETAIL10,DETAIL11,DETAIL12,completed)
			values 
			('#form.source#', '#form.project#', '#form.porj#',  
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">,
			'#form.d5#','#form.d6#','#form.d7#','#form.d8#','#form.d9#','#form.d10#','#form.d11#','#form.d12#',<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>)
		</cfquery>
	 <!---weiken--->
    <cfelseif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
    <cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn,completed,remark1,remark2,remark3,remark4,remark5
            ,com_id,com_name,wos_date,description,project_status,project_type,start_date,end_date,handleby,cost_est,cost_all,cost_add,budget,delivery_date,achievement
            )
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#"><cfif lcase(HcomID) eq 'taftc_i'>,'#form.WSQ#','#form.cprice#','#form.cdispec#','#form.camt#','#deposit#','#form.grantacc#','#form.urevenueacc#'</cfif>,<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_name#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wos_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_status#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_type#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.start_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.end_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.handleby#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_est#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_all#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_add#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.budget#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.delivery_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.achievement#">
            )
	</cfquery>
    
    <cfquery datasource="#dts#" name="insertartran">
			Insert into weikendecor_i.project 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn,completed,remark1,remark2,remark3,remark4,remark5
            ,com_id,com_name,wos_date,description,project_status,project_type,start_date,end_date,handleby,cost_est,cost_all,cost_add,budget,delivery_date,achievement
            )
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#"><cfif lcase(HcomID) eq 'taftc_i'>,'#form.WSQ#','#form.cprice#','#form.cdispec#','#form.camt#','#deposit#','#form.grantacc#','#form.urevenueacc#'</cfif>,<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_name#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wos_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_status#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_type#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.start_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.end_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.handleby#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_est#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_all#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_add#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.budget#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.delivery_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.achievement#">
            )
	</cfquery>
    <cfelseif lcase(HcomID) eq "weikendecor_i">
    		
            <cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn,DETAIL5,DETAIL6,DETAIL7,DETAIL8,DETAIL9,DETAIL10,DETAIL11,DETAIL12,completed,remark1,remark2,remark3,remark4,remark5,
            ,com_id,com_name,wos_date,description,project_status,project_type,start_date,end_date,handleby,cost_est,cost_all,cost_add,budget,delivery_date,achievement
            )
			values 
			('#form.source#', '#form.project#', '#form.porj#',  
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">,
			'#form.d5#','#form.d6#','#form.d7#','#form.d8#','#form.d9#','#form.d10#','#form.d11#','#form.d12#',<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_name#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wos_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_status#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_type#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.start_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.end_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.handleby#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_est#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_all#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_add#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.budget#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.delivery_date#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.achievement#">
            
            
            )
	</cfquery>
    
    
    <cfelse>
    <cfif lcase(HcomID) eq "donotti_i" or lcase(HcomID) eq "myid_i" or lcase(HcomID) eq "blve_i">
    <cfloop list="donotti_i,myid_i,blve_i" index="i">
    <cfquery datasource="#i#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn,completed)
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">
            ,<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>
            )
		</cfquery>
    </cfloop>
    <cfelse>
		<cfquery datasource="#dts#" name="insertartran">
			INSERT INTO #target_project# 
			(source,project,porj,creditsales,cashsales,salesreturn,purchase,purchasereturn<cfif lcase(HcomID) eq 'taftc_i'>,WSQ,cprice,cdispec,camt,bydeposit,grantacc,urevenueacc</cfif>,completed,remark1,remark2,remark3,remark4,remark5)
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#"><cfif lcase(HcomID) eq 'taftc_i'>,'#form.WSQ#','#form.cprice#','#form.cdispec#','#form.camt#','#deposit#','#form.grantacc#','#form.urevenueacc#'</cfif>,<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">
            )
		</cfquery>
        <!---
        <cfif isdefined('form.createams')>
        <cfset dts2=replace(dts,'_i','_a','all')>
        	<cfquery datasource="#dts2#" name="insertartranams">
			INSERT INTO #target_project# 
			(SOURCE,PROJECT,PORJ,COMPLETED,DATEFROM,DATETO,DATECOMM,DATEPREINS,DATEHANDOVER,PROJECTTEAM,STATUS,REMARK)
			values 
			('#form.source#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, '#form.porj#',
			<cfif isdefined('form.completed')>'Y'<cfelse>'N'</cfif>,
            '0000-00-00 00:00:00',
            '0000-00-00 00:00:00',
            '0000-00-00 00:00:00',
            '0000-00-00 00:00:00',
            '0000-00-00 00:00:00',
            "",
            "",
            ""
            )
			</cfquery>
        </cfif>--->
        
	</cfif>
   
    
    
    </cfif>
  	<cfset status="The #getgeneral.layer#, #form.source# had been successfully created. ">
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * FROM #target_project# where source='#form.source#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
         <cfif lcase(HcomID) eq "donotti_i" or lcase(HcomID) eq "myid_i" or lcase(HcomID) eq "blve_i">
            <cfloop list="donotti_i,myid_i,blve_i" index="i">
            <cfquery datasource='#i#' name="deleteitem">
	    		Delete FROM #target_project# where source='#form.source#'
	  		</cfquery>
            </cfloop>
            <cfelseif lcase(HcomID) eq 'weikeninv_i' or lcase(HcomID) eq 'weikenint_i' or lcase(HcomID) eq 'weikenbuilder_i' or lcase(HcomID) eq 'futurehome_i' or lcase(HcomID) eq 'weikenid_i' or lcase(HcomID) eq 'weikendecor_i'>
            
            <cfloop list="weikeninv_i,weikenint_i,weikenbuilder_i,futurehome_i,weikenid_i,weikendecor_i" index="i">
            <cfquery datasource='#i#' name="deleteitem">
	    		Delete FROM #target_project# where source='#form.source#'
	  		</cfquery>
            </cfloop>
            
            <cfelse>
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete FROM #target_project# where source='#form.source#'
	  		</cfquery>
            </cfif>
            
           
            
            
	  		<cfset status="The #getgeneral.layer#, #form.source# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">

	  		<cfif lcase(HcomID) eq "pls_i">
			 	<cfquery datasource='#dts#' name="updateproject">
					UPDATE #target_project# 
					set source='#form.source#',project ='#form.project#', porj='#form.porj#'
                    ,
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
                    purchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
                    purchasereturn =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">,
				 	DETAIL5='#form.d5#', DETAIL6='#form.d6#', DETAIL7='#form.d7#', DETAIL8='#form.d8#', DETAIL9='#form.d9#',
				  	DETAIL10='#form.d10#', DETAIL11='#form.d11#', DETAIL12='#form.d12#'
                    ,<cfif isdefined('form.completed')>completed='Y'<cfelse>completed='N'</cfif>
					where source = '#form.source#'
		  		</cfquery>
            <cfelseif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
            
            <cfloop list="weikeninv_i,weikenint_i,weikenbuilder_i,futurehome_i,weikenid_i,weikendecor_i" index="i">
            <cfquery datasource='#i#' name="updateproject">
					UPDATE #target_project# 
					set project =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, 
					porj='#form.porj#',
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
                    purchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
                    purchasereturn =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">,
                    remark1 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,
                    remark2 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,
                    remark3 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,
                    remark4 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,
                    remark5 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">
                    <cfif lcase(HcomID) eq 'taftc_i'>,WSQ = '#form.WSQ#',cprice = '#form.cprice#',cdispec = '#form.cdispec#',camt = '#form.camt#',bydeposit = '#deposit#',grantacc='#form.grantacc#',urevenueacc='#form.urevenueacc#'</cfif>
                    ,<cfif isdefined('form.completed')>completed='Y',<cfelse>completed='N',</cfif>
					
                    com_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_id#">,
                    com_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com_name#">,
                    wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wos_date#">,
                    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
                    project_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_status#">,
                    project_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_type#">,
                    start_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.start_date#">,
                    end_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.end_date#">,
                    handleby = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.handleby#">,
                    cost_est = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_est#">,
                    cost_all = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_all#">,
                    cost_add = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cost_add#">,
                    budget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.budget#">,  
                    delivery_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.delivery_date#">,   
                    achievement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.achievement#">
                    
                    where source = '#form.source#'
		  		</cfquery>
            </cfloop>
            
            <cfelse>
            <cfif lcase(HcomID) eq "donotti_i" or lcase(HcomID) eq "myid_i" or lcase(HcomID) eq "blve_i">
            <cfloop list="donotti_i,myid_i,blve_i" index="i">
            <cfquery datasource='#i#' name="updateproject">
					UPDATE #target_project# 
					set project =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, 
					porj='#form.porj#',
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
                    purchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
                    purchasereturn =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">
                    ,<cfif isdefined('form.completed')>completed='Y'<cfelse>completed='N'</cfif>
					where source = '#form.source#'
		  		</cfquery>
            </cfloop>
            <cfelse>
		  		<cfquery datasource='#dts#' name="updateproject">
					UPDATE #target_project# 
					set project =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">, 
					porj='#form.porj#',
                    creditsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.creditsales#">,
                    cashsales = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cashsales#">,
                    salesreturn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salesreturn#">,
                    purchase = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchase#">,
                    purchasereturn =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.purchasereturn#">,
                    remark1 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark1#">,
                    remark2 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark2#">,
                    remark3 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark3#">,
                    remark4 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark4#">,
                    remark5 =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark5#">
                    <cfif lcase(HcomID) eq 'taftc_i'>,WSQ = '#form.WSQ#',cprice = '#form.cprice#',cdispec = '#form.cdispec#',camt = '#form.camt#',bydeposit = '#deposit#',grantacc='#form.grantacc#',urevenueacc='#form.urevenueacc#'</cfif>
                    ,<cfif isdefined('form.completed')>completed='Y'<cfelse>completed='N'</cfif>
					where source = '#form.source#'
		  		</cfquery>
                </cfif>
                
                
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