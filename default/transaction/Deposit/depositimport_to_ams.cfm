<cfquery name="getposting" datasource="#dts#">
SELECT armstatus,armedon,armedby FROM poststatus
</cfquery>
<cfif getposting.armedon eq "" or getposting.armedon eq "0000-00-00">
<cfset diffminutes = 30>
<cfelse>
<cfset diffminutes = datediff('n',getposting.armedon,now())>
</cfif>
<cfif getposting.armstatus eq "Y" and getposting.armedby neq huserid and diffminutes lt 30 >

<cfoutput><script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<h1>Someone else is accessing this page.</h1>
<h2>Username: #getposting.armedby#</h2>
<h2>Access On: #dateformat(getposting.armedon,'YYYY-MM-DD')# #timeformat(getposting.armedon,'HH:MM:SS')# </h2>
<h2>To unarmed it, user may go to GENERAL SETUP > POSTING CONTROL</h2>
</cfoutput>
<cfelse>
<html>
<head>
<title>Importing Batch Of Transactionss</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function validatesubmit()
{
var answer = confirm('Are You Sure Want to Import to Ams?');

if(answer)
{
ColdFusion.Window.show('processing');
updatepercent();
document.getElementById('submit').disabled = true;
return true;
}
else
{
return false;
}
}
function updatepercent()
{
}
</script>

</head>

<cfset dts1 = replace(dts,"_i","_a","all")>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	date_format(lastaccyear,'%d-%m-%Y') as lastaccyear,periodficposting,cost
	from gsetup;
</cfquery>

<cfquery name="getbatch" datasource="#dts1#">
	select 
	recno,desp  
	from glbatch 
	where (lokstatus='1' or lokstatus = '' or lokstatus is null)
	and (delstatus='' or delstatus is null) 
	and (poststatus='' or poststatus is null) 
	and (locktran='' or locktran is null)
    order by recno;
</cfquery>
<cfinclude template="controlposting.cfm">
<body onLoad="loadpost('load');" onUnload="loadpost('unload');">
<!--- <h4> 
	<a href="postingacc.cfm?status=UNPOSTED">View Accounting Post Menu</a>
</h4> --->

<h1 align="center">Deposit Post Menu</h1>

<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Deposittable2.cfm?type=Create">Creating A New Deposit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Deposittable.cfm">List All Deposit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Deposittable.cfm?type=Deposit">Search For Deposit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Deposit.cfm">Deposit Listing</a></cfif>
	<cfif getpin2.h1F10 eq 'T'>
    || <a href="postingdeposit.cfm">Deposit Posting</a>
    || <a href="unpostingdeposit.cfm">Unposting Deposit</a>
	|| <a href="depositimport_to_ams.cfm">Import Posting</a>
 	</cfif>
	</h4>

<h1 align="center">Importing Batch Of Transactions</h1>

<cfif isdefined("form.detectsubmit")>
<cfquery name="updatecolumn" datasource="#dts#">
Update poststatus 
SET
armstatus = "Y",
armedon = now(),
armedby = "#huserid#"
</cfquery>
<script type="text/javascript">
var needToConfirm = true;

function setDirtyFlag()
{
needToConfirm = true; //Call this function if some changes is made to the web page and requires an alert
// Of-course you could call this is Keypress event of a text box or so...
}

function releaseDirtyFlag()
{
needToConfirm = false; //Call this function if dosent requires an alert.
//this could be called when save button is clicked 
}


