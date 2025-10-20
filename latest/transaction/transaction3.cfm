<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT *
	FROM gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>

<cfquery name="getuserdefault" datasource="#dts#">
    select * from userdefault
</cfquery>

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfquery name="listAttention" datasource="#dts#">
	SELECT attentionno,name 
	FROM attention;
</cfquery>

<cfquery name="gettermcondition" datasource="#dts#">
    select * from ictermandcondition
</cfquery>


<cfquery name="getusername" datasource="main">
    select username from users where userid='#huserid#' and userbranch='#dts#'
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfif isdefined('form.custno') and (getgsetup.prefixbycustquo eq 'Y' or getgsetup.prefixbycustso eq 'Y' or getgsetup.prefixbycustinv eq 'Y')>
<cfquery name="getcustprefixno" datasource="#dts#">
	select arrem2,arrem3,arrem4 from #target_arcust# where custno='#form.custno#'
</cfquery>
</cfif>

<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,DECL_TOTALAMT as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfset stDecl_UPrice=getgsetup2.Decl_Uprice>
<cfset stDecl_Disc=getgsetup2.DECL_DISCOUNT1>

<!---  chonghow --->
<cfif isdefined('form.recoverCoC')>
<cfquery name="RecoverCoC" datasource="#replace(dts,'_i','_c')#">
 UPDATE QA08 SET
        coc_no = '',
        toinv = ''
        WHERE COC_NO = '#form.nexttranno#'
</cfquery>
</cfif>
<!---  chonghow --->

<cfif isdefined("form.transactiondate")>
	<cfif transactiondate neq ''>
    <cfset ndatecreatetran=createdate(right(form.transactiondate,4),mid(form.transactiondate,4,2),left(form.transactiondate,2))>
    <cfelse>
    <cfset ndatecreatetran=''>
    </cfif>
</cfif>

<!---transaction process--->

