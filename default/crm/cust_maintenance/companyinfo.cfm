<html>
<head></head>
<body>

<cfquery name="getinfo" datasource="net_crm">
	SELECT a.*,b.custname,c.function,c.desp FROM company as a
    
    left join
    
    (select * from customer where custname != '') 
    as b on a.custid = b.custid
	
	left join
    
    (select * from customized_function) 
    as c on a.comid = c.comid
	
	WHERE a.comid = '#comid#'
</cfquery>

<table width="100%" border="0" align="center" cellspacing="0">
	<tr>
      	<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Company Details</strong></font></div></td>
	</tr>
	<tr>
		<td colspan="9"><hr></td>
  	</tr>
	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">CUSTOMER</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">COMID</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUSTOMIZED FUNCTION</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ATTN</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">CONTACT NO.</font></div></td>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">SUPPORT</font></div></td>
   	 	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">PROGRAMMER</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTIVE STATUS</font></div></td>
  	</tr>
	<tr>
		<td colspan="9"><hr></td>
  	</tr>
	<cfset thiscust = "999999">
	<cfloop query="getinfo">
		<cfoutput>
			<cfif getinfo.custname neq thiscust>
				<cfset thiscust = getinfo.custname>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.custname#</font></div></td>
      				<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.comid#</font></div></td>
      				<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.comname#</font></div></td>
					<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.function#</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.attn#</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.contactNo#</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.supportStaff#</font></div></td>
	  				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.programmer#</font></div></td>
					<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif getinfo.status eq "Yes">Active<cfelse>Inactive</cfif></font></div></td>
    			</tr>
			<cfelse>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
      				<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
      				<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
					<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.function#</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
      				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
	  				<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
					<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></div></td>
    			</tr>
			</cfif>
		
		</cfoutput>
  	</cfloop>
</table>
<cfoutput>
	
</cfoutput>
</body>
</html>