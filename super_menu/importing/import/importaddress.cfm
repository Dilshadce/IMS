<!---address --->
<cfquery name="moveaddress" datasource="importfromdbf">
SELECT * FROM address
</cfquery>

<cfloop query="moveaddress">

<cfquery name="insertaddress" datasource="#dts#">
INSERT IGNORE INTO address
(
ITEMNO,
CODE,
NAME,
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
<cfqueryparam cfsqltype="cf_sql_varchar" value="POS#REPLACE(moveaddress.CODE," ","",'all')#">,
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.NAME#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.ADD1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.ADD2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.ADD3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.ADD4#">,
'',
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#moveaddress.ATTN#">,
'',
'',
'',
''
)
</cfquery>

</cfloop>

