<cfprocessingdirective pageencoding="UTF-8">
<cfif IsDefined("url.logout")>
	<cfif IsDefined ("session.id")>
		<cfset dummy = StructDelete(application.sessiontracker, "#session.company_name#(#session.id#)")>
		<cfset session.islogin="No">
	</cfif>
</cfif>
<cfoutput>
<script type="text/javascript">
if (location.protocol != 'https:')
{
 location.href = 'https:' + window.location.href.substring(window.location.protocol.length);
}
</script>
</cfoutput>

<!---<cfif findnocase('pro',CGI.SERVER_NAME) NEQ 0>
<cfelse>
 <cflocation url="https://imspro.netiquette.asia" addtoken="no">
<cfabort>
</cfif>--->

<cfset currentURL = CGI.SERVER_NAME >

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<cfprocessingdirective pageencoding="UTF-8">
<cfset title = "OPERATION MP4U">
<cfset title_logo = "NETIQUETTE INVENTORY MANAGEMENT SYSTEM">
<cfset message1 = "Incorrect User ID or Password. Please try again.">
<cfset message2 = "You have been blocked for too many attempts! Please try again after 30 minutes!">
<cfset login_error = "Login Error">
<cfset secured_login = "Secured Login">
<cfset logged_off = "You had been successfully logged off.">
<cfset pls_enter = "Please enter your User ID and Password.">
<cfset user_id = "User ID">
<cfset pass_word = "Password">
<cfset company_id = "Company ID">
<cfset user_id_placeholder = "Please enter your User ID">
<cfset pass_word_placeholder = "Please enter your Password">
<cfset company_id_placeholder = "Please enter your Company ID">
<cfset log_in = "Login">
<cfset not_user = "Not A User Yet?">
<cfset sign_up = "Sign Up Here">
<cfset other_app = "Other Netiquette Business Applications">
<cfset AMS = "Accounting Management System">
<cfset PMS = "Payroll Management System">
<cfset CRM = "Customer Relationship System">
<cfset PMSlink = "http://payroll.netiquette.asia/">
<cfset AMSlink = "http://ams.netiquette.asia/">
<cfset CRMlink = "http://crm.netiquette.asia/">
<cfset termofuse = "Terms of Use">
<cfset termlink = "http://www.netiquette.asia/terms-and-conditions/">
<cfset privacy = "Privacy">
<cfset privacylink = "http://www.netiquette.asia/privacy-policy/">

<cfif CGI.SERVER_NAME eq "ims2.netiquette.hk" or CGI.SERVER_NAME eq "ims.netiquette.hk" or CGI.SERVER_NAME eq "ims2-hk.netiquette.asia" or CGI.SERVER_NAME eq "ims-hk.netiquette.asia">
	<cfset title = "登錄 | Netiquette 庫存管�?�系統">
	<cfset title_logo = "Netiquette 庫存管�?�系統">
	<cfset message1 = "�?正確的用戶ID或密碼，請�?試。">
	<cfset message2 = "您已被�?於太多的嘗試�?請在30分�?�後�?試�?">
	<cfset login_error = "登錄錯誤">
	<cfset secured_login = "安全登錄">
    <cfset logged_off = "您已�?功退出。">
	<cfset pls_enter = "請輸入您的用戶ID，密碼和�?業ID。">
	<cfset user_id = "用戶ID">
	<cfset pass_word = "密碼">
    <cfset company_id = "�?業ID">
	<cfset user_id_placeholder = "請輸入您的用戶ID">
    <cfset pass_word_placeholder = "請輸入您的密碼">
    <cfset company_id_placeholder = "請輸入您的�?業ID">
    <cfset log_in = "登錄">
	<cfset not_user = "�?是用戶？">
    <cfset sign_up = "在此註冊">
	<cfset other_app = "其他 Netiquette �?業管�?�系統">
    <cfset AMS = "會計管�?�系統">
	<cfset PMS = "薪酬管�?�系統">
    <cfset CRM = "顧客關係管�?�系統">
	<cfset AMSlink = "http://ams.netiquette.hk/">
    <cfset PMSlink = "http://payroll.netiquette.asia/">
    <cfset CRMlink = "http://crm.netiquette.hk/">
	<cfset termofuse = "�?款和�?件">
    <cfset termlink = "http://www.netiquette.asia/terms-and-conditions/">
    <cfset privacy = "隱�?權政策">
    <cfset privacylink = "http://www.netiquette.asia/privacy-policy/">
</cfif>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-Equiv="Cache-Control" Content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/mp.ico" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#title#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/loginstyle.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/lessframework4.css" />
</head>

<cfoutput>
    <body>
        <div class="main fix">
            <div class="header_area fix">
                <div class="header structure fix">
                    <img src="/latest/img/login/head_text.png" alt="Manpower Logo" width="342" />
                </div>
            </div>

            <div class="main_body_area fix">
                <div class="main_body structure fix">
                    <cfif IsDefined("url.status")>
                        <cfif url.status EQ 'failed'>
                            <cfset message = message1>
                        <cfelse>
                            <cfset message = message2>
                        </cfif>
                        <h2 style="color:red;">#login_error#</h2>
                        <p style="color:red; text-align:center">#message#</p>
					<cfelseif isdefined('url.msg')>
                        <cfif  url.msg eq 'SessionOut'>
							<nobr><h2 style="color:red;">Session Timed Out</h2></nobr>
							<p style="color:red; text-align:center"><cfoutput>Your session has timed out. Please login again.</cfoutput></p>
						</cfif>
                    <cfelseif IsDefined("url.logout")>
                        <h3>#logged_off#</h3>
                        <p style="text-align:center;">#pls_enter#</p>
                    <cfelse>
                        <h2>#secured_login#</h2>
                        <p style="text-align:center;">#pls_enter#</p>
                    </cfif>

                    <div class="form_heading fix" style="text-align:center">
                        <h1>
<br />
OPERATION<br />
<br />
</h1>
                    </div>

                    <div class="input fix">
                        <form action="/index.cfm" method="post" target="_parent">
                            <p><label for="userId">#user_id#</label></p>
                            <input type="text" name="userId" id="userId" autofocus="autofocus" placeholder="#user_id_placeholder#" required="yes" maxlength="50"/>
                            <p><label for="userPwd">#pass_word#</label></p>
                            <input type="password" name="userPwd" id="userPwd" required="yes" placeholder="#pass_word_placeholder#" autocomplete="off" maxlength="32"/>
                            <!---<p><label for="companyid">#company_id#</label></p>--->
                            <input type="hidden" name="companyid" id="companyid" required="yes" value="manpower" placeholder="#company_id_placeholder#" maxlength="50"/>
                            <div class="sign">
                                <input type="submit" name="submit" id="submit" value="#log_in#" />
                            </div>
                        </form>
                    </div>
                </div>

                <p id="secured"><img src="/latest/img/login/lock.png" alt="Lock Icon" /> This website is secured by 256-bit SSL security</p>


            </div>
        </div>

        
    </body>
</cfoutput>
</html>

<script type="text/javascript">
	if(window.self != window.parent){
		parent.location.replace("/logout.cfm");
	}
</script>
