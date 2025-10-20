<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">

<script src="/scripts/CalendarControl.js" language="javascript"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<cfset uuid = createuuid()>
<script language="javascript" type="text/javascript">
	function getSupp(type,option){
		var inputtext = document.updatepage.searchsupp.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
	}

	function getSuppResult(suppArray){
		DWRUtil.removeAllOptions("supplier");
		DWRUtil.addOptions("supplier", suppArray,"KEY", "VALUE");
	}
	
	function AssignGrade(itemno,frrefno,frtype,totype,frtrancode){
		var opt = 'Width=800px, Height=600px, scrollbars=yes, status=no';
		//window.showModalDialog('dsp_gradeitem.cfm?itemno=' + escape(itemno), '',opt);
		window.open('dsp_updategradeitem.cfm?itemno=' + escape(itemno) + '&frtype=' + frtype + '&frrefno=' + frrefno + '&frtrancode=' + frtrancode + '&totype=' + totype, '',opt);
		
	}
	
</script>

<script language="javascript" type="text/javascript">

	function calculatefufill(type,refno,totalqty)
	{
		var a=0;
		for(i=1;i<=totalqty;i++)
		{
			a=a+(document.getElementById('fulfill_'+type+'_'+refno+'_'+i).value*1+; 
		}
		document.getElementById('totalfulfill').value=a; 
	}

	function multiLocation(itemno,tran,refno,trancode,qty){
		var opt = 'Width=600px, Height=400px, Top=200px, left=300px, scrollbars=yes, status=no';
		<cfoutput>
			window.open('dsp_multilocation.cfm?itemno=' + escape(itemno) + '&type=' + tran + '&refno=' + refno + '&trancode=' + trancode 
			+ '&qty=' + qty + '&uuid=#uuid#', '',opt);
		</cfoutput>
	}


	function updatePrice(updateto,qtyfrom,priceto)
	{
	var qtyval = document.getElementById(qtyfrom).value;
	var priceval = document.getElementById(priceto).value;
	var totalval = document.getElementById(updateto).value;
	qtyval = qtyval * 1;
	priceval = priceval * 1;
    totalval = qtyval * priceval;
    document.getElementById(updateto).value = totalval.toFixed(2);
	}
	
	function checksupplier()
	{
		if(document.updatepage.supplier.value!="")
			{
				return true;
			}
		else
			{
				alert("Please Select A Supplier !");
				return false;
			}
	}
	
	function checkcustomer()
	{
		if(document.updatepage.customer.value!="")
			{
				return true;
			}
		else
			{
				alert("Please Select A Customer !");
				return false;
			}
	}
	
	
	
	
	
</script>
</head>

<cfquery name="getgsetup2" datasource='#dts#'>
  	Select * from gsetup2
</cfquery>
<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>
<cfquery name="checklocation" datasource='#dts#'>
  	Select chooselocation from gsetup
</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>
<cfif checklocation.chooselocation eq "Y">

<cfquery name="insert_new_location_item" datasource="#dts#">
	insert ignore into locqdbf 
	(
		itemno,
		location
	)
	(
		select 
		itemno,
		location 
		from ictran 
		where location<>''
		and (linecode <> 'SV' or linecode is null)
		group by location,itemno
		order by location,itemno
	)
</cfquery>


<cfquery name="check_compulsory_location_setting" datasource="#dts#">
	select 
	compulsory_location
	from transaction_menu;
</cfquery>
<cfset needlocation = "No">
<cfif check_compulsory_location_setting.compulsory_location eq "Y">
<cfset needlocation = "yes">
</cfif>

<cfquery name="getlocation" datasource="#dts#">
SELECT "emptylocation" as location, "Choose a Location" as desp 
union all
SELECT location,concat(location,' - ',desp) as desp FROM iclocation
where (noactivelocation='' or noactivelocation is null)
</cfquery>
<script type="text/javascript">
function showlocbal(itemno)
{
document.getElementById('locitemno').value = encodeURI(itemno);
ColdFusion.Window.show('showlocbal');
}



</script>

<input type="hidden" name="locitemno" id="locitemno" value="">
<cfwindow name="showlocbal" initshow="false" center="true" width="300" height="300" source="locitembal.cfm?itemno={locitemno}" modal="true" closable="true" title="Location Balance" refreshonshow="true" />
</cfif>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<cfset getitemqtyonhand.balance=0>

<cfif url.t2 eq "INV">		
	<h1>Update to <cfoutput>#gettranname.lINV#</cfoutput></h1>
	
	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>
	
	<cfif isdefined("form.invset")>
		<cfset trancode = form.invset>
		
		<cfif form.invset eq "invno">
			<cfset tranarun = "invarun">
		<cfelseif form.invset eq "invno_2">
			<cfset tranarun = "invarun_2">
		<cfelseif form.invset eq "invno_3">
			<cfset tranarun = "invarun_3">
		<cfelseif form.invset eq "invno_4">
			<cfset tranarun = "invarun_4">
		<cfelseif form.invset eq "invno_5">
			<cfset tranarun = "invarun_5">
		<cfelseif form.invset eq "invno_6">
			<cfset tranarun = "invarun_6">
		</cfif>
	<cfelse>
		<cfset trancode = "invno">
		<cfset tranarun = "invarun">
	</cfif>
		
<cfelseif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>
	
	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
    <cfelseif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>
	
	<cfset trancode = "dono">
	<cfset tranarun = "doarun">

<cfelseif url.t2 eq "RC">
	<h1>Update to <cfoutput>#gettranname.lRC#</cfoutput></h1>
	
	<cfif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>
	
	<cfset trancode = "rcno">
	<cfset tranarun = "rcarun">
    
<cfelseif url.t2 eq "RQ">
	<h1>Update to <cfoutput>#gettranname.lRQ#</cfoutput></h1>
	
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>
	
	<cfset trancode = "rqno">
	<cfset tranarun = "rqarun">

<cfelseif url.t2 eq "PO">
	<h1>Update to <cfoutput>#gettranname.lPO#</cfoutput></h1>
	
	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
    <cfelseif url.t1 eq "RQ">
		<cfset type = gettranname.lRQ>
	</cfif>
	
	<cfset trancode = "pono">
	<cfset tranarun = "poarun">

<cfelseif url.t2 eq "SO">
	<h1>Update to <cfoutput>#gettranname.lSO#</cfoutput></h1>
	
	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
	
    <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
	</cfif>
    
	<cfset trancode = "sono">
	<cfset tranarun = "soarun">	

<cfelseif url.t2 eq "CS">
	<h1>Update to <cfoutput>#gettranname.lCS#</cfoutput></h1>
	
	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>
    
    <cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	
	<cfset trancode = "csno">
	<cfset tranarun = "csarun">	
<cfelseif url.t2 eq "QUO">
<h1>Update to <cfoutput>#gettranname.lQUO#</cfoutput></h1>

	<cfif url.t1 eq "SAMM">
		<cfset type = "Sales Order">
	</cfif>

	<cfset trancode = "quono">
	<cfset tranarun = "quoarun">
</cfif>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where type = '#url.t2#'
	and counter = '#invset#'
</cfquery>

<cfif lcase(hcomid) eq "steel_i">
	<script type='text/javascript' src='../../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../../ajax/core/settings.js'></script>
	
	<script type='text/javascript' language="javascript">
	var glo_id="";
	
	var s1="";
	var s2="";
	var running="0";
	var first="1";
	//Ajax
	function getItem(id){
		glo_id=id;
		getItem0("0");
	}
	
	function getItem0(process) {
		if(running=="0" || process=="1")
		{
			s1=document.getElementById("letter"+glo_id).value;
			running="1";
			
			if (first=="1"){
				first="2";
				running="0";
				getItem2(glo_id);
			}
			else if(first=="2" && s2!="" && (s1==s2)){
				running="0";
				getItem2(glo_id);
			}
			else {
				s2=document.getElementById("letter"+glo_id).value;
				setTimeout('getItem0("1")', 1000);
				running="1";
			}
		}
	}
	
	function getItem2(id)
	{
		var letter = DWRUtil.getValue("letter"+id);
		var searchtype = DWRUtil.getValue("searchtype"+id);
		glo_id=id;
		if(letter=="#"){
			letter="##";
		}
		DWREngine._execute(_tranflocation, null, 'itemlookup', letter, searchtype, getItemResult);
	}
	
	function getItemResult(itemArray)
	{
		DWRUtil.removeAllOptions("itemno"+glo_id);
		DWRUtil.addOptions("itemno"+glo_id, itemArray,"KEY", "VALUE");
	}
	
	function resetLetter(id){
		document.getElementById(id.replace("searchtype","letter")).value="";
		getItem2(id.substring(10));
	}
	
	function init()
	{
		DWRUtil.useLoadingMessage();
		DWREngine._errorHandler =  errorHandler;
	}
	
	</script>
	<body onLoad="init()">
<cfelse>
	<body>
</cfif>

<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
                    <th>Qty on Hand</th>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>
                    <cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>
					<th>Qty To Fulfill</th> 
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>Price (FC)</th> 
					<th>Price</th>					
        			<th>User</th>
				</tr>
			</cfoutput> 
			
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
                
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			      	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			      	<cfset xParam2 = ''>
			    <cfelse>
			      	<cfset xParam2 = listgetat(mylist,i+1,";")>
			    </cfif>
				
				<cfset xParam3 = listgetat(mylist,i+2,";")>
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' 
					and type = '#t1#' and (shipped+writeoff) < qty 
				</cfquery> 
				
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#'
           		 		and frtype = '#t1#' and (type = 'INV' or type = 'DO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#' <!--- desp = '#getupdate.desp#' ---> <!--- and toinv = "" and custno = '#getupdate.custno#' --->
            		</cfquery>
            		
					<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>

					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil - val(getupdate.writeoff)>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
                    
                    <cfif getupdate.location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance,a.itemtype
                            
                            from icitem as a 
                            
                            left join 
                            (
                                select 
                                location,
                                itemno,
                                (select desp from iclocation where location=locqdbf.location) as locationdesp 
                                from locqdbf
                                where itemno=itemno 
                                and itemno='#itemno#' 
                                and location = '#getupdate.location#'
                            ) as b on a.itemno=b.itemno 
                            
                            left join 
                            (
                                select 
                                a.location,
                                a.itemno,
                                (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
                                
                                from locqdbf as a 
                                
                                left join
                                (
                                    select 
                                    location,
                                    itemno,
                                    sum(qty) as sum_in 
                                    
                                    from ictran
                                    
                                    where type in ('RC','CN','OAI','TRIN') 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getupdate.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                        
                                    group by location,itemno
                                    order by location,itemno
                                ) as b on a.location=b.location and a.itemno=b.itemno
                                
                                left join
                                (
                                    select 
                                    location,
                                    category,
                                    wos_group,
                                    itemno,
                                    sum(qty) as sum_out 
                                    
                                    from ictran 
                                    
                                    where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                                    and (toinv='' or toinv is null) 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getupdate.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                                    group by location,itemno
                                    order by location,itemno
                                ) as c on a.location=c.location and a.itemno=c.itemno 
                                
                                where a.itemno=a.itemno
                                and a.itemno='#itemno#' 
                               and a.location = '#getupdate.location#'
                                
                            ) as c on a.itemno=c.itemno and b.location=c.location 
                            
                            where a.itemno=a.itemno 
                            and b.location<>''
                        	and b.location = '#getupdate.location#'
                            and a.itemno='#itemno#' 
                            order by a.itemno;
                            </cfquery>
                            <cfelse>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,a.itemtype
                            from icitem as a
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalin 
                                from ictran 
                                where type in ('RC','CN','OAI','TRIN') 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                group by itemno
                            ) as b on a.itemno=b.itemno
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalout 
                                from ictran 
                                where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                and toinv='' 
                                group by itemno
                            ) as c on a.itemno=c.itemno
                            
                            where a.itemno='#itemno#' 
                            </cfquery>
                            </cfif>
                            <cfif getitemqtyonhand.recordcount eq 0>
                            <cfset getitemqtyonhand.balance=0>
                            </cfif>
                    
                    		<cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
					<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';"
                    <cfif (getitemqtyonhand.balance lt qtytoful) and getGsetup.negstk neq '1' and getupdate.linecode neq 'SV'>
                    style="background:##FF0000"
                    onMouseOut="javascript:this.style.backgroundColor='##FF0000';"
                    <cfelse>
                    onMouseOut="javascript:this.style.backgroundColor='';"
                    </cfif>
                    > 					 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
                        
                        
                            
                            <!--- --->
                            <td><div align="center">
                            <cfif getupdate.linecode eq 'SV'><input type="hidden" name="balanceqty" id="balanceqty_#t1#_#refno#_#trancode#" value="SV" size="6"><cfelse><input type="hidden" name="balanceqty" id="balanceqty_#t1#_#refno#_#trancode#" value="#val(getitemqtyonhand.balance)#" size="6"></cfif><cfif getupdate.linecode eq 'SV'>SV<cfelse>#val(getitemqtyonhand.balance)#</cfif></div></td>
						<td><div align="center">#QTY_bil#</div></td>	
                        			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
							<cfset qtytoful = 0>
						<cfelse>
							<cfset qtytoful = qtytoful>
						</cfif>
						<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            			<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
						<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
						<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <cfselect name="location" id="location_#t1#_#refno#_#trancode#" query="getlocation" value="location" display="desp" selected="#getupdate.location#" required="#needlocation#" />
                        </td>
                        </cfif>
						<td>
							<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
							<cfif getigrade.recordcount neq 0>
								<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
							</cfif>
						</td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
		  		<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
		  	</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>             
					<td colspan="5"><div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th> 
                     <cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>         
					<th>Qty To Fulfill</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
					<th>User</th>
				</tr>
			</cfoutput> 
				
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and itemno = '#listgetat(mylist,i +1,";")#' 
					and trancode = '#listgetat(mylist,i +2,";")#' and type = '#t1#' and shipped < qty
				</cfquery> 
					 
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'SO' or type = 'CS' or type = 'DO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                        			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
							<cfset qtytoful = 0>
						<cfelse>
							<cfset qtytoful = qtytoful>
						</cfif>
						<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            			<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
						<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
						<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <cfselect name="location" id="location_#t1#_#refno#_#trancode#" query="getlocation" value="location" display="desp" selected="#getupdate.location#" required="#needlocation#" />
                        </td>
</cfif>
						<td>
							<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
							<cfif getigrade.recordcount neq 0>
								<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
							</cfif>
						</td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
			</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>
					<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
	<!--- From PO To INV: t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checkcustomer(true);">
        <cfset session.formName="updatepage">
			<cfoutput>
			
			<cfquery name="getcust" datasource="#dts#">
				select custno,name,term from #target_arcust# where (status<>'B' or status is null) order by custno
			</cfquery>
			
			<select name="customer">
				<option value="" selected>Select a Customer</option>
				<cfloop query="getcust">
					<option value="#getcust.custno#">#getcust.custno# - #getcust.name# - #getcust.term#</option>
				</cfloop>
			</select>
			
			<input type="hidden" name="checkbox" value="#form.checkbox#">
        	
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>	
				
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>  
                     <cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>        
					<th>Qty To Fulfill</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>Price</th>					
        			<th>User</th>
				</tr>
			</cfoutput> 
			
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
				
                <cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			      	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			      	<cfset xParam2 = ''>
			    <cfelse>
			      	<cfset xParam2 = listgetat(mylist,i+1,";")>
			    </cfif>
				
				<cfset xParam3 = listgetat(mylist,i+2,";")>

				<cfquery datasource="#dts#" name="getupdate">
					Select a.*,b.price as xprice from ictran a 
                    left join (select price,itemno from icitem)as b on a.itemno=b.itemno 
					where 1=1
					and a.refno = '#listgetat(mylist,i,";")#' and a.type = '#t1#' 
					and a.exported = '' and a.toinv = ''<!---  and (a.linecode <> 'SV' or a.linecode is null)   --->
					and a.itemno = '#xParam2#'
				</cfquery> 
				
				<cfoutput query="getupdate"> 				
					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           		 		and frtype = '#t1#' and type = '#t2#' and frtrancode = '#getupdate.trancode#'
						and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getupdate.itemno#">
            		</cfquery>
					
            		<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>
				
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
				
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                        			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#' and trancode = '#getupdate.trancode#'
                        	and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getupdate.itemno#">
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <cfselect name="location" id="location_#t1#_#refno#_#trancode#" query="getlocation" value="location" display="desp" selected="#getupdate.location#" required="#needlocation#" />
                        </td>
</cfif>
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td>#numberformat(xprice,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#' and type = '#t1#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
		  		<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>             
          			<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<!--- Coding here is for update to DO --->
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO" or url.t1 eq "QUO" or url.t1 eq "SAM">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
				<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
				<p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p>
			</cfoutput>
			
			<!--- OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS --->
	
				<table class="data" align="center">
				<tr> 
					<th><cfoutput>#type#</cfoutput></th>
					<th>Date</th>
					<th>Customer No</th>
                    <th>Customer Name</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th><cfoutput>#getgsetup.laitemno#</cfoutput></th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
                    <th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>
                    <th>Qty on Hand</th>
                    <cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>          
					<th>Qty To Fulfill</th> 
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
						<th>&nbsp;</th> 
						<th>&nbsp;</th>
					<cfelse>
                    
						<th>Price (FC)</th> 
						<th>Price</th>
					</cfif>
					<th>User</th>
				</tr>
	
				<cfloop from="1" to="#cnt#" index="i" step="+3">
					<cfset xParam1 = listgetat(mylist,i,";")>
					
					<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
						<cfset xParam2 = ''>
					<cfelse>
						<cfset xParam2 = listgetat(mylist,i+1,";")>
					</cfif>
					
					<cfset xParam3 = listgetat(mylist,i+2,";")>
	
					<!--- <cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and shipped < qty 
					</cfquery> --->
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
						and trancode = '#xParam3#' and type = '#t1#' and (shipped+writeoff) < qty 
					</cfquery> 
					 
					<cfoutput query="getupdate">				
						<cfquery datasource="#dts#" name="getupqty">
							select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
							and frtype = '#t1#' and (type = 'INV' or type = 'DO' or type = 'CS' or type = 'SO') and itemno = '#getupdate.itemno#' 
							and frtrancode = '#getupdate.trancode#'
						</cfquery>
						
						<cfif getupqty.sumqty neq "">
							<cfset upqty = getupqty.sumqty>
						<cfelse>
							<cfset upqty = 0>
						</cfif>
					
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty_bil - val(getupdate.writeoff)>
						<cfelse>
							<cfset order = 0>
						</cfif>
					
						<cfset qtytoful = order - upqty>
                        
                        <cfif getupdate.linecode eq "SV">
                        <cfelse>
                        <!---get qty on hand --->
                            <cfif getupdate.location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance,a.itemtype
                            
                            from icitem as a 
                            
                            left join 
                            (
                                select 
                                location,
                                itemno,
                                (select desp from iclocation where location=locqdbf.location) as locationdesp 
                                from locqdbf
                                where itemno=itemno 
                                and itemno='#itemno#' 
                                and location = '#getupdate.location#'
                            ) as b on a.itemno=b.itemno 
                            
                            left join 
                            (
                                select 
                                a.location,
                                a.itemno,
                                (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
                                
                                from locqdbf as a 
                                
                                left join
                                (
                                    select 
                                    location,
                                    itemno,
                                    sum(qty) as sum_in 
                                    
                                    from ictran
                                    
                                    where type in ('RC','CN','OAI','TRIN') 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getupdate.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                        
                                    group by location,itemno
                                    order by location,itemno
                                ) as b on a.location=b.location and a.itemno=b.itemno
                                
                                left join
                                (
                                    select 
                                    location,
                                    category,
                                    wos_group,
                                    itemno,
                                    sum(qty) as sum_out 
                                    
                                    from ictran 
                                    
                                    where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                                    and (toinv='' or toinv is null) 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getupdate.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                                    group by location,itemno
                                    order by location,itemno
                                ) as c on a.location=c.location and a.itemno=c.itemno 
                                
                                where a.itemno=a.itemno
                                and a.itemno='#itemno#' 
                               and a.location = '#getupdate.location#'
                                
                            ) as c on a.itemno=c.itemno and b.location=c.location 
                            
                            where a.itemno=a.itemno 
                            and b.location<>''
                        	and b.location = '#getupdate.location#'
                            and a.itemno='#itemno#' 
                            order by a.itemno;
                            </cfquery>
                            <cfelse>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,a.itemtype
                            from icitem as a
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalin 
                                from ictran 
                                where type in ('RC','CN','OAI','TRIN') 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                group by itemno
                            ) as b on a.itemno=b.itemno
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalout 
                                from ictran 
                                where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                and toinv='' 
                                group by itemno
                            ) as c on a.itemno=c.itemno
                            
                            where a.itemno='#itemno#' 
                            </cfquery>
                            </cfif>
                            <cfif getitemqtyonhand.recordcount eq 0>
                            <cfset getitemqtyonhand.balance=0>
                            </cfif>
                            <!--- --->
                        </cfif>
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
						<tr onMouseOver="javascript:this.style.backgroundColor='99FF00';"
                        <cfif (getitemqtyonhand.balance lt qtytoful) and getGsetup.negstk neq '1' and getupdate.linecode neq 'SV'>
                        style="background:##FF0000"
                        onMouseOut="javascript:this.style.backgroundColor='##FF0000';"
                        <cfelse>
                        onMouseOut="javascript:this.style.backgroundColor='';"
                        </cfif>
                        > 					 
							<td>#refno#</td>
							<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
							<td>#custno#</td>
                            <td>#name#</td>
							<td><cftooltip autodismissdelay="60000" sourcefortooltip="/default/transaction/itembal.cfm?itemno=#URLENCODEDFORMAT(itemno)#&project=#URLENCODEDFORMAT(getupdate.source)#&job=#URLENCODEDFORMAT(getupdate.job)#&batchcode=#URLENCODEDFORMAT(getupdate.batchcode)#">#itemno#</cftooltip></td>
                          <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
							<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
                            
							<td><div align="center">#QTY_bil#</div></td>	
                         			
							<td><div align="center">#qtytoful#</div></td>
                            
                            <td><div align="center">
                            <cfif getupdate.linecode eq 'SV'><input type="hidden" name="balanceqty" id="balanceqty_#t1#_#refno#_#trancode#" value="SV" size="6">SV<cfelse><input type="hidden" name="balanceqty" id="balanceqty_#t1#_#refno#_#trancode#" value="#getitemqtyonhand.balance#" size="6">#getitemqtyonhand.balance#</cfif></div></td>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
							<!--- Add & modified on 031008 --->
                    		<cfquery name="getigrade" datasource="#dts#">
                    			select * from igrade 
                       	 		where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        		and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    		</cfquery>
							<cfif getigrade.recordcount neq 0>
								<cfset qtytoful = 0>
							<cfelse>
								<cfset qtytoful = qtytoful>
							</cfif>
							<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            				<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
							<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
							<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                            <cfif checklocation.chooselocation eq "Y">
                            <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                            <cfselect name="location" id="location_#t1#_#refno#_#trancode#" query="getlocation" value="location" display="desp" selected="#getupdate.location#" required="#needlocation#" />
                            </td>
    </cfif>
							<td>
								<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" size="6" <cfif getigrade.recordcount neq 0>readonly</cfif>>
								<cfif getigrade.recordcount neq 0>
									<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','DO','#getupdate.trancode#');">
								</cfif>
							</td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
								<td><div align="right"></div></td>
								<td></td>
							<cfelse>
								<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
								<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
							</cfif>
	
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
							</cfquery>
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
				</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>             
					<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
					</div></td>
				</tr>
			</table>
			<!--- </cfif> --->
		</cfform>
	<cfelseif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checkcustomer(true);">
        <cfset session.formName="updatepage">
			<cfoutput>
				<cfquery name="getcust" datasource="#dts#">
					select custno,name,term from #target_arcust# order by custno
				</cfquery>
			
				<select name="customer">
					<option value="" selected>Select a Customer</option>
					<cfloop query="getcust">
						<option value="#getcust.custno#">#getcust.custno# - #getcust.name# - #getcust.term#</option>
					</cfloop>
				</select>
				<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
				<p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p>
			</cfoutput>
			<table class="data" align="center">
			<tr> 
				<th><cfoutput>#type#</cfoutput></th>
				<th>Date</th>
				<th>Supplier No</th>
				<th>Item No</th>
                <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th><cfoutput>#getgsetup.laitemno#</cfoutput></th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
				<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
				<th>Qty Order</th>
				<th>Qty Outstanding</th>
                 <cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>         
				<th>Qty To Fulfill</th> 
                <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
				<!---cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
					<th>&nbsp;</th> 
					<th>&nbsp;</th>
				<cfelse>
					<th>Price (FC)</th> 
					<th>Price</th>
				</cfif--->
				<th>User</th>
			</tr>
	
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
					
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
					<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
					<cfset xParam2 = ''>
				<cfelse>
					<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>
					
				<cfset xParam3 = listgetat(mylist,i+2,";")>
	
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#'
				</cfquery> 
					 
				<cfoutput query="getupdate">				
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'DO' or type = 'CS') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
					</cfquery>
						
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                        			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 041008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                            select * from igrade 
                            where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                            and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                        </cfquery>
                        <cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <cfselect name="location" id="location_#t1#_#refno#_#trancode#" query="getlocation" value="location" display="desp" selected="#getupdate.location#" required="#needlocation#" />
                        </td>
