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

<cfset refnotype=1>
<cfset uuid = form.uuid>
<cfset type = form.tran>
<cfset custno = form.custno>
<cfset invno = form.invoiceno>

<cfquery name="getinvno" datasource="#dts#">
SELECT refno2 FROM ictrantempcn 
WHERE uuid =<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and refno2<>''
GROUP BY refno2
</cfquery>
    
<cfquery name="getbrem6trancode" datasource="#dts#">
SELECT brem1,brem6,trancode FROM ictrantempcn
WHERE 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfloop query="getbrem6trancode">
    <cfquery name="updateJO" datasource="#dts#">
    UPDATE ictrantempcn
    SET brem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.placementno#brem6##trancode#')#">
    WHERE 
    trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#">
    AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfloop>

<!---<cfif left(dts,12) eq 'manpowertest'>--->

      <cfquery name="checkexistrefno" datasource="#dts#">
      select rem40 from artran where  refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invoiceno#">
      </cfquery>
          
      <cfif form.invoiceno neq ''>
          <cfquery name="getassignment" datasource="#dts#">
              SELECT placementno FROM assignmentslip
              WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(checkexistrefno.rem40)#">
          </cfquery>
      <cfelse>
      	<cfquery name="getassignmentrefno" datasource="#dts#">
          SELECT brem6 FROM ictrantempcn
          WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
          and brem6<>''
          limit 1
        </cfquery>
      	<cfquery name="getassignment" datasource="#dts#">
          SELECT placementno FROM assignmentslip
          WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignmentrefno.brem6#">
        </cfquery>
      </cfif>
            
    <cfif type eq 'dn'>
        <cfquery name="getplacementno" datasource="#dts#">
            SELECT brem1 FROM ictrantempcn
            WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
            and brem1<>''
            and type = 'dn'
            limit 1
        </cfquery>  
        
        <cfif getplacementno.brem1 neq "">
            <cfset getassignment.placementno = getplacementno.brem1>
        </cfif>    
    </cfif>
      
      <cfquery name="getplacement" datasource="#dts#">
          SELECT location,po_no,jobpostype,supervisor FROM placement
          WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
      </cfquery> 
    
        <cfif getplacement.recordcount eq 0>
            <cfquery name="getictrantempcnbrem1" datasource="#dts#">
              SELECT brem1 FROM ictrantempcn
              WHERE uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
              and brem1<>''
              limit 1
            </cfquery>
            <cfquery name="getplacement" datasource="#dts#">
              SELECT location,po_no,jobpostype,supervisor FROM placement
              WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictrantempcnbrem1.brem1#">
            </cfquery> 
        </cfif>
      
      <cfquery name="getentity" datasource="#dts#">
          SELECT invnogroup FROM bo_jobtypeinv
          WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">
          AND jobtype = "#getplacement.jobpostype#"
      </cfquery>
      
      <cfquery name="getaddress" datasource="#dts#">
          SELECT * FROM invaddress
          WHERE invnogroup=<cfif getentity.invnogroup neq ''>
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
    	<cfelse>
    		<cfif left(getinvno.refno2,1) eq '5'>
				1
			<cfelseif left(getinvno.refno2,1) eq '6'>
				7
			<cfelseif left(getinvno.refno2,1) eq '2'>
				6
			<cfelse>
				3
        	</cfif>    	
    	</cfif>
      </cfquery> 
      
      <cfif getaddress.shortcode eq 'mss'>
            <cfset refnotype=1>
      <cfelseif getaddress.shortcode eq 'mbs'>
            <cfset refnotype=2>
      <cfelseif getaddress.shortcode eq 'tc'>    
      		<cfset refnotype=3>
      <cfelse>    
      		<cfset refnotype=4>
      </cfif>
      
      <!---<cfif checkexistrefno.rem40 eq '' and getaddress.shortcode eq ''>    
      		<cfset refnotype=4>
      </cfif>--->
      
      	<cfquery datasource="#dts#" name="getlastusedno">
                        select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
                        from refnoset
                        where type = '#tran#'
                        and counter = '#refnotype#'
            </cfquery>
            
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastusedno.tranno#" returnvariable="newnextNum" />
                <cfset actual_nexttranno = newnextNum>
                    <cfif (getlastusedno.refnocode2 neq "" or getlastusedno.refnocode neq "") and getlastusedno.presuffixuse eq refnotype>
                        <cfset nexttranno = getlastusedno.refnocode&actual_nexttranno&getlastusedno.refnocode2>
                    <cfelse>
                        <cfset nexttranno = actual_nexttranno>
                    </cfif>
                    <cfset tranarun_1 = getlastusedno.arun>
            
            <cfset form.refno = tostring(nexttranno)>

<!---</cfif>--->

<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = '#tran#'
			and counter = '#refnotype#'
</cfquery>
 
 	<cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1" and getGeneralInfo.arun eq "1">
    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
	<cfelse>
	<cfset newnextnum = refno>
	</cfif>
	
    <cfquery name="updaterefno" datasource="#dts#">
    UPDATE refnoset 
    SET lastUsedNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newnextnum#">
    where type = '#type#'
	and counter = '#refnotype#'
    </cfquery>

