<html>
<head>
	<title>Maintenance Deposit</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>

<body>

<cfquery name="getgsetup" datasource="#dts#">
				SELECT * FROM gsetup
</cfquery>

<cfquery name="getcust" datasource="#dts#">
				SELECT * FROM #target_arcust# ORDER BY custno
</cfquery>

<cfoutput>
	<cfswitch expression="#url.type#">
		<cfcase value="Edit,Delete" delimiters=",">
			<cfquery name="getDeposit" datasource="#dts#">
				select * from Deposit where Depositno = '#url.Deposit#'
			</cfquery>
		</cfcase>
	</cfswitch>

	<cfswitch expression="#url.type#">
		<cfcase value="Edit">
			<cfset mode="Edit">
            <cfset xtaxcode=getDeposit.taxcode>
            <cfset xptax=getDeposit.ptax>
			<cfset title="Edit Deposit">
			<cfset button="Edit">
            <cfset sono=getDeposit.sono>
            <cfset xcustno=getDeposit.custno>
		</cfcase>
		<cfcase value="Delete">
			<cfset mode="Delete">
            <cfset xtaxcode=getDeposit.taxcode>
            <cfset xptax=getDeposit.ptax>
			<cfset title="Delete Deposit">
			<cfset button="Delete">
            <cfset sono=getDeposit.sono>
            <cfset xcustno=getDeposit.custno>
		</cfcase>
		<cfcase value="Create">
			<cfset mode="Create">
            <cfset xtaxcode=getgsetup.df_salestax>
            <cfquery name="getdftaxp" datasource="#dts#">
							SELECT * FROM #target_taxtable#
                            WHERE tax_type <> "PT" and code='#getgsetup.df_salestax#'
            </cfquery>
            <cfset xptax=val(getdftaxp.rate1) * 100>
			<cfset title="Create Deposit">
			<cfset button="Create">
            <cfset sono=''>
            <cfset xcustno=''>
            <cfset add1=''>
			<cfset add2=''>
            <cfset add3=''>
            <cfset add4=''>
            
            <cfif lcase(huserloc) neq "all_loc">
            <cfquery datasource="#dts#" name="getlocationrefno">
			select lastUsedNo
            from refnoset_location
			where type = 'DEP'
			and location = '#huserloc#'
            and activate="T"
            </cfquery>
            <cfif getlocationrefno.recordcount neq 0>
            
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlocationrefno.lastUsedNo#" returnvariable="depositno" />
            
            <cfelse>
            
            <cfquery name="getlastno" datasource="#dts#">
				select depositno as depositno from Deposit <cfif lcase(hcomid) eq "mika_i">where depositno like "MHQDEP%"</cfif> order by depositno desc
			</cfquery>
            <cfif getlastno.recordcount eq 0>
            <cfif lcase(hcomid) eq "mika_i">
            <cfset depositno='MHQDEP00001'>
            <cfelse>
            <cfset depositno='00000001'>
            </cfif>
            <cfelse>
            <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastno.depositno#" returnvariable="depositno" />
            </cfif>
            </cfif>
            
            <cfelse>
            <cfquery name="getlastno" datasource="#dts#">
				select depositno as depositno from Deposit <cfif lcase(hcomid) eq "mika_i">where depositno like "MHQDEP%"</cfif> order by depositno desc
			</cfquery>
            <cfif getlastno.recordcount eq 0>
            <cfif lcase(hcomid) eq "mika_i">
            <cfset depositno='MHQDEP00001'>
            <cfelse>
            <cfset depositno='00000001'>
            </cfif>
            <cfelse>
             <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastno.depositno#" returnvariable="depositno" />
            </cfif>
            
            </cfif>
            
		</cfcase>
	</cfswitch>

	<h1>#title#</h1>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Deposittable2.cfm?type=Create">Creating A New Deposit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Deposittable.cfm">List All Deposit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Deposittable.cfm?type=Deposit">Search For Deposit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Deposit.cfm">Deposit Listing</a></cfif>
	<cfif getpin2.h1F10 eq 'T'>
    || <a href="postingdeposit.cfm">Deposit Posting</a>
    || <a href="depositimport_to_ams.cfm">Import Posting</a>
 	</cfif>
	</h4>

	<cfform name="Depositform" action="Deposittableprocess.cfm" method="post">
    <cfif isdefined('url.express')>
    <input type="hidden" name="expresscreate" id="expresscreate" value="1">
    </cfif>
    <cfif isdefined('url.tran')>
    <input type="hidden" name="transactioncreate" id="transactioncreate" value="1">
    <cfset sono=url.sono>
    </cfif>
    <cfif isdefined('url.custno')>
    <cfset xcustno=url.custno>
    </cfif>
    <cfif isdefined('url.add1')>
    <cfset add1=url.add1>
    </cfif>
    <cfif isdefined('url.add2')>
    <cfset add2=url.add2>
    </cfif>
    <cfif isdefined('url.add3')>
    <cfset add3=url.add3>
    </cfif>
    <cfif isdefined('url.add4')>
    <cfset add4=url.add4>
    </cfif>
    
    	<input type="hidden" name="sono" id="sono" value="#sono#">
    	<input type="hidden" name="mode" value="#mode#">

		<h1 align="center">Deposit File Maintenance</h1>

		<table align="center" class="data" width="500">
      		<tr>
        		<td width="100">Deposit :</td>
        		<td>
				<cfif mode eq "Delete" or mode eq "Edit">
            		<cfinput type="text" size="12" name="Depositno" value="#getDeposit.Depositno#" readonly>
            	<cfelse>
            		<cfinput type="text" size="12" name="Depositno" value="#depositno#" required="yes" maxlength="12" readonly>
          		</cfif>
				</td>
      		</tr>
      		<tr>
        		<td>Description:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<textarea name="desp" id="desp" cols="60" rows="3">#getDeposit.desp#</textarea>
					<cfelse>
                    <cfif isdefined('url.desp')>
                    <textarea name="desp" id="desp" cols="60" rows="3">#url.desp#</textarea>
                    <cfelse>
                    <textarea name="desp" id="desp" cols="60" rows="3">Deposit Pay</textarea>
                    </cfif>
					</cfif>
				</td>
      		</tr>
            <cfif lcase(hcomid) eq "ltm_i">
            <cfif mode eq "Delete" or mode eq "Edit">
            <tr><td>SO No.</td><td><strong>#getdeposit.sono#</strong></td></tr>
            <tr><td>Invoice No.</td><td><strong>#getdeposit.billno#</strong></td></tr>
            </cfif>
            </cfif>
            <tr>
        		<td>Date:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="wos_date" required="no" value="#dateformat(getDeposit.wos_date,'DD/MM/YYYY')#" maxlength="10" validate="eurodate">
					<cfelse>
						<cfinput type="text" size="10" name="wos_date" required="no" value="#dateformat(now(),'DD/MM/YYYY')#" maxlength="10" validate="eurodate">
					</cfif>
                    <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">
                    (DD/MM/YYYY)
				</td>
      		</tr>
            
            <tr>
        		<td>Customer No:</td>
        		<td>
						<select name="custno" id="custno">
                        <option  value="">Please Choose a Customer No.</option>
                        <cfloop query="getcust">
                        <option  value="#getcust.custno#" <cfif getcust.custno eq xcustno>selected</cfif>>#getcust.custno# - #getcust.name#</option>
                        </cfloop>
                        </select>
				</td>
      		</tr>
            
			<tr>
        		<td rowspan="4">Address:</td>
        		<td>
					<cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="45" name="add1" value="#getDeposit.add1#" required="no" maxlength="45">
					<cfelse>
						<cfinput type="text" size="45" name="add1" value="#add1#" required="no" maxlength="45">
					</cfif>
				</td>
             </tr>
             <tr>
                <td>
					<cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="45" name="add2" value="#getDeposit.add2#" required="no" maxlength="45">
                      <cfelse>
					<cfinput type="text" size="45" name="add2" value="#add2#" required="no" maxlength="45">
                    </cfif>
				</td>
             </tr>
             <tr>
                <td>
					<cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="45" name="add3" value="#getDeposit.add3#" required="no" maxlength="45">
                      <cfelse>
					<cfinput type="text" size="45" name="add3" value="#add3#" required="no" maxlength="45">
                    </cfif>	
			  </td>
              <tr>
                <td>
					<cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="45" name="add4" value="#getDeposit.add4#" required="no" maxlength="45">
                      <cfelse>
					<cfinput type="text" size="45" name="add4" value="#add4#" required="no" maxlength="45">
                    </cfif>	
				</td>
               </tr>
      		</tr>  
			          
            <tr>
        		<td>Cash:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_CASH" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_CASH,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_CASH" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
        		<td>Cheque:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_CHEQ" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_CHEQ,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_CHEQ" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
        		<td colspan="2">Cheque No:
				&nbsp;
				<cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="30" name="chequeno" required="no" value="#getDeposit.chequeno#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="30" name="chequeno" value="" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            
            <tr>
        		<td>Credit Card:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_crcd" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_crcd,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_crcd" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
