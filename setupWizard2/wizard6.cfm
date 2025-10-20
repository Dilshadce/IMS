
<cfif isdefined("form.radioCOA") AND form.radioCOA eq "1">	
    <cfquery name="insert_COA" datasource="#dts#">
        INSERT IGNORE INTO gldata
        (`EDI_ID`,`ACC_CODE`,`ACCNO`,`DESP`,`DESP2`,`ACCTYPE`,`DEPT`,`ID`,`SA`,`CURRCODE`,	
        `LASTYBAL`,`FLASTYBAL`,`LASTYFIG`,`FLASTYFIG`,
        `CAL1`,`CAL2`,`CAL3`,`CAL4`,`CAL5`,`CAL6`,
        `CRLIMIT`,`GROUPTO`,`RPT_ROW`,`RPT_ROW_2`,`RPT_COL`,`PALOPEN`,`FASSET_COD`,`ACC_LOCK`,
        `P11`,`P12`,`P13`,`P14`,`P15`,`P16`,`P17`,`P18`,`P19`,`P20`,`P21`,`P22`,`P23`,`P24`,`P25`,`P26`,`P27`,`P28`,
        `B11`,`B12`,`B13`,`B14`,`B15`,`B16`,`B17`,`B18`,`B19`,`B20`,`B21`,`B22`,`B23`,`B24`,`B25`,`B26`,`B27`,`B28`,
        `FB12`,`FB13`,`FB14`,`FB15`,`FB16`,`FB17`,`FB18`,`FB19`,`FB20`,`FB21`,`FB22`) 

        SELECT 
        EDI_ID,ACC_CODE,ACCNO,DESP,DESP2,ACCTYPE,DEPT,ID,SA,CURRCODE,	
        LASTYBAL,FLASTYBAL,LASTYFIG,FLASTYFIG,
        CAL1,CAL2,CAL3,CAL4,CAL5,CAL6,
        CRLIMIT,GROUPTO,RPT_ROW,RPT_ROW_2,RPT_COL,PALOPEN,FASSET_COD,ACC_LOCK,
        P11,P12,P13,P14,P15,P16,P17,P18,P19,P20,P21,P22,P23,P24,P25,P26,P27,P28,
        B11,B12,B13,B14,B15,B16,B17,B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28,
        FB12,FB13,FB14,FB15,FB16,FB17,FB18,FB19,FB20,FB21,FB22
        FROM mainams.gldata#form.chartofacc# AS a
        WHERE id="3"
    </cfquery>    
</cfif>

<html>
<head>
    <script type="text/javascript" src="js/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>
    <script type="text/javascript" src="validation.js"></script>
    <link rel="stylesheet" href="style.css" />
    
    <title>AMS Setup Wizard - Opening Balance</title>
</head>

<body>
<cfoutput>
   <div id="wrapper">
        <div id="contentliquid">
        	<div id="content">
            	<div class="content_header">Opening Balance</div>
                    <cfform name="general4" id="general4" method="post" action="wizard7.cfm?type=7">
                        <table>
                            <tr>
                                <td>
                                <iframe name="wizard4body" src="/General/openbal.cfm" marginWidth=0 marginHeight=0 width="1000" height="550" noResize frameborder="0"></iframe>
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="100%">
                                <div align="right">
                                	<img src="/images/Question.png" onclick="ColdFusion.Window.show('Guide6');" />
                                </div>
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
            <img src="sideBar/sideBar5.png">
        </div>
    </div>
</cfoutput>
</body>
</html>
