<cfsetting showdebugoutput="no">

<cfquery name="getgsetup2" datasource="#dts#">
	select 
	concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,
	Decl_Uprice as Decl_Uprice1, DECL_DISCOUNT as DECL_DISCOUNT1,
	concat('.',repeat('_',Decl_Discount)) as Decl_Discount
	from gsetup2
</cfquery>

<cfset stDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_Discount = getgsetup2.Decl_Discount>

<cfset uuid = url.uuid>
<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    </cfif>
	order by location;
</cfquery>

<cfquery datasource="#dts#" name="getjob">
	select * from project where porj='J'
</cfquery>

<cfquery datasource="#dts#" name="getunit">
	select * from unit
</cfquery>

<cfquery datasource="#dts#" name="getgsetup">
	select * from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getdisplay">
	select * from displaysetup
</cfquery>
<cfoutput>
<table width="100%">
<tr>
<th width="2%">No</th>
<cfif getdisplay.simple_itemno eq 'Y'><th width="15%">Item Code</th></cfif>
<cfif getdisplay.simple_desp eq 'Y'><th width="30%">Description</th></cfif>
<cfif getdisplay.simple_job eq 'Y'><th width="10%" >#getgsetup.ljob#</th></cfif>
<cfif getdisplay.simple_brem1 eq 'Y'><th width="10%" >#getgsetup.brem1#</th></cfif>
<th width="10%" <cfif getdisplay.simple_brand neq 'Y'>style="display:none"</cfif>>Brand</th>
<th width="10%" <cfif getdisplay.simple_group neq 'Y'>style="display:none"</cfif>>#getgsetup.lgroup#</th>
<th width="10%" <cfif getdisplay.simple_category neq 'Y'>style="display:none"</cfif>>#getgsetup.lcategory#</th>
<th width="10%" <cfif getdisplay.simple_model neq 'Y'>style="display:none"</cfif>>#getgsetup.lmodel#</th>
<th width="10%" <cfif getdisplay.simple_rating neq 'Y'>style="display:none"</cfif>>#getgsetup.lrating#</th>
<th width="10%" <cfif getdisplay.simple_sizeid neq 'Y'>style="display:none"</cfif>>#getgsetup.lsize#</th>
<th width="10%" <cfif getdisplay.simple_material neq 'Y'>style="display:none"</cfif>>#getgsetup.lmaterial#</th>
<cfif getdisplay.simple_qty eq 'Y'><th width="10%" >Quantity</th></cfif>
<th>Unit</th>
<cfif getdisplay.simple_freeqty eq 'Y'><th width="10%" >Free Quantity</th></cfif>
<cfif getdisplay.simple_packing eq 'Y'><th width="8%" >Packing</th></cfif>
<cfif getdisplay.simple_price eq 'Y'><th width="8%" >Price</th></cfif>
<cfif dts eq "tcds_i" and url.type eq "RC">
<cfif getdisplay.simple_price eq 'Y'><th width="8%" >Selling Price</th></cfif>
</cfif>
<cfif getdisplay.simple_disc eq 'Y'><th width="8%" >Discount</th></cfif>
<cfif getdisplay.simple_amt eq 'Y'><th width="8%" >Amount</th></cfif>
<th width="10%">Action</th>
</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT itemno,desp,source,job,brem1,brem2,brem3,brem4,location,type,refno,wos_group,category,sum(qty) as qty,sum(qty_bil) as qty_bil,price,price_bil,sum(amt) as amt,sum(amt_bil) as amt_bil,TRANCODE,rem10,rem9,PROMOTION,unit_bil FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> group by itemno,price_bil order by trancode
</cfquery>
<cfloop query="getictrantemp">

<cfquery name="getiteminfo" datasource="#dts#">
select sizeid,colorid,brand,category,wos_group,shelf,costcode from icitem where itemno='#getictrantemp.itemno#'
</cfquery>