window.onbeforeunload = confirmExit;
function confirmExit()
{
if (needToConfirm)
return "You have attempted to leave this page. If you do so, data corruption may happen and the data may not be import finish";
}
</script>
	
	<p id="message" style="color:red;"><font size="2">Please wait while the data is processing...</font></p>
	<cfif Hlinkams neq "Y">
		<h3 align="center">AMS No Linked! Please Contact Administrator!</h3>
		<cfabort>
	</cfif>
	
	<script>document.getElementById("message").innerHTML = "Processing...";</script>
	<cfquery name="check_posted_bill" datasource="#dts#">
		select count(reference) as total_posted_bills 
		from glpost91
		<cfif form.transaction_type eq "ALL">
		where acc_code in ('INV','CS','CN','DN','RC','PR')
		<cfelse>
		where acc_code='#form.transaction_type#'
		</cfif>
		and fperiod='#form.period#' 
		group by acc_code;
	</cfquery>
	
	<cfif val(check_posted_bill.total_posted_bills) neq 0 and form.transaction_type neq "RC" and form.transaction_type neq "PR">
    <cfif getgeneral.periodficposting eq "Y" and getgeneral.cost eq "WEIGHT">
    
	<cfquery name="getbilllist" datasource="#dts#">
    select reference,acc_code
		from glpost91
		where acc_code='#form.transaction_type#'
		and fperiod='#form.period#' 
		group by reference
    </cfquery>
    
    <cfquery name="getlist" datasource="#dts#">
    SELECT itemno FROM ictran WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbilllist.reference)#" list="yes" separator=",">) and type = '#form.transaction_type#' group by itemno
    </cfquery>
    
    <cfquery name="getitem" datasource="#dts#">
    SELECT itemno FROM icitem WHERE itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.itemno)#" list="yes" separator=",">) and (stock = "" or stock is null) and itemtype <> "SV" 
    </cfquery>
    
    <cfif getitem.recordcount neq 0>
    <cfoutput>
    <h3>Import Fail! Below item didn't have stock code</h3>
    <cfloop query="getitem">
    #getitem.itemno#<br/>
    </cfloop>
    </cfoutput>
	<cfabort>
	</cfif>
    
    <cfquery name="generatestock" datasource="#dts#">
    SELECT itemno,qty,wos_date,refno,type,source,job,agenno,fperiod,refno2,name,it_cos,trancode,trdatetime,stkcost FROM ictran WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbilllist.reference)#" list="yes" separator=",">) and type = '#form.transaction_type#' order by refno
    </cfquery>
    
    <cfloop query="generatestock">
    <cfif val(generatestock.qty) neq 0>
    <cfif val(generatestock.stkcost) neq 0>
    
    <cfquery name="getmomentstockval" datasource="#dts#">
    select stock,purc from icitem where itemno='#generatestock.itemno#'
    </cfquery>
    
    <cfif form.transaction_type eq "CN">
    <cfset debitfield = getmomentstockval.stock>
    <cfset creditfield = getmomentstockval.purc>
    <cfset currentunitstock = abs(numberformat(generatestock.it_cos,'.__'))>
    <cfelse>
    <cfset debitfield = getmomentstockval.stock>
    <cfset creditfield = getmomentstockval.purc>
    <cfset currentunitstock = abs(numberformat(generatestock.stkcost,'.__'))>
    </cfif>
    
    <cfquery name="insertpostdebit" datasource="#dts#">
     insert into glpost91
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						,SOURCE,JOB,agent,despa
                    )
                    values 
                    (
                        '#form.transaction_type#',
						'#debitfield#',
						'#generatestock.fperiod#',
						'#dateformat(generatestock.wos_date,'YYYY-MM-DD')#',
						'#generatestock.refno#',
                        '#generatestock.refno2#',
                        '#generatestock.name#',
                        '#numberformat(val(currentunitstock),".__")#',
                        '0',
                        '1',
                        '',
                        '0',
                        '#dateformat(generatestock.wos_date,'YYYY-MM-DD')#','#HUserID#','0'
						,'#generatestock.source#','#generatestock.job#'
                        ,'#generatestock.agenno#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#@#generatestock.trancode#">
                    )
			</cfquery>
            
            <cfquery name="insertpostdebit" datasource="#dts#">
     insert into glpost91
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						,SOURCE,JOB,agent,despa
                    )
                    values 
                    (
                        '#form.transaction_type#',
						'#creditfield#',
						'#generatestock.fperiod#',
						'#dateformat(generatestock.wos_date,'YYYY-MM-DD')#',
						'#generatestock.refno#',
                        '#generatestock.refno2#',
                        '#generatestock.name#',
                        '#numberformat(val(currentunitstock),".__")#',
                        '0',
                        '1',
                        '',
                        '0',
                        '#dateformat(generatestock.wos_date,'YYYY-MM-DD')#','#HUserID#','0'
						,'#generatestock.source#','#generatestock.job#'
                        ,'#generatestock.agenno#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#@#generatestock.trancode#">
                    )
			</cfquery>
    
    <cfelse>
    
    <cfquery name="getmomentstockval" datasource="#dts#">
    SELECT coalesce(a.qtybf,0)+coalesce(c.totalqty,0)-coalesce(b.totalreturnqty,0) as qty, coalesce(a.qtybf * a.ucost,0)+coalesce(c.totalamt,0)-coalesce(b.totalreturnamt,0) as amt,a.purc,a.stock,a.itemtype,d.outqty from (
    SELECT qtybf,ucost,itemno,purc,stock,itemtype FROM icitem  WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 	
    ) as a
    LEFT JOIN
    (
	select sum(qty) as totalreturnqty, sum(amt) as totalreturnamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and type = "PR"
    and wos_date <= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#"
    <!--- and time(trdatetime) <= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    ) as b
    on a.itemno = b.itemno
    LEFT JOIN
    (
    select sum(qty) as totalqty, sum(if(type = "CN",it_cos,amt)) as totalamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "RC" or type = "OAI" or type = "CN")
    <cfif generatestock.type eq "CN">
    and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.refno#"> and type <> "#generatestock.type#"
    </cfif>
    and wos_date <= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#"
    <!--- and trdatetime <= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    )
    as c
    on a.itemno = c.itemno    
    LEFT JOIN
    (
    select sum(qty) as outqty, itemno  FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "INV" or type = "ISS" or type = "DN" or type = "CS" or type = "DO" or type = "OAR")
   and wos_date <= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" 
    <!---  and trdatetime <= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#"--->
    group by itemno
    )
    as d
    on a.itemno = d.itemno
    </cfquery>
    <cfif getmomentstockval.itemtype neq "SV">
    <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
    
    <cfquery name="getnextstockin" datasource="#dts#">
    SELECT wos_date,trdatetime FROM ictran WHERE 
    (type = "RC" or type = "CN" or type = "OAI")
    and wos_date > "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#"
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    order by wos_date
    </cfquery>
    <cfif getnextstockin.recordcount neq 0>
    <cfquery name="getmomentstockval" datasource="#dts#">
    SELECT coalesce(a.qtybf,0)+coalesce(c.totalqty,0)-coalesce(b.totalreturnqty,0) as qty, coalesce(a.qtybf * a.ucost,0)+coalesce(c.totalamt,0)-coalesce(b.totalreturnamt,0) as amt,a.purc,a.stock,a.itemtype,'#val(getmomentstockval.outqty)#' as outqty from (
    SELECT <!--- <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif> --->qtybf,<!--- <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif> --->ucost,itemno,purc,stock,itemtype FROM icitem  WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 	
    ) as a
    LEFT JOIN
    (
	select sum(qty) as totalreturnqty, sum(amt) as totalreturnamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and type = "PR"
    <!--- <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
    <!--- and wos_date >= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" --->
    and trdatetime >= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#"
	</cfif> --->
    and wos_date <= "#dateformat(getnextstockin.wos_date,'YYYY-MM-DD')#"
    <!--- and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    ) as b
    on a.itemno = b.itemno
    LEFT JOIN
    (
    select sum(qty) as totalqty, sum(if(type = "CN",it_cos,amt)) as totalamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "RC" or type = "OAI" or type = "CN")
    <cfif generatestock.type eq "CN">
    and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.refno#"> and type <> "#generatestock.type#"
    </cfif>
     <!--- <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
   <!---  and wos_date >= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" --->
   and trdatetime >= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#"
	</cfif> --->
    and wos_date <= "#dateformat(getnextstockin.wos_date,'YYYY-MM-DD')#"
    <!--- and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    )
    as c
    on a.itemno = c.itemno
    </cfquery>
    </cfif>
    </cfif>
    
    <cfif val(getmomentstockval.qty) lte val(getmomentstockval.outqty)>
    
    <cfquery name="getnextstockin" datasource="#dts#">
    SELECT wos_date,trdatetime FROM ictran WHERE 
    (type = "RC" or type = "CN" or type = "OAI")
    and wos_date > "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" 
    <!--- and  trdatetime > "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#" --->
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    order by wos_date
    </cfquery>
    
    <cfif getnextstockin.recordcount neq 0>
    <cfquery name="getmomentstockval" datasource="#dts#">
    SELECT coalesce(a.qtybf,0)+coalesce(c.totalqty,0)-coalesce(b.totalreturnqty,0) as qty, coalesce(a.qtybf * a.ucost,0)+coalesce(c.totalamt,0)-coalesce(b.totalreturnamt,0) as amt,a.purc,a.stock,a.itemtype from (
    SELECT <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif>qtybf,<cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif>ucost,itemno,purc,stock,itemtype FROM icitem  WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 	
    ) as a
    LEFT JOIN
    (
	select sum(qty) as totalreturnqty, sum(amt) as totalreturnamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and type = "PR"
    <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
   and wos_date >= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" 
     <!--- and trdatetime >= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#"--->
	</cfif>
    and wos_date <= "#dateformat(getnextstockin.wos_date,'YYYY-MM-DD')#"
    <!--- and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    ) as b
    on a.itemno = b.itemno
    LEFT JOIN
    (
    select sum(qty) as totalqty, sum(if(type = "CN",it_cos,amt)) as totalamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "RC" or type = "OAI" or type = "CN")
    <cfif generatestock.type eq "CN">
    and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.refno#"> and type <> "#generatestock.type#"
    </cfif>
     <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
   and wos_date >= "#dateformat(generatestock.wos_date,'YYYY-MM-DD')#" 
   <!---  and trdatetime >= "#dateformat(generatestock.trdatetime,'YYYY-MM-DD')# #timeformat(generatestock.trdatetime,'HH:MM:SS')#"--->
	</cfif>
    and wos_date <= "#dateformat(getnextstockin.wos_date,'YYYY-MM-DD')#"
    <!--- and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#" --->
    group by itemno
    )
    as c
    on a.itemno = c.itemno
    </cfquery>
    </cfif>
    </cfif>
    
    <cfif val(getmomentstockval.qty) eq 0 and generatestock.type eq "CN">
    <cfset getmomentstockval.qty = 1>
    </cfif>
    
    <cfif val(getmomentstockval.qty) eq 0>
    <cfoutput>
    <h3>Negative Stock Found!</h3>
    #generatestock.type# - #generatestock.refno# - #generatestock.itemno# <br/>
    </cfoutput>

    <cfabort>

	</cfif>
    <cfif val(getmomentstockval.qty) neq 0>
    <cfset currentunitstock = val(getmomentstockval.amt)/val(getmomentstockval.qty) * abs(val(generatestock.qty))>
    
    <cfif form.transaction_type eq "CN">
    <cfset debitfield = getmomentstockval.stock>
    <cfset creditfield = getmomentstockval.purc>
    <cfset currentunitstock = abs(numberformat(generatestock.it_cos,'.__'))>
	<cfelse>
    <cfset debitfield = getmomentstockval.purc>
    <cfset creditfield = getmomentstockval.stock>
	</cfif>
    
    <cfif val(generatestock.qty) lt 0>
    <cfset olddebitfield = debitfield>
    <cfset oldcreditfield = creditfield>
    <cfset debitfield = oldcreditfield>
    <cfset creditfield = olddebitfield>
	</cfif>
    
    <cfquery name="insertpostdebit" datasource="#dts#">
     insert into glpost91
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						,SOURCE,JOB,agent,despa
                    )
                    values 
                    (
                        '#form.transaction_type#',
						'#debitfield#',
						'#generatestock.fperiod#',
						'#dateformat(generatestock.wos_date,'YYYY-MM-DD')#',
						'#generatestock.refno#',
                        '#generatestock.refno2#',
                        '#generatestock.name#',
                        '#numberformat(val(currentunitstock),".__")#',
                        '0',
                        '1',
                        '',
                        '0',
                        '#dateformat(generatestock.wos_date,'YYYY-MM-DD')#','#HUserID#','0'
						,'#generatestock.source#','#generatestock.job#'
                        ,'#generatestock.agenno#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#@#generatestock.trancode#">
                    )
			</cfquery>
            
            <cfquery name="insertpostdebit" datasource="#dts#">
     insert into glpost91
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
                        bdate,userid,TAXPEC
						,SOURCE,JOB,agent,despa
                    )
                    values 
                    (
                        '#form.transaction_type#',
						'#creditfield#',
						'#generatestock.fperiod#',
						'#dateformat(generatestock.wos_date,'YYYY-MM-DD')#',
						'#generatestock.refno#',
                        '#generatestock.refno2#',
                        '#generatestock.name#',
                        '#numberformat(val(currentunitstock),".__")#',
                        '0',
                        '1',
                        '',
                        '0',
                        '#dateformat(generatestock.wos_date,'YYYY-MM-DD')#','#HUserID#','0'
						,'#generatestock.source#','#generatestock.job#'
                        ,'#generatestock.agenno#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#generatestock.itemno#@#generatestock.trancode#">
                    )
			</cfquery>
            </cfif>
            </cfif>
    </cfif>
    
    </cfif>
    
    </cfloop>
	</cfif>
	</cfif>
