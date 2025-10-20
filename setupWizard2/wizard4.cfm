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
                <cfform name="general2" id="general2" action="/setupwizard/wizard5.cfm?type=5" method="post">
                    <table> 
                        <tr>
                            <td>
                                Chart of Accounts is a list of all the accounts used to code transactions.
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                Use Netiquette AMS default accounts or import your own:
                            </td>
                        </tr>
                                
                        <tr>
                            <td>
                                <input type="radio" id="radioCOA" name="radioCOA" value="1" checked="checked">Setup Sample Chart Of Accounts provided by AMS.
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <input type="radio" id="radioCOA" name="radioCOA" value="2">Setup own Chart Of Accounts.
                            </td>
                        </tr> 
                        
                        <tr>
                            <td colspan="100%" align="center">
                                <a href="wizard3.cfm">
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
            <img src="sideBar/sideBar4.png">
        </div>
    </div>
</cfoutput>
</body>
</html>
