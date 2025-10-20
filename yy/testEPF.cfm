<cfsetting requesttimeout="0" >
<cfhttp method="get" url="https://operation.mp4u.com.my/gross_jan.csv" name="csvData">
<cfloop query="csvdata" >

	<cfquery datasource="manpower_p">
		UPDATE manpower_p.pay1_12m_fig set grosspay =
		 WHERE empno = '#csvdata.empno#' and tmonth = 1;
	</cfquery>
</cfloop>
