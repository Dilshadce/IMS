<cfinclude template = "/CFC/convert_single_double_quote_script2.cfm">
<cfoutput>
<cfform action="itemdespprocess.cfm" method="post" name="ccformitemdesp"  id="ccformitemdesp">
<cfquery name="getitemdesp" datasource="#dts#">
select desp,despa,comment,gltradac,rem10,price,itemno from ictrantemp where uuid='#url.uuid#' and trancode='#url.trancode#'
</cfquery>
<table width="570px" >
<tr>
<th colspan="100%"><div align="center">Item Detail</div></th>
</tr>
<cfif getitemdesp.rem10 neq "">
<tr>
<td style="font-size:16px;">Item No</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;">
<cfquery name="getsamepriceitem" datasource="#dts#">
SELECT itemno,desp,despa FROM icitem WHERE price = "#getitemdesp.price#" or itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemdesp.itemno#"> order by itemno
</cfquery>
<select name="itemdetailitemno" id="itemdetailitemno" onchange="document.getElementById('itemdesp').value=this.options[this.selectedIndex].id;document.getElementById('itemdesp2').value=this.options[this.selectedIndex].title">
<cfloop query="getsamepriceitem">
<option value="#getsamepriceitem.itemno#" id="#getsamepriceitem.desp#" title="#getsamepriceitem.despa#" <cfif getsamepriceitem.itemno eq getitemdesp.itemno>Selected</cfif>>#getsamepriceitem.itemno# - #getsamepriceitem.desp#</option>
</cfloop>
</select>
</td>
</tr>
</cfif>
<tr>
<td width="250px"  height="30px">Description</td>
<td width="20px" style="font-size:16px;">:</td>
<td width="300px" align="left" style="font-size:16px;">

<cfinput type="text" name="itemdesp" id="itemdesp" value="#convertquote(getitemdesp.desp)#" maxlength="60" size="60" onKeyUp="nextIndex(event,'itemdesp','itemdesp2');" />

<cfinput type="hidden" name="itemdespuuid" id="itemdespuuid" value="#url.uuid#" maxlength="60" size="60" />
<input type="hidden" name="itemdesptrancodenew" id="itemdesptrancodenew" value="#url.trancode#" maxlength="60" size="60" />
</td>
</tr>
<tr>
<td width="250px" style="font-size:16px;" height="30px"></td>
<td width="20px" style="font-size:16px;"></td>
<td width="300px" align="left" style="font-size:16px;"><input type="text" name="itemdesp2" id="itemdesp2" value="#convertquote(getitemdesp.despa)#" maxlength="60" size="60" onKeyUp="nextIndex(event,'itemdesp2','itemcomment');" /></td>
</tr>
<tr>
<td style="font-size:16px; color:##000;">Comment</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<textarea name='itemcomment' id="itemcomment" tabindex="3" cols='60' rows='5'>#tostring(getitemdesp.comment)#</textarea>
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px; color:##000;">Gl Acc</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="left">
<cfinput type="text" name="glt6" id="glt6" value="#convertquote(getitemdesp.gltradac)#" maxlength="10" size="10" mask="9999/999" />
<cfif Hlinkams eq "Y"><a onclick="ColdFusion.Window.show('findglacc');"><img src="/images/down.png" /></a></cfif>
</td>
</tr>

<tr>
<td align="center" colspan="3"><input type="submit" name="itemdespbtn" id="itemdespbtn" value="Accept"/></td>
</tr>
</table>
</cfform>

</cfoutput>