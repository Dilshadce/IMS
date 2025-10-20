<html>
<head>
<title>User Defined</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfquery name="getremarkInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfif isdefined("url.type")>
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update gsetup set 
		Lcategory='#form.lcategory#',
		Lmodel='#form.lmodel#',
		Lrating='#form.lrating#',
		Lgroup='#form.lgroup#',
        Lbrand='#form.Lbrand#',
		Lsize='#form.lsize#',
		Lmaterial='#form.lmaterial#',
		lAGENT='#form.lAGENT#',
        lTEAM='#form.lTEAM#',
		lDRIVER='#form.lDRIVER#',
		lLOCATION='#form.lLOCATION#',
		lPROJECT='#form.lPROJECT#',
		lJOB='#form.lJOB#',
        lBATCH='#form.lBATCH#',
        lterm='#form.lterm#',
        lserial='#form.lserial#',
        bodyso='#form.bodyso#',
        bodypo='#form.bodypo#',
        bodydo='#form.bodydo#', 
        ldescription='#form.ldescription#',
        litemno='#form.litemno#',
        laitemno='#form.laitemno#',
        lbarcode='#form.lbarcode#',
        lRC='#form.lRC#',
        lPR='#form.lPR#',
        lDO='#form.lDO#',
        lINV='#form.lINV#',
        lCS='#form.lCS#',
        lCN='#form.lCN#',
        lDN='#form.lDN#',
        lPO='#form.lPO#',
        lRQ='#form.lRQ#',
        lQUO='#form.lQUO#',
        lSO='#form.lSO#',
        lSAM='#form.lSAM#',
        lISS='#form.lISS#',
        lOAI='#form.lOAI#',
        lOAR='#form.lOAR#',
        lCONSIGNIN='#form.lCONSIGNIN#',
        lCONSIGNOUT='#form.lCONSIGNOUT#',
        ass='#form.ass#',
		rem0='#form.rem0#',
		rem1='#form.rem1#',
		rem2='#form.rem2#',
		rem3='#form.rem3#',
		rem4='#form.rem4#',
		rem5='#form.rem5#',
		rem6='#form.rem6#',
		rem7='#form.rem7#',
		rem8='#form.rem8#',
		rem9='#form.rem9#',
		rem10='#form.rem10#',
		rem11='#form.rem11#',
        refno2='#form.refno2#',
        misccharge1='#form.misccharge1#',
        misccharge2='#form.misccharge2#',
        misccharge3='#form.misccharge3#',
        misccharge4='#form.misccharge4#',
        misccharge5='#form.misccharge5#',
        misccharge6='#form.misccharge6#',
        misccharge7='#form.misccharge7#',
		rem12='#form.rem12#',
		brem1='#form.brem1#',
		brem2='#form.brem2#',
		brem3='#form.brem3#',
		brem4='#form.brem4#',
        remark5list='#form.remark5list#',
        remark6list='#form.remark6list#',
        remark7list='#form.remark7list#',
        remark8list='#form.remark8list#',
        remark9list='#form.remark9list#',
        remark10list='#form.remark10list#',
        bodyremark1list='#bodyremark1list#',
        bodyremark2list='#bodyremark2list#',
        bodyremark3list='#bodyremark3list#',
        bodyremark4list='#bodyremark4list#'
		where companyid='IMS';
	</cfquery>
    
    
    <cfquery datasource="#dts#" name="saveuserdefault">
    update userdefault set 
    inv_desp='#form.inv_desp#',
    do_desp='#form.do_desp#',
    pr_desp='#form.pr_desp#',
    rc_desp='#form.rc_desp#',
    po_desp='#form.po_desp#',
    so_desp='#form.so_desp#',
    cs_desp='#form.cs_desp#',
    cn_desp='#form.cn_desp#',
    dn_desp='#form.dn_desp#',
    quo_desp='#form.quo_desp#',
    rq_desp='#form.rq_desp#'
    
    where company='IMS';
    </cfquery>

    <cfquery datasource="#dts#" name="Saveaddonremark">
    update extraremark set
    	<cfif getremarkInfo.addonremark eq 'Y'> 
    	rem30='#form.rem30#',
		rem31='#form.rem31#',
		rem32='#form.rem32#',
		rem33='#form.rem33#',
		rem34='#form.rem34#',
		rem35='#form.rem35#',
		rem36='#form.rem36#',
		rem37='#form.rem37#',
		rem38='#form.rem38#',
        rem39='#form.rem39#',
		rem40='#form.rem40#',
		rem41='#form.rem41#',
		rem42='#form.rem42#',
		rem43='#form.rem43#',
		rem44='#form.rem44#',
		rem45='#form.rem45#',
		rem46='#form.rem46#',
		rem47='#form.rem47#',
        rem48='#form.rem48#',
		rem49='#form.rem49#',
        </cfif>
        trrem0='#form.trrem0#',
        trrem1='#form.trrem1#',
        trrem2='#form.trrem2#',
        trrem3='#form.trrem3#',
        trrem4='#form.trrem4#',
        trrem5='#form.trrem5#',
        trrem6='#form.trrem6#',
        trrem7='#form.trrem7#',
        trrem8='#form.trrem8#',
        trrem9='#form.trrem9#',
        trrem10='#form.trrem10#',
        trrem11='#form.trrem11#',
        cust_rem1='#form.cust_rem1#',
        cust_rem2='#form.cust_rem2#',
        cust_rem3='#form.cust_rem3#',
        
        <cfloop from="5" to="20" index="a">
        <cfif isdefined('form.cust_rem#a#')>
        cust_rem#a# = '#evaluate('form.cust_rem#a#')#',
        cust_rem#a#list = '#evaluate('form.cust_rem#a#list')#',
        </cfif>
        
        </cfloop>
        
        cust_rem4='#form.cust_rem4#'
        
    where companyid='IMS';
    </cfquery>

    
