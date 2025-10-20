<cfsetting showdebugoutput="no">

<cfset url.batchno = URLDECODE(URLDECODE(url.batchno))>
<cfset url.location = URLDECODE(URLDECODE(url.location))>
<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>

<cfquery name="getitembatch" datasource="#dts#">
<cfif trim(url.location) neq "">
		select 
		batchcode,rc_type,rc_refno,pallet,
		((bth_qob+bth_qin)-bth_qut) as batch_balance,
		expdate as exp_date ,
        milcert
		from lobthob 
		where location='#url.location#' 
		and batchcode='#url.batchno#' 
        and itemno='#url.itemno#'
		order by batchcode
	
<cfelse>
			select 
			batchcode,pallet,
			rc_type,
			rc_refno,
			((bth_qob+bth_qin)-bth_qut) as batch_balance,
			exp_date,
            milcert
			from obbatch 
			where batchcode='#url.batchno#'  
            and itemno='#url.itemno#'
			order by batchcode
</cfif>
    
</cfquery>

<cfoutput>  
<input type="hidden" name="issexpdatehid" id="issexpdatehid" value="#dateformat(getitembatch.exp_date,'DD-MM-YYYY')#" />
<input type="hidden" name="issmilcerthid" id="issmilcerthid" value="#getitembatch.milcert#" />

<input type="hidden" name="isspallethid" id="isspallethid" value="#getitembatch.pallet#" />

</cfoutput>
