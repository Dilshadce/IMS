<cfoutput>
<!---   HEADER --->
<cfset error = "">
<cfset result = "">
<cfset count = 1>
<cfset header = "">
<cfset hdr1 = "00">
<cfset hdr2= "MYMMANPOWER">
<cfif hdr2 eq "" or len(hdr2) gt 30>
    <cfset error = error & 'Line 1 - Header no. 2: Corporate ID exceeds 30 characters or empty.<br />'>
</cfif>
<cfset pir_ref =  ReReplaceNoCase('#trim(form.pir_refno)#','[^a-zA-Z0-9]','','ALL') >
<cfset hdr3= pir_ref>
<cfif hdr3 eq "" or len(hdr3) gt 30>
    <cfset error = error & 'Line 1 - Header no. 3: Corporate ID exceeds 30 characters or empty.<br />'>
</cfif>


<cfloop from="1" to="29" index="i">
    <cfif i gte 4>
        <cfset header = header & "|">
        <cfset result = result & "|">
    <cfelse>
        <cfset header = header & evaluate("hdr#i#") & "|">
        <cfset result = result & evaluate("hdr#i#") & "|">
    </cfif>
    <cfif i eq 29> 
        <cffile action = "write" 
                file = "#filedir#" 
                output = "#header#" nameconflict="overwrite">
        <cfset result = result & "<br />">
    </cfif>
</cfloop>
<!---   end of HEADER   --->

<!---   RECORDS --->

<cfset sumpay = 0>
<cfset totalhash = 0>

