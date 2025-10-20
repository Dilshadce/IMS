<cfquery name="getremarkdetail" datasource="#dts#">
	select * 
	from extraremark;
</cfquery>
<cfquery name="getgsetup" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>
<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cftry>
<cfif form.type eq "Create">
        <cfset remark30 = "">
    	<cfset remark31 = "">
    	<cfset remark32 = "">
    	<cfset remark33 = "">
    	<cfset remark34 = "">
    	<cfset remark35 = "">
    	<cfset remark36 = "">
        <cfset remark37 = "">
    	<cfset remark38 = "">
    	<cfset remark39 = "">
    	<cfset remark40 = "">
    	<cfset remark41 = "">
    	<cfset remark42 = "">
    	<cfset remark43 = "">
        <cfset remark44 = "">
    	<cfset remark45 = "">
    	<cfset remark46 = "">
    	<cfset remark47 = "">
    	<cfset remark48 = "">
    	<cfset remark49 = "">
        <cfelse>
         <cfset remark30 = getitem.rem30>
    	<cfset remark31 = getitem.rem31>
    	<cfset remark32 = getitem.rem32>
    	<cfset remark33 = getitem.rem33>
    	<cfset remark34 = getitem.rem34>
    	<cfset remark35 = getitem.rem35>
    	<cfset remark36 = getitem.rem36>
        <cfset remark37 = getitem.rem37>
    	<cfset remark38 = getitem.rem38>
    	<cfset remark39 = getitem.rem39>
    	<cfset remark40 = getitem.rem40>
    	<cfset remark41 = getitem.rem41>
    	<cfset remark42 = getitem.rem42>
    	<cfset remark43 = getitem.rem43>
        <cfset remark44 = getitem.rem44>
    	<cfset remark45 = getitem.rem45>
    	<cfset remark46 = getitem.rem46>
    	<cfset remark47 = getitem.rem47>
    	<cfset remark48 = getitem.rem48>
    	<cfset remark49 = getitem.rem49>
        </cfif>
        <cfcatch>
        <cfset remark30 = getartran.rem30>
    	<cfset remark31 = getartran.rem31>
    	<cfset remark32 = getartran.rem32>
    	<cfset remark33 = getartran.rem33>
    	<cfset remark34 = getartran.rem34>
    	<cfset remark35 = getartran.rem35>
    	<cfset remark36 = getartran.rem36>
        <cfset remark37 = getartran.rem37>
    	<cfset remark38 = getartran.rem38>
    	<cfset remark39 = getartran.rem39>
    	<cfset remark40 = getartran.rem40>
    	<cfset remark41 = getartran.rem41>
    	<cfset remark42 = getartran.rem42>
    	<cfset remark43 = getartran.rem43>
        <cfset remark44 = getartran.rem44>
    	<cfset remark45 = getartran.rem45>
    	<cfset remark46 = getartran.rem46>
    	<cfset remark47 = getartran.rem47>
    	<cfset remark48 = getartran.rem48>
    	<cfset remark49 = getartran.rem49>
        </cfcatch>
        </cftry>
