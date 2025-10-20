<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup;
</cfquery>
<cfset c_Period = getgsetup.Period>
<cfset pageTitle = "View Audit Trail">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>#pageTitle#</title>
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

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="auditTrail" id="auditTrail" action="report1.cfm" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
            <table> 
                <tr>
                    <th><label for="billType">Type</label></th>			
                    <td>
                        <select id="billType" name="billType">
                            <option value="">Choose a Bill Type</option>	 	                             
                            <option value="PO">Purchase Order</option>	
                            <option value="RC">Purchase Receive</option>
                            <option value="PR">Purchase Return</option>	
                            <option value="QUO">Quotation</option>
                            <option value="SO">Sales Order</option>	
                            <option value="DO">Delivery Order</option>		  	  
                            <option value="INV">Invoice</option>	
                            <option value="CS">Cash Sales</option>	
                            <option value="CN">Credit Note</option>
                            <option value="DN">Debit Note</option>
                            <option value="ISS">Issue</option>	    
                            <option value="OAI">Adjustment Increase</option>
                            <option value="OAR">Adjustment Reduce</option>	
                            <option value="ASSM">Assembly</option>		
                            <option value="TR">Transfer</option>
                            <option value="SAM">Sample</option>	
                            <option value="PQ">Purchase Requisition</option>		
                        </select>
                    </td>
                </tr>
                <tr>
                <th><label for="sortBy">Sort By</label></th>			
                    <td>
                        <select id="sortBy" name="sortBy">
                            <option value="">Sort By</option>	 	  
                            <option value="userid">User ID</option>
                            <option value="wos_date">Date</option>
                            <option value="type">Type</option>
                            <option value="refno">Reference No</option>
                            <option value="updated_on">Last Update</option>  	  
                        </select>
                    </td>
                </tr>
                <tr> 
                    <th><label for="period">Period</label></th>			
                    <td>
                        <select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                            <option value="">[FROM] -- Choose a Period</option>
                              <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                                  <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                                  <cfset fdmont = dateformat(fccurr,"mm")>
                                  <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                                  <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                              </cfloop>
                        </select>
                        <select name="periodTo" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                            <option value="">[TO] -- Choose a Period</option>
                            <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                                <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                                <cfset fdmont = dateformat(fccurr,"mm")>
                                <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                                <cfset fnow = dateformat(now(),"mmmm ''yyyy")>
                                <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fnow eq fdmont2>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                            </cfloop>
                        </select>
                        
                        <div><input type="checkbox" name="include99" value="include99"> Include Period 99</div>
                    </td>
                </tr>
                <tr>
                    <th><label>Other Option(s)</label></th>
                    <td>
                        <div><input type="radio" name="result" value="instock" checked> Transactions in Stock</div>
                        <div><input type="radio" name="result" value="modified"> Transactions Modified</div>
                        <div><input type="radio" name="result" value="deleted"> Deleted Transaction</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="Submit" name="result" id="result" value="HTML">
            <input type="Submit" name="submit" id="submit" value="SUBMIT">
            <input type="Submit" name="submit" id="submit" value="BACK" onclick="history.go(-1);"> 
        </div>
    </cfform>
</cfoutput>
</body>
</html>