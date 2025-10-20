<cfset words_id_list = "1787,603,662,96,2054">
<cfinclude template="/latest/words.cfm">
<cfoutput>
<cfquery name="getUserID" datasource="main">
	SELECT userid,lang
    FROM users
    WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getauthuser())#">;
</cfquery>


<cfset pageTitle = "#words[2054]#">
<cfset userID = getUserID.userid>
<cfset userlang = getUserID.lang>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><cfoutput>#pageTitle#</cfoutput></title>
<link rel="stylesheet" href="/latest/css/form.css" />
<link rel="shortcut icon" href="/IMS.ico" />
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
</head>
<body class="container">
    <form class="formContainer form2Button" name="changeLanguageForm" id="changeLanguageForm" action="/latest/generalSetup/userMaintenance/changeLanguageProcess.cfm" method="post" onSubmit="document.getElementById('userID').disabled=false;">
        <div>#pageTitle#</div>
        <div>
            <table>
                <tr>
                    <th><label for="userID">#words[1787]#</label></th>
                    <td>
                        <input type="text" id="userID" name="userID" value="#userid#" disabled="true" />
                    </td>
                </tr>
                <tr>
                    <th><label for="language">#words[603]#</label></th>
                    <td>
                         <cfquery name="getlang" datasource="main">
            SELECT * FROM words WHERE id in ('1611','1610','1609','1608')
            </cfquery>
            
            <cfloop query="getlang">
            <cfif getlang.id eq "1608">
            <cfset sim_ch_words = getlang.sim_ch>
			</cfif>
            <cfif getlang.id eq "1609">
            <cfset tra_ch_words = getlang.tra_ch>
			</cfif>
            <cfif getlang.id eq "1611">
            <cfset thai_words = getlang.thai>
			</cfif>
            <cfif getlang.id eq "1610">
            <cfset viet_words = getlang.viet>
			</cfif>
            </cfloop>
            <select name="lang" id="lang">
            <option value="">Follow General Setting</option>
              <option value="English" <cfif userlang eq 'English'> selected</cfif>>English</option>
                            <option value="sim_ch" <cfif userlang eq 'sim_ch'> selected<cfelse></cfif>>#sim_ch_words#</option>
                            <option value="tra_ch" <cfif userlang eq 'tra_ch'> selected<cfelse></cfif>>#tra_ch_words#</option>
                            <option value="indo" <cfif userlang eq 'indo'> selected<cfelse></cfif>>Bahasa Indonesia</option>                   
                            <option value="thai" <cfif userlang eq 'thai'> selected<cfelse></cfif>>#thai_words#</option>
                            <option value="viet" <cfif userlang eq 'viet'> selected<cfelse></cfif>>#viet_words#</option>
                            <option value="malay" <cfif userlang eq 'malay'> selected<cfelse></cfif>>Bahasa Melayu</option>
            </select>
                    </td>
                </tr>
     
            </table>
        </div>
        <div>
            <input type="submit" value="#words[662]#" />
            <cfif NOT IsDefined('url.fromMainPage')>
            	<input type="button" value="#words[96]#" onClick="window.location='/latest/body/bodymenu.cfm?id=60200'" />
            </cfif>
        </div>
    </form>
</body>
</html>
</cfoutput>

  