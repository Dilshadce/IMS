<cfset dts = replacenocase(dts,'_i','_p')>
<cfset hcomid = replacenocase(dts,'_p','')>
<html>
	<head>
		<title>
			Thru Bank Via Diskette
		</title>
	</head>
	<body>
		<cfquery name="acBank_qry" datasource="#dts#">
            SELECT * FROM address a
            WHERE org_type in ('BANK')
        </cfquery>
		<cfquery name="aps_qry" datasource="#dts#">
            SELECT entryno, apsbank, apsnote FROM aps_set
        </cfquery>
		<cfquery name="gs_qry" datasource="payroll_main">
            SELECT mmonth, myear FROM gsetup WHERE comp_id = "#HcomID#"
        </cfquery>
		<cfquery name="category_qry" datasource="#dts#">
            SELECT * FROM address a where category="#url.type#" and org_type="BANK"
        </cfquery>
		<cfoutput>
        <form name="tgForm" action="/Report/BEPS/batchapproval/generateGiroBankfile/generateThruBankViaDuitnow.cfm" method="post" target="BLANK"  onSubmit="return validateform();">
            <table class="form">
                <tr>
                    <th colspan="2">
                        Generate Duitnow File
                    </th>
                </tr>
                <cfif left(dts,8) eq "manpower">

                        <cfquery name="getbatch" datasource="#replace(dts,'_p','_i')#">
                            Select batches,a.giropaydate from assignmentslip a
                            LEFT JOIN argiro b 
                            ON a.batches=b.batchno
                            WHERE 1=1
                            <cfif isdefined('url.paydate')>
                            AND paydate = "#url.paydate#"
                            </cfif>
                            and locked = "Y" and batches <> ""
                            and payrollperiod = "#url.mmonth#"
                            and a.created_on > #createdate(gs_qry.myear,1,7)#
                            and batches <> "" and batches is not null
                            GROUP BY batches order by batches
                        </cfquery>

                    <cfquery name="getvalidbatch" datasource="#replace(dts,'_p','_i')#">
                        SELECT batchno 
                        FROM argiro 
                        WHERE batchno in 
                        (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
                        and appstatus = "Approved" 
                        and (girorefno = "" or girorefno is null)
                    </cfquery>
                    <tr>
                        <td>
                            Assignment Batch
                        </td>
                        <td>
                                <cfquery datasource="#replace(dts,'_p','_i')#" name="getbatch">
                                    Select batches,a.giropaydate,branch from assignmentslip a
                                    LEFT JOIN argiro b 
                                    ON a.batches=b.batchno
                                    WHERE 1=1
                                    <cfif isdefined('url.paydate')>
                                    AND paydate = "#url.paydate#"
                                    </cfif>
                                    and locked = "Y" and batches <> ""
                                    and payrollperiod = "#url.mmonth#"
                                    and a.created_on > #createdate(gs_qry.myear,1,7)#
                                    and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getvalidbatch.batchno)#" separator="," list="yes">)
                                    GROUP BY batches order by batches
                                </cfquery>

                            <cfloop query="getbatch">
                                <input type="checkbox" name="batch" id="batch" value="#getbatch.batches#" onclick="setpirrefno(this.value,'#lcase(getbatch.branch)#','#url.paytype#','pir_refno_duitnow_file_');">
                                &nbsp;&nbsp;#getbatch.batches#
                                <br>
                            </cfloop>
                        </td>
                    </tr>
                </cfif>
                <tr>
                    <td>
                        <cfif left(dts,8) eq "manpower">
                            Bank Processing Date
                        <cfelse>
                            Salary Credit Date
                        </cfif>
                    </td>
                    <cfset rdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>
                    <td>
                        <input type="text" name="cdate" value="#DateFormat(getbatch.giropaydate,"yyyy/mm/dd")#" size="10" readonly>
                    </td>
                </tr>
                <tr>
                    <td>
                        Prepared By
                    </td>
                    <td>
                        <input type="text" id="Prepared_By" name="Prepared_By" value="#getauthuser()#" readonly>
                    </td>
                </tr>
                <tr>
                    <input type="hidden" id="Batch_No" name="Batch_No" value="00001" size="8" >
                    <td>
                        PIR Reference No
                    </td>
                    <td>
                        <input type="text" id="pir_refno_duitnow_file_#url.paytype#" name="pir_refno" value="" size="30" >
                    </td>
                </tr>
                <tr>
                    <td>
                        Remarks
                    </td>
                    <td>
                        <input type="text" name="" value="" size="20">
                    </td>
                </tr>
                <tr>
                    <td>
                        Exclude Employee
                    </td>
                    <td>
                        <input type="text" name="exclude" id="exclude" value="" size="20">
                    </td>
                </tr>
                <cfif category_qry.APS_FILE neq "">
                    <cfset APS_FILE = "#category_qry.aps_file#">
                <cfelse>
                    <cfset APS_FILE = "">
                </cfif>
                <tr>
                    <th colspan="2" width="350px">
                        TO GENERATE APS FILE :
                        <input type="text" name="APS_FILE" id="APS_FILE" value="#APS_FILE#" readonly >
                    </th>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <br />
                        <input type="submit" name="submit" value="Generate Encrypted File">
                        <input type="submit" name="submit" value="Generate Text File">
                    </td>
                </tr>
            </table>
        </form>
		</cfoutput>
	</body>
</html>
