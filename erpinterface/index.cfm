<cfoutput>
<frameset rows="130,*" cols="*" frameborder="no" border="0" framespacing="0">
<frame src="/erpinterface/header.cfm" name="topFrame" scrolling="NO" noresize >
<frameset cols="200,*" frameborder="no" border="0" framespacing="0">
<frame src="/menunew2/<cfif isdefined('url.quotation')>quotation<Cfelse>transaction</cfif>.cfm" name="leftFrame" scrolling="auto"  noresize>
<frame src="<cfif isdefined('url.quotation')>/default/transaction/transaction1.cfm?ttype=create&tran=QUO&nexttranno=&first=0<cfif isdefined('url.custno')>&custno=#url.custno#</cfif><cfif isdefined('url.leadid')>&leadid=#url.leadid#</cfif><cfelse>/newBody.cfm</cfif>" name="mainFrame">
</frameset>
</frameset><noframes></noframes>
</cfoutput>