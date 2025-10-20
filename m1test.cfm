<cfsetting enablecfoutputonly="no">
<cfinvoke 
webservice="http://c.netiquette.com.sg/m1provision.cfc?wsdl"
method="ProcessRequest"
returnvariable="returnvar">
<cfinvokeargument name="OPERATION" value="UPDATEDTL" />
    <cfinvokeargument name="SERVICE_ID"  value="12"	/>
    <cfinvokeargument name="BILL_PLAN_ID" value="12" />
    <cfinvokeargument name="NEW_BILL_PLAN_ID" value="12"	/>
	<cfinvokeargument name="VAS_ID" value="12"	/>
    <cfinvokeargument name="VAS_USR" value="12"	/>
    <cfinvokeargument name="TRXN_DATE" value="12"	/>
    <cfinvokeargument name="TRXN_ID" value="12"	/>
    <cfinvokeargument name="EMAIL_ADDR" value="12"	/>
    <cfinvokeargument name="CONTACT_NO" value="12"	/>
    <cfinvokeargument name="CONTACT_PERSON" value="12"	/>
    <cfinvokeargument name="LOGIN_ID" value="m1provisionacc" 	/>
    <cfinvokeargument name="LOGIN_PWD" value="8888"	/>
</cfinvoke>

 
<cfoutput>
<!--- Display compliment. --->
#returnvar#
</cfoutput>
