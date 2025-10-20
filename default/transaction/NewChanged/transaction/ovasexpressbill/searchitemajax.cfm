    <cfquery name="getitem1" datasource="#dts#">
    Select Servi as itemno, desp from icservi WHERE 
    Servi like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" />
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" />
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leftitemname)#%" />
    union all
    select itemno,desp from icitem WHERE 
    itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" /> 
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leftitemname)#%" />
    and wos_group like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.groupname)#%" />
    order by itemno limit 100
	</cfquery>
    
	<cfoutput>  
	<cfset reftype= url.reftype>
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
    <cfloop query="getitem1" >
    
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
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem1.itemno)#');ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/ovasexpressbill/addItemAjax.cfm?itemno=#URLENCODEDFORMAT(getitem1.itemno)#'+'&custno='+document.getElementById('custno').value+'&reftype=#reftype#');setTimeout('updateVal();',750);ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/ovasexpressbill/balonhand.cfm?itemno=#URLENCODEDFORMAT(getitem1.itemno)#');document.getElementById('desp2').focus();ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem1.itemno#</td>
    <td>#getitem1.desp#</td>
    <cfquery name="getitem" datasource="#dts#">
    select price,ucost from icitem where itemno='#getitem1.itemno#'
    </cfquery>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    <td>#getitembalance1.balance#</td>
    <cfif lcase(hcomid) neq "acht_i">
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem1.itemno)#');ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/ovasexpressbill/addItemAjax.cfm?itemno=#URLENCODEDFORMAT(getitem1.itemno)#'+'&custno='+document.getElementById('custno').value+'&reftype=#reftype#');setTimeout('updateVal();',750);ajaxFunction(window.document.getElementById('itembal'),'/default/transaction/ovasexpressbill/balonhand.cfm?itemno=#URLENCODEDFORMAT(getitem1.itemno)#');document.getElementById('desp2').focus();ColdFusion.Window.hide('searchitem');" >SELECT</a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>