<cfset refno = form.refno>


<cfquery datasource="#dts#" name="getcustdetail">
		SELECT * FROM #target_arcust# 
		WHERE custno=<cfif lcase(tran) eq 'dn' and newcustno neq ''>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#newcustno#">
        <cfelse>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">
        </cfif>
</cfquery>



<cfset frem0 = trim(getcustdetail.name)>
<cfset frem1 = trim(getcustdetail.name2)>
<cfset frem2 = trim(getcustdetail.add1)>
<cfset frem3 = trim(getcustdetail.add2)>
<cfset frem4 = trim(getcustdetail.add3)>
<cfset frem5 = trim(getcustdetail.add4)>
<cfset frem6 = trim(getcustdetail.fax)>
<cfset frem7 = trim(getcustdetail.name)>
<cfset frem8 = trim(getcustdetail.name2)>
<cfset remark2 = trim(getcustdetail.attn)>
<cfset remark3 = trim(getcustdetail.dattn)>
<cfset remark4 = trim(getcustdetail.phone)>
<cfset remark12 = trim(getcustdetail.dphone)>
<cfset comm0 = getcustdetail.daddr1>
<cfset comm1 = getcustdetail.daddr2>
<cfset comm2 = getcustdetail.daddr3>
<cfset comm3 = getcustdetail.daddr4>
<cfset comm4 = getcustdetail.dfax>
<cfset agenno = getcustdetail.agent>
<cfset phonea = getcustdetail.phonea>
<cfset term = getcustdetail.term>
<cfset driver = "">
<cfset source = "">
<cfset job = "">
<cfset currcode = getcustdetail.currcode>
<cfset currrate = "1">
<cfif isdefined('form.taxincl')>
<cfset form.gross=form.gross-form.taxamt>
</cfif>
<cfset gross_bil = form.gross>
<cfset disp1 = val(form.dispec1)>
<cfset disp2 = val(form.dispec2)>
<cfset disp3 = val(form.dispec3)>
<cfset disc1_bil = val(form.disbil1)>
<cfset disc2_bil = val(form.disbil2)>
<cfset disc3_bil = val(form.disbil3)>
<cfset disc_bil = val(form.disamt_bil)>
<cfset net_bil = val(form.net)>
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
<cfif tran eq "CN">
<cfset credit_bil = grand_bil>
<cfset debit_bil = 0>
<cfelse>
<cfset debit_bil = grand_bil>
<cfset credit_bil = 0>
</cfif>

<cfif val(currrate) eq "0">
<cfset currrate = 1>
</cfif>

<cfset invgross = val(gross_bil) * val(currrate)>
<cfset discount1 = val(disc1_bil) * val(currrate)>
<cfset discount2 = val(disc2_bil) * val(currrate)>
<cfset discount3 = val(disc3_bil) * val(currrate)>
<cfset discount = val(disc_bil) * val(currrate)>
<cfset net = val(net_bil) * val(currrate)>
<cfset tax1 = val(tax1_bil) * val(currrate)>
<cfset tax = val(tax_bil) * val(currrate)>
<cfset grand = val(grand_bil) * val(currrate)>
<cfset debitamt = val(debit_bil) * val(currrate)>
<cfset creditamt = val(credit_bil) * val(currrate)>
<cfset ndate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfquery name="getpayperiod" datasource="payroll_main">
SELECT mmonth FROM gsetup 
WHERE comp_id="#replace(dts,'_i','')#"
</cfquery>

<cfquery name="getGsetup" datasource='#dts#'>
	SELECT * FROM gsetup 
</cfquery>
    
<cfset fperiod = numberformat(getpayperiod.mmonth,'00')>
<cfset wos_date = dateformat(ndate,'yyyy-mm-dd')>


<cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='#type#' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

		<cfif checkexistrefno.recordcount neq 0>
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = '#type#'
				and counter = '#refnotype#'
			</cfquery>
        
        <cfif getGeneralInfo.arun eq "1">
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefno.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="refno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno,rem15,rem40 FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = '#type#'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = refno>
		</cfif>
        </cfloop>
		<cfelse>
        <h3>The refno existed. Please enter new refno. <a href="##" onClick="history.go(-1);">Back</a></h3>
        <cfabort />
        </cfif>
        
        </cfif>
		
