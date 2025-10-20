<html>
<head>
<title>Transaction Setup</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>

<cfif isdefined('url.type')>		
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update gsetup set 
		<!--- <cfif isdefined ("form.delinvoice")>delinvoice = '1',<cfelse>delinvoice = '0',</cfif> --->
		<!--- <cfif isdefined ("form.invsecure")>invsecure = '1',<cfelse>invsecure = '0',</cfif> --->
		<cfif isdefined ("form.cost")>
			cost=upper('#form.cost#'),
		<cfelse>
			cost='',
		</cfif>
		<cfif isdefined ("form.gpricemin")>
			gpricemin='1',
		<cfelse>
			gpricemin='0',
		</cfif>
		<cfif isdefined ("form.priceminctrl")>
			priceminctrl='1',
		<cfelse>
			priceminctrl='0',
		</cfif>
		<cfif isdefined ("form.printoption")>
			printoption='1',
		<cfelse>
			printoption='0',
		</cfif>
		<cfif isdefined ("form.negstk")>
			negstk = '1',
		<cfelse>
			negstk='0',
		</cfif>
		<cfif isdefined ("form.invoneset")>
			invoneset='1',
		<cfelse>
			invoneset='0',
		</cfif>
		<cfif isdefined ("form.postvalue")>
			postvalue='#form.postvalue#',
		<cfelse>
			postvalue='',
		</cfif>
		<cfif isdefined ("form.shipvia")>
			shipvia='1',
		<cfelse>
			shipvia='0',
		</cfif>
		<cfif isdefined ("form.filteritem")>
			filteritem='1',
		<cfelse>
			filteritem='0',
		</cfif>
		<cfif isdefined ("form.texteditor")>
			texteditor='1',
		<cfelse>
			texteditor='0',
		</cfif>
		<cfif isdefined ("form.rc_oneset")>
			rc_oneset='1',
		<cfelse>
			rc_oneset='0',
		</cfif>
		<cfif isdefined ("form.pr_oneset")>
			pr_oneset='1',
		<cfelse>
			pr_oneset='0',
		</cfif>
		<cfif isdefined ("form.do_oneset")>
			do_oneset='1',
		<cfelse>
			do_oneset='0',
		</cfif>
		<cfif isdefined ("form.cs_oneset")>
			cs_oneset='1',
		<cfelse>
			cs_oneset='0',
		</cfif>
		<cfif isdefined ("form.cn_oneset")>
			cn_oneset='1',
		<cfelse>
			cn_oneset='0',
		</cfif>
		<cfif isdefined ("form.dn_oneset")>
			dn_oneset='1',
		<cfelse>
			dn_oneset='0',
		</cfif>
		<cfif isdefined ("form.iss_oneset")>
			iss_oneset='1',
		<cfelse>
			iss_oneset='0',
		</cfif>
		<cfif isdefined ("form.po_oneset")>
			po_oneset='1',
		<cfelse>
			po_oneset='0',
		</cfif>
		<cfif isdefined ("form.so_oneset")>
			so_oneset='1',
		<cfelse>
			so_oneset='0',
		</cfif>
		<cfif isdefined ("form.quo_oneset")>
			quo_oneset='1',
		<cfelse>
			quo_oneset='0',
		</cfif>
		<cfif isdefined ("form.assm_oneset")>
			assm_oneset='1',
		<cfelse>
			assm_oneset='0',
		</cfif>
		<cfif isdefined ("form.tr_oneset")>
			tr_oneset='1',
		<cfelse>
			tr_oneset='0',
		</cfif>
		<cfif isdefined ("form.oai_oneset")>
			oai_oneset='1',
		<cfelse>
			oai_oneset='0',
		</cfif>
		<cfif isdefined ("form.oar_oneset")>
			oar_oneset='1',
		<cfelse>
			oar_oneset='0',
		</cfif>
		<cfif isdefined ("form.sam_oneset")>
			sam_oneset='1',
		<cfelse>
			sam_oneset='0',
		</cfif>
		<cfif isdefined ("form.filterall")>
			filterall='1',
		<cfelse>
			filterall='0',
		</cfif>
		<cfif isdefined ("form.multilocation")>
			multilocation='#form.multilocation#',
		<cfelse>
			multilocation='',
		</cfif>	
		<cfif isdefined ("form.suppcustdropdown")>
			suppcustdropdown='#form.suppcustdropdown#',
		<cfelse>
			suppcustdropdown='',
		</cfif>
        <cfif isdefined ("form.wpitemtax")>
			wpitemtax='#form.wpitemtax#',
		<cfelse>
			wpitemtax='',
		</cfif>	
        wpitemtax1=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.wpitemtax1#">,	
		<cfif isdefined ("form.editamount")>
			editamount='#form.editamount#',
		<cfelse>
			editamount='',
		</cfif>	
		priceminpass='#form.priceminpass#',
		gst='#form.gst#',
		<cfif isdefined ("form.df_salestax")>	
			df_salestax='#form.df_salestax#',
		<cfelse>
			df_salestax='',
		</cfif>
		<cfif isdefined ("form.df_purchasetax")>	
			df_purchasetax='#form.df_purchasetax#'
		<cfelse>
			df_purchasetax=''
		</cfif>
		<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
			,driver='#form.driver#'
		</cfif>
        <cfif isdefined("form.defaultEndUser")>
        	,defaultenduser = '1'
         <cfelse>
         	,defaultenduser = ''
		</cfif>
		where companyid='IMS';
	</cfquery>
