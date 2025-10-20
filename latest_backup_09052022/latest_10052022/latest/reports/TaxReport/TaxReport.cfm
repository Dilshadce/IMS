<cfif form.entity eq ''>
    <script>
        alert("Please select an Entity.");
        window.close();
    </script>
    <cfabort>
</cfif>
    
<cfif form.periodfrom eq '' and form.periodto eq ''>
    <script>
        alert("Please select a Period From or Periof To.");
        window.close();
    </script>
    <cfabort>
</cfif>

<cfif dts eq 'manpowertest_i'>
    <cfsetting showdebugoutput="true">
</cfif>
    
<cfset dsname = "#replace(dts,'_i','_p')#">
    
<cfquery datasource="#dsname#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
    
<cfquery datasource="#dts#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
    
<!--- QUERY FOR placement no--->
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>
    
<cfif form.entity eq 'mss'>
    <cfset cnprefix = 'cn5'>
    <cfset dnprefix = 'in5'>
    <cfset invprefix = '5'>
<cfelseif form.entity eq 'mbs'>
    <cfset cnprefix = 'cn6'>
    <cfset dnprefix = 'in6'>
    <cfset invprefix = '6'>
<cfelseif form.entity eq 'tc'>
    <cfset cnprefix = 'cn2'>
    <cfset dnprefix = 'in2'>
    <cfset invprefix = '2'>
<cfelseif form.entity eq 'apmr'>
    <cfset cnprefix = 'cn7'>
    <cfset dnprefix = 'in7'>
    <cfset invprefix = '7'>
</cfif>

<cfoutput>
    
<cfquery name="getData" datasource="#dts#">
select date_format(art.wos_date,'%e/%c/%Y') "Document Date",art.refno "Document Number",note_a "Tax Code",ict.custno "Cust/Vend ID",
arc.name "Cust/Vend Name",p.name "Cand Name",ici.dballname "Item",
case when note_a='sr' then amt_bil else 0 end "Tax Base",
case when note_a<>'sr' then amt_bil else 0 end "Non-Taxable",taxamt_bil "Tax",amt_bil+taxamt_bil "Document Amount",
#getComp_qry.myear# as "Fiscal Year",art.fperiod "Fiscal Period"
from ictran ict
left join artran art
on ict.refno=art.refno and ict.type=art.type
left join arcust arc
on ict.custno=arc.custno
left join (SELECT *  FROM (SELECT *  FROM (SELECT itemno as dballid,desp as dballname FROM icitem
            ORDER by itemno) as a
                    union 
                    SELECT *  FROM (
                    SELECT cate as dballid, desp as dballname FROM iccate
                    order by cate
                    ) as b
                    union 
                    SELECT *  FROM (
                    SELECT
                    shelf as dballid, desp as dballname from icshelf
                    order by length(shelf),shelf
                    ) as c
                    union 
                    SELECT *  FROM (
                    SELECT
                    'ALLAWEXC' as dballid, 'All AW EXCEPT 0%' as dballname
                    ) as e
                    union 
                    SELECT *  FROM (
                    SELECT
                    servi as dballid, desp as dballname from icservi
                    order by length(servi),servi
                    ) as f
            )as d
) ici on ict.itemno=ici.dballid
left join #dsname#.pmast p
on ict.brem5=p.empno
    
where art.type in ('inv','cn','dn') and art.fperiod<>99 
and ict.type in ('inv','cn','dn') and ict.fperiod<>99 
and (art.void is null or art.void='')
and (ict.void is null or ict.void='')
and itemno<>'name'
<cfif form.periodfrom neq '' and form.periodto neq ''>
    and art.fperiod >= #form.periodfrom#
    and art.fperiod <= #form.periodto#
<cfelseif form.periodfrom neq ''>
    and art.fperiod = #form.periodfrom#
<cfelseif form.periodto neq ''>
    and art.fperiod = #form.periodto#
</cfif>
and (left(art.refno,3)='#cnprefix#' or left(art.refno,3)='#dnprefix#' or left(art.refno,1)='#invprefix#')
order by art.fperiod,art.wos_date,art.refno
        

</cfquery>
                      
</cfoutput>
    
<!---Excel Format--->
<cfset s67 = StructNew()>
<cfset s67.dataformat="_(* ##,####0.00_);_(* (##,####0.00);_(* \-??_);_(@_)">
<!---Excel Format--->

<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report\">

<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">

<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data---> 
    
<!---<cfset data = SpreadSheetNew(true)> 

<cfset SpreadSheetAddRow(data, "Document Date,Document Number,Tax Code,Cust/Vend ID,Cust/Vend Name,Cand Name,Item,Tax Base,Non-Taxable,Tax,Document Amount,Fiscal Year,Fiscal Period")>

<cfset SpreadSheetAddRows(data, getdata)>
    
<cfset SpreadSheetFormatCellRange(data, s67, 2, 8, getdata.recordcount+2, 8)>
<cfset SpreadSheetFormatCellRange(data, s67, 2, 9, getdata.recordcount+2, 9)>
<cfset SpreadSheetFormatCellRange(data, s67, 2, 10, getdata.recordcount+2, 10)>
<cfset SpreadSheetFormatCellRange(data, s67, 2, 11, getdata.recordcount+2, 11)>--->
    
<cfspreadsheet action="write" sheetname="Tax Report" filename="#HRootPath#\Excel_Report\Tax_Report#timenow#.xlsx" query="getData" overwrite="true"> 
    
<cfif form.periodfrom neq '' and form.periodto neq ''>
    <cfset filename = "Tax Report #ucase(form.entity)# #form.periodfrom#-#form.periodto#_#timenow#">
<cfelseif form.periodfrom neq ''>
    <cfset filename = "Tax Report #ucase(form.entity)# #form.periodfrom# #timenow#">
<cfelseif form.periodto neq ''>
    <cfset filename = "Tax Report #ucase(form.entity)# #form.periodto# #timenow#">
</cfif>

<cfheader name="Content-Disposition" value="inline; filename=#filename#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\Tax_Report#timenow#.xlsx">