<cfoutput>
  	<table align="left" class="data" width="770">
    <tr>
    <th colspan="4"><div align="center">Add On Remark</div>
    </th>
    <tr>
    <th <cfif getdisplaysetup2.remark30 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem30#</th>
    <td <cfif getdisplaysetup2.remark30 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark30">
         <option value="Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)" <cfif remark30 eq "Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)">selected</cfif>>Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)</option>
         <option value=" " <cfif remark30 eq " ">selected</cfif>></option>
    </select>
    <cfelse>
    <input type="text" name="remark30" value="#remark30#" size="40" maxlength="100">
    </cfif>
    </td>
     <th <cfif getdisplaysetup2.remark31 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem31#</th>
    <td <cfif getdisplaysetup2.remark31 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark31">
         <option value="Singapore Dollars excludes taxes of all kinds" <cfif remark31 eq "Singapore Dollars excludes taxes of all kinds">selected</cfif>>Singapore Dollars excludes taxes of all kinds</option>
         <option value="Burnei Dollars excludes taxes of all kinds" <cfif remark31 eq "Burnei Dollars excludes taxes of all kinds">selected</cfif>>Burnei Dollars excludes taxes of all kinds</option>
         <option value="US Dollars excludes taxes of all kinds" <cfif remark31 eq "US Dollars excludes taxes of all kinds">selected</cfif>>US Dollars excludes taxes of all kinds</option>
         <option value="Euro  Dollars excludes taxes of all kinds" <cfif remark31 eq "Euro  Dollars excludes taxes of all kinds">selected</cfif>>Euro  Dollars excludes taxes of all kinds</option>
         <option value=" " <cfif remark31 eq " ">selected</cfif>></option>
    </select>
    <cfelse>
    <input type="text" name="remark31" value="#remark31#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark32 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem32#</th>
    <td <cfif getdisplaysetup2.remark32 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark32">
		 <option value=" " <cfif remark32 eq " ">selected</cfif>></option>
		 <option value="12 months Warranty  from Date of Delivery" <cfif remark32 eq "12 months Warranty  from Date of Delivery">selected</cfif>>12 months Warranty  from Date of Delivery</option>
         <option value="24 months   Warranty  from Date of Delivery" <cfif remark32 eq "24 months   Warranty  from Date of Delivery">selected</cfif>>24 months   Warranty  from Date of Delivery</option>
         <option value="3 years   Warranty  from Date of Delivery" <cfif remark32 eq "3 years   Warranty  from Date of Delivery">selected</cfif>>3 years   Warranty  from Date of Delivery</option>
         <option value="5  years Warranty  from Date of Delivery" <cfif remark32 eq "5  years Warranty  from Date of Delivery">selected</cfif>>5  years Warranty  from Date of Delivery</option>
         <option value="90 day software and 12 month hardware warranty." <cfif remark32 eq "90 day software and 12 month hardware warranty.">selected</cfif>>90 day software and 12 month hardware warranty.</option>
         
    </select>
    <cfelse>
    <input type="text" name="remark32" value="#remark32#" size="40" maxlength="100">
    </cfif>
    </td>
     <th <cfif getdisplaysetup2.remark33 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem33#</th>
    <td <cfif getdisplaysetup2.remark33 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark33">
         <option value="Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery." <cfif remark33 eq "Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery.">selected</cfif>>Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery.</option>
	<option value="Self Collect" <cfif remark33 eq "Self Collect">selected</cfif>>Self Collect</option>
	<option value=" " <cfif remark33 eq " ">selected</cfif>></option>
    </select>
    <cfelse>
    <input type="text" name="remark33" value="#remark33#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark34 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem34#</th>
    <td <cfif getdisplaysetup2.remark34 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark34">
         <option value="" <cfif remark34 eq "">selected</cfif>></option>
         <option value="Does not include any installation services and training." <cfif remark34 eq "Does not include any installation services and training.">selected</cfif>>Does not include any installation services and training.</option>
    </select>
    <cfelse>
    <input type="text" name="remark34" value="#remark34#" size="40" maxlength="100">
    </cfif></td>
     <th <cfif getdisplaysetup2.remark35 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem35#</th>
    <td <cfif getdisplaysetup2.remark35 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark35">
         <option value="" <cfif remark35 eq "">selected</cfif>></option>
         <option value="Does not include any cables and peripherals unless stated." <cfif remark35 eq "Does not include any cables and peripherals unless stated.">selected</cfif>>Does not include any cables and peripherals unless stated.</option>
    </select>
    <cfelse>
    <input type="text" name="remark35" value="#remark35#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark36 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem36#</th>
    <td <cfif getdisplaysetup2.remark36 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i">
    <select name="remark36">
         <option value="Email" <cfif remark36 eq "Email">selected</cfif>>Email</option>
         <option value="Verbal" <cfif remark36 eq "Verbal">selected</cfif>>Verbal</option>
	 <option value="" <cfif remark36 eq "">selected</cfif>></option>
    </select>
    
    <cfelse>
<input type="text" name="remark36" value="#remark36#" size="40" maxlength="100">
	</cfif>
