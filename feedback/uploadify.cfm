<!--- default incoming parameters --->
<cfsetting showdebugoutput="no" enablecfoutputonly="yes">
<cfparam name="form.filedata" default="" />
<cfparam name="form.filename" default="" />
<cfparam name="form.folder" default="" />
<!--- got a file to process? --->
<cfif Len(form.filedata)>
   <!--- does the requested directory exist? --->
   <cfif not DirectoryExists(ExpandPath(form.folder))>
      <cfdirectory action="create" directory="#ExpandPath(form.folder)#" />
   </cfif>
   <!--- move the file out of the CF tmp directory to the requested location --->
   <cffile action="move" source="#form.filedata#" destination="#ExpandPath(form.folder)#\#form.filename#" />
</cfif>
<!--- return something for uploadify to be happy --->
<cfoutput>
#form.filename#
</cfoutput>