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


<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
    <cfset rem30display=getdisplaysetup2.remark30_pur>
    <cfset rem31display=getdisplaysetup2.remark31_pur>
    <cfset rem32display=getdisplaysetup2.remark32_pur>
    <cfset rem33display=getdisplaysetup2.remark33_pur>
    <cfset rem34display=getdisplaysetup2.remark34_pur>
    <cfset rem35display=getdisplaysetup2.remark35_pur>
    <cfset rem36display=getdisplaysetup2.remark36_pur>
    <cfset rem37display=getdisplaysetup2.remark37_pur>
    <cfset rem38display=getdisplaysetup2.remark38_pur>
    <cfset rem39display=getdisplaysetup2.remark39_pur>
    <cfset rem40display=getdisplaysetup2.remark40_pur>
    <cfset rem41display=getdisplaysetup2.remark41_pur>
    <cfset rem42display=getdisplaysetup2.remark42_pur>
    <cfset rem43display=getdisplaysetup2.remark43_pur>
    <cfset rem44display=getdisplaysetup2.remark44_pur>
    <cfset rem45display=getdisplaysetup2.remark45_pur>
    <cfset rem46display=getdisplaysetup2.remark46_pur>
    <cfset rem47display=getdisplaysetup2.remark47_pur>
    <cfset rem48display=getdisplaysetup2.remark48_pur>
    <cfset rem49display=getdisplaysetup2.remark49_pur>
    
    <cfelse>

    <cfset rem30display=getdisplaysetup2.remark30>
    <cfset rem31display=getdisplaysetup2.remark31>
    <cfset rem32display=getdisplaysetup2.remark32>
    <cfset rem33display=getdisplaysetup2.remark33>
    <cfset rem34display=getdisplaysetup2.remark34>
    <cfset rem35display=getdisplaysetup2.remark35>
    <cfset rem36display=getdisplaysetup2.remark36>
    <cfset rem37display=getdisplaysetup2.remark37>
    <cfset rem38display=getdisplaysetup2.remark38>
    <cfset rem39display=getdisplaysetup2.remark39>
    <cfset rem40display=getdisplaysetup2.remark40>
    <cfset rem41display=getdisplaysetup2.remark41>
    <cfset rem42display=getdisplaysetup2.remark42>
    <cfset rem43display=getdisplaysetup2.remark43>
    <cfset rem44display=getdisplaysetup2.remark44>
    <cfset rem45display=getdisplaysetup2.remark45>
    <cfset rem46display=getdisplaysetup2.remark46>
    <cfset rem47display=getdisplaysetup2.remark47>
    <cfset rem48display=getdisplaysetup2.remark48>
    <cfset rem49display=getdisplaysetup2.remark49>
   
    </cfif>


