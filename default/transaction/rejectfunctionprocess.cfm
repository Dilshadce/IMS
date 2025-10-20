       <cfquery name="getartran" datasource="#dts#">
        select * from artran where type='#form.type#' and refno='#form.refno#'
        </cfquery>
        <cfset thisdate=CreateDate(year(getartran.wos_date),month(getartran.wos_date),day(getartran.wos_date))>
        <cfset thistrdatetime=CreateDateTime(year(getartran.trdatetime),month(getartran.trdatetime),day(getartran.trdatetime),hour(getartran.trdatetime),minute(getartran.trdatetime),second(getartran.trdatetime))>
        <cfquery datasource="#dts#" name="insert">
		insert into artranat 
		(TYPE,REFNO,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,
		<cfswitch expression="#form.type#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				CREDITAMT
			</cfcase>
			<cfdefaultcase>
				DEBITAMT
			</cfdefaultcase>
		</cfswitch>,
		TRDATETIME,USERID,REMARK,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON)
		values
		('#form.type#','#form.refno#','#getartran.custno#','#getartran.fperiod#',#thisdate#,'#getartran.desp#','#getartran.despa#',
		<cfswitch expression="#type#">
			<cfcase value="RC,CN,OAI" delimiters=",">
				'#getartran.CREDITAMT#'
			</cfcase>
			<cfdefaultcase>
			'#getartran.DEBITAMT#'
			</cfdefaultcase>
		</cfswitch>,
		<cfif getartran.trdatetime neq "" and getartran.trdatetime neq "0000-00-00 00:00:00">#thistrdatetime#<cfelse>'0000-00-00 00:00:00'</cfif>,
		'#getartran.userid#','Voided','#getartran.created_by#','#Huserid#',
		<cfif getartran.created_on neq "">#createdatetime(year(getartran.created_on),month(getartran.created_on),day(getartran.created_on),hour(getartran.created_on),minute(getartran.created_on),second(getartran.created_on))#<cfelse>'0000-00-00 00:00:00'</cfif>,
		#now()#)
	</cfquery>
        
        <cfquery name="updatevoid" datasource="#dts#">
        update artran set void='Y' where type='#form.type#' and refno='#form.refno#'
        </cfquery> 
        
        <cfquery name="updatevoid1" datasource="#dts#">
        update ictran set void='Y' where type='#form.type#' and refno='#form.refno#'
        </cfquery>
        
		<cfset status = form.type&"  "&form.refno&" has been successfully rejected">

<html>
<head>
	<title></title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<center><h3>#status#</h3></center>
	<br><br>
	<form action="" method="post">
	<br><br>
	<div align="center"><input type="button" value="Close" onClick="window.close();window.opener.location.reload();"></div>
	</form>
</cfoutput>
</body>
</html>