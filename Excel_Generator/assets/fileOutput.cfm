<cfheader name="Content-Disposition" value="inline; filename=#this.filename#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#filepath#">
