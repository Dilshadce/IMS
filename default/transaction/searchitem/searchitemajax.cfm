	<cfquery name="getdisplay" datasource="#dts#">
	select * from displaysetup
	</cfquery>

	<cfset defaultfontsize = "12px">

    <cfquery name="getitem1" datasource="#dts#">
    Select Servi as itemno, desp,0 as ucost,0 as price,'' as aitemno,'' as wos_group,'' as category,'' as sizeid,'' as colorid,0 as price2,"" as fcurrcode,0 as fprice,0 as fucost<cfloop from="2" to="10" index="i">,"" as fcurrcode#i#,0 as fprice#i#,0 as fucost#i#</cfloop> from icservi WHERE
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
    select itemno,desp,ucost,price,aitemno,wos_group,category,sizeid,colorid,price2,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="i">,fcurrcode#i#,fprice#i#,fucost#i#</cfloop> from icitem WHERE 
    1=1
    <cfif Hitemgroup neq ''>
        and wos_group='#Hitemgroup#'
    </cfif>
    <cfif URLDECODE(url.itemno) neq "">
    and itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    or aitemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    or barcode like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    </cfif>
    <cfif URLDECODE(url.itemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" /> 
    </cfif>
    <cfif URLDECODE(url.leftitemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.leftitemname)#%" />
    </cfif>
    <cfif URLDECODE(url.groupname) neq "">
    and wos_group like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(trim(url.groupname))#%" />
    </cfif>
    <cfif URLDECODE(url.catename) neq "">
    and category like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.catename)#%" />
    </cfif>
    
    <cfif URLDECODE(url.colorname) neq "">
    and colorid like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.colorname)#%" />
    </cfif>
    
    <cfif URLDECODE(url.sizename) neq "">
    and (sizeid like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.sizename)#%" />
    or remark1 like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.sizename)#%" />
    )
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
    and (nonstkitem<>'T' or nonstkitem is null)
    </cfif>
    
    order by itemno limit 200
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <cfif getpin2.h1360 eq 'T'> 
   	<cfif getdisplay.itemsearch_ucost eq 'Y'>
   	<th width="50px"><font style="text-transform:uppercase; font-size:#defaultfontsize#">UCOST</font></th>
   	</cfif>
   	<cfif getdisplay.itemsearch_price eq 'Y'>
    <th width="50px"><font style="text-transform:uppercase; font-size:#defaultfontsize#">PRICE</font></th>
    </cfif>
    </cfif>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem1" >
    
    <cfif getpin2.h1360 eq 'T'>
    
    <cfif trim(url.currcode) neq "">
    <cfif url.currcode eq getitem1.fcurrcode>
	<cfset getitem1.price=getitem1.fprice>
    <cfset getitem1.ucost=getitem1.fucost>
    </cfif>
    
    <cfloop from="2" to="10" index="i">
    <cfif url.currcode eq evaluate('getitem1.fcurrcode#i#')>
    <cfset getitem1.price= evaluate('getitem1.fprice#i#')>
    <cfset getitem1.ucost= evaluate('getitem1.fucost#i#')>
    </cfif>
    </cfloop>
    </cfif>
    
    </cfif>
    
    <tr>
    <td>#getitem1.itemno#</td>
    <td>#getitem1.desp#</td>
    <cfif getpin2.h1360 eq 'T'> 
   	<cfif getdisplay.itemsearch_ucost eq 'Y'>
   	<td>#getitem1.ucost#</td>
    </cfif>
   	<cfif getdisplay.itemsearch_price eq 'Y'>
    <td>#getitem1.price#</td>
    </cfif>
    </cfif>
    
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectitem('#URLEncodedFormat(getitem1.itemno)#');ColdFusion.Window.hide('searchitem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>