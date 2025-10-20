<cfif FileExists("C:\POSFILE\importingdbf\importdbf\address.dbf")> 
<cfinclude template="importaddress.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\project.dbf")> 
<cfinclude template="importproject.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icservi.dbf")> 
<cfinclude template="importicservi.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\iclocation.dbf")> 
<cfinclude template="importiclocation.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icgroup.dbf")> 
<cfinclude template="importicgroup.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\iccolor.dbf")> 
<cfinclude template="importiccolorid.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\iccate.dbf")> 
<cfinclude template="importiccate.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icarea.dbf")> 
<cfinclude template="importicarea.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icagent.dbf")> 
<cfinclude template="importicagent.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\comments.dbf")> 
<cfinclude template="importcomments.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\business.dbf")> 
<cfinclude template="importbusiness.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\brand.dbf")> 
<cfinclude template="importbrand.cfm">
</cfif>

<cfif isdefined('form.cbapvend')>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\apvend.dbf")> 
<cfinclude template="importapvend.cfm">
</cfif>
</cfif>

<cfif isdefined('form.cbarcust')>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\arcust.dbf")> 
<cfinclude template="importarcust.cfm">
</cfif>
</cfif>

<cfif isdefined('form.cbartran')>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\artran.dbf")> 
<cfinclude template="importartran.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\ictran.dbf")> 
<cfinclude template="importictran.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\iclink.dbf")> 
<cfinclude template="importiclink.cfm">
</cfif>
</cfif>


<cfif isdefined('form.cbicitem')>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icitem.dbf")> 
<cfinclude template="importicitem.cfm">
</cfif>
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\obbatch.dbf")> 
<cfinclude template="importobbatch.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\locqdbf.dbf")> 
<cfinclude template="importlocqdbf.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\lobthob.dbf")> 
<cfinclude template="importlobthob.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\itemgrd.dbf")> 
<cfinclude template="importitemgrd.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\iserial.dbf")> 
<cfinclude template="importiserial.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\igrade.dbf")> 
<cfinclude template="importigrade.cfm">
</cfif>
<cfif FileExists("C:\POSFILE\importingdbf\importdbf\icmitem.dbf")> 
<cfinclude template="importicmitem.cfm">
</cfif>

<cfif FileExists("C:\POSFILE\importingdbf\importdbf\fifoopq.dbf")> 
<cfinclude template="importfifoopq.cfm">
</cfif>
