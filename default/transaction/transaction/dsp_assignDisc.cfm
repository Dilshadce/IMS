<cfquery name="getictran" datasource="#dts#">
	select b.brand,c.rangeForDisc,c.DISPEC,sum(amt1) as totalamt1
	from ictran a,icitem b, brand c
	where a.type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
	and a.refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
	and (a.linecode <> 'SV' or a.linecode is null)
	and a.itemno=b.itemno
	and b.brand=c.brand
	group by b.brand
</cfquery>

<html>
<head>
	<title>Assign Discount By Brand</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type='text/javascript' src='../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../ajax/core/settings.js'></script>
	
	<script type="text/javascript">
		function checkAndAssign(){
			var a=0;
			var inputs = document.getElementsByTagName('input');
	   	 	var checkboxes = [];
	   	 	for (var i = 0; i < inputs.length; i++) {
		        if (inputs[i].type == 'checkbox' && inputs[i].checked==true) {
		        	var a=1;
		        	break;
				}
			}
			if(a==0){
				window.close();
			}
			else{
				var tran=document.getElementById('tran').value;
				var refno=document.getElementById('refno').value;
				DWREngine._execute(_tranflocation, null, 'assignDiscByBrand', tran, refno, showinfo);
				
			}
		}
		
		function showinfo(thisObject){
			if(thisObject.MESSAGE!=''){
				alert(thisObject.MESSAGE);
			}
			else{
				window.opener.location.reload(true);
				window.close();
			};
		}
	</script>
</head>
<body>
<h3>Assign Discount By Brand</h3>
<form name="form" action="" method="post">
<cfoutput>
	<input type="hidden" name="tran" id="tran" value="#url.type#">
	<input type="hidden" name="refno" id="refno" value="#url.refno#">
</cfoutput>
<table align="center" width="70%" cellpadding="0" cellspacing="2" class="data">
	<tr>
		<th>Brand</th>
		<th>Disc (%)</th>
		<th>Total Amount (S$)</th>
		<th></th>
	</tr>
	<cfoutput query="getictran">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td>#getictran.brand#</td>
			<td><div align="right">#val(getictran.DISPEC)#</div></td>
			<td><div align="right">#numberFormat(val(getictran.totalamt1),"0.00000")#</div></td>
			<td>
				<div align="center">
					<input type="checkbox" name="gotdisc" id="gotdisc" <cfif (val(getictran.totalamt1) gte val(getictran.rangeForDisc)) and val(getictran.rangeForDisc) neq 0>checked</cfif> disabled>
				</div>
			</td>
		</tr>
	</cfoutput>
	<tr><td colspan="100%"><hr></td></tr>
	<tr><td colspan="100%"><div align="center"><input type="button" name="btnok" id="btnok" value="Ok" onclick="checkAndAssign();"></div></td></tr>
</table>
</form>
</body>
</html>