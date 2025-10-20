<html>
<head>
<title>Copy Job Order</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

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
<cfform name="form" method="post" action="copyitemprocess.cfm" target="_self">
	<input id="ff_itemno" type="hidden" name="ff_itemno" value='#url.itemno#'>
    <input type="hidden" id="counter" name="counter" value="1">
    <table class="data" align="center" width="200px">
    	<tr><td height="10" colspan="100%"></td></tr>
        <tr>
        	<th width="40%">Copy from No</th>
           	<td width="60%">#url.itemno#</td>
      </tr>
    	<tr>
        	<th width="40%">Copy to No.</th>
           	<td width="60%">
            <input type="text" name="newno" id="newno" value="">
            </td>
        </tr>
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