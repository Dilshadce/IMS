<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Currency</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Currency</div>
                <cfform name="general" id="general" method="post" action="wizard10.cfm?type=10">
                    <table width="900" height="500" cellpadding="0" cellspacing="0" style="border: 1px solid black ;" align="center">
                        <tr>
                            <td>
                            	<iframe name="wizard6body" src="/currency/vcurrency.cfm" height="500" width="900"  scrolling="yes" frameborder="0"></iframe>
                            </td>
                        </tr>
                        
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
            <img src="sideBar/sideBar8.png">
        </div>
    </div>
</cfoutput>
</body>
</html>

<cfwindow center="true" width="630" height="630" name="Guide9" refreshOnShow="true"
        title="Currency Maintenance" initshow="false"
        source="/ext/docs/contentlayout.cfm?menu_id=16" />
