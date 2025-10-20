<cfif IsDefined("url.debug")>
	<cfabort>
</cfif>

<noscript>
	WARNING! Javascript has been disabled or is not supported in this browser.
    <br>Please enable Javascript in your browser.
</noscript>

<cffunction name="findCurrentSetInv" output="true">
	<cfargument name="input" type="query" required="yes">
	<cfargument name="refno" type="string" required="yes">
	<cfset prefixRefno=left(arguments.refno,3)>
	<cfif left(input.invno,3) eq prefixRefno>
		<cfreturn 1>
	<cfelseif left(input.invno_2,3) eq prefixRefno>
		<cfreturn 2>
	<cfelseif left(input.invno_3,3) eq prefixRefno>
		<cfreturn 3>
	<cfelseif left(input.invno_4,3) eq prefixRefno>
		<cfreturn 4>
	<cfelseif left(input.invno_5,3) eq prefixRefno>
		<cfreturn 5>
	<cfelse>
		<cfreturn 6>
	</cfif> 
</cffunction>

<cfset trancode="#lcase(tran)#no">
<cfset prefix="#lcase(tran)#code">
<cfset suffix="#lcase(tran)#no2">

<cfquery name="getGsetup" datasource="#dts#">
  	SELECT  invoneset,#prefix# AS prefix,#trancode#,#suffix# AS suffix,
			<cfif tran eq "INV">
            	<cfloop from="2" to="6" index="i">#prefix#_#i#,#trancode#_#i#,#suffix#_#i#,</cfloop>
            </cfif>
            compro,compro2,compro3,compro4,compro5,compro6,compro7,compro8,compro9,compro10,
            gstno,comuen,bcurr
            <cfloop from="5" to="11" index="i">,rem#i#</cfloop> 
    FROM gsetup; 
</cfquery>

<cfquery name="getGsetup2" datasource='#dts#'>
  	SELECT CONCAT(',.',REPEAT('_',Decl_Uprice)) AS Decl_Uprice,
    	   CONCAT(',.',REPEAT('_',Decl_Discount)) AS Decl_Discount,
           CONCAT(',.',REPEAT('_',Decl_TotalAmt)) AS Decl_TotalAmt 
    FROM gsetup2;
</cfquery>

<cfset tranPrefix=getGsetup.prefix>
<cfset tran_suffix=getGsetup.suffix>

<cfif tran eq "RC" or tran eq "PR" or tran eq "RQ" or tran eq "PO">
	<cfset ptype=target_apvend>
<cfelse>
	<cfset ptype=target_arcust>
</cfif>

<cfquery name="ClearICBil_M" datasource="#dts#">
    TRUNCATE r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	TRUNCATE r_IcBil_S
</cfquery>


<!---Function: SELECT artran --->
<cfinclude template="/billformat/default/newDefault/MYR/customized/selectArtran.cfm">

<cfquery name="getUserName" datasource="main">
	SELECT username 
    FROM users 
    WHERE userid = '#getHeaderInfo.userid#' 
    AND userdept = '#dts#'
</cfquery>


<cfif IsDefined('url.printBill')>
<cfelseif IsDefined('url.nexttranno')> 
	<cfquery name="updatePrinted" datasource="#dts#">
    	UPDATE artran 
        SET 
        	printed = 'Y' 
        WHERE refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#" >
        AND type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
    </cfquery>
<cfelse>
    <cfquery name="updatePrinted" datasource="#dts#">
    	UPDATE artran 
        SET 
        	printed = 'Y' 
        WHERE refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">) 
        AND type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    </cfquery>
</cfif>
<cfset j = 1>
<cfset k = 0>

