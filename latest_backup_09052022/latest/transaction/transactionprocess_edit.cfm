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

<cfquery datasource="#dts#" name="getcust">
	select 
	name,
	van,
	wos_date,
    rem5
	from artran 
	where type='#tran#' 
	and refno='#nexttranno#';
</cfquery>

<cfquery datasource="#dts#" name="gettime">
	select 
	trdatetime 
	from ictran 
	where type='#tran#' 
	and refno='#nexttranno#' 
    <cfif tran neq 'QUO'>
	and itemno='#form.itemno#'
    </cfif>
	and itemcount='#itemcount#';
</cfquery>

<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">

<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
	<cfset obtype= "bth_qin">
<cfelse>
	<cfset obtype= "bth_qut">
</cfif>

<cfif trim(listfirst(enterbatch)) neq ""><!--- Enterbatch neq Empty --->
	<cfif listfirst(enterbatch) eq listfirst(oldenterbatch)><!--- Enterbatch eq Oldenterbatch --->
		<!--- <cfquery name="updatelobthob" datasource="#dts#">
			update obbatch set 
			#obtype#=(#obtype#+(#qty#-#oldqty#))
			where itemno='#form.itemno#' 
			and batchcode='#form.enterbatch#';
		</cfquery> --->
		<cfquery name="updatelobthob" datasource="#dts#">
			update obbatch set 
			#obtype#=(#obtype#+(#act_qty#-#oldqty#))
			where itemno='#form.itemno#' 
			and batchcode='#form.enterbatch#';
		</cfquery>
		
		<cfif listfirst(location) neq ""><!--- Location neq Empty --->
			<cfif listfirst(location) eq listfirst(oldlocation)><!--- Location eq Oldlocation --->
				<!--- <cfquery name="updatelobthob" datasource="#dts#">
					update lobthob set 
					#obtype#=(#obtype#+(#qty#-#oldqty#)) 
					where location='#listfirst(location)#' 
					and itemno='#itemno#' 
					and batchcode='#listfirst(enterbatch)#';
				</cfquery> --->
				<cfquery name="updatelobthob" datasource="#dts#">
					update lobthob set 
					#obtype#=(#obtype#+(#act_qty#-#oldqty#))
					where location='#listfirst(location)#' 
					and itemno='#itemno#' 
					and batchcode='#listfirst(enterbatch)#';
				</cfquery>
			<cfelse><!--- Location neq Oldlocation --->
				<cfquery name="checklocationbatch" datasource="#dts#">
					select 
					batchcode 
					from lobthob 
					where location='#listfirst(location)#' 
					and batchcode='#listfirst(enterbatch)#' 
					and itemno='#itemno#';
				</cfquery>
					
				<cfif checklocationbatch.recordcount eq 0>
					<!--- <cfquery name="insertbatch" datasource="#dts#">
						insert into lobthob 
						values 
						(
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
							'#form.tran#',
							'#form.nexttranno#',
							'0',
							'<cfif obtype eq "bth_qin">#qty#<cfelse>0</cfif>',
							'<cfif obtype eq "bth_qut">#qty#<cfelse>0</cfif>',
							'0',
							'0',
							'0',
							'#dateformat(expdate,"yyyy-mm-dd")#',
							'#form.tran#',
							'#form.nexttranno#',
							'#dateformat(expdate,"yyyy-mm-dd")#'
						);
					</cfquery> --->
					<cfquery name="insertbatch" datasource="#dts#">
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
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
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
					
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where location='#listfirst(oldlocation)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery>
				<cfelse>
					<!--- <cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+#qty#)
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery> --->
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+#act_qty#)
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery>
					
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where location='#listfirst(oldlocation)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery>
				</cfif>					
			</cfif>
		<cfelse><!--- Location eq Empty --->
			<cfquery name="updatelobthob" datasource="#dts#">
				update lobthob set 
				#obtype#=(#obtype#-#oldqty#)
				where location='#listfirst(oldlocation)#' 
				and itemno='#itemno#' 
				and batchcode='#listfirst(enterbatch)#';
			</cfquery>
		</cfif>
	<cfelse><!--- Enterbatch neq Oldenterbatch --->
		<cfquery name="checkbatch" datasource="#dts#">
			select batchcode 
			from obbatch 
			where batchcode='#listfirst(enterbatch)#' 
			and itemno='#itemno#';
		</cfquery>
		
		<cfif checkbatch.recordcount eq 0>
			<!--- <cfquery name="insertbatch" datasource="#dts#">
				insert into obbatch 
				values 
				(
					'#listfirst(enterbatch)#',
					'#itemno#',
					'#form.tran#',
					'#form.nexttranno#',
					'0',
					'<cfif obtype eq "bth_qin">#qty#<cfelse>0</cfif>',
					'<cfif obtype eq "bth_qut">#qty#<cfelse>0</cfif>',
					'0',
					'0',
					'0',
					'#dateformat(expdate,"yyyy-mm-dd")#',
					'#form.tran#',
					'#form.nexttranno#',
					'#dateformat(expdate,"yyyy-mm-dd")#'
				);
			</cfquery> --->
			<cfif (checkcustom.customcompany eq "Y") and (tran eq "RC" or tran eq "OAI" or tran eq "CN")>
				<cfquery name="updateLotNo" datasource="#dts#">
					update gsetup
					set lotno = '#listfirst(enterbatch)#'
				</cfquery>
				<cfquery name="insert" datasource="#dts#">
					insert into lotnumber
					(LotNumber,itemno)
					value
					(<cfqueryparam cfsqltype="cf_sql_char" value="#listfirst(enterbatch)#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">)
				</cfquery>
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
					'#listfirst(enterbatch)#',
					'#itemno#',
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
			
			<cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#-#oldqty#)
				where batchcode='#listfirst(oldenterbatch)#' 
				and itemno='#itemno#';
			</cfquery>
		<cfelse>
			<!--- <cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#+#qty#) 
				where batchcode='#listfirst(enterbatch)#' 
				and itemno='#itemno#';
			</cfquery> --->
			<cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#+#act_qty#) ,manu_date='#manudate#',EXP_DATE='#expdate#'
				where batchcode='#listfirst(enterbatch)#' 
				and itemno='#itemno#';
			</cfquery>
			
			<cfquery name="updateobbatch" datasource="#dts#">
				update obbatch set 
				#obtype#=(#obtype#-#oldqty#)
				where batchcode='#listfirst(oldenterbatch)#' 
				and itemno='#itemno#';
			</cfquery>
		</cfif>

		<cfif listfirst(location) neq ""><!--- Location neq Empty --->
			<cfquery name="checklocationbatch" datasource="#dts#">
				select 
				batchcode 
				from lobthob 
				where location='#listfirst(location)#' 
				and batchcode='#listfirst(enterbatch)#' 
				and itemno='#itemno#';
			</cfquery>
			
			<cfif listfirst(location) eq listfirst(oldlocation)><!--- Location eq Oldlocation --->					
				<cfif checklocationbatch.recordcount eq 0>
					<!--- <cfquery name="insertbatch" datasource="#dts#">
						insert into lobthob 
						values 
						(
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
							'#form.tran#',
							'#form.nexttranno#',
							'0',
							'<cfif obtype eq "bth_qin">#qty#<cfelse>0</cfif>',
							'<cfif obtype eq "bth_qut">#qty#<cfelse>0</cfif>',
							'0',
							'0',
							'0',
							'#dateformat(expdate,"yyyy-mm-dd")#',
							'#form.tran#',
							'#form.nexttranno#',
							'#dateformat(expdate,"yyyy-mm-dd")#'
						);
					</cfquery> --->
					<cfquery name="insertbatch" datasource="#dts#">
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
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
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
					
					<!--- ADD ON 21-04-2009 --->
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where batchcode='#listfirst(oldenterbatch)#'
						and location='#listfirst(oldlocation)#' 
						and itemno='#itemno#';
					</cfquery>
				<cfelse>
					<!--- <cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#qty#-#oldqty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery> --->
					<!--- <cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#act_qty#-#oldqty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery> REMARK ON 21-04-2009 AND REPLACE WITH THE BELOW ONE --->
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#act_qty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery>
					
					<!--- ADD ON 21-04-2009 --->
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where batchcode='#listfirst(oldenterbatch)#'
						and location='#listfirst(oldlocation)#' 
						and itemno='#itemno#';
					</cfquery>
				</cfif>
			<cfelse><!--- Location neq Oldlocation --->
				<cfif checklocationbatch.recordcount eq 0>
					<!--- <cfquery name="insertbatch" datasource="#dts#">
						insert into lobthob 
						values 
						(
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
							'#form.tran#',
							'#form.nexttranno#',
							'0',
							'<cfif obtype eq "bth_qin">#qty#<cfelse>0</cfif>',
							'<cfif obtype eq "bth_qut">#qty#<cfelse>0</cfif>',
							'0',
							'0',
							'0',
							'#dateformat(expdate,"yyyy-mm-dd")#',
							'#form.tran#',
							'#form.nexttranno#',
							'#dateformat(expdate,"yyyy-mm-dd")#'
						);
					</cfquery> --->
					<cfquery name="insertbatch" datasource="#dts#">
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
							'#listfirst(location)#',
							'#listfirst(enterbatch)#',
							'#itemno#',
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
					
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where location='#listfirst(oldlocation)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(oldenterbatch)#';
					</cfquery>
				<cfelse>
					<!--- <cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#qty#-#oldqty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery> --->
					<!--- <cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#act_qty#-#oldqty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery> REMARK ON 21-04-2009 AND REPLACE WITH THE BELOW ONE --->
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#+(#act_qty#))
						where location='#listfirst(location)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(enterbatch)#';
					</cfquery>
					
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set 
						#obtype#=(#obtype#-#oldqty#)
						where location='#listfirst(oldlocation)#' 
						and itemno='#itemno#' 
						and batchcode='#listfirst(oldenterbatch)#';
					</cfquery>
				</cfif>
			</cfif>
		<cfelse><!--- Location eq Empty --->						
			<cfquery name="updatelobthob" datasource="#dts#">
				update lobthob set 
				#obtype#=(#obtype#-#oldqty#)
				where location='#listfirst(oldlocation)#' 
				and itemno='#itemno#' 
				and batchcode='#listfirst(enterbatch)#';
			</cfquery>
		</cfif>
	</cfif>
