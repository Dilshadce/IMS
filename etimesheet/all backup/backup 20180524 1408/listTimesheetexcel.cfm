<cfscript>
	pathToOutFile = ExpandPath("/etimesheetreport/timesheetreport_#HUserID#.xls");


	//headerList = "No, Employee No,Employee Name,Timesheet Status,Client No,Cleint Name,Submitted Date,Approval Date";
	
	//create a new workbook and worksheet
	book = createObject("java", "org.apache.poi.hssf.usermodel.HSSFWorkbook").init();
	HSSFPrintSetup = createObject("java","org.apache.poi.hssf.usermodel.HSSFPrintSetup");
	HSSFCellStyle = createObject("java","org.apache.poi.hssf.usermodel.HSSFCellStyle");
	HSSFFont = createObject("java","org.apache.poi.hssf.usermodel.HSSFFont");
	HSSFDataFormat = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataFormat");
	HSSFFooter = createObject("java","org.apache.poi.hssf.usermodel.HSSFFooter");
	region = createObject("java","org.apache.poi.hssf.util.Region");
	//HSSFName = createObject("java","org.apache.poi.hssf.usermodel.HSSFName");
	
	sheet = book.createSheet(p2Header);
	sheet.setColumnWidth(0,2600);  //A/C No
	sheet.setColumnWidth(1,3500);  //A/C DESCRIPTION
	sheet.setColumnWidth(2,2000);  //
	sheet.setColumnWidth(3,2000);  //
	sheet.setColumnWidth(4,3000);  //YEAR-TO-DATE DEBIT
	sheet.setColumnWidth(5,1000);  //
	sheet.setColumnWidth(6,3000);  //YEAR-TO-DATE CREDIT
	sheet.setColumnWidth(7,1000);  //
	sheet.setColumnWidth(8,3000);  //MONTH-TO-DATE DEBIT
	//sheet.setColumnWidth(9,1000);	//
	//sheet.setColumnWidth(10,3000);	//MONTH-TO-DATE CREDIT
	
	
	footer = sheet.getFooter();
	footer.setCenter(HSSFFooter.date());
	footer.setRight("Page " & HSSFFooter.page() & " of " & HSSFFooter.numPages());

	//sheet.SetDefaultColumnWidth(JavaCast( "int", 10 ));
	//sheet.SetDefaultRowHeight(330);
	
	//RowOffset = -1;
	sheet.setMargin(sheet.LeftMargin,0.6);
	sheet.setMargin(sheet.RightMargin,0.75);
	sheet.setMargin(sheet.TopMargin,0.75);
	sheet.setMargin(sheet.BottomMargin,0.99);
	//sheet.setFitToPage(JavaCast("boolean",true));
	
	book.setRepeatingRowsAndColumns(0,0,9,9,9);
	
	ps = sheet.getPrintSetup();
	ps.setPaperSize(HSSFPrintSetup.LEGAL_PAPERSIZE);
	ps.setLandscape(JavaCast("boolean",true));
	//ps.setScale(scale);
	//ps.setFitHeight(1);
	//ps.setFitWidth(1);
	
	//Font Style
	font = book.createFont();
	font.setFontName("Arial");
	font.setBoldWeight(HSSFFont.BOLDWEIGHT_BOLD);
	font.setFontHeightInPoints(9);
	
	font2 = book.createFont();
	font2.setFontName("Arial");
	font2.setFontHeightInPoints(8);
	
	font3 = book.createFont();
	font3.setFontName("Arial");
	font3.setBoldWeight(HSSFFont.BOLDWEIGHT_BOLD);
	font3.setFontHeightInPoints(15);
	
	mTitle = book.createCellStyle();  
	mTitle.setFont(font3);
	mTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	
	sTitle = book.createCellStyle();  
	sTitle.setFont(font2);
	sTitle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	
	sGroup = book.createCellStyle();  
	sGroup.setFont(font);
	sGroup.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	
	sDate = book.createCellStyle();  
	sDate.setFont(font2);
	sDate.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	
	sAddress = book.createCellStyle();  
	sAddress.setFont(font2);
	sAddress.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	
	sHeader = book.createCellStyle();
	sHeader.setFont(font);
	sHeader.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	sHeader.setBorderTop(HSSFCellStyle.BORDER_THIN);
	sHeader.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	sHeader.setVerticalAlignment(HSSFCellStyle.VERTICAL_JUSTIFY);
	
	sFooter = book.createCellStyle();
	sFooter.setFont(font);
	sFooter.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	sFooter.setVerticalAlignment(HSSFCellStyle.VERTICAL_JUSTIFY);
	sFooter.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	
	sBodyNumber = book.createCellStyle();
	sBodyNumber.setFont(font2);
	sBodyNumber.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	
	sBodyPrice = book.createCellStyle();
	sBodyPrice.setFont(font2);
	sBodyPrice.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sBodyPrice.setDataFormat("7");
	sBodyPrice.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum
	
	sBodyString = book.createCellStyle();
	sBodyString.setFont(font2);
	sBodyString.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	sBodyString.SetWrapText(JavaCast( "boolean", true ));
	
	sTotal = book.createCellStyle();
	sTotal.setFont(font2);
	sTotal.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	sTotal.setDataFormat("7");
	sTotal.setBorderTop(HSSFCellStyle.BORDER_THIN);
	
	sTotalAmt = book.createCellStyle();
	sTotalAmt.setFont(font2);
	sTotalAmt.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	//sTotalAmt.setDataFormat("7");
	sTotalAmt.setBorderTop(HSSFCellStyle.BORDER_THIN);
	sTotalAmt.setBorderBottom(HSSFCellStyle.BORDER_DOUBLE);
	sTotalAmt.setDataFormat(HSSFDataFormat.getBuiltinFormat("(##,####0.00_);(##,####0.00)"));//lum
	
	sAdd = book.createCellStyle();  
	sAdd.setFont(font);
	sAdd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	
	sLine = book.createCellStyle();
	sLine.setFont(font2);
	sLine.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	sLine.setBorderTop(HSSFCellStyle.BORDER_THIN);
	
	count = 0;
	count = count + 1;
	sheet.addMergedRegion( region.init(count,3,count,10));
	if(getgsetup.comproashead eq "on"){
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xcompro));
	cell.setCellStyle(mTitle);
	}else{
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",x2compro));
	cell.setCellStyle(mTitle);
	}
	//create row
	count = count + 1;
	row = sheet.createRow(javacast("int",count));
	//merge row
	sheet.addMergedRegion( region.init(count,3,count,8));
	//add value
	if(getgsetup.comproashead eq "on"){
	cell = row.createCell(3);
	if(xcomuen neq ""){
	cell.setCellValue(javacast("string","Company UEN :"&xcomuen));}
	cell.setCellStyle(sAdd);
	}else{
	cell = row.createCell(3);
	if(x2comuen neq ""){
	cell.setCellValue(javacast("string","Company UEN :"&x2comuen));}
	cell.setCellStyle(sAdd);
	}
	
	count = count + 1;
	row = sheet.createRow(javacast("int",count));
	sheet.addMergedRegion( region.init(count,3,count,8));
	
	if(getgsetup.comproashead eq "on"){
	cell = row.createCell(3);
	if(xgstno neq ""){
	cell.setCellValue(javacast("string","GST Registration No. :"&xgstno));}
	cell.setCellStyle(sAdd);
	}else{
	cell = row.createCell(3);
	if(x2gstno neq ""){
	cell.setCellValue(javacast("string","GST Registration No. :"&x2gstno));}
	cell.setCellStyle(sAdd);
	}
	
	count = count + 2;
	sheet.addMergedRegion( region.init(count,3,count,8));
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xcompro2));
	cell.setCellStyle(sAdd);
    
    count = count + 1;
    sheet.addMergedRegion( region.init(count,3,count,8));
    row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xcompro3));
	cell.setCellStyle(sAdd);
	
	count = count + 1;
	sheet.addMergedRegion( region.init(count,3,count,8));
    row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xcompro4));
	cell.setCellStyle(sAdd);
    
    count = count + 1;
    sheet.addMergedRegion( region.init(count,3,count,8));
    row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xcompro5));
	cell.setCellStyle(sAdd);
	
    count = count + 2;
    sheet.addMergedRegion( region.init(count,3,count,8));
    row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",pheaderforpdf));
	cell.setCellStyle(sAdd);    
 
	count = count + 1;
    sheet.addMergedRegion( region.init(count,3,count,8));
    row = sheet.createRow(javacast("int",count));
	cell = row.createCell(3);
	cell.setCellValue(javacast("string",xdate1));
	cell.setCellStyle(sAdd); 
	
	count = count + 1;
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(4);
	cell.setCellValue(javacast("string","YEAR-TO-DATE"));
	cell.setCellStyle(sGroup);

	if(not isdefined("form.trialbalancecheck1")){

	cell = row.createCell(8);
	cell.setCellValue(javacast("string","MONTH-TO-DATE"));
	cell.setCellStyle(sGroup);
	}
	
	count = count + 1;
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(0);
	cell.setCellValue(javacast("string","A/C No."));
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(1);
	cell.setCellValue(javacast("string","A/C DESCRIPTION"));
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(2);
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(3);
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(4);
	if((left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a")){
		cell.setCellValue(javacast("string",""));
	}else{
		cell.setCellValue(javacast("string","DEBIT"));
	}
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(5);
	cell.setCellStyle(sFooter);
	
	
	cell = row.createCell(6);
	if((left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a")){
		cell.setCellValue(javacast("string",""));
	}else{
		cell.setCellValue(javacast("string","CREDIT"));
	}
	cell.setCellStyle(sFooter);
	
	if(not isdefined("form.trialbalancecheck1")){
	cell = row.createCell(7);
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(8);
	if((left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a")){
		cell.setCellValue(javacast("string",""));
	}else{
		cell.setCellValue(javacast("string","DEBIT"));
	}
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(9);
	cell.setCellStyle(sFooter);
	
	cell = row.createCell(10);
	if((left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a")){
		cell.setCellValue(javacast("string",""));
	}else{
		cell.setCellValue(javacast("string","CREDIT"));
	}
	cell.setCellStyle(sFooter);
	}
	//var totaldebit1=0
	
for(j=1; j LTE gettemp.recordcount; j=j+1) {
	

	count = count + 1;
	row = sheet.createRow(javacast("int",count));
	cell = row.createCell(0);
	cell.setCellValue(javacast("string",gettemp["accno"][j]));
	cell.setCellStyle(sTitle);
 
	sheet.addMergedRegion( region.init(count,1,count,3));
	cell = row.createCell(1);
	cell.setCellValue(javacast("string",gettemp["desp"][j]));
	cell.setCellStyle(sTitle);
 
    if (gettemp["desp"][j] eq "TOTAL:"){
	sheet.addMergedRegion( region.init(count,1,count,3));
	cell = row.createCell(1);
	cell.setCellValue(javacast("string",gettemp["desp"][j]));
	cell.setCellStyle(sLine);
	
	cell = row.createCell(2);
	cell.setCellStyle(sLine);
	
	cell = row.createCell(3);
	cell.setCellStyle(sLine);
	}
	
    
	
	if(left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a"){
		cell = row.createCell(4);
		if(gettemp["tdebit"][j] eq "")	{
			cell.setCellValue(javacast("string",""));
		}else{
			cell.setCellValue(javacast("double",(val(gettemp["tdebit"][j])-val(gettemp["tcredit"][j]))));
		}
		if (gettemp["desp"][j] eq "TOTAL:"){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}	
		cell = row.createCell(6);
		if(j EQ gettemp.recordcount){
		cell.setCellStyle(sLine);}
	}else{
		cell = row.createCell(4);
		if(gettemp["tdebit"][j] eq ""){
			cell.setCellValue(javacast("string",""));	
		}else{
			cell.setCellValue(javacast("double",val(gettemp["tdebit"][j])));
		}
		if (j EQ gettemp.recordcount){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}
	
		cell = row.createCell(6);
		if(gettemp["tcredit"][j] eq ""){
			cell.setCellValue(javacast("string",""));	
		}else{
			cell.setCellValue(javacast("double",val(gettemp["tcredit"][j])));
		}
		if (gettemp["desp"][j] eq "TOTAL:"){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}
	}
	if(not isdefined("form.trialbalancecheck1")){
	if(left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a" or dts eq "mkrltd_a"){
		cell = row.createCell(8);
		if(gettemp["tmdebit"][j] eq "")	{
			cell.setCellValue(javacast("string",""));
		}else{
			cell.setCellValue(javacast("double",(val(gettemp["tmdebit"][j])-val(gettemp["tmcredit"][j]))));
		}
		if (j EQ gettemp.recordcount){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}	
		cell = row.createCell(10);
		if(j EQ gettemp.recordcount){
		cell.setCellStyle(sLine);}		
	}else{
		cell = row.createCell(8);
		if(gettemp["tmdebit"][j] eq ""){
			cell.setCellValue(javacast("string",""));	
		}else{
			cell.setCellValue(javacast("double",val(gettemp["tmdebit"][j])));
		}
		if (gettemp["desp"][j] eq "TOTAL:"){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}
		
		cell = row.createCell(10);
		if(gettemp["tmcredit"][j] eq ""){
			cell.setCellValue(javacast("string",""));	
		}else{
			cell.setCellValue(javacast("double",val(gettemp["tmcredit"][j])));
		}
		if (gettemp["desp"][j] eq "TOTAL:"){
			cell.setCellStyle(sTotalAmt);
			}else{
			cell.setCellStyle(sBodyPrice);
			}
	}//if(left(dts,5) eq "tdint" or left(dts,4) eq "djcs" or dts eq "clsimtest_a")
	}//if(not isdefined("form.trialbalancecheck1"))
}//for(j=1; j LTE gettemp.recordcount; j=j+1)
	//gettemp
	
	cell = row.createCell(0);
	cell.setCellStyle(sLine);
	cell = row.createCell(5);
	cell.setCellStyle(sLine);
	cell = row.createCell(7);
	cell.setCellStyle(sLine);
	cell = row.createCell(9);
	cell.setCellStyle(sLine);
	
	  
		
	//write the file to disk
	outFile = createObject("java", "java.io.FileOutputStream").init( pathToOutFile );
	book.write( outFile );
	outFile.close();

	WriteOutput("Done!");
</cfscript>

<cfheader name="Content-Disposition" value="inline; filename=etimesheetreport_&#datetimeformat(now(), 'ddmmyyyy HH:nn:ss')#.xls"> 
<cfcontent type="application/vnd.ms-excel" file="#pathToOutFile#">
