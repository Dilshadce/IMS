<cffunction name="datenew" returntype="date">
	        <cfargument name="olddate" type="any" required="yes">
            <cfset olddate = trim(olddate)>
            <cfset newdate = createdate(left(olddate,4),mid(olddate,5,2),right(olddate,2))>
			<cfreturn newdate>
	    </cffunction>
<cfinclude template="/object/dateobject.cfm">
<cfif isdefined('form.uploadkpi')>

		<cfset currentDirectory = "/uploadfile/"& dts>
        <cfset currentDirectory = expandpath(currentdirectory)>
        <cfif DirectoryExists(currentDirectory) eq false>
        <cfdirectory action = "create" directory = "#currentDirectory#" >
        </cfif>
        <cffile action="upload" filefield="uploadkpi" destination="#currentDirectory#" nameconflict="makeunique">
        <cfset filename = "/uploadfile/"&dts&"/"&file.ServerFile>
        <cfif right(file.ServerFile,3) neq "xls">
        <cfoutput>
        <script type="text/javascript">
		alert('Only .xls file is allowed!');
        </script>
        <cfabort>
        </cfoutput>
		</cfif>
        
        <cfif right(file.ServerFile,3) eq "csv">
        <cfinclude template="/csv.cfm">
        <cfset arrdata = CSVToArray(ExpandPath(filename)) >
        <cfelse>
        <cfset filename = expandpath(filename)>
        <cfset objPOI = CreateObject( 
		"component", 
		"POIUtility" 
		).Init() 
		/>
        
        <cfset arrSheets = objPOI.ReadExcel( 
		FilePath = "#filename#",
		HasHeaderRow = false
		) />
        </cfif>       
</cfif>
<cfset datenow = now()>
<cfif right(file.ServerFile,3) eq "xls">
<cfloop
		index="intSheet"
		from="1"
		to="#ArrayLen( arrSheets )#"
		step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
<!--- <cfdump var="#qCell#"> --->

<cfquery name="getgsetup" datasource="#dts#">
SELECT df_cs_cust FROM gsetup
</cfquery>

<cfif getgsetup.df_cs_cust neq "">
<cfset defaultcust = getgsetup.df_cs_cust>
<cfelse>
<cfset defaultcust = "3000/CS1">
</cfif>



<cfset uuid = createuuid()>
<cfloop query="objSheet.Query">
<cfset qCell = objSheet.Query>
	<cfif qCell.currentrow gt 2>
    <cfif qCell.column1 neq "">
    <cfquery name="inserttemp" datasource="#dts#">
    INSERT INTO postemp (
    sno,
    col2,
    wos_date,
    itemno,
    refno,
    location,
    costprice,
    sellprice,
    discountinfo,
    disamt,
    qty,
    subamt,
    subcost,
    taxamt,
    disctotal,
    category,
    catecode,
    salescode,
    costcode,
    created_on,
    created_by,
    uuid
    )
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column1#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column2#">,
    <cfif len(qCell.column3) eq 10>
    "#dateformatnew(qCell.column3,'yyyy-mm-dd')#",
    <cfelse>
    "#dateformat(qCell.column3,'yyyy-mm-dd')#",
    </cfif>
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column4#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column5#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column6#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column7#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column8#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column9#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column10#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column11#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column12#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column13#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column14#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column15#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column16#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column17#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column18#">, 
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qCell.column19#">, 
    now(),
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
    )
    </cfquery>
	</cfif>
    </cfif>
</cfloop>
</cfloop>

<cfquery name="getlist" datasource="#dts#">
SELECT refno FROM postemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> group by refno
</cfquery>

<cfloop query="getlist">
<cfquery name="validexist" datasource="#dts#">
SELECT refno FROM artran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="POS#getlist.refno#">
</cfquery>

<cfif validexist.recordcount eq 0>
<cfquery name="getlistdata" datasource="#dts#">
SELECT * FROM postemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlist.refno#">
</cfquery>

<cfloop query="getlistdata">
<cfset code = getlistdata.currentrow>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(getlistdata.wos_date,'yyyy-mm-dd')#" returnvariable="fperiod"/>

<cfquery name="insertictran" datasource="#dts#">
    INSERT INTO ICTRAN
    (fperiod,refno,refno2,type,custno,trancode,itemcount,wos_date,itemno,desp,brem1,brem2,brem3,brem4,brem8,brem9,location,qty,qty_bil,price,price_bil,amt,amt_bil,amt1,amt1_bil,currrate,note_a,taxpec1,taxamt,taxamt_bil,disamt,disamt_bil,taxincl)
    VALUES
    ('#fperiod#',
    "POS#getlistdata.refno#",
     "",
     'CS',
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#defaultcust#">,
     '#code#',
     '#code#',
     "#dateformat(getlistdata.wos_date,'yyyy-mm-dd')#",
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.itemno#">,
      <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.itemno# - #getlistdata.catecode#">,   
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.category#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.salescode#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.costcode#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.costprice#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.subcost#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.discountinfo#">,
     <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlistdata.location#">,
     "#numberformat(getlistdata.qty,'._____')#",
     "#numberformat(getlistdata.qty,'._____')#",
     "#numberformat(getlistdata.sellprice,'._____')#",
     "#numberformat(getlistdata.sellprice,'._____')#",
     "#numberformat(val(getlistdata.subamt)-val(getlistdata.disctotal),'._____')#",
     "#numberformat(val(getlistdata.subamt)-val(getlistdata.disctotal),'._____')#",
     "#numberformat(getlistdata.subamt,'._____')#",
     "#numberformat(getlistdata.subamt,'._____')#",
     '1','SR','7',
     "#numberformat(getlistdata.taxamt,'._____')#",
    "#numberformat(getlistdata.taxamt,'._____')#",
    "#numberformat(getlistdata.disctotal,'._____')#",
    "#numberformat(getlistdata.disctotal,'._____')#",
    "T"
       )
    </cfquery>
</cfloop>

<cfquery name="getdetail" datasource="#dts#">
SELECT sum(ROUND(amt_bil+0.000001,5)) as totalamt,sum(ROUND(taxamt+0.0000001,5)) as totaltax,fperiod,custno,wos_date FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="POS#getlist.refno#">
AND type = "CS"
</cfquery>

 <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="CS">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="POS#getlist.refno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.custno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getdetail.wos_date,'yyyy-mm-dd')#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="POS Sales">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totaltax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totaltax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totaltax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totaltax#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="7">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getdetail.totalamt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SALES">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SALES">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SR">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="POS Sales">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SALES">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="SGD">
        )
        </cfquery>

</cfif>

</cfloop>

<cfoutput>
<script type="text/javascript">
alert('Import Success!');
window.location.href='importpos.cfm';
</script>
</cfoutput>
<cfelse>
<script type="text/javascript">
alert('Upload file is required!');
window.location.href='importpos.cfm';
</script>
</cfif>