<td colspan="3">
<cfif mode eq "Delete" or mode eq "Edit">
<input type="radio" name="cctype1" id="cctype1" value="MASTER" <cfif getDeposit.cctype1 eq 'MASTER'>checked="checked"</cfif>/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="VISA" <cfif getDeposit.cctype1 eq 'VISA'>checked="checked"</cfif> />Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="AMEX" <cfif getDeposit.cctype1 eq 'AMEX'>checked="checked"</cfif> />American Express&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="DINERS" <cfif getDeposit.cctype1 eq 'DINERS'>checked="checked"</cfif> />Diners Club
<cfelse>
<input type="radio" name="cctype1" id="cctype1" value="MASTER" checked="checked"/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="VISA" />Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1" value="DINERS" />Diners Club
</cfif>
</td>
</tr>
            <tr>
        		<td>Credit Card 2:</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_crc2" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_crc2,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_crc2" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
<td colspan="3">
<cfif mode eq "Delete" or mode eq "Edit">
<input type="radio" name="cctype2" id="cctype2" value="MASTER" <cfif getDeposit.cctype2 eq 'MASTER'>checked="checked"</cfif>/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="VISA" <cfif getDeposit.cctype2 eq 'VISA'>checked="checked"</cfif>/>Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="AMEX" <cfif getDeposit.cctype2 eq 'AMEX'>checked="checked"</cfif>/>American Express&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="DINERS" <cfif getDeposit.cctype2 eq 'DINERS'>checked="checked"</cfif>/>Diners Club
<cfelse>
<input type="radio" name="cctype2" id="cctype2" value="MASTER" checked="checked"/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="VISA" />Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2" value="DINERS" />Diners Club

