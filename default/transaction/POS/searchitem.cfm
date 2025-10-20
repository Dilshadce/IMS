<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfoutput>
<cfset reftype= url.reftype>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,aitemno,desp,ucost,price from icitem where 1=1
         <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
		<cfif Huserloc neq "All_loc">
        and itemno in (select itemno from locqdbf where location='#Huserloc#')
        </cfif>
        </cfif>    
		and (nonstkitem <> "T" or nonstkitem is null)
         order by itemno limit 50
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" size="10" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname1').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    
    <cfelse>
    MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
	
	</cfif>
    
    &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  />
    <br />
    GROUP:&nbsp;&nbsp;<select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    &nbsp;PRODUCT CODE:&nbsp;<input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/pos/searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <table width="650px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <cfif hcomid neq "acht_i"><th width="100px">PRODUCT CODE</th></cfif>
    <th width="300px">NAME</th>
    
     
   <cfif getpin2.h1360 eq 'T'> <th width="50px">UCOST</th>
    <th width="50px">PRICE</th>
    <cfif lcase(hcomid) neq "kjcpl_i" or lcase(hcomid) neq "mlpl_i" or lcase(hcomid) neq "viva_i">
    <th width="50px">QTY ON HAND</th>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem" >
    <cfif getpin2.h1360 eq 'T'>
    <cfquery name="getitembalance" datasource="#dts#">
    
    <cfif HUserGrpID neq 'Super' and Huserloc neq "All_loc">
    
    select 
	a.itemno,
	ifnull(ifnull(a.locqfield,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from locqdbf as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getitem.itemno#' 
        and location="#Huserloc#"
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
        and location="#Huserloc#"
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getitem.itemno#' 
    and a.location="#Huserloc#"
    
    <cfelse>
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
    </cfif>
    </cfquery>
    </cfif>
    
    <tr id="tr#getitem.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem.itemno#</td>
    <cfif hcomid neq "acht_i"><td>#getitem.aitemno#</td></cfif>
    <td>#getitem.desp#</td>
    <cfif getpin2.h1360 eq 'T'>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    <cfif lcase(hcomid) neq "kjcpl_i" or lcase(hcomid) neq "mlpl_i" or lcase(hcomid) neq "viva_i">
    <td>#getitembalance.balance#</td>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <td><input name="btn#getitem.currentrow#" id="btn#getitem.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('expressservicelist').value =unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');" value="SELECT" onfocus="document.getElementById('tr#getitem.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem.currentrow neq getitem.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem.currentrow)+1#').focus()}</cfif> <cfif getitem.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif> " /></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
<!--- 	<script type="text/javascript">
	getfocus2()
    </script> --->