</cfif>
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','DO','#getupdate.trancode#');">
                            </cfif>
                        </td>
						<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<!---cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
							<td><div align="right"></div></td>
							<td></td>
						<cfelse>
							<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
							<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						</cfif--->
	
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
			</cfif>
		  	<tr>
				 <th>Date</th>
				  <td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
			<tr>             
				<td colspan="5"> <div align="right">
				<input type="reset" name="Submit2" value="Reset">
				<input type="submit" name="Submit" value="Submit">
						 
				 </div></td>
			</tr>
		</table>
		</cfform>
	</cfif>
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<!--- Coding here is for update to Purchase Order --->
	<!--- t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfoutput>
			<cfif lcase(hcomid) eq "steel_i">
				<form action="update3_steel.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
                <cfset session.formName="updatepage">
			<cfelse>
				<form action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
                <cfset session.formName="updatepage">
			</cfif>
		
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
        	
			<p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p>			
      		
			<table class="data" align="center">
            <tr>
            <td colspan="100%">Ref No 2 :  <input type="text" name="refno2" id="refno2" value="" maxlength="35"></td>
            </tr>
          	<tr> 
            	<th>#type#</th>
            	<th>Date</th>
            	<th>Supplier No</th>
           	 	<th>Item No</th>
                <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
            	<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
            	<th>Qty Order</th>
           	 	<th>Qty Outstanding</th>
				<cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>
            	<th>Qty To Fulfill</th>
                <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
                <cfif getpin2.h1360 eq 'T'>
            	<th>Price (FC)</th>
            	<th>Price</th>
                </cfif>
            	<th>User</th>
          	</tr>
        	</cfoutput> 
        	
			<cfloop from="1" to="#cnt#" index="i" step="+3">
          		<cfset xParam1 = listgetat(mylist,i,";")>
          		
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
            		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
            		<cfset xParam2 = ''>
            	<cfelse>
            		<cfset xParam2 = listgetat(mylist,i+1,";")>
          		</cfif>
          		
				<cfset xParam3 = listgetat(mylist,i+2,";")>
          		
				<!--- <cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and shipped < qty
          		</cfquery> --->
				<cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and (shipped+writeoff) < qty
          		</cfquery>
          		
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
              			<cfset order = getupdate.qty_bil - val(getupdate.writeoff)>
              		<cfelse>
              			<cfset order = 0>
            		</cfif>
            		
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
            		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>
                       
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="batchcode" value="#batchcode#">
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 051008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                            select * from igrade 
                            where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                            and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                        </cfquery>
                        <cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value=""> <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <select name="location" id="location_#t1#_#refno#_#trancode#">
                        <cfloop query="getlocation">
                        <option value="#getlocation.location#" <cfif getlocation.location eq getupdate.location>Selected</cfif> >#getlocation.desp#</option>
                        </cfloop>
                        </select>
                        </td></cfif>
                        <td>
                        <cfif getpin2.h286A eq 'T'>
                        <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" size="10" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                        <cfelse>
                        <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" size="10" readonly>
                        </cfif>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','RC','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						 <cfif getpin2.h1360 eq 'T'>
						<td><div align="right"><input type="text" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,stDecl_UPrice)#" size="12" <!---onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')"---> /></div></td>
						<td><div align="right"><input type="text" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,stDecl_UPrice)#" size="12" readonly /></div></td>				<cfelse>
                        <td><div align="right"><input type="hidden" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,stDecl_UPrice)#" size="12" <!---onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')"---> /></div></td>
						<td><div align="right"><input type="hidden" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,stDecl_UPrice)#" size="12" readonly /></div></td>
						</cfif>
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'   and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
            		</tr>
         	 	</cfoutput> 
        	</cfloop>
        	
			<cfif getgeneralinfo.arun neq 1>
          		<tr> 
            		<th colspan="2">Next Refno</th>
					<cfif lcase(hcomid) eq "steel_i">
						<cfinvoke component="cfc.incrementValue" method="getIncreament" input="#getGeneralInfo.tranno#" returnvariable="nexttranno"/>
						<td colspan="9"><cfoutput><input type="text" name="nextrefno" value="#nexttranno#" maxlength="20" size="8"></cfoutput></td>
					<cfelse>
            		<td colspan="9"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
					</cfif>
          		</tr>
        	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				</td>
			</tr>
        	<tr> 
          		<td colspan="5"><div align="right"> 
              		<input type="reset" name="Submit2" value="Reset">
              		<input type="submit" name="Submit" value="Submit"></div>
				</td>
        	</tr>
      	</table>
		</form>
	</cfif>
    
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checksupplier(true);">
        <cfset session.formName="updatepage">
			<cfoutput>
			
			<cfquery name="getsupp" datasource="#dts#">
				select custno,name,term,currcode from #target_apvend# where (status<>'B' or status is null) order by custno;
			</cfquery>
			
			<select name="supplier" id="supplier">
				<option value="" selected>Select a Supplier</option>
				<cfloop query="getsupp">
					<option value="#getsupp.custno#">#getsupp.custno# - #getsupp.name#<cfif trim(getsupp.term) neq ""> - #getsupp.term#</cfif><cfif trim(getsupp.currcode) neq ""> - #getsupp.currcode#</cfif></option>
				</cfloop>
			</select>
			<input type="text" name="searchsupp" onKeyUp="getSupp('supplier','Supplier');">
			<input type="hidden" name="checkbox" value="#form.checkbox#">
        	
			<p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p>	
				
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
                    <cfif hcomid eq "asiasoft_i">
                    <th>Cost</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
        			<th>User</th>
				</tr>
			</cfoutput> 
			
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
				
                <cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			      	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			      	<cfset xParam2 = ''>
			    <cfelse>
			      	<cfset xParam2 = listgetat(mylist,i+1,";")>
			    </cfif>
				
				<cfset xParam3 = listgetat(mylist,i+2,";")>
				<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
					Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
                <cfelse>
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
				</cfif>
				<cfoutput query="getupdate"> 				
					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           		 		and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
            		</cfquery>
					
            		<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>
				
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
				
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                      			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','PO','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<cfif hcomid eq "asiasoft_i">
                        <td><div align="right">#numberformat(val(brem2),"__,___" & stDecl_UPrice)#</div></td>
                            </cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
		  		<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
				<tr>             
          			<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
    
    <cfif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checksupplier(true);">
        <cfset session.formName="updatepage">
			<cfoutput>
			
			<cfquery name="getsupp" datasource="#dts#">
				select custno,name,term,currcode from #target_apvend# where (status<>'B' or status is null) order by custno;
			</cfquery>
			
			<select name="supplier" id="supplier">
				<option value="" selected>Select a Supplier</option>
				<cfloop query="getsupp">
					<option value="#getsupp.custno#">#getsupp.custno# - #getsupp.name#<cfif trim(getsupp.term) neq ""> - #getsupp.term#</cfif><cfif trim(getsupp.currcode) neq ""> - #getsupp.currcode#</cfif></option>
				</cfloop>
			</select>
			<input type="text" name="searchsupp" onKeyUp="getSupp('supplier','Supplier');">
			<input type="hidden" name="checkbox" value="#form.checkbox#">
        	
			<p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p>	
				
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
                    <th>Cost Price</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
                    <cfif hcomid eq "asiasoft_i">
                    <th>Cost</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
        			<th>User</th>
				</tr>
			</cfoutput> 
			
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
				
                <cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			      	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			      	<cfset xParam2 = ''>
			    <cfelse>
			      	<cfset xParam2 = listgetat(mylist,i+1,";")>
			    </cfif>
				
				<cfset xParam3 = listgetat(mylist,i+2,";")>
				<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
					Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
                <cfelse>
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
				</cfif>
				<cfoutput query="getupdate"> 				
					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           		 		and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
            		</cfquery>
					
            		<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>
				
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
				
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp,ucost,price,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="i">,fcurrcode#i#,fprice#i#,fucost#i#</cfloop> from icitem where itemno='#itemno#'
                    </cfquery>
                    
                    <cfif lcase(hcomid) eq "unistat_i">
                    <cfquery name="getbillcurrcode" datasource="#dts#">
                    		SELECT currcode from artran WHERE refno="#getupdate.refno#" and type=refno="#getupdate.type#"
                    </cfquery>
                    <cfset xcost=getproductcode.ucost>
                    <cfif trim(getbillcurrcode.currcode) neq "">
					<cfif getbillcurrcode.currcode eq getproductcode.fcurrcode>
                    <cfset xcost=getproductcode.fucost>
                    </cfif>
                    
                    <cfloop from="2" to="10" index="i">
                    <cfif getbillcurrcode.currcode eq evaluate('getproductcode.fcurrcode#i#')>
                    <cfset xcost= evaluate('getproductcode.fucost#i#')>
                    </cfif>
                    </cfloop>
                    </cfif>
                    
                    
                    <cfelse>
                    <cfset xcost=0>
                    </cfif>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                      			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','PO','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <td>
                            <input type="text" name="itemcost" id="itemcost_#t1#_#refno#_#trancode#" value="#val(xcost)#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                        </td>
                        
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<cfif hcomid eq "asiasoft_i">
                        <td><div align="right">#numberformat(val(brem2),"__,___" & stDecl_UPrice)#</div></td>
                            </cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
		  		<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
				<tr>             
          			<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
    
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<!--- Coding here is for update to DO --->
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO" or url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checksupplier(true);">
        <cfset session.formName="updatepage">
			<cfoutput>
			
			<cfquery name="getsupp" datasource="#dts#">
				select custno,name,term,currcode from #target_apvend# where (status<>'B' or status is null) order by custno;
			</cfquery>
			
			<select name="supplier" id="supplier">
				<option value="" selected>Select a Supplier</option>
				<cfloop query="getsupp">
					<option value="#getsupp.custno#">#getsupp.custno# - #getsupp.name#<cfif trim(getsupp.term) neq ""> - #getsupp.term#</cfif><cfif trim(getsupp.currcode) neq ""> - #getsupp.currcode#</cfif></option>
				</cfloop>
			</select>
			<input type="text" name="searchsupp" onKeyUp="getSupp('supplier','Supplier');">
			<input type="hidden" name="checkbox" value="#form.checkbox#">
        	
			<p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p>	
				
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
                    <cfif hcomid eq "asiasoft_i">
                    <th>Cost</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
        			<th>User</th>
				</tr>
			</cfoutput> 
			
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfset xParam1 = listgetat(mylist,i,";")>
				
                <cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			      	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			      	<cfset xParam2 = ''>
			    <cfelse>
			      	<cfset xParam2 = listgetat(mylist,i+1,";")>
			    </cfif>
				
				<cfset xParam3 = listgetat(mylist,i+2,";")>
				<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
					Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
                <cfelse>
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = '' </cfif>
				</cfquery> 
				</cfif>
				<cfoutput query="getupdate"> 				
					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           		 		and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
            		</cfquery>
					
            		<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>
				
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
				
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                       			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','PO','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<cfif hcomid eq "asiasoft_i">
                        <td><div align="right">#numberformat(val(brem2),"__,___" & stDecl_UPrice)#</div></td>
                            </cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
		  		<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
				<tr>             
          			<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
	
