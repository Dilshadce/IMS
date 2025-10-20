<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "703, 1601, 1602">
<cfinclude template="/latest/words.cfm">

<cfif hlinkams neq "Y">
	<h1>Your system don't have this access</h1>
	<cfabort>
</cfif>

<cfif IsDefined('form.batchp1')>
    <cfquery name="updaterec" datasource="#dts#">
    	UPDATE stockbatches 
        SET
    		<cfloop index="i" from="1" to="18">
    			p#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.batchp#i#')#">
				<cfif i neq 18>,</cfif>
    		</cfloop>
    </cfquery>
</cfif>

<cfquery name="getAccNo" datasource="#replace(LCASE(dts),'_i','_a')#">
    SELECT "" as recno, "#words[1602]#" AS desp
    UNION ALL
    SELECT recno,CONCAT(recno, ' - ', desp) AS desp 
    FROM glbatch;
</cfquery>

<cfquery name="getBatches" datasource="#dts#">
    SELECT * 
    FROM stockbatches;
</cfquery>
        
<cfset pageTitle="#words[1601]#">



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
</head>

<body class="container">
<cfoutput>
    <form id="stockBatchesForm" name"stockBatchesForm" class="formContainer form2Button" action="" method="post">
        <div>#pageTitle#</div>
        <div>
            <table>
            	<cfloop index="i" from="1" to="18">
                    <tr>
                        <th><label for="period#i#">#words[703]# #i#</label></th>
                        <td>
                        	<select id="batchp#i#" name="batchp#i#" selected="#evaluate('getBatches.p#i#')#">
                                <cfloop query="getAccNo">
                                    <option value="#ToString(getaccno.recno)#" <cfif evaluate('getBatches.p#i#') EQ ToString(getaccno.recno)>selected</cfif>>#ToString(getAccNo.desp)#</option>
                                </cfloop>
                            </select>   
                        </td>
                    </tr>
                </cfloop>    
            </table>
        </div>
        <div>
            <input type="submit" value="Submit" />
            <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60100'" />
        </div>
    </form>
</cfoutput>
</body>
</html>