<!---
	
	This library is part of the Common Function Library Project. An open source
	collection of UDF libraries designed for ColdFusion 5.0. For more information,
	please see the web site at:
		
		http://www.cflib.org
		
	Warning:
	You may not need all the functions in this library. If speed
	is _extremely_ important, you may want to consider deleting
	functions you do not plan on using. Normally you should not
	have to worry about the size of the library.
		
	License:
	This code may be used freely. 
	You may modify this code as you see fit, however, this header, and the header
	for the functions must remain intact.
	
	This code is provided as is.  We make no warranty or guarantee.  Use of this code is at your own risk.
--->

<cfscript>
/**
 * This turns a Microsoft Access hyperlink field into a standard URL.
 * 
 * @param strval 	 Variable containing the MS Access link you want to 'clean'. 
 * @return Returns a string. 
 * @author Mark Andrachek (hallow@webmages.com) 
 * @version 1, January 3, 2002 
 */
function AccessLinkClean(strval)  
{
   return Mid(strval,2,Len(strval)-2); 
}

/**
 * Creates a date range array.
 * 
 * @param startdate 	 The starting date. (Required)
 * @param ndays 	 The number of days. This will include the starting date. (Required)
 * @param dtformat 	 Date format. Defaults to "mm/dd/yyyy" (Optional)
 * @return Returns an array. 
 * @author Casey Broich (cab@pagex.com) 
 * @version 1, May 20, 2003 
 */
function CreateDateRange(startdate,ndays) {
  var dtarray = arraynew(1);
  var i = 1;
  var ndate = "";
  var dtformat = "mm/dd/yyyy";
  
  if (ArrayLen(arguments) gte 3) dtformat = arguments[3];
  ndate = dateformat(startdate,"mm/dd/yyyy") - 1;
  for(i = 1; i lte ndays; i = i+1) {
    ndate = dateformat(ndate+1,dtformat);
    arrayappend(dtarray, ndate);
  }
  return dtarray;
}

/**
 * Returns the path for the specified drive. (Windows only)
 * 
 * @param drvPath 	 Drive letter (c, c:, c:\) or network share (\\computer\share). 
 * @return Returns a string. 
 * @author Rob Brooks-Bilson (rbils@amkor.com) 
 * @version 1.0, July 19, 2001 
 */
function DrivePath(drvPath)
{
  Var fso  = CreateObject("COM", "Scripting.FileSystemObject");
  Var drive = fso.GetDrive(drvPath);
  Return drive.Path;
}

/**
 * Returns True if the specified folder (directory) exists on the ColdFusion server. (Windows only)
 * 
 * @param folder 	 Complete path (absolute or relative) to the folder whose existence you want to test.  
 * @return Returns a Boolean value. 
 * @author Rob Brooks-Bilson (rbils@amkor.com) 
 * @version 1, July 19, 2001 
 */
function FolderExists(folder)
{
  Var fso  = CreateObject("COM", "Scripting.FileSystemObject");
  if (fso.FolderExists(folder)){
    Return True;
  }
  else {
    Return False;
  }
}

/**
 * Generates a password the length you specify.
 * 
 * @param numberOfCharacters 	 Lengh for the generated password. 
 * @return Returns a string. 
 * @author Tony Blackmon (fluid@sc.rr.com) 
 * @version 1, April 25, 2002 
 */
function generatePassword(numberofCharacters) {
  var placeCharacter = "";
  var currentPlace=0;
  var group=0;
  var subGroup=0;

  for(currentPlace=1; currentPlace lte numberofCharacters; currentPlace = currentPlace+1) {
    group = randRange(1,4);
    switch(group) {
      case "1":
        subGroup = rand();
	switch(subGroup) {
          case "0":
            placeCharacter = placeCharacter & chr(randRange(33,46));
            break;
          case "1":
            placeCharacter = placeCharacter & chr(randRange(58,64));
            break;
        }
      case "2":
        placeCharacter = placeCharacter & chr(randRange(97,122));
        break;
      case "3":
        placeCharacter = placeCharacter & chr(randRange(65,90));
        break;
      case "4":
        placeCharacter = placeCharacter & chr(randRange(48,57));
        break;
    }
  }
  return placeCharacter;
}

/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * Update by David Kearns to support '
 * SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
 * 
 * @param str 	 The string to check. (Required)
 * @return Returns a boolean. 
 * @author Jeff Guillaume (jeff@kazoomis.com) 
 * @version 2, August 15, 2002 
 */