<cftry>
<cfif form.mode eq "Create">
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
    
    <th nowrap <cfif rem30display neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i"><cfif tran eq 'PO'>Consigment 1<cfelse>#getremarkdetail.rem30#</cfif><cfelse>#getremarkdetail.rem30#</cfif></th>
    
    <td <cfif rem30display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark30">
         <option value="Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)" <cfif remark30 eq "Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)">selected</cfif>>Quotation based on Vsolutions's Terms and Conditions (Please Contact Sales Representative if Terms & Conditions is not attached)</option>
         <option value=" " <cfif remark30 eq " ">selected</cfif>></option>
    </select>
    <cfelseif lcase(hcomid) eq "draco_i">
    <cfquery name="getsize" datasource="#dts#">
    select * from icsizeid
    </cfquery>
    <select name="remark30">
         <option value="" >Choose a #getremarkdetail.rem30#</option>
         <cfloop query="getsize">
         <option value="#getsize.sizeid#" <cfif remark30 eq getsize.sizeid>selected</cfif>>#getsize.sizeid# - #getsize.desp#</option>
         </cfloop>
    </select>
    
    <cfelse>
    <input type="text" name="remark30" value="#convertquote(remark30)#" size="40" maxlength="100">
    </cfif>
    </td>
     <th nowrap <cfif rem31display neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i"><cfif tran eq 'PO'>Consigment 2<cfelse>#getremarkdetail.rem31#</cfif><cfelse>#getremarkdetail.rem31#</cfif></th>
    <td <cfif rem31display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark31">
         <option value="Singapore Dollars excludes taxes of all kinds" <cfif remark31 eq "Singapore Dollars excludes taxes of all kinds">selected</cfif>>Singapore Dollars excludes taxes of all kinds</option>
         <option value="Burnei Dollars excludes taxes of all kinds" <cfif remark31 eq "Burnei Dollars excludes taxes of all kinds">selected</cfif>>Burnei Dollars excludes taxes of all kinds</option>
         <option value="US Dollars excludes taxes of all kinds" <cfif remark31 eq "US Dollars excludes taxes of all kinds">selected</cfif>>US Dollars excludes taxes of all kinds</option>
         <option value="Euro  Dollars excludes taxes of all kinds" <cfif remark31 eq "Euro  Dollars excludes taxes of all kinds">selected</cfif>>Euro  Dollars excludes taxes of all kinds</option>
         <option value=" " <cfif remark31 eq " ">selected</cfif>></option>
    </select>
    <cfelseif lcase(hcomid) eq "ltm_i" or lcase(hcomid) eq "atc2005_i">
    <select name="remark31" id="remark31">
    <option value="printall" <cfif remark31 eq "printall">selected</cfif>>Print All</option>
	<option value="printname" <cfif remark31 eq "printname">selected</cfif>>Hide bill to</option>
	<option value="printprice" <cfif remark31 eq "printprice">selected</cfif>>No price</option>
	<option value="printblank" <cfif remark31 eq "printblank">selected</cfif>>Print Blank</option>
	</select>
    <cfelse>
    <input type="text" name="remark31" value="#convertquote(remark31)#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr <cfif rem32display neq "Y" and rem33display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem32display neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i"><cfif tran eq 'PO'>Consigment 3<cfelse>#getremarkdetail.rem32#</cfif><cfelse>#getremarkdetail.rem32#</cfif></th>
    <td <cfif rem32display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark32">
		 <option value=" " <cfif remark32 eq " ">selected</cfif>></option>
		 <option value="12 months Warranty  from Date of Delivery" <cfif remark32 eq "12 months Warranty  from Date of Delivery">selected</cfif>>12 months Warranty  from Date of Delivery</option>
         <option value="24 months   Warranty  from Date of Delivery" <cfif remark32 eq "24 months   Warranty  from Date of Delivery">selected</cfif>>24 months   Warranty  from Date of Delivery</option>
         <option value="3 years   Warranty  from Date of Delivery" <cfif remark32 eq "3 years   Warranty  from Date of Delivery">selected</cfif>>3 years   Warranty  from Date of Delivery</option>
         <option value="5  years Warranty  from Date of Delivery" <cfif remark32 eq "5  years Warranty  from Date of Delivery">selected</cfif>>5  years Warranty  from Date of Delivery</option>
         <option value="90 day software and 12 month hardware warranty." <cfif remark32 eq "90 day software and 12 month hardware warranty.">selected</cfif>>90 day software and 12 month hardware warranty.</option>
         
    </select>
    <cfelseif lcase(hcomid) eq "draco_i">
    <cfquery name="getrating" datasource="#dts#">
    select * from iccostcode
    </cfquery>
    <select name="remark32" id="remark32">
         <option value="" >Choose a #getremarkdetail.rem32#</option>
         <cfloop query="getrating">
         <option value="#getrating.costcode#" <cfif remark32 eq getrating.costcode>selected</cfif>>#getrating.costcode# - #getrating.desp#</option>
         </cfloop>
    </select>
    
    <cfelseif lcase(hcomid) eq "ltm_i">
    <select name="remark32" id="remark32">
	<option value="Yes" <cfif remark32 eq "Yes">selected</cfif>>Yes</option>
	<option value="No" <cfif remark32 eq "No">selected</cfif>>No</option>
	</select>
    <cfelse>
    <input type="text" name="remark32" value="#convertquote(remark32)#" size="40" maxlength="100">
    </cfif>
    </td>
     <th nowrap <cfif rem33display neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i"><cfif tran eq 'PO'>Consigment 4<cfelse>#getremarkdetail.rem33#</cfif><cfelse>#getremarkdetail.rem33#</cfif></th>
    <td <cfif rem33display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark33">
         <option value="Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery." <cfif remark33 eq "Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery.">selected</cfif>>Self collect for order less than SGD 1,500.00, otherwise SGD 50.00 charge for delivery.</option>
	<option value="Self Collect" <cfif remark33 eq "Self Collect">selected</cfif>>Self Collect</option>
	<option value=" " <cfif remark33 eq " ">selected</cfif>></option>
    </select>
    <cfelseif lcase(hcomid) eq "ltm_i">
    <select name="remark33" id="remark33">
	<option value="1/4" <cfif remark33 eq "1/4">selected</cfif>>1/4</option>
	<option value="1/2" <cfif remark33 eq "1/2">selected</cfif>>1/2</option>
    <option value="3/4" <cfif remark33 eq "3/4">selected</cfif>>3/4</option>
    <option value="Full" <cfif remark33 eq "Full">selected</cfif>>Full</option>
	</select>
    <cfelseif lcase(hcomid) eq "atc2005_i">
    <cfquery name="getarea" datasource="#dts#">
    select area from icarea
    </cfquery>
    <select name="remark33" id="remark33">
    <option value="" <cfif remark33 eq "">selected</cfif>>Choose an Area</option>
    <cfloop query="getarea">
	<option value="#getarea.area#" <cfif remark33 eq "#getarea.area#">selected</cfif>>#getarea.area#</option>
    </cfloop>
	</select>
    <cfelse>
    <input type="text" name="remark33" value="#convertquote(remark33)#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr <cfif rem34display neq "Y" and rem35display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem34display neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i"><cfif tran eq 'PO'>Consigment 5<cfelse>#getremarkdetail.rem34#</cfif><cfelse>#getremarkdetail.rem34#</cfif></th>
    <td <cfif rem34display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark34">
         <option value="" <cfif remark34 eq "">selected</cfif>></option>
         <option value="Does not include any installation services and training." <cfif remark34 eq "Does not include any installation services and training.">selected</cfif>>Does not include any installation services and training.</option>
    </select>
    <cfelseif lcase(hcomid) eq "draco_i">
    <cfquery name="getcolorid" datasource="#dts#">
    select * from iccolorid
    </cfquery>
    <select name="remark34" id="remark34">
         <option value="" >Choose a #getremarkdetail.rem34#</option>
         <cfloop query="getcolorid">
         <option value="#getcolorid.colorid#" <cfif remark34 eq getcolorid.colorid>selected</cfif>>#getcolorid.colorid# - #getcolorid.desp#</option>
         </cfloop>
    </select>
    
    <cfelse>
    <input type="text" name="remark34" value="#convertquote(remark34)#" size="40" maxlength="100">
    </cfif></td>
     <th nowrap <cfif rem35display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem35#</th>
    <td <cfif rem35display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark35">
         <option value="" <cfif remark35 eq "">selected</cfif>></option>
         <option value="Does not include any cables and peripherals unless stated." <cfif remark35 eq "Does not include any cables and peripherals unless stated.">selected</cfif>>Does not include any cables and peripherals unless stated.</option>
    </select>
    
    <cfelse>
    <input type="text" name="remark35" value="#convertquote(remark35)#" size="40" maxlength="100">
    </cfif>
    </td>
    </tr>
        <tr <cfif rem36display neq "Y" and rem37display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem36display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem36#</th>
    <td <cfif rem36display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
    <select name="remark36">
         <option value="Email" <cfif remark36 eq "Email">selected</cfif>>Email</option>
         <option value="Verbal" <cfif remark36 eq "Verbal">selected</cfif>>Verbal</option>
	 <option value="" <cfif remark36 eq "">selected</cfif>></option>
    </select>
    
    <cfelse>
