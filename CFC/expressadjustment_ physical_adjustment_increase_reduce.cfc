<cfcomponent>
	<cffunction name="update_icitem_qtyactual">
		<cfargument name="dts" required="yes" type="any">
		<cfargument name="form" required="yes" type="struct">
        <cfargument name="huserid" required="yes" type="any">
		<cfparam name="tranoai" default="">
		<cfparam name="tranoar" default="">
		<cfparam name="oaisql" default="">
		<cfparam name="oarsql" default="">
		<cfparam name="oaitotal" default=0>
		<cfparam name="oartotal" default=0>
        
         <cfquery name="getgeneral" datasource="#dts#">
                SELECT autolocbf FROM gsetup
                </cfquery>
        
        <cfif form.mode eq 'Create'>
		
		<cfquery name="get_running_no" datasource="#arguments.dts#">
			select lastusedno as oaino,(select lastusedno as oaino from refnoset where counter = "1" and type = "OAR") as oarno from refnoset where counter = "1" and type = "OAI"   
		</cfquery>
		
		
       <cfset refnocheck = 0>
		<cfset refno1 = get_running_no.oaino>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno1">
			<cfinvokeargument name="input" value="#refno1#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.oaino#" returnvariable="nexttranno1" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno1#"> and type = 'OAI'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = nexttranno1>
		</cfif>
        </cfloop>
        
		
		<cfset refnocheck2 = 0>
		<cfset refno2 = get_running_no.oarno>
        <cfloop condition="refnocheck2 eq 0">
        <cftry>
       <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno2">
			<cfinvokeargument name="input" value="#refno2#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.oarno#" returnvariable="nexttranno2" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno2#"> and type = 'OAR'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck2 = 1>
        <cfelse>
        <cfset refno2 = nexttranno2>
		</cfif>
        </cfloop>
        
        <cfquery name="getlocadj" datasource="#dts#">
        select * from locadjtran where uuid='#form.uuid#' and refno='#form.refno#'
        </cfquery>
        
        
        <cfif getlocadj.recordcount neq 0>
        <cfset a=1>
        <cfset b=1>
		<cfloop query="getlocadj">
        
       
        <cfquery name="getgradeadj" datasource="#dts#">
        select * from expressadjtrangrd where uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        
        
        <cfif getgradeadj.recordcount gt 0>
        <!---Item with grade --->
        
        <cfquery name="getsumadjincrease" datasource="#dts#">
        select sum(adjqty) as adjqty from expressadjtrangrd where adjqty < 0 and uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        <!--- increase grade--->
        <cfif val(getsumadjincrease.adjqty) neq 0>
        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
						,icitem.qin#val(getlocadj.period)+10#=(icitem.qin#val(getlocadj.period)+10#+#abs(getsumadjincrease.adjqty)#)
						<cfset tranoai = "y">
						<cfset oaiqty = abs(getsumadjincrease.adjqty)>
						<cfset oaicost = getlocadj.ucost>
						<cfset oaisubtotal = oaiqty * oaicost>
						<cfset oaitotal = oaitotal + oaisubtotal>
						<cfset oaisql= oaisql&"("&chr(34)&"OAI"&chr(34)&","&chr(34)&nexttranno1&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
                   
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
		</cfquery>
        </cfif>
        <cfquery name="getsumadjreduce" datasource="#dts#">
        select sum(adjqty) as adjqty from expressadjtrangrd where adjqty > 0 and uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        
        <!--- reduce grade--->
        <cfif val(getsumadjreduce.adjqty) neq 0>
        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
						,icitem.qout#val(getlocadj.period)+10#=(icitem.qout#val(getlocadj.period)+10#+#abs(getsumadjreduce.adjqty)#)
						<cfset tranoar = "y">
						<cfset oarqty = abs(getsumadjreduce.adjqty)>
						<cfset oarcost = getlocadj.ucost>
						<cfset oarsubtotal = oarqty * oarcost>
						<cfset oartotal = oartotal + oarsubtotal>
						<cfset oarsql= oarsql&"("&chr(34)&"OAR"&chr(34)&","&chr(34)&nexttranno2&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
		</cfquery>
        </cfif>
        
        
        
        <!--- grade adjustment--->
        <cfloop query="getgradeadj">
        
        
        <cfif adjqty gt 0>
        <!---grade reduce--->
        
        <cfquery name="checkgrade2" datasource="#dts#">
					select itemno,location from igrade
					where type = 'OAR' and refno = '#nexttranno2#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
				</cfquery>
				
				<cfif checkgrade2.recordcount neq 0>
					
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#getgradeadj.grade# = #getgradeadj.adjqty#
						where type = 'OAR' and refno = '#nexttranno2#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
					</cfquery>
				<cfelse>
					
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#getgradeadj.grade#,location)
						values
						('OAR','#nexttranno2#',#a#,'#getlocadj.period#',#getlocadj.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">,
						'-1','1','1',#getgradeadj.adjqty#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">)
					</cfquery>
					
				</cfif>
				
				<cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# - #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
				</cfquery>
				
				<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# - #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
				</cfquery>
        
        
        <cfelse>
        <!---grade increase--->
        <cfset getgradeadj.adjqty=abs(getgradeadj.adjqty)>
        <cfquery name="checkgrade1" datasource="#dts#">
					select itemno,location from igrade
					where type = 'OAI' and refno = '#nexttranno1#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
		</cfquery>
       
        <cfif checkgrade1.recordcount neq 0>
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#getgradeadj.grade# = #getgradeadj.adjqty#
						where type = 'OAI' and refno = '#nexttranno1#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
					</cfquery>
				<cfelse>
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#getgradeadj.grade#,location)
						values
						('OAI','#nexttranno1#',#a#,'#getlocadj.period#',#getlocadj.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">,
						'1','1','1',#getgradeadj.adjqty#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">)
					</cfquery>
		</cfif>
        
        <cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# + #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
				</cfquery>
				
		<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# + #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
		</cfquery>
        
        
        </cfif>
        
        </cfloop>
        <cfset a = a + 1>
            <!---End grade adjustment--->
        
        <cfelse>
        

        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
					
					<cfif val(getlocadj.qtyonhand) lt val(getlocadj.qtyactual)>
						,icitem.qin#val(getlocadj.period)+10#=(icitem.qin#val(getlocadj.period)+10#+#abs(getlocadj.qtydiff)#)
						<cfset tranoai = "y">
						<cfset oaiqty = abs(getlocadj.qtydiff)>
						<cfset oaicost = getlocadj.ucost>
						<cfset oaisubtotal = oaiqty * oaicost>
						<cfset oaitotal = oaitotal + oaisubtotal>
						<cfset oaisql= oaisql&"("&chr(34)&"OAI"&chr(34)&","&chr(34)&nexttranno1&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
                        
                        
					<cfelseif val(getlocadj.qtyonhand) gt val(getlocadj.qtyactual)>
						,icitem.qout#val(getlocadj.period)+10#=(icitem.qout#val(getlocadj.period)+10#+#abs(getlocadj.qtydiff)#)
						<cfset tranoar = "y">
						<cfset oarqty = abs(getlocadj.qtydiff)>
						<cfset oarcost = getlocadj.ucost>
						<cfset oarsubtotal = oarqty * oarcost>
						<cfset oartotal = oartotal + oarsubtotal>
						<cfset oarsql= oarsql&"("&chr(34)&"OAR"&chr(34)&","&chr(34)&nexttranno2&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
					</cfif> 
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
				</cfquery>
        <cfset a=a+1>
        
        </cfif>
        
        </cfloop>
            
			<cfif tranoai eq "y">
				<cfquery name="update_oai_running_no" datasource="#arguments.dts#">
					update refnoset set
					lastusedno='#nexttranno1#'
                    WHERE type = "OAI" and counter = "1";
				</cfquery>
				
				<cfif right(oaisql,1) eq ",">
					<cfset oaisql = removechars(oaisql,len(oaisql),1)>
				<cfelse>
					<cfset oaisql = oaisql>
				</cfif>
				
				<!--- <cfset oaisql = iif((right(oaisql,1) eq ","),DE(removechars(oaisql,len(oaisql),1)),DE(oaisql))> --->
				
				<cfquery name="insert_oai_into_artran" datasource="#arguments.dts#">
					insert ignore into artran 
					(
						type,
						refno,
                        refno2,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						credit_bil,
						invgross,
						net,
						grand,
						creditamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAI',
						'#nexttranno1#',
                        '#form.refno#',
						'1',
						'#getlocadj.period#',
						'#lsdateformat(getlocadj.date,"yyyy-mm-dd")#',
						'ADJUSTMENT',
						'1',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'1',
						'ADJUSTMENT',
                        '#arguments.huserid#',
                        '#arguments.huserid#',
                        now()
					);
				</cfquery>
                
               
               
				
				<cfquery name="insert_oai_into_ictran" datasource="#arguments.dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name,
						location
					) 
					values 
					#oaisql#;
				</cfquery>
                
                 <cfif getgeneral.autolocbf eq "Y">
                <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno1#" type="OAI" returnvariable="done" />
                </cfif>
                
                 <cfquery name="update_ictran" datasource="#arguments.dts#">
                update ictran set trdatetime=now() where type='OAI' and refno='#nexttranno1#'
                </cfquery>
			</cfif>
			
			<cfif tranoar eq "y">
				<cfquery name="update_oar_running_no" datasource="#arguments.dts#">
					update refnoset SET
					lastusedno='#nexttranno2#'
                    WHERE type = "OAR" and counter = "1"
				</cfquery>
				
				<cfif right(oarsql,1) eq ",">
					<cfset oarsql = removechars(oarsql,len(oarsql),1)>
				<cfelse>
					<cfset oarsql = oarsql>
				</cfif>
				
				<!--- <cfset oarsql = iif((right(oarsql,1) eq ","),DE(removechars(oarsql,len(oarsql),1)),DE(oarsql))> --->
				
				<cfquery name="insert_oar_into_artran" datasource="#arguments.dts#">
					insert ignore into artran 
					(
						type,
						refno,
                        refno2,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						debit_bil,
						invgross,
						net,
						grand,
						debitamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAR',
						'#nexttranno2#',
                        '#form.refno#',
						'1',
						'#getlocadj.period#',
						'#lsdateformat(getlocadj.date,"yyyy-mm-dd")#',
						'ADJUSTMENT',
						'1',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'1',
						'ADJUSTMENT',
                        '#arguments.huserid#',
                        '#arguments.huserid#',
                        now()
                        
					);
				</cfquery>
                
                 
				
				<cfquery name="insert_oar_into_ictran" datasource="#arguments.dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name,
						location
					) 
					values 
					#oarsql#;
				</cfquery>
                
                <cfif getgeneral.autolocbf eq "Y">
                <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno2#" type="OAR" returnvariable="done" />
                </cfif>
                <cfquery name="update_ictran" datasource="#arguments.dts#">
                update ictran set trdatetime=now() where type='OAR' and refno='#nexttranno2#'
                </cfquery>
			</cfif>
