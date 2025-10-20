<cfoutput>


<cfset defaultfontsize = "12px">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

    <cfquery name="getgsetup" datasource="#dts#">
    select * from gsetup
    </cfquery>

	<cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>

	<cfquery name="getitem" datasource="#dts#">
   		select substring_index(itemno,'-',1) as mitemno,desp,price from icitem
        <cfif Hitemgroup neq ''>
            where wos_group='#Hitemgroup#'
        </cfif>
        group by substring_index(itemno,'-',1)
        limit 20
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
		and fperiod<>'99'
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
    
    <input type="hidden" name="matrixpickitemuuid" id="matrixpickitemuuid" value="#createuuid()#" />
    <table>
    <tr>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">ITEM NO1.</font></td>
    <td><input type="text" name="matrixitemno1" id="matrixitemno1" size="12" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.display='visible';ajaxFunction1(document.getElementById('ajaxFieldmatrixitm'),'matrixsearchitem/searchitemajax.cfm?itemno='+escape(document.getElementById('matrixitemno1').value)+'&itemname='+escape(document.getElementById('matrixitemname1').value)+'&sizeid='+escape(document.getElementById('matrixsizeid').value))};" /></td>
    <td>&nbsp;</td>

    <td>
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">MID NAME:&nbsp;</font></td>
    <td><input type="text" size="12" name="matrixitemname1" id="matrixitemname1" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.display='visible';ajaxFunction1(document.getElementById('ajaxFieldmatrixitm'),'matrixsearchitem/searchitemajax.cfm?itemno='+escape(document.getElementById('matrixitemno1').value)+'&itemname='+escape(document.getElementById('matrixitemname1').value)+'&sizeid='+escape(document.getElementById('matrixsizeid').value))};" /></td>
    <td>&nbsp;</td>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">SIZE:&nbsp;</font></td>
    <td><input type="text" size="12" name="matrixsizeid" id="matrixsizeid" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.display='visible';ajaxFunction1(document.getElementById('ajaxFieldmatrixitm'),'matrixsearchitem/searchitemajax.cfm?itemno='+escape(document.getElementById('matrixitemno1').value)+'&itemname='+escape(document.getElementById('matrixitemname1').value)+'&sizeid='+escape(document.getElementById('matrixsizeid').value))};"></td>
	

    <td> &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.display='visible';ajaxFunction1(document.getElementById('ajaxFieldmatrixitm'),'matrixsearchitem/searchitemajax.cfm?itemno='+escape(document.getElementById('matrixitemno1').value)+'&itemname='+escape(document.getElementById('matrixitemname1').value)+'&sizeid='+escape(document.getElementById('matrixsizeid').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  /></td>
    </tr>
     <td colspan="6"><div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div></td>
     </tr>
  	<tr>
    <td colspan="3" align="right"> <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmatrixmultiitem();ColdFusion.Window.hide('matrixsearchitem');" value="Add Selected Item"/></td>
    </tr>
    </table>
    <div id="ajaxFieldmatrixitm" name="ajaxFieldmatrixitm">
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
    <td><input name="matrixaddprice_#getitem.currentrow#"  size="5" id="matrixaddprice_#getitem.currentrow#" value="#getitem.price#" /></td>
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
    <div id="pickitemlist" style="display:none">
    ITEM LIST
    </div>
    
    </cfoutput>
	
    <div id="matrixupdateitemAjaxField"></div>
    <div id="matrixaddmultiitem"></div>
    