<cfquery name="getlist" datasource="payroll_main">
    SELECT entryID,userID,userName,userEmail,realpass FROM
    <cfif #session.usercty# contains 'test'>
        hmuserstest
    <cfelse>
        hmusers
    </cfif>
    WHERE realpass
    <> "" and lastLogin = '0000-00-00 00:00:00'
    and entryid = "#hrmgrid#"
</cfquery>

<cfoutput>
   
    <cfif #getlist.recordcount# NEQ 0>
        <cfloop query="getlist">
            <cftry>
                <cfmail from="donotreply@manpower.com.my" failto="myhrhelpdesk@manpower.com.my" to="#getlist.userEmail#" 
                        subject="ManpowerGroup Malaysia New System Implementation - MP4U" replyto="myhrhelpdesk@manpower.com.my" type="html"
                        bcc="myhrhelpdesk@manpower.com.my,alvin.hen@manpower.com.my,jiexiang.nieo@manpower.com.my,alvinh.mpg@gmail.com,nieo.netiquette@gmail.com">
                    <p>Dear #getlist.username#,<br><br> We have created for you a new account in <a href="http://www.mp4u.com.my">www.mp4u.com.my</a>, please follow the below steps to complete your profile setting.</p>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="113">
                                <p>
                                    Username: </p>
                            </td>
                            <td width="583">#getlist.userID#</p>
                            </td>
                        </tr>
                        <tr>
                            <td width="113">
                                <p>Password:</p>
                            </td>
                            <td width="583">
                                <p>#getlist.realpass#</p>
                            </td>
                        </tr>
                    </table><br>

                    <table border="1" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="696" valign="top">
                                <p>Step 1: Login &amp; Change Password<br> Login using the default password, and change default password to a password which is safe and easy for you to remember.</p>
                            </td>
                        </tr>
                        <tr>
                            <td width="696" valign="top">
                                <p>Step 2: Validate your approval list<br> Please validate and confirm the list of associates under your approval.</p>
                            </td>
                        </tr>
                        <tr>
                            <td width="696" valign="top">
                                <p>Step 3: Approval<br> In order for us to pay our associates, you must verify and approve their timesheets, claims and leaves in the MP4U before the cut-off date.</p>
                            </td>
                        </tr>
                    </table>
                    <p>You shall be notified on the In-person Training session, which specifies the timeline, procedure and SOP for timesheet, claim and leave approval, via email.<br>In addition, the E-training link is provided as below:</p>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="160">
                                <p>
                                    User Manual: </p>
                            </td>
                            <td width="536">
                                <p><a href="http://bit.ly/2cKCsyn">http://bit.ly/2cKCsyn</a></p>
                            </td>
                        </tr>
                        <tr>
                            <td width="160">
                                <p>YouTube Training Link:</p>
                            </td>
                            <td width="536">
                                <p><a href="https://youtu.be/sb3TYb3xE2w">https://youtu.be/sb3TYb3xE2w</a></p>
                            </td>
                        </tr>
                    </table>
                    <p>For general enquiries or to request support with your account, you could contact us through:</p>
                    <ul>
                        <li>Email : <a href="mailto:myhrhelpdesk@manpower.com.my"><em>myhrhelpdesk@manpower.com.my</em></a></li>
                        <li>Phone: +603 2087 0033. (To be started from 1 Nov 2016)</li>
                    </ul>
                    <p>Best Regards,<br> ManpowerGroup
                    </p>
                    <p><em>This is an automatically generated email, please do  not reply.</em></p>
                </cfmail>
                <cfquery name="updatesent" datasource="payroll_main">
                    UPDATE
                    <cfif #session.usercty# contains 'test'>
                        hmuserstest
                        <cfelse>
                            hmusers
                    </cfif>
                    SET emailsent = now() WHERE entryID = "#getlist.entryID#"
                </cfquery>
                <cfcatch type="any">
                </cfcatch>
            </cftry>
        </cfloop>
    <cfelse>
        <cfquery name="getlist" datasource="payroll_main">
            SELECT entryID,userID,userName,userEmail,realpass FROM
            <cfif #session.usercty# contains 'test'>
                hmuserstest
            <cfelse>
                hmusers
            </cfif>
            WHERE entryid = "#hrmgrid#"
        </cfquery>

        <cfloop query="getlist">
            <cfmail from="donotreply@manpower.com.my" failto="myhrhelpdesk@manpower.com.my" to="#getlist.useremail#" subject="MP4U Password Reset" 
                    replyto="myhrhelpdesk@manpower.com.my" type="html"
                    bcc="myhrhelpdesk@manpower.com.my,alvin.hen@manpower.com.my,jiexiang.nieo@manpower.com.my,alvinh.mpg@gmail.com,nieo.netiquette@gmail.com"><!---myhrhelpdesk@manpower.com.my--->
                Dear #getlist.username#,<br/><br/>
                Your user id for MP4U System is #trim(getlist.userID)#. The default password is #trim(getlist.realpass)#.<br/>
                Please login and change your password.
            </cfmail>  

            <cfquery name="updatesent" datasource="payroll_main">
                UPDATE
                <cfif #session.usercty# contains 'test'>
                    hmuserstest
                <cfelse>
                    hmusers
                </cfif>
                SET emailsent = now() WHERE entryID = "#getlist.entryID#"
            </cfquery> 		
        </cfloop>
    </cfif>
</cfoutput>

