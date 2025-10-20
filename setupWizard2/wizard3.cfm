<cfif isdefined("form.wizard2")>
	<cfquery name="updategsetup" datasource="#dts#">
    	UPDATE gsetup
        SET Ctycode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Ctycode#">,
        LastAccYear=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.LastAccYear#">,
        comuen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comuen#">,
        gstno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gstno#">
    </cfquery>
</cfif>

<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Company Logo</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Upload Company Logo</div>
                <cfform name="upload_picture" id="upload_picture" action="company_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
                    <table>
                    
                        <tr>
                            <td>
                            	*The Maximum Size For Logo is 200kb
                            	<br />*The recommended size will be at least 10px width x 10px Height
                            </td>
                        </tr>
                        
                        <cfset thisPath = ExpandPath("/ReportFormat/#dts#/logo.jpg")>
                        <tr>
                        	<td>
                            	<div id="companylogo" align="center">
									<cfif FileExists(thisPath) neq 'NO'>
                            			<img src="/ReportFormat/#dts#/logo.jpg">
                                    </cfif>
                                </div>
                             </td>
                        </tr>
                        
                        <tr>
                            <td align="center">
                                <input type="file" name="formatlogo" id="formatlogo" size="50" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
                                <br/>
                                <input type="submit" name="Upload" id="Upload" value="Upload">
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%" align="center">
                                <a href="wizard2.cfm">
                                    <img src="button/previous.png" alt="Back Button" width="55" height="25" onMouseOver="this.src='button/previous_clicked.png'" onMouseOut="this.src='button/previous.png'">
                                </a>
                                <a href="##">
                                    <img src="button/exit.png" alt="Exit Button" width="55" height="25" onMouseOver="this.src='button/exit_clicked.png'" onMouseOut="this.src='button/exit.png'">
                                </a>
                                    <img src="button/next.png" alt="Next Button" width="55" height="25" onMouseOver="this.src='button/next_clicked.png'" onMouseOut="this.src='button/next.png'" onClick="document.general.submit()">
                            </td>
                        </tr>
                    </table>
                </cfform>          
       		</div>
        </div>
        
        <div id="leftcolumn">
            <img src="sideBar/sideBar3.png">
        </div>
    </div>
</cfoutput>
</body>
</html>
