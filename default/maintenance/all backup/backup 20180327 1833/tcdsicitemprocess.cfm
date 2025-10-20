<cfparam name="status" default="">

<cfset form.photo = form.picture_available>

<cfif form.itemno CONTAINS '"' or form.itemno CONTAINS "'" or form.itemno CONTAINS "?" or form.itemno CONTAINS "@" or form.itemno CONTAINS "&" or form.itemno CONTAINS "," or form.itemno CONTAINS "\" or form.itemno CONTAINS ";" or form.itemno CONTAINS "##">

<h2>Do Not use Symbol ' " # @ & ? , \ ; in Item no</h2>
<cfabort>

</cfif>

<cfquery name='getgsetup' datasource='#dts#'>
  SELECT capall,autolocbf FROM gsetup
</cfquery>

<cfif form.mode eq "Create">
	<cfquery name="checkitemExist" datasource="#dts#">
 	 	SELECT * FROM icitem WHERE itemno = '#form.itemno#' <cfif hcomid eq "polypet_i">OR aitemno='#form.aitemno#'</cfif>
 	 </cfquery>
	
	<cfif checkitemExist.recordcount gt 0>
		<cfoutput><h3><font color="##FF0000">Error, This Item Number ("#form.itemno#")  <cfif hcomid eq "polypet_i">or Product code ("#form.aitemno#")</cfif> has been created already.</font></h3></cfoutput>
		<cfabort>
	</cfif>
	
	<cfif isdefined("form.wqformula")>
		<cfset wqformula = form.wqformula>
	<cfelse>
		<cfset wqformula = 0>
	</cfif>
	
	<cfif isdefined("form.wpformula")>
		<cfset wpformula = form.wpformula>
	<cfelse>
		<cfset wpformula = 0>
	</cfif>
	
	<cfif isdefined("form.price_min")>
		<cfset price_min = form.price_min>
	<cfelse>
		<cfset price_min = ''>
	</cfif>
	
	<cfif isdefined("form.wserialno")>
		<cfset wserialno = form.wserialno>
	<cfelse>
		<cfset wserialno = 'F'>
	</cfif>
	
	<cfquery name="insertitem" datasource="#dts#">
		insert into icitem (itemno,aitemno,desp,despa,comment,brand,category,sizeid,costcode,colorid,wos_group,
		shelf,taxcode, supp,packing,unit,wqformula,wpformula,ucost,price,price2,price3,price4,price5,price6,price_min,minimum,maximum,
		reorder,qty2,qty3,qty4,qty5,qty6,graded,muratio,qtybf,salec,salecsc,salecnc,purc,purprec,stock,wserialno,document,
		remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,nonstkitem,wos_date,
		unit2,factor1,factor2,priceu2,costformula,
		<cfloop from="3" to="6" index="i">
		unit#i#,factoru#i#_a,factoru#i#_b,priceu#i#,
		</cfloop>
		photo,created_by,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,barcode,commlvl,itemtype<cfif isdefined('form.custprice_rate')>,custprice_rate</cfif>,packingdesp1,packingqty1,packingfreeqty1,packingdesp2,packingqty2,packingfreeqty2,packingdesp3,packingqty3,packingfreeqty3,packingdesp4,packingqty4,packingfreeqty4,packingdesp5,packingqty5,packingfreeqty5,packingdesp6,packingqty6,packingfreeqty6,packingdesp7,packingqty7,packingfreeqty7,packingdesp8,packingqty8,packingfreeqty8,packingdesp9,packingqty9,packingfreeqty9,packingdesp10,packingqty10,packingfreeqty10,releasedate)
		
		values ('#trim(itemno)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#aitemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#despa#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#comment#">,'#brand#','#category#','#sizeid#','#costcode#','#colorid#',
		'#wos_group#','#jsstringformat(shelf)#',"#form.taxcode#",'#supp#','#packing#','#unit#','#wqformula#','#wpformula#','#val(ucost)#','#val(price)#','#val(price2)#',
		'#val(price3)#','#val(price4)#','#val(price5)#','#val(price6)#','#val(price_min)#','#val(minimum)#','#val(maximum)#','#val(reorder)#','#val(qty2)#','#val(qty3)#','#val(qty4)#','#val(qty5)#','#val(qty6)#','#graded#',
		'#val(muratio)#','#val(qtybf)#','#salec#','#salecsc#','#salecnc#','#purc#','#purprec#','#stock#','#wserialno#',<cfif isdefined('form.document_available')>'#form.document_available#'<cfelse>''</cfif>,'#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',
		'<cfif isdefined("form.nonstkitem")>#form.nonstkitem#<cfelse></cfif>','#dateformat(now(),"yyyy-mm-dd")#',
		'#unit2#','#FACTOR1#','#FACTOR2#','#PRICEU2#','#costformula#',
		<cfloop from="3" to="6" index="i">
			'#Evaluate("form.unit#i#")#','#Evaluate("form.factoru#i#_a")#','#Evaluate("form.factoru#i#_b")#','#Evaluate("form.priceu#i#")#',
		</cfloop>
		'#jsstringformat(form.photo)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.barcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comm#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemtype#"><cfif isdefined('form.custprice_rate')>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprice_rate#"></cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp1#">,"#val(packingqty1)#","#val(packingfreeqty1)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp2#">,"#val(packingqty2)#","#val(packingfreeqty2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp3#">,"#val(packingqty3)#","#val(packingfreeqty3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp4#">,"#val(packingqty4)#","#val(packingfreeqty4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp5#">,"#val(packingqty5)#","#val(packingfreeqty5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp6#">,"#val(packingqty6)#","#val(packingfreeqty6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp7#">,"#val(packingqty7)#","#val(packingfreeqty7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp8#">,"#val(packingqty8)#","#val(packingfreeqty8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp9#">,"#val(packingqty9)#","#val(packingfreeqty9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp10#">,"#val(packingqty10)#","#val(packingfreeqty10)#",<cfif form.releasedate eq ''>'0000-00-00'<cfelse>'#dateformat(createdate(right(form.releasedate,4),mid(form.releasedate,4,2),left(form.releasedate,2)),'yyyy-mm-dd')#'</cfif>)
	</cfquery>
	
	<cfif graded eq "Y">
		<cfinsert datasource="#dts#" tablename="itemgrd" formfields="itemno">
	</cfif>
	
    <cfif getgsetup.autolocbf eq "Y">
    <cfquery name="getlocation" datasource="#dts#">
    select * from iclocation
    </cfquery>
    
    <cfloop query="getlocation">
    
    <cfquery name="insertlocqdbf" datasource="#dts#">
    insert into locqdbf (itemno,location) values ('#trim(itemno)#','#getlocation.location#')
    </cfquery>
    
    </cfloop>
    
    </cfif>
    
	<cfif hcomid eq "fincom_i">
		<cfquery name="insert_from_special_item_price" datasource="#dts#">
			insert ignore into special_item_price 
			(
				itemno,
				custno,
				description
			)
			values 
			(
				'#jsstringformat(preservesinglequotes(form.itemno))#',
				'#jsstringformat(preservesinglequotes(form.supp))#',
				'#jsstringformat(preservesinglequotes(form.desp))#'
			)
		</cfquery>
	</cfif>
	
	<cfset status="The Item, #form.itemno# had been successfully created.">
	
<cfelse>
	<cfquery name="checkitemExist" datasource="#dts#">
		select * from icitem where itemno='#form.itemno#'
	</cfquery>
	
	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
			<cfquery name="checktranexist" datasource="#dts#">
				select itemno,refno,type from ictran where itemno = '#form.itemno#'
			</cfquery>
            
            <cfquery name="checktranexist2" datasource="#dts#">
				select ifnull(sum(locqfield),0) as qty from locqdbf where itemno = '#form.itemno#'
			</cfquery>
			
			<cfif checktranexist.recordcount gt 0 or val(checktranexist2.qty) gt 0>
				<h3>You have created transaction <cfoutput>#checktranexist.type# :#checktranexist.refno#</cfoutput> for this item / There is location quantity for this item. You are not allowed to delete this item.</h3>					
				<cfabort>
			</cfif>
			
			<!--- ADD ON 290908, Delete Grade --->
			<cfquery name="deleteitemgrd" datasource='#dts#'>
				Delete from itemgrd where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
			
			<cfquery name="deletelogrdob" datasource='#dts#'>
				Delete from logrdob where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
			
			<cfquery name="deleterelateditem1" datasource='#dts#'>
				Delete from relitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
			
			<cfquery name="deleterelateditem1" datasource='#dts#'>
				Delete from relitem where relitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
			
			<!--- ADD ON 26-10-2009, KEEP TRACK THE DELETED RECORD --->
			<cfquery name="insert_audittrail" datasource="#dts#">
				insert into deleted_icitem ( 
				  `EDI_ID`,
				  `ITEMNO`,
				  `AITEMNO`,
				  `MITEMNO`,
				  `SHORTCODE`,
				  `DESP`,
				  `DESPA`,
				  `BRAND`,
				  `CATEGORY`,
				  `WOS_GROUP`,
				  `SHELF`,
				  `SUPP`,
				  `PACKING`,
				  `WEIGHT`,
				  `COSTCODE`,
				  `UNIT`,
				  `UCOST`,
				  `PRICE`,
				  `PRICE2`,
				  `PRICE3`,
				  `PRICE_MIN`,
				  `MINIMUM`,
				  `MAXIMUM`,
				  `REORDER`,
				  `UNIT2`,
				  `COLORID`,
				  `SIZEID`,
				  `FACTOR1`,
				  `FACTOR2`,
				  `PRICEU2`,
				  `UNIT3`,
				  `FACTORU3_A`,
				  `FACTORU3_B`,
				  `PRICEU3`,
				  `UNIT4`,
				  `FACTORU4_A`,
				  `FACTORU4_B`,
				  `PRICEU4`,
				  `UNIT5`,
				  `FACTORU5_A`,
				  `FACTORU5_B`,
				  `PRICEU5`,
				  `UNIT6`,
				  `FACTORU6_A`,
				  `FACTORU6_B`,
				  `PRICEU6`,
				  `DISPEC_A1`,
				  `DISPEC_A2`,
				  `DISPEC_A3`,
				  `DISPEC_B1`,
				  `DISPEC_B2`,
				  `DISPEC_B3`,
				  `DISPEC_C1`,
				  `DISPEC_C2`,
				  `DISPEC_C3`,
				  `PRICE_CATA`,
				  `PRICE_CATB`,
				  `PRICE_CATC`,
				  `COST_CATA`,
				  `COST_CATB`,
				  `COST_CATC`,
				  `QTY2`,
				  `QTY3`,
				  `QTY4`,
				  `QTY5`,
				  `QTY6`,
				  `WQFORMULA`,
				  `WPFORMULA`,
				  `GRADED`,
				  `MURATIO`,
				  `QTYBF`,
				  `QTYNET`,
				  `QTYACTUAL`,
				  `AVCOST`,
				  `AVCOST2`,
				  `BOM_COST`,
				  `TQ_OBAL`,
				  `TQ_IN`,
				  `TQ_OUT`,
				  `TQ_CBAL`,
				  `T_UCOST`,
				  `T_STKV`,
				  `TQ_INV`,
				  `TQ_CS`,
				  `TQ_CN`,
				  `TQ_DN`,
				  `TQ_RC`,
				  `TQ_PR`,
				  `TQ_ISS`,
				  `TQ_OAI`,
				  `TQ_OAR`,
				  `TA_INV`,
				  `TA_CS`,
				  `TA_CN`,
				  `TA_DN`,
				  `TA_RC`,
				  `TA_PR`,
				  `TA_ISS`,
				  `TA_OAI`,
				  `TA_OAR`,
				  `QIN11`,
				  `QIN12`,
				  `QIN13`,
				  `QIN14`,
				  `QIN15`,
				  `QIN16`,
				  `QIN17`,
				  `QIN18`,
				  `QIN19`,
				  `QIN20`,
				  `QIN21`,
				  `QIN22`,
				  `QIN23`,
				  `QIN24`,
				  `QIN25`,
				  `QIN26`,
				  `QIN27`,
				  `QIN28`,
				  `QOUT11`,
				  `QOUT12`,
				  `QOUT13`,
				  `QOUT14`,
				  `QOUT15`,
				  `QOUT16`,
				  `QOUT17`,
				  `QOUT18`,
				  `QOUT19`,
				  `QOUT20`,
				  `QOUT21`,
				  `QOUT22`,
				  `QOUT23`,
				  `QOUT24`,
				  `QOUT25`,
				  `QOUT26`,
				  `QOUT27`,
				  `QOUT28`,
				  `SALEC`,
				  `SALECSC`,
				  `SALECNC`,
				  `PURC`,
				  `PURPREC`,
                  
				  `TEMPFIG`,
				  `TEMPFIG1`,
				  `CT_RATING`,
				  `POINT`,
				  `QCPOINT`,
				  `AWARD1`,
				  `AWARD2`,
				  `AWARD3`,
				  `AWARD4`,
				  `AWARD5`,
				  `AWARD6`,
				  `AWARD7`,
				  `AWARD8`,
				  `REMARK1`,
				  `REMARK2`,
				  `REMARK3`,
				  `REMARK4`,
				  `REMARK5`,
				  `REMARK6`,
				  `REMARK7`,
				  `REMARK8`,
				  `REMARK9`,
				  `REMARK10`,
				  `REMARK11`,
				  `REMARK12`,
				  `REMARK13`,
				  `REMARK14`,
				  `REMARK15`,
				  `REMARK16`,
				  `REMARK17`,
				  `REMARK18`,
				  `REMARK19`,
				  `REMARK20`,
				  `REMARK21`,
				  `REMARK22`,
				  `REMARK23`,
				  `REMARK24`,
				  `REMARK25`,
				  `REMARK26`,
				  `REMARK27`,
				  `REMARK28`,
				  `REMARK29`,
				  `REMARK30`,
				  `COMMRATE1`,
				  `COMMRATE2`,
				  `COMMRATE3`,
				  `COMMRATE4`,
				  `WOS_DATE`,
				  `QTYDEC`,
				  `TEMP_QTY`,
				  `QTY`,
				  `PHOTO`,
				  `COMPEC_A`,
				  `COMPEC_B`,
				  `COMPEC_C`,
				  `WOS_TIME`,
				  `EXPIRED`,
				  `WSERIALNO`,
				  `PROMOTOR`,
				  `TAXABLE`,
				  `TAXPERC1`,
				  `TAXPERC2`,
				  `NONSTKITEM`,
				  `GRAPHIC`,
				  `PRODCODE`,
				  `BRK_TO`,
				  `COLOR`,
				  `SIZE`,
				  `qtybf_actual`, 
				  `CREATED_BY`,
				  `CREATED_ON`,
				  `UPDATED_BY`,
				  `UPDATED_ON`,
				  `DELETED_BY`,
				  `DELETED_ON`)
				select 
				  a.EDI_ID,
				  a.ITEMNO,
				  a.AITEMNO,
				  a.MITEMNO,
				  a.SHORTCODE,
				  a.DESP,
				  a.DESPA,
				  a.BRAND,
				  a.CATEGORY,
				  a.WOS_GROUP,
				  a.SHELF,
				  a.SUPP,
				  a.PACKING,
				  a.WEIGHT,
				  a.COSTCODE,
				  a.UNIT,
				  a.UCOST,
				  a.PRICE,
				  a.PRICE2,
				  a.PRICE3,
				  a.PRICE_MIN,
				  a.MINIMUM,
				  a.MAXIMUM,
				  a.REORDER,
				  a.UNIT2,
				  a.COLORID,
				  a.SIZEID,
				  a.FACTOR1,
				  a.FACTOR2,
				  a.PRICEU2,
				  a.UNIT3,
				  a.FACTORU3_A,
				  a.FACTORU3_B,
				  a.PRICEU3,
				  a.UNIT4,
				  a.FACTORU4_A,
				  a.FACTORU4_B,
				  a.PRICEU4,
				  a.UNIT5,
				  a.FACTORU5_A,
				  a.FACTORU5_B,
				  a.PRICEU5,
				  a.UNIT6,
				  a.FACTORU6_A,
				  a.FACTORU6_B,
				  a.PRICEU6,
				  a.DISPEC_A1,
				  a.DISPEC_A2,
				  a.DISPEC_A3,
				  a.DISPEC_B1,
				  a.DISPEC_B2,
				  a.DISPEC_B3,
				  a.DISPEC_C1,
				  a.DISPEC_C2,
				  a.DISPEC_C3,
				  a.PRICE_CATA,
				  a.PRICE_CATB,
				  a.PRICE_CATC,
				  a.COST_CATA,
				  a.COST_CATB,
				  a.COST_CATC,
				  a.QTY2,
				  a.QTY3,
				  a.QTY4,
				  a.QTY5,
				  a.QTY6,
				  a.WQFORMULA,
				  a.WPFORMULA,
				  a.GRADED,
				  a.MURATIO,
				  a.QTYBF,
				  a.QTYNET,
				  a.QTYACTUAL,
				  a.AVCOST,
				  a.AVCOST2,
				  a.BOM_COST,
				  a.TQ_OBAL,
				  a.TQ_IN,
				  a.TQ_OUT,
				  a.TQ_CBAL,
				  a.T_UCOST,
				  a.T_STKV,
				  a.TQ_INV,
				  a.TQ_CS,
				  a.TQ_CN,
				  a.TQ_DN,
				  a.TQ_RC,
				  a.TQ_PR,
				  a.TQ_ISS,
				  a.TQ_OAI,
				  a.TQ_OAR,
				  a.TA_INV,
				  a.TA_CS,
				  a.TA_CN,
				  a.TA_DN,
				  a.TA_RC,
				  a.TA_PR,
				  a.TA_ISS,
				  a.TA_OAI,
				  a.TA_OAR,
				  a.QIN11,
				  a.QIN12,
				  a.QIN13,
				  a.QIN14,
				  a.QIN15,
				  a.QIN16,
				  a.QIN17,
				  a.QIN18,
				  a.QIN19,
				  a.QIN20,
				  a.QIN21,
				  a.QIN22,
				  a.QIN23,
				  a.QIN24,
				  a.QIN25,
				  a.QIN26,
				  a.QIN27,
				  a.QIN28,
				  a.QOUT11,
				  a.QOUT12,
				  a.QOUT13,
				  a.QOUT14,
				  a.QOUT15,
				  a.QOUT16,
				  a.QOUT17,
				  a.QOUT18,
				  a.QOUT19,
				  a.QOUT20,
				  a.QOUT21,
				  a.QOUT22,
				  a.QOUT23,
				  a.QOUT24,
				  a.QOUT25,
				  a.QOUT26,
				  a.QOUT27,
				  a.QOUT28,
				  a.SALEC,
				  a.SALECSC,
				  a.SALECNC,
				  a.PURC,
				  a.PURPREC,
                  
				  a.TEMPFIG,
				  a.TEMPFIG1,
				  a.CT_RATING,
				  a.POINT,
				  a.QCPOINT,
				  a.AWARD1,
				  a.AWARD2,
				  a.AWARD3,
				  a.AWARD4,
				  a.AWARD5,
				  a.AWARD6,
				  a.AWARD7,
				  a.AWARD8,
				  a.REMARK1,
				  a.REMARK2,
				  a.REMARK3,
				  a.REMARK4,
				  a.REMARK5,
				  a.REMARK6,
				  a.REMARK7,
				  a.REMARK8,
				  a.REMARK9,
				  a.REMARK10,
				  a.REMARK11,
				  a.REMARK12,
				  a.REMARK13,
				  a.REMARK14,
				  a.REMARK15,
				  a.REMARK16,
				  a.REMARK17,
				  a.REMARK18,
				  a.REMARK19,
				  a.REMARK20,
				  a.REMARK21,
				  a.REMARK22,
				  a.REMARK23,
				  a.REMARK24,
				  a.REMARK25,
				  a.REMARK26,
				  a.REMARK27,
				  a.REMARK28,
				  a.REMARK29,
				  a.REMARK30,
				  a.COMMRATE1,
				  a.COMMRATE2,
				  a.COMMRATE3,
				  a.COMMRATE4,
				  a.WOS_DATE,
				  a.QTYDEC,
				  a.TEMP_QTY,
				  a.QTY,
				  a.PHOTO,
				  a.COMPEC_A,
				  a.COMPEC_B,
				  a.COMPEC_C,
				  a.WOS_TIME,
				  a.EXPIRED,
				  a.WSERIALNO,
				  a.PROMOTOR,
				  a.TAXABLE,
				  a.TAXPERC1,
				  a.TAXPERC2,
				  a.NONSTKITEM,
				  a.GRAPHIC,
				  a.PRODCODE,
				  a.BRK_TO,
				  a.COLOR,
				  a.SIZE,
				  a.qtybf_actual, 
				  a.CREATED_BY,
				  a.CREATED_ON,
				  a.UPDATED_BY,
				  a.UPDATED_ON,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,now()
				from icitem as a
				where a.itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
					
			<cfquery name="deleteitem" datasource='#dts#'>
				Delete from icitem where itemno='#form.itemno#'
			</cfquery>
            
            <cfquery name="deleteprice" datasource="#dts#">
            	Delete from icl3p2 where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
            </cfquery>
            
            <cfquery name="deleteprice1" datasource="#dts#">
            	Delete from icl3p where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
            </cfquery>
			
			<cfif hcomid eq "fincom_i">
				<cfquery name="delete_from_special_item_price" datasource="#dts#">
					delete from special_item_price 
					where itemno='#jsstringformat(preservesinglequotes(form.itemno))#';
				</cfquery>
			</cfif>
			
			<cfset status="The Item, #form.itemno# had been successfully deleted. ">	
		</cfif>
				
		<cfif form.mode eq "Edit">
			<cfloop from="3" to="6" index="i">
				<cfif i eq 3>
					<cfset columname = "UNIT"&i&",FACTORU"&i&"_A"&",FACTORU"&i&"_B"&",PRICEU"&i>
				<cfelse>
					<cfset columname = columname&",UNIT"&i&",FACTORU"&i&"_A"&",FACTORU"&i&"_B"&",PRICEU"&i>
				</cfif>
			</cfloop>
			<!--- <cfoutput>#columname#</cfoutput><cfabort> --->
			<!--- <cfupdate datasource='#dts#' tablename="icitem" formfields="edi_id,itemno,aitemno,desp,despa,brand,category,sizeid,
			costcode,colorid,wos_group,shelf,supp,packing,unit,wpformula,wqformula,ucost,price,price2,price3,price_min,minimum,
			maximum,reorder,qty2,qty3,qty4,qty5,qty6,graded,muratio,qtybf,salec,salecsc,salecnc,purc,purprec,wserialno,remark1,
			remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,remark13,remark14,remark15,
			remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,remark24,remark25,remark26,remark27,remark28,
			remark29,remark30,nonstkitem,photo,unit2,priceu2,factor1,factor2,#columname#"> --->
			<cfquery name="updateicitem" datasource="#dts#">
				UPDATE icitem
				SET aitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aitemno#">,
				desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
				despa=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.despa#">,
                comment=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comment#">,
				brand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brand#">,
				category=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
				sizeid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sizeid#">,
				costcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.costcode#">,
				colorid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.colorid#">,
				wos_group=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wos_group#">,
				shelf=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.shelf#">,
                taxcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
				supp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.supp)#">,
				packing=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packing#">,
				unit=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.unit#">,
				wpformula=<cfif isdefined("form.wpformula")>'1'<cfelse>''</cfif>,
				wqformula=<cfif isdefined("form.wqformula")>'1'<cfelse>''</cfif>,
                costformula=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.costformula#">,
				ucost='#val(form.ucost)#',price='#val(form.price)#',price2='#val(form.price2)#',price3='#val(form.price3)#',price4='#val(form.price4)#',price5='#val(form.price5)#',price6='#val(form.price6)#',
				price_min='#val(form.price_min)#',minimum='#val(form.minimum)#',maximum='#val(form.maximum)#',reorder='#val(form.reorder)#',
				qty2='#val(form.qty2)#',qty3='#val(form.qty3)#',qty4='#val(form.qty4)#',qty5='#val(form.qty5)#',qty6='#val(form.qty6)#',
				graded='#form.graded#',
				muratio='#val(form.muratio)#',
				qtybf='#val(form.qtybf)#',
				salec='#form.salec#',
				salecsc='#form.salecsc#',
				salecnc='#form.salecnc#',
				purc='#form.purc#',
				purprec='#form.purprec#',
                stock='#form.stock#',
				wserialno=<cfif isdefined("form.wserialno")>'T'<cfelse>''</cfif>,
				<cfloop from="1" to="30" index="x">
					remark#x#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["remark#x#"]#">,
				</cfloop>
				nonstkitem=<cfif isdefined("form.nonstkitem")>'T'<cfelse>''</cfif>,
				photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.photo#">,
                document=<cfif isdefined('form.document_available')> <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.document_available#"><cfelse>''</cfif>,
				factor1='#val(form.factor1)#',factor2='#val(form.factor2)#',
				unit2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.unit2#">,priceu2='#val(form.priceu2)#',
				<cfloop from="3" to="6" index="y">
					unit#y#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["unit#y#"]#">,
					factoru#y#_a='#val(form["factoru#y#_a"])#',
					factoru#y#_b='#val(form["factoru#y#_b"])#',
					priceu#y#='#val(form["priceu#y#"])#',
				</cfloop>
                fcurrcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,
                fucost="#val(form.fucost)#",
                fprice="#val(form.fprice)#",
                fcurrcode2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,
                fucost2="#val(form.fucost2)#",
                fprice2="#val(form.fprice2)#",
                fcurrcode3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,
                fucost3="#val(form.fucost3)#",
                fprice3="#val(form.fprice3)#",
                fcurrcode4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,
                fucost4="#val(form.fucost4)#",
                fprice4="#val(form.fprice4)#",
                fcurrcode5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,
                fucost5="#val(form.fucost5)#",
                fprice5="#val(form.fprice5)#",
                fcurrcode6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,
                fucost6="#val(form.fucost6)#",
                fprice6="#val(form.fprice6)#",
                fcurrcode7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,
                fucost7="#val(form.fucost7)#",
                fprice7="#val(form.fprice7)#",
                fcurrcode8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,
                fucost8="#val(form.fucost8)#",
                fprice8="#val(form.fprice8)#",
                fcurrcode9=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,
                fucost9="#val(form.fucost9)#",
                fprice9="#val(form.fprice9)#",
                fcurrcode10=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,
                fucost10="#val(form.fucost10)#",
                fprice10="#val(form.fprice10)#",
                packingdesp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp1#">,
                packingqty1="#val(packingqty1)#",
                packingfreeqty1="#val(packingfreeqty1)#",
                packingdesp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp2#">,
                packingqty2="#val(packingqty2)#",
                packingfreeqty2="#val(packingfreeqty2)#",
                packingdesp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp3#">,
                packingqty3="#val(packingqty3)#",
                packingfreeqty3="#val(packingfreeqty3)#",
                packingdesp4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp4#">,
                packingqty4="#val(packingqty4)#",
                packingfreeqty4="#val(packingfreeqty4)#",
                packingdesp5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp5#">,
                packingqty5="#val(packingqty5)#",
                packingfreeqty5="#val(packingfreeqty5)#",
                packingdesp6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp6#">,
                packingqty6="#val(packingqty6)#",
                packingfreeqty6="#val(packingfreeqty6)#",
                packingdesp7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp7#">,
                packingqty7="#val(packingqty7)#",
                packingfreeqty7="#val(packingfreeqty7)#",
                packingdesp8=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp8#">,
                packingqty8="#val(packingqty8)#",
                packingfreeqty8="#val(packingfreeqty8)#",
                packingdesp9=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp9#">,
                packingqty9="#val(packingqty9)#",
                packingfreeqty9="#val(packingfreeqty9)#",
                packingdesp10=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.packingdesp10#">,
                packingqty10="#val(packingqty10)#",
                packingfreeqty10="#val(packingfreeqty10)#",
                barcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.barcode#">,
                <cfif isdefined('form.custprice_rate')>custprice_rate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custprice_rate#">,</cfif>
                commlvl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comm#">,
                itemtype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemtype#">,
                releasedate = <cfif form.releasedate eq ''>'0000-00-00'<cfelse>'#dateformat(createdate(right(form.releasedate,4),mid(form.releasedate,4,2),left(form.releasedate,2)),'yyyy-mm-dd')#'</cfif>,
				updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
				updated_on=now()
				WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
			</cfquery>
			<cfset status="The Item, #form.itemNo# had been successfully edited. ">
			
			<cfif graded eq "Y">
				<cftry>
					<cfinsert datasource="#dts#" tablename="itemgrd" formfields="itemno">
					<cfcatch type="database"></cfcatch>
				</cftry>
			</cfif>
			
			<cfif hcomid eq "fincom_i">
				<cfquery name="edit_special_item_price" datasource="#dts#">
					update special_item_price set 
					custno='#jsstringformat(preservesinglequotes(form.supp))#',
					description='#jsstringformat(preservesinglequotes(form.desp))#'
					where itemno='#jsstringformat(preservesinglequotes(form.itemno))#';
				</cfquery>
			</cfif>
		</cfif>				
	<cfelse>		
		<cfset status="Sorry, the Item, #form.itemNo# was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>
