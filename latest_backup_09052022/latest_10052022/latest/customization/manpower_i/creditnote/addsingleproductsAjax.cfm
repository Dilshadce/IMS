<cfsetting showdebugoutput="no">
    
<cfinclude template="creditnotescript.cfm">
    
</head>

<cfset refnotype=1>
<cfset tran = form.tran>

<cfquery name="getGsetup" datasource='#dts#'>
	SELECT * FROM gsetup 
</cfquery>

<!---<cfif left(dts,12) eq 'manpowertest'>--->


      <cfquery name="checkexistrefno" datasource="#dts#">
      select rem40 from artran where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#">
          and type in ('inv','cn','dn')
      </cfquery>
      
      <cfquery name="getassignment" datasource="#dts#">
          SELECT placementno FROM assignmentslip
          WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(checkexistrefno.rem40)#">
      </cfquery>
      
      <cfquery name="getplacement" datasource="#dts#">
          SELECT location,po_no,jobpostype,supervisor FROM placement
          WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
      </cfquery> 
      
      <cfquery name="getentity" datasource="#dts#">
          SELECT invnogroup FROM bo_jobtypeinv
          WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">
          AND jobtype = "#getplacement.jobpostype#"
      </cfquery>
      
      <cfquery name="getaddress" datasource="#dts#">
          SELECT * FROM invaddress
          WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
      </cfquery> 
      
      <cfif getaddress.shortcode eq 'mbs'>
            <cfset refnotype=2>
      <cfelseif getaddress.shortcode eq 'tc'>    
      		<cfset refnotype=3>
      </cfif>
      
     <cfif checkexistrefno.rem40 eq ''>    
      		<cfset refnotype=4>
      </cfif>
      
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

<cfif lcase(tran) eq 'dn'>
    <cfset newcustno = form.newcustno>
</cfif>
<cfset custno = form.custno>
<cfset invno = form.invno>
<cfset refno = form.refno>
<cfset uuid = form.uuid>
    
<cfset gstper = form.gstrate>

<cfquery name="checkitemExist" datasource="#dts#">
    select 
    refno,fperiod,wos_date
    from ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
	and refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
    and type = '#tran#'
</cfquery>

<cfquery name="getinfo" datasource="#dts#">
SELECT MAX(itemcount) AS itemcount, MAX(trancode) AS trancode
FROM ictrantempcn as a
where uuid ='#uuid#'
and type = '#tran#'
limit 1
</cfquery>

<cfif checkitemExist.wos_date eq '' >
	<cfset checkitemExist.wos_date = dateformat(form.wos_date,'yyyy-mm-dd')>
</cfif>

<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantempcn
	(TYPE, REFNO,REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, 
    CURRRATE, ITEMCOUNT, ITEMNO, DESP, QTY_BIL, PRICE_BIL, UNIT_BIL, 
    AMT1_BIL, AMT_BIL,  QTY, PRICE, UNIT, 
    AMT1, AMT,  QTY1,UUID,brem1)
    VALUES(
	'#tran#' , 
    '#refno#', 
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bosinvno#">,
    "#val(getinfo.trancode)+1#", 
    <cfif lcase(tran) eq 'dn' and form.newcustno neq ''>
        "#form.newcustno#", 
    <cfelse>
        "#form.custno#", 
    </cfif>    
    "#checkitemExist.fperiod#", 
    "#dateformat(form.wos_date,'yyyy-mm-dd')#", 
    '1', 
    "#val(getinfo.itemcount)+1#", 
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">, 
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">, 
    <cfqueryparam cfsqltype="cf_sql_double" value="#form.qty#">, 
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.price#">, 
    <cfelse>
        <cfif left(form.price,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.price#">, 
        <cfelse>
    	   <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.price)*-1#">,
        </cfif>
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="Unit">, 
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
    <cfelse>
        <cfif left(form.price,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
        <cfelse>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#val(form.amount)*-1#">,
            </cfif>
    </cfif>
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
    <cfelse>
        <cfif left(form.amount,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
        <cfelse>
    	   <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.amount)*-1#">,
        </cfif>
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_double" value="#form.qty#">, 
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.price#">, 
    <cfelse>
        <cfif left(form.price,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.price#">, 
        <cfelse>
    	   <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.price)*-1#">,
        </cfif>
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="Unit">, 
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
    <cfelse>
        <cfif left(form.amount,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
        <cfelse>
    	   <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.amount)*-1#">,
        </cfif>
    </cfif>
    <cfif tran eq 'DN'>
    	<cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
    <cfelse>
        <cfif left(form.amount,1) eq '-'>
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.amount#">, 
        <cfelse>
    	   <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.amount)*-1#">,
        </cfif>
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_double" value="#form.qty#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addsingleJO#">  
	)
