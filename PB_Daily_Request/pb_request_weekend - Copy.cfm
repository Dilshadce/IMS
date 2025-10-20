<cfset dts_p = #replace(dts, '_i', '_p')#>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>
<cfsetting requesttimeout="0">

<cfquery name="getPB" datASource="#dts#">
	<!--- SELECT a.empno, b.name, a.pbdata, a.mp4u, a.requested_on
	FROM manpower_p.pbupdated a
	LEFT JOIN manpower_p.pmast b
	ON a.empno = b.empno
	WHERE date_format(a.requested_on, '%Y-%m-%d')  = date_format(date_add(now(), interval -6 day),'%Y-%m-%d')
	ORDER BY a.requested_on DESC; --->
	select a.empno, b.name, a.datafield, a.pbdata, a.mp4u, a.requested_on, c.desp
	from manpower_p.pbupdated a
	left join manpower_p.pmast b
	on a.empno = b.empno
	left join manpower_p.fieldcontent c
	on a.datafield = c.datafield
	where date_format(a.requested_on, '%Y-%m-%d') >= date_format(date_add(now(), interval -9 day),'%Y-%m-%d')
	AND date_format(a.requested_on, '%Y-%m-%d') < date_format(now(), '%Y-%m-%d')
	order by a.requested_on desc
</cfquery>

<cfscript>
	Builder = createObject("component","/Excel_Generator/Excel_builder").init();

	Builder.setFilename("PB_Request_"&timenow);
	headerFields = [
		"Employee No", "Employee Name", "Client No", "Client Name","Field_update", "PB Data", "MP4U Data",
		"Requested_On", "Hiring Manager", "Hiring Manager Email"
	];

	Builder.setHeader(headerFields);

	for(i = 1; i <= getPB.recordCount; i++){

		tempcustno = "";
		tempcustname = "";
		tempplacementno = "";
		temphrmgr = "";
		temphrmgremail ="";

		tempplacementno = getcustno(getPB.empno[i], dateformat(getPB.requested_on[i], 'yyyy-mm-dd'), dts);
		if(tempplacementno EQ "")
		{
			tempplacementno = getcustno2(getPB.empno[i], dts);
		}

		tempcustno = getrealcustno(tempplacementno,dts);
		tempcustname = getcustname(tempcustno, dts);
		temphrmgr = gethrmgr(tempplacementno,dts,'username');
		temphrmgremail = gethrmgr(tempplacementno,dts,'useremail');

		line = [
			getPB.empno[i],
			getPB.name[i],
			tempcustno,
			tempcustname,
			getPb.desp[i],
			getPB.pbdata[i],
			getPB.mp4u[i],
			getPB.requested_on[i],
			temphrmgr,
			temphrmgremail
		];

		/*lineType = [
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"Number",
			"Number",
			"Number",
			"Number",
			"Number",
			"Number",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String"
		];*/

		Builder.addLine(line);
		//Builder.addLineType(lineType);
	}

	//Builder.setTypeFlag(True);

	Builder.outputPBRequest();

</cfscript>
<h1>Done</h1>
<cffunction name="getcustno" access="public">
  <cfargument name="empnopassed">
  <cfargument name="requestedDate">
  <cfargument name="dts">
  <cfquery name="getcust" datasource="#dts#">
		SELECT placementno FROM placement where empno = '#empnopassed#' and "#dateformat(requestedDate, 'yyyy-mm-dd')#" between startdate and completedate;
	</cfquery>
  <cfreturn getcust.placementno>
</cffunction>

<cffunction name="getcustno2" access="public" returnType="any">
  <cfargument name="empnopassed">
  <cfargument name="dts">
  <cfquery name="getcust2" datasource="#dts#">
		SELECT placementno FROM placement where empno = '#empnopassed#' order by completedate desc;
	</cfquery>
  <cfreturn getcust2.placementno>
</cffunction>

<cffunction name="getrealcustno" access="public" returnType="any">
  <cfargument name="placementnopassed">
  <cfargument name="dts">
  <cfquery name="getrealcust" datasource="#dts#">
		SELECT custno FROM placement where placementno = '#placementnopassed#';
	</cfquery>
  <cfreturn getrealcust.custno>
</cffunction>

<cffunction name="getcustname" access="public">
  <cfargument name="custnopassed">
  <cfargument name="dts">
  <cfquery name="getcust3" datasource="#dts#">
		SELECT name FROM arcust where custno = '#custnopassed#';
	</cfquery>
  <cfreturn getcust3.name>
</cffunction>

<cffunction name="gethrmgr" access="public">
  <cfargument name="placementnopassed">
  <cfargument name="dts">
  <cfargument name="returndata">
  <cfquery name="gethr" datasource="#dts#">
		SELECT #returndata# as data FROM placement a
		left join payroll_main.hmusers b
		on a.hrmgr = b.entryid
		where a.placementno = '#placementnopassed#' ;
	</cfquery>
  <cfreturn gethr.data>
</cffunction>