<!---Get the messaged to be passed into the view user page. (vUser.cfm) --->

<cfif hcomid eq "tcds_i">
<cfquery name="getsizeid" datasource="#dts#">
select size1 from icsizeid where sizeid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sizeid#">
</cfquery>

<cfquery name="updateremark1" datasource="#dts#">
update icitem set remark1='#getsizeid.size1#' where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
</cfquery>

</cfif>

<cfoutput>
	<cfif isdefined("form.relitem") and form.mode neq "Delete">
		<form name="done" action="addrelateditem.cfm?itemno=#form.itemno#" method="post">
			<input name="status" value="#status#" type="hidden">
		</form>
	<cfelse>
		<form name="done" action="s_icitem.cfm?type=icitem&process=done" method="post">
			<input name="status" value="#status#" type="hidden">
		</form>
	</cfif>
</cfoutput>

<cfif getgsetup.capall eq 'Y'>
<cfquery name="updateallitemtocap" datasource="#dts#">
update icitem set itemno=ucase(itemno),desp=ucase(desp),despa=ucase(despa),comment=ucase(comment),aitemno=ucase(aitemno),barcode=ucase(barcode) where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">
</cfquery>
</cfif>

<script language="javascript" type="text/javascript">
<cfif isdefined('form.express')>
<cfif form.express eq 1>
opener.document.invoicesheet.expressservicelist.value = <cfoutput>'#form.itemno#'</cfoutput>;
opener.document.invoicesheet.expressservicelist.focus();
</cfif>
<cfif form.express eq 2>
<cfoutput>window.opener.updateitemno('#form.itemno#','#form.desp#');</cfoutput>
</cfif>
window.close();

<cfelseif isdefined('form.ovasexpress')>
<cfoutput>window.opener.updateitem('#form.itemno#','#form.desp#');</cfoutput>
</cfif>	
done.submit();
</script>