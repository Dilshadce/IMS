<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../../scripts/collapse_expand_single_item.js"></script>
<script type="text/javascript">
function validate()
{
var ckbx_arr=document.getElementsByName('checkbox'); 
var ckbx_arr_ln=ckbx_arr.length;

for(var i=0;i<ckbx_arr_ln;i++){ 
if(ckbx_arr[i].checked == true)
{  
return true;
} 
}
alert("Please Check At Least One Check Box");
return false;
}
</script>
<script type="text/javascript">
function checkAll(id,refno,location){
	
	var locid='loc'+id+'_'+refno+'_'+location;
	var thisid=id+'_'+refno+'_'+location;
	
	checkboxObj=document.getElementById(locid);
	
	if(checkboxObj.checked == true){
		 var inputs = document.getElementsByTagName('input');
	   	 var checkboxes = [];
	    for (var i = 0; i < inputs.length; i++) {
	
	        if (inputs[i].type == 'checkbox' && inputs[i].id==thisid) {
	        	inputs[i].checked =true;
			}
		}
	}
	else{
		var inputs = document.getElementsByTagName('input');
	   	var checkboxes = [];
	    for (var i = 0; i < inputs.length; i++) {
	
	    	if (inputs[i].type == 'checkbox' && inputs[i].id==thisid) {
	        	inputs[i].checked =false;
			}
		}
	}
}
</script>

</head>

<cfparam name="fulfill" default="">

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>
<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>


<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>
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
	
<!--- REMARK ON 230608 AND REPLACE WITH THE BELOW ONE --->	
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as tranno, #tranarun# as arun from GSetup
</cfquery--->
<!--- <cfquery datasource="main" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where userDept = '#dts#'
	and type = '#t2#'
	and counter = '#invset#'
</cfquery> --->
<!--- <cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where type = '#t2#'
	and counter = '#invset#'
</cfquery> --->

<cfif isdefined("form.invset")>
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = '#invset#'
	</cfquery>
	<cfset counter = invset>
<cfelse>
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = 1
	</cfquery>
	
	<cfset invset = 1>
</cfif>

