<!---address --->
<cfquery name="moveaddress" datasource="importfromdbf">
SELECT * FROM address
</cfquery>

<cfloop query="moveaddress">

<cfquery name="insertaddress" datasource="#dts#">
INSERT IGNORE INTO address 
(
CODE,
NAME,
CUSTNO,
ADD1,
ADD2,
ADD3,
ADD4,
COUNTRY,
POSTALCODE,
ATTN,
PHONE,
FAX,
PHONEA,
E_MAIL
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.CODE)#">,
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.CUSTNO)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.ADD1)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.ADD2)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.ADD3)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.ADD4)#">,
'',
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(moveaddress.ATTN)#">,
'',
'',
'',
''
)
</cfquery>

</cfloop>

