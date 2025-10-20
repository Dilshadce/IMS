<html>
<head>
<title>Dealer Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>

<body>
<h4>
  <cfif getpin2.h5110 eq "T">
    <a href="../comprofile.cfm">Company Profile</a>
  </cfif>
  <cfif getpin2.h5120 eq "T">
    || <a href="../lastusedno.cfm">Last Used No</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    || <a href="../transaction.cfm">Transaction Setup</a>
  </cfif>
  <cfif getpin2.h5140 eq "T">
    || <a href="../Accountno.cfm">AMS Accounting Default Setup</a>
  </cfif>
  <cfif getpin2.h5150 eq "T">
    || <a href="../userdefine.cfm">User Defined</a>
  </cfif>
  <cfif getpin2.h5160 eq "T">
    ||Dealer Menu
  </cfif>
  <cfif getpin2.h5170 eq "T">
    ||<a href="../transaction_menu/transaction_menu.cfm">Transaction Menu</a>
  </cfif>
  <cfif getpin2.h5180 eq "T">
    ||<a href="../userdefineformula.cfm">User Define - Formula</a>
  </cfif>
  <cfif husergrpid eq "super">
    ||<a href="../modulecontrol.cfm">Module Control</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    ||<a href="../displaysetup.cfm">Listing Setup</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    ||<a href="../displaysetup2.cfm">Display Detail</a>
  </cfif>
</h4>
<h1 align="center">General Setup - Dealer_Menu</h1>
        
<cfquery name="get_dealer_menu_setting" datasource="#dts#">
    SELECT * FROM dealer_menu;
</cfquery>
<cfquery datasource="#dts#" name="getGeneralInfo">
    SELECT * FROM gsetup;
</cfquery>
<cfset editbillpassword=getGeneralInfo.editbillpassword>
<cfset editbillpassword1=getGeneralInfo.editbillpassword1>
<cfset gpricemin = getGeneralInfo.gpricemin>
<cfset priceminctrl = getGeneralInfo.priceminctrl>
<cfset priceminctrlemail = getGeneralInfo.priceminctrlemail>
<cfset priceminpass = getGeneralInfo.priceminpass>

<!--- Modification On 11-01-2010, Remove Those Unuse Fields From This Form --->

