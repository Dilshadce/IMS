<cfquery name="getData" datasource="#dts#">
	SELECT
       ITEMNO,DESP,DESPA,AITEMNO,BRAND,SUPP,CATEGORY,WOS_GROUP,SIZEID,COSTCODE,COLORID,SHELF,PACKING,MINIMUM,MAXIMUM,REORDER,UNIT,UCOST,PRICE,PRICE2,PRICE3,PRICE4,WSERIALNO,GRADED,QTY2,QTY3,QTY4,QTY5,QTY6,QTYBF,SALEC,SALECSC,SALECNC,PURC,PURPREC,UNIT2,FACTOR1,FACTOR2,PRICEU2,REMARK1,BARCODE,CUSTPRICE_RATE,FCURRCODE,FUCOST,FPRICE,FCURRCODE2,FUCOST2,FPRICE2,FCURRCODE3,FUCOST3,FPRICE3,FCURRCODE4,FUCOST4,FPRICE4,FCURRCODE5,FUCOST5,FPRICE5,ITEMTYPE,COMMENT,NONSTKITEM,PRICE5,PRICE6,SALEC,PURC
    FROM ICITEM
	WHERE 0=0
            <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno >= '#form.productfrom#' and itemno <= '#form.productto#'
  			</cfif>
			<cfif form.catefrom neq "" and form.cateto neq "">
			and category >= '#form.catefrom#' and category <= '#form.cateto#'
  			</cfif>
			<cfif form.sizeidfrom neq "" and form.sizeidto neq "">
			and sizeid >= '#form.sizeidfrom#' and sizeid <= '#form.sizeidto#'
  			</cfif>
			<cfif form.costcodefrom neq "" and form.costcodeto neq "">
			and costcode >= '#form.costcodefrom#' and costcode <= '#form.costcodeto#'
  			</cfif>
			<cfif form.coloridfrom neq "" and form.coloridto neq "">
			and colorid >= '#form.coloridfrom#' and colorid <= '#form.coloridto#'
  			</cfif>
			<cfif form.shelffrom neq "" and form.shelfto neq "">
			and shelf >= '#form.shelffrom#' and shelf <= '#form.shelfto#'
  			</cfif>
			<cfif form.groupfrom neq "" and form.groupto neq "">
			and wos_group >= '#form.groupfrom#' and wos_group <= '#form.groupto#'
  			</cfif>
    ORDER BY ITEMNO
</cfquery>
 <!---<cfabort>--->
