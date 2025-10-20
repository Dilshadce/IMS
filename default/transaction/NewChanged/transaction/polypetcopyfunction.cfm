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

<cfoutput query="getGSetup">
	var oneInv=#getGSetup.invoneset#;
	var oneRc=#getGSetup.rc_oneset#;
	var onePr=#getGSetup.pr_oneset#;
	var oneDo=#getGSetup.do_oneset#;
	var oneCs=#getGSetup.cs_oneset#;
	var oneCn=#getGSetup.cn_oneset#;
	var oneDn=#getGSetup.dn_oneset#;
	var oneIss=#getGSetup.iss_oneset#;
	var onePo=#getGSetup.po_oneset#;
	var oneSo=#getGSetup.so_oneset#;
	var oneQuo=#getGSetup.quo_oneset#;
	var oneAssm=#getGSetup.assm_oneset#;
	var oneTr=#getGSetup.tr_oneset#;
	var oneOai=#getGSetup.oai_oneset#;
	var oneOar=#getGSetup.oar_oneset#;
	var oneSam=#getGSetup.sam_oneset#;
</cfoutput>

function getRefnoRefresh(){getRefno("SAM",document.form.ff_invtype.value,oneInv);}

function getRefnoFtRefresh(){
	var type = document.form.ft.value;
	var count = document.form.ft_invtype.value;
	document.form.counter.value = document.form.ft_invtype.value;
	getArunStatus(type,count);
}

function getRefnosetResult(a){
	change('invt','block');
	DWRUtil.removeAllOptions("ft_invtype");
	DWRUtil.addOptions("ft_invtype", a,"KEY", "VALUE");
}

function init(){
	DWRUtil.useLoadingMessage();
	DWREngine._errorHandler =  errorHandler;
	change('invf','none');
	change('invt','none');
	refresh_from();
	refresh_to();
}
function refresh_from(){
	var value_f =document.form.ff.value;
	getRefno(value_f,"invno",oneInv);
	usrCtrl();
}
function refresh_to(){
	var value_t = document.form.ft.value;
	getCustomer(value_t);
	changeSize(value_t);
	getLastNum(value_t);
}
function getRefnosetResult(a){
	change('invt','block');
	DWRUtil.removeAllOptions("ft_invtype");
	DWRUtil.addOptions("ft_invtype", a,"KEY", "VALUE");
}

function showCopyJobOrderResult(msg){
	if(msg ==''){
		var nextjoborderno=document.getElementById('nextjoborderno').value;
		var windowOpener =window.dialogArguments;
		windowOpener.document.getElementById('joborderno').value=nextjoborderno;
		window.close();
	}
	else{
		alert(msg);
	}	
}

function getLastNum(type){getArunStatus(type,'1');}

<!--- Check Tran Type Running Refno Status Start --->
//function getArunStatus(type){
	//if(type=="INV" && oneInv!="1"){
		//DWREngine._execute(_copyflocation, null, 'arunlookup', type, document.form.ft_invtype.value, getARunResult);
	//}else if(type!=""){
		//DWREngine._execute(_copyflocation, null, 'arunlookup', type, oneInv, getARunResult);
	//}
//}

function getArunStatus(type,count){
	if(type == 'INV'){
		var typeoneset = oneInv;
	}else if(type == 'RC'){
		var typeoneset = oneRc;
	}else if(type == 'PR'){
		var typeoneset = onePr;
	}else if(type == 'DO'){
		var typeoneset = oneDo;
	}else if(type == 'CS'){
		var typeoneset = oneCs;
	}else if(type == 'CN'){
		var typeoneset = oneCn;
	}else if(type == 'DN'){
		var typeoneset = oneDn;
	}else if(type == 'ISS'){
		var typeoneset = oneIss;
	}else if(type == 'PO'){
		var typeoneset = onePo;
	}else if(type == 'SO'){
		var typeoneset = oneSo;
	}else if(type == 'QUO'){
		var typeoneset = oneQuo;
	}else if(type == 'ASSM'){
		var typeoneset = oneAssm;
	}else if(type == 'TR'){
		var typeoneset = oneTr;
	}else if(type == 'OAI'){
		var typeoneset = oneOai;
	}else if(type == 'OAR'){
		var typeoneset = oneOar;
	}else if(type == 'SAM'){
		var typeoneset = oneSam;
	}
	if(typeoneset !="1"){
		DWREngine._execute(_copyflocation, null, 'arunlookup', type, count, getARunResult);
	}else if(type!=""){
		DWREngine._execute(_copyflocation, null, 'arunlookup', type, '1', getARunResult);
	}
}

