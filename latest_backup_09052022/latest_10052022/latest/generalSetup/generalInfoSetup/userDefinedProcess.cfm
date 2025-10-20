<cfoutput>
    <cftry>	
        <cfquery name="updateUserDefined" datasource="#dts#">
            UPDATE userdefault
            SET
                inv_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.INVdesp)#">,
                do_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.DOdesp#">,
                so_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SOdesp#">,
                quo_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.QUOdesp#">,
                cs_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CSdesp#">,
                cn_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CNdesp#">,
                dn_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.DNdesp#">,
                po_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.POdesp#">,
                
                rq_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.RQdesp#">,
                pr_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PRdesp#">,
                rc_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.RCdesp#">
                
            WHERE company = 'IMS'; 
        </cfquery>
        
        <cfquery name="updateExtraRemark" datasource="#dts#">
            UPDATE extraremark
            SET
                <cfloop index="i" from="30" to="49">  
                	rem#i#= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.headerRemark#i#')#">,
                </cfloop>
                
                <cfloop index="i" from="30" to="49">  
                	remark#i#list= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.remark#i#list')#">,
                </cfloop>
                
                <cfloop index="i" from="0" to="11">  
                	trrem#i#= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.remark#i#')#"> <cfif i NEQ 11>,</cfif>
                </cfloop>
        </cfquery> 
        
        <cfquery name="updateGsetup" datasource="#dts#">
            UPDATE gsetup
            SET
            	refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refNo2#">,
                ldescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
				Lcategory=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lcategory#">,
                Lmodel=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lmodel#">,
                Lrating=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lrating#">,
                Lgroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lgroup#">,
                Lbrand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Lbrand#">,
                Lsize=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lsize#">,
                Lmaterial=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lmaterial#">,
                lAGENT=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lAGENT#">,
                lTEAM=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lTEAM#">,
                lDRIVER=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lDRIVER#">,
                lLOCATION=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lLOCATION#">,
                lPROJECT=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lPROJECT#">,
                lJOB=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lJOB#">,
                lterm=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lterm#">,
                bodyso=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bodyso#">,
                bodypo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bodypo#">,
                bodydo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bodydo#">,
                litemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.litemno#">,
                laitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.laitemno#">,
                lbarcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lbarcode#">,
                <cfloop index="i" from="5" to="11"> 
                	rem#i#= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.headerRemark#i#')#">,
                </cfloop>
                                
                <cfloop index="i" from="1" to="4">  
                	brem#i#= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.bodyRemark#i#')#">,
                </cfloop>
                <cfloop index="i" from="5" to="10">  
                	remark#i#list= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.remark#i#list')#">,
                </cfloop>
                <cfloop index="i" from="1" to="7">  
                	misccharge#i#= <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.miscCharge#i#')#"><cfif i NEQ 7>,</cfif>
                </cfloop>
                
        </cfquery> 
        
        
        <cfquery name="getmenulisting" datasource="main">
        	SELECT profile,profilecategory,menu_name,menu_id from menunew2
            WHERE profile<>"" and profilecategory="menu"
        </cfquery>
        
        <cfloop query="getmenulisting">
        <cfquery name="updateuserdefinedmenu" datasource="#dts#">
        	UPDATE userdefinedmenu SET 
            new_menu_name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#getmenulisting.profile#')# Profile"> 
            where menu_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getmenulisting.menu_id#"> 
        </cfquery>
        </cfloop>
        
        
        
        <cfquery name="getwordslisting" datasource="main">
        	SELECT id,profile,english,changewords from words
            WHERE profile<>""
        </cfquery>
        
        <cftry>
        <cfloop query="getwordslisting">
        
        <cfif evaluate('form.#getwordslisting.profile#') neq getwordslisting.changewords>
        
        <cfquery name="checkexistingwords" datasource="#dts#">
        	SELECT * from userdefinedwords
            where id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getwordslisting.id#"> 
        </cfquery>
        
        <cfset afterchangewords=evaluate('form.#getwordslisting.profile#')>
        <cfset afterchangewords2=replace('#getwordslisting.english#','#getwordslisting.changewords#','#afterchangewords#','all')>
        

        
        <cfif checkexistingwords.recordcount eq 0>
        
        <cfquery name="insertwords" datasource="#dts#">
        	INSERT IGNORE INTO userdefinedwords (id,userset) VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getwordslisting.id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#afterchangewords2#"> 
            )
        </cfquery>
        
        <cfelse>
        
        <cfquery name="updateuserdefinedwords" datasource="#dts#">
        	UPDATE userdefinedwords SET 
            userset=<cfqueryparam cfsqltype="cf_sql_varchar" value="#afterchangewords2#"> 
            where id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getwordslisting.id#"> 
        </cfquery>
        </cfif>
        
        
        </cfif>
        
        </cfloop>
        <cfcatch></cfcatch>
        </cftry>
        
     
    <cfcatch type="any">
        <script type="text/javascript">
            alert('Failed to update setup(s)!\nError Message: #cfcatch.message#');
            window.open('/latest/generalSetup/generalInfoSetup/userDefined.cfm','_self');
        </script>
    </cfcatch>
    </cftry>
    
    <script type="text/javascript">
        alert('Updated setup(s) successfully!');
        window.open('/latest/body/bodymenu.cfm?id=60100','_self');
    </script>	
</cfoutput>