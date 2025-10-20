<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1315,1323,1313,1314,1324,1325,1326,1327,1328,1088,666,665,689,667,185,668,673,690,664,188,662">
<cfinclude template="/latest/words.cfm">
<cfif isdefined('form.save_btn')>
	<cfif form.ftppass neq form.ftpconpass>
		<cfoutput>
        <script type="text/javascript">
            alert('FTP password is not same with FTP confirm Password. Please kindly check.');
            history.go(-1);
        </script>
        </cfoutput>
        <cfabort>
    </cfif>
    <cftry>
        <cfftp connection="testftp" server="#form.ftphost#" username="#form.ftpuser#" password="#form.ftppass#" port="#form.ftpport#" action="open" stoponerror="yes">
    <cfcatch type="any">
		<cfoutput>
        <script type="text/javascript">
			alert('FTP Establish Connection Fail. Please kindly check the FTP detail.');
			history.go(-1);
        </script>
        <cfabort>
        </cfoutput>
    </cfcatch>
    </cftry>
    <cfftp connection="testftp" action="close" stoponerror="yes">
    <cfquery name="checkexist" datasource="#dts#">
        SELECT * 
        FROM FTPDETAIL
    </cfquery>
	<cfif checkexist.recordcount neq 0>
        <cfquery name="updatedetail" datasource="#dts#">
            UPDATE ftpdetail 
            SET ftphost = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftphost#">,
                ftpport = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpport#">,
                ftpuser = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpuser#">,
                ftppass = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftppass#">
                <cfif isdefined('form.inv')>
                    ,inv='1'
                <cfelse>
                    ,inv=''
                </cfif>
                <cfif isdefined('form.do')>
                    ,do='1'
                <cfelse>
                    ,do=''
                </cfif>
                <cfif isdefined('form.cn')>
                    ,cn='1'
                <cfelse>
                    ,cn=''
                </cfif>
                <cfif isdefined('form.dn')>
                    ,dn='1'
                <cfelse>
                    ,dn=''
                </cfif>
                <cfif isdefined('form.cs')>
                    ,cs='1'
                <cfelse>
                    ,cs=''
                </cfif>
                <cfif isdefined('form.quo')>
                    ,quo='1'
                <cfelse>
                    ,quo=''
                </cfif>
                <cfif isdefined('form.so')>
                    ,so='1'
                <cfelse>
                    ,so=''
                </cfif>
                <cfif isdefined('form.po')>
                    ,po='1'
                <cfelse>
                    ,po=''
                </cfif>
                <cfif isdefined('form.rc')>
                    ,rc='1'
                <cfelse>
                    ,rc=''
                </cfif>
                <cfif isdefined('form.pr')>
                    ,pr='1'
                <cfelse>
                    ,pr=''
                </cfif>
        </cfquery>
    <cfelse>
        <cfquery name="insertdetail" datasource="#dts#">
            INSERT INTO ftpdetail
            (ftphost,ftpport,ftpuser,ftppass,inv,do,cn,dn,cs,quo,so,po,rc,pr)
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftphost#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpport#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftpuser#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ftppass#">
            <cfif isdefined('form.inv')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.do')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.cn')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.dn')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.cs')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.quo')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.so')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.po')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.rc')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
            <cfif isdefined('form.pr')>
                ,'1'
            <cfelse>
                ,''
            </cfif>
                )
        </cfquery>
    </cfif>
	<script type="text/javascript">
        alert('FTP connection established Successfully!');
    </script>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#words[1315]#</cfoutput></title>
