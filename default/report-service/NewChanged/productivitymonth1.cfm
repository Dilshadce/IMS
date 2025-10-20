<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>


		<cfset stDecl_UPrice = getgeneral.decl_uprice>'
        
        
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
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="80.75"/>
					<Column ss:Width="150.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
 <cfoutput>
 
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"> PRODUCTIVITY REPORT BY MONTH REPORT</Data></Cell>
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
    
    
    <cfswitch expression="#form.period#">
    <cfcase value="1">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
    
    
    where fperiod >='01' and fperiod <='06'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
  
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="2">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8
 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='07' and fperiod <='12'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
   
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="3">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='13' and fperiod <='18'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="4">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='01' and fperiod <='18'
    and linecode ='SV'
    
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
  
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="5">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod = '#form.poption#'
    and linecode ='SV'
    and ((a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#') or (b.multiagent1 >='#form.agentfrom#' and b.multiagent1 <= '#form.agentto#') or (c.multiagent2 >='#form.agentfrom#' and c.multiagent2 <= '#form.agentto#') or (d.multiagent3 >='#form.agentfrom#' and d.multiagent3 <= '#form.agentto#') or (e.multiagent4 >='#form.agentfrom#' and e.multiagent4 <= '#form.agentto#') or (f.multiagent5 >='#form.agentfrom#' and f.multiagent5 <= '#form.agentto#') or (g.multiagent6 >='#form.agentfrom#' and g.multiagent6 <= '#form.agentto#') or (h.multiagent7 >='#form.agentfrom#' and h.multiagent7 <= '#form.agentto#') or (i.multiagent8 >='#form.agentfrom#' and i.multiagent8 <= '#form.agentto#')  )
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
 
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>

    </cfcase>
    </cfswitch>
    
   <cfif form.servicefrom neq "" and form.serviceto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.servicefrom# - #form.serviceto#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">Service: #wddxText#</Data></Cell>
	</Row>
    </cfif>
  
    <cfif form.agentfrom neq "" and form.agentto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">AGENT: #wddxText#</Data></Cell>
	</Row>
    </cfif>
    
    <cfif form.areafrom neq "" and form.areato neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">AREA: #wddxText#</Data></Cell>
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
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
    </Row>
   
    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
      	<Cell ss:StyleID="s50"><Data ss:Type="String">DATE</Data></Cell>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">TYPE</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">REF No</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">Customer Name</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Agent</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Business</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Area</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Hrs Work</Data></Cell>
        <Cell ss:StyleID="s50"><Data ss:Type="String">Remarks</Data></Cell>
	  	<Cell ss:StyleID="s50"><Data ss:Type="String">Amount</Data></Cell>
    </Row>
  
<cfset sumqty=0>
	<cfloop query="getitem">
    
    <cfquery name="getbusiness" datasource="#dts#">
    select * from #target_arcust#  where custno = '#getitem.custno#'
    </cfquery>
    
    <cfquery name="getarea" datasource="#dts#">
    select van from artran  where refno = '#getitem.refno#'
    </cfquery>
    <cfif getitem.agenno neq "" and getitem.agenno gte form.agentfrom and getitem.agenno lte form.agentto >
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText3">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText4">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText5">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText6">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText7">
                <cfwddx action = "cfml2wddx" input = "#agenno#" output = "wddxText8">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText9">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText10">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText11">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText12">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText13">

			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
		</Row>
         <cfset sumqty = sumqty + getitem.qty_bil>
        </cfif>
        <cfif getitem.multiagent1 neq "" and getitem.multiagent1 gte form.agentfrom and getitem.multiagent1 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText14">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText15">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText16">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText17">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText18">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent1#" output = "wddxText19">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText20">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText21">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText22">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText23">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText24">
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText17#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText18#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText19#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText20#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText21#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText22#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText23#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText24#</Data></Cell>
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    <cfif getitem.multiagent2 neq "" and getitem.multiagent2 gte form.agentfrom and getitem.multiagent2 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText25">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText26">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText27">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText28">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText29">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent2#" output = "wddxText30">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText31">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText32">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText33">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText34">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText35">
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText25#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText26#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText27#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText28#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText29#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText30#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText31#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText32#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText33#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText34#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText35#</Data></Cell>
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
         <cfif getitem.multiagent3 neq "" and getitem.multiagent3 gte form.agentfrom and getitem.multiagent3 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText36">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText37">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText38">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText39">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText40">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent3#" output = "wddxText41">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText42">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText43">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText44">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText45">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText46">
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText36#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText37#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText38#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText39#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText40#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText41#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText42#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText43#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText44#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText45#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText46#</Data></Cell>
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent4 neq "" and getitem.multiagent4 gte form.agentfrom and getitem.multiagent4 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        
                 <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText47">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText48">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText49">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText50">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText51">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent4#" output = "wddxText52">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText53">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText54">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText55">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText56">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText57">

			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText47#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText48#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText49#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText50#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText51#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText52#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText53#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText54#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText55#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText56#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText57#</Data></Cell>
					
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent5 neq "" and getitem.multiagent5 gte form.agentfrom and getitem.multiagent5 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText58">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText59">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText60">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText61">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText62">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent5#" output = "wddxText63">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText64">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText65">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText66">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText67">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText68">

			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText58#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText59#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText60#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText61#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText62#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText63#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText64#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText65#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText66#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText67#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText68#</Data></Cell>
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
        
         <cfif getitem.multiagent6 neq "" and getitem.multiagent6 gte form.agentfrom and getitem.multiagent6 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
        
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText69">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText70">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText71">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText72">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText73">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent6#" output = "wddxText74">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText75">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText76">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText77">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText78">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText79">
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText70#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText71#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText72#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText73#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText74#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText75#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText76#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText77#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText78#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText79#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText80#</Data></Cell>
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent7 neq "" and getitem.multiagent7 gte form.agentfrom and getitem.multiagent7 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText80">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText81">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText82">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText83">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText84">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent7#" output = "wddxText85">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText86">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText87">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText88">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText89">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText90">
        
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText80#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText81#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText82#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText83#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText84#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText85#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText86#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText87#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText88#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText89#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText90#</Data></Cell>
					
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent8 neq "" and getitem.multiagent8 gte form.agentfrom and getitem.multiagent8 lte form.agentto >

		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText91">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText92">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText93">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText94">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText95">
                <cfwddx action = "cfml2wddx" input = "#getitem.multiagent8#" output = "wddxText96">
                <cfwddx action = "cfml2wddx" input = "#getbusiness.business#" output = "wddxText97">
                <cfwddx action = "cfml2wddx" input = "#getarea.van#" output = "wddxText98">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText99">
                <cfwddx action = "cfml2wddx" input = "#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#" output = "wddxText100">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText101">
        
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText91#.</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText92#</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText93#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText94#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText95#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText96#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText97#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText98#</Data></Cell>
           <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText99#</Data></Cell>
            <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText100#</Data></Cell>
           <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText101#</Data></Cell>
					
		</Row>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
   
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
		    <Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>


    </Row>
    
	
        <cfif form.agentfrom eq form.agentto>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#sumqty#" output = "wddxText102">
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    		<Cell ss:StyleID="s26"><Data ss:Type="String">Total hrs of work</Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
			<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
		    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText102#</Data></Cell>

    </Row>
        </cfif>
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
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> PRODUCTIVITY REPORT BY MONTH REPORT</strong></font></div></td>
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
    
    
    <cfswitch expression="#form.period#">
    <cfcase value="1">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
    
    
    where fperiod >='01' and fperiod <='06'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
  
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="2">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8
 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='07' and fperiod <='12'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
   
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="3">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='13' and fperiod <='18'
    and linecode ='SV'
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="4">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod >='01' and fperiod <='18'
    and linecode ='SV'
    
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
  
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>
    </cfcase>
    
    <cfcase value="5">
    <cfquery name="getitem" datasource="#dts#">
    select a.*,b.multiagent1,c.multiagent2,d.multiagent3,e.multiagent4,f.multiagent5,g.multiagent6,h.multiagent7,i.multiagent8 from ictran as a 
    left join (select multiagent1,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent1 >='#form.agentfrom#' and multiagent1 <= '#form.agentto#'
		</cfif>

    )as b on b.refno=a.refno 
    
    left join (select multiagent2,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "" >
			and multiagent2 >='#form.agentfrom#' and multiagent2 <= '#form.agentto#'
		</cfif>

    )as c on c.refno=a.refno 
    
    left join (select multiagent3,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent3 >='#form.agentfrom#' and multiagent3 <= '#form.agentto#'
		</cfif>

    )as d on d.refno=a.refno 
    
    left join (select multiagent4,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent4 >='#form.agentfrom#' and multiagent4 <= '#form.agentto#'
		</cfif>

    )as e on e.refno=a.refno 
    
    left join (select multiagent5,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent5 >='#form.agentfrom#' and multiagent5 <= '#form.agentto#'
		</cfif>

    )as f on f.refno=a.refno 
    
    left join (select multiagent6,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent6 >='#form.agentfrom#' and multiagent6 <= '#form.agentto#'
		</cfif>

    )as g on g.refno=a.refno 
    
    left join (select multiagent7,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent7 >='#form.agentfrom#' and multiagent7 <= '#form.agentto#'
		</cfif>

    )as h on h.refno=a.refno 
    
    left join (select multiagent8,refno from artran where 0=0 
		
		<cfif form.agentfrom neq "" and form.agentto neq "">
			and multiagent8 >='#form.agentfrom#' and multiagent8 <= '#form.agentto#'
		</cfif>

    )as i on i.refno=a.refno 
    
   
    
    where fperiod = '#form.poption#'
    and linecode ='SV'
    and ((a.agenno >='#form.agentfrom#' and a.agenno <= '#form.agentto#') or (b.multiagent1 >='#form.agentfrom#' and b.multiagent1 <= '#form.agentto#') or (c.multiagent2 >='#form.agentfrom#' and c.multiagent2 <= '#form.agentto#') or (d.multiagent3 >='#form.agentfrom#' and d.multiagent3 <= '#form.agentto#') or (e.multiagent4 >='#form.agentfrom#' and e.multiagent4 <= '#form.agentto#') or (f.multiagent5 >='#form.agentfrom#' and f.multiagent5 <= '#form.agentto#') or (g.multiagent6 >='#form.agentfrom#' and g.multiagent6 <= '#form.agentto#') or (h.multiagent7 >='#form.agentfrom#' and h.multiagent7 <= '#form.agentto#') or (i.multiagent8 >='#form.agentfrom#' and i.multiagent8 <= '#form.agentto#')  )
    <cfif form.trantype neq "" >
				and type ='#form.trantype#'
				</cfif>
 
				<cfif trim(form.areafrom) neq "" and trim(form.areato) neq "">
				and area >='#form.areafrom#' and area <= '#form.areato#'
				</cfif>
				<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
    order by wos_date
    </cfquery>

    </cfcase>
    </cfswitch>
   <cfif form.servicefrom neq "" and form.serviceto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service: #form.servicefrom# - #form.serviceto#</font></div></td>
        </tr>
    </cfif>
  
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
      	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REF No</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">Customer Name</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Agent</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Business</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Area</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Hrs Work</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Remarks</font></td>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
<cfset sumqty=0>
	<cfloop query="getitem">
    
    <cfquery name="getbusiness" datasource="#dts#">
    select * from #target_arcust#  where custno = '#getitem.custno#'
    </cfquery>
    
    <cfquery name="getarea" datasource="#dts#">
    select van from artran  where refno = '#getitem.refno#'
    </cfquery>
    <cfif getitem.agenno neq "" and getitem.agenno gte form.agentfrom and getitem.agenno lte form.agentto >
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#agenno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
         <cfset sumqty = sumqty + getitem.qty_bil>
        </cfif>
        <cfif getitem.multiagent1 neq "" and getitem.multiagent1 gte form.agentfrom and getitem.multiagent1 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent1#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
   
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    <cfif getitem.multiagent2 neq "" and getitem.multiagent2 gte form.agentfrom and getitem.multiagent2 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent2#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
         <cfif getitem.multiagent3 neq "" and getitem.multiagent3 gte form.agentfrom and getitem.multiagent3 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent3#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
    
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent4 neq "" and getitem.multiagent4 gte form.agentfrom and getitem.multiagent4 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
    
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
     <cfif getitem.multiagent5 neq "" and getitem.multiagent5 gte form.agentfrom and getitem.multiagent5 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent5#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
        
         <cfif getitem.multiagent6 neq "" and getitem.multiagent6 gte form.agentfrom and getitem.multiagent6 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent6#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent7 neq "" and getitem.multiagent7 gte form.agentfrom and getitem.multiagent7 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent7#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
    
     <cfif getitem.multiagent8 neq "" and getitem.multiagent8 gte form.agentfrom and getitem.multiagent8 lte form.agentto >

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.multiagent8#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getbusiness.business#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getarea.van#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>

            <td><font size="2" face="Times New Roman, Times, serif">#getitem.brem1# #getitem.brem2# #getitem.brem3# #getitem.brem4#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
 <cfset sumqty = sumqty + getitem.qty_bil>
    </cfif>
   
	</cfloop>
    
    
	<tr>
    	<td colspan="25"><hr></td>
    </tr>
        <cfif form.agentfrom eq form.agentto>
    <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td colspan="3">Total hrs of work</td>

    <td>#sumqty#</td>

    </tr>
        </cfif>
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