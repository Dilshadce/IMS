<cfquery datasource="#dts#" name="getgsetup">
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery datasource="#dts#" name="getCountryList">
    SELECT * 
    FROM droplistcountry;
</cfquery> 

<html>
<head>

 	<script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
  	<script type="text/javascript" src="js/custom.js"></script>
    <!---<script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="validation.css" />--->
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Company Profile</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Company Profile</div>
                <cfform name="general" id="general" action="wizard2.cfm" method="post">
                    <table align="center"> 
                        <input type="hidden" name="wizard1" id="wizard1" />
                        <tr>
                            <td>
                                Company Name
                            </td>
                            <td>
                                <div class="company_address">Name as it should appear In Netiquette<br /></div>
                                <cfinput name="compro" id="compro" type="text" value="#getgsetup.compro#" size="70" onKeyUp="checkUsernameForLength(this);controlBlankSpace(this);" onChange="javascript:this.value=this.value.toUpperCase();" />
                                 <!---<span class="hint">Company Name must be a least 6 characters in length.</span>--->
                            </td>
                        </tr>
                       
                        <tr>
                            <td rowspan="12">
                                Company Address
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <div class="company_address">Street Address<br /></div>
                                <cfinput name="compro2" id="compro2" type="text" value="#getgsetup.compro2#" size="70" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                               <div class="company_address">or PO Box<br /></div>
                                <cfinput name="compro3" id="compro3" type="text" value="#getgsetup.compro3#" size="70" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                               <div class="company_address">Town / City<br /></div>
                                <cfinput name="compro4" id="compro4" type="text" value="#getgsetup.compro4#" size="70" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <div class="company_address">State / Region<br /></div>
                                <cfinput name="compro5" id="compro5" type="text" value="#getgsetup.compro5#" size="70" maxlength="80" onKeyup="checkAllLetters(this)"onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <div class="company_address">Postal / Zip Code<br /></div>
                                <cfinput name="compro6" id="compro6" type="text" value="#getgsetup.compro6#" size="70" maxlength="80" onKeyup="checkAllNumbers(this)" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <div class="company_address">Country<br /></div>
                                <select name="compro7" id="compro7">
                                    <cfloop query="getCountryList">
                                        <option value="#getCountryList.country#">
                                            #getCountryList.country#
                                         </option>                      
                                    </cfloop>
                                </select> 
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%" align="center">
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
            <img src="sideBar/sideBar1.png">
        </div>
       
    </div>
</cfoutput>
</body>
</html>