<input type="text" name="remark36" value="#convertquote(remark36)#" size="40" maxlength="100">
	</cfif>
</td>
     <th nowrap <cfif rem37display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem37#</th>
    <td <cfif rem37display neq "Y">style="visibility:hidden"</cfif>>
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
    <input type="text" name="remark37" value="#convertquote(remark37)#" size="40" maxlength="100">
    </cfif></td>
    </tr>
        <tr <cfif rem38display neq "Y" and rem39display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem38display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem38#</th>
    <td <cfif rem38display neq "Y">style="visibility:hidden"</cfif>>
    
    <input type="text" name="remark38" value="#convertquote(remark38)#" size="40" maxlength="100">
    </td>
     <th nowrap <cfif rem39display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem39#</th>
    <td <cfif rem39display neq "Y">style="visibility:hidden"</cfif>>
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
    <input type="text" name="remark39" value="#convertquote(remark39)#" size="40" maxlength="100">
    </cfif></td>
    </tr>
        <tr <cfif rem40display neq "Y" and rem41display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem40display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem40#</th>
    <td <cfif rem40display neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark40" value="#convertquote(remark40)#" size="40" maxlength="100"></td>
     <th nowrap <cfif rem41display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem41#</th>
    <td <cfif rem41display neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark41" value="#convertquote(remark41)#" size="40" maxlength="100"></td>
    </tr>
        <tr <cfif rem42display neq "Y" and rem43display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem42display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem42#</th>
    <td <cfif rem42display neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark42" value="#convertquote(remark42)#" size="40" maxlength="100"></td>
     <th nowrap <cfif rem43display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem43#</th>
    <td <cfif rem43display neq "Y">style="visibility:hidden"</cfif>><input type="text" name="remark43" value="#convertquote(remark43)#" size="40" maxlength="100"></td>
    </tr>
        <tr <cfif rem44display neq "Y" and rem45display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem44display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem44#</th>
    <td <cfif rem44display neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
    <select name="remark44">
            <option value="">Choose a Paid to</option>
            <option value="SDC HKD" <cfif remark44 eq 'SDC HKD'>selected</cfif>>SDC HKD</option>
            <option value="SDC EUR" <cfif remark44 eq 'SDC EUR'>selected</cfif>>SDC EUR</option>
            <option value="SDC USD" <cfif remark44 eq 'SDC USD'>selected</cfif>>SDC USD</option>
            <option value="SDAB EUR" <cfif remark44 eq 'SDAB EUR'>selected</cfif>>SDAB EUR</option>
	    	<option value="SDAB USD" <cfif remark44 eq 'SDAB USD'>selected</cfif>>SDAB USD</option>
            <option value="WDC EUR" <cfif remark44 eq 'WDC EUR'>selected</cfif>>WDC EUR</option>
            <option value="GLI EUR" <cfif remark44 eq 'GLI EUR'>selected</cfif>>GLI EUR</option>
    </select>
    <cfelse>
    <input type="text" name="remark44" value="#convertquote(remark44)#" size="40" maxlength="100">
    </cfif>
    </td>
     <th nowrap <cfif rem45display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem45#</th>
    <td <cfif rem45display neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark45" value="#convertquote(remark45)#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark45);">(DD/MM/YYYY)</td><cfelse><input type="text" name="remark45" value="#remark45#" size="40" maxlength="100"></cfif></td>
    </tr>
        <tr <cfif rem46display neq "Y" and rem47display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem46display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem46#</th>
    <td <cfif rem46display neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark46" value="#convertquote(remark46)#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark46);">(DD/MM/YYYY)<cfelse><input type="text" name="remark46" value="#remark46#" size="40" maxlength="100"></cfif></td>
     <th nowrap <cfif rem47display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem47#</th>
    <td <cfif rem47display neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark47" value="#convertquote(remark47)#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark47);">(DD/MM/YYYY)<cfelse><input type="text" name="remark47" value="#remark47#" size="40" maxlength="100"></cfif></td>
    </tr>
        <tr <cfif rem48display neq "Y" and rem49display neq "Y">style="display:none"</cfif>>
    <th nowrap <cfif rem48display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem48#</th>
    <td <cfif rem48display neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark48" value="#convertquote(remark48)#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark48);">(DD/MM/YYYY)<cfelse><input type="text" name="remark48" value="#remark48#" size="40" maxlength="100"></cfif></td>
     <th nowrap <cfif rem49display neq "Y">style="visibility:hidden"</cfif>>#getremarkdetail.rem49#</th>
    <td <cfif rem49display neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.autooutstandingreport eq 'Y'><input type="text" name="remark49" value="#convertquote(remark49)#" size="40" maxlength="10"><img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark49);">(DD/MM/YYYY)<cfelse><input type="text" name="remark49" value="#remark49#" size="40" maxlength="100"></cfif></td>
    </tr>

  	</table>
    </cfoutput>