<cfscript>
	pathToOutFile = ExpandPath("/billformat/item_list_#HUserID#.xls");
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
	sheet.setColumnWidth(2,7000); 	//DESPA
	sheet.setColumnWidth(3,6000); 	//AITEMNO
	sheet.setColumnWidth(4,6000);	//BRAND
	sheet.setColumnWidth(5,6000);	//SUPP
	sheet.setColumnWidth(6,6000); 	//CATEGORY
	sheet.setColumnWidth(7,4000);	//WOS_GROUP
	sheet.setColumnWidth(8,6000);	//SIZEID
	sheet.setColumnWidth(9,6000);	//COSTCODE
	sheet.setColumnWidth(10,6000);	//COLORID
	sheet.setColumnWidth(11,6000);	//SHELF
	sheet.setColumnWidth(12,5000);	//PACKING
	sheet.setColumnWidth(13,6000); 	//MINIMUM
	sheet.setColumnWidth(14,6000); 	//MAXIMUM
	sheet.setColumnWidth(15,6000);	//REORDER
	sheet.setColumnWidth(16,6000);	//UNIT
	sheet.setColumnWidth(17,6000); 	//UCOST
	sheet.setColumnWidth(18,6000);	//PRICE
	sheet.setColumnWidth(19,5000);	//PRICE2
	sheet.setColumnWidth(20,5000);	//PRICE3
	sheet.setColumnWidth(21,5000);	//PRICE4
	sheet.setColumnWidth(22,3000);	//WSERIALNO
	sheet.setColumnWidth(23,3000);	//GRADED
	sheet.setColumnWidth(24,5000);	//QTY2
	sheet.setColumnWidth(25,3000);	//QTY3
	sheet.setColumnWidth(26,5500); 	//QTY4
	sheet.setColumnWidth(27,3500); 	//QTY5
	sheet.setColumnWidth(28,6000);	//QTY6
	sheet.setColumnWidth(29,4000);	//QTYBF
	sheet.setColumnWidth(30,3000); 	//SALEC
	sheet.setColumnWidth(31,3000);	//SALECSC
	sheet.setColumnWidth(32,3000);	//SALECNC
	sheet.setColumnWidth(33,6000);	//PURC
	sheet.setColumnWidth(34,4000);	//PURPREC
	sheet.setColumnWidth(35,1000);	//UNIT2
	sheet.setColumnWidth(36,6000);	//FACTOR1
	sheet.setColumnWidth(37,3000);	//FACTOR2
	sheet.setColumnWidth(38,3000);	//PRICEU2
	sheet.setColumnWidth(39,3000);	//REMARK1
	sheet.setColumnWidth(40,3000);	//BARCODE
	sheet.setColumnWidth(41,3000);	//CUSTPRICE
	sheet.setColumnWidth(42,3000);	//FOREIGN CURRCODE
	sheet.setColumnWidth(43,3000);	//FOREIGN COST
	sheet.setColumnWidth(44,3000);	//FOREIGN PRICE
	sheet.setColumnWidth(45,3000);	//FOREIGN CURRCODE2
	sheet.setColumnWidth(46,3000);	//FOREIGN COST2
	sheet.setColumnWidth(47,3000);	//FOREIGN PRICE2
	sheet.setColumnWidth(48,3000);	//FOREIGN CURRCODE3
	sheet.setColumnWidth(49,3000);	//FOREIGN COST3
	sheet.setColumnWidth(50,3000);	//FOREIGN PRICE3
	sheet.setColumnWidth(51,3000);	//FOREIGN CURRCODE4
	sheet.setColumnWidth(52,3000);	//FOREIGN COST4
	sheet.setColumnWidth(53,3000);	//FOREIGN PRICE4
	sheet.setColumnWidth(54,3000);	//FOREIGN CURRCODE5
	sheet.setColumnWidth(55,3000);	//FOREIGN COST5
	sheet.setColumnWidth(56,3000);	//FOREIGN PRICE5
	sheet.setColumnWidth(57,3000);	//ITEMTYPE
	sheet.setColumnWidth(58,3000);	//COMMENT
	sheet.setColumnWidth(59,3000);	//NONSTKITEM
	sheet.setColumnWidth(60,3000);	//SALES TAX CODE
	sheet.setColumnWidth(61,3000);	//PURCHASE TAX CODE
	sheet.setColumnWidth(62,3000);	//PRICE 5
	sheet.setColumnWidth(63,3000);	//PRICE 6
	
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
			cell.setCellValue(javacast("string","ITEMNO,C,60"));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",1));
		cell.setCellValue(javacast("string","DESP,C,100"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",2));
		cell.setCellValue(javacast("string","DESPA,C,100"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string","AITEMNO/ Product Code,C,40"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string","BRAND,C,40"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string","SUPP,C,12"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string","CATEGORY,C,80"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string","WOS_GROUP,C,50"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string","SIZEID (Size),C,40"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string","COSTCODE (Rating) ,C,20"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string","COLORID (Material),C,40"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string","SHELF (Model),C,25"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string","PACKING,C,20"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string","MINIMUM,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string","MAXIMUM,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",15));
		cell.setCellValue(javacast("string","REORDER,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",16));
		cell.setCellValue(javacast("string","UNIT,C,15"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",17));
		cell.setCellValue(javacast("string","UCOST,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",18));
		cell.setCellValue(javacast("string","PRICE,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",19));
		cell.setCellValue(javacast("string","PRICE2,D(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",20));
		cell.setCellValue(javacast("string","PRICE3,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",21));
		cell.setCellValue(javacast("string","PRICE4,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",22));
		cell.setCellValue(javacast("string","SERIALNO(Y/N),C,1"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",23));
		cell.setCellValue(javacast("string","GRADED(Y/N),C,1"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",24));
		cell.setCellValue(javacast("string","QTY2 (Length),D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",25));
		cell.setCellValue(javacast("string","QTY3 (Width),D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",26));
		cell.setCellValue(javacast("string","QTY4 (Thickness),D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",27));
		cell.setCellValue(javacast("string","QTY5 (Weight/Length),D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",28));
		cell.setCellValue(javacast("string","QTY6 (Price/Weight),D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",29));
		cell.setCellValue(javacast("string","QTYBF,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",30));
		cell.setCellValue(javacast("string","SALEC (Credit Sales),C,8"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",31));
		cell.setCellValue(javacast("string","SALECSC (Cash Sales),C,8"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",32));
		cell.setCellValue(javacast("string","SALECNC (Sales Return),C,8"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",33));
		cell.setCellValue(javacast("string","PURC (Purchase),C,8"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",34));
		cell.setCellValue(javacast("string","PURPREC (Purchase Return),C,8"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",35));
		cell.setCellValue(javacast("string","UNIT2,C,12"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",36));
		cell.setCellValue(javacast("string","FACTOR1,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",37));
		cell.setCellValue(javacast("string","FACTOR2,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",38));
		cell.setCellValue(javacast("string","PRICEU2,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",39));
		cell.setCellValue(javacast("string","REMARK 1,C,100"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",40));
		cell.setCellValue(javacast("string","BARCODEC,80"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",41));
		cell.setCellValue(javacast("string","CUST PRICE RATE(normal,offer,others)C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",42));
		cell.setCellValue(javacast("string","FOREIGN CURRCODE,C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",43));
		cell.setCellValue(javacast("string","FOREIGN COST,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",44));
		cell.setCellValue(javacast("string","FOREIGN PRICE,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",45));
		cell.setCellValue(javacast("string","FOREIGN CURRCODE 2,C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",46));
		cell.setCellValue(javacast("string","FOREIGN COST 2,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",47));
		cell.setCellValue(javacast("string","FOREIGN PRICE 2,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",48));
		cell.setCellValue(javacast("string","FOREIGN CURRCODE 3,C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",49));
		cell.setCellValue(javacast("string","FOREIGN COST 3,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",50));
		cell.setCellValue(javacast("string","FOREIGN PRICE 3,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",51));
		cell.setCellValue(javacast("string","FOREIGN CURRCODE 4,C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",52));
		cell.setCellValue(javacast("string","FOREIGN COST 4,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",53));
		cell.setCellValue(javacast("string","FOREIGN PRICE 4,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",54));
		cell.setCellValue(javacast("string","FOREIGN CURRCODE 5,C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",55));
		cell.setCellValue(javacast("string","FOREIGN COST 5,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",56));
		cell.setCellValue(javacast("string","FOREIGN PRICE 5,D,(17,7)"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",57));
		cell.setCellValue(javacast("string","ITEM TYPE (S,P,SV),C,45"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",58));
		cell.setCellValue(javacast("string","COMMENT"));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",59));
		cell.setCellValue(javacast("string","Discontinue Item(T/F)"));
		cell.setCellStyle(sBody);
		
		cell = row.createCell(javacast("int",60));
		cell.setCellValue(javacast("string","SALES TAX CODE,C,45"));
		cell.setCellStyle(sBody);
		
		cell = row.createCell(javacast("int",61));
		cell.setCellValue(javacast("string","PURCHASE TAX CODE,C,45"));
		cell.setCellStyle(sBody);
		
		cell = row.createCell(javacast("int",62));
		cell.setCellValue(javacast("string","PRICE5,D,(17,7)"));
		cell.setCellStyle(sBody);
		
		cell = row.createCell(javacast("int",63));
		cell.setCellValue(javacast("string","PRICE6,D,(17,7)"));
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
		cell.setCellValue(javacast("string",getData["DESPA"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",3));
		cell.setCellValue(javacast("string",getData["AITEMNO"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",4));
		cell.setCellValue(javacast("string",getData["BRAND"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",5));
		cell.setCellValue(javacast("string",getData["SUPP"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",6));
		cell.setCellValue(javacast("string",getData["CATEGORY"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",7));
		cell.setCellValue(javacast("string",getData["WOS_GROUP"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",8));
		cell.setCellValue(javacast("string",getData["SIZEID"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",9));
		cell.setCellValue(javacast("string",getData["COSTCODE"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",10));
		cell.setCellValue(javacast("string",getData["COLORID"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",11));
		cell.setCellValue(javacast("string",getData["SHELF"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",12));
		cell.setCellValue(javacast("string",getData["PACKING"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",13));
		cell.setCellValue(javacast("string",getData["MINIMUM"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",14));
		cell.setCellValue(javacast("string",getData["MAXIMUM"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",15));
		cell.setCellValue(javacast("string",getData["REORDER"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",16));
		cell.setCellValue(javacast("string",getData["UNIT"][i]));			
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",17));
		cell.setCellValue(javacast("string",getData["UCOST"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",18));
		cell.setCellValue(javacast("string",getData["PRICE"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",19));
		cell.setCellValue(javacast("string",getData["PRICE2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",20));
		cell.setCellValue(javacast("string",getData["PRICE3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",21));
		cell.setCellValue(javacast("string",getData["PRICE4"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",22));
		cell.setCellValue(javacast("string",getData["WSERIALNO"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",23));
		cell.setCellValue(javacast("string",getData["GRADED"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",24));
		cell.setCellValue(javacast("string",getData["QTY2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",25));
		cell.setCellValue(javacast("string",getData["QTY3"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",26));
		cell.setCellValue(javacast("string",getData["QTY4"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",27));
		cell.setCellValue(javacast("string",getData["QTY5"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",28));
		cell.setCellValue(javacast("string",getData["QTY6"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",29));
		cell.setCellValue(javacast("string",getData["QTYBF"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",30));
		cell.setCellValue(javacast("string",getData["SALEC"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",31));
		cell.setCellValue(javacast("string",getData["SALECSC"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",32));
		cell.setCellValue(javacast("string",getData["SALECNC"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",33));
		cell.setCellValue(javacast("string",getData["PURC"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",34));
		cell.setCellValue(javacast("string",getData["PURPREC"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",35));
		cell.setCellValue(javacast("string",getData["UNIT2"][i]));
		cell.setCellStyle(sBody);
		cell = row.createCell(javacast("int",36));
		cell.setCellValue(javacast("string",getData["FACTOR1"][i]));
		cell.setCellStyle(sBody);	
		cell = row.createCell(javacast("int",37));
		cell.setCellValue(javacast("string",getData["FACTOR2"][i]));
		cell.setCellStyle(sBody);	
		cell = row.createCell(javacast("int",38));
		cell.setCellValue(javacast("string",getData["PRICEU2"][i]));
		cell.setCellStyle(sBody);	
		cell = row.createCell(javacast("int",39));
		cell.setCellValue(javacast("string",getData["REMARK1"][i]));
		cell.setCellStyle(sBody);	
		cell = row.createCell(javacast("int",40));
		cell.setCellValue(javacast("string",getData["BARCODE"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",41));
		cell.setCellValue(javacast("string",getData["CUSTPRICE_RATE"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",42));
		cell.setCellValue(javacast("string",getData["FCURRCODE"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",43));
		cell.setCellValue(javacast("string",getData["FUCOST"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",44));
		cell.setCellValue(javacast("string",getData["FPRICE"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",45));
		cell.setCellValue(javacast("string",getData["FCURRCODE2"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",46));
		cell.setCellValue(javacast("string",getData["FUCOST2"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",47));
		cell.setCellValue(javacast("string",getData["FPRICE2"][i]));
		cell.setCellStyle(sBody);				
		
		cell = row.createCell(javacast("int",48));
		cell.setCellValue(javacast("string",getData["FCURRCODE3"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",49));
		cell.setCellValue(javacast("string",getData["FUCOST3"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",50));
		cell.setCellValue(javacast("string",getData["FPRICE3"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",51));
		cell.setCellValue(javacast("string",getData["FCURRCODE4"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",52));
		cell.setCellValue(javacast("string",getData["FUCOST4"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",53));
		cell.setCellValue(javacast("string",getData["FPRICE4"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",54));
		cell.setCellValue(javacast("string",getData["FCURRCODE5"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",55));
		cell.setCellValue(javacast("string",getData["FUCOST5"][i]));
		cell.setCellStyle(sBody);			
		cell = row.createCell(javacast("int",56));
		cell.setCellValue(javacast("string",getData["FPRICE5"][i]));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",57));
		cell.setCellValue(javacast("string",getData["ITEMTYPE"][i]));
		cell.setCellStyle(sBody);		
		cell = row.createCell(javacast("int",58));
		cell.setCellValue(javacast("string",getData["COMMENT"][i]));
		cell.setCellStyle(sBody);	
		cell = row.createCell(javacast("int",59));
		cell.setCellValue(javacast("string",getData["NONSTKITEM"][i]));
		cell.setCellStyle(sBody);							
		cell = row.createCell(javacast("int",60));
		cell.setCellValue(javacast("string",getData["SALEC"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",61));
		cell.setCellValue(javacast("string",getData["PURC"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",62));
		cell.setCellValue(javacast("string",getData["PRICE5"][i]));
		cell.setCellStyle(sBody);				
		cell = row.createCell(javacast("int",63));
		cell.setCellValue(javacast("string",getData["PRICE6"][i]));
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

<cfheader name="Content-Disposition" value="inline; filename=item_list__list.xls">
<cfcontent type="application/vnd.ms-excel" file="#pathToOutFile#">