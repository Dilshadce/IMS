<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">
<cfquery datasource="#dts#" name="getdisplaysetup2">
	SELECT * FROM displaysetup2
</cfquery>
<cfquery name="getremarkInfo" datasource="#dts#">
	SELECT * FROM gsetup;
</cfquery>
<cfquery name="getmodule" datasource="#dts#">
	SELECT * FROM modulecontrol;
</cfquery>
<html>
<head>
<title>Product Page</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script type="text/javascript" src="/scripts/prototype.js"></script>
<script type="text/javascript" src="/scripts/effects.js"></script>
<script type="text/javascript" src="/scripts/controls.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/scripts/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="/scripts/highslide/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="/scripts/highslide/highslide.css" />
<script type="text/javascript">
//<![CDATA[
hs.registerOverlay({
	html: '<div class="closebutton" onclick="return hs.close(this)" title="Close"></div>',
	position: 'top right',
	fade: 2 // fading the semi-transparent overlay looks bad in IE
});


hs.graphicsDir = '/scripts/highslide/graphics/';
hs.wrapperClassName = 'borderless';
//]]>
</script>
<script type="text/javascript">
		function showpic(picname)
		{
		return hs.expand(picname)
		}
		function insertSymbol1(sym)
			{
			var textexist = document.getElementById('desp').value;
			var symboladd = document.getElementById(sym).value;
			document.getElementById('desp').value = textexist + symboladd;
			}
			function insertSymbol2(sym)
			{
			var textexist = document.getElementById('despa').value;
			var symboladd = document.getElementById(sym).value;
			document.getElementById('despa').value = textexist + symboladd;
			}
			
	function texteditor(mcetype)
	{
			
		if (mcetype == "MCE1")
		{
		var elem = "desp";
		}
		else
		{
		var elem = "despa";
		}
		document.getElementById(mcetype).style.visibility = "hidden";
		tinyMCE.init({
    mode : "exact",
	elements : elem,
    theme : "advanced",
    theme_advanced_buttons1 : "fontselect,fontsizeselect,formatselect,bold,italic,underline,strikethrough,separator,sub,sup,separator,cut,copy,paste,undo,redo",
    theme_advanced_buttons2 : "justifyleft,justifycenter,justifyright,justifyfull,separator,numlist,bullist,outdent,indent,separator,forecolor,backcolor,separator,hr,link,unlink,table,code,separator,charmap",
    theme_advanced_buttons3 : "",
    theme_advanced_fonts : "Arial=arial,helvetica,sans-serif,Courier New=courier new,courier,monospace,Georgia=georgia,times new roman,times,serif,Tahoma=tahoma,arial,helvetica,sans-serif,Times=times new roman,times,serif,Verdana=verdana,arial,helvetica,sans-serif",
    theme_advanced_toolbar_location : "top",
    theme_advanced_toolbar_align : "left",
    theme_advanced_statusbar_location : "bottom",
    plugins : 'safari,asciimath,asciisvg,table,inlinepopups',
   
        
    content_css : "/stylesheet/content.css",
	forced_root_block : false,
   force_br_newlines : true,
   force_p_newlines : false

});
			
		}

	</script>
