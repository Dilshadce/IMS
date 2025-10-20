<cfoutput>
<cfset dts2=replace(dts,'_i','_a','all')>
	<cfquery name="getglacc" datasource="#dts2#">
   	select accno,desp,desp2,acc_code 
	from gldata 
	where accno not in (select custno from arcust order by custno) 
	and accno not in (select custno from apvend order by custno)
	order by accno;

	</cfquery>
    
  <font style="text-transform:uppercase">Account NO.</font>&nbsp;<input type="text" name="custno1" id="custno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'/default/maintenance/findglaccAjax2.cfm?custno='+document.getElementById('custno1').value+'&desp='+document.getElementById('custdesp1').value+'&desp2='+document.getElementById('custdesp2').value);"/>&nbsp;&nbsp;Description.</font>&nbsp;<input type="text" name="custdesp1" id="custdesp1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'/default/maintenance/findglaccAjax2.cfm?custno='+document.getElementById('custno1').value+'&desp='+document.getElementById('custdesp1').value+'&desp2='+document.getElementById('custdesp2').value);"/>&nbsp;&nbsp;Old Acc No.</font>&nbsp;<input type="text" name="custdesp2" id="custdesp2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'/default/maintenance/findglaccAjax2.cfm?custno='+document.getElementById('custno1').value+'&desp='+document.getElementById('custdesp1').value+'&desp2='+document.getElementById('custdesp2').value);"/>
  
  
    <br />
  <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Gl Account</font></th>
    <th><font style="text-transform:uppercase">Description</font></th>
    <th><font style="text-transform:uppercase">Old Account No</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getglacc" >
    <tr>
    <td>#getglacc.accno#</td>
    <td nowrap>#getglacc.desp# #getglacc.desp2#</td>
    <td nowrap>#getglacc.acc_code#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('SALEC').value='#getglacc.accno#';ColdFusion.Window.hide('findglacc2')"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>