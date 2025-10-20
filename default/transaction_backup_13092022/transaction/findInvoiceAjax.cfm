 <cfquery name="getbill" datasource="#dts#">
    SELECT refno,custno,name FROM artran where type = "INV" and refno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.refno)#%"> and custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.custno)#%">
    </cfquery>
    <cfoutput>
 <table>
    <tr><th width="100">Invoice No</th><th width="100">Cust No</th><th width="200">Cust Name</th><th width="100">Action</th></tr>
    <cfloop query="getbill">
    <tr><td>#getbill.refno#</td><td>#getbill.custno#</td><td>#getbill.name#</td><td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getbill.refno#');ColdFusion.Window.hide('findInvoice');"><u>SELECT</u></a></td></tr>
    </cfloop>
    </table>
    </cfoutput>