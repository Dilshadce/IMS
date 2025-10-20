<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bill Same Item Combine</title>
</head>

<body>
<h3>Combine Same Item in Bill</h3>
<cfform action="itemcombineprocess.cfm" method="post" name="combineform">
 <table width="100%">
    <tr>
    <th colspan="7">Step 1 :Choose a bill</th>
    </tr>
    <tr>
    <th>Bill Type</th>
    <td>:</td>
    <td><select name="tran" id="tran">
        <option value="INV">Invoice</option>
        <option value="QUO">Quotation</option>
        <option value="SO">Sales Order</option>
        <option value="CS">Cash Sales</option>
        <option value="PO">Order Purchase</option>
        <option value="DO">Delivery Order</option>
        <option value="RC">Purchase Receive</option>
        <option value="PR">Return Purchase</option>
        <option value="CN">Credit Note</option>
        <option value="DN">Debit Note</option>
        </select></td>
	<td></td>
    <th>Bill No</th>
    <td>:</td>
    <td>
    <cfselect name="billno" id="billno" bind="cfc:billno.getlist({tran},'#dts#')" bindonload="yes" value="refno" display="billdesp" required="yes" message="Please select a Bill" />    </td>
    </tr>
    <tr>
      <th colspan="7">Step 2: Combine Bill</th>
    </tr>
    <tr>
          <td colspan="7" align="center"><input type="submit" name="combine" id="combine" value="Combine" /></td>
    </tr>
    </table>
</cfform>
</body>
</html>
