<cfquery name="getdetails" datasource="#dts#">
	select 
	* 
	from ictran 
	where type='#trim(gettran.type)#' 
	and refno='#gettran.refno#' 
	<cfif lcase(Hcomid) eq "chemline_i">
		and ((linecode ='SV' and amt <> 0) or linecode='')
	</cfif>
</cfquery>
<cfset addcheck = 0>
<cfset addcheck2 = 0>
<cfloop query="getdetails">
	
    <cfif getdetails.currrate eq 0>
    	<cfset getdetails.currrate=1>
    </cfif>
	
	<cfif getdetails.linecode eq "SV" and getdetails.itemno neq "">
    
    <cfif trim(getdetails.type) eq "INV">
		<cfset accno = getaccno.creditsales>
    <cfelseif trim(getdetails.type) eq "DN">
        <cfset accno = getaccno.creditsales>
    <cfelseif trim(getdetails.type) eq "CN">
        <cfset accno = getaccno.salesreturn>
    <cfelseif trim(getdetails.type) eq "PR">
        <cfset accno = getaccno.purchasereturn>
    <cfelseif trim(getdetails.type) eq "RC">
        <cfset accno = getaccno.purchasereceive>
    <cfelseif trim(getdetails.type) eq "CS">
        <cfset accno = getaccno.cashsales>
    </cfif>
    
    <cfif accno eq "">
        <cfset accno = "0000/000">		
    </cfif>
    
    <cfif gettran.source neq "" or getdetails.source neq "">
        
	<cfif getacc eq "salec">
    <cfset proaccno = "creditsales">
    <cfelseif getacc eq "salecsc">
    <cfset proaccno = "cashsales">
    <cfelseif getacc eq "salecnc">
    <cfset proaccno = "salesreturn">
    <cfelseif getacc eq "purc">
    <cfset proaccno = "purchase">
    <cfelse>
    <cfset proaccno = "purchasereturn">
    </cfif>
    
    <cfif getdetails.source neq "">
    <cfset sourcecode = getdetails.source>
    <cfelseif gettran.source neq "">
    <cfset sourcecode = gettran.source>
	<cfelse>
    <cfset sourcecode = "">
    </cfif>
    <cfquery name="getproaccno" datasource="#dts#">
    SELECT source,#proaccno# as result from #target_project# 
    where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sourcecode#">
    </cfquery>
    
    <cfif getproaccno.recordcount neq 0 and getproaccno.result neq "" and getproaccno.result neq "0000/000">
    <cfset accno = getproaccno.result>
    </cfif>
    </cfif>
    
    <cfquery name="getservi" datasource="#dts#">
        select 
        #getacc# as result 
        from icservi 
        where servi='#getdetails.itemno#';
    </cfquery>
    
    
    	<cfif getservi.recordCount EQ 0>
        	 <cfquery name="getservi" datasource="#dts#">
                select 
                wos_group,
                <cfif getaccno.periodficposting eq "Y" and (trim(getdetails.type) eq "PR" or trim(getdetails.type) eq "RC")>
                if(itemtype = "SV",<cfif trim(getdetails.type) eq "PR">
    purprec<cfelse>#getacc#</cfif>,stock)
                <cfelse>
                <cfif trim(getdetails.type) eq "PR">
                    purprec 
                <cfelse>
                    #getacc# 
                </cfif></cfif>as result 
                from icitem 
                where itemno='#getdetails.itemno#'
                AND itemtype='SV'
            </cfquery>
            
            <!--- --->
            <cfif getservi.wos_group neq "">
			<cfquery name="getgroup" datasource="#dts#">
				select 
				#getacc# as result 
				from icgroup 
				where wos_group='#getitem.wos_group#'
			</cfquery>
			
				<cfif getgroup.result neq "" and getgroup.result neq "0000/000">
                    <cfset accno = getgroup.result>
                </cfif>
			</cfif>
            
            
            
        </cfif>
    
		
		<cfif getservi.recordcount eq 0>
			<cfif lcase(Hcomid) eq "chemline_i">
				<cfset getservi.result ="0000/000">
				<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
					<cfset accno = getdetails.gltradac>
					<cfelse>
						<cfif trim(getdetails.type) eq "INV">
                            <cfset accno = getaccno.creditsales>
                        <cfelseif trim(getdetails.type) eq "DN">
                            <cfset accno = getaccno.creditsales>
                        <cfelseif trim(getdetails.type) eq "CN">
                            <cfset accno = getaccno.salesreturn>
                        <cfelseif trim(getdetails.type) eq "PR">
                            <cfset accno = getaccno.purchasereturn>
                        <cfelseif trim(getdetails.type) eq "RC">
                            <cfset accno = getaccno.purchasereceive>
                        <cfelseif trim(getdetails.type) eq "CS">
                            <cfset accno = getaccno.cashsales>
                        </cfif>
					
					<cfif accno eq "">
						<cfset accno = "0000/000">		
					</cfif>
				</cfif>	
			</cfif>					
		<cfelse>
			<cfif getservi.result neq "" and getservi.result neq "0000/000">
				<cfset accno = getservi.result>
			</cfif>
		</cfif>
		<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
			<cfset accno = getdetails.gltradac>	
		</cfif>
	<cfelse> 
    
		<cfif trim(getdetails.type) eq "INV">
			<cfset accno = getaccno.creditsales>
		<cfelseif trim(getdetails.type) eq "DN">
			<cfset accno = getaccno.creditsales>
		<cfelseif trim(getdetails.type) eq "CN">
			<cfset accno = getaccno.salesreturn>
		<cfelseif trim(getdetails.type) eq "PR">
			<cfset accno = getaccno.purchasereturn>
		<cfelseif trim(getdetails.type) eq "RC">
			<cfset accno = getaccno.purchasereceive>
		<cfelseif trim(getdetails.type) eq "CS">
			<cfset accno = getaccno.cashsales>
		</cfif>
		
        <cfif gettran.source neq "" or getdetails.source neq "">
        
	<cfif getacc eq "salec">
    <cfset proaccno = "creditsales">
    <cfelseif getacc eq "salecsc">
    <cfset proaccno = "cashsales">
    <cfelseif getacc eq "salecnc">
    <cfset proaccno = "salesreturn">
    <cfelseif getacc eq "purc">
    <cfset proaccno = "purchase">
    <cfelse>
    <cfset proaccno = "purchasereturn">
    </cfif>
    
    <cfif getdetails.source neq "">
    <cfset sourcecode = getdetails.source>
    <cfelseif gettran.source neq "">
    <cfset sourcecode = gettran.source>
	<cfelse>
    <cfset sourcecode = "">
    </cfif>
    <cfquery name="getproaccno" datasource="#dts#">
    SELECT source,#proaccno# as result from #target_project# 
    where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sourcecode#">
    </cfquery>
    
    <cfif getproaccno.recordcount neq 0 and getproaccno.result neq "" and getproaccno.result neq "0000/000">
    <cfset accno = getproaccno.result>
    </cfif>
    </cfif>
        
        <cfquery name="getitem" datasource="#dts#">
			select 
			wos_group,
            <cfif getaccno.periodficposting eq "Y" and (trim(getdetails.type) eq "PR" or trim(getdetails.type) eq "RC")>
            if(itemtype = "SV",<cfif trim(getdetails.type) eq "PR">
purprec<cfelse>#getacc#</cfif>,stock)
            <cfelse>
			<cfif trim(getdetails.type) eq "PR">
				purprec 
			<cfelse>
				#getacc# 
			</cfif></cfif>as result 
			from icitem 
			where itemno='#getdetails.itemno#'
		</cfquery>
        
        <cfif getitem.wos_group neq "">
			<cfquery name="getgroup" datasource="#dts#">
				select 
				#getacc# as result 
				from icgroup 
				where wos_group='#getitem.wos_group#'
                <cfif dts eq "eumasjewel_i">
                and category3 = "#getdetails.location#"
				</cfif>
			</cfquery>
			
			<cfif getgroup.result neq "" and getgroup.result neq "0000/000">
				<cfset accno = getgroup.result>
			</cfif>
		</cfif>
        
		<cfif getitem.result neq "" and getitem.result neq "0000/000">
			<cfset accno = getitem.result>
		</cfif>

		<cfif gettran.special_account_code neq "" and gettran.special_account_code neq "0000/000">
			<cfset accno = gettran.special_account_code>
		</cfif>
		
		<cfif getdetails.gltradac neq "" and getdetails.gltradac neq "0000/000">
			<cfset accno = getdetails.gltradac>
		</cfif>
		
		<cfif accno eq "">
			<cfset accno = "0000/000">								
		</cfif>
	</cfif>
	<cfif getaccno.wpitemtax eq "1">
    <cfif getdetails.taxincl eq "T" and (getdetails.currrate eq 1 or getdetails.currrate neq '')>
    <cfset getdetails.amt_bil = getdetails.amt_bil - getdetails.taxamt_bil >
    <cfelseif getdetails.taxincl eq "T">
    <cfset getdetails.amt_bil = getdetails.amt_bil - getdetails.taxamt >
	</cfif>
    </cfif>

    <!---<cfif HuserID EQ 'ultraprinesh'>
    	<cfoutput>#getaccno.cashsales# -- #getitem.result# -- #gettran.special_account_code# -- #getdetails.gltradac#</cfoutput>
   	 <cfabort>		
    </cfif>--->
    
    		
	<cfif amt_bil neq 0>
	<cfquery name="inserttemp1" datasource="#dts#">
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
			amount2,
			gst,
			GSTAMT,
			GSTTYPE
			<!--- <cfif lcase(HcomID) eq "probulk_i"> --->		<!--- Add On 05-01-2010 --->
				,SOURCE,JOB
			<!--- </cfif> --->
		)
		values 
		(
			'#refno#',
			'#accno#',
			'#itemno#',
			'#type#',
			 <cfif wos_date NEQ ''>'#DateFormat(wos_date,"yyyy-mm-dd")#'<cfelse>'0000-00-00'</cfif>,
			'#ceiling(fperiod)#',
			'#currrate#',
			'#custno#',
            <cfif gettran.currcode eq getaccno.bcurr or gettran.currcode eq "">
            '0',
			<cfelse>
<!--- 			<cfif lcase(HcomID) eq "hchf_i">'#numberformat(amt_bil,".____")#'<cfelse> --->'#numberformat(amt_bil,"._____")#'<!--- </cfif> --->,
            </cfif>
<!--- 			<cfif lcase(HcomID) eq "hchf_i">'#numberformat(amt_bil*currrate,".____")#'<cfelse> --->'#numberformat(amt_bil*currrate,"._____")#'<!--- </cfif> --->,
			'#val(TAXPEC1)#',
			'#val(taxamt)#',
			'#note_a#'
			<!--- <cfif lcase(HcomID) eq "probulk_i"> --->		<!--- Add On 05-01-2010 --->
				,'#SOURCE#','#JOB#'
			<!--- </cfif> --->	
		);
	</cfquery>
    </cfif>
</cfloop>
<cfset negativevalue = 0>
<cfquery name="checknegative" datasource="#dts#">
select sum(amount2) as sumamt FROM temptrx where amount2 < 0
</cfquery>
<cfquery name="getnegaccno" datasource="#dts#">
SELECT amount2 FROM temptrx group by accno
</cfquery>
<cfif checknegative.recordcount neq 0 and getnegaccno.recordcount neq 1>
<cfset negativevalue = numberformat(val(checknegative.sumamt),'.__')>
</cfif>

<!--- <cfif lcase(huserid) eq "ultracai"> --->
<cfquery name="validatefield" datasource="#dts#">
select * from (SELECT <cfif getartran.taxincl eq "T" and getartran.currrate gt 1 >round(</cfif>sum(<cfif getartran.taxincl eq "T" and getartran.currrate gt 1 ><cfelse>round(</cfif>a.amtt+0.0000000001<cfif wpitemtax eq "Y"><cfif getartran.taxincl neq "T" >
<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
            <cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno1 = getaccno.discpur>
			<cfelse>
            <cfset xaccno1 = getaccno.discsales>
            </cfif>
    <cfif xaccno1 eq "" or xaccno1 eq "0000/000">
    +round(a.gstamt+0.0000000001,2)
	</cfif>
    <cfelse>
    +round(a.gstamt+0.0000000001,2)
	</cfif></cfif></cfif><cfif getartran.taxincl eq "T" and getartran.currrate gt 1 ><cfelse>,2)</cfif>)<cfif getartran.taxincl eq "T" and getartran.currrate gt 1 >,2)</cfif><cfif wpitemtax neq "Y" and getartran.taxincl neq "T">+round(sum(a.gstamt)+0.0000000001,2)</cfif> as totalamt,a.trxbillno,a.trxbtype,a.id
FROM(
select
id,
	trxbillno,
	trxbtype,
    sum(GSTAMT) as gstamt,
	sum(<cfif getnegaccno.recordcount neq 1>if(amount2 < 0,0,</cfif>amount2<cfif getnegaccno.recordcount neq 1>)</cfif>)as amtt
	from temptrx
	where trxdate<>''
	group by accno<cfif getaccno.PNOPROJECT neq "Y">,SOURCE,JOB</cfif>
	order by trxbillno,accno<cfif getaccno.PNOPROJECT neq "Y">,SOURCE,JOB</cfif>
    ) as a group by trxbillno,trxbtype) as aa
left join (select refno,<cfif val(negativevalue) neq 0 and getnegaccno.recordcount eq 1>grand<cfelse> round(grand+0.0000000001,2)</cfif>
	<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
            <cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno1 = getaccno.discpur>
			<cfelse>
            <cfset xaccno1 = getaccno.discsales>
            </cfif>
    <cfif xaccno1 eq "" or xaccno1 eq "0000/000">
    <cfelse>
    +round(discount+0.0000000001,2)<!--- <cfif getartran.taxincl eq "T">+round(tax+0.0000000001,2)</cfif> --->
	</cfif>
	</cfif>
    <cfif isdefined('check_misc.summisc')>
    <cfif val(check_misc.summisc) neq 0>
    - #(val(check_misc.summisc)-val(check_misc.sum_without_misc))#
	</cfif>
	</cfif>
     + #abs(val(negativevalue))# as grand,type from artran WHERE type='#trim(gettran.type)#' 
	and refno='#gettran.refno#') as bb on aa.trxbillno = bb.refno
and aa.trxbtype = bb.type where totalamt <> grand 
</cfquery>

<cfloop query="validatefield">
<cfset varyamount = val(validatefield.totalamt) - val(validatefield.grand)>

<cfif varyamount lte 1 and varyamount gte -1>
<!---<cfif huserid eq "ultracai">
            <cfelse> --->
          <!---   <cfif varyamount lt 0 and getartran.type eq "RC">
            <cfelse> --->

<!---  <cfif lcase(huserid) neq "ultracai">  --->

<cfif abs(varyamount) gte 0.005 and abs(varyamount) lte 0.02 and val(getartran.roundadj) eq 0>
<cfquery name="adjustamount" datasource="#dts#">
UPDATE temptrx SET amount2 = amount2-#varyamount# where id = "#validatefield.id#"
</cfquery>
</cfif>
<!--- <cfelse>
<script type="text/javascript">
<cfoutput>
alert('#val(validatefield.totalamt)# #val(validatefield.grand)#');
</cfoutput>
</script>
</cfif>   --->
 <!---
</cfif>
</cfif> --->
</cfif>
</cfloop>
<!--- </cfif> --->

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
	gst,
	GSTTYPE,
	<!--- <cfif lcase(HcomID) eq "probulk_i"> --->SOURCE,JOB,<!--- </cfif> --->
	sum(GSTAMT) as gstamt,
	sum(amount) as amtt_fc,
	sum(amount2)as amtt 
	from temptrx
	where trxdate<>''<!---  <cfif ppts eq "Y">and accno <> '' and accno <> '0000/000'</cfif> --->
	group by accno<cfif wpitemtax eq "Y">,GSTTYPE</cfif><cfif getaccno.PNOPROJECT neq "Y">,SOURCE,JOB</cfif>
	order by trxbillno,accno<cfif wpitemtax eq "Y">,GSTTYPE</cfif><cfif getaccno.PNOPROJECT neq "Y">,SOURCE,JOB</cfif>;
</cfquery>

<cfif val(getartran.disc1_bil) neq 0 or val(getartran.discount) neq 0>
            <cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno1 = getaccno.discpur>
			<cfelse>
            <cfset xaccno1 = getaccno.discsales>
            </cfif>
    <cfif xaccno1 eq "" or xaccno1 eq "0000/000">
    		<cfif refnobill neq getartran.refno>
            
    		<cfset refnobill = getartran.refno>
            <cfset gettemp.amtt_fc = val(gettemp.amtt_fc) - val(getartran.disc1_bil)>
            <cfset gettemp.amtt = val(gettemp.amtt) - val(getartran.discount)>
            </cfif>
    </cfif>
    </cfif>

<cfoutput>
<cfset validmisc = "">
<cfloop query="gettemp"> 
	<cfset varamt = 0>
    
	<cfif ppts eq "Y" >
        <cfquery name="validGST" dbtype="query">
    SELECT gstamt from gettemp where trxbillno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.trxbillno#">
    </cfquery>
    <cfset totalgstamt = 0 >
    <cfloop query="validGST">
    <cfset totalgstamt = totalgstamt + numberformat(validGST.gstamt,'.__') >
    
    </cfloop>
    
   
    <cfquery name="getFirstRow" dbtype="query">
    SELECT trxbillno,accno,trxbtype from gettemp where trxbillno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.trxbillno#">
    </cfquery>
    
    <cfquery name="validBilGst" datasource="#dts#">
    SELECT sum(tax_bil) as sumtaxbil from artran where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.trxbillno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.trxbtype#">
    </cfquery>
     
    <cfif totalgstamt neq validBilGst.sumtaxbil>
    <cfset varyamt = validBilGst.sumtaxbil - totalgstamt   >
    
	<cfif gettemp.trxbillno eq getFirstRow.trxbillno and gettemp.accno eq getFirstRow.accno and gettemp.trxbtype eq getFirstRow.trxbtype> 
	<cfset gettemp.gstamt = numberformat(gettemp.gstamt,'.__') + numberformat(varyamt,'.__') >
    <cfif validatefield.recordcount neq 0>
    <cfset gettemp.amtt = numberformat(val(gettemp.amtt),'.__') - numberformat(varyamt,'.__') >
    </cfif>
    
    </cfif>
    </cfif>
    
    
	</cfif>
	<!---<tr <cfif gettemp.accno eq "0000/000">style="background:##FF0000" </cfif> >
		<td>#gettemp.trxbtype#</td>
		<td>#gettemp.trxbillno#</td>
        <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
		<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>
		--->
		<cfif getartran.type eq "RC" or getartran.type eq "PR">
			<cfset xaccno = getaccno.gstpurchase>
		<cfelse>
			<cfset xaccno = getaccno.gstsales>
		</cfif>
		
		<cfif getartran.taxincl eq "T" <!--- and val(getaccno.gst) neq 0 ---> and (xaccno neq "" and xaccno neq "0000/000")>
			 <cfif wpitemtax eq "Y">
				<cfset gst_item_value = val(gettemp.GSTAMT)>
			<cfelse>
				<!--- <cfset gst_item_value = abs(val(gettemp.amtt) - (val(gettemp.amtt) / ((val(getartran.taxp1)/100) + 1)))> --->
                <cfset gst_item_value = val(gettemp.GSTAMT)>
			</cfif>
		<!---<cfset gst_item_value = val(gettemp.GSTAMT)> --->
		<cfelse>
			<cfset gst_item_value = 0>
		</cfif>
        <cfset gst_item_value = abs(val(gst_item_value))>
		<cfif validmisc eq "">
        <cfset validmisc = check_misc.sum_without_misc&gettemp.trxbillno>
        <cfelse>
		<cfif validmisc eq check_misc.sum_without_misc&gettemp.trxbillno>
        <cfset check_misc.sum_without_misc = 0>
		</cfif>
		</cfif>
        <cfset addin = 0>
        <cfif lcase(hcomid) eq "taftc_i" and (type eq "INV" or type eq "CN")>
                <cfif val(getcourse.cdispec) neq 0 and getcourse.grantacc neq "" and addcheck eq 0 and checknoofstudent.recordcount neq 0>
            	    <cfset addin = numberformat(val(getcourse.cdispec),".__")>
                    <cfif val(gettemp.amtt) gte 0>
                    <cfset gettemp.amtt = gettemp.amtt + addin>
                    <cfelse>
                    <cfset gettemp.amtt = gettemp.amtt - addin>
                    </cfif>
					<cfset addcheck = 1>
				</cfif>
                
                <cfif addcheck2 eq 0 and val(getjob.postingtimes) gt 1>
                <cfset gettemp.amtt = val(gettemp.amtt) / val(getjob.postingtimes)>
                <cfset addcheck2 = 1>
				</cfif>
                
		</cfif>
		
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN">
			<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
            
            <cfset acctype = "Cr">
                <!---<td></td>
                <td><div align="right">#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totcredit = totcredit + numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")></td>
                --->
            <cfelse>
                <cfset acctype = "D">
                <!---<td><div align="right">#numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")#</div><cfset totdebit = totdebit + numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__")></td>
                <td></td>--->
            </cfif>
		<cfelse>
			<cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>

            <cfset acctype = "D">
                		
                <!---<td><div align="right">#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totdebit = totdebit + numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
                <td></td>--->
			<cfelse>
                <cfset acctype = "Cr">
                <!---<td></td>		
                <td><div align="right">#numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#</div><cfset totcredit = totcredit + numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__")></td>
            	--->
			</cfif>
		</cfif>
		<!---
		<td><div align="left">
			<cfif wpitemtax eq "Y">
				#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif>
			<cfelse>
				#getartran.note# <cfif val(getartran.taxp1) neq 0>#val(getartran.taxp1)# %</cfif>
			</cfif>
		</div></td>
		<td>#gettemp.period#</td>
		<td>#gettemp.accno#</td>
		<td>#acctype#</td>
		<td nowrap>#getartran.name#</td>
        <td nowrap>#getartran.agenno#</td>
		<!--- <cfif lcase(HcomID) eq "probulk_i"> --->
			<td nowrap>#gettemp.source#</td>
			<td nowrap>#gettemp.job#</td>
		<!--- </cfif> --->
	</tr>	--->
	<cfif gettemp.accno eq "" or gettemp.accno eq "0000/000">
		<cfset noaccno="Y">
	</cfif>	
	<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
		<!---<tr>
			<td>#gettemp.trxbtype#</td>
			<td>#gettemp.trxbillno#</td>
            <cfif lcase(hcomid) eq "leadbuilders_i"><td>#getartran.refno2#</td></cfif>
			<td>#dateformat(gettemp.trxdate,"dd/mm/yyyy")#</td>--->
			
			<cfif getartran.type eq "RC" or getartran.type eq "CN">
                <cfset acctype1 = "D">			
                
                <cfif getartran.type eq "RC">
                    <cfset xaccno = getaccno.gstpurchase>				
                <cfelse>
                    <cfset xaccno = getaccno.gstsales>
                </cfif>
                <cfif val(gettemp.gstamt) lt 0>
                <!---<td></td>
                <td><div align="right">#numberformat(abs(val(gettemp.gstamt)),".__")#</div><cfset totcredit = totcredit + numberformat(abs(val(gettemp.gstamt)),".__")></td>
                --->
                <cfelse>
                <!---
                <td><div align="right">#numberformat(gettemp.gstamt,".__")#</div><cfset totdebit = totdebit + numberformat(gettemp.gstamt,".__")></td>
                <td></td>--->
                </cfif>
            <cfelse>
                <cfset acctype1 = "Cr">
                <cfif getartran.type eq "PR">
                    <cfset xaccno = getaccno.gstpurchase>				
                <cfelse>
                	<cfset xaccno = getaccno.gstsales>
                </cfif>
                <cfif val(gettemp.gstamt) lt 0>
                <!---
                <td><div align="right">#numberformat(abs(val(gettemp.gstamt)),".__")#</div><cfset totdebit = totdebit + numberformat(abs(val(gettemp.gstamt)),".__")></td>
                <td></td>--->
                <cfelse>
                <!---<td></td>
                <td><div align="right">#numberformat(gettemp.gstamt,".__")#</div><cfset totcredit = totcredit + numberformat(gettemp.gstamt,".__")></td>
                --->
				</cfif>
            </cfif>
			
			<!--- ADD ON 09-10-2009 --->
			<cfif gettemp.GSTTYPE neq "">
				<cfquery name="gettaxcode" datasource="#dts#">
					SELECT corr_accno FROM #target_taxtable# 
					WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettemp.GSTTYPE#"> LIMIT 1
				</cfquery>
				<cfif gettaxcode.recordcount neq 0 and gettaxcode.corr_accno neq "" and gettaxcode.corr_accno neq "0000/000">
					<cfset xaccno = gettaxcode.corr_accno>	
				</cfif>
			</cfif>
			<!---
			<td><div align="left">#gettemp.GSTTYPE# <cfif val(gettemp.gst) neq 0>#val(gettemp.gst)# %</cfif></div></td>
			<td>#gettemp.period#</td>
			<td>#xaccno#</td>
			<td>#acctype1#</td>
			<td nowrap>#getartran.name#</td>
            <td nowrap>#getartran.agenno#</td>
			<!--- <cfif lcase(HcomID) eq "probulk_i"> --->
				<td nowrap>#gettemp.source#</td>
				<td nowrap>#gettemp.job#</td>
			<!--- </cfif> --->
		</tr>		--->
		<cfif xaccno eq "" or xaccno eq "0000/000">
			<cfset noaccno="Y">
		</cfif>	
	</cfif>


    
		<cfif gettemp.trxbtype eq "RC" or gettemp.trxbtype eq "CN"<!---  or gettemp.trxbtype eq "PR" --->>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
					<cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    creditamt,
					<cfelse>
                    debitamt,
					</cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
					#trxdate#,
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
					'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#',
                    <cfif numberformat(gettemp.amtt-gst_item_value+check_misc.sum_without_misc,".__") lt 0>
                    '#numberformat(-(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
                    <cfelse>
					'#numberformat(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil,".__")#',
                    </cfif>
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					#trxdate#,
					<!---<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>--->'#numberformat(abs(gettemp.amtt)-gst_item_value+check_misc.sum_without_misc,".__")#'<!---</cfif>--->
                    ,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					
                    ,'#gettemp.source#'
                    ,'#gettemp.job#'
                    ,'#getartran.agenno#'
                    ,'#uuid#'
				)
			</cfquery>
			
			<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
				<cfquery name="insertpost3" datasource="#dts#">
                    insert into glposttemp
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        <cfif val(gettemp.gstamt) lt 0>
                        creditamt,
						<cfelse>
                        debitamt,
                        </cfif>
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                        ,uuid
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(abs(val(gettemp.gstamt)),".__")#',
                        <cfif currrate eq 0>'#numberformat((gettemp.gstamt),".__")#'<cfelse>'#numberformat((gettemp.gstamt/currrate),".__")#'</cfif>,
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '0',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
						<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#'
                        ,'#getartran.agenno#'<!--- </cfif> --->
                        ,'#uuid#'
                    )
                </cfquery>
                
				
			</cfif>
		<cfelse>
			<cfquery name="insertpost2" datasource="#dts#">
				insert into glposttemp
				(
					acc_code,
					accno,
					fperiod,
					date,
					reference,
                    refno,
					desp,
                    <cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    debitamt,
                    <cfelse>
					creditamt,
                    </cfif>
					fcamt,
					exc_rate,
					rem4,
					rem5,
					bdate,
					taxpur,userid,TAXPEC
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                    ,uuid
				)
				values 
				(
					'#gettemp.trxbtype#',
					'#accno#',
					'#period#',
                    <cfif trxdate NEQ ''>'#DateFormat(trxdate,"yyyy-mm-dd")#'<cfelse>'0000-00-00'</cfif>,
					<!---#trxdate#,--->
					'#billno#',
                    '#getartran.refno2#',
					'#getartran.name#',
				'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#',
					<cfif numberformat(val(gettemp.amtt)-val(gst_item_value)+val(check_misc.sum_without_misc),".__") lt 0>
                    '#numberformat((abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
                    <cfelse>
					'#numberformat(-(abs(amtt_fc)-(gst_item_value/getartran.currrate)+check_misc.sum_without_misc_bil),".__")#',
                    </cfif>
					'#currrate#',
					<cfif wpitemtax eq "Y">'#gettemp.GSTTYPE#'<cfelse>'#getartran.note#'</cfif>,
					'0',
					<cfif trxdate NEQ ''>'#DateFormat(trxdate,"yyyy-mm-dd")#'<cfelse>'0000-00-00'</cfif>,
					<!---<cfif wpitemtax eq "Y">'#val(abs(gettemp.amtt))#'<cfelse>--->'#numberformat(val(abs(gettemp.amtt))-val(gst_item_value)+val(check_misc.sum_without_misc),".__")#'<!---</cfif>--->,'#HUserID#',
					<cfif wpitemtax eq "Y">'#val(abs(gettemp.gst))#'<cfelse>'#val(getartran.taxp1)#'</cfif>
					<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                    ,'#uuid#'
				)
			</cfquery>
            
			
			<cfif wpitemtax eq "Y" and val(gettemp.GSTAMT) neq 0>
				 <cfquery name="insertpost3" datasource="#dts#">
                    insert into glposttemp
                    (
                        acc_code,
                        accno,
                        fperiod,
                        date,
                        reference,
                        refno,
                        desp,
                        <cfif val(gettemp.gstamt) lt 0>
                        debitamt,
						<cfelse>
                        creditamt,
                        </cfif>
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,SOURCE,JOB,agent<!--- </cfif> --->
                        ,uuid
                    )
                    values 
                    (
                        '#gettemp.trxbtype#',
						'#xaccno#',
						'#period#',
						#trxdate#,
						'#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(abs(val(gettemp.gstamt)),".__")#',
                        <cfif currrate eq 0>
                        '#numberformat(-(gettemp.gstamt),".__")#'
                        <cfelse>
                        '#numberformat(-(gettemp.gstamt/currrate),".__")#'
                        </cfif>
                        ,
                        '#currrate#',
                        '#gettemp.GSTTYPE#',
                        '0',
                        #getartran.wos_date#,'#HUserID#','#val(gettemp.gst)#'
						<!--- <cfif lcase(HcomID) eq "probulk_i"> --->,'#gettemp.source#','#gettemp.job#','#getartran.agenno#'<!--- </cfif> --->
                        ,'#uuid#'
                    )
                </cfquery>
				
			</cfif>
		
	</cfif>

	 <cfif lcase(hcomid) eq "hamari_i" and getartran.type eq "CN">
    <cfquery name="updateglposttempdesp" datasource="#dts#">
    	update glposttemp set desp='#getdetails.desp#' where uuid='#uuid#' and acc_code='#gettemp.trxbtype#' and reference='#billno#'
    </cfquery>
    </cfif>
    <cfif lcase(hcomid) eq "taftc_i" and (type eq "INV" or type eq "CN")>
		<cfif val(getjob.postingtimes) gt 1>
        <cfinclude template="taftcdevidepost.cfm">
        </cfif>
	</cfif>
</cfloop>
</cfoutput>