<br><br>It will display all item in the select <cfoutput>#type#</cfoutput>.
<!--- The coding below provide updating of DO or SO to Invoice --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<!--- Coding here is for update to Invoice --->
	<!--- t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO --->
	<cfif url.t1 eq "DO">
		<!--- Get information on the outstanding unbill DO--->
		<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and toinv = '' order by refno
		</cfquery>
		
		<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage"onsubmit="return validate();" >
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
		      	<input type="hidden" name="invset" value="#invset#">
	        </cfif>
			
      		<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>
			
			<table class="data" align="center" width="50%">
			<tr> 
          		<th>#type#</th>
          		<th>Date</th>
          		<th>Customer No</th>
          		<th>User</th>
          		<th>To Bill</th>
        	</tr>
			</cfoutput>
        	
			<cfoutput query="getupdate"> 
          	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 
            	<td>#refno#</td>
            	<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
            	<td>#custno#</td>
            	<td>#userid#</td>
            	<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#"></td>
          	</tr>
		  	</cfoutput> 
		  	
			<cfif getgeneralinfo.arun neq 1>
		  	<tr>
				<th colspan="2">Next Refno</th>
				<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
			</tr>
		  	</cfif>
          	<tr>             
          		<td colspan="5"><div align="center">
                <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
              		<input type="submit" name="Submit" value="Submit"></div>
				</td>
          	</tr>
      	</table>
	</cfform>
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>		

		<cfif lcase(hcomid) eq "nikbra_i">
			<cfoutput><form action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();"></cfoutput>
            <cfset session.formName="updatepage">
		<cfelse>
			<cfoutput><form action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();"></cfoutput>
            <cfset session.formName="updatepage">
		</cfif>
		
			<cfoutput>
			<cfif isdefined("form.invset")>
		      	<input type="hidden" name="invset" value="#invset#">
	        </cfif>
			
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>
      		</cfoutput>
			<cfif lcase(hcomid) eq "nikbra_i">
				<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>			
					<th colspan="3">Department</th>
					<th>To Bill</th>
				  </tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' and (shipped+writeoff) < qty 
						group by location
					</cfquery> 

					<cfoutput query="getupdate">

					<tr> 			 
            			<td>#refno#</td>
           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           				<td>#custno#</td>
						<td colspan="3" nowrap  onClick="javascript:shoh('item#location#_#refno#');">#location#<span style="background-color:99CC00">
							<img src="../../../images/u.gif" name="imgitem#location#_#refno#" align="center"/></span></td>
                    	<td><input type="checkbox" name="loccheckbox_#refno#_#location#" onClick="checkAll('checkbox','#refno#','#location#');" checked></td>
					</tr>	
					<tr>
						<td></td>
           				<td></td>
           				<td></td>
						<td></td>
						<td><cfinclude template="item.cfm"></td>
					</tr>	
					</cfoutput> 
				</cfloop>
			<cfelse>	
				<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>					
        			<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<!--- <cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' and shipped < qty 
						order by trancode
					</cfquery>  --->
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' and (shipped+writeoff) < qty 
						order by trancode
					</cfquery> 

					<cfoutput query="getupdate">

					<cfquery datasource="#dts#" name="getupqty">
						select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
						and frtype = '#t1#' and (type = 'INV' or type = 'DO') and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
					</cfquery>
				
					<cfif getupqty.sumqty neq "">
						<cfset upqty = getupqty.sumqty>
					<cfelse>
						<cfset upqty = 0>
					</cfif>

					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty - val(getupdate.writeoff)>
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
                        <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
                        
                        
						<td><div align="center">#QTY#</div></td>					
						<td><div align="center">#qtytoful#</div></td>
					
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    
						<cfif trim(itemno) eq ''>
			          		<!--- Just assign a value, because ColdFusion ignores empty list elements --->
			          		<cfset xitemno = 'YHFTOKCF'>
			        	<cfelse>
			          		<cfset xitemno = itemno>
			        	</cfif>
						<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
              			<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
             			<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
              			<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'
						</cfquery>
						<td>#getid.userid#</td>
					</tr>			
					</cfoutput> 
				</cfloop>
			</cfif>
				<tr>             
          			<td colspan="100%"><div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
					<input type="reset" name="Submit2" value="Reset">
             		<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</form>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
	  	<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
				
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
		      	<input type="hidden" name="invset" value="#invset#">
	        </cfif>
        	
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>
      		</cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>					
        			<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">

					<cfquery datasource="#dts#" name="getupqty">
            			select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           		 		and frtype = '#t1#' and (type = 'INV' or type = 'SO' or type='CS' or type='DO') and itemno = '#getupdate.itemno#' 
						and frtrancode = '#getupdate.trancode#'
            		</cfquery>
            		
					<cfif getupqty.sumqty neq "">
              			<cfset upqty = getupqty.sumqty>
              		<cfelse>
              			<cfset upqty = 0>
            		</cfif>

					<cfif getupdate.recordcount gt 0>
						<cfset order = getupdate.qty>
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
                        <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
						<td><div align="center">#QTY#</div></td>					
						<td><div align="center">#qtytoful#</div></td>
						
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    	
						<cfif trim(itemno) eq ''>
			          		<!--- Just assign a value, because ColdFusion ignores empty list elements --->
			          		<cfset xitemno = 'YHFTOKCF'>
			        	<cfelse>
			          		<cfset xitemno = itemno>
			        	</cfif>
						<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
						<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
						<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
              			<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
              			<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
              			<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
						
						<cfquery name="getid" datasource="#dts#">
							select userid from artran where refno = '#refno#'
						</cfquery>
           				
						<td>#getid.userid#</td>
					</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	<!--- From PO To INV: t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfelseif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
	  	
	  	<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>		
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>			
          			<th>To Bill</th>
					<th>Unit Price</th>
            		<th>Total Value</th>				
        			<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i" step="+1">
					<cfquery datasource="#dts#" name="getupdate">
						Select a.*,b.price as xprice from ictran a,icitem b 
						where a.itemno=b.itemno
						and a.refno = '#listgetat(mylist,i,";")#' and a.type = '#t1#' 
						and a.exported = '' and a.toinv = '' and (a.linecode <> 'SV' or a.linecode is null)  
						order by a.refno
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
							<cfset order = getupdate.qty>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							
							<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
								<cfset xitemno = 'YHFTOKCF'>
							<cfelse>
								<cfset xitemno = itemno>
							</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td><div align="right">#numberformat(xprice,"__,___" & stDecl_UPrice)#</div></td>
							<cfset xamt=val(qtytoful)*val(xprice)>
							<td><div align="right">#numberformat(xamt,"__,___.__")#</div></td>
							
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#' and type = '#t1#' 
							</cfquery>
							
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
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
		
        <!---ASAIKI UPDATE SAM--->
        <cfif lcase(hcomid) eq "asaiki_i" and url.t1 eq "SAM">

		<cfoutput><form action="asaikiupdate3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
		<cfset session.formName="updatepage"></cfoutput>
		
			<cfoutput><p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
				<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>ASA Roll</th>
                    <th>Serial No</th>
					<th colspan="9">To Bill</th>
				  </tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid,(i.qty-i.shipped-i.writeoff) as totalqty from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno )
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and (shipped+writeoff) < qty order by trancode				
					</cfquery>
					
					<cfoutput query="getupdate">
                    <cfquery name="getserial" datasource="#dts#">
                    select serialno,ctgno from iserial where refno='#listgetat(mylist,i,";")#' and type='#t1#' and trancode='#getupdate.trancode#' and generated='' order by ctgno limit #val(getupdate.totalqty)#
                    </cfquery>
                    <cfloop query="getserial">						
						<tr> 			 
                            <td>#getserial.ctgno#</td>
	           				<td>#getserial.serialno#</td>
	                    	<td><input type="checkbox" name="checkbox" value=";#getupdate.refno#;#convertquote(getupdate.itemno)#;#getupdate.trancode#;#getserial.serialno#" checked></td>
						</tr>	

                    </cfloop>
					</cfoutput> 
				</cfloop>
                <tr>
                        <th>Date</th>
                        <td colspan="4">
                            <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
                            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
                        </td>
						</tr>
			
				<tr>
          			<td colspan="100%"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		<!--- </cfform> --->
		</form>
        <!---END ASAIKI UPDATE SAM--->
        
        <cfelse>
        
		<cfif lcase(hcomid) eq "nikbra_i" and url.t1 eq "SO">
			<cfoutput><form action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
			<cfset session.formName="updatepage"></cfoutput>
		<cfelse>
			<cfoutput><form action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
			<cfset session.formName="updatepage"></cfoutput>
		</cfif>
		<!--- <cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage"> --->
			<cfoutput><p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			<cfif lcase(hcomid) eq "nikbra_i">
				<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th colspan="3">Department</th>
					<th colspan="9">To Bill</th>
				  </tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno )
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and (shipped+writeoff) < qty group by location					
					</cfquery>
					
					<cfoutput query="getupdate">						
						<tr> 			 
	            			<td>#refno#</td>
	           				<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
	           				<td>#custno#</td>
							<td colspan="3" nowrap  onClick="javascript:shoh('item#location#_#refno#');">#location#<span style="background-color:99CC00">
								<img src="../../../images/u.gif" name="imgitem#location#_#refno#"  align="center"/></span></td>
	                    	<td><input type="checkbox" name="loccheckbox_#refno#_#location#" onClick="checkAll('checkbox','#refno#','#location#');" checked></td>
						</tr>	
						<tr>
							<td></td>
	           				<td></td>
	           				<td></td>
							<td></td>
							<td><cfinclude template="item.cfm"></td>
						</tr>	
					</cfoutput> 
				</cfloop>
			<cfelse>
				<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
						<th>&nbsp;</th>
						<th>&nbsp;</th>
						<th>&nbsp;</th>
						<th>&nbsp;</th>										
					<cfelse>
						<th>Unit Price (FC)</th>
						<th>Total Value (FC)</th>
						<th>Unit Price (LC)</th>
						<th>Total Value (LC)</th>										
					</cfif>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<!--- <cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery> --->
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and (shipped+writeoff) < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='DO' or type='CS' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
				
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty - val(getupdate.writeoff)>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    		<td>#unit#</td>
                    		</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
							<cfif trim(itemno) eq ''>
			          			<!--- Just assign a value, because ColdFusion ignores empty list elements --->
			          			<cfset xitemno = 'YHFTOKCF'>
			        		<cfelse>
			          			<cfset xitemno = itemno>
			        		</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							
							<cfif lcase(hcomid) eq "floprints_i" and husergrpid eq "luser">
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
								<td><div align="right"></div></td>
							<cfelse>
								<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
								<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
								<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
								<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
							</cfif>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
			</cfif>
				<tr>             
          			<td colspan="100%"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		<!--- </cfform> --->
		</form>
        </cfif>
	<cfelseif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Supplier No</th>
					<th>Item No</th>
					<th>Item Description</th>
                    <cfif getdisplaysetup.update_aitemno eq 'Y'>
                    <th>#getgsetup.laitemno#</th>
                    </cfif>
                    <cfif getdisplaysetup.update_supplier eq 'Y'>
                    <th>Supp</th>
                    </cfif>
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
				
						<cfif getupdate.recordcount gt 0>
							<cfset order = getupdate.qty>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
							<cfif trim(itemno) eq ''>
			          			<!--- Just assign a value, because ColdFusion ignores empty list elements --->
			          			<cfset xitemno = 'YHFTOKCF'>
			        		<cfelse>
			          			<cfset xitemno = itemno>
			        		</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<!--- Coding here is for update to Purchase Order --->
	<!--- t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfif url.t1 eq "PO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
        		<cfoutput> 
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
                    <cfif lcase(HcomID) eq "bestform_i">
                    <th>#getgsetup.lproject#</th>
                    </cfif>
            		<th>Item Description</th>
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
            		<th>Qty Order</th>
            		<th>Qty Outstanding</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
            		<th>To Bill</th>
            		<!--- <th>Qty To Fulfill</th>  --->
                    <cfif getpin2.h1360 eq 'T'>
            		<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>
                    </cfif>
            		<th>User</th>
          		</tr>
        		</cfoutput> 
        		
				<cfloop from="1" to="#cnt#" index="i" step="+1">
          			<!--- <cfquery datasource="#dts#" name="getupdate">
          				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and 
						type = '#t1#' and shipped < qty order by trancode 
          			</cfquery> --->
			
					<cfquery datasource="#dts#" name="getupdate">
          				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and 
						type = '#t1#' and (shipped+writeoff) < qty order by trancode 
          			</cfquery>
          			
					<cfoutput query="getupdate"> 
            			<cfquery datasource="#dts#" name="getupqty">
           	 				select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           	 				and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' 
							and frtrancode = '#getupdate.trancode#' 
            			</cfquery>
            			
						<cfif getupqty.sumqty neq "">
              				<cfset upqty = getupqty.sumqty>
              			<cfelse>
              				<cfset upqty = 0>
            			</cfif>

            			<cfif getupdate.recordcount gt 0>
              				<cfset order = getupdate.qty - val(getupdate.writeoff)>
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
                            <cfif lcase(HcomID) eq "bestform_i">
                            <td>#source#</td>
                            </cfif>
              				<td nowrap>#desp#</td>
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
             	 			<td><div align="center">#QTY#</div></td>
              				<td><div align="center">#qtytoful#</div></td>
              				<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
              				
							<cfif trim(itemno) eq ''>
                				<!--- Just assign a value, because ColdFusion ignores empty list elements --->
                				<cfset xitemno = 'YHFTOKCF'>
                			<cfelse>
                				<cfset xitemno = itemno>
              				</cfif>
              				
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
                            <cfif getpin2.h1360 eq 'T'>
              				<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
              				<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
              				<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
              				<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
              				</cfif>
							<cfquery name="getid" datasource="#dts#">
              					select userid from artran where refno = '#refno#' 
              				</cfquery>
              				
							<td>#getid.userid#</td>
            			</tr>
					</cfoutput>
				</cfloop>
				<tr> 
          			<td colspan="5"> <div align="center"> 
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
              			<input type="reset" name="Submit2" value="Reset">
              			<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
    
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>					
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>					
        			<th>User</th>
				</tr>
				</cfoutput> 
                
				<cfloop from="1" to="#cnt#" index="i" step="+1">
                <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
						Select * from ictranmat where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
					</cfquery>
                <cfelse>
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
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
							<cfset order = getupdate.qty>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    		<td>#unit#</td>
                    		</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							
							<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
								<cfset xitemno = 'YHFTOKCF'>
							<cfelse>
								<cfset xitemno = itemno>
							</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
							<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
							
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'
							</cfquery>
							
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
    
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
    <cfif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Purchase Requisition No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>					
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>					
        			<th>User</th>
				</tr>
				</cfoutput> 
                
				<cfloop from="1" to="#cnt#" index="i" step="+1">
                <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
						Select * from ictranmat where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
					</cfquery>
                <cfelse>
                <cfif isdefined('form.remarks')>
                <cfquery datasource="#dts#" name="updaterem11">
						update artran set rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remarks#"> where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
					</cfquery>
                </cfif>
                
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
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
							<cfset order = getupdate.qty>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    		<td>#unit#</td>
                    		</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							
							<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
								<cfset xitemno = 'YHFTOKCF'>
							<cfelse>
								<cfset xitemno = itemno>
							</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
							<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
							
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'
							</cfquery>
							
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<!--- Coding here is for update to PO --->
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO" or url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Order</th>
					<th>Qty Outstanding</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>					
          			<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>					
        			<th>User</th>
				</tr>
				</cfoutput> 
                
				<cfloop from="1" to="#cnt#" index="i" step="+1">
                <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
                <input type="hidden" name="updatemat" id="updatemat" value="1">
                <cfquery datasource="#dts#" name="getupdate">
						Select * from ictranmat where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
					</cfquery>
                <cfelse>
					<cfquery datasource="#dts#" name="getupdate">
						Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
						and exported = '' <cfif getgsetup.updatetopo neq 'Y'>and toinv = ''</cfif> order by refno
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
							<cfset order = getupdate.qty>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    		<td>#unit#</td>
                    		</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
							
							<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
								<cfset xitemno = 'YHFTOKCF'>
							<cfelse>
								<cfset xitemno = itemno>
							</cfif>
							
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
							<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
							<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
							
							<cfquery name="getid" datasource="#dts#">
								select userid from artran where refno = '#refno#'
							</cfquery>
							
							<td>#getid.userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             			<input type="submit" name="Submit" value="Submit"></div>
					</td>
          		</tr>
			</table>
		</cfform>
	</cfif>