</cfif>
<cfquery name="getremarkdetail" datasource="#dts#">
	select * 
	from extraremark;
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfquery name="getuserdefault" datasource="#dts#">
	select * 
	from userdefault;
</cfquery>

<cfset Lcategory = getGeneralInfo.Lcategory>
<cfset Lgroup = getGeneralInfo.Lgroup>
<cfset Lbrand = getGeneralInfo.Lbrand>
<cfset Lmodel = getGeneralInfo.Lmodel>
<cfset Lrating = getGeneralInfo.Lrating>
<cfset Lsize = getGeneralInfo.Lsize>
<cfset Lmaterial = getGeneralInfo.Lmaterial>
<cfset rem0 = getGeneralInfo.rem0>
<cfset rem1 = getGeneralInfo.rem1>
<cfset rem2 = getGeneralInfo.rem2>
<cfset rem3 = getGeneralInfo.rem3>
<cfset rem4 = getGeneralInfo.rem4>
<cfset rem5 = getGeneralInfo.rem5>
<cfset rem6 = getGeneralInfo.rem6>
<cfset rem7 = getGeneralInfo.rem7>
<cfset rem8 = getGeneralInfo.rem8>
<cfset rem9 = getGeneralInfo.rem9>
<cfset rem10 = getGeneralInfo.rem10>
<cfset rem11 = getGeneralInfo.rem11>

<cfset misccharge1 = getGeneralInfo.misccharge1>
<cfset misccharge2 = getGeneralInfo.misccharge2>
<cfset misccharge3 = getGeneralInfo.misccharge3>
<cfset misccharge4 = getGeneralInfo.misccharge4>
<cfset misccharge5 = getGeneralInfo.misccharge5>
<cfset misccharge6 = getGeneralInfo.misccharge6>
<cfset misccharge7 = getGeneralInfo.misccharge7>

<cfset refno2 = getGeneralInfo.refno2>
<cfset rem12 = getGeneralInfo.rem12>
<cfset brem1 = getGeneralInfo.brem1>
<cfset brem2 = getGeneralInfo.brem2>
<cfset brem3 = getGeneralInfo.brem3>
<cfset brem4 = getGeneralInfo.brem4>

<cfset remark5list = getGeneralInfo.remark5list>
<cfset remark6list = getGeneralInfo.remark6list>
<cfset remark7list = getGeneralInfo.remark7list>
<cfset remark8list = getGeneralInfo.remark8list>
<cfset remark9list = getGeneralInfo.remark9list>
<cfset remark10list = getGeneralInfo.remark10list>

<cfset bodyremark1list = getGeneralInfo.bodyremark1list>
<cfset bodyremark2list = getGeneralInfo.bodyremark2list>
<cfset bodyremark3list = getGeneralInfo.bodyremark3list>
<cfset bodyremark4list = getGeneralInfo.bodyremark4list>