<!---     <cfif getauthuser() eq "ultracai">
     <cfabort>
	 </cfif> --->
   
	<cfquery name="insertlog" datasource="#dts#">
    INSERT INTO postlog (action,billtype,actiondata,user,timeaccess)
    VALUES
    ("Import","#form.transaction_type#","period-#form.period#  batch-#form.batch_no#","#huserid#",now())
    </cfquery>
    
    
    
    
	<cfif val(check_posted_bill.total_posted_bills) neq 0>
    <cftry>
		<cfinvoke component="cfc.post_to_ams2" method="update_glpost91">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="dts1" value="#dts1#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
			<cfinvokeargument name="target_apvend" value="#target_apvend#">
			<cfinvokeargument name="userid" value="#HUserID#">
			<cfinvokeargument name="form" value="#form#">
		</cfinvoke>
		
		<cfinvoke component="cfc.post_to_ams2" method="posting_to_ams_method">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="dts1" value="#dts1#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
			<cfinvokeargument name="target_apvend" value="#target_apvend#">
			<cfinvokeargument name="form" value="#form#">
		</cfinvoke>
		
		<cfinvoke component="cfc.post_to_ams2" method="iras_posting">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="dts1" value="#dts1#">
			<cfinvokeargument name="form" value="#form#">
		</cfinvoke>
		
		<cfinvoke component="cfc.post_to_ams2" method="delete_posted_glpost91">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="dts1" value="#dts1#">
			<cfinvokeargument name="form" value="#form#">
		</cfinvoke>
         <script language="javascript" type="text/javascript">
			alert("Import to AMS Success!");
		</script>
     <cfcatch type="any" >
     <script language="javascript" type="text/javascript">
			alert("Import to AMS Failed");
		</script>
     </cfcatch>
     </cftry>
	<cfelse>
		
		<h3 align="center">No Posted Bills Inported !</h3>
		<script language="javascript" type="text/javascript">
			alert("No Posted Bills Imported !");
		</script>
	</cfif>
	<script>document.getElementById("message").innerHTML = "";</script>
