<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
  	select location,desp 
    from iclocation
</cfquery>



<cfoutput>
<cfset reftype= url.reftype>
<cfset tran = reftype>
<cfset custno = URLDECODE(url.custno)>
<cfquery name="getcustomer" datasource="#dts#">
select currcode from <cfif tran eq "INV" or tran eq "DO" or tran eq "QUO" or tran eq "SO" or tran eq "CS">#target_arcust#<cfelse>#target_apvend#</cfif> where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#"> 
</cfquery>

	<cfquery name="getitem" datasource="#dts#">
   		select itemno,aitemno,desp,ucost,price,fcurrcode,fucost,fprice<cfloop from="2" to="10" index="i">,fcurrcode#i#,fucost#i#,fprice#i#</cfloop> from icitem
         <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
		<cfif Huserloc neq "All_loc">
        where itemno in (select itemno from locqdbf where location='#Huserloc#')
        </cfif>
        </cfif>    
         order by itemno limit 100
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" size="10" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname1').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    
    <cfelse>
    MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
	
	</cfif>
    
    &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  />
    <br />
    GROUP:&nbsp;&nbsp;<select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    &nbsp;PRODUCT CODE:&nbsp;<input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    &nbsp;Brand:&nbsp;&nbsp;<select name="brand1" id="brand1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&custno=#custno#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a brand</option>
    <cfloop query="getbrand">
    <option value="#getbrand.brand#">#getbrand.brand#</option>
    </cfloop>
    </select>
    
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmultiitem();ColdFusion.Window.hide('searchitem');" value="Add Selected Item"/>
    
    <table width="650px">
    <tr>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><th width="100px">PRODUCT CODE</th></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'>
    <th width="300px">NAME</th>
    </cfif>
     
   <cfif getpin2.h1360 eq 'T'> 
   <cfif getdisplay.itemsearch_ucost eq 'Y'>
   <th width="50px">UCOST</th>
   </cfif>
   <cfif getdisplay.itemsearch_price eq 'Y'>
    <th width="50px">PRICE</th>
    </cfif>
    <cfif getdisplay.itemsearch_qty eq 'Y'>
    <th width="50px">QTY ON HAND</th>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    <th nowrap="nowrap">All <input name="checkall" id="checkall" type="checkbox" value="" onclick="
    for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
    if(document.getElementById('checkall').checked==true){
	document.getElementById('additem_'+k).checked=true;
	}
    else{
    document.getElementById('additem_'+k).checked=false;
    }
    }
	}
    "/></th>
    <th>QTY<br>
<input type="text" name="qtyall" id="qtyall" value="" size="3" onKeyUp="if(this.value!=''){for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
      if(document.getElementById('additem_'+k).checked==true)
      {
          if(this.value == '')
          {
          document.getElementById('additemqty_'+k).value = 0.00
          }
          else
          {
          document.getElementById('additemqty_'+k).value = this.value
          }
      }

    }
	}}"></th>
    <th>PRICE<br>
