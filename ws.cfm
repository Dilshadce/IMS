
<!--- <cfquery name="getwebservices" datasource="#dts#">
SELECT * FROM webservicesdetail WHERE id = "#i#"
</cfquery>
<cfquery name="getwebservices" datasource="#dts#">
SELECT * FROM webservicesdetail WHERE id = "#i#"
</cfquery>
<cfquery name="getinvoicedetail" datasource="#dts#">
SELECT * FROM artran
</cfquery> --->



<!---  --->
<!--- <cfinvoke 
webservice="https://trial.tradexchange.gov.sg/docxservices/DocxWebService?wsdl"
method="docUpload"
returnvariable="returnvar" >
<!--- <cfloop list="#getwebservices.parameterlist#" index="a"> --->
<cfinvokeargument name="arg0" value="a">
<cfinvokeargument name="arg1" value="a" >
 </cfinvoke> --->
    <!---  stUser.lname = "Smith";
    stUser.age = 23;
    stUser.hiredate = createDate(2002,02,22);
    stUser.number = 123.321; --->
	
	<!--- = arrayNew(1);
	stUser.arg0[1].DocumentUserDetailsRequest[1] = 	
	stUser.arg0[1].DocumentUserDetailsRequest = structNew(); --->
    
    
    
<!--- <cfset charData = "">
<!---- Create a string of ASCII characters (32-255); concatenate them. ---->
<cfloop index = "data" from = "32" to = "255">
    <cfset ch = chr(data)>
    <cfset charData = charData & ch>
</cfloop>
<!----- Create a Base64 representation of this string. ----->
<cfset data64 = toBase64(charData)>
<!--- Convert string to binary. ---->
<cfset binaryData = toBinary(data64)>

    
  <cfscript>
    stUser = structNew();
	stUser.arg0 = arrayNew(1);
    stUser.arg0[1] = structNew();

	
	stUser.arg0[1].appID = '123';
	stUser.arg0[1].param1 = '';
	stUser.arg0[1].param2 = '';
	stUser.arg0[1].password = '8888';
	stUser.arg0[1].userID = 'abcd';
	stUser.arg0[1].chainID= "John";
	stUser.arg0[1].docStatus= "John";
	stUser.arg0[1].documentType= "";
	stUser.arg0[1].folderName= "hang";
	stUser.arg0[1].fromDate= "123";
	stUser.arg0[1].toDate= 3;

    ws = createObject("webservice", "https://trial.tradexchange.gov.sg/docxservices/DocxWebService?wsdl");
    myReturnVar = ws.docAvailability(stUser); 
	
</cfscript>   
<cfoutput>
<cfdump expand="yes" top="123" var="#myReturnVar#">
#myreturnVar.success#<br />
</cfoutput>

<br />
<br />
<br />
<br />--->



<!--- <cfscript>
    stUser = structNew();
	stUser.appID = '';
	stUser.param1 = '';
	stUser.param2 = '';
	stUser.password = '9yEzAacjICIr+1F+lLD86g==';
	stUser.userID = 'zjac001';
	stUser.chainRefNumber= "John";
	stUser.docRefNumber= "John";

    ws = createObject("webservice", "https://trial.tradexchange.gov.sg/docxservices/DocxWebService?wsdl");
    myReturnVar = ws.docDownload(stUser); 
	
</cfscript>   
<cfoutput>
<cfdump var="#myReturnVar#">
#myReturnVar.errorDetailsMap#<br />
#myReturnVar.errorDetailsMap.entry#<br />
#myReturnVar.errorDetailsMap.entry[1].key#<br />
#myReturnVar.errorDetailsMap.entry[1].value#<br />

#myreturnVar.success#<br />
</cfoutput>
<br />
<br />
<br />  --->







<!--- <cffunction name="getByteArray" access="private" returnType="binary" output="no">
<cfargument name="size" type="numeric" required="true"/>
<cfset var emptyByteArray =
createObject("java", "java.io.ByteArrayOutputStream").init().toByteArray()/>
<cfset var byteClass = emptyByteArray.getClass().getComponentType()/>
<cfset var byteArray =
createObject("java","java.lang.reflect.Array").newInstance(byteClass, arguments.size)/>
<cfreturn byteArray/>
</cffunction> --->

<cfoutput>
<cfset filename =expandpath('\billformat\#imsdts#\#form.refno#.pdf')>
<cfset filedata = FileReadBinary(filename)>

<cfquery name="getUser" datasource="#dts#">
SELECT * FROM tradexchangeprofile WHERE created_by = '#getAuthuser()#'
</cfquery>
 
 <cfscript>
/* function stringToBinary(stringValue){
 
        var binaryValue = charsetDecode( stringValue, "utf-8" );
 
        return( binaryValue );
 
    }*/
    stUser = structNew();
	//stUser.arg0 = arrayNew(1);
    //stUser.arg0[1] = structNew();
	//stUser.appID = 'zjac';
	//stUser.param1 = '';
	//stUser.param2 = '';
	stUser.password = getUser.uen;
	stUser.userID = getUser.username;
	stUser.chainID= form.chainId;
	stUser.documentName=docName1;
	stUser.documentType= form.docxtype;
	//stUser.folderID= "";
	stUser.folderName= form.folder;
	stUser.prevDocRefNumber= form.preDocRefNumber;
	//stUser.transactionCount= 3;

    ws = createObject("webservice", "https://www.tradexchange.gov.sg/docxservices/DocxWebService?wsdl");
    myReturnVar = ws.docUpload(stUser,filedata); 
</cfscript>   
</cfoutput>
<cfoutput>
<!--- <cfdump var="#myReturnVar#"> --->


#myReturnVar.success#<br />
#myReturnVar.errorDetailsMap#<br />
<cfif isdefined('myReturnVar.errorDetailsMap.entry')>
#myReturnVar.errorDetailsMap.entry[1].key#<br />
#myReturnVar.errorDetailsMap.entry[1].value#<br />
<cfquery name="TrackRecord" datasource="#dts#">
INSERT INTO docxMaintenance
(success,key,value,created_on,created_by)
values
('#myReturnVar.success#','#myReturnVar.errorDetailsMap.entry[1].key#','#myReturnVar.errorDetailsMap.entry[1].value#',now(),'#getAuthuser()#')
</cfquery>
<cfelse>
<!--- #myReturnVar.chainRefNumber#<br /> --->
#myReturnVar.docRefNumber#<br /> 
#myReturnVar.submissionDate#<br />
#myReturnVar.documentName#<br />
#myReturnVar.uenUploading#<br />
<cfquery name="TrackRecord" datasource="#dts#">
INSERT INTO docxMaintenance
(success,chainrefNumber,docRefNumber,submissionDate,documentName,uenUploading,created_on,created_by)
values
('#myReturnVar.success#','','#myReturnVar.docRefNumber#','#myReturnVar.submissionDate#','#myReturnVar.documentName#','#myReturnVar.uenUploading#',now(),'#getAuthuser()#')
</cfquery>
</cfif> 

</cfoutput>

<!---<cfscript>
stUser = structNew();
	
    stUser.arg0 = arrayNew(1);
    stUser.arg0[1] = structNew();
	stUser.arg0[1].DocumentUserDetailsRequest = structNew(); 
ws = createObject("webservice", "https://trial.tradexchange.gov.sg/docxservices/DocxWebService?wsdl");
    ws.docDownload(stUser);
</cfscript>--->



<!--- structappend(stUser.arg0 ); --->

<!--- <cfoutput>#returnvar#</cfoutput>
 --->
</body>
</html>