<cfloop query="getHeaderInfo">
 
 	<!---Function: SELECT address --->
	<cfinclude template="/billformat/default/newDefault/MYR/customized/selectAddress.cfm">   
	
	<cfif k neq 0>
		<cfquery name="update" datasource="#dts#">
			UPDATE r_icbil_s
			SET 
            	counter_2 = #k#
			WHERE No = #j-1#;
		</cfquery>
	</cfif>
	<cfset k = k+1>
    
	<!---Function: INSERT artran --->
	<cfinclude template="/billformat/default/newDefault/MYR/customized/insertArtran.cfm">
	
	<!---Function: SELECT ictran --->
	<cfinclude template="/billformat/default/newDefault/MYR/customized/selectIctran.cfm">
    
    <cfif getBodyInfo.recordCount EQ 0>
		<cfquery name="InsertICBil_S" datasource='#dts#'>
            INSERT INTO r_icbil_s (SRefno, No, Desp, TaxCode)
            VALUES (	
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#j#">,
                        " ",
                        " " 
                   )
        </cfquery>
        <cfset j = j + 1>
    <cfelse>
    	<cfset toRecalculateRunningNumber = 0>
        <cfloop query="getBodyInfo">
            <cfif getBodyInfo.nodisplay NEQ 'Y'>
                <cfquery name="getserial" datasource="#dts#">
                    SELECT * 
                    FROM iserial 
                    WHERE refno = '#getBodyInfo.refno#' 
                    AND type = '#getHeaderInfo.type#' 
                    AND itemno = '#getBodyInfo.itemno#' 
                    AND trancode = '#getBodyInfo.itemcount#';
                </cfquery>
                <cfset mylist1 = "">
                <cfloop query="getserial">
					<cfif mylist1 eq "">
                        <cfset mylist1 = getserial.serialno>
                    <cfelse>
                        <cfset mylist1 = mylist1&", "&getserial.serialno>
                    </cfif>
                </cfloop>
                
                <cfset iteminfo = arraynew(1)>
                <cfif getBodyInfo.desp EQ '' and getBodyInfo.despa EQ '' and replace(tostring(getBodyInfo.comment),chr(10)," ","all") EQ ''>
                    <cfset iteminfo[1] = ' '>
                <cfelse>
                    <cfset iteminfo[1] = getBodyInfo.desp>
                </cfif>
                
                <cfset iteminfo[2] = getBodyInfo.despa>
                <cfset iteminfo[3] = replace(tostring(getBodyInfo.comment),chr(10)," ","all")>
                <cfif mylist1 neq "">
                    <cfset iteminfo[4] = "Serial No: "&mylist1>
                <cfelse>
                    <cfset iteminfo[4] = "">
                </cfif>
                <cfset info=''>	        
                <cfloop index="a" from="1" to="4">
                    <cfif iteminfo[a] NEQ "" AND iteminfo[a] NEQ "XCOST">
                        <cfif a NEQ 4>
                            <cfset info = info&iteminfo[a]&chr(10)>
                        <cfelse>
                            <cfset info = info&iteminfo[a]>
                        </cfif>
                    </cfif>
                </cfloop>
                    
                <cfif info NEQ "">
                    <cfset str = ListGetAt(info,1,chr(13)&chr(10))>
                <cfelse>
                    <cfset str ="">
                </cfif>
                <cfset recordcnt = ListLen(info,chr(13)&chr(10))>
                
		<cfset toRecalculateRunningNumber = toRecalculateRunningNumber + 1>
                <cfif getbodyinfo.photo neq "">
		<cfset itemphoto='/images/#dts#/#getbodyinfo.photo#'>
		</cfif>
                <!---Function: INSERT ictran --->
		<cfquery name="InsertICBil_S" datasource='#dts#'>
    INSERT IGNORE INTO r_icbil_s (	no, sRefNo, itemNo, aitemno, desp, despa, sn_no, comment, 
                                    unit, qty, price, amt, dispec1, dispec2, dispec3, itemdis_bil, 
                                    taxpec1, taxpec2, taxpec3, taxamt, taxCode, 
                                    brem1, brem2, brem3, brem4,
                                    qty1, qty2, qty3, qty4, qty5, qty6, qty7,
                                    titledesp, location, 
                                    counter_1, counter_2, counter_3, counter_4, photo)
                            
    VALUES ( 	<cfqueryparam cfsqltype="cf_sql_decimal" value="#j#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.refno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.itemno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.aitemno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(str)#">, 	
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.despa)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(mylist1)#">,																					
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.comment)#">,
                    
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.unit_bil#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.qty_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.price_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.amt_bil)#">,
                <cfloop index='i' from='1' to='3'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.dispec#i#'))#">,
                </cfloop>
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.disamt_bil)#">,
                
                <cfloop index='i' from='1' to='3'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.taxpec#i#'))#">,
                </cfloop>
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.taxamt_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.note_a#">,
                
                <cfloop index='i' from='1' to='4'>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getBodyInfo.brem#i#')#">,
                </cfloop>  
                
                <cfloop index='i' from='1' to='7'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.qty#i#'))#">,
                </cfloop>
                
                '', 
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.location)#">,
                
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#toRecalculateRunningNumber#">,
                '',
                '',
                '',
                <cfif IsDefined('itemphoto')>
                	'#itemphoto#'
                <cfelseif getBodyInfo.photo NEQ ''>
                	'/images/#dts#/#getBodyInfo.photo#'
                <cfelse>
                	''    
                </cfif>
           )
