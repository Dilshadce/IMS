<!--- Blog Entry:
	Reading Excel Files With ColdFusion And POI
	
	Code Snippet:
	1
	
	Author:
	Ben Nadel / Kinky Solutions
	
	Link:
	http://www.bennadel.com/index.cfm?dax=blog:472.view
	
	Date Posted:
	Jan 14, 2007 at 3:08 PM --->


<!---
	Create the Excel file system object. This object is
	responsible for reading in the given Excel file.
--->
<cfset objPOI = CreateObject( 
		"component", 
		"POIUtility" 
		).Init() 
		/>
	
	
	<!--- 
		Read in the Exercises excel sheet. This has Push, Pull,
		and Leg exercises split up on to three different sheets.
		By default, the POI Utilty will read in all three sheets
		from the workbook. Since our excel sheet has a header
		row, we want to strip it out of our returned queries.
	--->
	<cfset arrSheets = objPOI.ReadExcel( 
		FilePath = "#filename#",
		HasHeaderRow = false
		) />
		
<!---         <cfloop
		index="intSheet"
		from="1"
		to="#ArrayLen( arrSheets )#"
		step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
        <cfdump var="#objSheet#">
        </cfloop> --->
	
	<!--- 
		The ReadExcel() has returned an array of sheet object.
		Let's loop over sheets and output the data. NOTE: This
		could be also done to insert into a DATABASE!
	--->
    
	 <cfloop
		index="intSheet"
		from="1"
		to="#ArrayLen( arrSheets )#"
		step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
<!--- <cfdump var="#qCell#"> --->




