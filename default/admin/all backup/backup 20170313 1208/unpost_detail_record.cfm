<cfquery name="getdetails" datasource="#dts#">
	select 
	* 
	from ictran 
	where type='#gettran.type#' 
	and refno='#gettran.refno#' 
	<!--- and amt<>'0.00' --->;
</cfquery>

<cfloop query="getdetails">
	<cfif getdetails.linecode eq "SV">
		<cfquery name="getservi" datasource="#dts#">
			select 
			#getacc# as result 
			from icservi 
			where servi='#getdetails.itemno#';
		</cfquery>
		
		<cfif getservi.recordcount eq 0>
			<h3>Error. This Service is not existing in the Service Profile. Please key in now in order to continue.</h3>
			<cfabort>					
		<cfelse>
			<cfif getservi.result neq "" and getservi.result neq "0000/000">
				<cfset accno = getservi.result>
			<cfelse>
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
				<cfelse>
					<cfif getdetails.type eq "INV">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "DN">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "CN">
						<cfset accno = getaccno.salesreturn>
					<cfelseif getdetails.type eq "PR">
						<cfset accno = getaccno.purchasereturn>
					<cfelseif getdetails.type eq "RC">
						<cfset accno = getaccno.purchasereceive>
					<cfelseif getdetails.type eq "CS">
						<cfset accno = getaccno.cashsales>
					</cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">		
					</cfif>
				</cfif>					
			</cfif>
		</cfif>
	<cfelse> <!--- for item --->
		<cfquery name="getitem" datasource="#dts#">
			select 
			wos_group,
			<cfif getdetails.type eq "PR">
				purprec 
			<cfelse>
				#getacc# 
			</cfif>as result 
			from icitem 
			where itemno='#getdetails.itemno#';
		</cfquery>
		
		<cfif getitem.wos_group neq "">
			<cfquery name="getgroup" datasource="#dts#">
				select 
				#getacc# as result 
				from icgroup 
				where wos_group='#getitem.wos_group#';
			</cfquery>
			
			<cfif getgroup.result neq "" and getgroup.result neq "0000/000">
				<cfset accno = getgroup.result>
			<cfelse>						
				<cfif getitem.result neq "" and getitem.result neq "0000/000">
					<cfset accno = getitem.result>
				<cfelse>
					<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
						<cfset accno = getdetails.gltradac>
					<cfelse>
						<cfif getdetails.type eq "INV">
							<cfset accno = getaccno.creditsales>
						<cfelseif getdetails.type eq "DN">
							<cfset accno = getaccno.creditsales>
						<cfelseif getdetails.type eq "CN">
							<cfset accno = getaccno.salesreturn>
						<cfelseif getdetails.type eq "PR">
							<cfset accno = getaccno.purchasereturn>
						<cfelseif getdetails.type eq "RC">
							<cfset accno = getaccno.purchasereceive>
						<cfelseif getdetails.type eq "CS">
							<cfset accno = getaccno.cashsales>
						</cfif>
						
						<cfif accno eq "">
							<cfset accno = "0000/000">
						</cfif>
					</cfif>
				</cfif>			
			</cfif>
		<cfelse>
			<cfif getitem.result neq "" and getitem.result neq "0000/000">
				<cfset accno = getitem.result>
			<cfelse>
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
				<cfelse>
					<cfif getdetails.type eq "INV">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "DN">
						<cfset accno = getaccno.creditsales>
					<cfelseif getdetails.type eq "CN">
						<cfset accno = getaccno.salesreturn>
					<cfelseif getdetails.type eq "PR">
						<cfset accno = getaccno.purchasereturn>
					<cfelseif getdetails.type eq "RC">
						<cfset accno = getaccno.purchasereceive>
					<cfelseif getdetails.type eq "CS">
						<cfset accno = getaccno.cashsales>
					</cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">								
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>			
	
	<cfquery name="inserttemp" datasource="#dts#">
		insert into temptrx 
		(
			trxbillno,
			accno,
			itemno,
			trxbtype,
			trxdate,
			period,
			currrate,
			custno,
			amount,
			amount2
		)
		values 
		(
			'#refno#',
			'#accno#',
			'#itemno#',
			'#type#',
			'#dateformat(wos_date,"yyyy-mm-dd")#',
			'#ceiling(fperiod)#',
			'#currrate#',
			'#custno#',
			'#numberformat(amt_bil,"._____")#',
			'#numberformat(amt_bil*currrate,"._____")#'
		);
	</cfquery>
</cfloop>

<cfquery name="gettemp" datasource="#dts#">
	select 
	trxbillno,
	accno,
	itemno,
	trxbtype,
	trxdate,
	period,
	currrate,
	custno,
	sum(amount) as amtt_fc,
	sum(amount2)as amtt 
	from temptrx
	where trxdate<>'' 
	group by accno 
	order by trxbillno,accno;
</cfquery>

<cfoutput>
<cfloop query="gettemp">
	<tr>
		<td>#gettemp.trxbtype#</td>
		<td>#gettemp.trxbillno#</td>
		<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>
		
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" and val(getaccno.gst) neq 0 and (xaccno neq "" and xaccno neq "0000/000")>
			<cfset gst_item_value = val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getaccno.gst)/100) + 1))>
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
		
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN">
			<cfset acctype = "D">
			<td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div></td>
			<td></td>
		<cfelse>
			<cfset acctype = "Cr">
			<td></td>		
			<td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div></td>
		</cfif>

		<td>&nbsp;</td>
		<td>#gettemp.period#</td>
		<td>#gettemp.accno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
	</tr>		
</cfloop>
</cfoutput>