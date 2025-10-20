<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Serial No Report Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>

<cfset myarray = ArrayNew(1)>
    <cfquery datasource="#dts#" name="getinfo">
		select * from icitem where itemno >= "#form.itemfrom#" and itemno <= "#form.itemto#" and wserialno = 'T' group by itemno 
	</cfquery>
    <cfloop query="getinfo">
        <cfsilent>
        <cfoutput>#ArrayAppend(myarray, "#itemno#")# </cfoutput><br> 
        </cfsilent>
    </cfloop>
    <cfset mylist= Arraytolist(myArray, ',')>
    <cfset cnt=ArrayLen(myarray)>
      
	<cfloop index ="i" from="1" to="#cnt#">
		<cfquery datasource="#dts#" name="getdesp">
			select desp from icitem where itemno = "#listgetat(mylist, i)#"
		</cfquery>
		<h2><cfoutput>#listgetat(mylist, i)# - #getdesp.desp#</cfoutput></h2><br>
		Serial No Details - <br><br>
		<cfquery datasource="#dts#" name="getserial">
			select * from iserial where itemno = "#listgetat(mylist, i)#"
		</cfquery>
		
		<cfoutput query="getserial">
			Serial No: #getserial.serialno#<br>
			Invoice No: #getserial.refno#<br>
			<cfquery datasource="#dts#" name="gettran">
				select * from artran where refno = "#getserial.refno#"
			</cfquery>
			Date of Transaction: #dateformat(gettran.wos_date, "dd/mm/yyyy")#<br><br>
		</cfoutput>
	</cfloop>

</body>
</body>
</html>