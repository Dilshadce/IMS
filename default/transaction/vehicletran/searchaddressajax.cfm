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
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('b_name').value =unescape('#URLENCODEDFORMAT(getaddress1.name)#');document.getElementById('b_add1').value =unescape('#URLENCODEDFORMAT(getaddress1.add1)#');document.getElementById('b_add2').value =unescape('#URLENCODEDFORMAT(getaddress1.add2)#');document.getElementById('b_add3').value =unescape('#URLENCODEDFORMAT(getaddress1.add3)#');document.getElementById('b_add4').value =unescape('#URLENCODEDFORMAT(getaddress1.add4)#');document.getElementById('b_attn').value =unescape('#URLENCODEDFORMAT(getaddress1.attn)#');document.getElementById('b_phone').value =unescape('#URLENCODEDFORMAT(getaddress1.phone)#');document.getElementById('b_fax').value =unescape('#URLENCODEDFORMAT(getaddress1.fax)#');ColdFusion.Window.hide('changeadd');">SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>