</cfif>
				<cfquery name="update_ictran" datasource="#arguments.dts#">
                update locadjtran set oarrefno=<cfif tranoar eq "y">'#nexttranno2#'<cfelse>''</cfif>,oairefno=<cfif tranoai eq "y">'#nexttranno1#'<cfelse>''</cfif> where uuid='#form.uuid#' and refno='#form.refno#'
                </cfquery>
                
		<cfelseif form.mode eq 'edit'>

        <cfquery name="getlocadj" datasource="#dts#">
        select * from locadjtran where uuid='#form.uuid#' and refno='#form.refno#'
        </cfquery>
        
        <cfquery name="updateartran" datasource="#dts#">
        update artran set fperiod='#getlocadj.period#',wos_date='#lsdateformat(getlocadj.date,"yyyy-mm-dd")#' where refno='#getlocadj.oairefno#' and type='OAI'
        </cfquery>
        
        <cfquery name="updateictran" datasource="#dts#">
        update ictran set fperiod='#getlocadj.period#',wos_date='#lsdateformat(getlocadj.date,"yyyy-mm-dd")#' where refno='#getlocadj.oairefno#' and type='OAI'
        </cfquery>
        
        <cfquery name="updateartran2" datasource="#dts#">
        update artran set fperiod='#getlocadj.period#',wos_date='#lsdateformat(getlocadj.date,"yyyy-mm-dd")#' where refno='#getlocadj.oarrefno#' and type='OAR'
        </cfquery>
        
        <cfquery name="updateictran2" datasource="#dts#">
        update ictran set fperiod='#getlocadj.period#',wos_date='#lsdateformat(getlocadj.date,"yyyy-mm-dd")#'where refno='#getlocadj.oarrefno#' and type='OAR'
        </cfquery>
        <!---
        <cfif getlocadj.recordcount neq 0>
        <cfquery name="getlocadjrefno" datasource="#dts#">
        select * from locadjtran where uuid='#form.uuid#' and refno='#form.refno#'  and (oarrefno!='' or oairefno!='')
        </cfquery>
        
        <cfset nexttranno2=getlocadjrefno.oarrefno>
        <cfset nexttranno1=getlocadjrefno.oairefno>
        
        <cfquery name="getmaxtrancode" datasource="#dts#">
        select max(trancode) as trancode from (
        select * from ictran where refno='#nexttranno1#' and type='OAI'
        UNION ALL
        select * from ictran where refno='#nexttranno2#' and type='OAR'
        )
        </cfquery>
        <cfset a=val(getmaxtrancode.trancode)+1>
        
        
        <cfquery name="get_running_no" datasource="#arguments.dts#">
			select lastusedno as oaino,(select lastusedno as oaino from refnoset where counter = "1" and type = "OAR") as oarno from refnoset where counter = "1" and type = "OAI"   
		</cfquery>
        
		<cfloop query="getlocadj">
        
        <cfquery name="checkoaiexist" datasource="#dts#">
        select * from ictran where refno='#nexttranno1#' and itemno='#getlocadj.itemno#' and type='OAI'
        </cfquery>
        
        <cfquery name="checkoarexist" datasource="#dts#">
        select * from ictran where refno='#nexttranno2#' and itemno='#getlocadj.itemno#' and type='OAR'
        </cfquery>
        
        <cfif checkoarexist.recordcount eq 0 and checkoaiexist.recordcount eq 0>
        
        <cfquery name="getgradeadj" datasource="#dts#">
        select * from expressadjtrangrd where uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        
        
        <cfif getgradeadj.recordcount gt 0>
        <!---Item with grade --->
        
        <cfquery name="getsumadjincrease" datasource="#dts#">
        select sum(adjqty) as adjqty from expressadjtrangrd where adjqty < 0 and uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        <!--- increase grade--->
        <cfif val(getsumadjincrease.adjqty) neq 0>
        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
						,icitem.qin#val(getlocadj.period)+10#=(icitem.qin#val(getlocadj.period)+10#+#abs(getsumadjincrease.adjqty)#)
						<cfset tranoai = "y">
						<cfset oaiqty = abs(getsumadjincrease.adjqty)>
						<cfset oaicost = getlocadj.ucost>
						<cfset oaisubtotal = oaiqty * oaicost>
						<cfset oaitotal = oaitotal + oaisubtotal>
						<cfset oaisql= oaisql&"("&chr(34)&"OAI"&chr(34)&","&chr(34)&nexttranno1&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
                   
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
		</cfquery>
        </cfif>
        <cfquery name="getsumadjreduce" datasource="#dts#">
        select sum(adjqty) as adjqty from expressadjtrangrd where adjqty > 0 and uuid='#form.uuid#' and itemno='#getlocadj.itemno#' and location='#getlocadj.location#'
        </cfquery>
        
        <!--- reduce grade--->
        <cfif val(getsumadjreduce.adjqty) neq 0>
        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
						,icitem.qout#val(getlocadj.period)+10#=(icitem.qout#val(getlocadj.period)+10#+#abs(getsumadjreduce.adjqty)#)
						<cfset tranoar = "y">
						<cfset oarqty = abs(getsumadjreduce.adjqty)>
						<cfset oarcost = getlocadj.ucost>
						<cfset oarsubtotal = oarqty * oarcost>
						<cfset oartotal = oartotal + oarsubtotal>
						<cfset oarsql= oarsql&"("&chr(34)&"OAR"&chr(34)&","&chr(34)&nexttranno2&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
		</cfquery>
        </cfif>
        <cfset a=a+1>
        
        
        
        <!--- grade adjustment--->
        <cfloop query="getgradeadj">
        
        
        <cfif adjqty gt 0>
        <!---grade reduce--->
        
        <cfquery name="checkgrade2" datasource="#dts#">
					select itemno,location from ictran
					where type = 'OAR' and refno = '#nexttranno2#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
				</cfquery>
				
				<cfif checkgrade2.recordcount neq 0>
					
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#getgradeadj.grade# = #getgradeadj.adjqty#
						where type = 'OAR' and refno = '#nexttranno2#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
					</cfquery>
				<cfelse>
					
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#getgradeadj.grade#,location)
						values
						('OAR','#nexttranno2#',#a#,'#getlocadj.period#',#getlocadj.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">,
						'-1','1','1',#getgradeadj.adjqty#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">)
					</cfquery>
					<cfset a = a + 1>
				</cfif>
				
				<cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# - #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
				</cfquery>
				
				<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# - #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
				</cfquery>
        
        
        <cfelse>
        <!---grade increase--->
        <cfset getgradeadj.adjqty=abs(getgradeadj.adjqty)>
        <cfquery name="checkgrade1" datasource="#dts#">
					select itemno,location from igrade
					where type = 'OAI' and refno = '#nexttranno1#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
		</cfquery>
       
        <cfif checkgrade1.recordcount neq 0>
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#getgradeadj.grade# = #getgradeadj.adjqty#
						where type = 'OAI' and refno = '#nexttranno1#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
					</cfquery>
				<cfelse>
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#getgradeadj.grade#,location)
						values
						('OAI','#nexttranno1#',#a#,'#getlocadj.period#',#getlocadj.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">,
						'1','1','1',#getgradeadj.adjqty#,<cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">)
					</cfquery>
		</cfif>
        
        <cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# + #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
				</cfquery>
				
		<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#getgradeadj.grade# = bgrd#getgradeadj.grade# + #getgradeadj.adjqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getgradeadj.location#">
		</cfquery>
        
        
        </cfif>
        
        </cfloop>
            <!---End grade adjustment--->
        
        <cfelse>
        
        
        
        <cfquery name="update_icitem" datasource="#arguments.dts#">
					update icitem,locqdbf set 
					locqdbf.locqactual='#getlocadj.qtyactual#'
					
					<cfif val(getlocadj.qtyonhand) lt val(getlocadj.qtyactual)>
						,icitem.qin#val(getlocadj.period)+10#=(icitem.qin#val(getlocadj.period)+10#+#abs(getlocadj.qtydiff)#)
						<cfset tranoai = "y">
						<cfset oaiqty = abs(getlocadj.qtydiff)>
						<cfset oaicost = getlocadj.ucost>
						<cfset oaisubtotal = oaiqty * oaicost>
						<cfset oaitotal = oaitotal + oaisubtotal>
						<cfset oaisql= oaisql&"("&chr(34)&"OAI"&chr(34)&","&chr(34)&nexttranno1&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
					<cfelseif val(getlocadj.qtyonhand) gt val(getlocadj.qtyactual)>
						,icitem.qout#val(getlocadj.period)+10#=(icitem.qout#val(getlocadj.period)+10#+#abs(getlocadj.qtydiff)#)
						<cfset tranoar = "y">
						<cfset oarqty = abs(getlocadj.qtydiff)>
						<cfset oarcost = getlocadj.ucost>
						<cfset oarsubtotal = oarqty * oarcost>
						<cfset oartotal = oartotal + oarsubtotal>
						<cfset oarsql= oarsql&"("&chr(34)&"OAR"&chr(34)&","&chr(34)&nexttranno2&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&getlocadj.period&chr(34)&","&chr(34)&lsdateformat(getlocadj.date,"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&a&chr(34)&","&chr(34)&jsstringformat(getlocadj.itemno)&chr(34)&","&chr(34)&jsstringformat(getlocadj.desp)&chr(34)&","&chr(34)&jsstringformat(getlocadj.unit)&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&"ADJUSTMENT"&chr(34)&","&chr(34)&jsstringformat(getlocadj.location)&chr(34)&")"&iif(a neq getlocadj.recordcount,DE(","),DE(""))>
					</cfif> 
					where locqdbf.itemno='#getlocadj.itemno#'
					and locqdbf.itemno=icitem.itemno
					and locqdbf.location='#getlocadj.location#'
				</cfquery>
        <cfset a=a+1>
        
        </cfif>
        </cfif>
        </cfloop>
            
				
				<cfif right(oaisql,1) eq ",">
					<cfset oaisql = removechars(oaisql,len(oaisql),1)>
				<cfelse>
					<cfset oaisql = oaisql>
				</cfif>
				<cfif oaisql neq ''>
                <!---If adjustment increase not created--->
                <cfif nexttranno1 eq ''>
				<cfset refnocheck = 0>
                <cfset refno1 = get_running_no.oaino>
                <cfloop condition="refnocheck eq 0">
                <cftry>
                <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno1">
                    <cfinvokeargument name="input" value="#refno1#">
                </cfinvoke>
                <cfcatch>
                <cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.oaino#" returnvariable="nexttranno1" />	
                </cfcatch>
                </cftry>
                <cfquery name="checkexistence" datasource="#dts#">
                SELECT refno FROM artran WHERE 
                refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno1#"> and type = 'OAI'
                </cfquery>
                <cfif checkexistence.recordcount eq 0>
                <cfset refnocheck = 1>
                <cfelse>
                <cfset refno1 = nexttranno1>
                </cfif>
                </cfloop>
                </cfif>
                <!--- --->
                
                <cfquery name="insert_oai_into_artran" datasource="#arguments.dts#">
					insert ignore into artran 
					(
						type,
						refno,
                        refno2,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						credit_bil,
						invgross,
						net,
						grand,
						creditamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAI',
						'#nexttranno1#',
                        '#form.refno#',
						'1',
						'#getlocadj.period#',
						'#lsdateformat(getlocadj.date,"yyyy-mm-dd")#',
						'ADJUSTMENT',
						'1',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'1',
						'ADJUSTMENT',
                        '#arguments.huserid#',
                        '#arguments.huserid#',
                        now()
					);
				</cfquery>
				<cfquery name="insert_oai_into_ictran" datasource="#arguments.dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name,
						location
					) 
					values 
					#oaisql#;
				</cfquery>
                 <cfquery name="update_ictran" datasource="#arguments.dts#">
                update ictran set trdatetime=now() where type='OAI' and refno='#nexttranno1#'
                </cfquery>
				</cfif>
                
				<cfif right(oarsql,1) eq ",">
					<cfset oarsql = removechars(oarsql,len(oarsql),1)>
				<cfelse>
					<cfset oarsql = oarsql>
				</cfif>
				<cfif oarsql neq ''>
                <!---If adjustment reduce not created--->
                <cfif nexttranno2 eq ''>
				<cfset refnocheck2 = 0>
                <cfset refno2 = get_running_no.oarno>
                <cfloop condition="refnocheck2 eq 0">
                <cftry>
               <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno2">
                    <cfinvokeargument name="input" value="#refno2#">
                </cfinvoke>
                <cfcatch>
                <cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.oarno#" returnvariable="nexttranno2" />	
                </cfcatch>
                </cftry>
                <cfquery name="checkexistence" datasource="#dts#">
                SELECT refno FROM artran WHERE 
                refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno2#"> and type = 'OAR'
                </cfquery>
                <cfif checkexistence.recordcount eq 0>
                <cfset refnocheck2 = 1>
                <cfelse>
                <cfset refno2 = nexttranno2>
                </cfif>
                </cfloop>
                </cfif>
                <!--- --->
                
                <cfquery name="insert_oar_into_artran" datasource="#arguments.dts#">
					insert ignore into artran 
					(
						type,
						refno,
                        refno2,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						debit_bil,
						invgross,
						net,
						grand,
						debitamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAR',
						'#nexttranno2#',
                        '#form.refno#',
						'1',
						'#getlocadj.period#',
						'#lsdateformat(getlocadj.date,"yyyy-mm-dd")#',
						'ADJUSTMENT',
						'1',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'1',
						'ADJUSTMENT',
                        '#arguments.huserid#',
                        '#arguments.huserid#',
                        now()
                        
					);
				</cfquery>
                
				<cfquery name="insert_oar_into_ictran" datasource="#arguments.dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name,
						location
					) 
					values 
					#oarsql#;
				</cfquery>
                <cfquery name="update_ictran" datasource="#arguments.dts#">
                update ictran set trdatetime=now() where type='OAR' and refno='#nexttranno2#'
                </cfquery>
