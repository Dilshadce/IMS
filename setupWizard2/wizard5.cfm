<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Chart Of Accounts</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Chart Of Accounts</div>
                <cfform name="general3" id="general3" action="/setupwizard/wizard6.cfm?type=6" method="post">
                    <input type="hidden" name="radioCOA" id="radioCOA" value="#form.radioCOA#" />
                	<table>
						<cfif isdefined("form.radioCOA") AND form.radioCOA eq "1">
                        <tr>  
                            <td>
                            	Type of Business:
                                <select name="chartofacc" id="chartofacc" onChange="javascript:list.location='../chartOfAcc.cfm?c='+this.options[this.selectedIndex].value">
                                    <option value="1">Trading Company</option>
                                    <option value="2">Training Centre</option>
                                    <option value="3">Travel Agency</option>
                                    <option value="4">Manufacturing Company</option>
                                    <option value="5">Textile Industry</option>
                                    <option value="6">Property</option>
                                    <option value="7">Co-operative Account</option>
                                    <option value="8">Partnership Account</option>
                                </select>
                            </td>
                        </tr> 
                        
                        <tr>
                            <td>
                                <iframe name=list marginWidth=0 marginHeight=0 width="800" height="500" src="/chartOfAcc.cfm?c=1" noResize frameborder="0"></iframe>
                            </td>
                        </tr>              
                        <cfelse> 
                            
                        <tr>
                            <td>
                                <iframe name=list marginWidth=0 marginHeight=0 width="800" height="300" src="/import/import_excel.cfm" scrolling="no" frameborder="0"></iframe>
                            </td>
                        </tr>
                        </cfif> 
                        
                        <tr>
                            <td colspan="100%" align="center">
                                <a href="wizard4.cfm">
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
            <img src="sideBar/sideBar5.png">
        </div>
    </div>
</cfoutput>
</body>
</html>
