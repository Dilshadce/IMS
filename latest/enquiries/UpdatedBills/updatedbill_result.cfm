<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,projectcompany

	from GSetup
</cfquery>
<html>
<head>
<title>UPDATED BILL</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<script language="javascript" type="text/javascript">
function confirmDelete(tran,refno,currentrow,trancode,frtran,frrefno,frtrancode,itemqty){
	if(confirm("Are you sure you want to Delete?")) {
		var id="ditemno_"+tran+"_"+refno+"_"+currentrow+"_"+trancode;
		var itemno=document.getElementById(id).value;
		DWREngine._execute(_tranflocation, null, 'deleteiclink', tran, refno, escape(itemno),trancode,frtran, frrefno,frtrancode,itemqty,currentrow, showResult);
	}
}

function showResult(rowObject){
	//var table = document.getElementById("tbl1");
	var id="row_"+rowObject.TRAN+"_"+rowObject.REFNO+"_"+rowObject.DROW+"_"+rowObject.TRANCODE;
	var row = document.getElementById(id);
	row.parentNode.removeChild(row);
}
</script>
</head>

<cfquery name="getheader" datasource="#dts#">
	select custno,wos_date,type,refno,name from artran where type='#url.frtype#'
	and custno='#form.customerNo#'
	order by refno
</cfquery>

<cfif url.frtype eq "SO" or url.frtype eq "QUO" or url.frtype eq "DO">
	<cfif url.frtype eq "SO">
		<cfset reftype=gettranname.lSO>
	<cfelseif url.frtype eq "QUO">
		<cfset reftype=gettranname.lQUO>
	<cfelseif url.frtype eq "DO">
		<cfset reftype=gettranname.lDO>
	</cfif>
<cfelse>
	<cfif url.frtype eq "PO">
		<cfset reftype=gettranname.lPO>
	</cfif>
</cfif>

<cfif url.totype eq 'PO'>
<cfset reftypeto=gettranname.lPO>
<cfelseif url.totype eq 'INV'>
<cfset reftypeto=gettranname.lINV>
<cfelseif url.totype eq 'CS'>
<cfset reftypeto=gettranname.lCS>
<cfelseif url.totype eq 'RC'>
<cfset reftypeto=gettranname.lRC>
</cfif>

<body>
<h1 align="center"><cfoutput>Updated Bill From #reftype#<cfif url.totype neq ""> To #reftypeto#</cfif></cfoutput></h1>
<table width="80%" border="0" class="data" align="center" cellspacing="0" cellpadding="3" name="tbl1" id="tbl1">
    <cfoutput>
	<tr>
      	<th>Date</th>
		<th>Type</th>
      	<th>Ref No.</th>
		<th>Item No.</th>
		<th><div align="center">Qty Ordered</div></th>
		<th><div align="center">Write Off</div></th>
		<th>#url.totype# Date</th>
      	<th>#url.totype# No</th>
      	<th><div align="center">Qty Updated</div></th>
        <cfif lcase(hcomid) eq "hunting_i">
        <th><div align="center">Balance Qty</div></th>
        </cfif>
		<th><div align="center">Action</div></th>
    </tr>
	</cfoutput>
	<cfoutput query="getheader">
    <cfquery name="getcustname" datasource="#dts#">
    select name from <cfif url.frtype eq 'PO'>#target_apvend#<cfelse>#target_arcust#</cfif> where custno='#getheader.custno#'