<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<cfif getdisplay.simple_itemno eq 'Y'><td nowrap ><a onmouseover="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');">#getictrantemp.itemno#</a></td></cfif>
<cfif getdisplay.simple_desp eq 'Y'><td nowrap ><a onmouseover="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');"><cfif getictrantemp.rem10 neq "">(PACKAGE : #getictrantemp.rem10#) </cfif>#getictrantemp.desp#</a></td></cfif>


<cfif getdisplay.simple_job eq 'Y'><td nowrap>
<select name="joblist#getictrantemp.trancode#" id="joblist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a #getgsetup.ljob#</option>
<cfloop query="getjob">
<option value="#getjob.source#" <cfif getictrantemp.job eq getjob.source>selected</cfif>>#getjob.source#</option>
</cfloop>
</select>
</td></cfif>


<cfif getdisplay.simple_brem1 eq 'Y'>
<td>
<cfif lcase(HcomID) eq "hodaka_i" and type eq 'PO'>
<cfquery name="gethodakaso" datasource="#dts#">
select refno from ictran where type='SO' and itemno='#getictrantemp.itemno#' and refno not in (select brem1 from ictran where type='PO' and itemno='#getictrantemp.itemno#')
</cfquery>
<select name="brem1list#getictrantemp.trancode#" id="brem1list#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose an SO NO</option>
<cfloop query="gethodakaso">
<option value="#gethodakaso.refno#">#gethodakaso.refno#</option>
</cfloop>
</select>
<cfelse>
<input type="text" name="brem1list#getictrantemp.trancode#" id="brem1list#getictrantemp.trancode#" value="#getictrantemp.brem1#" onBlur="updaterow('#getictrantemp.trancode#');" />
</cfif>
</td>
</cfif>
<td width="10%" <cfif getdisplay.simple_brand neq 'Y'>style="display:none"</cfif>>#getiteminfo.brand#</td>
<td width="10%" <cfif getdisplay.simple_group neq 'Y'>style="display:none"</cfif>>#getiteminfo.wos_group#</td>
<td width="10%" <cfif getdisplay.simple_category neq 'Y'>style="display:none"</cfif>>#getiteminfo.category#</td>
<td width="10%" <cfif getdisplay.simple_model neq 'Y'>style="display:none"</cfif>>#getiteminfo.shelf#</td>
<td width="10%" <cfif getdisplay.simple_rating neq 'Y'>style="display:none"</cfif>>#getiteminfo.costcode#</td>
<td width="10%" <cfif getdisplay.simple_sizeid neq 'Y'>style="display:none"</cfif>>#getiteminfo.sizeid#</td>
<td width="10%" <cfif getdisplay.simple_material neq 'Y'>style="display:none"</cfif>>#getiteminfo.colorid#</td>

<cfif getdisplay.simple_qty eq 'Y'><td nowrap align="right" ><cfif type eq 'QUO'>
<input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
<cfelse>
<input type="hidden" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
#getictrantemp.qty_bil#
<input type="button" name="multilocationbtn" id="multilocationbtn" value="Multi Location" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('multilocationwindow');"/>
</cfif></td></cfif>
<cfif getdisplay.simple_freeqty eq 'Y'>
<cfquery name="getpacking" datasource="#dts#">
select * from icitem where itemno='#getictrantemp.itemno#'
</cfquery>

<cfset validfree = 0>
<cfset itemfreeqty = 0>
<cfset promoqtyamt = getictrantemp.qty>
<cfif getpacking.packingqty1 eq 0>
<cfset getpacking.packingqty1=1>
</cfif>
<cfif getpacking.packingqty2 eq 0>
<cfset getpacking.packingqty2=1>
</cfif>
<cfif getpacking.packingqty3 eq 0>
<cfset getpacking.packingqty3=1>
</cfif>
<cfif getpacking.packingqty4 eq 0>
<cfset getpacking.packingqty4=1>
</cfif>
<cfif getpacking.packingqty5 eq 0>
<cfset getpacking.packingqty5=1>
</cfif>
			<cfif getictrantemp.promotion eq 1>
            <cfif getictrantemp.qty gte getpacking.packingqty1>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty1)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty1)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 2>
            <cfif getictrantemp.qty gte getpacking.packingqty2>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty2)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty2)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 3>
            <cfif getictrantemp.qty gte getpacking.packingqty3>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty3)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty3)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 4>
            <cfif getictrantemp.qty gte getpacking.packingqty4>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty4)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty4)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 5>
            <cfif getictrantemp.qty gte getpacking.packingqty5>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty5)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty5)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 6>
            <cfif getictrantemp.qty gte getpacking.packingqty6>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty6)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty6)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 7>
            <cfif getictrantemp.qty gte getpacking.packingqty7>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty7)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty7)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 8>
            <cfif getictrantemp.qty gte getpacking.packingqty8>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty8)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty8)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 9>
            <cfif getictrantemp.qty gte getpacking.packingqty9>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty9)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty9)>
            </cfif>
            <cfelseif getictrantemp.promotion eq 10>
            <cfif getictrantemp.qty gte getpacking.packingqty10>
            <cfset leftcontrol = promoqtyamt / val(getpacking.packingqty10)>
            <cfset validfree = int(leftcontrol) >
            <cfset itemfreeqty = validfree * val(getpacking.packingfreeqty10)>
            </cfif>
            </cfif>
            <cfif getpin2.h2J02 eq "T">
            <td onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('updatefreeqty');getfocus8();" nowrap align="right"><a   style="cursor:pointer">
            <cfif val(getictrantemp.rem11) neq 0>#val(getictrantemp.rem11)#<cfelse>#itemfreeqty#</cfif>
            </a></td>
            <cfelse>
            <td nowrap align="right"><a   style="cursor:pointer">
            <cfif val(getictrantemp.rem11) neq 0>#val(getictrantemp.rem11)#<cfelse>#itemfreeqty#</cfif>
            </a></td>
            </cfif>
            </cfif>
            
            <td>
            <select name="unitlist#getictrantemp.trancode#" id="unitlist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
            <option value="">Choose a Unit</option>
            <cfloop query="getunit">
            <option value="#getunit.unit#" <cfif getictrantemp.unit_bil eq getunit.unit>selected</cfif>>#getunit.unit#</option>
            </cfloop>
            </select>
            
            </td>
            