</cfquery>
                <cfset j = j + 1>
                
                <cfif recordcnt GT 1 and billname neq "esasia_iCBIL_QUOT1">
                    <cfloop index="i" from="2" to="#recordcnt#" >
                        <cfset str = ListGetAt(info,i,chr(13)&chr(10))>
                        <cfset str1 = Replace(Left(str,1)," ","")>
                        <cfset count = Len(str) - 1>
                        <cfif count LTE 0>
                            <cfset count = 1>
                        </cfif>
                        <cfset str2 = Right(str,count)>
                        <cfset str = str1 & str2>
                        
                        <cfif str NEQ "">
                            <cfquery name="InsertICBil_S" datasource='#dts#'>
                                INSERT INTO r_icbil_s (SRefno, No, Desp)
                                VALUES (	
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.refno#">,
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#j#">,
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#str#"> 
                                       )
                            </cfquery>
                            <cfset j = j + 1>
                        </cfif>
                    </cfloop>
                </cfif><!---CLOSING TAG: recordcnt GT 1--->	
			</cfif><!---CLOSING TAG: No Display---> 
		</cfloop><!---CLOSING TAG: getBodyInfo--->        
	</cfif><!---CLOSING TAG: BLANK getBodyInfo--->       
</cfloop><!---CLOSING TAG: getHeaderInfo--->

<cfquery name="update" datasource="#dts#">
	UPDATE r_icbil_s
	SET 
    	counter_2 = #k#
	WHERE no = #j-1#
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
  	SELECT r_icbil_m.*, r_icbil_s.*, CAST(r_icbil_s.comment AS BINARY) AS Cmd
  	FROM r_icbil_m, r_icbil_s 
  	WHERE r_icbil_m.Refno = r_icbil_s.SRefno 
	ORDER BY r_icbil_s.no;
</cfquery>

<cfoutput>
	<cfset thisPath = ExpandPath("/billformat/#dts#/companyLogo.jpg")>
	<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

	<cfif FileExists('#thisDirectory#companyLogo.jpg') EQ 'NO'>
		<cfset companyLogo=''>
	<cfelse>
		<cfset companyLogo='/billformat/#dts#/companyLogo.jpg'>
	</cfif>
</cfoutput>

<cfset fname=billname&".cfr">
<cfquery name="checkFormatType" datasource="#dts#">
	SELECT format 
    FROM customized_format 
    WHERE file_name='#BillName#';
</cfquery>

