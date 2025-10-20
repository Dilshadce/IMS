    <cfquery name="getitem1" datasource="#dts#">
    Select Servi as itemno, desp,0 as ucost,0 as price,'' as aitemno,'' as wos_group,'' as category,'' as sizeid,'' as colorid,0 as price2,'' as remark1 from icservi WHERE
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
    select itemno,desp,ucost,price,aitemno,wos_group,category,sizeid,colorid,price2,remark1 from icitem WHERE 
    1=1
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
    and wos_group like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.groupname)#%" />
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
    
    order by <cfif lcase(hcomid) eq 'tcds_i'>remark1,sizeid,desp<cfelse>itemno</cfif> limit 200
	</cfquery>
    
	<cfoutput>  
    <table width="1000px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <cfif lcase(hcomid) eq "tcds_i">
    <th width="80px">CATEGORY</th>
    <th width="80px">ARTIST</th>
    </cfif>
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
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem1.itemno)#');updateitemdetail('#URLENCODEDFORMAT(getitem1.itemno)#');document.getElementById('expressservicelist').focus();ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem1.itemno#</td>
    <cfif lcase(hcomid) eq "tcds_i">
    <td style="font:'Times New Roman', Times, serif;">#getitem1.category#</td>
    <td style="font:'Times New Roman', Times, serif;">#getitem1.sizeid#</td>
    </cfif>
    <td>#getitem1.desp#</td>
    <cfquery name="getitem" datasource="#dts#">
    select price,ucost from icitem where itemno='#getitem1.itemno#'
    </cfquery>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    <td>#getitembalance1.balance#</td>
    <cfif lcase(hcomid) neq "acht_i">
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem1.itemno)#');updateitemdetail('#URLENCODEDFORMAT(getitem1.itemno)#');document.getElementById('expressservicelist').focus();ColdFusion.Window.hide('searchitem');" >SELECT</a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>