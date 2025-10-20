<cfquery name="getgiropaydate" datasource="manpower_i">
	SELECT giropaydate from manpower_i.icgiro where month(giropaydate) = 4 <!---and giropaydate = '2017-04-07'---> group by giropaydate
</cfquery>

<cfloop query="getgiropaydate">

	<cfquery name="getassociate" datasource="manpower_i">
		SELECT empno from manpower_i.icgiro where giropaydate = "#dateformat(getgiropaydate.giropaydate, 'yyyy-mm-dd')#"
	</cfquery>
	
	<cfloop query="getassociate">
		<cfquery name="updatepay1_12m" datasource="manpower_p">
			update manpower_p.pay1_12m_fig a
			set ded115 =  (select sum(coalesce(funddd,0.00)) from manpower_i.icgiro where giropaydate = "#dateformat(getgiropaydate.giropaydate, 'yyyy-mm-dd')#" and empno = "#getassociate.empno#") 
			where empno = "#getassociate.empno#" and tmonth = 4;
		</cfquery>	
		
		<cfquery name="updatepay_12m" datasource="manpower_p">
			update manpower_p.pay_12m a
			set ded115 =  (select sum(coalesce(funddd,0.00)) from manpower_i.icgiro where giropaydate = "#dateformat(getgiropaydate.giropaydate, 'yyyy-mm-dd')#" and empno = "#getassociate.empno#") 
			where empno = "#getassociate.empno#" and tmonth = 4;
		</cfquery>	
	</cfloop>
	
</cfloop>