</cfif>

<cfform name="import_to_ams" action="depositimport_to_ams.cfm" method="post" onsubmit="return validatesubmit()">
	<table class="data" align="center" width="50%">
		<tr>
			<th>Bill Type To Import</th>
			<td>
				<input name="transaction_type" id="transaction_type" type="radio" value="DEP" checked> Deposit<br/>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<th>Period To Import</th>
			<td>
				<cfoutput>
					<select name="period" id="period"  onChange="ajaxFunction(document.getElementById('batchajaxfield'),'importams_batch_Ajax.cfm?fperiod='+document.getElementById('period').value);">
						<option value="1"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="2"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="3"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="4"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="5"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="6"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="7"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="8"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="9"  #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
						<option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					</select>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<th>Date From</th>
			<td><cfinput name="date_from" type="text" size="10" validate="eurodate" mask="99-99-9999"></td>
		</tr>
		<tr>
			<th>Date To</th>
			<td><cfinput name="date_to" type="text" size="10" validate="eurodate" mask="99-99-9999"></td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
		<tr>
			<th>Import To Batch No.</th>
			<td>
            <div id="batchajaxfield">
				<select name="batch_no" id="batch_no">
					<cfoutput query="getbatch">
						<option value="#getbatch.recno#">#getbatch.recno# - #getbatch.desp#</option>
					</cfoutput>
				</select>
            </div>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr></td>
		</tr>
	</table>
	<table class="data" align="center" width="50%">
		<tr align="center">
			<td>
            <input type="hidden" name="detectsubmit" value="1">
				<input name="Submit" id="submit" type="submit" value="Import">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="Reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>

<iframe src="depositimport_to_ams_preview.cfm" align="middle" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
</body>
</html>

<script type="text/javascript">

ajaxFunction(document.getElementById('batchajaxfield'),'importams_batch_Ajax.cfm?fperiod='+document.getElementById('period').value);


try{
releaseDirtyFlag()
}
catch(any)
{
}
window.onbeforeunload = releasearm;
function releasearm()
{
loadpost('unload');
}
</script>
</cfif>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Importing....Please Wait" modal="true" resizable="false" >
<h1>Importing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
<div id="ajaxcontrol"></div>
</cfwindow>