</cfif>
            </cfif>
            <cfquery name="update_ictran" datasource="#arguments.dts#">
                update locadjtran set oarrefno='#nexttranno2#',oairefno='#nexttranno1#' where uuid='#form.uuid#' and refno='#form.refno#'
                </cfquery>
				--->
            <cfelseif form.mode eq 'delete'>
            
        <cfquery name="getlocadj" datasource="#dts#">
        select * from locadjtran where uuid='#form.uuid#' and refno='#form.refno#'
        </cfquery>
        
        <cfif getlocadj.recordcount neq 0>
        
        <cfquery name="deleteoai" datasource="#dts#">
        delete from ictran where refno='#getlocadj.oairefno#' and type='OAI'
        </cfquery>
        
        <cfquery name="deleteoar" datasource="#dts#">
        delete from ictran where refno='#getlocadj.oarrefno#' and type='OAR'
        </cfquery>
        
        <cfquery name="deleteoai2" datasource="#dts#">
        delete from artran where refno='#getlocadj.oairefno#' and type='OAI'
        </cfquery>
        
        <cfquery name="deleteoar2" datasource="#dts#">
        delete from artran where refno='#getlocadj.oarrefno#' and type='OAR'
        </cfquery>
        
        <cfquery name="deleteoar2" datasource="#dts#">
        delete from locadjtran where uuid='#form.uuid#' and refno='#form.refno#'
        </cfquery>
        
        <cfquery name="deleteoai3" datasource="#dts#">
        delete from igrade where refno='#getlocadj.oairefno#' and type='OAI'
        </cfquery>
        
        <cfquery name="deleteoar3" datasource="#dts#">
        delete from igrade where refno='#getlocadj.oarrefno#' and type='OAR'
        </cfquery>
        
        <cfquery name="deleteoai4" datasource="#dts#">
        delete from expressadjtrangrd where uuid='#getlocadj.uuid#'
        </cfquery>
        
        <cfquery name="deleteoar4" datasource="#dts#">
        delete from expressadjtrangrd where uuid='#getlocadj.uuid#'
        </cfquery>

        </cfif></cfif>
	</cffunction>
</cfcomponent>