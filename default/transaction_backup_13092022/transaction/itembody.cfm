<cfset refno = urldecode(url.refno)>
<cfset type = url.type>


<cfquery name="getData" datasource="#dts#">
	SELECT ITEMNO,(SELECT REMARK1 FROM ICITEM WHERE ITEMNO=A.ITEMNO)AS REMARK1,DESP,COMMENT,BREM1,BREM2,BREM3,BREM4,LOCATION,QTY,PRICE,DISPEC1,DISPEC2,DISPEC3,NOTE_A,TAXPEC1 FROM ICTRAN AS A WHERE A.REFNO='#refno#' AND A.TYPE=<cfif type eq 'TR'>'TROU'<cfelse>'#type#'</cfif>

    ORDER BY TRANCODE
</cfquery>
<!---
<cfif lcase(HcomID) eq "gramas_i" or lcase(HcomID) eq "kjpe_i" or lcase(HcomID) eq "aipl_i">


 <!---<cfabort>--->
<cfscript>
	pathToOutFile = ExpandPath("/billformat/itembody_#HUserID#.xls");
	//create a new workbook and worksheet
	book = createObject("java", "org.apache.poi.hssf.usermodel.HSSFWorkbook").init();
	HSSFPrintSetup = createObject("java","org.apache.poi.hssf.usermodel.HSSFPrintSetup");
	HSSFCellStyle = createObject("java","org.apache.poi.hssf.usermodel.HSSFCellStyle");
	HSSFFont = createObject("java","org.apache.poi.hssf.usermodel.HSSFFont");
	HSSFDataFormat = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataFormat");
	HSSFFooter = createObject("java","org.apache.poi.hssf.usermodel.HSSFFooter");
	HSSFColor = createObject("java","org.apache.poi.hssf.util.HSSFColor");
	//HSSFName = createObject("java","org.apache.poi.hssf.usermodel.HSSFName");
	region = createObject("java","org.apache.poi.hssf.util.Region");
	HSSFColor$GREY_40_PERCENT = createObject("java","org.apache.poi.hssf.util.HSSFColor$GREY_25_PERCENT");
	
	//DataFormat format = book.createDataFormat();
	sheet = book.createSheet('sheet 1');
	sheet.setColumnWidth(0,5500);	//ITEMNO
	sheet.setColumnWidth(1,7000);	//REMARK1
	sheet.setColumnWidth(2,7000); 	//DESP
	sheet.setColumnWidth(3,6000); 	//COMMENT
	sheet.setColumnWidth(4,6000);	//BREM1
	sheet.setColumnWidth(5,6000);	//BREM2
	sheet.setColumnWidth(6,6000); 	//BREM3
	sheet.setColumnWidth(7,4000);	//BREM4
	sheet.setColumnWidth(8,6000);	//LOCATION
	sheet.setColumnWidth(9,6000);	//QTY
	sheet.setColumnWidth(10,6000);	//PRICE
	sheet.setColumnWidth(11,6000);	//DISPEC1
	sheet.setColumnWidth(12,6000);	//DISPEC2
	sheet.setColumnWidth(13,6000);	//DISPEC3
	sheet.setColumnWidth(14,6000);	//NOTEA
	sheet.setColumnWidth(15,6000);	//TAXPEC

	
	footer = sheet.getFooter();
	footer.setCenter(HSSFFooter.date());
	footer.setRight("Page " & HSSFFooter.page() & " of " & HSSFFooter.numPages());

	//sheet.SetDefaultColumnWidth(JavaCast( "int", 10 ));
	sheet.SetDefaultRowHeight(330);
	
	//RowOffset = -1;
	sheet.setMargin(sheet.LeftMargin,0.6);
	sheet.setMargin(sheet.RightMargin,0.75);
	sheet.setMargin(sheet.TopMargin,0.75);
	sheet.setMargin(sheet.BottomMargin,0.99);
	//sheet.setFitToPage(JavaCast("boolean",true));
	
	//book.setRepeatingRowsAndColumns(0,0,9,9,9);
	
	ps = sheet.getPrintSetup();
	ps.setPaperSize(HSSFPrintSetup.LEGAL_PAPERSIZE);
	ps.setLandscape(JavaCast("boolean",true));
	//ps.setScale(scale);
	//ps.setFitHeight(1);
	//ps.setFitWidth(1);
	
	//Font Style

	
	font2 = book.createFont();
	font2.setFontName("Arial");
	font2.setFontHeightInPoints(10);

	sBody = book.createCellStyle();  
	sBody.setFont(font2);
	sBody.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	//sBody.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum

	sBody2 = book.createCellStyle();  
	sBody2.setFont(font2);
	sBody2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody2.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum

	sBody3 = book.createCellStyle();  
	sBody3.setFont(font2);
	sBody3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody3.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));//lum

	//sBody4 = book.createCellStyle();  
	//sBody4.setFont(font2);
	//sBody4.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody4.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.0000000000_);(##,####0.0000000000)"));//lum
	
	// Create a row and put some cells in it. Rows are 0 based.  
	count = 0;	
	count = count;	
	
	row = sheet.createRow(javacast("int",count));	
		cell = row.createCell(javacast("int",0));
			cell.setCellValue(javacast("string","ITEMNO"));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string","OLD ITEMNO"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string","DESCRIPTION"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string","COMMENT"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string","REMARK 1"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string","REMARK 2"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string","REMARK 3"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string","REMARK 4"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string","LOCATION"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string","QTY"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string","PRICE"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string","DISP 1 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string","DISP 2 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string","DISP 3 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string","TAXCODE"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",15));
		cell.setCellValue(javacast("string","GST %"));
		cell.setCellStyle(sBody);
	
	for(i=1;i lte getData.recordcount;i=i+1){			
	count = count +1;
	
	
	row = sheet.createRow(javacast("int",count));
		cell = row.createCell(javacast("int",0));
		cell.setCellValue(javacast("string",getData["ITEMNO"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string",getData["remark1"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string",getData["DESP"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string",tostring(getData["COMMENT"][i])));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string",getData["BREM1"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string",getData["BREM2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string",getData["BREM3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string",getData["BREM4"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string",getData["LOCATION"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string",getData["QTY"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string",getData["PRICE"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string",getData["DISPEC1"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string",getData["DISPEC2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string",getData["DISPEC3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string",getData["NOTE_A"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",15));
		cell.setCellValue(javacast("string",getData["TAXPEC1"][i]));
		cell.setCellStyle(sBody);
		
	}
	
	//write the file to disk
	outFile = createObject("java", "java.io.FileOutputStream").init( pathToOutFile );
	book.write( outFile );
	outFile.close();

	WriteOutput("Done!");
</cfscript>


<cfelse>
--->
<cfscript>
	pathToOutFile = ExpandPath("/billformat/itembody_#HUserID#.xls");
	//create a new workbook and worksheet
	book = createObject("java", "org.apache.poi.hssf.usermodel.HSSFWorkbook").init();
	HSSFPrintSetup = createObject("java","org.apache.poi.hssf.usermodel.HSSFPrintSetup");
	HSSFCellStyle = createObject("java","org.apache.poi.hssf.usermodel.HSSFCellStyle");
	HSSFFont = createObject("java","org.apache.poi.hssf.usermodel.HSSFFont");
	HSSFDataFormat = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataFormat");
	HSSFFooter = createObject("java","org.apache.poi.hssf.usermodel.HSSFFooter");
	HSSFColor = createObject("java","org.apache.poi.hssf.util.HSSFColor");
	//HSSFName = createObject("java","org.apache.poi.hssf.usermodel.HSSFName");
	region = createObject("java","org.apache.poi.hssf.util.Region");
	HSSFColor$GREY_40_PERCENT = createObject("java","org.apache.poi.hssf.util.HSSFColor$GREY_25_PERCENT");
	
	//DataFormat format = book.createDataFormat();
	
	sheet = book.createSheet('sheet 1');
	sheet.setColumnWidth(0,5500);	//ITEMNO
	sheet.setColumnWidth(1,7000);	//DESP
	sheet.setColumnWidth(2,7000); 	//COMMENT
	sheet.setColumnWidth(3,6000); 	//BREM1
	sheet.setColumnWidth(4,6000);	//BREM2
	sheet.setColumnWidth(5,6000);	//BREM3
	sheet.setColumnWidth(6,6000); 	//BREM4
	sheet.setColumnWidth(7,4000);	//LOCATION
	sheet.setColumnWidth(8,6000);	//QTY
	sheet.setColumnWidth(9,6000);	//PRICE
	sheet.setColumnWidth(10,6000);	//DISPEC1
	sheet.setColumnWidth(11,6000);	//DISPEC2
	sheet.setColumnWidth(12,6000);	//DISPEC3
	sheet.setColumnWidth(13,6000);	//NOTEA
	sheet.setColumnWidth(14,6000);	//TAXPEC

	
	footer = sheet.getFooter();
	footer.setCenter(HSSFFooter.date());
	footer.setRight("Page " & HSSFFooter.page() & " of " & HSSFFooter.numPages());

	//sheet.SetDefaultColumnWidth(JavaCast( "int", 10 ));
	sheet.SetDefaultRowHeight(330);
	
	//RowOffset = -1;
	sheet.setMargin(sheet.LeftMargin,0.6);
	sheet.setMargin(sheet.RightMargin,0.75);
	sheet.setMargin(sheet.TopMargin,0.75);
	sheet.setMargin(sheet.BottomMargin,0.99);
	//sheet.setFitToPage(JavaCast("boolean",true));
	
	//book.setRepeatingRowsAndColumns(0,0,9,9,9);
	
	ps = sheet.getPrintSetup();
	ps.setPaperSize(HSSFPrintSetup.LEGAL_PAPERSIZE);
	ps.setLandscape(JavaCast("boolean",true));
	//ps.setScale(scale);
	//ps.setFitHeight(1);
	//ps.setFitWidth(1);
	
	//Font Style

	
	font2 = book.createFont();
	font2.setFontName("Arial");
	font2.setFontHeightInPoints(10);

	sBody = book.createCellStyle();  
	sBody.setFont(font2);
	sBody.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	//sBody.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum

	sBody2 = book.createCellStyle();  
	sBody2.setFont(font2);
	sBody2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody2.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum

	sBody3 = book.createCellStyle();  
	sBody3.setFont(font2);
	sBody3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody3.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));//lum

	//sBody4 = book.createCellStyle();  
	//sBody4.setFont(font2);
	//sBody4.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBody4.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.0000000000_);(##,####0.0000000000)"));//lum
	
	// Create a row and put some cells in it. Rows are 0 based.  
	count = 0;	
	count = count;	
	
	row = sheet.createRow(javacast("int",count));	
		cell = row.createCell(javacast("int",0));
			cell.setCellValue(javacast("string","ITEMNO"));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string","DESCRIPTION"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string","COMMENT"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string","REMARK 1"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string","REMARK 2"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string","REMARK 3"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string","REMARK 4"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string","LOCATION"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string","QTY"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string","PRICE"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string","DISP 1 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string","DISP 2 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string","DISP 3 %"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string","TAXCODE"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string","GST %"));
		cell.setCellStyle(sBody);

	
	
					
	for(i=1;i lte getData.recordcount;i=i+1){			
	count = count +1;
	
	row = sheet.createRow(javacast("int",count));
		cell = row.createCell(javacast("int",0));
		cell.setCellValue(javacast("string",getData["ITEMNO"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string",getData["DESP"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string",tostring(getData["COMMENT"][i])));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string",getData["BREM1"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string",getData["BREM2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string",getData["BREM3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string",getData["BREM4"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string",getData["LOCATION"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string",getData["QTY"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string",getData["PRICE"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string",getData["DISPEC1"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string",getData["DISPEC2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string",getData["DISPEC3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string",getData["NOTE_A"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string",getData["TAXPEC1"][i]));
		cell.setCellStyle(sBody);
		
	}
	
	//write the file to disk
	outFile = createObject("java", "java.io.FileOutputStream").init( pathToOutFile );
	book.write( outFile );
	outFile.close();

	WriteOutput("Done!");
</cfscript>

<cfoutput>
#pathToOutFile#
</cfoutput>

<cfheader name="Content-Disposition" value="inline; filename=itembody.xls">
<cfcontent type="application/vnd.ms-excel" file="#pathToOutFile#">
