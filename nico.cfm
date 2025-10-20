
<cfoutput>
<!---<cfquery name="getGsetupData" datasource="#dts#">
	SELECT ldriver FROM Gsetup
</cfquery>--->

<!---<cfloop query="getGsetupData">
#getGsetupData.ldriver#
</cfloop>--->
<!---<cfquery name="getremarkdetail" datasource="#dts#">
	SELECT * 
	FROM extraremark;
</cfquery>--->

<cfquery name="getWordsData" datasource="main">
	SELECT * 
	FROM words
    ORDER BY id*1;
</cfquery>

<cfloop query="getWordsData">
#getWordsData.id#
</cfloop>
<br />
<cfloop query="getWordsData">
#getWordsData.sim_ch#
</cfloop>
<!---<cfquery name="test" datasource="#dts#">
	desc vehimodel
</cfquery>

<cfdump var="#test#">--->
<!---<cfloop query="getGsetupData">
#getGsetupData.lRC#
<br>
#getGsetupData.lPR#
<br>
#getGsetupData.lDO#
<br>
#getGsetupData.lINV#
<br>
#getGsetupData.lCS#
<br>
#getGsetupData.lCN#
<br>
#getGsetupData.lDN#
<br>
#getGsetupData.lPO#
<br>
#getGsetupData.lQUO#
<br>
#getGsetupData.lSO#
<br>
#getGsetupData.lSAM#
<br>
#getGsetupData.lRQ#
<br>
<br>
#getGsetupData.refno2#
<br>
<br>
#getGsetupData.rem5#
<br>
#getGsetupData.rem6#
<br>
#getGsetupData.rem7#
<br>
#getGsetupData.rem8#
<br>
#getGsetupData.rem9#
<br>
#getGsetupData.rem10#
<br>
#getGsetupData.rem11#
<br>
</cfloop>
<cfloop query="getremarkdetail">
<br>
<br>
#getremarkdetail.rem30#
<br>
#getremarkdetail.rem31#
<br>
#getremarkdetail.rem32#
<br>
#getremarkdetail.rem45#
<br>
#getremarkdetail.rem46#
</cfloop>--->
</cfoutput>