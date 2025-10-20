<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfoutput>
<cfset nametype = url.type>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor from placement
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
    <cfquery name="gettimesheet" datasource="#dts1#">
    SELECT tsrowcount FROM timesheet WHERE empno = "#getitemno.xempno#" and tmonth = "#company_details.mmonth#" and editable = "Y" ORDER BY tsrowcount
    </cfquery>
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
    <td><a style="cursor:pointer" onClick="<cfif getemployeename.paystatus neq "A">alert('Emplyee Pay Status is Not Active');<cfelseif getemployeename.dbirth eq "" or  getemployeename.dbirth eq "0000-00-00">alert('Emplyee Date Of Birth is Empty');<cfelse>document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('lastworkingdate').value='#dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')#';document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('custname').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('custname2').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('empname').value='#getemployeename.name#';selectlist('#getitemno.assignmenttype#','assignmenttype');document.getElementById('iname').value='#getitemno.iname#';document.getElementById('supervisor').value='#getitemno.supervisor#';<cfif gettimesheet.recordcount neq 0>gettimesheet('#getitemno.xplacementno#','#getitemno.xempno#');<cfelse>getpanel('#getitemno.xplacementno#');</cfif>ColdFusion.Window.hide('findplacement');</cfif>"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>