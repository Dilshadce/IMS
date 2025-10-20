<!---
	Create the Excel file system object. This object is
	responsible for reading in the given Excel file.
--->
	<cfset 	objPOI = CreateObject("component","POIUtility").Init() />
	
	
	<!--- 
		Read in the Exercises excel sheet. This has Push, Pull,
		and Leg exercises split up on to three different sheets.
		By default, the POI Utilty will read in all three sheets
		from the workbook. Since our excel sheet has a header
		row, we want to strip it out of our returned queries.
	--->
	<cfset arrSheets = objPOI.ReadExcel(FilePath = "#filename#",HasHeaderRow = false) />
	
	<!--- 
		The ReadExcel() has returned an array of sheet object.
		Let's loop over sheets and output the data. NOTE: This
		could be also done to insert into a DATABASE!
	--->
    
	 <cfloop index="intSheet" from="1" to="#ArrayLen( arrSheets )#" step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
        
        <cfloop query="objSheet.Query">
       		<cfset qCell = objSheet.Query>
            <cfif qCell.currentrow gt 1>
                <!--- <cftry> --->
                
                    <cfif submitarcust EQ 'Submit' AND trim(column1) NEQ ''>
                        <cfquery name="insertInto_arcustTemp" datasource="#dts#">
							INSERT INTO arcust_temp( custno,name,name2,comUEN,
                                        			 add1,add2,add3,add4,country,postalCode,attn,phone,phonea,fax,e_mail,
                                        			 daddr1,daddr2,daddr3,daddr4,d_country,d_postalCode,dattn,dphone,contact,dfax,d_email,
                                          			 ngst_cust,GSTno,saleC,saleCNC,
                                        			 currCode,currency,currency1,term,crLimit,invLimit,
                                        			 dispec_cat,dispec1,dispec2,dispec3,normal_rate,offer_rate,others_rate,
                                         			 business,area,end_user,agent,groupTo,arrem1,arrem2,arrem3,arrem4,badStatus )
                                         
                            VALUES (	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column1),8)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column2),40)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column3),40)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column4),45)#">,	
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column5),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column6),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column7),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column8),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column9),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column10),25)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column11),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column12),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column13),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column14),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column15),100)#">,
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column16),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column17),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column18),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column19),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column20),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column21),25)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column22),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column23),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column24),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column25),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column26),100)#">,
                                        
                                        <cfif column27 EQ 'Y'>
                                        	'F'
                                        <cfelse>
                                        	'T'
                                        </cfif>,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column28),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column29),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column30),12)#">,
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column31),10)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column32),10)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column33),27)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column34),12)#">,
                                        '#val(column35)#',
                                        '#val(column36)#',
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column37),1)#">,
                                        '#val(column38)#',
                                        '#val(column39)#',
                                        '#val(column40)#',
                                        '#val(column41)#',
                                        '#val(column42)#',
                                        '#val(column43)#',
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column44),15)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column45),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column46),45)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column47),20)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column48),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column49),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column50),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column51),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column52),35)#">,
                                        <cfif column53 EQ 'T'>
                                        	'T'
                                        <cfelse>
                                        	'F'
                                        </cfif>
                        		 )
                        </cfquery>
                    </cfif>
                    
                    <cfif submitapvend EQ 'Submit' AND trim(column1) NEQ ''>
						<cfquery name="insertInto_apvendTemp" datasource="#dts#">
							INSERT INTO apvend_temp( custno,name,name2,comUEN,
                                        			 add1,add2,add3,add4,country,postalCode,attn,phone,phonea,fax,e_mail,
                                        			 daddr1,daddr2,daddr3,daddr4,d_country,d_postalCode,dattn,dphone,contact,dfax,d_email,
                                          			 ngst_cust,GSTno,saleC,saleCNC,
                                        			 currCode,currency,currency1,term,crLimit,invLimit,
                                        			 dispec_cat,dispec1,dispec2,dispec3,
                                         			 business,area,end_user,agent,groupTo,arrem1,arrem2,arrem3,arrem4,badStatus )
                                         
                            VALUES (	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column1),8)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column2),40)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column3),40)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column4),45)#">,	
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column5),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column6),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column7),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column8),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column9),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column10),25)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column11),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column12),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column13),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column14),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column15),100)#">,
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column16),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column17),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column18),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column19),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column20),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column21),25)#">,	
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column22),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column23),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column24),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column25),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column26),100)#">,
                                        
                                        <cfif column27 EQ 'Y'>
                                        	'F'
                                        <cfelse>
                                        	'T'
                                        </cfif>,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column28),25)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column29),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column30),12)#">,
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column31),10)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column32),10)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column33),27)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column34),12)#">,
                                        '#val(column35)#',
                                        '#val(column36)#',
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column37),1)#">,
                                        '#val(column38)#',
                                        '#val(column39)#',
                                        '#val(column40)#',
                                        
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column41),15)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column42),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column42),45)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column43),20)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column44),12)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column45),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column46),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column47),35)#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(trim(column48),35)#">,
                                        <cfif column49 EQ 'T'>
                                        	'T'
                                        <cfelse>
                                        	'F'
                                        </cfif>
                        		 )
                        </cfquery>
                    </cfif>
                    
                    <cfif submiticitem eq 'Submit' and trim(column1) neq "">
          
                        <cfquery name="inserticitem" datasource="#dts#">
                            insert into icitem_temp
                            (itemno,desp,despa,aitemno,brand,supp,category,wos_group,sizeid,costcode,
                            colorid,shelf,packing,
                            minimum,maximum,reorder,unit,ucost,price,price2,price3,price4,
                            WSERIALNO,graded,qty2,qty3,qty4,qty5,qty6,qtybf,
                            salec,salecsc,salecnc,purc,purprec,unit2,factor1,factor2,priceu2,remark1,barcode,custprice_rate,fcurrcode,fucost,fprice,fcurrcode2,fucost2,fprice2,fcurrcode3,fucost3,fprice3,fcurrcode4,fucost4,fprice4,fcurrcode5,fucost5,fprice5,itemtype,comment,nonstkitem)
                            values
                            (<cfqueryparam cfsqltype="cf_sql_varchar" value="#column1#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(column2,100)#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(column3,100)#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column4#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column5#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column6#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(trim(column7),80)#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column8#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(trim(column9),40)#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column10#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column11#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column12#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column13#">,
                            '#val(column14)#',
                            '#val(column15)#',
                            '#val(column16)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column17#">,
                            '#val(column18)#',
                            '#val(column19)#',
                            '#val(column20)#',
                            '#val(column21)#',
                            '#val(column22)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(column23,1)#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(column24,1)#">,
                            '#val(column25)#',
                            '#val(column26)#',
                            '#val(column27)#',
                            '#val(column28)#',
                            '#val(column29)#',
                            '#val(column30)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column31#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column32#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column33#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column34#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column35#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column36#">,
                            '#val(column37)#',
                            '#val(column38)#',
                            '#val(column39)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column40#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column41#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column42#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column43#">,
                            '#val(column44)#',
                            '#val(column45)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column46#">,
                            '#val(column47)#',
                            '#val(column48)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column49#">,
                            '#val(column50)#',
                            '#val(column51)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column52#">,
                            '#val(column53)#',
                            '#val(column54)#',
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#column55#">,
                            '#val(column56)#',
                            '#val(column57)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#column58#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column59#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column60#">)
                        </cfquery>
                    </cfif>
            <!--- 	<cfcatch type="any">
                    <cfoutput>#column1#::#column2#:::#cfcatch.Message#<br>#cfcatch.Detail#<br></cfoutput>
                </cfcatch>
                </cftry> --->
            </cfif>
        </cfloop>
</cfloop>