<cfelse><!--- Enterbatch eq Empty --->
	<cfif listfirst(oldenterbatch) neq "">
		<cfquery name="updatelobthob" datasource="#dts#">
			update obbatch set 
			#obtype#=(#obtype#-#oldqty#)
			where itemno='#listfirst(itemno)#' 
			and batchcode='#listfirst(oldenterbatch)#';
		</cfquery>
				
		<cfquery name="updatelobthob" datasource="#dts#">
			update lobthob set 
			#obtype#=(#obtype#-#oldqty#) 
			where location='#oldlocation#' 
			and itemno='#listfirst(itemno)#' 
			and batchcode='#listfirst(oldenterbatch)#';
		</cfquery>
	</cfif>
</cfif>

</cfif>

<cfif lcase(HUserID) neq "kellysteel2">
	<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">
		<cfif tran eq "OAI" or tran eq "RC" or tran eq "DN">
			<cfset qname='QIN'&(readperiod+10)>
		<cfelse>
			<cfset qname='QOUT'&(readperiod+10)>
		</cfif>
	
		<cfquery name="checkitemqty" datasource="#dts#">
			select 
			itemno 
			from icitem 
			where itemno='#form.itemno#' 
			and #qname# <> 0
		</cfquery>
		
		<cfif checkitemqty.recordcount eq 0>
			<cfset check = "y">
		<cfelse>
			<cfset check = "n">
		</cfif>
			
		<!--- <cfquery name="UpdateIcitem" datasource="#dts#">
			update icitem set 
			#qname#=<cfif check eq "y">(#qname#+#qty#)<cfelse>(#qname#+(#qty#-#oldqty#))</cfif> 
			where itemno='#itemno#';
		</cfquery> --->
		<cfquery name="UpdateIcitem" datasource="#dts#">
			update icitem set 
			#qname#=<cfif check eq "y">(#qname#+#act_qty#)<cfelse>(#qname#+(#act_qty#-#oldqty#))</cfif> 
			where itemno='#itemno#';
		</cfquery>
	</cfif>
