<cfsetting showdebugoutput="no">

<cfset url.refno = URLDECODE(url.refno)>
<cfset url.tran = URLDECODE(url.tran)>

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
<cfquery name="getictran" datasource="#dts#">
SELECT * FROM ictran WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tran#"> order by trancode
</cfquery>
<cfloop query="getictran">
<tr <cfif (getictran.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictran.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getictran.currentrow#</td>
<td nowrap>#getictran.itemno#</td>
<cfquery name="getaitem" datasource="#dts#">
   		select aitemno from icitem where itemno='#getictran.itemno#'
	</cfquery>
<!---<td nowrap>#getaitem.aitemno#</td>--->
<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><input type="text" name="brem1#getictran.trancode#" id="brem1#getictran.trancode#" value="#getictran.brem1#" size="5" onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem1#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<td nowrap><a onmouseover="JavaScript:this.style.cursor='hand'" onClick="document.getElementById('itemdesptrancode').value='#getictran.trancode#';ColdFusion.Window.show('itemdesp');">#getictran.desp#</a></td>
<cfif getictran.location eq ''>
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
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getictran.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getictran.itemno#' 
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
		and itemno='#getictran.itemno#' 
		and location = '#getictran.location#' 

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
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#'

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
			and itemno='#getictran.itemno#' 
			and location = '#getictran.location#' 
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
		and a.itemno='#getictran.itemno#' 

		and a.location = '#getictran.location#'

	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location = '#getictran.location#'
    and a.itemno='#getictran.itemno#' 
	order by a.itemno;
</cfquery>
</cfif>

<td nowrap <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><cfif val(getitembalance.balance) gt 0>STK<cfelse>IND</cfif></td>
<td nowrap>
<select name="coltypelist#getictran.trancode#" id="coltypelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getictran.location eq getlocation.location>selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</td>

<td nowrap align="right"><input type="text" name="qtylist#getictran.trancode#" id="qtylist#getictran.trancode#" value="#val(getictran.qty_bil)#" size="5"  onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#val(getictran.qty_bil)#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}"></td>
<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i"><cfelse>style="display:none"</cfif>>
        <select name="deductitemlist#getictran.trancode#" id="deductitemlist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.deductableitem eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.deductableitem eq 'N' or getictran.deductableitem eq ''>selected</cfif>>N</option>
</select>
        </td>


<td nowrap align="right"><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictran.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictran.price_bil),',.__')#</a></td>
<td nowrap align="right"><input type="text" name="brem4#getictran.trancode#" id="brem4#getictran.trancode#" value="#getictran.brem4#" size="5"  onBlur="updaterow('#getictran.trancode#');" onKeyup="if(this.value != '#getictran.brem4#'){document.getElementById('updatebtn#getictran.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictran.trancode#').style.display='none';}" ></td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="nodisplaylist#getictran.trancode#" id="nodisplaylist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.nodisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.nodisplay eq 'N' or getictran.nodisplay eq ''>selected</cfif>>N</option>
</select>
        </td>

<td <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>>
        <select name="subtotallist#getictran.trancode#" id="subtotallist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="Y" <cfif getictran.totalupdisplay eq 'Y'>selected</cfif>>Y</option>
<option value="N" <cfif getictran.totalupdisplay eq 'N' or getictran.totalupdisplay eq ''>selected</cfif>>N</option>
</select>
        </td>

<td nowrap align="right" <cfif lcase(hcomid) eq "sosbat_i">style="display:none"</cfif>><select name="grouplist#getictran.trancode#" id="grouplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lgroup#</option>
<cfloop query="getgroup">
<option value="#getgroup.wos_group#" <cfif getictran.brem2 eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group#</option>
</cfloop>
</select></td>

<td nowrap align="right" <cfif lcase(HcomID) eq "imperial1_i" or lcase(HcomID) eq "coolnlite_i" or lcase(HcomID) eq "sosbat_i">style="display:none"</cfif>><select name="catelist#getictran.trancode#" id="catelist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a #getgsetup.lproject#</option>
<cfloop query="getproject">
<option value="#getproject.source#" <cfif getictran.source eq getproject.source>selected</cfif>>#getproject.source#</option>
</cfloop>
</select></td>

<td nowrap align="right" style="display:none"><select name="supplist#getictran.trancode#" id="supplist#getictran.trancode#" onChange="updaterow('#getictran.trancode#');">
<option value="">Choose a Supp</option>
<cfloop query="getsupp">
<option value="#getsupp.custno#" <cfif getictran.note1 eq getsupp.custno>selected</cfif>>#getsupp.name#</option>
</cfloop>
</select></td>

<td nowrap align="right">#numberformat(val(getictran.amt_bil),',.__')#</td>
<td nowrap><input type="button" name="deletebtn#getictran.trancode#" id="deletebtn#getictran.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictran.trancode#')}" value="DELETE"/>&nbsp;<img id="updatebtn#getictran.trancode#" name="updatebtn#getictran.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;">
<a onMouseOver="JavaScript:this.style.cursor='hand';" onclick="document.getElementById('updownposition').value='up';updaterow('#getictran.trancode#');document.getElementById('updownposition').value=''"><img src="/images/up.png" /></a>
<a onMouseOver="JavaScript:this.style.cursor='hand';" onclick="document.getElementById('updownposition').value='down';updaterow('#getictran.trancode#');document.getElementById('updownposition').value=''"><img src="/images/down.png" /></a>
<!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictran.trancode#" id="updatebtn#getictran.trancode#" onClick="updaterow('#getictran.trancode#')" value="UPDATE" style="display:none"/> ---></td>
</tr>
</cfloop>

</table>
</cfoutput>
