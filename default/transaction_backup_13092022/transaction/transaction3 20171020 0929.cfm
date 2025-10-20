<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "2155,805,104,5,2078,58,702,1292,1692,1198,69,120,294,1241,1109,293,294,11,1831,2162,148,2163,124,1627,1634,1635,1636,1637,1638,1639,1640,1297,1298,2117,2079,2080,2164,2165,2081,2077,2166,2167,53,2168,785,1870,121,128,120,65,122,146,123,150,152,154,148,482,506,475,2027,1113,1293,227,492,1096,785,1099,1097,56,10,48,67,849,851,11,2154,793,782,664,188,665,666,185,689,667,690,668,673,674,961,835,2151,721,718,719,720,722,723,724,980,692,726,725,727,728,2152,698,960,2153,745,694,748,1782,1849,813,696,814,815,816,817,818,819,820,821,822,697,698,749,106,704,16,702,29,703,40,795,752,441,300,753,506,475,754,759,1692,1358,695,757,65,887,668,781,784,783,892,785,786,787,788,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703,1716,1717,1288,705,706,10,3,808,848,2155,806,805,804">
<cfinclude template="/latest/words.cfm">


<cfajaximport tags="cfform">
<cfajaximport tags="cfform">
<cfajaximport tags="CFINPUT-AUTOSUGGEST"> 
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<!--- UPDATE GSETUP2 UNIT COST STATUS --->
<cfif tran eq "RC">
	<cfinclude template = "transaction3_update_unit_cost_status.cfm">
</cfif>
<!--- UPDATE GSETUP2 UNIT COST STATUS --->

<cfset alcreate=0>
<cfset newtrancode=0>
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
<cfquery datasource="#dts#" name="getmodule">
	Select * from modulecontrol
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>

<cfquery name="getdefault" datasource="#dts#">
SELECT dfpos,ldescription,autolocbf FROM gsetup
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select * from dealer_menu
</cfquery>

<cfquery name="getusername" datasource="main">
    select username from users where userid='#huserid#' and userbranch='#dts#'
</cfquery>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="gettermcondition" datasource="#dts#">
    select * from ictermandcondition
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<!---checklocationrefno--->

<cfset followlocationrefno=0><!---Follow location Profile Running No--->

<cfif lcase(huserloc) neq "all_loc">
<cfquery datasource="#dts#" name="getlocationrefno">
			select lastUsedNo
            from refnoset_location
			where type = '#tran#'
			and location = '#huserloc#'
            and activate="T"
</cfquery>
<cfif getlocationrefno.recordcount neq 0>
<cfset followlocationrefno=1>
</cfif>
</cfif>

<!---end checklocationrefno--->

<cfif getgsetup.prefixbycustquo eq 'Y' or getgsetup.prefixbycustso eq 'Y' or getgsetup.prefixbycustinv eq 'Y'>
<cfif isdefined('form.custno')>
<cfif tran eq "RC">
<cfquery name="getcustprefixno" datasource="#dts#">
	select arrem2,arrem3,arrem4 from #target_apvend# where custno='#form.custno#'
</cfquery>
<cfelse>
<cfquery name="getcustprefixno" datasource="#dts#">
	select arrem2,arrem3,arrem4 from #target_arcust# where custno='#form.custno#'
</cfquery>
</cfif>
</cfif>
</cfif>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<cfswitch expression="#tran#">
	<cfcase value="RC">
		<cfset tran = 'RC'><cfset tranname = words[664]><cfset trancode = 'rcno'><cfset tranarun = 'rcarun'>
		<cfif getpin2.h2102 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="PR">
		<cfset tran = 'PR'><cfset tranname = words[188]><cfset trancode = 'prno'><cfset tranarun = 'prarun'>
		<cfif getpin2.h2201 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="DO">
		<cfset tran = 'DO'><cfset tranname = words[665]><cfset trancode = 'dono'><cfset tranarun = 'doarun'>
		<cfif getpin2.h2301 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="INV">
		<cfset tran = 'INV'><cfset tranname = words[666]>
		<cfif isdefined("form.invset")><cfset trancode = form.invset><cfset tranarun = form.tranarun>
  		<cfelse><cfset trancode = "invno"><cfset tranarun = "invarun">
  		</cfif>
  		<cfif getpin2.h2401 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="CS">
		<cfset tran = 'CS'><cfset tranname = words[185]><cfset trancode = 'csno'><cfset tranarun = 'csarun'>
		<cfif getpin2.h2501 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="CN">
		<cfset tran = 'CN'><cfset tranname = words[689]><cfset trancode = 'cnno'><cfset tranarun = 'cnarun'>
		<cfif getpin2.h2601 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="DN">
		<cfset tran = 'DN'><cfset tranname = words[667]><cfset trancode = 'dnno'><cfset tranarun = 'dnarun'>
		<cfif getpin2.h2701 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="PO">
		<cfset tran = 'PO'><cfset tranname = words[690]><cfset trancode = 'pono'><cfset tranarun = 'poarun'>
		<cfif getpin2.h2861 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
    <cfcase value="RQ">
		<cfset tran = 'RQ'><cfset tranname = words[961]><cfset trancode = 'rqno'><cfset tranarun = 'rqarun'>
		<cfif getpin2.h28G1 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="QUO">
		<cfset tran = 'QUO'><cfset tranname = words[668]><cfset trancode = 'quono'><cfset tranarun = 'quoarun'>
		<cfif getpin2.h2871 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="SO">
		<cfset tran = 'SO'><cfset tranname = words[673]><cfset trancode = 'sono'><cfset tranarun = 'soarun'>
		<cfif getpin2.h2881 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
	<cfcase value="SAM">
		<cfset tran = "SAM"><cfset tranname = words[674]><cfset trancode = "samno"><cfset tranarun = "samarun">
		<cfif getpin2.h2851 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
    <cfcase value="SAMM">
		<cfset tran = "SAMM"><cfset tranname = "Sales Order"><cfset trancode = "sammno"><cfset tranarun = "sammarun">
		<cfif getpin2.h2851 eq 'T'><cfset alcreate = 1></cfif>
	</cfcase>
</cfswitch>

<cfif isdefined("form.invoicedate")>
	<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#form.invoicedate#" returnvariable="nDateCreate"/>
</cfif>

<cfif isdefined("form.transactiondate")>
	<cfif transactiondate neq ''>
    <cfset ndatecreatetran=createdate(right(form.transactiondate,4),mid(form.transactiondate,4,2),left(form.transactiondate,2))>
    <cfelse>
    <cfset ndatecreatetran=''>
    </cfif>
</cfif>