function getARunResult(arunObject){
	if(arunObject.ARUNSTATUS=="1"){
		if(arunObject.TYPE == 'INV'){
			var typeoneset = oneInv;
		}else if(arunObject.TYPE == 'RC'){
			var typeoneset = oneRc;
		}else if(arunObject.TYPE == 'PR'){
			var typeoneset = onePr;
		}else if(arunObject.TYPE == 'DO'){
			var typeoneset = oneDo;
		}else if(arunObject.TYPE == 'CS'){
			var typeoneset = oneCs;
		}else if(arunObject.TYPE == 'CN'){
			var typeoneset = oneCn;
		}else if(arunObject.TYPE == 'DN'){
			var typeoneset = oneDn;
		}else if(arunObject.TYPE == 'ISS'){
			var typeoneset = oneIss;
		}else if(arunObject.TYPE == 'PO'){
			var typeoneset = onePo;
		}else if(arunObject.TYPE == 'SO'){
			var typeoneset = oneSo;
		}else if(arunObject.TYPE == 'QUO'){
			var typeoneset = oneQuo;
		}else if(arunObject.TYPE == 'ASSM'){
			var typeoneset = oneAssm;
		}else if(arunObject.TYPE == 'TR'){
			var typeoneset = oneTr;
		}else if(arunObject.TYPE == 'OAI'){
			var typeoneset = oneOai;
		}else if(arunObject.TYPE == 'OAR'){
			var typeoneset = oneOar;
		}else if(arunObject.TYPE == 'SAM'){
			var typeoneset = oneSam;
		}
		if(typeoneset !="1"){
			DWREngine._execute(_copyflocation, null, 'lastNumlookup', arunObject.TYPE, arunObject.COUNTER, getLastNumResult);
		}else{
			DWREngine._execute(_copyflocation, null, 'lastNumlookup', arunObject.TYPE, arunObject.COUNTER, getLastNumResult);
		}
		document.getElementById("ft_refnofrom").readOnly=true;
		document.getElementById("ft_refnofrom").style.backgroundColor="#FFFF99";
	}else if(arunObject.ARUNSTATUS=="0"){
		document.getElementById("ft_refnofrom").value="";
		document.getElementById("ft_refnofrom").readOnly=false;
		document.getElementById("ft_refnofrom").style.backgroundColor="";
		document.getElementById("ft_actualrefno").value="";
	}
}

function refresh_to(){
	var value_t = document.form.ft.value;
	getLastNum(value_t);
}

function getLastNumResult(numObject){
	DWRUtil.setValue("ft_refnofrom", numObject.LASTNUM);
	DWRUtil.setValue("ft_actualrefno", numObject.ACTUALNO);
}

</script>

</head>

<body width="100%">
<br>
<cfoutput>
<cfform name="form" method="post" action="polypetcopyfunctionprocess.cfm" target="_self">
	<input id="ff_type" type="hidden" name="ff_type" value="#url.type#">
    <input id="ff_refnofrom" type="hidden" name="ff_refnofrom" value="#url.refno#">
    <input type="hidden" id="counter" name="counter" value="1">
    <table class="data" align="center" width="200px">
    	<tr><td height="10" colspan="100%"></td></tr>
        <tr>
        	<th width="40%">Bill Type</th>
           	<td width="60%">
            <select name="ft" onChange="refresh_to()">

            <option value="SAM">#gettranname.lSAM#</option>
            </select>
            </td>
        </tr>
        <script type="text/javascript">
		refresh_to();
		</script>
    	<tr>
        	<th width="40%">Ref No.</th>
           	<td width="60%">

			<cfselect name="ft_invtype" id="ft_invtype" bind="cfc:refnobill.getrefnoset({ft},'#dts#')" bindonload="yes" display="lastno" value="counter" onChange="getRefnoFtRefresh()" />

            <input type="text" name="ft_refnofrom" id="ft_refnofrom" value=""><input id="ft_actualrefno" type="hidden" name="ft_actualrefno">
            </td>
        </tr>
        <tr>
        	<td colspan="100%"><div align="right">
        		<input type="submit" value="Send">
                &nbsp;
                <input type="button" value="Cancel" onClick="window.close();">
            </div></td>
        </tr>
    </table>
</cfform>
</cfoutput>
</body>
</html>