<cfif checkFormatType.format NEQ ''>
	<cfset formatVariable = checkFormatType.format> 
<cfelse>
	<cfset formatVariable = 'PDF'>
</cfif> 
    
<!---Function: INSERT ictran --->
<cfquery name="getcninvdate" datasource="#dts#">
	SELECT wos_date 
	FROM artran
	WHERE refno = "#getheaderinfo.rem49#" and type="INV";
</cfquery>

<cfif tran eq "tr">
<cfquery name="gettradd" datasource="#dts#">
	SELECT * FROM iclocation where location="#getheaderinfo.rem1#"
</cfquery>

<cfquery name="gettradd2" datasource="#dts#">
	SELECT * FROM iclocation where location="#getheaderinfo.rem2#"
</cfquery>

</cfif>

<cfquery name="getformattype" datasource="#dts#">
	select * from customized_format where <cfif IsDefined("url.counter")>counter="#url.counter#" and </cfif> type="#url.tran#"
</cfquery>

<cfif lcase(huserloc) eq "all_loc">
<cfset defaultadd=1>
<cfelse>
<cfset defaultadd=left(huserloc,1)>
</cfif>

<cfquery name="getdefaultadd" datasource="#dts#">
	SELECT * FROM address where code="#defaultadd#"
</cfquery>

<cfif getdefaultadd.recordcount eq 0>

<cfquery name="getdefaultadd" datasource="#dts#">
	SELECT * FROM address where code="1"
</cfquery>

</cfif>

<cfif getdefaultadd.recordcount neq 0>

<cfset getGsetup.compro=getdefaultadd.name>
<cfset getGsetup.compro2=getdefaultadd.add1>
<cfset getGsetup.compro3=getdefaultadd.add2>
<cfset getGsetup.compro4=getdefaultadd.add3>
<cfset getGsetup.compro5=getdefaultadd.add4>
<cfset getGsetup.compro6=getdefaultadd.postalcode>
<cfset getGsetup.compro7=getdefaultadd.country>
<cfset getGsetup.compro8=getdefaultadd.phone>
<cfset getGsetup.compro9=getdefaultadd.fax>
<cfset getGsetup.compro10=getdefaultadd.e_mail>
<cfset getGsetup.gstno=getdefaultadd.gstno>
<cfset companyLogo=getdefaultadd.name2>

</cfif>



