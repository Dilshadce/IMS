<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1811, 5, 681, 104, 156, 1302, 1131, 702, 1300, 1301, 688, 1812, 1813, 1814, 1815">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle = "#words[1811]#">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<cfoutput>
    <title>#pageTitle#</title>
    </cfoutput>
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
    <cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    
    <script language="JavaScript" type="text/javascript">
		function showhidediv(rad){
			var rads=document.getElementsByName(rad.name);
			document.getElementById('one').style.display=(rads[0].checked || rads[1].checked)?'table-row':'none' ;
			document.getElementById('two').style.display=(rads[2].checked)?'table-row':'none' ;
			document.getElementById('three').style.display=(rads[3].checked)?'table-row':'none' ;
		}
	</script>

</head>

<body class="container">
<cfoutput>
	<form class="formContainer form3Button" name="auditTrailForm_2" id="auditTrailForm_2" action="report2.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <tr id="one" style="display:table-row;">
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customer" name="customer" class="customerFilter" data-placeholder="#words[681]#" />
                    </td>
                </tr>
                <tr id="two" style="display:none;"> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="supplier" name="supplier" class="supplierFilter" data-placeholder="#words[156]#" />
                    </td>
                </tr>
                <tr id="three" style="display:none;">
                    <th><label for="product">#words[1302]#</label></th>			
                    <td>
                        <input type="hidden" id="product" name="product" class="productFilter" data-placeholder="#words[1131]#" />
                    </td>
                </tr>
            	<tr> 
                    <th><label for="date">#words[702]#</label></th>			
                    <td>
                        <input type="Text" id="dateFrom" name="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
                        <input type="Text" id="dateTo" name="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                    </td>
				</tr>
                <tr>
                    <th><label>#words[688]#</label></th>
                    <td>
                        <div><input type="radio" name="result" value="edited_arcust" onclick="showhidediv(this);" checked="yes"/> #words[1812]#(s)</div>
                        <div><input type="radio" name="result" value="deleted_arcust" onclick="showhidediv(this);"/> #words[1813]#</div>
                    </td>
                </tr>
                <tr>
                    <th><label></label></th>
                    <td>
                        <div><input type="radio" name="result" value="deleted_apvend" onclick="showhidediv(this);"/> #words[1814]#</div>
                        <div><input type="radio" name="result" value="deleted_icitem" onclick="showhidediv(this);"> #words[1815]#</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="SUBMIT">
            <input type="button" name="back" id="back" value="BACK" onclick="history.go(-1);"> 
        </div>
    </form>
</cfoutput>
</body>
</html>