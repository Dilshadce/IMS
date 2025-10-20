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
    <th rowspan="#getsizedesp.recordcount#">Qty<br>PRS</th>
	<th rowspan="#getsizedesp.recordcount#">Unit<br>Price</th>
    <th rowspan="#getsizedesp.recordcount#">Discount Amount</th>
	<th rowspan="#getsizedesp.recordcount#">Amount</th>
	<th rowspan="#getsizedesp.recordcount#">Action</th>
    </tr>
    <cfloop query="getsizedesp">
    <cfif getsizedesp.currentrow neq 1>
    <tr>
    <th>#getsizedesp.sizeid#</th>
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
    </tr>
    </cfif>
    </cfloop>
	<cfloop query='getictran'>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getictran.itemno#');">
		<td>#listgetat(itemno,1,'-')#</td>
        <td></td>
		<td><font face='Arial, Helvetica, sans-serif'>#listgetat(itemno,2,'-')#</font></td>
        <cfquery name="getitemsize" datasource='#dts#'>
        select sizeid from icitem where itemno='#getictran.itemno#' 
        </cfquery>
        <cfquery name="getitemsizedesp" datasource='#dts#'>
        select * from icsizeid where sizeid='#getitemsize.sizeid#' 
        </cfquery>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size1>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size2>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size3>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size4>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size5>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size6>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size7>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size8>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size9>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size10>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size11>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size12>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size13>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size14>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size15>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size16>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size17>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size18>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size19>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size20>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size21>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size22>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size23>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size24>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size25>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size26>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size27>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size28>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size29>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        <td>
        <cfif listgetat(itemno,3,'-') eq getitemsizedesp.size30>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </cfif>
        </td>
        
        <td>
		<font face='Arial, Helvetica, sans-serif'>#qty_bil#</font>
        </td>
        <td><div align='right'><font face='Arial, Helvetica, sans-serif'>#numberFormat(Price_bil,',_.__')#</font></div></td>
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