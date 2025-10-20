	<cfquery name="getitem" datasource="#dts#">
    select substring_index(itemno,'-',1) as mitemno,desp,ucost,price,aitemno,wos_group,category,sizeid,colorid,price2 from icitem WHERE 
    1=1
    <cfif URLDECODE(url.itemno) neq "">
    and itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    or aitemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    or barcode like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" /> 
    </cfif>
    <cfif URLDECODE(url.itemname) neq "">
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemname)#%" /> 
    </cfif>
    
    <cfif URLDECODE(url.sizeid) neq "">
    and (sizeid like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.sizeid)#%" />
    or remark1 like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.sizeid)#%" />
    )
    </cfif>
    
     <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
	<cfif Huserloc neq "All_loc">
    and itemno in (select itemno from locqdbf where location='#Huserloc#')
    </cfif>
    and (nonstkitem<>'T' or nonstkitem is null)
    </cfif>
    group by substring_index(itemno,'-',1)
    order by itemno limit 50
	</cfquery>
    
    <cfquery name="getallbal" datasource="#dts#">
     select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from (SELECT itemno,qtybf FROM icitem WHERE 1=1
    <cfif getitem.recordcount neq 0>
        AND (
        <cfloop query="getitem">
        <cfif getitem.currentrow neq 1>
        OR
        </cfif>
        itemno like "#getitem.mitemno#%"
        </cfloop>
        )
        </cfif>
    ) as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and fperiod<>'99'
        <cfif getitem.recordcount neq 0>
        AND (
        <cfloop query="getitem">
        <cfif getitem.currentrow neq 1>
        OR
        </cfif>
        itemno like "#getitem.mitemno#%"
        </cfloop>
        )
        </cfif>
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and fperiod<>'99'
        <cfif getitem.recordcount neq 0>
        AND (
        <cfloop query="getitem">
        <cfif getitem.currentrow neq 1>
        OR
        </cfif>
        itemno like "#getitem.mitemno#%"
        </cfloop>
        )
        </cfif>
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
    </cfquery>
    
	<cfoutput>  
    <table>
    <tr>
    <th width="100px"><div align="center"><font style="text-transform:uppercase">ITEM NO</font></div></th>
    <th width="400px"><div align="left">DESP</div></th>
    <th width="100px"><div align="left">Price</div></th>
    <th colspan="5"><div align="left">Size</div></th>
    </tr>
    <cfloop query="getitem" >
    <tr>
    <td><div align="center">#getitem.mitemno#</div></td>
    <td>#getitem.desp#</td>
    <td><input name="matrixaddprice_#getitem.currentrow#" size="5" id="matrixaddprice_#getitem.currentrow#" value="#getitem.price#" /></td>
    
    <cfquery name="getitemlist" datasource="#dts#">
    	SELECT * FROM(SELECT if(substring_index(itemno,'-',-1)="S","a",if(substring_index(itemno,'-',-1)="M","b",if(substring_index(itemno,'-',-1)="L","c",substring_index(itemno,'-',-1))))as sequen,itemno,substring_index(itemno,'-',-1) as size from icitem WHERE 1=1
        AND itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.mitemno#%" />
        ) as aa order by sequen	
    </cfquery>
    <cfif getitemlist.recordcount eq 1>
    <cfquery name="getitembalance"  dbtype="query">
    SELECT balance FROM getallbal WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#">
    </cfquery>
    <td><input name="additem_#getitem.currentrow#_#getitemlist.currentrow#" id="additem_#getitem.currentrow#_#getitemlist.currentrow#" type="checkbox" value="#getitemlist.itemno#" onclick="itemcheckbox('#getitemlist.itemno#',this,'#getitem.currentrow#');"/>
    @ #getitembalance.balance#
    <input type="text"  style="display:none" name="additemqty_#getitemlist.itemno#" id="additemqty_#getitemlist.itemno#" onchange="matrixupdateqty('#getitemlist.itemno#',this.value)" value="1" size="2"/>
    </td>
    <cfelse>
    <cfloop query="getitemlist">
    <cfquery name="getitembalance"  dbtype="query">
    SELECT balance FROM getallbal WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#">
    </cfquery>
    <td nowrap="nowrap"><input name="additem_#getitem.currentrow#_#getitemlist.currentrow#" id="additem_#getitem.currentrow#_#getitemlist.currentrow#" type="checkbox" value="#getitemlist.itemno#" onclick="itemcheckbox('#getitemlist.itemno#',this,'#getitem.currentrow#');"/>
    #getitemlist.size# @ #getitembalance.balance#
    <input type="text" style="display:none" name="additemqty_#getitemlist.itemno#" id="additemqty_#getitemlist.itemno#" onchange="matrixupdateqty('#getitemlist.itemno#',this.value)" value="1" size="2"/>
    </td>
    </cfloop>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>