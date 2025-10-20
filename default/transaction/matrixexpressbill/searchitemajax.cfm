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
   
    <cfquery name="getitem1" datasource="#dts#">
    Select Servi as itemno, desp,0 as ucost,0 as price,'' as aitemno,"" as fcurrcode,0 as fucost,0 as fprice<cfloop from="2" to="10" index="i">,"" as fcurrcode#i#,0 as fucost#i#,0 as fprice#i#</cfloop> from icservi WHERE
    1=1 
    <cfif URLDECODE(url.itemno) neq "">
    and Servi like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" />
    </cfif>
    <cfif URLDECODE(url.itemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" />
    </cfif>
    <cfif URLDECODE(url.leftitemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leftitemname)#%" />
    </cfif>
    union all
    select itemno,desp,ucost,price,aitemno,fcurrcode,fucost,fprice<cfloop from="2" to="10" index="i">,fcurrcode#i#,fucost#i#,fprice#i#</cfloop> from icitem WHERE 
    1=1
    <cfif URLDECODE(url.itemno) neq "">
    and itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    </cfif>
    <cfif URLDECODE(url.itemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" /> 
    </cfif>
    <cfif URLDECODE(url.leftitemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leftitemname)#%" />
    </cfif>
    <cfif URLDECODE(url.groupname) neq "">
    and wos_group like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.groupname)#%" />
    </cfif>
    <cfif URLDECODE(url.brandname) neq "">
    and brand like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.brandname)#%" />
    </cfif>
    <cfif URLDECODE(url.aitemno) neq "">
    and aitemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.aitemno)#%" />
    </cfif>
     <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
	<cfif Huserloc neq "All_loc">
    and itemno in (select itemno from locqdbf where location='#Huserloc#')
    </cfif>
    </cfif>
    
    order by itemno limit 100
	</cfquery>
    
	<cfoutput>  
	<cfset reftype= url.reftype>
    <cfset tran = reftype>
<cfset custno = URLDECODE(url.custno)>
<cfquery name="getcustomer" datasource="#dts#">
select currcode from <cfif tran eq "INV" or tran eq "DO" or tran eq "QUO" or tran eq "SO" or tran eq "CS">#target_arcust#<cfelse>#target_apvend#</cfif> where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#"> 
</cfquery>
    <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmultiitem();ColdFusion.Window.hide('searchitem');" value="Add Selected Item"/>
    <table width="650px">
    <tr>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'>
    <th width="100px"><font style="text-transform:uppercase">PRODUCT CODE</font></th>
    </cfif>
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
<input type="text" name="qtyall" id="qtyall" value="" size="3" onKeyUp="for (k=1;k<=200;k=k+1)
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
	}"></th>
    <th>PRICE<br>
<input type="text" name="priceall" id="priceall" value="" size="6"  onKeyUp="for (k=1;k<=200;k=k+1)
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
	}"></th>
    <th>DIS%</th>
    <th>LOCATION</th>
    </tr>
    <cfloop query="getitem1" >
    <cfif getpin2.h1360 eq 'T'>
    <cfquery name="getitembalance1" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getitem1.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getitem1.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getitem1.itemno#' 
    </cfquery>
    </cfif>
    <tr id="tr#getitem1.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem1.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem1.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <td>#getitem1.itemno#</td>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'>
    <td>#getitem1.aitemno#</td>
    </cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'>
    <td>#getitem1.desp#</td>
    </cfif>
    <cfif getpin2.h1360 eq 'T'>
    
    <cfif isdefined('getitem1.fcurrcode')>
    <cfif getitem1.fcurrcode neq "" and getcustomer.currcode eq getitem1.fcurrcode>
        <cfset getitem1.price = getitem1.fprice>
        <cfset getitem1.ucost = getitem1.fucost>
        </cfif>
        
        <cfloop from="2" to="10" index="i">
        <cfif evaluate('getitem1.fcurrcode#i#') neq "" and getcustomer.currcode eq evaluate('getitem1.fcurrcode#i#')>
        <cfset getitem1.price = evaluate('getitem1.fprice#i#')>
        <cfset getitem1.ucost = evaluate('getitem1.fucost#i#')>
        </cfif>
        
        </cfloop>    
        </cfif>
    
    <cfif getdisplay.itemsearch_ucost eq 'Y'>
    <td>#lsnumberformat(getitem1.ucost,',_.__')#</td>
    </cfif>
    <cfif getdisplay.itemsearch_price eq 'Y'>
    <td>#lsnumberformat(getitem1.price,',_.__')#</td>
    </cfif>
    <cfif getdisplay.itemsearch_qty eq 'Y'>
    <td>#getitembalance1.balance#</td>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <td><input name="btn#getitem1.currentrow#" id="btn#getitem1.currentrow#" type="button" style="background:none; border:none; cursor:pointer;"  onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem1.itemno)#'));ColdFusion.Window.hide('searchitem');" value="SELECT" onfocus="document.getElementById('tr#getitem1.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem1.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem1.currentrow neq getitem1.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem1.currentrow)+1#').focus()}</cfif> <cfif getitem1.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem1.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif>" /></td>
    <td><input name="additem_#getitem1.currentrow#" id="additem_#getitem1.currentrow#" type="checkbox" value="#getitem1.itemno#"/></td>
    <td><input name="additemqty_#getitem1.currentrow#" id="additemqty_#getitem1.currentrow#" type="text" size="3" value="0"  onblur="if((this.value*1)>0){document.getElementById('additem_#getitem1.currentrow#').checked=true}else{document.getElementById('additem_#getitem1.currentrow#').checked=false}"/></td>
    <td>
    <cfif reftype eq 'PO' or reftype eq 'PR' or reftype eq 'RC'>
    <input name="additemprice_#getitem1.currentrow#" id="additemprice_#getitem1.currentrow#" type="text" size="6" value="#getitem1.ucost#"  />
    <cfelse>
    <input name="additemprice_#getitem1.currentrow#" id="additemprice_#getitem1.currentrow#" type="text" size="6" value="#getitem1.price#"  />
    </cfif>
    </td>
    <td nowrap><input name="additemdisc_#getitem1.currentrow#" id="additemdisc_#getitem1.currentrow#" type="text" size="3" value="0"  />
    <cfif lcase(hcomid) eq "didachi_i">
    <input name="additemdisc2_#getitem1.currentrow#" id="additemdisc2_#getitem1.currentrow#" type="text" size="3" value="0"  />%
    <input name="additemdisc3_#getitem1.currentrow#" id="additemdisc3_#getitem1.currentrow#" type="text" size="3" value="0"  />%
    </cfif>
    </td>
    <td><select name="additemloc_#getitem1.currentrow#" id="additemloc_#getitem1.currentrow#">
    <option value="">Select a location</option>
    <cfloop query="getlocation">
    <option value="#getlocation.location#" <cfif getgsetup.ddllocation eq location>selected</cfif>>#getlocation.location#</option>
    </cfloop>
    </select>
    </td>
    </cfif>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>