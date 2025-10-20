<cfinclude template = "/CFC/convert_single_double_quote_script2.cfm">
<cfoutput>
<cfform action="itemdespprocess.cfm" method="post" name="ccformitemdesp"  id="ccformitemdesp">
<cfquery name="getitemdesp" datasource="#dts#">
select desp,despa,comment,gltradac,price,itemno from ictran where refno='#url.refno#' and type='#url.tran#' and trancode='#url.trancode#'
</cfquery>
<table width="570px" >
<tr>
<th colspan="100%"><div align="center">Item Detail</div></th>
</tr>
<tr>
<td width="250px"  height="30px">Description</td>
<td width="20px" style="font-size:16px;">:</td>
<td width="300px" align="left" style="font-size:16px;">

<cfinput type="text" name="itemdesp" id="itemdesp" value="#convertquote(getitemdesp.desp)#" maxlength="60" size="60" onKeyUp="nextIndex(event,'itemdesp','itemdesp2');" />

<cfinput type="hidden" name="itemdesprefno" id="itemdesprefno" value="#url.refno#" maxlength="60" size="60" />
<cfinput type="hidden" name="itemdesptran" id="itemdesptran" value="#url.tran#" maxlength="60" size="60" />
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
<tr>
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