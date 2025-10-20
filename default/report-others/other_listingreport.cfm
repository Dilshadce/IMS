<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Others Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<cfquery datasource="#dts#" name="getitem">
	select * from icitem
</cfquery>
<cfquery datasource="#dts#" name="getcust">
	select * from #target_arcust#
</cfquery>
<cfquery datasource="#dts#" name="getgrp">
	select * from icgroup
</cfquery>

<cfif #url.type# eq 1>
	<cfset typename = "Flash">
</cfif>
<cfif #url.type# eq 2>
	<cfset typename = "Aging">
</cfif>
<cfif #url.type# eq 3>
	<cfset typename = "Baratron">
</cfif>
<cfif #url.type# eq 4>
	<cfset typename = "Market">
</cfif>
<cfif #url.type# eq 5>
	<cfset typename = "Top 20 Customers">
</cfif>
<cfif #url.type# eq 6>
	<cfset typename = "Product Mix">
</cfif>

<body>
<h1><center><cfoutput>#typename# Report</cfoutput></center></h1>

<cfif #url.type# eq 5>
<br><br>Click one item to view report.<br><br>

<cfform action="other_listingreport1.cfm" method="post" target="_self" name="form">
<p>&nbsp;</p>
	<select name="itemno">
		<cfoutput query="getitem"> 
    		<option value="#itemno#">#itemno# - #desp#</option>
    	</cfoutput>
	</select>
	<input type="submit" name="Submit1" value="Submit">
</cfform>
</cfif>

<cfif #url.type# eq 2>
<cfform action="other_listingreport2.cfm" method="post" target="_self" name="form">
    <table border="0" align="center" width="54%" class="data">
      <tr> 
      <th width="16%">Product:</th>
      <td width="2%"> <div align="center"></div></td>
      <td colspan="2"><select name="getfrom">
          <option value="">Choose a Item</option>
            <cfoutput query="getitem"> 
              <option value="#itemno#">#itemno# 
              - #desp#</option>
            </cfoutput> 
        </select></td>
    </tr>
    <tr> 
      <td colspan="5"><hr></td>
    </tr>
    <tr> 
      <th width="16%">Period:</th>
      <td width="2%"> <div align="center"></div></td>
      <td colspan="2">
	  	<select name="period">
            <option value="">Choose a period</option>
            <option value="01">1</option>
            <option value="02">2</option>
            <option value="03">3</option>
            <option value="04">4</option>
            <option value="05">5</option>
            <option value="06">6</option>
            <option value="07">7</option>
            <option value="08">8</option>
            <option value="09">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
		</select></td>
    </tr>
    <tr> 
      <td width="16%">&nbsp;</td>
      <td width="2%">&nbsp;</td>
      <td width="72%">&nbsp;</td>
      <td width="10%"><input type="submit" name="Submit12" value="Submit"></td>
    </tr>
  </table>
</cfform>
</cfif>
<cfif #url.type# eq 3>
  <cfform action="other_listingreport3.cfm" method="post" target="_self" name="form">
    <table border="0" align="center" width="54%" class="data">
      <tr> 
        <th>Customer</th>
        <td><div align="center">From</div></td>
        <td colspan="2"><select name="custfrom">
            <option value="">Choose a Customer</option>
            <cfoutput query="getcust"> 
              <option value="#custno#">#custno# 
              - #name#</option>
            </cfoutput> </select></td>
      </tr>
      <tr> 
        <th width="13%">Customer</th>
        <td width="6%"> <div align="center">To</div></td>
        <td colspan="2"><select name="custto">
            <option value="">Choose a Customer</option>
            <cfoutput query="getcust"> 
              <option value="#custno#">#custno# 
              - #name#</option>
            </cfoutput> </select> </td>
      </tr>
      <tr> 
        <td colspan="4"><hr></td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">From</div></td>
        <td><select name="groupfrom">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# 
              - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">To</div></td>
        <td><select name="groupto">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# 
              - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="4"><hr></td>
      </tr>
      <tr> 
        <th>Period</th>
        <td><div align="center">From</div></td>
        <td><select name="periodfrom">
            <option value="">Choose a period</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
          </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <th>Period</th>
        <td><div align="center">To</div></td>
        <td><select name="periodto">
            <option value="">Choose a period</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
          </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="13%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="70%">&nbsp;</td>
        <td width="11%"><input type="submit" name="Submit122" value="Submit"></td>
      </tr>
    </table>
  </cfform>
