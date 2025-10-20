<cfsetting showdebugoutput="no">

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getgsetup2" datasource='#dts#'>
	select concat(',.',(repeat('_',decl_uprice))) as decl_uprice 
	from gsetup2
</cfquery>

<cfquery name="getrecordcount" datasource="#dts#">
	select count(itemno) as totalrecord 
	from icitem 
	order by wos_date
</cfquery>
<cfif url.type neq "TR">
<cfquery name='getictran' datasource='#dts#'>
		select * from ictrantemp where type ="#url.type#" and uuid='#url.uuid#'
	</cfquery>
    <cfelse>
    <cfquery name='getictran' datasource='#dts#'>
		select * from ictrantemp where type ="TROU" and uuid='#url.uuid#'
	</cfquery>
    </cfif>
    <cfset tran=url.type>
    <cfset wpitemtax="">
<cfoutput>
	<cfquery name="getsizedesp" datasource="#dts#">
select * from icsizeid 
</cfquery>
<table align="middle" class="data" width="1000px">
    <tr> 
	<th rowspan="#getsizedesp.recordcount#">Article</th>
    <th rowspan="#getsizedesp.recordcount#">Colour</th>
    <th>#getsizedesp.sizeid#</th>
    <cfif lcase(hcomid) eq "didachi_i">
    <th>#getsizedesp.size1#</th>
    <th>#getsizedesp.size2#</th>
    <th>#getsizedesp.size3#</th>
    <th>#getsizedesp.size4#</th>
    <th>#getsizedesp.size5#</th>
    <th>#getsizedesp.size6#</th>
    <th>#getsizedesp.size7#</th>
    <th>#getsizedesp.size8#</th>
    <th>#getsizedesp.size9#</th>
    <th>#getsizedesp.size10#</th>
    <cfelse>
    <th>#getsizedesp.size1#</th>
    <th>#getsizedesp.size2#</th>
    <th>#getsizedesp.size3#</th>
    <th>#getsizedesp.size4#</th>
    <th>#getsizedesp.size5#</th>
    <th>#getsizedesp.size6#</th>
    <th>#getsizedesp.size7#</th>
    <th>#getsizedesp.size8#</th>
    <th>#getsizedesp.size9#</th>
    <th>#getsizedesp.size10#</th>
    <th>#getsizedesp.size11#</th>
    <th>#getsizedesp.size12#</th>
    <th>#getsizedesp.size13#</th>
    <th>#getsizedesp.size14#</th>
    <th>#getsizedesp.size15#</th>
    <th>#getsizedesp.size16#</th>
    <th>#getsizedesp.size17#</th>
    <th>#getsizedesp.size18#</th>
    <th>#getsizedesp.size19#</th>
    <th>#getsizedesp.size20#</th>
    <th>#getsizedesp.size21#</th>
    <th>#getsizedesp.size22#</th>
    <th>#getsizedesp.size23#</th>
    <th>#getsizedesp.size24#</th>
    <th>#getsizedesp.size25#</th>
    <th>#getsizedesp.size26#</th>
    <th>#getsizedesp.size27#</th>
    <th>#getsizedesp.size28#</th>
    <th>#getsizedesp.size29#</th>
    <th>#getsizedesp.size30#</th>
    </cfif>
    <th rowspan="#getsizedesp.recordcount#">Qty<br>PRS</th>
	<th rowspan="#getsizedesp.recordcount#">Unit<br>Price</th>
    <cfif lcase(hcomid) eq "didachi_i">
    <th rowspan="#getsizedesp.recordcount#">Discount %</th>
    </cfif>
    <th rowspan="#getsizedesp.recordcount#">Discount Amount</th>
	<th rowspan="#getsizedesp.recordcount#">Amount</th>
	<th rowspan="#getsizedesp.recordcount#">Action</th>
    </tr>
    <cfloop query="getsizedesp">
    <cfif getsizedesp.currentrow neq 1>
    <tr>
    <th>#getsizedesp.sizeid#</th>
    <cfif lcase(hcomid) eq "didachi_i">
    <th>#getsizedesp.size1#</th>
    <th>#getsizedesp.size2#</th>
    <th>#getsizedesp.size3#</th>
    <th>#getsizedesp.size4#</th>
    <th>#getsizedesp.size5#</th>
    <th>#getsizedesp.size6#</th>
    <th>#getsizedesp.size7#</th>
    <th>#getsizedesp.size8#</th>
    <cfelse>
    <th>#getsizedesp.size1#</th>
    <th>#getsizedesp.size2#</th>
    <th>#getsizedesp.size3#</th>
    <th>#getsizedesp.size4#</th>
    <th>#getsizedesp.size5#</th>
    <th>#getsizedesp.size6#</th>
    <th>#getsizedesp.size7#</th>
    <th>#getsizedesp.size8#</th>
    <th>#getsizedesp.size9#</th>
    <th>#getsizedesp.size10#</th>
    <th>#getsizedesp.size11#</th>
    <th>#getsizedesp.size12#</th>
    <th>#getsizedesp.size13#</th>
    <th>#getsizedesp.size14#</th>
    <th>#getsizedesp.size15#</th>
    <th>#getsizedesp.size16#</th>
    <th>#getsizedesp.size17#</th>
    <th>#getsizedesp.size18#</th>
    <th>#getsizedesp.size19#</th>
    <th>#getsizedesp.size20#</th>
    <th>#getsizedesp.size21#</th>
    <th>#getsizedesp.size22#</th>
    <th>#getsizedesp.size23#</th>
    <th>#getsizedesp.size24#</th>
    <th>#getsizedesp.size25#</th>
    <th>#getsizedesp.size26#</th>
    <th>#getsizedesp.size27#</th>
    <th>#getsizedesp.size28#</th>
    <th>#getsizedesp.size29#</th>
    <th>#getsizedesp.size30#</th>
    </cfif>
    </tr>
    </cfif>
    </cfloop>
	<cfloop query='getictran'>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getictran.itemno#');">
		<td><cftry>#listgetat(itemno,1,'-')#<cfcatch>#itemno#</cfcatch></cftry></td>
		<td><font face='Arial, Helvetica, sans-serif'><cftry><cfif lcase(hcomid) eq "didachi_i">
        <cfquery name="getcolor" datasource="#dts#">
        	select desp from iccolor2 where colorno="#listgetat(itemno,2,'-')#"
        </cfquery>
        #getcolor.desp#
        <cfelse>#listgetat(itemno,2,'-')#</cfif><cfcatch></cfcatch></cftry></font></td>
        <td></td>
        <cfquery name="getitemsize" datasource='#dts#'>
        select sizeid from icitem where itemno='#getictran.itemno#' 
        </cfquery>
        <cfquery name="getitemsizedesp" datasource='#dts#'>
        select * from icsizeid where sizeid='#getitemsize.sizeid#' 
        </cfquery>
        <cftry>
        <cfif lcase(hcomid) eq "didachi_i">
        <cfloop from="1" to="10" index="i">
        <td align="center">
        
        <cfif listgetat(itemno,3,'-') eq evaluate('getitemsizedesp.size#i#')>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        
        </td>
        </cfloop>
        
        <cfelse>
        <cfloop from="1" to="30" index="i">
        <td align="center">
        
        <cfif listgetat(itemno,3,'-') eq evaluate('getitemsizedesp.size#i#')>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        
        </td>
        </cfloop>
        </cfif>
        <cfcatch>
        </cfcatch></cftry>
        
        
       
        
        <td align="center">
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </td>
        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(Price_bil,',_.__')#</font></div></td>
        <cfif lcase(hcomid) eq "didachi_i">
        <td nowarp><div align='right'><font face='Arial, Helvetica, sans-serif'>#dispec1#%+#dispec2#%+#dispec3#%</font></div></td>
        </cfif>
        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(disamt_bil,',_.__')#</font></div></td>
		<td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(amt_bil,',_.__')#</font></div></td>
       

		<td>
        <div align="center">
        <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ColdFusion.Window.show('edititem');">EDIT</a></div></td>
        <td><div align="center"><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ajaxFunction(document.getElementById('ajaxField2'),'deleteproductsAjax.cfm?type=#url.type#&uuid=#url.uuid#&itemno=#URLENCODEDFORMAT(getictran.itemno)#');setTimeout('refreshlist();',1000);setTimeout('recalculateamt();',1000);">DELETE</a></div>
				
                
                </td><div id="ajaxField2" name="ajaxField2">
                </div>
	</tr>
    
   	</cfloop>
    <cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>
    <input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />
    	</table>
        
        </cfoutput>