<cfform name="dealer_menu" action="update_dealer_menu.cfm" method="post">
  <table align="center" class="data" width="50%">
    <tr>
      <th onClick="javascript:shoh('dealer_menu_page1');shoh('dealer_menu_page2');">Page 1<img src="/images/d.gif" name="imgdealer_menu_page1" align="center"></th>
      <th onClick="javascript:shoh('dealer_menu_page2');shoh('dealer_menu_page1');">Page 2<img src="/images/u.gif" name="imgdealer_menu_page2" align="center"></th>
    </tr>
  </table>
  <cfoutput>
    <table id="dealer_menu_page1" align="center" class="data" width="50%">
 
      <tr>
        <td align="center" colspan="100%"><strong>Safety Control Password For INV,CS,DO,DN,CN</strong></td>
      </tr>

      <tr>
        <th><div align="left">Min Selling Price</div></th>
        <td><input name="gpricemin" id="gpricemin" type="checkbox" value="1" <cfif gpricemin eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Min Selling Price Security</div></th>
        <td><input name="priceminctrl" id="priceminctrl" type="checkbox" value="1" <cfif priceminctrl eq '1'>checked</cfif>>
          Password
          <cfinput name="priceminpass" type="password" value="#priceminpass#" size="10" maxlength="10"></td>
      </tr>
      <tr>
        <th><div align="left">Print Bill Min Selling Price Email Approval Control</div></th>
        <td><input name="priceminctrlemail" id="priceminctrlemail" type="checkbox" value="1" <cfif priceminctrlemail eq '1'>checked</cfif>></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Selling Below Cost</th>
        <td><input name="selling_below_cost" type="checkbox" value="Y" #iif(get_dealer_menu_setting.selling_below_cost eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Selling Price Cannot Be Lower Than Unit Price
        <input name="minimum_selling_price1" type="text" value="#get_dealer_menu_setting.minimum_selling_price1#" maxlength="100" size="20">
        </th>
        <td><input name="minimum_selling_price" type="checkbox" value="Y" #iif(get_dealer_menu_setting.minimum_selling_price eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Selling Above Credit Limit
          <input name="selling_above_credit_limit1" type="text" value="#get_dealer_menu_setting.selling_above_credit_limit1#" maxlength="100" size="20"></th>
        <td><input name="selling_above_credit_limit" type="checkbox" value="Y" #iif(get_dealer_menu_setting.selling_above_credit_limit eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Credit Term
          <input name="credit_term1" type="text" value="#get_dealer_menu_setting.credit_term1#" maxlength="100" size="20"></th>
        <td><input name="credit_term" type="checkbox" value="Y" #iif(get_dealer_menu_setting.credit_term eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Negative Stock Password Control
          <input name="text" type="text" value="#get_dealer_menu_setting.negstkpassword1#" size="10" maxlength="50"></th>
        <td><input name="negstkpassword" type="checkbox" value="Y" #iif(get_dealer_menu_setting.negstkpassword eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Password</th>
        <td><cfinput name="password" type="password" value="#get_dealer_menu_setting.password#" size="10" maxlength="50"></td>
      </tr>
      <tr>
        <th>Customer Ajax Format</th>
        <td><select name="custformat" id="custformat">
            <option value="1" <cfif get_dealer_menu_setting.custformat eq '1'>selected</cfif>>Custno,Leftname,Midname</option>
            <option value="2" <cfif get_dealer_menu_setting.custformat eq '2'>selected</cfif>>Agentno,Custname,Custno</option>
          </select></td>
      </tr>
      <tr>
        <th>Product Ajax Format</th>
        <td><select name="itemformat" id="custformat">
            <option value="1" <cfif get_dealer_menu_setting.itemformat eq '1'>selected</cfif>>Itemno,Leftname,Midname</option>
            <option value="2" <cfif get_dealer_menu_setting.itemformat eq '2'>selected</cfif>>Productcode,Description,Itemno</option>
          </select></td>
      </tr>
 
      <tr>
        <th><div align="left">Edit Bill Password control for
            <input name="editbillpassword1" type="text" value="#editbillpassword1#" maxlength="100" size="20">
            (For example: QUO,INV)</div></th>
        <td><input name="editbillpassword" type="checkbox" value="1" <cfif editbillpassword eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <td align="center" colspan="100%"><strong>Rules in transaction</strong></td>
      </tr>
      <tr>
        <th>Enable Change Terms In Transaction</th>
        <td><input name="tran_edit_term" type="checkbox" value="Y" #iif(get_dealer_menu_setting.tran_edit_term eq "Y",DE("checked"),DE(""))#></td>
      </tr>
      <tr>
        <th>Enable Change Name In Transaction</th>
        <td><input name="tran_edit_name" type="checkbox" value="Y" #iif(get_dealer_menu_setting.tran_edit_name eq "Y",DE("checked"),DE(""))#></td>
      </tr>
    </table>
    <table id="dealer_menu_page2" style="display:none" align="center" class="data" width="50%">
      <tr>
        <td align="center" colspan="100%"><strong>Other Setting</strong></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Customer / Supplier Sort By</th>
        <td><select name="custSuppSortBy">
            <option value="custno,name" #iif(get_dealer_menu_setting.custSuppSortBy eq "custno,name",DE("selected"),DE(""))#>Cust/Supp No.</option>
            <option value="name,custno" #iif(get_dealer_menu_setting.custSuppSortBy eq "name,custno",DE("selected"),DE(""))#>Cust/Supp Name</option>
            <option value="created_on desc" #iif(get_dealer_menu_setting.custSuppSortBy eq "created_on desc",DE("selected"),DE(""))#>Date Created (Descending)</option>
          </select></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Product Sort By</th>
        <td><select name="productSortBy">
            <option value="itemno,desp" #iif(get_dealer_menu_setting.productSortBy eq "itemno,desp",DE("selected"),DE(""))#>Item No.</option>
            <option value="desp,itemno" #iif(get_dealer_menu_setting.productSortBy eq "desp,itemno",DE("selected"),DE(""))#>Item Description</option>
            <option value="created_on desc" #iif(get_dealer_menu_setting.productSortBy eq "created_on desc",DE("selected"),DE(""))#>Date Created (Descending)</option>
          </select></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Transaction Sort By</th>
        <td><select name="transactionSortBy">
            <option value="created_on desc,refno desc" #iif(get_dealer_menu_setting.transactionSortBy  eq "created_on desc,refno desc",DE("selected"),DE(""))#>Date Created (Descending)</option>
            <option value="wos_date desc,refno desc" #iif(get_dealer_menu_setting.transactionSortBy  eq "wos_date desc,refno desc",DE("selected"),DE(""))#>Bill Date (Descending)</option>
            <option value="refno desc,wos_date desc" #iif(get_dealer_menu_setting.transactionSortBy  eq "refno desc,wos_date desc",DE("selected"),DE(""))#>Refno (Descending)</option>
          </select></td>
      </tr>
      <cfif husergrpid eq "Super">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
          <th>Custom Company</th>
          <td><input name="customcompany" type="checkbox" value="Y" #iif(get_dealer_menu_setting.customcompany eq "Y",DE("checked"),DE(""))#></td>
        </tr>
        <cfelse>
        <input name="customcompany" type="hidden" value="#get_dealer_menu_setting.customcompany#">
      </cfif>
      <tr>
        <td align="center" colspan="100%"><strong>Report Setting</strong></td>
      </tr>
      <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <th>Include SO/PO In Stock Card Report</th>
        <td><input name="include_SO_PO_stockcard" type="checkbox" value="Y" #iif(get_dealer_menu_setting.include_SO_PO_stockcard eq "Y",DE("checked"),DE(""))#></td>
      </tr>

    </table>
    <table align="center" class="data" width="50%">
      <tr>
        <td align="center"><input name="Save" type="submit" value="Save">
          <input name="Reset" type="reset" value="Reset"></td>
      </tr>
    </table>
  </cfoutput>
</cfform>
</body>
</html>