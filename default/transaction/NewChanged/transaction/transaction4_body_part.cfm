<cfwindow center="true" width="700" height="500" name="findComment" refreshOnShow="true"
        title="Find Comment" initshow="false"
        source="/default/transaction/findComment.cfm" />
        <cfwindow center="true" width="700" height="500" name="findmats" refreshOnShow="true"
        title="Find Material" initshow="false"
        source="/default/transaction/findmats.cfm?itemno={itemno}" />
<cfwindow center="true" width="700" height="500" name="extendcomment" refreshOnShow="true"
        title="Extend Comment" initshow="false"
        source="/default/transaction/extendcomment.cfm?comm5={comm5}" />
<script language="javascript" src="/scripts/date_format.js"></script>
<cfwindow center="true" width="700" height="500" name="uploadimage" refreshOnShow="true"
        title="Find Comment" initshow="false"
        source="/default/transaction/uploadimage.cfm?itemno=#itemno#&trancode=#itemcount#&refno=#nexttranno#&type=#tran#" />
<cfwindow x="40" y="50" width="300" height="320" name="findSymbol" refreshOnShow="true"
        title="ADD SYMBOL" initshow="false"
        source="/default/transaction/transaction4SymbolAjax.cfm" />
        
        <cfajaximport tags="cfform">
<cfwindow center="true" width="600" height="400" name="createProjectAjax" refreshOnShow="true"
        title="Create Project" initshow="false"
        source="/default/transaction/createProjectAjax.cfm" />
<cfwindow center="true" width="600" height="400" name="createJobAjax" refreshOnShow="true"
        title="Create Job" initshow="false"
        source="/default/transaction/createJobAjax.cfm" />
<cfwindow center="true" width="600" height="400" name="createlocationAjax" refreshOnShow="true"
        title="Create Location" initshow="false"
        source="/default/transaction/createlocationAjax.cfm" />
<cfquery name="gettitle" datasource="#dts#">
	select * from title order by title_id
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select * from dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>
<cfquery name="getgenerallayer" datasource="#dts#">
select * from gsetup
</cfquery>
<cfoutput>
<cfif submit eq "">
	<form name='form1' method='post' action='' enctype="multipart/form-data" <cfif mode neq 'delete'>onsubmit='return validate()'</cfif>>
</cfif>

<cfif service neq "">
	<input type='hidden' name="service" id="ser2" value="#convertquote(listfirst(service))#">
<cfelse>
	<input type='hidden' name="service" id="ser3" value="">
</cfif>

<input type="hidden" name="discountlimit" id="discountlimit" value="#getGeneralInfo.disclimit#">
<input type='hidden' name='tran' id="tr2" value='#listfirst(tran)#'>
<input type='hidden' name='type' id="in2" value='Inprogress'>
<input type='hidden' name='agenno' id="ag2" value='#listfirst(agenno)#'>
<input type='hidden' name='hmode' value='#listfirst(hmode)#'>
<input type="hidden" name="newtrancode" value="#newtrancode#">
<!--- ADD ON 110908 --->
<input type="hidden" name="itemcounter" value="#itemcount#">
<!--- ADD ON 201108 --->
<input type="hidden" name="multilocation" value="#multilocation#">
<input type="hidden" name="graded" value="#graded#">
<!--- ADD ON 30-07-09 --->
<input type="hidden" name="wpitemtax" value="#wpitemtax#">

<cfif isdefined("form.updunitcost")>
	<input type='hidden' name='updunitcost' value='#form.updunitcost#'>
</cfif>

<cfif mode eq "Add">
	<input type='hidden' name='currrate' id="cur2" value='#listfirst(currrate)#'>
    <input type='hidden' name='refno3' id="ref2" value='#listfirst(refno3)#'>
    <input type='hidden' name='mode' id="mo2" value='ADD'>
    <input type='hidden' name='nexttranno' id="net2" value='#listfirst(nexttranno)#'>
    <input type='hidden' name='custno' id="cus2" value='#getartran.custno#'>
    <input type='hidden' name='readperiod' id="rp2" value='#getartran.fperiod#'>
    <input type='hidden' name='nDateCreate' id="ndt2" value='#getartran.wos_date#'>
    <input type='hidden' name='invoicedate' id="ind3" value="#dateformat(getartran.wos_date,"dd/mm/yyyy")#">
	<!--- <input type='hidden' name='taxincl' id="taxincl" value='#getartran.taxincl#'> --->
	<cfif checkcustom.customcompany eq "Y">
		<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
			<input type="hidden" name="hremark5" value="#listfirst(remark5)#">	<!--- PERMIT NUMBER, ADD ON 24-03-2009 --->	
			<input type="hidden" name="hremark6" value="#listfirst(remark6)#">
			<input type="hidden" name="bremark8" value="">
			<input type="hidden" name="bremark9" value="">
			<input type="hidden" name="bremark10" value="">
		<cfelse>
			<input type="hidden" name="hremark5" value="">
			<input type="hidden" name="hremark6" value="">
			<input type="hidden" name="bremark8" value="">
			<input type="hidden" name="bremark9" value="">
			<input type="hidden" name="bremark10" value="">
		</cfif>
	</cfif>
<cfelseif mode eq "Edit">
	<cfquery name="getartran" datasource="#dts#">
    	select 
		* 
		from artran 
		where type='#tran#'
		and refno='#nexttranno#';
   	 </cfquery>

	 <input type='hidden' name='itemcount' id="itmct3" value='#listfirst(itemcount)#'>
     <input type ='hidden' name='mode' id="mo3" value='Edit'>
     <input type='hidden' name='nexttranno' id="net3" value='#listfirst(nexttranno)#'>
     <input type='hidden' name='currrate' id="cur4" value='#listfirst(currrate)#'>
     <input type='hidden' name='refno3' id="ref34" value='#listfirst(refno3)#'>
     <input type='hidden' name='custno' id="cus4" value='#getartran.custno#'>
     <input type='hidden' name='readperiod' id="rp4" value='#getartran.fperiod#'>
     <input type='hidden' name='nDateCreate' id="nd4" value='#getartran.wos_date#'>
     <input type='hidden' name='invoicedate' id="ind4" value="#dateformat(getartran.wos_date,"dd/mm/yyyy")#">
	<!--- <input type='hidden' name='taxincl' id="taxincl" value='#getartran.taxincl#'> --->
	<cfif checkcustom.customcompany eq "Y">
		<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
			<input type="hidden" name="hremark5" value="#listfirst(getartran.rem5)#">	<!--- PERMIT NUMBER, ADD ON 24-03-2009 --->
			<input type="hidden" name="hremark6" value="#listfirst(getartran.rem6)#">
			<input type="hidden" name="bremark8" value="">
			<input type="hidden" name="bremark9" value="">
			<input type="hidden" name="bremark10" value="">
		<cfelse>
			<input type="hidden" name="hremark5" value="#Brem5#">
			<input type="hidden" name="hremark6" value="#Brem7#">
			<input type="hidden" name="bremark8" value="#Brem8#">
			<input type="hidden" name="bremark9" value="#Brem9#">
			<input type="hidden" name="bremark10" value="#Brem10#">
		</cfif>		
	</cfif>
<cfelse>
	<cfquery name="getartran" datasource="#dts#">
		select 
		* 
		from artran 
		where type='#tran#'
		and refno='#nexttranno#';
    </cfquery>

	<input type='hidden' name='mode' id="mo4" value='Delete'>
    <input type='hidden' name='nexttranno' id="net4" value='#listfirst(nexttranno)#'>
	<input type='hidden' name='itemcount' id="itmct4" value='#listfirst(itemcount)#'>
    <input type='hidden' name='currrate' id="cur5" value='#listfirst(currrate)#'>
    <input type='hidden' name='refno3' id="ref35" value='#listfirst(refno3)#'>
    <input type='hidden' name='custno' id="cus5" value='#getartran.custno#'>
    <input type='hidden' name='readperiod' id="rp5" value='#getartran.fperiod#'>
    <input type='hidden' name='nDateCreate' id="nd5" value='#getartran.wos_date#'>
    <input type='hidden' name='invoicedate' id="ivd5" value="#dateformat(getartran.wos_date,"dd/mm/yyyy")#">
	<!--- <input type='hidden' name='taxincl' id="taxincl" value='#getartran.taxincl#'> --->
	<cfif checkcustom.customcompany eq "Y">
		<cfif tran eq "RC" or tran eq "OAI" or tran eq "CN">
			<input type="hidden" name="hremark5" value="#listfirst(getartran.rem5)#">	<!--- PERMIT NUMBER, ADD ON 24-03-2009 --->
			<input type="hidden" name="hremark6" value="#listfirst(getartran.rem6)#">
			<input type="hidden" name="bremark8" value="">
			<input type="hidden" name="bremark9" value="">
			<input type="hidden" name="bremark10" value="">
		<cfelse>
			<input type="hidden" name="hremark5" value="#Brem5#">
			<input type="hidden" name="hremark6" value="#Brem7#">
			<input type="hidden" name="bremark8" value="#Brem8#">
			<input type="hidden" name="bremark9" value="#Brem9#">
			<input type="hidden" name="bremark10" value="#Brem10#">
		</cfif>
	</cfif>
</cfif>
	<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
  	<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    </cfif>
  <script type="text/javascript">
  			function selectOptionByValue(selObj, val){ 
			var A= selObj.options, L= A.length; 
			while(L){ 
				if (A[--L].value== val){ 
					selObj.selectedIndex= L; 
					L= 0; 
				} 
			} 
			} 
  
  			function uploading_picture(pic_name)
			{
			var new_pic_name1 = new String(pic_name);
			var new_pic_name2 = new_pic_name1.split(/[-,/,\\]/g);
			document.getElementById("picture_name").value=new_pic_name2[new_pic_name2.length-1];
			}
  			
 			function updateProject(Projectno){
			myoption = document.createElement("OPTION");
			myoption.text = Projectno;
			myoption.value = Projectno;
			document.getElementById("Source").options.add(myoption);
			var indexvalue = document.getElementById("Source").length-1;
			document.getElementById("Source").selectedIndex=indexvalue;
			}
  			
			function updatejob(jobno){
			myoption = document.createElement("OPTION");
			myoption.text = jobno;
			myoption.value = jobno;
			document.getElementById("Job").options.add(myoption);
			var indexvalue = document.getElementById("job").length-1;
			document.getElementById("job").selectedIndex=indexvalue;
			}
			function updatelocation(locationno){
			myoption = document.createElement("OPTION");
			myoption.text = locationno;
			myoption.value = locationno;
			document.getElementById("location").options.add(myoption);
			var indexvalue = document.getElementById("location").length-1;
			document.getElementById("location").selectedIndex=indexvalue;
			}
			function insertSymbol(sym)
			{
			var textexist = document.getElementById('comm5').value;
			var symboladd = document.getElementById(sym).value;
			document.getElementById('comm5').value = textexist + symboladd;
			}
			
			function changebrem4(value)
			{
			var day = value.substring(0,2)
			var month = value.substring(3,5)
			var year = value.substring(6,10)
			var symbol = value.substring(2,3)
			document.getElementById('brem4').value = day+symbol+month+symbol+((year*1)+1) ;
			}
			function joincomment()
			{
			document.getElementById('comment').value = document.getElementById('comment0').value
			
			if (document.getElementById('comment1').value !='')
			{document.getElementById('comment').value = document.getElementById('comment0').value+String.fromCharCode(13)+document.getElementById('comment1').value}
			
			if (document.getElementById('comment2').value !='')
			{document.getElementById('comment').value = document.getElementById('comment0').value+String.fromCharCode(13)+document.getElementById('comment1').value+String.fromCharCode(13)+document.getElementById('comment2').value
}
			if (document.getElementById('comment3').value !='')
			{document.getElementById('comment').value = document.getElementById('comment0').value+String.fromCharCode(13)+document.getElementById('comment1').value+String.fromCharCode(13)+document.getElementById('comment2').value+String.fromCharCode(13)+document.getElementById('comment3').value}
			
			if (document.getElementById('comment4').value !='')
			{document.getElementById('comment').value = document.getElementById('comment0').value+String.fromCharCode(13)+document.getElementById('comment1').value+String.fromCharCode(13)+document.getElementById('comment2').value+String.fromCharCode(13)+document.getElementById('comment3').value+String.fromCharCode(13)+document.getElementById('comment4').value}
;
}
<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
function activelanguage()
{
var langdesp1 = document.getElementById('dep5').value;
var langdesp2 = document.getElementById('dep6').value;
var langcomment = document.getElementById('comm5').value;
var langbrem1 = document.getElementById('req3').value;
var langbrem2 = document.getElementById('creq4').value;
var langbrem3 = document.getElementById('br36').value;
var langbrem4 = document.getElementById('br46').value;

var loadurl = '/default/transaction/activelanguage/updatelang.cfm?desp1='+escape(encodeURI(langdesp1))+'&desp2='+escape(encodeURI(langdesp2))+'&comment='+escape(encodeURI(langcomment))+'&brem1='+escape(encodeURI(langbrem1))+'&brem2='+escape(encodeURI(langbrem2))+'&brem3='+escape(encodeURI(langbrem3))+'&brem4='+escape(encodeURI(langbrem4));
	
	  new Ajax.Request(loadurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('activelanguage').innerHTML = trim(getdetailback.responseText);
        },
		onCreate: function(){ showmodal('Y');},
        onFailure: function(){ 
		alert('Language Load Failed');showmodal('N'); },		
		onComplete: function(transport){
		retrievelang();
		showmodal('N');
        }
      })
	  
}

function showmodal(showcontrol)
{
if(showcontrol == "Y")
{
ColdFusion.Window.show('activelanguagemodal');
}
else
{
ColdFusion.Window.hide('activelanguagemodal');
}
}

function retrievelang()
{
document.getElementById('dep5').value = document.getElementById('langdesp1').value;
document.getElementById('dep6').value = document.getElementById('langdesp2').value;
document.getElementById('comm5').value = document.getElementById('langcomment').value;
document.getElementById('req3').value = document.getElementById('langbrem1').value;
document.getElementById('creq4').value = document.getElementById('langbrem2').value;
document.getElementById('br36').value = document.getElementById('langbrem3').value;
document.getElementById('br46').value = document.getElementById('langbrem4').value;
}
</cfif>

function settaxcode()
	{
	<cfoutput>
	var tran='#tran#'
	</cfoutput>
	if(tran=='PO'||tran=='PR'||tran=='RC'||tran=='RQ' ){
	if(document.getElementById('tax16').value==0)
	{
	<cfoutput>
	for (var idx=0;idx<document.getElementById('selecttax').options.length;idx++) 
		{
			if ('#getGeneralInfo.df_purchasetaxzero#'==document.getElementById('selecttax').options[idx].value) 
			{
				document.getElementById('selecttax').options[idx].selected=true;
				
			}
		}
	</cfoutput>
	}
	}
	else{
	if(document.getElementById('tax16').value==0)
	{
	<cfoutput>
	for (var idx=0;idx<document.getElementById('selecttax').options.length;idx++) 
		{
			if ('#getGeneralInfo.df_salestaxzero#'==document.getElementById('selecttax').options[idx].value) 
			{
				document.getElementById('selecttax').options[idx].selected=true;
				
			}
		}
	</cfoutput>
	}
	}
	}
	function changevoucherno(){
	if(document.getElementById('voucherno').value.length == 9){
	document.getElementById('voucherno').value=document.getElementById('voucherno').value.substring(0,3)+document.getElementById('voucherprefix').value+document.getElementById('voucherno').value.substring(3,9)
	}
	else if(document.getElementById('voucherno').value.length == 12)
	{
	document.getElementById('voucherno').value=document.getElementById('voucherno').value.substring(0,3)+document.getElementById('voucherprefix').value+document.getElementById('voucherno').value.substring(6,12)
	}
	}
	
	function calsdcprice(){
	document.getElementById('pri6').value=(document.getElementById('sdcoriprice').value*document.getElementById('creq4').value).toFixed(2)
	}
	
	function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
	
	function captureso()
	{
	var listlen = 0;
	try
	{
		listlen = document.getsolist.soitemlist.length;
	}
	catch(err)
	{
		if(document.getElementById('soitemlist').checked == true){
		document.getElementById('soitem').value = document.getElementById('soitemlist').value;
		ColdFusion.Window.hide('searchsoitem');
		return true;
		} else{
		alert('No SO Selected');
		return true;
		}
	}
	var solist = "";
	var solistvar = document.getsolist.soitemlist;
	for(var i=0;i<listlen;i++)
	{
		if(solistvar[i].checked == true)
		{
		if(solist != '')
		{
			solist +=',';
		}
		solist +=solistvar[i].value;
		
		}
		
	}
	if(solist == '')
	{
		document.getElementById('soitem').value = '';
		ColdFusion.Window.hide('searchsoitem');
		return true;
	}
	document.getElementById('soitem').value = '';
	document.getElementById('soitem').value = solist;
	ColdFusion.Window.hide('searchsoitem');
	
	}								
	
	function bsssbnodisplay()
	{
		if(document.getElementById('nodisplay').checked == true)
		{
			document.getElementById('pri6').value=0;
			document.getElementById('amt').value=0;
		}
		
	}
	
            </script>