<cfif getdisplay.simple_packing eq 'Y'><td nowrap align="right">
<select name="promotiontype#getictrantemp.trancode#" id="promotiontype#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
		<option value="" <cfif getictrantemp.promotion eq ''>selected</cfif>></option>
        <option value="1" <cfif getictrantemp.promotion eq '1'>selected</cfif>>#ucase(getpacking.packingdesp1)#</option>
        <option value="2" <cfif getictrantemp.promotion eq '2'>selected</cfif>>#ucase(getpacking.packingdesp2)#</option>
        <option value="3" <cfif getictrantemp.promotion eq '3'>selected</cfif>>#ucase(getpacking.packingdesp3)#</option>
        <option value="4" <cfif getictrantemp.promotion eq '4'>selected</cfif>>#ucase(getpacking.packingdesp4)#</option>
        <option value="5" <cfif getictrantemp.promotion eq '5'>selected</cfif>>#ucase(getpacking.packingdesp5)#</option>
        <option value="6" <cfif getictrantemp.promotion eq '6'>selected</cfif>>#ucase(getpacking.packingdesp6)#</option>
        <option value="7" <cfif getictrantemp.promotion eq '7'>selected</cfif>>#ucase(getpacking.packingdesp7)#</option>
        <option value="8" <cfif getictrantemp.promotion eq '8'>selected</cfif>>#ucase(getpacking.packingdesp8)#</option>
        <option value="9" <cfif getictrantemp.promotion eq '9'>selected</cfif>>#ucase(getpacking.packingdesp9)#</option>
        <option value="10" <cfif getictrantemp.promotion eq '10'>selected</cfif>>#ucase(getpacking.packingdesp10)#</option>
        </select>
        </td></cfif>

<cfif getdisplay.simple_price eq 'Y'><td nowrap align="right"><cfif getpin2.h2J01 eq "T"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictrantemp.price_bil),stDecl_UPrice)#</a><cfelse>#numberformat(val(getictrantemp.price_bil),stDecl_UPrice)#</cfif></td></cfif>
<cfif dts eq "tcds_i" and url.type eq "RC">
<cfif getdisplay.simple_price eq 'Y'>
<td nowrap align="right"><cfif getpin2.h2J01 eq "T"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changesellingprice');getfocus4();">#numberformat(val(getictrantemp.rem8),',.__')#</a><cfelse>#numberformat(val(getictrantemp.rem8),',.__')#</cfif></td></cfif>
</cfif>
<cfif getdisplay.simple_disc eq 'Y'><td nowrap align="right"><input type="text" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" ></td></cfif>
<cfif getdisplay.simple_amt eq 'Y'><td nowrap align="right" >
#numberformat(val(getictrantemp.amt_bil),',.__')#</td></cfif>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#')" value="UPDATE" style="display:none"/> ---></td>

<td>
<cfif getdisplay.simple_location neq 'Y'>

</cfif>
<cfif getdisplay.simple_job neq 'Y'>
<input type="hidden" name="joblist#getictrantemp.trancode#" id="joblist#getictrantemp.trancode#" value="#getictrantemp.job#" />
</cfif>

<cfif getdisplay.simple_brem1 neq 'Y'>
<input type="hidden" name="brem1list#getictrantemp.trancode#" id="brem1list#getictrantemp.trancode#" value="#getictrantemp.brem1#" />
</cfif>

<cfif getdisplay.simple_qty neq 'Y'>
<input type="hidden" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" />
</cfif>
<cfif getdisplay.simple_packing neq 'Y'>
<input type="hidden" name="promotiontype#getictrantemp.trancode#" id="promotiontype#getictrantemp.trancode#" value="#getictrantemp.promotion#" />
</cfif>
<cfif getdisplay.simple_disc neq 'Y'>
<input type="hidden" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" />
</cfif></td>

</tr>
</cfloop>

</table>
</cfoutput>
