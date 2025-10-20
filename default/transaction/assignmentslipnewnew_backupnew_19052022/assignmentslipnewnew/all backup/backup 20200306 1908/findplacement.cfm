<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfoutput>
<cfset nametype = url.type>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor,invoicegroup,jobpostype 
        from placement
        where 1=1
        and jobstatus = '2'
        <cfif dts neq 'manpowertest_i'>
        and placementno not like '%test%'
        </cfif>			
        ORDER BY PLACEMENTNO DESC
         limit 15
	</cfquery>
    <cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="company_details" datasource="payroll_main">
        SELECT * FROM gsetup WHERE comp_id = "#dts2#"
        </cfquery>

        <cfif val(company_details.mmonth) eq "13">
        <cfset company_details.mmonth = 12 >
        </cfif>

        <cfset currentdate = createdate(val(company_details.myear),val(company_details.mmonth),1)>



    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="placementno1" size="8" id="placementno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementAjax.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&empname='+document.getElementById('sempname').value);"  />&nbsp;&nbsp;Employee Name : <input type="text" name="sempname" id="sempname" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementAjax.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&empname='+document.getElementById('sempname').value);" />
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="780px">
    <tr>
    <th width="120px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="200px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="380px"><font style="text-transform:uppercase">CUSTOMER NAME</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <cfquery name="getbillref" datasource="#dts#">
    SELECT arrem10 FROM arcust WHERE custno = "#xcustno#"
    </cfquery>
    <!---<cfquery name="gettimesheet" datasource="#dts1#">
    SELECT tsrowcount FROM timesheet WHERE empno = "#getitemno.xempno#" and tmonth = "#company_details.mmonth#" and editable = "Y" ORDER BY tsrowcount
    </cfquery>--->
    <tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getitemno.xplacementno#</td>
    <cfquery name="getemployeename" datasource="#dts#">
	SELECT name,paystatus,dbirth
	FROM #dts1#.pmast where empno='#getitemno.xempno#'
	</cfquery>
    <td>#getemployeename.name#</td>
    <td>#getitemno.xcustname#</td>
	<input type=hidden name='xcustname' id='xcustname' value=''>
    <cfquery name="getlastworkingdate" datasource="#dts#">
        select completedate as assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
        
    <cfif getitemno.xcustno eq '300033162'>
        <cfquery name="checkadvanced" datasource="#dts#">
            select refno from assignmentslip 
            WHERE 1=1
            and empname like "Advance%"   
            and custno = "300033162"
            and month(assignmentslipdate) = "#company_details.mmonth#"
            and payrollperiod<>99
        </cfquery>
    </cfif>
       
    <!---Assignment type check for L'oreal by Nieo 20171218 1649--->
    <!---<cfif getbillref.arrem10 eq '0'>
        <cfif getitemno.xcustno eq '300033162'>
            <cfif getitemno.jobpostype eq '1' or getitemno.jobpostype eq '2'>
                <cfif checkadvanced.recordcount neq 0 and getitemno.xempno eq '100123480'>
                    <cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#'<cfelse>'#getitemno.xcustno#'</cfif>
                <cfelse>
                    <cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#-2'<cfelse>'#getitemno.xcustno#-2'</cfif>
                </cfif>
            <cfelseif getitemno.jobpostype eq '5'>
                <cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#-1'<cfelse>'#getitemno.xcustno#-1'</cfif>
            </cfif>
        <cfelse>
            <cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#'<cfelse>'#getitemno.xcustno#'</cfif>
        </cfif>
    <cfelse>
        'invoice'
    </cfif>--->
    <!---Assignment type check for L'oreal by Nieo 20171218 1649--->
        <!---<cfset checkdatedate = createdate(listlast(urlDecode(url.completedate),'/'),listgetat(urlDecode(url.completedate),2,'/'),listfirst(urlDecode(url.completedate),'/'))>--->
        
        <td><a style="cursor:pointer" onClick="<cfif getemployeename.paystatus neq "A">alert('Emplyee Pay Status is Not Active');<cfelseif getemployeename.dbirth eq "" or  getemployeename.dbirth eq "0000-00-00">alert('Emplyee Date Of Birth is Empty');<cfelse>document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('lastworkingdate').value='#dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')#';document.getElementById('jobstartdate').innerHTML='#dateformat(getitemno.startdate,'DD/MM/YYYY')#';document.getElementById('jobcompletedate').innerHTML='#dateformat(getitemno.completedate,'DD/MM/YYYY')#';document.getElementById('jobcompletedate').style.color='red';document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('custname').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('custname2').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('empname').value='#replace(getemployeename.name,"'","","all")#';document.getElementById('assignmenttype').value=<cfif getbillref.arrem10 eq '0'><cfif getitemno.xcustno eq '300033162'><cfif getitemno.jobpostype eq '1' or getitemno.jobpostype eq '2'><cfif checkadvanced.recordcount neq 0 and getitemno.xempno eq '100123480'><cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#'<cfelse>'#getitemno.xcustno#'</cfif><cfelse><cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#-2'<cfelse>'#getitemno.xcustno#-2'</cfif></cfif><cfelseif getitemno.jobpostype eq '5'><cfif checkadvanced.recordcount gte 2 and getitemno.xempno eq '100123480'><cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#-4'<cfelse>'#getitemno.xcustno#-4'</cfif><cfelseif checkadvanced.recordcount neq 0 and getitemno.xempno eq '100123480'><cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#'<cfelse>'#getitemno.xcustno#'</cfif><cfelse><cfif trim(getitemno.invoicegroup) neq ''>'#getitemno.invoicegroup#-1'<cfelse>'#getitemno.xcustno#-1'</cfif></cfif></cfif><cfelse><cfif trim(getitemno.invoicegroup) neq ''>'#REReplace(getitemno.invoicegroup, "'", "", "ALL")#'<cfelse>'#REReplace(getitemno.xcustno, "'", "", "ALL")#'</cfif></cfif><cfelse>'invoice'</cfif>;document.getElementById('iname').value='#getitemno.iname#';document.getElementById('supervisor').value='#REReplace(getitemno.supervisor, "[^a-zA-Z]", "", "ALL")#';<!---<cfif gettimesheet.recordcount neq 0>gettimesheet('#getitemno.xplacementno#','#getitemno.xempno#');<cfelse>--->getpanel('#getitemno.xplacementno#');<!---</cfif>--->ColdFusion.Window.hide('findplacement');</cfif>"><u>SELECT</u></a></td>
    </tr>
    </cfloop>

    </table>
    </div>
    </cfoutput>