<cfif isdefined('form.type') and isdefined("form.remark12")> <!--- from first page --->
	<!--- Add On 12-01-2010 --->
	<cfif form.type eq 'Create' and isdefined('session.tran_refno')>
    <cfset newformname = "transpage"&form.newuuid>
			<!---check duplicate entry--->
            <cfif IsDefined("session.#newformname#") and session[#newformname#] eq "transpage">
            <cfset StructDelete(Session, "#newformname#")>
            <cfelse>
            <cfoutput>
            <h1>Duplicate Submission Detected. Please do not press back button.</h1>
            <cfabort />
            </cfoutput>
            </cfif>
            <!---check duplicate entry--->
    
		<cfquery name="checkexistrefno" datasource="#dts#">
			select * from artran where type='#tran#' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.tran_refno#">
		</cfquery>
			<cfif checkexistrefno.recordcount neq 0>
        	<cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#tran#'
				and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery>
            <!---cust refno --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem2>
			</cfif>
            
            <cfif getgsetup.prefixbycustso eq 'Y' and tran eq 'SO' and getcustprefixno.arrem3 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem3 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem3>
			</cfif>
            
            <cfif getgsetup.prefixbycustinv eq 'Y' and tran eq 'INV' and getcustprefixno.arrem4 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem4 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem4>
			</cfif>
            <!--- --->
            
			<cfif getGeneralInfo.arun eq "1">
            <cfset refnocheck = 0>
            <cfset refno1 = checkexistrefno.refno>
            <cfloop condition="refnocheck eq 0">
            <cftry>
            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="newnextNum"/>
            <cfcatch>
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="newnextNum" />	
            </cfcatch>
            </cftry>
            <cfquery name="checkexistence" datasource="#dts#">
            SELECT refno FROM artran WHERE 
            refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextNum#"> and type = '#tran#'
            </cfquery>
            <cfif checkexistence.recordcount eq 0>
            <cfset refnocheck = 1>
            <cfelse>
            <cfset refno1 = newnextNum>
            </cfif>
            </cfloop>
			<cfset form.currefno=newnextNum>
            <cfelse>
            <cfset form.type='Edit'>
            <cfset form.currefno=checkexistrefno.refno>
            </cfif>
        </cfif>
	</cfif>
	
    <!---delete--->
	<cfif form.type eq 'Delete'>
		<cfif isdefined("form.keepDeleted")>
			<cfset keepDeleted="1">
			<cfset deleteStatus="Voided">
		<cfelse>
			<cfset keepDeleted="">
			<cfset deleteStatus="Deleted">
		</cfif>
        
        <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i">
            <cfquery datasource='#dts#' name='deliclink2'>
				delete from servicededuct where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			</cfif>
        
		<cfset status = '#tranname# #deleteStatus# Successfully'>
		<!--- Recover --->
		<cfif isdefined("form.recover") and isdefined("form.related")>

        	<cfset crmdts=replace(dts,'_i','_c','all')>
            <cftry>
            <cfquery datasource='#dts#' name='getitem'>
				select frtype,frrefno,frdate,frtrancode,itemno,qty from iclink where refno = '#form.currefno#' and type = '#tran#'
                UNION ALL
                select frtype,frrefno,frdate,frtrancode,itemno,qty from #crmdts#.iclink where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            <cfcatch>
			<cfquery datasource='#dts#' name='getitem'>
				select frtype,frrefno,frdate,frtrancode,itemno,qty from iclink where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			</cfcatch>
            </cftry>
            
			<cfif getitem.recordcount gt 0>
				<cfloop query='getitem'>
						<cfset itemqty = getitem.qty>
					
                    <cftry>
                    <cfquery datasource="#dts#" name="getship">
						select shipped from ictran where refno = '#frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
                        UNION ALL
                        select shipped from #crmdts#.ictran where refno = '#frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
					</cfquery>
                    <cfcatch>
					<cfquery datasource="#dts#" name="getship">
						select shipped from ictran where refno = '#frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
					</cfquery>
                    </cfcatch>
                    </cftry>

					<cfif getship.recordcount gt 0>

						<cfif tran eq 'PO' or tran eq 'SAM' or tran eq 'RQ'>
							<cfset newshipped = getship.shipped>
						<cfelse>
							<cfset newshipped = getship.shipped - itemqty>
						</cfif>

						<cfquery datasource='#dts#' name='recoverictran'>
							update ictran set <cfif tran neq 'SAM'>toinv = '', exported = '', exported1 = '0000-00-00'<cfelse>exported2 = '', exported3 = '0000-00-00'</cfif>, shipped = '#newshipped#' where refno = '#getitem.frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
						</cfquery>
                        
                        <cftry>
                        <cfquery datasource='#crmdts#' name='recoverictran'>
							update ictran set <cfif tran neq 'SAM'>toinv = '', exported = '', exported1 = '0000-00-00'<cfelse>exported2 = '', exported3 = '0000-00-00'</cfif>, shipped = '#newshipped#' where refno = '#getitem.frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
						</cfquery>
                        <cfcatch>
                        </cfcatch>
                        </cftry>
                        
                        <cfif tran eq 'PO'>
                        <cfquery datasource='#dts#' name='recoverictran'>
							update ictranmat set <cfif tran neq 'SAM'>toinv = '', exported = '', exported1 = '0000-00-00'<cfelse>exported2 = '', exported3 = '0000-00-00'</cfif>, shipped = '#newshipped#' where refno = '#getitem.frrefno#' and type = '#frtype#' and itemno = '#itemno#' and trancode = '#frtrancode#'
						</cfquery>
                        </cfif>
						
						<!--- Add On 071008, For Graded Item --->
						<cfquery name="recoverigrade" datasource="#dts#">
							update igrade set exported = '',generated='' 
							where refno = '#getitem.frrefno#' and type = '#frtype#' 
							and itemno = '#itemno#' and trancode = '#frtrancode#'
						</cfquery>
					</cfif>
					
					<cfif frtype eq "QUO" or frtype eq "SO" and (tran eq "INV" or tran eq "DO" or tran eq "SO" or tran eq "CS")>
						<cfquery datasource='#dts#' name='recoverartran'>
							update artran 
							set toinv = '', generated='', order_cl = ''
							where refno = '#getitem.frrefno#' and type = '#frtype#'
						</cfquery>
                        
                        <cftry>
                        <cfquery datasource='#crmdts#' name='recoverartran'>
							update artran 
							set toinv = '', generated='', order_cl = ''
							where refno = '#getitem.frrefno#' and type = '#frtype#'
						</cfquery>
                        <cfcatch>
                        </cfcatch>
                        </cftry>
                        
					<cfelse>
						<cfquery datasource='#dts#' name='recoverartran'>
							update artran set <cfif tran neq 'SAM'>toinv = '', order_cl = '', exported = '', exported1 = '0000-00-00'<cfelse>exported2 = '', exported3 = '0000-00-00'</cfif> where refno = '#getitem.frrefno#' and type = '#frtype#'
						</cfquery>
                        
                        <cftry>
                        <cfquery datasource='#crmdts#' name='recoverartran'>
							update artran set <cfif tran neq 'SAM'>toinv = '', order_cl = '', exported = '', exported1 = '0000-00-00'<cfelse>exported2 = '', exported3 = '0000-00-00'</cfif> where refno = '#getitem.frrefno#' and type = '#frtype#'
						</cfquery>
                        <cfcatch></cfcatch></cftry>
                        
					</cfif>
				 </cfloop>
			</cfif>
            
            <cftry>
            <cfquery datasource='#replace(dts,"_i","_c","all")#' name='deliclinkcrm'>
				delete from iclink where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            <cfcatch>
            </cfcatch>
            </cftry>

			<cfquery datasource='#dts#' name='deliclink'>
				delete from iclink where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            
            <!---
            <cfquery datasource='#dts#' name='deliclink'>
				delete from ictran where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>--->
            
        <!--- <cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "winbells_i" or lcase(HcomID) eq "iel_i"> --->
		<cftry>
			<cfquery datasource='#dts#' name='deleteartran_remark'>
				Delete from artran_remark where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
		<cfcatch type="any">
		</cfcatch>
		</cftry>	
		<!--- </cfif> --->
        
        <cfif lcase(hcomid) eq "fdipx_i">
        <cfif tran eq "QUO">
        <cfquery datasource='#dts#' name='deletejobordertoquo'>
				Delete from joborder_update_to_quotation where quotation_refno = '#form.currefno#'
			</cfquery>
            <cfelseif tran eq "DO">
            <cfquery datasource='#dts#' name='deletejobordertodo'>
				Delete from joborder_update_to_delivery_order where DELIVERY_ORDER_REFNO = '#form.currefno#'
			</cfquery>
            <cfelseif tran eq "INV">
            <cfquery datasource='#dts#' name='deletejobordertoinv'>
				Delete from joborder_update_to_invoice where INVOICE_REFNO = '#form.currefno#'
			</cfquery>
            <cfelseif tran eq "CS">
            <cfquery datasource='#dts#' name='deletejobordertocs'>
				Delete from joborder_update_to_cs where CS_REFNO = '#form.currefno#'
			</cfquery>
        </cfif>
        </cfif>
        
        
        <!--- Add On 061008, For View Audit Trail --->
		<cfquery datasource="#dts#" name="getartran">
			select * from artran
			where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
        

		<cfquery datasource="#dts#" name="insert">
			insert into artranat 
			(TYPE,REFNO,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,
			<cfswitch expression="#tran#">
				<cfcase value="RC,CN,OAI" delimiters=",">
					CREDITAMT
				</cfcase>
				<cfdefaultcase>
					DEBITAMT
				</cfdefaultcase>
			</cfswitch>,
			TRDATETIME,USERID,REMARK,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON)
			values
			('#tran#','#form.currefno#','#getartran.custno#','#getartran.fperiod#',#getartran.wos_date#,'#getartran.desp#','#getartran.despa#',
			<cfswitch expression="#tran#">
				<cfcase value="RC,CN,OAI" delimiters=",">
					'#getartran.CREDITAMT#'
				</cfcase>
				<cfdefaultcase>
				'#getartran.DEBITAMT#'
				</cfdefaultcase>
			</cfswitch>,
            <cftry>
			#createdatetime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))#<cfcatch>now()</cfcatch></cftry>,
			'#getartran.userid#','#deleteStatus#','#getartran.created_by#','#Huserid#',
			<cfif getartran.created_on neq "">#createdatetime(year(getartran.created_on),month(getartran.created_on),day(getartran.created_on),hour(getartran.created_on),minute(getartran.created_on),second(getartran.created_on))#<cfelse>'0000-00-00'</cfif>,
			#now()#)
		</cfquery>
        
        <!--- Add On 061008, For View Audit Trail --->
		<cfif left(dts,4) eq "beps">
        <cfif isdefined('form.remark11')>
        <cfif form.remark11 neq "">
            <cfquery name="updateremark30" datasource="#dts#">
            UPDATE artran SET 
            rem30 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark11#"> 
            WHERE 
            refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#"> 
            and type = "INV"
            </cfquery>
		</cfif>
		</cfif>
        <cfif left(form.currefno,1) eq "B" and tran eq "INV">
        <cfquery name="getDONO" datasource="#dts#">
        SELECT dono FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#"> and type = "INV"
        </cfquery>
        
        <cfif trim(getDONO.dono) neq "">
		<cfquery name="decombine" datasource="#dts#">
        UPDATE assignmentslip SET combine = "N" 
        WHERE left(refno,1) = "S"
        and refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDONO.dono#" list="yes" separator=",">)
        </cfquery>
        </cfif>
		</cfif>
		</cfif>
        
            
 		<cfif getgsetup.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         <cfquery name="getdeletedlist" datasource="#dts#">
         	SELECT itemno FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#"> and type = '#tran#' GROUP BY ITEMNO
         </cfquery>
		 </cfif>
        </cfif>
			
         <cfif getgsetup.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         	<cfloop query="getdeletedlist">
		 	<cfquery name="insertdelete" datasource="#dts#">
            INSERT INTO locationitempro (itemno) 
            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeletedlist.itemno#">)
            </cfquery>
            </cfloop>
		 </cfif>
        </cfif>
            
		</cfif>
		
        
		<cfif keepDeleted eq "1">
			<cfquery datasource='#dts#' name='voidartran'>
				Update artran 
				set void='Y'
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
		<cfelse>
			<cfquery datasource='#dts#' name='deleteartran'>
				Delete from artran where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
		</cfif>
        
        <cfif getgsetup.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         <cfquery name="getdeletedlist" datasource="#dts#">
         	SELECT itemno FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#"> and type = '#tran#' GROUP BY ITEMNO
         </cfquery>
		 </cfif>
        </cfif>

		<cfif keepDeleted eq "1">
			<cfquery datasource='#dts#' name='updateictran'>
				Update ictran 
				set void='Y'
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
	
			<cfquery datasource='#dts#' name='updateserial'>
				Update iserial 
				set void='Y'
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            
            <cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "supporttest_i">
            <cfquery datasource='#dts#' name='deleteserial2'>
				update iserial set generated='' where generated = '#form.currefno#'
			</cfquery>
            </cfif>
		<cfelse>
			<cfquery datasource='#dts#' name='deleteictran'>
				Delete from ictran where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
	
			<cfquery datasource='#dts#' name='deleteserial'>
				Delete from iserial where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            <cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "supporttest_i">
            <cfquery datasource='#dts#' name='deleteserial2'>
				update iserial set generated='' where generated = '#form.currefno#'
			</cfquery>
            </cfif>
		</cfif>
        <cfif getgsetup.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         	<cfloop query="getdeletedlist">
		 	<cfquery name="insertdelete" datasource="#dts#">
            INSERT INTO locationitempro (itemno) 
            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeletedlist.itemno#">)
            </cfquery>
            </cfloop>
		 </cfif>
        </cfif>

		<!--- Begin: Add on 040908 for Graded Item --->
		<cfquery name="getigrade" datasource="#dts#">
			select * from igrade where refno = "#form.currefno#" and type = '#tran#'
		</cfquery>
		
		<cfif getigrade.recordcount neq 0>
			<cfset firstcount = 11>
			<cfset maxcounter = 160>
			<cfset totalrecord = (maxcounter - firstcount + 1)>
			
			<cfloop query="getigrade">
				<cfif getigrade.type neq "SO" and getigrade.type neq "PO" and getigrade.type neq "QUO" and getigrade.type neq "SAM" and getigrade.type neq "RQ">
					<cfloop from="#firstcount#" to="#maxcounter#" index="i">
						<cfif i eq firstcount>
							<cfset grdvaluelist = Evaluate("getigrade.GRD#i#")>
							<cfset bgrdlist = "bgrd"&i>
						<cfelse>
							<cfset grdvaluelist = grdvaluelist&","&Evaluate("getigrade.GRD#i#")>
							<cfset bgrdlist = bgrdlist&",bgrd"&i>
						</cfif>	
					</cfloop>
	
					<cfset myArray = ListToArray(bgrdlist,",")>
					<cfset myArray2 = ListToArray(grdvaluelist,",")>
	
					<cfquery name="updateitemgrd" datasource="#dts#">
						update itemgrd
						set
						<cfloop from="1" to="#totalrecord#" index="i">
							<cfif i neq totalrecord>
								#myArray[i]# = #myArray[i]#<cfif getigrade.type eq "OAI" or getigrade.type eq "RC" or getigrade.type eq "CN">-<cfelse>+</cfif>#myArray2[i]#,
							<cfelse>
								#myArray[i]# = #myArray[i]#<cfif getigrade.type eq "OAI" or getigrade.type eq "RC" or getigrade.type eq "CN">-<cfelse>+</cfif>#myArray2[i]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#"> 
					</cfquery>
	
		
					<cfquery name="updatelogrdob" datasource="#dts#">
						update logrdob
						set
						<cfloop from="1" to="#totalrecord#" index="i">
							<cfif i neq totalrecord>
								#myArray[i]# = #myArray[i]#<cfif getigrade.type eq "OAI" or getigrade.type eq "RC" or getigrade.type eq "CN">-<cfelse>+</cfif>#myArray2[i]#,
							<cfelse>
								#myArray[i]# = #myArray[i]#<cfif getigrade.type eq "OAI" or getigrade.type eq "RC" or getigrade.type eq "CN">-<cfelse>+</cfif>#myArray2[i]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">
					</cfquery>
				</cfif>
			</cfloop>
	
			<cfif keepDeleted eq "1">
				<cfquery name="updateigrade" datasource="#dts#">
					Update igrade
					set void='Y'
					where type= '#tran#' and refno="#form.currefno#"
				</cfquery>
			<cfelse>
				<cfquery name="deleteigrade" datasource="#dts#">
					delete from igrade
					where type= '#tran#' and refno="#form.currefno#"
				</cfquery>
			</cfif>
		</cfif>
		<!--- End 040908 for Graded Item --->
		
		<form name='done' action='transaction.cfm' method='post'>
			<cfoutput>
				<input type='hidden' value='#tran#' name='tran'>
				<input name='status' value='#status#' type='hidden'>
			</cfoutput>
		</form>

		<script>done.submit();</script>
		<cfabort>

	<cfelseif form.type eq 'Edit'>
		<cfset status = 'Invoice Edited Successfully'>
		<cfset mode = "Edit">
		<!--- Calculate the period --->

		<cfset lastaccyear = dateformat(getgsetup.lastaccyear, 'dd/mm/yyyy')>
		<cfset period=getgsetup.period>
		<cfset currentdate = dateformat(form.invoicedate,'dd/mm/yyyy')>

		<cfset tmpYear = year(currentdate)>
		<cfset clsyear = year(lastaccyear)>

		<cfset tmpmonth = month(currentdate)>
		<cfset clsmonth = month(lastaccyear)>

		<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

		<cfif intperiod gt 18 or intperiod lte 0>
			<cfset readperiod = 99>
		<cfelse>
			<cfset readperiod = numberformat(intperiod,"00")>
		</cfif>
		<!--- To add more fields to add in!! --->
		<cfquery datasource='#dts#' name='getar'>
			select * from artran where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
		
		<!--- ADD ON 090608, TO DEDUCT FROM THE PREVIOUS QIN/QOUT AND ADD INTO THE CURRENT QIN/QOUT --->
		<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "RQ">
			<cfquery name="geticitem" datasource="#dts#">
				select * from ictran
				where refno = '#form.currefno#' and type = '#tran#'
				and (void = '' or void is null)
				and toinv= ''
				<cfif tran eq "INV">
					and dono = ''
				</cfif>
			</cfquery>
			<cfif geticitem.recordcount neq 0>
            
			
            
				<cfif lcase(HUserID) neq "kellysteel2" and readperiod neq getar.fperiod>
     
					<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">
						<cfset qname_old='QIN'&(getar.fperiod+10)>
						<cfset qname_new='QIN'&(readperiod+10)>
					<cfelse>
						<cfset qname_old='QOUT'&(val(getar.fperiod)+10)>
						<cfset qname_new='QOUT'&(val(readperiod)+10)>
					</cfif>
					<cfloop query="geticitem">
						<cfquery name="UpdateIcitem" datasource="#dts#">
							update icitem set 
							#qname_old#=(#qname_old#-#geticitem.qty#),
							#qname_new#=(#qname_new#+#geticitem.qty#)
							where itemno='#geticitem.itemno#'
						</cfquery>
					</cfloop>
				</cfif>
			</cfif>
		</cfif>
		<!--- ADD ON 090608, TO DEDUCT FROM THE PREVIOUS QIN/QOUT AND ADD INTO THE CURRENT QIN/QOUT --->
		
		<cfset xinvgross = val(getar.gross_bil) * currrate>
		<cfset xdiscount1 = val(getar.disc1_bil) * currrate>
		<cfset xdiscount2 = val(getar.disc2_bil)* currrate>
		<cfset xdiscount3 = val(getar.disc3_bil) * currrate>
		<cfset xdiscount = val(getar.disc_bil) * currrate>
		<cfset xtax = val(getar.tax_bil) * currrate>
		<cfset xnet = val(getar.net_bil) * currrate>
		<cfset xgrand = val(getar.grand_bil) * currrate>
		<cfset xgrand = numberformat(xgrand,".__")>
        <!--- ADD ON 27-07-2009 --->
        <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
			<cfset xtaxnbt= val(getar.taxnbt_bil) * currrate>
		</cfif>
		
		<!--- ADD ON 17-08-2009 --->
		<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
			<cfif form.remark10 neq "" and isdate(form.remark10) eq "Yes" and form.remark11 eq "">
				<cfset date1=createDate(ListGetAt(form.remark10,3,"/"),ListGetAt(form.remark10,2,"/"),ListGetAt(form.remark10,1,"/"))>
				<cfset form.remark11=dateformat(DateAdd("d", 364, date1),"dd/mm/yyyy")>
			</cfif>
		</cfif>
		
		<!--- ADD ON 01-10-2009 --->
		<cfif lcase(HcomID) eq "ovas_i" and (tran eq "CS" or tran eq "SAM")>
			<cfif form.driver neq "">
				<cfquery name="getdriver" datasource="#dts#">
	            	select name,name2,add1,add2,add3,'' as add4,attn,phone,phonea as hphone,fax 
					from driver
	                where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driver#">
	            </cfquery>
				<cfset form.remark0="">
	            <cfset form.frem0=getdriver.name>
			  	<cfset form.frem1=getdriver.name2>
			  	<cfset form.frem2=getdriver.add1>
			  	<cfset form.frem3=getdriver.add2>
			  	<cfset form.frem4=getdriver.add3>
			  	<cfset form.frem5=getdriver.add4>
			  	<cfset form.remark13="">
			  	<cfset form.remark2=getdriver.attn>
			  	<cfset form.remark4=getdriver.phone>
			  	<cfset form.frem6=getdriver.fax>
			  	<cfset form.phonea=getdriver.hphone>
			</cfif>
		</cfif>

		<!--- <cfset invdate=createDate(ListGetAt(form.invoicedate,3,"/"),ListGetAt(form.invoicedate,2,"/"),ListGetAt(form.invoicedate,1,"/"))>
		<cfset nowtrdatetime = CreateDateTime(year(invdate),month(invdate),day(invdate),hour(now()),minute(now()),second(now()))> --->
		<cfif lcase(hcomid) eq "taftc_i">
			<cfif getar.source neq form.source>
                	<cfquery name="getcoursedetail" datasource="#dts#">
                    SELECT camt,bydeposit,cprice from #target_project# where source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.source#">
                    </cfquery> 
                    <cfif getcoursedetail.bydeposit eq "1">
                    <cfset pricenew = val(getcoursedetail.camt) / 2>
                    <cfset cpricenew = val(getcoursedetail.cprice) / 2>
                    <cfelse>
                    <cfset pricenew = val(getcoursedetail.camt)>
                    <cfset cpricenew = val(getcoursedetail.cprice)>
                    </cfif>
                    <cfquery name="updatenewprice" datasource="#dts#">
                    Update ictran SET
                    price = '#pricenew#',
                    price_bil = '#pricenew#',
                    amt = '#pricenew#',
                    amt_bil = '#pricenew#',
                    source = '#form.source#',
                    job = '#form.job#'
                    where refno = '#form.currefno#' and type = '#tran#' and brem1 <> "no"
                    </cfquery>
                    <cfquery name="updatenewprice" datasource="#dts#">
                    Update ictran SET
                    price = '#cpricenew#',
                    price_bil = '#cpricenew#',
                    amt = '#cpricenew#',
                    amt_bil = '#cpricenew#',
                    source = '#form.source#',
                    job = '#form.job#'
                    where refno = '#form.currefno#' and type = '#tran#' and brem1 = "no"
                    </cfquery>
                    
                    
		</cfif>
        
		</cfif>
        
		<cfquery datasource='#dts#' name='updateartran'>
			Update artran set refno2 = '#refno2#', wos_date = #ndatecreate#, fperiod = '#numberformat(readperiod,"00")#',
			currcode = '#listfirst(form.refno3)#',currrate = '#currrate#',custno = '#form.custno#',desp = '#desp#',despa = '#despa#',
			name = '#form.name#', term = '#form.terms#', source = '#form.source#',job = '#form.job#',
			agenno = '#form.agenno#', invgross = '#xinvgross#', discount1 = '#xdiscount1#',
			discount2 = '#xdiscount2#',discount = '#xdiscount#',tax = '#xtax#', net = '#xnet#', grand='#xgrand#',
			pono = '#form.pono#',dono = '#form.dono#',sono = '#form.sono#',quono = '#form.quono#', rem0 = '#form.remark0#', rem1 = '#form.remark1#',
			rem2 = '#form.remark2#', rem3 = '#form.remark3#', rem4 = '#form.remark4#', rem5 = '#form.remark5#',
			rem6 = '#form.remark6#', 
			<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "dgalleria_i">
            <cfif form.remark7 neq "" and form.remark7 neq "0000-00-00" and form.remark7 neq "00-00-0000">
                    <cfset remark7 = createDate(ListGetAt(form.remark7,3,"/"),ListGetAt(form.remark7,2,"/"),ListGetAt(form.remark7,1,"/"))>
                    <cfset remark7=dateformat(remark7,'YYYY-MM-DD')>
			<cfelse>
					<cfset remark7='0000-00-00'>
			</cfif>
            rem7 = '#remark7#',
            <cfelse>
            rem7 = '#form.remark7#',
            </cfif>
            
            <cfif lcase(hcomid) eq "shell_i">
            <cfif form.remark8 neq "" and form.remark8 neq "0000-00-00" and form.remark8 neq "00-00-0000">
                    <cfset remark8 = createDate(ListGetAt(form.remark8,3,"/"),ListGetAt(form.remark8,2,"/"),ListGetAt(form.remark8,1,"/"))>
                    <cfset remark8=dateformat(remark8,'YYYY-MM-DD')>
			<cfelse>
					<cfset remark8='0000-00-00'>
			</cfif>
            rem8 = '#remark8#',
            <cfelse>
             rem8 = '#form.remark8#',
            </cfif>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<cfif form.remark9 neq "">
                    <cfinvoke component="cfc.Date" method="getDbDate" inputDate="#form.remark9#" returnvariable="remark9"/>
				<cfelse>
					<cfset form.remark9='0000-00-00'>
				</cfif>
				<cfif form.remark11 neq "">
                    <cfinvoke component="cfc.Date" method="getDbDate" inputDate="#form.remark11#" returnvariable="remark11"/>
				<cfelse>
					<cfset form.remark11='0000-00-00'>
				</cfif>
				rem9='#remark9#', rem10='#form.remark10#',rem11='#remark11#',permitno='#permitno#', 
			<cfelseif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO">
				<cfif form.remark9 neq "">
					<cfset remark9 = createDate(ListGetAt(form.remark9,3,"/"),ListGetAt(form.remark9,2,"/"),ListGetAt(form.remark9,1,"/"))>
					rem9 = #remark9#
				<cfelse>
					rem9 = '#form.remark9#'
				</cfif>
				,rem10 = '#form.remark10#', rem11 = '#form.remark11#',permitno = '#form.permitno#',
			<cfelse>
				rem9 = '#form.remark9#',rem10 = '#form.remark10#', rem11 = '#form.remark11#',permitno = '#form.permitno#',
			</cfif>
			rem12 = '#form.remark12#',  rem13 = '#form.remark13#',
			rem14 = '#remark14#',frem0 = '#form.frem0#',frem1 = '#form.frem1#',frem2 = '#form.frem2#',frem3 = '#form.frem3#',
			frem4 = '#form.frem4#',frem5 = '#form.frem5#',frem6 = '#form.frem6#',frem7 = '#form.frem7#',
			frem8 = '#form.frem8#',frem9 = '#form.frem9#',comm0='#form.comm0#',comm1='#form.comm1#',comm2='#form.comm2#',
			comm3='#form.comm3#',comm4='#form.comm4#',<!---d_phone2='#form.d_phone2#',--->	van = '#form.driver#',phonea='#form.phonea#',e_mail='#form.e_mail#',postalcode='#form.postalcode#',d_postalcode='#form.d_postalcode#',
			<!--- REMARK ON 06-08-2009 --->
			<!--- <cfif lcase(husergrpid) neq "super">userid='#Huserid#',</cfif> --->
			<cfif lcase(husergrpid) eq "super" or lcase(huserid) contains "ultra"><cfelse><cfif getgsetup.tranuserid eq "Y">userid='#Huserid#',username='#getusername.username#',</cfif></cfif>
			updated_by = '#Huserid#',updated_on = #now()#
            <cfif getGsetup.collectaddress eq 'Y'>
				,rem15='#form.remark15#',rem16='#form.remark16#',rem17='#form.remark17#',rem18='#form.remark18#',rem19='#form.remark19#'
                ,rem20='#form.remark20#',rem21='#form.remark21#',rem22='#form.remark22#',rem23='#form.remark23#',rem24='#form.remark24#'
                ,rem25='#form.remark25#'
			</cfif>
            <cfif lcase(hcomid) eq 'ugateway_i'>
            	,via = '#form.via#'
			</cfif>
            <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and tran eq "INV">
            	,checkno = '#form.checkno#'
			</cfif>
            <!--- ADD ON 27-07-2009 --->
            <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
				,taxnbt='#val(xtaxnbt)#'
			</cfif>
            <cfif getgsetup.transactiondate eq 'Y'>
            <cfif nDateCreatetran eq ''>
            ,tran_date='0000-00-00'
            <cfelse>
            ,tran_date='#dateformat(nDateCreatetran,'yyyy-mm-dd')#'
            </cfif>
            </cfif>
            <cfif lcase(hcomid) eq "net_i" and tran eq "QUO">
            ,printstatus=''
            </cfif>
            
			where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
		
       
        
        <cfif getgsetup.addonremark eq 'Y'>
        <cfinclude template="tran2updateaddonremark.cfm">
        </cfif>
         <cfif lcase(hcomid) eq "atc2005_i">
        <cfquery name="updateatcrem46" datasource="#dts#">
            UPDATE artran SET 
            rem46 = "Amend"
            where refno = '#form.currefno#' and type = '#tran#' and (rem45 ="Printed" or rem45="1")
        </cfquery>
        </cfif>
        
        <cfif getgsetup.multiagent eq 'Y'>
        <cfinclude template="multiagentupdate.cfm">
        </cfif>
        
		 <cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakbill_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set remark1 = '#form.comment_selected#',
					remark2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					remark3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.xremark3#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2,REMARK3)
					values
					('#tran#','#form.currefno#','#form.comment_selected#',
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.xremark3#">)
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set remark1 = '#form.xremark1#',
					remark2 = '#form.xremark2#'
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2)
					values
					('#tran#','#form.currefno#','#form.xremark1#','#form.xremark2#')
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "winbells_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set REMARK1 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					REMARK2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					REMARK3 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					REMARK4 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					REMARK5 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					REMARK6 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					REMARK7 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
					REMARK8 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark8#">,
					REMARK9 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark9#">,
					REMARK10 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark10#">,
					REMARK11 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark11#">,
					REMARK12 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark12#">,
					REMARK13 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark13#">,
					REMARK14 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark14#">,
					REMARK15 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark15#">,
					REMARK16 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark16#">,
					REMARK17 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark17#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7,REMARK8,REMARK9,REMARK10,
					REMARK11,REMARK12,REMARK13,REMARK14,REMARK15,REMARK16,REMARK17)
					values
					('#tran#','#form.currefno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark8#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark9#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark10#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark11#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark12#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark13#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark14#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark15#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark16#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark17#">)
				</cfquery>
			</cfif>
        <cfelseif lcase(HcomID) eq "iel_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set REMARK1 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					REMARK2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					REMARK3 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					REMARK4 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4)
					values
					('#tran#','#form.currefno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">)
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set remark1 = '#form.xremark1#'
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1)
					values
					('#tran#','#form.currefno#','#form.xremark1#')
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "chemline_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set REMARK1 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					REMARK2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					REMARK3 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					REMARK4 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					REMARK5 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					REMARK6 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					REMARK7 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
					REMARK8 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.comment_selected#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7,REMARK8)
					values
					('#tran#','#form.currefno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.comment_selected#">)
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set remark1 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					remark2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2)
					values
					('#tran#','#form.currefno#',
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">)
				</cfquery>
			</cfif>
		<cfelseif lcase(HcomID) eq "probulk_i">
			<cfquery datasource='#dts#' name='getcomment'>
				select * from artran_remark
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfif getcomment.recordcount neq 0>
				<cfquery datasource='#dts#' name='updatecomment'>
					Update artran_remark
					set remark1 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					remark2 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					remark3 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					remark4 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					remark5 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					remark6 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					remark7 = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#val(form.xremark7)#">
					where refno = '#form.currefno#' and type = '#tran#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name='insertcomment'>
					Insert into artran_remark
					(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7)
					values
					('#tran#','#form.currefno#',
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#val(form.xremark7)#">)
				</cfquery>
			</cfif>
		</cfif>
		
		<!--- REMARK ON 24-03-2009 --->
		<cfquery datasource='#dts#' name='updateictran'>
			update ictran 
			set wos_date = #ndatecreate#, fperiod = '#numberformat(readperiod,"00")#',
			currrate = '#currrate#', custno = '#form.custno#',name = '#form.name#',
			agenno = '#form.agenno#' 
			<cfif getgsetup.projectbybill eq "1">
				,source = '#form.source#', job = '#form.job#' 
                <cfelseif getgsetup.jobbyitem eq "Y">
                ,source = '#form.source#'
			</cfif>
			<!--- REMARK ON 06-08-2009 --->
			<cfif lcase(husergrpid) eq "super" or lcase(huserid) contains "ultra"><cfelse><cfif getgsetup.tranuserid eq "Y">,userid='#Huserid#'</cfif></cfif>
			<cfif (checkcustom.customcompany eq "Y") and (tran eq "RC" or tran eq "OAI" or tran eq "CN")>,BREM5='#form.remark5#',BREM7='#form.remark6#'</cfif>
			where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
		
		<cfif (checkcustom.customcompany eq "Y") and (tran eq "RC" or tran eq "OAI" or tran eq "CN")>
			<cfquery name="updateobbatch" datasource="#dts#">
				update obbatch
				set permit_no='#form.remark5#',
				permit_no2='#form.remark6#'
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
			
			<cfquery name="updatelobthob" datasource="#dts#">
				update lobthob
				set permit_no='#form.remark5#',
				permit_no2='#form.remark6#'
				where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
		</cfif>
		
		<!--- Add on 040908, For Graded Item --->
		<cfquery name="updateigrade" datasource="#dts#">
			update igrade
			set wos_date = #ndatecreate#,
			fperiod = '#numberformat(readperiod,"00")#',
			custno = '#form.custno#'
			where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
		<!--- End 040908 --->
		
		<cfif isdefined("form.itemrate")>
			<cfquery name="getic" datasource="#dts#">
				select * from ictran where refno = '#form.currefno#' and type = '#tran#' order by itemcount
			</cfquery>

			<cfloop query="getic">
				<cfset xprice = price_bil * currrate>
                <cfif getic.factor1 neq 0>
                <cfset xprice = (xprice * val(getic.factor2)) / val(getic.factor1)>
                </cfif>
				<cfset xamt1 = amt1_bil * currrate>
				<cfset xdisamt = disamt_bil * currrate>
				<cfset xtaxamt = taxamt_bil * currrate>
				<cfset xamt = amt_bil * currrate>
				<cfset xamt = numberformat(xamt,".__")>

				<cfquery datasource='#dts#' name='updateictran'>
					update ictran set currrate = '#currrate#', price = '#xprice#',
					amt1 = '#xamt1#', disamt = '#xdisamt#', taxamt = '#xtaxamt#',
					amt = '#xamt#'
					where refno = '#form.currefno#' and type = '#tran#' and itemcount = '#itemcount#' and itemno='#itemno#'
				</cfquery>
			</cfloop>
		</cfif>
		<cfset nexttranno = form.currefno>
		
	<cfelseif form.type eq 'Create'>
		<cfset mode = "Create">

			<cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#tran#'
				and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery>
            <!---cust refno --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem2>
			</cfif>
            
            <cfif getgsetup.prefixbycustso eq 'Y' and tran eq 'SO' and getcustprefixno.arrem3 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem3 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem3>
			</cfif>
            
            <cfif getgsetup.prefixbycustinv eq 'Y' and tran eq 'INV' and getcustprefixno.arrem4 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem4 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem4>
			</cfif>
            <!--- --->

		<cfif getGeneralInfo.arun eq '1'>
			<cftry>
				<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#getGeneralInfo.tranno#" returnvariable="nexttranno"/>
			<cfcatch>
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
				<cfset nexttranno = newnextNum>	
			</cfcatch>
			</cftry>
            
        <cfquery name="checkexistrefnonew" datasource="#dts#">
        select refno from artran where 
        type='#tran#' 
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">
        </cfquery>
        
		<cfif checkexistrefnonew.recordcount neq 0>
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefnonew.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="nexttranno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="nexttranno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = '#tran#'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = nexttranno>
		</cfif>
        </cfloop>
        </cfif>

			<!--- ADD ON 19-12-2008 --->
			<cfif (lcase(HcomID) eq "mhsl_i" and tran eq "INV") or (lcase(HcomID) eq "ideal_i")>
				<cfset actual_nexttranno = nexttranno>
				<cfif getGeneralInfo.refnocode2 neq "">
					<cfset nexttranno = actual_nexttranno&"/"&getGeneralInfo.refnocode2>
				</cfif>		
			<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
				<cfset actual_nexttranno = nexttranno>
				<cfif getGeneralInfo.refnocode2 neq "">
					<cfset nexttranno = actual_nexttranno&"-"&getGeneralInfo.refnocode2>
				</cfif>	
            <cfelseif (lcase(HcomID) eq "3ree_i" or lcase(HcomID) eq "btind_i") and tran eq "INV">
				<cfset actual_nexttranno = nexttranno>
                <cfquery name="get3reeremark" datasource="#dts#">
                select arrem1 from #target_arcust# where custno='#form.custno#'
                </cfquery>
                <cfif trim(get3reeremark.arrem1) neq ''>
                <cfset nexttranno = actual_nexttranno&listgetat(form.invoicedate,2,'/')&right(listgetat(form.invoicedate,3,'/'),2)&get3reeremark.arrem1>
                <cfelse>
				<cfset nexttranno = actual_nexttranno&listgetat(form.invoicedate,2,'/')&right(listgetat(form.invoicedate,3,'/'),2)&right(form.custno,3)>
                </cfif>
            <cfelseif lcase(HcomID) eq "asaiki_i" or lcase(hcomid) eq "supporttest_i">
				<cfset actual_nexttranno = nexttranno>
				<cfif isdefined("form.invset")><cfif form.invset neq 4><cfset nexttranno = actual_nexttranno&listgetat(form.invoicedate,2,'/')&right(listgetat(form.invoicedate,3,'/'),2)><cfelse><cfset nexttranno = actual_nexttranno></cfif><cfelse><cfset nexttranno = actual_nexttranno&listgetat(form.invoicedate,2,'/')&right(listgetat(form.invoicedate,3,'/'),2)></cfif>
			<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
				<cfset nexttranno = newnextNum>	
            <cfelse>
        		<cfset actual_nexttranno = nexttranno>
               
                <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
                    <cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
                <cfelse>
                <cfif (getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "") or (getgsetup.prefixbycustso eq 'Y' and tran eq 'SO' and getcustprefixno.arrem3 neq "") or (getgsetup.prefixbycustinv eq 'Y' and tran eq 'INV' and getcustprefixno.arrem4 neq "")>
                <cftry>
                <cfset nexttranno = listgetat(form.custno,2,'/')&"-"&actual_nexttranno>
                <cfcatch>
                <cfset nexttranno = actual_nexttranno>
                </cfcatch>
                </cftry>
                <cfelse>
                    <cfset nexttranno = actual_nexttranno>
                </cfif>
                </cfif>
			</cfif>
			
            <cfquery name="getrefnolen" datasource="#dts#">
            SELECT refnoNACC,refnoACC,ddlitem from gsetup
            </cfquery>
			
			<cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO' or tran eq 'RQ'>
				<cfset limit = getrefnolen.refnoNACC>
			<cfelse>
				<cfset limit = getrefnolen.refnoACC>
			</cfif>
			<cfif len(nexttranno) gt limit><cfset nexttranno = '99999999'></cfif>
		<cfelse>
	  		<cfset nexttranno= form.nexttranno>
		</cfif>

		<cfquery name='checkexist' datasource='#dts#'>
			select refno from artran where refno='#nexttranno#' and type='#tran#'
		</cfquery>

		<cfif checkexist.recordcount gt 0>
			<h3>This transaction refence number has been used. Please use another number.</h3>
			<cfoutput><h2><a href='transaction1.cfm?ttype=create&tran=#tran#&nexttranno=&bcode=&dcode=&first=0'>Create New #tranname#</a></h2></cfoutput>
			<cfabort>
		</cfif>
		
		
			
			<!--- MODIFIED ON 19-12-2008 --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
             <!---cust refno --->
            <cfquery name="getcustrefno" datasource="#dts#">
			update #target_arcust# set arrem2=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif> where custno ='#form.custno#'
  			</cfquery>
              <cfelseif getgsetup.prefixbycustso eq 'Y' and tran eq 'SO' and getcustprefixno.arrem3 neq "">
            <cfquery name="getcustrefno" datasource="#dts#">
			update #target_arcust# set arrem3=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif> where custno ='#form.custno#'
  			</cfquery>
             <cfelseif getgsetup.prefixbycustinv eq 'Y' and tran eq 'INV' and getcustprefixno.arrem4 neq "">
            <cfquery name="getcustrefno" datasource="#dts#">
			update #target_arcust# set arrem4=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif> where custno ='#form.custno#'
  			</cfquery>
             <!--- --->
            <cfelse>
			<cfquery name="updategsetup" datasource="#dts#">
				update refnoset set 
				lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
				where type = '#tran#'
				and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery>
            

			</cfif>
        <cfif isdefined('form.invset2')>
        <cfif isdefined("form.invset")>
        <cfset invsettest = form.invset>
        <cfelse>
        <cfset invsettest = 1>
		</cfif>
        <cfif form.invset2 neq invsettest>
        <cfquery name="getrefno2" datasource="#dts#">
        SELECT lastusedno from refnoset where type = "#tran#" and counter = "#form.invset2#"
        </cfquery>
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getrefno2.lastusedno#" returnvariable="newrefno2" />
        <cfquery name="updategsetup" datasource="#dts#">
				update refnoset set 
				lastUsedNo= '#newrefno2#'
				where type = '#tran#'
				and counter =  '#form.invset2#'
			</cfquery>
        </cfif>
		</cfif>
		
		<!--- Format the date to MYSQL readable --->
		<cfset dd = dateformat(form.invoicedate, 'DD')>

		<cfif dd greater than '12'>
			<cfset nDateCreate = dateformat(form.invoicedate,"YYYYMMDD")>
			<cfset nDatecreate2 = dateformat(form.invoicedate,"YYYY-MM-DD")>
		<cfelse>
			<cfset nDateCreate = dateformat(form.invoicedate,"YYYYDDMM")>
			<cfset nDateCreate2 = dateformat(form.invoicedate,"YYYY-DD-MM")>
		</cfif>

		<cfset dd = dateformat(now(), 'DD')>

		<cfif dd greater than '12'>
			<cfset nDateNow = dateformat(now(),'YYYYMMDD')>
		<cfelse>
			<cfset nDateNow = dateformat(now(),'YYYYDDMM')>
		</cfif>
		<cfif isdefined("form.transactiondate")>
        <cfset ddtran = dateformat(form.transactiondate, 'DD')>

		<cfif ddtran greater than '12'>
			<cfset nDatecreatetran = dateformat(form.transactiondate,"YYYY-MM-DD")>
		<cfelse>
			<cfset nDateCreate2tran = dateformat(form.transactiondate,"YYYY-DD-MM")>
		</cfif>
        </cfif>
		<!--- End of date format --->
		<!--- Calculate the period --->
		

		<cfset lastaccyear = dateformat(getgsetup.lastaccyear, 'dd/mm/yyyy')>
		<cfset period = getgsetup.period>
		<cfset currentdate = dateformat(form.invoicedate,'dd/mm/yyyy')>
		<cfset tmpYear = year(currentdate)>
		<cfset clsyear = year(lastaccyear)>
		<cfset tmpmonth = month(currentdate)>
		<cfset clsmonth = month(lastaccyear)>
		<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

		<cfif intperiod gt 18 or intperiod lte 0>
			<cfset readperiod = 99>
		<cfelse>
			<cfset readperiod = numberformat(intperiod,"00")>
		</cfif>
        
        <cfif getGsetup.periodalfr neq "01">
            <cfloop from="1" to="#val(getGsetup.periodalfr)-1#" index="a">
                <cfif val(readperiod) eq val(a)>
                    <h3>Period Allowed from <cfoutput>#getGsetup.periodalfr# to 18.</cfoutput></h3>
                    <cfabort>
                </cfif>
            </cfloop>
        </cfif>

		<cfset nowdatetime = ndatecreate2 & " " & timeformat(now(),"HH:MM:SS")>
		<cfset form.taxincl = "">
        <cfif getgsetup.taxincluded eq 'Y'>
        <cfset form.taxincl = "T">
        </cfif>
        
        <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
        <cfquery name="gettaxinclcust" datasource="#dts#">
        SELECT taxincl_cust,arrem1 from #target_apvend# where custno = '#form.custno#'
        </cfquery>
        <cfelse>
        <cfquery name="gettaxinclcust" datasource="#dts#">
        SELECT taxincl_cust,arrem1 from #target_arcust# where custno = '#form.custno#'
        </cfquery>
		</cfif>
        
        <cfset form.taxincl = gettaxinclcust.taxincl_cust>

		<!--- ADD ON 17-08-2009 --->
		<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
			<cfif form.remark10 neq "" and isdate(form.remark10) eq "Yes" and form.remark11 eq "">
				<cfset date1=createDate(ListGetAt(form.remark10,3,"/"),ListGetAt(form.remark10,2,"/"),ListGetAt(form.remark10,1,"/"))>
				<cfset form.remark11=dateformat(DateAdd("d", 364, date1),"dd/mm/yyyy")>
			</cfif>
		</cfif>

        
		<!--- ADD ON 01-10-2009 --->
		<cfif lcase(HcomID) eq "ovas_i" and (tran eq "CS" or tran eq "SAM")>
			<cfif form.driver neq "">
				<cfquery name="getdriver" datasource="#dts#">
	            	select name,name2,add1,add2,add3,'' as add4,attn,phone,phonea as hphone,fax 
					from driver
	                where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.driver#">
	            </cfquery>
				<cfset form.remark0="">
	            <cfset form.frem0=getdriver.name>
			  	<cfset form.frem1=getdriver.name2>
			  	<cfset form.frem2=getdriver.add1>
			  	<cfset form.frem3=getdriver.add2>
			  	<cfset form.frem4=getdriver.add3>
			  	<cfset form.frem5=getdriver.add4>
			  	<cfset form.remark13="">
			  	<cfset form.remark2=getdriver.attn>
			  	<cfset form.remark4=getdriver.phone>
			  	<cfset form.frem6=getdriver.fax>
			  	<cfset form.phonea=getdriver.hphone>
			</cfif>
		</cfif>
		<!--- MODIFIED ON 26-10-2009 --->

		<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
			<cfset dnote=getgsetup.df_purchasetax>
		<cfelse>
			<cfset dnote=getgsetup.df_salestax>
		</cfif>
        <cftry>
            <cfquery datasource='#dts#' name='insertartran'>
                Insert into artran (type,refno,refno2,custno,desp,despa,fperiod,wos_date,agenno,currrate,
                term,source,job,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,permitno,rem12,
                rem13,rem14,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm1,comm2,comm3,comm4,d_phone2,d_email,phonea,E_mail,postalcode,d_postalcode,
                name,toinv,exported,van,trdatetime,userid,username,currcode,comm0,taxincl,created_by,created_on,updated_by,updated_on,note
                <cfif getgsetup.addonremark eq 'Y'>
                ,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,
                rem46,rem47,rem48,rem49
                </cfif>
                <cfif getgsetup.multiagent eq 'Y'>
                ,multiagent1,multiagent2,multiagent3,multiagent4,multiagent5,multiagent6,multiagent7,multiagent8
                </cfif>
                <cfif getGsetup.collectaddress eq 'Y'>
                    ,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
                    
                </cfif>
                <cfif lcase(hcomid) eq 'ugateway_i'>
            	,via
				</cfif>
                <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and tran eq "INV">
                ,checkno
				</cfif>
                <cfif getgsetup.transactiondate eq 'Y'>
                ,tran_date
                </cfif>
                <cfif (lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i") and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>
                ,rebateaftertax
                ,rebateper
                </cfif>
                )
    
                values('#tran#','#nexttranno#','#refno2#','#form.custno#','#desp#','#despa#','#numberformat(readperiod,"00")#',
                #nDateCreate#,'#form.agenno#','#currrate#','#form.terms#',<cfif getgsetup.soautocreaproj eq 'Y' and tran eq 'SO'>'#nexttranno#'<cfelse>'#form.source#'</cfif>,'#form.job#',
                '#form.pono#','#form.dono#','#form.sono#','#form.quono#','#form.remark0#','#form.remark1#', '#form.remark2#','#form.remark3#',
                '#form.remark4#','#form.remark5#','#form.remark6#', 
                <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "dgalleria_i">
            	<cfif form.remark7 neq "" and form.remark7 neq "0000-00-00" and form.remark7 neq "00-00-0000">
                <cfset remark7 = createDate(ListGetAt(form.remark7,3,"/"),ListGetAt(form.remark7,2,"/"),ListGetAt(form.remark7,1,"/"))>
                <cfset remark7=dateformat(remark7,'YYYY-MM-DD')>
				<cfelse>
					<cfset remark7='0000-00-00'>
				</cfif>
            	'#remark7#',
            	<cfelse>
           	 	'#form.remark7#',
           	 	</cfif>
                
                <cfif lcase(hcomid) eq "shell_i">
            	<cfif form.remark8 neq "" and form.remark8 neq "0000-00-00" and form.remark8 neq "00-00-0000">
                <cfset remark8 = createDate(ListGetAt(form.remark8,3,"/"),ListGetAt(form.remark8,2,"/"),ListGetAt(form.remark8,1,"/"))>
                <cfset remark8=dateformat(remark8,'YYYY-MM-DD')>
				<cfelse>
					<cfset remark8='0000-00-00'>
				</cfif>
            	'#remark8#',
            	<cfelse>
           	 	'#form.remark8#',
           	 	</cfif>
                
                <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
					<cfif form.remark9 neq "">
                    	<cfinvoke component="cfc.date" method="getDbDate" inputDate="#form.remark9#" returnvariable="remark9"/>
					<cfelse>
						<cfset form.remark9='0000-00-00'>
					</cfif>
					<cfif form.remark11 neq "">
                    	<cfinvoke component="cfc.date" method="getDbDate" inputDate="#form.remark11#" returnvariable="remark11"/>
					<cfelse>
						<cfset form.remark11='0000-00-00'>
					</cfif>
                    '#remark9#', '#form.remark10#','#remark11#', '#permitno#', 
                <cfelseif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO">
                    <cfif form.remark9 neq "">
                        <cfset remark9 = createDate(ListGetAt(form.remark9,3,"/"),ListGetAt(form.remark9,2,"/"),ListGetAt(form.remark9,1,"/"))>
                        #remark9#
                    <cfelse>
                        '#form.remark9#'
                    </cfif>
                    ,'#form.remark10#','#form.remark11#','#permitno#', 
                <cfelse>
                    '#form.remark9#', '#form.remark10#','#form.remark11#', '#permitno#', 
                </cfif>
                '#form.remark12#','#form.remark13#','#form.remark14#',
                '#form.frem0#','#form.frem1#','#form.frem2#','#form.frem3#','#form.frem4#','#form.frem5#',
                '#form.frem6#','#form.frem7#','#form.frem8#','#form.frem9#','#form.comm1#','#form.comm2#','#form.comm3#',
                '#form.comm4#', '#form.d_phone2#','#form.d_email#','#form.phonea#','#form.e_mail#','#form.postalcode#','#form.d_postalcode#',
				'#form.name#','','','#form.driver#','#nowDatetime#', '#HUserID#', '#getusername.username#','#listfirst(form.refno3)#','#form.comm0#',
                '#form.taxincl#','#HUserID#',#now()#,'#HUserID#',#now()#,'#dnote#'
                <cfif getgsetup.addonremark eq 'Y'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark30#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark31#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark32#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark33#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark34#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark35#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark36#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark37#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark38#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark39#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark40#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark41#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark42#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark43#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark44#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark45#">
                    ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark46#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark47#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark48#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remark49#">
                </cfif>
                <cfif getgsetup.multiagent eq 'Y'>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent1#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent2#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent3#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent4#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent5#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent6#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent7#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.multiagent8#">
				</cfif>
                <cfif getGsetup.collectaddress eq 'Y'>
                    ,'#form.remark15#','#form.remark16#','#form.remark17#','#form.remark18#','#form.remark19#'
                    ,'#form.remark20#','#form.remark21#','#form.remark22#','#form.remark23#','#form.remark24#'
                    ,'#form.remark25#'
                </cfif>
                <cfif lcase(hcomid) eq 'ugateway_i'>
            	 ,'#form.via#'
			</cfif>
            <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and tran eq "INV">
                ,'#form.checkno#'
				</cfif>
            <cfif getgsetup.transactiondate eq 'Y'>
                ,<cfif nDateCreatetran eq ''>'0000-00-00'<cfelse>'#nDatecreatetran#'</cfif>
                </cfif>
                <cfif (lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i") and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>
                ,'T'
                ,'#val(gettaxinclcust.arrem1)#'
                </cfif>
                )
            </cfquery>
            <cfif getgsetup.soautocreaproj eq 'Y' and tran eq "SO">
            <cfquery datasource='#dts#' name='insertnewproject'>
            insert into #target_project# (source,project,porj) values ('#nexttranno#','#nexttranno#','P')
            </cfquery>
			</cfif>
            
        <cfif isdefined('getgsetup.appDisSupCus')>
        <cfif getgsetup.appDisSupCus eq "Y" and tran neq "CN" or tran neq "DN">
        <cfif getgsetup.appDisSupCusitem neq "Y">
        <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
        <cfquery name="getdisccust" datasource="#dts#">
        SELECT dispec1,dispec2,dispec3 from #target_apvend# where custno = '#form.custno#'
        </cfquery>
        <cfelse>
        <cfquery name="getdisccust" datasource="#dts#">
        SELECT dispec1,dispec2,dispec3 from #target_arcust# where custno = '#form.custno#'
        </cfquery>
        </cfif>
        <cfquery name="updateartrandisc" datasource="#dts#">
        UPDATE artran SET
        disp1 = "#val(getdisccust.dispec1)#",
        disp2 = "#val(getdisccust.dispec2)#",
        disp3 = "#val(getdisccust.dispec3)#"
        WHERE
        type = '#tran#'
        and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#">
        and custno = "#form.custno#"
        </cfquery>
        </cfif>
		</cfif>
		</cfif>
         
        <cfcatch type="any">
        	<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput>
            <cfabort />
        </cfcatch>
        </cftry>
		
		<cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakbill_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2,REMARK3)
				values
				('#tran#','#nexttranno#','#form.comment_selected#',
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.xremark3#">)
			</cfquery>
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2)
				values
				('#tran#','#nexttranno#','#form.xremark1#','#form.xremark2#')
			</cfquery>
		<cfelseif lcase(HcomID) eq "winbells_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7,REMARK8,REMARK9,REMARK10,
				REMARK11,REMARK12,REMARK13,REMARK14,REMARK15,REMARK16,REMARK17)
				values
				('#tran#','#nexttranno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark8#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark9#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark10#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark11#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark12#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark13#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark14#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark15#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark16#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark17#">)
			</cfquery>
        <cfelseif lcase(HcomID) eq "iel_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4)
				values
				('#tran#','#nexttranno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">)
			</cfquery>
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1)
				values
				('#tran#','#nexttranno#','#form.xremark1#')
			</cfquery>
		<cfelseif lcase(HcomID) eq "chemline_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7,REMARK8)
				values
				('#tran#','#nexttranno#',<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark7#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.comment_selected#">)
			</cfquery>
		<cfelseif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2)
				values
				('#tran#','#nexttranno#',
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">)
			</cfquery>
		<cfelseif lcase(HcomID) eq "probulk_i">
			<cfquery datasource='#dts#' name='insertcomment'>
				Insert into artran_remark
				(TYPE,REFNO,REMARK1,REMARK2,REMARK3,REMARK4,REMARK5,REMARK6,REMARK7)
				values
				('#tran#','#nexttranno#',
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark1#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark2#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark3#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark4#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark5#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.xremark6#">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#val(form.xremark7)#">)
			</cfquery>
		</cfif>
	</cfif>
</cfif>



<!---end transaction process--->


<!--- --->
<cfloop list="RC,PR,DO,INV,CS,CN,DN,PO,RQ,QUO,SO,SAM" index="i">

<cfif tran eq i>
  	<cfset tran = i>
  	<cfset tranname = evaluate('getGsetup.l#i#')>
  	<cfset trancode = i&"no">
  	<cfset tranarun = i&"arun">
</cfif>
</cfloop>

<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
	<cfquery name='getcust' datasource='#dts#'>
		select name,arrem1 from #target_apvend# where custno = '#custno#'
	</cfquery>
	<cfset ptype = "Supplier">
<cfelse>
	<cfquery name='getcust' datasource='#dts#'>
		select name,arrem1 from #target_arcust# where custno = '#custno#'
	</cfquery>
	<cfset ptype = "Customer">
</cfif>



<cfset multilocation = "">
<cfif getgsetup.multilocation neq "">
	<cfif ListFindNoCase(getgsetup.multilocation, tran, ",") neq 0>
		<cfset multilocation = "Y">
	</cfif>
</cfif>

<!--- ADD ON 30-07-2009 --->
<cfset wpitemtax="">
<cfif getgsetup.wpitemtax eq "1">
	<cfif getgsetup.wpitemtax1 neq "">
    	<cfif ListFindNoCase(getgsetup.wpitemtax1, tran, ",") neq 0>
			<cfset wpitemtax = "Y">
        </cfif>
	<cfelse>
    	<cfset wpitemtax="Y">
	</cfif>
</cfif>

<cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
	<cfquery name='updateshellictran' datasource='#dts#'>
		update ictran set brem3=trancode where refno='#nexttranno#' and type='#tran#' and brem3=''
	</cfquery>
</cfif>

<!---getictran--->
<cfif multilocation neq "Y">
	<cfquery name='getictran' datasource='#dts#'>
		select * from ictran where refno='#nexttranno#' and type='#tran#' <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">order by length(brem3),brem3<cfelse>order by itemcount</cfif>
	</cfquery>

	<cfif getictran.recordcount eq 0>
		<cfset newtrancode=1>
	<cfelse>
		<cfset newtrancode=getictran.recordcount+1>
	</cfif>
<cfelse>
	<cfquery name='getictran' datasource='#dts#'>
		select sum(qty_bil) as qty_bil,sum(amt_bil) as amt_bil,sum(qty) as qty,sum(amt1_bil) as amt1_bil,sum(TAXAMT_BIL) as TAXAMT_BIL,
		itemno,desp,despa,custno,price_bil,grade,linecode,'' as itemcount,'' as GLTRADAC,UNIT_BIL,source,job,'' as batchcode,note_a,taxincl,location,brem1,brem2,brem3,brem4
		from ictran 
		where refno='#nexttranno#' 
		and type='#tran#' 
		and ( linecode <>  'SV' or linecode is null)
		group by itemno,desp,despa,custno,price_bil,grade,linecode,note_a
		
		union
		
		select qty_bil,amt_bil,qty,amt1_bil,TAXAMT_BIL,
		itemno,desp,despa,custno,price_bil,grade,linecode,itemcount,batchcode,note_a,GLTRADAC,UNIT_BIL,source,job,taxincl,location,brem1,brem2,brem3,brem4
		from ictran 
		where refno='#nexttranno#' 
		and type='#tran#' 
		and linecode = 'SV'
        
        order by itemcount
	</cfquery>
	<cfquery name="getnewtrancode" datasource="#dts#">
		select max(trancode) as newtrancode
		from ictran
		where refno='#nexttranno#' 
		and type='#tran#' 
	</cfquery>
	<cfif getnewtrancode.recordcount eq 0>
		<cfset newtrancode=1>
	<cfelse>
		<cfset newtrancode = val(getnewtrancode.newtrancode)+1>
	</cfif>
</cfif>
<!---getictran--->

	


<!--- --->

<cfset buttonStatus = "btn btn-primary active" >
<cfset buttonStatus2 = "btn btn-default" >

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#mode# #tranname#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">

<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<script>
	var dts='#dts#';
	var target='#url.target#';
	var action='#mode#';
</script>

    <!---Filter Template--->
    <cfinclude template="/latest/transaction/filter/filterService.cfm">
    <cfinclude template="/latest/transaction/filter/filterItem.cfm">
    <script type="text/javascript" src="/latest/transaction/transaction3itemlist.js"></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <!--- --->
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

   <!--- --->
   <script language="JavaScript">
   <cfoutput>
    function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
	function AddProductPage(){
	<!---var itemno=encodeURI(trim(document.getElementById('itemno').value));
	var ndatecreate=encodeURI(trim(document.getElementById('nDateCreate').value));
	var itemcount=0;
	var tran=encodeURI(trim(document.getElementById('tran').value));
	var refno=encodeURI(trim(document.getElementById('nexttranno').value));
	var multilocation="#multilocation#";
	--->
	
	ajaxFunction(document.getElementById("addproductajax"),"transaction4.cfm?type1=Add&mode=#mode#&agenno=#agenno#&newtrancode=1&ndatecreate=20140426&itemcount=0&multilocation=&itemno=001&tran=#tran#&nexttranno=#nexttranno#&currrate=#currrate#&refno3=#refno3#&hidtrancode=&custno=#custno#&readperiod=#readperiod#&service=")
	}
	
	function AddProductProcess(){
	<!---var itemno=encodeURI(trim(document.getElementById('itemno').value));
	var ndatecreate=encodeURI(trim(document.getElementById('nDateCreate').value));
	var itemcount=0;
	var tran=encodeURI(trim(document.getElementById('tran').value));
	var refno=encodeURI(trim(document.getElementById('nexttranno').value));
	var multilocation="#multilocation#";
	
	ajaxFunction(document.getElementById("addproductajax"),"transaction4.cfm?type1=Add&ndatecreate=20140426&itemcount=0&multilocation=")
	--->
	}
	</cfoutput>
	</script>
   <!--- --->

</head>
<body>
<cfoutput>


	<cfquery name='getartran' datasource='#dts#'>
		select * from artran where refno = '#nexttranno#' and type = '#tran#'
	</cfquery>

	<cfquery name='getictran2' datasource='#dts#'>
		select sum(amt_bil) as subtotal from ictran where refno = '#nexttranno#' and type = '#tran#'
	</cfquery>

	<cfif getartran.recordcount gt 0>
		<cfif mode eq 'Create' and wpitemtax neq "Y">
			<!--- Modified on 17-03-2009 --->
			<cfif lcase(hcomid) eq "net_i" or lcase(hcomid) eq "ideal_i" >
				<cfset xtaxp1="7">
			<cfelseif lcase(hcomid) eq "efrozenfood_i">
				<cfset xtaxp1=getgeneralinfo.gst>
			<cfelse>
				<!--- Modified on 14-10-2009 --->
				<cfquery name="selected_tax" datasource="#dts#">
					SELECT * FROM #target_taxtable#
					WHERE
					<cfif getartran.note neq "">
						code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.note#">
					<cfelse>
						code=code
					</cfif>
					<cfif lcase(hcomid) eq "iaf_i">
						AND tax_type in ('T',
						<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
							'PT'
						<cfelse>
							'ST'
						</cfif>
						)
					</cfif>
					limit 1
				</cfquery>
				<cfif selected_tax.recordcount neq 0>
					<cfset xnote = selected_tax.code>
					<cfset selected_taxrate = selected_tax.rate1 * 100>
					<cfset xtaxp1 = selected_taxrate>
				<cfelse>
					<cfset xtaxp1=getgeneralinfo.gst>
			  </cfif>
			</cfif>
		<cfelse>
			<cfset xtaxp1=getartran.taxp1>
		</cfif>
	
		<cfset xdisp1 = val(getartran.disp1)>
		<cfset xdisp2 = val(getartran.disp2)>
		<cfset xdisp3 = val(getartran.disp3)>
		<cfset xttlamttax=val(getartran.tax_bil)>
		<cfset xamtdisp1=val(getartran.disc_bil)>
        <cfif val(getictran2.subtotal) neq 0>
			<!--- ADD ON 23-11-2009 --->
			<cfif xdisp1 neq 0 or xdisp2 neq 0 or xdisp3 neq 0>
				<cfset disc1_bil = val(getictran2.subtotal) * xdisp1 / 100>
				<cfset disc1_bil = numberformat(disc1_bil,stDecl_Disc)>
			  	<cfset xnet_bil = val(getictran2.subtotal) - val(disc1_bil)>
				<cfset disc2_bil = xnet_bil * xdisp2 / 100>
				<cfset disc2_bil = numberformat(disc2_bil,stDecl_Disc)>
			  	<cfset xnet_bil = xnet_bil - val(disc2_bil)>
				<cfset disc3_bil = xnet_bil * xdisp3 / 100>
				<cfset disc3_bil = numberformat(disc3_bil,stDecl_Disc)>
				<cfset xamtdisp1 = val(disc1_bil) + val(disc2_bil) + val(disc3_bil)>
			</cfif><!--- ADD ON 23-11-2009 --->
        	<cfset xnet=val(getictran2.subtotal)-xamtdisp1>
			<!--- REMARK ON 23-11-2009 AND REPLACE WITH THE BELOW CONDITION --->
		  	<cfif wpitemtax neq "Y" and isdefined ('url.complete') and val(xtaxp1) neq 0>
				<!--- MODIFIED ON 10-11-2009 --->
				<cfif getartran.taxincl neq "T">
					<cfset xttlamttax=numberformat(xnet*val(xtaxp1)/100,"0.00")>
				<cfelse>
					<cfset xttlamttax=numberformat(xnet*val(xtaxp1)/(100+val(xtaxp1)),"0.00")>
				</cfif>
		  	</cfif>
			<!--- MODIFIED ON 10-11-2009 --->
		  <cfif getartran.taxincl neq "T">
				<cfset xgrand=xnet+xttlamttax>
			<cfelse>
				<cfset xgrand=xnet>
		  </cfif>
		<cfelse>
			<cfset xnet=val(getartran.net_bil)>
			<cfset xgrand=val(getartran.grand_bil)>
    </cfif>
	<cfset xdebt=xgrand>
	<cfif val(getartran.deposit) neq 0>
		<cfset xdebt=xdebt-val(getartran.deposit)>
    </cfif>
	<cfif val(getartran.cs_pm_cash) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_cash)>
    </cfif>
	<cfif val(getartran.cs_pm_cheq) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_cheq)>
    </cfif>
	<cfif val(getartran.cs_pm_crcd) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_crcd)>
    </cfif>
	<cfif val(getartran.cs_pm_crc2) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_crc2)>
    </cfif>
    <cfif val(getartran.cs_pm_dbcd) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_dbcd)>
    </cfif>
	<cfif val(getartran.cs_pm_vouc) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_vouc)>
    </cfif>

	<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq 'PO' or tran eq "RC" or tran eq "PR")>
		<cfif val(getartran.cs_pm_tt) neq 0>
			<cfset xdebt=xdebt-val(getartran.cs_pm_tt)>
		</cfif>
    </cfif>
		
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<cfset xnote=getartran.note>
		<cfelse>
			<cfif getartran.note neq "">
				<cfset xnote=getartran.note>
			<cfelse>
				<cfif getgeneralinfo.gst neq 0>
			  		<cfif mode eq "Create">
						<!--- Modified on 17-03-2009 --->
						<cfif lcase(hcomid) eq "net_i">
							<cfset xnote = 'STAX'>
						<cfelseif lcase(hcomid) eq "lioncity_i" or lcase(hcomid) eq "ugateway_i">
				  			<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
								<cfset xnote = 'PTAX'>
							<cfelseif tran eq "CS" or tran eq 'INV' or tran eq 'DO' or tran eq 'QUO' or tran eq 'SO'>
								<cfset xnote = 'STAX'>
							<cfelse>
								<cfset xnote = ''>
				  			</cfif>
						<cfelse>
				  			<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
								<cfset xnote = ''>
							<cfelse>
								<cfset xnote = 'STAX'>
				  			</cfif>
						</cfif>
					<cfelse>
						<cfset xnote=getartran.note>
					</cfif>
				<cfelse>
					<cfset xnote = 'ZR'>
				</cfif>
		  	</cfif>
	  	</cfif>
	</cfif>
    
    <cfset rebateaftertax = getartran.rebateaftertax>
    
    <cfif rebateaftertax eq 'T'>
    <cfset rebateafterdiscper=0>
    <cfset rebateafterdiscamt=0>
    <cfset rebateaftertaxper=getartran.rebateper>
    <cfset rebateaftertaxamt=getartran.rebateamt>
    <cfelse>
    <cfset rebateafterdiscper=getartran.rebateper>
    <cfset rebateafterdiscamt=getartran.rebateamt>
    <cfset rebateaftertaxper=0>
    <cfset rebateaftertaxamt=0>
    </cfif>
	
    <cfif getartran.note neq "">
				<cfset xRQnote=getartran.RQnote>
	<cfelse>
    			<cfset xRQnote=''>
    </cfif>
    <cfif getartran.RQtaxp1 neq "0">
				<cfset xRQtaxp1=getartran.RQtaxp1>
	<cfelse>
    			<cfset xrqtaxp1=0>
    </cfif>
    
    <!--- ADD ON 27-07-2009 --->
    <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
    	<cfset xnbttaxp=val(getartran.taxnbtp)>
        <cfset xnbttax=val(getartran.taxnbt)>
	</cfif>
    
	<cfif tran eq "DO">
		<cfif getpin2.h5700 eq "T">
			<cfset hidestatus="text">
		<cfelse>
			<cfset hidestatus="hidden">
	  	</cfif>
	<cfelse>
		<cfset hidestatus="text">
	</cfif>
    
    <cfif getartran.posted neq "">
   			<cfset hidestatus="hidden">
    </cfif>
	
	<cfif lcase(hcomid) eq "steel_i">
		<cfset mcList="Freight Insurance mc1:,Freight Charges mc2:,Marine Insurance mc3:,Packing mc4:,Inland Handling mc5:,mc6:,mc7:">
	<cfelse>
		<cfset mcList="Misc. Charges (1):,Misc. Charges (2):,Misc. Charges (3):,Misc. Charges (4):,Misc. Charges (5):,Misc. Charges (6):,Misc. Charges (7):">
	</cfif>
        
        
		<form class="form-horizontal" role="form" action="transaction10.cfm" method="post"><!--- onsubmit="document.getElementById('custno').disabled=false";--->
			<input type='hidden' name='tran' id="tran" value='#listfirst(tran)#'>
            <input type='hidden' name='currrate' value='#listfirst(currrate)#'>
            <input type='hidden' name='agenno' value='#listfirst(agenno)#'>
            <input type='hidden' name='refno3' value='#listfirst(refno3)#'>
            <input type="hidden" name="hidtrancode" id="hidtrancode" value="">
            <input type='hidden' name='nexttranno' value='#listfirst(nexttranno)#'>
            <input type='hidden' name='mode' value='#listfirst(mode)#'>
            <input type='hidden' name='custno' id="custno" value='#listfirst(custno)#'>
            <input type='hidden' name='readperiod' value='#listfirst(readperiod)#'>
            <input type='hidden' name='nDateCreate' value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
            <input type='hidden' name='nDateNow' value='#dateformat(now(),'dd/mm/yyyy')#'>
            <input type='hidden' name='invoicedate' value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
            <input type="hidden" name='discformat' value="#stDecl_Disc#">
            <!---<input type="hidden" name="remark5" value="#listfirst(remark5)#">
            <input type="hidden" name="remark6" value="#listfirst(remark6)#">--->
            
            <table width="100%">
            <tr>
            <td colspan="100%">
            <img src="/images/transaction page header-03.png" width="100%" >
            </td>
            </tr>
            <tr>
            <td rowspan="4" width="30%">
            <table style="margin:5% 5% 5% 5%" border="1" width="80%" height="80">
            <tr>
            <td width="50%" height="100%" style=" background-color:##999; font-size:14px" align="center">Last Sales Order<br><font size="+1">1111</font></td>
			<td width="50%" height="100%" style=" font-size:14px" align="center">New Sales Order<br><font size="+1">
            #nexttranno#
            </font></td>
            </tr>
            </table>

            
            </td>
            <th>Customer</th>
            <th colspan="2">Date</th>
            
            </tr>
            <tr>
 			<td width="30%" nowrap>
            #custno# - #name#
            </td>
            <td width="40%" colspan="2">
            #invoicedate#
            </td>
            </tr>
            <tr>
            <th>Reference No 2</th>
            <th colspan="2">Outstanding Amount</th>
            </tr>
            <tr>
            <td>#refno2#</td>
            <td colspan="2">
            <cfif getdisplaysetup2.f_crlimit eq 'Y'>
            <cfquery name="get_dealer_menu_info" datasource="#dts#">
				select 
				(
					select 
					selling_above_credit_limit 
					from dealer_menu 
				) as selling_above_credit_limit, 
				(
					select 
					crlimit 
					from #target_arcust#
					where custno='#jsstringformat(preservesinglequotes(custno))#' 
				) as credit_limit,
				(
					ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(custno))#'
							and type in ('INV','DN','CS')
							and posted='' 
							group by custno 
						)
					,0)
                    -
                    ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(custno))#'
							and type='CN'
							and posted='' 
							group by custno 
						)
					,0)
					+<!--- - --->
                    <cfif Hlinkams eq 'Y'>
					ifnull(
						(
							select 
							ifnull((sum(debitamt)- sum(creditamt)),0)
							from #replacenocase(dts,"_i","_a","all")#.glpost 
							where accno='#jsstringformat(preservesinglequotes(custno))#'  and fperiod <> '99'
							group by accno
						) 
					,0) 
                    
                    +
                    ifnull(
						(
							select 
							ifnull(lastybal,0)
							from #replacenocase(dts,"_i","_a","all")#.gldata 
							where accno='#jsstringformat(preservesinglequotes(form.custno))#' 
							group by accno
						) 
					,0) 
                    <cfelse>
                    0
                    </cfif>
				) as credit_balance;
			</cfquery>
            #numberformat(get_dealer_menu_info.credit_balance,',_.__')#
            </cfif>
            </td>
            </tr>
            <tr>
            <th>Product</th>
            <td colspan="3">
            <input type="hidden" id="itemno" name="itemno" class="itemFilter"  placeholder="Choose a Product" />
            </td>
            </tr>
            
            <tr>
            <th>Service</th>
            <td colspan="3">
            <input type="hidden" id="service" name="service" class="serviceFilter"  placeholder="Choose a Product" />
            
            <button class="btn btn-default" data-toggle="modal" data-target=".bs-example-modal-lg" onClick="AddProductPage();">Add</button>
            </td>
            </tr>
            </table>
            
            
            <table width="100%">
            <tr>
            <th>Sub Total</th>
            <td colspan="2"></td>
            <td align="right"><input name='subtotal' id="subtotal" type='text' size='10' maxlength='15' value='#numberformat(getictran2.subtotal,'.__')#' style="background-color:##FFFF99" readonly></td>
            </tr>
            <tr>
            <th>Discount (%)</th>
            <td colspan="2">
            <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>
               <input type="hidden" id="discountpasswordcontrol" name="discountpasswordcontrol" value="0">
            </cfif>
            <input name='totaldisc1' type='text' id="totaldisc1" size='4' maxlength='5' value='#xdisp1#' <cfif getgsetup.disp1limit neq 0>onKeyUp="if(document.getElementById('totaldisc1').value*1 >'#getgsetup.disp1limit#'){alert('Discount limit is over');document.getElementById('totaldisc1').value=0;getDiscountControl();};"<cfelse>onKeyUp="getDiscountControl();"</cfif> > +
            <input name='totaldisc2' type='text' id="totaldisc2" size='4' maxlength='5' value='#xdisp2#' <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>onFocus="if (document.getElementById('discountpasswordcontrol').value==0){ColdFusion.Window.show('discountpassword');document.getElementById('totaldisc1').focus();}"</cfif> onKeyUp="getDiscountControl();"> +
            <input name='totaldisc3' type='text' id="totaldisc3" size='4' maxlength='5' value='#xdisp3#' <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>onFocus="if (document.getElementById('discountpasswordcontrol').value==0){ColdFusion.Window.show('discountpassword');document.getElementById('totaldisc1').focus();}"</cfif> onKeyUp="getDiscountControl();">
            </td>
            <td><input name='totalamtdisc' id="totalamtdisc_id" type='text' size='10' maxlength='15' value='#xamtdisp1#' <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </tr>
            <tr>
            <th>Net</th>
            <td colspan="2"></td>
            <td><input name='viewNet' id='viewNet' type='text' size='10' value='#xnet#' style="background-color:##FFFF99" readonly></td>
            </tr>
            <tr>
            <th>
            	<cfif getgsetup.ngstcustdisabletax eq "1">
            	<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
            	<cfquery name="getnongstcust" datasource="#dts#">
            	select NGST_CUST,taxcode from #target_apvend# where custno='#custno#'
            	</cfquery>
           		<cfelse>
            	<cfquery name="getnongstcust" datasource="#dts#">
            	select NGST_CUST,taxcode from #target_arcust# where custno='#custno#'
            	</cfquery>
            	</cfif><cfif getnongstcust.NGST_CUST eq 'T'><cfelse>Tax (%)</cfif><cfelse>Tax (%)</cfif>
            </th>
            <td>
            <cfif wpitemtax eq "Y">
                <select name="selecttax" id="selecttax" style="visibility:hidden">
                <option value="#xnote#"></option>
                </select>
                    <input type="hidden" name="wpitemtax" id="wpitemtax" value="Y">
				<cfelse>
						<cfif lcase(hcomid) eq "efrozenfood_i">
						<select name="selecttax" onChange="getTaxControl();">
							<cfif tran eq "INV">
			                    <option value="EX"<cfif xnote eq "EX">selected</cfif>>Exempted</option>
		                        <option value="STAX"<cfif xnote eq "STAX">selected</cfif>>STAX</option>
		                        <option value="ZR"<cfif xnote eq "ZR">selected</cfif>>Zero Rated</option>
		                    <cfelse>
		                    	<option value="XGST" <cfif xnote eq "XGST">selected</cfif>>X-GST</option>
		                    	<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
		                        	<option value="PTAX"<cfif xnote eq "PTAX">selected</cfif>>PTAX</option>
		                        <cfelse>
				                    <option value="EX"<cfif xnote eq "EX">selected</cfif>>Exempted</option>
									<option value="OS"<cfif xnote eq "OS">selected</cfif>>Out of Scope</option>
			                        <option value="STAX"<cfif xnote eq "STAX">selected</cfif>>STAX</option>
			                        <option value="PTAX"<cfif xnote eq "PTAX">selected</cfif>>PTAX</option>
			                        <option value="ZR"<cfif xnote eq "ZR">selected</cfif>>ZR</option>
								</cfif>
							</cfif>
						</select>
                        <!---ngstcustdisabletax --->
                        <cfelseif getgsetup.ngstcustdisabletax eq "1">
                        <cfif getnongstcust.NGST_CUST eq "T">
                         <select name="selecttax" id="selecttax" style="visibility:hidden">
                         <cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
                        <cfif getnongstcust.taxcode eq ''>
            		    <option value="#getgsetup.df_purchasetaxzero#">#getgsetup.df_purchasetaxzero#</option>						<cfelse>
                        <option value="#getnongstcust.taxcode#">#getnongstcust.taxcode#</option>						
                        </cfif>
                        <cfelse>
                        <cfif getnongstcust.taxcode eq ''>
                        <option value="#getgsetup.df_salestaxzero#">#getgsetup.df_salestaxzero#</option>
                        <cfelse>
                        <option value="#getnongstcust.taxcode#">#getnongstcust.taxcode#</option>
                        </cfif>
                        </cfif>
             		   </select>
                        <cfelse>
                        <cfquery name="select_tax" datasource="#dts#">
							SELECT * FROM #target_taxtable#
							<cfif lcase(hcomid) eq "iaf_i">
								WHERE tax_type in ('T',
								<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
									'PT'
								<cfelse>
									'ST'
								</cfif>
								)
                            <cfelse>
                            
							<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
                            WHERE tax_type <> "ST"
                            <cfelseif tran eq 'DN' <!---or tran eq 'CN'---> >
                            <cfelse>
                            WHERE tax_type <> "PT"
                            </cfif>
                                 
							</cfif>
						</cfquery>
						<select name="selecttax" id="selecttax" onChange="JavaScript:document.getElementById('pTax').value=this.options[this.selectedIndex].id;getTaxControl();">
			                <cfloop query="select_tax">
			                	<cfset idrate = select_tax.rate1 * 100>
			                	<option value="#select_tax.code#" id="#idrate#" <cfif xnote eq select_tax.code>selected</cfif>>#select_tax.code#</option>
			                </cfloop>
		                </select>
                        </cfif>
                        <!---end ngstcustdisabletax --->
					<cfelse>
						<cfquery name="select_tax" datasource="#dts#">
							SELECT * FROM #target_taxtable#
							<cfif lcase(hcomid) eq "iaf_i">
								WHERE tax_type in ('T',
								<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'  or tran eq 'RQ'>
									'PT'
								<cfelse>
									'ST'
								</cfif>
								)
                            <cfelse>
                            
							<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
                            WHERE tax_type <> "ST"
                            <cfelseif tran eq 'DN' <!---or tran eq 'CN'---> >
                            <cfelse>
                            WHERE tax_type <> "PT"
                            </cfif>
                                 
							</cfif>
						</cfquery>
						<select name="selecttax" id="selecttax" onChange="JavaScript:document.getElementById('pTax').value=this.options[this.selectedIndex].id;getTaxControl();">
			                <cfloop query="select_tax">
			                	<cfset idrate = select_tax.rate1 * 100>
			                	<option value="#select_tax.code#" id="#idrate#" <cfif xnote eq select_tax.code>selected</cfif>>#select_tax.code#</option>
			                </cfloop>
		                </select>
					</cfif>
				</cfif>
            
            </td>
            <td>
            	<cfif wpitemtax eq "Y">
                	<input name="pTax" id="pTax" type="hidden" size="5" maxlength="5" value="0">
				<cfelse>
                 <cfif getgsetup.ngstcustdisabletax eq "1">
                 <cfif getnongstcust.NGST_CUST eq "T">
                 <input name="pTax" id="pTax" type="hidden" size="5" maxlength="5" value="0">
                 <cfelse>
                 <input name="pTax" id="pTax" type="text" size="5" maxlength="5" value="#xtaxp1#" onKeyUp="getTaxControl();" onBlur="settaxcode();">
                 
                 </cfif>
                 <cfelse>
                	<input name="pTax" id="pTax" type="text" size="5" maxlength="5" value="#xtaxp1#" onKeyUp="getTaxControl();" onBlur="settaxcode();">
                  </cfif>
				</cfif>
            </td>
            <td><input name="totalamttax" type="text" size="10" value="#xttlamttax#" onKeyUp="getGrand();" <cfif wpitemtax eq "Y">style="background-color:##FFFF99" readonly<cfelseif lcase(HcomID) eq "verjas_i"> readonly</cfif>></td>
            </tr>
            <tr>
            <th>Grand</th>
            <td colspan="2"></td>
            <td><input name="viewGrand" type="text" size="10" maxlength="15" value="#xgrand#" onKeyUp="auto_fill_discount_value();" onClick="select();"></td>
            </tr>
            <tr>
            <td align="center" colspan="100%">Extra Charges</td>
            </tr>
            <tr>
            <td>Misc Charges 1</td>
            <td align="right" colspan="3"><input type="text" id="mc1_bil" name="mc1_bil" value="#numberformat(getartran.mc1_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 2</td>
            <td align="right" colspan="3"><input type="text" id="mc2_bil" name="mc2_bil" value="#numberformat(getartran.mc2_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 3</td>
            <td align="right" colspan="3"><input type="text" id="mc3_bil" name="mc3_bil" value="#numberformat(getartran.mc3_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 4</td>
            <td align="right" colspan="3"><input type="text" id="mc4_bil" name="mc4_bil" value="#numberformat(getartran.mc4_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 5</td>
            <td align="right" colspan="3"><input type="text" id="mc5_bil" name="mc5_bil" value="#numberformat(getartran.mc5_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 6</td>
            <td align="right" colspan="3"><input type="text" id="mc6_bil" name="mc6_bil" value="#numberformat(getartran.mc6_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <td>Misc Charges 7</td>
            <td align="right" colspan="3"><input type="text" id="mc7_bil" name="mc7_bil" value="#numberformat(getartran.mc7_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
            </td>
            </tr>
            <tr>
            <cfquery name="currency" datasource="#dts#">
  			select * 
			from #target_currency# 
			</cfquery>
			<cfset footercurrrate =getartran.footercurrrate>
    		<cfset xfootercurrcode=getartran.footercurrcode>

    		<!---end get footer currate & code--->
			<cfif getgsetup.footerexchange eq 'Y'>
            <td>Currency Code</td>
			<td><select name="footercurrcode" id="footercurrcode" onChange="ajaxFunction(document.getElementById('footercurrajax'),'/default/transaction/footercurrrateajax.cfm?footercurrcode='+document.getElementById('footercurrcode').value+'&date=#dateformat(getartran.wos_date,'yyyy-mm-dd')#');">
            <option value="">Choose a currency code</option>
            <cfloop query="currency">
            <option value="#currency.currcode#"<cfif xfootercurrcode eq currency.currcode>selected</cfif>>#currency.currcode#</option>
            </cfloop>
            </select>
            </td>
            <cfelse>
            <td>&nbsp;</td>
			<td colspan="2"><input name="footercurrcode" id="footercurrcode" type="hidden" size="10" value="#listfirst(xfootercurrcode)#" readonly ></td>
            </cfif>
            </tr>
            <tr>
            <cfif getgsetup.footerexchange eq 'Y'>
            <td>Currency Rate</td>
			<td><div id="footercurrajax"><input name="footercurrrate" id="footercurrrate" type="text" size="10" value="#Numberformat(listfirst(footercurrrate), '._____')#"></div></td>
            <cfelse>
            <td>&nbsp;</td>
			<td><input name="footercurrrate" id="footercurrrate" type="hidden" size="10" value="#Numberformat(listfirst(footercurrrate), '._____')#"></td>
            </cfif>
            </tr>
            </table>
            
            <cfif getgsetup.termscondition eq 'Y'>
        <table  width='100%' border="0" align='center' cellspacing="0">
        
        <tr>
        <td><div align="right"><cfif hcomid eq 'mylustre_i'>Note<cfelse>Terms & Condition</cfif></div></td>
        <td colspan="10">
        <cfif hcomid eq "clickworkz_i" or hcomid eq "zinnia_i">
        <cfquery name="gettnc" datasource="#dts#">
        SELECT * FROM termsandconditions WHERE (billtype = "#tran#" or billtype = "All") Order by id
        </cfquery>
        <select name="picktermscondition" id="picktermscondition" onChange="ajaxFunction(document.getElementById('termsconditionajaxfield'),'clickworkzterm.cfm?term='+this.value);setTimeout('texteditor();',500);">
        <option value="">Choose a Terms & Condition</option>
        <cfloop query="gettnc">
        <option value="#gettnc.id#" id="#URLENCODEDFORMAT(gettnc.desp)#" <cfif getartran.picktermscondition eq gettnc.id>Selected</cfif> ><cfif len(gettnc.desp) lt 20>#gettnc.desp#<cfelse>#left(gettnc.desp,20)#</cfif></option>
        
        </cfloop>
        </select><br>
        <script type="text/javascript">
						texteditor();
		</script>
		</cfif>
        <div id="termsconditionajaxfield">
			<textarea name="termscondition" id="termscondition" cols="160" rows="5"><cfif getartran.termscondition neq ''>#convertquote(getartran.termscondition)#<cfelse><cfif tran eq 'RC'>#convertquote(gettermcondition.lRC)#<cfelseif tran eq 'PR'>#convertquote(gettermcondition.lPR)#<cfelseif tran eq 'DO'>#convertquote(gettermcondition.lDO)#<cfelseif tran eq 'INV'>#convertquote(gettermcondition.lINV)#<cfelseif tran eq 'CS'>#convertquote(gettermcondition.lCS)#<cfelseif tran eq 'CN'>#convertquote(gettermcondition.lCN)#<cfelseif tran eq 'DN'>#convertquote(gettermcondition.lDN)#<cfelseif tran eq 'PO'>#convertquote(gettermcondition.lPO)#<cfelseif tran eq 'QUO'>#convertquote(gettermcondition.lQUO)#<cfelseif tran eq 'SO'>#convertquote(gettermcondition.lSO)#<cfelseif tran eq 'SAM'>#convertquote(gettermcondition.lSAM)#</cfif></cfif></textarea>
		</div>
        </td>
        </tr>
        
       
        
        </table>
        <cfelse>
        <input type="hidden" name="termscondition" id="termscondition" value="">
         </cfif>
            
            <!---End Header--->
            
            <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
			</table>
            <!---Item List--->
			<div>
            <table width='100%' align='center' class='data'>
            <tr>
                <th>No.</th>
                <cfif getdisplaysetup.billbody_aitemno eq 'Y'>
                <th>Product Code</th>
                </cfif>
                <cfif getdisplaysetup.billbody_itemno eq 'Y'>
                <th><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>Item Code</cfif></th>
                </cfif>
                <cfif getdisplaysetup.billbody_desp eq 'Y'>
                <th><cfoutput>#getgsetup.ldescription#</cfoutput></th>
                </cfif>
                <cfoutput>
                <cfif getdisplaysetup.billbody_brand eq 'Y'><th>Brand</th></cfif>
                <cfif getdisplaysetup.billbody_group eq 'Y'><th>#getgsetup.lgroup#</th></cfif>
                <cfif getdisplaysetup.billbody_category eq 'Y'><th>#getgsetup.lcategory#</th></cfif>
                <cfif getdisplaysetup.billbody_model eq 'Y'><th>#getgsetup.lmodel#</th></cfif>
                <cfif getdisplaysetup.billbody_rating eq 'Y'><th>#getgsetup.lrating#</th></cfif>
                <cfif getdisplaysetup.billbody_sizeid eq 'Y'><th>#getgsetup.lsize#</th></cfif>
                <cfif getdisplaysetup.billbody_material eq 'Y'><th>#getgsetup.lmaterial#</th></cfif>
                <cfif getdisplaysetup.billbody_pono eq 'Y'><th>PO No.</th></cfif>
                </cfoutput>
                <cfif getdisplaysetup.billbody_location eq 'Y'>
                <th>Location</th>
                </cfif>
                <cfif getdisplaysetup.billbody_project eq 'Y'>
                <th>Project</th>
                </cfif>
                <cfif getdisplaysetup.billbody_job eq 'Y'>
                <th>Job</th>
                </cfif>
                <cfif getdisplaysetup.billbody_batch eq 'Y'>
                <th>Batch Code</th>
                </cfif>
                <cfif getdisplaysetup.billbody_onhand eq 'Y'>
                
                <th>Qty Balance</th>
                </cfif>
                <cfif getdisplaysetup.billbody_gltradac eq 'Y'>
                <th>GL ACC</th>
                </cfif>
                <cfif getdisplaysetup.billbody_qty eq 'Y'>
                <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Drum<cfelse>Quantity</cfif></th>
                </cfif>
                <cfif getdisplaysetup.billbody_unit eq 'Y'>
                <th>Unit</th>
                </cfif>
                
                <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'PR' or tran eq 'RC' or tran eq 'RQ')>
                <cfif getdisplaysetup.billbody_price eq 'Y'>
                <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Capacity per Drum<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">Price<cfelseif tran neq "DO">Price</cfif></cfif></th>
                </cfif>
                <cfif getdisplaysetup.billbody_currcode eq 'Y'>
                <th>Curr Code</th>
                </cfif>
                <cfif wpitemtax eq "Y">
                <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
                    <th>Tax Amount</th>
                </cfif>
                </cfif>
                <cfif getdisplaysetup.billbody_amt eq 'Y'>
                <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Total Quantity<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">Amount<cfelseif tran neq "DO">Amount</cfif></cfif></th>
                </cfif>
                <cfif wpitemtax eq "Y">
                <cfif getdisplaysetup.billbody_taxcode eq 'Y'>
                    <th>Tax Code</th>
                </cfif>
                </cfif>
                </cfif>
                
                <cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
                <cfif getdisplaysetup.billbody_price eq 'Y'>
                <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Capacity per Drum<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">Price<cfelseif tran neq "DO">Price</cfif></cfif></th>
                </cfif>
                <cfif getdisplaysetup.billbody_currcode eq 'Y'>
                <th>Curr Code</th>
                </cfif>
                <cfif wpitemtax eq "Y">
                <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
                    <th>Tax Amount</th>
                </cfif>
                </cfif>
                <cfif getdisplaysetup.billbody_amt eq 'Y'>
                <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Total Quantity<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">Amount<cfelseif tran neq "DO">Amount</cfif></cfif></th>
                </cfif>
                <cfif wpitemtax eq "Y">
                <cfif getdisplaysetup.billbody_taxcode eq 'Y'>
                    <th>Tax Code</th>
                </cfif>
                </cfif>
                </cfif>
                
                
                <cfif getdisplaysetup.billbody_brem1 eq 'Y'>
                <th><cfoutput>#getgsetup.brem1#</cfoutput></th>
                </cfif>
                <cfif getdisplaysetup.billbody_brem2 eq 'Y'>
                <th><cfoutput>#getgsetup.brem2#</cfoutput></th>
                </cfif>
                
                <cfif getdisplaysetup.billbody_brem3 eq 'Y'>
                <th><cfoutput>#getgsetup.brem3#</cfoutput></th>
                </cfif>
                
                <cfif getdisplaysetup.billbody_brem4 eq 'Y'>
                <th><cfoutput>#getgsetup.brem4#</cfoutput></th>
                </cfif>
                
                <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
                <th>
                Item Count
                </th>
                </cfif>
                
                <th>Action</th>
            </tr>
                
            <cfif getictran.recordcount gt 0>
                <cfquery name='getarrate' datasource='#dts#'>
                    select currrate from artran where refno='#nexttranno#' and type='#tran#'
                </cfquery>
            
                <cfset xcurrrate=getarrate.currrate>
                <!---For Weiken--->    
                <cfset strText = ucase('abcdefghijklmnopqrstuvwxyz')>
                <cfset character = 1>
                <cfset Number = 1>
                <!--- --->
                <cfoutput query='getictran'>
                
                <cfquery name="getiteminfo" datasource="#dts#">
                select sizeid,colorid,brand,category,wos_group,shelf,costcode from icitem where itemno='#getictran.itemno#'
                </cfquery>
                
                <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
                
                
                <cfif getictran.title_desp neq ''>
                 <cfset strChar = Mid( strText, Character, 1 ) />
                 <cfset character+=1>
                <tr bgcolor="##CCCCCC" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='##CCCCCC';">
                <td>#strChar#</td>
                <td colspan="8">#getictran.title_desp#</td>
                </tr>
                <cfset Number = 0>
                </cfif>
                </cfif>
                
                
                <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    <td><cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
                            or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
                            or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
                            or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
                            or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
                            or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
                            or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i"><input type="text" name="displaylist#trancode#" id="displaylist#trancode#" size="5" value="#brem3#" onBlur="updaterow('#trancode#');">
                            <cfelseif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
                            <cfset Number += 1>
                            #Number#
                            <cfelse>
                            #getictran.currentrow#.</cfif></td>
                    <cfif getdisplaysetup.billbody_aitemno eq 'Y'>
                    <cfquery name="getproductcode" datasource="#dts#">
                    select aitemno from icitem where itemno='#getictran.itemno#'
                    </cfquery>
                    <td>#getproductcode.aitemno#</td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_itemno eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#itemno#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_desp eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#desp##despa#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_brand eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.brand#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_group eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.wos_group#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_category eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.category#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_model eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.shelf#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_rating eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.costcode#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_sizeid eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.sizeid#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_material eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#getiteminfo.colorid#</font></td></cfif>
                    <cfif getdisplaysetup.billbody_pono eq 'Y'><td><font face='Arial, Helvetica, sans-serif'>#pono#</font></td></cfif>
                    
                    
                    <cfif getdisplaysetup.billbody_location eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#location#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_project eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#source#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_job eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#job#</font></td>
                    </cfif>
                    <cfif getdisplaysetup.billbody_batch eq 'Y'>
                    <td><font face='Arial, Helvetica, sans-serif'>#batchcode#</font></td>
                    </cfif>
            <cfif getdisplaysetup.billbody_onhand eq 'Y'>
            <cfquery name="getlocation" datasource="#dts#">
            select * from iclocation where location='#location#'
            </cfquery>
            <cfif getlocation.location neq ''>
                    <cfquery datasource="#dts#" name="getqtybalance">
            
                select 
                c.balance 
                
                from icitem as a 
                
                left join 
                (
                    select 
                    location,
                    itemno,
                    (select desp from iclocation where location=locqdbf.location) as locationdesp 
                    from locqdbf
                    where itemno=itemno 
                    and itemno='#itemno#' 
                    and location = '#location#'
                ) as b on a.itemno=b.itemno 
                
                left join 
                (
                    select 
                    a.location,
                    a.itemno,
                    (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
                    
                    from locqdbf as a 
                    
                    left join
                    (
                        select 
                        location,
                        itemno,
                        sum(qty) as sum_in 
                        
                        from ictran
                        
                        where type in ('RC','CN','OAI','TRIN') 
                        and fperiod<>'99'
                        and itemno='#itemno#' 
                        and location = '#location#'
                        and (void = "" or void is null)
                        group by location,itemno
                        order by location,itemno
                    ) as b on a.location=b.location and a.itemno=b.itemno
                    
                    left join
                    (
                        select 
                        location,
                        category,
                        wos_group,
                        itemno,
                        sum(qty) as sum_out 
                        
                        from ictran 
                        
                        where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                        and toinv='' 
                        and fperiod<>'99'
                        and itemno='#itemno#' 
                        and location = '#location#'
                        and (void = "" or void is null)
                        group by location,itemno
                        order by location,itemno
                    ) as c on a.location=c.location and a.itemno=c.itemno 
                    
                    where a.itemno=a.itemno
                    and a.itemno='#itemno#' 
                   
                    and a.location = '#location#'
                ) as c on a.itemno=c.itemno and b.location=c.location 
                
                where a.itemno=a.itemno 
                and b.location<>''
            
            
                and b.location = '#location#'
            
                and a.itemno='#itemno#' 
                order by a.itemno;
            </cfquery>
            
            <cfelse>
            
            <cfquery name="getqtybalance" datasource="#dts#">
                select 
                a.itemno,
                ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                
                from icitem as a
                
                left join 
                (
                    select itemno,sum(qty) as sumtotalin,gltradac
                    from ictran 
                    where type in ('RC','CN','OAI','TRIN') 
                    and itemno='#itemno#'  
                    and fperiod<>'99'
                    and (void = '' or void is null)
                    group by itemno
                ) as b on a.itemno=b.itemno
                
                left join 
                (
                    select itemno,sum(qty) as sumtotalout,gltradac
                    from ictran 
                    where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                    and itemno='#itemno#' 
                    and fperiod<>'99'
                    and (void = '' or void is null)
                    and toinv='' 
                    group by itemno
                ) as c on a.itemno=c.itemno
            
                
                where a.itemno='#itemno#'  
                </cfquery>
                </cfif>

                 <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#getqtybalance.balance#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_gltradac eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#gltradac#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_qty eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#qty_bil#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_unit eq 'Y'>
                        <td><div align='left'><font face='Arial, Helvetica, sans-serif'>#unit_bil#</font></div></td>
                        </cfif>
                       
                        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'PR' or tran eq 'RC' or tran eq 'RQ')>
                        <cfif getdisplaysetup.billbody_price eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'><cfif tran eq "DO" and getpin2.h5700 eq "T">#numberFormat(price_bil, stDecl_UPrice)#<cfelseif tran neq "DO">
                        <cfif lcase(hcomid) eq "visionlaw_i">
                        <a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#trancode#';ColdFusion.Window.show('changeprice');getfocus();">#numberformat(val(price_bil),',.__')#</a>
                        <cfelse>
                        #numberFormat(price_bil, stDecl_UPrice)#</cfif></cfif></font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_currcode eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#listfirst(refno3)#</font></div></td>
                        </cfif>
                        <cfif wpitemtax eq "Y">
                        <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
                            <td><div align='right'><font face='Arial, Helvetica, sans-serif'>
                            <cfif lcase(hcomid) eq "visionlaw_i"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#trancode#';ColdFusion.Window.show('changegst');getfocus2();">#numberFormat(TAXAMT_BIL, ".__")#</a><cfelse>
                            #numberFormat(TAXAMT_BIL, ".__")#</cfif></font></div></td>
                        </cfif>
                        </cfif>
                        <cfif getdisplaysetup.billbody_amt eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>
                        
                        <cfif tran eq "DO" and getpin2.h5700 eq "T"><cfif multilocation neq "Y">#numberFormat(amt_bil, ".__")#<cfelse>#numberFormat(amt_bil, stDecl_UPrice)#</cfif><cfelseif tran neq "DO"><cfif multilocation neq "Y">#numberFormat(amt_bil, ".__")#<cfelse>#numberFormat(amt_bil, stDecl_UPrice)#</cfif></cfif></font></div></td>
                        </cfif>
                        <cfif wpitemtax eq "Y">
                        <cfif getdisplaysetup.billbody_taxcode eq 'Y'>
                            <td><div align='left'><font face='Arial, Helvetica, sans-serif'>
                              #note_a#
                              <cfif getictran.taxincl eq "T"> (Tax Included)</cfif></font></div></td>
                        </cfif>
                        </cfif>
                        </cfif>
                        
                        <cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
                        <cfif getdisplaysetup.billbody_price eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'><cfif lcase(hcomid) eq "visionlaw_i">
                        <a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#trancode#';ColdFusion.Window.show('changeprice');getfocus();">#numberformat(val(price_bil),',.__')#</a>
                        <cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">#numberFormat(price_bil, stDecl_UPrice)#<cfelseif tran neq "DO">#numberFormat(price_bil, stDecl_UPrice)#</cfif></cfif></font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_currcode eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#listfirst(refno3)#</font></div></td>
                        </cfif>
                        <cfif wpitemtax eq "Y">
                        <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
                            <td><div align='right'><font face='Arial, Helvetica, sans-serif'>
                            <cfif lcase(hcomid) eq "visionlaw_i"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#trancode#';ColdFusion.Window.show('changegst');getfocus2();">#numberFormat(TAXAMT_BIL, ".__")#</a><cfelse>
                            #numberFormat(TAXAMT_BIL, ".__")#</cfif></font></div></td>
                        </cfif>
                        </cfif>
                        <cfif getdisplaysetup.billbody_amt eq 'Y'>
                        <td><div align='right'><font face='Arial, Helvetica, sans-serif'><cfif tran eq "DO" and getpin2.h5700 eq "T"><cfif multilocation neq "Y">#numberFormat(amt_bil, ".__")#<cfelse>#numberFormat(amt_bil, stDecl_UPrice)#</cfif><cfelseif tran neq "DO"><cfif multilocation neq "Y">#numberFormat(amt_bil, ".__")#<cfelse>#numberFormat(amt_bil, stDecl_UPrice)#</cfif></cfif></font></div></td>
                        </cfif>
                        <cfif wpitemtax eq "Y">
                        <cfif getdisplaysetup.billbody_currcode eq 'Y'>
                            <td><div align='left'><font face='Arial, Helvetica, sans-serif'>
                              #note_a#
                              <cfif getictran.taxincl eq "T"> (Tax Included)</cfif></font></div></td>
                        </cfif>
                        </cfif>
                        </cfif>
                        
                        
                        <cfif getdisplaysetup.billbody_brem1 eq 'Y'>
                        <td><div align='left'><font face='Arial, Helvetica, sans-serif'>#brem1#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_brem2 eq 'Y'>
                        <td><div align='left'><font face='Arial, Helvetica, sans-serif'>#brem2#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_brem3 eq 'Y'>
                        <td><div align='left'><font face='Arial, Helvetica, sans-serif'>#brem3#</font></div></td>
                        </cfif>
                        <cfif getdisplaysetup.billbody_brem4 eq 'Y'>
                        <td><div align='left'><font face='Arial, Helvetica, sans-serif'>#brem4#</font></div></td>
                        </cfif>
                        <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i">
                        <td style="text-align:right">
                        #itemcount#
                        </td>
                        </cfif>
                        
                        
                        <cfif tran eq "INV">
                            <cfquery name="checkitemupdatedfrombills" datasource="#dts#">
                                select refno from iclink where refno='#nexttranno#' and type='#tran#' and itemno='#itemno#' and trancode='#trancode#'
                                 and frtype='DO'
                            </cfquery>
                        <cfelseif tran eq "CS">
                            <cfquery name="checkitemupdatedfrombills" datasource="#dts#">
                                select refno from iclink where refno='#nexttranno#' and type='#tran#' and itemno='#itemno#' and trancode='#trancode#'
                                 and frtype='SO'
                            </cfquery>
                        </cfif>
                        
                        <cfquery name="checkitemupdatedtobills" datasource="#dts#">
                            select refno from iclink where frrefno='#nexttranno#' and frtype='#tran#' and itemno='#itemno#' and frtrancode='#trancode#' and type<>'SAM' and frtype<>'SAM'
                        </cfquery>
                        
                        <td><div align='center'><font face='Arial, Helvetica, sans-serif'>
                            <cfif lcase(hcomid) eq "steel_i" and tran neq "TR">
                            <a onClick="releaseDirtyFlag();" href='transaction_steel.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemcount=#itemcount#&
                            ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#&
                            custno=#URLEncodedFormat(custno)#&readperiod=#readperiod#&invoicedate=#invoicedate#'>
                            <img height='18px' width='18px' src='../../images/edit.ICO' alt='Change Item' border='0'>Change Item</a>&nbsp;
                            </cfif>
                              <cfquery datasource="#dts#" name="getartran">
                                select * 
                                from artran
                                where refno = '#nexttranno#' 
                                and type = '#tran#'
                            </cfquery>
                            <!---posted bill--->
                            <cfif getartran.posted neq "">
                            <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#&editinfoonly=1&noeditprice=1'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>Edit</a>&nbsp;
                            <cfelse>
                            <!--- <cfif multilocation neq "Y"> --->
                             <cfif tran eq "INV">
                             <cfif checkitemupdatedfrombills.recordcount eq 0>
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#newtrancode#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>Edit</a>&nbsp;
                            <cfelse>
                                <!---cannot edit location--->
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#&editinfoonly=1&noeditloc=1'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>Edit</a>&nbsp;
                            </cfif>
                            <cfelse>
                            <cfif checkitemupdatedtobills.recordcount eq 0>
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>Edit</a>&nbsp;
                            <cfelse>
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#&editinfoonly=1'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>Edit</a>&nbsp;
                            </cfif>
                            </cfif>
                            </cfif>
                            <!---posted bill--->
                            <cfif getartran.posted neq "">
                            <img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>Delete
                            <cfelse>
                            <cfif tran eq "INV" or tran eq "CS">
                                <cfif checkitemupdatedfrombills.recordcount eq 0>
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Delete&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>Delete</a>
                                <cfelse>
                                <img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>Delete
                                </cfif>
                            <cfelse>
                                <cfif checkitemupdatedtobills.recordcount eq 0>
                                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&mode=#mode#&type1=Delete&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#agenno#
                                &enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>Delete</a>
                                <cfelse>
                                <img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>Delete
                                </cfif>
                            </cfif>
                            </cfif>
                                 </font></div>
                            </td>
                                </tr>
                                </cfoutput>
                            </cfif>
                      </table>	
            
            
            </div>
            <!---Item List--->
            
			<div align="center">
				<button type="submit" class="btn btn-primary" id="submit">Next</button>
				<button type="button" class="btn btn-default" onclick="window.history(-1)" >Back</button>
			</div>
		</form>		
	</div>
</cfoutput>

<!---include div--->
<cfinclude template="transaction3ajax.cfm">
<!--- --->


</body>
</html>





