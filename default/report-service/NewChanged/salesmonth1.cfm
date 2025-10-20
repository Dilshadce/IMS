<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>


		<cfset stDecl_UPrice = getgeneral.decl_uprice>


<cfswitch expression="#form.period#">
	<cfcase value="1">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth11" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="areafrom" value="#form.areafrom#">
			<cfinvokeargument name="areato" value="#form.areato#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="2">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth12" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="areafrom" value="#form.areafrom#">
			<cfinvokeargument name="areato" value="#form.areato#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="3">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth13" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="areafrom" value="#form.areafrom#">
			<cfinvokeargument name="areato" value="#form.areato#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
	<cfcase value="4">
		<cfloop index="a" from="1" to="18">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth14" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="areafrom" value="#form.areafrom#">
			<cfinvokeargument name="areato" value="#form.areato#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
		</cfinvoke>
	</cfcase>
    <cfcase value="5">
		<cfloop index="a" from="1" to="1">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonthbymonth" method="getmonthitem" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="catefrom" value="#trim(form.catefrom)#">
			<cfinvokeargument name="cateto" value="#trim(form.cateto)#">
			<cfinvokeargument name="itemfrom" value="#trim(form.itemfrom)#">
			<cfinvokeargument name="itemto" value="#trim(form.itemto)#">
			<cfinvokeargument name="agentfrom" value="#form.agentfrom#">
			<cfinvokeargument name="agentto" value="#form.agentto#">
			<cfinvokeargument name="areafrom" value="#form.areafrom#">
			<cfinvokeargument name="areato" value="#form.areato#">
			<cfinvokeargument name="groupfrom" value="#trim(form.groupfrom)#">
			<cfinvokeargument name="groupto" value="#trim(form.groupto)#">
			<cfinvokeargument name="label" value="#form.label#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
            <cfinvokeargument name="period" value="#form.poption#">
		</cfinvoke>
	</cfcase>
</cfswitch>

        
        <cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

		<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
		  		<Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
			 	<Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
		  		<Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s27">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
                
                  <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>

		  		</Style>
                
                <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>


		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="200.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
 <cfoutput>

 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
	<cfif isdefined("form.include")>
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">SERVICE BY MONTH REPORT (Included DN/CN)</Data></Cell>
    <cfelse>
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">SERVICE BY MONTH REPORT (Excluded DN/CN)</Data></Cell>
	</cfif>
	</Row>
    
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">
        
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</Data></Cell>
    </Row>
   
  
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">AGENT: #wddxText#</Data></Cell>
    </Row>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">AREA: #wddxText#</Data></Cell>
    </Row>
    </cfif>
	
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
                <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText2">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
    </Row>
    
      <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
      	<Cell ss:StyleID="s50"><Data ss:Type="String">SERVICES NO.</Data></Cell>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">DESP</Data></Cell>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<Cell ss:StyleID="s50"><Data ss:Type="String">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</Data></Cell>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">TOTAL</Data></Cell>
    </Row>
   
	<cfloop query="getitem">
		  <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText3">
                <cfwddx action = "cfml2wddx" input = "#getitem.servi#" output = "wddxText4">
                <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText5">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.sump1,stDecl_UPrice)#" output = "wddxText6">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.sump3,stDecl_UPrice)#" output = "wddxText7">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.sump4,stDecl_UPrice)#" output = "wddxText8">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.sump5,stDecl_UPrice)#" output = "wddxText9">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.sump6,stDecl_UPrice)#" output = "wddxText10">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getitem.total,stDecl_UPrice)#" output = "wddxText11">
                
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#.</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>

			<cfswitch expression="#form.period#">
				<cfcase value="1,2,3" delimiters=",">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfcase>
                <cfcase value="5">
                  <Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump1,stDecl_UPrice)#</Data></Cell>
                <cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
				<cfset grandtotal = grandtotal + getitem.total>
                </cfcase>
				<cfdefaultcase>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump1,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump2,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump3,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump4,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump5,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump6,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump7,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump8,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump9,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump10,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump11,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump12,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump13,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump14,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump15,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump16,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump17,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.sump18,stDecl_UPrice)#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(getitem.total,stDecl_UPrice)#</Data></Cell>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset monthtotal[7] = monthtotal[7] + getitem.sump7>
					<cfset monthtotal[8] = monthtotal[8] + getitem.sump8>
					<cfset monthtotal[9] = monthtotal[9] + getitem.sump9>
					<cfset monthtotal[10] = monthtotal[10] + getitem.sump10>
					<cfset monthtotal[11] = monthtotal[11] + getitem.sump11>
					<cfset monthtotal[12] = monthtotal[12] + getitem.sump12>
					<cfset monthtotal[13] = monthtotal[13] + getitem.sump13>
					<cfset monthtotal[14] = monthtotal[14] + getitem.sump14>
					<cfset monthtotal[15] = monthtotal[15] + getitem.sump15>
					<cfset monthtotal[16] = monthtotal[16] + getitem.sump16>
					<cfset monthtotal[17] = monthtotal[17] + getitem.sump17>
					<cfset monthtotal[18] = monthtotal[18] + getitem.sump18>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfdefaultcase>
			</cfswitch>
		</Row>
	</cfloop>
    
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
            </Row>
    
    
	
    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    	<Cell ss:StyleID="s38"><Data ss:Type="String">TOTAL:</Data></Cell>
		<cfswitch expression="#form.period#">
			<cfcase value="1,2,3" delimiters=",">
				<cfloop index="a" from="1" to="6">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(monthtotal[a],stDecl_UPrice)#</Data></Cell>
				</cfloop>
			</cfcase>

			<cfdefaultcase>
				<cfloop index="a" from="1" to="18">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#numberformat(monthtotal[a],stDecl_UPrice)#</Data></Cell>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
		<Cell ss:StyleID="s38"><Data ss:Type="String">#numberformat(grandtotal,stDecl_UPrice)#</Data></Cell>
	</Row>
