<cfoutput>
	<cftry>
    	<cfquery name="checkExist" datasource="#dts#">
			SELECT refno 
            FROM artranINDO
			WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="##">;
		</cfquery>
        
		<cfif checkExist.recordcount EQ 0>
            <cfquery name="insert_artranINDO" datasource="#dts#">
                INSERT INTO artranINDO (refno, type, kodePajak, kodeTransaksi, kodeStatus, kodeDokumen, 
                                        flagVAT, npwp, namaLwnTransaksi, nomorDokumen, jenisDokumen, nomorSeriDiganti, 
                                        jenisDokumenDiganti, tanggalDokumen, tanggalSSP, masaPajak, tahunPajak, pembetulan, 
                                        DPP, PPN, PPnBM)
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,      
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodePajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeStatus)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.flagVAT)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.NPWP)#">,         
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.namaLwnTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorSeriDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumenDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalDokumen,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalSSP,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.masaPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.tahunPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pembetulan)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.DPP)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPN)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPnBM)#">
                )
            </cfquery>
            
            <cfquery name="insert_artranINDO" datasource="#replace(dts,'_i','_a','all')#">
                INSERT INTO artranINDO (refno, type, kodePajak, kodeTransaksi, kodeStatus, kodeDokumen, 
                                        flagVAT, npwp, namaLwnTransaksi, nomorDokumen, jenisDokumen, nomorSeriDiganti, 
                                        jenisDokumenDiganti, tanggalDokumen, tanggalSSP, masaPajak, tahunPajak, pembetulan, 
                                        DPP, PPN, PPnBM)
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,      
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodePajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeStatus)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.flagVAT)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.NPWP)#">,         
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.namaLwnTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorSeriDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumenDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalDokumen,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalSSP,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.masaPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.tahunPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pembetulan)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.DPP)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPN)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPnBM)#">
                )
            </cfquery>
                            
        <cfelse>
            <cfquery name="update_artranINDO" datasource="#dts#">
                UPDATE artranINDO
                SET
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,      
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodePajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeStatus)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.flagVAT)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.NPWP)#">,         
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.namaLwnTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorSeriDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumenDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalDokumen,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalSSP,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.masaPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.tahunPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pembetulan)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.DPP)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPN)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPnBM)#">    
                WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="##">
                AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="##">;
            </cfquery> 
            
            <cfquery name="update_artranINDO" datasource="#replace(dts,'_i','_a','all')#">
                UPDATE artranINDO
                SET
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="##">,      
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodePajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeStatus)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.kodeDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.flagVAT)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.NPWP)#">,         
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.namaLwnTransaksi)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumen)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.nomorSeriDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.jenisDokumenDiganti)#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalDokumen,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_datetime" value="#DateFormat(form.tanggalSSP,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.masaPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.tahunPajak)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.pembetulan)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.DPP)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPN)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.PPnBM)#">    
                WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="##">
                AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="##">;
            </cfquery>
             
        </cfif>	
    	<cfcatch>
        	<script type="text/javascript">
				alert('Failed to update !\nError Message: #cfcatch.message#');
				window.open('/latest/generalSetup/eSPT/eSPT.cfm','_self');
			</script>
        </cfcatch>
	</cftry>
    <script type="text/javascript">
		alert('Updated ## successfully!');
		window.open('/latest/generalSetup/eSPT/eSPT.cfm','_self');
	</script>	        
</cfoutput>