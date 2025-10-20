<cfoutput>
<html>
<head>
	<title>Receive To Invoice</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    </head>
    <body>
    <h1>Update Recieve to Invoice</h1>
    <cfquery name="getlist" datasource="#dts#">
    SELECT * FROM(
    SELECT refno,name as suppname,rem30,custno as suppno,wos_date,sono from artran where type ="RC" and (rem34 = "" or rem34 is null)) as a
    LEFT JOIN
    (SELECT accountno,id FROM #replace(dts,"_i","_c")#.lead) as b
    on b.id = a.rem30
    LEFT JOIN
    (SELECT name,custno FROM #target_arcust#) as c
    on c.custno = b.accountno
    </cfquery>
    <table align="center" class="data" width="70%">
			<tr>
				<td colspan="5"><div align="center"><strong><cfoutput>Receive</cfoutput></strong></div></td>
			</tr>
			<tr>
				<th>Receive Refno</th>
				<th>Supplier Name</th>               
				<th>Customer Name</th>
                <th>Sales Order No</th>
				<th>Action</th>
                
			</tr>
            <cfloop query="getlist">
            <tr>
            <td>#getlist.refno#</td>
            <td>#getlist.suppno# - #getlist.suppname#</td>
            <td>#getlist.custno# - #getlist.name#</td>
            <td>#getlist.sono#</td>
            <td><a href="process.cfm?refno=#URLENCODEDFORMAT(getlist.refno)#&custno=#URLENCODEDFORMAT(getlist.custno)#" onClick="return confirm('Are You Sure You want to Update Receive #getlist.refno# to Invoice as Customer #getlist.custno# - #getlist.name#')">Update</a></td>
            </tr>
            </cfloop>
            </table>

    
    </body>
    </html>
    </cfoutput>