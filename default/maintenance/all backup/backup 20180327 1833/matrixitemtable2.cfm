<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Product Page</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../../scripts/collapse_expand_single_item.js"></script>

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<script language='JavaScript'>
	
	function change_picture(picture)
	{
		var encode_picture = encodeURI(picture);
		show_picture.location="icitem_image.cfm?pic3="+encode_picture;
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
	
	function calculate_price3(fixnum){
		if(isNaN(document.form.MURATIO.value)){
			alert("The value is not a number. Please try again");
		}
		else{
			if(document.form.UCOST.value == ''){
				var costprice = 0;
			}
			else{
				var costprice = document.form.UCOST.value;
			}
			var price3 = document.form.MURATIO.value * document.form.UCOST.value;
			price3 = price3.toFixed(fixnum);
			document.form.PRICE3.value = price3;
		}
	}
	
	function validate()
	{
		if(document.form.mitemno.value=='')
		{
			alert("Your Matrix Item's No. cannot be blank.");
			document.form.mitemno.focus();
			return false;
		}
		
		return true;
	}
	
	function getcolorsize(colorno){
		if(colorno !=''){
			DWREngine._execute(_maintenanceflocation, null, 'getcolorsize', colorno, showcolorsize);
		}
	}
	
	function showcolorsize(colorObject){
		//1. Clear all the Size & Color	
		for(j=1;j<=20;j++){
			fieldname = 'color'+j;
			fieldname2 = 'size'+j;
			DWRUtil.setValue(fieldname, '');
			DWRUtil.setValue(fieldname2, '');
		}
		
		//2. Add Color	
		newArray = colorObject.COLORLIST;
		var colorArray = newArray.split(",");
		var count=0;
		if(colorArray.length <= 20){
			for(i=0;i<colorArray.length;i++){
				var count=count+1;
				fieldname = 'color'+count;
				DWRUtil.setValue(fieldname, colorArray[i]);
			}
		}else{
			for(i=0;i<20;i++){
				var count=count+1;
				fieldname = 'color'+count;
				DWRUtil.setValue(fieldname, colorArray[i]);
			}
		}
		
		//3. Add Size
		newArray2 = colorObject.SIZELIST;
		var sizeArray = newArray2.split(",");
		var count1=0;
		if(sizeArray.length <= 20){
			for(i=0;i<sizeArray.length;i++){
				var count1=count1+1;
				fieldname = 'size'+count1;
				DWRUtil.setValue(fieldname, sizeArray[i]);
			}
		}else{
			for(i=0;i<20;i++){
				var count1=count1+1;
				fieldname = 'size'+count1;
				DWRUtil.setValue(fieldname, sizeArray[i]);
			}
		}	
	}
	
	function uploading_picture(pic_name)
	{
		var new_pic_name1 = new String(pic_name);
		var new_pic_name2 = new_pic_name1.split(/[-,/,\\]/g);
		document.getElementById("picture_name").value=new_pic_name2[new_pic_name2.length-1];
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
	
</script>
</head>

<cfquery name='getgsetup' datasource='#dts#'>
  Select * from gsetup
</cfquery>

<!--- Control The Decimal Point --->
<cfquery name='getgsetup2' datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = '.'>

<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = stDecl_UPrice & '_'>
</cfloop>

<cfquery name="geticcolor2" datasource="#dts#">
	select distinct colorno from iccolor2
</cfquery>
<body>
<cfoutput>
	<cfif url.type eq 'Edit'>
		<cfquery datasource='#dts#' name='getitem'>
			Select * from icmitem where mitemno='#url.mitemno#'
	  	</cfquery>
		
		<cfset xcolorno=getitem.colorno>	
	  	<cfset mitemno=getitem.mitemno>
	  	<cfset desp=getitem.desp>
	  	<cfset despa=getitem.despa>
	  	<cfset AITEMNO=getitem.AITEMNO>
	  	<cfset xBRAND=getitem.BRAND>
	  	<cfset xCATEGORY=getitem.CATEGORY>
	  	<cfset xSUPP=getitem.SUPP>
	  	<cfset xWOS_GROUP=getitem.WOS_GROUP>
        <cfset xsizeid=getitem.sizeid>
        <cfset xcolorid=getitem.colorid>
        <cfset xshelf=getitem.shelf>
        <cfset photo = getitem.photo>
		<cfset xUNIT=getitem.UNIT>
	  	<cfset UCOST=getitem.UCOST>
	  	<cfset PRICE=getitem.PRICE>
        <cfset PRICE2=getitem.PRICE2>
        <cfset PRICE3=getitem.PRICE3>
        <cfset PRICE4=getitem.PRICE4>
        
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
        
        <cfset muratio=getitem.muratio>
	  	<cfset sizecolor=getitem.sizecolor>
	  	<cfset mode='Edit'>
	  	<cfset title='Edit Item'>
	  	<cfset button='Edit'>
	</cfif>

	<cfif url.type eq 'Delete'>
		<cfquery datasource='#dts#' name='getitem'>
			Select * from icmitem where mitemno='#url.mitemno#'
	  	</cfquery>
		
		<cfset xcolorno=getitem.colorno>
	  	<cfset mitemno=getitem.mitemno>
	  	<cfset desp=getitem.desp>
	  	<cfset despa=getitem.despa>
	  	<cfset AITEMNO=getitem.AITEMNO>
	  	<cfset xBRAND=getitem.BRAND>
	  	<cfset xCATEGORY=getitem.CATEGORY>
	  	<cfset xSUPP=getitem.SUPP>
	  	<cfset xWOS_GROUP=getitem.WOS_GROUP>
        <cfset xsizeid=getitem.sizeid>
		<cfset xUNIT=getitem.UNIT>
        <cfset xcolorid=getitem.colorid>
        <cfset xshelf=getitem.shelf>
        <cfset photo = getitem.photo>
	  	<cfset UCOST=getitem.UCOST>
	  	<cfset PRICE=getitem.PRICE>
        <cfset PRICE2=getitem.PRICE2>
        <cfset PRICE3=getitem.PRICE3>
        <cfset PRICE4=getitem.PRICE4>
        
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
        
        <cfset muratio=getitem.muratio>
	  	<cfset sizecolor=getitem.sizecolor>
		<cfset mode='Delete'>
	  	<cfset title='Delete Item'>
	  	<cfset button='Delete'>
	</cfif>
			
    <cfif url.type eq 'Create'>
      	<cfset xcolorno=''>
		<cfset mitemno=''>
	  	<cfset desp=''>
	  	<cfset despa=''>
	  	<cfset AITEMNO=''>
	  	<cfset xBRAND=''>
	  	<cfset xCATEGORY=''>
	  	<cfset xSUPP=''>
	  	<cfset xWOS_GROUP=''>
        <cfset xsizeid=''>
	  	<cfset xUNIT=''>
	  	<cfset UCOST=''>
	  	<cfset PRICE=''>
        <cfset PRICE2=''>
        <cfset PRICE3=''>
        <cfset PRICE4=''>
        <cfset muratio=''>
        <cfset xcolorid=''>
        <cfset xshelf=''>
        <cfset photo =''>
        
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
        
	  	<cfset sizecolor='SC'>
	  	<cfset mode='Create'>
	  	<cfset title='Create Item'>
	  	<cfset button='Create'>
	</cfif>

	<h1>#title#</h1>
	
    <h4>
		<cfif getpin2.h1M10 eq 'T'><a href="matrixitemtable2.cfm?type=Create">Creating a New Matrix Item</a> </cfif>
		<cfif getpin2.h1M20 eq 'T'>|| <a href="matrixitemtable.cfm">List all Matrix Item</a> </cfif>
		<cfif getpin2.h1M30 eq 'T'>|| <a href="s_matrixitemtable.cfm?type=Icitem">Search For Matrix Item</a> </cfif>
	</h4>
  </cfoutput>

<cfform name='form' action='matrixitemtableprocess.cfm' method='post' onsubmit='return validate();'>
<cfoutput><input type='hidden' name='mode' value='#mode#'></cfoutput>
<h1 align='center'>Matrix Item File Maintenance</h1>
	<table align='center' class='data' width='90%' cellspacing="0">
    <cfoutput>
		<tr>
        	<td width='126'>Color No. :</td>
        	<td colspan='7'>
          		<cfif mode eq 'Delete' or mode eq 'Edit'>
            		<input type='text' size='5' name='colorno' value='#xcolorno#' readonly>
            	<cfelse>
            		<select name='colorno' onChange="getcolorsize(this.value)">
          				<option value=''>-</option>
          				<cfloop query='geticcolor2'>
            				<option value='#colorno#'>#colorno#</option>
         	 			</cfloop>
        			</select>
          		</cfif>
       		</td>
      	</tr>
      	<tr>
        	<td width='126'>Matrix Itemno :</td>
        	<td colspan='7'>
          		<cfif mode eq 'Delete' or mode eq 'Edit'>
            		<input type='text' size='40' name='mitemno' value='#convertquote(url.mitemno)#' readonly>
            	<cfelse>
            		<input type='text' size='40' name='mitemno' value='#mitemno#' maxlength='20'>
          		</cfif>
        	</td>
      	</tr>
      	<tr>
        	<td>Description :</td>
        	<td colspan='7'><input type='text' size='100' name='desp' value='#convertquote(desp)#' maxlength='60'></td>
      	</tr>
      	<tr>
        	<td>&nbsp;</td>
        	<td colspan='7'><input type='text' size='100' name='despa' value='#convertquote(despa)#' maxlength='70'></td>
      	</tr>
      	<tr>
        	<td>Alternate Itemno:</td>
        	<td colspan='7'><input type='text' size='60' name='AITEMNO' value='#AITEMNO#' maxlength='20'></td>
      	</tr>
        <cfquery name='getbrand' datasource='#dts#'>
    select * from brand order by brand
    </cfquery>
      	<tr>
        	<td height='22'>Brand :</td>
        	<td colspan='7'><select name='Brand'>
            <option value=''>-</option>
            <cfloop query='getbrand'>
              <option value='#brand#'<cfif brand eq xbrand>selected</cfif>>#brand# - #desp#</option>
            </cfloop>
          </select></td>
      	</tr>
    </cfoutput>
    <tr>
      <td colspan='10'><hr></td>
    </tr>
    <tr>
      <th height='20' colspan='10'>
        <div align='center'><strong>General Information</strong></div></th>
    </tr>
    <!--- Value Type => Category --->
    <cfquery name='getcate' datasource='#dts#'>
    select * from iccate order by cate
    </cfquery>
    
    
    <!--- Model => Group --->
    <cfquery name='getgroup' datasource='#dts#'>
    select * from icgroup order by wos_group
    </cfquery>
    <!--- size --->
    <cfquery name='getsize' datasource='#dts#'>
    select * from icsizeid order by sizeid
    </cfquery>
    <!--- unit --->
    <cfquery name='getUnit' datasource='#dts#'>
    select * from Unit order by unit
    </cfquery>
    <!--- Supplier --->
    <cfquery name='getsupp' datasource='#dts#'>
    select * from #target_apvend# where status<>'B' or status is null order by custno
    </cfquery>
	<!--- Color --->
	<cfquery name='geticcolor2' datasource='#dts#'>
    	select colorid2,desp from iccolor2 group by colorid2 order by colorid2
    </cfquery>
    <!--- Material => ColorID --->
    <cfquery name='getcolorid' datasource='#dts#'>
    select * from iccolorid order by colorid
    </cfquery>
    <!--- Manufacturer => shelf --->
    <cfquery name='getshelf' datasource='#dts#'>
    select * from icshelf order by shelf
    </cfquery>
    <cfquery name="getcurr" datasource="#dts#">
      SELECT "" as currcode,"Choose a Currency" as currdesp
      union all
      SELECT currcode,concat(currcode,' - ',currency1) as currdesp FROM #target_currency# WHERE currcode <> "#getgsetup.bcurr#"
      </cfquery>
    <tr>
      <td>Supplier :</td>
      <td colspan='7'>
        <select name='supp'>
          <option value=''>-</option>
          <cfoutput query='getsupp'>
            <option value='#custno#'<cfif custno eq xsupp>selected</cfif>>#custno# - #getsupp.name#</option>
          </cfoutput>
        </select>
      </td>
    </tr>
    <tr> 
		<cfoutput><td>#getgsetup.lcategory# :</td></cfoutput>
        <td colspan='7'>
          <select name='CATEGORY'>
            <option value=''>-</option>
            <cfoutput query='getcate'>
              <option value='#cate#'<cfif cate eq xcategory>selected</cfif>>#cate# - #desp#</option>
            </cfoutput>
          </select>
        </td>
        <td rowspan="6" colspan="2">
        <cfoutput>
			<iframe id="show_picture" name="show_picture" frameborder="1" marginheight="0" marginwidth="0" align="middle" height="150" width="150" scrolling="no" src="icitem_image.cfm?pic3=#urlencodedformat(photo)#"></iframe><br/>Click Picture To Show Original Size
            </cfoutput>
		</td>
    </tr>
    <tr>
		<cfoutput><td>#getgsetup.lgroup# :</td></cfoutput>
        <td colspan='7'>
          <select name='WOS_GROUP'>
            <option value=''>-</option>
            <cfoutput query='getgroup'>
              <option value='#wos_group#'<cfif wos_group eq xwos_group>selected</cfif>>#wos_group# - #desp#</option>
            </cfoutput>
          </select>
        </td>
    </tr>
     <tr>
		<cfoutput><td>#getgsetup.lsize# :</td></cfoutput>
        <td colspan='7'>
          <select name='sizeid'>
            <option value=''>-</option>
            <cfoutput query='getsize'>
              <option value='#sizeid#'<cfif sizeid eq xsizeid>selected</cfif>>#sizeid# - #desp#</option>
            </cfoutput>
          </select>
        </td>
    </tr>
    <tr>
		<cfoutput><td>#getgsetup.lmaterial# :</td></cfoutput>
        <td colspan='7'>
          <select name='COLORID'>
            <option value=''>-</option>
            <cfoutput query='getcolorid'>
              <option value='#colorid#'<cfif colorid eq xcolorid>selected</cfif>>#colorid# - #desp#</option>
            </cfoutput>
          </select>
        </td>
    </tr>
    <tr>
		<cfoutput><td>#getgsetup.lmodel# :</td></cfoutput>
        <td colspan='7'>
          <select name='shelf'>
            <option value=''>-</option>
            <cfoutput query='getshelf'>
              <option value='#shelf#'<cfif shelf eq xshelf>selected</cfif>>#shelf# - #desp#</option>
            </cfoutput>
          </select>
        </td>
    </tr>
    <tr>
		<td>Change Picture :</td>
		<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">
		<td>
			<select name="picture_available" id="picture_available" onChange="javascript:change_picture(this.value);">
				<option value="">-</option>
				<cfoutput query="picture_list">
					<cfif picture_list.name neq "Thumbs.db">
						<option value="#picture_list.name#" #iif((photo eq picture_list.name),DE("selected"),DE(""))#>#picture_list.name#</option>
					</cfif>
				</cfoutput>
			</select>&nbsp;&nbsp;<img name="img1" src="/images/delete.ico" height="15" width="15" onMouseOver="this.style.cursor='hand'" onClick="delete_picture(document.getElementById('picture_available').value);" />
		</td>
        <td>
        <input type="button" name="openuploadphoto" id="openuploadphoto" value="Upload Photo" onClick="ColdFusion.Window.show('uploadphotoAjax');">
        </td>
	</tr>
    <tr>
      <td colspan='10'><hr></td>
    </tr>
    <tr>
      <th colspan='10'><div align='center'><strong>Product Details</strong></div></th>
    </tr>
    <tr align="left">
        <td nowrap>Unit of Measurement :</td>
        <td colspan='7'>
            <select name='UNIT'>
                <option value=''>-</option>
                <cfoutput query='getUnit'>
                	<option value='#Unit#'<cfif Unit eq xUNIT>selected</cfif>>#Unit# - #desp#</option>
                </cfoutput>
            </select>
        </td>
    </tr>
    <cfoutput>
      <tr>
        <td nowrap>Unit Cost Price :</td>
        <td colspan='7'><input name='UCOST' type='text' value='#NumberFormat(UCOST, stDecl_UPrice)#' size='17' maxlength='17'></td>
      </tr>
    </cfoutput>
    <tr>
		<td height='22'>Unit Selling Price :</td>
      	<td colspan='7'>
			<cfinput name='PRICE' type='text' id='PRICE' value='#NumberFormat(PRICE, stDecl_UPrice)#' size='17' maxlength='17'>
		</td>
    </tr>
    <tr>
    <cfif getpin2.h1360 neq 'T'>
    <td height='22'></td>
      <td><cfinput name='PRICE2' type='hidden' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
	<cfelse>
      <td height='22'>Unit Selling Price 2 :</td>
      <td><cfinput name='PRICE2' type='text' value='#NumberFormat(PRICE2, stDecl_UPrice)#' size='17' maxlength='17'></td>
      </cfif>
      </tr>
      <cfoutput>
      <tr>
      <cfif getpin2.h1360 neq 'T'>
      <td nowrap>
            <input name='MURATIO' type='hidden' value='#MURATIO#' size='5' maxlength='5' onKeyUp="calculate_price3('#iDecl_UPrice#');"></td>
        <td><input name='PRICE3' type='hidden' value='#NumberFormat(PRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
	  <cfelse>
        <td nowrap>M.U Ratio :
            <input name='MURATIO' type='text' value='#MURATIO#' size='5' maxlength='5' onKeyUp="calculate_price3('#iDecl_UPrice#');"></td>
        <td><input name='PRICE3' type='text' value='#NumberFormat(PRICE3, stDecl_UPrice)#' size='17' maxlength='17'></td>
        </cfif>
      </tr>
      
      <tr>
    <cfif getpin2.h1360 neq 'T'>
    <td height='22'></td>
      <td><cfinput name='PRICE4' type='hidden' value='#NumberFormat(PRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
	<cfelse>
      <td height='22'>Unit Selling Price 4 :</td>
      <td><cfinput name='PRICE4' type='text' value='#NumberFormat(PRICE4, stDecl_UPrice)#' size='17' maxlength='17'></td>
      </cfif>
      </tr>
      </cfoutput>
	<tr>
      <td colspan='10'><hr></td>
    </tr>
    <cfoutput>
    <tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r4');"><div align='center'><strong>Foreign Price and Cost<img src="../../images/u.gif" name="imgr4" align="center"></strong></div></th>
      	</tr>
		<tr>
        	<td colspan="7">
          		<table style="display:none" id="r4" align="center" width="100%">
      
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
     
     
      </table></td></tr>
    </cfoutput>
    
    <tr>
        	<td colspan='100%'><hr></td>
      	</tr>
        <cfoutput>
      	<tr>
        	<th height='20' colspan='100%' onClick="javascript:shoh('r1');"><div align='center'><strong>
            Remarks<img src="../../images/u.gif" name="imgr1" align="center"></strong></div></th>
      	</tr>
      	<tr>
        	<td colspan="100%">
          		<table style="display:none" id="r1" align="center" width="85%">
            		<tr>
              			<td width='25%' nowrap height='22'>
						<!--- <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
							Foreign Currency Price 1 --->
						<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
							Fixed / Variable
						<cfelse>
							Remark 1
						</cfif> :
						</td>
              			<td width='75%'>
							<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
								<select name="Remark1">
									<option value="F" <cfif Remark1 eq "F">selected</cfif>>Fixed</option>
									<option value="V" <cfif Remark1 eq "V">selected</cfif>>Variable</option>
								</select>
							<cfelse>
								<input name='Remark1' type='text' value='#Remark1#' size='100' maxlength='100' onClick="select();">
							</cfif>						
						</td>
            		</tr>
            		<tr>
              			<td height='22'><cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">Type of Service<cfelse>Remark 2</cfif> :</td>
              			<td>
							<cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
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
							</cfif>
						</td>
            		</tr>
            		<tr>
              			<td height='22'>Remark 3 :</td>
              			<td><input name='Remark3' type='text' value='#Remark3#' size='100' maxlength='100' onClick="select();"></td>
            		</tr>
            		<tr>
              			<td height='22'>Remark 4 :</td>
              			<td><input name='Remark4' type='text' value='#Remark4#' size='100' maxlength='100' onClick="select();"></td>
            		</tr>
            		<tr>
              			<td height='22'>Remark 5 :</td>
              			<td><input name='Remark5' type='text' value='#Remark5#' size='100' maxlength='100' onClick="select();"></td>
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
            
      </tr>
      </cfoutput>
    
    <tr>
      <th colspan='10'><div align='center'><strong>Color</strong></div></th>
    </tr>
	<cfset totcol = 4>
	<cfset totalrecord = 20>
	<cfset totrow = ceiling(totalrecord / totcol)>
	<tr>
		<td colspan="100%">
			<table>
				<cfloop from="1" to="#totrow#" index="i">
				<tr>
					<cfloop from="0" to="#totcol-1#" index="j">
						<cfset thisrecord = i+(j*totrow)>
						<cfif thisrecord LTE totalrecord>
							<cfoutput>
							<td width="10%" align="right">Color #thisrecord#&nbsp;&nbsp;</td>
							<td width="15%">
								<cfif mode eq 'Delete' or mode eq 'Edit'>
									<select name="color#thisrecord#" id="color#thisrecord#">
                						<option value="">-</option>
               							<cfloop query='geticcolor2'>
                							<option value='#colorid2#'<cfif colorid2 eq Evaluate("getitem.color#thisrecord#")>selected</cfif>>#colorid2# - #desp#</option>
                						</cfloop>
            						</select>
								<cfelse>
									<select name="color#thisrecord#" id="color#thisrecord#">
                						<option value="">-</option>
               							<cfloop query='geticcolor2'>
                							<option value='#colorid2#'>#colorid2# - #desp#</option>
                						</cfloop>
            						</select>
								</cfif>
							
							</td>
							</cfoutput>
						</cfif>
					</cfloop>
				</tr>
				</cfloop>
			</table>
		</td>
	</tr>
	
	<tr>
      <td colspan='10'><hr></td>
    </tr>
    <tr>
      <th colspan='10'><div align='center'><strong>Size</strong></div></th>
    </tr>
	<cfloop from="1" to="#totrow#" index="i">
		<tr>
			<cfloop from="0" to="#totcol-1#" index="j">
				<cfset thisrecord = i+(j*totrow)>
				<cfif thisrecord LTE totalrecord>
					<cfoutput>
						<td width="10%" align="right">Size #thisrecord#&nbsp;&nbsp;</td>
						<td width="15%">
							<cfif mode eq 'Delete' or mode eq 'Edit'>
								<input type="text" value="#Evaluate("getitem.size#thisrecord#")#" size="10" id="size#thisrecord#" name="size#thisrecord#">
							<cfelse>
								<input type="text" value="" size="10" id="size#thisrecord#" name="size#thisrecord#">
							</cfif>
						</td>
					</cfoutput>
				</cfif>
			</cfloop>
		</tr>
	</cfloop>
	<tr>
      <td colspan='10'><hr></td>
    </tr>
	<tr>
		<td colspan="5" align="left">
			&nbsp;<input type="checkbox" name="inserthyphen" checked> Insert ' - ' into Item No.
			&nbsp;<input type="checkbox" name="insertcolorsize" checked> Insert (Color/Size) into Item Description			
		</td>
		<td colspan="3">
			&nbsp;<input type="radio" name="sizecolor" value="SC" <cfif sizecolor eq "SC">checked</cfif>>&nbsp;Size and Color
			&nbsp;<input type="radio" name="sizecolor" value="S" <cfif sizecolor eq "S">checked</cfif>>&nbsp;Size Only
			&nbsp;<input type="radio" name="sizecolor" value="C" <cfif sizecolor eq "C">checked</cfif>>&nbsp;Color Only
		</td>
    </tr>
	<tr>
      <td colspan='10'><hr></td>
    </tr>
	<tr>
		<td colspan="10" align="center">
			<input name='submit' type='submit' value='Edit Opening Quantity'>&nbsp;
			<input name='submit' type='submit' value='Generate Item No'>&nbsp;
			<cfoutput><input name='submit' type='submit' value='#button#'></cfoutput>
		</td>
    </tr>
  </table>
</cfform>
<cfajaximport tags="cfform">
<cfwindow center="true" width="600" height="400" name="uploadphotoAjax" refreshOnShow="true"
        title="Create Unit" initshow="false"
        source="/default/maintenance/uploadphoto.cfm" />
</body>
</html>