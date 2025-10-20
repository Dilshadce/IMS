<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfoutput>
<cfset reftype= url.reftype>
	<cfquery name="getitem" datasource="#dts#">
   		Select * from package order by packcode limit 200
	</cfquery>
    
    <font style="text-transform:uppercase">Package No.</font>&nbsp;<input type="text" name="packno1" id="packno1" size="10" onfocus="clearTimeout(t2);" onkeyup="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldpack'),'addpackageajax.cfm?reftype=#reftype#&packno='+escape(document.getElementById('packno1').value)+'&packdesp='+escape(document.getElementById('packdesp1').value));" />&nbsp;
    Package desp.</font>&nbsp;<input type="text" name="packdesp1" id="packdesp1" size="10" onfocus="clearTimeout(t2);" onkeyup="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldpack'),'addpackageajax.cfm?reftype=#reftype#&packno='+escape(document.getElementById('packno1').value)+'&packdesp='+escape(document.getElementById('packdesp1').value));" />
    
    &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldpack'),'addpackageajax.cfm?reftype=#reftype#&packno='+escape(document.getElementById('packno1').value)+'&packdesp='+escape(document.getElementById('packdesp1').value));alert(document.getElementById('packno1').value);" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  />
    
    
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldpack" name="ajaxFieldpack">
    <input name="hidpackagecode" id="hidpackagecode" type="text" value=""/>
    
    <table width="650px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Pack NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Description</font></th>
    <th width="80px">ACTION</th>

    </tr>
    <cfloop query="getitem" >

    <tr id="tr#getitem.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getitem.packcode#</td>
    <td>#getitem.packdesp#</td>
    <td><input name="btn#getitem.currentrow#" id="btn#getitem.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('hidpackagecode').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem.packcode)#'));addpackagefunc();ColdFusion.Window.hide('addpackage');" value="Select" /></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
<!--- 	<script type="text/javascript">
	getfocus2()
    </script> --->