<html>
<head>
	<link rel="stylesheet" href="css.css"/>
	
	<style type="text/css">
	.styleAdd{
   		font-size:12px;
   		font-family:Tahoma,sans-serif;
   		font-weight:bold;
   		color:#FF9999;
   		background-color:#33FF66;
   		border-style:outset;
   		border-color:#CCFFCC;
   		border-width:2px;
	}

	.styleEdit{
    	font-size:12px;
   		font-weight:bold;
   		color:#FFFF66;
   		background-color:#FF9966;
   		border-style:ridge;
   		border-color:#CCCCCC;
   		border-width:1px;
	}

	.styleDelete{
   		font-size:12px;
   		font-weight:bold;
   		font-family:Tahoma,sans-serif;
   		color:#DDDDDD;
   		background-color:#FF0099;
   		border-style:ridge;
   		border-color:#CCCC66;
   		border-width:2px;
	}
	
</style>

<script type="text/javascript">
	function confirmdelete(custid){
		if (confirm("Are you sure you want to delete")) {
 			window.location.href='action.cfm?type=delete&custid=' + custid;
 		}
	}
</script>
</head>

<body>

<cfquery datasource="net_crm" name="search">
    SELECT * FROM customer
    <cfif type neq "default">
		<cfif url.c neq "">
        	<cfif type eq "custname">
            	WHERE custname LIKE '#url.c#%'
			<cfelseif type eq "custno">
            	WHERE custno LIKE '#url.c#%'
        	</cfif>
		<cfelse>
			limit 20
		</cfif>
    </cfif>
</cfquery>

<table border="0" width="100%">
<tr class="style4">
    <th width="5%" align="center">
		No
    </th>
	<th width="5%" align="center">
		Cust No
    </th>
	<th width="25%" align="center">
		Customer Name
	</th>
	<th width="25%" align="center">
		Description
	</th>
	<th width="25%" align="center">
		Comment
	</th>
    <th width="15%" align="center">
		Action
	</th>
</tr>
<cfoutput>
<cfloop query="search">	
<tr class="style3">
    <td align="center">
        <cfoutput>#search.currentrow#.</cfoutput>
    </td>
	<td align="center">
		<cfoutput>#search.custno#</cfoutput>
	</td>
    <td>
        <cfoutput>#search.custname#</cfoutput>
    </td>
    <td>
        <cfoutput><pre class="style3">#search.desp#</pre></cfoutput>
    </td>
    <td>
        <cfoutput><pre class="style3">#search.comment#</pre></cfoutput>
    </td>
    <td align="center">
        <input type="button" class="styleEdit" value="Edit" Onclick="myPanelsSlides('slide2');ajaxFunction(window.document.getElementById('slide2'),'dsp_customer.cfm?custid=#search.custid#');">
       <input type="button" class="styleDelete" value="Delete" Onclick="confirmdelete('#search.custid#');">
    </td>
</tr>
</cfloop>
</cfoutput>
</table>
<cfsetting showdebugoutput="no">

</body>
</html>
