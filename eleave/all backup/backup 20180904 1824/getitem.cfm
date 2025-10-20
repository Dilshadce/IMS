<cfheader name="Content-Disposition" value="inline; filename=#ListLast(url.item, '/')#">		
<cfcontent deletefile="no" file="#Replace(HRootPath, 'IMS', 'PAY-Associate')#/upload/#url.item#"> 