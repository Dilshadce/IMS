<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/jquery-ui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.js"></script>
<script>

  $( document ).tooltip({ position: { my: "center top", at: "center bottom", collision: "flipfit" } });

</script>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * from gsetup
</cfquery>

<cfif isdefined('form.sub_btn')>

<cfquery datasource="#dts#" name="checkrecordcount">
select * from modulecontrol
</cfquery>
<cfif checkrecordcount.recordcount eq 0>
<cfquery datasource="#dts#" name="SaveGeneralInfo">
		insert into modulecontrol (companyid,project,location,serialno,grade,matrix,manufacturing,batchcode) values ('IMS',
        <cfif isdefined ("form.project")>
			project='1'
		<cfelse>
			project='0'
		</cfif>
        ,
        <cfif isdefined ("form.job")>
			job='1'
		<cfelse>
			job='0'
		</cfif>
        ,
        <cfif isdefined ("form.location")>
			location='1'
		<cfelse>
			location='0'
		</cfif>
        ,
        <cfif isdefined ("form.serialno")>
			serialno='1'
		<cfelse>
			serialno='0'
		</cfif>
        ,
        <cfif isdefined ("form.grade")>
			grade='1'
		<cfelse>
			grade='0'
		</cfif>
        ,
        <cfif isdefined ("form.matrix")>
			matrix='1'
		<cfelse>
			matrix='0'
		</cfif>
        ,
        <cfif isdefined ("form.manufacturing")>
			manufacturing='1'
		<cfelse>
			manufacturing='0'
		</cfif>
        ,
         <cfif isdefined ("form.batchcode")>
			batchcode='1'
		<cfelse>
			batchcode='0'
		</cfif>
       
        ) 
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update modulecontrol set 
        <cfif isdefined ("form.project")>
			project='1'
		<cfelse>
			project='0'
		</cfif>
        ,
         <cfif isdefined ("form.job")>
			job='1'
		<cfelse>
			job='0'
		</cfif>
        ,
        <cfif isdefined ("form.location")>
			location='1'
		<cfelse>
			location='0'
		</cfif>
        ,
        <cfif isdefined ("form.serialno")>
			serialno='1'
		<cfelse>
			serialno='0'
		</cfif>
        ,
        <cfif isdefined ("form.grade")>
			grade='1'
		<cfelse>
			grade='0'
		</cfif>
        ,
        <cfif isdefined ("form.matrix")>
			matrix='1'
		<cfelse>
			matrix='0'
		</cfif>
        ,
        <cfif isdefined ("form.manufacturing")>
			manufacturing='1'
		<cfelse>
			manufacturing='0'
		</cfif>
        ,
        <cfif isdefined ("form.batchcode")>
			batchcode='1'
		<cfelse>
			batchcode='0'
		</cfif>
		where companyid='IMS';
	</cfquery>
</cfif>   

</cfif>

<cfquery name="getCurrency" datasource="#dts#">
	select * from #target_currency#
	order by CurrCode 
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfset cost = getgsetup.cost>
<cfset negstk = getgsetup.negstk>
<cfset gpricemin = getgsetup.gpricemin>
<cfset priceminctrl = getgsetup.priceminctrl>
<cfset priceminpass = getgsetup.priceminpass>


