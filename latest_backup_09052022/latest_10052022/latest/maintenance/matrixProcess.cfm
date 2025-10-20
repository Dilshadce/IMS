<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "607,100,606,65,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.mItemNo')>
	<cfset URLmItemNo = trim(urldecode(url.mItemNo))>
</cfif>

<cfquery name="getlocation" datasource="#dts#">
     select * from iclocation
</cfquery>

<cfoutput>
<cfif IsDefined("url.action")>
	<!---create item using matrix--->
    <cfif url.action EQ "create" or url.action EQ "update">
    
    <cfif form.matrixItemNo contains "-">
    <h3>Kindly do not use - symbol</h3>
    <input type="button" name="back" id="back" onClick="window.history.go(-1)" />
    <cfabort>
    </cfif>
    
	<cfset counter = 0>
	<cfif form.sizecolor eq "SC">
		<cfloop from="1" to="20" index="i">
			<cfset thiscolor = Evaluate("form.color#i#")>
			<cfif thiscolor neq "">
				<cfloop from="1" to="20" index="j">
					<cfset thissize = Evaluate("form.size#j#")>
					<cfif thissize neq "">
							<cfset thisitemno = form.matrixItemNo&'-'&thiscolor&'-'&thissize>
						<cfquery name="checkitemExist1" datasource="#dts#">
 	 						select * from icitem where itemno = '#thisitemno#' 
 	 					</cfquery>
						<cfif checkitemExist1.recordcount eq 0>
							<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
								<cfset thisdesp = form.desp&' ('&thiscolor&'/'&thissize&')'>
							<cfelse>
								<cfset thisdesp = form.desp>
							</cfif>
                            
                            <cfif lcase(hcomid) eq "hwangkit_i" or lcase(hcomid) eq "showcase_i">
                            <cfquery name="gethuawangbarcode" datasource="#dts#">
                                select max(barcode) as lastbarcode from icitem
                            </cfquery>	
                            <cfinvoke component="cfc.refno" method="processNum" oldNum="#gethuawangbarcode.lastbarcode#" returnvariable="xbarcode" />
                            <cfelse>
                                <cfset xbarCode = "">
                            </cfif>
						
							<cfquery name="insertitem" datasource="#dts#">
								INSERT INTO icitem 
								(itemno,aitemno,desp,despa,comment,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
                                remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
                                remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate,barcode)
								VALUES 
								('#thisitemno#','#form.alternateItemNo#','#thisdesp#','#form.despa#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comment#">,'#form.BRAND#','#form.CATEGORY#','#form.group#',
								'#form.unitOfMeasurement#','#val(form.unitCostPrice)#','#val(form.unitSellingPrice1)#','#form.supplier#','#form.size#','#form.material#','#form.model#',<cfif IsDefined('picture_available')>'#form.picture_available#'<cfelse>''</cfif>,'#val(form.unitSellingPrice2)#','#val(form.unitSellingPrice3)#','#val(form.unitSellingPrice4)#','#val(form.muratio)#','#remark1#','#remark2#',
                                '#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
                                '#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
                                '#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency1#">,"#val(form.foreignUnitCostValue1)#","#val(form.foreignSellingPriceValue1)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency2#">,"#val(form.foreignUnitCostValue2)#","#val(form.foreignSellingPriceValue2)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency3#">,"#val(form.foreignUnitCostValue3)#","#val(form.foreignSellingPriceValue3)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency4#">,"#val(form.foreignUnitCostValue4)#","#val(form.foreignSellingPriceValue4)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency5#">,"#val(form.foreignUnitCostValue5)#","#val(form.foreignSellingPriceValue5)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency6#">,"#val(form.foreignUnitCostValue6)#","#val(form.foreignSellingPriceValue6)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency7#">,"#val(form.foreignUnitCostValue7)#","#val(form.foreignSellingPriceValue7)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency8#">,"#val(form.foreignUnitCostValue8)#","#val(form.foreignSellingPriceValue8)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency9#">,"#val(form.foreignUnitCostValue9)#","#val(form.foreignSellingPriceValue9)#",
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency10#">,"#val(form.foreignUnitCostValue10)#","#val(form.foreignSellingPriceValue10)#",'normal',
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#xbarCode#">)
							</cfquery>
                            
                            <cfloop query="getlocation">
                            
                            <cfquery name="insertlocqdbf" datasource="#dts#">
                            insert into locqdbf (itemno,location) values ('#thisitemno#','#getlocation.location#')
                            </cfquery>
                            
                            </cfloop>
                            
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
					<cfset thisitemno = form.matrixItemNo&'-'&thissize>
				<cfquery name="checkitemExist1" datasource="#dts#">
 	 				SELECT * 
                    FROM icitem 
                    WHERE itemno = '#thisitemno#' 
 	 			</cfquery>
				<cfif checkitemExist1.recordcount eq 0>
					<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
						<cfset thisdesp = form.desp&' ('&thissize&')'>
					<cfelse>
						<cfset thisdesp = form.desp>
					</cfif>
                    
                    <cfif lcase(hcomid) eq "hwangkit_i" or lcase(hcomid) eq "showcase_i">
                    <cfquery name="gethuawangbarcode" datasource="#dts#">
                        select max(barcode) as lastbarcode from icitem
                    </cfquery>	
                    <cfinvoke component="cfc.refno" method="processNum" oldNum="#gethuawangbarcode.lastbarcode#" returnvariable="xbarcode" />
                    <cfelse>
                        <cfset xbarCode = "">
                    </cfif>
						
					<cfquery name="insertitem" datasource="#dts#">
						INSERT INTO icitem 
						(itemno,aitemno,desp,despa,comment,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
                        remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
                        remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate,barcode)
						VALUES 
						('#thisitemno#','#form.alternateItemNo#','#thisdesp#','#form.despa#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comment#">,'#form.BRAND#','#form.CATEGORY#','#form.group#',
						'#form.unitOfMeasurement#','#val(form.unitCostPrice)#','#val(form.unitSellingPrice1)#','#form.supplier#','#form.size#','#form.material#','#form.model#',<cfif IsDefined('picture_available')>'#form.picture_available#'<cfelse>''</cfif>,'#val(form.unitSellingPrice2)#','#val(form.unitSellingPrice3)#','#val(form.unitSellingPrice4)#','#val(form.muratio)#','#remark1#','#remark2#',
                        '#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
                        '#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
                        '#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency1#">,"#val(form.foreignUnitCostValue1)#","#val(form.foreignSellingPriceValue1)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency2#">,"#val(form.foreignUnitCostValue2)#","#val(form.foreignSellingPriceValue2)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency3#">,"#val(form.foreignUnitCostValue3)#","#val(form.foreignSellingPriceValue3)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency4#">,"#val(form.foreignUnitCostValue4)#","#val(form.foreignSellingPriceValue4)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency5#">,"#val(form.foreignUnitCostValue5)#","#val(form.foreignSellingPriceValue5)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency6#">,"#val(form.foreignUnitCostValue6)#","#val(form.foreignSellingPriceValue6)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency7#">,"#val(form.foreignUnitCostValue7)#","#val(form.foreignSellingPriceValue7)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency8#">,"#val(form.foreignUnitCostValue8)#","#val(form.foreignSellingPriceValue8)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency9#">,"#val(form.foreignUnitCostValue9)#","#val(form.foreignSellingPriceValue9)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency10#">,"#val(form.foreignUnitCostValue10)#","#val(form.foreignSellingPriceValue10)#",'normal',
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#xbarcode#">)
					</cfquery>
                    
                    <cfloop query="getlocation">
                            
                            <cfquery name="insertlocqdbf" datasource="#dts#">
                            insert into locqdbf (itemno,location) values ('#thisitemno#','#getlocation.location#')
                            </cfquery>
                            
                    </cfloop>
					<cfset counter = counter + 1>
				</cfif>
			</cfif>
		</cfloop>
	<cfelse>
		<cfloop from="1" to="20" index="j">
			<cfset thiscolor = form["color#j#"]>
			<cfif thiscolor neq "">
					<cfset thisitemno = form.matrixItemNo&'-'&thiscolor>
				<cfquery name="checkitemExist1" datasource="#dts#">
 	 				SELECT * 
                    FROM icitem 
                    WHERE itemno = '#thisitemno#' 
 	 			</cfquery>
				<cfif checkitemExist1.recordcount eq 0>
					<cfif isdefined("form.insertcolorsize") and form.insertcolorsize eq "on">
						<cfset thisdesp = form.desp&' ('&thiscolor&')'>
					<cfelse>
						<cfset thisdesp = form.desp>
					</cfif>
                    
                    
                    <cfif lcase(hcomid) eq "hwangkit_i" or lcase(hcomid) eq "showcase_i">
                    <cfquery name="gethuawangbarcode" datasource="#dts#">
                        select max(barcode) as lastbarcode from icitem
                    </cfquery>	
                    <cfinvoke component="cfc.refno" method="processNum" oldNum="#gethuawangbarcode.lastbarcode#" returnvariable="xbarcode" />
                    <cfelse>
                        <cfset xbarCode = "">
                    </cfif>
						
					<cfquery name="insertitem" datasource="#dts#">
						INSERT INTO icitem 
						(itemno,aitemno,desp,despa,comment,brand,category,wos_group,unit,ucost,price,supp,sizeid,colorid,shelf,photo,price2,price3,price4,muratio,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10,remark11,remark12,
                        remark13,remark14,remark15,remark16,remark17,remark18,remark19,remark20,remark21,remark22,remark23,
                        remark24,remark25,remark26,remark27,remark28,remark29,remark30,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,fcurrcode6,fucost6,fprice6,fcurrcode7,fucost7,fprice7,fcurrcode8,fucost8,fprice8,fcurrcode9,fucost9,fprice9,fcurrcode10,fucost10,fprice10,custprice_rate,barcode)
						values 
						('#thisitemno#','#form.alternateItemNo#','#thisdesp#','#form.despa#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comment#">,'#form.BRAND#','#form.CATEGORY#','#form.group#',
						'#form.unitOfMeasurement#','#val(form.unitCostPrice)#','#val(form.unitSellingPrice1)#','#form.supplier#','#form.size#','#form.material#','#form.model#',<cfif IsDefined('picture_available')>'#form.picture_available#'<cfelse>''</cfif>,'#val(form.unitSellingPrice2)#','#val(form.unitSellingPrice3)#','#val(form.unitSellingPrice4)#','#val(form.muratio)#','#remark1#','#remark2#',
                        '#remark3#','#remark4#','#remark5#','#remark6#','#remark7#','#remark8#','#remark9#','#remark10#','#remark11#','#remark12#',
                        '#remark13#','#remark14#','#remark15#','#remark16#','#remark17#','#remark18#','#remark19#','#remark20#','#remark21#','#remark22#',
                        '#remark23#','#remark24#','#remark25#','#remark26#','#remark27#','#remark28#','#remark29#','#remark30#',
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency1#">,"#val(form.foreignUnitCostValue1)#","#val(form.foreignSellingPriceValue1)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency2#">,"#val(form.foreignUnitCostValue2)#","#val(form.foreignSellingPriceValue2)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency3#">,"#val(form.foreignUnitCostValue3)#","#val(form.foreignSellingPriceValue3)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency4#">,"#val(form.foreignUnitCostValue4)#","#val(form.foreignSellingPriceValue4)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency5#">,"#val(form.foreignUnitCostValue5)#","#val(form.foreignSellingPriceValue5)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency6#">,"#val(form.foreignUnitCostValue6)#","#val(form.foreignSellingPriceValue6)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency7#">,"#val(form.foreignUnitCostValue7)#","#val(form.foreignSellingPriceValue7)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency8#">,"#val(form.foreignUnitCostValue8)#","#val(form.foreignSellingPriceValue8)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency9#">,"#val(form.foreignUnitCostValue9)#","#val(form.foreignSellingPriceValue9)#",
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.foreignCurrency10#">,"#val(form.foreignUnitCostValue10)#","#val(form.foreignSellingPriceValue10)#",'normal',
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#xbarcode#">)
					</cfquery>
                    <cfloop query="getlocation">
                            
                            <cfquery name="insertlocqdbf" datasource="#dts#">
                            insert into locqdbf (itemno,location) values ('#thisitemno#','#getlocation.location#')
                            </cfquery>
                            
                    </cfloop>
					<cfset counter = counter + 1>
				</cfif>
			</cfif>
		</cfloop>
	</cfif>
    </cfif>
	<!--- --->
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT mitemno 
            FROM icmitem
			WHERE mitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.matrixItemNo)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.matrixItemNo)# already exist!');
				window.open('/latest/maintenance/matrix.cfm?action=create','_self');
			</script>
		<cfelse>
			<!---<cftry>	--->
				<cfquery name="createMatrix" datasource="#dts#">
					INSERT INTO icmitem 
                    (colorno,mitemno,aitemno,desp,despa,comment,
                     brand,supp,category,wos_group,photo,sizeid,colorid,shelf,
                     unit,ucost,price,price2,price3,price4,
                     fcurrcode
                     <cfloop index="i" from="2" to="10">,fcurrcode#i#</cfloop>
                     ,fucost
                     <cfloop index="i" from="2" to="10">,fucost#i#</cfloop>
                     ,fprice
                     <cfloop index="i" from="2" to="10">,fprice#i#</cfloop>
                     <cfloop index="i" from="1" to="30">,remark#i#</cfloop>
                     <cfloop index="i" from="1" to="20">,color#i#</cfloop>
                     <cfloop index="i" from="1" to="20">,size#i#</cfloop>,muratio,sizeColor)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.colorNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.matrixItemNo)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.alternateItemNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.despa)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.comment)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.brand)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.supplier)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.group)#">,
                        <cfif IsDefined('picture_available')>
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.picture_available)#">,
                        <cfelse>    
                        	'',
                        </cfif>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.size)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.material)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.model)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.unitOfMeasurement)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitCostPrice)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice1)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice2)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice3)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice4)#">,  
                     	
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.foreignCurrency1)#">
                        <cfloop index="i" from="2" to="10">
                       		<cfset fcurrcodeValue = evaluate('form.foreignCurrency#i#')>	
                        		,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(fcurrcodeValue)#">
                        </cfloop>,
                        
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.foreignUnitCostValue1)#">
                        <cfloop index="i" from="2" to="10">
                       		<cfset foreignUnitCost = evaluate('form.foreignUnitCostValue#i#')>
                        		,<cfqueryparam cfsqltype="cf_sql_double" value="#val(foreignUnitCost)#">
                        </cfloop>,
                        
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.foreignSellingPriceValue1)#">
                        <cfloop index="i" from="2" to="10">
                       		<cfset foreignSellingPrice = evaluate('form.foreignSellingPriceValue#i#')>	
                        		,<cfqueryparam cfsqltype="cf_sql_double" value="#val(foreignSellingPrice)#">
                        </cfloop>,
                        
                        <cfloop index="i" from="1" to="30">
                       		<cfset remarkValue = evaluate('form.remark#i#')>	
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(remarkValue)#">,
                        </cfloop>
                        
                        <cfloop index="i" from="1" to="20">
                       		<cfset colorValue = evaluate('form.color#i#')>	
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(colorValue)#">,
                        </cfloop>
                        
                        <cfloop index="i" from="1" to="20">
                       		<cfset sizeValue = evaluate('form.size#i#')>	
                        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(sizeValue)#">,
                        </cfloop>
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.muRatio)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#(form.sizeColor)#">
					)
				</cfquery>
               <!--- <cfcatch type="any">
                    <script type="text/javascript">
                        alert('Failed to create #trim(form.matrixItemNo)#!\nError Message: #cfcatch.message#');
                        window.open('/latest/maintenance/matrix.cfm?action=create','_self');
                    </script>
                </cfcatch>
       		</cftry>--->
			<script type="text/javascript">
				 alert('#trim(form.matrixItemNo)# has been created successfully!');
				window.open('/latest/maintenance/matrixProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		<cftry>	
			<cfquery name="updateMatrix" datasource="#dts#">
				UPDATE icmitem
				SET
					colorno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.colorNo)#">,
					mitemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.matrixItemNo#">,
                    aitemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.alternateItemNo#">,
                    desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                    despa = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.despa#">,
                    comment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comment#">,
                    brand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.brand#">,
                    supp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supplier#">,
                    category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
                    wos_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.group#">,
                    photo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.picture_available#">,
                    sizeid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.size#">,
                    colorid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.material#">,
                    shelf = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.model#">,
                    
                    unit = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.unitOfMeasurement#">,
                    ucost = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitCostPrice)#">,
                    price = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice1)#">,
                    price2 = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice2)#">,
                    price3 = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice3)#">,
                    price4 = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.unitSellingPrice4)#">,
                
					
                    fcurrcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.foreignCurrency1)#">
                    <cfloop index="i" from="2" to="10">
                        <cfset fcurrcodeValue = evaluate('form.foreignCurrency#i#')>	
                            ,fcurrcode#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(fcurrcodeValue)#">
                    </cfloop>,
                    
                    fucost = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.foreignUnitCostValue1)#">
                    <cfloop index="i" from="2" to="10">
                        <cfset foreignUnitCost = evaluate('form.foreignUnitCostValue#i#')>	
                            ,fucost#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#val(foreignUnitCost)#">
                    </cfloop>,
                    
                    fprice = <cfqueryparam cfsqltype="cf_sql_double" value="#val(form.foreignSellingPriceValue1)#">
                    <cfloop index="i" from="2" to="10">
                        <cfset foreignSellingPrice = evaluate('form.foreignSellingPriceValue#i#')>	
                            ,fprice#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#val(foreignSellingPrice)#">
                    </cfloop>,
                    
                     <cfloop index="i" from="1" to="30">
                        <cfset remarkValue = evaluate('form.remark#i#')>	
                        remark#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(remarkValue)#">,
                    </cfloop>
                    
                    <cfloop index="i" from="1" to="20">
                        <cfset colorValue = evaluate('form.color#i#')>	
                        color#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(colorValue)#">,
                    </cfloop>
                    
                    <cfloop index="i" from="1" to="20">
                        <cfset sizeValue = evaluate('form.size#i#')>	
                        size#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(sizeValue)#">,
                    </cfloop>
                   
                    muratio = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.muRatio)#">,
                    sizeColor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#(form.sizeColor)#">
				WHERE mitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.matrixItemNo)#">;
			</cfquery>
            <cfcatch type="any">
                <script type="text/javascript">
                    alert('Failed to create #trim(form.matrixItemNo)#!\nError Message: #cfcatch.message#');
                    window.open('/latest/maintenance/matrix.cfm?action=update','_self');
                </script>
            </cfcatch>
        </cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.matrixItemNo)# successfully!');
			window.open('/latest/maintenance/matrixProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteMatrix" datasource="#dts#">
				DELETE FROM icmitem
				WHERE mitemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLmItemNo#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLmItemNo#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/matrixProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLmItemNo# successfully!');
			window.open('/latest/maintenance/matrixProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printSize" datasource="#dts#">
			SELECT mitemno,desp
			FROM icmitem
			ORDER BY mitemno;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[607]#</title>
		<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
		<!--[if lt IE 9]>
			<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
			<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
		</head>
		<body>
		
		<div class="container">
		<div class="page-header">
			<h1 class="text">#words[607]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[606])#</th>
					<th>#UCase(words[65])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printSize">
				<tr>
					<td>#mitemno#</td>
					<td>#desp#</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		</div>
		<div class="panel-footer">
		<p>#words[101]# #DateFormat(Now(),'dd-mm-yyyy')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
		</div>
		</div>		
		
		</body>
		</html>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/matrixProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/matrixProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>