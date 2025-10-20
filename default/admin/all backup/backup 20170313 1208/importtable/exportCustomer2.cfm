<cfquery name="getData" datasource="#dts#">
	SELECT *
    FROM #form.custvpend#
	WHERE 0=0
    <cfif isdefined("form.customerfrom") AND form.customerfrom neq ""> 
    	AND custno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerfrom#">
    </cfif>
    <cfif isdefined("form.customerto") AND form.customerto neq ""> 
    	AND custno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerto#">
    </cfif>
    ORDER BY custno;
</cfquery>

<cfscript>
	pathToOutFile = ExpandPath("/billformat/#form.headertype#_list_#HUserID#.xls");
	book = createObject("java", "org.apache.poi.hssf.usermodel.HSSFWorkbook").init();
	HSSFPrintSetup = createObject("java","org.apache.poi.hssf.usermodel.HSSFPrintSetup");
	HSSFCellStyle = createObject("java","org.apache.poi.hssf.usermodel.HSSFCellStyle");
	HSSFFont = createObject("java","org.apache.poi.hssf.usermodel.HSSFFont");
	HSSFDataFormat = createObject("java","org.apache.poi.hssf.usermodel.HSSFDataFormat");
	HSSFFooter = createObject("java","org.apache.poi.hssf.usermodel.HSSFFooter");
	HSSFColor = createObject("java","org.apache.poi.hssf.util.HSSFColor");
	region = createObject("java","org.apache.poi.hssf.util.Region");
	HSSFColor$GREY_40_PERCENT = createObject("java","org.apache.poi.hssf.util.HSSFColor$GREY_25_PERCENT");
	
	sheet = book.createSheet(form.headertype);
	FOR(a=0;a LTE 52;a++){
		sheet.setColumnWidth(a,7000);
	}
	footer = sheet.getFooter();
	footer.setCenter(HSSFFooter.date());
	footer.setRight("Page " & HSSFFooter.page() & " of " & HSSFFooter.numPages());

	sheet.SetDefaultRowHeight(330);

	sheet.setMargin(sheet.LeftMargin,0.6);
	sheet.setMargin(sheet.RightMargin,0.75);
	sheet.setMargin(sheet.TopMargin,0.75);
	sheet.setMargin(sheet.BottomMargin,0.99);

	ps = sheet.getPrintSetup();
	ps.setPaperSize(HSSFPrintSetup.LEGAL_PAPERSIZE);
	ps.setLandscape(JavaCast("boolean",true));

	font2 = book.createFont();
	font2.setFontName("TIMES NEW ROMAN");
	font2.setFontHeightInPoints(10);

	sBody = book.createCellStyle();  
	sBody.setFont(font2);
	sBody.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	sBody2 = book.createCellStyle();  
	sBody2.setFont(font2);
	sBody2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	sBody3 = book.createCellStyle();  
	sBody3.setFont(font2);
	sBody3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);


	// Create a row and put some cells in it. Rows are 0 based.  
	count = 0;	
	count = count;	
	row = sheet.createRow(javacast("int",count));	
		cell = row.createCell(javacast("int",0));
		if(form.custvpend eq "#target_arcust#"){
			cell.setCellValue(javacast("string","CUSTOMER NO (8) [3000/xxx]"));
		}else{
			cell.setCellValue(javacast("string","SUPPLIER NO (8) [3000/xxx]"));			
		}
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string","NAME(40)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string","NAME2(40)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string","COMPANY UEN(45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string","BILLING ADDRESS 1(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string","BILLING ADDRESS 2(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string","BILLING ADDRESS 3(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string","BILLING ADDRESS 4(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string","BILLING COUNTRY(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string","BILLING POSTALCODE(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string","BILLING ATTENTION(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string","BILLING PHONE(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string","BILLING HP(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string","BILLING FAX(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string","BILLING EMAIL(100)"));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",15));
		cell.setCellValue(javacast("string","DELIVERY ADDRESS 1(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",16));
		cell.setCellValue(javacast("string","DELIVERY ADDRESS 2(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",17));
		cell.setCellValue(javacast("string","DELIVERY ADDRESS 3(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",18));
		cell.setCellValue(javacast("string","DELIVERY ADDRESS 4(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",19));
		cell.setCellValue(javacast("string","DELIVERY COUNTRY (25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",20));
		cell.setCellValue(javacast("string","DELIVERY POSTALCODE(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",21));
		cell.setCellValue(javacast("string","DELIVERY ATTENTION(35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",22));
		cell.setCellValue(javacast("string","DELIVERY PHONE(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",23));
		cell.setCellValue(javacast("string","DELIVERY HP(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",24));
		cell.setCellValue(javacast("string","DELIVERY FAX(25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",25));
		cell.setCellValue(javacast("string","DELIVERY EMAIL(100)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",26));
		cell.setCellValue(javacast("string","GST CUSTOMER (Y/N)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",27));
		cell.setCellValue(javacast("string","GST NUMBER (25)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",28));
		cell.setCellValue(javacast("string","CREDIT SALES CODE (12)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",29));
		cell.setCellValue(javacast("string","SALES RETURN CODE (12)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",30));
		cell.setCellValue(javacast("string","CURRENCY CODE (10)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",31));
		cell.setCellValue(javacast("string","CURRENCY SYMBOL (10)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",32));
		cell.setCellValue(javacast("string","CURRENCY DESCRIPTION (27)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",33));
		cell.setCellValue(javacast("string","TERMS (12)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",34));
		cell.setCellValue(javacast("string","CREDIT LIMIT(19,2)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",35));
		cell.setCellValue(javacast("string","INVOICE LIMIT (19,2)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",36));
		cell.setCellValue(javacast("string","DISCOUNT CATEGORY (1)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",37));
		cell.setCellValue(javacast("string","DISCOUNT LEVEL 1 (5,2)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",38));
		cell.setCellValue(javacast("string","DISCOUNT LEVEL 2 (5,2)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",39));
		cell.setCellValue(javacast("string","DISCOUNT LEVEL 3 (5,2)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",40));
		cell.setCellValue(javacast("string","NORMAL RATE (45)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",41));
		cell.setCellValue(javacast("string","OFFER RATE (45)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",42));
		cell.setCellValue(javacast("string","OTHER RATE (45)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",43));
		cell.setCellValue(javacast("string","BUSINESS NATURE (15)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",44));
		cell.setCellValue(javacast("string","AREA (12)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",45));
		cell.setCellValue(javacast("string","END USER (45)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",46));
		cell.setCellValue(javacast("string","AGENT (20)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",47));
		cell.setCellValue(javacast("string","GROUP TO (12)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",48));
		cell.setCellValue(javacast("string","REMARK 1 (35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",49));
		cell.setCellValue(javacast("string","REMARK 2 (35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",50));
		cell.setCellValue(javacast("string","REMARK 3 (35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",51));
		cell.setCellValue(javacast("string","REMARK 4 (35)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",52));
		cell.setCellValue(javacast("string","STATUS (T/F)"));
		cell.setCellStyle(sBody);
					
	FOR(i=1;i LTE getData.recordcount;i=i+1){			
		count = count +1;		
		row = sheet.createRow(javacast("int",count));
			cell = row.createCell(javacast("int",0));
			cell.setCellValue(javacast("string",getData["CUSTNO"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",1));
			cell.setCellValue(javacast("string",getData["NAME"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",2));
			cell.setCellValue(javacast("string",getData["NAME2"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",3));
			cell.setCellValue(javacast("string",getData["COMUEN"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",4));
			cell.setCellValue(javacast("string",getData["ADD1"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",5));
			cell.setCellValue(javacast("string",getData["ADD2"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",6));
			cell.setCellValue(javacast("string",getData["ADD3"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",7));
			cell.setCellValue(javacast("string",getData["ADD4"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",8));
			cell.setCellValue(javacast("string",getData["COUNTRY"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",9));
			cell.setCellValue(javacast("string",getData["POSTALCODE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",10));
			cell.setCellValue(javacast("string",getData["ATTN"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",11));
			cell.setCellValue(javacast("string",getData["PHONE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",12));
			cell.setCellValue(javacast("string",getData["PHONEA"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",13));
			cell.setCellValue(javacast("string",getData["FAX"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",14));
			cell.setCellValue(javacast("string",getData["E_MAIL"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",15));
			cell.setCellValue(javacast("string",getData["DADDR1"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",16));
			cell.setCellValue(javacast("string",getData["DADDR2"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",17));
			cell.setCellValue(javacast("string",getData["DADDR3"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",18));
			cell.setCellValue(javacast("string",getData["DADDR4"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",19));
			cell.setCellValue(javacast("string",getData["D_COUNTRY"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",20));
			cell.setCellValue(javacast("string",getData["D_POSTALCODE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",21));
			cell.setCellValue(javacast("string",getData["DATTN"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",22));
			cell.setCellValue(javacast("string",getData["DPHONE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",23));
			cell.setCellValue(javacast("string",getData["CONTACT"][i]));			
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",24));
			cell.setCellValue(javacast("string",getData["DFAX"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",25));
			cell.setCellValue(javacast("string",getData["D_EMAIL"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",26));
			if(getData["NGST_CUST"][i] EQ 'F'){
				tempValue = 'Y';
			}
			else{
				tempValue = 'N';
			}
			cell.setCellValue(javacast("string",tempValue));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",27));
			cell.setCellValue(javacast("string",getData["GSTNO"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",28));
			cell.setCellValue(javacast("string",getData["SALEC"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",29));
			cell.setCellValue(javacast("string",getData["SALECNC"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",30));
			cell.setCellValue(javacast("string",getData["CURRCODE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",31));
			cell.setCellValue(javacast("string",getData["CURRENCY"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",32));
			cell.setCellValue(javacast("string",getData["CURRENCY1"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",33));
			cell.setCellValue(javacast("string",getData["TERM"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",34));
			cell.setCellValue(javacast("double",numberformat(getData["CRLIMIT"][i],".__")));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",35));
			cell.setCellValue(javacast("double",numberformat(getData["INVLIMIT"][i],".__")));
			cell.setCellStyle(sBody2);
			cell = row.createCell(javacast("int",36));
			cell.setCellValue(javacast("string",getData["DISPEC_CAT"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",37));
			cell.setCellValue(javacast("string",getData["DISPEC1"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",38));
			cell.setCellValue(javacast("string",getData["DISPEC2"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",39));
			cell.setCellValue(javacast("string",getData["DISPEC3"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",40));
			cell.setCellValue(javacast("string",getData["NORMAL_RATE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",41));
			cell.setCellValue(javacast("string",getData["OFFER_RATE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",42));
			cell.setCellValue(javacast("string",getData["OTHERS_RATE"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",43));
			cell.setCellValue(javacast("string",getData["BUSINESS"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",44));
			cell.setCellValue(javacast("string",getData["AREA"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",45));
			cell.setCellValue(javacast("string",getData["END_USER"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",46));
			cell.setCellValue(javacast("string",getData["AGENT"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",47));
			cell.setCellValue(javacast("string",getData["GROUPTO"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",48));
			cell.setCellValue(javacast("string",getData["ARREM1"][i]));
			cell.setCellStyle(sBody);	
			cell = row.createCell(javacast("int",49));
			cell.setCellValue(javacast("string",getData["ARREM2"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",50));
			cell.setCellValue(javacast("string",getData["ARREM3"][i]));
			cell.setCellStyle(sBody);		
			cell = row.createCell(javacast("int",51));
			cell.setCellValue(javacast("string",getData["ARREM4"][i]));
			cell.setCellStyle(sBody);
			cell = row.createCell(javacast("int",52));
			cell.setCellValue(javacast("string",getData["badStatus"][i]));
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

<cfheader name="Content-Disposition" value="inline; filename=#form.headertype#_list.xls">
<cfcontent type="application/vnd.ms-excel" file="#pathToOutFile#">