<cfloop query="objSheet.Query">
<cfset qCell = objSheet.Query>
	<cfif qCell.currentrow eq 1>
			<cfloop from="1" to="100" index="i">
            <cfif isdefined('column#i#')>
            <cfset currentcolumn=evaluate('column#i#')>
            
            <cfif trim(currentcolumn) eq "item">
            <cfset item="column#i#">
            </cfif>
            
            <cfif trim(currentcolumn) eq "color">
            <cfset color="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "F">
            <cfset F="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "3XS">
            <cfset XXXS="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "XXS">
            <cfset XXS="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "XS">
            <cfset XS="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "S">
            <cfset S="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "M">
            <cfset M="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "L">
            <cfset L="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "XL">
            <cfset XL="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "XXL">
            <cfset XXL="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "3XL">
            <cfset XXXL="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "03" or currentcolumn eq "3">
            <cfset size3="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "04" or currentcolumn eq "4">
            <cfset size4="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "05" or currentcolumn eq "5">
            <cfset size5="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "06" or currentcolumn eq "6">
            <cfset size6="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "07" or currentcolumn eq "7">
            <cfset size7="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "08" or currentcolumn eq "8">
            <cfset size8="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "09" or currentcolumn eq "9">
            <cfset size9="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "10" or currentcolumn eq "10">
            <cfset size10="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "12" or currentcolumn eq "12">
            <cfset size12="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "11" or currentcolumn eq "11">
            <cfset size11="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "37" or currentcolumn eq "37">
            <cfset size37="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "38" or currentcolumn eq "38">
            <cfset size38="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "39" or currentcolumn eq "39">
            <cfset size39="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "40" or currentcolumn eq "40">
            <cfset size40="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "41" or currentcolumn eq "41">
            <cfset size41="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "42" or currentcolumn eq "42">
            <cfset size42="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "43" or currentcolumn eq "43">
            <cfset size43="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "44" or currentcolumn eq "44">
            <cfset size44="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "price">
            <cfset price="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "discount 1">
            <cfset dispec1="column#i#">
            </cfif>
            
            <cfif currentcolumn eq "discount 2">
            <cfset dispec2="column#i#">
            </cfif>
            </cfif>
            </cfloop> 
            
          
	</cfif>

	<cfif qCell.currentrow gt 1>
		<cftry>
		<cfset realitemno=evaluate('#item#')>
        <cfset realcolor=evaluate('#color#')>
        <cfset realprice=evaluate('#price#')>
        <cfset realdispec1=evaluate('#dispec1#')>
        <cfif isdefined('dispec2')>
        <cfset realdispec2=evaluate('#dispec2#')>
        <cfelse>
        <cfset realdispec2=0>
        </cfif>
        <cfif isdefined('F')>
        <cfset realF=evaluate('#F#')>
        <cfelse>
        <cfset realF=0>
        </cfif>
        
        <cfif isdefined('XXXS')>
        <cfset realXXXS=evaluate('#XXXS#')>
        <cfelse>
        <cfset realXXXS=0>
        </cfif>
        
        <cfif isdefined('XXS')>
        <cfset realXXS=evaluate('#XXS#')>
        <cfelse>
        <cfset realXXS=0>
        </cfif>
        
        <cfif isdefined('XS')>
        <cfset realXS=evaluate('#XS#')>
        <cfelse>
        <cfset realXS=0>
        </cfif>
        
        <cfif isdefined('S')>
        <cfset realS=evaluate('#S#')>
        <cfelse>
        <cfset realS=0>
        </cfif>
        
        <cfif isdefined('M')>
        <cfset realM=evaluate('#M#')>
        <cfelse>
        <cfset realM=0>
        </cfif>
        
        <cfif isdefined('L')>
        <cfset realL=evaluate('#L#')>
        <cfelse>
        <cfset realL=0>
        </cfif>
        
        <cfif isdefined('XL')>
        <cfset realXL=evaluate('#XL#')>
        <cfelse>
        <cfset realXL=0>
        </cfif>
        
        <cfif isdefined('XXL')>
        <cfset realXXL=evaluate('#XXL#')>
        <cfelse>
        <cfset realXXL=0>
        </cfif>
        
        <cfif isdefined('XXXL')>
        <cfset realXXXL=evaluate('#XXXL#')>
        <cfelse>
        <cfset realXXXL=0>
        </cfif>
        
        <cfif isdefined('size3')>
        <cfset realsize3=evaluate('#size3#')>
        <cfelse>
        <cfset realsize3=0>
        </cfif>
        
        <cfif isdefined('size4')>
        <cfset realsize4=evaluate('#size4#')>
        <cfelse>
        <cfset realsize4=0>
        </cfif>
        
        <cfif isdefined('size5')>
        <cfset realsize5=evaluate('#size5#')>
        <cfelse>
        <cfset realsize5=0>
        </cfif>
        
        <cfif isdefined('size6')>
        <cfset realsize6=evaluate('#size6#')>
        <cfelse>
        <cfset realsize6=0>
        </cfif>
        
        <cfif isdefined('size7')>
        <cfset realsize7=evaluate('#size7#')>
        <cfelse>
        <cfset realsize7=0>
        </cfif>
        
        <cfif isdefined('size8')>
        <cfset realsize8=evaluate('#size8#')>
        <cfelse>
        <cfset realsize8=0>
        </cfif>
        
        <cfif isdefined('size9')>
        <cfset realsize9=evaluate('#size9#')>
        <cfelse>
        <cfset realsize9=0>
        </cfif>
        
        <cfif isdefined('size10')>
        <cfset realsize10=evaluate('#size10#')>
        <cfelse>
        <cfset realsize10=0>
        </cfif>
        
        <cfif isdefined('size11')>
        <cfset realsize11=evaluate('#size11#')>
        <cfelse>
        <cfset realsize11=0>
        </cfif>
        
        <cfif isdefined('size12')>
        <cfset realsize12=evaluate('#size12#')>
        <cfelse>
        <cfset realsize12=0>
        </cfif>
        
        <cfif isdefined('size37')>
        <cfset realsize37=evaluate('#size37#')>
        <cfelse>
        <cfset realsize37=0>
        </cfif>
        
        <cfif isdefined('size38')>
        <cfset realsize38=evaluate('#size38#')>
        <cfelse>
        <cfset realsize38=0>
        </cfif>
        
        <cfif isdefined('size39')>
        <cfset realsize39=evaluate('#size39#')>
        <cfelse>
        <cfset realsize39=0>
        </cfif>
        
        <cfif isdefined('size40')>
        <cfset realsize40=evaluate('#size40#')>
        <cfelse>
        <cfset realsize40=0>
        </cfif>
        
        <cfif isdefined('size41')>
        <cfset realsize41=evaluate('#size41#')>
        <cfelse>
        <cfset realsize41=0>
        </cfif>
        
        <cfif isdefined('size42')>
        <cfset realsize42=evaluate('#size42#')>
        <cfelse>
        <cfset realsize42=0>
        </cfif>
        
        <cfif isdefined('size43')>
        <cfset realsize43=evaluate('#size43#')>
        <cfelse>
        <cfset realsize43=0>
        </cfif>
        
        <cfif isdefined('size44')>
        <cfset realsize44=evaluate('#size44#')>
        <cfelse>
        <cfset realsize44=0>
        </cfif>
        
			<cfif trim(realitemno) neq "">
				<cfquery name="inserticitem" datasource="#dts#">
					insert into ictran_excel3
					(itemno,color,qtyf,qty3XS,qtyXXS,qtyXS,qtyS,qtyM,qtyL,qtyXL,qtyXXL,qty3XL,qty3,qty4,qty5,qty6,qty7,qty8,qty9,qty10,qty11,qty12,qty37,qty38,qty39,qty40,qty41,qty42,qty43,qty44,price,location,dispec1,dispec2,dispec3)
					values
					(<cfqueryparam cfsqltype="cf_sql_varchar" value="#realitemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#realcolor#">,'#val(realF)#','#val(realxxxs)#','#val(realXXS)#','#val(realXS)#','#val(realS)#','#val(realM)#','#val(realL)#','#val(realXL)#','#val(realXXL)#','#val(realXXXL)#','#val(realsize3)#','#val(realsize4)#','#val(realsize5)#','#val(realsize6)#','#val(realsize7)#','#val(realsize8)#','#val(realsize9)#','#val(realsize10)#','#val(realsize11)#','#val(realsize12)#','#val(realsize37)#','#val(realsize38)#','#val(realsize39)#','#val(realsize40)#','#val(realsize41)#','#val(realsize42)#','#val(realsize43)#','#val(realsize44)#','#val(realprice)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="">,'#val(realdispec1)#','#val(realdispec2)#','0')
				</cfquery>
			</cfif>
		<cfcatch type="any">
			<cfoutput>#column1#::#column2#:::#cfcatch.Message#<br>#cfcatch.Detail#<br></cfoutput>
		</cfcatch>
		</cftry>
	</cfif>
</cfloop></cfloop>

