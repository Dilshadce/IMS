<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1161,1151,1152,1153,1154,971,1091,972,973,1091,1092,1155,65,805,98,969">
<cfinclude template="/latest/words.cfm">
<html>
<head>
	<title><cfoutput>#words[1161]#</cfoutput></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
\<body>
<cfquery datasource='#dts#' name="getPersonnel">
	SELECT * 
    FROM repairtran 
    ORDER BY repairno
</cfquery>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevFive" default="0">
<cfparam name="nextFive" default="0">
<cfoutput>
<h1>#words[1161]#</h1>
	<h4>
	<a href="createrepairservicetable.cfm?type=Create">#words[1151]#</a>
	|| <a href="repairservicetable.cfm">#words[1152]#</a>
	|| <a href="s_repairservicetable.cfm?type=package">#words[1153]#</a>
    || <a href="p_repairservice.cfm">#words[1154]#</a>
	</h4>

<cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/5)>
		<cfif getPersonnel.recordcount mod 5 LT 3 and getPersonnel.recordcount mod 5 neq 0>
			<cfset noOfPage=noOfPage+1>
		</cfif>
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="##FF0000">#words[971]#</font></h3>
			<cfabort>
		</cfif>
	</cfif>

	<cfform action="repairservicetable.cfm" method="post">
		<div align="right">#words[1091]#
            <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
            <cfset noOfPage=round(getPersonnel.recordcount/5)>
            <cfif getPersonnel.recordcount mod 5 LT 3 and getPersonnel.recordcount mod 5 neq 0>
                <cfset noOfPage=noOfPage+1>
            </cfif>
            <cfif isdefined("url.start")>
                <cfset start=url.start>
            </cfif>
            <cfif isdefined("form.skeypage")>
                <cfset start = form.skeypage * 5 + 1 - 5>
    
                <cfif form.skeypage eq "1">
                    <cfset start = "1">
                </cfif>
            </cfif>
            <cfset prevFive=start -5>
            <cfset nextFive=start +5>
            <cfset page=round(nextFive/5)>
            <cfif start neq 1>
                || <a href="areatable.cfm?start=#prevFive#">#words[972]#</a> ||
            </cfif>
            <cfif page neq noOfPage>
                <a href="areatable.cfm?start=#evaluate(nextFive)#">#words[973]#</a> ||
            </cfif>
            #words[1091]# #page# #words[1092]# #noOfPage#
		</div>
		<hr>
		<cfif isdefined("url.process")>
			<h1>#form.status#</h1>
            <hr>
		</cfif>
		<cfloop query="getPersonnel" startrow="#start#" endrow="5">
			<cfset strNo = 'getPersonnel.repairno'>
			<table align="center" class="data" width="50%">
				<tr>
          			<th width="20%">#words[1155]#</th>
          			<td>#getPersonnel.repairno#</td>
        		</tr>
        		<tr>
          			<th>#words[65]#</th>
          			<td>#getPersonnel.desp#</td>
        		</tr>
        		<cfif getpin2.h1D11 eq 'T'>
                    <tr>
                        <td colspan="2">
                        <div align="right">
                            <a href="repairservicetable2.cfm?type=Delete&repairno=#evaluate(strNo)#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">#words[805]#</a>
                            <a href="repairservicetable2.cfm?type=Edit&repairno=#evaluate(strNo)#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">#words[98]#</a>
                        </div>
                        </td>
                    </tr>
				</cfif>
     	 	</table>
			<br>
			<hr>
		</cfloop>
	</cfform>
	<div align="right">
		<cfif start neq 1>
            || <a href="Packagetable.cfm?start=#prevFive#">#words[972]#</a> ||
        </cfif>
        <cfif page neq noOfPage>
            <a href="Packagetable.cfm?start=#evaluate(nextFive)#">#words[973]#</a> ||
        </cfif>
        #words[1091]# #page# #words[1092]# #noOfPage#
	</div>
	<hr>
<cfelse>
	<h3>#words[969]#</h3>
</cfif>
</cfoutput>
</body>
</html>