<script language="javascript" type="text/javascript" src="../../scripts/collapse_expand_single_item.js"></script>
<script language='JavaScript'>
function imposeMaxLength(Object, MaxLen)
{
  return (Object.value.length <= MaxLen);
}

	function validate(e)
	{
		if(document.CustomerForm.itemno.value=='')
		{
			alert("Your Item's No. cannot be blank.");
			document.CustomerForm.itemno.focus();
			return false;
			
		}
		
		<cfif getdisplaysetup2.compulsory_item_desp eq 'Y'>
		if(document.CustomerForm.desp.value=='')
		{
			alert("Your Description cannot be blank.");
			document.CustomerForm.desp.focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_comment eq 'Y'>
		if(document.CustomerForm.comment.value=='')
		{
			alert("Your Comment cannot be blank.");
			document.CustomerForm.comment.focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_productcode eq 'Y'>
		if(document.CustomerForm.AITEMNO.value=='')
		{
			alert("Your Product Code No. cannot be blank.");
			document.CustomerForm.AITEMNO.focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_barcode eq 'Y'>
		if(document.CustomerForm.barcode.value=='')
		{
			alert("Your Bar Code. cannot be blank.");
			document.CustomerForm.barcode.focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_brand eq 'Y'>
		if(document.getElementById('Brand').selectedIndex ==0)
		{
			alert("Your Brand cannot be blank.");
			document.getElementById('Brand').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_supplier eq 'Y'>
		if(document.getElementById('Supp').selectedIndex ==0)
		{
			alert("Your Supplier cannot be blank.");
			document.getElementById('Supp').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_cate eq 'Y'>
		if(document.getElementById('CATEGORY').selectedIndex ==0)
		{
			alert("Your Category cannot be blank.");
			document.getElementById('CATEGORY').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_size eq 'Y'>
		<cfif left(dts,4) eq "tcds">
		if(document.getElementById('sizeid').value == '')
		<cfelse>
		if(document.getElementById('sizeid').selectedIndex ==0)</cfif>
		{
			alert("Your Size cannot be blank.");
			document.getElementById('sizeid').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_shelfno eq 'Y'>
		if(document.getElementById('shelf').selectedIndex ==0)
		{
			alert("Your Shelf cannot be blank.");
			document.getElementById('shelf').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_material eq 'Y'>
		if(document.getElementById('COLORID').selectedIndex ==0)
		{
			alert("Your Color cannot be blank.");
			document.getElementById('COLORID').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_group eq 'Y'>
		if(document.getElementById('wos_group').selectedIndex ==0)
		{
			alert("Your Group cannot be blank.");
			document.getElementById('wos_group').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_rating eq 'Y'>
		if(document.getElementById('COSTCODE').selectedIndex ==0)
		{
			alert("Your rating cannot be blank.");
			document.getElementById('COSTCODE').focus();
			return false;
			
		}
		
		</cfif>
		
		<cfif getdisplaysetup2.compulsory_item_uom eq 'Y'>
		if(document.getElementById('unit').selectedIndex ==0)
		{
			alert("Your unit cannot be blank.");
			document.getElementById('unit').focus();
			return false;
			
		}
		
		</cfif>
		
		
		if(document.CustomerForm.com_id.value == 'polypet_i')
		{
		var key;      
     	if(window.event)
          key = window.event.keyCode; //IE
     	else
          key = e.which; //firefox      

    	 return (key != 13);
		}
		
		
		if(document.CustomerForm.com_id.value == 'mhsl_i' || document.CustomerForm.com_id.value == 'mpt_i' || document.CustomerForm.com_id.value == 'mhca_i'){
			if(document.CustomerForm.desp.value == ''){
				alert("Your Item's Description cannot be blank.");
				document.CustomerForm.desp.focus();
				return false;
			}
			else if(document.CustomerForm.CATEGORY.value == ''){
				alert("Your Item's Category cannot be blank.");
				document.CustomerForm.CATEGORY.focus();
				return false;
			}
			else if(document.CustomerForm.WOS_GROUP.value == ''){
				alert("Your Item's Group cannot be blank.");
				document.CustomerForm.WOS_GROUP.focus();
				return false;
			}
			else if(document.CustomerForm.UNIT.value == ''){
				alert("Your Item's Unit of Measurement cannot be blank.");
				document.CustomerForm.UNIT.focus();
				return false;
			}
		}else{
			
			if(document.CustomerForm.WOS_GROUP.value == '')
			{
				a=document.CustomerForm.graded1.checked;
				if(a==true)
				{			
					alert("A Graded Item Must Assign A Group !");
					document.CustomerForm.WOS_GROUP.focus();
					return false;
				}
			}
		}
		if(document.CustomerForm.com_id.value == 'glenn_i'){
			if(document.CustomerForm.UNIT.value == ''){
				alert("Your Item's Unit of Measurement cannot be blank.");
				document.CustomerForm.UNIT.focus();
				return false;
			}else if(document.CustomerForm.PRICE.value == ''){
				alert("Your Item's Unit Selling Price cannot be blank.");
				document.CustomerForm.PRICE.focus();
				return false;
			}
			else if(document.CustomerForm.SALEC.value == ''){
				alert("Your Item's Credit Sales cannot be blank.");
				document.CustomerForm.SALEC.focus();
				return false;
			}
		}
		
		return true;
	}
	function change_picture(picture)
	{
		var encode_picture = encodeURI(picture);
		show_picture.location="icitem_image.cfm?pic3="+encode_picture;
	}

	
	function downloaddoc()
	{
		if(document.getElementById('document_available').value =='')
		{
		alert('Document Field Cannot Be Blank')
		}
		else
		{
			<cfoutput>
			window.open('/document/#hcomid#/'+document.getElementById('document_available').value)
			</cfoutput>
		}
		
	}
	
	function delete_picture(picture)
	{
	var answer =confirm("Are you sure wan to delete picture "+picture);
	if (answer)
	{
		var encode_picture = encodeURI(picture);
		show_picture.location="icitem_image.cfm?delete=true&picture="+encode_picture;
		var elSel = document.getElementById('picture_available');
		  var i;
		  for (i = elSel.length - 1; i>=0; i--) {
			if (elSel.options[i].selected) {
			  elSel.remove(i);
			}
		  }
	}
	
	}
	
	function delete_document(document1)
	{
	var answer =confirm("Are you sure wan to delete document "+document1);
	if (answer)
	{
		var encode_document = encodeURI(document1);
		
		
		ajaxFunction(document.getElementById('getdocumentajax'),"icitem_document.cfm?delete=true&document="+encode_document);
		var elSel = document.getElementById('document_available');
		  var i;
		  for (i = elSel.length - 1; i>=0; i--) {
			if (elSel.options[i].selected) {
			  elSel.remove(i);
			}
		  }
	}
	
	}
	
	
	function uploading_picture(pic_name)
	{
		var new_pic_name1 = new String(pic_name);
		var new_pic_name2 = new_pic_name1.split(/[-,/,\\]/g);
		document.getElementById("picture_name").value=new_pic_name2[new_pic_name2.length-1];
	}
	function uploading_document(doc_name)
	{
		var new_doc_name1 = new String(doc_name);
		var new_doc_name2 = new_doc_name1.split(/[-,/,\\]/g);
		document.getElementById("document_name").value=new_doc_name2[new_doc_name2.length-1];
	}
	function add_option(pic_name)
	{
		var agree = confirm("Are You Sure ?");
		if (agree==true)
		{
			var detection=0;
			var totaloption=document.getElementById("picture_available").length-1;

			for(var i=0;i<=totaloption;++i)
			{
				if(document.getElementById("picture_available").options[i].value==pic_name)
				{
					detection=1;
					break;
				}
			}
			
			if(detection!=1)
			{
				var a=new Option(pic_name,pic_name);
				document.getElementById("picture_available").options[document.getElementById("picture_available").length]=a;
			}
			document.getElementById("picture_available").value=pic_name;
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function add_option2(doc_name)
	{
		var agree = confirm("Are You Sure ?");
		if (agree==true)
		{
			var detection=0;
			var totaloption=document.getElementById("document_available").length-1;

			for(var i=0;i<=totaloption;++i)
			{
				if(document.getElementById("document_available").options[i].value==doc_name)
				{
					detection=1;
					break;
				}
			}
			
			if(detection!=1)
			{
				var a=new Option(doc_name,doc_name);
				document.getElementById("document_available").options[document.getElementById("document_available").length]=a;
			}
			document.getElementById("document_available").value=doc_name;
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function calculate_price3(fixnum){
		if(isNaN(document.CustomerForm.MURATIO.value)){
			alert("The value is not a number. Please try again");
		}
		else{
			if(document.CustomerForm.UCOST.value == ''){
				var costprice = 0;
			}
			else{
				var costprice = document.CustomerForm.UCOST.value;
			}
			var price3 = document.CustomerForm.MURATIO.value * document.CustomerForm.UCOST.value;
			price3 = price3.toFixed(fixnum);
			document.CustomerForm.PRICE3.value = price3;
		}
	}
	
	function getSupp(type,option){
		var inputtext = document.CustomerForm.searchsupp.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);	
	}
	
	function getSuppResult(suppArray){
		DWRUtil.removeAllOptions("supp");
		DWRUtil.addOptions("supp", suppArray,"KEY", "VALUE");
	}
	
	function updateBrand(brand){
			myoption = document.createElement("OPTION");
			myoption.text = brand;
			myoption.value = brand;
			document.getElementById("Brand").options.add(myoption);
			var indexvalue = document.getElementById("Brand").length-1;
			document.getElementById("Brand").selectedIndex=indexvalue;
			}
	function updateCate(cate){
			myoption = document.createElement("OPTION");
			myoption.text = cate;
			myoption.value = cate;
			document.getElementById("CATEGORY").options.add(myoption);
			var indexvalue = document.getElementById("CATEGORY").length-1;
			document.getElementById("CATEGORY").selectedIndex=indexvalue;
			}
	function updateSize(size){
		<cfif left(dts,4) neq "tcds">
			myoption = document.createElement("OPTION");
			myoption.text = size;
			myoption.value = size;
			document.getElementById("SIZEID").options.add(myoption);
			var indexvalue = document.getElementById("SIZEID").length-1;
			document.getElementById("SIZEID").selectedIndex=indexvalue;
			<cfelse>
			document.getElementById("SIZEID").value = size;
			</cfif>
			}
	function updateCostcode(COSTCODE){
			myoption = document.createElement("OPTION");
			myoption.text = COSTCODE;
			myoption.value = COSTCODE;
			document.getElementById("COSTCODE").options.add(myoption);
			var indexvalue = document.getElementById("COSTCODE").length-1;
			document.getElementById("COSTCODE").selectedIndex=indexvalue;
			}
	function updateColorid(COLORID){
			myoption = document.createElement("OPTION");
			myoption.text = COLORID;
			myoption.value = COLORID;
			document.getElementById("COLORID").options.add(myoption);
			var indexvalue = document.getElementById("COLORID").length-1;
			document.getElementById("COLORID").selectedIndex=indexvalue;
			}
	function updateGroup(group){
			myoption = document.createElement("OPTION");
			myoption.text = group;
			myoption.value = group;
			document.getElementById("wos_group").options.add(myoption);
			var indexvalue = document.getElementById("wos_group").length-1;
			document.getElementById("wos_group").selectedIndex=indexvalue;
			}
	function updateShelf(shelf){
			myoption = document.createElement("OPTION");
			myoption.text = shelf;
			myoption.value = shelf;
			document.getElementById("shelf").options.add(myoption);
			var indexvalue = document.getElementById("shelf").length-1;
			document.getElementById("shelf").selectedIndex=indexvalue;
			}
	function updateUnit(unitno){
			myoption = document.createElement("OPTION");
			myoption.text = unitno;
			myoption.value = unitno;
			document.getElementById("UNIT").options.add(myoption);
			var indexvalue = document.getElementById("UNIT").length-1;
			document.getElementById("UNIT").selectedIndex=indexvalue;
			}
	
	function generatenumber(){
		var intRegex = /^\d+$/;
		var result1 = 0;
		var result2 = 0;
		
		if(intRegex.test(document.getElementById("itemno").value)) {
		   if(document.getElementById("itemno").value.length==7 || document.getElementById("itemno").value.length==11 || document.getElementById("itemno").value.length==12 || document.getElementById("itemno").value.length==13 || document.getElementById("itemno").value.length==17)
			{
				if(document.getElementById("itemno").value.length==7)
				{
					var itemno1='0000000000'+document.getElementById("itemno").value;
				}
				else if(document.getElementById("itemno").value.length==11)
				{
					var itemno1='000000'+document.getElementById("itemno").value;
				}
				else if(document.getElementById("itemno").value.length==12)
				{
					var itemno1='00000'+document.getElementById("itemno").value;
				}
				else if(document.getElementById("itemno").value.length==13)
				{
					var itemno1='0000'+document.getElementById("itemno").value;
				}
				else
				{
				}
				
				
				for (i=17; i >= 1; i -= 2)
				{
					var result1=(result1*1)+(itemno1.substr(i-1,1)*1);
				}
				var result1=result1*3;

				for (i=2; i <= 17; i += 2)
				{
					var result2=(result2*1)+(itemno1.substr(i-1,1)*1);
				}

				var result1=result1+result2;

				result1=result1%10;

				if(result1!=0){
				result1=10-result1;
				}
				
				document.getElementById("itemno").value=document.getElementById("itemno").value+result1
				
			}
			else
			{
				alert('Barcode must be either 7, 11, 12, 13 or 17 numbers')
			}
		}
		else
		{
			alert('Barcode must be only numbers')
		}	
		}
		
		function itemtbafunc()
		{
			if(document.getElementById("itemtba").checked == true)
			{
				document.getElementById("releasedate").value = '31/12/9999'
				document.getElementById("releasedatefield").style.visibility = 'hidden'
			}
			else
			{
				document.getElementById("releasedate").value = ''
				document.getElementById("releasedatefield").style.visibility = 'visible'
			}
		}
	
</script>
</head>
<cfquery name='getgsetup' datasource='#dts#'>
  SELECT * FROM gsetup
</cfquery>

<!--- Control The Decimal Point --->
<cfquery name='getgsetup2' datasource='#dts#'>
  SELECT * FROM gsetup2
</cfquery>
<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = '.'>
<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = stDecl_UPrice & '_'>
</cfloop>

<!--- Add On 09-03-2010 --->
<cfquery name="getbrand" datasource="#dts#">
	select brand,desp from brand order by brand
</cfquery>

<body>
<cfoutput>
  <cfif url.type eq 'Edit'>
    <cfquery datasource='#dts#' name='getitem'>
			Select * from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
	  	</cfquery>
    <cfset edi_id=getitem.edi_id>
    <cfset ItemNo=getitem.itemno>
    <cfset desp=getitem.desp>
    <cfset despa=getitem.despa>
    <cfset comment=getitem.comment>
    <cfset AITEMNO=getitem.AITEMNO>
    <cfset barcode=getitem.barcode>
    <cfset xbrand=getitem.BRAND>
    <cfset releasedate=dateformat(getitem.releasedate,'dd/mm/yyyy')>
    <cfset xCATEGORY=getitem.CATEGORY>
    <cfset xSUPP=getitem.SUPP>
    <cfset MINIMUM=getitem.MINIMUM>
    <cfset xSIZEID=getitem.SIZEID>
    <cfset PACKING=getitem.PACKING>
    <cfset MAXIMUM=getitem.MAXIMUM>
    <cfset xCOSTCODE=getitem.COSTCODE>
    <cfset REORDER=getitem.REORDER>
    <cfset xCOLORID=getitem.COLORID>
    <cfset xshelf=getitem.shelf>
    <cfset taxcode = getitem.taxcode>
    <cfset xWOS_GROUP=getitem.WOS_GROUP>
    <CFSET xUNIT=getitem.UNIT>
    <CFSET WQFORMULA=getitem.WQFORMULA>
    <CFSET WPFORMULA=getitem.WPFORMULA>
    <CFSET QTYBF=getitem.QTYBF>
    <CFSET UCOST=getitem.UCOST>
    <CFSET PRICE=getitem.PRICE>
    <CFSET PRICE2=getitem.PRICE2>
    <CFSET PRICE3=getitem.PRICE3>
    <CFSET PRICE4=getitem.PRICE4>
    <CFSET PRICE5=getitem.PRICE5>
    <CFSET PRICE6=getitem.PRICE6>
    <CFSET PRICE_MIN=getitem.PRICE_MIN>
    <cfset graded=getitem.graded>
    <CFSET MURATIO=getitem.MURATIO>
    <CFSET QTY2=getitem.QTY2>
    <CFSET QTY3=getitem.QTY3>
    <CFSET QTY4=getitem.QTY4>
    <CFSET QTY5=getitem.QTY5>
    <CFSET QTY6=getitem.QTY6>
    <CFSET SALEC=getitem.SALEC>
    <CFSET SALECSC=getitem.SALECSC>
    <CFSET SALECNC=getitem.SALECNC>
    <CFSET PURC=getitem.PURC>
    <CFSET PURPREC=getitem.PURPREC>
    <CFSET STOCK=getitem.STOCK>
    <CFSET WSERIALNO=getitem.WSERIALNO>
    <cfset nonstkitem = getitem.nonstkitem>
    <CFSET REMARK1=getitem.REMARK1>
    <CFSET REMARK2=getitem.REMARK2>
    <CFSET REMARK3=getitem.REMARK3>
    <CFSET REMARK4=getitem.REMARK4>
    <CFSET REMARK5=getitem.REMARK5>
    <CFSET REMARK6=getitem.REMARK6>
    <CFSET REMARK7=getitem.REMARK7>
    <CFSET REMARK8=getitem.REMARK8>
    <CFSET REMARK9=getitem.REMARK9>
    <CFSET REMARK10=getitem.REMARK10>
    <CFSET REMARK11=getitem.REMARK11>
    <CFSET REMARK12=getitem.REMARK12>
    <CFSET REMARK13=getitem.REMARK13>
    <CFSET REMARK14=getitem.REMARK14>
    <CFSET REMARK15=getitem.REMARK15>
    <CFSET REMARK16=getitem.REMARK16>
    <CFSET REMARK17=getitem.REMARK17>
    <CFSET REMARK18=getitem.REMARK18>
    <CFSET REMARK19=getitem.REMARK19>
    <CFSET REMARK20=getitem.REMARK20>
    <CFSET REMARK21=getitem.REMARK21>
    <CFSET REMARK22=getitem.REMARK22>
    <CFSET REMARK23=getitem.REMARK23>
    <CFSET REMARK24=getitem.REMARK24>
    <CFSET REMARK25=getitem.REMARK25>
    <CFSET REMARK26=getitem.REMARK26>
    <CFSET REMARK27=getitem.REMARK27>
    <CFSET REMARK28=getitem.REMARK28>
    <CFSET REMARK29=getitem.REMARK29>
    <CFSET REMARK30=getitem.REMARK30>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset UNIT2 = getitem.UNIT2>
    <cfset FACTOR1 = getitem.FACTOR1>
    <cfset FACTOR2 = getitem.FACTOR2>
    <cfset PRICEU2 = getitem.PRICEU2>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset photo = getitem.photo>
    <cfset document = getitem.document>
    <cfset mode='Edit'>
    <cfset title='Edit Item'>
    <cfset button='Save'>
    <cfset fucost = getitem.fucost>
    <cfset fprice = getitem.fprice>
    <cfset fcurrcode = getitem.fcurrcode>
    <cfset fucost2 = getitem.fucost2>
    <cfset fprice2 = getitem.fprice2>
    <cfset fcurrcode2 = getitem.fcurrcode2>
    <cfset fucost3 = getitem.fucost3>
    <cfset fprice3 = getitem.fprice3>
    <cfset fcurrcode3 = getitem.fcurrcode3>
    <cfset fucost4 = getitem.fucost4>
    <cfset fprice4 = getitem.fprice4>
    <cfset fcurrcode4 = getitem.fcurrcode4>
    <cfset fucost5 = getitem.fucost5>
    <cfset fprice5 = getitem.fprice5>
    <cfset fcurrcode5 = getitem.fcurrcode5>
    <cfset fucost6 = getitem.fucost6>
    <cfset fprice6 = getitem.fprice6>
    <cfset fcurrcode6 = getitem.fcurrcode6>
    <cfset fucost7 = getitem.fucost7>
    <cfset fprice7 = getitem.fprice7>
    <cfset fcurrcode7 = getitem.fcurrcode7>
    <cfset fucost8 = getitem.fucost8>
    <cfset fprice8 = getitem.fprice8>
    <cfset fcurrcode8 = getitem.fcurrcode8>
    <cfset fucost9 = getitem.fucost9>
    <cfset fprice9 = getitem.fprice9>
    <cfset fcurrcode9 = getitem.fcurrcode9>
    <cfset fucost10 = getitem.fucost10>
    <cfset fprice10 = getitem.fprice10>
    <cfset fcurrcode10 = getitem.fcurrcode10>
    <cfset packingdesp1 = getitem.packingdesp1>
    <cfset packingqty1 = getitem.packingqty1>
    <cfset packingfreeqty1 = getitem.packingfreeqty1>
    <cfset packingdesp2 = getitem.packingdesp2>
    <cfset packingqty2 = getitem.packingqty2>
    <cfset packingfreeqty2 = getitem.packingfreeqty2>
    <cfset packingdesp3 = getitem.packingdesp3>
    <cfset packingqty3 = getitem.packingqty3>
    <cfset packingfreeqty3 = getitem.packingfreeqty3>
    <cfset packingdesp4 = getitem.packingdesp4>
    <cfset packingqty4 = getitem.packingqty4>
    <cfset packingfreeqty4 = getitem.packingfreeqty4>
    <cfset packingdesp5 = getitem.packingdesp5>
    <cfset packingqty5 = getitem.packingqty5>
    <cfset packingfreeqty5 = getitem.packingfreeqty5>
    <cfset packingdesp6 = getitem.packingdesp6>
    <cfset packingqty6 = getitem.packingqty6>
    <cfset packingfreeqty6 = getitem.packingfreeqty6>
    <cfset packingdesp7 = getitem.packingdesp7>
    <cfset packingqty7 = getitem.packingqty7>
    <cfset packingfreeqty7 = getitem.packingfreeqty7>
    <cfset packingdesp8 = getitem.packingdesp8>
    <cfset packingqty8 = getitem.packingqty8>
    <cfset packingfreeqty8 = getitem.packingfreeqty8>
    <cfset packingdesp9 = getitem.packingdesp9>
    <cfset packingqty9 = getitem.packingqty9>
    <cfset packingfreeqty9 = getitem.packingfreeqty9>
    <cfset packingdesp10 = getitem.packingdesp10>
    <cfset packingqty10 = getitem.packingqty10>
    <cfset packingfreeqty10 = getitem.packingfreeqty10>
    <cfset custprice_rate = getitem.custprice_rate>
    <cfset comm = getitem.commlvl>
    <cfset costformula = getitem.costformula>
    <cfset created_on = getitem.created_on>
    <cfset itemtype = getitem.itemtype>
  </cfif>
  <cfif url.type eq 'Delete'>
    <cfquery datasource='#dts#' name='getitem'>
			Select * from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
	  	</cfquery>
    <cfset edi_id=getitem.edi_id>
    <cfset ItemNo=getitem.itemno>
    <cfset desp=getitem.desp>
    <cfset despa=getitem.despa>
    <cfset comment=getitem.comment>
    <cfset AITEMNO=getitem.AITEMNO>
    <cfset barcode=getitem.barcode>
    <cfset xbrand=getitem.BRAND>
    <cfset xCATEGORY=getitem.CATEGORY>
    <cfset xSUPP=getitem.SUPP>
    <cfset MINIMUM=getitem.MINIMUM>
    <cfset xSIZEID=getitem.SIZEID>
    <cfset PACKING=getitem.PACKING>
    <cfset MAXIMUM=getitem.MAXIMUM>
    <cfset xCOSTCODE=getitem.COSTCODE>
    <cfset REORDER=getitem.REORDER>
    <cfset xCOLORID=getitem.COLORID>
    <cfset xshelf=getitem.shelf>
    <cfset taxcode = getitem.taxcode>
    <cfset xWOS_GROUP=getitem.WOS_GROUP>
    <CFSET xUNIT=getitem.UNIT>
    <CFSET WQFORMULA=getitem.WQFORMULA>
    <CFSET WPFORMULA=getitem.WPFORMULA>
    <CFSET QTYBF=getitem.QTYBF>
    <CFSET UCOST=getitem.UCOST>
    <CFSET PRICE=getitem.PRICE>
    <CFSET PRICE2=getitem.PRICE2>
    <CFSET PRICE3=getitem.PRICE3>
    <CFSET PRICE4=getitem.PRICE4>
    <CFSET PRICE5=getitem.PRICE5>
    <CFSET PRICE6=getitem.PRICE6>
    <CFSET PRICE_MIN=getitem.PRICE_MIN>
    <cfset graded=getitem.graded>
    <CFSET MURATIO=getitem.MURATIO>
    <CFSET QTY2=getitem.QTY2>
    <CFSET QTY3=getitem.QTY3>
    <CFSET QTY4=getitem.QTY4>
    <CFSET QTY5=getitem.QTY5>
    <CFSET QTY6=getitem.QTY6>
    <CFSET SALEC=getitem.SALEC>
    <CFSET SALECSC=getitem.SALECSC>
    <CFSET SALECNC=getitem.SALECNC>
    <CFSET PURC=getitem.PURC>
    <CFSET PURPREC=getitem.PURPREC>
    <CFSET STOCK=getitem.STOCK>
    <CFSET WSERIALNO=getitem.WSERIALNO>
    <cfset nonstkitem = getitem.nonstkitem>
    <CFSET REMARK1=getitem.REMARK1>
    <CFSET REMARK2=getitem.REMARK2>
    <CFSET REMARK3=getitem.REMARK3>
    <CFSET REMARK4=getitem.REMARK4>
    <CFSET REMARK5=getitem.REMARK5>
    <CFSET REMARK6=getitem.REMARK6>
    <CFSET REMARK7=getitem.REMARK7>
    <CFSET REMARK8=getitem.REMARK8>
    <CFSET REMARK9=getitem.REMARK9>
    <CFSET REMARK10=getitem.REMARK10>
    <CFSET REMARK11=getitem.REMARK11>
    <CFSET REMARK12=getitem.REMARK12>
    <CFSET REMARK13=getitem.REMARK13>
    <CFSET REMARK14=getitem.REMARK14>
    <CFSET REMARK15=getitem.REMARK15>
    <CFSET REMARK16=getitem.REMARK16>
    <CFSET REMARK17=getitem.REMARK17>
    <CFSET REMARK18=getitem.REMARK18>
    <CFSET REMARK19=getitem.REMARK19>
    <CFSET REMARK20=getitem.REMARK20>
    <CFSET REMARK21=getitem.REMARK21>
    <CFSET REMARK22=getitem.REMARK22>
    <CFSET REMARK23=getitem.REMARK23>
    <CFSET REMARK24=getitem.REMARK24>
    <CFSET REMARK25=getitem.REMARK25>
    <CFSET REMARK26=getitem.REMARK26>
    <CFSET REMARK27=getitem.REMARK27>
    <CFSET REMARK28=getitem.REMARK28>
    <CFSET REMARK29=getitem.REMARK29>
    <CFSET REMARK30=getitem.REMARK30>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset UNIT2 = getitem.UNIT2>
    <cfset FACTOR1 = getitem.FACTOR1>
    <cfset FACTOR2 = getitem.FACTOR2>
    <cfset PRICEU2 = getitem.PRICEU2>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset photo = getitem.photo>
    <cfset document = getitem.document>
    <cfset mode='Delete'>
    <cfset title='Delete Item'>
    <cfset button='Delete'>
    <cfset fucost = getitem.fucost>
    <cfset fprice = getitem.fprice>
    <cfset custprice_rate = getitem.custprice_rate>
    <cfset fcurrcode = getitem.fcurrcode>
    <cfset fucost2 = getitem.fucost2>
    <cfset fprice2 = getitem.fprice2>
    <cfset fcurrcode2 = getitem.fcurrcode2>
    <cfset fucost3 = getitem.fucost3>
    <cfset fprice3 = getitem.fprice3>
    <cfset fcurrcode3 = getitem.fcurrcode3>
    <cfset fucost4 = getitem.fucost4>
    <cfset fprice4 = getitem.fprice4>
    <cfset fcurrcode4 = getitem.fcurrcode4>
    <cfset fucost5 = getitem.fucost5>
    <cfset fprice5 = getitem.fprice5>
    <cfset fcurrcode5 = getitem.fcurrcode5>
    <cfset fucost6 = getitem.fucost6>
    <cfset fprice6 = getitem.fprice6>
    <cfset fcurrcode6 = getitem.fcurrcode6>
    <cfset fucost7 = getitem.fucost7>
    <cfset fprice7 = getitem.fprice7>
    <cfset fcurrcode7 = getitem.fcurrcode7>
    <cfset fucost8 = getitem.fucost8>
    <cfset fprice8 = getitem.fprice8>
    <cfset fcurrcode8 = getitem.fcurrcode8>
    <cfset fucost9 = getitem.fucost9>
    <cfset fprice9 = getitem.fprice9>
    <cfset fcurrcode9 = getitem.fcurrcode9>
    <cfset fucost10 = getitem.fucost10>
    <cfset fprice10 = getitem.fprice10>
    <cfset fcurrcode10 = getitem.fcurrcode10>
    <cfset packingdesp1 = getitem.packingdesp1>
    <cfset packingqty1 = getitem.packingqty1>
    <cfset packingfreeqty1 = getitem.packingfreeqty1>
    <cfset packingdesp2 = getitem.packingdesp2>
    <cfset packingqty2 = getitem.packingqty2>
    <cfset packingfreeqty2 = getitem.packingfreeqty2>
    <cfset packingdesp3 = getitem.packingdesp3>
    <cfset packingqty3 = getitem.packingqty3>
    <cfset packingfreeqty3 = getitem.packingfreeqty3>
    <cfset packingdesp4 = getitem.packingdesp4>
    <cfset packingqty4 = getitem.packingqty4>
    <cfset packingfreeqty4 = getitem.packingfreeqty4>
    <cfset packingdesp5 = getitem.packingdesp5>
    <cfset packingqty5 = getitem.packingqty5>
    <cfset packingfreeqty5 = getitem.packingfreeqty5>
    <cfset packingdesp6 = getitem.packingdesp6>
    <cfset packingqty6 = getitem.packingqty6>
    <cfset packingfreeqty6 = getitem.packingfreeqty6>
    <cfset packingdesp7 = getitem.packingdesp7>
    <cfset packingqty7 = getitem.packingqty7>
    <cfset packingfreeqty7 = getitem.packingfreeqty7>
    <cfset packingdesp8 = getitem.packingdesp8>
    <cfset packingqty8 = getitem.packingqty8>
    <cfset packingfreeqty8 = getitem.packingfreeqty8>
    <cfset packingdesp9 = getitem.packingdesp9>
    <cfset packingqty9 = getitem.packingqty9>
    <cfset packingfreeqty9 = getitem.packingfreeqty9>
    <cfset packingdesp10 = getitem.packingdesp10>
    <cfset packingqty10 = getitem.packingqty10>
    <cfset packingfreeqty10 = getitem.packingfreeqty10>
    <cfset comm = getitem.commlvl>
    <cfset costformula = getitem.costformula>
    <cfset created_on = getitem.created_on>
    <cfset itemtype = getitem.itemtype>
    <cfset releasedate=dateformat(getitem.releasedate,'dd/mm/yyyy')>
  </cfif>
  <cfif url.type eq 'Create'>
    <cfif lcase(HcomID) eq "snnpl_i">
      <cfquery datasource='#dts#' name='getitem'>
			Select substring(itemno,9,4) as itemrun from icitem
            where itemno not in ('8886450610035' ,'8886450610080' ,'8886450610134' ,'8886450610233' ,'8886450610332' ,'8886450610431' ,'8886450610530' ,'8886450610639' ,'8886450610691' ,'8886450610790' ,'8886450620034' ,'8886450630002' ,'8886450630019' ,'8886450630026' ,'8886450630040' ,'8886450630064' ,'8886450630071' ,'8886450630088' ,'8886450630095' ,'8886450630101' ,'8886450630118' ,'8886450630125' ,'8886450630149' ,'8886450630163' ,'8886450630194' ,'8886450630200' ,'8886450630224' ,'8886450630248' ,'8886450630255' ,'8886450630934' ,'8886450631139' ,'8886450631238' ,'8886450631436' ,'8886450631474' ,'8886450631573' ,'8886450631979' ,'8886450632235' ,'8886450632273' ,'8886450632730' ,'8886450640032' ,'8886450640131' ,'8886450640230' ,'8886450640339' ,'8886450650048' ,'8886450650116' ,'8886450650147' ,'8886450650246' ,'8886450650345' ,'8886450651045' ,'8886450651144' ,'8886450651243' ,'8886450651342' ,'8886450652042' ,'8886450660009' ,'8886450660023' ,'8886450660030' ,'8886450660047' ,'8886450660054' ,'8886450660061' ,'8886450660078' ,'8886450660085' ,'8886450660108' ,'8886450660207' ,'8886450660214' ,'8886450660221' ,'8886450660238' ,'8886450660269' ,'8886450660290' ,'8886450660344' ,'8886450660351' ,'8886450660368' ,'8886450660375' ,'888645066043' ,'88864506888')
            and itemno like '88864506%'
            order by substring(itemno,9,4) desc
	  	</cfquery>
    </cfif>
    <cfset edi_id=''>
    <cfif lcase(HcomID) eq "snnpl_i">
      <cfif getitem.recordcount eq 0>
        <cfset ItemNo='888645060000'>
        <cfelse>
        <cfset getitem.itemrun=getitem.itemrun+1>
        <cfif getitem.itemrun eq '1003' or getitem.itemrun eq '1008' or getitem.itemrun eq '1013' or getitem.itemrun eq '1023' or getitem.itemrun eq '1033' or getitem.itemrun eq '1043' or getitem.itemrun eq '1053' or getitem.itemrun eq '1063' or getitem.itemrun eq '1069' or getitem.itemrun eq '1079' or getitem.itemrun eq '2003' or getitem.itemrun eq '3000' or getitem.itemrun eq '3001' or getitem.itemrun eq '3002' or getitem.itemrun eq '3004' or getitem.itemrun eq '3006' or getitem.itemrun eq '3007' or getitem.itemrun eq '3008' or getitem.itemrun eq '3009' or getitem.itemrun eq '3010' or getitem.itemrun eq '3011' or getitem.itemrun eq '3012' or getitem.itemrun eq '3014' or getitem.itemrun eq '3016' or getitem.itemrun eq '3019' or getitem.itemrun eq '3020' or getitem.itemrun eq '3022' or getitem.itemrun eq '3024' or getitem.itemrun eq '3025' or getitem.itemrun eq '3093' or getitem.itemrun eq '3113' or getitem.itemrun eq '3123' or getitem.itemrun eq '3143' or getitem.itemrun eq '3147' or getitem.itemrun eq '3157' or getitem.itemrun eq '3197' or getitem.itemrun eq '3223' or getitem.itemrun eq '3227' or getitem.itemrun eq '3273' or getitem.itemrun eq '4003' or getitem.itemrun eq '4013' or getitem.itemrun eq '4023' or getitem.itemrun eq '4033' or getitem.itemrun eq '5004' or getitem.itemrun eq '5011' or getitem.itemrun eq '5014' or getitem.itemrun eq '5024' or getitem.itemrun eq '5034' or getitem.itemrun eq '5104' or getitem.itemrun eq '5114' or getitem.itemrun eq '5124' or getitem.itemrun eq '5134' or getitem.itemrun eq '5204' or getitem.itemrun eq '6000' or getitem.itemrun eq '6000' or getitem.itemrun eq '6002' or getitem.itemrun eq '6003' or getitem.itemrun eq '6004' or getitem.itemrun eq '6005' or getitem.itemrun eq '6006' or getitem.itemrun eq '6007' or getitem.itemrun eq '6008' or getitem.itemrun eq '6010' or getitem.itemrun eq '6020' or getitem.itemrun eq '6021' or getitem.itemrun eq '6022' or getitem.itemrun eq '6023' or getitem.itemrun eq '6026' or getitem.itemrun eq '6029' or getitem.itemrun eq '6034' or getitem.itemrun eq '6035' or getitem.itemrun eq '6036' or getitem.itemrun eq '6037' or getitem.itemrun eq '6043' or getitem.itemrun eq '888' >
          <cfset getitem.itemrun=getitem.itemrun+1>
        </cfif>
        <cfset ItemNo='88864506'&getitem.itemrun>
      </cfif>
      <cfelse>
      <cfset ItemNo=''>
    </cfif>
    <cfset desp=''>
    <cfset despa=''>
    <cfset comment=''>
    <cfset AITEMNO=''>
    <cfset barcode=''>
    <cfset xbrand=''>
    <cfset xCATEGORY=''>
    <cfset xSUPP=''>
    <cfset MINIMUM=''>
    <cfset xSIZEID=''>
    <cfset PACKING=''>
    <cfset MAXIMUM=''>
    <cfset xCOSTCODE=''>
    <cfset REORDER=''>
    <cfset xCOLORID=''>
    <cfset xshelf=''>
    <cfset taxcode=''>
    <cfset xWOS_GROUP=''>
    <cfif lcase(hcomid) eq "ltm_i">
      <CFSET xUNIT='PCS'>
      <cfelse>
      <CFSET xUNIT=''>
    </cfif>
    <CFSET WQFORMULA=''>
    <CFSET WPFORMULA=''>
    <CFSET QTYBF=''>
    <CFSET UCOST=''>
    <CFSET PRICE=''>
    <CFSET PRICE2=''>
    <CFSET PRICE3=''>
    <CFSET PRICE4=''>
    <CFSET PRICE5=''>
    <CFSET PRICE6=''>
    <CFSET PRICE_MIN=''>
    <cfset graded = '0'>
    <CFSET MURATIO=''>
    <CFSET QTY2=''>
    <CFSET QTY3=''>
    <CFSET QTY4=''>
    <CFSET QTY5=''>
    <CFSET QTY6=''>
    <CFSET SALEC=''>
    <CFSET SALECSC=''>
    <CFSET SALECnC=''>
    <CFSET PURC=''>
    <CFSET PURPREC=''>
    <CFSET STOCK=''>
    <CFSET WSERIALNO=''>
    <cfset nonstkitem = "">
    <CFSET REMARK1=''>
    <CFSET REMARK2=''>
    <CFSET REMARK3=''>
    <CFSET REMARK4=''>
    <CFSET REMARK5=''>
    <CFSET REMARK6=''>
    <CFSET REMARK7=''>
    <CFSET REMARK8=''>
    <CFSET REMARK9=''>
    <CFSET REMARK10=''>
    <CFSET REMARK11=''>
    <CFSET REMARK12=''>
    <CFSET REMARK13=''>
    <CFSET REMARK14=''>
    <CFSET REMARK15=''>
    <CFSET REMARK16=''>
    <CFSET REMARK17=''>
    <CFSET REMARK18=''>
    <CFSET REMARK19=''>
    <CFSET REMARK20=''>
    <CFSET REMARK21=''>
    <CFSET REMARK22=''>
    <CFSET REMARK23=''>
    <CFSET REMARK24=''>
    <CFSET REMARK25=''>
    <CFSET REMARK26=''>
    <CFSET REMARK27=''>
    <CFSET REMARK28=''>
    <CFSET REMARK29=''>
    <CFSET REMARK30=''>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset UNIT2 = ''>
    <cfset FACTOR1 = 1>
    <cfset FACTOR2 = 1>
    <cfset PRICEU2 = 0>
    <!--- ADD ON 260908, 2ND UNIT --->
    <cfset photo = "">
    <cfset document = "">
    <cfset fucost = 0>
    <cfset fprice = 0>
    <cfset custprice_rate = ''>
    <cfset fcurrcode = "">
    <cfset fucost2 = 0>
    <cfset fprice2 = 0>
    <cfset fcurrcode2 = ''>
    <cfset fucost3 = 0>
    <cfset fprice3 = 0>
    <cfset fcurrcode3 = ''>
    <cfset fucost4 = 0>
    <cfset fprice4 = 0>
    <cfset fcurrcode4 = ''>
    <cfset fucost5 = 0>
    <cfset fprice5 = 0>
    <cfset fcurrcode5 = ''>
    <cfset fucost6 = 0>
    <cfset fprice6 = 0>
    <cfset fcurrcode6 = ''>
    <cfset fucost7 = 0>
    <cfset fprice7 = 0>
    <cfset fcurrcode7 = ''>
    <cfset fucost8 = 0>
    <cfset fprice8 = 0>
    <cfset fcurrcode8 = ''>
    <cfset fucost9 = 0>
    <cfset fprice9 = 0>
    <cfset fcurrcode9 = ''>
    <cfset fucost10 = 0>
    <cfset fprice10 = 0>
    <cfset fcurrcode10 = ''>
    <cfset packingdesp1 = ''>
    <cfset packingqty1 = 0>
    <cfset packingfreeqty1 = 0>
    <cfset packingdesp2 = ''>
    <cfset packingqty2 = 0>
    <cfset packingfreeqty2 = 0>
    <cfset packingdesp3 = ''>
    <cfset packingqty3 = 0>
    <cfset packingfreeqty3 = 0>
    <cfset packingdesp4 = ''>
    <cfset packingqty4 = 0>
    <cfset packingfreeqty4 = 0>
    <cfset packingdesp5 = ''>
    <cfset packingqty5 = 0>
    <cfset packingfreeqty5 = 0>
    <cfset packingdesp6 = ''>
    <cfset packingqty6 = 0>
    <cfset packingfreeqty6 = 0>
    <cfset packingdesp7 = ''>
    <cfset packingqty7 = 0>
    <cfset packingfreeqty7 = 0>
    <cfset packingdesp8 = ''>
    <cfset packingqty8 = 0>
    <cfset packingfreeqty8 = 0>
    <cfset packingdesp9 = ''>
    <cfset packingqty9 = 0>
    <cfset packingfreeqty9 = 0>
    <cfset packingdesp10 = ''>
    <cfset packingqty10 = 0>
    <cfset packingfreeqty10 = 0>
    <cfset mode='Create'>
    <cfset title='Create Item'>
    <cfset button='Create'>
    <cfset comm = "">
    <cfset costformula = "">
    <cfset created_on = "">
    <cfset itemtype = "">
    <cfset releasedate="">
  </cfif>
  <h1>#title#</h1>
  <h4>
    <cfif getpin2.h1310 eq 'T'>
      <cfif lcase(hcomid) eq 'tcds_i'>
    	<a href="tcdsicitem2.cfm?type=Create">Creating a New Item</a> 
    <cfelse>
		<a href="icitem2.cfm?type=Create">Creating a New Item</a> 
    </cfif>
    </cfif>
    <cfif getpin2.h1320 eq 'T'>
      || <a href="icitem.cfm?">List all Item</a>
    </cfif>
    <cfif getpin2.h1330 eq 'T'>
      || <a href="s_icitem.cfm?type=icitem">Search For Item</a>
    </cfif>
    <cfif getpin2.h1340 eq 'T'>
      || <a href="p_icitem.cfm">Item Listing</a>
    </cfif>
    || <a href="icitem_setting.cfm">More Setting</a>
    <cfif getpin2.h1350 eq 'T'>
      || <a href="printbarcode_filter.cfm">Print Barcode</a>
    </cfif>
    <cfif getpin2.h1311 eq 'T' and getpin2.h13D0 eq 'T'>
      ||<a href="edititemexpress.cfm">Edit Item Express</a>
    </cfif>
    <cfif getpin2.h1311 eq 'T'>
      <cfquery name="checkitemnum" datasource="#dts#">
    select itemno from icitem
    </cfquery>
      <cfif checkitemnum.recordcount lt 400>
        ||<a href="edititemexpress2.cfm">Edit Item Express 2</a>
      </cfif>
    </cfif>
    <cfif lcase(HcomID) eq "tcds_i">
      ||<a href="tcdsupdatesupplier.cfm">Update Supplier According To Label</a> ||<a href="tcdsupdatelabel.cfm">Change Label</a>
    </cfif>
  </h4>
</cfoutput>

<cfquery name="getlastreceive" datasource="#dts#">
select sum(amt) as amt,sum(qty) as qty,wos_date from ictran where itemno='#itemno#' and type='RC' and price<>0 order by wos_date desc limit 1
</cfquery>


<cfform name='CustomerForm' action='tcdsicitemprocess.cfm' method='post' onsubmit='return validate(event);'>
  <cfoutput>
    <input type='hidden' name='mode' value='#mode#'>
    <input type='hidden' name='edi_id' value='#edi_id#'>
    <input type='hidden' name='com_id' value='#lcase(HcomID)#'>
    <cfif isdefined('url.express')>
      <input type='hidden' name='express' value='#url.express#'>
    </cfif>
    <cfif isdefined('url.ovasexpress')>
      <input type='hidden' name='ovasexpress' value='1'>
    </cfif>
  </cfoutput>
  <h1 align='center'>Item File Maintenance</h1>
  <table align='center' class='data' width='779' cellspacing="0">
    <cfoutput>
      <tr>
        <td width='126'><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
            Stock Code
            <cfelse>
            #getgsetup.litemno#
          </cfif>
          :</td>
        <td colspan='6'><cfif mode eq 'Delete' or mode eq 'Edit'>
            <input type='text' size='60' name='itemno' value='#convertquote(url.itemno)#' readonly>
            <cfelse>
            <cfif lcase(hcomid) eq "ovas_i" or lcase(hcomid) eq "demo_i">
              <input type='text' size='60' name='itemno' value='#itemno#'>
              <cfelse>
              <input type='text' size='60' name='itemno' value='#itemno#' maxlength='54'>
            </cfif>
          </cfif>
          
          <!--- These variables could be set dynamically --->
          
          <cfset theImage="images.jpg">
          
          <!--- The theItem string has an ampersand, so you must URL-encode it. --->
          
          <cftooltip sourceForTooltip="tiptext.cfm"> <cfoutput> <img src="#theImage#" height="20" width="20" /> </cfoutput> </cftooltip>
          <cfif lcase(HcomID) eq "snnpl_i">
            <cfif mode eq 'Delete' or mode eq 'Edit'>
              <cfelse>
              <input type="button" name="generateno" id="generateno" value="Generate Number" onClick="generatenumber();">
            </cfif>
          </cfif>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
          &nbsp;
          <div id="hint" class="autocomplete"></div>
          <script type="text/javascript">
						var url = "/ajax/functions/getRecord.cfm";
							
						new Ajax.Autocompleter("itemno","hint",url,{afterUpdateElement : getSelectedId});
							
						function getSelectedId(text, li) {
							$('itemno').value=li.id;
						}
					</script></td>
        <td><cfif isdefined('url.express')>
            <input name='submit' type='submit' value='#button#'>
          </cfif></td>
      </tr>
      <tr style="display:none">
        <td >Comment :</td>
        <td <cfif getdisplaysetup2.item_comment neq "Y">style="visibility:hidden"</cfif>><textarea name='comment' id="comment" tabindex="3" cols='60' rows='5'>#convertquote(comment)#</textarea></td>
      </tr>
      <tr>
        <td <cfif getdisplaysetup2.item_productcode neq "Y">style="visibility:hidden"</cfif>><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>
            Vendor's Code
            <cfelse>
            #getgsetup.laitemno#
          </cfif>
          : <cfif getdisplaysetup2.compulsory_item_productcode eq "Y">*</cfif></td>
        <td colspan='7' <cfif getdisplaysetup2.item_productcode neq "Y">style="visibility:hidden"</cfif>><input type='text' size='60' name='AITEMNO' value='#AITEMNO#' maxlength='30'></td>
      </tr>
      <tr>
        <td <cfif getdisplaysetup2.item_barcode neq "Y">style="visibility:hidden"</cfif>>#getgsetup.lbarcode# : <cfif getdisplaysetup2.compulsory_item_barcode eq "Y">*</cfif></td>
        <td colspan='7' <cfif getdisplaysetup2.item_barcode neq "Y">style="visibility:hidden"</cfif>><input type='text' size='60' name='barcode' value='#barcode#' maxlength='20'></td>
      </tr>
      
      
      <tr <cfif getdisplaysetup2.item_release neq "Y">style="display:none"</cfif>>
        <td height='22' <cfif getdisplaysetup2.item_release neq "Y">style="visibility:hidden"</cfif>>Release Date : <cfif getdisplaysetup2.compulsory_item_release eq "Y">*</cfif></td>
        <td colspan='7' <cfif getdisplaysetup2.item_release neq "Y">style="visibility:hidden"</cfif>>
        <input type="checkbox" name="itemtba" id="itemtba" value="1" onClick="itemtbafunc();" <cfif releasedate eq '31/12/9999'>checked</cfif>> TBA
        
        <div id="releasedatefield" >
        <cfinput type="text" name="releasedate" id="releasedate" value="#releasedate#" validate="eurodate" message="Please Key in correct format"> <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(releasedate);"> (DD/MM/YYYY)
        
        </div>
      <script language="javascript">
	  itemtbafunc();
	  </script>
      </tr>
      
      
    </cfoutput>
    <tr>
      <td colspan='8'><hr></td>
    </tr>
    <!--- Value Type => Category --->
    <cfquery name='getcate' datasource='#dts#'>
    select * from iccate order by cate
    </cfquery>
    <!--- Size => SizeID --->
    <cfquery name='getsizeid' datasource='#dts#'>
    select * from icsizeid order by sizeid
    </cfquery>
    <!--- Rating => CostCode --->
    <cfquery name='getcostcode' datasource='#dts#'>
    select * from iccostcode order by costcode
    </cfquery>
    <!--- Material => ColorID --->
    <cfquery name='getcolorid' datasource='#dts#'>
    select * from iccolorid order by colorid
    </cfquery>
    <!--- Manufacturer => shelf --->
    <cfquery name='getshelf' datasource='#dts#'>
    select * from icshelf order by shelf
    </cfquery>
    <!--- Model => Group --->
    <cfquery name='getgroup' datasource='#dts#'>
    select wos_group,desp from icgroup
    <cfif Hitemgroup neq ''>
    where wos_group='#Hitemgroup#'
    </cfif>
    order by wos_group
    </cfquery>
    <!--- unit --->
    <cfquery name='getUnit' datasource='#dts#'>
    select * from Unit order by unit
    </cfquery>
    <!--- Supplier --->
    <cfquery name='getsupp' datasource='#dts#'>
    select custno,name,currcode from #target_apvend# where (status<>'B' or status is null) order by custno
    </cfquery>
    <tr>
    <td><cfoutput>#getgsetup.lsize# : </cfoutput><cfif getdisplaysetup2.compulsory_item_size eq "Y">*</cfif></td>
    <td width='148' nowrap>
	<cfif left(dts,4) eq "tcds">
        <cfoutput>
          <input type="text" name="SIZEID" id="SIZEID" value="#xsizeid#" size="20" readonly onFocus="ColdFusion.Window.show('findsizewindow');">
          <input type="button" name="searchsize" value="Search" onClick="ColdFusion.Window.show('findsizewindow');">
        </cfoutput>
        <cfelse>
        <select name='SIZEID' id="SIZEID">
          <option value=''>-</option>
          <cfoutput query='getsizeid'>
            <option value='#sizeid#'<cfif sizeid eq xsizeid>selected</cfif>>#sizeid# - #desp#</option>
          </cfoutput>
        </select>
      </cfif>
      <br>
      <a onClick="ColdFusion.Window.show('createSizeAjax');" onMouseOver="this.style.cursor='hand';">Create New <cfoutput>#getgsetup.lsize#</cfoutput></a></td>
    </tr>
    <cfoutput>
    <tr>
        <td>Description</td>
        <td colspan='6'><textarea id="desp" name="desp" cols="100" rows="1" style="overflow:auto" onKeyPress="return imposeMaxLength(this, <cfif lcase(HcomID) eq "hl_i">
        35
		<cfelse>
        #getgsetup.desplimit#
		</cfif>);"  >#convertquote(desp)#</textarea>
        
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan='7' <cfif getdisplaysetup2.item_descp neq "Y">style="visibility:hidden"</cfif>><textarea id="despa" name="despa" cols="100" rows="1" style="overflow:auto" onKeyPress="return imposeMaxLength(this, <cfif lcase(HcomID) eq "hl_i">
        35
		<cfelse>
        70
		</cfif>);" >#convertquote(despa)#</textarea>
          &nbsp;&nbsp;</td>
      </tr>
    </cfoutput>
    <tr>
      <td colspan='8'><hr></td>
    </tr>
    <tr>
      <th height='20' colspan='8'> <div align='center'><strong>General Information</strong></div></th>
    </tr>
    <tr>
      <td <cfif getdisplaysetup2.item_supplier neq "Y">style="visibility:hidden"</cfif>><cfif getpin2.h13C0 eq 'T'>
          Supplier : <cfif getdisplaysetup2.compulsory_item_supplier eq "Y">*</cfif>
        </cfif></td>
      <td colspan='4' <cfif getdisplaysetup2.item_supplier neq "Y">style="visibility:hidden"</cfif>><cfif getpin2.h13C0 eq 'T'>
          <select name='supp' id="supp">
            <option value=''>-</option>
            <cfoutput query='getsupp'>
              <option value='#custno#'<cfif custno eq xsupp>selected</cfif>>#custno# - #getsupp.name#
              <cfif trim(getsupp.currcode) neq "">
                - #getsupp.currcode#
              </cfif>
              </option>
            </cfoutput>
          </select>
          <input type="text" name="searchsupp" onKeyUp="getSupp('supp', 'Supplier');">
          <cfelse>
          <input type="hidden" name="supp" id="supp" value="#xsupp#">
        </cfif></td>
    </tr>
      <tr>
    <tr><cfoutput>
        <td <cfif getdisplaysetup2.item_material neq "Y">style="visibility:hidden"</cfif>>#getgsetup.lmaterial# : <cfif getdisplaysetup2.compulsory_item_material eq "Y">*</cfif></td>
      </cfoutput>
      <td width='148' <cfif getdisplaysetup2.item_material neq "Y">style="visibility:hidden"</cfif>><select name='COLORID' id="COLORID">
          <option value=''>-</option>
          <cfoutput query='getcolorid'>
            <option value='#colorid#'<cfif colorid eq xcolorid>selected</cfif>>#colorid# - #desp#</option>
          </cfoutput>
        </select>
        <a onClick="ColdFusion.Window.show('createColorAjax');" onMouseOver="this.style.cursor='hand';">Create New <cfoutput>#getgsetup.lmaterial#</cfoutput></a></td>
      <td colspan='-1' <cfif getdisplaysetup2.item_maximum neq "Y">style="visibility:hidden"</cfif>>Maximum :</td>
      <td colspan='-1' <cfif getdisplaysetup2.item_maximum neq "Y">style="visibility:hidden"</cfif>><cfinput type='text' size='14' name='MAXIMUM' value='#MAXIMUM#' maxlength='14'></td>
    </tr>
    <cfoutput>
      <td <cfif getdisplaysetup2.item_category neq "Y">style="visibility:hidden"</cfif>>#getgsetup.lcategory# : <cfif getdisplaysetup2.compulsory_item_cate eq "Y">*</cfif></td>
    </cfoutput>
    <td colspan="3" <cfif getdisplaysetup2.item_category neq "Y">style="visibility:hidden"</cfif>><cfoutput>
        <select name='CATEGORY' id="CATEGORY" onChange="ajaxFunction(document.getElementById('groupajax'),'icitemgroupajax.cfm?xgroup=#xwos_group#&category='+document.getElementById('CATEGORY').value);">
          <option value=''>-</option>
          <cfloop query='getcate'>
            <option value='#cate#'<cfif cate eq xcategory>selected</cfif>>#cate# - #desp#</option>
          </cfloop>
        </select>
      </cfoutput>
      <cfif getpin2.h1410 eq 'T'>
      <br>
        <a onClick="ColdFusion.Window.show('createCateAjax');" onMouseOver="this.style.cursor='hand';">Create New <cfoutput>#getgsetup.lcategory#</cfoutput></a>
      </cfif></td>
      <td rowspan="6" colspan="2" <cfif getdisplaysetup2.item_changepic neq "Y">style="visibility:hidden"</cfif>><iframe id="show_picture" name="show_picture" frameborder="1" marginheight="0" marginwidth="0" align="middle" height="150" width="150" scrolling="no" src="icitem_image.cfm?pic3=#urlencodedformat(photo)#"></iframe>
        <br/>
        Click Picture To Show Original Size </td>
        </tr>
        
        <tr><cfoutput>
        <td <cfif getdisplaysetup2.item_shelfno neq "Y">style="visibility:hidden"</cfif>>#getgsetup.lmodel#: <cfif getdisplaysetup2.compulsory_item_shelfno eq "Y">*</cfif></td>
      </cfoutput>
      <td width='148' <cfif getdisplaysetup2.item_shelfno neq "Y">style="visibility:hidden"</cfif>><select name='shelf' id="shelf">
          <option value=''>-</option>
          <cfoutput query='getshelf'>
            <option value='#shelf#'<cfif shelf eq xshelf>selected</cfif>>#shelf# - #desp#</option>
          </cfoutput>
        </select>
        <a onClick="ColdFusion.Window.show('createShelfAjax');" onMouseOver="this.style.cursor='hand';">Create New <cfoutput>#getgsetup.lmodel#</cfoutput></a></td>
      <td <cfif getdisplaysetup2.item_defalutedtax neq "Y">style="visibility:hidden"</cfif>>Defaulted Tax:</td>
      <cfquery name="gettax" datasource="#dts#">
        select "" as code,"Choose a tax" as code2 
        union all
        select code,code as code2 from #target_taxtable# where (tax_type = "ST" or tax_type = "T")
        </cfquery>
      <td <cfif getdisplaysetup2.item_defalutedtax neq "Y">style="visibility:hidden"</cfif>><cfselect name="taxcode" id="taxcode" query="gettax" display="code2" value="code" selected="#taxcode#" /></td>
      <td colspan='1'></td>
    </tr>
        
        <tr><cfoutput>
        <td <cfif getdisplaysetup2.item_group neq "Y" or getpin2.h13F0 neq 'T'>style="visibility:hidden"</cfif>>#getgsetup.lgroup# : <cfif getdisplaysetup2.compulsory_item_group eq "Y">*</cfif></td>
      </cfoutput>
      <td width='148' <cfif getdisplaysetup2.item_group neq "Y" or getpin2.h13F0 neq 'T'>style="visibility:hidden"</cfif>><div id="groupajax">
          <select name='WOS_GROUP' id="WOS_GROUP">
            <option value=''>-</option>
            <cfoutput query='getgroup'>
              <option value='#wos_group#'<cfif wos_group eq xwos_group>selected</cfif>>#wos_group# - #desp#</option>
            </cfoutput>
          </select>
        </div>
        <cfif getpin2.h1510 eq 'T'>
          <a onClick="ColdFusion.Window.show('createGroupAjax');" onMouseOver="this.style.cursor='hand';">Create New <cfoutput>#getgsetup.lgroup#</cfoutput></a>
        </cfif></td>
      <td colspan='-1' <cfif getdisplaysetup2.item_reorder neq "Y">style="visibility:hidden"</cfif>>Reorder :</td>
      <td colspan='-1' <cfif getdisplaysetup2.item_reorder neq "Y">style="visibility:hidden"</cfif>><cfinput type='text' size='14' name='REORDER' value='#REORDER#' maxlength='14'></td>
    </tr>
        
        
        <cfoutput>
      	<tr>
        
        <td height='22' <cfif getdisplaysetup2.item_brand neq "Y">style="visibility:hidden"</cfif>>
            <cfoutput>#getgsetup.lbrand# :</cfoutput><cfif getdisplaysetup2.compulsory_item_brand eq "Y">*</cfif></td>
        <td colspan='7' <cfif getdisplaysetup2.item_brand neq "Y">style="visibility:hidden"</cfif>><select name="BRAND" id="BRAND">
            <option value="">-</option>
            <cfloop query="getbrand">
              <option value="#brand#" <cfif getbrand.brand eq xbrand>selected</cfif>>#getbrand.brand# - #getbrand.desp#</option>
            </cfloop>
          </select>
          <br>
          <!--- <input type='text' size='100' name='BRAND' value='#convertquote(BRAND)#' maxlength='40'>---> 
          <a onClick="ColdFusion.Window.show('createBrandAjax');" onMouseOver="this.style.cursor='hand';">Create New #getgsetup.lbrand#</a></td>
      </tr>
      </cfoutput>
      <cfoutput>
      <tr>
      <td nowrap>Average Cost Price :</td>
      <td nowrap>
      <cfif val(getlastreceive.qty) neq 0>#NumberFormat(getlastreceive.amt/getlastreceive.qty,'.__')#<cfelse>#NumberFormat(UCOST,'.__')#</cfif>
      </td>
      </tr>
      <tr>
      <cfif getpin2.h1360 neq 'T'>
          <td nowrap>&nbsp;</td>
          <td nowrap><input name='UCOST' type='hidden' value='#NumberFormat(UCOST, stDecl_UPrice)#' size='17' maxlength='17'>
            &nbsp;&nbsp;</td>
          <cfelse>
          <td nowrap <cfif getdisplaysetup2.item_ucp neq "Y">style="visibility:hidden"</cfif>>Lastest Cost Price :</td>
          <td nowrap <cfif getdisplaysetup2.item_ucp neq "Y">style="visibility:hidden"</cfif>><input name='UCOST' type='text' value='#NumberFormat(UCOST, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </cfif>
      </tr>
      </cfoutput>
      <tr>
      <cfif getpin2.h1360 neq 'T'>
        <cfif getpin2.h1361 neq 'T'>
          <td height='22'>&nbsp;</td>
          <td><cfinput name='PRICE' type='hidden' id='PRICE' value='#NumberFormat(PRICE, stDecl_UPrice)#' size='17' maxlength='17'>
            &nbsp;&nbsp;
            <cfinput name='FPRICE' type='hidden' id='FPRICE' value='#NumberFormat(FPRICE, stDecl_UPrice)#' size='17' maxlength='17'></td>
          <cfelse>
          <td height='22' <cfif getdisplaysetup2.item_usp1 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "ultrexauto_i">
              Asking Price:
              <cfelse>
              Selling Price :
            </cfif></td>
          <td <cfif getdisplaysetup2.item_usp1 neq "Y">style="visibility:hidden"</cfif>><cfinput name='PRICE' type='text' id='PRICE' value='#NumberFormat(PRICE, stDecl_UPrice)#' size='17' maxlength='17'>
            <cfoutput>
              <cfif url.type eq 'Edit'>
                <input type="button" name="button" value="Price Record" onClick="window.open('/default/maintenance/icitemhistran/historypricerecord.cfm?itemno=#url.itemno#')">
              </cfif>
            </cfoutput></td>
        </cfif>
        <cfelse>
        <td height='22' <cfif getdisplaysetup2.item_usp1 neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "ultrexauto_i">
            Asking Price:
            <cfelse>
            Selling Price :
          </cfif></td>
        <td <cfif getdisplaysetup2.item_usp1 neq "Y">style="visibility:hidden"</cfif>><cfinput name='PRICE' type='text' id='PRICE' value='#NumberFormat(PRICE, stDecl_UPrice)#' size='17' maxlength='17'>
          <cfoutput>
            <cfif url.type eq 'Edit'>
              <input type="button" name="button" value="Price Record" onClick="window.open('/default/maintenance/icitemhistran/historypricerecord.cfm?itemno=#url.itemno#')">
            </cfif>
          </cfoutput></td>
      </cfif>
      </tr>
      
      <tr>
      <cfif getpin2.h1360 neq 'T'>
        <cfif getpin2.h1361 neq 'T'>
          <cfif getpin2.h1361 neq 'T'>
            <td height='22'></td>
            <td><cfinput name='PRICE2' type='hidden' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
            <cfelse>
            <td height='22' <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>>Lowest Selling Price :</td>
            <td <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>><cfinput name='PRICE2' type='text' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
          </cfif>
          <cfelse>
          <td height='22' <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>>Lowest Selling Pric2 :</td>
          <td <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>><cfinput name='PRICE2' type='text' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </cfif>
        <cfelse>
        <td height='22' <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>>Lowest Selling Price :</td>
        <td <cfif getdisplaysetup2.item_usp2 neq "Y">style="visibility:hidden"</cfif>><cfinput name='PRICE2' type='text' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
      </cfif>
      </tr>
      <tr ><cfoutput>
        <td <cfif getdisplaysetup2.item_rating neq "Y">style="visibility:hidden"</cfif>>#getgsetup.lrating# : <cfif getdisplaysetup2.compulsory_item_rating eq "Y">*</cfif></td>
      </cfoutput>
      <td width='200' <cfif getdisplaysetup2.item_rating neq "Y">style="visibility:hidden"</cfif>><select name='COSTCODE' id="COSTCODE">
          <option value=''>-</option>
          <cfoutput query='getcostcode'>
            <option value='#costcode#'<cfif costcode eq xcostcode>selected</cfif>>#costcode# - #desp#</option>
          </cfoutput>
        </select>
        <a onClick="ColdFusion.Window.show('createRatingAjax');" onMouseOver="this.style.cursor='hand';"><br><cfoutput>Create New #getgsetup.lrating#</cfoutput></a></td>
      <td width='100' colspan='-1' <cfif getdisplaysetup2.item_minimum neq "Y">style="visibility:hidden"</cfif>>Minimum :</td>
      <td width='151' colspan='-1' <cfif getdisplaysetup2.item_minimum neq "Y">style="visibility:hidden"</cfif>><cfinput type='text' size='14' name='MINIMUM' value='#MINIMUM#' maxlength='14'></td>
    </tr>
      <cfoutput>
      <tr>
      <td>Created On :</td>
      <td>#dateformat(created_on,'DD/MM/YYYY')#</td>
      </tr>
      <tr>
      <td nowrap>Last Receive Date :</td>
      <td><cfif getlastreceive.recordcount neq 0>#dateformat(getlastreceive.wos_date,'DD/MM/YYYY')#</cfif></td>
      </tr>
      </cfoutput>
      <tr style="display:none">
      <td colspan='-1' <cfif getdisplaysetup2.item_packing neq "Y">style="visibility:hidden"</cfif>><cfif lcase(hcomid) eq "meisei_i">
          SPQ/ MOQ
          <cfelse>
          Packing
        </cfif>
        :</td>
      <td colspan='-1' <cfif getdisplaysetup2.item_packing neq "Y">style="visibility:hidden"</cfif>><cfinput type='text' size='14' name='PACKING' value='#PACKING#' maxlength='20'></td>
    </tr>
    
    
    
    
    
    
    
    <tr style="display:none">
      <td colspan='1'></td>
      <td colspan='3'></td>
    </tr>
    <tr style="display:none">
      <td <cfif getdisplaysetup2.item_changepic neq "Y">style="visibility:hidden"</cfif>>Change Picture :</td>
      <cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">
      <td <cfif getdisplaysetup2.item_changepic neq "Y">style="visibility:hidden"</cfif>><select name="picture_available" id="picture_available" onChange="javascript:change_picture(this.value);">
          <option value="">-</option>
          <cfoutput query="picture_list">
            <cfif picture_list.name neq "Thumbs.db">
              <option value="#picture_list.name#" #iif((photo eq picture_list.name),DE("selected"),DE(""))#>#picture_list.name#</option>
            </cfif>
          </cfoutput>
        </select>
        &nbsp;&nbsp;<img name="img1" src="/images/delete.ico" height="15" width="15" onMouseOver="this.style.cursor='hand'" onClick="delete_picture(document.getElementById('picture_available').value);" />
        <input type="button" name="openuploadphoto" id="openuploadphoto" value="Upload Photo" onClick="ColdFusion.Window.show('uploadphotoAjax');"></td>
      <td <cfif getdisplaysetup2.item_itemtype neq "Y">style="visibility:hidden"</cfif>>Item Type</td>
      <td <cfif getdisplaysetup2.item_itemtype neq "Y">style="visibility:hidden"</cfif>><select name="itemtype" id="itemtype">
          <option value="">Choose an Itemtype</option>
          <option value="S" <cfif itemtype eq "S">selected </cfif>>Sales Only</option>
          <option value="P" <cfif itemtype eq "P">selected </cfif>>Purchases Only</option>
          <option value="SV" <cfif itemtype eq "SV">selected </cfif>>Service Item</option>
        </select></td>
    </tr>
    <tr style="display:none">
      <td <cfif getdisplaysetup2.item_costcode neq "Y">style="visibility:hidden"</cfif>>Cost Code</td>
      <td <cfif getdisplaysetup2.item_costcode neq "Y">style="visibility:hidden"</cfif>><cfinput type="text" id="costformula" name="costformula" value="#costformula#" readonly bind="cfc:costformula.getcostformula('#dts#',{UCOST})"></td>
    </tr>
    <tr style="display:none">
      <td <cfif getdisplaysetup2.item_changepic neq "Y">style="visibility:hidden"</cfif>>Document :</td>
      <cfdirectory action="list" directory="#HRootPath#\document\#hcomid#\" name="document_list">
      <td <cfif getdisplaysetup2.item_changepic neq "Y">style="visibility:hidden"</cfif>><select name="document_available" id="document_available">
          <option value="">-</option>
          <cfoutput query="document_list">
            <option value="#document_list.name#" #iif((document eq document_list.name),DE("selected"),DE(""))#>#document_list.name#</option>
          </cfoutput>
        </select>
        &nbsp;&nbsp;<img name="img1" src="/images/delete.ico" height="15" width="15" onMouseOver="this.style.cursor='hand'" onClick="delete_document(document.getElementById('document_available').value);" />
        <input type="button" name="opendoc" id="opendoc" value="Upload Document" onClick="ColdFusion.Window.show('uploaddocumentAjax');">
        <cfoutput>
          <input type="button" name="downloaddocument" id="downloaddocument" value="Download Document" onClick="downloaddoc()">
        </cfoutput>
        <div id="getdocumentajax"> </div></td>
    </tr>
    <tr style="display:none">
      <td colspan='8'><hr></td>
    </tr>
    <tr style="display:none">
      <th colspan='8'><div align='center'><strong>Product Details</strong></div></th>
    </tr>
    <tr align="left" style="display:none">
      <td nowrap <cfif getdisplaysetup2.item_uom neq "Y">style="visibility:hidden"</cfif>>Unit of Measurement : <cfif getdisplaysetup2.compulsory_item_uom eq "Y">*</cfif></td>
      <td <cfif getdisplaysetup2.item_uom neq "Y">style="visibility:hidden"</cfif>><select name='UNIT' id="UNIT">
          <option value=''>-</option>
          <cfoutput query='getUnit'>
            <option value='#Unit#'<cfif Unit eq xUNIT>selected</cfif>>#Unit# - #desp#</option>
          </cfoutput>
        </select>
        <br>
        <a onClick="ColdFusion.Window.show('createUnitAjax');" onMouseOver="this.style.cursor='hand';">Create New Unit of Measurement</a></td>
      <cfoutput>
        <td nowrap <cfif getdisplaysetup2.item_qtyformula neq "Y">style="visibility:hidden"</cfif>>Qty Formula :</td>
        <td nowrap <cfif getdisplaysetup2.item_qtyformula neq "Y">style="visibility:hidden"</cfif>><input name='WQFORMULA' type='checkbox' value='1' <cfif #WQFORMULA# eq 1>checked</cfif>></td>
        <td nowrap <cfif getdisplaysetup2.item_upformula neq "Y">style="visibility:hidden"</cfif>> U.P Formula :</td>
        <td nowrap <cfif getdisplaysetup2.item_upformula neq "Y">style="visibility:hidden"</cfif>><input name='WPFORMULA' type='checkbox' value='1' <cfif #WPFORMULA# eq 1>checked</cfif>></td>
      </cfoutput> </tr>
    <cfoutput>
      <tr style="display:none">
       
        <td nowrap <cfif getmodule.serialno neq "1" >style="visibility:hidden"<cfelse>
		<cfif getdisplaysetup2.item_serialno neq "Y">style="visibility:hidden"</cfif></cfif>>Serial No. :</td>
        <td nowrap 
		<cfif getmodule.serialno neq "1" >style="visibility:hidden"<cfelse>
		
		<cfif getdisplaysetup2.item_serialno neq "Y">style="visibility:hidden"</cfif></cfif>><input name='wserialno' type='checkbox' value='T'<cfif #wserialno# eq "T">checked</cfif>></td>
        <td nowrap <cfif getdisplaysetup2.item_relateditem neq "Y">style="visibility:hidden"</cfif>> Related Item :</td>
        <td nowrap <cfif getdisplaysetup2.item_relateditem neq "Y">style="visibility:hidden"</cfif>><input name="relitem" type="checkbox" value="1" onClick="javascript:ColdFusion.Window.show('relitem');"></td>
        <td colspan='-1'>&nbsp;</td>
        <td colspan='-1'>&nbsp;</td>
      </tr>
    </cfoutput>
    <tr style="display:none">
      
      <td nowrap 
      <cfif getmodule.grade neq "1" >style="visibility:hidden"<cfelse>
	  <cfif getdisplaysetup2.item_grade neq "Y">style="visibility:hidden"</cfif></cfif>>Non Graded :</td>
      <td nowrap 
      <cfif getmodule.grade neq "1" >style="visibility:hidden"<cfelse>
	  
	  <cfif getdisplaysetup2.item_grade neq "Y">style="visibility:hidden"</cfif></cfif>><input name='graded' id="graded2" type='radio' value='N' <cfif graded eq "N" or graded eq ''>checked<cfelse>checked</cfif>></td>
      <td nowrap <cfif getdisplaysetup2.item_qtybf neq "Y" or getpin2.h13E0 neq 'T'>style="visibility:hidden"</cfif>>Qty B/F :</td>
      <td nowrap <cfif getdisplaysetup2.item_qtybf neq "Y" or getpin2.h13E0 neq 'T'>style="visibility:hidden"</cfif>><cfoutput>
          <input name='QTYBF' type='text' value='#QTYBF#' size='10' maxlength='10'>
        </cfoutput></td>
      <td colspan='-1'>&nbsp;</td>
      <td colspan='-1'>&nbsp;</td>
    </tr>
    <tr style="display:none">
      
      <td nowrap 
	  <cfif getmodule.grade neq "1" >style="visibility:hidden"<cfelse>
	  <cfif getdisplaysetup2.item_grade neq "Y">style="visibility:hidden"</cfif></cfif>>Graded :</td>
      <td nowrap 
      <cfif getmodule.grade neq "1" >style="visibility:hidden"<cfelse>
	  
	  <cfif getdisplaysetup2.item_grade neq "Y">style="visibility:hidden"</cfif></cfif>><input name='graded' id="graded1" type='radio' value='Y' <cfif graded eq "Y">checked</cfif>></td>
      <td nowrap <cfif getdisplaysetup2.item_commissionlevel neq "Y">style="visibility:hidden"</cfif>>Commission Level :</td>
      <td nowrap <cfif getdisplaysetup2.item_commissionlevel neq "Y">style="visibility:hidden"</cfif>><cfquery name="getcomm" datasource="#dts#">
      SELECT "Choose a Commission Level" as commname
      union all
      SELECT commname FROM commission
      </cfquery>
        <cfselect name="comm" id="comm" query="getcomm" value="commname" display="commname" selected="#comm#" /></td>
      <!--- <td nowrap>Graded 2 :</td>
      	<td nowrap><input name='graded' type='radio' value='Y' <cfif #graded# eq 2>checked</cfif>></td> ---> 
    </tr>
    <cfoutput>
      <tr style="display:none">
        <cfif getpin2.h1360 neq 'T'>
          <cfif getpin2.h1361 neq 'T'>
            <td nowrap><input name='MURATIO' type='hidden' value='#MURATIO#' size='5' maxlength='5' onKeyUp="calculate_price3('#iDecl_UPrice#');"></td>
            <td><input name='PRICE3' type='hidden' value='#NumberFormat(PRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
            <cfelse>
            <td nowrap <cfif getdisplaysetup2.item_mur neq "Y">style="visibility:hidden"</cfif>>M.U Ratio :
              <input name='MURATIO' type='text' value='#MURATIO#' size='5' maxlength='5' onKeyUp="calculate_price3('#iDecl_UPrice#');"></td>
            <td <cfif getdisplaysetup2.item_mur neq "Y">style="visibility:hidden"</cfif>><input name='PRICE3' type='text' value='#NumberFormat(PRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
          </cfif>
          <cfelse>
          <td nowrap <cfif getdisplaysetup2.item_mur neq "Y">style="visibility:hidden"</cfif>>M.U Ratio :
            <input name='MURATIO' type='text' value='#MURATIO#' size='5' maxlength='5' onKeyUp="calculate_price3('#iDecl_UPrice#');"></td>
          <td <cfif getdisplaysetup2.item_mur neq "Y">style="visibility:hidden"</cfif>><input name='PRICE3' type='text' value='#NumberFormat(PRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </cfif>
        <td nowrap <cfif getdisplaysetup2.item_length neq "Y">style="visibility:hidden"</cfif>><cfif lcase(HcomID) eq "fixics_i">
            Unit
            <cfelseif lcase(HcomID) eq "excelsnm_i">
            Depth
            <cfelse>
            Length
          </cfif>
          :</td>
        <td nowrap <cfif getdisplaysetup2.item_length neq "Y">style="visibility:hidden"</cfif>><cfinput name='QTY2' type='text' value='#QTY2#' size='8' maxlength='8'></td>
        <td nowrap <cfif getdisplaysetup2.item_creditsales neq "Y">style="visibility:hidden"</cfif>>Credit Sales :</td>
        <td nowrap <cfif getdisplaysetup2.item_creditsales neq "Y">style="visibility:hidden"</cfif>><cfinput name='SALEC' type='text' value='#SALEC#' size='8' maxlength='8'>
          <cfif Hlinkams eq "Y">
            <a onClick="ColdFusion.Window.show('findglacc2');"><img src="/images/down.png" /></a>
          </cfif></td>
      </tr>
      <cfif getpin2.h1360 neq 'T'>
        <cfif getpin2.h1361 neq 'T'>
          <input name='PRICE4' type='hidden' value='#NumberFormat(PRICE4, stDecl_UPrice)#' size='17' maxlength='17'>
          <input name='PRICE5' type='hidden' value='#NumberFormat(PRICE5, stDecl_UPrice)#' size='17' maxlength='17'>
          <input name='PRICE6' type='hidden' value='#NumberFormat(PRICE6, stDecl_UPrice)#' size='17' maxlength='17'>
          <cfelse>
          <tr style="display:none">
            <td nowrap <cfif getdisplaysetup2.item_usp4 neq "Y">style="display:none"</cfif>>Unit Selling Price 4 : </td>
            <td <cfif getdisplaysetup2.item_usp4 neq "Y">style="display:none"</cfif>><input name='PRICE4' type='text' value='#NumberFormat(PRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
          </tr>
          <tr>
            <td nowrap <cfif getdisplaysetup2.item_usp5 neq "Y">style="display:none"</cfif>>Unit Selling Price 5 : </td>
            <td <cfif getdisplaysetup2.item_usp5 neq "Y">style="display:none"</cfif>><input name='PRICE5' type='text' value='#NumberFormat(PRICE5, stDecl_UPrice)#' size='17' maxlength='17'></td>
          </tr>
          <tr>
            <td nowrap <cfif getdisplaysetup2.item_usp6 neq "Y">style="display:none"</cfif>>Unit Selling Price 6 : </td>
            <td <cfif getdisplaysetup2.item_usp6 neq "Y">style="display:none"</cfif>><input name='PRICE6' type='text' value='#NumberFormat(PRICE6, stDecl_UPrice)#' size='17' maxlength='17'></td>
          </tr>
        </cfif>
        <cfelse>
        <tr style="display:none">
          <td nowrap <cfif getdisplaysetup2.item_usp4 neq "Y">style="display:none"</cfif>>Unit Selling Price 4 : </td>
          <td <cfif getdisplaysetup2.item_usp4 neq "Y">style="display:none"</cfif>><input name='PRICE4' type='text' value='#NumberFormat(PRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </tr>
        <tr style="display:none">
          <td nowrap <cfif getdisplaysetup2.item_usp5 neq "Y">style="display:none"</cfif>>Unit Selling Price 5 : </td>
          <td <cfif getdisplaysetup2.item_usp5 neq "Y">style="display:none"</cfif>><input name='PRICE5' type='text' value='#NumberFormat(PRICE5, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </tr>
        <tr style="display:none">
          <td nowrap <cfif getdisplaysetup2.item_usp6 neq "Y">style="display:none"</cfif>>Unit Selling Price 6 : </td>
          <td <cfif getdisplaysetup2.item_usp6 neq "Y">style="display:none"</cfif>><input name='PRICE6' type='text' value='#NumberFormat(PRICE6, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </tr>
      </cfif>
      <tr style="display:none">
        <cfif getpin2.h1360 neq 'T'>
          <td></td>
          <td><cfif getgsetup.gpricemin eq 1>
              <cfinput name='PRICE_MIN' type='hidden' value='#NumberFormat(PRICE_MIN, stDecl_UPrice)#' size='17' maxlength='17'>
              <cfelse>
              <input type="hidden" name="PRICE_MIN" id="PRICE_MIN" value="#val(PRICE_MIN)#">
            </cfif></td>
          <cfelse>
          <td <cfif getdisplaysetup2.item_msp neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.gpricemin eq 1>
              Min. Selling Price :
            </cfif></td>
          <td <cfif getdisplaysetup2.item_msp neq "Y">style="visibility:hidden"</cfif>><cfif getgsetup.gpricemin eq 1>
              <cfinput name='PRICE_MIN' type='text' value='#NumberFormat(PRICE_MIN, stDecl_UPrice)#' size='17' maxlength='17'>
              <cfelse>
              <input type="hidden" name="PRICE_MIN" id="PRICE_MIN" value="#val(PRICE_MIN)#">
            </cfif></td>
        </cfif>
        <td nowrap <cfif getdisplaysetup2.item_width neq "Y">style="visibility:hidden"</cfif>><cfif lcase(HcomID) eq "ultrexauto_i">
            Engine No:
            <cfelse>
            Width :
          </cfif></td>
        <td nowrap <cfif getdisplaysetup2.item_width neq "Y">style="visibility:hidden"</cfif>><input name='QTY3' type='text' value='#QTY3#' size='8' maxlength='25'></td>
        <td nowrap <cfif getdisplaysetup2.item_cashsales neq "Y">style="visibility:hidden"</cfif>>Cash Sales :</td>
        <td nowrap <cfif getdisplaysetup2.item_cashsales neq "Y">style="visibility:hidden"</cfif>><input name='SALECSC' type='text' value='#SALECSC#' size='8' maxlength='8'>
          <cfif Hlinkams eq "Y">
            <a onClick="ColdFusion.Window.show('findglacc1');"><img src="/images/down.png" /></a>
          </cfif></td>
      </tr>
    </cfoutput> <cfoutput>
      <tr style="display:none">
        <td nowrap <cfif getdisplaysetup2.item_discontinue neq "Y">style="visibility:hidden"</cfif>>Discontinue Item :</td>
        <td nowrap <cfif getdisplaysetup2.item_discontinue neq "Y">style="visibility:hidden"</cfif>><input name='nonstkitem' type='checkbox' value='T' <cfif nonstkitem eq 'T'>checked</cfif>></td>
        <td nowrap <cfif getdisplaysetup2.item_thickness neq "Y">style="visibility:hidden"</cfif>><cfif lcase(HcomID) eq "ultrexauto_i">
            Chasis No:
            <cfelseif lcase(HcomID) eq "excelsnm_i">
            Height
            <cfelse>
            Thickness :
          </cfif></td>
        <td nowrap <cfif getdisplaysetup2.item_thickness neq "Y">style="visibility:hidden"</cfif>><input name='QTY4' type='text' value='#QTY4#' size='8' maxlength='25'></td>
        <td nowrap <cfif getdisplaysetup2.item_salesreturn neq "Y">style="visibility:hidden"</cfif>>Sales Return :</td>
        <td nowrap <cfif getdisplaysetup2.item_salesreturn neq "Y">style="visibility:hidden"</cfif>><input name='SALECNC' type='text' value='#SALECNC#' size='8' maxlength='8'>
          <cfif Hlinkams eq "Y">
            <a onClick="ColdFusion.Window.show('findglacc3');"><img src="/images/down.png" /></a>
          </cfif></td>
      </tr>
      <cfquery name="getcurr" datasource="#dts#">
      SELECT "" as currcode,"Choose a Currency" as currdesp
      union all
      SELECT currcode,concat(currcode,' - ',currency1) as currdesp FROM #target_currency# WHERE currcode <> "#getgsetup.bcurr#"
      </cfquery>
      <tr style="display:none">
        <td <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>>Normal</td>
        <td nowrap <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>><input name='custprice_rate' type='radio' value='normal'<cfif custprice_rate eq "normal"> checked</cfif>></td>
        <td nowrap <cfif getdisplaysetup2.item_w_l neq "Y">style="visibility:hidden"</cfif>>
        <cfif lcase(HcomID) eq "excelsnm_i">
        Length
        <cfelse>
        Weight / Length :
        </cfif></td>
        <td nowrap <cfif getdisplaysetup2.item_w_l neq "Y">style="visibility:hidden"</cfif>><input name='QTY5' type='text' value='#QTY5#' size='8' maxlength='8'></td>
        <td nowrap <cfif getdisplaysetup2.item_purchase neq "Y">style="visibility:hidden"</cfif>>Purchase :</td>
        <td nowrap <cfif getdisplaysetup2.item_purchase neq "Y">style="visibility:hidden"</cfif>><input name='PURC' type='text' value='#PURC#' size='8' maxlength='8'>
          <cfif Hlinkams eq "Y">
            <a onClick="ColdFusion.Window.show('findglacc4');"><img src="/images/down.png" /></a>
          </cfif></td>
      </tr>
      <tr style="display:none">
        <td <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>>Offer</td>
        <td nowrap <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>><input name='custprice_rate' type='radio' value='offer' <cfif custprice_rate eq "offer">  checked</cfif>></td>
        <td nowrap <cfif getdisplaysetup2.item_p_w neq "Y">style="visibility:hidden"</cfif>>
        <cfif lcase(HcomID) eq "excelsnm_i">
        Max.wt
        <cfelse>
        Price / Weight :
        </cfif>
        </td>
        <td nowrap <cfif getdisplaysetup2.item_p_w neq "Y">style="visibility:hidden"</cfif>><input name='QTY6' type='text' value='#QTY6#' size='8' maxlength='8'></td>
        <td nowrap <cfif getdisplaysetup2.item_purchasereturn neq "Y">style="visibility:hidden"</cfif>>Purchase Return :</td>
        <td nowrap <cfif getdisplaysetup2.item_purchasereturn neq "Y">style="visibility:hidden"</cfif>><input name='PURPREC' type='text' value='#PURPREC#' size='8' maxlength='8'>
          <cfif Hlinkams eq "Y">
            <a onClick="ColdFusion.Window.show('findglacc5');"><img src="/images/down.png" /></a>
          </cfif></td>
      </tr>
      <tr style="display:none">
        <td <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>>Others</td>
        <td nowrap <cfif getdisplaysetup2.item_cp neq "Y">style="visibility:hidden"</cfif>><input name='custprice_rate' type='radio' value='others' <cfif custprice_rate eq "others">  checked</cfif>></td>
        <td></td>
        <td></td>
        <td nowrap <cfif getdisplaysetup2.item_stock neq "Y">style="visibility:hidden"</cfif>>Stock :</td>
        <td nowrap <cfif getdisplaysetup2.item_stock neq "Y">style="visibility:hidden"</cfif>><input name='STOCK' type='text' value='#STOCK#' size='8' maxlength='8'></td>
      </tr>
      <tr>
        <td colspan="7" align="right"><cfif getpin2.h1312 neq 'T'>
            <input name='submit'  style="font: medium bolder;background-color:##FFCC00; color:##FFFFFF" type='submit' value='#button#'>
          </cfif></td>
      </tr>
      <tr style="display:none">
        <td colspan='100%'><hr></td>
      </tr>
      <tr style="display:none">
        <th height='20' colspan='100%' onClick="javascript:shoh('r5');"><div align='center'><strong>Packing<img src="../../images/u.gif" name="imgr5" align="center"></strong></div></th>
      </tr>
      <tr style="display:none">
        <td colspan="7"><table style="display:none" id="r5" align="center" width="100%">
            <tr>
              <td>Packing Name 1 :</td>
              <td><input type="text" name="packingdesp1" id="packingdesp1" value="#packingdesp1#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty1" id="packingqty1" value="#packingqty1#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty1" id="packingfreeqty1" value="#packingfreeqty1#" /></td>
            </tr>
            <tr>
              <td>Packing Name 2 :</td>
              <td><input type="text" name="packingdesp2" id="packingdesp2" value="#packingdesp2#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty2" id="packingqty2" value="#packingqty2#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty2" id="packingfreeqty2" value="#packingfreeqty2#" /></td>
            </tr>
            <tr>
              <td>Packing Name 3 :</td>
              <td><input type="text" name="packingdesp3" id="packingdesp3" value="#packingdesp3#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty3" id="packingqty3" value="#packingqty3#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty3" id="packingfreeqty3" value="#packingfreeqty3#" /></td>
            </tr>
            <tr>
              <td>Packing Name 4 :</td>
              <td><input type="text" name="packingdesp4" id="packingdesp4" value="#packingdesp4#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty4" id="packingqty4" value="#packingqty4#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty4" id="packingfreeqty4" value="#packingfreeqty4#" /></td>
            </tr>
            <tr>
              <td>Packing Name 5 :</td>
              <td><input type="text" name="packingdesp5" id="packingdesp5" value="#packingdesp5#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty5" id="packingqty5" value="#packingqty5#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty5" id="packingfreeqty5" value="#packingfreeqty5#" /></td>
            </tr>
            <tr>
              <td>Packing Name 6 :</td>
              <td><input type="text" name="packingdesp6" id="packingdesp6" value="#packingdesp6#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty6" id="packingqty6" value="#packingqty6#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty6" id="packingfreeqty6" value="#packingfreeqty6#" /></td>
            </tr>
            <tr>
              <td>Packing Name 7 :</td>
              <td><input type="text" name="packingdesp7" id="packingdesp7" value="#packingdesp7#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty7" id="packingqty7" value="#packingqty7#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty7" id="packingfreeqty7" value="#packingfreeqty7#" /></td>
            </tr>
            <tr>
              <td>Packing Name 8 :</td>
              <td><input type="text" name="packingdesp8" id="packingdesp8" value="#packingdesp8#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty8" id="packingqty8" value="#packingqty8#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty8" id="packingfreeqty8" value="#packingfreeqty8#" /></td>
            </tr>
            <tr>
              <td>Packing Name 9 :</td>
              <td><input type="text" name="packingdesp9" id="packingdesp9" value="#packingdesp9#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty9" id="packingqty9" value="#packingqty9#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty9" id="packingfreeqty9" value="#packingfreeqty9#" /></td>
            </tr>
            <tr>
              <td>Packing Name 10 :</td>
              <td><input type="text" name="packingdesp10" id="packingdesp10" value="#packingdesp10#" /></td>
              <td>Qty :</td>
              <td><input type="text" name="packingqty10" id="packingqty10" value="#packingqty10#" /></td>
              <td>Free Qty :</td>
              <td><input type="text" name="packingfreeqty10" id="packingfreeqty10" value="#packingfreeqty10#" /></td>
            </tr>
          </table></td>
      </tr>
      <tr style="display:none">
        <td colspan='100%'><hr></td>
      </tr>
      <tr style="display:none">
        <th height='20' colspan='100%' onClick="javascript:shoh('r4');"><div align='center'><strong>Foreign Price and Cost<img src="../../images/u.gif" name="imgr4" align="center"></strong></div></th>
      </tr>
      <tr>
        <td colspan="7"><table style="display:none" id="r4" align="center" width="100%">
            <tr>
              <td>Foreign Currency :</td>
              <td><cfselect name="fcurrcode" id="fcurrcode" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode#" /></td>
              <td>Foreign Currency 2:</td>
              <td><cfselect name="fcurrcode2" id="fcurrcode2" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode2#" /></td>
            </tr>
            <tr>
              <td>Foreign Unit Cost</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST' type='hidden' value='#NumberFormat(FUCOST, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST' type='text' value='#NumberFormat(FUCOST, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Unit Cost 2</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST2' type='hidden' value='#NumberFormat(FUCOST2, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST2' type='text' value='#NumberFormat(FUCOST2, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Selling Price</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE' type='hidden' value='#NumberFormat(FPRICE, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE' type='text' value='#NumberFormat(FPRICE, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE' type='text' value='#NumberFormat(FPRICE, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Selling Price 2</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE2' type='hidden' value='#NumberFormat(FPRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE2' type='text' value='#NumberFormat(FPRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE2' type='text' value='#NumberFormat(FPRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Currency 3:</td>
              <td><cfselect name="fcurrcode3" id="fcurrcode3" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode3#" /></td>
              <td>Foreign Currency 4:</td>
              <td><cfselect name="fcurrcode4" id="fcurrcode4" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode4#" /></td>
            </tr>
            <tr>
              <td>Foreign Unit Cost 3</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST3' type='hidden' value='#NumberFormat(FUCOST3, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST3' type='text' value='#NumberFormat(FUCOST3, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Unit Cost 4</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST4' type='hidden' value='#NumberFormat(FUCOST4, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST4' type='text' value='#NumberFormat(FUCOST4, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Selling Price 3</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE3' type='hidden' value='#NumberFormat(FPRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE3' type='text' value='#NumberFormat(FPRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE3' type='text' value='#NumberFormat(FPRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Selling Price 4</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE4' type='hidden' value='#NumberFormat(FPRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE4' type='text' value='#NumberFormat(FPRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE4' type='text' value='#NumberFormat(FPRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Currency 5:</td>
              <td><cfselect name="fcurrcode5" id="fcurrcode5" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode5#" /></td>
              <td>Foreign Currency 6:</td>
              <td><cfselect name="fcurrcode6" id="fcurrcode6" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode6#" /></td>
            </tr>
            <tr>
              <td>Foreign Unit Cost 5</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST5' type='hidden' value='#NumberFormat(FUCOST5, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST5' type='text' value='#NumberFormat(FUCOST5, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Unit Cost 6</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST6' type='hidden' value='#NumberFormat(FUCOST6, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST6' type='text' value='#NumberFormat(FUCOST6, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Selling Price 5</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE5' type='hidden' value='#NumberFormat(FPRICE5, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE5' type='text' value='#NumberFormat(FPRICE5, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE5' type='text' value='#NumberFormat(FPRICE5, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Selling Price 6</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE6' type='hidden' value='#NumberFormat(FPRICE6, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE6' type='text' value='#NumberFormat(FPRICE6, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE6' type='text' value='#NumberFormat(FPRICE6, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Currency 7:</td>
              <td><cfselect name="fcurrcode7" id="fcurrcode7" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode7#" /></td>
              <td>Foreign Currency 8:</td>
              <td><cfselect name="fcurrcode8" id="fcurrcode8" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode8#" /></td>
            </tr>
            <tr>
              <td>Foreign Unit Cost 7</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST7' type='hidden' value='#NumberFormat(FUCOST7, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST7' type='text' value='#NumberFormat(FUCOST7, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Unit Cost 8</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST8' type='hidden' value='#NumberFormat(FUCOST8, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST8' type='text' value='#NumberFormat(FUCOST8, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Selling Price 7</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE7' type='hidden' value='#NumberFormat(FPRICE7, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE7' type='text' value='#NumberFormat(FPRICE7, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE7' type='text' value='#NumberFormat(FPRICE7, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Selling Price 8</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE8' type='hidden' value='#NumberFormat(FPRICE8, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE8' type='text' value='#NumberFormat(FPRICE8, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE8' type='text' value='#NumberFormat(FPRICE8, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Currency 9:</td>
              <td><cfselect name="fcurrcode9" id="fcurrcode9" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode9#" /></td>
              <td>Foreign Currency 10:</td>
              <td><cfselect name="fcurrcode10" id="fcurrcode10" query="getcurr" value="currcode" display="currdesp" selected="#fcurrcode10#" /></td>
            </tr>
            <tr>
              <td>Foreign Unit Cost 9</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST9' type='hidden' value='#NumberFormat(FUCOST9, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST9' type='text' value='#NumberFormat(FUCOST9, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Unit Cost 10</td>
              <cfif getpin2.h1360 neq 'T'>
                <td nowrap><input name='FUCOST10' type='hidden' value='#NumberFormat(FUCOST10, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <cfelse>
                <td nowrap><input name='FUCOST10' type='text' value='#NumberFormat(FUCOST10, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
            <tr>
              <td>Foreign Selling Price 9</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE9' type='hidden' value='#NumberFormat(FPRICE9, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE9' type='text' value='#NumberFormat(FPRICE9, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE9' type='text' value='#NumberFormat(FPRICE9, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
              <td>Foreign Selling Price 10</td>
              <cfif getpin2.h1360 neq 'T'>
                <cfif getpin2.h1361 neq 'T'>
                  <td nowrap><input name='FPRICE10' type='hidden' value='#NumberFormat(FPRICE10, stDecl_UPrice)#' size='17' maxlength='17'></td>
                  <cfelse>
                  <td nowrap><input name='FPRICE10' type='text' value='#NumberFormat(FPRICE10, stDecl_UPrice)#' size='17' maxlength='17'></td>
                </cfif>
                <cfelse>
                <td nowrap><input name='FPRICE10' type='text' value='#NumberFormat(FPRICE10, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </cfif>
            </tr>
          </table></td>
      </tr>
      
      <!--- ADD ON 260908, 2ND UOM --->
      <tr style="display:none">
        <td colspan='100%'><hr></td>
      </tr>
      <tr style="display:none">
        <th height='20' colspan='100%' onClick="javascript:shoh('r3');"><div align='center'><strong>2nd Unit&nbsp;<img src="../../images/u.gif" name="imgr3" align="center"></strong></div></th>
      </tr>
      <tr>
        <td colspan="7"><table style="display:none" id="r3" align="center" width="50%">
            <tr>
              <td>Unit of Measure</td>
              <td>1st Unit</td>
              <td>2nd Unit</td>
              <td>Selling Price</td>
            </tr>
            <tr>
              <td><select name='unit2'>
                  <option value=''>-</option>
                  <cfloop query='getUnit'>
                    <option value='#Unit#'<cfif Unit eq UNIT2>selected</cfif>>#Unit# - #desp#</option>
                  </cfloop>
                </select></td>
              <td><cfinput name='FACTOR1' type='text' id='FACTOR1' value='#NumberFormat(FACTOR1, stDecl_UPrice)#' size='17' maxlength='17'></td>
              <td><cfinput name='FACTOR2' type='text' id='FACTOR2' value='#NumberFormat(FACTOR2, stDecl_UPrice)#' size='17' maxlength='17'></td>
              <td><cfinput name='PRICEU2' type='text' id='PRICEU2' value='#NumberFormat(PRICEU2, stDecl_UPrice)#' size='17' maxlength='17'></td>
            </tr>
            <cfloop from="3" to="6" index="i">
              <cfif url.type eq 'Create'>
                <cfset SecondUnit = "">
                <cfset factora = 1>
                <cfset factorb = 1>
                <cfset Price2ndUnit = 0>
                <cfelse>
                <cfset SecondUnit = Evaluate("getitem.UNIT#i#")>
                <cfset factora = Evaluate("getitem.FACTORU#i#_A")>
                <cfset factorb = Evaluate("getitem.FACTORU#i#_B")>
                <cfset Price2ndUnit = Evaluate("getitem.PRICEU#i#")>
              </cfif>
              <tr>
                <td><select name='unit#i#'>
                    <option value=''>-</option>
                    <cfloop query='getUnit'>
                      <option value='#Unit#'<cfif Unit eq SecondUnit>selected</cfif>>#Unit# - #desp#</option>
                    </cfloop>
                  </select></td>
                <td><cfinput name='FACTORU#i#_A' type='text' id='FACTORU#i#_A' value='#NumberFormat(factora, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <td><cfinput name='FACTORU#i#_B' type='text' id='FACTORU#i#_B' value='#NumberFormat(factorb, stDecl_UPrice)#' size='17' maxlength='17'></td>
                <td><cfinput name='PRICEU#i#' type='text' id='PRICEU#i#' value='#NumberFormat(Price2ndUnit, stDecl_UPrice)#' size='17' maxlength='17'></td>
              </tr>
            </cfloop>
          </table></td>
      </tr>
      <!--- ADD ON 260908, 2ND UOM --->
      <tr>
        <td colspan='8'><hr></td>
      </tr>
      <tr style="display:none">
        <th height='20' colspan='8' onClick="javascript:shoh('r1');"><div align='center'><strong>
            <cfif lcase(hcomid) eq "kingston_i">
              Other Suppliers
              <cfelse>
              Remarks
            </cfif>
            <img src="../../images/u.gif" name="imgr1" align="center"></strong></div></th>
      </tr>
      <tr style="display:none">
        <cfif lcase(hcomid) eq "kingston_i">
          <td colspan="7"><table style="display:none" id="r1" align="center" width="85%">
              <cfloop from="1" to="30" index="i">
                <tr>
                  <td height='22'>Other Supplier #i# :</td>
                  <td><select name='Remark#i#'>
                      <option value=''>-</option>
                      <cfloop query='getsupp'>
                        <option value='#custno#'<cfif custno eq "#evaluate('Remark#i#')#">selected</cfif>>#custno# - #getsupp.name#
                        <cfif trim(getsupp.currcode) neq "">
                          - #getsupp.currcode#
                        </cfif>
                        </option>
                      </cfloop>
                    </select></td>
                </tr>
              </cfloop>
            </table></td>
          <cfelse>
            <td colspan="7">
          <table style="display:none" id="r1" align="center" width="85%">
            <tr>
              <td width='25%' nowrap height='22'><!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
							Foreign Currency Price 1 --->
                
                <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
                  Fixed / Variable
                  <cfelseif lcase(hcomid) eq "asaiki_i">
                  Length
                  <cfelse>
                  Remark 1
                </cfif>
                : </td>
              <td width='75%'><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
                  <select name="Remark1">
                    <option value="F" <cfif Remark1 eq "F">selected</cfif>>Fixed</option>
                    <option value="V" <cfif Remark1 eq "V">selected</cfif>>Variable</option>
                  </select>
                  <cfelse>
                  <input name='Remark1' type='text' value='#Remark1#' size='100' maxlength='100' onClick="select();">
                </cfif></td>
            </tr>
            <tr>
              <td height='22'><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
                  Type of Service
                  <cfelseif lcase(hcomid) eq "asaiki_i">
                  Width
                  <cfelse>
                  Remark 2
                </cfif>
                :</td>
              <td><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
                  <select name="Remark2">
                    <option value="">Please Select One</option>
                    <option value="PT" <cfif Remark2 eq "PT">selected</cfif>>PORT TARIFF</option>
                    <option value="PS" <cfif Remark2 eq "PS">selected</cfif>>PORT SERVICE</option>
                    <option value="OP" <cfif Remark2 eq "OP">selected</cfif>>OPEN PURCHASES</option>
                    <option value="CS" <cfif Remark2 eq "CS">selected</cfif>>COMMERCIAL SEGMENT</option>
                    <option value="CH" <cfif Remark2 eq "CH">selected</cfif>>CHARTER HIRE</option>
                    <option value="SC" <cfif Remark2 eq "SC">selected</cfif>>SCRAP SALES</option>
                    <option value="OI" <cfif Remark2 eq "OI">selected</cfif>>OTHER INCOME</option>
                  </select>
                  <cfelse>
                  <input name='Remark2' type='text' value='#Remark2#' size='100' maxlength='100' onClick="select();">
                </cfif></td>
            </tr>
            <tr>
              <td height='22'><cfif lcase(hcomid) eq "asaiki_i">
                  SQM
                  <cfelse>
                  Remark 3
                </cfif>
                :</td>
              </td>
            
            
              <td><input name='Remark3' type='text' value='#Remark3#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'><cfif lcase(hcomid) eq "asaiki_i">
                  CUST P/N/REMARK
                  <cfelse>
                  Remark 4
                </cfif>
                :</td>
              <td><input name='Remark4' type='text' value='#Remark4#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 5 :</td>
              <td><input name='Remark5' id="Remark5" type='text' value='#Remark5#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 6 :</td>
              <td><input name='Remark6' type='text' value='#Remark6#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 7 :</td>
              <td><input name='Remark7' type='text' value='#Remark7#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 8 :</td>
              <td><input name='Remark8' type='text' value='#Remark8#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 9 :</td>
              <td><input name='Remark9' type='text' value='#Remark9#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td nowrap height='22'>Remark 10 :</td>
              <td><input name='Remark10' type='text' value='#Remark10#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 11 :</td>
              <td><input name='Remark11' type='text' value='#Remark11#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 12 :</td>
              <td><input name='Remark12' type='text' value='#Remark12#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='26'>Remark 13 :</td>
              <td><input name='Remark13' type='text' value='#Remark13#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 14 :</td>
              <td><input name='Remark14' type='text' value='#Remark14#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 15 :</td>
              <td><input name='Remark15' type='text' value='#Remark15#' size='100' maxlength='50' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 16 :</td>
              <td><input name='Remark16' type='text' value='#Remark16#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 17 :</td>
              <td><input name='Remark17' type='text' value='#Remark17#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 18 :</td>
              <td><input name='Remark18' type='text' value='#Remark18#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 19 :</td>
              <td><input name='Remark19' type='text' value='#Remark19#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 20 :</td>
              <td><input name='Remark20' type='text' value='#Remark20#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 21 :</td>
              <td><input name='Remark21' type='text' value='#Remark21#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 22 :</td>
              <td><input name='Remark22' type='text' value='#Remark22#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 23 :</td>
              <td><input name='Remark23' type='text' value='#Remark23#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 24 :</td>
              <td><input name='Remark24' type='text' value='#Remark24#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 25 :</td>
              <td><input name='Remark25' type='text' value='#Remark25#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 26 :</td>
              <td><input name='Remark26' type='text' value='#Remark26#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 27 :</td>
              <td><input name='Remark27' type='text' value='#Remark27#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 28 :</td>
              <td><input name='Remark28' type='text' value='#Remark28#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 29 :</td>
              <td><input name='Remark29' type='text' value='#Remark29#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
            <tr>
              <td height='22'>Remark 30 :</td>
              <td><input name='Remark30' type='text' value='#Remark30#' size='100' maxlength='100' onClick="select();"></td>
            </tr>
          </table>
            </td>
        </cfif>
      </tr>
    </cfoutput>
  </table>
</cfform>
<!---
<form name="upload_picture" action="icitem_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
	<table class="data" align="center" width="779">
		<tr>
        	<th height='20' colspan='8' onClick="javascript:shoh('r2');"><div align='center'><strong>Upload Item Photo<img src="../../images/d.gif" name="imgr2" align="center"></strong></div></th>
      	</tr>
		<tr id="r2">
			<td align="center">
				<input type="file" name="picture" size="50" onChange="javascript:uploading_picture(this.value);" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
				<br/>
				<input type="text" name="picture_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="javascript:return add_option(document.getElementById('picture_name').value);">
			</td>
		</tr>
	</table>
</form>--->
<cfajaximport tags="cfform">
<cfoutput>
  <cfwindow x="20" y="100" width="250" height="250" name="findSymbol1" refreshOnShow="true"
        title="ADD SYMBOL" initshow="false"
        source="/default/maintenance/symbol/maintenanceSymbolAjax.cfm?id=1" />
  <cfwindow x="20" y="100" width="250" height="250" name="findSymbol2" refreshOnShow="true"
        title="ADD SYMBOL" initshow="false"
        source="/default/maintenance/symbol/maintenanceSymbolAjax.cfm?id=2" />
  <cfwindow center="true" width="600" height="400" name="createBrandAjax" refreshOnShow="true"
        title="Create #getgsetup.lbrand#" initshow="false"
        source="/default/maintenance/createBrandAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createCateAjax" refreshOnShow="true"
        title="Create Category" initshow="false"
        source="/default/maintenance/createCateAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createSizeAjax" refreshOnShow="true"
        title="Create #getgsetup.lsize#" initshow="false"
        source="/default/maintenance/createSizeAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createRatingAjax" refreshOnShow="true"
        title="Create Rating" initshow="false"
        source="/default/maintenance/createRatingAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createColorAjax" refreshOnShow="true"
        title="Create #getgsetup.lmaterial#" initshow="false"
        source="/default/maintenance/createColorAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createGroupAjax" refreshOnShow="true"
        title="Create Group" initshow="false"
        source="/default/maintenance/createGroupAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createShelfAjax" refreshOnShow="true"
        title="Create Model" initshow="false"
        source="/default/maintenance/createShelfAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="createUnitAjax" refreshOnShow="true"
        title="Create Unit" initshow="false"
        source="/default/maintenance/createUnitAjax.cfm" />
  <cfwindow center="true" width="600" height="400" name="uploaddocumentAjax" refreshOnShow="true"
        title="Upload" initshow="false"
        source="/default/maintenance/uploaddocument.cfm" />
  <cfwindow center="true" width="600" height="400" name="uploadphotoAjax" refreshOnShow="true"
        title="Upload" initshow="false"
        source="/default/maintenance/uploadphoto.cfm" />
  <cfwindow center="true" width="700" height="400" name="findglacc1" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc1.cfm" />
  <cfwindow center="true" width="700" height="400" name="findglacc2" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc2.cfm" />
  <cfwindow center="true" width="700" height="400" name="findglacc3" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc3.cfm" />
  <cfwindow center="true" width="700" height="400" name="findglacc4" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc4.cfm" />
  <cfwindow center="true" width="700" height="400" name="findglacc5" refreshOnShow="true" closable="true" modal="true" title="Gl Account" initshow="false" source="findglacc5.cfm" />
</cfoutput>
<cfif left(dts,4) eq "tcds">
  <cfwindow width="500" height="500" name="findsizewindow" refreshOnShow="true" closable="true" center="true" title="Find #getgsetup.lsize#" initshow="false" source="findsize.cfm" />
</cfif>
</body>
</html>