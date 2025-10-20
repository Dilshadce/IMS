<cfsetting showdebugoutput="no">
<cfif isdefined('url.voucherfrom')>
<cfquery name="getvoucher" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type,a.used from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.type = "Value" 
            and custno in (SELECT custno FROM voucher WHERE voucherno = "#URLDECODE(url.voucherfrom)#")
            order by a.voucherno
</cfquery>
<cfoutput>
<select name="vouchernumto" id="vouchernumto" onChange="assignvoucherto(this.value,this.options[this.selectedIndex].id,this.options[this.selectedIndex].title);counttransfer();">
			<option value="" id="0">Select a voucher</option>
            <cfloop query="getvoucher">
            <option value="#getvoucher.voucherno#" id="#getvoucher.value#" title="#getvoucher.type#">
            #getvoucher.voucherno#-$ #numberformat(getvoucher.value,'.__')#
            </option>
            </cfloop>
</select>
</cfoutput>
</cfif>