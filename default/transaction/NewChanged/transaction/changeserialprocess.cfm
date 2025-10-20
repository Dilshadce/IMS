<cfquery name="checkserialno" datasource="#dts#">
select ifnull(sum(sign),0) as sign from iserial where serialno='#form.changeserialno1#' and (void is null or void='') and type<>'SAM'
</cfquery>

<cfif url.tran eq "RC" or url.tran eq "CN" or url.tran eq "OAI">

<cfif checkserialno.sign eq 0> 
			<cfquery name="insertserial" datasource="#dts#">
				update iserial set serialno='#form.changeserialno1#'
                where type='#url.tran#' and refno='#url.nexttranno#' and trancode='#url.trancode#' and serialno='#form.oldserialno#'
			</cfquery>
            
<script type="text/javascript">
<cfoutput>
alert('Serial no #oldserialno# has been changed to #changeserialno1#');
</cfoutput>
window.close();
window.opener.getResult();
</script>

<cfelse>

<script type="text/javascript">
alert('Serial No Already Exist In System')
history.go(-1);
</script>

</cfif>

<cfelse>

</cfif>