<!--- t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ --->
	<cfif url.t1 eq "RQ">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfoutput>
			<cfif lcase(hcomid) eq "steel_i">
				<form action="update3_steel.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checksupplier(true);">
                <cfset session.formName="updatepage">
			<cfelse>
				<form action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return checksupplier(true);">
                <cfset session.formName="updatepage">
			</cfif>
		
        	<cfquery name="getsupp" datasource="#dts#">
				select custno,name,term,currcode from #target_apvend# where (status<>'B' or status is null) order by custno;
			</cfquery>
            
            <cfif lcase(hcomid) eq "haikhim_i">
            
            <cfset xParam1 = listgetat(mylist,1,";")>
            <cfquery datasource="#dts#" name="haikhimgetrqsupp">
          			Select custno,name from artran where refno = '#xParam1#' and type = '#t1#' 
          	</cfquery>
            
            <select name="supplier" id="supplier">
            	<cfif haikhimgetrqsupp.recordcount eq 0>
                <option value="" selected>Select a Supplier</option>
                </cfif>
				<cfloop query="haikhimgetrqsupp">
					<option value="#haikhimgetrqsupp.custno#">#haikhimgetrqsupp.custno# - #haikhimgetrqsupp.name#</option>
				</cfloop>
			</select>
            
            <cfelse>
            
            <cftry>
            <cfset xParam1 = listgetat(mylist,1,";")>
            <cfcatch>
            <cfset xParam1 = "">
            </cfcatch>
            </cftry>
            
            <cfquery datasource="#dts#" name="getupdatecust">
          			Select * from artran where refno = '#xParam1#' and type = '#t1#'
          	</cfquery>
			
			<select name="supplier" id="supplier">
				<option value="" selected>Select a Supplier</option>
				<cfloop query="getsupp">
					<option value="#getsupp.custno#" <cfif getsupp.custno eq getupdatecust.custno>selected</cfif>>#getsupp.custno# - #getsupp.name#<cfif trim(getsupp.term) neq ""> - #getsupp.term#</cfif><cfif trim(getsupp.currcode) neq ""> - #getsupp.currcode#</cfif></option>
				</cfloop>
			</select>
        	<input type="text" name="searchsupp" onKeyUp="getSupp('supplier','Supplier');">
            </cfif>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
        	
			<p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p>			
      		
			<table class="data" align="center">
          	<tr> 
            	<th>#type#</th>
            	<th>Date</th>
            	<th>Supplier No</th>
           	 	<th>Item No</th>
                <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
            	<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
            	<th>Qty Order</th>
           	 	<th>Qty Outstanding</th>
				<cfif checklocation.chooselocation eq "Y">
                    <th>Location</th>          
                    </cfif>
            	<th>Qty To Fulfill</th>
                <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
                <cfif getpin2.h1360 eq 'T'>
            	<th>Price (FC)</th>
            	<th>Price</th>
                </cfif>
            	<th>User</th>
          	</tr>
        	</cfoutput> 
        	
			<cfloop from="1" to="#cnt#" index="i" step="+3">
          		<cfset xParam1 = listgetat(mylist,i,";")>
          		
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
            		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
            		<cfset xParam2 = ''>
            	<cfelse>
            		<cfset xParam2 = listgetat(mylist,i+1,";")>
          		</cfif>
          		
				<cfset xParam3 = listgetat(mylist,i+2,";")>
          		
				<!--- <cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and shipped < qty
          		</cfquery> --->
				<cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and (shipped+writeoff) < qty
          		</cfquery>
          		
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
              			<cfset order = getupdate.qty_bil - val(getupdate.writeoff)>
              		<cfelse>
              			<cfset order = 0>
            		</cfif>
            		
					<cfset qtytoful = order - upqty>
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
            		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>
                        
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="batchcode" value="#batchcode#">
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 051008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                            select * from igrade 
                            where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                            and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                        </cfquery>
                        <cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value=""> <cfif checklocation.chooselocation eq "Y">
                        <td><a onClick="showlocbal('#getupdate.itemno#')">B</a>
                        <select name="location" id="location_#t1#_#refno#_#trancode#">
                        <cfloop query="getlocation">
                        <option value="#getlocation.location#" <cfif getlocation.location eq getupdate.location>Selected</cfif> >#getlocation.desp#</option>
                        </cfloop>
                        </select>
                        </td></cfif>
                        <td>
                       

                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" size="10" <!---onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')"---> <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','RC','#getupdate.trancode#');">
                            </cfif>
                        </td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						 <cfif getpin2.h1360 eq 'T'>
						<td><div align="right"><input type="text" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,".__" & stDecl_UPrice)#" size="12" <!---onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')"---> /></div></td>
						<td><div align="right"><input type="text" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,".__" & stDecl_UPrice)#" size="12" readonly /></div></td>				<cfelse>
                        <td><div align="right"><input type="hidden" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,".__" & stDecl_UPrice)#" size="12" <!---onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')"---> /></div></td>
						<td><div align="right"><input type="hidden" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,".__" & stDecl_UPrice)#" size="12" readonly /></div></td>
						</cfif>
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'   and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
            		</tr>
         	 	</cfoutput> 
        	</cfloop>
        	
			<cfif getgeneralinfo.arun neq 1>
          		<tr> 
            		<th colspan="2">Next Refno</th>
					<cfif lcase(hcomid) eq "steel_i">
						<cfinvoke component="cfc.incrementValue" method="getIncreament" input="#getGeneralInfo.tranno#" returnvariable="nexttranno"/>
						<td colspan="9"><cfoutput><input type="text" name="nextrefno" value="#nexttranno#" maxlength="20" size="8"></cfoutput></td>
					<cfelse>
            		<td colspan="9"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
					</cfif>
          		</tr>
        	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				</td>
			</tr>
        	<tr> 
          		<td colspan="5"><div align="right"> 
              		<input type="reset" name="Submit2" value="Reset">
              		<input type="submit" name="Submit" value="Submit"></div>
				</td>
        	</tr>
      	</table>
		</form>
	</cfif>
    
    
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<!--- Coding here is for update to DO --->
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
				<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
				<p>Last Sales Order No : <font size="2">#getGeneralInfo.tranno#</font></p>
			</cfoutput>
			<!--- STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL STELL --->
			<cfif lcase(hcomid) eq "steel_i">
				<table class="data" align="center">
				<tr> 
					<th rowspan="2"><cfoutput>#type#</cfoutput></th>
					<th rowspan="2">Date</th>
					<th rowspan="2">Customer No</th>
					<th rowspan="2">QUO - Item Description</th>
					<th colspan="2">SO - Item Description</th>
					<th rowspan="2">Qty Bill</th>
					<th rowspan="2">Qty Outstanding</th>          
					<th rowspan="2">Qty To Fulfill</th> 
					<!---
					<th rowspan="2">Price (FC)</th> 
					<th rowspan="2">Price</th>--->
					<th rowspan="2">User</th>
				</tr>
				<tr>
					<th>New Item</th>
					<th>Filter</th>
				</tr>
				<cfloop from="1" to="#cnt#" index="i" step="+3">
					<cfset xParam1 = listgetat(mylist,i,";")>
					
					<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
						<cfset xParam2 = ''>
					<cfelse>
						<cfset xParam2 = listgetat(mylist,i+1,";")>
					</cfif>
					
					<cfset xParam3 = listgetat(mylist,i+2,";")>
	
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#xParam1#' and i.itemno='#xParam2#' and i.trancode='#xParam3#' and i.type='#t1#' and shipped < qty 
					</cfquery>
					 
					<cfoutput query="getupdate">				
						<cfquery datasource="#dts#" name="getupqty">
							select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty from iclink where frrefno = '#getupdate.refno#' 
							and frtype='#t1#' and (type='INV' or type='SO' or type = 'CS' or type = 'DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
						</cfquery>
						
						<cfset upqty = getupqty.sumqty>
						<cfset order=getupdate.qty_bil>
						<cfset qtytoful=order-upqty>
						
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
							<td>#refno#</td>
							<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
							<td>#custno#</td>
							<td nowrap>#desp##despa#</td>
							<td nowrap>
								<select id="itemno#i#" name="newitemno">
									<option value="-1">&nbsp;Please use the filter.</option>
								</select>
							</td>
							<td nowrap>
								Filter by:
							<input id="#i#" name="letter#i#" type="text" size="8" onKeyUp="getItem(this.id)"> in:
							<select id="searchtype#i#" name="searchtype#i#" onChange="resetLetter(this.id)">
								<option value="itemno">Item No</option>
								<option value="mitemno">Product Code</option>
								<option value="desp">Description</option>
								<option value="category">Category</option>
								<option value="wos_group">Group</option>
								<option value="brand">Brand</option>
							</select>
							</td>
							</td>
							<td><div align="center">#QTY_bil#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<!--- <td><input type="text" name="fulfill" value="#qtytoful#" size="8"></td> --->
							
							 <!--- Add & modified on 051008 --->
                            <cfquery name="getigrade" datasource="#dts#">
                                select * from igrade 
                                where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                                and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                            </cfquery>
                            <cfif getigrade.recordcount neq 0>
                                <cfset qtytoful = 0>
                            <cfelse>
                                <cfset qtytoful = qtytoful>
                            </cfif>
                            <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                            <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                            <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                            <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                            <td>
                                <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" onKeyUp="calculatefufill('#t1#','#refno#','#getupdate.recordcount#');" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                                <cfif getigrade.recordcount neq 0>
                                    <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','SO','#getupdate.trancode#');">
                                </cfif>
                            </td>
							
							<!---
							<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
							<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>--->
							<td>#userid#</td>
						</tr>
                       
					</cfoutput> 
				</cfloop>
				<cfif getgeneralinfo.arun neq 1>
					<tr>
						<th colspan="2">Next Refno</th>
						<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
					</tr>
				</cfif>
			  	<tr>
					<th>Date</th>
					<td colspan="4">
						  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
					<tr>             
						<td colspan="12"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
						 
						 </div></td>
					</tr>
				</table>
			<!--- OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS OTHERS --->
			<cfelse>
				<table class="data" align="center">
				<tr> 
					<th><cfoutput>#type#</cfoutput></th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th><cfoutput>#getgsetup.laitemno#</cfoutput></th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th> <!---
					<cfif ucase(HcomID) eq "FLOPRINTS" and husergrpid eq "luser">
						<th>&nbsp;</th> 
						<th>&nbsp;</th>
					<cfelse>
						<th>Price (FC)</th> 
						<th>Price</th>
					</cfif>--->
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>User</th>
				</tr>
	
				<cfloop from="1" to="#cnt#" index="i" step="+3">
					<cfset xParam1 = listgetat(mylist,i,";")>
					
					<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
						<cfset xParam2 = ''>
					<cfelse>
						<cfset xParam2 = listgetat(mylist,i+1,";")>
					</cfif>
					
					<cfset xParam3 = listgetat(mylist,i+2,";")>
	
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and type = '#t1#' and shipped < qty 
					</cfquery> 
					 
					<cfoutput query="getupdate">				
						<cfquery datasource="#dts#" name="getupqty">
							select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
							and frtype = '#t1#' and (type='INV' or type='SO' or type='DO' or type='CS') and itemno = '#getupdate.itemno#' 
							and frtrancode = '#getupdate.trancode#'
						</cfquery>
						
						<cfif getupqty.sumqty neq "">
							<cfset upqty = getupqty.sumqty>
						<cfelse>
							<cfset upqty = 0>
						</cfif>
					
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty_bil>
						<cfelse>
							<cfset order = 0>
						</cfif>
					
						<cfset qtytoful = order - upqty>
                        
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                        
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
							<td>#refno#</td>
							<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
							<td>#custno#</td>
							<td>#itemno#</td>
                            <cfif getdisplaysetup.update_aitemno eq 'Y'>
                            <td>#getproductcode.aitemno#</td>
                            </cfif>
                            <cfif getdisplaysetup.update_supplier eq 'Y'>
                            <td>#getproductcode.supp#</td>
                            </cfif>
							<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
							<td><div align="center">#QTY_bil#</div></td>		
                        			
							<td><div align="center">#qtytoful#</div></td>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
							
							<!--- Add & modified on 051008 --->
                            <cfquery name="getigrade" datasource="#dts#">
                                select * from igrade 
                                where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                                and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                            </cfquery>
                            <cfif getigrade.recordcount neq 0>
                                <cfset qtytoful = 0>
                            <cfelse>
                                <cfset qtytoful = qtytoful>
                            </cfif>
                            <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                            <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                            <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                            <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                            <td>
                            <cfif lcase(hcomid) eq "tranz_i">
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="0" readonly>
                            <input type="button" value="Multilocation" onClick="multiLocation('#itemno#','#t1#','#refno#','#getupdate.trancode#','#qtytoful#');">
                            <input type="hidden" name="multilocuuid" id="multilocuuid" value="#uuid#">
                            <cfelse>
                                <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" onKeyUp="calculatefufill('#t1#','#refno#','#getupdate.recordcount#');" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                                <cfif getigrade.recordcount neq 0>
                                    <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','SO','#getupdate.trancode#');">
                                </cfif>
                            </cfif>
                            </td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<!---
							<cfif ucase(HcomID) eq "FLOPRINTS" and husergrpid eq "luser">
								<td><div align="right"></div></td>
								<td></td>
							<cfelse>
								<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
								<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
							</cfif>
							--->
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
							</cfquery>
							<td>#getid.userid#</td>
						</tr>
                        
					</cfoutput> 
				</cfloop>
				<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
				</cfif>
			  	<tr>
					<th>Date</th>
					<td colspan="4">
						  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">
					</td>
				</tr>
					<tr>             
						<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
						 
						 </div></td>
					</tr>
				</table>
			</cfif>
		</cfform>
        
        <!--- t1 = SAM --->
	<cfelseif url.t1 eq "SAM">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfoutput>
			
				<form action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
                <cfset session.formName="updatepage">
		
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
        	
			<p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p>			
      		
			<table class="data" align="center">
          	<tr> 
            	<th>#type#</th>
            	<th>Date</th>
            	<th>Supplier No</th>
           	 	<th>Item No</th>
            	<th>Item Description</th>
            	<th>Qty Order</th>
           	 	<th>Qty Outstanding</th>
            	<th>Qty To Fulfill</th>
                <cfif getpin2.h1360 eq 'T'>
            	<th>Price (FC)</th>
            	<th>Price</th>
                </cfif>
            	<th>User</th>
          	</tr>
        	</cfoutput> 
        	
			<cfloop from="1" to="#cnt#" index="i" step="+3">
          		<cfset xParam1 = listgetat(mylist,i,";")>
          		
				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
            		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
            		<cfset xParam2 = ''>
            	<cfelse>
            		<cfset xParam2 = listgetat(mylist,i+1,";")>
          		</cfif>
          		
				<cfset xParam3 = listgetat(mylist,i+2,";")>
          		
				<!--- <cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and shipped < qty
          		</cfquery> --->
				<cfquery datasource="#dts#" name="getupdate">
          			Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' 
          			and trancode = '#xParam3#' and type = '#t1#' and (shipped+writeoff) < qty
          		</cfquery>
          		
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
              			<cfset order = getupdate.qty_bil - val(getupdate.writeoff)>
              		<cfelse>
              			<cfset order = 0>
            		</cfif>
            		
					<cfset qtytoful = order - upqty>
            		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
						<td nowrap>#desp##despa#</td>
						<td><div align="center">#QTY_bil#</div></td>
                      
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="batchcode" value="#batchcode#">
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						
						<!--- Add & modified on 051008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                            select * from igrade 
                            where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                            and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                        </cfquery>
                        <cfif getigrade.recordcount neq 0>
                            <cfset qtytoful = 0>
                        <cfelse>
                            <cfset qtytoful = qtytoful>
                        </cfif>
                        <input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
                        <input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
                        <input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
                        <td>
                            <input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" size="10" onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')" <cfif getigrade.recordcount neq 0>readonly</cfif>>
                            <cfif getigrade.recordcount neq 0>
                                <input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','RC','#getupdate.trancode#');">
                            </cfif>
                        </td>
						 <cfif getpin2.h1360 eq 'T'>
						<td><div align="right"><input type="text" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,".__" & stDecl_UPrice)#" size="12" onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')" /></div></td>
						<td><div align="right"><input type="text" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,".__" & stDecl_UPrice)#" size="12" readonly /></div></td>				<cfelse>
                        <td><div align="right"><input type="hidden" name="pricebil" id="pricebil_#t1#_#refno#_#trancode#" value="#numberformat(price_bil,".__" & stDecl_UPrice)#" size="12" onKeyUp="updatePrice('price_#t1#_#refno#_#trancode#','fulfill_#t1#_#refno#_#trancode#','pricebil_#t1#_#refno#_#trancode#')" /></div></td>
						<td><div align="right"><input type="hidden" name="price" id="price_#t1#_#refno#_#trancode#" value="#numberformat(price,".__" & stDecl_UPrice)#" size="12" readonly /></div></td>
						</cfif>
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'   and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
            		</tr>
         	 	</cfoutput> 
        	</cfloop>
        	
			<cfif getgeneralinfo.arun neq 1>
          		<tr> 
            		<th colspan="2">Next Refno</th>
					<cfif lcase(hcomid) eq "steel_i">
						<cfinvoke component="cfc.incrementValue" method="getIncreament" input="#getGeneralInfo.tranno#" returnvariable="nexttranno"/>
						<td colspan="9"><cfoutput><input type="text" name="nextrefno" value="#nexttranno#" maxlength="20" size="8"></cfoutput></td>
					<cfelse>
            		<td colspan="9"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
					</cfif>
          		</tr>
        	</cfif>
		  	<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
				</td>
			</tr>
        	<tr> 
          		<td colspan="5"><div align="right"> 
              		<input type="reset" name="Submit2" value="Reset">
              		<input type="submit" name="Submit" value="Submit"></div>
				</td>
        	</tr>
      	</table>
		</form>
        
        
	</cfif>
	
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			
			<p>Last #gettranname.lcs# No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
					<th>User</th>
				</tr>
			</cfoutput> 
				
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and itemno = '#listgetat(mylist,i +1,";")#' 
					and trancode = '#listgetat(mylist,i +2,";")#' and type = '#t1#' and shipped < qty
				</cfquery> 
					 
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'SO' or type = 'CS' or type = 'DO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>	
                       			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
							<cfset qtytoful = 0>
						<cfelse>
							<cfset qtytoful = qtytoful>
						</cfif>
						<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            			<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
						<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
						<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
						<td>
							<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
							<cfif getigrade.recordcount neq 0>
								<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
							</cfif>
						</td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
			</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>
					<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
        
        <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			
			<p>Last #gettranname.lcs# No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    <th>#getgsetup.brem1#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    <th>#getgsetup.brem2#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    <th>#getgsetup.brem3#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    <th>#getgsetup.brem4#</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
					<th>Price (FC)</th>
					<th>Price</th>					
					<th>User</th>
				</tr>
			</cfoutput> 
				
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and itemno = '#listgetat(mylist,i +1,";")#' 
					and trancode = '#listgetat(mylist,i +2,";")#' and type = '#t1#' and shipped < qty
				</cfquery> 
					 
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'SO' or type = 'CS' or type = 'DO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
                    
                    <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                    
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
                        <cfif getdisplaysetup.update_aitemno eq 'Y'>
                        <td>#getproductcode.aitemno#</td>
                        </cfif>
                        <cfif getdisplaysetup.update_supplier eq 'Y'>
                        <td>#getproductcode.supp#</td>
                        </cfif>
						<td nowrap>#desp##despa#</td>
                    	<cfif getdisplaysetup.update_bodyremark1 eq 'Y'>
                    	<td>#brem1#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark2 eq 'Y'>
                    	<td>#brem2#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark3 eq 'Y'>
                    	<td>#brem3#</td>
                    	</cfif>
                    	<cfif getdisplaysetup.update_bodyremark4 eq 'Y'>
                    	<td>#brem4#</td>
                    	</cfif>
						<td><div align="center">#QTY_bil#</div></td>		
                      			
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
							<cfset qtytoful = 0>
						<cfelse>
							<cfset qtytoful = qtytoful>
						</cfif>
						<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            			<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
						<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
						<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
						<td>
							<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
							<cfif getigrade.recordcount neq 0>
								<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
							</cfif>
						</td>
                        <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
			</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>
					<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
        
	</cfif>
