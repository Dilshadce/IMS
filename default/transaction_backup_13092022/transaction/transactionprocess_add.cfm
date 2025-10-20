<!--- <cfif expdate neq "">
	<cfset expdate = mid(expdate,7,4)&"-"&mid(expdate,4,2)&"-"&mid(expdate,1,2)>
<cfelse>
	<cfset expdate = expdate>
</cfif> --->

<!--- <cfif sodate neq "">
	<cfset sodate = mid(sodate,7,4)&"-"&mid(sodate,4,2)&"-"&mid(sodate,1,2)>
<cfelse>
	<cfset sodate = sodate>
</cfif> --->

<!--- <cfif dodate neq "">
	<cfset dodate = mid(dodate,7,4)&"-"&mid(dodate,4,2)&"-"&mid(dodate,1,2)>
<cfelse>
	<cfset dodate = dodate>
</cfif> --->
<cfquery name="getgsetup" datasource="#dts#">
select autobom,recompriceup,recompriceup1,autolocbf,bcurr from gsetup
</cfquery>

<cfif trim(expdate) neq "">
	<cfset expdate = createDate(ListGetAt(expdate,3,"-"),ListGetAt(expdate,2,"-"),ListGetAt(expdate,1,"-"))>
<cfelse>
	<cfset expdate = "">
</cfif>

<cfif trim(manudate) neq "">
	<cfset manudate = createDate(ListGetAt(manudate,3,"-"),ListGetAt(manudate,2,"-"),ListGetAt(manudate,1,"-"))>
<cfelse>
	<cfset manudate = "">
</cfif>

<cfif trim(sodate) neq "">
	<cfset sodate = createDate(ListGetAt(sodate,3,"-"),ListGetAt(sodate,2,"-"),ListGetAt(sodate,1,"-"))>
<cfelse>
	<cfset sodate = "">
</cfif>

<cfif trim(dodate) neq "">
	<cfset dodate = createDate(ListGetAt(dodate,3,"-"),ListGetAt(dodate,2,"-"),ListGetAt(dodate,1,"-"))>
<cfelse>
	<cfset dodate = "">
</cfif>

<cfif trim(requiredate) neq "">
	<cfset requiredate = dateformat(createDate(right(requiredate,4),mid(requiredate,4,2),left(requiredate,2)),'yyyy-mm-dd')>
<cfelse>
	<cfset requiredate = "0000-00-00">
</cfif>

<cfif trim(replydate) neq "">
	<cfset replydate = dateformat(createDate(right(replydate,4),mid(replydate,4,2),left(replydate,2)),'yyyy-mm-dd')>
<cfelse>
	<cfset replydate = "0000-00-00">
</cfif>

<cfif trim(deliverydate) neq "">
	<cfset deliverydate = dateformat(createDate(right(deliverydate,4),mid(deliverydate,4,2),left(deliverydate,2)),'yyyy-mm-dd')>
<cfelse>
	<cfset deliverydate = "0000-00-00">
</cfif>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#sodate#" returnvariable="sodate"/>
<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#dodate#" returnvariable="dodate"/>
<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#expdate#" returnvariable="expdate"/>
<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#manudate#" returnvariable="manudate"/>
<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="" returnvariable="exported1"/>

<cfquery name="checkitemExist" datasource="#dts#">
	select 
	itemcount 
	from ictran 
	where type='#tran#'
	and refno='#nexttranno#' 
	and custno='#form.custno#' 
	order by itemcount;
</cfquery>

<cfif checkitemExist.recordcount GT 0>
	<cfinvoke method="reorder" refno="#nexttranno#" itemcountlist="#valuelist(checkitemExist.itemcount)#"/>
	<cfinvoke method="relocate" refno="#nexttranno#" end="#checkitemExist.itemcount[checkitemExist.recordcount]#" newtc="#newtrancode#"/>
	
	<cfset itemcnt = newtrancode>
	<cfset trcode = itemcnt>
<cfelse>
	<cfset itemcnt = 1>
	<cfset trcode = itemcnt>
</cfif> 

<cfif getgsetup.autobom eq 'Y'>
<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">
		<cfquery name="checkexistbom" datasource="#dts#">
		select bomno from billmat where itemno='#form.itemno#'
        </cfquery>
		
        <cfif checkexistbom.recordcount neq 0>
	<cfoutput>
        
			<cfinvoke component="transactionautobom" method="generatebom" returnvariable="">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="qty" value="#form.qty#">
			<cfinvokeargument name="itemno" value="#form.itemno#">
            <cfinvokeargument name="bomno" value="#checkexistbom.bomno#">
            <cfinvokeargument name="location" value="#form.location#">
            <cfinvokeargument name="huserid" value="#huserid#">
		</cfinvoke>
        </cfoutput>
        </cfif>
        </cfif>
</cfif>