</cfif>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select * 
	from gsetup;
</cfquery>

<!--- <cfset delinvoice = '#getGeneralInfo.delinvoice#'>
<cfset invsecure = '#getGeneralInfo.invsecure#'> --->
<cfset cost = getGeneralInfo.cost>
<cfset gpricemin = getGeneralInfo.gpricemin>
<cfset priceminctrl = getGeneralInfo.priceminctrl>
<cfset priceminpass = getGeneralInfo.priceminpass>
<cfset printoption = getGeneralInfo.printoption>
<cfset negstk = getGeneralInfo.negstk>
<cfset invoneset = getGeneralInfo.invoneset>
<cfset postvalue = getGeneralInfo.postvalue>
<cfset shipvia = getGeneralInfo.shipvia>
<cfset gst = getGeneralInfo.gst>
<cfset filteritem = getGeneralInfo.filteritem>
<cfset texteditor = getGeneralInfo.texteditor>
<!--- ADD ON 19-06-2008 --->
<cfset rc_oneset = getGeneralInfo.rc_oneset>
<cfset pr_oneset = getGeneralInfo.pr_oneset>
<cfset do_oneset = getGeneralInfo.do_oneset>
<cfset cs_oneset = getGeneralInfo.cs_oneset>
<cfset cn_oneset = getGeneralInfo.cn_oneset>
<cfset dn_oneset = getGeneralInfo.dn_oneset>
<cfset iss_oneset = getGeneralInfo.iss_oneset>
<cfset po_oneset = getGeneralInfo.po_oneset>
<cfset so_oneset = getGeneralInfo.so_oneset>
<cfset quo_oneset = getGeneralInfo.quo_oneset>
<cfset assm_oneset = getGeneralInfo.assm_oneset>
<cfset tr_oneset = getGeneralInfo.tr_oneset>
<cfset oai_oneset = getGeneralInfo.oai_oneset>
<cfset oar_oneset = getGeneralInfo.oar_oneset>
<cfset sam_oneset = getGeneralInfo.sam_oneset>
<!--- ADD ON 11-09-2008 --->
<cfset filterall = getGeneralInfo.filterall>
<!--- ADD ON 18-11-2008 --->
<cfset xmultilocation = getGeneralInfo.multilocation>
<!--- ADD ON 16-06-2009 --->
<cfset suppcustdropdown=getGeneralInfo.suppcustdropdown>
<!--- ADD ON 30-07-2009 --->
<cfset wpitemtax=getGeneralInfo.wpitemtax>
<cfset wpitemtax1=getGeneralInfo.wpitemtax1>
<!--- ADD ON 07-10-2009 --->
<cfset editamount=getGeneralInfo.editamount>
<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
	<cfset driver=getGeneralInfo.driver>
</cfif>
<!--- ADD ON 26-10-2009 --->
<cfset df_salestax=getGeneralInfo.df_salestax>
<cfset df_purchasetax=getGeneralInfo.df_purchasetax>

<!--- ADD ON 30-10-2009 --->
<cfset defaultEndUser = getGeneralInfo.defaultenduser>

<body>

