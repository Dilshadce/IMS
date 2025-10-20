<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset targetTable=form.targetTable>
    <cfset type=form.transactionType>
	
	<cfset criteria="">
	<cfif type NEQ "">
		<cfset criteria=" AND (">
		<cfloop index="i" list="#type#" delimiters=",">
				<cfset criteria=criteria&"type="""&i&""" OR ">
		</cfloop>
		<cfset criteria=Left(criteria,Len(criteria)-4)>
		<cfset criteria=criteria&")">
	</cfif>
		
	<cfset sLimit="">
	<cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
		<cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
	</cfif>		
	
	<cfset sOrder="">
	<cfif IsDefined("form.iSortCol_0")>
		<cfset sOrder="ORDER BY ">
		<cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
			<cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
				<cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
				<cfif Evaluate('form.sSortDir_'&i) EQ "asc">
					<cfset sOrder=sOrder&" ASC,">
				<cfelse>
					<cfset sOrder=sOrder&" DESC,">
				</cfif>
			</cfif>
		</cfloop>
		<cfset sOrder=Left(sOrder,Len(sOrder)-1)>
		<cfif sOrder EQ "ORDER BY">
			<cfset sOrder="">
		</cfif>		
	</cfif>

	<cfset sWhere="">
	<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
		<cfset sWhere=" AND (">
		<cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
			<cfif Evaluate('form.bSearchable_'&i) EQ "true">
				<cfset sWhere=sWhere&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&form.sSearch&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">
	</cfif>
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
		SELECT SQL_CALC_FOUND_ROWS type,refno,custno,wos_date,fperiod
		FROM #targetTable#
        WHERE fperiod != '99'
        AND (posted = '' OR posted IS NULL)
        AND (void = '' OR void IS NULL)
   	    #criteria#
		#sWhere#
		#sOrder#
		#sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(type) AS iTotal
		FROM #targetTable#
        WHERE fperiod != '99'
        AND (posted = '' OR posted IS NULL)
        AND (void = '' OR void IS NULL)
        #criteria#
	</cfquery>
    
	<cfset aaData=ArrayNew(1)>
    <cfloop query="getFilteredDataSet">	
        <cfset data=StructNew()>
        <cfset data["refno"]=" "&getFilteredDataSet.refno>
        <cfset data["type"]=getFilteredDataSet.type>
        <cfset data["custno"]=getFilteredDataSet.custno>  
        <cfset data["wos_date"]=DateFormat(getFilteredDataSet.wos_date,"DD/MM/YYYY")>
        <cfset data["fperiod"]=getFilteredDataSet.fperiod>  
        <cfset ArrayAppend(aaData,data)>
    </cfloop>
	
	<cfset output=StructNew()>
	<cfset output["sEcho"]=form.sEcho>
	<cfset output["iTotalRecords"]=getTotalDataSetLength.iTotal>
	<cfset output["iTotalDisplayRecords"]=getFilteredDataSetLength.iFilteredTotal>
	<cfset output["aaData"]=aaData>
	<cfreturn output>
</cffunction>

<cffunction name="getArtranINDO" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset refno=form.refno>
    
	<cfquery name="getArtranINDO" datasource="#dts#">
		SELECT *
		FROM artranINDO
		WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
	</cfquery>
    
	<cfset output=StructNew()>
	<cfset output["kodeTransaksi"]=getArtranINDO.kodeTransaksi>
	<cfset output["kodeStatus"]=getArtranINDO.kodeStatus>
	<cfset output["kodeDokumen"]=getArtranINDO.kodeDokumen>
	<cfset output["flagVAT"]=getArtranINDO.flagVAT>
	<cfset output["NPWP"]=getArtranINDO.NPWP>
	<cfset output["namaLwnTransaksi"]=getArtranINDO.namaLwnTransaksi>
	<cfset output["nomorDokumen"]=getArtranINDO.nomorDokumen>
	<cfset output["jenisDokumen"]=getArtranINDO.jenisDokumen>
	<cfset output["nomorSeriDiganti"]=getArtranINDO.nomorSeriDiganti>
	<cfset output["jenisDokumenDiganti"]=getArtranINDO.jenisDokumenDiganti>
	<cfset output["tanggalDokumen"]=getArtranINDO.tanggalDokumen>
    <cfset output["tanggalSSP"]=getArtranINDO.tanggalSSP>
    <cfset output["masaPajak"]=getArtranINDO.masaPajak>
    <cfset output["tahunPajak"]=getArtranINDO.tahunPajak>
    <cfset output["pembetulan"]=getArtranINDO.pembetulan>
    <cfset output["DPP"]=getArtranINDO.DPP>
    <cfset output["PPN"]=getArtranINDO.PPN>
    <cfset output["PPnBM"]=getArtranINDO.PPnBM>
	<cfreturn output>
</cffunction>

<cffunction name="updateArtranINDO" access="remote" returntype="boolean">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset refno=form.refno>
    <cfset type=form.type>  
	<cfset kodePajak=form.kodePajak>
	<cfset kodeTransaksi=form.kodeTransaksi>
	<cfset kodeStatus=form.kodeStatus>
	<cfset kodeDokumen=form.kodeDokumen>
	<cfset flagVAT=form.flagVAT>
	<cfset NPWP=form.NPWP>
	<cfset namaLwnTransaksi=form.namaLwnTransaksi>
	<cfset nomorDokumen=form.nomorDokumen>
	<cfset jenisDokumen=form.jenisDokumen>
	<cfset nomorSeriDiganti=form.nomorSeriDiganti>
	<cfset jenisDokumenDiganti=form.jenisDokumenDiganti>
    <cfset tanggalDokumen=form.tanggalDokumen>
    <cfset tanggalSSP=form.tanggalSSP>
    <cfset masaPajak=form.masaPajak>
    <cfset tahunPajak=form.tahunPajak>
    <cfset pembetulan=form.pembetulan>
    <cfset DPP=form.DPP>
    <cfset PPN=form.PPN>
    <cfset PPnBM=form.PPnBM>
    
    <cfquery name="checkExist" datasource="#dts#">
        SELECT refno
        FROM artranINDO
        WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">;
    </cfquery>
    
    <cfif checkExist.recordcount EQ 0>
   
    	<cfquery name="insert_artranINDO" datasource="#dts#">
        	INSERT INTO artranINDO (refno, type, kodePajak, kodeTransaksi, kodeStatus, kodeDokumen, 
                                    flagVAT, npwp, namaLwnTransaksi, nomorDokumen, jenisDokumen, nomorSeriDiganti, 
                                    jenisDokumenDiganti, tanggalDokumen, tanggalSSP, masaPajak, tahunPajak, pembetulan, 
                                    DPP, PPN, PPnBM)
            VALUES(
            
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">,      
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodePajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeTransaksi)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeStatus)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(flagVAT)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(NPWP)#">,         
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(namaLwnTransaksi)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorSeriDiganti)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumenDiganti)#">,
                <cfif tanggalDokumen NEQ ''>
                	<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalDokumen,'YYYY-MM-DD')#">,
                <cfelse>
                	'0000-00-00',                
                </cfif>
                <cfif tanggalSSP NEQ ''>
                	<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalSSP,'YYYY-MM-DD')#">,
                <cfelse>
                	'0000-00-00',
                </cfif>
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(masaPajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(tahunPajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(pembetulan)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(DPP)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPN)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPnBM)#">
            )
        </cfquery>
        <!---INSERT INTO: AMS table --->
        <cfquery name="insert_artranINDO" datasource="#replace(dts,'_i','_a','all')#">
            INSERT INTO artranINDO (refno, type, kodePajak, kodeTransaksi, kodeStatus, kodeDokumen, 
                                    flagVAT, npwp, namaLwnTransaksi, nomorDokumen, jenisDokumen, nomorSeriDiganti, 
                                    jenisDokumenDiganti, tanggalDokumen, tanggalSSP, masaPajak, tahunPajak, pembetulan, 
                                    DPP, PPN, PPnBM)
            VALUES(
            
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">,      
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodePajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeTransaksi)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeStatus)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(flagVAT)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(NPWP)#">,         
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(namaLwnTransaksi)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumen)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorSeriDiganti)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumenDiganti)#">,
                <cfif tanggalDokumen NEQ ''>
                	<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalDokumen,'YYYY-MM-DD')#">,
                <cfelse>
                	'0000-00-00',                
                </cfif>
                <cfif tanggalSSP NEQ ''>
                	<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalSSP,'YYYY-MM-DD')#">,
                <cfelse>
                	'0000-00-00',
                </cfif>
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(masaPajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(tahunPajak)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(pembetulan)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(DPP)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPN)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPnBM)#">
            )
        </cfquery>                    
    <cfelse>   
        <cfquery name="update_artranINDO" datasource="#dts#">
            UPDATE artranINDO
            SET
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">,
                type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">,      
                kodePajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodePajak)#">,
                kodeTransaksi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeTransaksi)#">,
                kodeStatus=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeStatus)#">,
                kodeDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeDokumen)#">,
                flagVAT=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(flagVAT)#">,
                npwp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(NPWP)#">,         
                namaLwnTransaksi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(namaLwnTransaksi)#">,
                nomorDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorDokumen)#">,
                jenisDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumen)#">,
                nomorSeriDiganti=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorSeriDiganti)#">,
                jenisDokumenDiganti=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumenDiganti)#">,
                <cfif tanggalDokumen NEQ ''>
                	tanggalDokumen=<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalDokumen,'YYYY-MM-DD')#">,
                <cfelse>
                	tanggalDokumen='0000-00-00',                
                </cfif>
                <cfif tanggalSSP NEQ ''>
                	tanggalSSP=<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalSSP,'YYYY-MM-DD')#">,
                <cfelse>
                	tanggalSSP='0000-00-00',
                </cfif>
                masaPajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(masaPajak)#">,
                tahunPajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(tahunPajak)#">,
                pembetulan=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(pembetulan)#">,
                DPP=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(DPP)#">,
                PPN=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPN)#">,
                PPnBM=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPnBM)#">    
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">
            AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">;
        </cfquery>
        <!---UPDATE: AMS table --->
        <cfquery name="update_artranINDO" datasource="#replace(dts,'_i','_a','all')#">
            UPDATE artranINDO
            SET
                refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">,
                type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">,      
                kodePajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodePajak)#">,
                kodeTransaksi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeTransaksi)#">,
                kodeStatus=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeStatus)#">,
                kodeDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(kodeDokumen)#">,
                flagVAT=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(flagVAT)#">,
                npwp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(NPWP)#">,         
                namaLwnTransaksi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(namaLwnTransaksi)#">,
                nomorDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorDokumen)#">,
                jenisDokumen=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumen)#">,
                nomorSeriDiganti=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(nomorSeriDiganti)#">,
                jenisDokumenDiganti=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(jenisDokumenDiganti)#">,
                <cfif tanggalDokumen NEQ ''>
                	tanggalDokumen=<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalDokumen,'YYYY-MM-DD')#">,
                <cfelse>
                	tanggalDokumen='0000-00-00',                
                </cfif>
                <cfif tanggalSSP NEQ ''>
                	tanggalSSP=<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(tanggalSSP,'YYYY-MM-DD')#">,
                <cfelse>
                	tanggalSSP='0000-00-00',
                </cfif>
                masaPajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(masaPajak)#">,
                tahunPajak=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(tahunPajak)#">,
                pembetulan=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(pembetulan)#">,
                DPP=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(DPP)#">,
                PPN=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPN)#">,
                PPnBM=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(PPnBM)#">    
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(refno)#">
            AND type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(type)#">;
        </cfquery>
    </cfif>
	<cfreturn true>
</cffunction>
</cfcomponent>