<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">
	<cfif trim(enterbatch) neq "">
		<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
			<cfset obtype = "bth_qin">
			<cfif checkcustom.customcompany eq "Y">
				<cfquery name="updateLotNo" datasource="#dts#">
					update gsetup
					set lotno = '#enterbatch#'
				</cfquery>
				<cfquery name="insert" datasource="#dts#">
					insert into lotnumber
					(LotNumber,itemno)
					value
					(<cfqueryparam cfsqltype="cf_sql_char" value="#enterbatch#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">)
				</cfquery>
			</cfif>
		<cfelse>
			<cfset obtype = "bth_qut">
		</cfif>
		
		<cfquery name="checkbatch" datasource="#dts#">
			select 
			batchcode 
			from obbatch 
			where batchcode='#enterbatch#' 
			and itemno='#itemno#';
		</cfquery>
		
		<cfif checkbatch.recordcount eq 0>
			<!--- <cfquery name="insertbatch" datasource="#dts#">
				insert into obbatch values 
				(
					'#form.enterbatch#',
					'#form.itemno#',
					'#form.tran#',
					'#form.nexttranno#',
					'0',
					'<cfif obtype eq "bth_qin">#form.qty#<cfelse>0</cfif>',
					'<cfif obtype eq "bth_qut">#form.qty#<cfelse>0</cfif>',
					'0',
					'0',
					'0',
					'#dateformat(expdate,"yyyy-mm-dd")#',
					'#form.tran#',
					'#form.nexttranno#',
					'#dateformat(expdate,"yyyy-mm-dd")#'
				);
			</cfquery> --->
            <cfif isdefined('manudate')>
            <cfif manudate eq "">
            <cfset manudate = "0000-00-00">
			</cfif>
			</cfif>
            
			<cfquery name="insertbatch" datasource="#dts#">
				insert into obbatch
                (
                	batchcode,
                    itemno,
                    type,
                    refno,
                    bth_QOB,
                    BTH_QIN,
                    BTH_QUT,
                    RPT_QOB,
                    RPT_QIN,
                    RPT_QUT,
                    EXP_DATE,
                    manu_date,
                    milcert,
                    importpermit,
                    countryoforigin,
                    pallet,
                    RC_TYPE,
                    RC_REFNO,
                    RC_EXPDATE
                    <cfif checkcustom.customcompany eq "Y">
                    ,permit_no,permit_no2
                	</cfif>
                ) 
                values  
				(
					'#form.enterbatch#',
					'#form.itemno#',
					'#form.tran#',
					'#form.nexttranno#',
					'0',
					'<cfif obtype eq "bth_qin">#act_qty#<cfelse>0</cfif>',
					'<cfif obtype eq "bth_qut">#act_qty#<cfelse>0</cfif>',
					'0',
					'0',
					'0',
					'#expdate#',
                    '#manudate#',
                    '#form.milcert#',
                    '#form.importpermit#',
                    '#form.countryoforigin#',
                    '#val(form.pallet)#',
					'#form.tran#',
					'#form.nexttranno#',
					'#expdate#'                 
					<cfif checkcustom.customcompany eq "Y">
						,'#form.hremark5#','#form.hremark6#'
					</cfif>
				);
			</cfquery>
		<cfelse>
			<!--- <cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#+#form.qty#) 
				where itemno='#itemno#' 
				and batchcode='#enterbatch#';
			</cfquery> --->
			<cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#+#act_qty#),manu_date='#manudate#',EXP_DATE='#expdate#'
				where itemno='#itemno#' 
				and batchcode='#enterbatch#';
			</cfquery>
		</cfif>
		
		<cfif location neq "">
			<cfquery name="checklobthob" datasource="#dts#">
				select 
				batchcode 
				from lobthob 
				where location='#location#' 
				and batchcode='#enterbatch#' 
				and itemno='#itemno#';
			</cfquery>
			
			<cfif checklobthob.recordcount eq 0>
				<!--- <cfquery name="insertlobthob" datasource="#dts#">
					insert into lobthob values 
					(
						'#form.location#',
						'#form.enterbatch#',
						'#form.itemno#',
						'#form.tran#',
						'#form.nexttranno#',
						'0',
						'<cfif obtype eq "bth_qin">#form.qty#<cfelse>0</cfif>',
						'<cfif obtype eq "bth_qut">#form.qty#<cfelse>0</cfif>',
						'0',
						'0',
						'0',
						'#dateformat(expdate,"yyyy-mm-dd")#',
						'#form.tran#',
						'#form.nexttranno#',
						'#dateformat(expdate,"yyyy-mm-dd")#'
					);
				</cfquery> --->
				<cfquery name="insertlobthob" datasource="#dts#">
					insert into lobthob
                    (
                    location,
                	batchcode,
                    itemno,
                    type,
                    refno,
                    bth_QOB,
                    BTH_QIN,
                    BTH_QUT,
                    RPT_QOB,
                    RPT_QIN,
                    RPT_QUT,
                    EXPDATE,
                    manudate,
                    milcert,
                    importpermit,
                    countryoforigin,
                    pallet,
                    RC_TYPE,
                    RC_REFNO,
                    RC_EXPDATE
                    <cfif checkcustom.customcompany eq "Y">
                    ,permit_no,permit_no2
                	</cfif>
                ) 
                     values 
					(
						'#form.location#',
						'#form.enterbatch#',
						'#form.itemno#',
						'#form.tran#',
						'#form.nexttranno#',
						'0',
						'<cfif obtype eq "bth_qin">#act_qty#<cfelse>0</cfif>',
						'<cfif obtype eq "bth_qut">#act_qty#<cfelse>0</cfif>',
						'0',
						'0',
						'0',
						'#expdate#',
                        '#manudate#',
                        '#form.milcert#',
                        '#form.importpermit#',
                        '#form.countryoforigin#',
                        '#val(form.pallet)#',
						'#form.tran#',
						'#form.nexttranno#',
						'#expdate#'
                        
						<cfif checkcustom.customcompany eq "Y">
							,'#form.hremark5#','#form.hremark6#'
						</cfif>
					);
				</cfquery>
			<cfelse>
				<!--- <cfquery name="updatelobthob" datasource="#dts#">
					update lobthob set 
					#obtype#=(#obtype#+#form.qty#) 
					where location='#location#' 
					and itemno='#itemno#' 
					and batchcode='#enterbatch#';
				</cfquery> --->
				<cfquery name="updatelobthob" datasource="#dts#">
					update lobthob set 
					#obtype#=(#obtype#+#act_qty#)
					where location='#location#' 
					and itemno='#itemno#' 
					and batchcode='#enterbatch#';
				</cfquery>
			</cfif>
		</cfif>
	</cfif>

	<cfif lcase(HUserID) neq "kellysteel2">
		<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">
			<cfset qname='QIN'&(val(readperiod)+10)>
		<cfelse>
			<cfset qname='QOUT'&(val(readperiod)+10)>
		</cfif>
		
		<!--- <cfquery name="UpdateIcitem" datasource="#dts#">
			update icitem set 
			#qname#=(#qname#+#form.qty#) 
			where itemno='#itemno#';
		</cfquery> --->
		
		<cfquery name="UpdateIcitem" datasource="#dts#">
			update icitem set 
			#qname#=(#qname#+#act_qty#) 
			where itemno='#itemno#';
		</cfquery>
	</cfif>
