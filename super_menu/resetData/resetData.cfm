<cfoutput>
	<cfif IsDefined("form.submit")>           
        <!--- Backup Data Before Truncate --->
        <cfset currentURL =  CGI.SERVER_NAME>
        <cfif MID(currentURL,'4','1') EQ "2">
			<cfset serverhost = "localhost">
            <cfset servername = "root">
            <cfset serverpass = "Nickel266(">
        <cfelse>
			<cfset serverhost = "192.168.168.106">
            <cfset servername = "appserver1">
            <cfset serverpass = "Nickel266(">
        </cfif>

        <cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & dts>
        <cfif DirectoryExists(currentDirectory) EQ false>
            <cfdirectory action = "create" directory = "#currentDirectory#" >
        </cfif>
        
        <cfset filename=dts&"_"&DateFormat(NOW(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_resetData.sql">
        <cfset currentdirfile=currentDirectory&"\"&filename>
        <cfexecute name = "C:\inetpub\wwwroot\IMS\mysqldump"
            arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts#" 
            outputfile="#currentdirfile#" 
            timeout="720">
        </cfexecute>
    	
        <cfif Hlinkams eq "Y">
        	<cfset dts2 = replace(dts,'_i','_a','ALL')>
        	<cfset filename=dts2&"_"&DateFormat(NOW(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_resetData.sql">
			<cfset currentdirfile=currentDirectory&"\"&filename>
            <cfexecute name = "C:\inetpub\wwwroot\IMS\mysqldump"
                arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts2#" 
                outputfile="#currentdirfile#" 
                timeout="720">
            </cfexecute>
        </cfif>
        
        <!--- Truncate CUSTOMER or SUPPLIER PROFILE --->	
        <cfif (form.resetOption EQ 'customerProfile') OR (form.resetOption EQ 'supplierProfile')>
        	<cfif form.resetOption EQ 'customerProfile'>
        		<cfset targetTable = 'arcust'> 
                <cfset GLdataID = '1'>
			<cfelseif form.resetOption EQ 'supplierProfile'>   
                <cfset targetTable = 'apvend'>
                <cfset GLdataID = '2'>
            </cfif>
        
			<cfif Hlinkams eq "Y">
                
                <cfquery name="clear_GLdata" datasource="#replace(LCASE(dts),'_i','_a','all')#">
                    DELETE a.*
                    FROM gldata a
                    LEFT JOIN #targetTable# b
                    ON b.custno = a.accno
                    WHERE a.id = '#GLdataID#';
                </cfquery>

                <cfquery name="clear_CustomerSupplierAMS" datasource="#replace(LCASE(dts),'_i','_a','all')#">
                    TRUNCATE #targetTable#;
                </cfquery>
            </cfif>
        
            <cfquery name="clear_CustomerSupplierIMS" datasource="#dts#">
                TRUNCATE #targetTable#;
            </cfquery>
        
        <!--- Truncate ITEM PROFILE --->    
        <cfelseif form.resetOption EQ 'itemProfile'>
        
        	<cfquery name="checkExist" datasource="#dts#">
                TRUNCATE icitem;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE billmat;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE fifoopq;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE igrade;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE iserial;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE locqdbf;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE logrdob;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE lobthob;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE obbatch;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE icl3p;
            </cfquery>
            
            <cfquery name="checkExist" datasource="#dts#">
                TRUNCATE icl3p2;
            </cfquery>
        </cfif>
        <script>
			alert("Process has been completed!");
		</script>
    </cfif>
</cfoutput>
                             
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Reset Data</title>
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <script>		
		function getConfirmation(){
			<cfoutput>
				
				var companyID = "#dts#"
				var newCompanyID =  companyID.replace("_i","");
				var message = "\t\t\t\t***WARNING*** \n\nSure wanna reset "+document.getElementById('resetOption').value+" for "+ newCompanyID.toUpperCase()+"\n\n**Please wait until the next message. DO NOT Click Submit again!**"; 
			</cfoutput>
			
			return confirm(message);
		}
	</script>
</head>
<body class="container">
<cfoutput>
    <form name="resetDataForm" id="resetDataForm" class="formContainer form2Button" action="/super_menu/resetData/resetData.cfm" method="post" onSubmit="getConfirmation();">
        <div>Reset Data</div>
        <div>
            <table>
                <tr>
                    <th><label for="resetOption">Reset</label></th>
                    <td>
                    	<select name="resetOption" id="resetOption">
                        	<option value="">Choose something</option>
                       		<option value="customerProfile">Customer Profile</option>
                            <option value="supplierProfile">Supplier Profile</option>
                            <option value="itemProfile">Item Profile [Including B.O.M, Serial Number, etc]</option>
						</select>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <input type="submit" name="submit" id="submit" value="Submit"/>
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60810'" />
        </div>
    </form>
</cfoutput>    
</body>
</html>