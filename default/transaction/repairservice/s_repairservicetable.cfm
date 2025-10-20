<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1149,1150,1151,1152,1153,1154,697,1155,65,1156,966,294,5,706,10,1158,3,98,805,967,851,850,1157,58,969">
<cfinclude template="/latest/words.cfm">
<cfajaximport tags="cfform,cftooltip">
<cfajaximport tags="cfwindow,cflayout-tab">
<html>
<head>
<title><cfoutput>#words[1149]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
</script>
</head>

<body>
<cfoutput>
<h1>#words[1150]#</h1>
	<h4>
	<a href="createrepairservicetable.cfm?type=Create">#words[1151]#</a>
	|| <a href="repairservicetable.cfm">#words[1152]#</a>
	|| <a href="s_repairservicetable.cfm?type=Repair">#words[1153]#</a>
    || <a href="p_repairservice.cfm">#words[1154]#</a>
	</h4>
    <form action="s_repairservicetable.cfm" method="post">
		<h1>#words[697]#:
        <select name="searchType">
			<option value="repairno">#words[1155]#</option>
	      	<option value="Desp">#words[65]#</option>
	    </select>
      	#words[1156]# : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
  	<cfquery datasource='#dts#' name="type">
		SELECT * 
        FROM repairtran 
        ORDER BY wos_date DESC
  	</cfquery>
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		SELECT * 
            FROM repairtran 
            WHERE #form.searchType# = '#form.searchStr#' 
            ORDER BY #form.searchType#
		</cfquery>
  		<cfquery datasource="#dts#" name="similarResult">
    		SELECT * 
            FROM repairtran where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> 
            ORDER BY #form.searchType#
		</cfquery>
		<h2>#words[966]#</h2>
		<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="50%">
      		<tr> 
                <th nowrap>#words[58]#</th>
        		<th>#words[294]#</th>
        		<th>#words[5]#</th>
                <th>#words[706]#</th>
                <th width="10%">#words[10]#</th>
      		</tr>
            <cfloop query="exactResult"> 
                <cfquery datasource="#dts#" name="checkrccreated">
                    SELECT refno 
                    FROM artran 
                    WHERE type='RC' AND refno='#exactResult.repairno#'
                </cfquery>
                <cfquery datasource="#dts#" name="checkdocreated">
                    SELECT refno 
                    FROM artran 
                    WHERE type='DO' AND refno='#exactResult.repairno#'
                </cfquery>
                <tr> 
                    <td>#exactResult.repairno#</td>
                    <td>#exactResult.custno# #exactResult.name#</td>
                    <td>
                    <cfif checkrccreated.recordcount eq 0>
                        <a href="createrepairRC.cfm?repairno=#exactResult.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
                    <cfelseif checkDOcreated.recordcount eq 0 and checkrccreated.recordcount neq 0 and exactResult.status eq 'Repair'>
                        <a href="repairservicetable2.cfm?repairno=#exactResult.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
                    <cfelseif checkDOcreated.recordcount eq 0 and checkrccreated.recordcount neq 0 and exactResult.status eq 'Delivery'>
                        <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#exactResult.repairno#','linkname','800','600');">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
                    <cfelse> 
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#
                    </cfif>
                    </td>
                    <cfif getpin2.h1F11 eq 'T'>
                        <td nowrap> 
                        <div align="center">
                            <a href="printrepair.cfm?repairno=#exactResult.repairno#" target="_blank">#words[1158]#</a>&nbsp; 
                            <a href="processprint.cfm?repairno=#exactResult.repairno#" target="_blank">#words[3]#</a>&nbsp;&nbsp;
                            <cfif exactResult.status neq 'Done'>
                                <a href="repairservicetable2.cfm?repairno=#exactResult.repairno#" target="_blank"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">#words[98]#</a>
                            </cfif>
                            <a href="createrepairservicetable.cfm?type=Delete&repairno=#exactResult.repairno#">&nbsp;<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">#words[805]#</a>&nbsp; 				
                        </div>
                        </td>
                    </cfif>
                </tr>
      		</cfloop> 
    	</table>
	<cfelse>
	  	<h3>#words[967]#</h3>
    </cfif>
			
    <h2>#words[851]#</h2>
    <cfif similarResult.recordCount neq 0>
        <cfquery datasource="#dts#" name="checkrccreated2">
            SELECT refno 
            FROM artran 
            WHERE type='RC' AND refno='#similarResult.repairno#'
        </cfquery>
        <cfquery datasource="#dts#" name="checkdocreated2">
            SELECT refno 
            FROM artran 
            WHERE type='DO' AND refno='#similarResult.repairno#'
        </cfquery>
      	<table align="center" class="data" width="50%">					
	    	<tr>
                <th nowrap>#words[58]#</th>
	      		<th>#words[294]#</th>
        		<th>#words[5]#</th>
                <th>#words[706]#</th>
				<th width="10%">#words[10]#</th>
	    	</tr>
	
	   		<cfloop query="similarResult">
                <tr> 
                    <td>#similarResult.repairno#</td>
                    <td>#similarResult.custno# #similarResult.name#</td>
                    <td>
                    <cfif checkrccreated2.recordcount eq 0>
                        <a href="createrepairRC.cfm?repairno=#similarResult.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
                    <cfelseif checkDOcreated2.recordcount eq 0 and checkrccreated2.recordcount neq 0 and similarResult.status eq 'Repair'>
                        <a href="repairservicetable2.cfm?repairno=#similarResult.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
                    <cfelseif checkDOcreated2.recordcount eq 0 and checkrccreated2.recordcount neq 0 and similarResult.status eq 'Delivery'>
                        <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#similarResult.repairno#','linkname','800','600');">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
                    <cfelse> 
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#
                    </cfif>
                    </td>
                    <cfif getpin2.h1F11 eq 'T'>
                    <td nowrap> 
                    <div align="center">
                        <a href="printrepair.cfm?repairno=#similarResult.repairno#" target="_blank">#words[1158]#</a>&nbsp;
                        <a href="processprint.cfm?repairno=#similarResult.repairno#" target="_blank">#words[3]#</a>&nbsp; 
                        <cfif similarResult.status neq 'Done'>
                            <a href="repairservicetable2.cfm?repairno=#similarResult.repairno#" target="_blank"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">#words[98]#</a>
                        </cfif>
                        &nbsp; 
                        <a href="createrepairservicetable.cfm?type=Delete&repairno=#similarResult.repairno#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">#words[805]#</a>&nbsp; 
                    </div>
                    </td>
                    </cfif>
                </tr>
	    	</cfloop>
      	</table>
    <cfelse>
	  	<h3>#words[850]#</h3>
    </cfif>