<cfif isdefined('form.type') and isdefined("form.remark12")> <!--- from first page --->
	<!--- Add On 12-01-2010 --->
	<cfif form.type eq 'Create' and isdefined('session.tran_refno')>
    <cfset newformname = "transpage"&form.newuuid>
    <cfif IsDefined("session.#newformname#") and session[#newformname#] eq "transpage">
    <cfset StructDelete(Session, "#newformname#")>
	<cfelse>
    <cfoutput>
    <h1>Duplicate Submission Detected. Please do not press back button.</h1>
    <cfabort />
    </cfoutput>
    </cfif>
		<cfquery name="checkexistrefno" datasource="#dts#">
			select * from artran where type='#tran#' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#session.tran_refno#">
		</cfquery>
		<cfif checkexistrefno.recordcount neq 0>
        	<cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset_location
				where type = '#tran#'
				and location = '#huserloc#'
            	and activate="T"
			</cfquery>
            <cfelse>
        	<cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#tran#'
				and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery>
            </cfif>
            <!---cust refno --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem2>
			</cfif>
            
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'RC' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_apvend# where custno ='#form.custno#'
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
	
	<cfif form.type eq 'Delete'>
		<cfif isdefined("form.keepDeleted")>	<!--- ADD ON 22-12-2009 --->
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
		<!--- UNUPDATE --->
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
					<cfif getitem.qty eq 0>
						<cfset itemqty = 0>
					<cfelse>
						<cfset itemqty = getitem.qty>
					</cfif>
					
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
						<cfset oldshipped = getship.shipped>

						<cfif tran eq 'PO' or tran eq 'SAM' or tran eq 'RQ'><!--- SO tp PO no minus shipped --->
							<cfset newshipped = oldshipped>
						<cfelse>
							<cfset newshipped = oldshipped - itemqty>
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
					
					<cfif frtype eq "QUO" and (tran eq "INV" or tran eq "DO" or tran eq "SO" or tran eq "CS")>
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

			<cfquery datasource='#dts#' name='deliclink'>
				delete from iclink where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
            
            
 <cfif getdefault.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         <cfquery name="getdeletedlist" datasource="#dts#">
         	SELECT itemno FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#"> and type = '#tran#' GROUP BY ITEMNO
         </cfquery>
		 </cfif>
        </cfif>
			<cfquery datasource='#dts#' name='deliclink'>
				delete from ictran where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
             <cfif getdefault.autolocbf eq "Y">
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
		
		<!--- <cfif lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "winbells_i" or lcase(HcomID) eq "iel_i"> --->
		<cftry>
			<cfquery datasource='#dts#' name='deleteartran_remark'>
				Delete from artran_remark where refno = '#form.currefno#' and type = '#tran#'
			</cfquery>
		<cfcatch type="any">
		</cfcatch>
		</cftry>	
		<!--- </cfif> --->
		
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
			#createdatetime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))#,
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
        
        <cfif lcase(hcomid) eq "baronad_i">
        <cfquery name="updatebaron" datasource="#dts#">
        	UPDATE baronspaceorder SET
            toinv=""
            where toinv=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currefno#">;
        </cfquery>
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
		<!--- DELETE AND UPDATE OBBATCH DETAIL --->
		<cfquery name="getallbatchitem" datasource="#dts#">
			select * from ictran where refno = '#form.currefno#' and type = '#tran#' and batchcode<>''
		</cfquery>
		<cfif tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM" and tran neq "RQ">
		<cfif getallbatchitem.recordcount gt 0>
			<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
				<cfset obtype = "bth_qin">
			<cfelse>
				<cfset obtype = "bth_qut">
			</cfif>

			<cfloop query="getallbatchitem">
				<cfquery name="updateobbatch" datasource="#dts#">
					update obbatch set #obtype#=(#obtype#-#getallbatchitem.qty#)
					where itemno='#getallbatchitem.itemno#' and batchcode='#getallbatchitem.batchcode#'
				</cfquery>

				<cfif getallbatchitem.location neq "">
					<cfquery name="updatelobthob" datasource="#dts#">
						update lobthob set #obtype#=(#obtype#-#getallbatchitem.qty#)
						where location='#getallbatchitem.location#' and itemno='#getallbatchitem.itemno#' and batchcode='#getallbatchitem.batchcode#'
					</cfquery>
				</cfif>
			</cfloop>
		</cfif>
        </cfif>
		<!--- END OF DELETE AND UPDATE OBBATCH DETAIL--->

		<cfquery name="getallitem" datasource="#dts#">
			select itemno,fperiod,qty from ictran where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>

		<cfif getallitem.recordcount gt 0>
			<cfif tran eq "OAI" or tran eq "RC" or tran eq "CN">
				<cfset qname = 'QIN'&(getallitem.fperiod+10)>
			<cfelse>
				<cfset qname = 'QOUT'&(getallitem.fperiod+10)>
			</cfif>

			<cfloop query="getallitem">
            	<cftry>
                    <cfquery name="UpdateIcitem" datasource="#dts#">
                        update icitem set #qname#=(#qname#-#getallitem.qty#) where itemno = '#getallitem.itemno#'
                    </cfquery>
                <cfcatch>
                </cfcatch>
                </cftry>
			</cfloop>
		</cfif>
        
        <cfif getdefault.autolocbf eq "Y">
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
        <cfif getdefault.autolocbf eq "Y">
         <cfif tran eq "RC" or tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "CN" or tran eq "DN" >
         	<cfloop query="getdeletedlist">
		 	<cfquery name="insertdelete" datasource="#dts#">
            INSERT INTO locationitempro (itemno) 
            VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeletedlist.itemno#">)
            </cfquery>
            </cfloop>
		 </cfif>
        </cfif>
        
            <cfquery name="getgeneral" datasource="#dts#">
            SELECT autolocbf FROM gsetup
            </cfquery>
            <cfif getgeneral.autolocbf eq "Y">
            
            
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
		<cfset hmode = "Edit">
		<!--- Calculate the period --->
		<cfquery datasource='#dts#' name="getGeneralInfo">
			Select * from GSetup
		</cfquery>

		<cfset lastaccyear = dateformat(getGeneralInfo.lastaccyear, 'dd/mm/yyyy')>
		<cfset period=getGeneralInfo.period>
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
        
        <!--- Add On 061008, For View Audit Trail --->

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
			('#tran#','#form.currefno#','#getar.custno#','#getar.fperiod#',#getar.wos_date#,'#getar.desp#','#getar.despa#',
			<cfswitch expression="#tran#">
				<cfcase value="RC,CN,OAI" delimiters=",">
					'#getar.CREDITAMT#'
				</cfcase>
				<cfdefaultcase>
				'#getar.DEBITAMT#'
				</cfdefaultcase>
			</cfswitch>,
			#createdatetime(year(getar.trdatetime),month(getar.trdatetime),day(getar.trdatetime),hour(getar.trdatetime),minute(getar.trdatetime),second(getar.trdatetime))#,
			'#getar.userid#','','#getar.created_by#','#Huserid#',
			<cfif getar.created_on neq "">#createdatetime(year(getar.created_on),month(getar.created_on),day(getar.created_on),hour(getar.created_on),minute(getar.created_on),second(getar.created_on))#<cfelse>'0000-00-00'</cfif>,
			#now()#)
		</cfquery>
		<!--- Add On 061008, For View Audit Trail --->
        
        
        
        
		
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
                    	<cftry>
                            <cfquery name="UpdateIcitem" datasource="#dts#">
                                update icitem set 
                                #qname_old#=(#qname_old#-#geticitem.qty#),
                                #qname_new#=(#qname_new#+#geticitem.qty#)
                                where itemno='#geticitem.itemno#'
                            </cfquery>
                    	<cfcatch>
                        </cfcatch>
                        </cftry>        
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
		<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">
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
        <!---
        <cfif lcase(hcomid) eq "yimloong_i" and (tran eq "INV" or tran eq "CS") and huserid eq "ultralung">
        <cfinclude template = "/latest/customization/yimloong_i/createtradeinbill.cfm">
        </cfif>
        --->
		<cfquery datasource='#dts#' name='updateartran'>
			Update artran set refno2 = '#refno2#', wos_date = #ndatecreate#<!---, fperiod = '#numberformat(readperiod,"00")#'--->,
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
			comm3='#form.comm3#',comm4='#form.comm4#',<!---d_phone2='#form.d_phone2#',--->	van = '#form.driver#',phonea='#form.phonea#',e_mail='#form.e_mail#',postalcode='#form.postalcode#',d_postalcode='#form.d_postalcode#',b_gstno='#form.b_gstno#',d_gstno='#form.d_gstno#',
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
            ,returnbillno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returnbillno#">
            ,returnreason=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returnreason#">
            ,returndate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returndate#">
            
			where refno = '#form.currefno#' and type = '#tran#'
		</cfquery>
		
        <cfif getgsetup.addonremark eq 'Y' or (getgsetup.bcurr eq 'MYR' and (tran eq "CN" or tran eq "DN"))>
        <cfinclude template="tran2updateaddonremark.cfm">
        </cfif>
        <cfif getgsetup.multiagent eq 'Y'>
        <cfinclude template="multiagentupdate.cfm">
        </cfif>
        
		 <cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">
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
		<!--- <cfquery datasource='#dts#' name='updateictran'>
			update ictran set wos_date = #ndatecreate#, fperiod = '#numberformat(readperiod,"00")#',
			currrate = '#currrate#', custno = '#form.custno#',name = '#form.name#',
			agenno = '#form.agenno#', userid='#Huserid#' where refno = '#form.currefno#' and type = '#tran#'
		</cfquery> --->
        <cfif isdefined("form.itemrate")>
			<cfquery name="getic" datasource="#dts#">
				select * from ictran where refno = '#form.currefno#' and type = '#tran#' AND currrate<>'#currrate#' order by itemcount
				
            </cfquery>

			<cfloop query="getic">
				<cfset xprice = price_bil * form.currrate>
				<cfset xamt1 = amt1_bil * form.currrate>
				<cfset xdisamt = disamt_bil * form.currrate>
				<cfset xtaxamt = taxamt_bil * form.currrate>
				<cfset xamt = amt_bil * form.currrate>
				<cfset xamt = numberformat(xamt,".__")>

				<cfquery datasource='#dts#' name='updateictran'>
					update ictran set currrate = '#currrate#', price = '#xprice#',
					amt1 = '#xamt1#', disamt = '#xdisamt#', taxamt = '#xtaxamt#',
					amt = '#xamt#'
					where refno = '#form.currefno#' and type = '#tran#' and itemcount = '#itemcount#' and itemno='#itemno#'
				</cfquery>
			</cfloop>
		</cfif>
        
		<cfquery datasource='#dts#' name='updateictran'>
			update ictran 
			set wos_date = #ndatecreate#, <!---fperiod = '#numberformat(readperiod,"00")#',--->
			currrate = '#currrate#', custno = '#form.custno#',name = '#form.name#',
			agenno = '#form.agenno#' 
			<cfif getGeneralInfo.projectbybill eq "1">
				,source = '#form.source#', job = '#form.job#' 
                <cfelseif getGeneralInfo.jobbyitem eq "Y">
                ,source = '#form.source#'
			</cfif>
            <cfif lcase(hcomid) eq "amgworld_i" and tran eq "RC">
            ,trdatetime = #ndatecreate#
            </cfif>
			<!--- REMARK ON 06-08-2009 --->
			<!--- <cfif lcase(husergrpid) neq "super">, userid='#Huserid#'</cfif> --->
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
		
		
		<cfset nexttranno = form.currefno>
		<!--- ADD ON 10-12-2009 --->
        <!---
		<cftry>
		<cfif isdefined("form.submit1") and form.submit1 eq "  Save  ">
			<cfif getGeneralInfo.printoption eq "1">
				<cflocation url="transaction3c.cfm?tran=#tran#&nexttranno=#nexttranno#">
			<cfelse>
		
			<cfoutput>
				<form name="done" action="transaction.cfm?tran=#tran#" method="post">
				</form>
			</cfoutput>
			<script>
				<cfoutput>window.open('../../billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#nexttranno#');</cfoutput>
				done.submit();
			</script>
			</cfif>	
			<cfabort>
		</cfif>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#:::#cfcatch.Detail#</cfoutput><cfabort>
		</cfcatch>
		</cftry>---->
		<!--- Readperiod will be inserted into the period in the database. --->
		<!--- End of Read period --->
	<cfelseif form.type eq 'Create'>
		<cfset hmode = "Create">
		
		<cfif HcomID eq "pnp_i">
			<cfif isdefined("form.invset")>
				<!--- <cfquery datasource="main" name="getGeneralInfo">
					select lastUsedNo as tranno, refnoused as arun from refnoset
					where userDept = '#dts#'
					and type = '#tran#'
					and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
				</cfquery> --->
				
				<cfquery datasource="#dts#" name="getGeneralInfo">
					select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                    from refnoset
					where type = '#tran#'
					and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
				</cfquery>
			<cfelse>
				<cfinclude template="../../pnp/get_target_refno.cfm">
			</cfif>
		<cfelse>
			<!---cfquery datasource="#dts#" name="getGeneralInfo">
				select 
				#trancode# as tranno, 
				#tranarun# as arun, 
				invoneset 
				from GSetup
			</cfquery--->
			<!--- <cfquery datasource="main" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun from refnoset
				where userDept = '#dts#'
				and type = '#tran#'
				and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery> --->
            <cfif followlocationrefno eq 1>
                <cfquery datasource="#dts#" name="getGeneralInfo">
                    select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                    from refnoset_location
                    where type = '#tran#'
                    and location = '#huserloc#'
                    and activate="T"
                </cfquery>
            <cfelse>
                <cfquery datasource="#dts#" name="getGeneralInfo">
                    select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                    from refnoset
                    where type = '#tran#'
                    and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
                </cfquery>
            </cfif>
            <!---cust refno --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_arcust# where custno ='#form.custno#'
  			</cfquery>
			<cfset getGeneralInfo.tranno=getcustrefno.arrem2>
			</cfif>
            
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'RC' and getcustprefixno.arrem2 neq "">
  			<cfquery name="getcustrefno" datasource="#dts#">
			select arrem2 from #target_apvend# where custno ='#form.custno#'
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
		</cfif>
		
		<!--- <cfquery datasource='#dts#' name='getGeneralInfo'>
			Select #trancode# as tranno, #tranarun# as arun, invoneset from GSetup
  		</cfquery> --->

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
			<!--- <cfif lcase(HcomID) eq "mhsl_i" and tran eq "INV"> --->
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
				<cfset nexttranno = actual_nexttranno&listgetat(form.invoicedate,2,'/')&right(listgetat(form.invoicedate,3,'/'),2)>
			<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
				<cfset nexttranno = newnextNum>	
            <cfelse>
<!--- 				<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" /> --->
        		<cfset actual_nexttranno = nexttranno>
               
                <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
                    <cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
                <cfelse>
                <cfif (getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "") or (getgsetup.prefixbycustquo eq 'Y' and tran eq 'RC' and getcustprefixno.arrem2 neq "") or (getgsetup.prefixbycustso eq 'Y' and tran eq 'SO' and getcustprefixno.arrem3 neq "") or (getgsetup.prefixbycustinv eq 'Y' and tran eq 'INV' and getcustprefixno.arrem4 neq "")>
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
		
		<cfif HcomID eq "pnp_i">
			<cfif isdefined("form.invset")>
				<!--- <cfquery name="updategsetup" datasource="main">
					update refnoset set 
					lastUsedNo=UPPER('#nexttranno#')
					where userDept = '#dts#'
					and type = '#tran#'
					and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
				</cfquery> --->
				
				<cfquery name="updategsetup" datasource="#dts#">
					update refnoset set 
					lastUsedNo=UPPER('#nexttranno#')
					where type = '#tran#'
					and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
				</cfquery>
			<cfelse>
				<cfinclude template="../../pnp/update_target_refno.cfm">
			</cfif>
		<cfelse>
			<!---cfquery name="updategsetup" datasource="#dts#">
				update Gsetup set 
				#trancode#=UPPER('#nexttranno#');
			</cfquery--->
			<!--- <cfquery name="updategsetup" datasource="main">
				update refnoset set 
				lastUsedNo=UPPER('#nexttranno#')
				where userDept = '#dts#'
				and type = '#tran#'
				and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery> --->
			
			<!--- <cfquery name="updategsetup" datasource="#dts#">
				update refnoset set 
				lastUsedNo=UPPER('#nexttranno#')
				where type = '#tran#'
				and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
			</cfquery> --->
			
			<!--- MODIFIED ON 19-12-2008 --->
            <cfif getgsetup.prefixbycustquo eq 'Y' and tran eq 'QUO' and getcustprefixno.arrem2 neq "">
             <!---cust refno --->
            <cfquery name="getcustrefno" datasource="#dts#">
			update #target_arcust# set arrem2=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif> where custno ='#form.custno#'
  			</cfquery>
             <cfelseif getgsetup.prefixbycustquo eq 'Y' and tran eq 'RC' and getcustprefixno.arrem2 neq "">
             <!---cust refno --->
            <cfquery name="getcustrefno" datasource="#dts#">
			update #target_apvend# set arrem2=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif> where custno ='#form.custno#'
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
            
            <cfif followlocationrefno eq 1>
                <cfquery datasource="#dts#" name="getGeneralInfo">
                    update refnoset_location set 
                    lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                    where type = '#tran#'
                    and location = '#huserloc#'
                </cfquery>
            <cfelse>
            
                <cfquery name="updategsetup" datasource="#dts#">
                    update refnoset set 
                    lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                    where type = '#tran#'
                    and counter =  <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
                </cfquery>
            </cfif>
            

			</cfif>
           
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
		<cfquery datasource='#dts#' name='getGeneralInfo'>
			Select * from GSetup
		</cfquery>

		<cfset lastaccyear = dateformat(getGeneralInfo.lastaccyear, 'dd/mm/yyyy')>
		<cfset period = getGeneralInfo.period>
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

		<!--- Readperiod will be inserted into the period in the database. --->
		<!--- End of Read period --->
		
<!--- 		<cfif hcomid eq "pnp_i">
			<!--- Default TAX Inceluded Setting --->
			<cfinclude template="transaction_body_setting_checking/default_tax_included_setting.cfm">
			<!--- Default TAX Inceluded Setting --->
		<cfelse>
			<cfset form.taxincl = "">
		</cfif> --->
        
		<cfset form.taxincl = "">
        <cfif getgsetup.taxincluded eq 'Y'>
        <cfset form.taxincl = "T">
        </cfif>
        <!---
        <cfif isdefined('getGeneralInfo.ngstcustautotax')>
        <cfif getGeneralInfo.ngstcustautotax eq '1'>--->
        
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
        <!---
        </cfif>
        </cfif>--->

		<!--- ADD ON 17-08-2009 --->
		<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">
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
		<!--- <cfif lcase(hcomid) eq "net_i">
			<cfset dnote = 'STAX'>
		<cfelseif lcase(hcomid) eq "lioncity_i" or lcase(hcomid) eq "ugateway_i">
			<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
				<cfset dnote = 'PTAX'>
			<cfelseif tran eq "CS" or tran eq 'INV' or tran eq 'DO' or tran eq 'QUO' or tran eq 'SO'>
				<cfset dnote = 'STAX'>
			<cfelse>
				<cfset dnote = ''>
			</cfif>
		<cfelseif lcase(hcomid) eq "iaf_i">
			<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
				<cfset dnote = 'TX7'>
			<cfelse>
				<cfset dnote = 'SR'>
			</cfif>
		<cfelse>
			<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
				<cfset dnote = ''>
			<cfelse>
				<cfset dnote = 'STAX'>
			</cfif>
		</cfif> --->

		<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
			<cfset dnote=getGeneralInfo.df_purchasetax>
		<cfelse>
			<cfset dnote=getGeneralInfo.df_salestax>
		</cfif>
        
        <!--- --->
		<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
        <cfquery name="getnongstcusttaxcode" datasource="#dts#">
            select taxcode,ngst_cust from #target_apvend# where custno='#form.custno#'
        </cfquery>
        <cfelse>
        <cfquery name="getnongstcusttaxcode" datasource="#dts#">
            select taxcode,ngst_cust from #target_arcust# where custno='#form.custno#'
        </cfquery>
        </cfif>
        
        <cfif getnongstcusttaxcode.ngst_cust eq "T">
            <cfset dnote=getnongstcusttaxcode.taxcode>
        </cfif>
        <!--- --->
        
        <cfif lcase(hcomid) eq "yimloong_i" and (tran eq "INV" or tran eq "CS")>
        <cfinclude template = "/latest/customization/yimloong_i/createtradeinbill.cfm">
        </cfif>
        
        <cfif form.name eq "">
        
        <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
        <cfquery name="getcustname" datasource="#dts#">
        SELECT name from #target_apvend# where custno = '#form.custno#'
        </cfquery>
        <cfelse>
        <cfquery name="getcustname" datasource="#dts#">
        SELECT name from #target_arcust# where custno = '#form.custno#'
        </cfquery>
		</cfif>
        
        <cfset form.name=getcustname.name>
        </cfif>
        
        <cftry>
            <cfquery datasource='#dts#' name='insertartran'>
                Insert into artran (type,refno,refno2,custno,desp,despa,fperiod,wos_date,agenno,currrate,
                term,source,job,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,permitno,rem12,
                rem13,rem14,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm1,comm2,comm3,comm4,d_phone2,d_email,phonea,E_mail,
                postalcode,d_postalcode,b_gstno,d_gstno,country,d_country,
                name,toinv,exported,van,trdatetime,userid,username,currcode,comm0,taxincl,created_by,created_on,updated_by,updated_on,note
                <cfif getgsetup.addonremark eq 'Y' or (getgsetup.bcurr eq 'MYR' and (tran eq "CN" or tran eq "DN"))>
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
                ,returnbillno
                ,returnreason
                ,returndate
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
                '#form.comm4#', '#form.d_phone2#','#form.d_email#','#form.phonea#','#form.e_mail#',
                '#form.postalcode#','#form.d_postalcode#','#form.b_gstno#','#form.d_gstno#','#form.country#','#form.d_country#',
                
				'#form.name#','','','#form.driver#','#nowDatetime#', '#HUserID#', '#getusername.username#','#listfirst(form.refno3)#','#form.comm0#',
                '#form.taxincl#','#HUserID#',#now()#,'#HUserID#',#now()#,'#dnote#'
                <cfif getgsetup.addonremark eq 'Y' or (getgsetup.bcurr eq 'MYR' and (tran eq "CN" or tran eq "DN"))>
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
                ,<cfif nDateCreatetran eq ''>'0000-00-00'<cfelse>#nDatecreatetran#</cfif>
                </cfif>
                <cfif (lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i") and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>
                ,'T'
                ,'#val(gettaxinclcust.arrem1)#'
                </cfif>
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returnbillno#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returnreason#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.returndate#">
                )
            </cfquery>
            <cfif getgsetup.soautocreaproj eq 'Y' and tran eq "SO">
            <cfquery datasource='#dts#' name='insertnewproject'>
            insert into #target_project# (source,project,porj) values ('#nexttranno#','#nexttranno#','P')
            </cfquery>
			</cfif>
            
        <cfif isdefined('getGeneralInfo.appDisSupCus')>
        <cfif getGeneralInfo.appDisSupCus eq "Y" and tran neq "CN" or tran neq "DN">
        <cfif getGeneralInfo.appDisSupCusitem neq "Y">
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
		
		<cfif lcase(HcomID) eq "avent_i" or lcase(hcomid) eq "techpak_i" or lcase(hcomid) eq "techpakasia_i" or lcase(hcomid) eq "techpakbill_i">
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

<!--- <cfset nextinvno= 'INV00021'> --->
<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
	<cfquery name='getcust' datasource='#dts#'>
		select name,arrem1 from #target_apvend# where custno = '#custno#'
	</cfquery>
	<cfset ptype = words[104]>
<cfelse>
	<cfquery name='getcust' datasource='#dts#'>
		select name,arrem1 from #target_arcust# where custno = '#custno#'
	</cfquery>
	<cfset ptype = words[5]>
</cfif>

<cfif lcase(hcomid) neq "steel_i">
	<cfquery name='getitem' datasource='#dts#'>
		SELECT itemno, 
		<cfif lcase(hcomid) eq "sdc_i">
        	fcurrcode as desp
		<cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        	concat(aitemno,' ------',desp) as desp
		<cfelseif lcase(hcomid) eq "uniq_i" >
        	concat(IFNULL(desp,''),IFNULL(despa,''))
        <cfelse>
        	desp as desp
        </cfif> 
        FROM icitem 
        where (nonstkitem<>'T' or nonstkitem is null) 
        <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
        <cfelse>
		<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
                    and (itemtype = "P" or itemtype = "" or itemtype is null or itemtype = "SV")
					<cfelse>
                    and (itemtype = "S" or itemtype = "" or itemtype is null or itemtype = "SV")
		</cfif>
        </cfif>
        <cfif lcase(hcomid) eq "keminates_i" and (tran eq "PO" or tran eq "PR" or tran eq "RC")>
        and (supp="#custno#" or supp="")
        </cfif>
        <cfif Hitemgroup neq ''>
        and wos_group='#Hitemgroup#'
        </cfif>
        <cfif lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i">
                    and wos_group = (SELECT coalesce(agent,'') from <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>#target_apvend#<cfelse>#target_arcust#</cfif> WHERE custno = "#custno#")
					</cfif>
		order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
	</cfquery>
</cfif>

<cfquery name='getservice' datasource='#dts#'>
	select servi, desp from icservi order by servi
</cfquery>
<!--- Control The Decimal Point --->
<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,DECL_TOTALAMT as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfset stDecl_UPrice=getgsetup2.Decl_Uprice>
<cfset stDecl_Disc=getgsetup2.DECL_DISCOUNT1>

<cfquery name='getgeneralinfo' datasource='#dts#'>
	select gst,filteritem,filterall, 
	invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset, multilocation,wpitemtax,wpitemtax1,EAPT,voucher,filteritemAJAX,voucherbal,asvoucher,voucherb4disc
	from gsetup
</cfquery>

<cfset multilocation = "">
<cfif getGeneralInfo.multilocation neq "">
	<cfif ListFindNoCase(getgeneralinfo.multilocation, tran, ",") neq 0>
		<cfset multilocation = "Y">
	</cfif>
</cfif>

<!--- ADD ON 30-07-2009 --->
<cfset wpitemtax="">
<cfif getGeneralInfo.wpitemtax eq "1">
	<cfif getGeneralInfo.wpitemtax1 neq "">
    	<cfif ListFindNoCase(getgeneralinfo.wpitemtax1, tran, ",") neq 0>
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

<cfif multilocation neq "Y">
	<cfquery name='getictran' datasource='#dts#'>
		select * from ictran where refno='#nexttranno#' and type='#tran#' and (void = '' or void is null) <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
				
				order by length(brem3),brem3<cfelse>order by itemcount</cfif>
				
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
		and (void = '' or void is null)
		group by itemno,desp,despa,custno,price_bil,grade,linecode,note_a
		
		union
		
		select qty_bil,amt_bil,qty,amt1_bil,TAXAMT_BIL,
		itemno,desp,despa,custno,price_bil,grade,linecode,itemcount,batchcode,note_a,GLTRADAC,UNIT_BIL,source,job,taxincl,location,brem1,brem2,brem3,brem4
		from ictran 
		where refno='#nexttranno#' 
		and type='#tran#' 
		and linecode = 'SV'
		and (void = '' or void is null)
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



<html>
<head>
	<title><cfoutput>#tranname#</cfoutput></title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type='text/javascript' src='../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../ajax/core/settings.js'></script>
</head>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>

<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript" src="/scripts/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="/scripts/highslide/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="/scripts/highslide/highslide.css" />
<script type="text/javascript">
//<![CDATA[
hs.registerOverlay({
	html: '<div class="closebutton" onclick="return hs.close(this)" title="Close"></div>',
	position: 'top right',
	fade: 2 // fading the semi-transparent overlay looks bad in IE
});


hs.graphicsDir = '/scripts/highslide/graphics/';
hs.wrapperClassName = 'borderless';
//]]>
</script>

<script language="javascript" type="text/javascript">
function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
	function updateitemno(itemno,itemdesp){
			myoption = document.createElement("OPTION");
			myoption.text = itemno + " - " + itemdesp;
			myoption.value = itemno;
			document.getElementById("itemno").options.add(myoption);
			var indexvalue = document.getElementById("itemno").length-1;
			document.getElementById("itemno").selectedIndex=indexvalue;
		}
	
function getItemNew()
{
	if(trim(document.getElementById('letter').value) !='')
	{
	<cfif (lcase(hcomid) eq "hyray_i")>
		document.form.submit2.disabled=true;
	</cfif>
	<cfoutput>
	var ajaxurl = '/default/transaction/databind/act_getitem.cfm?new=1&searchtype='+document.getElementById('searchtype').value + '&text=' + escape(encodeURI(document.getElementById('letter').value))+ "&tran=" + document.form.tran.value+"&supp=#custno#";
	</cfoutput>	 
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('getitemnew').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
			try{
			showImage(document.getElementById('itemno').value);
			}
			catch(err)
			{
			}
		 <cfif (lcase(hcomid) eq "hyray_i")>
		document.form.submit2.disabled=false;
		</cfif>
        }
      })	  
	}
}

	
	function calculatedeposit()
	{
	if(document.getElementById('depositno').options[document.getElementById('depositno').selectedIndex].value !="")
	{
	<!---deposit--->
	document.getElementById('deposit').value=(document.getElementById('depositno').options[document.getElementById('depositno').selectedIndex].title*1).toFixed(2);
	}
	else
	{
		
	}
	}

function showpic(picname)
		{
		return hs.expand(picname)
		}

function checkdate(fieldid)
	{
		re = /^(\d{1,2})\/(\d{1,2})$/;
	
	if(document.getElementById(fieldid).value != '') {
      if(regs = document.getElementById(fieldid).value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 12) {
          alert("Invalid value for Month: " + regs[1]);
          document.getElementById(fieldid).focus();
        }
      } else {
        alert("Invalid date format: " + document.getElementById(fieldid).value);
        document.getElementById(fieldid).focus();
      }
	}
	}
	
	function change_picture(itemno)
	{
		var encode_itemno = encodeURI(itemno);
		show_picture.location="transaction3_image.cfm?itemno="+encode_itemno;
	}


