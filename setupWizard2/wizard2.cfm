<cfif isdefined("form.wizard1")>
  <cfquery name="updategsetup" datasource="#dts#">
    	UPDATE gsetup
        SET compro=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro#">,
        compro2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro2#">,
        compro3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro3#">,
        compro4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro4#">,
        compro5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro5#">,
        compro6=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro6#">,
        compro7=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.compro7#">
    </cfquery>
</cfif>

<cfquery datasource="#dts#" name="getgsetup">
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery datasource="#dts#" name="getcurrency">
    SELECT * 
    FROM currency;
</cfquery>

<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    <title>AMS Setup Wizard - Financial</title>
    
	<script language="javascript" type="text/javascript">
		function chkdate(){
			if (document.getElementById('LastAccYear').value == "(YYYY-MM-DD)"){
				document.getElementById('LastAccYear').value = "";
			}
		}
		function chkdatenone(){
			if (document.getElementById('LastAccYear').value == ""){
				document.getElementById('LastAccYear').value = "(YYYY-MM-DD)";
			}
		}	
	</script>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Financial</div>
                <cfform name="general" id="general" action="/setupwizard/wizard3.cfm?type=3" method="post">
                    <input type="hidden" name="wizard2" id="wizard2" />
                    <table>
                        <tr>
                            <td>
                                Currency Code</strong><br />
                                Choose the currency that your organisation files taxes and reports in.
                            </td>
                            
                            <td>
                            <select name="Ctycode" id="Ctycode">
                                <cfloop query="getcurrency">
                                    <option value="#getcurrency.currcode#" 
                                        <cfif getcurrency.currcode eq getgsetup.ctycode>selected</cfif>>
                                            #getcurrency.currcode# - #getcurrency.currency1#
                                    </option>
                                </cfloop>
                            </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%"><hr /></td>
                        </tr>
                        
                        <tr>
                            <td>Last Accounting Year Closing Date </td>
                        
                            <td>
                                <cfinput name="LastAccYear" id="LastAccYear" type="text"  size="10" maxlength="10" value="#dateformat(getgsetup.lastaccyear,'YYYY/MM/DD')#" onKeyUp="checkDate(this);"> 
                            </td>
                        
                        </tr>
                        
                        <tr>
                            <td>This Accounting Year Closing Period</td>
                            <td>
                                <select name="Period" id="Period">
                                <cfloop from="1" to="18" index="pd">
                                    <option value="#pd#" <cfif pd eq getgsetup.period>selected</cfif>>#pd#</option>
                                </cfloop>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%"><hr /></td>
                        </tr>
                        
                        <tr>
                            <td>Company Unique Entity Number (UEN)</td>
                            <td>
                                <cfinput name="comuen" id="comuen" type="text" value="#getgsetup.comuen#" size="20" maxlength="11" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%"><hr /></td>
                        </tr>
                        
                        <tr>
                            <td>Goods and Services Tax (GST) Registration No.</td>                         
                            <td>
                                <cfinput name="gstno" id="gstno" type="text" value="#getgsetup.gstno#" size="20" maxlength="11" onchange="javascript:this.value=this.value.toUpperCase();">
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="100%" align="center">
                                <a href="wizard1.cfm">
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
            <img src="sideBar/sideBar2.png">
        </div>
    </div>
</cfoutput>
</body>
</html>
