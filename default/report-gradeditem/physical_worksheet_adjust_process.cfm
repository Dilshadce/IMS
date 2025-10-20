<cfset frgrade=11>
<cfset tograde=310>
<!--- Update the actual qty --->
<cfloop from="1" to="#form.totalrecord#" index="i">
	<cfquery name="updateitemgrd" datasource="#dts#">
		update itemgrd
		set
		<cfloop from="#frgrade#" to="#tograde-1#" index="j">
			CGRD#j# = #form["qtyactual_#i#_#j#"]#,
		</cfloop>
		CGRD#tograde# = #form["qtyactual_#i#_#tograde#"]#
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
	</cfquery>
	
	<!--- <cfquery name="updateitemgrd" datasource="#dts#">
		update logrdob
		set
		<cfloop from="11" to="69" index="j">
			CGRD#j# = #form["qtyactual_#i#_#j#"]#,
		</cfloop>
		CGRD70 = #form["qtyactual_#i#_70"]#
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
		and location = ''
	</cfquery> --->
	
	<cfquery name="updateicitem" datasource="#dts#">
		update icitem
		set qtyactual = #form["actualqty_#i#"]#
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
	</cfquery>
</cfloop>

<!--- If the GENERATE ADJUSTMENT TRANSACTIONS is checked --->
<cfif isdefined("form.generate_adjustment_transaction") and form.generate_adjustment_transaction eq "yes">
	
	<cfquery datasource="#dts#" name="getlastno_oai">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = 'OAI'
		and counter = 1
	</cfquery>

	<cfquery datasource="#dts#" name="getlastno_oar">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = 'OAR'
		and counter = 1
	</cfquery>
	
    <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno1">
			<cfinvokeargument name="input" value="#getlastno_oai.tranno#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastno_oai.tranno#" returnvariable="nexttranno1" />	
		</cfcatch>
        </cftry>
        
        <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno2">
			<cfinvokeargument name="input" value="#getlastno_oar.tranno#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastno_oar.tranno#" returnvariable="nexttranno2" />	
		</cfcatch>
        </cftry>
	
	<cfset oaino= "">
	<cfset oarno= "">
	<!--- <cfset oaitotal = 0>
	<cfset oartotal = 0> --->
	<cfset a = 1>
	<cfset b = 1>
	<cfloop from="1" to="#form.totalrecord#" index="i">
		<cfloop from="#frgrade#" to="#tograde#" index="j">
			<cfif val(form["balance_#i#_#j#"]) lt val(form["qtyactual_#i#_#j#"])>
				<cfif oaino neq nexttranno1>
					<cfset oaino = nexttranno1>
				
					<cfquery name="update_oai_running_no" datasource="#dts#">
						update refnoset set 
						lastUsedNo=UPPER('#nexttranno1#')
						where type = 'OAI'
						and counter = 1
					</cfquery>
				
					<cfquery name="insert_oai_into_artran" datasource="#dts#">
						insert ignore into artran 
						(type,refno,trancode,fperiod,wos_date,desp,currrate,currrate2,custno,name,trdatetime,userid,created_by,created_on,updated_by,updated_on)
						values
						('OAI','#nexttranno1#','1','#form.period#',#form.date#,'ADJUSTMENT','1','1','#HUserID#','ADJUSTMENT',#now()#,'#HUserID#','#HUserID#',#now()#,'#HUserID#',#now()#)
					</cfquery>
				</cfif>
				
				<cfquery name="check1" datasource="#dts#">
					select itemno from ictran
					where type = 'OAI' and refno = '#nexttranno1#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
				
				<cfset oaiqty = val(form["qtyactual_#i#_#j#"]) - val(form["balance_#i#_#j#"])>
				<cfset oaicost = form["ucost_#i#"]>
				<cfif check1.recordcount neq 0>
					<cfquery name="updateictran" datasource="#dts#">
						update ictran
						set qty_bil = qty_bil + #oaiqty#,
						qty = qty + #oaiqty#
						where type = 'OAI' and refno = '#nexttranno1#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					</cfquery>
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#j# = #oaiqty#
						where type = 'OAI' and refno = '#nexttranno1#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					</cfquery>
				<cfelse>
					<cfquery name="insert_oai_into_ictran" datasource="#dts#">
						insert ignore into ictran 
						(type,refno,trancode,fperiod,wos_date,currrate,
						itemcount,itemno,desp,unit,unit_bil,qty_bil,price_bil,
						qty,price,name,factor1,factor2) 
						values 
						('OAI','#nexttranno1#',#a#,'#form.period#',#form.date#,'1',
						#a#,<cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["itemdesp_#i#"]#">,'#form["unit_#i#"]#','#form["unit_#i#"]#',
						#oaiqty#,'#oaicost#',#oaiqty#,'#oaicost#','ADJUSTMENT','1','1')	
					</cfquery>
					
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#j#)
						values
						('OAI','#nexttranno1#',#a#,'#form.period#',#form.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">,
						'1','1','1',#oaiqty#)
					</cfquery>
					<cfset a = a + 1>
				</cfif>
				
				<cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#j# = bgrd#j# + #oaiqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
				
				<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#j# = bgrd#j# + #oaiqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					and location = ''
				</cfquery>
				
				<cfquery name="updateicitem" datasource="#dts#">
					update icitem
					set qin#val(form.period)+10#=(qin#val(form.period)+10#+#oaiqty#)
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
			<cfelseif val(form["balance_#i#_#j#"]) gt val(form["qtyactual_#i#_#j#"])>
				<cfif oarno neq nexttranno2>
					<cfset oarno = nexttranno2>
				
					<cfquery name="update_oar_running_no" datasource="#dts#">
						update refnoset set 
						lastUsedNo=UPPER('#nexttranno2#')
						where type = 'OAR'
						and counter = 1
					</cfquery>
				
					<cfquery name="insert_oar_into_artran" datasource="#dts#">
						insert ignore into artran 
						(type,refno,trancode,fperiod,wos_date,desp,currrate,currrate2,custno,name,trdatetime,userid,created_by,created_on,updated_by,updated_on)
						values
						('OAR','#nexttranno2#','1','#form.period#',#form.date#,'ADJUSTMENT','1','1','#HUserID#','ADJUSTMENT',#now()#,'#HUserID#','#HUserID#',#now()#,'#HUserID#',#now()#)
					</cfquery>
				</cfif>
				
				<cfquery name="check2" datasource="#dts#">
					select itemno from ictran
					where type = 'OAR' and refno = '#nexttranno2#'
					and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
				
				<cfset oarqty = val(form["balance_#i#_#j#"]) - val(form["qtyactual_#i#_#j#"])>
				<cfset oarcost = form["ucost_#i#"]>
				<cfif check2.recordcount neq 0>
					<cfquery name="updateictran" datasource="#dts#">
						update ictran
						set qty_bil = qty_bil + #oarqty#,
						qty = qty + #oarqty#
						where type = 'OAR' and refno = '#nexttranno2#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					</cfquery>
					<cfquery name="updateigrade" datasource="#dts#">
						update igrade
						set GRD#j# = #oarqty#
						where type = 'OAR' and refno = '#nexttranno2#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					</cfquery>
				<cfelse>
					<cfquery name="insert_oar_into_ictran" datasource="#dts#">
						insert ignore into ictran 
						(type,refno,trancode,fperiod,wos_date,currrate,
						itemcount,itemno,desp,unit,unit_bil,qty_bil,price_bil,
						qty,price,name,factor1,factor2) 
						values 
						('OAR','#nexttranno2#',#b#,'#form.period#',#form.date#,'1',
						#b#,<cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["itemdesp_#i#"]#">,'#form["unit_#i#"]#','#form["unit_#i#"]#',
						#oarqty#,'#oarcost#',#oarqty#,'#oarcost#','ADJUSTMENT','1','1')	
					</cfquery>
					
					<cfquery name="insertigrade" datasource="#dts#">
						insert into igrade
						(type,refno,trancode,fperiod,wos_date,itemno,sign,factor1,factor2,GRD#j#)
						values
						('OAR','#nexttranno2#',#b#,'#form.period#',#form.date#,<cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">,
						'-1','1','1',#oarqty#)
					</cfquery>
					<cfset b = b + 1>
				</cfif>
				
				<cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set bgrd#j# = bgrd#j# - #oarqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
				
				<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set bgrd#j# = bgrd#j# - #oarqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
					and location = ''
				</cfquery>
				
				<cfquery name="updateicitem" datasource="#dts#">
					update icitem
					set qout#val(form.period)+10#=(qout#val(form.period)+10#+#oarqty#)
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form["itemno_#i#"]#">
				</cfquery>
			</cfif>
		</cfloop>
	</cfloop>
	
	<cfif oaino neq "">
		<cfquery name="updatesubtotal" datasource="#dts#">
			update ictran
			set amt1_bil = qty * price,
			amt_bil = qty * price,
			amt1 = qty * price,
			amt = qty * price
			where type = 'OAI' and refno = '#oaino#'
		</cfquery>
		<cfquery name="updatetotal" datasource="#dts#">
			update artran a,(select sum(amt) as sumamt,type,refno from ictran where type = 'OAI' and refno = '#oaino#' group by type,refno) as b
			set a.gross_bil = b.sumamt,
			a.net_bil = b.sumamt,
			a.grand_bil = b.sumamt,
			a.invgross = b.sumamt,
			a.net = b.sumamt,
			a.grand = b.sumamt
			where a.type = b.type
			and a.refno = b.refno
			and a.type = 'OAI' 
			and a.refno = '#oaino#'
		</cfquery>
	</cfif>
	
	<cfif oarno neq "">
		<cfquery name="updatesubtotal" datasource="#dts#">
			update ictran
			set amt1_bil = qty * price,
			amt_bil = qty * price,
			amt1 = qty * price,
			amt = qty * price
			where type = 'OAR' and refno = '#oarno#'
		</cfquery>
		
		<cfquery name="updatetotal" datasource="#dts#">
			update artran a,(select sum(amt) as sumamt,type,refno from ictran where type = 'OAR' and refno = '#oarno#' group by type,refno) as b
			set a.gross_bil = b.sumamt,
			a.net_bil = b.sumamt,
			a.grand_bil = b.sumamt,
			a.invgross = b.sumamt,
			a.net = b.sumamt,
			a.grand = b.sumamt
			where a.type = b.type
			and a.refno = b.refno
			and a.type = 'OAR' 
			and a.refno = '#oarno#'
		</cfquery>
	</cfif>
	
	<script language="javascript" type="text/javascript">
		alert("Adjustment Process Done !");
		window.close();
	</script>
<cfelse>
	<script language="javascript" type="text/javascript">
		window.close();
	</script>
</cfif>