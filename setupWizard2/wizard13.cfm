<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Batch</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Batch</div>
                <table> 
                    <tr>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">
                        <div align="center">
                        <a href="wizard1.cfm"><font color="##FFFFFF">Company Profile</font></a>
                        </div>
                        </th>
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc"><a href="wizard2.cfm"><font color="##FFFFFF">Setup Chart Of Accounts</font></a></th>
                        
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc"><a href="wizard7.cfm"><font color="##FFFFFF">Opening Balances</font></a></th>
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc"><a href="wizard8.cfm"><font color="##FFFFFF">User Maintenance</font></a></th>
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc"><a href="wizard11.cfm"><font color="##FFFFFF">User Defined Setup</font></a></th>
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc"><a href="wizard12.cfm"><font color="##FFFFFF">Import Master File</font></a></th> 
                        <th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##00abcc; border-color:##00abcc">>>></th>
                        <th style="font-family: Ubuntu, Helvetica, sans-serif;
                        font-size: 12px;
                        color: ##FFFFFF;
                        line-height: 30px;
                        font-style: normal; 
                        letter-spacing: 1px;     
                        text-align: center;
                        background-color:##F93; border-color:##00abcc"><a href="wizard12.cfm"><font color="##FFFFFF">Setup Batch</font></a></th>        
                    </tr>       
                </table>
                
                <cfform name="general8" id="general8" method="post" action="skipwizard.cfm">
                    <table>
                        <tr>
                            <td>
                            	<iframe name="wizard6body" src="/transaction/ob.cfm" height="550" width="1000" noResize></iframe>
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
            <img src="sideBar/sideBar11.png">
        </div>
    </div>
</cfoutput>
</body>
</html>