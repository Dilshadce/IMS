    <cfquery name="getitem1" datasource="#dts#">
    <!---Select Servi as itemno, desp,0 as ucost,0 as price,'' as aitemno from icservi WHERE
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
    union all--->
    select itemno,desp,ucost,price,aitemno from icitem WHERE 
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
    <cfif URLDECODE(url.aitemno) neq "">
    and aitemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.aitemno)#%" />
    </cfif>
     <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
	<cfif Huserloc neq "All_loc">
    and itemno in (select itemno from locqdbf where location='#Huserloc#')
    </cfif>
    </cfif>
    and (nonstkitem <> "T" or nonstkitem is null)
    order by itemno limit 50
	</cfquery>
    
	<cfoutput>  
	<cfset reftype= url.reftype>
    <table width="650px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">PRODUCT CODE</font></th>
    <th width="300px">NAME</th>
    <cfif getpin2.h1360 eq 'T'>
    <th width="50px">UCOST</th>
    <th width="50px">PRICE</th>
    <cfif lcase(hcomid) neq "kjcpl_i" or lcase(hcomid) neq "mlpl_i" or lcase(hcomid) neq "viva_i">
    <th width="50px">QTY ON HAND</th>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem1" >
    <cfif getpin2.h1360 eq 'T'>
    <cfquery name="getitembalance1" datasource="#dts#">
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
		and itemno='#getitem1.itemno#' 
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
		and itemno='#getitem1.itemno#' 
        and location="#Huserloc#"
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getitem1.itemno#' 
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
    </cfif>
    </cfquery>
    </cfif>
    <tr id="tr#getitem1.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem1.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem1.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem1.itemno#</td>
    <td>#getitem1.aitemno#</td>
    <td>#getitem1.desp#</td>
    <cfif getpin2.h1360 eq 'T'>
    <td>#lsnumberformat(getitem1.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem1.price,',_.__')#</td>
    <cfif lcase(hcomid) neq "kjcpl_i" or lcase(hcomid) neq "mlpl_i" or lcase(hcomid) neq "viva_i">
    <td>#getitembalance1.balance#</td>
    </cfif>
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <td><input name="btn#getitem1.currentrow#" id="btn#getitem1.currentrow#" type="button" style="background:none; border:none; cursor:pointer;"  onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem1.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem1.itemno)#');<!--- document.getElementById('<cfif lcase(hcomid) eq "hairo_i">expressservicelist<cfelse>desp2</cfif>').focus(); --->ColdFusion.Window.hide('searchitem');" value="SELECT" onfocus="document.getElementById('tr#getitem1.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem1.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem1.currentrow neq getitem1.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem1.currentrow)+1#').focus()}</cfif> <cfif getitem1.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem1.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif>" /></td>
    </cfif>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>