<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "558,100,557,23,16,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.attentionNo')>
	<cfset URLattentionNo = trim(urldecode(url.attentionNo))>
</cfif>


<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT attentionno 
            FROM attention
			WHERE attentionno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionNo)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.attentionNo)# already exist!');
				window.open('/latest/maintenance/attention.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createAttention" datasource="#dts#">
					INSERT INTO attention  (attentionno,salutation,name,customerno,phone,phonea,c_email,title2,designation,
                    					   	b_add1,b_add2,b_add3,b_add4,b_city,b_state,b_country,b_postalcode,
                    						o_add1,o_add2,o_add3,o_add4,o_city,o_state,o_country,o_postalcode,
                    						business,assistant,asst_phone,department,description,
                    						dob,contactgroup,category,commodity)
					VALUES

					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.salutation)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phonea)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.c_email)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.title)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.designation)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.city)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.state)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.country)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.postalCode)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add4)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_city)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_state)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_country)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_postalcode)#">,
      
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.business)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.assistant)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.assistantPhone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.department)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.description)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.dob)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.contactGroup)#">,
                 		<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerCategory)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.commodity)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.attentionNo)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/attention.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.attentionNo)# has been created successfully!');
				window.open('/latest/maintenance/attentionProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateAttention" datasource="#dts#">
				UPDATE attention
				SET
					
                   	attentionno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.attentionNo#">,
                    salutation=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.salutation#">,
					name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
                    customerno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerNo#">,
                    phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
                    phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonea#">,
                    c_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.c_email#">,
                    title2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title#">,
                    designation=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.designation#">,
                    
                    b_add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add1#">,
                    b_add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add2#">,
                    b_add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add3#">,
                    b_add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.add4#">,
                    b_city=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.city#">,
                    b_state=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.state#">,
                    b_country=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.country#">,
                    b_postalcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.postalCode#">,
                                        
                    o_add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_add1#">,
                    o_add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_add2#">,
                    o_add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_add3#">,
                    o_add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_add4#">,
                    o_city=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_city#">,
                    o_state=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_state#">,
                    o_country=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_country#">,
                    o_postalcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.d_postalcode#">,
                    
                    business=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.business#">,
                    assistant=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistant#">,
                    asst_phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assistantPhone#">,
                    department=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
                    description=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description#">,
                    
                    dob=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#">,
                    contactgroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactGroup#">,						
					category=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerCategory#">,
                    commodity=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commodity#">
                    
				WHERE attentionno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attentionNo)#">;
			</cfquery>    
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.attentionNo)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/attention.cfm?action=update&attentionNo=#form.attentionNo#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.attentionNo)# successfully!');
			window.open('/latest/maintenance/attentionProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteAttention" datasource="#dts#">
				DELETE FROM attention
				WHERE attentionno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLattentionNo#">;
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLattentionNo#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/attentionProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLattentionNo# successfully!');
			window.open('/latest/maintenance/attentionProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printAttention" datasource="#dts#">
			SELECT attentionno,name,customerno
			FROM attention
			ORDER BY attentionno;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[558]#</title>
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
			<h1 class="text">#words[558]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        <cfoutput>
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[557])#</th>
					<th>#UCase(words[23])#</th>
                    <th>#UCase(words[16])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printAttention">
				<tr>
					<td>#attentionno#</td>
					<td>#name#</td>
                    <td>#customerno#</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		</div>
        </cfoutput>
		<div class="panel-footer">
		<p>#words[101]# #DateFormat(Now(),'dd-mm-yyyy')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
		</div>
		</div>		
		
		</body>
		</html>
    <cfelseif url.action EQ "printexcel">
    <cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
	</cfquery>
        
    <cfquery name="printAttention" datasource="#dts#">
        SELECT *
        FROM attention
        ORDER BY attentionno;
    </cfquery>
    
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
		 	</Styles>
			
			<Worksheet ss:Name="Attention Listing">
				<cfset i=0>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    <Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    <Column ss:Width="60.75"/>
                    <Column ss:Width="60.75"/>
                    <Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
                    
					<cfset c="14">
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<cfoutput>
                    <cfwddx action = "cfml2wddx" input = "Attention Listing" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    <cfwddx action = "cfml2wddx" input = "" output = "wddxText">
                    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                        <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
                    </Row>
					<cfwddx action = "cfml2wddx" input = "" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
					</cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Attention No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Name</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Customer No</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Address 1</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Address 2</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Address 3</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Address 4</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Phone</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Designation</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Phone</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Email</Data></Cell>
                
                </Row>
				   
				<cfoutput query="printAttention" >
        
					<cfwddx action = "cfml2wddx" input = "#i#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#attentionno#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#name#" output = "wddxText3">
					<cfwddx action = "cfml2wddx" input = "#customerno#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#b_add1#" output = "wddxText5">
					<cfwddx action = "cfml2wddx" input = "#b_add2#" output = "wddxText6">
					<cfwddx action = "cfml2wddx" input = "#b_add3#" output = "wddxText7">
					<cfwddx action = "cfml2wddx" input = "#b_add4#" output = "wddxText8">
                    <cfwddx action = "cfml2wddx" input = "#phone#" output = "wddxText9">
                    <cfwddx action = "cfml2wddx" input = "#designation#" output = "wddxText10">
                    <cfwddx action = "cfml2wddx" input = "#phone#" output = "wddxText11">
                    <cfwddx action = "cfml2wddx" input = "#c_email#" output = "wddxText12">
                    
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText11#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText12#</Data></Cell>


					</Row>
				<cfset i = incrementvalue(i)>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="12"/>

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
		<cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
        <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
    
    
    
    
    
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/attentionProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/attentionProfile.cfm','_self');
	</script>
</cfif>