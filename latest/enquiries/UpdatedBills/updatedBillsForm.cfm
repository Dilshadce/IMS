<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1400,1385,668,1401,1402,5,681,104,156,688,880,881,352,1111">
<cfinclude template="/latest/words.cfm">
<cfif url.target EQ "type1">
	<cfset pageTitle="#words[1400]#">
    <cfset frtype="SO">
    <cfset totype="INV">

<cfelseif url.target EQ "type2">
	<cfset pageTitle="#words[1400]#">
    <cfset frtype="SO">
    <cfset totype="CS">

<cfelseif url.target EQ "type3">
	<cfset pageTitle="#words[1385]#">
    <cfset frtype="SO">
    <cfset totype="PO">
    
<cfelseif url.target EQ "type4">
	<cfset pageTitle="#words[668]#">    
    <cfset frtype="QUO">
    <cfset totype="">

<cfelseif url.target EQ "type5">
	<cfset pageTitle="#words[1401]#">    
    <cfset frtype="PO">
    <cfset totype="RC">    
    
<cfelseif url.target EQ "type6">
	<cfset pageTitle="#words[1402]#">    
    <cfset frtype="DO">
    <cfset totype="INV">      
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script language="javascript">
		function validation(){			
			if(document.updatedBills.customerNo.value == '') {
				alert("Choose a customer or supplier!");
				return false;	
			}
			return true;		
		}
	</script>
	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="updatedBills" id="updatedBills" action="updatedbill_result.cfm?frtype=#frtype#&totype=#totype#" method="post" target="_blank" onSubmit="return validation();">
        <div>#pageTitle#</div>
        <div>
        <table> 
        	<input type="hidden" name="frtype" value="#frtype#">
			<input type="hidden" name="totype" value="#totype#">
            <cfif url.target NEQ "type5">
                <tr> 
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerNo" name="customerNo" class="customerFilter" data-placeholder="#words[681]#"/>
                    </td>
                </tr>
            <cfelse>
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="customerNo" name="customerNo" class="supplierFilter" data-placeholder="#words[156]#" />
                    </td>
                </tr>
			</cfif>
            <tr>
				<th><label>#words[688]#</label></th>
                <td>
                    <div> <input type="checkbox" name="cbcust" value="checkbox"><cfif url.target NEQ "type5">#words[880]#<cfelse>#words[881]#</cfif></div>
                </td>
			</tr> 
        </table>
        </div>
        <div>
            <input type="Submit" name="Submit" value="#words[352]#">
            <input type="button" name="Back" value="#words[1111]#" onclick="history.go(-1);">
        </div>
    </cfform>
</cfoutput>
</body>
</html>