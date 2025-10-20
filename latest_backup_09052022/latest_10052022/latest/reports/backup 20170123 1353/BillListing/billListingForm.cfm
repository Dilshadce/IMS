<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "664,188,665,666,689,667,185,690,668,673,674,1067,1068,1069,1350,1073,1072,5,1352,1353,104,1354,1355,29,1387,1388,1302,1417,1418,482,499,500,506,1389,1390,475,1391,1392,1375,1376,1377,146,497,498,88,1419,1420,1421,1422,1423,703,1361,1362,1300,1301,688,1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,501,1399,1435,702">
<cfinclude template="/latest/words.cfm">
<cfset consignment=''>
<cfif url.target EQ "type1">
	<cfset pageTitle = "#words[664]#">
	<cfset trantype = "Purchase Receive">
	<cfset trancode = "RC">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle = "#words[188]#">
	<cfset trantype = "Purchase Return">
	<cfset trancode = "PR">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle = "#words[665]#">
	<cfset trantype = "Delivery Order">
	<cfset trancode = "DO">    

<cfelseif url.target EQ "type4">
	<cfset pageTitle = "#words[666]#">
	<cfset trantype = "Invoice">
	<cfset trancode = "INV">  

<cfelseif url.target EQ "type5">
	<cfset pageTitle = "#words[689]#">
	<cfset trantype = "Credit Note">
	<cfset trancode = "CN">  

<cfelseif url.target EQ "type6">
	<cfset pageTitle = "#words[667]#">
	<cfset trantype = "Debit Note">
	<cfset trancode = "DN">   

<cfelseif url.target EQ "type7">
	<cfset pageTitle = "#words[185]#">
	<cfset trantype = "Cash Sales">
	<cfset trancode = "CS">   

<cfelseif url.target EQ "type8">
	<cfset pageTitle = "#words[690]#">
	<cfset trantype = "Purchase Order">
	<cfset trancode = "PO">   

<cfelseif url.target EQ "type9">
	<cfset pageTitle = "#words[668]#">
	<cfset trantype = "Quotation">
	<cfset trancode = "QUO"> 

<cfelseif url.target EQ "type10">
	<cfset pageTitle = "#words[673]#">
	<cfset trantype = "Sales Order">
	<cfset trancode = "SO"> 
	
<cfelseif url.target EQ "type11">
	<cfset pageTitle = "#words[674]#">
	<cfset trantype = "Sample">
	<cfset trancode = "SAM">   

<cfelseif url.target EQ "type12">
	<cfset pageTitle = "#words[1067]#">
	<cfset trantype = "Issue">
	<cfset trancode = "ISS"> 

<cfelseif url.target EQ "type13">
	<cfset pageTitle = "#words[1068]#">
	<cfset trantype = "Adjustment Increase">
	<cfset trancode = "OAI">

<cfelseif url.target EQ "type14">
	<cfset pageTitle = "#words[1069]#">
	<cfset trantype = "Adjustment Reduce">
	<cfset trancode = "OAR">

<cfelseif url.target EQ "type15">
	<cfset pageTitle = "#words[1350]#">
	<cfset trantype = "Transfer Note">
	<cfset trancode = "TR">

<cfelseif url.target EQ "type16">
	<cfset pageTitle = "#words[1073]#">
	<cfset trantype = "Consignment Return">
	<cfset trancode = "TR">
 	<cfset consignment='return'>

<cfelseif url.target EQ "type17">
	<cfset pageTitle = "#words[1072]#">
	<cfset trantype = "Consignment Out">
	<cfset trancode = "TR">
	<cfset consignment='out'>
</cfif>

<cfset target = trancode>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * 
    FROM gsetup
</cfquery>

<cfset c_Period = getgsetup.Period>

<cfparam name="alown" default="0">

