<cfparam name="status" default="">
<cfset form.photo = form.picture_available>

<cfif submit eq 'Edit Opening Quantity' or submit eq 'Generate Item No'>
	
	<cfquery datasource='#dts#' name="checkitemExist">
	 	Select * from icmitem 
	 	where mitemno = '#form.mitemno#'
 	</cfquery>

	<cfif checkitemExist.recordcount gt 0>
		<cfquery name="update" datasource="#dts#">
			update icmitem
			set desp = '#form.desp#',
			despa = '#form.despa#',
			aitemno = '#form.AITEMNO#',
			unit = '#form.UNIT#',
			ucost = '#val(form.UCOST)#',
			price = '#form.PRICE#',
            price2 = '#val(form.price2)#',
            price3 = '#val(form.price3)#',
            price4 = '#val(form.price4)#',
            muratio = '#val(form.muratio)#',
			category = '#form.CATEGORY#',
			wos_group = '#form.WOS_GROUP#',
            sizeid = '#form.sizeid#',
            colorid = '#form.colorid#',
            shelf = '#form.shelf#',
            photo = '#form.photo#',
			brand = '#form.BRAND#',
			supp = '#form.supp#',
			colorno = '#form.colorno#',
			sizecolor = '#form.sizecolor#',
            <cfloop from="1" to="30" index="x">
					remark#x#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["remark#x#"]#">,
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
			<cfloop from="1" to="20" index="i">
				color#i# = '#form["color#i#"]#',
				size#i# = '#form["size#i#"]#',
			</cfloop>
			updated_by = '#HUserID#',
			updated_on = #now()#
			where mitemno = '#form.mitemno#'
		</cfquery>
		<!--- <cfset status="The Matrix Item, #form.mitemno# had been successfully edited. "> --->
	<cfelse>
		<cfquery name="insert" datasource="#dts#">
			insert into icmitem
			(mitemno,desp,despa,aitemno,unit,ucost,price,category,wos_group,brand,supp,colorno,sizecolor,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,
			<cfloop from="1" to="20" index="i">
				color#i#,size#i#,
			</cfloop>
			created_by,created_on,updated_by,updated_on 
			)
			values
			('#form.mitemno#','#form.desp#','#form.despa#','#form.AITEMNO#','#form.UNIT#','#val(form.UCOST)#','#form.PRICE#',
			'#form.CATEGORY#','#form.WOS_GROUP#','#form.BRAND#','#form.supp#','#form.colorno#','#form.sizecolor#','#form.sizeid#','#form.colorid#','#form.shelf#','#form.photo#','#val(form.price2)#','#val(form.price3)#','#val(form.price4)#','#val(form.muratio)#','#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",
			<cfloop from="1" to="20" index="i">
				'#form["color#i#"]#','#form["size#i#"]#',
			</cfloop>
			'#HUserID#',#now()#,'#HUserID#',#now()#
			)
		</cfquery>
		<!--- <cfset status="The Matrix Item, #form.mitemno# had been successfully created. "> --->
	</cfif>
	
	<cfset counter = 0>
	<cfif form.sizecolor eq "SC">
		<cfloop from="1" to="20" index="i">
			<cfset thiscolor = Evaluate("form.color#i#")>
			<cfif thiscolor neq "">
				<cfloop from="1" to="20" index="j">
					<cfset thissize = Evaluate("form.size#j#")>
					<cfif thissize neq "">
						<cfif isdefined("form.inserthyphen") and form.inserthyphen eq "on">
							<cfset thisitemno = form.mitemno&'-'&thiscolor&'-'&thissize>
						<cfelse>
							<cfset thisitemno = form.mitemno&thiscolor&thissize>
						</cfif>
						<cfquery name="checkitemExist1" datasource="#dts#">
 	 						select * from icitem where itemno = '#thisitemno#' 
 	 					</cfquery>
						<cfif checkitemExist1.recordcount eq 0>
							<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
								<cfset thisdesp = form.desp&' ('&thiscolor&'/'&thissize&')'>
							<cfelse>
								<cfset thisdesp = form.desp>
							</cfif>
						
							<cfquery name="insertitem" datasource="#dts#">
								insert into icitem 
								(itemno,aitemno,desp,despa,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate)
								values 
								('#thisitemno#','#form.AITEMNO#','#thisdesp#','#form.despa#','#form.BRAND#','#form.CATEGORY#','#form.WOS_GROUP#',
								'#form.UNIT#','#val(form.UCOST)#','#form.PRICE#','#form.supp#','#form.sizeid#','#form.colorid#','#form.shelf#','#form.photo#','#val(form.price2)#','#val(form.price3)#','#val(form.price4)#','#val(form.muratio)#','#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",'normal')
							</cfquery>
							<cfset counter = counter + 1>
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>
	<cfelseif form.sizecolor eq "S">
		<cfloop from="1" to="20" index="j">
			<cfset thissize = form["size#j#"]>
			<cfif thissize neq "">
				<cfif isdefined("form.inserthyphen") and form.inserthyphen eq "on">
					<cfset thisitemno = form.mitemno&'-'&thissize>
				<cfelse>
					<cfset thisitemno = form.mitemno&thissize>
				</cfif>
				<cfquery name="checkitemExist1" datasource="#dts#">
 	 				select * from icitem where itemno = '#thisitemno#' 
 	 			</cfquery>
				<cfif checkitemExist1.recordcount eq 0>
					<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
						<cfset thisdesp = form.desp&' ('&thissize&')'>
					<cfelse>
						<cfset thisdesp = form.desp>
					</cfif>
						
					<cfquery name="insertitem" datasource="#dts#">
						insert into icitem 
						(itemno,aitemno,desp,despa,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate)
						values 
						('#thisitemno#','#form.AITEMNO#','#thisdesp#','#form.despa#','#form.BRAND#','#form.CATEGORY#','#form.WOS_GROUP#',
						'#form.UNIT#','#val(form.UCOST)#','#form.PRICE#','#form.supp#','#form.sizeid#','#form.colorid#','#form.shelf#','#form.photo#','#val(form.price2)#','#val(form.price3)#','#val(form.price4)#','#val(form.muratio)#','#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",'normal')
					</cfquery>
					<cfset counter = counter + 1>
				</cfif>
			</cfif>
		</cfloop>
	<cfelse>
		<cfloop from="1" to="20" index="j">
			<cfset thiscolor = form["color#j#"]>
			<cfif thiscolor neq "">
				<cfif isdefined("form.inserthyphen") and form.inserthyphen eq "on">
					<cfset thisitemno = form.mitemno&'-'&thiscolor>
				<cfelse>
					<cfset thisitemno = form.mitemno&thiscolor>
				</cfif>
				<cfquery name="checkitemExist1" datasource="#dts#">
 	 				select * from icitem where itemno = '#thisitemno#' 
 	 			</cfquery>
				<cfif checkitemExist1.recordcount eq 0>
					<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
						<cfset thisdesp = form.desp&' ('&thiscolor&')'>
					<cfelse>
						<cfset thisdesp = form.desp>
					</cfif>
						
					<cfquery name="insertitem" datasource="#dts#">
						insert into icitem 
						(itemno,aitemno,desp,despa,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate)
						values 
						('#thisitemno#','#form.AITEMNO#','#thisdesp#','#form.despa#','#form.BRAND#','#form.CATEGORY#','#form.WOS_GROUP#',
						'#form.UNIT#','#val(form.UCOST)#','#form.PRICE#','#form.supp#','#form.sizeid#','#form.colorid#','#form.shelf#','#form.photo#','#val(form.price2)#','#val(form.price3)#','#val(form.price4)#','#val(form.muratio)#','#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",'normal')
					</cfquery>
					<cfset counter = counter + 1>
				</cfif>
			</cfif>
		</cfloop>
	</cfif>
	
	<cfif isdefined("form.inserthyphen") and form.inserthyphen eq "on">
		<cfset inserthyphen = 1>
	<cfelse>
		<cfset inserthyphen = 0>
	</cfif>
	<cfset status="No. Of Record Generated: #counter# ">
	<cfif submit eq 'Edit Opening Quantity' and counter eq 0>
		<cfset status= "">
	</cfif>
<cfelse>
	<cfif form.mode eq "Create">
		<cfquery datasource='#dts#' name="checkitemExist">
	 	 	Select * from icmitem 
	 		where mitemno = '#form.mitemno#'
 		</cfquery>
  	
		<cfif checkitemExist.recordcount gt 0 >
			<cfoutput>
      			<h3><font color="##FF0000">Error, This Matrix Item No. ("#form.mitemno#") Already Exist.</font></h3>
				<script language="javascript" type="text/javascript">
					alert("Error, This record #form.mitemno# Already Exist.");
					javascript:history.back();
					javascript:history.back();
				</script>
	    	</cfoutput> 
    		<cfabort>
		</cfif>
	
		<cfquery name="insert" datasource="#dts#">
			insert into icmitem
			(mitemno,desp,despa,aitemno,unit,ucost,price,category,wos_group,brand,supp,colorno,sizecolor,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
		remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
		remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,
			<cfloop from="1" to="20" index="i">
				color#i#,size#i#,
			</cfloop>
			created_by,created_on,updated_by,updated_on 
			)
			values
			('#form.mitemno#','#form.desp#','#form.despa#','#form.AITEMNO#','#form.UNIT#','#val(form.UCOST)#','#form.PRICE#',
			'#form.CATEGORY#','#form.WOS_GROUP#','#form.BRAND#','#form.supp#','#form.colorno#','#form.sizecolor#','#form.sizeid#','#form.colorid#','#form.shelf#','#form.photo#','#val(form.price2)#','#val(form.price3)#','#val(form.price4)#','#val(form.muratio)#','#remark1#','#remark2#',
		'#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
		'#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
		'#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode#">,"#val(form.fucost)#","#val(form.fprice)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode2#">,"#val(form.fucost2)#","#val(form.fprice2)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode3#">,"#val(form.fucost3)#","#val(form.fprice3)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode4#">,"#val(form.fucost4)#","#val(form.fprice4)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode5#">,"#val(form.fucost5)#","#val(form.fprice5)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode6#">,"#val(form.fucost6)#","#val(form.fprice6)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode7#">,"#val(form.fucost7)#","#val(form.fprice7)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode8#">,"#val(form.fucost8)#","#val(form.fprice8)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode9#">,"#val(form.fucost9)#","#val(form.fprice9)#",<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fcurrcode10#">,"#val(form.fucost10)#","#val(form.fprice10)#",
			<cfloop from="1" to="20" index="i">
				'#Evaluate("form.color#i#")#','#Evaluate("form.size#i#")#',
			</cfloop>
			'#HUserID#',#now()#,'#HUserID#',#now()#
			)
		</cfquery>
	
		<cfset status="The Matrix Item, #form.mitemno# had been successfully created. ">
	<cfelse>
		<cfquery datasource='#dts#' name="checkitemExist">
	 	 	Select * from icmitem 
	 		where mitemno = '#form.mitemno#'
 		</cfquery>

		<cfif checkitemExist.recordcount GT 0>
			<cfif form.mode eq "Delete">
				<cfquery datasource='#dts#' name="deleteitem">
					Delete from icmitem
					where mitemno = '#form.mitemno#'
				</cfquery>
				
				<cfset status="The Matrix Item, #form.mitemno# had been successfully deleted. ">	
			</cfif>
			
			<cfif form.mode eq "Edit">
				<cfquery name="update" datasource="#dts#">
					update icmitem
					set desp = '#form.desp#',
					despa = '#form.despa#',
					aitemno = '#form.AITEMNO#',
					unit = '#form.UNIT#',
					ucost = '#val(form.UCOST)#',
					price = '#form.PRICE#',
                    price2 = '#val(form.price2)#',
          			price3 = '#val(form.price3)#',
                    price4 = '#val(form.price4)#',
         			muratio = '#val(form.muratio)#',
					category = '#form.CATEGORY#',
					wos_group = '#form.WOS_GROUP#',
                    sizeid = '#form.sizeid#',
                    colorid = '#form.colorid#',
                    shelf = '#form.shelf#',
                    photo = '#form.photo#',
					brand = '#form.BRAND#',
					supp = '#form.supp#',
					colorno = '#form.colorno#',
					sizecolor = '#form.sizecolor#',
                    <cfloop from="1" to="30" index="x">
					remark#x#=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form["remark#x#"]#">,
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
					<cfloop from="1" to="20" index="i">
						color#i# = '#Evaluate("form.color#i#")#',
						size#i# = '#Evaluate("form.size#i#")#',
					</cfloop>
					updated_by = '#HUserID#',
					updated_on = #now()#
					where mitemno = '#form.mitemno#'
				</cfquery>
                
                <cfif lcase(hcomid) eq 'aipl_i'>
                <cfquery name="update" datasource="#dts#">
					update icitem
					set photo = '#form.photo#',remark2='#form.remark2#'
					where itemno like '%#form.mitemno#%'
				</cfquery>
				</cfif>
				<cfset status="The Matrix Item, #form.mitemno# had been successfully edited. ">
			</cfif>
				
		<cfelse>		
			<cfset status="Sorry, the Matrix Item, #form.mitemno# was ALREADY removed from the system. Process unsuccessful.">
		</cfif>
	</cfif>
</cfif>

<cfoutput>
	<cfif submit neq 'Edit Opening Quantity'>
		<form name="done" action="s_matrixitemtable.cfm?process=done" method="post">
			<input name="status" value="#status#" type="hidden">
		</form>
	<cfelse>
		<form name="done" action="matrixitem_openingqty.cfm?process=done" method="post">
			<input name="status" value="#status#" type="hidden">
			<input name="inserthyphen" value="#inserthyphen#" type="hidden">
			<input name="sizecolor" value="#form.sizecolor#" type="hidden">
			<input name="mitemno" value="#form.mitemno#" type="hidden">
		</form>
	</cfif>
</cfoutput>

<script>
	done.submit();
</script>