</cfif>
</td>
</tr>
            <tr>
        		<td>Debit Card :</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_dbcd" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_dbcd,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_dbcd" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
            <tr>
        		<td>Voucher :</td>
        		<td><cfif mode eq "Delete" or mode eq "Edit">
						<cfinput type="text" size="10" name="CS_PM_vouc" validate="float" required="no" value="#numberformat(getDeposit.CS_PM_vouc,'_.__')#" maxlength="40">
					<cfelse>
						<cfinput type="text" size="10" name="CS_PM_vouc" validate="float" value="0.00" required="no" maxlength="40">
					</cfif>
				</td>
      		</tr>
			<tr>
            <td>Tax</td>
            <td>
            <cfquery name="select_tax" datasource="#dts#">
							SELECT * FROM #target_taxtable#
                            WHERE tax_type <> "PT"
            </cfquery>
            <select name="taxcode" id="taxcode" onChange="JavaScript:document.getElementById('pTax').value=this.options[this.selectedIndex].id;">
            <option value="">Please Select a Tax Code</option>
            <cfloop query="select_tax">
            <cfset idrate = select_tax.rate1 * 100>
            <option value="#select_tax.code#" id="#idrate#" <cfif xtaxcode eq select_tax.code>selected</cfif>>#select_tax.code#</option>
            </cfloop>
            </select>
            <cfinput type="text" name="pTax" id="pTax" value="#xptax#" validate="integer" message="Please key in number only">
            </td>
            </tr>

      		<tr>
        		<td></td>
        		<td align="right"><cfinput name="submit" type="submit" value="  #button#  "></td>
      		</tr>
		</table>
	</cfform>
</body>
</cfoutput>
</html>