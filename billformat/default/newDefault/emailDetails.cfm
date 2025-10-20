<cfoutput> 
<div align="center">
	<table>
        <cfform name="emailForm" id="emailForm" action="preprintedformatEmail.cfm?tran=#tran#&nexttranno=#nexttranno#" method="post">
            <tr>
            	<td><h4>Email Details</h4></td>
            </tr>
            <tr>
            	<td><label>Subject</label></td>
            	<td><input type="text" name="emailSubject" id="emailSubject" maxlength="50"/></td>
            </tr>
            <tr>
            	<td><label>Detail</label></td>
            	<td><textarea name="emailDetail" id="emailDetail" rows="8" cols="40" maxlength="300"></textarea></td>
            </tr>
            <tr align="right">
            	<td></td>
                <td>
                	<input type="button" name="cancle" id="cancle" value="Back"  onclick="javascript:window.location='/default/transaction/transaction.cfm?tran=#tran#';"  >
                    <input type="submit" name="submit" id="submit" value="Send" >
                </td>
            </tr>
      </cfform>  
    </table>
</div>
</cfoutput>