<cfoutput>
<cfform name="wizard2form" id="wizard3form" method="post" action="wizard5.cfm?type=w5">
<cfinclude template="header_wizard.cfm">
<!---<div align="Center"><h3>*Below is a <strong>6 step</strong> simple wizard to help you set up your Inventory Management System</h3></div>--->
<br />
<br />
<h1 align="center">Transaction & Stock Control</h1>
<table height="400" cellpadding="0" cellspacing="0" style="border: 1px solid black ;" align="center">
<tr><td>&nbsp;</td></tr>

	  <tr ><th><div align="center">Costing Method</div></th>
      <th><div align="center">Description</div></th>
      <th><div align="center">Action</div></th>
      </tr>
      <tr >
        <td align="left">Fixed Cost</td>
        <td align="left">This is a simple straight forward single cost method.</td>
        <td align="center"><input type="radio" name="cost" value="fixed"<cfif cost eq "FIXED">checked</cfif>></td>
      </tr>
      <tr >
        <td align="left">Month Average</td>
        <td align="left">This costing method will do re-value the new cost average at end of the month.</td>
        <td align="center"><input type="radio" name="cost" value="month"<cfif cost eq "MONTH">checked</cfif>></td>
      </tr>
      <tr >
        <td align="left">Moving Average</td>
        <td align="left">Use current unit cost for costing withdrawals until another purchase is made and compute new average cost.</td>
        <td align="center"><input type="radio" name="cost" value="moving"<cfif cost eq "MOVING">checked</cfif>></td>
      </tr>
      <tr >
        <td align="left">Weighted Average</td>
        <td align="left">Will be based on amount of inventory computed at the end of period (include opening).</td>
        <td align="center"><input type="radio" name="cost" value="weight"<cfif cost eq "WEIGHT">checked</cfif>></td>
      </tr>
      <tr >
        <td align="left">First In First Out (FIFO)&nbsp;&nbsp;</td>
        <td align="left">An inventory costing method where the good placed first in an inventory is sold first.</td>
        <td align="center"><input type="radio" name="cost" value="fifo"<cfif cost eq "FIFO">checked</cfif>></td>
      </tr>
      <tr >
        <td align="left">Last In First Out (LIFO)&nbsp;&nbsp;&nbsp;</td>
        <td align="left">An inventory costing method where the good placed last in an inventory is sold first.</td>
        <td align="center"><input type="radio" name="cost" value="lifo"<cfif cost eq "LIFO">checked</cfif>></td>
      </tr>
	  <tr>
	  	<td colspan="100%" align="right">&nbsp;</td>
	  </tr>
      <tr><th colspan="100%"><div align="center">Control Setting</div></th></tr>
      <tr title="An option for user to enable negative stock when issue a transaction. If this option is tick, then when user issue any transaction, although the stock is negative, they are also allowed to issue the transaction. If not, otherwise.">
        <td align="center" colspan="2">Enable Negative Stock</td>
        <td align="center"><input name="negstk" type="checkbox" value="1" <cfif negstk eq '1'>checked</cfif>></td>
      </tr>
      <tr title="An option for user to enable min selling price. If this option is tick, the user is able to issue price less than selling price.">
      	<td align="center" colspan="2">Min Selling Price</td>
        <td align="center"><input name="gpricemin" id="gpricemin" type="checkbox" value="1" <cfif gpricemin eq '1'>checked</cfif>></td>
      </tr>
      <tr title="An option for user to key in password when issue item with min selling price. If this option is tick, then when user key issue item with min price a password confimation will pop out.">
        <td align="center"  colspan="2">Min Selling Price Security</td>
        <td align="center"><input name="priceminctrl" id="priceminctrl" type="checkbox" value="1" <cfif priceminctrl eq '1'>checked</cfif>></td>
      </tr>
	  <tr>
	  	<td align="right" colspan="2">Password</td>
		<td align="center"><cfinput name="priceminpass" type="password" value="#priceminpass#" maxlength="10"></td>
	  </tr>
<tr>
<tr><td>&nbsp;</td></tr>
<td colspan="3" align="center">
<!--- <p align="right">
<input type="button" name="skip_this" id="skip_this" value="Skip This" onclick="window.location.href='wizard5.cfm?type=w5'" />
</p> --->
<input type="button" name="back_btn" id="back_btn" value="Back" onclick="window.location.href='wizard3.cfm?type=w3'" />&nbsp;&nbsp;&nbsp;
<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
</td>
</tr>
</table>

</cfform>
</cfoutput>

<cfwindow center="true" width="750" height="220" name="Guide4" refreshOnShow="true"
        title="Costing Method" initshow="false" modal="true"
        source="Guide4.cfm" />