</cfquery>

<cfset smonth = mid(form.startdate,4,2)>
<cfif left(smonth,1) eq '0'> 
<cfset smonth = right(smonth,1)>
</cfif>

<cfset emonth = mid(form.completedate,4,2)>
<cfif left(emonth,1) eq '0'> 
<cfset emonth = right(emonth,1)>
</cfif>

<cfset sdate = createdate(right(form.startdate,4),smonth,left(form.startdate,2))>
<cfset edate = createdate(right(form.completedate,4),emonth,left(form.completedate,2))>

<!---<cfif len(invno) neq 5 or left(refno,1) eq '7'>
    <cfquery name="setperiod" datasource="#dts#">
    UPDATE ictrantempcn
    SET brem3= "#dateformat(sdate,'dd Mmm YYYY')#-#dateformat(edate,'dd Mmm YYYY')#"
    WHERE trancode = #val(getinfo.trancode)+1# 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (brem3='' or brem3 is null)
    </cfquery>
</cfif>--->

<cfquery name="setperiod" datasource="#dts#">
UPDATE ictrantempcn
SET brem6= "#form.assignrefno#"
<cfif len(invno) neq 5 or left(refno,1) eq '7'>
    ,brem3= "#dateformat(sdate,'dd Mmm YYYY')#-#dateformat(edate,'dd Mmm YYYY')#"
</cfif>
WHERE trancode = #val(getinfo.trancode)+1# 
AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
and type = '#tran#'
</cfquery>

<cfinclude template="manpowergstcalc.cfm">

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt_bil) as sumsubtotal,count(itemno) as countitemno,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
and type = '#tran#'
</cfquery>
    
<cfif lcase(tran) eq 'dn'>
    
<cfquery name="getcustgsttype" datasource="#dts#">
select arrem5 from #target_arcust# where custno='#form.custno#'
</cfquery>

<cfif form.newcustno neq ''>
    <cfquery name="getcustgsttype" datasource="#dts#">
    SELECT arrem5 FROM #target_arcust# WHERE custno = "#form.newcustno#"
    </cfquery>
</cfif>
    
</cfif>
    
<cfset check = false>
    
<cfif form.invno neq ''>
    
<cfif lcase(tran) eq 'cn'>
    
<cfquery name="checktotaltemp" datasource="#dts#">
    SELECT sum(amt_bil*-1) totalbill FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
</cfquery>
    
<cfelse>
    
<cfquery name="checktotaltemp" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
</cfquery>
    
</cfif>
    
<cfquery name="checktotalbefore" datasource="#dts#">
    SELECT sum(amt_bil) totalbill FROM ictran 
    WHERE type = '#tran#' 
    AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#" />
    AND (void = '' or void is null)
</cfquery>
    
<cfset check = checktotaltemp.totalbill neq checktotalbefore.totalbill>
    
</cfif>

<cfif form.invno eq '' or lcase(tran) eq 'dn' or check>
    
<cfquery name="getSum_ictran" datasource="#dts#">
    SELECT refno,type,round((sum(amt_bil)*#gstper#/100),2) AS sumTaxAmt
    FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    AND note_a = 'SR'
    GROUP BY refno
</cfquery>
    
<cfset getsum.sumtaxtotal = getSum_ictran.sumTaxAmt>
    
<!---<cfquery name="getgst" datasource="#dts#">
    SELECT refno,taxpec1
    FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    AND taxpec1<>0
    GROUP BY taxpec1
</cfquery>
    
<cfif getgst.recordcount neq 0>
    <cfset gstper = val(getgst.taxpec1)>
</cfif>--->
    
<cfelse>
    
<cfquery name="getSum_artran" datasource="#dts#">
    SELECT tax_bil*-1 AS sumTaxAmt,taxp1
    FROM artran
    WHERE refno = (
    SELECT refno2 FROM ictrantempcn 
    WHERE type = '#tran#' 
    AND uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
    AND (void = '' or void is null)
    GROUP BY refno2
    )    
</cfquery>
    
<cfif getSum_artran.sumTaxAmt neq "">
    <cfset getsum.sumtaxtotal = getSum_artran.sumTaxAmt>
    <cfset gstper = val(getSum_artran.taxp1)>
</cfif>
    
</cfif>

<cfinclude template="manpowergstcalc.cfm">

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
<input type="hidden" name="hidtaxper" id="hidtaxper" value="#numberformat(gstper,'_')#" />


<cfquery name="getictrantemp" datasource="#dts#">
    SELECT * FROM ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    and type = '#tran#' 
    order by length(trancode),trancode,refno2
</cfquery>

<body class="container">
    <cfinclude template="creditnotetablebody.cfm">
</body>

</cfoutput>

