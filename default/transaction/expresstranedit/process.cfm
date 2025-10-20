<cffunction name="reorder" output="false">
	<cfargument name="itemcountlist" required="yes">
	<cfargument name="refno" required="yes">
	
	<cfloop index="i" from="1" to="#listlen(itemcountlist)#">
		<cfif listgetat(itemcountlist,i) neq i>
			<cfquery name="updateIserial" datasource="#dts#">
				update iserial set 
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and trancode='#listgetat(itemcountlist,i)#';
			</cfquery>
            <cfquery name="updateIgrade" datasource="#dts#">
				update igrade set 
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and trancode='#listgetat(itemcountlist,i)#';
			</cfquery>
            <cfquery name="updateiclinkfr" datasource="#dts#">
            	Update iclink SET
                frtrancode = '#i#'
                WHERE frtype = '#tran#'
                and frrefno = '#refno#'
                and frtrancode= '#listgetat(itemcountlist,i)#';
            </cfquery>
            
            <cfquery name="updateiclinkto" datasource="#dts#">
            	Update iclink SET
                trancode = '#i#'
                WHERE type = '#tran#'
                and refno = '#refno#'
                and trancode= '#listgetat(itemcountlist,i)#';
            </cfquery>
            
			<cfquery name="updateIctran" datasource="#dts#">
				update ictran set 
				itemcount='#i#',
				trancode='#i#'
				where type='#tran#' 
				and refno='#refno#' 
				and custno='#form.custno#' 
				and itemcount='#listgetat(itemcountlist,i)#';
			</cfquery>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="relocate" output="false">
	<cfargument name="newtc" required="yes">
	<cfargument name="end" required="yes">
	<cfargument name="refno" required="yes">
	<cfquery name="updateIserial" datasource="#dts#">
        update iserial set 
        trancode=trancode + 1
       	where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and trancode>=#newtc# 
		and trancode<=#end#
    </cfquery>
    
    <cfquery name="updateIgrade" datasource="#dts#">
        update igrade set 
        trancode=trancode + 1
        where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and trancode>=#newtc# 
		and trancode<=#end#
    </cfquery>
    <cfquery name="updateiclinkfr" datasource="#dts#">
        Update iclink SET
        frtrancode = frtrancode + 1
        WHERE frtype = '#tran#'
        and frrefno = '#refno#'
        and frtrancode >=#newtc#
        and frtrancode<=#end#
    </cfquery>
    
     <cfquery name="updateiclinkfr" datasource="#dts#">
        Update iclink SET
        trancode = trancode + 1
        WHERE type = '#tran#'
        and refno = '#refno#'
        and trancode >=#newtc#
        and trancode <=#end#
    </cfquery>
            
	<cfquery name="updateIctran" datasource="#dts#">
		update ictran set 
		itemcount=itemcount+1,
		trancode=trancode+1
		where type='#tran#'
		and refno='#refno#' 
		and custno='#form.custno#' 
		and itemcount>=#newtc# 
		and itemcount<=#end#
		order by itemcount desc;
	</cfquery>
</cffunction>


<html>
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<cfset frem0 = form.B_name>
<cfset frem1 = form.B_name2>
<cfset frem2 = form.B_add1>
<cfset frem3 = form.B_add2>
<cfset frem4 = form.B_add3>
<cfset frem5 = form.B_add4>
<cfset frem6 = form.B_fax>
<cfset frem7 = form.D_name>
<cfset frem8 = form.D_name2>
<cfset remark2 = form.B_Attn>
<cfset remark3 = form.D_Attn>
<cfset remark4 = form.B_Phone>
<cfset remark12 = form.D_Phone>
<cfset comm0 = form.D_add1>
<cfset comm1 = form.D_add2>
<cfset comm2 = form.D_add3>
<cfset comm3 = form.D_add4>
<cfset comm4 = form.D_fax>
<cfset agenno = form.agent>
<cfset phonea = form.b_phone2>
<cfset term = form.term>
<cfset driver = trim(form.driver)>
<cfset source = form.project>
<cfset job = form.job>


<cfset type = form.tran>
<cfset refno = form.refno>
<cfset custno = form.custno>
<cfset currcode = form.currcode>
<cfset currrate = form.currrate>
<cfif isdefined('form.taxincl')>
<cfset form.gross=form.gross-form.taxamt>
</cfif>
<cfset gross_bil = form.gross>
<cfset disp1 = val(form.dispec1)>
<cfset disp2 = val(form.dispec2)>
<cfset disp3 = val(form.dispec3)>
<cfset disc1_bil = form.disbil1>
<cfset disc2_bil = form.disbil2>
<cfset disc3_bil = form.disbil3>
<cfset disc_bil = form.disamt_bil>
<cfset net_bil = form.net>
<cfif isdefined('form.taxincl')>
<cfset taxincl = form.taxincl>
<cfelse>
<cfset taxincl = "">
</cfif>
<cfif isdefined('form.taxcode')>
<cfset note = form.taxcode>
<cfelse>
<cfset note = "">
</cfif>
<cfset taxp1 = form.taxper>
<cfset tax_bil = form.taxamt>
<cfset tax1_bil = form.taxamt>
<cfset grand_bil = form.grand>
<cfif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "CN">
<cfset credit_bil = grand_bil>
<cfset debit_bil = 0>
<cfelse>
<cfset debit_bil = grand_bil>
<cfset credit_bil = 0>
</cfif>
<cfif val(currrate) eq "0">
<cfset currrate = 1>
</cfif>
<cfset invgross = gross_bil * val(currrate)>
<cfset discount1 = disc1_bil * val(currrate)>
<cfset discount2 = disc2_bil * val(currrate)>
<cfset discount3 = disc3_bil * val(currrate)>
<cfset discount = disc_bil * val(currrate)>
<cfset net = net_bil * val(currrate)>
<cfset tax1 = tax1_bil * val(currrate)>
<cfset tax = tax_bil * val(currrate)>
<cfset grand = grand_bil * val(currrate)>
<cfset debitamt = debit_bil * val(currrate)>
<cfset creditamt = credit_bil * val(currrate)>
<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>