<h4>
	<a href="comprofile.cfm">Company Profile</a> || 
	<a href="lastusedno.cfm">Last Used No</a> || 
	<a>Transaction Setup</a> ||
	<a href="Accountno.cfm">UBS Accounting Default Setup</a> || 
	<a href="userdefine.cfm">User Defined</a> || 
	<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a> ||
	<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a> ||
	<a href="userdefineformula.cfm">User Define - Formula</a>
</h4>

<h1>General Setup - Transaction Setup</h1>

<cfform name="transaction_menu"  action="transaction.cfm?type=save" method="post">
	<table align="center" class="data" width="50%">
		<tr>
			<th onClick="javascript:shoh('transaction_menu_page1');shoh('transaction_menu_page2');">Page 1<img src="/images/d.gif" name="imgtransaction_menu_page1" align="center"></th>
			<th onClick="javascript:shoh('transaction_menu_page2');shoh('transaction_menu_page1');">Page 2<img src="/images/u.gif" name="imgtransaction_menu_page2" align="center"></th>
		</tr>
	</table>
	<cfoutput>
	<table id="transaction_menu_page1" align="center" class="data" width="50%">
		<tr> 
      		<td colspan="2"><div align="center"><strong>Transaction Setup</strong></div></td>
    	</tr>
		<tr> 
      		<th>Use only 1 set of Invoice no</th>
      		<td><input name="invoneset" type="checkbox" value="1" <cfif invoneset eq '1'>checked</cfif>></td>
    	</tr>
		<!--- BEGIN: ADD ON 190608 --->
		<cfif HcomID eq "pnp_i">
			<input name="rc_oneset" type="hidden" value="#rc_oneset#">
			<input name="pr_oneset" type="hidden" value="#pr_oneset#">
			<input name="do_oneset" type="hidden" value="#do_oneset#">
			<input name="cs_oneset" type="hidden" value="#cs_oneset#">
			<input name="cn_oneset" type="hidden" value="#cn_oneset#">
			<input name="dn_oneset" type="hidden" value="#dn_oneset#">
			<input name="iss_oneset" type="hidden" value="#iss_oneset#">
			<input name="po_oneset" type="hidden" value="#po_oneset#">
			<input name="so_oneset" type="hidden" value="#so_oneset#">
			<input name="quo_oneset" type="hidden" value="#quo_oneset#">
			<input name="assm_oneset" type="hidden" value="#assm_oneset#">
			<input name="tr_oneset" type="hidden" value="#tr_oneset#">
			<input name="oai_oneset" type="hidden" value="#oai_oneset#">
			<input name="oar_oneset" type="hidden" value="#oar_oneset#">
			<input name="sam_oneset" type="hidden" value="#sam_oneset#">
		<cfelse>
			<tr> 
      			<th>Use only 1 set of Purchase Receive no</th>
      			<td><input name="rc_oneset" type="checkbox" value="1" <cfif rc_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Purchase Return no</th>
      			<td><input name="pr_oneset" type="checkbox" value="1" <cfif pr_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Delivery Order no</th>
      			<td><input name="do_oneset" type="checkbox" value="1" <cfif do_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Cash Sales no</th>
      			<td><input name="cs_oneset" type="checkbox" value="1" <cfif cs_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Credit Note no</th>
      			<td><input name="cn_oneset" type="checkbox" value="1" <cfif cn_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Debit Note no</th>
      			<td><input name="dn_oneset" type="checkbox" value="1" <cfif dn_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Issue no</th>
      			<td><input name="iss_oneset" type="checkbox" value="1" <cfif iss_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Purchase Order no</th>
      			<td><input name="po_oneset" type="checkbox" value="1" <cfif po_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Sales Order no</th>
      			<td><input name="so_oneset" type="checkbox" value="1" <cfif so_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Quotation no</th>
      			<td><input name="quo_oneset" type="checkbox" value="1" <cfif quo_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Assembly no</th>
      			<td><input name="assm_oneset" type="checkbox" value="1" <cfif assm_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Transfer no</th>
      			<td><input name="tr_oneset" type="checkbox" value="1" <cfif tr_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Adjustment Increase no</th>
      			<td><input name="oai_oneset" type="checkbox" value="1" <cfif oai_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Adjustment Reduce no</th>
      			<td><input name="oar_oneset" type="checkbox" value="1" <cfif oar_oneset eq '1'>checked</cfif>></td>
    		</tr>
			<tr> 
      			<th>Use only 1 set of Sample no</th>
      			<td><input name="sam_oneset" type="checkbox" value="1" <cfif sam_oneset eq '1'>checked</cfif>></td>
    		</tr>
		</cfif>
		<tr> 
      		<th>Min Selling Price</th>
      		<td><input name="gpricemin" type="checkbox" value="1" <cfif gpricemin eq '1'>checked</cfif>></td>
    	</tr>
    	<tr> 
      		<th>Min Selling Price Security</th>
      		<td>
				<input name="priceminctrl" type="checkbox" value="1" <cfif priceminctrl eq '1'>checked</cfif>>
        		Password<cfinput name="priceminpass" type="password" value="#priceminpass#" size="10" maxlength="10"></td>
    	</tr>
    	<tr> 
      		<th>Transaction Printing Option</th>
      		<td><input name="printoption" type="checkbox" value="1" <cfif printoption eq '1'>checked</cfif>></td>
    	</tr>
    	<tr>
      		<th>Negative Stock</th>
      		<td><input name="negstk" type="checkbox" value="1" <cfif negstk eq '1'>checked</cfif>></td>
    	</tr>
		<cfif lcase(hcomid) eq "msd_i">
			<tr>
      			<th>Ship Via Selection</th>
      			<td><input name="shipvia" type="checkbox" value="1" <cfif shipvia eq '1'>checked</cfif>></td>
    		</tr>
		<cfelse>
			<input name="shipvia" type="hidden" value="1">
		</cfif>
		<tr> 
      		<th>Default Gst (%)</th>
      		<td><cfinput type="text" name="gst" value="#gst#" size="3" maxlength="2" validate="float" message="Please Enter Correct TAX Value !"></td>
    	</tr>
		<cfquery name="gettaxcode" datasource="#dts#">
			select * from #target_taxtable#
		</cfquery>
		<tr> 
      		<th>Default Sales Tax Code</th>
      		<td>
		      	<select name="df_salestax">
					<cfloop query="gettaxcode">
						<option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_salestax>selected</cfif>>#gettaxcode.code#</option>
					</cfloop>
				</select>
			</td>
    	</tr>
		<tr> 
      		<th>Default Purchase Tax Code</th>
      		<td>
		      	<select name="df_purchasetax">
					<cfloop query="gettaxcode">
						<option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_purchasetax>selected</cfif>>#gettaxcode.code#</option>
					</cfloop>
				</select>
			</td>
    	</tr>
		<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
			<cfquery name="getdriver" datasource="#dts#">
				select driverno,name from driver order by driverno
			</cfquery>
			<tr> 
	      		<th>Default #getGeneralInfo.lDRIVER#</th>
	      		<td>
		      		<select name="driver">
						<option value="">Please select one...</option>
						<cfloop query="getdriver">
							<option value="#getdriver.driverno#" <cfif getdriver.driverno eq driver>selected</cfif>>#getdriver.driverno# - #getdriver.name#</option>
						</cfloop>
					</select>
				</td>
	    	</tr>
		</cfif>
		<tr> 
      		<th>Select Item Code By Filter</th>
      		<td><input name="filteritem" type="checkbox" value="1" <cfif filteritem eq '1'>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Text Editor For Comment</th>
      		<td><input name="texteditor" type="checkbox" value="1" <cfif texteditor eq '1'>checked</cfif>></td>
    	</tr>
        <tr> 
      		<th>With per Item Tax</th>
      		<td>
            	<input name="wpitemtax" type="checkbox" value="1" <cfif wpitemtax eq '1'>checked</cfif>>
                <input name="wpitemtax1" type="text" value="#wpitemtax1#">
            </td>
    	</tr>
        <tr> 
      		<th>Allow Edit Amount</th>
      		<td>
            	<input name="editamount" type="checkbox" value="1" <cfif editamount eq '1'>checked</cfif>>
            </td>
    	</tr>
	</table>
	<table id="transaction_menu_page2" style="display:none" align="center" class="data" width="50%">
		<tr> 
      		<td colspan="2"><div align="center"><strong>Costing Method</strong></div></td>
    	</tr>
    	<tr> 
      		<th>Fixed Cost</th>
      		<td><input type="radio" name="cost" value="fixed"<cfif cost eq "FIXED">checked</cfif>></td>
    	</tr>
    	<tr> 
      		<th>Month Average </th>
      		<td><input type="radio" name="cost" value="month"<cfif cost eq "MONTH">checked</cfif>></td>
    	</tr>
    	<tr> 
      		<th>Moving Average </th>
      		<td><input type="radio" name="cost" value="moving"<cfif cost eq "MOVING">checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>First In First Out (FIFO)</th>
      		<td><input type="radio" name="cost" value="fifo"<cfif cost eq "FIFO">checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Last In First Out (LIFO)</th>
      		<td><input type="radio" name="cost" value="lifo"<cfif cost eq "LIFO">checked</cfif>></td>
    	</tr>
		<tr> 
      		<td colspan="2"><div align="center"><strong>Posting</strong></div></td>
    	</tr>
    	<tr> 
      		<th>Description</th>
      		<td><input type="radio" name="postvalue" value="desp"<cfif postvalue eq 'desp'>checked</cfif>></td>
    	</tr>
    	<tr> 
      		<th>PONO</th>
      		<td><input type="radio" name="postvalue" value="pono"<cfif postvalue eq 'pono'>checked</cfif>></td>
    	</tr>
		<tr> 
      		<td colspan="2"><div align="center"><strong>Others</strong></div></td>
    	</tr>
		<tr> 
      		<th>Select Product,Category,Group,Supplier/Customer By Filter</th>
      		<td><input name="filterall" type="checkbox" value="1" <cfif filterall eq '1'>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Show Supplier/Customer in Drop Down Selection List</th>
      		<td><input name="suppcustdropdown" type="checkbox" value="1" <cfif suppcustdropdown eq '1'>checked</cfif>></td>
    	</tr>
        <tr> 
      		<th>Default Assign End User In Transaction</th>
      		<td><input name="defaultEndUser" type="checkbox" value="1" <cfif defaultEndUser eq '1'>checked</cfif>></td>
    	</tr>
		<tr> 
      		<td colspan="2"><div align="center"><strong>Multi Location</strong></div></td>
    	</tr>
		<tr> 
      		<th>Invoice</th>
      		<td><input name="multilocation" type="checkbox" value="INV" <cfif ListFindNoCase(xmultilocation, "INV", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Purchase Receive</th>
      		<td><input name="multilocation" type="checkbox" value="RC" <cfif ListFindNoCase(xmultilocation, "RC", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Purchase Return</th>
      		<td><input name="multilocation" type="checkbox" value="PR" <cfif ListFindNoCase(xmultilocation, "PR", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Delivery Order</th>
      		<td><input name="multilocation" type="checkbox" value="DO" <cfif ListFindNoCase(xmultilocation, "DO", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Cash Sales</th>
      		<td><input name="multilocation" type="checkbox" value="CS" <cfif ListFindNoCase(xmultilocation, "CS", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Credit Note</th>
      		<td><input name="multilocation" type="checkbox" value="CN" <cfif ListFindNoCase(xmultilocation, "CN", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Debit Note</th>
      		<td><input name="multilocation" type="checkbox" value="DN" <cfif ListFindNoCase(xmultilocation, "DN", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Issue</th>
      		<td><input name="multilocation" type="checkbox" value="ISS" <cfif ListFindNoCase(xmultilocation, "ISS", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Purchase Order</th>
      		<td><input name="multilocation" type="checkbox" value="PO" <cfif ListFindNoCase(xmultilocation, "PO", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Sales Order</th>
      		<td><input name="multilocation" type="checkbox" value="SO" <cfif ListFindNoCase(xmultilocation, "SO", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Quotation</th>
      		<td><input name="multilocation" type="checkbox" value="QUO" <cfif ListFindNoCase(xmultilocation, "QUO", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Adjustment Increase</th>
      		<td><input name="multilocation" type="checkbox" value="OAI" <cfif ListFindNoCase(xmultilocation, "OAI", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Adjustment Reduce</th>
      		<td><input name="multilocation" type="checkbox" value="OAR" <cfif ListFindNoCase(xmultilocation, "OAR", ",") neq 0>checked</cfif>></td>
    	</tr>
		<tr> 
      		<th>Sample</th>
      		<td><input name="multilocation" type="checkbox" value="SAM" <cfif ListFindNoCase(xmultilocation, "SAM", ",") neq 0>checked</cfif>></td>
    	</tr>
	</table>
	<table align="center" class="data" width="50%">
		<tr> 
      		<td colspan="2" align="center">
          		<input name="submit" type="submit" value="Save">
          		<input name="reset" type="reset" value="Reset">
        	</td>
    	</tr>
	</table>
	</cfoutput>
</cfform>

</body>
</html>