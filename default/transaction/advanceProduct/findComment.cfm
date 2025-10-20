<cfoutput>

	<cfquery name="getComment" datasource="#dts#">
   		Select code,desp as cdesp,details from comments order by code desc
	</cfquery>
    <font style="text-transform:uppercase">Code:</font>&nbsp;<input type="text" name="commentcode" id="commentcode" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldfindcomment'),'findCommentAjax.cfm?commentcode='+document.getElementById('commentcode').value+'&commentdesp='+document.getElementById('commentdesp').value);"  />&nbsp;&nbsp;NAME:&nbsp;<input type="text" name="commentdesp" id="commentdesp" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldfindcomment'),'findCommentAjax.cfm?commentcode='+document.getElementById('commentcode').value+'&commentdesp='+document.getElementById('commentdesp').value);" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldfindcomment" name="ajaxFieldfindcomment">
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
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('expcomment').value = unescape(decodeURI(document.getElementById('#getComment.code#').value));document.getElementById('expcomment2').value = unescape(decodeURI('#getComment.code#'));ColdFusion.Window.hide('findComment');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>