<!--- ADD ON 14-07-2009 --->
<cfset lAGENT = getGeneralInfo.lAGENT>
<cfset lTEAM = getGeneralInfo.lTEAM>
<cfset lDRIVER = getGeneralInfo.lDRIVER>
<cfset lLOCATION = getGeneralInfo.lLOCATION>
<!--- ADD ON 26-03-2010 --->
<cfset lPROJECT = getGeneralInfo.lPROJECT>
<cfset lJOB = getGeneralInfo.lJOB>
<cfset lBATCH = getGeneralInfo.lBATCH>
<cfset lterm = getGeneralInfo.lterm>
<cfset lserial = getGeneralInfo.lserial>
<cfset bodyso = getGeneralInfo.bodyso>
<cfset bodypo = getGeneralInfo.bodypo>
<cfset bodydo = getGeneralInfo.bodydo>
<cfset ldescription = getGeneralInfo.ldescription>
<cfset litemno = getGeneralInfo.litemno>
<cfset laitemno = getGeneralInfo.laitemno>
<cfset lbarcode = getGeneralInfo.lbarcode>
<cfset lRC = getGeneralInfo.lRC>
<cfset lPR = getGeneralInfo.lPR>
<cfset lDO = getGeneralInfo.lDO>
<cfset lINV = getGeneralInfo.lINV>
<cfset lCS = getGeneralInfo.lCS>
<cfset lCN = getGeneralInfo.lCN>
<cfset lDN = getGeneralInfo.lDN>
<cfset lPO = getGeneralInfo.lPO>
<cfset lRQ = getGeneralInfo.lRQ>
<cfset lQUO = getGeneralInfo.lQUO>
<cfset lSO = getGeneralInfo.lSO>
<cfset lSAM = getGeneralInfo.lSAM>
<cfset LISS = getGeneralInfo.LISS>
<cfset lOAI = getGeneralInfo.lOAI>
<cfset lOAR = getGeneralInfo.lOAR>
<cfset lCONSIGNIN = getGeneralInfo.lCONSIGNIN>
<cfset lCONSIGNOUT = getGeneralInfo.lCONSIGNOUT>
<cfset ass = getGeneralInfo.ass>

<cfset inv_desp = getuserdefault.inv_desp>
<cfset do_desp = getuserdefault.do_desp>
<cfset pr_desp = getuserdefault.pr_desp>

<cfset rc_desp = getuserdefault.rc_desp>
<cfset po_desp = getuserdefault.po_desp>
<cfset so_desp = getuserdefault.so_desp>
<cfset cs_desp = getuserdefault.cs_desp>
<cfset cn_desp = getuserdefault.cn_desp>
<cfset dn_desp = getuserdefault.dn_desp>
<cfset quo_desp = getuserdefault.quo_desp>
<cfset rq_desp = getuserdefault.rq_desp>


<cfset rem30 = getremarkdetail.rem30>
<cfset rem31 = getremarkdetail.rem31>
<cfset rem32 = getremarkdetail.rem32>
<cfset rem33 = getremarkdetail.rem33>
<cfset rem34 = getremarkdetail.rem34>
<cfset rem35 = getremarkdetail.rem35>
<cfset rem36 = getremarkdetail.rem36>
<cfset rem37 = getremarkdetail.rem37>
<cfset rem38 = getremarkdetail.rem38>
<cfset rem39 = getremarkdetail.rem39>
<cfset rem40 = getremarkdetail.rem40>
<cfset rem41 = getremarkdetail.rem41>
<cfset rem42 = getremarkdetail.rem42>
<cfset rem43 = getremarkdetail.rem43>
<cfset rem44 = getremarkdetail.rem44>
<cfset rem45 = getremarkdetail.rem45>
<cfset rem46 = getremarkdetail.rem46>
<cfset rem47 = getremarkdetail.rem47>
<cfset rem48 = getremarkdetail.rem48>
<cfset rem49 = getremarkdetail.rem49>

<cfset trrem0 = getremarkdetail.trrem0>
<cfset trrem1 = getremarkdetail.trrem1>
<cfset trrem2 = getremarkdetail.trrem2>
<cfset trrem3 = getremarkdetail.trrem3>
<cfset trrem4 = getremarkdetail.trrem4>
<cfset trrem5 = getremarkdetail.trrem5>
<cfset trrem6 = getremarkdetail.trrem6>
<cfset trrem7 = getremarkdetail.trrem7>
<cfset trrem8 = getremarkdetail.trrem8>
<cfset trrem9 = getremarkdetail.trrem9>
<cfset trrem10 = getremarkdetail.trrem10>
<cfset trrem11 = getremarkdetail.trrem11>

<cfset cust_rem1 = getremarkdetail.cust_rem1>
<cfset cust_rem2 = getremarkdetail.cust_rem2>
<cfset cust_rem3 = getremarkdetail.cust_rem3>
<cfset cust_rem4 = getremarkdetail.cust_rem4>

<cfloop from="5" to="20" index="a">
        <cfif isdefined('getremarkdetail.cust_rem#a#')>
       <cfset 'cust_rem#a#' = evaluate('getremarkdetail.cust_rem#a#')>
       <cfset 'cust_rem#a#list' = evaluate('getremarkdetail.cust_rem#a#list')>
        </cfif>
        </cfloop>

<body>

