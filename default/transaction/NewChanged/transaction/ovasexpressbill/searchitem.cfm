<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfoutput>
<cfset reftype= url.reftype>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,desp,ucost,price from icitem order by itemno limit 100
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" size="10" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/ovasexpressbill/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value));"  />&nbsp;MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/ovasexpressbill/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value));" />&nbsp;LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/ovasexpressbill/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value));" />&nbsp;&nbsp;<input type="button" name="gobtn1" value="Go"  />
    <br />
    GROUP:&nbsp;&nbsp;<select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/ovasexpressbill/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <th width="50px">UCOST</th>
    <th width="50px">PRICE</th>
    <th width="50px">QTY ON HAND</th>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem" >
    <cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getitem.itemno#' 
    </cfquery>
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem.itemno)#');ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/ovasexpressbill/addItemAjax.cfm?itemno=#URLENCODEDFORMAT(getitem.itemno)#&reftype=#reftype#'+'&custno='+document.getElementById('custno').value);setTimeout('updateVal();',750);ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/ovasexpressbill/balonhand.cfm?itemno=#URLENCODEDFORMAT(getitem.itemno)#');document.getElementById('desp2').focus();ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem.itemno#</td>
    <td>#getitem.desp#</td>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    <td>#getitembalance.balance#</td>
    <cfif lcase(hcomid) neq "acht_i">
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('expressservicelist').value =unescape('#URLENCODEDFORMAT(getitem.itemno)#');ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/ovasexpressbill/addItemAjax.cfm?itemno=#URLENCODEDFORMAT(getitem.itemno)#&reftype=#reftype#'+'&custno='+document.getElementById('custno').value);setTimeout('updateVal();',750);ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/ovasexpressbill/balonhand.cfm?itemno=#URLENCODEDFORMAT(getitem.itemno)#');document.getElementById('desp2').focus();ColdFusion.Window.hide('searchitem');"><u>SELECT</u></a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>