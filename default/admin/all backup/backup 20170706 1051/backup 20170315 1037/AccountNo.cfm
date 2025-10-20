<html>
<head>
<title>UBS Accounting Default Setup</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>

<cfif isdefined("url.type")>
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update gsetup set 
		creditsales=UPPER('#form.creditsales#'),
		cashsales=UPPER('#form.cashsales#'),
		salesreturn=UPPER('#form.salesreturn#'),
		discsales=UPPER('#form.discsales#'),
		gstsales=UPPER('#form.gstsales#'),
		custmisc1=UPPER('#form.custmisc1#'),
		custmisc2=UPPER('#form.custmisc2#'),
		custmisc3=UPPER('#form.custmisc3#'),
		custmisc4=UPPER('#form.custmisc4#'),
		custmisc5=UPPER('#form.custmisc5#'),
		custmisc6=UPPER('#form.custmisc6#'),
		custmisc7=UPPER('#form.custmisc7#'),
		purchasereceive=UPPER('#form.purchasereceive#'),
		purchasereturn=UPPER('#form.purchasereturn#'),
		discpur=UPPER('#form.discpur#'),
		gstpurchase=UPPER('#form.gstpurchase#'),
		suppmisc1=UPPER('#form.suppmisc1#'),
		suppmisc2=UPPER('#form.suppmisc2#'),
		suppmisc3=UPPER('#form.suppmisc3#'),
		suppmisc4=UPPER('#form.suppmisc4#'),
		suppmisc5=UPPER('#form.suppmisc5#'),
		suppmisc6=UPPER('#form.suppmisc6#'),
		suppmisc7=UPPER('#form.suppmisc7#'),
		cashaccount=UPPER('#form.cashaccount#'),
		chequeaccount=UPPER('#form.chequeaccount#'),
		creditcardaccount1=UPPER('#form.creditcardaccount1#'),
		creditcardaccount2=UPPER('#form.creditcardaccount2#'),
        debitcardaccount=UPPER('#form.debitcardaccount#'),
		cashvoucheraccount=UPPER('#form.cashvoucheraccount#'),
		depositaccount=UPPER('#form.depositaccount#'),
        <cfif isdefined("form.bankaccount")>
        bankaccount=UPPER('#form.bankaccount#'),
        </cfif>
		withholdingtaxaccount=UPPER('#form.withholdingtaxaccount#')
        <!--- ADD ON 27-07-2009 --->
		<cfif lcase(hcomid) eq "mhsl_i">
            ,nbt=UPPER('#form.nbt#')
        </cfif>
		where companyid='IMS';
	</cfquery>
</cfif>

<cfquery name="getgeneralinfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfset creditsales = getgeneralinfo.creditsales>
<cfset cashsales = getgeneralinfo.cashsales>
<cfset salesreturn = getgeneralinfo.salesreturn>
<cfset discsales = getgeneralinfo.discsales>
<cfset gstsales = getgeneralinfo.gstsales>
<cfset custmisc1 = getgeneralinfo.custmisc1>
<cfset custmisc2 = getgeneralinfo.custmisc2>
<cfset custmisc3 = getgeneralinfo.custmisc3>
<cfset custmisc4 = getgeneralinfo.custmisc4>
<cfset custmisc5 = getgeneralinfo.custmisc5>
<cfset custmisc6 = getgeneralinfo.custmisc6>
<cfset custmisc7 = getgeneralinfo.custmisc7>
<cfset purchasereceive = getgeneralinfo.purchasereceive>
<cfset purchasereturn = getgeneralinfo.purchasereturn>
<cfset discpur = getgeneralinfo.discpur>
<cfset gstpurchase = getgeneralinfo.gstpurchase>
<cfset suppmisc1 = getgeneralinfo.suppmisc1>
<cfset suppmisc2 = getgeneralinfo.suppmisc2>
<cfset suppmisc3 = getgeneralinfo.suppmisc3>
<cfset suppmisc4 = getgeneralinfo.suppmisc4>
<cfset suppmisc5 = getgeneralinfo.suppmisc5>
<cfset suppmisc6 = getgeneralinfo.suppmisc6>
<cfset suppmisc7 = getgeneralinfo.suppmisc7>
<cfset cashaccount = getgeneralinfo.cashaccount>
<cfset chequeaccount = getgeneralinfo.chequeaccount>
<cfset creditcardaccount1 = getgeneralinfo.creditcardaccount1>
<cfset creditcardaccount2 = getgeneralinfo.creditcardaccount2>
<cfset debitcardaccount = getgeneralinfo.debitcardaccount>
<cfset cashvoucheraccount = getgeneralinfo.cashvoucheraccount>
<cfset depositaccount = getgeneralinfo.depositaccount>
<cfset bankaccount = getgeneralinfo.bankaccount>
<cfset withholdingtaxaccount = getgeneralinfo.withholdingtaxaccount>
<!--- ADD ON 27-07-2009 --->
<cfif lcase(hcomid) eq "mhsl_i">
	<cfset nbt=getgeneralinfo.nbt>
</cfif>

<body>
<cfif lcase(husergrpid) eq "super">
<h4>
<cfif getpin2.h5110 eq "T"><a href="comprofile.cfm">Company Profile</a> </cfif>
    <cfif getpin2.h5120 eq "T">|| <a href="lastusedno.cfm">Last Used No</a> </cfif>
    <cfif getpin2.h5130 eq "T">|| <a href="transaction.cfm">Transaction Setup</a> </cfif>
    <cfif getpin2.h5140 eq "T">|| AMS Accounting Default Setup</cfif> 
    <cfif getpin2.h5150 eq "T">|| <a href="userdefine.cfm">User Defined</a> </cfif>
    <cfif getpin2.h5160 eq "T">||<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a> </cfif> 
    <cfif getpin2.h5170 eq "T">||<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a> </cfif> 
    <cfif getpin2.h5180 eq "T">||<a href="userdefineformula.cfm">User Define - Formula</a></cfif>
    <cfif husergrpid eq "super">||<a href="modulecontrol.cfm">Module Control</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup.cfm">Listing Setup</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup2.cfm">Display Detail</a></cfif>
</h4>
</cfif>

<h1 align="center">General Setup - AMS Accounting Default Setup</h1>

<cfif Hlinkams eq "Y">
	<cfinclude template="AccountNo_ams.cfm">
<cfelse>
	<cfinclude template="AccountNo_ims.cfm">
</cfif>

</body>
</html>