<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
function trim1 (str) {
				var	str = str.replace(/^\s\s*/, ''),
					ws = /\s/,
					i = str.length;
				while (ws.test(str.charAt(--i)));
				return str.slice(0, i + 1);
			}
			
	function getselectadd(event)
	{
	var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			if(keyCode==13){
			
			var getitemnostring = document.getElementById('itemselect').value;
			
			var itemnofield = document.getElementById('itemno');
				var mySplitResult = getitemnostring.split("    ");
				var spliresult = trim1(mySplitResult[3]);
				splitresult = spliresult.toLowerCase();
				for (var idx=0;idx<itemnofield.options.length;idx++) 
				{
					if (spliresult==trim(itemnofield.options[idx].value).toLowerCase()) 
					{
						itemnofield.options[idx].selected=true;
						releaseDirtyFlag();
						form.submit();
						return true;
						
					}
				}
			
			return false;}
			return true;
	}
</cfif>

	function settaxcode()
	{
	<cfoutput>
	var tran='#tran#'
	</cfoutput>
	if(tran=='PO'||tran=='PR'||tran=='RC'||tran=='RQ' ){
	if(document.getElementById('pTax').value==0)
	{
	<cfoutput>
	for (var idx=0;idx<document.getElementById('selecttax').options.length;idx++) 
		{
			if ('#getgsetup.df_purchasetaxzero#'==document.getElementById('selecttax').options[idx].value) 
			{
				document.getElementById('selecttax').options[idx].selected=true;
				
			}
		}
	</cfoutput>
	}
	}
	else{
	if(document.getElementById('pTax').value==0)
	{
	<cfoutput>
	for (var idx=0;idx<document.getElementById('selecttax').options.length;idx++) 
		{
			if ('#getgsetup.df_salestaxzero#'==document.getElementById('selecttax').options[idx].value) 
			{
				document.getElementById('selecttax').options[idx].selected=true;
				
			}
		}
	</cfoutput>
	}
	}
	}

	function updateVal()
	{
	var validdesp = document.getElementById('desphid').value;
	
	var droplist = document.getElementById('expunit');
	
	  while (droplist.length > 0)
	  {
		  droplist.remove(droplist.length - 1);
	  }

	
	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('btn_add').value = "Item No Existed";
	document.getElementById('btn_add').disabled = true; 
	}
	else
	{
	var commaSeparatedValueList = document.getElementById('unithid').value;
	var valueArray = commaSeparatedValueList.split(",");
	for(var i=0; i<valueArray.length; i++){
		var opt = document.createElement("option");
        document.getElementById("expunit").options.add(opt);  
        opt.text = valueArray[i];
        opt.value = valueArray[i];

	}
	document.getElementById('desp').value = document.getElementById('desphid').value;
	document.getElementById('expunit').selectedIndex =0;
	document.getElementById('expprice').value = document.getElementById('pricehid').value;
	document.getElementById('expdespa').value = document.getElementById('despahid').value;
	document.getElementById('expcomment').value = document.getElementById('commenthid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	}
	
	function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  break;
      }
    if(document.getElementById(textid).value==''){
      output[0].selected=true;
      }
  }
}
	
	function caldisamt()
	{
	var qtydis = document.getElementById('expqtycount').value;
	var disamt = document.getElementById('expunitdis').value;
	qtydis = qtydis * 1;
	disamt = disamt * 1;
	var totaldiscount = qtydis * disamt;
	document.getElementById('expdis').value = totaldiscount.toFixed(2);
	}
	<cfoutput>
	var fixnum=#getgsetup2.Decl_UPrice1#;
	var fixnumdisc=#getgsetup2.DECL_DISCOUNT#;
	var default_gst=#val(getGeneralInfo.gst)#;
	var hcomid='#lcase(hcomid)#';	
	var tran='#tran#';	
	var wpitemtax='#wpitemtax#';
	</cfoutput>
	function init()
	{
		<cfif isdefined ('url.complete') or type eq 'Edit'>
		getDiscountControl();
		getDepositCount();
		getCashCount();
		getChequeCount();
		getCredit_Card1Count();
		getCredit_Card2Count();
		getGift_VoucherCount();
		</cfif>
		<cfif hcomid eq "pnp_i">
			document.getElementById("cash").select();
		</cfif>
		<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
document.getElementById('itemselect').focus();
</cfif>				
	}
	
	function assignvoucher(vcode,vvalue,vtype)
	{
	<cfif getgsetup.voucherasdisc eq 'Y'>
	var billgrand1 = document.getElementById('subtotal').value * 1;
	var billgrand = document.getElementById('viewNet').value * 1;
	<cfelse>
	var billgrand1 = document.getElementById('subtotal').value * 1;
	var billgrand = document.getElementById('viewGrand').value * 1;
	</cfif>
	<cfif getgsetup.voucherasdisc eq 'Y'>
	if(vtype == "Value")
	{
	vvalue = vvalue * 1;
	<cfif getgeneralinfo.voucherbal eq "Y">
	
	if (vvalue > 0)
	{
	document.getElementById('totalamtdisc_id').readOnly=true;
	}
	else
	{
	document.getElementById('totalamtdisc_id').readOnly=false;
	}
	</cfif>
	if (vvalue >=<cfif getgeneralinfo.voucherb4disc eq "Y">billgrand1<cfelse>billgrand</cfif>)
	{
	document.getElementById('totalamtdisc_id').value = billgrand;
	}
	else
	{
	<cfif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i") and tran neq "CN">
	document.getElementById('gift_voucher').readOnly=false;
	alert('Voucher Value is Not Enough');
	document.getElementById('vouchernum').selectedIndex = 0;
	return false;
	</cfif>
	document.getElementById('totalamtdisc_id').value = vvalue.toFixed(2);
	}
	}
	else
	{
	var totalamount = document.getElementById('viewGrand').value;
	var totalvouc = (vvalue/100) * totalamount;
	<cfif getgeneralinfo.voucherbal eq "Y">
	if (totalvouc > 0)
	{
	document.getElementById('totalamtdisc_id').readOnly=true;
	}
	else
	{
	document.getElementById('totalamtdisc_id').readOnly=false;
	}
	</cfif>
	if (totalvouc >= <cfif getgeneralinfo.voucherb4disc eq "Y">billgrand1<cfelse>billgrand</cfif>)
	{
	document.getElementById('totalamtdisc_id').value = billgrand;
	}
	else
	{
	document.getElementById('totalamtdisc_id').value = totalvouc.toFixed(2);
	}
	}
	getDiscountControl();
	<cfelse>
	if(vtype == "Value")
	{
	vvalue = vvalue * 1;
	<cfif getgeneralinfo.voucherbal eq "Y">
	if (vvalue > 0)
	{
	document.getElementById('gift_voucher').readOnly=true;
	}
	else
	{
	document.getElementById('gift_voucher').readOnly=false;
	}
	</cfif>
	if (vvalue >=<cfif getgeneralinfo.voucherb4disc eq "Y">billgrand1<cfelse>billgrand</cfif>)
	{
	document.getElementById('gift_voucher').value = billgrand;
	}
	else
	{
	<cfif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i") and tran neq "CN">
	document.getElementById('gift_voucher').readOnly=false;
	alert('Voucher Value is Not Enough');
	document.getElementById('vouchernum').selectedIndex = 0;
	return false;
	</cfif>
	document.getElementById('gift_voucher').value = vvalue.toFixed(2);
	}
	}
	else
	{
	var totalamount = document.getElementById('viewGrand').value;
	var totalvouc = (vvalue/100) * totalamount;
	<cfif getgeneralinfo.voucherbal eq "Y">
	if (totalvouc > 0)
	{
	document.getElementById('gift_voucher').readOnly=true;
	}
	else
	{
	document.getElementById('gift_voucher').readOnly=false;
	}
	</cfif>
	if (totalvouc >= <cfif getgeneralinfo.voucherb4disc eq "Y">billgrand1<cfelse>billgrand</cfif>)
	{
	document.getElementById('gift_voucher').value = billgrand;
	}
	else
	{
	document.getElementById('gift_voucher').value = totalvouc.toFixed(2);
	}
	}
	getGift_VoucherCount();
	/*var disamt = document.getElementById('totalamtdisc_id').value * 1;
	var voucamt = document.getElementById('gift_voucher').value * 1;
	document.getElementById('totalamtdisc_id').value = disamt + voucamt;
	getDiscountControl();*/
	</cfif>
	}
	
	function getItem(){
		<cfif (lcase(hcomid) eq "hyray_i")>
		document.form.submit2.disabled=true;
		</cfif>
		var text = document.form.letter.value;
		var w = document.form.searchtype.selectedIndex;
		var searchtype = document.form.searchtype.options[w].value;
		if(text != ''){
			
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text+"&supp=#custno#";
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
		<cfif (lcase(hcomid) eq "hyray_i")>
		document.form.submit2.disabled=false;
		</cfif>
	}
	
	function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("itemno");
		newArray = unescape(rset.fields("itemnolist").value);
		var itemnoArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("itemdesclist").value);
		var itemdescArray = newArray2.split(";;");
		
		for(i=0;i<itemnoArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(itemnoArray[i] == '-1'){
				myoption.text = itemdescArray[i];
			}else{
				myoption.text = itemnoArray[i] + " - " + itemdescArray[i];
			}
			
			myoption.value = itemnoArray[i];
			document.form.itemno.options.add(myoption);
		}
		//Add On 30-12-2009
		if(document.getElementById("itemno").value !='' && document.getElementById("itemno").value !='-1'){
			showImage(document.getElementById("itemno").value);
		}
	}
	
	function getProduct(){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_tranflocation, null, 'productlookup', inputtext, getProductResult);
	}

	function getProductResult(itemArray){
		DWRUtil.removeAllOptions("itemno");
		DWRUtil.addOptions("itemno", itemArray,"KEY", "VALUE");
	}
	
	function getService(servi,servidesp){
		myoption = document.createElement("OPTION");
		myoption.text = servi + " - " + servidesp;
		myoption.value = servi;
		document.form.service.options.add(myoption);
		var indexvalue = document.getElementById("service").length-1;
		document.getElementById("service").selectedIndex=indexvalue;
	}
	
	function check_witempertax(){
		if(wpitemtax == 'Y'){
			if(document.getElementById("taxincl").checked==true){
				var taxincl='T';
			}else{
				var taxincl='F';
			}
			
			var tran=document.form.tran.value;
			var refno=document.form.nexttranno.value;
			DWREngine._execute(_tranflocation, null, 'updatetax', tran, refno, taxincl, getTaxResult);
		}
	}
	
	function getTaxResult(taxObject){
		var taxamt=parseFloat(taxObject.TTAXAMT_BIL);
		DWRUtil.setValue("totalamttax", taxamt);
		check_taxincls();
	}
	
	//function showImage: Add On 30-12-2009
	function showImage(thisitemno){
		if(thisitemno=='' || thisitemno=='-1'){
			var newHTML ="";
		}else{
			var newHTML = "&nbsp;| <a href='view_image.cfm?itemno="+escape(thisitemno)+"' target='_blank'>IMAGE</a>";
		}
		document.getElementById("itemimages").innerHTML=newHTML;
	}
	
	function assignDisc(){
		checkboxObj=document.getElementById("assigndisc");
		checkboxObj.checked =false;
		var tran=document.form.tran.value;
		var refno=document.form.nexttranno.value;
		var opt = 'Width=500px, Height=350px, Top=200px, left=400px scrollbars=no, status=no';
		<cfoutput>window.open('dsp_assignDisc.cfm?type=' + tran + '&refno=' + refno, 'discwindow',opt);</cfoutput>
	}
	
	function getfocus()
	{	
	setTimeout("document.getElementById('price_bil1').focus();",1000);
	}
	
	function getfocus2()
	{	
	setTimeout("document.getElementById('taxamt_bil1').focus();",1000);
	}
	
	function updaterow(rowno)
	{
		var brem3 = 'displaylist'+rowno;
		var reftype = document.getElementById('tran').value;
		var refno = document.getElementById('nexttranno').value;
		var brem3data = document.getElementById(brem3).value;
		var updateurl = 'shellupdaterow.cfm?refno='+escape(refno)+'&type='+escape(reftype)+'&trancode='+rowno+'&brem3='+escape(brem3data);
		
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('shellupdaterowajax').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Item'); },		
		
		onComplete: function(transport){
		alert('Complete')
        }
      })
		
	}
	
	function addmultiitem()
	{
	var itemlisting='';
	<cfoutput>
	
	for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
	if (document.getElementById('additem_'+k).checked == true)
	{
	var itemlisting=itemlisting+"&servicecode"+k+"="+document.getElementById('additem_'+k).value+"&qty"+k+"="+document.getElementById('additemqty_'+k).value;
	
	}
	}
	}
	
	var tran = trim(document.getElementById('tran').value);
	
	var refno = trim(document.getElementById('nexttranno').value);
	
	var custno = trim(document.getElementById('custno').value);
	
	var ajaxurl2 = '/default/transaction/products/addmultiproductsAjax.cfm?tran='+escape(tran)+'&tranno='+refno+'&custno='+escape(custno)+itemlisting;
	
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		clearformadvance();
        }
      })
	</cfoutput>
	}
	
	function selectlist(textid,fieldid) {
  var input=textid.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  break;
      }
  }
}
	
	function itemcheckbox(itemno,itembox,matrixitemno)
	{
		
		var itemprice=document.getElementById('matrixaddprice_'+matrixitemno).value;
		
		if (itembox.checked == true)
		{
			var actionpick = 'add';	
			document.getElementById('additemqty_'+itemno).style.display="block";
		}	  
		else 
		{	
			var actionpick = 'delete';	
			document.getElementById('additemqty_'+itemno).style.display="none";	
		}
			var updateurl = 'matrixpickitemlist.cfm?action='+actionpick+'&uuid='+escape(document.getElementById('matrixpickitemuuid').value)+'&itemno='+escape(itembox.value)+'&price='+escape(itemprice);
				new Ajax.Request(updateurl,
			  {
				method:'get',
				onSuccess: function(getdetailback){
				document.getElementById('pickitemlist').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
				alert('Error Pick Item'); },		
				
				onComplete: function(transport){
				}
			  })
	}
	
	function addmatrixmultiitem()
	{
	var itemlisting=document.getElementById('matrixpickitemuuid').value;
	<cfoutput>
	var tran = trim(document.getElementById('tran').value);
	var refno = trim(document.getElementById('nexttranno').value);
	var custno = trim(document.getElementById('custno').value);
	var ajaxurl2 = '/default/transaction/matrixsearchitem/addmultiproductsAjax.cfm?tran='+escape(tran)+'&tranno='+refno+'&custno='+escape(custno)+'&itemlisting='+itemlisting;
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('matrixaddmultiitem').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Add Item'); },		
		
		onComplete: function(transport){
		releaseDirtyFlag();
		submitinvoice();
        }
      })
	</cfoutput>
	}
	
	function matrixupdateqty(itemno,qty){
	var itemlisting=document.getElementById('matrixpickitemuuid').value;
	
	var ajaxurl2 = 'matrixpickitemlist.cfm?action=edit&itemno='+escape(itemno)+'&qty='+qty+'&uuid='+itemlisting;
	new Ajax.Request(ajaxurl2,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('pickitemlist').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Qty'); },		
		
		onComplete: function(transport){
        }
      })
		
	}
	
	
</script>

<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_deposit.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_cash.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_cheque.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_credit_card1.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_credit_card2.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_debit_card.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_voucher.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_tax_included.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/transaction_footer_calculation_telegraph_transfer.js"></script>

<cfif HcomID eq "bhl_i">
	<script language="javascript" type="text/javascript" src="/bhl/auto_fill_discount.js"></script>
</cfif>

<body <cfif hmode eq 'Create'>onLoad="init();"</cfif>>
<cfoutput>
	<br>