<table align='center' class='data' width='85%' cellspacing="0">
	<tr>
		<th colspan='6'>#tranname# Body</th>
    </tr>
    <tr>
        <th width="35%">Item Code<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "viva_i"><br />Product Code</cfif></th>
        <td colspan='3'>
        <cfif tran eq 'QUO' and multilocation neq "Y" and getGeneralInfo.quotationchangeitem eq "Y">
        <input type='text' name='itemno' id="itm6" value='#convertquote(itemno)#' readonly>
        
        <input type="button" name="searchitembtn" id="searchitembtn" value="Search" onClick="javascript:ColdFusion.Window.show('searchitem');">
        <cfelse>
        #itemno#<input type='hidden' name='itemno' id="itm6" value='#convertquote(itemno)#'>
        </cfif>
		<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "viva_i"><br />
        <cfquery name="getitemproductcode" datasource="#dts#">
        select aitemno from icitem where itemno='#itemno#'
        </cfquery>
        #getitemproductcode.aitemno#
		</cfif></td>
        <cfquery name="getservice" datasource="#dts#">
        select itemtype from icitem where itemno='#itemno#'
        </cfquery>
        <th <cfif getdisplaysetup2.body_bal_on_hand neq "Y">style="visibility:hidden"</cfif>><cftooltip autodismissdelay="60000" sourcefortooltip="/default/transaction/itembal2.cfm?itemno=#URLENCODEDFORMAT(itemno)#&project=&job=&batchcode=">Balance on Hand</cftooltip></th>
    	<td <cfif getdisplaysetup2.body_bal_on_hand neq "Y">style="visibility:hidden" <cfelseif getservice.itemtype eq "SV">style="visibility:hidden"</cfif>><input name='balance' id='balance' type='text' size='10' maxlength='10'value='#listfirst(balonhand)#' readonly></td>
        
    </tr>
    <tr>
        <th rowspan='2'><cfif lcase(HcomID) eq "asaiki_i">Supplier Part Number<cfelse>#getgenerallayer.ldescription#</cfif></th>
		<!--- Modified on 230908, ecraft want to show the PO Arrival Date here --->
		<cfif (lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and (tran eq "CS" or tran eq "INV")>
			<td colspan='3' nowrap><input name='desp' id="dep5" tabindex="1" type='text' value="#convertquote(desp)#" size='60' maxlength='60'></td>
            
			<th rowspan="2">Arrival Date</th>
    		<td><input name='arrivaldate' id='arrivaldate' type='text' size='10' maxlength='10' value='#arrivaldate#' readonly></td>
		<cfelseif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
			<td colspan='5' nowrap><input name='desp' id="dep5" tabindex="1" type='text' value="#convertquote(desp)#" size='60' maxlength='60' <cfif remark1 neq "V">readonly</cfif>></td>
		<cfelseif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "kjctrial_i") and (tran eq "CS" or tran eq "INV" or tran eq "DO" or tran eq "QUO" or tran eq "SO")>
        <cfquery name="getreserveqty" datasource="#dts#">
        select (ifnull(sum(qty),0) - ifnull(sum(shipped),0) - ifnull(sum(writeoff),0)) as reserveqty from ictran where 
        fperiod <>'99' 
        and (toinv='' or toinv is null)
        and type='SO'
        and (void='' or void is null) 
        and (refno!= '#nexttranno#' or trancode!='#itemcount#' or itemno!='#itemno#')
        and itemno='#itemno#'
        </cfquery>
        <td colspan='3' nowrap><input name='desp' id="dep5" tabindex="1" type='text' value="#convertquote(desp)#" size='65' maxlength='65'></td>
        <th ><cftooltip autodismissdelay="60000" sourcefortooltip="/default/transaction/reservedqty.cfm?itemno=#URLENCODEDFORMAT(itemno)#&project=&job=&batchcode=">Reserved Qty</cftooltip></th>
			<td nowrap><input name='reserveqty2' id="reserveqty2" type='hidden' value="#listfirst(balonhand)-getreserveqty.reserveqty#" size='10' maxlength='10' readonly><input name='reserveqty' id="reserveqty" type='text' value="#getreserveqty.reserveqty#" size='10' maxlength='10' readonly></td>
        <cfelseif tran eq "SO">
        <cfquery name="getreserveqty" datasource="#dts#">
        select (ifnull(sum(qty),0) - ifnull(sum(shipped),0) - ifnull(sum(writeoff),0)) as reserveqty from ictran where 
        fperiod <>'99' 
        and (toinv='' or toinv is null)
        and (void='' or void is null) 
        and type='SO'
        and itemno='#itemno#'
        </cfquery>
        <td colspan='3' nowrap><input name='desp' id="dep5" tabindex="1" type='text' value="#convertquote(desp)#" size='60' maxlength='60'></td>
        <th ><cftooltip autodismissdelay="60000" sourcefortooltip="/default/transaction/reservedqty.cfm?itemno=#URLENCODEDFORMAT(itemno)#&project=&job=&batchcode=">Available Qty</cftooltip></th>
			<td nowrap><input name='reserveqty2' id="reserveqty2" type='text' value="#listfirst(balonhand)-getreserveqty.reserveqty#" size='10' maxlength='10' readonly>
            <input name='reserveqty' id="reserveqty" type='hidden' value="#getreserveqty.reserveqty#" size='10' maxlength='10' readonly>
            
            </td>
        <cfelse>
			<td colspan='5' nowrap><input name='desp' id="dep5" tabindex="1" type='text' value="#convertquote(desp)#" size='60' maxlength='75'></td>
		</cfif>
    </tr>
   
    <tr>
        <td colspan='3' nowrap>
			<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<input name='despa' id="dep6" type='text' tabindex="2" value="#convertquote(despa)#" size='60' maxlength='70' <cfif remark1 eq "F">readonly</cfif>>
			<cfelse>
				<input name='despa' id="dep6" type='text' tabindex="2" value="#convertquote(despa)#" size='60' maxlength='75'>
			</cfif>		</td>
         <cfif lcase(hcomid) eq "meisei_i">
         <cfquery name="getitempacking" datasource="#dts#">
         select PACKING from icitem where itemno='#itemno#'
         </cfquery>
         <th>SPQ/MOQ</th>
         <td>#getitempacking.PACKING#</td>
         </cfif>
         
          
    <cfif lcase(hcomid) eq "excelsnm_i">
            <cfquery name="getpacking" datasource="#dts#">
            select * from icitem where itemno='#itemno#'
            </cfquery>
            <th>Packing</th>
            <td>#getpacking.packing#</td>
            </cfif>
    </tr>
    <tr>
        <td style="background-color:##D6ECFC;font-size:13px;padding:0px 10px 0px 10px;" align="right"><strong>Comment</strong></td>
        <td colspan='3'>
			<cfif getGeneralInfo.texteditor eq "1">
				<textarea name='comment' id="comm5" tabindex="3" cols='60' rows='5'>#convertquote(comment)#</textarea>
            <cfelseif getGeneralInfo.commenttext eq "Y">
			<cfset rcdc = listlen(convertquote(comment),chr(13))>
            <cfset comment0 = "">
            <cfset comment1 = "">
            <cfset comment2 = "">
            <cfset comment3 = "">
            <cfset comment4 = "">
            
            <cfif rcdc neq 0>
            <cfloop from="1" to="#rcdc#" index="i">
            <cfset "comment#i-1#" = listgetat(convertquote(comment),'#i#',chr(13))>
            </cfloop>
			</cfif>
            
            <cfif rcdc gt 5>
            <cfloop from="5" to="#rcdc-1#" index="a">
            <cfset comment4 = comment4&evaluate("comment#a#")>
            </cfloop>
			</cfif>
            
            <input type="text" name="comment0" id="comment0" size="60" maxlength="#getGeneralInfo.commentlimit#" value="#comment0#" onblur="JavaScript:joincomment()"/><br/>
            <input type="text" name="comment1" id="comment1" size="60" maxlength="#getGeneralInfo.commentlimit#" onblur="JavaScript:joincomment()" value="#comment1#"/>
            <br />
            <input type="text" name="comment2" id="comment2" size="60" maxlength="#getGeneralInfo.commentlimit#"onblur="JavaScript:joincomment()" value="#comment2#" />
            <br />
            <input type="text" name="comment3" id="comment3" size="60" maxlength="#getGeneralInfo.commentlimit#"onblur="JavaScript:joincomment()" value="#comment3#" />
            <br />
            <input type="text" name="comment4" id="comment4" size="60" maxlength="#getGeneralInfo.commentlimit#"onblur="JavaScript:joincomment()" value="#comment4#" />
			<textarea name='comment' id="comm5" tabindex="3" cols='60' rows='5' style="visibility:hidden; position:absolute" >#convertquote(comment)#</textarea>
			<cfelse>
				<cfif tran eq "SAM">
					<textarea name='comment' id="comm5" tabindex="3" cols='70' rows='5' wrap="hard" style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
				<cfelseif tran eq "DO">
					<cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">
						<textarea name='comment' id="comm5" tabindex="3" cols='55' rows='5' wrap="hard" style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
                    <cfelse>
						<textarea name='comment' id="comm5" tabindex="3" cols='80' rows='5' wrap="hard" style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
					</cfif>
				<cfelse>
                	<cfif lcase(hcomid) eq "apnt_i">
                    <cfif tran eq "INV">
						<textarea name='comment' id="comm5" tabindex="3" cols='60' rows='5' wrap="hard" style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
                    <cfelse>
                    	<textarea name='comment' id="comm5" tabindex="3" cols='65' rows='5' wrap="hard" style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
                    </cfif>
                        <cfelse>
					<textarea name='comment' id="comm5" tabindex="3" <cfif lcase(hcomid) eq "agape_i"> cols='70'<cfelse> cols='60'</cfif> rows='5' <cfif lcase(hcomid) eq "spcivil_i" >wrap="soft"<cfelse>wrap="hard"</cfif> style="font-family:'Courier New', Courier, monospace">#convertquote(comment)#</textarea>
					</cfif>
                </cfif>
			</cfif> <input type="button" name="SYMBOL" id="SYMBOL" value="SYMBOL" onClick="javascript:ColdFusion.Window.show('findSymbol');" >
            
            <input type="button" name="MCE" id="MCE" value="MCE" onClick="texteditor();" >		</td>
        <td colspan='2'>
			<cfif type1 neq "delete">
            <cfif lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i">
				<div <cfif getdisplaysetup2.body_searchcomment neq "Y">style="visibility:hidden"</cfif>><input type="button" name="SearchComment" style="width: 100px; height: 20px; font-size:9px" value="Search Comment" onClick="javascript:ColdFusion.Window.show('findComment');"></div>

                <div <cfif getdisplaysetup2.body_extendcomment neq "Y">style="visibility:hidden"</cfif>><input type="button" name="Extend Comment" style="width: 100px; height: 20px; font-size:9px" value="Extend Comment" onClick="javascript:ColdFusion.Window.show('extendcomment');"></div>
                <div <cfif getdisplaysetup2.body_createnewcomment neq "Y">style="visibility:hidden"</cfif>><input type="button" name="createComment" style="width: 100px; height: 20px; font-size:9px" value="Create New Comment" onClick="window.open('/default/maintenance/commenttable2.cfm?type=Create')"></div>

                <div <cfif getdisplaysetup2.body_searchmaterial neq "Y">style="visibility:hidden"</cfif>><input type="button" name="searchmaterial" style="width: 100px; height: 20px; font-size:9px" value="Search Material" onClick="javascript:ColdFusion.Window.show('findmats');"></div>
            </cfif>
			</cfif>
            <cfif lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i">
            <div <cfif getdisplaysetup2.body_uploadimage neq "Y">style="visibility:hidden"</cfif>><input type="button" name="uploadimage" style="width: 100px; height: 20px; font-size:9px" value="Upload Image" onClick="javascript:ColdFusion.Window.show('uploadimage');"></div>
          </cfif>
            <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
            <input type="button" name="changelanguage" value="Change Language" style="width: 100px; height: 20px; font-size:9px" onClick="activelanguage();">
            <cfwindow name="activelanguagemodal" height="200" width="200" center="true" closable="false" draggable="false" resizable="false" modal="true">
            <div class="loading-indicator">
            Loading Language....
            </div>
            </cfwindow>
            <div id="activelanguage" style="display:none">
            </div>
            <script type="text/javascript">
				function getfilename(newval)
				{
				var valuepieces = newval.split("\\");
				document.getElementById('ictranfilename').value = valuepieces[valuepieces.length-1];
				}
                </script>
            <input type="file" name="ictranfile" id="ictranfile" value="" size="5" onchange="getfilename(this.value);" />
            <input type="hidden" name="ictranfilename" id="ictranfilename" value="#ictranfilename#" />
            <div id="fileid"><cfif trim(ictranfilename) neq "">
            <a href="/download/#dts#/#ictranfilename#" target="_blank">#ictranfilename#</a>
            <a style="cursor:pointer" onclick="if(confirm('Are you sure you want to delete file?')){document.getElementById('ictranfilename').value='';document.getElementById('fileid').innerHTML='';}">Delete</a>
			</cfif></div>
            
			</cfif>
            <cfif lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i">
			<div <cfif getdisplaysetup2.body_copyitemremark neq "Y">style="visibility:hidden"</cfif>><input type='Button' id="cp1" name='Copy' value='Copy Item Remark' style="width: 100px; height: 20px; font-size:9px" onClick='JavaScript:CopyItemRemark()'></div>        </cfif></td>
    </tr>

	<cfif isservice eq 1 and getGeneralInfo.showservicepart eq 'Y'>
	   	<cfquery name="getAllItem" datasource="#dts#">
			select 
			itemno,
			desp
			from icitem 
			order by itemno;
		</cfquery>
		
		<tr>
          
        	<th <cfif getdisplaysetup2.body_service neq "Y">style="visibility:hidden"</cfif>>Service Part</th>
          	<td colspan='5' <cfif getdisplaysetup2.body_service neq "Y">style="visibility:hidden"</cfif>>
			<select name='sv_part' id="sv5">
				<option value=''>Choose an Part</option>
              	<cfloop query="getAllItem">
                	<option value='#getAllItem.Itemno#'<cfif xsv_part eq getAllItem.Itemno>selected</cfif>>#getAllItem.itemno# - #getAllItem.desp#</option>
              	</cfloop>
            	</select>			</td>
		</tr>
        <tr>
          	<th <cfif getdisplaysetup2.body_service neq "Y">style="visibility:hidden"</cfif>>Service Cost</th>
          	<td colspan='5' <cfif getdisplaysetup2.body_service neq "Y">style="visibility:hidden"</cfif>><input type='text' name='sercost' id="sc5" maxlength='14' value='#numberformat(sercost,"_.__")#' size='14'></td>
        </tr>
	<cfelse>
        <input type='hidden' name='sv_part' id="sv6" maxlength='14' value='' size='14'>
        <input type='hidden' name='sercost' id="sc6" maxlength='14' value='' size='14'>
	</cfif>
	<cfif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i" or lcase(hcomid) eq "chequer_i">
    <tr>
    <cfquery name="getfcurrcode" datasource="#dts#">
    select fcurrcode from icitem where itemno='#itemno#'
    </cfquery>
          	<th <cfif lcase(hcomid) eq "ascend_i" >style="visibility:hidden"</cfif>>Currency Code</th>
          	<td colspan='5' <cfif lcase(hcomid) eq "ascend_i" >style="visibility:hidden"</cfif>>#getfcurrcode.fcurrcode#</td>
        </tr>
	</cfif>
	<tr>
        <th rowspan="2" <cfif getdisplaysetup2.body_uom neq "Y">style="visibility:hidden"</cfif>>U.O.M.</th>
        <!--- REMARK ON 190908 --->
		<!---  <td colspan='3' nowrap><input type='text' name='unit' id="uni6" maxlength='12' value='#unit#' size='20' readonly></td> --->
		<td colspan='3' nowrap <cfif getdisplaysetup2.body_uom neq "Y">style="visibility:hidden"</cfif>>
			<cfif is_service eq 1>
				<input type='text' name='unit'  id="uni6" maxlength='15' value='#unit#' size='12'>
			<cfelse>
				<input type='text' name='unit'  id="uni6" maxlength='15' value='#unit#' size='12' readonly>
			</cfif>
			<input type="text" name="factor1"  value='#numberformat(factor1,"_._____")#' size="12" readonly>
			<input type="text" name="factor2"  value='#numberformat(factor2,"_._____")#' size="12" readonly>
			<cfif is_service neq 1>
				<input type="button" value="Change Unit" onclick="changeUnit();">
			</cfif>		</td>
        <th nowrap><cfif lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i">PKG<cfelse>Qty</cfif></th>
		<!--- ADD ON 05-06-2009 --->
		<input type="hidden" name="qty1" value="#qty1#">
		<input type="hidden" name="qty2" value="#qty2#">
		<input type="hidden" name="qty3" value="#qty3#">
		<input type="hidden" name="qty4" value="#qty4#">
		<input type="hidden" name="qty5" value="#qty5#">
		<input type="hidden" name="qty6" value="#qty6#">
		<input type="hidden" name="qty7" value="#qty7#">
        
        <cfif isdefined("url.type1") and type1 eq 'Add' and lcase(hcomid) eq "taftc_i">
        <cfset qty = "1">
        </cfif>
        <td>
        <!---Cannot key more than existing qty--->
        <cfif isdefined("url.editqty")>
        <input type="hidden" name="enablemoreqtyonly" id="enablemoreqtyonly" value="1" />
        <cfelse>
        <input type="hidden" name="enablemoreqtyonly" id="enablemoreqtyonly" value="0" />
        </cfif>
        
        <!---check minimum selling price--->
        
        <cfquery name="checkminimumsellingprice" datasource="#dts#">
			select
			price,ucost
			from icitem 
			where itemno='#itemno#'
		</cfquery>
        <input type='hidden' id="minimumsellingprice" name='minimumsellingprice' value='#checkminimumsellingprice.price#'>
        <cfif tran eq 'PO' or tran eq 'PR' or tran eq 'RC' or tran eq 'RQ'>
        <input type='hidden' id="minimumsellingpassword" name='minimumsellingpassword' value='N'>
        <cfelse>
        <cfif checkcustom.minimum_selling_price eq "Y" and (checkcustom.minimum_selling_price1 eq "" or ListFindNoCase(checkcustom.minimum_selling_price1,tran))>
        <input type='hidden' id="minimumsellingpassword" name='minimumsellingpassword' value='Y'>
        <cfelse>
       	<input type='hidden' id="minimumsellingpassword" name='minimumsellingpassword' value='N'>
        </cfif>
        </cfif>
        <input type='hidden' id="sellingbelowcost" name='sellingbelowcost' value='#checkminimumsellingprice.ucost#'>
        <cfif checkcustom.selling_below_cost eq "Y">
        <input type='hidden' id="sellingbelowcostpassword" name='sellingbelowcostpassword' value='Y'>
        <cfelse>
       	<input type='hidden' id="sellingbelowcostpassword" name='sellingbelowcostpassword' value='N'>
        </cfif>
        
		<!--- Use to check the Qty cannot more the qty balance on hand --->
        <cfif tran eq "SO">
        <cfif getGeneralInfo.proavailqty eq "1" and isservice neq 1>
        <input type='hidden' id="cpq5" name='CompareQty' value='Y'>
        <cfif checkcustom.negstkpassword eq "Y" and (checkcustom.negstkpassword1 eq "" or ListFindNoCase(checkcustom.negstkpassword1,tran))>
        <input type='hidden' id="negqtypassword" name='negqtypassword' value='Y'>
        <cfelse>
        <input type='hidden' id="negqtypassword" name='negqtypassword' value='N'>
        </cfif>
        <input type='hidden' id="min6" name='minimum' value='#getitembal.minimum#'>
        <cfelse>
        <input type='hidden' id="cpq6" name='CompareQty' value='N'>
        <cfif checkcustom.negstkpassword eq "Y" and (checkcustom.negstkpassword1 eq "" or ListFindNoCase(checkcustom.negstkpassword1,tran))>
        <input type='hidden' id="negqtypassword" name='negqtypassword' value='Y'>
        <cfelse>
        <input type='hidden' id="negqtypassword" name='negqtypassword' value='N'>
        </cfif>
        </cfif>
        <cfelse>
		<cfif getGeneralInfo.negstk eq "0">
			<cfif isservice neq 1 and (tran eq "PR" or tran eq "DO" or tran eq "INV" or tran eq "CS" or tran eq "DN" or tran eq "ISS" or tran eq "OAR")>
              	<input type='hidden' id="cpq5" name='CompareQty' value='Y'>
                <input type='hidden' id="allownegstk" name='allownegstk' value='N'>
                <cfif checkcustom.negstkpassword eq "Y" and (checkcustom.negstkpassword1 eq "" or ListFindNoCase(checkcustom.negstkpassword1,tran))>
        		<input type='hidden' id="negqtypassword" name='negqtypassword' value='Y'>
        		<cfelse>
       			<input type='hidden' id="negqtypassword" name='negqtypassword' value='N'>
        		</cfif>
              	<input type='hidden' id="min6" name='minimum' value='#getitembal.minimum#'>
            <cfelse>
              	<input type='hidden' id="cpq6" name='CompareQty' value='N'>
                <cfif checkcustom.negstkpassword eq "Y" and (checkcustom.negstkpassword1 eq "" or ListFindNoCase(checkcustom.negstkpassword1,tran))>
        		<input type='hidden' id="negqtypassword" name='negqtypassword' value='Y'>
        		<cfelse>
        		<input type='hidden' id="negqtypassword" name='negqtypassword' value='N'>
        		</cfif>
                <input type='hidden' id="negqtypassword" name='negqtypassword' value='#checkcustom.negstkpassword#'>
            </cfif>
		<cfelse>
            <!--- Negative Stock is allow, so no need to check. --->
            <input type='hidden' id="cpq7" name='CompareQty' value='N'>
        </cfif>
        </cfif>
		
		<cfif isdefined("form.enterbatch")>
        
        <cfif getGeneralInfo.quobatch eq "Y" and (form.tran eq "QUO" or form.tran eq "SO" or form.tran eq "PO" or form.tran eq "RQ")>
        
        <cfif trim(form.enterbatch) neq "">
        <cfset enterbatch = form.enterbatch >
        <cfset milcert = form.milcert >
        <cfset importpermit = form.importpermit >
        <cfset countryoforigin = form.countryoforigin >
        <cfset pallet = form.pallet >
        <cfif form.expdate neq "">
        <cfset ndate = createdate(right(form.expdate,4),mid(form.expdate,4,2),left(form.expdate,2))>
        <cfset newdate = dateformat(ndate,'YYYY-MM-DD')>
        <cfelse>
        <cfset newdate = "0000-00-00">
		</cfif>
        <cfif form.manudate neq "">
        <cfset ndate1 = createdate(right(form.manudate,4),mid(form.manudate,4,2),left(form.manudate,2))>
        <cfset newdate1 = dateformat(ndate1,'YYYY-MM-DD')>
        <cfelse>
        <cfset newdate = "0000-00-00">
		</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfquery name="updateLotNo" datasource="#dts#">
					update gsetup
					set lotno = '#enterbatch#'
				</cfquery>
				<cfquery name="insert" datasource="#dts#">
					insert into lotnumber
					(LotNumber,itemno)
					value
					(<cfqueryparam cfsqltype="cf_sql_char" value="#enterbatch#">,
					<cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">)
				</cfquery>
			</cfif>
		
		<cfquery name="checkbatch" datasource="#dts#">
			select 
			batchcode,refno
			from obbatch 
			where batchcode='#enterbatch#' 
			and itemno='#form.items#';
		</cfquery>
		
			<cfif checkbatch.recordcount eq 0>
                <cfquery name="insertbatch" datasource="#dts#">
                    insert into obbatch
                    (
                	batchcode,
                    itemno,
                    type,
                    refno,
                    bth_QOB,
                    BTH_QIN,
                    BTH_QUT,
                    RPT_QOB,
                    RPT_QIN,
                    RPT_QUT,
                    EXP_DATE,
                    manu_date,
                    RC_TYPE,
                    RC_REFNO,
                    RC_EXPDATE
                ) 
                     values 
                    (
                        '#form.enterbatch#',
                        '#form.items#',
                        'RC',
                        '99999999',
                        '0',
                        '#val(form.batchqty)#',
                        '0',
                        '0',
                        '0',
                        '0',
                        '#newdate#',
                        '#newdate#1',
                        'RC',
                        '99999999',
                        '#newdate#'
                    );
                </cfquery>
            <cfelse>
                <cfquery name="updateobbatch" datasource="#dts#">
                    update obbatch set 
                    bth_qin=(<cfif checkbatch.refno neq "99999999">bth_qin+</cfif>#val(form.batchqty)#) 
                    where itemno='#form.items#' 
                    and batchcode='#enterbatch#';
                </cfquery>
			</cfif>
		</cfif>
        </cfif>
        
			<cfif tran neq "RC" and tran neq "CN" and tran neq "OAI">
				<cfif form.enterbatch neq "">
					<cfquery name="checkbatchqty" datasource="#dts#">
						<cfif location neq "">
                        <!---
							select 
							location,
							batchcode,
							rc_type,
							rc_refno,
							((bth_qob+bth_qin)-bth_qut) as batch_balance,
							expdate,
                            manudate,
                            milcert ,importpermit,
                            countryoforigin,
                    		pallet
							from lobthob 
							where location='#location#' 
							and batchcode='#form.enterbatch#' 
							and itemno='#form.items#' 
							and ((bth_qob+bth_qin)-bth_qut) <> 0 
							order by itemno;--->
                            
                            select 
                            a.batchcode,a.location,
                            a.rc_type,
                            a.rc_refno,
                            ((a.bth_qob+ifnull(b.getin,0))-ifnull(c.getout,0)) as batch_balance,
                            a.expdate,
                            a.manudate ,
                            a.milcert,a.importpermit,
                            a.countryoforigin,
                            a.pallet
                            from lobthob as a
                            
                            left join
                            (select sum(qty) as getin,itemno,batchcode,location  
                            from ictran
                            where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
                            and (void = '' or void is null) and batchcode<>'' and location<>''
                            and itemno='#form.items#' 
                            and location='#location#' 
                            and batchcode='#form.enterbatch#' 
                            group by itemno,batchcode,location
                            ) as b on a.itemno = b.itemno and a.batchcode=b.batchcode and a.location=b.location
            
                            left join
                            (	select sum(qty) as getout,itemno,batchcode,location 
                                from ictran
                                where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
                                and (void = '' or void is null) 
                                and toinv='' and batchcode<>'' and location<>''
                                and itemno='#form.items#' 
                                and location='#location#' 
                                and batchcode='#form.enterbatch#' 
                                group by itemno,batchcode,location
                            ) as c on a.itemno = c.itemno and a.batchcode=c.batchcode and a.location=c.location
                                             
                            where 
                            a.itemno='#form.items#' 
                            and a.location='#location#' 
                            and a.batchcode='#form.enterbatch#' 
                            and ((a.bth_qob+ifnull(b.getin,0))-ifnull(c.getout,0)) >0
                            order by a.itemno;
                            
						<cfelse>
                        <!---
							select 
							batchcode,
							rc_type,
							rc_refno,
							((bth_qob+bth_qin)-bth_qut) as batch_balance,
							exp_date,
                            manu_date 
							from obbatch
							where batchcode='#form.enterbatch#' 
							and itemno='#form.items#' 
							and ((bth_qob+bth_qin)-bth_qut) <> 0 
							order by itemno;--->
                            
                            select 
                            a.batchcode,
                            a.rc_type,'' as location,
                            a.rc_refno,
                            ((a.bth_qob+ifnull(b.getin,0))-ifnull(c.getout,0)) as batch_balance,
                            a.exp_date as expdate,
                            a.manu_date as manudate,
                            a.milcert,a.importpermit,
                            a.countryoforigin,
                            a.pallet
                            from obbatch as a
                            
                            left join
                            (select sum(qty) as getin,itemno,batchcode  
                            from ictran
                            where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN')
                            and (void = '' or void is null) and batchcode<>''
                            and batchcode='#form.enterbatch#' 
							and itemno='#form.items#' 
                            group by itemno,batchcode
                            ) as b on a.itemno = b.itemno and a.batchcode=b.batchcode
            
                            left join
                            (	select sum(qty) as getout,itemno,batchcode 
                                from ictran
                                where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
                                and (void = '' or void is null) 
                                and toinv='' and batchcode<>''
                                and batchcode='#form.enterbatch#' 
								and itemno='#form.items#'  
                                group by itemno,batchcode
                            ) as c on a.itemno = c.itemno and a.batchcode=c.batchcode
                            
                            
                            where a.batchcode='#form.enterbatch#' 
							and a.itemno='#form.items#' 
                            and ((a.bth_qob+ifnull(b.getin,0))-ifnull(c.getout,0)) >0
                            order by a.itemno;
                            
						</cfif>
					</cfquery>
				
					<cfif val(form.batchqty) gt val(checkbatchqty.batch_balance) and type1 neq "Edit">
						<script>
							alert("Batch QTY Invalid");
							javascript:history.back();
						</script>
					</cfif>
				</cfif>
			</cfif>
			<!--- Batch Option --->
			<input type="hidden" name="grdcolumnlist" value="#grdcolumnlist#">
            <input type="hidden" name="grdvaluelist" value="#grdvaluelist#">
			<input type="hidden" name="totalrecord" value="#totalrecord#">
			<input type="hidden" name="bgrdcolumnlist" value="#bgrdcolumnlist#">
			<input type="hidden" name="oldgrdvaluelist" value="#oldgrdvaluelist#">
			<!--- <cfif multilocation neq "Y">
				<cfif graded neq "" and graded eq "Y">
					<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="checkqty();" readonly>
					<input type="button" value="Grade" onclick="AssignGrade();">
				<cfelse>
					<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="checkqty();">
				</cfif>
			<cfelse>
				<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="checkqty();" readonly>
			</cfif> --->
			<cfif multilocation eq "Y" and is_service neq 1>
				<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
			<cfelse>
				<cfif graded neq "" and graded eq "Y">
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
					<input type="button" value="Grade" onclick="AssignGrade();">
				<cfelse>
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" onblur="<cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" <cfif (wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "") or isdefined('url.editinfoonly')>readonly</cfif>>
					<cfif wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "">
                        <input type="button" name="btnprice" value="Q" style="cursor:hand" onclick="calculateFormula('qtyFormula');">
                    </cfif>
				</cfif>
			</cfif>
			
			<!--- <input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#batchqty#' onkeyup="checkqty();"> --->
			<input name='batchqty' type="hidden" size='10' maxlength='10' value='#batchqty#'>
			<cfif isdefined("url.type1") and type1 eq 'Add'>
				<input name='oldqty' id="oldqty" type='hidden' size='10' maxlength='10' value='0'>
				<input name='oldenterbatch' id='oldenterbatch' type='hidden' value=''>
			<cfelse>
				<input name='oldqty' id="oldqty" type='hidden' size='10' maxlength='10' value='#oldqty#'>

				<cfif oldenterbatch eq "">
					<input name='oldenterbatch' id='oldenterbatch' type='hidden' value=''>
				<cfelse>
					<input name='oldenterbatch' id='oldenterbatch' type='hidden' value='#oldenterbatch#'>
				</cfif>
			</cfif>

			<input name='dodate' id='dodate' type='hidden' value='#form.dodate#'>
			<input name='sodate' id='sodate' type='hidden' value='#form.sodate#'>
			<input name='adtcost1' id='adtcost1' type='hidden' value='#form.mc1bil#'>
			<input name='adtcost2' id='adtcost2' type='hidden' value='#form.mc2bil#'>
			<input name='enterbatch' id='enterbatch' type="hidden" value='#form.enterbatch#'>
			<input name='expdate' id='expdate' type='hidden' value='#form.expdate#'>
            <input name='manudate' id='manudate' type='hidden' value='#form.manudate#'>
            <input name='milcert' id='milcert' type='hidden' value='#form.milcert#'>
            <input name='importpermit' id='importpermit' type='hidden' value='#form.importpermit#'>
            <input name='countryoforigin' id='countryoforigin' type='hidden' value='#form.countryoforigin#'>
            <input name='pallet' id='pallet' type='hidden' value='#form.pallet#'>
			<input name='mc1bil' id='mc1bil' type='hidden' value='#form.mc1bil#'>
			<input name='mc2bil' id='mc2bil' type='hidden' value='#form.mc2bil#'>
			<input name='defective' id='defective' type='hidden' value='#form.defective#'>
			<!---End Batch Option --->
		<cfelseif isdefined("url.type1") and type1 eq 'Add'>
            <!--- Modified on 290808 for Graded Item --->
			<input type="hidden" name="grdcolumnlist" value="#grdcolumnlist#">
            <input type="hidden" name="grdvaluelist" value="#grdvaluelist#">
			<input type="hidden" name="totalrecord" value="#totalrecord#">
			<input type="hidden" name="bgrdcolumnlist" value="#bgrdcolumnlist#">
			<input type="hidden" name="oldgrdvaluelist" value="#oldgrdvaluelist#">
			<!--- <cfif multilocation neq "Y">
				<cfif graded neq "" and graded eq "Y">
					<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#qty#' onkeyup="checkqty();" readonly>
					<input type="button" value="Grade" onclick="AssignGrade();">
				<cfelse>
					<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#qty#' onkeyup="checkqty();">
				</cfif>
			<cfelse>
				<input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#qty#' onkeyup="checkqty();" readonly>
			</cfif> --->
			<cfif multilocation eq "Y" and is_service neq 1>
				<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
			<cfelse>
				<cfif graded neq "" and graded eq "Y">
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
					<input type="button" value="Grade" onclick="AssignGrade();">
				<cfelse>
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelseif lcase(hcomid) eq 'fixics_i'>document.getElementById('creq4').value=this.value*'#getitembal.qty2#';<cfelse>checkqty();</cfif>" onblur="<cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" <cfif (wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "") or isdefined('url.editinfoonly')>readonly</cfif>>
					<cfif wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "">
                        <input type="button" name="btnprice" value="Q" style="cursor:hand" onclick="calculateFormula('qtyFormula');">
                    </cfif>
				</cfif>
			</cfif>
			
			
			<input name='oldqty' id="oldqty" type='hidden' size='10' maxlength='10' value='0'>
			<input name='oldenterbatch' id='oldenterbatch' type='hidden' value=''>
			<input name='dodate' id='dodate' type='hidden' value=''>
			<input name='sodate' id='sodate' type='hidden' value=''>
			<input name='adtcost1' id='adtcost1' type='hidden' value=''>
			<input name='adtcost2' id='adtcost2' type='hidden' value=''>
			<input name='enterbatch' id='enterbatch' type="hidden" value=''>
			<input name='expdate' id='expdate' type='hidden' value=''>
            <input name='manudate' id='manudate' type='hidden' value=''>
            <input name='milcert' id='milcert' type='hidden' value=''>
            <input name='importpermit' id='importpermit' type='hidden' value=''>
            <input name='countryoforigin' id='countryoforigin' type='hidden' value=''>
            <input name='pallet' id='pallet' type='hidden' value=''>
			<input name='mc1bil' id='mc1bil' type='hidden' value=''>
			<input name='mc2bil' id='mc2bil' type='hidden' value=''>
			<input name='defective' id='defective' type='hidden' value=''>
		<cfelse>
			 <!--- Modified on 020908 for Graded Item --->
			<input type="hidden" name="grdcolumnlist" value="#grdcolumnlist#">
            <input type="hidden" name="grdvaluelist" value="#grdvaluelist#">
			<input type="hidden" name="totalrecord" value="#totalrecord#">
			<input type="hidden" name="bgrdcolumnlist" value="#bgrdcolumnlist#">
			<input type="hidden" name="oldgrdvaluelist" value="#oldgrdvaluelist#">
			<cfif multilocation eq "Y" and is_service neq 1>
				<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
			<cfelse>
				<cfif graded neq "" and graded eq "Y">
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" readonly>
					<input type="button" value="Grade" onclick="AssignGrade();">
				<cfelse>
					<input name='qty' id="qt6" tabindex="4" type='text' size='10' maxlength='10' value='#qty#' onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" onblur="<cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>" <cfif (wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "") or isdefined('url.editinfoonly')>readonly</cfif>>
                    <cfif wqformula eq "1" and trim(getGeneralInfo.qtyformula) neq "">
                        <input type="button" name="btnprice" value="Q" style="cursor:hand" onclick="calculateFormula('qtyFormula');">
                    </cfif>
				</cfif>
			</cfif>
			
			<!--- <input name='qty' id="qt6" type='text' size='10' maxlength='10' value='#qty#' onkeyup="checkqty();"> --->
			<input name='oldqty' id="oldqty" type='hidden' size='10' maxlength='10' value='#oldqty#'>
			<cfif multilocation eq "Y" and is_service neq 1>
				<input name='oldenterbatch' id='oldenterbatch' type='hidden' value=''>
			<cfelse>
				<input name='oldenterbatch' id='oldenterbatch' type='hidden' value='#getitem.batchcode#'>
                <input name='dodate' id='dodate' type='hidden' value='#dateformat(getitem.dodate,"dd-mm-yyyy")#'>
				<input name='sodate' id='sodate' type='hidden' value='#dateformat(getitem.sodate,"dd-mm-yyyy")#'>
				<input name='adtcost1' id='adtcost1' type='hidden' value='#getitem.mc1_bil#'>
				<input name='adtcost2' id='adtcost2' type='hidden' value='#getitem.mc2_bil#'>
			</cfif>
			
			
			<!--- <cfif multilocation neq "Y">
				<input name='enterbatch' id='enterbatch' type="hidden" value='#getitem.batchcode#'>
			<cfelse>
				<input name='enterbatch' id='enterbatch' type="hidden" value=''>
			</cfif> --->
			<cfif multilocation eq "Y" and is_service neq 1>
				<input name='enterbatch' id='enterbatch' type="hidden" value=''>
			<cfelse>
				<input name='enterbatch' id='enterbatch' type="hidden" value='#getitem.batchcode#'>
				<!--- <input name='expdate' id='expdate' type='hidden' value='#dateformat(getitem.expdate,"yyyy-mm-dd")#'> --->
                <input name='expdate' id='expdate' type='hidden' value='#dateformat(getitem.expdate,"dd-mm-yyyy")#'>
                <input name='manudate' id='manudate' type='hidden' value='#dateformat(getitem.manudate,"dd-mm-yyyy")#'>
                <input name='milcert' id='milcert' type='hidden' value='#getitem.milcert#'>
                <input name='importpermit' id='importpermit' type='hidden' value='#getitem.importpermit#'>
                <input name='countryoforigin' id='countryoforigin' type='hidden' value='#getitem.countryoforigin#'>
                <input name='pallet' id='pallet' type='hidden' value='#getitem.pallet#'>
				<input name='mc1bil' id='mc1bil' type='hidden' value='#getitem.mc1_bil#'>
				<input name='mc2bil' id='mc2bil' type='hidden' value='#getitem.mc2_bil#'>
				<input name='defective' id='defective' type='hidden' value='#getitem.defective#'>
			</cfif>
		</cfif>

		<cfif mode eq "Add" or type1 eq "Add">
			<input type="hidden" name="type1" value="#type1#">
			<input type="hidden" name="items" value="#convertquote(itemno)#">
			<input type="hidden" name="itemcount" value="0">
			<input type="hidden" name="service" value="#convertquote(service)#">
			<input type="hidden" name="agenno" value="#agenno#">
			<input type="hidden" name="refno3" value="#refno3#">
			<cfif multilocation neq "Y" and is_service neq 1>
            <cfif getmodule.batchcode eq 1>
				<!--- <input type="submit" name="submit" value="Select Batch Code"> --->	
				<cfif checkcustom.customcompany eq "Y">
					<input type="button" name="submit" value="Lot Number" onclick="selectBatch();">
				<cfelse>
                <cfif lcase(hcomid) neq "visionlaw_i" and lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i">
					<input type="submit" name="submit" value="Select #getGeneralInfo.lbatch# Code">
                </cfif>
				</cfif>
            </cfif>
			</cfif>
		<cfelse>
			<input type="hidden" name="items" value="#convertquote(itemno)#">
			<input type="hidden" name="type1" value="#type1#">
			<input type="hidden" name="service" value="#convertquote(service)#">
			<input type="hidden" name="agenno" value="#agenno#">
			<input type="hidden" name="refno3" value="#refno3#">
			<input type="hidden" name="enterbatch1" value="#URLDECODE(enterbatch)#">
			<input type="hidden" name="batchqty" value="#qty#">
			<cfif multilocation neq "Y" and is_service neq 1>
            <cfif getmodule.batchcode eq 1>
				<!--- <input type="submit" name="submit" value="Select Batch Code"> --->
				<cfif checkcustom.customcompany eq "Y">
					<input type="button" name="submit" value="Lot Number" onclick="selectBatch();">
				<cfelse>
                <cfif lcase(hcomid) neq "visionlaw_i" and lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i">
					<input type="submit" name="submit" value="Select #getGeneralInfo.lbatch# Code">
                    </cfif>
				</cfif>
            </cfif>
			</cfif>
		</cfif>       	</td>
	</tr>
    <tr>
        <td colspan='3' nowrap></td>
        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
        
        <th><cfif lcase(hcomid) eq "visionlaw_i">Fee<cfelseif lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Cap<cfelseif tran eq 'RQ'>Cost<cfelse>Price</cfif></th>
        <td> 
			<input name='price' id="pri6" tabindex="5" type='text' <cfif lcase(hcomid) eq "meisei_i" >size='10' maxlength='15' <cfelse>size='10' maxlength='10'</cfif> value='<cfif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and isdefined('form.batchcap')>#numberformat(val(form.batchcap),stDecl_UPrice)#<cfelse>#numberformat(price,stDecl_UPrice)#</cfif>'<cfif (lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super") or (wpformula eq "1" and trim(getGeneralInfo.priceformula) neq "")> readonly</cfif> <cfif getpin2.h2F00 neq 'T'>readonly</cfif> onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif><cfif lcase(hcomid) eq "asiasoft_i">getProfit();</cfif>">
			<cfif hcomid eq "fincom_i">
				<cfinclude template="../fincom/select_special_item_price_to_transaction.cfm">
			</cfif>
			<cfif wpformula eq "1" and trim(getGeneralInfo.priceformula) neq "">
				<input type="button" name="btnprice" value="P" style="cursor:hand" onclick="calculateFormula('priceFormula');">
			</cfif>		</td>
            
        <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
        
       <th><cfif lcase(hcomid) eq "visionlaw_i">Fee<cfelseif lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Cap<cfelse>Price</cfif></th>
        <td> 
			<input name='price' id="pri6" tabindex="5" type='text' <cfif lcase(hcomid) eq "meisei_i" >size='10' maxlength='15' <cfelse>size='10' maxlength='10'</cfif> value='<cfif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and isdefined('form.batchcap')>#numberformat(val(form.batchcap),stDecl_UPrice)#<cfelse>#numberformat(price,stDecl_UPrice)#</cfif>'<cfif (lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super") or (wpformula eq "1" and trim(getGeneralInfo.priceformula) neq "")> readonly</cfif> <cfif getpin2.h2F00 neq 'T'>readonly</cfif> onkeyup="<cfif url.type1 eq "Add" and checkpromotion.recordcount neq 0 and checkpromotion.type eq "buy">buypromo();</cfif><cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse>checkqty();</cfif>">
			<cfif hcomid eq "fincom_i">
				<cfinclude template="../fincom/select_special_item_price_to_transaction.cfm">
			</cfif>
			<cfif wpformula eq "1" and trim(getGeneralInfo.priceformula) neq "">
				<input type="button" name="btnprice" value="P" style="cursor:hand" onclick="calculateFormula('priceFormula');">
			</cfif>		</td>
        <cfelse>
        <td></td>
        <td><input type="hidden" id="pri6" name="price" value='<cfif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and isdefined('form.batchcap')>#numberformat(val(form.batchcap),stDecl_UPrice)#<cfelse>#numberformat(price,stDecl_UPrice)#</cfif>'/></td>
        </cfif>
        <cfif isdefined('foc')>
        <input type="hidden" id="foc" name="foc" value="#foc#" />
        </cfif>
    </tr>
	<!--- ADD ON 090608, SHOW THE PRODUCT'S AMOUNT IN THE BODY PART, SO THE USER CAN KEY IN THE AMOUNT IF THE QTY IS ZERO --->
	<tr>
    <cfquery name="checkpromotion2" datasource="#dts#">
            SELECT * FROM promoitem as a right join promotion as b on a.promoid = b.promoid WHERE a.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and b.periodfrom <="#dateformat(now(),'yyyy-mm-dd')#" and b.periodto >= "#dateformat(now(),'yyyy-mm-dd')#" and (b.customer='#getartran.custno#' or b.customer='') and b.type = "free"
            </cfquery>
        <cfif checkpromotion2.recordcount neq 0>
        <th>Promotion</th>
        <td colspan="3" nowrap><select name="promotiontype">
        <cfloop query="checkpromotion2">
        <option value="#checkpromotion2.promoid#">#ucase(checkpromotion2.type)# - #checkpromotion2.description#</option>
        </cfloop>
        </select>
        </td>
        <cfelse>    
        <td colspan='4' nowrap></td>
        </cfif>
        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
        <th <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Qty<cfelse>Amount</cfif></th>
        <td <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>
        <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
        <input name="amt" id="amt" tabindex="6" type='text' size='10' maxlength='10' value='#numberformat(amt,".__")#'<cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onkeyup="getDiscount2();<cfif getGeneralInfo.editamount eq '1'>document.form1.price.value=0;</cfif>">
        <cfelse>
			<input name="amt" id="amt" tabindex="6" type='text' size='10' maxlength='10' value='#numberformat(amt,".__")#'<cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onkeyup="getDiscount();<cfif getGeneralInfo.editamount eq '1'>document.form1.price.value=0;</cfif>">
            </cfif>
           	</td>
            <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
             <th><cfif lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i">Qty<cfelse>Amount</cfif></th>
        <td>
        <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
        <input name="amt" id="amt" tabindex="6" type='text' size='10' maxlength='10' value='#numberformat(amt,".__")#'<cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onkeyup="getDiscount2();<cfif getGeneralInfo.editamount eq '1'>document.form1.price.value=0;</cfif>">
        <cfelse>
			<input name="amt" id="amt" tabindex="6" type='text' size='10' maxlength='10' value='#numberformat(amt,".__")#'<cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onkeyup="getDiscount();<cfif getGeneralInfo.editamount eq '1'>document.form1.price.value=0;</cfif>">
            </cfif>
           	</td>
            
        <cfelse>
        <td></td>
        <td><input name='amt' id="amt" type="hidden" value='#numberformat(amt,".__")#'/></td>
        </cfif>
        <cfif getGeneralInfo.editamount eq '1'>
        <input type="hidden" name="enableeditamount" id="enableeditamount" value="1" />
        <cfelse>
        <input type="hidden" name="enableeditamount" id="enableeditamount" value="0" />
        </cfif>
    </tr>
    <cfif lcase(hcomid) eq "eocean_i">
    <cfquery name="geteoceanrack" datasource="#dts#">
    select wos_group,colorid from icitem where itemno='#itemno#'
    </cfquery>
    <tr>
    <th>Rack</th><td>#geteoceanrack.wos_group#</td><th>Second Rack</th><td>#geteoceanrack.colorid#</td>
    </tr>
    </cfif>
    <tr>
        <th <cfif getdisplaysetup2.body_location neq "Y">style="visibility:hidden"</cfif>>
		<cfif getmodule.location eq "1">
		<cfif lcase(hcomid) eq "mhca_i">Marketer<cfelseif lcase(hcomid) eq "nikbra_i">Dept Code<cfelse>Location</cfif></cfif></th>
		<input type="hidden" name="oldlocation" value="#xlocation#">
        <td 
		<cfif getmodule.location neq "1" >style="visibility:hidden"<cfelse>
		<cfif getdisplaysetup2.body_location neq "Y">style="visibility:hidden"</cfif></cfif>>
			<cfif multilocation eq "Y" and is_service neq 1>
				<input type="button" value="Multi Location" onclick="multiLocation();">
				<input type="hidden" name="location" id="location" value="">
				<input type="hidden" name="locationlist" id="locationlist" value="#locationlist#">
				<input type="hidden" name="qtylist" id="qtylist" value="#qtylist#">
				<input type="hidden" name="oldqtylist" id="oldqtylist" value="#oldqtylist#">
				<input type="hidden" name="batchlist" id="batchlist" value="#batchlist#">
				<input type="hidden" name="oldbatchlist" id="oldbatchlist" value="#oldbatchlist#">
				<input type="hidden" name="mc1billist" id="mc1billist" value="#mc1billist#">
				<input type="hidden" name="mc2billist" id="mc2billist" value="#mc2billist#">
				<input type="hidden" name="sodatelist" id="sodatelist" value="#sodatelist#">
				<input type="hidden" name="dodatelist" id="dodatelist" value="#dodatelist#">
				<input type="hidden" name="expdatelist" id="expdatelist" value="#expdatelist#">
                <input type="hidden" name="milcertlist" id="milcertlist" value="#milcertlist#">
                <input type="hidden" name="importpermitlist" id="importpermitlist" value="#importpermitlist#">
                <input type="hidden" name="countryoforiginlist" id="countryoforiginlist" value="#countryoforiginlist#">
                <input type="hidden" name="palletlist"  id="palletlist" value="#palletlist#">
				<input type="hidden" name="defectivelist" id="defectivelist" value="#defectivelist#">
			<cfelse>
            <cfif getGeneralInfo.lightloc eq "Y">
            <cfquery datasource="#dts#" name="getlocationlight">

            select 
            location,
             desp 
            from iclocation 
            where 0=0
            and (noactivelocation='' or noactivelocation is null)
            <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and location='#Huserloc#'
            </cfif>
            </cfif>
            group by left(location,4)
            order by location
        	</cfquery>
				<select name='locationfirst' id="locationfirst" onchange="ajaxFunction(document.getElementById('locationajaxfield'),'locationlistajax.cfm?isservice=#isservice#&xlocation=#URLENCODEDFORMAT(xlocation)#&locheader='+escape(document.getElementById('locationfirst').value));">
                <option value="">Choose a Location Header</option>
                <cfloop query="getlocationlight">
                <option value="#left(getlocationlight.location,4)#" <cfif left(xlocation,4) eq left(getlocationlight.location,4)>Selected</cfif>>#left(getlocationlight.location,4)#</option>
                </cfloop>
                </select><br/>
                <div id="locationajaxfield">
                <select name='location' id="loc6" <cfif isservice neq 1>onchange="getbalqty(this.value);"</cfif>>
				<option value="">Choose a Location</option>
                </select>
                </div>
                <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('findlocation');" />
            <cfelse>
            <cfif isdefined('url.noeditloc')>#xlocation#</cfif>
				<select name='location' id="loc6" <cfif isdefined('url.noeditloc')>style="display:none"</cfif> <cfif lcase(hcomid) eq "ltm_i"><cfif isservice neq 1>onchange="getbalqty(this.value);selectOptionByValue(document.getElementById('job'),document.getElementById('loc6').value);"</cfif><cfelse><cfif isservice neq 1>onchange="getbalqty(this.value);"</cfif></cfif>>
                <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
                <option value=''>Choose a Location</option>
    			<cfelse>
				<cfif Huserloc eq "All_loc">
            		<option value=''>Choose a <cfif lcase(hcomid) eq "mhca_i">Marketer<cfelseif lcase(hcomid) eq "nikbra_i">Dept<cfelse>Location</cfif></option>
                    </cfif>
                 </cfif>   
					<cfif lcase(hcomid) neq "ecraft_i" and lcase(hcomid) neq "ovas_i">
                        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
                        <cfif xlocation eq ''>
                        <cfloop query='getlocation'>
                        <option value='#getlocation.location#'<cfif Huserloc eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
                        </cfloop>
                        <cfelse>
                        <cfloop query='getlocation'>
                        <option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
                        </cfloop>
                        </cfif>
    					<cfelse>
                        
                        <cfif isservice neq 1>
							<cfloop query='getlocation'>
								<cfquery name="getlocitembal" datasource="#dts#">
									select LOCQFIELD as locqtybf from locqdbf
									where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
								</cfquery>
								<cfif getlocitembal.recordcount neq 0>
									<cfset itembal = getlocitembal.locqtybf>
								<cfelse>
									<cfset itembal = 0>
								</cfif>
							
								<cfquery name="getin" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type in ('RC','CN','OAI','TRIN') 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getin.sumqty neq "">
									<cfset inqty = getin.sumqty>
								<cfelse>
									<cfset inqty = 0>
								</cfif>

								<cfquery name="getout" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type in ('INV','DN','PR','CS','ISS','OAR','TROU') 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getout.sumqty neq "">
									<cfset outqty = getout.sumqty>
								<cfelse>
									<cfset outqty = 0>
								</cfif>

								<cfquery name="getdo" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type='DO' 
									and (toinv='' or toinv is null) 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getdo.sumqty neq "">
									<cfset DOqty = getdo.sumqty>
								<cfelse>
									<cfset DOqty = 0>
								</cfif>
							
								<cfset locbalonhand = itembal + inqty - outqty - doqty >		
                                <cfif getGeneralInfo.locationwithqty eq 'Y' and (tran eq 'DO' or tran eq 'INV')>
                                <cfif locbalonhand gt 0>
                                <option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp# (#locbalonhand#)</option>
                                <cfelseif xlocation eq getlocation.location>
                                <option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp# (#qty#)</option>
                                </cfif>
                                <cfelse>			
            					<option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp# (#locbalonhand#)</option>
                                </cfif>
            				</cfloop>
						<cfelse>
                        
                        <cfloop query='getlocation'>
            				<option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
                        </cfloop>
                        </cfif>
                        
                        </cfif>
					<cfelse>
						<cfif isservice neq 1>
							<cfloop query='getlocation'>
								<cfquery name="getlocitembal" datasource="#dts#">
									select LOCQFIELD as locqtybf from locqdbf
									where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
								</cfquery>
								<cfif getlocitembal.recordcount neq 0>
									<cfset itembal = getlocitembal.locqtybf>
								<cfelse>
									<cfset itembal = 0>
								</cfif>
							
								<cfquery name="getin" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type in ('RC','CN','OAI','TRIN') 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getin.sumqty neq "">
									<cfset inqty = getin.sumqty>
								<cfelse>
									<cfset inqty = 0>
								</cfif>

								<cfquery name="getout" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type in ('INV','DN','PR','CS','ISS','OAR','TROU') 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getout.sumqty neq "">
									<cfset outqty = getout.sumqty>
								<cfelse>
									<cfset outqty = 0>
								</cfif>

								<cfquery name="getdo" datasource="#dts#">
									select 
									sum(qty)as sumqty 
									from ictran 
									where type='DO' 
									and toinv='' 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and location = '#getlocation.location#'
									and fperiod <> '99' 
									and (void = '' or void is null)
								</cfquery>

								<cfif getdo.sumqty neq "">
									<cfset DOqty = getdo.sumqty>
								<cfelse>
									<cfset DOqty = 0>
								</cfif>
							
								<cfquery name="getpo" datasource="#dts#">
									select 
									ifnull(sum(qty),0) as sumqty 
									from ictran 
									where type='PO' 
									and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
									and fperiod <> '99' 
									and location = '#getlocation.location#'
									and (void = '' or void is null) and toinv=''
								</cfquery>		
							
								<cfset locbalonhand = itembal + inqty - outqty - doqty + getpo.sumqty>					
            					<option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp# (#locbalonhand#)</option>
            				</cfloop>
						<cfelse>
							<cfloop query='getlocation'>
            					<option value='#getlocation.location#'<cfif xlocation eq getlocation.location>Selected</cfif>>#getlocation.location# - #getlocation.desp#</option>
            				</cfloop>
						</cfif>
					</cfif>
          		</select>
                </cfif>
			</cfif>		<br /><a onClick="ColdFusion.Window.show('createlocationAjax');" onMouseOver="this.style.cursor='hand';" >Create New Location</a></td>
        <th nowrap <cfif getdisplaysetup2.body_gl_ac neq "Y">style="visibility:hidden"</cfif>>GL A/C</th>
        <td <cfif getdisplaysetup2.body_gl_ac neq "Y">style="visibility:hidden"</cfif>><input name='gltradac' id="glt6"  type='text' value='#gltradac#' size='10' maxlength='8'><cfif Hlinkams eq "Y"><a onclick="ColdFusion.Window.show('findglacc');"><img src="/images/down.png" /></a></cfif></td>
        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
        
        <th <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>Disc (%)</th>
    	<td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<cfquery name="getDisc" datasource="#dts#">
					select * from discounttable order by discount
				</cfquery>
				<select name='dispec1' id="dis13" tabindex="8" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec1>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
            
                <cfelse>
                <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
                
                <input name='dispec1' id="dis13" tabindex="8" type='text' value='#numberformat(dispec1,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 1(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();<cfif lcase(hcomid) eq "asiasoft_i">getProfit();</cfif>">
                
                <cfelse>
				<input name='dispec1' id="dis13" tabindex="8" type='text' value='#numberformat(dispec1,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 1(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();<cfif lcase(hcomid) eq "asiasoft_i">getProfit();</cfif>">
                </cfif>
			</cfif>		</td>
            <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
            <th <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>Disc (%)</th>
    	<td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<cfquery name="getDisc" datasource="#dts#">
					select * from discounttable order by discount
				</cfquery>
				<select name='dispec1' id="dis13" tabindex="8" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec1>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
            
                <cfelse>
                <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
                
                <input name='dispec1' id="dis13" tabindex="8" type='text' value='#numberformat(dispec1,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 1(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();<cfif lcase(hcomid) eq "asiasoft_i">getProfit();</cfif>">
                
                <cfelse>
				<input name='dispec1' id="dis13" tabindex="8" type='text' value='#numberformat(dispec1,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 1(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();<cfif lcase(hcomid) eq "asiasoft_i">getProfit();</cfif>">
                </cfif>
			</cfif>		</td>
            
            
        <cfelse>
        <td></td>
        <td><input type="hidden" name="dispec1" id="dis13" value='#numberformat(dispec1,stDecl_Discount)#'/></td>
        </cfif>
	</tr>
    
    <tr>
        <th nowrap <cfif getdisplaysetup2.body_serialno neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "asaiki_i"><cfif tran eq 'SAM'>ASA PO<cfelse>#getgeneralinfo.brem1#</cfif><cfelse>#getgeneralinfo.brem1#</cfif></th>
        <td nowrap <cfif getdisplaysetup2.body_serialno neq "Y">style="visibility:hidden"</cfif>>
		<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
			<select name="requestdate" id="req3">
			<option value="">None Zero Rate</option>
			<option value="(z)" <cfif brem1 eq "(z)">selected</cfif>>Zero Rated</option>
			</select>
        <cfelseif lcase(hcomid) eq "aimpest_i">
        <select name="requestdate" id="req3">
			<option value="">Choose a period</option>
			<option value="weekly" <cfif brem1 eq "weekly">selected</cfif>>Weekly</option>
            <option value="fortnightly" <cfif brem1 eq "fortnightly">selected</cfif>>Fortnightly</option>
            <option value="monthly" <cfif brem1 eq "monthly">selected</cfif>>Monthly</option>
            <option value="bi-monthly" <cfif brem1 eq "bi-monthly">selected</cfif>>Bi-Monthly</option>
            <option value="quarterly" <cfif brem1 eq "quarterly">selected</cfif>>Quarterly</option>
			</select>
        <cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">
        <cfquery name="getbsssbitem" datasource="#dts#">
        select itemno from icitem
        </cfquery>
        <select name="requestdate" id="req3">
			<option value="">Choose a Item No</option>
            <cfloop query="getbsssbitem">
			<option value="#getbsssbitem.itemno#" <cfif brem1 eq getbsssbitem.itemno>selected</cfif>>#getbsssbitem.itemno#</option>
            </cfloop>
			</select>
        <cfelseif lcase(hcomid) eq "polypet_i" and tran eq "CS">
        <select name="requestdate" id="req3">
			<option value="">Choose a Method</option>
			<option value="Cash n Carry" <cfif brem1 eq "Cash n Carry">selected</cfif>>Cash n Carry</option>
            <option value="Cash n Delivery" <cfif brem1 eq "Cash n Delivery">selected</cfif>>Cash n Delivery</option>
			</select>
        <cfelseif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and (tran eq "CS" or tran eq "INV" or tran eq "DO")>
        <cfquery name="getsameprojectrc" datasource="#dts#">
        select refno from artran where type='RC' and source='#getartran.source#'
        </cfquery>
        <select name="requestdate" id="req3">
			<option value="">Choose a Receive No</option>
            <cfloop query="getsameprojectrc">
			<option value="#getsameprojectrc.refno#" <cfif brem1 eq getsameprojectrc.refno>selected</cfif>>#getsameprojectrc.refno#</option>
            </cfloop>
			</select>
        <cfelseif lcase(hcomid) eq "atc2005_i">
        <cfquery name="getcolor" datasource="#dts#">
        select * from iccolorid
        </cfquery>
        <select name="requestdate" id="req3">
			<option value="">Choose a Sponge</option>
            <cfloop query="getcolor">
			<option value="#getcolor.colorid#" <cfif brem1 eq getcolor.colorid>selected</cfif>>#getcolor.colorid# - #getcolor.desp#</option>
            </cfloop>
			</select>    
        
        <cfelseif lcase(hcomid) eq "SDC_i" or lcase(hcomid) eq "sdab_i">
        <cfquery name="getsdccurrency" datasource="#dts#">
        select * from currency
        </cfquery>
        <select name="requestdate" id="req3" onchange="ajaxFunction(document.getElementById('sdcajax'),'sdccurrajax.cfm?currcode='+document.getElementById('req3').value);setTimeout('calsdcprice();',1000);setTimeout('checkqty();',2000);">
			<option value="">Choose a Currcode</option>
            <cfloop query="getsdccurrency">
			<option value="#getsdccurrency.currcode#" <cfif brem1 eq ''><cfif getsdccurrency.currcode eq 'EUR'>selected</cfif><cfelse><cfif brem1 eq getsdccurrency.currcode>selected</cfif></cfif>>#getsdccurrency.currcode#</option>
            </cfloop>
			</select>
        <cfelseif lcase(hcomid) eq "chequer_i">
        <cfquery name="getsdccurrency" datasource="#dts#">
        select * from #target_currency#
        </cfquery>
        <select name="requestdate" id="req3">
			<option value="">Choose a Currcode</option>
            <cfloop query="getsdccurrency">
			<option value="#getsdccurrency.currcode#" <cfif brem1 eq ''><cfif getsdccurrency.currcode eq 'EUR'>selected</cfif><cfelse><cfif brem1 eq getsdccurrency.currcode>selected</cfif></cfif>>#getsdccurrency.currcode#</option>
            </cfloop>
			</select>
        <cfelseif lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i">
        <cfif tran eq 'RQ'>
        <input type='text'  name='requestdate' id="req3" maxlength='40' value='#convertquote(brem1)#' size='20'>
        <cfelse>
        <input type='hidden'  name='requestdate' id="req3" maxlength='40' value='#convertquote(brem1)#' size='20'>
        </cfif>
		<cfelse>
			<input type='text'  name='requestdate' id="req3" maxlength='40' value='#convertquote(brem1)#' size='20' <cfif lcase(Hcomid) eq "probulk_i">onKeyUp="calculateAmt(this.value);"</cfif>>
        </cfif>		</td>
        <th nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "asaiki_i"><cfif tran eq 'SAM'>DATE CODE<cfelse>#getgeneralinfo.brem2#</cfif><cfelse>#getgeneralinfo.brem2#</cfif></th>
        <cfif lcase(hcomid) eq "SDC_i" or lcase(hcomid) eq "sdab_i" or lcase(hcomid) eq "chequer_i">
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>>
        <div id="sdcajax"> <input type='text' name='crequestdate' id="creq4"  maxlength='40'  value='<cfif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and isdefined('form.importpermit')>#form.importpermit#<cfelse>#convertquote(brem2)#</cfif>' size='20' onblur="calsdcprice();setTimeout('checkqty();',1000);">        </div><input type="hidden" name="sdcoriprice" id="sdcoriprice" value="#numberformat(price,stDecl_UPrice)#" /></td>
        <cfelseif lcase(hcomid) eq "atc2005_i">
        <cfquery datasource="#dts#" name="getsize">
		select * from icsizeid order by sizeid
		</cfquery>
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>>
        <select name="crequestdate" id="creq4">
		<option value="">Choose a Size</option>
		<cfloop query="getsize">
		<option value="#getsize.sizeid#" <cfif brem2 eq getsize.sizeid>selected</cfif>>#getsize.sizeid# - #getsize.desp#</option>
		</cfloop>
		</select>
        </td>
        
        <cfelseif lcase(hcomid) eq "ltm_i">
        <cfquery datasource="#dts#" name="getgroup">
		select * from icgroup order by wos_group
		</cfquery>
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>>
        <select name="crequestdate" id="creq4">
		<option value="">Choose a Mechanic</option>
		<cfloop query="getgroup">
		<option value="#getgroup.wos_group#" <cfif brem2 eq getgroup.wos_group>selected</cfif>>#getgroup.wos_group# - #getgroup.desp#</option>
		</cfloop>
		</select>
        </td>
        
        <cfelseif lcase(hcomid) eq "amalax_i">
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>>
        <select name="crequestdate" id="creq4">
		<option value="">Choose a Status</option>
		<option value="Kit" <cfif brem2 eq 'Kit'>selected</cfif>>Kit</option>
		<option value="FOC" <cfif brem2 eq 'FOC'>selected</cfif>>FOC</option>
		</select>
        </td>
        <cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>> <input type='text' onkeyup="checkqtybsssb();" name='crequestdate' id="creq4"  maxlength='40' value='#convertquote(brem2)#' size='20'>        </td>
        
        <cfelse>
        <td nowrap <cfif getdisplaysetup2.body_remark2 neq "Y">style="visibility:hidden"</cfif>> <input type='text' <cfif lcase(hcomid) eq "asiasoft_i">onkeyup="getProfit();"</cfif> name='crequestdate' id="creq4"  maxlength='40' value='<cfif (lcase(hcomid) eq "marquis_i" or lcase(HcomID) eq "hempel_i") and isdefined('form.importpermit')>#form.importpermit#<cfelseif lcase(hcomid) eq 'fixics_i'>#getitembal.qty2#<cfelse>#convertquote(brem2)#</cfif>' size='20'>        </td>
        </cfif>
        <td></td>
        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
       
        <td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<select name='dispec2' id="dis23" tabindex="10" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec2>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
			<cfelse>
            <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
            <input name='dispec2' id="dis23" tabindex="10" type='text' value='#numberformat(dispec2,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 2(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();">
            <cfelse>
				<input name='dispec2' id="dis23" tabindex="10" type='text' value='#numberformat(dispec2,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 2(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();">
                </cfif>
			</cfif>		</td>
            <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
            <td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<select name='dispec2' id="dis23" tabindex="10" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec2>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
			<cfelse>
            <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
            <input name='dispec2' id="dis23" tabindex="10" type='text' value='#numberformat(dispec2,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 2(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();">
            <cfelse>
				<input name='dispec2' id="dis23" tabindex="10" type='text' value='#numberformat(dispec2,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 2(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();">
                </cfif>
			</cfif>		</td>
            
        <cfelse>
        <td></td>
        <td><input type="hidden" name="dispec2" id="dis23" value='#numberformat(dispec2,stDecl_Discount)#'/></td>
        </cfif>
	</tr>
    <tr>
        <th <cfif getdisplaysetup2.body_remark3 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "asaiki_i"><cfif tran eq 'SAM'>HP PO<cfelse>#getgeneralinfo.brem3#</cfif><cfelse>#getgeneralinfo.brem3#</cfif></th>
        <td <cfif getdisplaysetup2.body_remark3 neq "Y">style="visibility:hidden"</cfif>>
		<cfif lcase(hcomid) eq "aimpest_i"><textarea name='brem3' id="br36" size='20' rows="3">#convertquote(brem3)#</textarea> 
        
        
		<cfelseif lcase(hcomid) eq "atc2005_i">
        <cfquery datasource="#dts#" name="getrating">
		select * from iccostcode order by costcode
		</cfquery>
        <select name="brem3" id="br36">
        <option value="">Choose a filling</option>
		<cfloop query="getrating">
		<option value="#getrating.costcode#" <cfif brem3 eq getrating.costcode>selected</cfif>>		#getrating.costcode# - #getrating.desp#</option>
		</cfloop>
		</select>
        <cfelse> 
          <input type='text' name='brem3' id="br36" maxlength='40' value='#convertquote(brem3)#' size='20'<cfif lcase(hcomid) eq "accord_i">onblur='JavaScript:changebrem4(this.value);'</cfif> ></cfif></td>
        <th nowrap <cfif getdisplaysetup2.body_remark4 neq "Y">style="visibility:hidden"</cfif>>#getgeneralinfo.brem4#</th>
        <td <cfif getdisplaysetup2.body_remark4 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "aimpest_i"><textarea name='brem4' id="br46" size='20' rows="3">#convertquote(brem4)#</textarea><cfelse><input type='text' name='brem4' id="br46" maxlength='40' value='#convertquote(brem4)#' size='20' <cfif lcase(hcomid) eq "litelab_i" and husergrpid neq 'admin'>readonly</cfif>></cfif></td>
        <td>&nbsp;</td>
         <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
        <td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<select name='dispec3' id="dis36" tabindex="11" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec3>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
			<cfelse>
            <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
            <input name='dispec3' id="dis36" type='text' tabindex="11" value='#numberformat(dispec3,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 3(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();">
            <cfelse>
				<input name='dispec3' id="dis36" type='text' tabindex="11" value='#numberformat(dispec3,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 3(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();">
             </cfif>
			</cfif>		</td> 
            <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
            <td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>
			<cfif (lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i") and husergrpid neq "Admin" and husergrpid neq "Super">
				<select name='dispec3' id="dis36" tabindex="11" onChange="getDiscountControl2();">
					<option value="">-</option>
					<cfloop query="getDisc">
						<option value="#getDisc.discount#" <cfif getDisc.discount eq dispec3>selected</cfif>>#getDisc.discount#</option>
					</cfloop>
				</select>
			<cfelse>
            <cfif getGeneralInfo.itemdiscmethod eq 'byprice'>
            <input name='dispec3' id="dis36" type='text' tabindex="11" value='#numberformat(dispec3,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 3(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl3();">
            <cfelse>
				<input name='dispec3' id="dis36" type='text' tabindex="11" value='#numberformat(dispec3,stDecl_Discount)#' validate='float' size='10' maxlength='7' required='yes' message='Please input a value for Discount 3(%)(0-100).' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif> onKeyUp="getDiscountControl();">
             </cfif>
			</cfif>		</td> 
            
        <cfelse>
        <td></td>
        <td>
        <input type="hidden" name="dispec3" id="dis36" value="#numberformat(dispec3,stDecl_Discount)#" />        </td>
		</cfif>
    </tr>
    <tr>
		<cfif lcase(hcomid) eq "avent_i" >
			<td colspan="2">
				&nbsp;<input type='checkbox' name='nodisplay' id="nodisplay" value='Y'  <cfif nodisplay eq "Y">checked</cfif>>&nbsp;&nbsp;No Display</td>
            <input type="hidden" name="supp" value="#supp#" />
        <cfelseif lcase(hcomid) eq "nikbra_i">
        	<cfquery name="getsupp" datasource="#dts#">
            	select custno,name from #target_apvend#
                order by custno
            </cfquery>
        	<th>Supplier</th>
            <td colspan="3">
            	<select name="supp">
                	<option value="">Please select one</option>
                    <cfloop query="getsupp">
                    	<option value="#custno#" <cfif supp eq getsupp.custno>Selected</cfif>>#custno# - #name#</option>
                    </cfloop>
                </select>            </td>
		<cfelse>
			
        	<th <cfif getdisplaysetup2.body_nodisplay neq "Y">style="visibility:hidden"</cfif>>No Display</th>
            <td <cfif getdisplaysetup2.body_nodisplay neq "Y">style="visibility:hidden"</cfif>><input type='checkbox' name='nodisplay' id="nodisplay" value='Y' <cfif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">onclick="bsssbnodisplay();"</cfif> <cfif nodisplay eq "Y">checked</cfif>></td>
            <cfif tran eq "CN" or (lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i")>
            <th <cfif getdisplaysetup2.body_initial neq "Y">style="visibility:hidden"</cfif>>Initial Cost</th>
            <td <cfif getdisplaysetup2.body_initial neq "Y">style="visibility:hidden"</cfif>><input type="text" name="it_cos" id="it_cos" value="#it_cos#" /></td>
			<cfelseif tran eq "INV" and getGeneralInfo.asvoucher eq "Y">
            <cfquery name='getvoucherprefix' datasource="#dts#">
            select * from voucherprefix
            </cfquery>
            <th <cfif getdisplaysetup2.body_as_voucher neq "Y">style="visibility:hidden"</cfif>>As Voucher</th>
            <td <cfif getdisplaysetup2.body_as_voucher neq "Y">style="visibility:hidden"</cfif>>
            <input type="checkbox" name="asvoucher" id="asvoucher" <cfif asvoucher eq "Y">checked</cfif> />
            <input type="text" name="voucherno" id="voucherno" value="#voucherno#" />
            <select name="voucherprefix" onchange="changevoucherno()">
            <option value="">Choose a Voucher Prefix</option>
            <cfloop query="getvoucherprefix">
            <option value="#getvoucherprefix.voucherprefixno#" >#getvoucherprefix.voucherprefixno#</option>
            </cfloop>
            </select>
            </td>
            <cfelse>
			<td></td><td></td>
            </cfif>
			<!--- <input type='hidden' name='nodisplay' id="nodisplay" value='#nodisplay#'> --->
            <input type="hidden" name="supp" value="#supp#" />
		</cfif>
       
		<input type='hidden' name='shelf' id="shelf" value='#convertquote(shelf)#'>
		<cfif lcase(hcomid) eq "avent_i">
			<th>Packing</th>
        	<td><input type='text' name='packing' id="packing" maxlength='12' value='#convertquote(packing)#' size='20'></td>
		<cfelse>
			<input type='hidden' name='packing' id="packing" value='#convertquote(packing)#'>
			<cfif lcase(hcomid) neq "nikbra_i" and tran neq "CN" and (tran neq "INV" and getGeneralInfo.asvoucher neq "Y")>
				<td>&nbsp;</td>
        		<td>&nbsp;</td>
			</cfif>
		</cfif>
        <cfif lcase(hcomid) eq "asiasoft_i" and tran eq 'INV'><td>&nbsp;</td></cfif>
        <!---<td>&nbsp;</td--->
        <!--- <th>Tax (%)</th>
        <td><input name='taxpec1' id="tax16" type='text' value='#taxpec1#' size='10' maxlength='5' <cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif>></td> --->
        <cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>
        
    	<th <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>Disc(Amount)</th>


		<td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>><input type="text" name="discamt" id="discamt_id" tabindex="11" size="10" onKeyUp="getDiscountControl();" value="#numberformat(discamt,stDecl_Discount)#"></td>
        <cfelseif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>
        <th <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>>Disc(Amount)</th>


		<td <cfif lcase(hcomid) eq "visionlaw_i" or getdisplaysetup2.body_discountbody neq "Y">style="visibility:hidden"</cfif>><input type="text" name="discamt" id="discamt_id" tabindex="11" size="10" onKeyUp="getDiscountControl();" value="#numberformat(discamt,stDecl_Discount)#"></td>
        <cfelse>
        <td></td>
        <td>
        <input type="hidden" name="discamt" id="discamt_id" value="#numberformat(discamt,stDecl_Discount)#" />        </td>
		</cfif>
	</tr>
    <tr>
    <th <cfif getdisplaysetup2.body_nodisplay neq "Y">style="visibility:hidden"</cfif>>Total Up</th>
    <td <cfif getdisplaysetup2.body_nodisplay neq "Y">style="visibility:hidden"</cfif>><input type='checkbox' name='totalupdisplay' id="totalupdisplay" value='Y' <cfif totalupdisplay eq "Y">checked</cfif>></td>
    <th <cfif getdisplaysetup2.body_note1 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "ltm_i">Supplier<cfelse>Why Free?</cfif></th>
    <td <cfif getdisplaysetup2.body_note1 neq "Y">style="visibility:hidden"</cfif>>
    <cfif lcase(hcomid) eq "ltm_i">
    <cfquery name="getsupp" datasource="#dts#">
    select * from #target_apvend#
    </cfquery>
    <select name="note1" id="note1">
    <option value="">Please Select a Supplier</option>
    <cfloop query="getsupp">
    <option value="#getsupp.custno#" <cfif convertquote(note1) eq getsupp.custno>selected</cfif>>#getsupp.custno#</option>
    </cfloop>
    </select>
    <cfelse>
    <input type='text' name='note1' id="note1" maxlength='40' value='#convertquote(note1)#' size='20'></td>
    </cfif>
    </tr>
    <tr <cfif getdisplaysetup2.body_deductable_item neq "Y">style="display:none"</cfif>>
    <th>Deductable Item</th>
    <td><input type='checkbox' name='deductableitem' id="deductableitem" value='Y' <cfif deductableitem eq "Y">checked</cfif>></td>
    <th>DO NO</th>
    <td><input type="text" name="dono" id="dono" value="#dono#" /></td>
    </tr>
	<cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i">
		<tr>
	        <th>REMARK 5</th>
	        <td>
				<input type='text' name='brem5' id="req3" maxlength='40' value="#convertquote(brem5)#" size='20'>			</td>
			<th>REMARK 6</th>
	        <td>
				<input type='text' name='brem6' id="req3" maxlength='40' value="#convertquote(brem6)#" size='20'>			</td>
	    </tr>
        <cfif lcase(hcomid) eq "avent_i" or lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "redhorn_i">
        <tr>
	        <th>REMARK 7</th>
	        <td>
				<input type='text' name='brem7' id="req3" maxlength='40' value="#convertquote(brem7)#" size='20'>			</td>
			<th>REMARK 8</th>
	        <td>
				<input type='text' name='brem8' id="req3" maxlength='40' value="#convertquote(brem8)#" size='20'>			</td>
	    </tr>
           <tr>
	        <th>REMARK 9</th>
	        <td>
				<input type='text' name='brem9' id="req3" maxlength='40' value="#convertquote(brem9)#" size='20'>			</td>
	    </tr>
        </cfif>
	</cfif>
    <cfif getGeneralInfo.displaycostcode eq 'Y'>
    <cfquery name="getcostformula" datasource="#dts#">
    select costformula,ucost from icitem where itemno='#convertquote(itemno)#'
    </cfquery>
    <cfif getpin2.h1360 eq 'T'>
    <th <cfif getdisplaysetup2.body_cost_code neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "excelhw_i">Cost<cfelse>Cost Code</cfif></th>
    <td <cfif getdisplaysetup2.body_cost_code neq "Y">style="visibility:hidden"</cfif>><input type='text' <cfif lcase(hcomid) eq "excelhw_i">style="background-color:##FF9;"</cfif> name='costformula' id="costformula" value="<cfif lcase(hcomid) eq "excelhw_i">#getcostformula.ucost#<cfelse>#getcostformula.costformula#</cfif>" readonly></td>
    </cfif>
    </cfif>
    <cfif getdisplaysetup2.body_pricelist eq "Y">
    <cfquery name="getallprice" datasource="#dts#">
    select price,price2,price3,price4 from icitem where itemno='#convertquote(itemno)#'
    </cfquery>
    <tr><th>Price</th><td><input type='text' <cfif lcase(hcomid) eq "exceljb_i">style="background-color:##FF9;"</cfif> name='displayprice1' id="displayprice1" value="#numberformat(getallprice.price,',_.____')#" readonly></td></tr>
    <tr><th>Price 2</th><td><input type='text' <cfif lcase(hcomid) neq "exceljb_i">style="background-color:##FF9;"</cfif> name='displayprice2' id="displayprice2" value="#numberformat(getallprice.price2,',_.____')#" readonly></td></tr>
	<tr><th>Price 3</th><td><input type='text' name='displayprice3' id="displayprice3" value="#numberformat(getallprice.price3,',_.____')#" readonly></td></tr>
	<tr><th>Price 4</th><td><input type='text' name='displayprice4' id="displayprice4" value="#numberformat(getallprice.price4,',_.____')#" readonly></td></tr>

    </cfif>
    <cfif tran eq 'PO'>
		<tr>
	        <th <cfif getdisplaysetup2.body_requiredate neq "Y">style="visibility:hidden"</cfif>>Require Date</th>
	        <td <cfif getdisplaysetup2.body_requiredate neq "Y">style="visibility:hidden"</cfif>>
				<input type='text' name='requiredate' id="requiredate" maxlength='40' value="#requiredate#" size='10' onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');">	<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(requiredate);">		</td>
			<th <cfif getdisplaysetup2.body_replydate neq "Y">style="visibility:hidden"</cfif>>Reply Date</th>
	        <td <cfif getdisplaysetup2.body_replydate neq "Y">style="visibility:hidden"</cfif>>
				<input type='text' name='replydate' id="replydate" maxlength='40' value="#replydate#" size='10' onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(replydate);">			</td>
	    </tr>
    <cfelse>
    <input type='hidden' name='requiredate' id="requiredate" maxlength='40' value="" size='10' readonly>
    <input type='hidden' name='replydate' id="replydate" maxlength='40' value="" size='10'>
    </cfif>
    <cfif tran eq 'SO'>
        <tr>
	        <th <cfif getdisplaysetup2.body_deliverydate neq "Y">style="visibility:hidden"</cfif>>Delivery Date</th>
	        <td <cfif getdisplaysetup2.body_deliverydate neq "Y">style="visibility:hidden"</cfif>>
				<input type='text' name='deliverydate' id="deliverydate" maxlength='40' value="#deliverydate#" size='10' onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"> <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(deliverydate);"></td>
	    </tr>
     <cfelse>
     <input type='hidden' name='deliverydate' id="deliverydate" maxlength='40' value="" size='10' readonly>
     </cfif>

    <cfif wpitemtax eq "Y">
	    <tr>
		    <td colspan="4"></td>
		    <th <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>Tax included</th>
		    <td <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>><input type="checkbox" name="taxincl" id="taxincl" value="T" onclick="getTax1();" <cfif isdefined('getitem.taxincl')><cfif getitem.taxincl eq "T"> checked="checked"</cfif></cfif>  /></td>    
	    </tr>
    <cfelse>
    	<input type="hidden" name="taxincl" id="taxincl" value="#getartran.taxincl#"  />
    </cfif>
	<!--- ADD ON 10-12-2009 --->
	<tr>
		<th <cfif getdisplaysetup2.body_project neq "Y">style="visibility:hidden"</cfif>><!--- Project / Job --->#getGeneralInfo.lPROJECT#<cfif getmodule.job eq "1">/  #getGeneralInfo.lJOB#</cfif></th>
		<td colspan="3" <cfif getdisplaysetup2.body_project neq "Y">style="visibility:hidden"</cfif>>
			<cfif getGeneralInfo.projectbybill eq "1">
				<input type="text" name="xsource" id="xsource" value="#xsource#" size="20" disabled>
                <cfif getmodule.job neq "1"><div style="visibility:hidden"></cfif>
				<input type="text" name="xjob" id="xjob" value="#xjob#" size="20" disabled><cfif getmodule.job neq "1"></div></cfif>
				<input type="hidden" name="source" id="source" value="#xsource#">
             
				<input type="hidden" name="job" id="job" value="#xjob#">
            <cfelseif getGeneralInfo.jobbyitem eq "Y" >
            <input type="text" name="xsource" id="xsource" value="#xsource#" size="20" disabled>
            <input type="hidden" name="source" id="source" value="#xsource#">
            <cfset glac = "creditsales">
			<cfif URLEncodedFormat(tran) eq "INV">
            <cfset glac = "creditsales">
            <cfelseif URLEncodedFormat(tran) eq "RC">
            <cfset glac = "purchase">
            <cfelseif URLEncodedFormat(tran) eq "PR" or URLEncodedFormat(tran) eq "PO">
            <cfset glac = "purchasereturn">
			<cfelseif URLEncodedFormat(tran) eq "CN">
            <cfset glac = "salesreturn">
            <cfelseif URLEncodedFormat(tran) eq "CS">
            <cfset glac = "cashsales">
			</cfif>
            <cfquery name="getProject2" datasource="#dts#">
				  select * FROM #target_project# where porj = "J" order by source
				</cfquery>
                 <cfif getmodule.job neq "1"><div style="visibility:hidden"></cfif>
            <select name="job" id="job">
					<option value="">Choose a <!--- Job --->#getGeneralInfo.lJOB#</option>
                    
					<cfloop query="getProject2">
						<option value="#getProject2.source#"<cfif xjob eq getProject2.source>Selected</cfif>>#getProject2.source#</option>
					</cfloop>
				</select><cfif getmodule.job neq "1"></div></cfif>
			<cfelse>
            <cfset glac = "creditsales">
			<cfif URLEncodedFormat(tran) eq "INV">
            <cfset glac = "creditsales">
            <cfelseif URLEncodedFormat(tran) eq "RC">
            <cfset glac = "purchase">
            <cfelseif URLEncodedFormat(tran) eq "PR" or URLEncodedFormat(tran) eq "PO">
            <cfset glac = "purchasereturn">
			<cfelseif URLEncodedFormat(tran) eq "CN">
            <cfset glac = "salesreturn">
            <cfelseif URLEncodedFormat(tran) eq "CS">
            <cfset glac = "cashsales">
			</cfif>
            
				<cfquery name="getProject" datasource="#dts#">
				  select source,project, #glac# as glacc FROM #target_project# where porj = "P" order by source
				</cfquery>
				
				<cfquery name="getProject2" datasource="#dts#">
				  select * FROM #target_project# where porj = "J" order by source
				</cfquery>
                
				<select name="source" id="source" onchange="document.getElementById('glt6').value = this.options[this.selectedIndex].id">
					<option value="" id="">Choose a <!--- Project --->#getGeneralInfo.lPROJECT#</option>
					<cfloop query="getProject">
						<option value="#getProject.source#" id="#getProject.glacc#"<cfif xsource eq getProject.source>Selected</cfif>>#getProject.source# - #getProject.project#</option>
					</cfloop>
				</select>
                <cfif getmodule.job neq "1"><div style="visibility:hidden"></cfif>
				<select name="job" id="job">
					<option value="">Choose a <!--- Job --->#getGeneralInfo.lJOB#</option>
                    
                   
                    
					<cfloop query="getProject2">
						<option value="#getProject2.source#"<cfif xjob eq getProject2.source>Selected</cfif>>#getProject2.source#</option>
					</cfloop>
				</select>
                <cfif getmodule.job neq "1"></div></cfif>
				<cfif getGeneralInfo.remainloc eq "Y" and gltradac eq "">
                <script type="text/javascript">
				var sourcefield = document.getElementById('source');
				document.getElementById('glt6').value = sourcefield.options[sourcefield.selectedIndex].id
                </script>
				</cfif>
                <br /><a onClick="ColdFusion.Window.show('createProjectAjax');" onMouseOver="this.style.cursor='hand';" >Create New Project</a>&nbsp;&nbsp;&nbsp;&nbsp;
 <cfif getmodule.job eq "1">
                <a onClick="ColdFusion.Window.show('createJobAjax');" onMouseOver="this.style.cursor='hand';" >Create New Job</a></cfif>	</td>
			</cfif>	
        <cfif wpitemtax eq "Y">
            <th <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>Tax (%)</th>
            <td <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>
            	<!--- <select name="selecttax" onChange="getTaxControl();">
                    <option value="" <cfif xnote_a eq "">selected</cfif>>X-GST</option>
                    <option value="EX"<cfif xnote_a eq "EX">selected</cfif>>Exempted</option>
                    <option value="OS"<cfif xnote_a eq "OS">selected</cfif>>Out of Scope</option>
                    <option value="STAX"<cfif xnote_a eq "STAX">selected</cfif>>STAX</option>
                    <option value="PTAX"<cfif xnote_a eq "PTAX">selected</cfif>>PTAX</option>
                    <option value="ZR"<cfif xnote_a eq "ZR">selected</cfif>>ZR</option>
                    <cfif tran eq "RC" or tran eq "PR">
                    	<option value="MES"<cfif xnote_a eq "MES">selected</cfif>>MES</option>
                    </cfif>
					<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR'>
		                <option value="TX7"<cfif xnote_a eq "TX7">selected</cfif>>TX7</option>
		                <option value="IM"<cfif xnote_a eq "IM">selected</cfif>>IM</option>
		                <option value="ME"<cfif xnote_a eq "ME">selected</cfif>>ME</option>
		                <option value="BL"<cfif xnote_a eq "BL">selected</cfif>>BL</option>
		                <option value="NR"<cfif xnote_a eq "NR">selected</cfif>>NR</option>
		                <option value="ZP"<cfif xnote_a eq "ZP">selected</cfif>>ZP</option>
		                <option value="EP"<cfif xnote_a eq "EP">selected</cfif>>EP</option>
		                <option value="OP"<cfif xnote_a eq "OP">selected</cfif>>OP</option>
		                <option value="E33"<cfif xnote_a eq "E33">selected</cfif>>E33</option>
		                <option value="EN33"<cfif xnote_a eq "EN33">selected</cfif>>EN33</option>
		                <option value="RE"<cfif xnote_a eq "RE">selected</cfif>>RE</option>
		             <cfelse>
		                <option value="SR"<cfif xnote_a eq "SR">selected</cfif>>SR</option>
		                <option value="ES33"<cfif xnote_a eq "ES33">selected</cfif>>ES33</option>
		                <option value="ESN33"<cfif xnote_a eq "ESN33">selected</cfif>>ESN33</option>
		                <option value="DS"<cfif xnote_a eq "DS">selected</cfif>>DS</option>
		                <option value="OS"<cfif xnote_a eq "OS">selected</cfif>>OS</option>
		             </cfif>
		            <option value="PM"<cfif xnote_a eq "PM">selected</cfif>>PM</option>
                    <option value="NTAX"<cfif xnote_a eq "NTAX">selected</cfif>>NTAX</option>
                </select> --->
				<cfquery name="select_tax" datasource="#dts#">
					SELECT * FROM #target_taxtable#
					<cfif lcase(hcomid) eq "iaf_i">
                        WHERE tax_type in ('T',
                        <cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
                            'PT'
                        <cfelse>
                            'ST'
                        </cfif>
                        )
                    <cfelse>                            
					<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' or tran eq 'RQ'>
                    WHERE tax_type <> "ST"
                    <cfelseif tran eq 'DN' or tran eq 'CN' >
                    <cfelse>
                    WHERE tax_type <> "PT"
                    </cfif>
                    </cfif>
				</cfquery>
				<select name="selecttax" tabindex="13" onChange="JavaScript:document.getElementById('taxpec1').value=this.options[this.selectedIndex].id;getTax1();">
			    	<cfloop query="select_tax">
			        	<cfset idrate = select_tax.rate1 * 100>
			            <option value="#select_tax.code#" id="#idrate#" <cfif xnote_a eq select_tax.code>selected</cfif>>#select_tax.code#</option>
			        </cfloop>
		       </select>            </td>
		<cfelse>
        	<cfif lcase(hcomid) eq 'asiasoft_i'><!--- 20/6/2012 --->
				<th>Profit</th>
                <td>
                <div id="profitfield">
               <input type="text" name="profit" id="profit" readonly="readonly" size="10"/>
                </div>
                </td>
			</cfif>     
        
        
        	<td <cfif lcase(hcomid) eq 'asiasoft_i'>style="visibility:hidden"</cfif>>
            	<input name="selecttax" id="selecttax" type="hidden" value="#xnote_a#">            </td>
		</cfif>
	</tr>
	<tr>
        <th <cfif getdisplaysetup2.body_title neq "Y">style="visibility:hidden"</cfif>>Title</th>
        <td colspan="3" <cfif getdisplaysetup2.body_title neq "Y">style="visibility:hidden"</cfif>>
			<select name="title_id" onChange="changeTitleDesp()">
				<option value="">Select a Title</option>
				<cfloop query="gettitle">
					<option value="#gettitle.title_id#" <cfif title eq gettitle.title_id>selected</cfif>>#title_id#</option>
				</cfloop>
			</select>		</td>  
        <cfif wpitemtax eq "Y">
            <th <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>&nbsp;</th>
            <td <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>
            	<input name="taxpec1" id="tax16" tabindex="14"  type="text" value="#taxpec1#" size="10" maxlength="10" onkeyup="getTax();" onBlur="settaxcode();" <cfif lcase(hcomid) eq "dnet_i">readonly</cfif><cfif lcase(hcomid) eq "gel_i" and husergrpid neq "Admin" and husergrpid neq "Super">readonly</cfif>>
                <!--- <input name="taxamt_bil" id="taxamt_bil" type="text" value="#numberformat(taxamt_bil,stDecl_Discount)#" size="10" maxlength="5" style="background-color:##FFFF99" readonly> --->
                <input name="taxamt_bil" id="taxamt_bil" tabindex="24" type="text" value="#numberformat(taxamt_bil,stDecl_Discount)#" size="10" maxlength="10">            </td>
		<cfelse>
        	<cfif lcase(hcomid) eq 'asiasoft_i'><!--- 20/6/2012 --->
				<th>Margin</th>
                <td>
                <div id="marginfield">
                <input type="text" name="margin" id="margin" readonly="readonly" size="10"/></td>
                </div>
			</cfif>
        		
        
        	<td <cfif lcase(hcomid) eq 'asiasoft_i'>style="visibility:hidden"<!--- 18/6/2012 ---></cfif>>
            	<input name="taxpec1" id="tax16" type="hidden" value="#taxpec1#">
                <input name="taxamt_bil" id="taxamt_bil" type="hidden" value="#numberformat(taxamt_bil,stDecl_Discount)#">            </td>
		</cfif>
    </tr>
	<tr>
        <th <cfif getdisplaysetup2.body_titledesp neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "thats_i">Min Charge</cfif>&nbsp;</th>
        <td colspan="3" <cfif getdisplaysetup2.body_titledesp neq "Y">style="visibility:hidden"</cfif>>
			<cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(hcomid) eq "kingston_i" or lcase(hcomid) eq "cstct_i" or lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "ascend_i" or lcase(hcomid) eq "vsyspteltd_i" or lcase(hcomid) eq "apnt_i">

				<cfif tran eq "DO">
			        <textarea name='title_desp' id="title_desp" cols='80' rows='5' <cfif lcase(hcomid) eq "kingston_i" >wrap="soft"<cfelse> wrap="hard"</cfif>>#convertquote(titledesp)#</textarea>
				<cfelse>
					<textarea name='title_desp' id="title_desp" cols='80' rows='5' <cfif lcase(hcomid) eq "kingston_i" >wrap="soft"<cfelse> wrap="hard"</cfif>>#convertquote(titledesp)#</textarea>
				</cfif>	
			<cfelse>
				<input type="text" name="title_desp" id="title_desp" value="#convertquote(titledesp)#" size="60" <cfif lcase(hcomid) eq "taftc_i">maxlength="200"<cfelse>maxlength="100"</cfif>>
			</cfif>		</td>
		<cfif wpitemtax eq "Y">
			<th <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>Total</th>
			<td <cfif lcase(hcomid) eq "visionlaw_i">style="visibility:hidden"</cfif>>
	       		<cfset totalvalue = 0>
	       		<cfif isdefined('getitem.taxincl')>
					<cfif getitem.taxincl eq "T">
	        			<cfset totalvalue = amt - #numberformat(taxamt_bil,stDecl_Discount)# >
	        		<cfelse>
	        			<cfset totalvalue = amt - #numberformat(discamt,stDecl_Discount)# + #numberformat(taxamt_bil,stDecl_Discount)# >
					</cfif>
	        	</cfif>
			  	<input type="text" name="itemtotalamt" id="itemtotalamt" size="10" value="#numberformat(totalvalue,'.__')#" readonly="readonly" />			</td>
		<cfelse>
        	<td></td>
	        <td> 
			  <input type="hidden" name="itemtotalamt" id="itemtotalamt" size="10" value="" readonly="readonly" />	        </td>
		</cfif>
    </tr>
	<cfif lcase(hcomid) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i">
		<!--- <tr>
	        <th>&nbsp;</th>
	        <td colspan="3">
		        <cfif tran eq "DO">
			        <textarea name='title_despa' cols='55' rows='5' wrap="hard">#convertquote(titledespa)#</textarea>
				<cfelse>
					<textarea name='title_despa' cols='60' rows='5' wrap="hard">#convertquote(titledespa)#</textarea>
				</cfif>			
			</td>      
	        <td></td>
	    </tr> --->
	    <input name="title_despa" id="title_despa" type="hidden" value="#convertquote(titledespa)#">
	</cfif>
    <!--- <cfif wpitemtax eq "Y">
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <th>Total</th>
        <td>
        <cfset totalvalue = 0>
        <cfif isdefined('getitem.taxincl')>
		<cfif getitem.taxincl eq "T">
        <cfset totalvalue = amt - #numberformat(taxamt_bil,stDecl_Discount)# >
        <cfelse>
        <cfset totalvalue = amt + #numberformat(taxamt_bil,stDecl_Discount)# >
		</cfif>
        </cfif>
         
		  <input type="text" name="itemtotalamt" id="itemtotalamt" size="10" value="#numberformat(totalvalue,'.__')#" readonly="readonly" />
        </td>
    </tr>
    <cfelse>
        <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td></td>
        <td> 
		  <input type="hidden" name="itemtotalamt" id="itemtotalamt" size="10" value="" readonly="readonly" />
        </td>
    </tr>
	</cfif> --->
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><input type="button" name="cancel" id="cancel" value="Cancel" onclick="javascript:history.go(-1)" /></td>
        <td nowrap align="right"> <!--- <input type='button' name='back' value='back' onClick='javascript:history.back()'> --->
		  <cfif mode eq 'Edit'><input type='submit' tabindex="16" name='Submit' value='  Save  '><cfelse> <input type='submit' tabindex="16" name='Submit' value='  #mode#  '> </cfif>       </td>
    </tr>
    <cfif hcomid eq "hodaka_i" and (tran eq "PO" or tran eq "RC")>
    <tr>
    <th>SO No.</th>
    <td>
    <input type="text" name="soitem" id="soitem" value="#soitem#" readonly /><input type="button" name="soitembtn" id="soitembtn" value="select Sales Order" onClick="ColdFusion.Window.show('searchsoitem');"/>
    </td>
    </tr>
    
    </cfif>
    
    <cfif tran eq "CN">
<tr>
<th>Link To Invoice</th>
<cfquery name="invlist" datasource="#dts#">
SELECT refno FROM ictran WHERE (void = "" or void is null)
and fperiod <> "99" and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#"> and type = "INV" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> group by refno order by refno 
</cfquery>
<td>
<select name="invlinklist" id="invlinklist" onchange="ajaxFunction(document.getElementById('invitemlist'),'invitemlist.cfm?custno=#URLENCODEDFORMAT(getartran.custno)#&itemno=#URLENCODEDFORMAT(itemno)#&refno='+escape(this.value))">
<option value="">Choose an Invoice</option>
<cfloop query="invlist">
<option value="#invlist.refno#" <cfif isdefined('invlinklist')><cfif invlinklist eq invlist.refno>SElECTED</cfif></cfif>>#invlist.refno#</option>
</cfloop>
</select>
</td>
<th>
<div id="invitemlist">
<select name="invcnitem" id="invcnitem">
<option value="">Choose an Item</option>
<cfif isdefined('invlinklist')>
<cfquery name="getinvitem" datasource="#dts#">
SELECT trancode,desp,price_bil FROM ictran WHERE (void = "" or void is null)
and fperiod <> "99" and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.custno#"> and type = "INV" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invlinklist#"> order by trancode
</cfquery>
<cfloop query="getinvitem">
<option value="#getinvitem.trancode#" <cfif isdefined('invcnitem')><cfif getinvitem.trancode eq invcnitem>Selected</cfif></cfif> >#getinvitem.trancode# - #getinvitem.desp# @ #numberformat(getinvitem.price_bil,',.__')#</option>
</cfloop>
</cfif>
</select> 
</div>
</th>
</tr>
</cfif>
<cfif hcomid eq "demo_i" or hcomid eq "draco_i">
<tr>
<td colspan="100%">
<cfoutput>
<script type="text/javascript">
function rollcost()
{
	var squoprice = parseFloat(document.getElementById('squoprice').value);
var pers = parseFloat(document.getElementById('pers').value);
	var rollsize1 = parseFloat(document.getElementById('rollsize1').value);
	var rollsizescale1 = parseFloat(document.getElementById('rollsizescale1').value);
	var rollsize2 = parseFloat(document.getElementById('rollsize2').value);
	var rollsizescale2 = parseFloat(document.getElementById('rollsizescale2').value);
	var perrollcost = (squoprice * pers)* (rollsize1*rollsizescale1)* (rollsize2*rollsizescale2);
	document.getElementById('perrollcost').value = perrollcost.toFixed(2);
}

function supprice()
{
	var squoprice = parseFloat(document.getElementById('squoprice').value);
var pers = parseFloat(document.getElementById('pers').value);
	var rollsize1 = parseFloat(document.getElementById('rollsize1').value);
	var rollsizescale1 = parseFloat(document.getElementById('rollsizescale1').value);
	var rollsize2 = parseFloat(document.getElementById('rollsize2').value);
	var rollsizescale2 = parseFloat(document.getElementById('rollsizescale2').value);
	var perrollcost = parseFloat(document.getElementById('perrollcost').value);
	
	var squoprice = perrollcost /((pers)* (rollsize1*rollsizescale1)* (rollsize2*rollsizescale2));
	document.getElementById('squoprice').value = squoprice.toFixed(2);
}
</script>
<table width="100%">
<tr>
<th><div align="left">Cost Computational</div></th>
<!--- <th><div align="left">Profit and Margin</div></th> --->
</tr>
<tr>
<td>
<table>
<tr>
<th>Supplier Quote Price</th>
<td>$<input type="text" name="squoprice" id="squoprice" value="1" onkeyup="rollcost();"  />
Per Square <select name="pers" id="pers" onchange="rollcost()">
<option value="1">Meter</option>
<option value="10.76391111">Feet</option>
</select>
</td>
</tr>
<tr>
<th>Roll Size</th>
<td>
<input type="text" name="rollsize1" id="rollsize1" value="100"  onkeyup="rollcost();"   />
<select name="rollsizescale1" id="rollsizescale1" onchange="rollcost()">
<option value="0.001">MM</option>
<option value="0.01">CM</option>
<option value="1">M</option>
<option value="0.0254">Inch</option>
<option value="0.3048">Feet</option>
</select> X 
<input type="text" name="rollsize2" id="rollsize2" value="100"  onkeyup="rollcost();"    />
<select name="rollsizescale2" id="rollsizescale2" onchange="rollcost()">
<option value="0.001">MM</option>
<option value="0.01">CM</option>
<option value="1">M</option>
<option value="0.0254">Inch</option>
<option value="0.3048">Feet</option>
</select>
</td>
</tr>
<tr>
<th>Per Roll Cost</th>
<td>
$<input type="text" name="perrollcost" id="perrollcost" value="0.01" onkeyup="supprice();" />
</td>
</th>
</tr>
</table>
</td>
</tr>
</table>
</cfoutput>
<td>
</tr>
</cfif>
	<cfif url.type1 eq 'Add' and isservice neq 1>
    	<cfif getrecommendprice.recordcount gt 0>
        	<tr>
            	<th colspan="6">Recommended Price (#refno3#)</th>
          	</tr>
          	<tr>
            	<td colspan="2"><strong>Recommended Price</strong> - #numberformat(getrecommendprice.price,",.____")#<br><strong>Note</strong>: #getrecommendprice.ci_note#</td>
            	<td colspan="2"><strong>Disc 1</strong> - #decimalformat(getrecommendprice.dispec)#%<br> <strong>Disc 2</strong> - #decimalformat(getrecommendprice.dispec2)#%<br> <strong>Disc 3</strong> - #decimalformat(getrecommendprice.dispec3)#%</td>
            	<td colspan="2"><strong>Net Price</strong> - #numberformat(getrecommendprice.netprice,",.____")#</td>
          	</tr>
        </cfif>
	</cfif>
<cfif lcase(hcomid) neq "mastercare_i" and lcase(hcomid) neq "gorgeous_i" and lcase(hcomid) neq "visionlaw_i">
	<cfif getitembal.recordcount neq 0>
    	<tr>
          	<th colspan='6'>Last 5 Price / Discount History</th>
        </tr>
        <tr>
          	<td><strong>Date</strong></td>
            <td><strong>Ref No</strong></td>
          	<td><strong>Price</strong></td>
          	<td><strong>Qty</strong></td>
          	<td><strong>Discount %</strong></td>
          	<td>&nbsp;</td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td>#date1#</td>
            <td>#refnohis1#</td>
          	<td><cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>#NumberFormat(pricehis1,stDecl_UPrice)#</cfif><cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>#NumberFormat(pricehis1,stDecl_UPrice)#</cfif></td>
			<td>#qtyhis1#</td>
          	<td colspan="2">#disc1#</td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td>#date2#</td>
            <td>#refnohis2#</td>
          	<td><cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>#NumberFormat(pricehis2,stDecl_UPrice)#</cfif><cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>#NumberFormat(pricehis2,stDecl_UPrice)#</cfif></td>
			<td>#qtyhis2#</td>
          	<td colspan="2">#disc2#</td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td>#date3#</td>
            <td>#refnohis3#</td>
          	<td><cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>#NumberFormat(pricehis3,stDecl_UPrice)#</cfif><cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>#NumberFormat(pricehis3,stDecl_UPrice)#</cfif></td>
			<td>#qtyhis3#</td>
          	<td colspan="2">#disc3#</td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td>#date4#</td>
            <td>#refnohis4#</td>
          	<td><cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>#NumberFormat(pricehis4,stDecl_UPrice)#</cfif><cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>#NumberFormat(pricehis4,stDecl_UPrice)#</cfif></td>
			<td>#qtyhis4#</td>
          	<td colspan="2">#disc4#</td>
          	<td>&nbsp;</td>
        </tr>
        <tr>
          	<td>#date5#</td>
            <td>#refnohis5#</td>
          	<td><cfif getpin2.h1360 eq 'T' and (tran eq 'PO' or tran eq 'RC' or tran eq 'PR' or tran eq 'RQ')>#NumberFormat(pricehis5,stDecl_UPrice)#</cfif><cfif getpin2.h1361 eq 'T' and (tran eq 'INV' or tran eq 'DO' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN' or tran eq 'QUO' or tran eq 'SO' or tran eq 'SAM')>#NumberFormat(pricehis5,stDecl_UPrice)#</cfif></td>
			<td>#qtyhis5#</td>
          	<td colspan="2">#disc5#</td>
          	<td>&nbsp;</td>
        </tr>
	</cfif>
</cfif>

</table>
</form>


<cfwindow center="true" width="700" height="400" name="findglacc" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc.cfm" /> 

<script type="text/javascript">
<cfif lcase(hcomid) eq "topsteelhol_i" or lcase(hcomid) eq "topsteel_i">checkqtytopsteel();<cfelseif lcase(hcomid) eq "bsssb_i" or lcase(hcomid) eq "puss_i" or lcase(hcomid) eq "rvsb_i" or lcase(hcomid) eq "hnm_i">checkqtybsssb();<cfelse><cfif getGeneralInfo.editamount eq '1' or getGeneralInfo.itemdiscmethod eq 'byprice'><cfelse>checkqty();</cfif></cfif>
document.getElementById('dep5').focus();

getbalqty(document.getElementById('loc6').value);

</script>
<cfif lcase(hcomid) eq "hairo_i">
<script type="text/javascript">
document.getElementById('qt6').focus();
</script>
</cfif>
<cfif getGeneralInfo.lightloc eq "Y">
<script type="text/javascript">
ajaxFunction(document.getElementById('locationajaxfield'),'locationlistajax.cfm?isservice=#isservice#&xlocation=#URLENCODEDFORMAT(xlocation)#&locheader='+escape(document.getElementById('locationfirst').value));
</script>
<cfwindow center="true" width="550" height="400" name="findlocation" refreshOnShow="true"
        title="Find Location" initshow="false"
        source="findlocation.cfm?type=Location&locationfirst={locationfirst}" />
</cfif>

<cfwindow center="true" width="550" height="400" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/transaction/searchitem/searchitem2.cfm" />      
<cfif getGeneralInfo.negstk neq "1">
<cfwindow center="true" width="300" height="300" name="negativestock" refreshOnShow="true" closable="true" modal="true" title="Negative Stock" initshow="false"
        source="negativestock.cfm" />
</cfif>
<cfwindow center="true" width="300" height="300" name="minimumprice" refreshOnShow="true" closable="true" modal="true" title="Minimum Pirce" initshow="false"
        source="minimumprice.cfm" />

<cfwindow center="true" width="300" height="300" name="minimumprice2" refreshOnShow="true" closable="true" modal="true" title="Selling Below Cost" initshow="false"
        source="minimumprice2.cfm" />
<cfif lcase(hcomid) eq 'hodaka_i'>
<cfwindow center="true" width="600" height="400" name="searchsoitem" refreshOnShow="true" closable="true" modal="false" title="Select Sales Order" initshow="false"
        source="/default/transaction/soitemlist.cfm?itemno={itemno}" />
</cfif>
<cfif lcase(hcomid) eq 'asiasoft_i'>
<script type="text/javascript">
function getProfit()
{
	var ic = document.form1.creq4.value*1;
	var pr = document.form1.pri6.value*1;
	var dispec1 = document.form1.dispec1.value*1;
	
	<cfif tran eq 'PO' or tran eq 'RC' or tran eq 'PR'>
	var total = ic-(pr*((100-dispec1)/100));
	var margin = (total/pr)*100
	<cfelse>
	var total = (pr*((100-dispec1)/100))-ic;
	var margin = (total/ic)*100
	</cfif>
	
	
	document.form1.profit.value = total.toFixed(2);
	if(ic != '')
	{
	document.form1.margin.value = margin.toFixed(2)+'%';	
	}
	
	if(ic == '')
	{
	document.form1.margin.value = '100%';	
	}
}
</script>
</cfif>

</cfoutput>