<h4>
	<cfif getpin2.h5110 eq "T"><a href="comprofile.cfm">Company Profile</a> </cfif>
    <cfif getpin2.h5120 eq "T">|| <a href="lastusedno.cfm">Last Used No</a> </cfif>
    <cfif getpin2.h5130 eq "T">|| <a href="transaction.cfm">Transaction Setup</a> </cfif>
    <cfif getpin2.h5140 eq "T">|| <a href="Accountno.cfm">AMS Accounting Default Setup</a> </cfif> 
    <cfif getpin2.h5150 eq "T">||User Defined</cfif>
    <cfif getpin2.h5160 eq "T">||<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a> </cfif> 
    <cfif getpin2.h5170 eq "T">||<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a> </cfif> 
    <cfif getpin2.h5180 eq "T">||<a href="userdefineformula.cfm">User Define - Formula</a></cfif>
    <cfif husergrpid eq "super">||<a href="modulecontrol.cfm">Module Control</a></cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup.cfm">Listing Setup</a></cfif>
     <cfif getpin2.h5130 eq "T">||<a href="displaysetup2.cfm">Display Detail</a></cfif>
</h4>

<h1>General Setup - User Defined</h1>

<cfform action="/default/admin/userdefine.cfm?type=save" method="post">
	<table width="500" align="center" style="border: 3px ridge #CCC;
	border-spacing: 0;
    border-radius: 7px;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	-khtml-border-radius-: 7px;
	text-shadow:#FFF;
	background-color:#F5F5F5;" cellspacing="0">
        
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center"><strong>Profile</strong></div></th></tr>
		<tr> 
		  	<th>Category Layer</th>
		  	<td><cfinput name="LCategory" type="text" maxlength="30" size="30" value="#LCategory#"></td>
		</tr>
		<tr> 
		  	<th>Group Layer</th>
		  	<td><cfinput name="Lgroup" type="text" maxlength="30" size="30" value="#Lgroup#"></td>
		</tr>
        <tr> 
		  	<th>Brand Layer</th>
		  	<td><cfinput name="Lbrand" type="text" maxlength="30" size="30" value="#Lbrand#"></td>
		</tr>
		<tr> 
		  	<th>Material Layer</th>
		  	<td><cfinput name="LMaterial" type="text" maxlength="30" size="30" value="#LMaterial#"></td>
		</tr>
		<tr> 
		  	<th>Model Layer</th>
		  	<td><cfinput name="LModel" type="text" maxlength="30" size="30" value="#LModel#"></td>
		</tr>
		<tr> 
		  	<th>Rating Layer</th>
		  	<td><cfinput name="LRating" type="text" maxlength="30" size="30" value="#LRating#"></td>
		</tr>
		<tr> 
		  	<th>Size Layer</th>
		  	<td><cfinput name="Lsize" type="text" maxlength="30" size="30" value="#Lsize#"></td>
		</tr>
		<!--- ADD ON 14-07-2009 --->	
		<tr> 
		  	<th>Agent Layer</th>
		  	<td><cfinput name="lAGENT" type="text" maxlength="30" size="30" value="#lAGENT#"></td>
		</tr>
        <tr> 
		  	<th>Team Layer</th>
		  	<td><cfinput name="lTEAM" type="text" maxlength="30" size="30" value="#lTEAM#"></td>
		</tr>
		<tr> 
		  	<th>End User Layer</th>
		  	<td><cfinput name="lDRIVER" type="text" maxlength="30" size="30" value="#lDRIVER#"></td>
		</tr>
		<tr> 
		  	<th>Location Layer</th>
		  	<td><cfinput name="lLOCATION" type="text" maxlength="30" size="30" value="#lLOCATION#"></td>
		</tr>
		<!--- ADD ON 26-03-2010 --->
		<tr> 
		  	<th>Project Layer</th>
		  	<td><cfinput name="lPROJECT" type="text" maxlength="30" size="30" value="#lPROJECT#"></td>
		</tr>
		<tr> 
		  	<th>Job Layer</th>
		  	<td><cfinput name="lJOB" type="text" maxlength="30" size="30" value="#lJOB#"></td>
		</tr>
        
        <tr> 
		  	<th>Item Layer</th>
		  	<td><cfinput name="litemno" type="text" maxlength="30" size="30" value="#litemno#"></td>
		</tr>
        <tr> 
		  	<th>Product Code Layer</th>
		  	<td><cfinput name="laitemno" type="text" maxlength="30" size="30" value="#laitemno#"></td>
		</tr>
        <tr> 
		  	<th>Bar Code Layer</th>
		  	<td><cfinput name="lbarcode" type="text" maxlength="30" size="30" value="#lbarcode#"></td>
		</tr>
        <tr> 
		  	<th>Batch Layer</th>
		  	<td><cfinput name="lBATCH" type="text" maxlength="30" size="30" value="#lBATCH#"></td>
		</tr>
        
        <tr> 
		  	<th>Term Layer</th>
		  	<td><cfinput name="lterm" type="text" maxlength="30" size="30" value="#lterm#"></td>
		</tr>
        <tr> 
		  	<th>Serial No Layer</th>
		  	<td><cfinput name="lserial" type="text" maxlength="30" size="30" value="#lserial#"></td>
		</tr>
        
        <tr> 
		  	<th>SO Layer</th>
		  	<td><cfinput name="bodyso" type="text" maxlength="30" size="30" value="#bodyso#"></td>
		</tr>
        <tr> 
		  	<th>PO Layer</th>
		  	<td><cfinput name="bodypo" type="text" maxlength="30" size="30" value="#bodypo#"></td>
		</tr>
        <tr> 
		  	<th>DO Layer</th>
		  	<td><cfinput name="bodydo" type="text" maxlength="30" size="30" value="#bodydo#"></td>
		</tr>
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Customer Profile</div></th></tr>
        <tr> 
		  	<th>Remark 1</th>
		  	<td><cfinput name="cust_rem1" type="text" maxlength="30" size="30" value="#cust_rem1#"></td>
		</tr>
        <tr> 
		  	<th>Remark 2</th>
		  	<td><cfinput name="cust_rem2" type="text" maxlength="30" size="30" value="#cust_rem2#"></td>
		</tr>
        <tr> 
		  	<th>Remark 3</th>
		  	<td><cfinput name="cust_rem3" type="text" maxlength="30" size="30" value="#cust_rem3#"></td>
		</tr>
        <tr> 
		  	<th>Remark 4</th>
		  	<td><cfinput name="cust_rem4" type="text" maxlength="30" size="30" value="#cust_rem4#"></td>
		</tr>
        <cfif hcomid eq 'mylustre_i' or hcomid eq 'lafa_i'>
        <cfloop from="5" to="20" index="a">
        <tr> 
		  	<th><cfoutput>Remark #a#</cfoutput></th>
		  	<td><cfinput name="cust_rem#a#" type="text" maxlength="30" size="30" value="#evaluate('cust_rem#a#')#"></td>
		</tr>
         <cfoutput><tr> 
		  	<th>Remark #a# Select List</th>
		  	<td><textarea cols="30" rows="4" name="cust_rem#a#List" type="text" >#evaluate('cust_rem#a#List')#</textarea></td>
		</tr></cfoutput>
        </cfloop>
        
        </cfif>
        
        
        
        
        
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Transaction</div></th></tr>
        
        <tr> 
		  	<th>Purchase Receive Layer</th>
		  	<td><cfinput name="lRC" type="text" maxlength="30" size="30" value="#lRC#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Return Layer</th>
		  	<td><cfinput name="lPR" type="text" maxlength="30" size="30" value="#lPR#"></td>
		</tr>
        <tr> 
		  	<th>Delivery Order Layer</th>
		  	<td><cfinput name="lDO" type="text" maxlength="30" size="30" value="#lDO#"></td>
		</tr>
        <tr> 
		  	<th>Invoice Layer</th>
		  	<td><cfinput name="lINV" type="text" maxlength="30" size="30" value="#lINV#"></td>
		</tr>
        <tr> 
		  	<th>Cash Sales Layer</th>
		  	<td><cfinput name="lCS" type="text" maxlength="30" size="30" value="#lCS#"></td>
		</tr>
        <tr> 
		  	<th>Credit Note Layer</th>
		  	<td><cfinput name="lCN" type="text" maxlength="30" size="30" value="#lCN#"></td>
		</tr>
        <tr> 
		  	<th>Debit Note Layer</th>
		  	<td><cfinput name="lDN" type="text" maxlength="30" size="30" value="#lDN#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Order Layer</th>
		  	<td><cfinput name="lPO" type="text" maxlength="30" size="30" value="#lPO#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Requisition Layer</th>
		  	<td><cfinput name="lRQ" type="text" maxlength="30" size="30" value="#lRQ#"></td>
		</tr>
        <tr> 
		  	<th>Quotation Layer</th>
		  	<td><cfinput name="lQUO" type="text" maxlength="30" size="30" value="#lQUO#"></td>
		</tr>
        <tr> 
		  	<th>Sales Order Layer</th>
		  	<td><cfinput name="lSO" type="text" maxlength="30" size="30" value="#lSO#"></td>
		</tr>
        <tr> 
		  	<th>Sample Layer</th>
		  	<td><cfinput name="lSAM" type="text" maxlength="30" size="30" value="#lSAM#"></td>
		</tr>
        <tr> 
		  	<th>Assemble/Dissemble</th>
		  	<td><cfinput name="ass" type="text" maxlength="30" size="30" value="#ass#"></td>
		</tr>
        <tr> 
		  	<th>Issue Layer</th>
		  	<td><cfinput name="lISS" type="text" maxlength="30" size="30" value="#lISS#"></td>
		</tr>
        <tr> 
		  	<th>Adjustment Increase Layer</th>
		  	<td><cfinput name="lOAI" type="text" maxlength="30" size="30" value="#lOAI#"></td>
		</tr>
        <tr> 
		  	<th>Adjustment Reduce Layer</th>
		  	<td><cfinput name="lOAR" type="text" maxlength="30" size="30" value="#lOAR#"></td>
		</tr>
        <tr> 
		  	<th>Consignment Return Layer</th>
		  	<td><cfinput name="lCONSIGNIN" type="text" maxlength="30" size="30" value="#lCONSIGNIN#"></td>
		</tr>
        <tr> 
		  	<th>Consignment Out Layer</th>
		  	<td><cfinput name="lCONSIGNOUT" type="text" maxlength="30" size="30" value="#lCONSIGNOUT#"></td>
		</tr>
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
         <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Transaction Description</div></th></tr>
        
        <tr> 
		  	<th>Invoice Description</th>
		  	<td><cfinput name="inv_desp" type="text" maxlength="30" size="30" value="#inv_desp#"></td>
		</tr>
        
        <tr> 
		  	<th>Delivery Order Description</th>
		  	<td><cfinput name="do_desp" type="text" maxlength="30" size="30" value="#do_desp#"></td>
		</tr>
        <tr> 
		  	<th>Sales Order Description</th>
		  	<td><cfinput name="so_desp" type="text" maxlength="30" size="30" value="#so_desp#"></td>
		</tr>
        <tr> 
		  	<th>Quotation Description</th>
		  	<td><cfinput name="quo_desp" type="text" maxlength="30" size="30" value="#quo_desp#"></td>
		</tr>
        <tr> 
		  	<th>Cash Sales Description</th>
		  	<td><cfinput name="cs_desp" type="text" maxlength="30" size="30" value="#cs_desp#"></td>
		</tr>
        <tr> 
		  	<th>Credit Note Description</th>
		  	<td><cfinput name="cn_desp" type="text" maxlength="30" size="30" value="#cn_desp#"></td>
		</tr>
        <tr> 
		  	<th>Debit Note Description</th>
		  	<td><cfinput name="dn_desp" type="text" maxlength="30" size="30" value="#dn_desp#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Order Description</th>
		  	<td><cfinput name="po_desp" type="text" maxlength="30" size="30" value="#po_desp#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Requisition Description</th>
		  	<td><cfinput name="rq_desp" type="text" maxlength="30" size="30" value="#rq_desp#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Return Description</th>
		  	<td><cfinput name="pr_desp" type="text" maxlength="30" size="30" value="#pr_desp#"></td>
		</tr>
        <tr> 
		  	<th>Purchase Receive Description</th>
		  	<td><cfinput name="rc_desp" type="text" maxlength="30" size="30" value="#rc_desp#"></td>
		</tr>
        
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Transaction Header</div></th></tr>
        <tr> 
		  	<th>Ref No 2</th>
		  	<td><cfinput name="refno2" type="text" maxlength="30" size="30" value="#refno2#"></td>
		</tr>
        
		<tr> 
		  	<th>Header Remark 0 (R)</th>
		  	<td><input name="rem0" type="text" maxlength="30" size="30" value="Bill To Address Code"readonly></td>
		</tr>
		<tr> 
		  	<th>Header Remark 1 (R)</th>
		  	<td><input name="rem1" type="text" maxlength="30" size="30" value="Del Address Code"readonly></td>
		</tr>
		<tr> 
			<th>Header Remark 2 (R)</th>
		  	<td><input name="rem2" type="text" maxlength="30" size="30" value="Bill Attn"readonly></td>
		</tr>
		<tr> 
		  	<th>Header Remark 3 (R)</th>
		  	<td><input name="rem3" type="text" maxlength="30" size="30" value="Delivery Attn"readonly></td>
		</tr>
		<tr> 
		  	<th>Header Remark 4 (R)</th>
		  	<td><input name="rem4" type="text" maxlength="30" size="30" value="Bill Tel"readonly></td>
		</tr>
		<tr> 
		  	<th>Header Remark 5</th>
		  	<td><cfinput name="rem5" type="text" maxlength="30" size="30" value="#rem5#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 6</th>
		  	<td><cfinput name="rem6" type="text" maxlength="30" size="30" value="#rem6#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 7</th>
		  	<td><cfinput name="rem7" type="text" maxlength="30" size="30" value="#rem7#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 8</th>
		  	<td><cfinput name="rem8" type="text" maxlength="30" size="30" value="#rem8#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 9</th>
		  	<td><cfinput name="rem9" type="text" maxlength="30" size="30" value="#rem9#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 10</th>
		  	<td><cfinput name="rem10" type="text" maxlength="30" size="30" value="#rem10#"></td>
		</tr>
		<tr> 
		  	<th>Header Remark 11</th>
		  	<td><cfinput name="rem11" type="text" maxlength="30" size="30" value="#rem11#"></td>
		</tr>
        
		<tr> 
		  	<th>Header Remark 12 (R)</th>
		  	<td><input name="rem12" type="text" maxlength="30" size="30" value="Delivery Tel" readonly></td>
		</tr>
        <tr> 
		  	<th>Description</th>
		  	<td><cfinput name="ldescription" type="text" maxlength="30" size="30" value="#ldescription#"></td>
		</tr>
        <cfif getGeneralInfo.addonremark eq 'Y'>
        <tr> 
		  	<th>Header Remark 30</th>
		  	<td><cfinput name="rem30" type="text" maxlength="30" size="30" value="#rem30#"></td>
		</tr>
        <tr> 
		  	<th>Header Remark 31</th>
		  	<td><cfinput name="rem31" type="text" maxlength="30" size="30" value="#rem31#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 32</th>
		  	<td><cfinput name="rem32" type="text" maxlength="30" size="30" value="#rem32#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 33</th>
		  	<td><cfinput name="rem33" type="text" maxlength="30" size="30" value="#rem33#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 34</th>
		  	<td><cfinput name="rem34" type="text" maxlength="30" size="30" value="#rem34#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 35</th>
		  	<td><cfinput name="rem35" type="text" maxlength="30" size="30" value="#rem35#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 36</th>
		  	<td><cfinput name="rem36" type="text" maxlength="30" size="30" value="#rem36#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 37</th>
		  	<td><cfinput name="rem37" type="text" maxlength="30" size="30" value="#rem37#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 38</th>
		  	<td><cfinput name="rem38" type="text" maxlength="30" size="30" value="#rem38#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 39</th>
		  	<td><cfinput name="rem39" type="text" maxlength="30" size="30" value="#rem39#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 40</th>
		  	<td><cfinput name="rem40" type="text" maxlength="30" size="30" value="#rem40#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 41</th>
		  	<td><cfinput name="rem41" type="text" maxlength="30" size="30" value="#rem41#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 42</th>
		  	<td><cfinput name="rem42" type="text" maxlength="30" size="30" value="#rem42#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 43</th>
		  	<td><cfinput name="rem43" type="text" maxlength="30" size="30" value="#rem43#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 44</th>
		  	<td><cfinput name="rem44" type="text" maxlength="30" size="30" value="#rem44#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 45</th>
		  	<td><cfinput name="rem45" type="text" maxlength="30" size="30" value="#rem45#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 46</th>
		  	<td><cfinput name="rem46" type="text" maxlength="30" size="30" value="#rem46#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 47</th>
		  	<td><cfinput name="rem47" type="text" maxlength="30" size="30" value="#rem47#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 48</th>
		  	<td><cfinput name="rem48" type="text" maxlength="30" size="30" value="#rem48#"></td>
		</tr>
                <tr> 
		  	<th>Header Remark 49</th>
		  	<td><cfinput name="rem49" type="text" maxlength="30" size="30" value="#rem49#"></td>
		</tr>
           


        
        
        </cfif>
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Transaction Footer</div></th></tr>
        <tr> 
		  	<th>Misc. Charges (1)</th>
		  	<td><cfinput name="misccharge1" type="text" maxlength="30" size="30" value="#misccharge1#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (2)</th>
		  	<td><cfinput name="misccharge2" type="text" maxlength="30" size="30" value="#misccharge2#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (3)</th>
		  	<td><cfinput name="misccharge3" type="text" maxlength="30" size="30" value="#misccharge3#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (4)</th>
		  	<td><cfinput name="misccharge4" type="text" maxlength="30" size="30" value="#misccharge4#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (5)</th>
		  	<td><cfinput name="misccharge5" type="text" maxlength="30" size="30" value="#misccharge5#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (6)</th>
		  	<td><cfinput name="misccharge6" type="text" maxlength="30" size="30" value="#misccharge6#"></td>
		</tr>
        <tr> 
		  	<th>Misc. Charges (7)</th>
		  	<td><cfinput name="misccharge7" type="text" maxlength="30" size="30" value="#misccharge7#"></td>
		</tr>
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Transaction Body</div></th></tr>
		<tr> 
		  	<th>Body Remark 1</th>
		  	<td><cfinput name="brem1" type="text" maxlength="30" size="30" value="#brem1#"></td>
		</tr>
		<tr> 
		  	<th>Body Remark 2</th>
		  	<td><cfinput name="brem2" type="text" maxlength="30" size="30" value="#brem2#"></td>
		</tr>
		<tr> 
		  	<th>Body Remark 3</th>
		  	<td><cfinput name="brem3" type="text" maxlength="30" size="30" value="#brem3#"></td>
		</tr>
		<tr> 
		  	<th>Body Remark 4</th>
		  	<td><cfinput name="brem4" type="text" maxlength="30" size="30" value="#brem4#"></td>
		</tr>
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        
        
        <tr height="20"><th colspan="100%"  style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px"><div align="center">Remark Field List</div></th></tr>
        <cfoutput>
        <tr><th>Remark 5</th><td><input type="text" name="remark5list" id="remark5list" value="#remark5list#" size="30" maxlength="1500"> <br>(80 Words Max Per choice)</td></tr>
        <tr><th>Remark 6</th><td><input type="text" name="remark6list" id="remark6list" value="#remark6list#" size="30" maxlength="1500"> <br>(80 Words Max Per choice)</td></tr>
        <tr><th>Remark 7</th><td><input type="text" name="remark7list" id="remark7list" value="#remark7list#" size="30" maxlength="1500"> <br>(80 Words Max Per choice)</td></tr>
        <tr><th>Remark 8</th><td><input type="text" name="remark8list" id="remark8list" value="#remark8list#" size="30" maxlength="1500"> <br>(80 Words Max Per choice)</td></tr>
        <tr><th>Remark 9</th><td><input type="text" name="remark9list" id="remark9list" value="#remark9list#" size="30" maxlength="1500"> <br>(80 Words Max Per choice)</td></tr>
        <tr><th>Remark 10</th><td><input type="text" name="remark10list" id="remark10list" value="#remark10list#" size="30" maxlength="1500"> <br>(35 Words Max Per choice)</td></tr>
        
        <tr><th>Body Remark 1</th><td><input type="text" name="bodyremark1list" id="bodyremark1list" value="#bodyremark1list#" size="30" maxlength="1500"> <br>(45 Words Max Per choice)</td></tr>
        <tr><th>Body Remark 2</th><td><input type="text" name="bodyremark2list" id="bodyremark2list" value="#bodyremark2list#" size="30" maxlength="1500"> <br>(45 Words Max Per choice)</td></tr>
        <tr><th>Body Remark 3</th><td><input type="text" name="bodyremark3list" id="bodyremark3list" value="#bodyremark3list#" size="30" maxlength="1500"> <br>(45 Words Max Per choice)</td></tr>
        <tr><th>Body Remark 4</th><td><input type="text" name="bodyremark4list" id="bodyremark4list" value="#bodyremark4list#" size="30" maxlength="1500"> <br>(45 Words Max Per choice)</td></tr>
        
        <tr> 
		  	<td colspan="100%">&nbsp;</td>
		</tr>
        <tr height="20"><th colspan="100%"  style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center">Transfer Header</div></th></tr>
        <tr> 
		  	<th>Remark 0</th>
		  	<td><cfinput name="trrem0" type="text" maxlength="30" size="30" value="#trrem0#"></td>
		</tr>
        <tr> 
		  	<th>Remark 1</th>
		  	<td><cfinput name="trrem1" type="text" maxlength="30" size="30" value="#trrem1#"></td>
		</tr>
        <tr> 
		  	<th>Remark 2</th>
		  	<td><cfinput name="trrem2" type="text" maxlength="30" size="30" value="#trrem2#"></td>
		</tr>
        <tr> 
		  	<th>Remark 3</th>
		  	<td><cfinput name="trrem3" type="text" maxlength="30" size="30" value="#trrem3#"></td>
		</tr>
        <tr> 
		  	<th>Remark 4</th>
		  	<td><cfinput name="trrem4" type="text" maxlength="30" size="30" value="#trrem4#"></td>
		</tr>
        <tr> 
		  	<th>Remark 5</th>
		  	<td><cfinput name="trrem5" type="text" maxlength="30" size="30" value="#trrem5#"></td>
		</tr>
        <tr> 
		  	<th>Remark 6</th>
		  	<td><cfinput name="trrem6" type="text" maxlength="30" size="30" value="#trrem6#"></td>
		</tr>
        <tr> 
		  	<th>Remark 7</th>
		  	<td><cfinput name="trrem7" type="text" maxlength="30" size="30" value="#trrem7#"></td>
		</tr>
        <tr> 
		  	<th>Remark 8</th>
		  	<td><cfinput name="trrem8" type="text" maxlength="30" size="30" value="#trrem8#"></td>
		</tr>
        <tr> 
		  	<th>Remark 9</th>
		  	<td><cfinput name="trrem9" type="text" maxlength="30" size="30" value="#trrem9#"></td>
		</tr>
        <tr> 
		  	<th>Remark 10</th>
		  	<td><cfinput name="trrem10" type="text" maxlength="30" size="30" value="#trrem10#"></td>
		</tr>
        <tr> 
		  	<th>Remark 11</th>
		  	<td><cfinput name="trrem11" type="text" maxlength="30" size="30" value="#trrem11#"></td>
		</tr>
		
		</cfoutput>
		
        <tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>

</body>
</html>