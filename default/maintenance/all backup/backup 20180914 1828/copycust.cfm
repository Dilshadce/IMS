<html>
<head>
<title>Copy Job Order</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="../../scripts/check_customer_code.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<cfquery name="getcodepatern" datasource="#dts#">
	select 
	debtorfr,
	debtorto,
    countryddl,
    custSuppNo,
    custnamelength,
    ldriver,
    lagent,
    dfcustcode
	from gsetup;
</cfquery>

<cfquery name="getGSetup" datasource="#dts#">
		SELECT invno,invno_2,invno_3,invno_4,invno_5,invno_6,
    	invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,
		po_oneset,so_oneset,quo_oneset,assm_oneset,tr_oneset,oai_oneset,oar_oneset,sam_oneset  
    	FROM gsetup
	</cfquery>
    
    <cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<script type="text/javascript">

<!--- Check Tran Type Running Refno Status Start --->
//function getArunStatus(type){
	//if(type=="INV" && oneInv!="1"){
		//DWREngine._execute(_copyflocation, null, 'arunlookup', type, document.form.ft_invtype.value, getARunResult);
	//}else if(type!=""){
		//DWREngine._execute(_copyflocation, null, 'arunlookup', type, oneInv, getARunResult);
	//}
//}

</script>

</head>

<body width="100%">
<br>
<cfoutput>
<cfform name="form" method="post" action="copycustprocess.cfm" target="_self" onSubmit="if(validate('#getcodepatern.debtorfr#','#getcodepatern.debtorto#','#getcodepatern.custSuppNo#')&&check_float()&&check_field()){return true;}else{return false;}">
	<input id="ff_custno" type="hidden" name="ff_custno" value="#url.custno#">
    <input type="hidden" id="counter" name="counter" value="1">
    <table class="data" align="center" width="200px">
    	<tr><td height="10" colspan="100%"></td></tr>
        <tr>
        	<th width="40%">Copy from No</th>
           	<td width="60%">#url.custno#</td>
      </tr>
    	<tr>
        	<th width="40%">Copy to No.</th>
           	<td width="60%">
            <cfinput type="text" size="4" name="s_prefix" id="s_prefix" maxlength="4"  value="#inputvalue1#" validateat="onblur" onvalidate="test_prefix"  onChange="javascript:this.value=this.value.toUpperCase();" message="-Please enter a value greater than or equal to #getgsetup.debtorfr# and less than or equal to #getgsetup.debtorto# in to Customer No prefix field" required="yes" tabindex="1"> 
/
<cfinput type="text" size="3" name="s_suffix" id="s_suffix" value="#inputvalue2#" maxlength="3" onChange="javascript:this.value=this.value.toUpperCase();" onvalidate="test_suffix" validateat="onblur" tabindex="2" required="yes" message="-Please enter at least 3 characters in the Customer No Suffixfield. and can not be 000" onKeyUp="ajaxFunction(document.getElementById('ajaxField'),'/default/maintenance/customerAjax.cfm?prefix='+document.getElementById('s_prefix').value+'&suffix='+document.getElementById('s_suffix').value);" onBlur="ajaxFunction(document.getElementById('ajaxField'),'/default/maintenance/customerAjax.cfm?prefix='+document.getElementById('s_prefix').value+'&suffix='+document.getElementById('s_suffix').value);checkcustno();" ><input type="hidden" name="nexcustno" id="nexcustno" value="#getgsetup.custSuppNo#" >
<div id="ajaxField" name="ajaxField">
</div>
            </td>
        </tr>
        <script type="text/javascript">
						var url = "/ajax/functions/getRecord.cfm?custtype=customer";
							
						new Ajax.Autocompleter("custno","hint",url,{afterUpdateElement : getSelectedId});
							
						function getSelectedId(text, li) {
							$('custno').value=li.id;
						}
		</script>
        <tr>
        	<td colspan="100%"><div align="right">
        		<input type="submit" value="Copy">
                &nbsp;
                <input type="button" value="Cancel" onClick="window.close();">
            </div></td>
        </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>