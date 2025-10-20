<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getdisablefoc" datasource="#dts#">
    select disablefoc,gpricemin,priceminctrl,priceminpass from gsetup
</cfquery>
<!---<cfif lcase(hcomid) eq "iaf_i">--->
<cfif getdisablefoc.gpricemin eq "1" and is_service neq 1 and tran neq "RC" and tran neq "PR" and tran neq "CN" and tran neq "DN">
    <cfquery name="getminprice" datasource="#dts#">
    SELECT PRICE_MIN FROM icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
    </cfquery>
    
	<cfif getdisablefoc.gpricemin eq "1" and getdisablefoc.priceminctrl eq "1" and val(getminprice.price_min) neq 0 and is_service neq 1>
    <cfwindow name="validatepass" center="true" closable="true" draggable="false" modal="true" refreshonshow="true" source="/default/transaction/validatepass.cfm?itemprice=#numberformat(val(getminprice.price_min),',.__')#" height="150" width="350"></cfwindow>
    <input type="hidden" name="pricemincontrol" id="pricemincontrol" value="0" />
    </cfif>
</cfif>
<!---</cfif>--->
<cfoutput>
<script type="text/javascript">
	function trim(str) {
		str = str.replace(/^\s+/, '');
		for (var i = str.length - 1; i >= 0; i--) {
			if (/\S/.test(str.charAt(i))) {
				str = str.substring(0, i + 1);
				break;
			}
		}
		return str;
	}
		
	function validate()
	{
		<!---<cfif lcase(hcomid) eq "iaf_i">--->
		<cfif is_service neq 1  and tran neq "RC" and tran neq "PR" and tran neq "CN" and tran neq "DN">
		<cfif getdisablefoc.gpricemin eq "1" and getdisablefoc.priceminctrl neq "1" and val(getminprice.price_min) neq 0 >
		if(	parseFloat(document.getElementById('pri6').value) < #val(getminprice.price_min)#)
		{
			alert("Item Price is Below Minimum Selling Price - #numberformat(val(getminprice.price_min),',.__')#");
			return false;
		}		
		</cfif>
		
		<cfif getdisablefoc.gpricemin eq "1" and getdisablefoc.priceminctrl eq "1" and val(getminprice.price_min) neq 0>
		if( parseFloat(document.getElementById('pricemincontrol').value) == 0)
		{
			if(	parseFloat(document.getElementById('pri6').value) < #val(getminprice.price_min)#)
			{
				ColdFusion.Window.show('validatepass');
				return false;
			}	
		}
		</cfif>
		</cfif>
		<!---</cfif>--->
		re = /^(\d{1,2})\/(\d{1,2})\/(\d{4})$/;
		if(document.getElementById('requiredate').value != '') {
      	if(regs = document.getElementById('requiredate').value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById('requiredate').focus();
		  return false;
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById('requiredate').focus();
		  return false;
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > 2500) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and 2500" );
          document.getElementById('requiredate').focus();
		  return false;
        }
      } else {
        alert("Invalid date format: " + document.getElementById('requiredate').value);
        document.getElementById('requiredate').focus();
		return false;
      }
	}
	
	if(document.getElementById('replydate').value != '') {
      	if(regs = document.getElementById('replydate').value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById('replydate').focus();
		  return false;
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById('replydate').focus();
		  return false;
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > 2500) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and 2500");
          document.getElementById('replydate').focus();
		  return false;
        }
      } else {
        alert("Invalid date format: " + document.getElementById('replydate').value);
        document.getElementById('replydate').focus();
		return false;
      }
	}
	
	if(document.getElementById('deliverydate').value != '') {
      	if(regs = document.getElementById('deliverydate').value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById('deliverydate').focus();
		  return false;
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById('deliverydate').focus();
		  return false;
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > 2500) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and 2500");
          document.getElementById('deliverydate').focus();
		  return false;
        }
      } else {
        alert("Invalid date format: " + document.getElementById('deliverydate').value);
        document.getElementById('deliverydate').focus();
		return false;
      }
	}
		if(document.form1.enablemoreqtyonly.value=='1'){
			if((document.form1.qty.value*1)<(document.form1.oldqty.value*1)){
				alert('Qty cannot be lower than previous Qty');
				return false;
			}
		}
  		<!--- INSERT COMPULSORY LOCATION CHECKING --->
		<cfif is_service neq 1>
		<cfinclude template = "transaction_setting_checking/compulsory_location_transaction4.cfm">
		</cfif>
		<!--- INSERT COMPULSORY LOCATION CHECKING --->
		
		<cfif checkcustom.customcompany eq "Y" and is_service neq 1>
			<!--- INSERT COMPULSORY BATCHCODE CHECKING --->
			<cfinclude template = "transaction_setting_checking/compulsory_batchcode_transaction4.cfm">
			<!--- INSERT COMPULSORY BATCHCODE CHECKING --->
		</cfif>
		<cfif lcase(hcomid) eq "aimpest_i" and tran eq 'SAM'>
		if(document.form1.req3.value=='')
		{
		alert ("Please Choose a Period.");
		return false;
		}
		</cfif>	
		if(document.form1.qty.value=='')
		{
			alert ("Empty Quantity!" + '\n\n' + "Please key in the quantity.");
			document.form1.qty.focus();
			return false;
  		}
  		if(isNaN(document.form1.qty.value))
		{
			alert ("Please key in quantity in numeric.");
			document.form1.qty.focus();
			return false;
 		 }
		 <cfif lcase(hcomid) eq "aimpest_i">
		 document.getElementById('foc').value = "N";
		 <cfelse>
		 <cfif getdisablefoc.disablefoc eq 'Y'>
		 document.getElementById('foc').value = "N";
		 <cfelse>
		 if(parseFloat(document.getElementById('pri6').value) <= 0 && document.getElementById('foc').value != "Y")
		 {
		  var answer = confirm("The item price is zero, Do you wish to list this item into FOC?");
		  if(answer)
		  {
		  document.getElementById('foc').value = "Y";
		  }
		 }
		 else if(parseFloat(document.getElementById('pri6').value) > 0 && document.getElementById('foc').value == "Y")
		 {
		 document.getElementById('foc').value = "N";
		 }
		 </cfif>
		</cfif>
		
		<cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i" or lcase(hcomid) eq "netilung_i")>
			if((document.getElementById('weikensoproject').value*1)-(document.getElementById('weikeninvproject').value*1)-(document.getElementById('amt').value*1) < 0)
			{
				if(confirm("Project "+document.getElementById('source').value+" Amount is Over Contract Amount "+(document.getElementById('weikensoproject').value*1).toFixed(2)+". Do You Want To Proceed?")){
				}
				else{
				return false;
				}
			}
			
		</cfif>
		
		
		if(document.form1.minimumsellingpassword.value=='Y' && document.form1.minimumsellingprice.value!=0 && (document.form1.minimumsellingprice.value*1)>(((document.form1.amt.value*1)-(document.form1.discamt.value*1))/document.form1.qty.value*1))
		{
			ColdFusion.Window.show('minimumprice');
			return false;
		}
		
		if(document.form1.sellingbelowcostpassword.value=='Y' && document.form1.sellingbelowcost.value!=0 && (document.form1.sellingbelowcost.value*1)>(((document.form1.amt.value*1)-(document.form1.discamt.value*1))/document.form1.qty.value*1))
		{
			ColdFusion.Window.show('minimumprice2');
			return false;
		}
		
  		var xCompareQty=document.form1.CompareQty.value;

  		if(xCompareQty=='Y')
		{
    		var aQty=document.form1.qty.value;
    		
			var aMin=document.form1.minimum.value;
			<cfif tran eq 'SO'>
			var aQOH=(document.form1.balance.value*1)-(document.form1.reserveqty.value*1);
			<cfelse>
			var aQOH=document.form1.balance.value;
			</cfif>

    		if((parseFloat(aQOH) - parseFloat(aQty)) < parseFloat(aMin))
			{
				if (parseFloat(aMin)=='0')
				{
				<cfif tran eq 'SO'>

					alert("The quantity is more than available Qty!");		
					document.form1.qty.focus();
	   	 			return false;

				<cfelse>
				<!---
					var xConfirm=confirm("The quantity is more than Balance On Hand!" + '\n\n' + "Do you want to proceed?");	--->
					<cfif isdefined('mode')>
					<!---<cfif mode eq "Add">--->
					if(document.getElementById('negqtypassword').value=='Y')
					{
					if(document.getElementById('allownegstk').value=='Y')
					{
					return true;
					}
					else
					{
					ColdFusion.Window.show('negativestock');
					return false;
					}
					}
					else{
					alert("The quantity is more than Balance On Hand!");	
					return false;
					}
					
					<cfelse>
					if(document.getElementById('negqtypassword').value=='Y')
					{
					if(document.getElementById('allownegstk').value=='Y')
					{
					return true;
					}
					else
					{
					ColdFusion.Window.show('negativestock');
					return false;
					}
					}
					else{
					alert("The quantity is more than Balance On Hand!");	
					return false;
					}
					</cfif>
					
				</cfif>
				}
				else
				{
					var xConfirm=confirm("Stock below minimum level!" + '\n\n' + "Do you want to proceed?");
				}
				<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i">
				if (xConfirm==true)
				{
	   	 			return true;
     			}
     			else
				{
	   	 			document.form1.qty.focus();
	   	 			return false;
      			}
				<cfelse>
				<cfif (tran neq 'SO')>
      			if (xConfirm==true)
				{
	   	 			return true;
     			}
     			else
				{
	   	 			document.form1.qty.focus();
	   	 			return false;
      			}
				</cfif>
				</cfif>
    		}
  		}
  	return true;
	}
	
	function CopyItemRemark()
	{
		<cfquery name="getItemRemark" datasource="#dts#">
    		select 
			remark1,
			remark2,
			remark3,
			remark4,
			remark5,
			remark6,
			remark7,
			remark8,
			remark9,
			remark10,
	  		remark11,
			remark12,
			remark13,
			remark14,
			remark15,
			remark16,
			remark17,
			remark18,
			remark19,
			remark20,
	  		remark21,
			remark22,
			remark23,
			remark24,
			remark25,
			remark26,
			remark27,
			remark28,
			remark29,
			remark30
	  		from icitem 
			where itemno='#itemno#';
    	</cfquery>

    	<cfset NewLine=JSStringFormat(chr(13))>

		<cfif getItemRemark.remark1 neq "">
			<cfif left(getItemRemark.remark1,1) eq " ">
				document.form1.comment.value=document.form1.comment.value + ' ' + '#getItemRemark.remark1#';
			<cfelse>
       			document.form1.comment.value=document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark1#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark2 neq "">
			<cfif left(getItemRemark.remark2,1) eq " ">
	  			document.form1.comment.value=document.form1.comment.value + '#getItemRemark.remark2#';
			<cfelse>
				document.form1.comment.value=document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark2#';
			</cfif>
		</cfif>

		<cfif getItemRemark.remark3 neq "">
			<cfif left(getItemRemark.remark3,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark3#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark3#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark4 neq "">
			<cfif left(getItemRemark.remark4,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark4#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark4#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark5 neq "">
			<cfif left(getItemRemark.remark5,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark5#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark5#';
	  		</cfif>
    	</cfif>

		<cfif getItemRemark.remark6 neq "">
			<cfif left(getItemRemark.remark6,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark6#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark6#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark7 neq "">
			<cfif left(getItemRemark.remark7,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark7#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark7#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark8 neq "">
			<cfif left(getItemRemark.remark8,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark8#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark8#';
			</cfif>
    	</cfif>

		<cfif getItemRemark.remark9 neq "">
			<cfif left(getItemRemark.remark9,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark9#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark9#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark10 neq "">
			<cfif left(getItemRemark.remark10,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark10#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark10#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark11 neq "">
			<cfif left(getItemRemark.remark11,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark11#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark11#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark12 neq "">
			<cfif left(getItemRemark.remark12,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark12#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark12#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark13 neq "">
			<cfif left(getItemRemark.remark13,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark13#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark13#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark14 neq "">
			<cfif left(getItemRemark.remark14,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark14#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark14#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark15 neq "">
			<cfif left(getItemRemark.remark15,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark15#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark15#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark16 neq "">
			<cfif left(getItemRemark.remark16,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark16#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark16#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark17 neq "">
			<cfif left(getItemRemark.remark17,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark17#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark17#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark18 neq "">
			<cfif left(getItemRemark.remark18,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark18#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark18#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark19 neq "">
			<cfif left(getItemRemark.remark19,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark19#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark19#';
    		</cfif>
    	</cfif>

		<cfif getItemRemark.remark20 neq "">
			<cfif left(getItemRemark.remark20,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark20#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark20#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark21 neq "">
			<cfif left(getItemRemark.remark21,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark21#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark21#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark22 neq "">
			<cfif left(getItemRemark.remark22,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark22#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark22#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark23 neq "">
			<cfif left(getItemRemark.remark23,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark23#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark23#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark24 neq "">
			<cfif left(getItemRemark.remark24,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark24#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark24#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark25 neq "">
			<cfif left(getItemRemark.remark25,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark25#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark25#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark26 neq "">
			<cfif left(getItemRemark.remark26,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark26#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark26#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark27 neq "">
			<cfif left(getItemRemark.remark27,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark27#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark27#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark28 neq "">
			<cfif left(getItemRemark.remark28,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark28#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark28#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark29 neq "">
			<cfif left(getItemRemark.remark29,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark29#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark29#';
    		</cfif>
		</cfif>

		<cfif getItemRemark.remark30 neq "">
			<cfif left(getItemRemark.remark30,1) eq " ">
				document.form1.comment.value = document.form1.comment.value + '#getItemRemark.remark30#';
			<cfelse>
      			document.form1.comment.value = document.form1.comment.value + '#NewLine#' + '#getItemRemark.remark30#';
    		</cfif>
		</cfif>
  	
  	return true;
	}
</script>
</cfoutput>