</head>
<body>
<cfoutput>
    <h1>#words[1323]#</h1>
    <h4>
        <a href="createlist.cfm?type=create">#words[1313]#</a>||
        <a href="listpos.cfm">#words[1314]#</a>||
        <a href="SetupFtp.cfm">#words[1315]#</a>
    </h4>
    <cfquery name="getFTP" datasource="#dts#">
        SELECT * 
        FROM ftpdetail
    </cfquery>
    <cfif getFTP.recordcount neq 0>
		<cfset ftphost = getFTP.ftphost>
        <cfset ftpuser = getFTP.ftpuser>
        <cfset ftppass = getFTP.ftppass>
        <cfset ftpport = getFTP.ftpport>
        <cfset inv = getFTP.inv>
        <cfset do = getFTP.do>
        <cfset cn = getFTP.cn>
        <cfset dn = getFTP.dn>
        <cfset cs = getFTP.cs>
        <cfset quo = getFTP.quo>
        <cfset so = getFTP.so>
        <cfset po = getFTP.po>
        <cfset rc = getFTP.rc>
        <cfset pr = getFTP.pr>
    <cfelse>
        <cfset ftphost = "">
        <cfset ftpuser = "">
        <cfset ftppass = "">
        <cfset ftpport = "21">
        <cfset inv = "1">
        <cfset do = "1">
        <cfset cn = "1">
        <cfset dn = "1">
        <cfset cs = "1">
        <cfset quo = "1">
        <cfset so = "1">
        <cfset po = "1">
        <cfset rc = "1">
        <cfset pr = "1">
    </cfif>
    <cfform name="setupftp" action="" method="post">
        <table align="center" width="70%">
            <tr>
                <th>#words[1324]#</th>
                <td>:</td>
                <td><cfinput type="text" name="ftphost" id="ftphost" size="35" required="yes" message="FTP Host is Required" value="#ftphost#"/></td>
            </tr>
            <tr>
                <th>#words[1325]#</th>
                <td>:</td>
                <td><cfinput type="text" name="ftpport" id="ftpport" size="35" required="yes"  message="FTP PORT is Required" value="#ftpport#" /></td>
            </tr>
            <tr>
                <th>#words[1326]#</th>
                <td>:</td>
                <td>
                <cfinput type="text" name="ftpuser" id="ftpuser" size="35" required="yes" message="FTP Username is Required" value="#ftpuser#"/>
                </td>
            </tr>
            <tr>
                <th>#words[1327]#</th>
                <td>:</td>
                <td>
                <cfinput type="password" name="ftppass" id="ftppass" size="35" required="yes" message="FTP Password is Required" value="#ftppass#" />
                </td>
                </tr>
            <tr>
                <th>#words[1328]#</th>
                <td>:</td>
                <td>
                <cfinput type="password" name="ftpconpass" id="ftpconpass" size="35" required="yes" message="FTP Confirm Password is Required" value="#ftppass#" />
                </td>
            </tr>
            <tr>
                <th>#words[1088]#</th>
                <td>:</td>
                <td>
                <input type="checkbox" name="inv" id="inv" <cfif inv eq '1'>checked</cfif>> #words[666]# <br />
                <input type="checkbox" name="do" id="do" <cfif do eq '1'>checked</cfif>> #words[665]# <br />
                <input type="checkbox" name="cn" id="cn" <cfif cn eq '1'>checked</cfif>> #words[689]# <br />
                <input type="checkbox" name="dn" id="dn" <cfif dn eq '1'>checked</cfif>> #words[667]# <br />
                <input type="checkbox" name="cs" id="cs" <cfif cs eq '1'>checked</cfif>> #words[185]# <br />
                <input type="checkbox" name="quo" id="quo" <cfif quo eq '1'>checked</cfif>> #words[668]# <br />
                <input type="checkbox" name="so" id="so" <cfif so eq '1'>checked</cfif>> #words[673]# <br />
                <input type="checkbox" name="po" id="po" <cfif po eq '1'>checked</cfif>> #words[690]# <br />
                <input type="checkbox" name="rc" id="rc" <cfif rc eq '1'>checked</cfif>> #words[664]# <br />
                <input type="checkbox" name="pr" id="pr" <cfif pr eq '1'>checked</cfif>> #words[188]# <br />
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center"><input type="submit" name="save_btn" value="#words[662]#" /></td>
            </tr>
        </table>
    </cfform>
</cfoutput>
</body>
</html>
