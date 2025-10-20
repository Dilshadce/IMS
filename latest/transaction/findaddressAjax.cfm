	<cfquery datasource='#dts#' name="findaddress">
	  Select * from address 
	  where custno = '#url.custno#' or custno=""
	</cfquery>



	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px">Address Code</th>
    <th width="300px">Address</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="findaddress" >
    
    <tr>
    <td>#findaddress.code#</td>
    <td>#findaddress.add1# #findaddress.add2# #findaddress.add3# #findaddress.add4#</td>
    <td>
    <cfif url.addtype eq 'bill'>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('BCode').value='#findaddress.code#';document.getElementById('b_add1').value='#findaddress.add1#';document.getElementById('b_add2').value='#findaddress.add2#';document.getElementById('b_add3').value='#findaddress.add3#';document.getElementById('b_add4').value='#findaddress.add4#';ColdFusion.Window.hide('findaddress');"><u>SELECT</u></a></td>
    <cfelse>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('DCode').value='#findaddress.code#';document.getElementById('d_add1').value='#findaddress.add1#';document.getElementById('d_add2').value='#findaddress.add2#';document.getElementById('d_add3').value='#findaddress.add3#';document.getElementById('d_add4').value='#findaddress.add4#';ColdFusion.Window.hide('findaddress');"><u>SELECT</u></a></td>
    </cfif>
    </td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>