/**
 * Excel_builder
 *
 * @author yewyang
 * @date 3/24/17
 *
 *
 **/
component accessors=true output=false persistent=false {
	property excelData;
	property header;
	property ROOT;
	property DEFAULT_STYLE;
	property HEADER_STYLE;
	property footer;
	property preloadHeader;
	property rowStyles;
	property customHeader;
	property colStyles;
	property stylesheet;
	property filename;

	public function init(){
		this.excelData = [];
		this.rowStyles = [];
		this.DEFAULT_STYLE = "Default";
		this.HEADER_STYLE = "s27";
		this.ROOT = getDirectoryFromPath(getCurrentTemplatePath());
		this.stylesheet = getDirectoryFromPath(getCurrentTemplatePath()) &"assets/excel_styles.cfm";
		this.preloadHeader = getDirectoryFromPath(getCurrentTemplatePath()) & "assets/excel_header.cfm";
		this.colStyles = StructNew();
		this.customHeader = "";
		this.filename = "File";

		return this;
	}

	public function setDefaultStyle(style_id){
		this.DEFAULT_STYLE = style_id;
	}

	public function setFilename(name){
		this.filename = name;
	}

	public function addLine(line, rowStyleID = ""){
		if(rowStyleID != ""){
			ArrayAppend(this.rowStyles,rowStyleID);
		}else{
			ArrayAppend(this.rowStyles,this.DEFAULT_STYLE);
		}

		ArrayAppend(this.excelData,line);
	}


	public function setCustomHeader(customHeaderPath){
		this.customHeader = customHeaderPath;
	}

	public function setHeader(header, rowStyle = ""){
		this.header = header;

		if(rowStyle != ""){
			this.HEADER_STYLE = rowStyle;
		}
	}


	public function setRowStyle(rowIndex,styleID){
		if(ArrayLen(this.rowStyles) > rowIndex){
			this.rowStyles[row] = styleID;

			return true;
		}

		return false;
	}

	public function setColStyle(col,styleID){
		this.colStyles["col_"&col] = styleID;
		return true;
	}

	public function output(){
			var outputString = "";
			outputString &= FileRead(this.Root & "assets/excel_header.cfm");
			outputString &= FileRead(this.Root & "assets/excel_styles.cfm");
			outputString &= FileRead(this.Root  & "assets/Worksheet_header.cfm");
			if(this.customHeader != ""){
			 	try{
			 		outputString &= FileRead(this.customHeader);
		 		}catch(Any err){
		 			WriteDump(err);
		 			exit;
	 			}
 			}


 			var dataType = "String";
 			var style = "";

 			outputString &= "<Row>";
 			for(var h = 1; h <= ArrayLen(this.header); h++){
 					outputString &= ("<Cell ss:StyleID='" & this.HEADER_STYLE & "' >");

 					outputString &= ("<Data ss:Type='" & dataType & "'>");
 					outputString &= REREPLACE(this.header[h],'&','&amp;');
 					outputString &= "</Data></Cell>";

 			}
 			outputString &= "</Row>";
 			for( var i = 1; i <= ArrayLen(this.excelData); i++){
 				outputString &= "<Row>";
 				for(var j = 1; j <= ArrayLen(this.excelData[i]); j++){
 					style = StructKeyExists(this.colStyles,"col_" & j) ? this.colStyles["col_" & j] : this.rowStyles[i];
 					dataType = IsNumeric(this.excelData[i][j]) ? "Number": "String";

 					outputString &= ("<Cell ss:StyleID='" & style & "' >");

 					outputString &= ("<Data ss:Type='" & dataType & "'>");
 					outputString &= REREPLACE(this.excelData[i][j],'&','&amp;');
 					outputString &= "</Data></Cell>";
 				}
 				outputString &= "</Row>";
 			}

 			outputString &= FileRead(this.ROOT & "assets/excel_footer.cfm");

 			try{
 				outputString = xmlParse(outputString);
 			}catch(Any err){
 				writeDump(outputString);
 				WriteDump(err);
 			}

			var filepath = this.Root & "output/" & TimeFormat(Now()) &"_file.cfm";
 			 FileWrite(filepath,toString(outputString),"utf-8");

			include "assets/fileOutput.cfm";


	}


/*


                          _ooOoo_
                         o8888888o
                         88" . "88
                         (| -_- |)
                          O\ = /O
                      ____/`---'\____
                    .   ' \\| |// `.
                     / \\||| : |||// \
                  // _||||| -:- |||||- \
                     | | \\\ - /// | |
                   | \_| ''\---/'' | |
                    \ .-\__ `-` ___/-. /
                 ___`. .' /--.--\ `. . __
              ."" '< `.___\_<|>_/___.' >'"".
             | | : `- \`.;`\ _ /`;.`/ - ` : | |
               \ \ `-. \_ __\ /__ _/ .-` / /
       ======`-.____`-.___\_____/___.-`____.-'======
                          `=---='
         .............................................



*/
}