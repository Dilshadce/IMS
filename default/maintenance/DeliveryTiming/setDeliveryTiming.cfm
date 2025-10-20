
<cfif cgi.HTTP_HOST eq 'ims2.netiquette.com.sg' or cgi.HTTP_HOST eq 'ims.netiquette.com.sg' or cgi.HTTP_HOST eq 'imspro.netiquette.com.sg'>
<cfset imsdts = dts>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfelse>
<cfinclude template="/_dsp/dsp_header.cfm">
<cfif not len(getAuthUser())>
	<cfset request.loginmessage = <!--- request.loginmessage &  --->"<br>You must be authorized to access that area ... Please login.">
	<cfinclude template="#Application.webroot#security/login.cfm">
</cfif>
</cfif>
<cfoutput>
<cfquery name="general" datasource="#replace(dts,'_i','_c','all')#">
select * from  generalsetup 
</cfquery>

<cfif isdefined('form.submit')>
<cfquery name="save" datasource="#replace(dts,'_i','_c','all')#">
update generalsetup set deliveryTIming = '#form.hidrem5#'
</cfquery>

<script type="text/javascript">
alert('Save Successfully');
window.location.href='<!--- /maintenancetable/deliveryTiming/ --->setDeliveryTiming.cfm';
</script>


</cfif>
<table border="0" >
<tr>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="list.cfm"><b>Delivery Timing Listing</b></a></td>
<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="form.cfm?type=Create"><b>Create Delivery Timing</b></a></td>
<!---<td onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><a href="electrolist.cfm"><b>Production Routing Card List</b></a></td> --->
</tr>

</table>

<cfquery name="getDeliveryTiming" datasource="#imsdts#">
select * from deliveryTiming 
</cfquery>


<h4>Set the Delivery Timing</h4>
<form name="a" method="post">
<table class="data">
<tr>
<th>Set Current Delivery Timing</th>
<td>
 <select name="hidrem5" id="hidrem5">
    <option value="">Choose a Delivery Timing</option>
   <cfloop query="getDeliveryTiming">
            <option value="#id#" <cfif general.deliveryTiming eq  id>selected</cfif> title="<cfloop from='1' to='7' index='a'><cfif isnumeric(evaluate('day#a#'))>#DayOfWeekAsString(evaluate('day#a#'))# - #timeformat(evaluate('time#a#'),'hh:mm tt')# to #timeformat(evaluate('totime#a#'),'hh:mm tt')##chr(13)#</cfif></cfloop>" >#option1#</option>
            </cfloop>
            </select> 
</td>
</tr>
<tr><td colspan="2"><input type="submit" name="submit" value="Save"></td></tr>
</table>

</form>

</cfoutput>
<!--- <tr>
<th>#getgsetup.rem5#</th>
<td style="font-size:16px;" align="left">
           
         
            <cfloop from='1' to='7' index='a'>
           <cfif isnumeric(evaluate('day#a#'))>
           
           <option value="#evaluate('day#a#')#-#timeformat(evaluate('time#a#'),'hh:mm tt')##timeformat(evaluate('totime#a#'),'hh:mm tt')#">#DayOfWeekAsString(evaluate('day#a#'))# - #timeformat(evaluate('time#a#'),'hh:mm tt')# to #timeformat(evaluate('totime#a#'),'hh:mm tt')#</option>
           </cfif>
           
         </cfloop>
         </select>
     <!---     --->
</table> --->