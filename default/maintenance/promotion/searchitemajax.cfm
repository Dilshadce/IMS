   <cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

   <cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>
   	<cfquery name="getpromo" datasource="#dts#">
    select periodfrom,periodto from promotion where promoid='#url.promoid#'
    </cfquery>
    
    <cfquery name="getpromo2" datasource="#dts#">
    select promoid from promotion where periodfrom='#getpromo.periodfrom#' and periodto='#getpromo.periodto#'
    </cfquery>
    
    <cfset promolist=valuelist(getpromo2.promoid)>
    
     <cfquery name="getpromo3" datasource="#dts#">
    select itemno from promoitem where promoid in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promolist#">)
    </cfquery>

	<cfset itemlist=valuelist(getpromo3.itemno)>
    
    <cfquery name="getitem1" datasource="#dts#">
   
   	<cfif lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "gramas_i">
        select substring_index(itemno,'-',1) as itemno,desp,ucost,price,aitemno from icitem WHERE 
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
        and itemno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
        group by substring_index(itemno,'-',1)
        order by substring_index(itemno,'-',1)
    <cfelse>
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
        <cfif URLDECODE(url.brandname) neq "">
        and brand like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.brandname)#%" />
        </cfif>
        <cfif URLDECODE(url.aitemno) neq "">
        and aitemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.aitemno)#%" />
        </cfif>
        and itemno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
        order by itemno
        limit 50
    </cfif>
    </cfquery>
    
	<cfoutput>  
	<cfset reftype= url.reftype>
    <table width="650px">

    <tr>
    <td colspan="100%" align="right">
    <input name="selectallbtn" id="selectallbtn" type="button" style="cursor:pointer;" onClick="for (k=1;k<=50;k=k+1)
	{	
	document.getElementById('additem_'+k).checked = true
	}" value="Check All Item"/>&nbsp;&nbsp;&nbsp;
    <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmultiitem();ColdFusion.Window.hide('searchitem');" value="Add Selected Item"/>
    </td>
    </tr>

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
  
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem1" >
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
   
    <td><input name="additem_#getitem1.currentrow#" id="additem_#getitem1.currentrow#" type="checkbox" value="#getitem1.itemno#" onclick="
    for (m=1;m<=200;m=m+1)
	{
	if (document.getElementById('btn'+m) == null)
	{
	}
	else
	{	
	document.getElementById('btn'+m).style.visibility='hidden';
	}
	}"/></td>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>