<!---<cfquery name="updaterate" datasource="#dts#">
update ictrantempcn 
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
uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>
<cfif taxincl neq "Y" and net neq 0>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictrantempcn
        set note_a=<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
        TAXPEC1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
        TAXAMT_BIL=round((AMT_BIL/#val(net_bil)#)*#val(tax1_bil)#,3),
        TAXAMT=round((AMT/#val(net)#)*#val(tax)#,3)
        where 
        type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    </cfquery>
</cfif>--->




<cfquery name="checkitemExist" datasource="#dts#">
select 
id 
from ictrantempcn 
where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

<cfquery name="checkitemExisttotal" datasource="#dts#">
select ifnull(count(id),1) as qty
from ictrantempcn 
where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
</cfquery>

<cfif checkitemExist.recordcount gt 0>
<cfset itemcountlist = valuelist(checkitemExist.id)>

<cfloop index="i" from="1" to="#checkitemExisttotal.qty#">
<!---<cfquery name="updateIctran" datasource="#dts#">
	update ictrantempcn set 
	itemcount='#i#',
	trancode='#i#'
	where 
	uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
	and id='#listgetat(itemcountlist,i)#';
</cfquery>--->
</cfloop>
</cfif>

<cfset rem15 = ''>
<cfset rem40 = ''>	

<cfquery name="getartranrem" datasource="#dts#">
SELECT rem15,rem40 FROM artran 
WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getinvno.refno2#"> 
</cfquery>

<cfif form.invoiceno neq ''>
	<cfquery name="getartranrem" datasource="#dts#">
    SELECT rem15,rem40 FROM artran 
    WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invoiceno#"> 
    </cfquery>
</cfif>

<cfif getartranrem.recordcount neq 0>
	<cfset rem15 = getartranrem.rem15>
	<cfset rem40 = getartranrem.rem40>
</cfif>

<cfif form.invoiceno eq ''>
<cfif getassignmentrefno.brem6 neq ''>
	<cfset rem15 = getassignmentrefno.brem6>
	<cfset rem40 = getassignmentrefno.brem6>
</cfif>
</cfif>

<cfif getaddress.shortcode neq ''>
	<cfset rem30 = '#getaddress.shortcode#'>
<cfelse>
	<cfset rem30 = 'APMR'>
</cfif>
    
<cfset newdate = createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>

<cfquery name="insertartran" datasource="#dts#">
INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,
agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,
tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,
disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,
grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,
rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,
taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,
userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,
    rem11,checkno,CS_PM_CASHCD,rem9,creditcardtype2,rem15,rem40,rem30,returnreason,rem5)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">,
<cfif form.invoiceno eq ''>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinvno.refno2#">,
<cfelse>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invoiceno#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
<cfif lcase(tran) eq 'dn' and newcustno neq ''>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#newcustno#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#agenno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#source#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#job#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currrate#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#debit_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#credit_bil#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#disp3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxp1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem5#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem6#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem7#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem8#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#remark12#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm0#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#comm4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxincl#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#note#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now(),
"",
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#frem0#">,
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#driver#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.area#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#currcode#">,
'0',<!---#val(form.cash)#--->
'0',<!---#val(form.cheque)#--->
'0',<!---#val(form.credit_card1)#--->
'0',<!---#val(form.credit_card2)#--->
'0',<!---#val(form.debit_card)#--->
'0',<!---#val(form.voucher)#--->
'0',<!---#val(form.deposit)#--->
"",
'',<!---#val(form.checkno)#--->
'0',<!---#val(form.cashcamt)#--->
'',<!---#val(form.rem9)#--->
"",<!---#val(form.cctype2)#--->
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem15#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem40#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#rem30#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reason#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.po_no#">
)
</cfquery>

<cfquery name="updatebackuuid" datasource="#dts#">
UPDATE refnoset set uuidtemp = "" WHERE type = '#type#'
and counter = '#refnotype#'
</cfquery>

<cfquery name="updaterefno" datasource="#dts#">
UPDATE ictrantempcn set refno = "#refno#"
where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="insertbody" datasource="#dts#">
INSERT INTO ictran 

(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,brem5,brem6)

SELECT 

    TYPE, '#refno#' as REFNO, REFNO2, TRANCODE, <cfif lcase(tran) eq 'dn' and newcustno neq ''>'#newcustno#' as </cfif>CUSTNO, '#fperiod#' as FPERIOD, <!---"#dateformat(newdate,'yyyy-mm-dd')#" as---> WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, '#frem0#' as NAME, DEL_BY, VAN, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,brem5,brem6
FROM ictrantempcn
where 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfquery name="getbrem6trancode" datasource="#dts#">
SELECT brem1,brem6,trancode FROM ictrantempcn
WHERE 
type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
</cfquery>

<cfloop query="getbrem6trancode">
    <cfquery name="updateJO" datasource="#dts#">
    UPDATE ictran
    SET brem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.placementno#brem6##trancode#')#">
    WHERE 
    trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#">
    AND brem6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#brem6#">
    AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
    AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
    </cfquery>
</cfloop>
    
<cfif form.invoiceno eq '' or lcase(tran) eq 'dn'>
    
<cfquery name="getcustgsttype" datasource="#dts#">
select arrem5 from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfquery name="getSum_ictran" datasource="#dts#">
    SELECT refno,type,round((sum(amt_bil)*#getGsetup.gst#/100),2) AS sumTaxAmt
    FROM ictran
    WHERE type = '#tran#' 
    AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#" />
    AND (void = '' or void is null)
    AND note_a = 'SR'
    GROUP BY refno
</cfquery>
    
<cfset getsum.sumtaxtotal = getSum_ictran.sumTaxAmt>

</cfif>

<cflocation url="/default/transaction/CNdone.cfm?type=#type#&refno=#refno#" addtoken="no">
 	
    </body>
    </html>