</cfoutput>

        </Table>
		 	
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

            <cfcase value="HTML">


<html>
<head>
<title>Product Service By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
	<cfif isdefined("form.include")>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE BY MONTH REPORT (Included DN/CN)</strong></font></div></td>
    <cfelse>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE BY MONTH REPORT (Excluded DN/CN)</strong></font></div></td>
	</cfif>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">PERIOD #form.Poption#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</font></div>
	  	</td>
    </tr>
   
  
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
        </tr>
    </cfif>
    <cfif form.areafrom neq "" and form.areato neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
        </tr>
    </cfif>
	
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">SERVICES NO.</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">DESP</font></td>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>

	<cfloop query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.servi#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></td>

			<cfswitch expression="#form.period#">
				<cfcase value="1,2,3" delimiters=",">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump2,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump3,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump4,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump5,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump6,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.total,stDecl_UPrice)#</font></div></td>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfcase>
                <cfcase value="5">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
                <cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
				<cfset grandtotal = grandtotal + getitem.total>
                </cfcase>
				<cfdefaultcase>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump1,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump2,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump3,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump4,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump5,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump6,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump7,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump8,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump9,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump10,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump11,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump12,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump13,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump14,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump15,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump16,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump17,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.sump18,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.total,stDecl_UPrice)#</font></div></td>
					<cfset monthtotal[1] = monthtotal[1] + getitem.sump1>
					<cfset monthtotal[2] = monthtotal[2] + getitem.sump2>
					<cfset monthtotal[3] = monthtotal[3] + getitem.sump3>
					<cfset monthtotal[4] = monthtotal[4] + getitem.sump4>
					<cfset monthtotal[5] = monthtotal[5] + getitem.sump5>
					<cfset monthtotal[6] = monthtotal[6] + getitem.sump6>
					<cfset monthtotal[7] = monthtotal[7] + getitem.sump7>
					<cfset monthtotal[8] = monthtotal[8] + getitem.sump8>
					<cfset monthtotal[9] = monthtotal[9] + getitem.sump9>
					<cfset monthtotal[10] = monthtotal[10] + getitem.sump10>
					<cfset monthtotal[11] = monthtotal[11] + getitem.sump11>
					<cfset monthtotal[12] = monthtotal[12] + getitem.sump12>
					<cfset monthtotal[13] = monthtotal[13] + getitem.sump13>
					<cfset monthtotal[14] = monthtotal[14] + getitem.sump14>
					<cfset monthtotal[15] = monthtotal[15] + getitem.sump15>
					<cfset monthtotal[16] = monthtotal[16] + getitem.sump16>
					<cfset monthtotal[17] = monthtotal[17] + getitem.sump17>
					<cfset monthtotal[18] = monthtotal[18] + getitem.sump18>
					<cfset grandtotal = grandtotal + getitem.total>
				</cfdefaultcase>
			</cfswitch>
		</tr>
	</cfloop>
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td></td>
		<td></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<cfswitch expression="#form.period#">
			<cfcase value="1,2,3" delimiters=",">
				<cfloop index="a" from="1" to="6">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[a],stDecl_UPrice)#<strong></strong></font></div></td>
				</cfloop>
			</cfcase>

			<cfdefaultcase>
				<cfloop index="a" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[a],stDecl_UPrice)#<strong></strong></font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grandtotal,stDecl_UPrice)#</strong></font></div></td>
	</tr>
</table>
</cfoutput>

<cfif getitem.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>