<!--- t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ --->
	<cfif url.t1 eq "RQ">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
        		<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
            		<th>Qty Order</th>
            		<th>Qty Outstanding</th>
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>
            		<th>To Bill</th>
            		<!--- <th>Qty To Fulfill</th>  --->
                    <cfif getpin2.h1360 eq 'T'>
            		<th>Unit Price (FC)</th>
            		<th>Total Value (FC)</th>
            		<th>Unit Price (LC)</th>
            		<th>Total Value (LC)</th>
                    </cfif>
            		<th>User</th>
          		</tr>
        		</cfoutput> 
        		
				<cfloop from="1" to="#cnt#" index="i" step="+1">
          			<!--- <cfquery datasource="#dts#" name="getupdate">
          				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and 
						type = '#t1#' and shipped < qty order by trancode 
          			</cfquery> --->
			
					<cfquery datasource="#dts#" name="getupdate">
          				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and 
						type = '#t1#' and toinv = '' order by trancode 
          			</cfquery>
          			
					<cfoutput query="getupdate"> 
            			<cfquery datasource="#dts#" name="getupqty">
           	 				select sum(qty)as sumqty from iclink where frrefno = '#getupdate.refno#' 
           	 				and frtype = '#t1#' and type = '#t2#' and itemno = '#getupdate.itemno#' 
							and frtrancode = '#getupdate.trancode#' 
            			</cfquery>
            			
						<cfif getupqty.sumqty neq "">
              				<cfset upqty = getupqty.sumqty>
              			<cfelse>
              				<cfset upqty = 0>
            			</cfif>

            			<cfif getupdate.recordcount gt 0>
              				<cfset order = getupdate.qty - val(getupdate.writeoff)>
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
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
             	 			<td><div align="center">#QTY#</div></td>
              				<td><div align="center">#qtytoful#</div></td>
              				<cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<input type="hidden" name="qtytoful" value="#qtytoful#">
              				
							<cfif trim(itemno) eq ''>
                				<!--- Just assign a value, because ColdFusion ignores empty list elements --->
                				<cfset xitemno = 'YHFTOKCF'>
                			<cfelse>
                				<cfset xitemno = itemno>
              				</cfif>
              				
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
                            <cfif getpin2.h1360 eq 'T'>
              				<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
              				<td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
              				<td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
              				<td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
              				</cfif>
							<cfquery name="getid" datasource="#dts#">
              					select userid from artran where refno = '#refno#' 
              				</cfquery>
              				
							<td>#getid.userid#</td>
            			</tr>
					</cfoutput>
				</cfloop>
				<tr> 
          			<td colspan="5"> <div align="center"> 
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
              			<input type="reset" name="Submit2" value="Reset">
              			<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
	</cfif>
    
    
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Sales Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
                
                <cfif isdefined('form.remarks')>
                <cfquery datasource="#dts#" name="updaterem11">
						update artran set rem11=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remarks#"> where refno = '#listgetat(mylist,i,";")#' and type = '#t1#' 
					</cfquery>
                </cfif>
                
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='SO' or type='CS' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
						<cfset order = getupdate.qty>
						<cfset qtytoful = order - upqty>
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
						
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
						<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
							<cfset xitemno = 'YHFTOKCF'>
						<cfelse>
							<cfset xitemno = itemno>
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
							<td nowrap>#desp#</td>
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<cfif getdisplaysetup.update_unit eq 'Y'>
                    		<td>#unit#</td>
                    		</cfif>
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
        <!---- ------>
        <cfelseif url.t1 eq "SAM">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last Sales Order No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='SO' or type='CS' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
						<cfset order = getupdate.qty>
						<cfset qtytoful = order - upqty>
						
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                        
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
						<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
							<cfset xitemno = 'YHFTOKCF'>
						<cfelse>
							<cfset xitemno = itemno>
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
							<td nowrap>#desp#</td>
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
                            <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
        
	</cfif>
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last #gettranname.lCS# No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='SO' or type='CS' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
						<cfset order = getupdate.qty>
						<cfset qtytoful = order - upqty>
						
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>

                        
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
						<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
							<cfset xitemno = 'YHFTOKCF'>
						<cfelse>
							<cfset xitemno = itemno>
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
							<td nowrap>#desp#</td>
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
                            <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
						<input type="reset" name="Submit2" value="Reset">
             		 	<input type="submit" name="Submit" value="Submit"></div>
					</td>
				</tr>
			</table>
		</cfform>
        
        <cfelseif url.t1 eq "SO">
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last #gettranname.lCS# No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
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
                    <cfif getdisplaysetup.update_location eq 'Y'>
                    <th>location</th>
                    </cfif>
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
                    <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                    <th>Qty On Hand</th>
                    </cfif>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>	
                    <cfif getdisplaysetup.update_unit eq 'Y'>
                    <th>Unit</th>
                    </cfif>				
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='SO' or type='CS' or type='DO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
						<cfset order = getupdate.qty>
						<cfset qtytoful = order - upqty>
						
                        <cfquery name="getproductcode" datasource="#dts#">
                            select aitemno,supp from icitem where itemno='#itemno#'
                            </cfquery>
                        
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
						<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
							<cfset xitemno = 'YHFTOKCF'>
						<cfelse>
							<cfset xitemno = itemno>
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
							<td nowrap>#desp#</td>
                            <cfif getdisplaysetup.update_location eq 'Y'>
                    	<td>#location#</td>
                    	</cfif>
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
                        <cfif getdisplaysetup.update_qtyonhand eq 'Y'>
                        <cfif location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
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
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
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
                        <td><div align="center">#getitemqtyonhand.balance#</div></td>
                        </cfif>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
                            <cfif getdisplaysetup.update_unit eq 'Y'>
                    	<td>#unit#</td>
                    	</cfif>
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
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
		
		<cfform action="update2a.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage" onsubmit="return validate();">
        <cfset session.formName="updatepage">
			<cfoutput><p>Last #gettranname.lQUO# No : <font size="2">#getGeneralInfo.tranno#</font></p></cfoutput>
			
			<table class="data" align="center">
				<cfoutput> 
				<tr> 
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>Item No</th>
                    
					<th>Item Description</th>
					<th>Qty Bill</th>
					<th>Qty Outstanding</th>					
          			<th>To Bill</th>
					<th>User</th>
				</tr>
				</cfoutput> 
				
				<cfloop from="1" to="#cnt#" index="i">
					<cfquery datasource="#dts#" name="getupdate">
						Select i.*,a.userid from ictran i
						left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
						where i.refno='#listgetat(mylist,i,";")#' and i.type='#t1#' and shipped < qty order by trancode
					</cfquery>
					
					<cfoutput query="getupdate">
						<cfquery datasource="#dts#" name="getupqty">
            				select if((sum(qty)='' or sum(qty) is null),0,sum(qty)) as sumqty 
							from iclink 
							where frrefno='#getupdate.refno#' 
           		 			and frtype='#t1#' and (type='INV' or type='SO' or type='CS' or type='DO' or type = 'QUO') and itemno='#getupdate.itemno#' 
							and frtrancode='#getupdate.trancode#'
            			</cfquery>
						
              			<cfset upqty = getupqty.sumqty>
						<cfset order = getupdate.qty>
						<cfset qtytoful = order - upqty>
						
						<input type="hidden" name="qtytoful" value="#qtytoful#">
                    		
						<cfif trim(itemno) eq ''>
							<!--- Just assign a value, because ColdFusion ignores empty list elements --->
							<cfset xitemno = 'YHFTOKCF'>
						<cfelse>
							<cfset xitemno = itemno>
						</cfif>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            				<td>#refno#</td>
           					<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           					<td>#custno#</td>
							<td>#itemno#</td>
							<td nowrap>#desp#</td>
							<td><div align="center">#QTY#</div></td>					
							<td><div align="center">#qtytoful#</div></td>
							<td><input type="checkbox" name="checkbox" id="checkbox" value=";#refno#;#convertquote(xitemno)#;#trancode#"></td>
							<td>#userid#</td>
						</tr>
					</cfoutput> 
				</cfloop>
				<tr>             
          			<td colspan="5"> <div align="center">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
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