<cfif getpin2.h4700 eq 'T'>
	<cfset alown = 1>
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

	<cfinclude template="/latest/filter/filterCustomer.cfm">
    <cfinclude template="/latest/filter/filterSupplier.cfm">
    <cfinclude template="/latest/filter/filterAgent.cfm">
	<cfinclude template="/latest/filter/filterProduct.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterProject.cfm">
    <cfinclude template="/latest/filter/filterReferenceNo.cfm">
    <cfinclude template="/latest/filter/filterDriver.cfm">
    <cfinclude template="/latest/filter/filterAddress.cfm">
    <cfinclude template="/latest/filter/filterJob.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form3Button" name="billListingForm" id="billListingForm" action="bill_listingreport1.cfm?type=#trantype#&trancode=#trancode#&alown=#alown#&consignment=#consignment#" method="post" target="_blank">
        <div>#pageTitle#</div>
        <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >

            <cfif trancode eq "INV" or trancode eq "CN" or trancode eq "DN" or trancode eq "CS" or trancode eq "QUO" or trancode eq "SO" or trancode eq "DO">
				<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
			<cfelse>
				<input type="hidden" name="tran" id="tran" value="#target_apvend#" />
			</cfif>
            <cfif url.target NEQ "type1" AND url.target NEQ "type2" AND url.target NEQ "type8" AND url.target NEQ "type13" AND url.target NEQ "type14">
                <tr> 
                    <th><label for="customer">#words[5]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="#words[1352]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="#words[1353]#" />
                    </td>
                </tr>
                <cfset title = "Customer">
            <cfelse>    
                <tr> 
                    <th><label for="supplier">#words[104]#</label></th>			
                    <td>
                        <input type="hidden" id="customerFrom" name="customerFrom" class="supplierFilter" data-placeholder="#words[1354]#" />
                        <input type="hidden" id="customerTo" name="customerTo" class="supplierFilter" data-placeholder="#words[1355]#" />
                    </td>
                </tr>
                <cfset title = "Supplier">
            </cfif>    
            <tr> 
                <th><label for="agent">#words[29]#</label></th>			
                <td>
                    <input type="hidden" id="agentFrom" name="agentFrom" class="agentFilter" data-placeholder="#words[1387]#" />
                    <input type="hidden" id="agentTo" name="agentTo" class="agentFilter" data-placeholder="#words[1388]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="product">#words[1302]#</label></th>			
                <td>
                    <input type="hidden" id="productFrom" name="productFrom" class="productFilter" data-placeholder="#words[1417]#" />
                    <input type="hidden" id="productTo" name="productTo" class="productFilter" data-placeholder="#words[1418]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="location">#words[482]#</label></th>			
                <td>
                    <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="#words[499]#" />
                    <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="#words[500]#" />
                </td>
            </tr>
			<tr> 
                <th><label for="project">#words[506]#</label></th>			
                <td>
                    <input type="hidden" id="projectFrom" name="projectFrom" class="projectFilter" data-placeholder="#words[1389]#" />
                    <input type="hidden" id="projectTo" name="projectTo" class="projectFilter" data-placeholder="#words[1390]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="job">#words[475]#</label></th>			
                <td>
                    <input type="hidden" id="jobFrom" name="jobFrom" class="jobFilter" data-placeholder="#words[1391]#" />
                    <input type="hidden" id="jobTo" name="jobTo" class="jobFilter" data-placeholder="#words[1392]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="refNo">#words[1375]#</label></th>			
                <td>
                    <input type="hidden" id="refNoFrom" name="refNoFrom" class="referenceNoFilter" data-placeholder="#words[1376]#" />
                    <input type="hidden" id="refNoTo" name="refNoTo" class="referenceNoFilter" data-placeholder="#words[1377]#" />
                </td>
            </tr>
                <th><label for="group">#words[146]#</label></th>			
                <td>
                    <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="#words[497]#" />
                    <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" data-placeholder="#words[498]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="driver">#words[88]#</label></th>			
                <td>
                    <input type="hidden" id="driverFrom" name="driverFrom" class="driverFilter" data-placeholder="#words[1419]#" />
                    <input type="hidden" id="driverTo" name="driverTo" class="driverFilter" data-placeholder="#words[1420]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="dAddress">#words[1421]#</label></th>			
                <td>
                    <input type="hidden" id="dAddressFrom" name="dAddressFrom" class="addressFilter" data-placeholder="#words[1422]#" />
                    <input type="hidden" id="dAddressTo" name="dAddressTo" class="addressFilter" data-placeholder="#words[1423]#" />
                </td>
            </tr>
            <tr> 
                <th><label for="period">#words[703]#</label></th>			
                <td>
                    <select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1361]#</option>
                          <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                              <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                              <cfset fdmont = dateformat(fccurr,"mm")>
                              <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                              <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                          </cfloop>
                    </select>
                    <select name="periodTo" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">#words[1362]#</option>
                        <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                            <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                            <cfset fdmont = dateformat(fccurr,"mm")>
                            <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                            <cfset fnow = dateformat(now(),"mmmm ''yyyy")>
                            <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fnow eq fdmont2>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                        </cfloop>
                    </select>
                </td>
            </tr>
            <cfif lcase(hcomid) eq "neohmobile_i">
            <tr>
            	<th>Tax</th>
                <td>
                <select name="taxbilltype" id="taxbilltype">
                <option value="">All Bills</option>
                <option value="taxincluded">Tax Included Bills Only</option>
                <option value="taxexcluded">Tax Excluded Bills Only</option>
                </select>
                </td>
            </tr>
            </cfif>
            <cfif url.target eq "type15" and (lcase(hcomid) eq "centraltruss_i"  or lcase(hcomid) eq "demoindo_i" or lcase(hcomid) eq "amgworld_i")>
            <tr>
            	<th><label for="transferstatus">Transfer Status</label></th>
                <td>
                <select name="transferstatus" id="transferstatus">
                <option value="">All Bills</option>
                <option value="Order Pending">Order Pending Bills Only</option>
                <option value="In transit">In transit Bills Only</option>
                </select>
                </td>
            </tr>
            </cfif>
            <tr> 
                <th><label for="date">#words[702]#</label></th>			
                <td>
					<input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="#words[1300]#" readonly="readonly" />
					<input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="#words[1301]#" readonly="readonly" />
                </td>
			</tr>
            <tr>
				<th><label>#words[688]#</label></th>
                <td>
                    <div><input type="checkbox" name="checkbox1" value="checkbox1"> #words[1424]#</div>
                    <div><input type="checkbox" name="checkbox2" value="checkbox2"> #words[1425]#</div>
                    <div><input type="checkbox" name="checkbox3" value="checkbox3"> #words[1426]#</div>
                </td>
			</tr>
            <tr>
            	<th></th>
                <td>
                	<div><input type="checkbox" name="cbso" value="cbso"> #words[1427]#</div>
                    <div><input type="checkbox" name="cbproject" value="cbproject"> #words[1428]#</div>
                    <div><input type="checkbox" name="cbjob" value="cbjob"> #words[1429]#</div>
                </td>
            </tr>
            <tr>
            	<th></th>
                <td>
                	<div><input type="checkbox" name="cbgst" value="cbgst"> #words[1430]#</div>
                    <div><input type="checkbox" id="checkbox4" name="checkbox4" value="checkbox4"> #words[1431]#</div>
                    <div><input type="checkbox" name="cbagent" value="cbagent"> #words[1432]#</div>
                </td>
            </tr>
             <tr>
            	<th></th>
                <td>
                	<div><input type="checkbox" name="cbdetail" value="cbdetail"/> #words[1433]#</div>
                    <div><input type="checkbox" name="cbdate" value="cbdate" /> #words[1434]#</div>
                </td>
            </tr>
           
        </table>
        </div>
        <input type="hidden" name="title" id="title" value="#title#" />
        <div>
            <input type="Submit" name="result" id="result" value="#words[501]#"  />
            <input type="Submit" name="result" id="result" value="#words[1399]#"  />
            <input type="Submit" name="result" id="result" value="#words[1435]#"  />
        </div>
    </cfform>
</cfoutput>
</body>
</html>