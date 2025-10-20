<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../../scripts/collapse_expand_single_item.js"></script>

<script type="text/javascript">
function checkAll(id,location){
	
	var locid='loc'+id+'_'+location;
	var thisid=id+'_'+location;
	
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

function validate(){
	var inputs = document.getElementsByTagName('input');
	//var checkboxes = [];
	for (var i = 0; i < inputs.length; i++) {
	
		if (inputs[i].type == 'checkbox' && inputs[i].checked == true) {
	    	return true;
	    	break;
		}
	}
	return false;
}
</script>
</head>

<cfparam name="fulfill" default="">
<cfparam name="counter" default="">
<cfparam name="fr_type" default="">
<cfparam name="ft_type" default="">
<cfparam name="fr_refno" default="">
<cfparam name="nextrefno" default="">
<cfparam name="bylocation" default="">
<cfparam name="f_cdate" default="">
<cfparam name="updatecheckall" default="1">

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>
<!--- fr_type: From Type; ft_type: To Type --->
<!--- FROM DO --->
<cfif fr_type eq "DO">
	<cfset updateFromType="Delivery Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV">
	    <cfset msg1="and (shipped+writeoff) < qty">
	</cfif>
<!--- FROM SO --->
<cfelseif fr_type eq "SO">
	<cfset updateFromType="Sales Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	<!--- TO DO --->
	<cfelseif ft_type eq "DO">
		<cfset updateToType="Delivery Order">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	<!--- TO PO --->
	<cfelseif ft_type eq "PO">
		<cfset updateToType="Purchase Order">
	    <cfset tt_type="PO">
	    <cfset msg1="and a.exported = '' and a.toinv = ''">
	</cfif>
<!--- FROM PO --->
<cfelseif fr_type eq "PO">
	<cfset updateFromType="Purchase Order">
	<!--- TO RC --->
	<cfif ft_type eq "RC">
		<cfset updateToType="Purchase Receive">
	    <cfset tt_type="RC">
	    <cfset msg1="and (shipped+writeoff) < qty">
	</cfif>
<!--- FROM QUO --->
<cfelseif fr_type eq "QUO">
	<cfset updateFromType="Quotation">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	<cfelseif ft_type eq "SO">
		<cfset updateToType="Sales Order">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	</cfif>
</cfif>

<!--- <cfif ft_type eq "INV">
	<cfset updateToType="Invoice">
    <cfset tt_type="INV,DO">
<cfelseif ft_type eq "DO">
	<cfset updateToType="Delivery Order">
    <cfset tt_type="INV,DO">
<cfelseif ft_type eq "SO">
	<cfset updateToType="Sales Order">
    <cfset tt_type="SO">
<cfelseif ft_type eq "RC">
	<cfset updateToType="Purchase Receive">
    <cfset tt_type="RC">
<cfelseif ft_type eq "PO">
	<cfset updateToType="Purchase Order">
     <cfset tt_type="PO">
</cfif> --->

<cfoutput><h1>Update to #updateToType#</h1></cfoutput>
<body>

<form action="update2.cfm" method="post" name="updatepage">
	<cfoutput>
        <input type="hidden" name="counter" value="#counter#">
        <input type="hidden" name="fr_type" value="#fr_type#">
        <input type="hidden" name="fr_refno" value="#fr_refno#">
        <input type="hidden" name="f_cdate" value="#f_cdate#">
        <input type="hidden" name="ft_type" value="#ft_type#">
        <input type="hidden" name="nextrefno" value="#nextrefno#">
		<input type="hidden" name="bylocation" value="#bylocation#">
        <p>#updateToType# No : <font size="2">#nextrefno#</font></p>
    </cfoutput>
    <table class="data" align="center">
    <cfif bylocation eq "Y">
    	<tr> 
            <th><cfoutput>#updateFromType#</cfoutput></th>
            <th>Date</th>
            <th>Customer No</th>			
            <th><cfif lcase(hcomid) eq "nikbra_i">Department<cfelse>Location</cfif></th>
            <th>To Bill</th>
        </tr>
    	<cfquery datasource="#dts#" name="getlocation">
			Select type,refno,custno,name,wos_date,location from ictran 
            where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
            and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">  
            #msg1#
			group by location
		</cfquery>
        <cfoutput query="getlocation">
        	<tr> 			 
                <td>#refno#</td>
                <td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
                <td>#custno#</td>
                <td nowrap  onClick="javascript:shoh('item#location#');">#location#<span style="background-color:99CC00">
                    <img src="../../../images/u.gif" name="imgitem#location#" align="center"/></span></td>
                <td><input type="checkbox" name="loccheckbox_#location#" onClick="checkAll('checkbox','#location#');" checked></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td><cfinclude template="item.cfm"></td>
            </tr>		
		</cfoutput>
	<cfelse>
    	<tr> 
            <th><cfoutput>#updateFromType#</cfoutput></th>
            <th>Date</th>
            <th>Customer No</th>
            <th>Item No</th>
            <th>Item Description</th>
            <th>Qty Order</th>
            <th>Qty Outstanding</th>					
            <th>To Bill</th>
            <th>Unit Price (FC)</th>
            <th>Total Value (FC)</th>
            <th>Unit Price (LC)</th>
            <th>Total Value (LC)</th>					
            <th>User</th>
        </tr>
        <cfquery datasource="#dts#" name="getupdate">
            Select a.*,b.userid from ictran a,artran b
            where a.type=b.type and a.refno=b.refno 
            and a.refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
            and a.type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
            #msg1#
            order by a.trancode 
        </cfquery>
        
        <cfoutput query="getupdate">
            <cfquery datasource="#dts#" name="getupqty">
                select sum(qty)as sumqty from iclink where frrefno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
                and frtype =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#"> 
                and type in (#ListQualify(tt_type,"'")#) and itemno = '#getupdate.itemno#' and frtrancode = '#getupdate.trancode#'
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
            <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 			 
                <td>#refno#</td>
                <td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
                <td>#custno#</td>
                <td>#itemno#</td>
                <td nowrap>#desp#</td>
                <td><div align="center">#QTY#</div></td>					
                <td><div align="center">#qtytoful#</div></td>
                
                <input type="hidden" name="qtytoful" value="#qtytoful#">
                
                <cfif trim(itemno) eq ''>
                    <!--- Just assign a value, because ColdFusion ignores empty list elements --->
                    <cfset xitemno = 'YHFTOKCF'>
                <cfelse>
                    <cfset xitemno = itemno>
                </cfif>
                
                <td><input type="checkbox" name="checkbox" value=";#convertquote(xitemno)#;#trancode#"<cfif updatecheckall eq "1"> checked</cfif>></td>
                <td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
                <td><div align="right">#numberformat(amt1_bil,"__,___.__")#</div></td>
                <td><div align="right">#numberformat(price,"__,___" & stDecl_UPrice)#</div></td>
                <td><div align="right">#numberformat(amt1,"__,___.__")#</div></td>
                <td>#userid#</td>
            </tr>			
		</cfoutput> 
	</cfif>
	<tr>             
    	<td colspan="100%"><div align="right">
			<input type="reset" name="Submit2" value="Reset">
            <input type="submit" name="Submit" value="Submit" onClick="return validate();"></div>
		</td>
	</tr>
	</table>
</form>

</body>
</html>