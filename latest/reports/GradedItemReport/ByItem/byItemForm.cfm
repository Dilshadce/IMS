<cfif url.target EQ "type1">
	<cfset pageTitle="Item Physical Worksheet">
	<cfset formAction="report1.cfm">
    
<cfelseif url.target EQ "type2">
	<cfset pageTitle="Item Opening">
	<cfset formAction="report2.cfm">
    
<cfelseif url.target EQ "type3">
	<cfset pageTitle="Item Sales">
	<cfset formAction="report3.cfm"> 

<cfelseif url.target EQ "type4">
	<cfset pageTitle="Item Status">
	<cfset formAction="report4.cfm"> 
                             
<cfelseif url.target EQ "type5">
	<cfset pageTitle="Item Stock Card">
	<cfset formAction="report5.cfm"> 
                             
<cfelseif url.target EQ "type6">
	<cfset pageTitle="Item-Location Opening">
	<cfset formAction="report6.cfm"> 
                             
<cfelseif url.target EQ "type7">
	<cfset pageTitle="Item-Location Sales">
	<cfset formAction="report7.cfm"> 
                             
<cfelseif url.target EQ "type8">
	<cfset pageTitle="Item-Location Status">
	<cfset formAction="report8.cfm"> 

</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT * from gsetup
</cfquery>
<cfset c_Period = getgsetup.Period> 

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

	<cfinclude template="/latest/filter/filterItem.cfm">
    <cfinclude template="/latest/filter/filterGroup.cfm">
    <cfinclude template="/latest/filter/filterLocation.cfm">
    <cfinclude template="/latest/filter/filterCategory.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/latest/date/datePickerFunction2.cfm">
    <cfinclude template="/CFC/LastDayOfMonth.cfm">


</head>

<body class="container">
<cfoutput>
	<cfform class="formContainer form4Button" name="" id="" action="#formAction#" method="post" target="_blank">
        <div>#pageTitle#</div>
      <div>
        <table> 
        
        	<input type="hidden" NAME="tf_fperiodfromDesp" id="tf_fperiodfromDesp" readonly="readonly" />
			<input type="hidden" NAME="tf_fperiodtoDesp" id="tf_fperiodtoDesp" readonly="readonly" />
			<input type="hidden" name="rptdate" id="rptdate" value="" >
			<input type="hidden" name="tf_fperiod" id="tf_fperiod" value="" >
            
        	<tr> 
                <th><label for="item">Item</label></th>			
                <td>
                    <input type="hidden" id="itemFrom" name="itemFrom" class="itemFilter" data-placeholder="[FROM] -- Choose an Item" />
                    <input type="hidden" id="itemTo" name="itemTo" class="itemFilter" data-placeholder="[TO] -- Choose an Item" />
                </td>
            </tr>
            <tr> 
                    <th><label for="category">Category</label></th>			
                    <td>
                        <input type="hidden" id="categoryFrom" name="categoryFrom" class="categoryFilter" data-placeholder="[FROM] -- Choose a Category" />
                        <input type="hidden" id="categoryTo" name="categoryTo" class="categoryFilter" data-placeholder="[TO] -- Choose a Category" />
                    </td>
            </tr>
          	<tr> 
                <th><label for="group">Group</label></th>			
                <td>
                    <input type="hidden" id="groupFrom" name="groupFrom" class="groupFilter" data-placeholder="[FROM] -- Choose a Group" />
                    <input type="hidden" id="groupTo" name="groupTo" class="groupFilter" data-placeholder="[TO] -- Choose a Group" />
                </td>
            </tr>
            <tr> 
                <th><label for="model">Model</label></th>			
                <td>
                    <input type="hidden" id="modelFrom" name="modelFrom" class="modelFilter" data-placeholder="[FROM] -- Choose a Model" />
                    <input type="hidden" id="modelTo" name="modelTo" class="modelFilter" data-placeholder="[TO] -- Choose a Model" />
                </td>
            </tr>
            <tr> 
                <th><label for="location">Location</label></th>			
                <td>
                    <input type="hidden" id="locationFrom" name="locationFrom" class="locationFilter" data-placeholder="[FROM] -- Choose a Location" />
                    <input type="hidden" id="locationTo" name="locationTo" class="locationFilter" data-placeholder="[TO] -- Choose a Location" />
                </td>
            </tr>
		    <tr>
                    <th><label for="">Number of Grade</label></th>			
                    <td>
                    	<select name="">
                            <option value="">6</option>	 	  
                            <option value="">9</option>
                            <option value="">12</option>
                        </select>
                    </td>
            </tr>
            <tr> 
                <th><label for="">Start From Grade</label></th>			
                <td>
                    <input type="text" id="" name="" class="" data-placeholder="1" />
                </td>
            </tr>
            <tr> 
                <th><label for="period">Period</label></th>			
                <td>
                    <select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">Choose a Start Period</option>
                          <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                              <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                              <cfset fdmont = dateformat(fccurr,"mm")>
                              <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                              <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                          </cfloop>
                    </select>
                    <select name="periodTo" id="periodTo" Onchange="tf_fperiodtoDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">Choose an End Period</option>
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
            <tr> 
                <th><label for="period">Period</label></th>			
                <td>
                    <select name="periodFrom" id="periodFrom" Onchange="tf_fperiodfromDesp.value = this.options[this.selectedIndex].title;">
                        <option value="">Choose a Start Period</option>
                          <cfloop index="fCurrMonth" from="1" to="#c_Period#">
                              <cfset fccurr = DateAdd('m', fCurrMonth, "#getgsetup.LastAccYear#")>
                              <cfset fdmont = dateformat(fccurr,"mm")>
                              <cfset fdmont2 = dateformat(fccurr,"mmmm ''yyyy")>
                              <option title="#fdmont2#" value="#numberFormat(fCurrMonth,'00')#"<cfif fcurrmonth eq 1>selected</cfif>>#fCurrMonth# - #dateformat(fccurr,"mmm'yyyy")#</option>
                          </cfloop>
                    </select>
                </td>
            </tr>
  
            <tr> 
                <th><label for="date">Date</label></th>			
                <td>
					<input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="[FROM] -- Choose a Date" readonly="readonly" />
					<input type="Text" name="dateTo" id="dateTo" maxlength="10" size="10" placeholder="[TO] -- Choose a Date" readonly="readonly" />
                </td>
			</tr>
            <tr> 
                <th><label for="date">Date</label></th>			
                <td>
					<input type="Text" name="dateFrom" id="dateFrom" maxlength="10" size="10" placeholder="Choose a Date" readonly="readonly" />
                </td>
			</tr>
            
            <tr>
				<th><label>Report Format(s)</label></th>
                <td>
                    <div><input type="checkbox" name="checkbox1" value=""> WITH QUANTITY</div>
                    <div><input type="checkbox" name="checkbox2" value=""> INCLUDE 0 STOCK</div>
                    <div><input type="checkbox" name="checkbox3" value=""> UPDATE ACTUAL QUANTITY</div>
                </td>
			</tr>
            <tr>
				<th><label></label></th>
                <td>
                    <div><input type="checkbox" name="checkbox1" value=""> SHOW TRANSACTION ITEM ONLY</div>
                </td>
			</tr>
                  </table>
        </div>
        <div>
            <input type="Submit" name="submit" id="submit" value="SUBMIT">
            <input type="Submit" name="result" id="result" value="HTML"  />
            <input type="Submit" name="result" id="result" value="EXCEL"  />
            <input type="button" name="Back" value="BACK" onclick="history.go(-1);">
        </div>
    </cfform>
</cfoutput>
</body>
</html>