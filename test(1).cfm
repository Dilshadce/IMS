<cfsetting showdebugoutput="True" requestTimeOut = "0">
<cfoutput>   
    <cfset sFactory = CreateObject("java","coldfusion.server.ServiceFactory")>
      <cfset MailSpoolService = sFactory.mailSpoolService>
      <cfset MailSpoolService.start()>
</cfoutput>