<cfloop query="getpay_qry">
    <cfset count += 1>
    <cfset record = "">
    <cfset rcd1 = "01">
    <cfset rcd2 = "IT">
    <cfif getpay_qry.bankcode neq "MBBEMYKL">
        <cfset rcd2 = "IG">
    </cfif>
    <cfset rcd3 = "Staff Payroll">
    <cfset rcd4 = "">
    <cfset rcd5 = dateformat(getpay_qry.giropaydate,'DDMMYYYY')>
    <cfset rcd6 = "">
    <cfset rcd7 = "">
    <cfset rcd8 = getpay_qry.empno&gs_qry.mmonth&gs_qry.myear>
    <cfset rcd9 = pir_ref>
    <cfif len(rcd9) gt 55>
        <cfset error = error & 'Line ' & #count# & ' - Record no. 9  PIR Reference no. exceeds 55 characters or wrong format.<br />'>
    </cfif>
    <cfset rcd10 = "">
    <cfset rcd11 = "MYR">
    <cfset rcd12 = numberformat(getpay_qry.netpay,'.__')>
    <cfset rcd13 = "N">
    <cfset rcd14 = "MYR">
    <cfif isdefined('getentity.debitbankaccno')>
        <cfset rcd15 = "#getentity.debitbankaccno#"><!---Company Debit Account number--->
    <cfelse>
        <cfset rcd15 = ""><!---Company Debit Account number--->
    </cfif>
    <cfset rcd16 = trim(getpay_qry.bankaccno)>
    <cfif len(rcd16) lte 6 or len(rcd16) gt 35>
        <cfset error = error & 'Line ' & #count# & ' - Record no. 6  employee bank account no. exceeds 35 characters or wrong format. @ #getpay_qry.empno#<br />'>
    </cfif>
    <cfset rcd17 = "">
    <cfset rcd18 = "">
    <cfset rcd19 = "N">
    <cfif getpay_qry.national eq "MY">
        <cfset rcd19 = "Y">
    </cfif>
    <cfset rcd20 = "">
    <cfset rcd21 = "">
    <cfset rcd22 = "">
    <cfif len(getpay_qry.name) gte 0 and len(getpay_qry.name) lte 40>
        <cfset rcd20 = getpay_qry.name>
    <cfelseif len(getpay_qry.name) gte 41 and len(getpay_qry.name) lte 80>
        <cfset rcd20 = left(getpay_qry.name,40)>
        <cfset rcd21 = mid(getpay_qry.name,41,40)>
    <cfelseif len(getpay_qry.name) gte 81 and len(getpay_qry.name) lte 120>
        <cfset rcd20 = left(getpay_qry.name,40)>
        <cfset rcd21 = mid(getpay_qry.name,41,40)>
        <cfset rcd22 = mid(getpay_qry.name,81,40)>
    </cfif>
    <cfif reFind("[^a-zA-Z\'\/\.\-@ ]",getpay_qry.name)>
         <cfset error = error & 'Line ' & #count# & ' - Record no. 20 or 21 or 22  employee name contain special character. @ #getpay_qry.empno# - #getpay_qry.name#<br />'>   
    </cfif>
    <cfset rcd23 = "">
    <cfset rcd24 = "">
    <cfset rcd25 = getpay_qry.nricn>
    <cfset rcd26 = getpay_qry.nric>
    <cfset rcd27 = "">
    <cfset rcd28 = getpay_qry.passport>
    <cfset rcd29 = "">
    <cfset rcd30 = "">
    <cfset rcd31 = "">
    <cfset getpay_qry.add1 = ReReplaceNoCase(trim(getpay_qry.add1),'[^a-zA-Z\\, ]','','ALL')>
    <cfset getpay_qry.add2 = ReReplaceNoCase(trim(getpay_qry.add2),'[^a-zA-Z\\, ]','','ALL')>
    <cfset tempadd = getpay_qry.add1&' '&getpay_qry.add2>
    <cfif len(tempadd) gte 0 and len(tempadd) lte 30>
        <cfset rcd29 = replace(getpay_qry.add1,'.','')>
        <cfset rcd30 = replace(getpay_qry.add2,'.','')>
        <cfset rcd31 = "">
    <cfelseif len(tempadd) gte 31 and len(tempadd) lte 60>
        <cfset rcd29 = replace(left(tempadd,30),'.','')>
        <cfset rcd30 = replace(mid(tempadd,31,30),'.','')>
        <cfset rcd31 = "">  
    <cfelseif len(tempadd) gte 61 and len(tempadd) lte 90>
        <cfset rcd29 = replace(left(tempadd,30),'.','')>
        <cfset rcd30 = replace(mid(tempadd,31,30),'.','')>
        <cfset rcd31 = replace(mid(tempadd,61,30),'.','')>
    </cfif>    
    <cfset rcd32 = "">
    <cfset rcd33 = "">
    <cfset rcd34 = "">
    <cfset rcd35 = "">
    <cfset rcd36 = "">
    <cfif getpay_qry.bankcode neq "MBBEMYKL">
        <cfset rcd37 = getpay_qry.bankcode> <!---swift code--->
    <cfelse>
        <cfset rcd37 = ""> <!---swift code--->
    </cfif>
    <cfset rcd38 = "">
    <cfset rcd39 = "">
    <cfset rcd40 = "">
    <cfset rcd41 = "">
    <cfset rcd42 = "">
    <cfset rcd43 = "">
    <cfset rcd44 = "">
    <cfset rcd45 = "">
    <cfset rcd46 = "">
    <cfset rcd47 = "">
    <cfset rcd48 = "">
    <cfset rcd49 = "">
    <cfset rcd50 = "">
    <cfset rcd51 = "">
    <cfset rcd52 = "">
    <cfset rcd53 = "">
    <cfset rcd54 = "">
    <cfset rcd55 = "">
    <cfset rcd56 = "">
    <cfset rcd57 = "">
    <cfset rcd58 = "">
    <cfset rcd59 = "">
    <cfset rcd60 = "">
    <cfset rcd61 = "">
    <cfset rcd62 = "">
    <cfset rcd63 = "">
    <cfset rcd64 = "">
    <cfset rcd65 = "">
    <cfset rcd66 = "">
    <cfset rcd67 = "">
    <cfset rcd68 = "">
    <cfset rcd69 = "">
    <cfset rcd70 = "">
    