function IsEmail(str) {
        //supports new top level tlds
if (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$",str)) return TRUE;
	else return FALSE;
}

/**
 * Returns true if user is authenticated.
 * 
 * @return Returns a boolean. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1, April 29, 2002 
 */
function IsLoggedIn() {
	return getAuthUser() neq "";
}

/**
 * Generates an 8-character random password free of annoying similar-looking characters such as 1 or l.
 * 
 * @return Returns a string. 
 * @author Alan McCollough (amccollough@anmc.org) 
 * @version 1, December 18, 2001 
 */
function MakePassword()
{      
  var valid_password = 0;
  var loopindex = 0;
  var this_char = "";
  var seed = "";
  var new_password = "";
  var new_password_seed = "";
  while (valid_password eq 0){
    new_password = "";
    new_password_seed = CreateUUID();
    for(loopindex=20; loopindex LT 35; loopindex = loopindex + 2){
      this_char = inputbasen(mid(new_password_seed, loopindex,2),16);
      seed = int(inputbasen(mid(new_password_seed,loopindex/2-9,1),16) mod 3)+1;
      switch(seed){
        case "1": {
          new_password = new_password & chr(int((this_char mod 9) + 48));
          break;
        }
	case "2": {
          new_password = new_password & chr(int((this_char mod 26) + 65));
          break;
        }
        case "3": {
          new_password = new_password & chr(int((this_char mod 26) + 97));
          break;
        }
      } //end switch
    }
    valid_password = iif(refind("(O|o|0|i|l|1|I|5|S)",new_password) gt 0,0,1);	
  }
  return new_password;
}

/**
 * Creates a Select form item populated with given string items.
 * Mods by RCamden and Grant Furick.
 * 
 * @param name 	 The name of the Select item. (Required)
 * @param displayList 	 The text values for the drop down. (Required)
 * @param defaultSelected 	 The selected item. (Optional)
 * @param valueListSTR 	 The values for the drop down. Defaults to displayList. (Optional)
 * @param delimiter 	 The delimiter to use for all lists. (Optional)
 * @param mutliple 	 Turns on multiple for the drop down. Default is false. (Optional)
 * @param size 	 Size of the drop down.  (Optional)
 * @return Returns a string. 
 * @author Seth Duffey (sduffey@ci.davis.ca.us) 
 * @version 2, June 21, 2002 
 */
function MakeSelectList(name, displayList) {
    var outstring = "<select name=""#name#""";
	var defaultSelected = "";
	var valueListSTR = displayList;
	var delimiter = ",";
	var i = 1;

	if(arrayLen(arguments) gt 2) defaultSelected = arguments[3];
	if(arrayLen(arguments) gt 3) valueListSTR = arguments[4];
	if(arrayLen(arguments) gt 4) delimiter = arguments[5];
    if(arrayLen(arguments) gt 5 AND arguments[6]) outstring = outstring & " multiple";
    if(arrayLen(arguments) gt 6) outstring = outstring & " size=#arguments[7]#";
    outstring = outstring & ">";

    for (i=1; i LTE listLen(displayList,delimiter); i=i+1) {
		outstring = outstring & "<option value=""#listGetAt(valueListSTR,i,delimiter)#""";
		if(defaultSelected eq listGetAt(valueListSTR,i,delimiter)) outstring = outstring & " selected";
        outstring = outstring & ">#listGetAt(displayList,i,delimiter)#</option>";
    }

    outstring = outstring & "</select>";
	
    return outstring;
}

/**
 * Converts a CF DateTime object into a MySQL timestamp.
 * 
 * @param dt 	 Date object. (Required)
 * @return Returns a string. 
 * @author Mark Andrachek (hallow@webmages.com) 
 * @version 1, June 27, 2002 
 */
function MySQLDT2TS(dt) {
	return Year(dt) & NumberFormat(Month(dt),'00') & NumberFormat(Day(dt),'00') & NumberFormat(Hour(dt),'00') & NumberFormat(Minute(dt),'00') & NumberFormat(Second(dt),'00');
}

/**
 * Converts a query to excel-ready format.
 * 
 * @param query 	 The query to use. (Required)
 * @param headers 	 A list of headers. Defaults to col. (Optional)
 * @param cols 	 The columns of the query. Defaults to all columns. (Optional)
 * @param alternateColor 	 The color to use for every other row. Defaults to white. (Optional)
 * @return Returns a string. 
 * @author Jesse Monson (jesse@ixstudios.com) 
 * @version 1, June 26, 2002 
 */
function Query2Excel (query) {
	var InputColumnList = query.columnList;
	var Headers = query.columnList;

	var AlternateColor = "FFFFFF";
	var header = "";
	var headerLen = 0;
	var col = "";
	var colValue = "";
	var colLen = 0;
	var i = 1;
	var j = 1;
	var k = 1;
	
	if (arrayLen(arguments) gte 2) {
		Headers = arguments[2];
	}
	if (arrayLen(arguments) gte 3) {
		InputColumnList = arguments[3];
	}

	if (arrayLen(arguments) gte 4) {
		AlternateColor = arguments[4];
	}
	if (listLen(InputColumnList) neq listLen(Headers)) {
		return "Input Column list and Header list are not of equal length";
	}
	
	writeOutput("<table border=1><tr bgcolor=""C0C0C0"">");
	for (i=1;i lte ListLen(Headers);i=i+1){
		header=listGetAt(Headers,i);
		headerLen=Len(header)*10;
		writeOutput("<th width=""#headerLen#""><b>#header#</b></th>");
	}
	writeOutput("</tr>");
	for (j=1;j lte query.recordcount;j=j+1){
		if (j mod 2) {
			writeOutput("<tr bgcolor=""FFFFFF"">");
		} else {
			writeOutput("<tr bgcolor=""#alternatecolor#"">");
		}
		for (k=1;k lte ListLen(InputColumnList);k=k+1) {
			col=ListGetAt(InputColumnList,k);
			colValue=query[trim(col)][j];
			colLength=Len(colValue)*10;
			if (NOT Len(colValue)) {
				colValue="&nbsp;";
			} 
			if (isNumeric(colValue) and Len(colValue) gt 10) {
				colValue="'#colValue#";
			} 
			writeOutput("<td width=""#colLength#"">#colValue#</td>");
		}
	writeOutput("</tr>");
	}
	writeOutput("</table>");
	return "";
}
</cfscript>

<!---
 Mimics the cfdirectory, action=&quot;create&quot; command.
 
 @param directory 	 Name of directory to create. (Required)
 @param mode 	 Mode to apply to directory. (Optional)
 @return Does not return a value. 
 @author Raymond Camden (ray@camdenfamily.com) 
 @version 1, October 15, 2002 
--->
<cffunction name="directoryCreate" output="false" returnType="void">
	<cfargument name="directory" type="string" required="true">
	<cfargument name="mode" type="string" required="false" default="">
	<cfif len(mode)>
		<cfdirectory action="create" directory="#directory#" mode="#mode#">
	<cfelse>
		<cfdirectory action="create" directory="#directory#">
	</cfif>
</cffunction>

<!---
 Automatically creates any missing directories before writing to the specified file.
 
 @param fileAndPath 	 Full pathname for the file to be created. (Required)
 @param fileOutput 	 Text to be saved to the file. (Required)
 @param fileAndPathMode 	 Mode to use when creating directories and the file. (Optional)
 @param fileAddNewLine 	 Boolean that determines if a newline should be entered at the end of the file. Defaults to false. (Optional)
 @param fileAttributes 	 Attributes to use for the new file. (Optional)
 @return Returns void. 
 @author Shawn Seley (shawnse@aol.com) 
 @version 1, October 15, 2002 
--->
<cffunction name="WriteFileAndDirectories" output="false" returnType="void">
	<cfargument name="fileAndPath"      type="string"   required="true">
	<cfargument name="fileOutput"       type="string"   required="true">
	<cfargument name="fileAndPathMode"  type="string"   required="false"  default="">
	<cfargument name="fileAddNewLine"   type="boolean"  required="false"  default="yes">
	<cfargument name="fileAttributes"   type="string"   required="false"  default="">

	<cfset var path_array     = ListToArray(fileAndPath, "\")>
	<cfset var this_dir_path  = path_array[1]>   <!--- first item in fileAndPath is the drive path --->
	<cfset var file_name      = path_array[ArrayLen(path_array)]>   <!--- last item in fileAndPath is the file name --->
	<cfset var second_last    = ArrayLen(path_array)-1>

	<cfset var i = 0>

	<!--- lock these directories and files to prevent errors with concurrent threads --->
	<cflock timeout="30" throwontimeout="Yes" name="WriteFileAndDirectoriesLock" type="EXCLUSIVE">

		<!--- create any missing directories --->
		<cfloop index="i" from="2" to="#second_last#">
			<cfset this_dir_path = this_dir_path & "\" &  path_array[i]>
			<cfif not DirectoryExists(this_dir_path)>
				<cfif fileAndPathMode is "">
					<cfdirectory action="CREATE" directory="#this_dir_path#">
				<cfelse>
					<cfdirectory action="CREATE" directory="#this_dir_path#" mode="#fileAndPathMode#">
				</cfif>
			</cfif>
		</cfloop>

		<!--- write the file to the now confirmed/created directory path --->
		<cfif fileAndPathMode is "">
			<cffile action="WRITE" file="#fileAndPath#" output="#fileOutput#" addNewLine="#fileAddNewLine#" attributes="#fileAttributes#">
		<cfelse>
			<cffile action="WRITE" file="#fileAndPath#" output="#fileOutput#" mode="#fileAndPathMode#" addNewLine="#fileAddNewLine#" attributes="#fileAttributes#">
		</cfif>
	</cflock>

</cffunction>