<!--- Add Items Button --->
<cfform name='form' id="form" action='transaction4.cfm?type1=Add&ndatecreate=#ndatecreate#&itemcount=0&multilocation=#multilocation#' method='post' onSubmit="releaseDirtyFlag();return validateAddItem();return false;">
    <input type='hidden' name='tran' id="tran" value='#listfirst(tran)#'>
    <input type='hidden' name='currrate' id="currrate" value='#listfirst(currrate)#'>
    <input type='hidden' name='agenno' id="agenno" value='#listfirst(agenno)#'>
    <input type='hidden' name='refno3' value='#listfirst(refno3)#'>
    <input type="hidden" name="hidtrancode" id="hidtrancode" value="">
    <input type='hidden' name='nexttranno' id="nexttranno" value='#listfirst(nexttranno)#'>
	<input type='hidden' name='hmode' id="hmode" value='#listfirst(hmode)#'>
    <input type='hidden' name='custno' id="custno" value='#listfirst(custno)#'>
    <input type='hidden' name='readperiod' value='#listfirst(readperiod)#'>
    <input type='hidden' name='nDateCreate' value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
    <input type='hidden' name='nDateNow' value='#dateformat(now(),'dd/mm/yyyy')#'>
    <input type='hidden' name='invoicedate' id="invoicedate" value='#dateformat(listfirst(invoicedate),'dd/mm/yyyy')#'>
	
	<cfif checkcustom.customcompany eq "Y">
		<input type="hidden" name="remark5" value="#listfirst(remark5)#">	<!--- PERMIT NUMBER, ADD ON 24-03-2009 --->
		<input type="hidden" name="remark6" value="#listfirst(remark6)#">
	</cfif>

	<cfif isdefined("form.updunitcost")><input type='hidden' name='updunitcost' value='#form.updunitcost#'></cfif>
	<div id="shellupdaterowajax"></div>
	<table width='85%' align='center' class='data' cellspacing="0">
    <tr>
		<th rowspan="2" nowrap width="18%">#tranname# #words[58]#</th>
		<td rowspan="2" nowrap width="20%"><h3>#nexttranno#</h3></td>
		<th nowrap width="15%">#tranname# #words[702]#</th>
		<td nowrap>#invoicedate#</td>
        
	</tr>
	 <tr>
		<th nowrap width="15%">#words[1292]#</th>
		<td nowrap><select name="newtrancode"><cfloop from="#newtrancode#" to="1" index="i" step="-1"><option value="#i#">#i#</option></cfloop></select></td>
	</tr>
	<tr>
		<th nowrap>#ptype#</th>
		<td nowrap>#custno# - #getcust.name#</td>
        <th>#words[1692]#</th>
        <td><cfquery name="getrefno2record" datasource="#dts#">select refno2 from artran where refno='#nexttranno#' and type='#tran#'</cfquery>#getrefno2record.refno2#</td>
	</tr>
    <cfif getdisplaysetup2.f_crlimit eq 'Y'>
    <tr>
    <th nowrap>#words[69]#</th>
    
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
							where accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">  and fperiod <> '99'
							group by accno
						) 
					,0) 
                    
                    +
                    ifnull(
						(
							select 
							ifnull(lastybal,0)
							from #replacenocase(dts,"_i","_a","all")#.gldata 
							where accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
							group by accno
						) 
					,0) 
                    <cfelse>
                    0
                    </cfif>
				) as credit_balance;
			</cfquery>
    
    <td>#numberformat(get_dealer_menu_info.credit_limit,',_.__')#</td>
    <th nowrap>#words[1198]#</th>
    <td>#numberformat(get_dealer_menu_info.credit_balance,',_.__')#</td>
    </tr>
    </cfif>
    <tr>
      	<td colspan="4"><hr></td>
   	</tr>
    <tr>
    	<th nowrap height="30">#words[120]#</th>
      	<td width='60%' colspan="3" nowrap>
            <cfquery name="getgsetup10" datasource="#dts#">
	select ddlitem from gsetup
      </cfquery>
		<cfif lcase(hcomid) eq "steel_i" >
			<select id="itemno" name='itemno'></select> #words[1241]#:
			<input id="letter" name="letter" type="text" size="8" onKeyUp="getItem('0')"> in:
			<select id="searchtype" name="searchtype" onChange="resetLetter()">
				<cfloop list="itemno,mitemno,desp,category,wos_group,brand,sizeid,colorid" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp =#getgsetup.litemno#>
                <cfelseif #i# eq "mitemno">
                <cfset sitemdesp =#getgsetup.laitemno#>
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
                <cfelseif #i# eq "category">
                <cfset sitemdesp ="Category">
                <cfelseif #i# eq "wos_group">
                <cfset sitemdesp ="Group">
                <cfelseif #i# eq "brand">
                <cfset sitemdesp ="Brand">
                <cfelseif #i# eq "sizeid">
                <cfset sitemdesp =getgsetup.lsize>
                <cfelseif #i# eq "colorid">
                <cfset sitemdesp =getgsetup.lmaterial>
                </cfif>
                <option value="#i#" <cfif #sitemdesp# eq #getrefnolen.ddlitem#>selected</cfif>>#sitemdesp#</option>
                </cfloop>
			</select>
			<select id="itemno2" name='itemno2'>
              <option value='-1'>Choose an Item</option>
              <cfloop query='getitem'>
                <option value="#convertquote(itemno)#">#itemno# - #desp#</option>
              </cfloop>
            </select>
			<input type='submit' name='submit2' value='#words[1109]#'>
		<cfelseif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i" or lcase(hcomid) eq "pnp_i" >
        <select id="itemno" name='itemno'>
				<option value='-1'>Choose an Item</option>
				<cfloop query='getitem'>
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
           		</cfloop>
       		</select>
		<cfif getgeneralinfo.filterall eq "1">
					<input type="text" name="searchitemto" onKeyUp="getProduct();" size="10">
			</cfif>
			<input type='submit' name='submit2' value='#words[1109]#'>
		<cfelse>
			<cfif getgeneralinfo.filteritem eq "1">
            <div id="getitemnew" style="display:inline">
            
				<select id="itemno" name='itemno' onChange="showImage(this.value);change_picture(this.value);">
					<option value='-1'>Please Filter The Item</option>
				</select></div> #words[1241]#:
				<input id="letter" name="letter" type="text" size="8" onKeyup="getItemNew();" onBlur="change_picture(document.getElementById('itemno').value);"> in:
             
				<select id="searchtype" name="searchtype" onChange="getItemNew()">
                    <cfloop list="itemno,aitemno,desp,despa,category,wos_group,brand,sizeid,colorid" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp =#getgsetup.litemno#>
                <cfelseif #i# eq "aitemno">
                <cfset sitemdesp =#getgsetup.laitemno#>
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
                <cfelseif i eq "despa">
                <cfset sitemdesp ="Description 2">
                <cfelseif #i# eq "category">
                <cfset sitemdesp ="Category">
                <cfelseif #i# eq "wos_group">
                <cfset sitemdesp ="Group">
                <cfelseif #i# eq "brand">
                <cfset sitemdesp ="Brand">
                <cfelseif #i# eq "sizeid">
                <cfset sitemdesp =getgsetup.lsize>
                <cfelseif #i# eq "colorid">
                <cfset sitemdesp =getgsetup.lmaterial>
                </cfif>
                <option value="#i#" <cfif #sitemdesp# eq #getgsetup10.ddlitem#>selected</cfif>>#sitemdesp#</option>
                </cfloop>
				</select>
				<input type='submit' name='submit2' value='#words[1109]#'>
                
                
                <cfif multilocation neq "Y">
                <cfif lcase(HcomID) neq "ascend_i">
                <input type="button" value="#words[2162]#" name="ExpressBtn" onClick="javascript:ColdFusion.Window.show('expressproduct');">
				</cfif>
                </cfif>
                <cfif multilocation neq "Y" and tran eq 'SO' and getgsetup.projectcompany eq 'Y'>
                <input type="button" value="#words[148]#" name="MatBtn" onClick="javascript:ColdFusion.Window.show('matproduct');">
				</cfif>
			<cfelse>
            <cfif getgeneralinfo.filteritemAJAX eq "1" >
            <cfif isdefined("url.itemno1")>
            <cfset selecteditemno = url.itemno1>
			<cfelse>
            <cfset selecteditemno = "">
			</cfif>
            <cfquery name='getitemlist' datasource='#dts#'>
                    SELECT "Choose an Item" as itemdesp, "-1" as itemno," " as despa,'' as desp
                    union all
                    select concat(itemno," - ",desp) as itemdesp, itemno,despa,desp from icitem 
                    where (nonstkitem<>'T' or nonstkitem is null)
                    <cfif lcase(hcomid) eq "lkabb_i" or lcase(hcomid) eq "lkabp_i" or lcase(hcomid) eq "lkab_i" or lcase(hcomid) eq "lkatlb_i"
				or lcase(hcomid) eq "lkatbh_i" or lcase(hcomid) eq "svcmm_i" or lcase(hcomid) eq "svcnvn_i" or lcase(hcomid) eq "svctm_i"
				or lcase(hcomid) eq "svcyr_i" or lcase(hcomid) eq "svcdm_i" or lcase(hcomid) eq "svcbd_i" or lcase(hcomid) eq "21bl_i"
				or lcase(hcomid) eq "21cmw_i" or lcase(hcomid) eq "jvtpy_i" or lcase(hcomid) eq "jvsbw_i" or lcase(hcomid) eq "stbrd_i"
				or lcase(hcomid) eq "stpylb_i" or lcase(hcomid) eq "stfsrg_i" or lcase(hcomid) eq "stfsk_i" or lcase(hcomid) eq "ftmps_i"
				or lcase(hcomid) eq "lkabt_i" or lcase(hcomid) eq "lkatb_i" or lcase(hcomid) eq "lkatl_i" or lcase(hcomid) eq "shell_i"
				or lcase(hcomid) eq "fttk_i" or lcase(hcomid) eq "svcnc_i" or lcase(hcomid) eq "autoserv_i">
                	<cfelse>
                    <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
                    and (itemtype = "P" or itemtype = "" or itemtype is null or itemtype = "SV")
					<cfelse>
                    and (itemtype = "S" or itemtype = "" or itemtype is null or itemtype = "SV")
					</cfif>
                    </cfif>
                    <cfif Hitemgroup neq ''>
                    and wos_group='#Hitemgroup#'
                    </cfif>
					<cfif lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i">
                    and wos_group = (SELECT coalesce(agent,'') from <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>#target_apvend#<cfelse>#target_arcust#</cfif> WHERE custno = "#custno#")
					</cfif>
                    order by <cfif getdealer_menu.productSortBy eq "desp">desp<cfelse>itemno</cfif>
                    </cfquery>
            
            <cfselect name="itemno" id="itemno" onChange="showImage(this.value);change_picture(this.value);" bindonload="yes" query="getitemlist" display="itemdesp" value="itemno" selected="#URLDECODE(selecteditemno)#" />
            <cfelse>
				<select id="itemno" name='itemno' onChange="showImage(this.value);change_picture(this.value);">
       				<option value='-1'>Choose an Item</option>
					<cfloop query='getitem'><option value="#convertquote(itemno)#" <cfif isdefined("url.itemno1") and getitem.itemno eq url.itemno1>selected</cfif>><cfif lcase(hcomid) eq "mhca_i">#desp# - #itemno#<cfelse>#itemno# - #desp#</cfif></option>
           			</cfloop>
       			</select>
             </cfif>
             <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
            <input type="text" name="itemnoselect" id="itemselect" value="" onKeyPress="return getselectadd(event)">
			</cfif>
				<input type='submit' name='submit2' value='#words[1109]#'>
                <cfif multilocation neq "Y">
                <cfif lcase(HcomID) neq "ascend_i">
                <input type="button" value="#words[2162]#" name="ExpressBtn" onClick="javascript:ColdFusion.Window.show('expressproduct');">
				</cfif>
                </cfif>
				<cfif multilocation neq "Y" and tran eq 'SO' and getgsetup.projectcompany eq 'Y'>
                <input type="button" value="#words[148]#" name="MatBtn" onClick="javascript:ColdFusion.Window.show('matproduct');">
				</cfif>
				<!--- <a href='tranitemsearch.cfm?tran=#tran#&stype=#tran#&hmode=#hmode#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>SEARCH</a>&nbsp;|&nbsp;
            	<a href='historysearch.cfm?tran=#tran#&hmode=#hmode#&stype=#tran#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>HISTORY</a> --->
				<cfif checkcustom.customcompany eq "Y">
					<!--- ADD PERMIT NUMBER, ADD ON 24-03-2009 --->
					<a  onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('searchitem');">AS</a>&nbsp;&nbsp;|<a onClick="releaseDirtyFlag();"  href='tranitemsearch.cfm?tran=#tran#&stype=#tran#&hmode=#hmode#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#&remark5=#URLEncodedFormat(listfirst(remark5))#&remark6=#URLEncodedFormat(listfirst(remark6))#'>#words[11]#</a>&nbsp;|&nbsp;<a  onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('historyitem');">HS</a>&nbsp;|&nbsp;
	            	<a onClick="releaseDirtyFlag();" href='historysearch.cfm?tran=#tran#&hmode=#hmode#&stype=#tran#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#&remark5=#URLEncodedFormat(listfirst(remark5))#&remark6=#URLEncodedFormat(listfirst(remark6))#'>#words[2163]#</a>
				<cfelse>
                
					<a  onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('searchitem');">AS</a>
                    &nbsp;&nbsp;|
                    <cfif lcase(hcomid) eq "newapparel_i">&nbsp;<input type="button" name="matrixsearchitembtn" id="matrixsearchitembtn" value="Matrix Add" onClick="javascript:ColdFusion.Window.show('matrixsearchitem');">&nbsp;&nbsp;|</cfif>
					<cfif getmodule.auto eq '1'>&nbsp;<input type="button" name="searchitembtn" id="searchitembtn" value="#words[11]#" onClick="releaseDirtyFlag();window.location.href=('tranitemsearch.cfm?tran=#tran#&stype=#tran#&hmode=#hmode#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#')" >
              <cfelse><a onClick="releaseDirtyFlag();" href='tranitemsearch.cfm?tran=#tran#&stype=#tran#&hmode=#hmode#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>#words[11]#</a>
              </cfif>&nbsp;|&nbsp;<a  onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('historyitem');">HS</a>&nbsp;|&nbsp;
	            	<a onClick="releaseDirtyFlag();" href='historysearch.cfm?tran=#tran#&hmode=#hmode#&stype=#tran#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>#words[2163]#</a>
				</cfif>
			</cfif>
			
			<!--- REMARK ON 100608 AND REPLACE WITH THE UPPER ONE, LET THE USER CAN FILTER THE ITEM --->
			<!---select id="itemno" name='itemno'>
       			<option value='-1'>Choose an Item</option>
				<cfloop query='getitem'><option value='#itemno#' <cfif isdefined("url.itemno1") and getitem.itemno eq url.itemno1>selected</cfif>>#itemno# - #desp#</option>
           		</cfloop>
       		</select>
			<input type='submit' name='submit2' value='Add Item'>

			<a href='tranitemsearch.cfm?tran=#tran#&stype=#tran#&hmode=#hmode#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>SEARCH</a>&nbsp;|&nbsp;
            <a href='historysearch.cfm?tran=#tran#&hmode=#hmode#&stype=#tran#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(listfirst(custno))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&readperiod=#readperiod#&ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&refno3=#URLEncodedFormat(listfirst(refno3))#&agenno=#URLEncodedFormat(listfirst(agenno))#'>#words[2163]#</a--->
		</cfif>
        <!---
		<cfif lcase(hcomid) eq "nikbra_i">
			| <a href="/customized/#dts#/upload_excel.cfm?tran=#tran#&refno=#nexttranno#&custno=#form.custno#&currrate=#currrate#">UPLOAD EXCEL</a>
		</cfif>--->
		<!--- Add On 30-12-2009 --->
		<!---<label id="itemimages"><cfif isdefined("url.itemno1")>&nbsp;| <a href="view_image.cfm?itemno=#url.itemno1#" target="_blank">IMAGE</a></cfif></label>--->	
        <cfif getpin2.h1310 eq 'T' and getgsetup.grpinitem neq "Y">&nbsp;&nbsp;|&nbsp;&nbsp;<a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('/default/maintenance/icitem2.cfm?type=Create&express=2');">#words[124]#</a></cfif>
        	</td>
    </tr>
    <tr>
    
      	<th nowrap height="30" ><cfif getdisplaysetup2.f_service eq "Y">#words[294]#</cfif></th>  
        <td colspan="3" nowrap >
         <cfif getdisplaysetup2.f_service neq "Y"> <div style="visibility:hidden"></cfif>
        
		<select name='service'>
        	<option value=''>#words[1831]#</option>
          	<cfloop query='getservice'>
				<cfif getservice.servi eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#servi#'>#servi# - #desp#</option>
				</cfif>
          	</cfloop>
		</select>
		<input type='submit' name='submit22' value='#words[293]#'>
        <cfif isdefined ('url.complete') or type eq 'Edit'>
        
        <input type="button" name="expressservice" value="#words[2162]#" onClick="javascript:ColdFusion.Window.show('expressservice');" >
		</cfif>
        

		<cfif getpin2.h1G10 eq 'T'>
			<a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('createservice');">Create New Service</a>
            
            <cfif getdisplaysetup2.f_service neq "Y"> </div></cfif>        
		</cfif>
        &nbsp;&nbsp;<cfif lcase(HcomID) neq "ascend_i">|</cfif>&nbsp;&nbsp;
       
        <!--- imiqgroup --->
        <cfif lcase(hcomid) eq "imiqgroup_i" or lcase(hcomid) eq "intelquip_i">
		<a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.show('clientinvoice');"><b>Project Employee Records</b></a>&nbsp;&nbsp;|
		</cfif>
        <!--- imiqgroup ---> 
        <!---<a onClick="releaseDirtyFlag()" href="/default/transaction/tran_edit2.cfm?tran=#tran#&ttype=Edit&refno=#nexttranno#&custno=#custno#&first=0"><b>Edit Detail Information</b></a>--->
        
        &nbsp;&nbsp;<cfif lcase(HcomID) neq "ascend_i">|</cfif>&nbsp;&nbsp;
 <cfif lcase(HcomID) neq "ascend_i">
<a style="cursor:pointer;" onClick="window.open('uploadfile.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Upload Document</b></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('import_tranexcel.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item</b></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('itembody.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Export Item</b></a></cfif>
        <cfif (lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "gramas_i" or lcase(hcomid) eq "belco_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "demo_i"  or lcase(hcomid) eq "supporttest_i" or lcase(hcomid) eq "hanyuan_ong_i") and tran eq 'INV'>
		&nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('aiplimportbody/import_tranexcelINV.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item INV</b>
        <cfelseif (lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "gramas_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "belco_i" or lcase(hcomid) eq "demo_i"  or lcase(hcomid) eq "supporttest_i" or lcase(hcomid) eq "hanyuan_ong_i") and (tran eq 'RC' or tran eq 'PR')>
        &nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('aiplimportbody/import_tranexcelRC.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item RC</b>
        <cfelseif (lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "gramas_i" or lcase(hcomid) eq "belco_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "demo_i"  or lcase(hcomid) eq "supporttest_i" or lcase(hcomid) eq "hanyuan_ong_i") and (tran eq 'CN' or tran eq 'DN')>
        &nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('aiplimportbody/import_tranexcelCN.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item CN/DN</b>
        <cfelseif (lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "gramas_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "belco_i" or lcase(hcomid) eq "demo_i"  or lcase(hcomid) eq "supporttest_i" or lcase(hcomid) eq "hanyuan_ong_i") and tran eq 'SAM'>
        <!---
        &nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('aiplimportbody/import_tranexcelSAM.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item SAM</b>--->
        &nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('aiplimportbody/import_tranexcelSO.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item SAM</b>
        </cfif>
        <cfif (lcase(HcomID) eq "asaiki_i" or lcase(hcomid) eq "supporttest_i") and tran eq 'RC'>
        &nbsp;&nbsp;|&nbsp;&nbsp;<a style="cursor:pointer;" onClick="window.open('asaikiimportbody/import_tranexcelRC.cfm?refno=#URLENCODEDFORMAT(nexttranno)#&type=#tran#','UploadDocument','width=600, height=500, status=yes, menubar=no, location=no, scrollbars=yes')"><b>Import Item ASAIKI</b>
        </cfif>
        </td>
    </tr>
  	</table>
</cfform>
<script type="text/javascript">


<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
	function copygrandtocash()
	{
	if(document.getElementById("checkcash").checked == true)
	{
	document.getElementById("cash").value=document.getElementById("viewGrand").value;
	}
	else{
	document.getElementById("cash").value='0.00';
	}
	
	getCashCount();
	}
	
	function copygrandtocheq()
	{
	if(document.getElementById("checkcheq").checked == true)
	{
	document.getElementById("cheque").value=document.getElementById("viewGrand").value;
	}
	else{
	document.getElementById("cheque").value='0.00';
	}
	getChequeCount();
	}
</cfif>	

function selectitem(itemChoose)
{
itemChoose = unescape(itemChoose);

for (var idx=0;idx<document.getElementById('itemno').options.length;idx++) {
        if (itemChoose==document.getElementById('itemno').options[idx].value) {
            document.getElementById('itemno').options[idx].selected=true;
        }
    } 

}
function trim(strval)
{
return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
}

function checkexpress(addType)
{

var expressservice=trim(document.getElementById('expressservicelist').value);
var desp = trim(document.getElementById('desp').value);

if (addType == "Products")
{
var expressamt = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
}
else
{
var expressamt = trim(document.getElementById('expressamt').value);
}
var intvalid = true;
if (addType == "Products")
{
try
{
expressamt = expressamt * 1;
expprice = expprice * 1;
}
catch(err)
{
intvalid = false;
}
}
var msg = "";

if (expressservice == "")
{
if (addType == "Products")
{
msg = msg + "-Please select a product\n";
}
else
{
msg = msg + "-Please select a service\n";
}
}
if ( desp == "")
{
msg = msg + "-Description field is required\n";
}

if (addType == "Products")
{
if ( expressamt == "" || expressamt <= 0 )
{
msg = msg + "-Quantity field is required\n";
}
if ( expprice == "" || expprice <= 0 )
{
msg = msg + "-Price field is required\n";
}
if (intvalid == false)
{
msg = msg + "-Price or quantity field is invalid\n";
}

else
{
if ( expressamt == "")
{
msg = msg + "-Amount field is required\n";
}
}
}

if (expressservice == "" || desp == "" || expressamt == "" || intvalid == false)
{
alert(msg);
return false;
}

}

function setdespprice()
{
document.getElementById('desp').value = document.getElementById('desphid').value;
document.getElementById('expprice').value = document.getElementById('pricehid').value;
}

function calamt()
{
var expqty = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
expqty = expqty * 1;
expprice = expprice * 1;
var itemamt = expqty * expprice;
document.getElementById('expressamt').value =  itemamt.toFixed(2);
}

function calamtadvance()
{
var expqty = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
var expdis = trim(document.getElementById('expdis').value);
expqty = expqty * 1;
expprice = expprice * 1;
expdis = expdis * 1;
var itemamt = (expqty * expprice) - expdis;
document.getElementById('expressamt').value =  itemamt.toFixed(2);
}

function addItem(addType)
{
if (addType == "Services")
{
var validatefield = checkexpress('Services');
}
else
{
var validatefield = checkexpress('Products');
}
if (validatefield == false)
{
}
else
{

var expressservice=trim(document.getElementById('expressservicelist').value);
var desp = encodeURI(trim(document.getElementById('desp').value));
var expressamt = trim(document.getElementById('expressamt').value);
var ajaxurl = '/default/transaction/services/addservicesAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&tran=#tran#&tranno=#nexttranno#&custno=#custno#';
if (addType == "Services")
{
ajaxFunction(document.getElementById('ajaxFieldSer'),ajaxurl);
}
if (addType == "Products")
{
var expqty = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
var location = encodeURI(trim(document.getElementById('location').value));

<cfquery name="check_compulsory_location_setting" datasource="#dts#">
	select 
	compulsory_location
	from transaction_menu;
</cfquery>

<cfif check_compulsory_location_setting.compulsory_location eq "Y">
	if(location=="")
	{
		alert("Please Select A Location !");
		document.getElementById("location").focus();
		return false;
	}
</cfif>
var ajaxurl = '/default/transaction/products/addproductsAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&expqty='+expqty+'&expprice='+expprice+'&tran=#tran#&tranno=#nexttranno#&custno=#custno#&location='+escape(location);
ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
}


clearform(addType);
}

}

function addmat(addType)
{
if (addType == "Services")
{
var validatefield = checkexpress('Services');
}
else
{
var validatefield = checkexpress('Products');
}
if (validatefield == false)
{
}
else
{

var expressservice=trim(document.getElementById('expressservicelist').value);
var desp = encodeURI(trim(document.getElementById('desp').value));
var expressamt = trim(document.getElementById('expressamt').value);
var ajaxurl = '/default/transaction/services/addservicesAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&tran=#tran#&tranno=#nexttranno#&custno=#custno#';
if (addType == "Services")
{
ajaxFunction(document.getElementById('ajaxFieldSer'),ajaxurl);
}
if (addType == "Products")
{
var expqty = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
var location = encodeURI(trim(document.getElementById('location').value));

<cfquery name="check_compulsory_location_setting" datasource="#dts#">
	select 
	compulsory_location
	from transaction_menu;
</cfquery>

<cfif check_compulsory_location_setting.compulsory_location eq "Y">
	if(location=="")
	{
		alert("Please Select A Location !");
		document.getElementById("location").focus();
		return false;
	}
</cfif>
var ajaxurl = '/default/transaction/material/addproductsAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&expqty='+expqty+'&expprice='+expprice+'&tran=#tran#&tranno=#nexttranno#&custno=#custno#&location='+escape(location);
ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
}


clearform(addType);
}

}

function addItemAdvance()
{
var validatefield = checkexpress('Products');

if (validatefield == false)
{
}
else
{
var expressservice=escape(trim(document.getElementById('expressservicelist').value));
var desp = escape(trim(document.getElementById('desp').value));
var expdespa = escape(trim(document.getElementById('expdespa').value));
var expressamt = trim(document.getElementById('expressamt').value);
var expqty = trim(document.getElementById('expqty').value);
var expprice = trim(document.getElementById('expprice').value);
var expcomment = escape(trim(document.getElementById('expcomment2').value));
var expunit = trim(document.getElementById('expunit').value);
var expdis = trim(document.getElementById('expdis').value);
var ajaxurl = '/default/transaction/advanceProduct/addproductsAjax.cfm?servicecode='+expressservice+'&desp='+desp+'&expressamt='+expressamt+'&expqty='+expqty+'&expprice='+expprice+'&comment='+expcomment+'&despa='+expdespa+'&unit='+expunit+'&dis='+expdis+'&tran=#tran#&tranno=#nexttranno#&custno=#custno#';
ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
clearformadvance();
}
}

function clearform(addType)
{
document.getElementById('expressservicelist').selectedIndex = 0;
document.getElementById('desp').value = '';
document.getElementById('expressamt').value = '0.00';
if (addType == "Products")
{
document.getElementById('expqty').value = '0';
document.getElementById('expprice').value = '0.00';
document.getElementById('location').selectedIndex = 0;
}
}

function clearformadvance()
{
document.getElementById('expressservicelist').value = '';
document.getElementById('desp').value = '';
document.getElementById('expressamt').value = '0.00';
document.getElementById('expqty').value = '1';
document.getElementById('expqtycount').value = '1';
document.getElementById('expprice').value = '0.00';
document.getElementById('expunit').value = '';
document.getElementById('expdis').value = '0.00';
document.getElementById('expunitdis').value = '0.00';
document.getElementById('expressservicelist').focus();
document.getElementById('expcomment').value = '';
document.getElementById('expcomment2').value = '';
}

function nextIndex(thisid,id)
{
var itemno = document.getElementById('expressservicelist').value;
if (thisid == 'expressservicelist' && itemno == '')
{
}
else
{
if(event.keyCode==13){
document.getElementById(''+id+'').focus();
document.getElementById(''+id+'').select();
}
}
}

function checkstring(strText)
{
var strReplaceAll = strText;
var intIndexOfMatch = strReplaceAll.indexOf( "%" );
 

// Loop over the string value replacing out each matching
// substring.
while (intIndexOfMatch != -1){
// Relace out the current instance.
strReplaceAll = strReplaceAll.replace( "%", "925925925925" )
 

// Get the index of any next matching substring.
intIndexOfMatch = strReplaceAll.indexOf( "%" );
}
return strReplaceAll;
}
</script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

</cfoutput>

<cfif isdefined ('url.complete') or type eq 'Edit'>


	<cfquery name='getartran' datasource='#dts#'>
		select * from artran where refno = '#nexttranno#' and type = '#tran#'
	</cfquery>

	<cfquery name='getictran2' datasource='#dts#'>
		select sum(amt_bil) as subtotal from ictran where refno = '#nexttranno#' and type = '#tran#' and (void = '' or void is null)
	</cfquery>

	<cfif getartran.recordcount gt 0>
		<cfif hmode eq 'Create' and wpitemtax neq "Y">
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
		  	<!--- <cfif wpitemtax neq "Y" and type neq 'Edit' and val(xtaxp1) neq 0> --->
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
	<!--- REMARK ON 23-11-2009 --->
	<!--- <cfif val(getartran.cs_pm_vouc) neq 0>
		<cfset xdebt=xdebt-val(getartran.cs_pm_vouc)>
    </cfif> --->
	<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq 'PO' or tran eq "RC" or tran eq "PR")>
		<cfif val(getartran.cs_pm_tt) neq 0>
			<cfset xdebt=xdebt-val(getartran.cs_pm_tt)>
		</cfif>
    </cfif>
		<!--- <cfset xnet=val(getartran.net_bil)>
		<cfset xgrand=val(getartran.grand_bil)> --->
		
		<!--- <cfif hmode eq 'Create' and wpitemtax neq "Y">
			<!--- Modified on 17-03-2009 --->
			<cfif lcase(hcomid) eq "net_i">
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
						<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
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
		</cfif> --->

		<!--- Modified on 17-11-2008 --->
		<!--- <cfif getartran.note neq ""><cfset xnote=getartran.note>
		<cfelse>
			<cfif getgeneralinfo.gst neq 0>
				<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'><cfset xnote = ''>
				<cfelse><cfset xnote = 'STAX'>
				</cfif>
			<cfelse>
				<cfset xnote = 'ZR'>
			</cfif>
		</cfif> --->
		<!--- MODIFIED ON 24-02-2009 --->
		<!--- <cfif lcase(hcomid) neq "ecraft_i">
			<cfif getartran.note neq "">
				<cfset xnote=getartran.note>
			<cfelse>
				<cfif getgeneralinfo.gst neq 0>
					<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
						<cfset xnote = ''>
					<cfelse>
						<cfset xnote = 'STAX'>
					</cfif>
				<cfelse>
					<cfset xnote = 'ZR'>
				</cfif>
			</cfif>
		<cfelse>
			<cfset xnote=getartran.note>
		</cfif> --->
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<cfset xnote=getartran.note>
		<cfelse>
			<cfif getartran.note neq "">
				<cfset xnote=getartran.note>
			<cfelse>
				<cfif getgeneralinfo.gst neq 0>
			  		<cfif hmode eq "Create">
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
	
	<cfif lcase(hcomid) eq "steel_i">
		<cfset mcList="Freight Insurance mc1:,Freight Charges mc2:,Marine Insurance mc3:,Packing mc4:,Inland Handling mc5:,mc6:,mc7:">
	<cfelse>
		<cfset mcList="Misc. Charges (1):,Misc. Charges (2):,Misc. Charges (3):,Misc. Charges (4):,Misc. Charges (5):,Misc. Charges (6):,Misc. Charges (7):">
	</cfif>
	<cfoutput>
	<form name='invoicesheet' action='transaction3b.cfm' method='post' onSubmit="releaseDirtyFlag();return permit();">
		<input type='hidden' name='currrate' value='#listfirst(currrate)#'>
  		<input type='hidden' name='tran' value='#listfirst(tran)#'>
 		<input type='hidden' name='nexttranno' value='#listfirst(nexttranno)#'>
    	<input type='hidden' name='custno' value='#listfirst(custno)#'>
		<input type="hidden" name='discformat' value="#stDecl_Disc#">
		<!--- Add on 250808 --->
		<input type="hidden" name='hmode' value="#hmode#">
        <input type="hidden" name='discountlimit' value="#getgsetup.disclimit#">
        
		<cfif isdefined("form.updunitcost")><input type='hidden' name='updunitcost' value='#form.updunitcost#'></cfif>
		<input name='frem9' type='hidden' value='#getartran.frem9#'>
        
        <br>
		<table width='95%' border="0" align='center' cellspacing="0">
		<tr>
			<td width="33%" nowrap align="left" <cfif getdisplaysetup2.f_misc_charg1 neq "Y">style="visibility:hidden"</cfif>>#words[1634]# :<input type="#hidestatus#" name="mc1_bil" id="mc1_bil" value="#numberformat(getartran.mc1_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td width="1%">&nbsp;</td>
			<td width="12%" colspan="3" rowspan="2" <cfif getdisplaysetup2.f_acc_code neq "Y">style="visibility:hidden"</cfif>><iframe id="show_picture" name="show_picture" frameborder="1" marginheight="0" marginwidth="0" align="middle" height="100" width="100" scrolling="no" src="icitem_image.cfm"></iframe><!---Special Account Code--->
            <input type="hidden" name="special_account_code"  value="#getartran.special_account_code#" maxlength="8" size="10" onClick="select();">
            <div style="display:none">
            <input type="radio" name="clear_all_special_account_code" value="yes" onClick="clear_special_account_code(this.value);">YES &nbsp;
			<input type="radio" name="clear_all_special_account_code" value="no" onClick="clear_special_account_code(this.value);" checked>NO
            </div>
            </td>
			<td width="10%" <cfif getdisplaysetup2.f_subtotal neq "Y">style="visibility:hidden"</cfif>>Sub Total</td>
			<td width="1%" <cfif getdisplaysetup2.f_subtotal neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td width="7%">&nbsp;</td>
			<td width="7%">&nbsp;</td>
			<td width="6%">&nbsp;</td>
			<td width="10%" <cfif getdisplaysetup2.f_subtotal neq "Y">style="visibility:hidden"</cfif>><input name='subtotal' id="subtotal" type='#hidestatus#' size='10' maxlength='15' value='#numberformat(getictran2.subtotal,'.__')#' style="background-color:##FFFF99" readonly></td>
		</tr>
        
		<cfif LCASE(HcomID) EQ 'demoindo_i' OR LCASE(HcomID) EQ 'scalenowindo_i'>
            <tr>
            	<td>&nbsp;</td>
            	<td>&nbsp;</td>
                <td>Tax PPH 23(%)</td>
                <td>:</td>
                <td>
                    <select name="indoTaxPPH23" id="indoTaxPPH23">
                        <option value="">Select PPH23 Tax Type</option>
                        <option value="2" <cfif getartran.indoTaxPPH23 EQ '2'>selected</cfif>>2 %</option>
                        <option value="4" <cfif getartran.indoTaxPPH23 EQ '4'>selected</cfif>>4 %</option>
                    </select>
                </td>
            </tr>    
        </cfif>
		<tr>
			<td align="left" <cfif getdisplaysetup2.f_misc_charg2 neq "Y">style="visibility:hidden"</cfif>>#words[1635]# :<input type="#hidestatus#" name="mc2_bil" id="mc2_bil" value="#numberformat(getartran.mc2_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
            <cfif LCASE(HcomID) EQ 'demoindo_i'>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            </cfif>
			<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>Discount (%)</td>
			<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>:</td>
			<cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">
				<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totaldisc1' type='#hidestatus#' size='4' maxlength='5' value='#xdisp1#' readonly> +</td> 
				<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totaldisc2' type='#hidestatus#' size='4' maxlength='5' value='#xdisp2#' readonly> +</td>
				<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totaldisc3' type='#hidestatus#' size='4' maxlength='5' value='#xdisp3#' readonly></td>
				<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totalamtdisc' id="totalamtdisc_id" type='#hidestatus#' size='10' maxlength='15' value='#xamtdisp1#' readonly></td>
			<cfelse>
				<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
					<cfquery name="getDisc" datasource="#dts#">
						select * from discounttable order by discount
					</cfquery>
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>
						<select name='totaldisc1' onChange="getDiscountControl2();">
							<option value="">-</option>
							<cfloop query="getDisc">
								<option value="#getDisc.discount#" <cfif getDisc.discount eq xdisp1>selected</cfif>>#getDisc.discount#</option>
							</cfloop>
						</select> +
					</td> 
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>
						<select name='totaldisc2' onChange="getDiscountControl2();">
							<option value="">-</option>
							<cfloop query="getDisc">
								<option value="#getDisc.discount#" <cfif getDisc.discount eq xdisp2>selected</cfif>>#getDisc.discount#</option>
							</cfloop>
						</select> +
					</td>
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>
						<select name='totaldisc3' onChange="getDiscountControl2();">
							<option value="">-</option>
							<cfloop query="getDisc">
								<option value="#getDisc.discount#" <cfif getDisc.discount eq xdisp3>selected</cfif>>#getDisc.discount#</option>
							</cfloop>
						</select>
					</td>
				<cfelse>
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totaldisc1' type='#hidestatus#' id="totaldisc1" size='4' maxlength='5' value='#xdisp1#' <cfif getgsetup.disp1limit neq 0>onKeyUp="if(document.getElementById('totaldisc1').value*1 >'#getgsetup.disp1limit#'){alert('Discount limit is over');document.getElementById('totaldisc1').value=0;getDiscountControl();};"<cfelse>onKeyUp="getDiscountControl();"</cfif> > +</td> 
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>>
                    <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>
                    <input type="hidden" id="discountpasswordcontrol" name="discountpasswordcontrol" value="0">
                    </cfif>
                    <input name='totaldisc2' type='#hidestatus#' id="totaldisc2" size='4' maxlength='5' value='#xdisp2#' <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>onFocus="if (document.getElementById('discountpasswordcontrol').value==0){ColdFusion.Window.show('discountpassword');document.getElementById('totaldisc1').focus();}"</cfif> onKeyUp="getDiscountControl();"> +</td>
					<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totaldisc3' type='#hidestatus#' id="totaldisc3" size='4' maxlength='5' value='#xdisp3#' <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>onFocus="if (document.getElementById('discountpasswordcontrol').value==0){ColdFusion.Window.show('discountpassword');document.getElementById('totaldisc1').focus();}"</cfif> onKeyUp="getDiscountControl();"></td>
				</cfif>
	
                	<td <cfif getdisplaysetup2.f_discount neq "Y">style="visibility:hidden"</cfif>><input name='totalamtdisc' id="totalamtdisc_id" type='#hidestatus#' size='10' maxlength='15' value='#xamtdisp1#' <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
               
			</cfif>
		</tr>
        <tr <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "demoindo_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i"><cfelse>style="display:none"</cfif>>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>Rebate</td>
        <td>:</td>
        <td><input <cfif rebateaftertax eq 'T'>style="visibility:hidden"</cfif> name='rebateafterdiscper' id='rebateafterdiscper' type='text' size='10' value='#rebateafterdiscper#' <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>> %</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>	
        <td><input <cfif rebateaftertax eq 'T'>style="visibility:hidden"</cfif> name='rebateafterdiscamt' id='rebateafterdiscamt' type='text' size='10' value='#rebateafterdiscamt#' readonly></td>	
        </tr>
		<tr>
		  <td align="left" <cfif getdisplaysetup2.f_misc_charg3 neq "Y">style="visibility:hidden"</cfif>>#words[1636]# :<input type="#hidestatus#" name="mc3_bil" id="mc3_bil" value="#numberformat(getartran.mc3_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
            <td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_net neq "Y">style="visibility:hidden"</cfif>>Net</td>
			<td <cfif getdisplaysetup2.f_net neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>	
			<td <cfif getdisplaysetup2.f_net neq "Y">style="visibility:hidden"</cfif>><input name='viewNet' id='viewNet' type='#hidestatus#' size='10' value='#xnet#' style="background-color:##FFFF99" readonly></td>
		</tr>
		<tr>
			<td  align="left" <cfif getdisplaysetup2.f_misc_charg4 neq "Y">style="visibility:hidden"</cfif>>#words[1637]# :<input type="#hidestatus#" name="mc4_bil" id="mc4_bil" value="#numberformat(getartran.mc4_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
			<td colspan="3" <cfif lcase(HcomID) eq "visionlaw_i" or lcase(HcomID) eq "sdc_i" or lcase(HcomID) eq "ascend_i">style="visibility:hidden"</cfif>><div align="center" style="color:##FF0000; font-size:13px;"><b>#words[1627]#</b></div></td>
			<td <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>>
			<cfif getgsetup.ngstcustdisabletax eq "1">
            	<cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
            	<cfquery name="getnongstcust" datasource="#dts#">
            	select NGST_CUST,taxcode from #target_apvend# where custno='#custno#'
            	</cfquery>
           		<cfelse>
            	<cfquery name="getnongstcust" datasource="#dts#">
            	select NGST_CUST,taxcode from #target_arcust# where custno='#custno#'
            	</cfquery>
            	</cfif>
                
					<cfif getnongstcust.NGST_CUST eq 'T'>
            		
            		<cfelse>
                    Tax (%)
            		</cfif>
            
			<cfelse>Tax (%)</cfif></td>
			<td <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td align="right" colspan="2" <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>>
                <cfif wpitemtax eq "Y">
                <select name="selecttax" id="selecttax" style="visibility:hidden">
                <option value="#xnote#"></option>
                </select>
                    <input type="hidden" name="wpitemtax" id="wpitemtax" value="Y">
				<cfelse>
					<!--- REMARK ON 08-10-2009 --->
                    <!--- <select name="selecttax" onChange="getTaxControl();">
                        <cfif lcase(hcomid) eq "efrozenfood_i" and tran eq "INV">
		                    <option value="EX"<cfif xnote eq "EX">selected</cfif>>Exempted</option>
	                        <option value="STAX"<cfif xnote eq "STAX">selected</cfif>>STAX</option>
	                        <option value="ZR"<cfif xnote eq "ZR">selected</cfif>>Zero Rated</option>
						<cfelse>
	                        <option value="XGST" <cfif xnote eq "XGST">selected</cfif>>X-GST</option>
	                        <cfif lcase(hcomid) eq "efrozenfood_i" and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')>
		                        <option value="PTAX"<cfif xnote eq "PTAX">selected</cfif>>PTAX</option>
							<cfelse>
			                    <option value="EX"<cfif xnote eq "EX">selected</cfif>>Exempted</option>
								<option value="OS"<cfif xnote eq "OS">selected</cfif>>Out of Scope</option>
		                        <option value="STAX"<cfif xnote eq "STAX">selected</cfif>>STAX</option>
		                        <option value="PTAX"<cfif xnote eq "PTAX">selected</cfif>>PTAX</option>
		                        <option value="ZR"<cfif xnote eq "ZR">selected</cfif>>ZR</option>
		                        <cfif tran eq "RC" or tran eq "PR">
		                        	<option value="MES"<cfif xnote eq "MES">selected</cfif>>MES</option>
		                        </cfif>
		                        <cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
		                            <option value="PTAXS"<cfif xnote eq "PTAXS">selected</cfif>>PTAXS</option>
		                            <option value="SPTAX"<cfif xnote eq "SPTAX">selected</cfif>>SPTAX</option>
		                            <option value="EPTAX"<cfif xnote eq "EPTAX">selected</cfif>>EPTAX</option>
		                            <option value="ZPTAX"<cfif xnote eq "ZPTAX">selected</cfif>>ZPTAX</option>
		                            <option value="TX7"<cfif xnote eq "TX7">selected</cfif>>TX7</option>
		                            <option value="IM"<cfif xnote eq "IM">selected</cfif>>IM</option>
		                            <option value="ME"<cfif xnote eq "ME">selected</cfif>>ME</option>
		                            <option value="BL"<cfif xnote eq "BL">selected</cfif>>BL</option>
		                            <option value="NR"<cfif xnote eq "NR">selected</cfif>>NR</option>
		                            <option value="ZP"<cfif xnote eq "ZP">selected</cfif>>ZP</option>
		                            <option value="EP"<cfif xnote eq "EP">selected</cfif>>EP</option>
		                            <option value="OP"<cfif xnote eq "OP">selected</cfif>>OP</option>
		                            <option value="E33"<cfif xnote eq "E33">selected</cfif>>E33</option>
		                            <option value="EN33"<cfif xnote eq "EN33">selected</cfif>>EN33</option>
		                            <option value="RE"<cfif xnote eq "RE">selected</cfif>>RE</option>
		                        <cfelse>
		                            <option value="STAXS"<cfif xnote eq "STAXS">selected</cfif>>STAXS</option>
		                            <option value="SSTAX"<cfif xnote eq "SSTAX">selected</cfif>>SSTAX</option>
		                            <option value="ESTAX"<cfif xnote eq "ESTAX">selected</cfif>>ESTAX</option>
		                            <option value="ZSTAX"<cfif xnote eq "ZSTAX">selected</cfif>>ZSTAX</option>
		                            <option value="SR"<cfif xnote eq "SR">selected</cfif>>SR</option>
		                            <option value="ES33"<cfif xnote eq "ES33">selected</cfif>>ES33</option>
		                            <option value="ESN33"<cfif xnote eq "ESN33">selected</cfif>>ESN33</option>
		                            <option value="DS"<cfif xnote eq "DS">selected</cfif>>DS</option>
		                            <option value="OS"<cfif xnote eq "OS">selected</cfif>>OS</option>
		                        </cfif>
		                        <option value="PM"<cfif xnote eq "PM">selected</cfif>>PM</option>
		                        <option value="NTAX"<cfif xnote eq "NTAX">selected</cfif>>NTAX</option>
							</cfif>
						</cfif>
                    </select> --->
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
			<td <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>>
            	<cfif wpitemtax eq "Y">
                	<input name="pTax" id="pTax" type="hidden" size="5" maxlength="5" value="0">
				<cfelse>
                 <cfif getgsetup.ngstcustdisabletax eq "1">
                 <cfif getnongstcust.NGST_CUST eq "T">
                 <input name="pTax" id="pTax" type="hidden" size="5" maxlength="5" value="0">
                 <cfelse>
                 <input name="pTax" id="pTax" type="#hidestatus#" size="5" maxlength="5" value="#xtaxp1#" onKeyUp="getTaxControl();" onBlur="settaxcode();">
                 
                 </cfif>
                 <cfelse>
                	<input name="pTax" id="pTax" type="#hidestatus#" size="5" maxlength="5" value="#xtaxp1#" onKeyUp="getTaxControl();" onBlur="settaxcode();">
                  </cfif>
				</cfif>
            </td>
			<td <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>>
            	<!--- <input name="totalamttax" type="#hidestatus#" size="10" value="#xttlamttax#" onKeyUp="getGrand();" style="background-color:##FFFF99" readonly> --->
                <input name="totalamttax" type="#hidestatus#" size="10" value="#xttlamttax#" onKeyUp="getGrand();" <cfif wpitemtax eq "Y">style="background-color:##FFFF99" readonly<cfelseif lcase(HcomID) eq "verjas_i"> readonly</cfif>>
            </td>
		</tr>
        <!--- ADD ON 27-07-2009 --->
        <!--- <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
			<tr>
            	<td colspan="5">&nbsp;</td>
                <td>NBT (%)</td>
				<td>:</td>
                <td colspan="2">&nbsp;</td>
                <td><input name="pnbtTax" type="#hidestatus#" size="5" maxlength="5" value="#xnbttaxp#" onKeyUp="getNBTTaxControl();"></td>
                <td><input name="xnbttax" type="#hidestatus#" size="10" value="#xnbttax#" onKeyUp="getNBTTaxControl();" style="background-color:##FFFF99" readonly></td>
            </tr>
		</cfif> --->
        
        <tr <cfif lcase(HcomID) eq "weikeninv_i"  or lcase(HcomID) eq "demoindo_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i"><cfelse>style="display:none"</cfif>>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>Rebate</td>
        <td>:</td>
        <td><input <cfif rebateaftertax neq 'T'>style="visibility:hidden"</cfif> name='rebateaftertaxper' id='rebateaftertaxper' type='text' size='10' value='#rebateaftertaxper#' <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>> %</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>	
        <td><input <cfif rebateaftertax neq 'T'>style="visibility:hidden"</cfif> name='rebateaftertaxamt' id='rebateaftertaxamt' type='text' size='10' value='#rebateaftertaxamt#' readonly></td>	
        
        </tr>
        <cfif getdefault.dfpos eq "0.05" and (tran eq "CS" or tran eq "RC")>
        <tr>
        <td></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>Rounding</td>
        <td>:</td>
        <td></td>
        <td></td>
        <td></td>
        <td>
        <input name='roundadj' id="roundadj" type='text' size="10" style="background-color:##FFFF99" readonly value='#numberformat(getartran.roundadj,".__")#'>
        </td>
        </tr>
        <cfelse>
        <input name='roundadj' id="roundadj" type='hidden' value='0'>
        </cfif>
		<tr>
			<td  align="left" <cfif getdisplaysetup2.f_misc_charg5 neq "Y">style="visibility:hidden"</cfif>>#words[1638]# :<input type="#hidestatus#" name="mc5_bil" id="mc5_bil" value="#numberformat(getartran.mc5_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_pay_cash neq "Y">style="visibility:hidden"</cfif>>#words[1297]#</td>
			<td <cfif getdisplaysetup2.f_pay_cash neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_cash neq "Y">style="visibility:hidden"</cfif>><input tabindex="0" name="cash" id="cash" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cash,'0.00')#" size="10" maxlength="15" onKeyUp="getCashCount();">
            <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
            <input type="checkbox" name="checkcash" id="checkcash" onClick="copygrandtocash();">
            </cfif>
            </td>
			<td <cfif getdisplaysetup2.f_grand neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">NBT Tax (%)<cfelse>Grand</cfif></td>
			<td <cfif getdisplaysetup2.f_grand neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<cfif HcomID eq "bhl_i">
				<td>&nbsp;</td>
				<td><input name="viewGrand" type="#hidestatus#" size="10" maxlength="15" value="#xgrand#" onKeyUp="auto_fill_discount_value();" onClick="select();">
			    </td>
            <cfelseif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
                <td><input name="pnbtTax" type="#hidestatus#" size="5" maxlength="5" value="#xnbttaxp#" onKeyUp="getNBTTaxControl();"></td>
                <td><input name="xnbttax" type="#hidestatus#" size="10" value="#xnbttax#" onKeyUp="getNBTTaxControl();" style="background-color:##FFFF99" readonly></td>
			<cfelse>
           
				<td>&nbsp;</td>
				<td <cfif getdisplaysetup2.f_grand neq "Y">style="visibility:hidden"</cfif>><input name="viewGrand" id="viewGrand" type="#hidestatus#" readonly  size="10" maxlength="15" value="#xgrand#" style="background-color:##00FFCC" ></td>
			</cfif>
		</tr>
        
		<tr>
			<td  align="left" <cfif getdisplaysetup2.f_misc_charg6 neq "Y">style="visibility:hidden"</cfif>>#words[1639]# :<input type="#hidestatus#" name="mc6_bil" id="mc6_bil" value="#numberformat(getartran.mc6_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>>#words[1298]#</td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>><input name="cheque" id="cheque" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cheq,'0.00')#" size="10" maxlength="15" onKeyUp="getChequeCount();">
            <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
            <input type="checkbox" name="checkcheq" id="checkcheq" onClick="copygrandtocheq();">
            </cfif>
            </td>
            <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
            	<td>Grand</td>
				<td>:</td>
			<cfelse>
				<!--- REMARK ON 10-11-2009 --->
            	 <cfif getGeneralInfo.wpitemtax neq "1">
            		<td nowrap <cfif getdisplaysetup2.f_tax neq "Y">style="visibility:hidden"</cfif>><input name="taxincl" id="taxincl" type="checkbox" value="T" #iif(getartran.taxincl eq "T",DE("checked"),DE(""))#<cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i") and hmode eq 'Create' and tran eq "CS"></cfif> <cfif wpitemtax eq "Y">onClick="check_witempertax();"<cfelse>onClick="check_taxincls();"</cfif> > #words[53]#</td>
                    
                <cfelse>
                   <td nowrap><input name="taxincl" id="taxincl" type="checkbox" value="T"  style="visibility:hidden" ></td> 
                </cfif>
			</cfif>
            <td>&nbsp;</td>
            <td><cfif tran eq "INV"><input name="postingtaxexcl" style=" display:none" id="postingtaxexcl" type="checkbox" value="T" #iif(getartran.postingtaxexcl eq "T",DE("checked"),DE(""))#>Post Excl Tax<cfelse><input name="postingtaxexcl" id="postingtaxexcl" type="hidden" value="#getartran.postingtaxexcl#"></cfif>
            
            <cfif tran eq "RC"><input name="rcrounding" id="rcrounding" type="checkbox" value="T" #iif(getartran.rcrounding eq "T",DE("checked"),DE(""))# onClick="getTaxControl();">Enable Rounding<cfelse><input name="rcrounding" id="rcrounding" type="hidden" value="#getartran.rcrounding#"></cfif>
            
            </td>
			<td nowrap>
            
            <cfif lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "demoindo_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i">
            <input name="activaterebate" id="activaterebate" type="checkbox" value="T" checked  style="visibility:hidden" >
            Rebate After Tax
            <cfelse>
            <input name="activaterebate" id="activaterebate" type="checkbox" value="T" style="visibility:hidden" >
            </cfif>&nbsp;
          </td>
          
			<td <cfif ((lcase(HcomID) eq "weikeninv_i" or lcase(HcomID) eq "weikenint_i" or lcase(HcomID) eq "weikenbuilder_i" or lcase(HcomID) eq "futurehome_i" or lcase(HcomID) eq "weikenid_i" or hcomid eq 'weikendecor_i' or lcase(HcomID) eq "weikentrial_i") and (tran eq 'RC' or tran eq 'PO' or tran eq 'PR')) or lcase(HcomID) eq "demoindo_i"><cfelse>style="visibility:hidden"</cfif>>
            
            
            <input type="checkbox" name="rebateaftertax" id="rebateaftertax" <cfif rebateaftertax eq 'T'>checked</cfif> value="T" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onClick="getDiscountControl2();"<cfelse>onClick="getDiscountControl();"</cfif>>&nbsp;</td>
			
		  <cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
            	<td><input name="viewGrand" id="viewGrand" type="#hidestatus#" size="10" maxlength="15" value="#xgrand#" style="background-color:##00FFCC" readonly></td>
			<cfelse>
				
			</cfif>
		</tr>
        <cfif lcase(hcomid) eq "excelsnm_i" and tran eq "DO">
          <tr>
        <cfquery name="getcustrem" datasource="#dts#">
        select arrem1 from #target_arcust# where custno='#form.custno#'
        </cfquery>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td><cfoutput>Discount:#getcustrem.arrem1#</cfoutput></td>
        </tr>
        </cfif>
		<tr>
			<td align="left" <cfif getdisplaysetup2.f_misc_charg7 neq "Y">style="visibility:hidden"</cfif>>#words[1640]# :<input type="#hidestatus#" name="mc7_bil" id="mc7_bil" value="#numberformat(getartran.mc7_bil,'0.00')#" maxlength="18" size="18" onClick="select();" <cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">onKeyUp="getDiscountControl2();"<cfelse>onKeyUp="getDiscountControl();"</cfif>></td>
			<td>&nbsp;</td>
			<!--- <td>Credit Card 1</td> --->	<!--- REMARK ON 190908 & REPLACE BY THE BELOW ONE --->
			<td nowrap <cfif getdisplaysetup2.f_pay_cc1 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i" >AMEX<cfelseif HcomID eq "bama_i">VISA/MASTER<cfelseif lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "manhattan09_i" or lcase(HcomID) eq "ascend_i">#words[2079]# 
            <select name="creditcardtype1" id="creditcardtype1">
            <option value="">#words[2164]#</option>
            <option value="VISA" <cfif getartran.creditcardtype1 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype1 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype1 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype1 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype1 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype1 eq 'CUP'>selected</cfif>>CUP</option>
			<option value="UNION" <cfif getartran.creditcardtype1 eq 'UNION'>selected</cfif>>Union Pay</option>
            </select>
            <cfelse>
            <cfif getgsetup.crcdtype eq 'Y'>
            <select name="creditcardtype1" id="creditcardtype1">
            <option value="">#words[2164]#</option>
            <option value="VISA" <cfif getartran.creditcardtype1 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype1 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype1 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype1 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype1 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype1 eq 'CUP'>selected</cfif>>CUP</option>
			<option value="UNION" <cfif getartran.creditcardtype1 eq 'UNION'>selected</cfif>>Union Pay</option>
            </select>
            <cfelse>
            <cfif HcomID eq "bama_i">VISA/MASTER<cfelse>Credit Card 1</cfif>
            </cfif>
			</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_cc1 neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_cc1 neq "Y">style="visibility:hidden"</cfif>><input name="credit_card1" id="credit_card1" type="#hidestatus#" value="#numberformat(getartran.cs_pm_crcd,'0.00')#" size="10" maxlength="15" onKeyUp="getCredit_Card1Count();"><cfif HcomID eq "atc2005_i"><input type="button" name="ccdetail" id="ccdetail" value="Detail" onClick="javascript:ColdFusion.Window.show('addccdetail');"></cfif></td>
			<cfif lcase(hcomid) eq "mhsl_i" and tran eq "RC">
            	<td nowrap><input name="taxincl" id="taxincl" type="checkbox" value="T" #iif(getartran.taxincl eq "T",DE("checked"),DE(""))# onClick="javascript:check_taxincls();"> #words[53]#
                </td>
			<!--- ADD ON 17-08-2009 --->
			<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "gaf_i" or lcase(hcomid) eq "evco3_i") and tran eq "INV">
				<td nowrap><input name="contract" type="checkbox" value="T" #iif(getartran.frem9 eq "T",DE("checked"),DE(""))#> Contract</td>
			<cfelseif (lcase(HcomID) eq "ugateway_i") and tran eq "INV">
				<td nowrap><input type="checkbox" name="assigndisc" id="assigndisc" value="T" onClick="assignDisc();"> Assign Discount</td>
			<cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and tran eq "INV">
				<td>Payment Refno</td>
            <cfelseif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
            	<td>#words[2117]#</td>
                <cfelse>
                <td>&nbsp;</td>
		  </cfif>
			<td><cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and tran eq "INV">:<cfelseif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")>
            	:<cfelse>&nbsp;</cfif></td>
			<td><cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i" ) and tran eq "INV"><input type="text" name="paymentrefno" id="paymentrefno" value="<cfif isdefined('getartran.refno2')>#getartran.refno2#</cfif>" /><cfelseif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i")><input type="text" name="paymentrefno" id="paymentrefno" value="<cfif isdefined('getartran.rem6')>#getartran.rem6#</cfif>" /><cfelse>&nbsp;</cfif></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<!--- <td><cfif HcomID eq "pnp_i">NET<cfelse>Credit Card 2</cfif></td> --->	<!--- REMARK ON 190908 & REPLACE BY THE BELOW ONE --->
			<td <cfif getdisplaysetup2.f_pay_cc2 neq "Y">style="visibility:hidden"</cfif>><cfif HcomID eq "pnp_i">NET<cfelseif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">VISA/MC<cfelseif HcomID eq "bama_i">AMEX/PAYPAL<cfelseif lcase(hcomid) eq "manhattan_i" or lcase(hcomid) eq "elmanhattan_i" or lcase(hcomid) eq "manhattan09_i">#words[2080]#
			<select name="creditcardtype2">
            <option value="">#words[2165]#</option>
            <option value="VISA" <cfif getartran.creditcardtype2 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype2 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype2 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype2 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype2 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype2 eq 'CUP'>selected</cfif>>CUP</option>
			<option value="UNION" <cfif getartran.creditcardtype1 eq 'UNION'>selected</cfif>>Union Pay</option>
            </select>
            <cfelse>
            <cfif getgsetup.crcdtype eq 'Y'>
            <select name="creditcardtype2">
            <option value="">#words[2165]#</option>
            <option value="VISA" <cfif getartran.creditcardtype2 eq 'VISA'>selected</cfif>>VISA</option>
            <option value="MASTER" <cfif getartran.creditcardtype2 eq 'MASTER'>selected</cfif>>MASTER</option>
            <option value="AMEX" <cfif getartran.creditcardtype2 eq 'AMEX'>selected</cfif>>AMEX</option>
            <option value="JCB" <cfif getartran.creditcardtype2 eq 'JCB'>selected</cfif>>JCB</option>
            <option value="DINERS" <cfif getartran.creditcardtype2 eq 'DINERS'>selected</cfif>>DINERS</option>
			<option value="CUP" <cfif getartran.creditcardtype2 eq 'CUP'>selected</cfif>>CUP</option>
			<option value="UNION" <cfif getartran.creditcardtype1 eq 'UNION'>selected</cfif>>Union Pay</option>
            </select>
            <cfelse>
            <cfif HcomID eq "bama_i">AMEX/PAYPAL<cfelse>#words[2080]#</cfif>
            </cfif>
			</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_cc2 neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_cc2 neq "Y">style="visibility:hidden"</cfif>><input name="credit_card2" id="credit_card2" type="#hidestatus#" value="#numberformat(getartran.cs_pm_crc2,'0.00')#" size="10" maxlength="15" onKeyUp="getCredit_Card2Count();"></td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>><cfif tran eq "RQ">Sales Tax %<cfelse>#words[2117]#</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>>:<cfif tran eq "RQ">:<cfelse>&nbsp;</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>><input type="text" name="checkno" id="checkno" value="<cfif isdefined('getartran.checkno')>#getartran.checkno#</cfif>" /></td>
			<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>><cfif tran eq "RQ">
            <div align="right">
            			<cfquery name="RQselect_tax" datasource="#dts#">
							SELECT * FROM #target_taxtable#
                            WHERE tax_type in ('T','ST')
						</cfquery>
						<select name="RQselecttax" id="RQselecttax" onChange="JavaScript:document.getElementById('RQpTax').value=this.options[this.selectedIndex].id;">
			                <cfloop query="RQselect_tax">
			                	<cfset idrate = RQselect_tax.rate1 * 100>
			                	<option value="#RQselect_tax.code#" id="#idrate#" <cfif xrqnote eq RQselect_tax.code>selected</cfif>>#RQselect_tax.code#</option>
			                </cfloop>
		                </select>
                        </div>
            <cfelse>            
            &nbsp;
            </cfif>     
            </td>
			<td><cfif tran eq "RQ"><input name="RQpTax" id="RQpTax" type="text" size="5" maxlength="5" value="#xrqtaxp1#"><cfelse>&nbsp;</cfif></td>
			<td>&nbsp;</td>
		</tr>
		<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq 'PO' or tran eq "RC" or tran eq "PR")>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>T.T.</td>
				<td>:</td>
				<td><input name="telegraph_transfer" id="telegraph_transfer" type="#hidestatus#" value="#numberformat(getartran.cs_pm_tt,'0.00')#" size="10" maxlength="15" onKeyUp="getTelegraph_Transfer();"></td>
                
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
        <cfelseif lcase(hcomid) eq "amgworld_i" or lcase(hcomid) eq "netilung_i">
        	<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>Trade In</td>
				<td>:</td>
				<td><input name="telegraph_transfer" id="telegraph_transfer" type="#hidestatus#" value="#numberformat(getartran.cs_pm_tt,'0.00')#" size="10" maxlength="15" onKeyUp="getTelegraph_Transfer();"></td>
                
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		<cfelse>
			<input name="telegraph_transfer" id="telegraph_transfer" type="hidden" value="0">
		</cfif>
        
        <cfif (lcase(hcomid) eq "polypet_i") and (tran eq 'CS')>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td <cfif getdisplaysetup2.f_pay_cashc neq "Y">style="visibility:hidden"</cfif>>#words[2081]#</td>
				<td <cfif getdisplaysetup2.f_pay_cashc neq "Y">style="visibility:hidden"</cfif>>:</td>
				<td <cfif getdisplaysetup2.f_pay_cashc neq "Y">style="visibility:hidden"</cfif>><input name="cashcd" id="cashcd" type="#hidestatus#" value="#numberformat(getartran.cs_pm_cashCD,'0.00')#" size="10" maxlength="15" onKeyUp="getCashCDCount();"></td>
				<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>>#words[2117]#</td>
				<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>>:</td>
				<td <cfif getdisplaysetup2.f_pay_cheque neq "Y">style="visibility:hidden"</cfif>><input type="text" name="checkno" id="checkno" value="<cfif isdefined('getartran.checkno')>#getartran.checkno#</cfif>" /></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		<cfelse>
			<input name="cashcd" id="cashcd" type="hidden" value="0">
		</cfif>
        
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_pay_gvoucher neq "Y">style="visibility:hidden"</cfif>>#words[2077]#</td>
			<td <cfif getdisplaysetup2.f_pay_gvoucher neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_gvoucher neq "Y">style="visibility:hidden"</cfif>><input name="gift_voucher" id="gift_voucher" type="#hidestatus#" value="#numberformat(getartran.cs_pm_vouc,'0.00')#" size="10" maxlength="15" onKeyUp="getGift_VoucherCount();"></td>
			<td <cfif getdisplaysetup2.f_pay_gvoucher neq "Y">style="visibility:hidden"</cfif>>
			<cfif getgeneralinfo.voucher eq "Y" and (tran eq "INV" or tran eq "DO" or tran eq "CN" or tran eq "SO")> 
            <cfquery name="getusedvoucher" datasource="#dts#">
            SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
where type in('DO','CN','Transfer')
</cfif>
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where <cfif getgeneralinfo.asvoucher eq "Y"> a.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#"> and</cfif> (a.used = "N" or a.used = "" or a.used is null)
            </cfquery>
            
            <select name="vouchernum" id="vouchernum" onChange="assignvoucher(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);">
			<option value="">Select a voucher</option>
            <cfif getartran.voucher neq "">
			<option value="#getartran.voucher#" id="#numberformat(getartran.cs_pm_vouc,'0.00')#" title="#numberformat(getartran.cs_pm_vouc,'0.00')#" selected>#getartran.voucher#-#numberformat(getartran.cs_pm_vouc,'0.00')#</option>
			</cfif> 
            <cfloop query="getusedvoucher">
            <option value="#getusedvoucher.voucherno#" id="#getusedvoucher.value#" title="#getusedvoucher.type#">
            #getusedvoucher.voucherno#-<cfif getusedvoucher.type eq "Value">$ #numberformat(getusedvoucher.value,'.__')#<cfelse>#getusedvoucher.value#%</cfif>
            </option>
            </cfloop>
            
            </select>
	   </cfif>
       
       </td>
       <td>:</td>
			<td><cfif getgeneralinfo.voucherb4disc eq "Y"><input type="text" name="voucherb4disc" id="voucherb4disc" value="#numberformat(getictran2.subtotal,'.__')#" size="10"></cfif></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
        <!---Debit card --->
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_pay_dc neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "bama_i" or lcase(hcomid) eq "dgalleria_i">NETS<cfelseif getmodule.auto eq '1'>NETS<cfelse>#words[2166]#</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_dc neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_dc neq "Y">style="visibility:hidden"</cfif>><input name="debit_card" id="debit_card" type="#hidestatus#" value="#numberformat(getartran.cs_pm_dbcd,'0.00')#" size="10" maxlength="15" onKeyUp="getDebit_cardCount();" <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif>></td>
            <!---get footer currate & code--->
            <cfquery name="currency" datasource="#dts#">
  			select * 
			from #target_currency# 
			</cfquery>
			<cfset footercurrrate =getartran.footercurrrate>
    		<cfset xfootercurrcode=getartran.footercurrcode>

    <!---end get footer currate & code--->
			<cfif getgsetup.footerexchange eq 'Y'>
            <td>#words[785]#</td>
            <td>:</td>
			<td><select name="footercurrcode" id="footercurrcode" onChange="ajaxFunction(document.getElementById('footercurrajax'),'/default/transaction/footercurrrateajax.cfm?footercurrcode='+document.getElementById('footercurrcode').value+'&date=#dateformat(getartran.wos_date,'yyyy-mm-dd')#');">
            <option value="">Choose a currency code</option>
            <cfloop query="currency">
            <option value="#currency.currcode#"<cfif xfootercurrcode eq currency.currcode>selected</cfif>>#currency.currcode#</option>
            </cfloop>
            </select>
            </td>
            <cfelse>
            <td>&nbsp;</td>
			<td colspan="3"><input name="footercurrcode" id="footercurrcode" type="hidden" size="10" value="#listfirst(xfootercurrcode)#" readonly ></td>
            </cfif>


		</tr>
        <!--- --->
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td <cfif getdisplaysetup2.f_pay_deposit neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "visionlaw_i">Legal Subsidy<cfelseif lcase(hcomid) eq "bama_i">Bank Transfer<cfelse>#words[2078]#</cfif></td>
			<td <cfif getdisplaysetup2.f_pay_deposit neq "Y">style="visibility:hidden"</cfif>>:</td>
		  	<td <cfif getdisplaysetup2.f_pay_deposit neq "Y">style="visibility:hidden"</cfif>>
            <cfif lcase(Hcomid) neq "rpi270505_i">

            <cfset xdepositno=getartran.depositno>
            <cfquery name="getdepositno" datasource="#dts#">
            SELECT * from deposit where billno='' or billno is null or 
            depositno="#getartran.depositno#" order by depositno
            </cfquery>
            <select name="depositno" id="depositno" onChange="getDiscountControl();" style="width:170px;">
            <option value="">Choose a Deposit No</option>
            <cfloop query="getdepositno">
            <option value="#getdepositno.depositno#" id="#getdepositno.ptax#" title="#val(getdepositno.cs_pm_cash)+val(getdepositno.cs_pm_cheq)+val(getdepositno.cs_pm_crcd)+val(getdepositno.cs_pm_crc2)+val(getdepositno.cs_pm_dbcd)+val(getdepositno.cs_pm_vouc)#" <cfif xdepositno eq getdepositno.depositno>selected</cfif>>#getdepositno.depositno# - #getdepositno.desp#</option>
            </cfloop>
            </select>
            <!---
#(((val(getdepositno.cs_pm_cash)+val(getdepositno.cs_pm_cheq)+val(getdepositno.cs_pm_crcd)+val(getdepositno.cs_pm_crc2)+val(getdepositno.cs_pm_dbcd)+val(getdepositno.cs_pm_vouc))*100)/(100+val(getdepositno.ptax)))#
			--->
            <a href="deposit/deposittable2.cfm?type=Create&tran=INV&sono=#nexttranno#&custno=#custno#&express=1" target="_blank">New Deposit</a>
            <br>
            </cfif>
            <input name="deposit" id="deposit" type="#hidestatus#" value="#numberformat(getartran.deposit,'0.00')#" size="10" maxlength="15" onKeyUp="getDepositCount();" <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif><cfif lcase(Hcomid) eq "rpi270505_i" and getartran.accepted eq "Y">readonly</cfif>>
            <cfif lcase(Hcomid) eq "rpi270505_i">
            <cfif getartran.accepted eq "Y">
            <input type="button" name="rpiaddbtn" id="rpiaddbtn" value="+" onClick="javascript:ColdFusion.Window.show('rpipaymentwindow');">
            
            <cfwindow center="true" width="600" height="400" name="rpipaymentwindow" refreshOnShow="true" closable="false" modal="true" title="Add Payment" initshow="false" source="/default/transaction/rpipayment.cfm?type=#tran#&refno=#nexttranno#" />
            
            <cfelse>
            <select name="rpidepositmethod" id="rpidepositmethod">
            	<option value="cash">Cash</option>
                <option value="crcd">Credit Card</option>
                <option value="dbcd">Debit Card / Nets</option>
                <option value="voucher">Voucher</option>
                <option value="cheque">Cheque</option>
            </select>
            </cfif>
            </cfif>
            
            </td>
			<cfif getgsetup.footerexchange eq 'Y'>
            <td>#words[1870]#</td>
            <td>:</td>
			<td><div id="footercurrajax"><input name="footercurrrate" id="footercurrrate" type="text" size="10" value="#Numberformat(listfirst(footercurrrate), '._____')#"></div></td>
            <cfelse>
            <td>&nbsp;</td>
			<td><input name="footercurrrate" id="footercurrrate" type="hidden" size="10" value="#Numberformat(listfirst(footercurrrate), '._____')#"></td>
            </cfif>


		</tr>
        
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  <td <cfif getdisplaysetup2.f_pay_as_debt neq "Y">style="visibility:hidden"</cfif>>#words[2168]#</td>
			<td <cfif getdisplaysetup2.f_pay_as_debt neq "Y">style="visibility:hidden"</cfif>>:</td>
			<td <cfif getdisplaysetup2.f_pay_as_debt neq "Y">style="visibility:hidden"</cfif>><input name="debt" id="debt" type="#hidestatus#" size="10" value="#xdebt#" style="background-color:##FFFF99" readonly></td>
			<td colspan='6' align='left'><input type='submit' name='Submit' value='Accept & Preview'><!---<font color='##FF0000'> <--Please click 'Accept' when you finished </font>---><cfif alcreate eq 1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  <input type='submit' name='Submit' value='Accept & Create New'> </cfif></td>
		</tr>
        
		</table>
        <cfif getgsetup.termscondition eq 'Y'>
        <table  width='100%' border="0" align='center' cellspacing="0">
        
        <tr>
        <td><div align="right"><cfif hcomid eq 'mylustre_i'>Note<cfelse>#words[2167]#</cfif></div></td>
        <td colspan="10">
			<textarea name="termscondition" id="termscondition" cols="160" rows="5"><cfif getartran.termscondition neq ''>#convertquote(getartran.termscondition)#<cfelse><cfif tran eq 'RC'>#convertquote(gettermcondition.lRC)#<cfelseif tran eq 'PR'>#convertquote(gettermcondition.lPR)#<cfelseif tran eq 'DO'>#convertquote(gettermcondition.lDO)#<cfelseif tran eq 'INV'>#convertquote(gettermcondition.lINV)#<cfelseif tran eq 'CS'>#convertquote(gettermcondition.lCS)#<cfelseif tran eq 'CN'>#convertquote(gettermcondition.lCN)#<cfelseif tran eq 'DN'>#convertquote(gettermcondition.lDN)#<cfelseif tran eq 'PO'>#convertquote(gettermcondition.lPO)#<cfelseif tran eq 'QUO'>#convertquote(gettermcondition.lQUO)#<cfelseif tran eq 'SO'>#convertquote(gettermcondition.lSO)#<cfelseif tran eq 'SAM'>#convertquote(gettermcondition.lSAM)#</cfif></cfif></textarea>
		</td>
        </tr>
        
       
        
        </table>
        <cfelse>
        <input type="hidden" name="termscondition" id="termscondition" value="">
         </cfif>
        <cfquery datasource="#dts#" name="getartran">
			select * from artran
			where refno = '#nexttranno#' and type = '#tran#'
		</cfquery>
        

        <cfquery name="gettaxincludesum" datasource="#dts#">
        select sum(TAXAMT_BIL) as TAXAMT_BIL from ictran where refno = '#nexttranno#' and type = '#tran#' and taxincl = "T"
        </cfquery>
 


<cfif isdefined('gettaxincludesum.recordcount')>
<cfif gettaxincludesum.recordcount neq 0>
<input type="hidden" name="textincludeitem" id="textincludeitem" value="1" >
</cfif>
</cfif> 
	</form>
	</cfoutput>
</cfif>
<br>
<table width='100%' align='center' class='data'>
<cfoutput>
<tr>
	<th>#words[58]#.</th>
    <cfif getdisplaysetup.billbody_aitemno eq 'Y'>
    <th><div align="left">#words[121]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_barcode eq 'Y'>
    <th><div align="left">#words[128]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_itemno eq 'Y'>
	<th><div align="left"><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>#words[120]#</cfif></div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_desp eq 'Y'>
	<th><div align="left"><cfoutput>#words[65]#</cfoutput></div></th>
    </cfif>
    <cfoutput>
    <cfif getdisplaysetup.billbody_brand eq 'Y'><th>#words[122]#</th></cfif>
    <cfif getdisplaysetup.billbody_group eq 'Y'><th>#words[146]#</th></cfif>
    <cfif getdisplaysetup.billbody_category eq 'Y'><th>#words[123]#</th></cfif>
    <cfif getdisplaysetup.billbody_model eq 'Y'><th>#words[150]#</th></cfif>
    <cfif getdisplaysetup.billbody_rating eq 'Y'><th>#words[152]#</th></cfif>
    <cfif getdisplaysetup.billbody_sizeid eq 'Y'><th>#words[154]#</th></cfif>
    <cfif getdisplaysetup.billbody_material eq 'Y'><th>#words[148]#</th></cfif>
    </cfoutput>
    <cfif getdisplaysetup.billbody_location eq 'Y'>
    <th><div align="left">#words[482]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_project eq 'Y'>
    <th><div align="left">#words[506]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_job eq 'Y'>
    <th><div align="left">#words[475]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_batch eq 'Y'>
    <th><div align="left">#words[2027]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_onhand eq 'Y'>
    
    <th>#words[1113]#</th>
    </cfif>
    <cfif getdisplaysetup.billbody_gltradac eq 'Y'>
	<th><div align="left">#words[1293]#</div></th>
    </cfif>
    <cfif getdisplaysetup.billbody_qty eq 'Y'>
	<th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Drum<cfelse>#words[227]#</cfif></th>
    </cfif>
    <cfif getdisplaysetup.billbody_unit eq 'Y'>
    <th>#words[492]#</th>
    </cfif>
    
    <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'PR' or tran eq 'RC' or tran eq 'RQ')>
    <cfif getdisplaysetup.billbody_price eq 'Y'>
	<th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Capacity per Drum<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">#words[1096]#<cfelseif tran neq "DO">#words[1096]#</cfif></cfif></th>
    </cfif>
    <cfif getdisplaysetup.billbody_currcode eq 'Y'>
	<th>#words[785]#</th>
    </cfif>
	<cfif wpitemtax eq "Y">
    <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
		<th>#words[1099]#</th>
    </cfif>
	</cfif>
    <cfif getdisplaysetup.billbody_amt eq 'Y'>
	<th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Total Quantity<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">#words[1097]#<cfelseif tran neq "DO">#words[1097]#</cfif></cfif></th>
    </cfif>
	<cfif wpitemtax eq "Y">
    <cfif getdisplaysetup.billbody_taxcode eq 'Y'>
		<th>#words[56]#</th>
    </cfif>
	</cfif>
    </cfif>
    
    <cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
    <cfif getdisplaysetup.billbody_price eq 'Y'>
    <th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Capacity per Drum<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">#words[1096]#<cfelseif tran neq "DO">#words[1096]#</cfif></cfif></th>
    </cfif>
    <cfif getdisplaysetup.billbody_currcode eq 'Y'>
	<th>#words[785]#</th>
    </cfif>
	<cfif wpitemtax eq "Y">
    <cfif getdisplaysetup.billbody_taxamt eq 'Y'>
		<th>#words[1099]#</th>
    </cfif>
	</cfif>
    <cfif getdisplaysetup.billbody_amt eq 'Y'>
	<th><cfif lcase(HcomID) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Total Quantity<cfelse><cfif tran eq "DO" and getpin2.h5700 eq "T">#words[1097]#<cfelseif tran neq "DO">#words[1097]#</cfif></cfif></th>
    </cfif>
	<cfif wpitemtax eq "Y">
    <cfif getdisplaysetup.billbody_taxcode eq 'Y'>
		<th>#words[56]#</th>
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
    
	<th>#words[10]#</th>
</tr>
</cfoutput>
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
        <cfif getdisplaysetup.billbody_barcode eq 'Y'>
        <cfquery name="getproductcode" datasource="#dts#">
        select barcode from icitem where itemno='#getictran.itemno#'
        </cfquery>
        <td>#getproductcode.barcode#</td>
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
			<a onClick="releaseDirtyFlag();" href='transaction_steel.cfm?tran=#tran#&hmode=#hmode#&type1=Edit&itemcount=#itemcount#&
			ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#&
			custno=#URLEncodedFormat(custno)#&readperiod=#readperiod#&invoicedate=#invoicedate#'>
			<img height='18px' width='18px' src='../../images/edit.ICO' alt='Change Item' border='0'>Change Item</a>&nbsp;
			</cfif>
		 	<!--- <cfif multilocation neq "Y"> --->
             <cfif tran eq "INV">
             <cfif checkitemupdatedfrombills.recordcount eq 0>
				<a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#newtrancode#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>#words[2155]#</a>&nbsp;
			<cfelse>
                <!---cannot edit location--->
                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#&editinfoonly=1&noeditloc=1'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>#words[2155]#</a>&nbsp;
            </cfif>
            <cfelse>
            <cfif checkitemupdatedtobills.recordcount eq 0>
            	<a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>#words[2155]#</a>&nbsp;
            <cfelse>
            	<a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Edit&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&grade=#grade#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#&editinfoonly=1'><img height='18px' width='18px' src='../../images/edit.ICO' alt='Edit' border='0'>#words[2155]#</a>&nbsp;
            </cfif>
            </cfif>
			
			<cfif tran eq "INV" or tran eq "CS">
            	<cfif checkitemupdatedfrombills.recordcount eq 0>
                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Delete&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>#words[805]#</a>
                <cfelse>
                <img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>#words[805]#
                </cfif>
            <cfelse>
                <cfif checkitemupdatedtobills.recordcount eq 0>
                <a onClick="releaseDirtyFlag();" href='transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=Delete&itemno=#URLEncodedFormat(itemno)#&service=#linecode#&itemcount=#itemcount#&ndatecreate=#ndatecreate#&nexttranno=#URLEncodedFormat(nexttranno)#&refno3=#listfirst(refno3)#&currrate=#xcurrrate#&agenno=#URLEncodedFormat(agenno)#
				&enterbatch=#URLENCODEDFORMAT(batchcode)#&oldqty=#qty#&newtrancode=#URLEncodedFormat(nexttranno)#&multilocation=#multilocation#'><img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>#words[805]#</a>
                <cfelse>
                <img height='18px' width='18px' src='../../images/delete.ICO' alt='Delete' border='0'>#words[805]#
                </cfif>
            </cfif>
                 </font></div>
</td>
	</tr>
   	</cfoutput>
</cfif>
</table>	

<cftry>
		<cfif isdefined("form.submit1") and form.submit1 eq "  Save  ">
			<script type="text/javascript">
			setTimeout('releaseDirtyFlag();document.invoicesheet.submit();','500');
			</script>
        </cfif>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#:::#cfcatch.Detail#</cfoutput><cfabort>
		</cfcatch>
</cftry>


<cfoutput>
<script type="text/javascript">
		
	function adjustgrand()
	{
		
		<cfif isdefined('gettaxincludesum.TAXAMT_BIL')>
			<cfif gettaxincludesum.TAXAMT_BIL neq "" >
				var totaltaxincl = #gettaxincludesum.TAXAMT_BIL#;
			<cfelse>
				var totaltaxincl = 0;
			</cfif>
		<cfelse>
			var totaltaxincl = 0;
		</cfif>
		var totalamount =document.invoicesheet.viewGrand.value;
		if(document.getElementById("taxincl").checked!=true)
		{
		document.invoicesheet.viewGrand.value = (totalamount - totaltaxincl).toFixed(fixnum);
		}
		
		<cfif getdefault.dfpos eq "0.05">
		<cfif lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "gramas_i">
		document.invoicesheet.roundadj.value=((((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2)-document.invoicesheet.viewGrand.value).toFixed(2);
		document.invoicesheet.viewGrand.value=(((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2);
		<cfelseif lcase(hcomid) eq "tcds_i">
		var grandafterround=((Math.ceil(document.invoicesheet.viewGrand.value* 2*10)/10).toFixed(1));
		document.invoicesheet.roundadj.value=((grandafterround/2).toFixed(2)-document.invoicesheet.viewGrand.value).toFixed(2);
		document.invoicesheet.viewGrand.value=(grandafterround/2).toFixed(2);;
		<cfelse>
		<cfif tran eq "CS">
		
		document.invoicesheet.roundadj.value=((((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2)-document.invoicesheet.viewGrand.value).toFixed(2);
		document.invoicesheet.viewGrand.value=(((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2);
		</cfif>
		</cfif>
		</cfif>
		<!---RC Rounding--->
		<cfif tran eq "RC">
		if(document.invoicesheet.rcrounding.checked==true){
			document.invoicesheet.roundadj.value=((((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2)-document.invoicesheet.viewGrand.value).toFixed(2);
			document.invoicesheet.viewGrand.value=(((document.invoicesheet.viewGrand.value* 2).toFixed(1))/2).toFixed(2);
		}
		else{
			document.invoicesheet.roundadj.value=0.00;
		}
		</cfif>
		<!--- --->
		//document.invoicesheet.debt.value = (totalamount - totaltaxincl).toFixed(fixnum);
		var grand=parseFloat(document.getElementById("viewGrand").value);
		var cash=!isNaN(parseFloat(document.getElementById("cash").value)) ? parseFloat(document.getElementById("cash").value) : 0;
		var cheque=!isNaN(parseFloat(document.getElementById("cheque").value)) ? parseFloat(document.getElementById("cheque").value) : 0;
		var credit_card1=!isNaN(parseFloat(document.getElementById("credit_card1").value)) ? parseFloat(document.getElementById("credit_card1").value) : 0;
		var credit_card2=!isNaN(parseFloat(document.getElementById("credit_card2").value)) ? parseFloat(document.getElementById("credit_card2").value) : 0;
		var telegraph_transfer=!isNaN(parseFloat(document.getElementById("telegraph_transfer").value)) ? parseFloat(document.getElementById("telegraph_transfer").value) : 0;
		var gift_voucher=!isNaN(parseFloat(document.getElementById("gift_voucher").value)) ? parseFloat(document.getElementById("gift_voucher").value) : 0;
		var dep=!isNaN(parseFloat(document.getElementById("deposit").value)) ? parseFloat(document.getElementById("deposit").value) : 0;
		debt=(grand-cash-cheque-credit_card1-credit_card2-telegraph_transfer-gift_voucher-dep).toFixed(fixnum);
		document.invoicesheet.debt.value = debt;
	}
	adjustgrand();
	getDiscountControl();
	<cfif isdefined('xtaxp1')>
	<cfif xtaxp1 eq 0>
	var taxfield = document.getElementById('selecttax');
	document.getElementById('pTax').value=taxfield.options[taxfield.selectedIndex].id;
	getTaxControl();
	</cfif>
	</cfif>
</script>
<script type="text/javascript">
function submitinvoice()
{
document.invoicesheetpost.submit();

}


</script>
</cfoutput>
<cfquery datasource="#dts#" name="getartran">
			select currcode from artran
			where refno = '#nexttranno#' and type = '#tran#'
</cfquery>


<cfwindow center="true" width="700" height="500" name="findComment" refreshOnShow="true"
        title="Find Comment" initshow="false"
        source="/default/transaction/advanceProduct/findComment.cfm" />

        <cfwindow center="true" width="600" height="400" name="expressservice" refreshOnShow="true" closable="false" modal="true" title="Add Services" initshow="false"
        source="/default/transaction/services/addservices.cfm?tran=#tran#&custno=#custno#&tranno=#nexttranno#" />
        <cfwindow center="true" width="550" height="400" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/searchitem/searchitem.cfm?currcode=#getartran.currcode#" />
        
        <cfif lcase(hcomid) eq "newapparel_i">
        <cfwindow center="true" width="1000" height="600" name="matrixsearchitem" refreshOnShow="true" closable="true" modal="false" title="Add Matrix Item" initshow="false"
        source="/default/transaction/matrixsearchitem/searchitem.cfm?tran={tran}&tranno={nexttranno}&custno={custno}" />
        </cfif>
        
        <cfwindow center="true" width="700" height="500" name="multiaddsearchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/products/searchitem.cfm?currcode=#getartran.currcode#" />
        
        <cfwindow center="true" width="550" height="400" name="historyitem" refreshOnShow="true" closable="true" modal="false" title="History Item" initshow="false"
        source="/default/transaction/historyitem/historyitem.cfm?custno=#custno#" />
        
        <cfwindow center="true" width="600" height="400" name="createservice" refreshOnShow="true" closable="true" modal="true" title="Create Services" initshow="false"
        source="/default/transaction/createservice/createservice.cfm" />
        <cfif lcase(hcomid) eq 'litelab_i' and (tran eq 'SO' or tran eq 'INV' or tran eq 'QUO' or tran eq 'DO')>
        <cfwindow center="true" width="300" height="300" name="discountpassword" refreshOnShow="true" closable="true" modal="true" title="Discount Password" initshow="false"
        source="discountpasswordcontrol.cfm" />
        </cfif>

<cfif lcase(hcomid) eq "imiqgroup_i" or  lcase(hcomid) eq "intelquip_i">
        <cfwindow center="true" width="700" height="500" name="clientinvoice" refreshOnShow="true" closable="true" modal="true" title="Project Employee Records" initshow="false"
        source="/default/transaction/clientinvoice.cfm?custno=#custno#&invoicedate=#invoicedate#&type=#tran#&invno=#nexttranno#" />
        	<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
        </cfif>
         
        
        <cfif getGeneralInfo.EAPT eq "1">
        <cfset eAdd="/default/transaction/products/addproducts.cfm?tran="&tran&"&custno="&custno&"&tranno="&nexttranno >
        <cfset ewidth = "800" >
        <cfset eheight = "400" >
		<cfelse>
        <cfset eAdd="/default/transaction/advanceproduct/addproducts.cfm?tran="&tran&"&custno="&custno&"&tranno="&nexttranno >
        <cfset ewidth = "800" >
        <cfset eheight = "500" >
        </cfif>
        <cfwindow center="true" width="#ewidth#" height="#eheight#" name="expressproduct" refreshOnShow="true" closable="false" modal="true" title="Add Products" initshow="false" 
        source="#eAdd#" />
        <cfset eAdd2="/default/transaction/material/addproducts.cfm?tran="&tran&"&custno="&custno&"&tranno="&nexttranno >
        <cfwindow center="true" width="#ewidth#" height="#eheight#" name="matproduct" refreshOnShow="true" closable="false" modal="true" title="Add Material" initshow="false" 
        source="#eAdd2#" />
        <cfif lcase(hcomid) eq "visionlaw_i">
        <cfwindow center="true" width="250" height="150" name="changeprice" refreshOnShow="true" closable="true" modal="true" title="Edit Price" initshow="false" source="changeprice.cfm?refno=#nexttranno#&type=#tran#&custno=#custno#&trancode={hidtrancode}" /> 
        <cfwindow center="true" width="250" height="150" name="changegst" refreshOnShow="true" closable="true" modal="true" title="Edit GST" initshow="false" source="changegst.cfm?refno=#nexttranno#&type=#tran#&custno=#custno#&trancode={hidtrancode}" /> 
        </cfif>
        <cfwindow center="true" width="700" height="250" name="addccdetail" refreshOnShow="true" closable="true" modal="true" title="Credit Card Detail" initshow="false" 
        source="creditcarddetailajax.cfm?refno=#nexttranno#&type=#tran#" />

</body>
</html>
<script type="text/javascript">
var needToConfirm = true;

function setDirtyFlag()
{
needToConfirm = true; //Call this function if some changes is made to the web page and requires an alert
// Of-course you could call this is Keypress event of a text box or so...
}

function releaseDirtyFlag()
{
needToConfirm = false; //Call this function if dosent requires an alert.
//this could be called when save button is clicked 
}


window.onbeforeunload = confirmExit;
function confirmExit()
{
if (needToConfirm)
return "You have attempted to leave this page. \n\n\nIf you have made any changes to the fields without clicking the ACCEPT button, \n\nyour changes will be LOST and the BILL TOTAL AMOUNT WILL NOT BE CORRECT.\n\n\n Are you really sure you want to exit this page?";
}

<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
document.getElementById('itemselect').focus();
</cfif>
</script>
<cfabort>

<cfwindow center="true" width="700" height="500" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/products/searchitem2.cfm" />
