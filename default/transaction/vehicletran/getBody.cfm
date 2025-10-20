<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>

<cfquery name="getgsetup" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>

<cfquery name="getcategory" datasource="#dts#">
SELECT * FROM iccate order by cate
</cfquery>

<cfquery name="getproject" datasource="#dts#">
SELECT * FROM #target_project# where porj='P' order by source
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
SELECT * FROM icgroup order by wos_group
</cfquery>

<cfquery name="getsupp" datasource="#dts#">
SELECT custno,name FROM #target_apvend# order by custno
</cfquery>

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
<cfoutput>
<table width="100%">
<tr>
<th width="2%">No</th>
<th width="15%">Item Code</th>
<!---<th width="10%">#getgsetup.laitemno#</th>--->
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>S/N</th>
<th width="30%">Description</th>
<th width="10%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Status</th>
<th width="10%">Location</th>
<th width="10%">Quantity</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>Deductable Item</th>

<th width="8%">Price</th>
<th width="8%">Discount</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>No Display</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>SubTotal</th>
<th width="8%" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>>Mechanic</th>
<th width="8%" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>Department</th>
<th width="8%" style="display:none">Supp</th>

<th width="8%">Amount</th>
<th width="10%">Action</th>
</tr>
<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode
</cfquery>
<cfloop query="getictrantemp">
<tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictrantemp.currentrow#</td>
<td nowrap>#getictrantemp.itemno#</td>
<cfquery name="getaitem" datasource="#dts#">
   		select aitemno from icitem where itemno='#getictrantemp.itemno#'
	</cfquery>
<!---<td nowrap>#getaitem.aitemno#</td>--->
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><input type="text" name="brem1#getictrantemp.trancode#" id="brem1#getictrantemp.trancode#" value="#getictrantemp.brem1#" size="5" onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem1#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td nowrap><a onmouseover="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('itemdesp');">#getictrantemp.desp#</a></td>
<cfif getictrantemp.location eq ''>
<cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getictrantemp.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getictrantemp.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getictrantemp.itemno#' 
    </cfquery>
<cfelse>
<cfquery name="getitembalance" datasource="#dts#">
	select 
	c.balance 
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		and itemno='#getictrantemp.itemno#' 
		and location = '#getictrantemp.location#' 

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
			and itemno='#getictrantemp.itemno#' 
			and location = '#getictrantemp.location#'

			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU','SO') 
		and (toinv='' or toinv is null) 
			and fperiod<>'99'
			and itemno='#getictrantemp.itemno#' 
			and location = '#getictrantemp.location#' 
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#getictrantemp.itemno#' 

		and a.location = '#getictrantemp.location#'

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location = '#getictrantemp.location#'
    and a.itemno='#getictrantemp.itemno#' 
	order by a.itemno;
</cfquery>
</cfif>

<td nowrap <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif val(getitembalance.balance) gt 0>STK<cfelse>IND</cfif></td>
<td nowrap>
<select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getictrantemp.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</td>

<td nowrap align="right"><input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}"></td>
<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>
        <select name="deductitemlist#getictrantemp.trancode#" id="deductitemlist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="Y" <cfif getictrantemp.deductableitem eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictrantemp.deductableitem eq 'N' or getictrantemp.deductableitem eq ''>selected</cfif>>N</option>
</select>
        </td>


<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictrantemp.price_bil),',.__')#</a></td>
<td nowrap align="right"><input type="text" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" ></td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="nodisplaylist#getictrantemp.trancode#" id="nodisplaylist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="Y" <cfif getictrantemp.nodisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictrantemp.nodisplay eq 'N' or getictrantemp.nodisplay eq ''>selected</cfif>>N</option>
</select>
        </td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="subtotallist#getictrantemp.trancode#" id="subtotallist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="Y" <cfif getictrantemp.totalupdisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictrantemp.totalupdisplay eq 'N' or getictrantemp.totalupdisplay eq ''>selected</cfif>>N</option>
</select>
        </td>

<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><select name="grouplist#getictrantemp.trancode#" id="grouplist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#" <cfif getictrantemp.brem2 eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group#</option>
</cfloop>
</select></td>

<td nowrap align="right" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>><select name="catelist#getictrantemp.trancode#" id="catelist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#" <cfif getictrantemp.source eq getproject.source>selected</cfif>>#getproject.source#</option>
</cfloop>
</select></td>

<td nowrap align="right" style="display:none"><select name="supplist#getictrantemp.trancode#" id="supplist#getictrantemp.trancode#" onChange="updaterow('#getictrantemp.trancode#');">
<option value="">Choose a Supp</option>
<cfloop query="getsupp">
<option value="#getsupp.custno#" <cfif getictrantemp.note1 eq getsupp.custno>selected</cfif>>#getsupp.name#</option>
</cfloop>
</select></td>

<td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;">
<a onMouseOver="JavaScript:this.style.cursor='hand';" onclick="document.getElementById('updownposition').value='up';updaterow('#getictrantemp.trancode#');document.getElementById('updownposition').value=''"><img src="/images/up.png" /></a>
<a onMouseOver="JavaScript:this.style.cursor='hand';" onclick="document.getElementById('updownposition').value='down';updaterow('#getictrantemp.trancode#');document.getElementById('updownposition').value=''"><img src="/images/down.png" /></a>
<!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#')" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>

</table>
</cfoutput>
