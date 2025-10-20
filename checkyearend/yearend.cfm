<cfif isdefined('dts')>
<cfif getauthuser() neq "">
<cfif husergrpid eq "admin" or husergrpid eq "super">
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(now(),'yyyy-mm-dd')#" returnvariable="fperiod"/>
<cfif ((fperiod eq "99" or fperiod eq "13" or fperiod eq "16" or fperiod eq "17" or fperiod eq "18") AND isdefined('getinfo')) or ((fperiod eq "99" or fperiod gte "13") AND isdefined('getinfo') eq false)>
<!--- <cfquery name="getlastlogin" datasource="main">
SELECT userlogtime FROM userlog WHERE userlogid = "#getauthuser()#" and date(userlogtime) = "#dateformat(now(),'YYYY-MM-DD')#"
</cfquery>
<cfif getlastlogin.recordcount eq 0>  --->
<cfajaximport tags="cfform">
<cfwindow name="yearendnow" center="true" closable="true" height="400" width="500" source="/checkyearend/yearendform.cfm?fperiod=#fperiod#" modal="true" refreshonshow="true" initshow="true">
</cfwindow>
<script type="text/javascript">
function checkconfirm(pr)
{
	if(parseFloat(pr) > 12)
	{
		if(confirm('Are You Sure You Want To Close More Than 12 Months?'))
		{
			if(confirm('ARE YOU SURE YOU WANT TO YEAR END NOW? /n PLEASE KINDLY CONFIRM ALL OTHERS USER CURRENTLY IS NOT USING THE SYSTEM! YOU WILL GET AN CONFIRMATION EMAIL ONCE YEAR END HAS COMPLETED!'))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}
	else
	{
		if(confirm('ARE YOU SURE YOU WANT TO YEAR END NOW? /n PLEASE KINDLY CONFIRM ALL OTHERS USER CURRENTLY IS NOT USING THE SYSTEM! YOU WILL GET AN CONFIRMATION EMAIL ONCE YEAR END HAS COMPLETED!'))
			{
				return true;
			}
			else
			{
				return false;
			}
	}
}
<!---
alert('Please kindly do year end!');--->
</script>
<cfabort>
<cfelseif isdefined('getinfo') eq false>
<h1>Please kindly contact us at support@mynetiquette.com if you would like to do closing less than 12 period.</h1>
<!--- </cfif>  --->
</cfif>
</cfif>
</cfif>
</cfif>