<cfif tran eq "rc" or tran eq "pr" or tran eq "po">        
<cfquery name="getarea" datasource="#dts#">
select area from #target_apvend# where custno='#custno#'
</cfquery>
<cfelse>
<cfquery name="getarea" datasource="#dts#">
select area from #target_arcust# where custno='#custno#'
</cfquery>
</cfif>


<cfquery name="updaterate" datasource="#dts#">
update ictran 
SET
price = price_bil * #val(currrate)#,
amt1 = amt1_bil * #val(currrate)#,
amt = amt_bil * #val(currrate)#,
disamt = disamt_bil * #val(currrate)#,
fperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
currrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
trdatetime = now()
WHERE 
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">
</cfquery>


<cfif taxincl neq "Y" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3)
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    </cfquery>
</cfif>

<cfquery name="insertictran" datasource="#dts#">
update ictran set agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">
where
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">

</cfquery>

<cfquery name="insertartran" datasource="#dts#">
update artran set
refno2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno2#">,
trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
fperiod=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
wos_date=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
despa=<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
agenno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
job=<cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
currrate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
gross_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
disc1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
disc2_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
disc3_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
disc_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
net_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
tax1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
tax_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax_bil#">,
grand_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
debit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#debit_bil#">,
credit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#credit_bil#">,
invgross=<cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
disp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp1#">,
disp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp2#">,
disp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp3#">,
discount1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
discount2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
discount3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
discount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
net=<cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
tax1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1#">,
tax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
taxp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
grand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
debitamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
creditamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">,
frem0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
frem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem1#">,
frem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem2#">,
frem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem3#">,
frem4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem4#">,
frem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem5#">,
frem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem6#">,
frem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem7#">,
frem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem8#">,
rem0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bcode#">,
rem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Dcode#">,
rem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
rem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
rem4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
rem12=<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
rem13=<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
rem14=<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
comm0=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm0#">,
comm1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm1#">,
comm2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm2#">,
comm3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm3#">,
comm4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm4#">,
taxincl=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
note=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
updated_on=now(),
creditcardtype1="#form.cctype#",
PONO=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pono#">,
DONO=<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
van=<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
term=<cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
area=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.area#">,
currcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
CS_PM_CASH='#val(form.cash)#',
CS_PM_CHEQ='#val(form.cheque)#',
CS_PM_CRCD='#val(form.credit_card1)#',
CS_PM_CRC2='#val(form.credit_card2)#',
CS_PM_DBCD='#val(form.debit_card)#',
CS_PM_VOUC='#val(form.voucher)#',
DEPOSIT='#val(form.deposit)#',
rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem11#">,
checkno='#form.checkno#',
CS_PM_CASHCD='#val(form.cashcamt)#',
rem9='#form.rem9#',
creditcardtype2="#form.cctype2#",
counter='',
rem7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem7#">,
rem6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem6#">,
rem5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem5#">,
rem8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem8#">,
rem10=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rem10#">,
termscondition=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.termscondition#">
<cfif isdefined('form.leadno')>,permitno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leadno#"></cfif>
,phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#phonea#">
,d_phone2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_phone2#">
,e_mail=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.b_email#">
,d_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_email#">

where
refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#">

</cfquery>


<cfif type eq "RC">
<cfquery name="checkupdate" datasource="#dts#">
SELECT UPDATE_UNIT_COST FROM gsetup2
</cfquery>
<cftry>
<cfif checkupdate.update_unit_cost eq "T">
	<cfquery name = "getictran" datasource = "#dts#">
		select 
		custno,
		itemno,
		price,
		dispec1,
		dispec2,
		dispec3,
        UPDCOST,
        type,
        refno
		from ictran 
		where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		and fperiod <> '99' 
		order by itemcount;
	</cfquery>
	
	<cfif getictran.recordcount gt 0 and getictran.UPDCOST neq "Y">
		<cfloop query = "getictran">
			<cfquery name = "updateIcitem" datasource = "#dts#">
				update icitem 
				set ucost=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">
				where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">;
			</cfquery>
            
            <cfquery name="updateictran" datasource="#dts#">
            	UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
                type=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.type#">
                and refno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.refno#">
                and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">
                and fperiod <> '99'
                
            </cfquery>
			
			<cfif getictran.custno neq "">
				<cfquery name = "update_icl3p2" datasource = "#dts#">
					insert into icl3p2 
					(
						itemno,
						custno,
						price,
						dispec,
						dispec2,
						dispec3
					)
					values 
					(
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.custno#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">
					) 
					on duplicate key update 
					price=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
					dispec=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
					dispec2=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
					dispec3=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">;
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
<cfelse>
<cfquery name = "updateictran" datasource = "#dts#">
		UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
		type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
		and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
		and fperiod <> '99
	</cfquery>
</cfif>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>
	<cfquery name="getgeneral" datasource="#dts#">
    select autolocbf from gsetup
    </cfquery>
    
    <cfif getgeneral.autolocbf eq "Y">
    <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#refno#" type="#type#" returnvariable="done" />
    </cfif>
    
    
<cflocation url="/default/transaction/transaction3c.cfm?tran=#type#&nexttranno=#refno#" addtoken="no">
 	
    </body>
    </html>