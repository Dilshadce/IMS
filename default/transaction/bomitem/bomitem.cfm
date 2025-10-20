<cfif url.itemno neq "" and url.project neq "">
<cfset project = URLDECODE(url.project)>
<cfset itemno = listfirst(url.itemno,'_____')>
<cfset bomno = listlast(url.itemno,'_____')>

<cfquery datasource="#dts#" name="gettranname">
select lproductcode from GSetup
</cfquery>

<cfquery name="getbomsource" datasource="#dts#">
    SELECT * FROM(
    SELECT * FROM billmat WHERE 
    project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#project#">
    and bomno = "#bomno#"
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
    ) as a left join (select itemno as itemno1, desp from icitem) as b on a.bmitemno = b.itemno1
</cfquery>

<cfquery name="getsumout" datasource="#dts#">
SELECT sum(qty) as outqty FROM trackmrnqty WHERE bomno = "#bomno#"
</cfquery>

<cfquery name="getlocation" datasource="#dts#">
select * from iclocation 
</cfquery>

<cfif getbomsource.recordcount neq 0>
<cfoutput><cfform name="bominsert" id="bominsert" action="/default/transaction/bomitem/bomitemprocess.cfm" method="post" >
<input type="hidden" name="bomcountitem" id="bomcountitem" value="#getbomsource.recordcount#" />
<h1>BOM LIST FOR ITEM #itemno#</h1>
Total Needed Quantity&nbsp;&nbsp;<input type="text" name="bomitemqty" id="bomitemqty" value="0" onkeyup="recalculatebom();document.getElementById('bomoutstanding').value=document.getElementById('bomoutstanding1').value*1-document.getElementById('bomitemqty').value" />&nbsp;&nbsp;&nbsp;SO outstanding&nbsp;&nbsp;<input type="text" readonly="readonly" name="bomoutstanding" id="bomoutstanding" value="#val(getbomsource.quantity)-val(getsumout.outqty)#" /><input type="hidden" readonly="readonly" name="bomoutstanding1" id="bomoutstanding1" value="#val(getbomsource.quantity)#" />
        
        <input type="hidden" name="itemno" id="itemno" value="#itemno#">
        <input type="hidden" name="project" id="project" value="#project#">
        <input type="hidden" name="bomno" id="bomno" value="#bomno#">
        <input type="hidden" name="refno" id="refno" value="#url.refno#">
        <input type="hidden" name="type" id="type" value="#url.type#">
        
        <table width="100%" align="center">
        <tr>
        <th>ITEMNO</th>
        <th>#gettranname.lproductcode#</th>
        <th>DESP</th>
        <th>SNGLE QTY</th>
        <th>AVAILABLE QTY</th>
        <th>LOCATION</th>
        <th>NEEDED QTY</th>
        <th>RESERVED QTY</th>
        <th>ACTUAL QTY</th>
        <th>CHECK ALL</th>
        </tr>
        <cfloop query="getbomsource">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td>#getbomsource.BMitemno#<input type="hidden" name="bomitemnoforlocation" id="bomitemnoforlocation" value="#getbomsource.BMitemno#" />
        
        <input type="hidden" name="multilocationuuid_#getbomsource.BMitemno#" id="multilocationuuid_#getbomsource.currentrow#" value="">
        </td>
        <td>
        <cfquery name="getitemproductcode" datasource="#dts#">
		select aitemno from icitem where itemno='#getbomsource.BMitemno#'
		</cfquery>
        #getitemproductcode.aitemno#
        </td>
        <td>#getbomsource.desp#</td>
        <td>#val(getbomsource.BMqty)#
        <input type="hidden" name="bomdsingleqty_#getbomsource.currentrow#" id="bomsingleqty_#getbomsource.currentrow#" value="#val(getbomsource.BMqty)#" />
        </td>
        <td><cfinvoke component="cfc.itembal" method="itembal" dts="#dts#" itemno="#getbomsource.BMitemno#" returnvariable="itembal" />
        #itembal#        
        <input type="hidden" name="qtybalance_#getbomsource.currentrow#" id="qtybalance_#getbomsource.currentrow#" value="#itembal#" readonly="readonly" size="10" />
        </td>
        <td>
        <input type="hidden" name="bomlocation_#getbomsource.BMitemno#" id="bomlocation_#getbomsource.currentrow#" value="">
        <input type="button" name="bomaddmultilocation" id="bomaddmultilocation" onClick="document.getElementById('bomitemnorow').value='#getbomsource.currentrow#';document.getElementById('multilocationitemno').value='#getbomsource.bmitemno#';document.getElementById('bomitemnoneeduseqty').value='#val(getbomsource.BMqty)#';document.getElementById('bomitemnoneeduseqty2').value=document.getElementById('bomitemnoneeduseqty').value*document.getElementById('bomitemqty').value;ColdFusion.Window.show('bomaddmultilocation');" value="Multi Location"/>
        </td>
        <td><input type="text" name="bomneedqty_#getbomsource.currentrow#" id="bomneedqty_#getbomsource.currentrow#" value="#val(getbomsource.BMqty)#" readonly="readonly" size="10" /></td>
        <cfquery name="getreservedqty" datasource="#dts#">
        select sum(qty) as qty from ictran where source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#project#"> and itemno='#getbomsource.BMitemno#' and brem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and type='SAMM'
        </cfquery>
        <td>#val(getreservedqty.qty)#</td>
        <td><input type="text" name="bomqty_#getbomsource.BMitemno#" id="bomqty_#getbomsource.currentrow#" value="0" size="10" readonly/></td>
        <td>
        <input type="checkbox" name="bomitemno" id="bomitemno#getbomsource.currentrow#" value="#getbomsource.BMitemno#" onclick="return false" />
        </td>
        </tr>
        </cfloop>
        <tr>
        <td colspan="200%" align="center">
        <input type="submit" name="submitbtn" id="submitbtn" value="Generate" >&nbsp;&nbsp;<input type="reset" name="resetbtn" value="Reset" />
        </td>
        </tr>
        </table>
		</cfform>
</cfoutput>
<cfelse>
<h1>No Item Material Found</h1>
</cfif>

</cfif>