</td>
     <th <cfif getdisplaysetup2.remark37 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem37#</th>
    <td <cfif getdisplaysetup2.remark37 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "sdc_i">
         <select name="remark37">
         <option value="">Choose a warranty</option>
         <option value="Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01" <cfif remark9 eq 'Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01'>selected</cfif>>Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01</option>
         <option value="Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions" <cfif remark9 eq 'Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions'>selected</cfif>>Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions</option>
         <option value="BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions" <cfif remark9 eq 'BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions'>selected</cfif>>BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions</option>
         <option value="Refer to www.bearvarimixer.dk/legal" <cfif remark9 eq 'Refer to www.bearvarimixer.dk/legal'>selected</cfif>>Refer to www.bearvarimixer.dk/legal</option>
         <option value="Refer to www.sveba-dahlen.com/legal" <cfif remark9 eq 'Refer to www.sveba-dahlen.com/legal'>selected</cfif>>Refer to www.sveba-dahlen.com/legal</option>
         <option value="Refer to www.glimek.com/legal" <cfif remark9 eq 'Refer to www.glimek.com/legal'>selected</cfif>>Refer to www.glimek.com/legal</option>
         </select>
         <cfelse>
    <input type="text" name="remark37" value="#remark37#" size="40" maxlength="100">
    </cfif></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark38 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem38#</th>
    <td <cfif getdisplaysetup2.remark38 neq "Y">style="visibility:hidden"</cfif>>
    
    <input type="text" name="remark38" value="#remark38#" size="40" maxlength="100">
    </td>
     <th <cfif getdisplaysetup2.remark39 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem39#</th>
    <td <cfif getdisplaysetup2.remark39 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "sdc_i">
         <select name="remark39">
         <option value="">Choose a warranty</option>
         <option value="Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01" <cfif remark9 eq 'Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01'>selected</cfif>>Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01</option>
         <option value="Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions" <cfif remark9 eq 'Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions'>selected</cfif>>Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions</option>
         <option value="BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions" <cfif remark9 eq 'BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions'>selected</cfif>>BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions</option>
         <option value="Refer to www.bearvarimixer.dk/legal" <cfif remark9 eq 'Refer to www.bearvarimixer.dk/legal'>selected</cfif>>Refer to www.bearvarimixer.dk/legal</option>
         <option value="Refer to www.sveba-dahlen.com/legal" <cfif remark9 eq 'Refer to www.sveba-dahlen.com/legal'>selected</cfif>>Refer to www.sveba-dahlen.com/legal</option>
         <option value="Refer to www.glimek.com/legal" <cfif remark9 eq 'Refer to www.glimek.com/legal'>selected</cfif>>Refer to www.glimek.com/legal</option>
         </select>
         <cfelse>
    <input type="text" name="remark39" value="#remark39#" size="40" maxlength="100">
    </cfif></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark40 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem40#</th>
    <td <cfif getdisplaysetup2.remark40 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark40" value="#remark40#" size="40" maxlength="100"></td>
     <th <cfif getdisplaysetup2.remark41 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem41#</th>
    <td <cfif getdisplaysetup2.remark41 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark41" value="#remark41#" size="40" maxlength="100"></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark42 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem42#</th>
    <td <cfif getdisplaysetup2.remark42 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark42" value="#remark42#" size="40" maxlength="100"></td>
     <th <cfif getdisplaysetup2.remark43 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem43#</th>
    <td <cfif getdisplaysetup2.remark43 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark43" value="#remark43#" size="40" maxlength="100"></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark44 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem44#</th>
    <td <cfif getdisplaysetup2.remark44 neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark44" value="#remark44#" size="40" maxlength="100"></td>
     <th <cfif getdisplaysetup2.remark45 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem45#</th>
    <td <cfif getdisplaysetup2.remark45 neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark45" value="#remark45#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark45);">(DD/MM/YYYY)</td><cfelse><input type="text" name="remark45" value="#remark45#" size="40" maxlength="100"></cfif></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark46 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem46#</th>
    <td <cfif getdisplaysetup2.remark46 neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark46" value="#remark46#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark46);">(DD/MM/YYYY)<cfelse><input type="text" name="remark46" value="#remark46#" size="40" maxlength="100"></cfif></td>
     <th <cfif getdisplaysetup2.remark47 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem47#</th>
    <td <cfif getdisplaysetup2.remark47 neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark47" value="#remark47#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark47);">(DD/MM/YYYY)<cfelse><input type="text" name="remark47" value="#remark47#" size="40" maxlength="100"></cfif></td>
    </tr>
        <tr>
    <th <cfif getdisplaysetup2.remark48 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem48#</th>
    <td <cfif getdisplaysetup2.remark48 neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark48" value="#remark48#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark48);">(DD/MM/YYYY)<cfelse><input type="text" name="remark48" value="#remark48#" size="40" maxlength="100"></cfif></td>
     <th <cfif getdisplaysetup2.remark49 neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem49#</th>
    <td <cfif getdisplaysetup2.remark49 neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark49" value="#remark49#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark49);">(DD/MM/YYYY)<cfelse><input type="text" name="remark49" value="#remark49#" size="40" maxlength="100"></cfif></td>
    </tr>

  	</table>
    </cfoutput>