<input type="text" name="priceall" id="priceall" value="" size="6"  onKeyUp="if(this.value!=''){for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
      if(document.getElementById('additem_'+k).checked==true)
      {
          if(this.value == '')
          {
          document.getElementById('additemprice_'+k).value = 0.00
          }
          else
          {
          document.getElementById('additemprice_'+k).value = this.value
          }
      }

    }
	}}"></th>
    <th nowrap="nowrap">DIS%<br />
    <input type="text" name="discall" id="discall" value="" size="3"  onKeyUp="if(this.value!=''){for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
      if(document.getElementById('additem_'+k).checked==true)
      {
          if(this.value == '')
          {
          document.getElementById('additemdisc_'+k).value = 0
          }
          else
          {
          document.getElementById('additemdisc_'+k).value = this.value
          }
      }

    }
	}}">%
    <cfif lcase(hcomid) eq "didachi_i">
    <input type="text" name="disc2all" id="disc2all" value="" size="3"  onKeyUp="if(this.value!=''){for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
      if(document.getElementById('additem_'+k).checked==true)
      {
          if(this.value == '')
          {
          document.getElementById('additemdisc2_'+k).value = 0
          }
          else
          {
          document.getElementById('additemdisc2_'+k).value = this.value
          }
      }

    }
	}}">%
    <input type="text" name="disc3all" id="disc3all" value="" size="3"  onKeyUp="if(this.value!=''){for (k=1;k<=200;k=k+1)
	{
	if (document.getElementById('additem_'+k) == null)
	{
	}
	else
	{	
      if(document.getElementById('additem_'+k).checked==true)
      {
          if(this.value == '')
          {
          document.getElementById('additemdisc3_'+k).value = 0
          }
          else
          {
          document.getElementById('additemdisc3_'+k).value = this.value
          }
      }

    }
	}}">%
    </cfif>
    </th>
    <th>LOCATION</th>
    </tr>
    <cfloop query="getitem" >
    <cfif getpin2.h1360 eq 'T'>
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
    </cfif>
    
    <tr id="tr#getitem.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <td>#getitem.itemno#</td>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><td>#getitem.aitemno#</td></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'><td>#getitem.desp#</td></cfif>
    <cfif getpin2.h1360 eq 'T'>
    
    <cfif isdefined('getitem.fcurrcode')>
    <cfif getitem.fcurrcode neq "" and getcustomer.currcode eq getitem.fcurrcode>
        <cfset getitem.price = getitem.fprice>
        <cfset getitem.ucost = getitem.fucost>
        </cfif>
        
        <cfloop from="2" to="10" index="i">
        <cfif evaluate('getitem.fcurrcode#i#') neq "" and getcustomer.currcode eq evaluate('getitem.fcurrcode#i#')>
        <cfset getitem.price = evaluate('getitem.fprice#i#')>
        <cfset getitem.ucost = evaluate('getitem.fucost#i#')>
        </cfif>
        
        </cfloop>    
        </cfif>
        
    <cfif getdisplay.itemsearch_ucost eq 'Y'>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    </cfif>
    <cfif getdisplay.itemsearch_price eq 'Y'>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    </cfif>
    <cfif getdisplay.itemsearch_qty eq 'Y'>
    <td>#getitembalance.balance#</td>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <td><input name="btn#getitem.currentrow#" id="btn#getitem.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('expressservicelist').value =unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));ColdFusion.Window.hide('searchitem');" value="SELECT" onfocus="document.getElementById('tr#getitem.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem.currentrow neq getitem.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem.currentrow)+1#').focus()}</cfif> <cfif getitem.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif> " /></td>
    <td><input name="additem_#getitem.currentrow#" id="additem_#getitem.currentrow#" type="checkbox" value="#getitem.itemno#"/></td>
    <td><input name="additemqty_#getitem.currentrow#" id="additemqty_#getitem.currentrow#" type="text" size="3" value="0" onblur="if((this.value*1)>0){document.getElementById('additem_#getitem.currentrow#').checked=true}else{document.getElementById('additem_#getitem.currentrow#').checked=false}"/></td>
   	<td>
	<cfif reftype eq 'PO' or reftype eq 'PR' or reftype eq 'RC'>
    <input name="additemprice_#getitem.currentrow#" id="additemprice_#getitem.currentrow#" type="text" size="6" value="#getitem.ucost#"  />
    <cfelse>
    <input name="additemprice_#getitem.currentrow#" id="additemprice_#getitem.currentrow#" type="text" size="6" value="#getitem.price#"  />
    </cfif>
    </td>
    <td nowrap><input name="additemdisc_#getitem.currentrow#" id="additemdisc_#getitem.currentrow#" type="text" size="3" value="0"  />%
	<cfif lcase(hcomid) eq "didachi_i">
    <input name="additemdisc2_#getitem.currentrow#" id="additemdisc2_#getitem.currentrow#" type="text" size="3" value="0"  />%
    <input name="additemdisc3_#getitem.currentrow#" id="additemdisc3_#getitem.currentrow#" type="text" size="3" value="0"  />%
    </cfif>
    </td>
    <td><select name="additemloc_#getitem.currentrow#" id="additemloc_#getitem.currentrow#">
    <option value="">Select a location</option>
    <cfloop query="getlocation">
    <option value="#getlocation.location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#getlocation.location#</option>
    </cfloop>
    </select>
    </td></cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
<!--- 	<script type="text/javascript">
	getfocus2()
    </script> --->