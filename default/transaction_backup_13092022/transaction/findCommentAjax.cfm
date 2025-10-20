	<cfquery name="getComment" datasource="#dts#">
   		Select code,desp as cdesp,details from comments WHERE code like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.commentcode#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.commentdesp#%"> order by code desc
	</cfquery>
    <cfoutput>
 <table width="680px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">CODE</font></th>
    <th width="100px">DESCRIPTION</th>
    <th width="500px">DETAILS</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfset countloop = 1 >
    <cfloop query="getComment" >
    <cfset countloop = countloop + 1>
    <cfset countcond = countloop mod 2>
    
    <tr  <cfif countcond neq 0>style="background-color:##CCCCFF"
    </cfif>>
    <td>#getComment.code#</td>
    <td>#getComment.cdesp#</td>
    <td>#ToString(getComment.details)#<input type="hidden" name="#getComment.code#" id="#getComment.code#" value="#URLENCODEDFORMAT(ToString(getComment.details))#"  /></td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('comm5').value = unescape(decodeURI(document.getElementById('#getComment.code#').value));ColdFusion.Window.hide('findComment');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </cfoutput>