</cfif>

<!--- <cfquery name="checkitemExist" datasource="#dts#">
	select 
	itemcount 
	from ictran 
	where type='#tran#'
	and refno='#nexttranno#' 
	and custno='#form.custno#' 
	order by itemcount;
</cfquery>

<cfif checkitemExist.recordcount GT 0>
	<cfinvoke method="reorder" refno="#nexttranno#" itemcountlist="#valuelist(checkitemExist.itemcount)#"/>
	<cfinvoke method="relocate" refno="#nexttranno#" end="#checkitemExist.itemcount[checkitemExist.recordcount]#" newtc="#newtrancode#"/>
	
	<cfset itemcnt = newtrancode>
	<cfset trcode = itemcnt>
<cfelse>
	<cfset itemcnt = 1>
	<cfset trcode = itemcnt>
</cfif>  --->	

<cfquery name="getcust" datasource="#dts#">
	select 
	name,
	van,source,job,
	wos_date,rem5
	from artran 
	where type='#tran#'
	and refno='#nexttranno#'; 
</cfquery>

<!--- Add on 020908 for Graded Item --->
<cfif form.grdcolumnlist neq "" and form.service eq "">
	<cfset grdcolumnlist = form.grdcolumnlist>
	<cfset bgrdcolumnlist = form.bgrdcolumnlist>
	<cfset grdvaluelist = form.grdvaluelist>
	<cfset myArray = ListToArray(grdcolumnlist,",")>
	<cfset myArray2 = ListToArray(grdvaluelist,",")>
	<cfset myArray3 = ListToArray(bgrdcolumnlist,",")>
	
	<!--- <cfquery name="insertigrade" datasource="#dts#">
		insert into igrade
		(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray[i]#,
			<cfelse>
				#myArray[i]#
			</cfif>
		</cfloop>
		)
		values
		('#tran#','#nexttranno#','#itemcnt#','#form.itemno#',#getcust.wos_date#,'#numberformat(form.readperiod,"00")#',
		<cfif tran eq "RC" or tran eq "PO" or tran eq "CN" or tran eq "OAI">'1'<cfelse>'-1'</cfif>,'','#location#','','','#form.custno#','',
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray2[i]#,
			<cfelse>
				#myArray2[i]#
			</cfif>
		</cfloop>)
	</cfquery> --->
	<cfquery name="insertigrade" datasource="#dts#">
		insert into igrade
		(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray[i]#,
			<cfelse>
				#myArray[i]#
			</cfif>
		</cfloop>
		)
		values
		('#tran#','#nexttranno#','#itemcnt#','#form.itemno#',#getcust.wos_date#,'#numberformat(form.readperiod,"00")#',
		<cfif tran eq "RC" or tran eq "PO" or tran eq "CN" or tran eq "OAI">'1'<cfelse>'-1'</cfif>,'','#location#','','',
		'#form.custno#','','#form.factor1#','#form.factor2#',
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray2[i]#,
			<cfelse>
				#myArray2[i]#
			</cfif>
		</cfloop>)
	</cfquery>
	
	<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">
		<cfquery name="checkexist2" datasource="#dts#">
			select * from itemgrd
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
		</cfquery>
	
		<cfif checkexist2.recordcount eq 0>
			<cfquery name="insert" datasource="#dts#">
				insert into itemgrd 
				(itemno)
				values
				(<cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">)
			</cfquery>
		</cfif>
	
		<!--- <cfquery name="updateitemgrd" datasource="#dts#">
			update itemgrd
			set
			<cfloop from="1" to="#form.totalrecord#" index="i">
				<cfif i neq form.totalrecord>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]# ,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
		</cfquery> --->
		
		<cfquery name="updateitemgrd" datasource="#dts#">
			update itemgrd
			set
			<cfloop from="1" to="#form.totalrecord#" index="i">
				<cfif i neq form.totalrecord>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
					<cfif val(form.factor2) neq 0>
						(#myArray2[i]# * #form.factor1# / #form.factor2#)
					<cfelse>
						0
					</cfif> ,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
					<cfif val(form.factor2) neq 0>
						(#myArray2[i]# * #form.factor1# / #form.factor2#)
					<cfelse>
						0
					</cfif>
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
		</cfquery>
		
		<cfquery name="checkexist1" datasource="#dts#">
			select * from logrdob
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
		</cfquery>
		
		<cfif checkexist1.recordcount eq 0>
			<cfquery name="insert" datasource="#dts#">
				insert into logrdob 
				(itemno,location)
				values
				(<cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">,
				<cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">)
			</cfquery>
		</cfif>
		
		<!--- <cfquery name="updatelogrdob" datasource="#dts#">
			update logrdob
			set
			<cfloop from="1" to="#form.totalrecord#" index="i">
				<cfif i neq form.totalrecord>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]# ,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
		</cfquery> --->
		<cfquery name="updatelogrdob" datasource="#dts#">
			update logrdob
			set
			<cfloop from="1" to="#form.totalrecord#" index="i">
				<cfif i neq form.totalrecord>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
					<cfif val(form.factor2) neq 0>
						(#myArray2[i]# * #form.factor1# / #form.factor2#)
					<cfelse>
						0
					</cfif> ,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
					<cfif val(form.factor2) neq 0>
						(#myArray2[i]# * #form.factor1# / #form.factor2#)
					<cfelse>
						0
					</cfif>
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
		</cfquery>

	</cfif>
</cfif>

<cfset status = "Item Added Successfully">

<cfif lcase(hcomid) eq "amgworld_i" and tran eq "RC">
<cfset nowdatetime = dateformat(getcust.wos_date,"yyyy-mm-dd") & " 00:00:01">	
<cfelse>
<cfset nowdatetime = dateformat(getcust.wos_date,"yyyy-mm-dd") & " " & timeformat(now(),"HH:mm:ss")>	
</cfif>
<!--- REMARK ON 290908 --->
<!--- <cfquery name="insertictran" datasource="#dts#" >
	insert into ictran 
	(
		type,
		refno,
		custno,
		fperiod,
		wos_date,
		currrate,
		trancode,
		itemcount,
		linecode,
		itemno,
		desp,
		despa,
		agenno,
		location,
		qty_bil,
		price_bil,
		unit_bil,
		amt1_bil,
		dispec1,
		dispec2,
		dispec3,
		disamt_bil,
		amt_bil,
		taxpec1,
		gltradac,
		taxamt_bil,
		qty,
		price,
		unit,
		amt1,
		disamt,
		amt,
		taxamt,
		dono,
		name,
		exported,
		exported1,
		sono,
		toinv,
		van,
		generated,
		wos_group,
		category,
		brem1,
		brem2,
		brem3,
		brem4,
		packing,
		shelf,
		trdatetime,
		sv_part,
		sercost,
		userid,
		sodate,
		dodate,
		adtcost1,
		adtcost2,
		batchcode,
		expdate,
		mc1_bil,
		mc2_bil,
		defective,
		comment,
		m_charge1,
		m_charge2,
		m_charge3,
		m_charge4,
		m_charge5,
		m_charge6,
		m_charge7,
		mc3_bil,
		mc4_bil,
		mc5_bil,
		mc6_bil,
		mc7_bil
	)
	values
	(
		'#tran#',
		'#nexttranno#',
		'#form.custno#',
		'#numberformat(form.readperiod,"00")#',
		#getcust.wos_date#,
		'#currrate#',
		'#itemcnt#',
		'#trcode#',
		<cfif form.service neq "">'SV'<cfelse>''</cfif>,
		'#form.itemno#',
		'#jsstringformat(preservesinglequotes(form.desp))#',
		'#jsstringformat(preservesinglequotes(form.despa))#',
		'#form.agenno#',
		'#form.location#',
		'#form.qty#',
		'#form.price#',
		'#jsstringformat(preservesinglequotes(form.unit))#',
		'#amt1_bil#',
		'#form.dispec1#',
		'#form.dispec2#',
		'#form.dispec3#',
		'#disamt_bil#',
		'#val(amt_bil)#',
		'#form.taxpec1#',
		'#form.gltradac#',
		'#taxamt_bil#',
		'#form.qty#',
		'#xprice#',
		'#form.unit#',
		'#amt1#',
		'#disamt#',
		'#val(amt)#',
		'#taxamt#',
		'',
		'#getcust.name#',
		'',
		'',
		'',
		'',
		'#getcust.van#',
		'',
		'#getitem.wos_group#',
		'#getitem.category#',
		'#form.requestdate#',
		'#form.crequestdate#',
		'#form.brem3#',
		'<cfif ucase(form.brem4) eq "XCOST">XCOST<cfelse>#form.brem4#</cfif>',
		'#form.packing#',
		'#form.shelf#',
		'#nowDatetime#',
		'#form.sv_part#',
		'#form.sercost#',
		'#huserid#',
		'#dateformat(sodate,"yyyy-mm-dd")#',
		'#dateformat(dodate,"yyyy-mm-dd")#',
		'#val(form.adtcost1)*currrate#',
		'#val(form.adtcost2)*currrate#',
		'#form.enterbatch#',
		'#dateformat(expdate,"yyyy-mm-dd")#',
		'#form.mc1bil#',
		'#form.mc2bil#',
		'#form.defective#',
		
		<cfset CommentLen = len(tostring(form.comment))>
		<cfset xComment = tostring(form.comment)>
		<cfset SingleQ = "">
		<cfset DoubleQ = "">
		
		<cfloop index = "Count" from = "1" to = "#CommentLen#">
			<cfif mid(xComment,Count,1) eq "'">
				<cfset SingleQ = 'Y'>
			<cfelseif mid(xComment,Count,1) eq '"'>
				<cfset DoubleQ = 'Y'>
			</cfif>
		</cfloop>
		
		<cfif SingleQ eq "Y" and DoubleQ eq "">
			<!--- Found ' in the comment --->
			"#tostring(form.comment)#",'0','0','0','0','0','0','0','0','0','0','0','0')
		<cfelseif SingleQ eq "" and DoubleQ eq "Y">
			<!--- Found " in the comment --->
			'#tostring(form.comment)#','0','0','0','0','0','0','0','0','0','0','0','0')
		<cfelseif SingleQ eq "" and DoubleQ eq "">
			'#tostring(form.comment)#','0','0','0','0','0','0','0','0','0','0','0','0')
		<cfelse>
			<h3>Error. You cannot key in both ' and " in the comment.</h3>
		<cfabort>
	</cfif>
</cfquery> --->

<!--- ADD PROJECT & JOB ON 24-11-2009 --->

<!---calculate stock value---->

<cfset movingstockbal=0>

<cfif tran neq "RC" and tran neq "PR">
    <cfif getGeneralInfo.periodficposting eq "Y" and getGeneralInfo.cost eq "WEIGHT">
     
     <cfquery name="createtable" datasource="#dts#">
      CREATE TABLE IF NOT EXISTS `dolink`  (
        `useddo` VARCHAR(50)
      )
      ENGINE = MyISAM;
      </cfquery>
      <cfquery name="truncatedolink" datasource="#dts#">
      truncate dolink
      </cfquery>
      <cfquery name="getdoupdated" datasource="#dts#">
      INSERT INTO dolink SELECT frrefno FROM iclink WHERE frtype = "DO" 
      and itemno = '#form.itemno#'
	  group by frrefno
      </cfquery>
            <cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#form.itemno#'
			 limit 1
            </cfquery>
            
            <cfset movingunitcost=getqtybf.avcost2>
            <cfset movingbal=getqtybf.qtybf>
            
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#form.itemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod<>'99'
			and a.wos_date <= #getcust.wos_date#
			
			order by a.wos_date,b.created_on,a.trdatetime
			</cfquery>
        
        <cfloop query="getmovingictran">
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
        <!---exclude CN --->
        <cfif getGeneralInfo.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getGeneralInfo.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>                 
        <cfif getmovingictran.type eq "DO">
        <cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
       
        </cfif>
        
        </cfloop>
        
		<cfset movingstockbal=act_qty*movingunitcost>
        
	</cfif>
	</cfif>

<!--- --->

<cftry> 
<cfif tran eq "INV" or tran eq "DO" or tran eq "QUO" or tran eq "SO" or tran eq "CS">
    <cfquery name="checkpromotion" datasource="#dts#">
            SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='#form.custno#' or b.customer='') and b.type = "free" <cfif isdefined("form.promotiontype")>and b.promoid='#form.promotiontype#'</cfif> order by priceamt desc
            </cfquery>
            
            <cfif checkpromotion.recordcount neq 0>
            
            
			<cfset validfree = 0>
            <cfset itemfreeqty = 0>
            <cfset promoqtyamt = act_qty>
            
			<cfif act_qty neq 0>
            <cfloop query="checkpromotion">
            <cfif val(checkpromotion.priceamt) lte promoqtyamt>
            <cfset leftcontrol = promoqtyamt / val(checkpromotion.priceamt)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty =itemfreeqty + ( validfree * val(checkpromotion.rangeFrom))>
            <cfset promoqtyamt = act_qty * (leftcontrol-validfree)/leftcontrol >
            </cfif>
            </cfloop>
			</cfif>
            <cfif itemfreeqty gt 0>
            <cfset qtyfree = itemfreeqty >
            
            <cfif val(form.factor2) neq 0>
            <cfset qtyfree_bil = val(qtyfree) * val(form.factor2) / val(form.factor1)>
			<cfelse>
            <cfset qtyfree_bil = 0>
            </cfif>
            
			
             <cfquery name="insertictran" datasource="#dts#" >
                insert into ictran 
                (
                    type,refno,custno,fperiod,wos_date,currrate,trancode,itemcount,linecode,
                    itemno,desp,despa,agenno,location,
                    qty_bil,price_bil,unit_bil,amt1_bil,
                    dispec1,dispec2,dispec3,
                    disamt_bil,amt_bil,
                    taxpec1,gltradac,taxamt_bil,
                    qty,price,unit,factor1,factor2,amt1,disamt,amt,taxamt,note_a,
                    dono,name,exported,exported1,sono<cfif isdefined('form.soitem')>,soitem</cfif>,toinv,van,generated,
                    wos_group,category,brem1,brem2,brem3,brem4,requiredate,replydate,deliverydate,
                    packing,shelf,source,job,
                    trdatetime,sv_part,sercost,userid,sodate,dodate<cfif isdefined('form.it_cos') and tran eq "CN">,it_cos</cfif>
                    <cfif getgsetup.bcurr EQ 'IDR'>,PPH,pph_amt_bil</cfif>
                )
                values
                (
                    '#tran#','#nexttranno#','#form.custno#','#numberformat(form.readperiod,"00")#',#getcust.wos_date#,
                    '#currrate#','#itemcnt#','#trcode#',<cfif form.service neq "">'SV'<cfelse>''</cfif>,
                    <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.despa#">,
                    '#form.agenno#','#form.location#','#qtyfree_bil#','0',
                    <cfqueryparam cfsqltype="cf_sql_char" value="#form.unit#">,'0',
                    '0','0','0',
                    '0','0','0','#trim(form.gltradac)#','0',
                    '#qtyfree#','0','#getitem.unit#','#form.factor1#','#form.factor2#',
                    '0','0','0','0','','#form.dono#',
                    '#getcust.name#','','0000-00-00',<cfif isdefined('form.sono')>'#form.sono#'<cfelse>''</cfif><cfif isdefined('form.soitem')>,'#form.soitem#'</cfif>,'','#getcust.van#','',
                    <cfif lcase(hcomid) eq "ltm_i">'#form.crequestdate#'<cfelse>'#getitem.wos_group#'</cfif>,'#getitem.category#','#form.requestdate#','#form.crequestdate#',
                    '#form.brem3#','<cfif ucase(form.brem4) eq "XCOST">XCOST<cfelse>#form.brem4#</cfif>','#requiredate#','#replydate#','#deliverydate#',
                    '#form.packing#','#form.shelf#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.job#">,
					'#nowDatetime#','#form.sv_part#','#val(form.sercost)#',
                    '#huserid#','#sodate#','#dodate#'
					<cfif isdefined('form.it_cos') and tran eq "CN"> 
					<cfif form.it_cos eq "" or form.it_cos eq 0>
					<cfset it_cos = val(amt)>
                    <cfelse>
                    <cfset it_cos = form.it_cos>
                    </cfif>
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#it_cos#" >
					</cfif>
                    <cfif getgsetup.bcurr EQ 'IDR'>
                    	,'#trim(form.selectPPH)#'
                        ,'#val(form.pph_amt_bil)#'
                    </cfif>
                )		
            </cfquery>
                 <cfquery name="checkitemExist" datasource="#dts#">
                select 
                itemcount 
                from ictran 
                where type='#tran#'
                and refno='#nexttranno#' 
                and custno='#form.custno#' 
                order by itemcount;
            </cfquery>
            
            <cfif checkitemExist.recordcount GT 0>
                <cfinvoke method="reorder" refno="#nexttranno#" itemcountlist="#valuelist(checkitemExist.itemcount)#"/>
                <cfinvoke method="relocate" refno="#nexttranno#" end="#checkitemExist.itemcount[checkitemExist.recordcount]#" newtc="#newtrancode#"/>
                
                <cfset itemcnt = newtrancode>
                <cfset trcode = itemcnt>
            <cfelse>
                <cfset itemcnt = 1>
                <cfset trcode = itemcnt>
            </cfif> 
			</cfif>
            </cfif>
            </cfif>
    <cfif isdefined('form.asvoucher')>
    
	<cfif form.voucherno eq "">
        <cfquery name="getlastvoucherno" datasource="#dts#">
        select max(voucherno) as voucherno from voucher WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
        </cfquery>
        <cfif getlastvoucherno.voucherno neq "">
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastvoucherno.voucherno#" returnvariable="newvoucherno" />
        <cfset form.voucherno = newvoucherno>
        <cfelse>
        <cfset form.voucherno = right(form.custno,3)&"000001">
        </cfif>
    <cfelse>
        <cfquery name="checkexistvoucherno" datasource="#dts#">
        SELECT voucherno FROM voucher where voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#">
        </cfquery>
        <cfif checkexistvoucherno.recordcount neq 0>
            <cfquery name="getlastvoucherno" datasource="#dts#">
            select max(voucherno) as voucherno from voucher WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
            </cfquery>
				<cfif getlastvoucherno.voucherno neq "">
                <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastvoucherno.voucherno#" returnvariable="newvoucherno" />
                <cfset form.voucherno = newvoucherno>
                <cfelse>
                <cfset form.voucherno = right(getartran.custno,3)&"000001">
                </cfif>
		</cfif>
    
	</cfif>
    
    <cfquery name="insertvoucher" datasource="#dts#">
    insert into voucher (voucherno,type,value,desp,created_by,created_on,custno)
values
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#">,'Value','#val(amt1_bil)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,'#HUserID#',now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#" >)
    </cfquery>
    <cfquery name="getID" datasource="#dts#">
			Select LAST_INSERT_ID() as en;
	</cfquery>
    <cfset form.voucherno = getID.en>
	</cfif>
    <cfquery name="getitemphoto" datasource="#dts#" >
    select photo from icitem where itemno='#form.itemno#'
    </cfquery>
    
    
    
    <cfquery name="insertictran" datasource="#dts#" >
        insert into ictran 
        (
            type,refno,custno,fperiod,wos_date,currrate,trancode,itemcount,linecode,
            itemno,desp,despa,agenno,location,
            qty_bil,price_bil,unit_bil,amt1_bil,
            dispec1,dispec2,dispec3,
            disamt_bil,amt_bil,
            taxpec1,gltradac,taxamt_bil,<!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">LOC_CURRRATE,LOC_CURRCODE,</cfif> --->
            qty,price,unit,factor1,factor2,amt1,disamt,amt,taxamt,note_a,
            dono,name,exported,exported1,sono<cfif isdefined('form.soitem')>,soitem</cfif>,toinv,van,generated,
            wos_group,category,brem1,brem2,brem3,brem4,requiredate,replydate,deliverydate,
            <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
                brem5,brem6,
				<cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
                brem7,brem8,brem9,
				</cfif>
            <cfelseif checkcustom.customcompany eq "Y">
                brem5,brem7,brem8,brem9,brem10,
            </cfif>
			<cfif isdefined('form.it_cos') and tran eq "CN">it_cos,</cfif>
            packing,shelf,supp,qty1,qty2,qty3,qty4,qty5,qty6,qty7,source,job,
            trdatetime,sv_part,sercost,userid,sodate,dodate,
            adtcost1,adtcost2,batchcode,expdate,manudate,milcert,importpermit,countryoforigin,pallet,mc1_bil,mc2_bil,defective,nodisplay,totalupdisplay,deductableitem,note1,title_id,title_desp,<cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">title_despa,</cfif><cfif getgsetup.bcurr EQ 'IDR'>pph,pph_amt_bil,</cfif>
            comment,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,
            mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil
			<cfif isdefined('form.taxinclude') and wpitemtax eq "Y">,taxincl</cfif><cfif isdefined('form.foc')>,foc</cfif><cfif isdefined('form.asvoucher')>,asvoucher,voucherno</cfif>,photo<cfif isdefined('form.ictranfilename')>,ictranfilename</cfif><cfif isdefined('form.invlinklist')>,invlinklist</cfif><cfif isdefined('form.invcnitem')>,invcnitem</cfif>,stkcost
        )
        values
        (
            '#tran#','#nexttranno#','#form.custno#','#numberformat(form.readperiod,"00")#',#getcust.wos_date#,
            '#currrate#','#itemcnt#','#trcode#',<cfif form.service neq "">'SV'<cfelse>''</cfif>,
            '#form.itemno#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.despa#">,
            '#form.agenno#','#form.location#',
            '#val(form.qty)#','#form.price#','#jsstringformat(preservesinglequotes(form.unit))#','#amt1_bil#',
            '#form.dispec1#','#form.dispec2#','#form.dispec3#',
            '#disamt_bil#','#val(amt_bil)#','#form.taxpec1#','#trim(form.gltradac)#','#taxamt_bil#',
            <!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">'#loc_currrate#','#loc_currrcode#',</cfif> --->
            '#act_qty#','#xprice#','#getitem.unit#','#form.factor1#','#form.factor2#',
            '#amt1#','#disamt#','#val(amt)#','#taxamt#','#form.selecttax#','#form.dono#',
            '#getcust.name#','','#exported1#',<cfif isdefined('form.sono')>'#form.sono#'<cfelse>''</cfif><cfif isdefined('form.soitem')>,'#form.soitem#'</cfif>,'','#getcust.van#','',
            <cfif lcase(hcomid) eq "ltm_i">'#form.crequestdate#'<cfelse>'#getitem.wos_group#'</cfif>,'#getitem.category#','#form.requestdate#','#form.crequestdate#',
            '#form.brem3#','<cfif ucase(form.brem4) eq "XCOST">XCOST<cfelse>#form.brem4#</cfif>','#requiredate#','#replydate#','#deliverydate#',
            <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
                '#form.brem5#','#form.brem6#',
            <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
            	'#form.brem7#','#form.brem8#','#form.brem9#',
			</cfif>
            <cfelseif checkcustom.customcompany eq "Y">
                '#form.hremark5#','#form.hremark6#','#form.bremark8#','#form.bremark9#','#form.bremark10#',
            </cfif>
			<cfif isdefined('form.it_cos') and tran eq "CN"> 
					<cfif form.it_cos eq "" or form.it_cos eq 0>
					<cfset it_cos = val(amt)>
                    <cfelse>
                    <cfset it_cos = form.it_cos>
                    </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#it_cos#" >,
					</cfif>
'#form.packing#','#form.shelf#','#form.supp#','#val(form.qty1)#','#val(form.qty2)#','#val(form.qty3)#','#val(form.qty4)#',
            '#val(form.qty5)#','#val(form.qty6)#','#val(form.qty7)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.job#">,
            '#nowDatetime#','#form.sv_part#','#val(form.sercost)#',
            '#huserid#','#sodate#','#dodate#',
            '#val(form.adtcost1)*currrate#','#val(form.adtcost2)*currrate#',
            '#form.enterbatch#','#expdate#','#manudate#','#form.milcert#','#form.importpermit#','#form.countryoforigin#','#val(form.pallet)#',
            '#val(form.mc1bil)#','#val(form.mc2bil)#','#form.defective#','#form.nodisplay#','#form.totalupdisplay#','#form.deductableitem#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.note1#">,'#form.title_id#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(form.title_desp)#">,
            <cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i"><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.title_despa#">,</cfif>
            <cfif getgsetup.bcurr EQ 'IDR'>
                '#trim(form.selectPPH)#'
 				,'#val(form.pph_amt_bil)#',
            </cfif>
            
            <cfset CommentLen = len(tostring(form.comment))>
            <cfset xComment = tostring(form.comment)>
            <cfset SingleQ = "">
            <cfset DoubleQ = "">
            
            <cfloop index = "Count" from = "1" to = "#CommentLen#">
                <cfif mid(xComment,Count,1) eq "'">
                    <cfset SingleQ = 'Y'>
                <cfelseif mid(xComment,Count,1) eq '"'>
                    <cfset DoubleQ = 'Y'>
                </cfif>
            </cfloop>
            
            <cfif SingleQ eq "Y" and DoubleQ eq "">
                <!--- Found ' in the comment --->
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#tostring(form.comment)#">,'0','0','0','0','0','0','0','0','0','0','0','0'<cfif isdefined('form.taxinclude') and wpitemtax eq "Y">,'#form.taxinclude#'</cfif><cfif isdefined('form.foc')>,"#form.foc#"</cfif><cfif isdefined('form.asvoucher')>,"Y",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#"></cfif>,<cfif getitemphoto.recordcount eq 0>''<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemphoto.photo#"></cfif><cfif isdefined('form.ictranfilename')>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ictranfilename#">
			</cfif><cfif isdefined('form.invlinklist')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invlinklist#"></cfif><cfif isdefined('form.invcnitem')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invcnitem#"></cfif>,'#movingstockbal#')
            <cfelseif SingleQ eq "" and DoubleQ eq "Y">
                <!--- Found " in the comment --->
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#tostring(form.comment)#">,'0','0','0','0','0','0','0','0','0','0','0','0'<cfif isdefined('form.taxinclude') and wpitemtax eq "Y">,'#form.taxinclude#'</cfif><cfif isdefined('form.foc')>,"#form.foc#"</cfif><cfif isdefined('form.asvoucher')>,"Y",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#"></cfif>,<cfif getitemphoto.recordcount eq 0>''<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemphoto.photo#"></cfif><cfif isdefined('form.ictranfilename')>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ictranfilename#">
			</cfif><cfif isdefined('form.invlinklist')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invlinklist#"></cfif><cfif isdefined('form.invcnitem')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invcnitem#"></cfif>,'#movingstockbal#')
            <cfelseif SingleQ eq "" and DoubleQ eq "">
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#tostring(form.comment)#">,'0','0','0','0','0','0','0','0','0','0','0','0'<cfif isdefined('form.taxinclude') and wpitemtax eq "Y">,'#form.taxinclude#'</cfif><cfif isdefined('form.foc')>,"#form.foc#"</cfif><cfif isdefined('form.asvoucher')>,"Y",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#"></cfif>,<cfif getitemphoto.recordcount eq 0>''<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemphoto.photo#"></cfif><cfif isdefined('form.ictranfilename')>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ictranfilename#">
			</cfif><cfif isdefined('form.invlinklist')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invlinklist#"></cfif><cfif isdefined('form.invcnitem')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invcnitem#"></cfif>,'#movingstockbal#')
            <cfelse>
                <h3>Error. You cannot key in both ' and " in the comment.</h3>
            <cfabort>
            
        </cfif>
    </cfquery>

<cfif getgsetup.recompriceup eq "Y"  and (getgeneralinfo.recompriceup1 eq "" or ListFindNoCase(getgeneralinfo.recompriceup1,tran))>
            <cfquery name="checkexist" datasource="#dts#">
            SELECT itemno,custno FROM icl3p<cfif tran eq "INV" or tran eq "SO" or tran eq "DO" or tran eq "QUO">2</cfif> WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
            and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
            </cfquery>
            <cfset xremprice = form.price>
            <cfset xdis1 = form.dispec1>
            <cfset xdis2 = form.dispec2>
            <cfset xdis3 = form.dispec3>
            <cfset xfirst = xremprice - (xdis1/100 * xremprice)>
            <cfset xsecond = xfirst - (xdis2/100 * xfirst)>
            <cfset xthird = xsecond - (xdis3/100 * xsecond)>
            <cfif checkexist.recordcount eq 0>
                <cfquery datasource="#dts#" name="inserticl3p2">
                    insert into icl3p<cfif tran eq "INV" or tran eq "SO" or tran eq "DO" or tran eq "QUO">2</cfif> (itemno,custno,price,dispec,dispec2,dispec3,netprice,ci_note,desp)
                    values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">, '#form.custno#', '#form.price#',
                    '#form.dispec1#','#form.dispec2#','#form.dispec3#', '#xthird#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#tran# - #nexttranno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">)
                </cfquery>	
            <cfelse>
                <cfquery name="updateicl3p2" datasource="#dts#">
                    UPDATE icl3p<cfif tran eq "INV" or tran eq "SO" or tran eq "DO" or tran eq "QUO">2</cfif> SET
                    price = '#form.price#',
                    dispec = '#form.dispec1#',
                    dispec2 = '#form.dispec2#',
                    dispec3 = '#form.dispec3#',
                    netprice = '#xthird#',
                    ci_note = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran# - #nexttranno#">,
                    desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
                    WHERE 
                    custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
                    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
                </cfquery>
            </cfif>	
        </cfif>
 
    
    <cfif lcase(hcomid) eq "accord_i" and tran eq "INV" and getcust.rem5 neq "" and isdate(form.brem4)>
            <cfquery name="updateexpdate" datasource="#dts#">
            Update vehicles SET inexpdate = "#dateformat(form.brem4,'YYYY-MM-DD')#" where carno = "#getcust.rem5#" and custcode = "#form.custno#"
            </cfquery>
            
			</cfif>
<cfcatch type="any">
	<script type="application/javascript">
	alert('Price/Qty Is Key In Wrongly!');
	history.go(-1);
	</script>
	<cfoutput>#cfcatch.Message#<br />#cfcatch.Detail#</cfoutput><cfabort>
</cfcatch>
</cftry>

<cfif wpitemtax eq "Y">
	<cfquery name="gettax" datasource="#dts#">
    	select sum(taxamt_bil) as tt_taxamt_bil from ictran where type='#tran#' and refno='#nexttranno#' and (void='' or void is null)
    </cfquery>
	<cfset gettax.tt_taxamt_bil=numberformat(val(gettax.tt_taxamt_bil),".__")>
    <cfquery name="updatetax" datasource="#dts#">
    	update artran set tax_bil='#val(gettax.tt_taxamt_bil)#'
		<!--- <cfif isdefined('form.taxinclude')>
		<cfif form.taxinclude eq "T">
        ,taxincl = "T"
		</cfif>
        </cfif> --->
        
         where type='#tran#' and refno='#nexttranno#'
    </cfquery>
</cfif>

		<cfif (lcase(hcomid) eq "amalax_i" or lcase(hcomid) eq "gamemartz_i") and tran eq "RC">
        <cfif val(form.requestdate) neq 0>
        <cfquery name="updateamalax" datasource="#dts#">
        update icitem set price='#val(form.requestdate)#' where itemno='#form.itemno#'
        </cfquery> 
        </cfif>
        </cfif>
		
<cfif getgsetup.autolocbf eq "Y">
<cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno#" type="#tran#" returnvariable="done" />
</cfif>