</cfif>
<hr>
<fieldset>
    <legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: ##0066FF;">
        #words[1157]#:
    </legend>
    <br>
	<cfif type.recordCount neq 0>
        <table align="center" class="data" width="50%">
            <tr>
                <th nowrap>#words[58]#</th>
                <th>#words[1149]#</th>
                <th>#words[5]#</th>
                <th>#words[706]#</th>
                <th width="10%">#words[10]#</th>
            </tr>
            <cfloop query="type" endrow="50"> 
                <cfquery datasource="#dts#" name="checkrccreated3">
                    SELECT refno 
                    FROM artran 
                    WHERE type='RC' AND refno='#type.repairno#'
                </cfquery>
                <cfquery datasource="#dts#" name="checkdocreated3">
                    SELECT refno 
                    FROM artran 
                    WHERE type='DO' AND refno='#type.repairno#'
                </cfquery>
                <tr> 
                    <td width="5%">#type.currentrow#</td>
                    <td>#type.repairno#</td>
                    <td nowrap>#type.custno# #type.name#</td>
                    <td>
                    <cfif checkrccreated3.recordcount eq 0>
                        <a href="createrepairRC.cfm?repairno=#type.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a> 
                    <cfelseif checkDOcreated3.recordcount eq 0 and checkrccreated3.recordcount neq 0 and type.status eq 'Repair'>
                        <a href="repairservicetable2.cfm?repairno=#type.repairno#" target="_blank">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a> 
                    <cfelseif checkDOcreated3.recordcount eq 0 and checkrccreated3.recordcount neq 0 and type.status eq 'Delivery'>
                        <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#type.repairno#','linkname','800','600');">
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a>
                    <cfelse> 
                        <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#
                    </cfif>
                    </td>
                    <cfif getpin2.h1F11 eq 'T'>
                        <td nowrap>
                        <div align="center">
                            <a href="printrepair.cfm?repairno=#type.repairno#" target="_blank">#words[1158]#</a>&nbsp; 
                            <a href="processprint.cfm?repairno=#type.repairno#" target="_blank">#words[3]#</a>&nbsp; 
                            <cfif type.status neq 'Done'>
                                <a href="repairservicetable2.cfm?repairno=#type.repairno#" target="_blank"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">#words[98]#</a>
                            </cfif>
                            &nbsp; 
                            <a href="createrepairservicetable.cfm?type=Delete&repairno=#type.repairno#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">#words[805]#</a>&nbsp; 
                            </div> 
                        </td>
                    </cfif>
                </tr>
            </cfloop>
        </table>
    <cfelse>
        <h3>#words[969]#</h3>
    </cfif>
<br>
</fieldset>
</cfoutput>
</body>
</html>