<cfreport template="#fname#" format="#getformattype.format#" query="MyQuery">    	
    <cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
    <cfreportparam name="dts" value="#dts#">
    <cfreportparam name="custSupp" value="#ptype#">
    <cfreportparam name="decimalPlace_unitPrice" value="#getGsetup2.Decl_Uprice#">
    <cfreportparam name="decimalPlace_discount" value="#getGsetup2.Decl_Discount#">
    <cfreportparam name="decimalPlace_totalAmt" value="#getGsetup2.Decl_TotalAmt#">
    <cfreportparam name="compro" value="#getGsetup.compro#">
    <cfloop index="i" from="2" to="10">
    	<cfreportparam name="compro#i#" value="#evaluate('getGsetup.compro#i#')#">
	</cfloop>
    <cfreportparam name="companyCurrency" value="#getGsetup.bcurr#">
    <cfreportparam name="GSTno" value="#getGsetup.gstno#">
    <cfreportparam name="gst" value="">
    <cfreportparam name="companyUEN" value="#getGsetup.comuen#">
    <cfloop index="i" from="5" to="11">
    	<cfreportparam name="headerRemark#i#" value="#evaluate('getGsetup.rem#i#')#">
	</cfloop>    
    <cfreportparam name="currencyCodeControl" value="#getHeaderInfo.currencyCode#">
    <cfreportparam name="taxInclude" value="#getHeaderInfo.taxincl#">
    <cfreportparam name="cash" value="#getHeaderInfo.cs_pm_cash#">
    <cfreportparam name="cheque" value="#getHeaderInfo.cs_pm_cheq#">
    <cfreportparam name="cheqno" value="#getHeaderInfo.checkno#">
    <cfreportparam name="creditCard1" value="#getHeaderInfo.cs_pm_crcd#">
    <cfreportparam name="creditCard2" value="#getHeaderInfo.cs_pm_crc2#">
    <cfreportparam name="voucher" value="#getHeaderInfo.cs_pm_vouc#">
    <cfreportparam name="debitCard" value="#getHeaderInfo.cs_pm_dbcd#">
    <cfreportparam name="debt" value="#getHeaderInfo.cs_pm_debt#">
    <cfreportparam name="miscellaneousCharges" value="#getHeaderInfo.mc1_bil#">
    <cfreportparam name="termsCondition" value="#getHeaderInfo.termscondition#">
    <cfloop index="i" from="30" to="47">
    	<cfreportparam name="rem#i#" value="#evaluate('getHeaderInfo.rem#i#')#">
	</cfloop>
    
    <cfif IsDefined("getheaderinfo.returnreason") AND  getheaderinfo.returnreason neq "">
    	<cfreportparam name="rem48" value="#getHeaderInfo.returnreason#">
    <cfelse>
    	<cfreportparam name="rem48" value="#getHeaderInfo.rem48#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returnbillno") AND getheaderinfo.returnbillno neq "">
    	<cfreportparam name="rem49" value="#getHeaderInfo.returnbillno#">
    <cfelse>
    	<cfreportparam name="rem49" value="#getHeaderInfo.rem49#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returndate") AND getheaderinfo.returndate neq "" and isdate(getheaderinfo.returndate)>
    	<cftry>
    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),mid(getheaderinfo.returndate,4,2),left(getheaderinfo.returndate,2))>
    	<cfcatch>
    		<cfif Len(getheaderinfo.returndate) GT 8>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
       	 	<cfelse>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,2),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
        	</cfif>
    	</cfcatch>
    	</cftry>
    
    	<cfreportparam name="rem50" value="#rem50date#">
    <cfelse>
    	<cfreportparam name="rem50" value="#getcninvdate.wos_date#">
    </cfif>
    
    <cfreportparam name="agentSignature" value="#getHeaderInfo.agentSignature#">
    <cfreportparam name="termCode" value="#getHeaderInfo.termCode#">
    <cfreportparam name="termDesp" value="#getHeaderInfo.termDesp#">
    <cfreportparam name="soNo" value="#getHeaderInfo.sono#">
    <cfreportparam name="quoNo" value="#getHeaderInfo.quono#">
    <cfreportparam name="projectDesp" value="#getHeaderInfo.projectDesp#">
    <cfreportparam name="jobDesp" value="#getHeaderInfo.jobDesp#">
    <cfreportparam name="driverNo" value="#getHeaderInfo.driverno#">
    <cfreportparam name="driverName" value="#getHeaderInfo.name#">
    <cfif getHeaderInfo.username NEQ ''>
        <cfreportparam name="username" value="#getHeaderInfo.username#">
    <cfelse>
        <cfreportparam name="username" value="#getUserName.username#">
    </cfif> 
    <cfif tran eq "tr">
    <cfreportparam name="trfradd1" value="#gettradd.addr1#"> 
    <cfreportparam name="trfradd2" value="#gettradd.addr2#"> 
    <cfreportparam name="trfradd3" value="#gettradd.addr3#"> 
    
    <cfreportparam name="trtoadd1" value="#gettradd2.addr1#"> 
    <cfreportparam name="trtoadd2" value="#gettradd2.addr2#"> 
    <cfreportparam name="trtoadd3" value="#gettradd2.addr3#"> 
    </cfif>

    <cfreportparam name="createdBy" value="#getHeaderInfo.created_by#"> 
    <cfreportparam name="companyLogo" value="#companyLogo#">    
</cfreport>


