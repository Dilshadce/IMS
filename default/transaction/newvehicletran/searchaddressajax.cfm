    <cfquery name="getaddress1" datasource="#dts#">
    select * from address WHERE 
    code like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.code)#%" /> 
    and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.addname)#%" /> 
    and custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custno)#%" />
    order by code limit 100
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">CODE</font></th>
    <th width="300px">NAME</th>
    <th width="50px">CUSTNO</th>
    <th width="50px">ADDRESS</th>
    <th width="50px">ATTN</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getaddress1" >

    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getaddress1.code#</td>
    <td>#getaddress1.name#</td>
    <td>#getaddress1.custno#</td>
    <td>#getaddress1.add1#<br />#getaddress1.add2#<br />#getaddress1.add3#<br />#getaddress1.add4#</td>
    <td>#getaddress1.attn#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('delname').value =unescape('#URLENCODEDFORMAT(getaddress1.name)#');document.getElementById('deladd1').value =unescape('#URLENCODEDFORMAT(getaddress1.add1)#');document.getElementById('deladd2').value =unescape('#URLENCODEDFORMAT(getaddress1.add2)#');document.getElementById('deladd3').value =unescape('#URLENCODEDFORMAT(getaddress1.add3)#');document.getElementById('deladd4').value =unescape('#URLENCODEDFORMAT(getaddress1.add4)#');document.getElementById('delattn').value =unescape('#URLENCODEDFORMAT(getaddress1.attn)#');document.getElementById('deltel').value =unescape('#URLENCODEDFORMAT(getaddress1.phone)#');document.getElementById('delfax').value =unescape('#URLENCODEDFORMAT(getaddress1.fax)#');ColdFusion.Window.hide('changedaddr');">SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>