</cfif>

<cfif form.grdcolumnlist neq "" and form.service eq "">
	<cfset grdcolumnlist = form.grdcolumnlist>
	<cfset grdvaluelist = form.grdvaluelist>
	<cfset bgrdcolumnlist = form.bgrdcolumnlist>
	<cfset oldgrdvaluelist = form.oldgrdvaluelist>
	
	<cfset myArray = ListToArray(grdcolumnlist,",")>
	<cfset myArray2 = ListToArray(grdvaluelist,",")>
	<cfset myArray3 = ListToArray(bgrdcolumnlist,",")>
	<cfset myArray4 = ListToArray(oldgrdvaluelist,",")>
	
	<cfquery name="checkexist" datasource="#dts#">
		select * from igrade
		where type='#tran#' 
		and refno='#nexttranno#' 
		and itemno='#form.itemno#' 
		and trancode='#itemcount#'
	</cfquery>
	
	<cfif checkexist.recordcount eq 0>
		<cfquery name="insert" datasource="#dts#">
			insert into igrade
			(type,refno,itemno,trancode,sign)
			values
			('#tran#','#nexttranno#','#form.itemno#','#itemcount#',<cfif tran eq "RC" or tran eq "PO" or tran eq "CN" or tran eq "OAI">'1'<cfelse>'-1'</cfif>)
		</cfquery>
		<cfset oldfactor1 = 1>
		<cfset oldfactor2 = 1>
	<cfelse>
		<cfset oldfactor1 = checkexist.factor1>
		<cfset oldfactor2 = checkexist.factor2>
	</cfif>
	
	<!--- <cfquery name="updateigrade" datasource="#dts#">
		update igrade
		set wos_date=#getcust.wos_date#,
		fperiod='#numberformat(readperiod,"00")#',
		location ='#form.location#',
		custno='#form.custno#',
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray[i]# = #myArray2[i]#,
			<cfelse>
				#myArray[i]# = #myArray2[i]#
			</cfif>
		</cfloop>
		where type='#tran#' 
		and refno='#nexttranno#' 
		and itemno='#form.itemno#' 
		and trancode='#itemcount#'
	</cfquery> --->
	<cfquery name="updateigrade" datasource="#dts#">
		update igrade
		set wos_date=#getcust.wos_date#,
		fperiod='#numberformat(readperiod,"00")#',
		location ='#form.location#',
		custno='#form.custno#',
		factor1='#form.factor1#',
		factor2='#form.factor2#',
		<cfloop from="1" to="#form.totalrecord#" index="i">
			<cfif i neq form.totalrecord>
				#myArray[i]# = #myArray2[i]#,
			<cfelse>
				#myArray[i]# = #myArray2[i]#
			</cfif>
		</cfloop>
		where type='#tran#' 
		and refno='#nexttranno#' 
		and itemno='#form.itemno#' 
		and trancode='#itemcount#'
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
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#
				</cfif>
			</cfloop>
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
		</cfquery> --->
		<cfquery name="updateitemgrd" datasource="#dts#">
			update itemgrd
			set
			<cfloop from="1" to="#form.totalrecord#" index="i">
				<cfif i neq form.totalrecord>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
					<cfif val(oldfactor2) neq 0>
						(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
					<cfelse>
						0
					</cfif>
					<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
					<cfif val(form.factor2) neq 0>
						(#myArray2[i]# * #form.factor1# / #form.factor2#)
					<cfelse>
						0
					</cfif>,
				<cfelse>
					#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
					<cfif val(oldfactor2) neq 0>
						(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
					<cfelse>
						0
					</cfif>
					<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
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
		
		<cfif oldlocation eq form.location>		<!--- Old location same with new location --->
			<!--- <cfquery name="updatelogrdob" datasource="#dts#">
				update logrdob
				set
				<cfloop from="1" to="#form.totalrecord#" index="i">
					<cfif i neq form.totalrecord>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#,
					<cfelse>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#
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
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
						<cfif val(oldfactor2) neq 0>
							(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
						<cfelse>
							0
						</cfif>
						<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
						<cfif val(form.factor2) neq 0>
							(#myArray2[i]# * #form.factor1# / #form.factor2#)
						<cfelse>
							0
						</cfif>,
					<cfelse>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
						<cfif val(oldfactor2) neq 0>
							(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
						<cfelse>
							0
						</cfif>
						<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
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
		<cfelse>
			<!--- <cfquery name="updatelogrdob" datasource="#dts#">
				update logrdob
				set
				<cfloop from="1" to="#form.totalrecord#" index="i">
					<cfif i neq form.totalrecord>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#,
					<cfelse>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>#myArray4[i]#
					</cfif>
				</cfloop>
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
				and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.oldlocation#">
			</cfquery> --->
			<cfquery name="updatelogrdob" datasource="#dts#">
				update logrdob
				set
				<cfloop from="1" to="#form.totalrecord#" index="i">
					<cfif i neq form.totalrecord>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
						<cfif val(oldfactor2) neq 0>
							(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
						<cfelse>
							0
						</cfif>,
					<cfelse>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">-<cfelse>+</cfif>
						<cfif val(oldfactor2) neq 0>
							(#myArray4[i]# * #oldfactor1# / #oldfactor2#)
						<cfelse>
							0
						</cfif>
					</cfif>
				</cfloop>
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
				and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.oldlocation#">
			</cfquery>
			
			<!--- <cfquery name="updatelogrdob2" datasource="#dts#">
				update logrdob
				set
				<cfloop from="1" to="#form.totalrecord#" index="i">
					<cfif i neq form.totalrecord>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#,
					<cfelse>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>#myArray2[i]#
					</cfif>
				</cfloop>
				where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">
				and location = <cfqueryparam cfsqltype="cf_sql_char" value="#form.location#">
			</cfquery> --->
			<cfquery name="updatelogrdob2" datasource="#dts#">
				update logrdob
				set
				<cfloop from="1" to="#form.totalrecord#" index="i">
					<cfif i neq form.totalrecord>
						#myArray3[i]# = #myArray3[i]#<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">+<cfelse>-</cfif>
						<cfif val(form.factor2) neq 0>
							(#myArray2[i]# * #form.factor1# / #form.factor2#)
						<cfelse>
							0
						</cfif>,
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
</cfif>

<cfset xtime = right(gettime.trdatetime,10)>
<cfset xtime2 = timeformat(now(),"HH:MM:SS")>		
<cfset nowdatetime = dateformat(getcust.wos_date,"yyyy-mm-dd") & " " & xtime2>

<!---cfquery datasource="#dts#" name="updateartran">
	update ictran set 
	wos_date=#getcust.wos_date#,
	location ='#form.location#',
	custno='#form.custno#',
	desp='#jsstringformat(preservesinglequotes(form.desp))#',
	despa='#jsstringformat(preservesinglequotes(form.despa))#',
	currrate='#currrate#',
	fperiod='#numberformat(readperiod,"00")#',
	agenno='#form.agenno#',
	dispec1='#form.dispec1#',
	dispec2='#form.dispec2#',
	dispec3='#form.dispec3#',
	taxpec1='#form.taxpec1#',
	gltradac='#form.gltradac#',
	qty_bil='#form.qty#',
	price_bil='#form.price#',
	unit_bil='#form.unit#',
	amt1_bil='#amt1_bil#', 
	disamt_bil='#disamt_bil#',
	amt_bil='#val(amt_bil)#',
	taxamt_bil ='#taxamt_bil#',
	qty='#form.qty#',
	price='#xprice#',
	unit='#jsstringformat(preservesinglequotes(form.unit))#',
	amt1='#amt1#',
	disamt='#disamt#',
	amt='#val(amt)#',
	taxamt='#taxamt#',
	brem1='#form.requestdate#',
	brem2='#form.crequestdate#',
	brem3='#form.brem3#',
	brem4='<cfif ucase(form.brem4) eq "XCOST">XCOST<cfelse>#form.brem4#</cfif>',
	packing='#form.packing#',
	van='#getcust.van#',
	name='#getcust.name#',
	wos_group='#getitem.wos_group#',
	category='#getitem.category#',
	sv_part='#form.sv_part#',
	sercost='#form.sercost#',
	userid='#huserid#',
	trdatetime='#nowdatetime#',
	comment='#jsstringformat(preservesinglequotes(form.comment))#',
	sodate='#dateformat(sodate,"yyyy-mm-dd")#',
	dodate='#dateformat(dodate,"yyyy-mm-dd")#',
	adtcost1='#val(form.adtcost1)*currrate#',
	adtcost2='#val(form.adtcost2)*currrate#',
	batchcode='#form.enterbatch#',
	expdate='#dateformat(expdate,"yyyy-mm-dd")#',
	mc1_bil='#form.mc1bil#',
	mc2_bil='#form.mc2bil#',
	defective='#form.defective#',
	mc1_bil=mc1_bil,
	mc2_bil=mc2_bil,
	mc3_bil=mc3_bil,
	mc4_bil=mc4_bil,
	mc5_bil=mc5_bil,
	mc6_bil=mc6_bil,
	mc7_bil=mc7_bil,
	m_charge1=m_charge1,
	m_charge2=m_charge2,
	m_charge3=m_charge3,
	m_charge4=m_charge4,
	m_charge5=m_charge5,
	m_charge6=m_charge6,
	m_charge7=m_charge7 
	
	where type='#tran#' 
	and refno='#nexttranno#' 
	and itemno='#form.itemno#' 
	and itemcount='#itemcount#';
</cfquery--->		
<cftry>
<cfif isdefined('form.asvoucher')>
<cfquery name="getictran" datasource="#dts#">
SELECT voucherno FROM ictran where type='#tran#' 
        and refno='#nexttranno#' 
        and itemno='#form.itemno#' 
        and itemcount='#itemcount#';
</cfquery>

<cfif getictran.voucherno neq "">
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
        SELECT voucherno FROM voucher where voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#"> and voucherid <> "#getictran.voucherno#"
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
  <cfquery name="updatevoucher" datasource="#dts#">
    UPDATE voucher
    SET
    voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#">,
    custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
    value = '#val(amt1_bil)#',
    updated_by = '#huserid#',
    updated_on = now()
    WHERE voucherid = "#getictran.voucherno#"
    </cfquery>
    <cfset form.voucherno = getictran.voucherno>
    
    <cfelse>
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
(<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#">,'Value','#val(amt_bil)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,'#HUserID#',now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#" >)
    </cfquery>
    <cfquery name="getID" datasource="#dts#">
			Select LAST_INSERT_ID() as en;
	</cfquery>
    <cfset form.voucherno = getID.en>
    <cfset form.asvoucher = "Y">
	</cfif>
    
	
	<cfelseif isdefined('form.asvoucher') eq false and getGeneralInfo.asvoucher eq "Y">
    
    <cfquery name="getictran" datasource="#dts#">
    SELECT voucherno FROM ictran where type='#tran#' 
            and refno='#nexttranno#' 
            and itemno='#form.itemno#' 
            and itemcount='#itemcount#';
    </cfquery>
    <cfquery name="deletevoucher" datasource="#dts#">
    delete from voucher where voucherid = "#getictran.voucherno#"
    </cfquery>
    <cfset form.asvoucher = "N">
    <cfset form.voucherno = "">
</cfif>
	<cfoutput>
    
    </cfoutput>
    <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" <!---or lcase(hcomid) eq "lkatlb_i"--->
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
    <!---shell company do not run recover bill--->
    <cfelse>
    
    <!---Update update from bill--->
    <cfif act_qty neq oldqty>
    <cfquery datasource="#dts#" name="checkiclinkexist">
    select * from iclink where type='#tran#' and refno='#nexttranno#' and trancode='#itemcount#';
    </cfquery>
    <cfif checkiclinkexist.recordcount neq 0>
    <cfquery datasource="#dts#" name="getupdatedfromrefno">
    select ifnull(qty,0) as qty,ifnull(shipped,0) as shipped from ictran where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    <cfif act_qty gt oldqty>
    <cfif val(act_qty)-val(oldqty) gt val(getupdatedfromrefno.qty)-val(getupdatedfromrefno.shipped)>
    <!--- --->
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatefromrefno">
    update ictran set shipped=qty,toship=0 where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    </cfif>
    <cfquery datasource="#dts#" name="updateiclink">
    update iclink set qty='#val(act_qty)#' where refno='#nexttranno#' and type='#tran#' and trancode='#itemcount#'
    </cfquery>
    <!--- --->
    <cfelse>
    <!--- --->
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatefromrefno">
    update ictran set shipped='#getupdatedfromrefno.shipped+(act_qty-oldqty)#' where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    <cfquery datasource="#dts#" name="updatefromrefno2">
    update ictran set toship=qty-shipped where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    </cfif>
    <cfquery datasource="#dts#" name="updateiclink">
    update iclink set qty='#getupdatedfromrefno.shipped+(act_qty-oldqty)#' where refno='#nexttranno#' and type='#tran#' and trancode='#itemcount#'
    </cfquery>
    <!--- --->
    </cfif>
    <cfquery datasource="#dts#" name="checkordercl">
    select sum(qty)-sum(shipped) as qty from ictran where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#'
    </cfquery>
    
    <cfif checkordercl.qty eq 0>
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatetoinvartran">
    update artran set toinv='#nexttranno#',order_cl='Y' where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#'
    </cfquery>
    </cfif>
    </cfif>
    <cfelse>
    
    <cfif val(act_qty) gt 0>
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatefromrefno">
    update ictran set shipped='#val(act_qty)#' where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    <cfquery datasource="#dts#" name="updatefromrefno2">
    update ictran set toship=qty-shipped where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    </cfif>
    <cfquery datasource="#dts#" name="updateiclink">
    update iclink set qty='#val(act_qty)#' where refno='#nexttranno#' and type='#tran#' and trancode='#itemcount#'
    </cfquery>
    <cfelse>
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatefromrefno">
    update ictran set shipped='0' where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    <cfquery datasource="#dts#" name="updatefromrefno2">
    update ictran set toship=qty-shipped where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#' and trancode='#checkiclinkexist.frtrancode#'
    </cfquery>
    </cfif>
    <cfquery datasource="#dts#" name="updateiclink">
    update iclink set qty='0' where refno='#nexttranno#' and type='#tran#' and trancode='#itemcount#'
    </cfquery>
    
    </cfif>
    <cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'SAM') and checkiclinkexist.frtype eq 'SO'>
    <cfelse>
    <cfquery datasource="#dts#" name="updatetoinvartran">
    update artran set toinv='',order_cl='' where refno='#checkiclinkexist.frrefno#' and type='#checkiclinkexist.frtype#'
    </cfquery>
    </cfif>
    </cfif>
    </cfif>
    </cfif>
	<!---end update from bill--->
    </cfif>

    <cfquery datasource="#dts#" name="updateartran">
        update ictran set 
        wos_date=#getcust.wos_date#,
        location ='#form.location#',
        custno='#form.custno#',
        desp='#jsstringformat(preservesinglequotes(form.desp))#',
        despa='#jsstringformat(preservesinglequotes(form.despa))#',
        currrate='#currrate#',
        fperiod='#numberformat(readperiod,"00")#',
        agenno='#form.agenno#',
        dispec1='#val(form.dispec1)#',
        dispec2='#val(form.dispec2)#',
        dispec3='#val(form.dispec3)#',
        taxpec1='#form.taxpec1#',
        gltradac='#trim(form.gltradac)#',
        qty_bil='#val(form.qty)#',
        price_bil='#form.price#',
        unit_bil='#form.unit#',
        amt1_bil='#amt1_bil#', 
        disamt_bil='#disamt_bil#',
        amt_bil='#val(amt_bil)#',
        taxamt_bil ='#taxamt_bil#',
        qty='#act_qty#',
        price='#xprice#',
        unit='#getitem.unit#',
        factor1 = '#form.factor1#',
        factor2 = '#form.factor2#',
        amt1='#amt1#',
        disamt='#disamt#',
        amt='#val(amt)#',
        taxamt='#taxamt#',
        note_a='#form.selecttax#',
        brem1='#form.requestdate#',
        brem2='#form.crequestdate#',
        brem3='#form.brem3#',
        dono='#form.dono#',
        brem4='<cfif ucase(form.brem4) eq "XCOST">XCOST<cfelse>#form.brem4#</cfif>',
        requiredate='#requiredate#',
        replydate='#replydate#',
        deliverydate='#deliverydate#',
        pono='#form.pono#',
        <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
            brem5='#form.brem5#',
            brem6='#form.brem6#',
        <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i" or lcase(hcomid) eq "asaiki_i">
        	brem7='#form.brem7#',
            brem8='#form.brem8#',
            brem9='#form.brem9#',
		</cfif>
        <cfelseif checkcustom.customcompany eq "Y">
            brem5='#form.hremark5#',
            brem7='#form.hremark6#',
            brem8='#form.bremark8#',
            brem9='#form.bremark9#',
            brem10='#form.bremark10#',
        </cfif>
        packing='#form.packing#',
        supp='#form.supp#',
        qty1='#val(form.qty1)#',
        qty2='#val(form.qty2)#',
        qty3='#val(form.qty3)#',
        qty4='#val(form.qty4)#',
        qty5='#val(form.qty5)#',
        qty6='#val(form.qty6)#',
        qty7='#val(form.qty7)#',
        van='#getcust.van#',
        name='#getcust.name#',
        wos_group=<cfif lcase(hcomid) eq "ltm_i">'#form.crequestdate#'<cfelse>'#getitem.wos_group#'</cfif>,
        category='#getitem.category#',
        sv_part='#form.sv_part#',
        sercost='#val(form.sercost)#',
        userid='#huserid#',
        trdatetime='#nowdatetime#',
        comment=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tostring(form.comment)#">,
        sodate='#sodate#',
        dodate='#dodate#',
        adtcost1='#val(form.adtcost1)*currrate#',
        adtcost2='#val(form.adtcost2)*currrate#',
        batchcode='#form.enterbatch#',
        expdate='#expdate#',
        manudate='#manudate#',
        milcert='#form.milcert#',
        importpermit='#form.importpermit#',
        countryoforigin='#form.countryoforigin#',
        pallet='#val(form.pallet)#',
        mc1_bil='#form.mc1bil#',
        mc2_bil='#form.mc2bil#',
        defective='#form.defective#',
        nodisplay='#form.nodisplay#',
        totalupdisplay='#form.totalupdisplay#',
        deductableitem='#form.deductableitem#',
        note1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(form.note1)#">,
        title_id='#form.title_id#',
        title_desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(form.title_desp)#">,
		source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#">,
		job=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.job#">,
        <cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">title_despa=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.title_despa#">,</cfif>
        mc1_bil=mc1_bil,
        mc2_bil=mc2_bil,
        mc3_bil=mc3_bil,
        mc4_bil=mc4_bil,
        mc5_bil=mc5_bil,
        mc6_bil=mc6_bil,
        mc7_bil=mc7_bil,
        m_charge1=m_charge1,
        m_charge2=m_charge2,
        m_charge3=m_charge3,
        m_charge4=m_charge4,
        m_charge5=m_charge5,
        m_charge6=m_charge6,
        m_charge7=m_charge7
        <cfif isdefined('form.taxinclude') and wpitemtax eq "Y">,taxincl = '#form.taxinclude#'<cfelse>,taxincl = ''</cfif> 
        <cfif isdefined('form.it_cos') and tran eq "CN">
        <cfif form.it_cos eq "" or form.it_cos eq 0>
        <cfset it_cos = val(amt)>
        <cfelse>
        <cfset it_cos = form.it_cos>
		</cfif>
        ,it_cos = <cfqueryparam cfsqltype="cf_sql_varchar" value="#it_cos#" >
		</cfif>
        <cfif isdefined('form.foc')>,foc="#form.foc#"</cfif>
        <cfif isdefined('form.asvoucher')>
        ,asvoucher="#form.asvoucher#"
        ,voucherno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.voucherno#"></cfif>
        <cfif isdefined('form.ictranfilename')>
            ,ictranfilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ictranfilename#">
			</cfif>
        <cfif isdefined('form.invlinklist')>
        ,invlinklist=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invlinklist#">
		</cfif>
		<cfif isdefined('form.invcnitem')>
        ,invcnitem=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invcnitem#">
		</cfif>
        
        <cfif isdefined('form.sono')>
        ,sono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#">
		</cfif>
		<cfif isdefined('form.soitem')>
        ,soitem=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.soitem#">
		</cfif>
        
        <cfif tran eq 'QUO'>
        ,itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
        </cfif>
        <cfif lcase(hcomid) eq "hodaka_i" and (tran eq "INV" or tran eq "CS" )>
        ,itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
        </cfif>
        where type='#tran#' 
        and refno='#nexttranno#'
        <cfif lcase(hcomid) eq "hodaka_i" and (tran eq "INV" or tran eq "CS" )>
        <cfelse> 
        <cfif tran neq 'QUO'>
        and itemno='#form.itemno#' 
        </cfif>
        </cfif>
        and itemcount='#itemcount#';
    </cfquery>
    
     <cfquery name="getgsetup" datasource="#dts#">
            SELECT recompriceup,recompriceup1 FROM gsetup
    </cfquery>
    <cfif getgsetup.recompriceup eq "Y" and (getgsetup.recompriceup1 eq "" or ListFindNoCase(getgsetup.recompriceup1,tran))>
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
	<cfoutput>#cfcatch.Message#<br />#cfcatch.Detail#</cfoutput><cfabort>
</cfcatch>
</cftry>

<cfif wpitemtax eq "Y">
	<cfquery name="gettax" datasource="#dts#">
    	select sum(taxamt_bil) as tt_taxamt_bil from ictran where type='#tran#' and refno='#nexttranno#' and (void='' or void is null)
    </cfquery>
	<cfset gettax.tt_taxamt_bil=numberformat(val(gettax.tt_taxamt_bil),".__")>
    <cfquery name="updatetax" datasource="#dts#">
    	update artran set tax_bil='#val(gettax.tt_taxamt_bil)#' where type='#tran#' and refno='#nexttranno#'
    </cfquery>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
SELECT autolocbf FROM gsetup
</cfquery>
<cfif getgeneral.autolocbf eq "Y">
<cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno#" type="#tran#" returnvariable="done" />
</cfif>
<cfset status = "Item Edited Successfully">