</cfif>

<cfif #url.type# eq 6>
	<cfform action="other_listingreport4.cfm" method="post" target="_self" name="form">	
	  <table border="0" align="center" width="54%" class="data">
		<tr> 
		  <th>Product</th>
		  <td><div align="center">From</div></td>
		  <td colspan="2"><select name="itemfrom">
			  <option value="">Choose a Item</option>
			  <cfoutput query="getitem"> 
				<option value="#itemno#">#itemno# 
				- #desp#</option>
			  </cfoutput> </select></td>
		</tr>
		<tr> 
		  <th width="13%">Product</th>
		  <td width="6%"> <div align="center">To</div></td>
		  <td colspan="2"><select name="itemto">
			  <option value="">Choose a Item</option>
			  <cfoutput query="getitem"> 
				<option value="#itemno#">#itemno# 
				- #desp#</option>
			  </cfoutput> </select> </td>
		</tr>
		<tr> 
		  <td width="13%">&nbsp;</td>
		  <td width="6%">&nbsp;</td>
		  <td width="70%">&nbsp;</td>
		  <td width="11%"><input type="submit" name="Submit122" value="Submit"></td>
		</tr>
	  </table>	
  </cfform>
</cfif>

<cfif #url.type# eq 4>
<cfform action="other_listingreport5.cfm" method="post" target="_self" name="form">
	<table border="0" align="center" width="54%" class="data">
      <tr> 
        <th>Customer</th>
        <td><div align="center">From</div></td>
        <td colspan="2"><select name="custfrom">
            <option value="">Choose a Customer</option>
            <cfoutput query="getcust"> 
              <option value="#custno#">#custno# 
              - #name#</option>
            </cfoutput> </select></td>
      </tr>
      <tr> 
        <th width="13%">Customer</th>
        <td width="6%"> <div align="center">To</div></td>
        <td colspan="2"><select name="custto">
            <option value="">Choose a Customer</option>
            <cfoutput query="getcust"> 
              <option value="#custno#">#custno# 
              - #name#</option>
            </cfoutput> </select> </td>
      </tr>
      <tr> 
        <td colspan="4"><hr></td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">From</div></td>
        <td><select name="groupfrom">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">To</div></td>
        <td><select name="groupto">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="13%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="70%">&nbsp;</td>
        <td width="11%"><input type="submit" name="Submit122" value="Submit"></td>
      </tr>
    </table>
</cfform>
</cfif>

<cfif #url.type# eq 1>
  <cfform action="other_listingreport6.cfm" method="post" target="_self" name="form">
    <table border="0" align="center" width="54%" class="data">
      <tr> 
        <th>Product</th>
        <td><div align="center">From</div></td>
        <td colspan="2"><select name="itemfrom">
            <option value="">Choose a Item</option>
            <cfoutput query="getitem"> 
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput> </select></td>
      </tr>
      <tr> 
        <th width="13%">Product</th>
        <td width="6%"> <div align="center">To</div></td>
        <td colspan="2"><select name="itemto">
            <option value="">Choose a Item</option>
            <cfoutput query="getitem"> 
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput> </select> </td>
      </tr>
      <tr> 
        <td colspan="4"><hr></td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">From</div></td>
        <td><select name="groupfrom">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <th>Group</th>
        <td><div align="center">To</div></td>
        <td><select name="groupto">
            <option value="">Choose a Group</option>
            <cfoutput query="getgrp"> 
              <option value="#wos_group#">#wos_group# - #desp#</option>
            </cfoutput> </select></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="13%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="70%">&nbsp;</td>
        <td width="11%"><input type="submit" name="Submit1222" value="Submit"></td>
      </tr>
    </table>
  </cfform>
</cfif>
</body>
</html>
