<html>
<head>
<title>View Profit Margin Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<body>
<cfform action="TaxTotal_View.cfm" method="post" target="_self" name="form">
  <cfoutput>
    <h2>View Tax Total</h2>
  </cfoutput>
  <p>&nbsp;</p>
  <table border="0" align="center" width="80%" class="data">
    <tr>
      <th width="16%">Period</th>
      <td width="5%"> <div align="center">From</div></td>
      <td colspan="2"><select name="periodfrom">
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
      <th width="16%">Period</th>
      <td width="5%"> <div align="center">To</div></td>
      <td colspan="2"><select name="periodto">
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
      <td colspan="5"><hr></td>
    </tr>
    <tr>
      <td width="20%">&nbsp;</td>
      <td width="8%">&nbsp;</td>
      <td width="60%"> <div align="right">
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
  <p>&nbsp;</p></cfform>
</body>
</html>