<cfelseif url.t2 eq "QUO">
<cfif url.t1 eq "SAMM">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
        <cfset session.formName="updatepage">
			<cfoutput>
			<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">
			
			<p>Last #gettranname.lquo# No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center">
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
					<th>Item Description</th>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>          
					<th>Qty To Fulfill</th>  
					<th>Price (FC)</th>
					<th>Price</th>					
					<th>User</th>
				</tr>
			</cfoutput> 
				
			<cfloop from="1" to="#cnt#" index="i" step="+3">
				<cfquery datasource="#dts#" name="getupdate">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and itemno = '#listgetat(mylist,i +1,";")#' 
					and trancode = '#listgetat(mylist,i +2,";")#' and type = '#t1#' and shipped < qty
				</cfquery> 
					 
				<cfoutput query="getupdate"> 
					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'SO' or type = 'CS' or type = 'DO' or type = 'QUO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
					</cfquery>
					
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>
					
					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty_bil>
					<cfelse>
						<cfset order = 0>
					</cfif>
					
					<cfset qtytoful = order - upqty>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
						<td>#refno#</td>
						<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
						<td>#custno#</td>
						<td>#itemno#</td>
						<td nowrap>#desp##despa#</td>
						<td><div align="center">#QTY_bil#</div></td>			
                       
						<td><div align="center">#qtytoful#</div></td>
						<input type="hidden" name="qtytoful" value="#qtytoful#">
						<!--- <td><input type="text" name="fulfill" value="#qtytoful#"></td> --->
						<!--- Add & modified on 031008 --->
                    	<cfquery name="getigrade" datasource="#dts#">
                    		select * from igrade 
                       	 	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        	and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    	</cfquery>
						<cfif getigrade.recordcount neq 0>
							<cfset qtytoful = 0>
						<cfelse>
							<cfset qtytoful = qtytoful>
						</cfif>
						<input type="hidden" name="grdcolumnlist_#t1#_#refno#_#trancode#" id="grdcolumnlist_#t1#_#refno#_#trancode#" value="">
            			<input type="hidden" name="grdvaluelist_#t1#_#refno#_#trancode#" id="grdvaluelist_#t1#_#refno#_#trancode#" value="">
						<input type="hidden" name="totalrecord_#t1#_#refno#_#trancode#" id="totalrecord_#t1#_#refno#_#trancode#" value="0">
						<input type="hidden" name="bgrdcolumnlist_#t1#_#refno#_#trancode#" id="bgrdcolumnlist_#t1#_#refno#_#trancode#" value="">
						<td>
							<input type="text" name="fulfill" id="fulfill_#t1#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
							<cfif getigrade.recordcount neq 0>
								<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#t1#','INV','#getupdate.trancode#');">
							</cfif>
						</td>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
						<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'  and type='#URLEncodedFormat(t1)#'
						</cfquery>
						
						<td>#getid.userid#</td>
					</tr>
				</cfoutput> 
			</cfloop>
			
			<cfif getgeneralinfo.arun neq 1>
				<tr>
					<th colspan="2">Next Refno</th>
					<td colspan="8"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
			</cfif>
		  		<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
				<tr>
					<td colspan="5"> <div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
</cfif>
</body>
</html>