</cfquery>
		<tr bgcolor="##9370DB">
          	<td><strong>#dateformat(wos_date,"dd/mm/yyyy")#</strong></td>
			<td nowrap><strong>#type#</strong></td>
          	<td nowrap><strong>#refno#</strong></td>
            <cfif lcase(hcomid) eq "hunting_i">
            <td colspan="8" nowrap><strong>#custno# - <cfif isdefined('form.cbcust')>#getcustname.name#<cfelse>#getheader.name#</cfif></strong></td>
            <cfelse>
          	<td colspan="7" nowrap><strong>#custno# - <cfif isdefined('form.cbcust')>#getcustname.name#<cfelse>#getheader.name#</cfif></strong></td>
            </cfif>
        </tr>
		<cfif gettranname.projectcompany eq 'Y' and url.frtype eq "SO" and url.totype eq 'PO'>
        <cfquery name="getbody" datasource="#dts#">
			select refno,trancode,qty,price,amt,itemno,brem1,brem2,brem4,exported,writeoff 
			from ictranmat
			where type='#url.frtype#' and refno='#getheader.refno#'
			order by trancode
		</cfquery>
        <cfelse>
		<cfquery name="getbody" datasource="#dts#">
			select refno,trancode,qty,price,amt,itemno,brem1,brem2,brem4,exported,writeoff 
			from ictran 
			where type='#url.frtype#' and refno='#getheader.refno#'
			order by trancode
		</cfquery>
        </cfif>
		<cfloop query="getbody">
        	<cfset xitemno=getbody.itemno>
            <cfset orderedqty=val(getbody.qty)>
            
        	<cfquery name="getrcqty" datasource="#dts#">
        		select qty ,refno,type,itemno,trancode,wos_date,frtype,frrefno,frtrancode
                from iclink 
                where frrefno = '#getbody.refno#' 
        		and itemno = '#xitemno#' 
                and frtrancode = '#getbody.trancode#' 
        		<cfif url.totype eq "INV" and url.frtype neq "DO">
                    and type in ('INV','DO')
				<cfelseif url.frtype eq "QUO">
					and type in ('INV','DO','CS','SO')
                <cfelse>
                    and type='#url.totype#'
                </cfif>
        		and frtype ='#url.frtype#' 
                order by refno 
        	</cfquery>
            
            <cfset cnt = 0>
            <cfloop query="getrcqty">
				<input type="hidden" name="ditemno_#getrcqty.type#_#getrcqty.refno#_#getrcqty.currentrow#_#getrcqty.trancode#" id="ditemno_#getrcqty.type#_#getrcqty.refno#_#getrcqty.currentrow#_#getrcqty.trancode#" value="#itemno#">
				<cfquery name="checkexist" datasource="#dts#">
					select * from ictran
					where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrcqty.type#"> and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrcqty.refno#">
					and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrcqty.itemno#">
					and trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getrcqty.trancode#">
				</cfquery>
                <tr id="row_#getrcqty.type#_#getrcqty.refno#_#getrcqty.currentrow#_#getrcqty.trancode#" name="row_#getrcqty.type#_#getrcqty.refno#_#getrcqty.currentrow#_#getrcqty.trancode#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    <td colspan="3"></td>
                    <td nowrap><cfif cnt eq 0>#xitemno#</cfif></td>
                    <td nowrap><cfif cnt eq 0><div align="center">#orderedqty#</div></cfif></td>
                    <td nowrap><cfif cnt eq 0><div align="center">#val(getbody.writeoff)#</div></cfif></td>
                    <td>#dateformat(getrcqty.wos_date,"dd/mm/yyyy")#</td>
                    <td><cfif url.totype eq "">#getrcqty.type# </cfif>#getrcqty.refno#</td>
                    <td><div align="center">#val(getrcqty.qty)#</div></td>
                    <cfif lcase(hcomid) eq "hunting_i">
                    <cfquery datasource="#dts#" name="getitembalance">
                    
                    select 
                    ifnull(b.sumtotalin,0) as qtyin,
                    ifnull(c.sumtotalout,0) as qtyout,
                    ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                    
                    from icitem as a
                    
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalin 
                        from ictran 
                        where type in ('RC','CN','OAI','TRIN') 
                        and itemno='#xitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        group by itemno
                    ) as b on a.itemno=b.itemno
                    
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalout 
                        from ictran 
                        where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                        and itemno='#xitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        and toinv='' 
                        group by itemno
                    ) as c on a.itemno=c.itemno
                    
                    where a.itemno='#xitemno#' 
                    </cfquery>
                    <td><div align="center">#val(getitembalance.balance)#</div><cfif (orderedqty-getrcqty.qty) gt 0><cfif val(getitembalance.balance) gt (orderedqty-getrcqty.qty)><a onClick="window.open('../transaction/transaction.cfm?tran=so');">link to MRN</a></cfif></cfif> </td>
                    </cfif>
					<td><cfif checkexist.recordcount eq 0><div align="center"><input type="button" name="btnDelete" value="Delete" onClick="confirmDelete('#getrcqty.type#','#getrcqty.refno#','#getrcqty.currentrow#','#getrcqty.trancode#','#getrcqty.frtype#','#getrcqty.frrefno#','#getrcqty.frtrancode#','#getrcqty.qty#')"></div></cfif></td>
                </tr>
                <cfset cnt = cnt + 1>
            </cfloop>
		</cfloop>
	</cfoutput>
</table>
</body>
</html>