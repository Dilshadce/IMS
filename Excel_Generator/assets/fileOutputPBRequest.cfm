<!---
<cfheader name="Content-Disposition" value="inline; filename=#this.filename#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#filepath#">
 --->

<cfset previousDay = "#DateFormat(DateAdd('d', -1, now()), 'YYYY-MM-DD')#">
<cfset timeNow = "#TimeFormat(now(), 'HHnnss')#">

<cffile
action = "write"
file = "#ExpandPath("/PB_Daily_Request/Report/PB_Request_#previousDay#_#timeNow#.xls")#"
output = "#toString(outputString)#"
charset = "utf-8">
    
<cfheader name="Content-Type" value="xls">
<cfset filename = "PB_Request_#previousDay#_#timeNow#.xls">

<cfheader name="Content-Disposition" value="inline; filename=#filename#">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#ExpandPath('Report\#filename#')#">