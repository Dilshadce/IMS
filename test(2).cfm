<cfquery name="getlist" datasource="payroll_main">
    SELECT entryID,userID,userName,userEmail,realpass FROM
<!---    <cfif #session.usercty# contains 'test'>
        hmuserstest
    <cfelse>--->
        hmusers
<!---    </cfif>--->
    WHERE <!---entryid = "#hrmgrid#"---> userid = 'mandy.tan@samsung.com'
</cfquery>

<cfloop query="getlist">
    <cfmail from="donotreply@manpower.com.my" failto="myhrhelpdesk@manpower.com.my" to="lau.cc@samsung.com" bcc="alvinh.mpg@gmail.com" subject="MP4U Password Reset" replyto="myhrhelpdesk@manpower.com.my" type="html"><!---myhrhelpdesk@manpower.com.my--->
        Dear #getlist.username#,<br/><br/>
        Your user id for MP4U System is #trim(getlist.userID)#. The default password is #trim(getlist.realpass)#.<br/>
        Please login and change your password.<br /><br/>
        If you have changed your password previously or you are able to login with your previous password then you can ignore this message.
    </cfmail>      
</cfloop>