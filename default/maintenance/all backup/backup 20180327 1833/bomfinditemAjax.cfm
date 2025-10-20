	
	<cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by itemno limit 500
	</cfquery>
	<cfoutput>  
    <table width="780px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">DESP</th>
    <th width="300px">Existing Bom No</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <cfquery name="getbomdata" datasource="#dts#">
	SELECT bomno FROM billmat where itemno='#getitemno.xitemno#' group by bomno ORDER BY bomno
	</cfquery>
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td>#valuelist(getbomdata.bomno)#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getitemno.xitemno#','sitemno');ColdFusion.Window.hide('finditem2');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>