<!---    <cfset rcd102 = "">
    <cfset rcd103 = "">
    <cfset rcd104 = "">
    <cfset rcd105 = "">
    <cfset rcd106 = "">
    <cfset rcd107 = "">
    <cfset rcd108 = "">
    <cfset rcd109 = "">--->
    <cfset rcd110 = "01">
    <cfif rcd2 neq 'IT' and rcd2 neq 'IG'>
        <cfset rcd111 = "Payroll">
    <cfelse>
        <cfset rcd111 = "">
    </cfif>
    <cfset rcd145 = "">
    <cfset rcd146 = "">
    <cfset rcd147 = "">
    <cfset rcd148 = "">

    <cfloop from="1" to="500" index="i">
        <cfif (i gte 71 and i lte 109) or (i gte 112 and i lte 500)>
            <cfset record = record & "|">
            <cfset result = result & "|">
        <cfelse>
            <cfset record = record & evaluate("rcd#i#") & "|">
            <cfset result = result & evaluate("rcd#i#") & "|">
        </cfif>
        <cfif i eq 500>  
            <cffile action="append" addnewline="yes" 
                       file = "#filedir#"
                       output = "#record#"> 
            <cfset result = result & "<br />">
        </cfif>
    </cfloop> 
    <cfset sumpay += numberformat(rcd12,'.__')>
    <cfset payhash = #rereplace(rcd12, "[^0-9]", "", "all")#>
    <cfset payhash = (payhash%2000)+count-1>
    <cfset acchash = 0>
    
    <cfif len(rcd16) gte 6>
    <cfloop from="1" to="6" index="i">
        <cfset accno = trim(replace(rcd16,'-','','all'))>
        <cfset accno = mid(accno,len(accno)-i+1,1)>
        <cftry>
            <cfset acchash += accno>
            <cfcatch type="any">
                <cfoutput>
                    #rcd20#<br>
                #rcd16#<br>
                #accno#<br>
                    #mid(accno,len(accno)-i+1,1)#<br>
                <cfabort>
                </cfoutput>
            </cfcatch>
        </cftry>
        
    </cfloop>
    </cfif>
    <cfset acchash = (acchash*2) +count -1>
    <cfset totalhash = totalhash + payhash + acchash>

</cfloop>
<!---   END OF RECORDS--->

<!---   FOOTER  --->
<cfset footer = "">

<cfset ftr1 = "99">
<cfset ftr2 = count-1>
<cfset ftr3 = numberformat(sumpay,'.__')>
<cfset ftr4 = totalhash>

<cfloop from="1" to="29" index="i"> 
    <cfif i gt 4>
        <cfset footer = footer & "|">
    <cfelse>
        <cfset footer = footer & evaluate("ftr#i#") & "|">
    </cfif>
    <cfif i eq 29>
        <cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#footer#"> 
    </cfif>
</cfloop> 

<!---   END OF FOOTER   --->

<!---				<cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#content#"> 
--->

<!---#header#
#record#
#footer#--->
			<!--- <cffile action = "rename" source = "C:\Inetpub\wwwroot\payroll\download\file.txt" destination = "C:\Inetpub\wwwroot\payroll\download\#filename#.txt"> --->
<cfif error eq "">	
    <cfset timenow = "#DateTimeFormat(now(), 'yyyy-mm-dd_hhnnss')#">
    <cfset filename="#pir_ref#"&"-#replace(form.batch,',','-','all')#_#timenow#">
    
    <cfset yourFileName="#filedir#">
    <cfif form.submit eq 'Generate Encrypted File'>
        <cfset yourFileName2="#filename#.txt.gpg">
            
        <cfexecute name="C:\Program Files (x86)\GnuPG\bin\gpg.exe" 
           arguments="--trust-model always --encrypt -r mbbprodkeys #yourFileName#" 
            errorFile="C:\TEMP\GnuPG_error\test_bat_error.txt"  
           timeout="0">
        </cfexecute>
            
            <cfscript>
            sleep(200);
            </cfscript>
            
            <!---<cfset tempfile = yourFileName &".gpg">
            #yourFileName#.gpg<br>
            #fileExists(tempfile)#
            <cfabort>--->
            
        <cffile action="delete" file="#yourFileName#">
        <cffile action="rename" source="#yourFileName#.gpg" destination="#filenewdir##yourFileName2#" attributes="normal">            
            
        <cfcontent type="application/x-unknown">
    
        <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
        <cfheader name="Content-Description" value="This is a pipe-delimited file.">
        <cfcontent type="text/html" file="#filenewdir##yourFileName2#" deletefile="yes">
        <cflocation url="#filenewdir##yourFileName2#">
    <cfelse>
        <cfset yourFileName2="#filename#.txt">
            
        <cfcontent type="application/x-unknown">
    
        <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
        <cfheader name="Content-Description" value="This is a pipe-delimited file.">
        <cfcontent type="Multipart/Report" file="#yourFileName#" deletefile="yes">
        <cflocation url="#yourFileName#">
    </cfif>
        
    
        
<cfelse>      
    <cffile action="delete" file="#filedir#">
    <span style="color: red">Error in File:</span><br>
    #error#
    <hr>
    #result#
</cfif>
</cfoutput>