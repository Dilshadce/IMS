<cfif getHeaderInfo.type EQ "TR">
    <cfquery name="getTransferFrom" datasource='#dts#'>
       SELECT location,desp,addr1 AS add1,addr2 AS add2,addr3 AS add3,addr4 AS add4   
       FROM iclocation 
       WHERE location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.rem1#">
    </cfquery>
    
    <cfset getCustAdd.name = getHeaderInfo.name>
    <cfset getCustAdd.name2 = getTransferFrom.location &"-"& getTransferFrom.desp>
    <cfset getCustAdd.add1 = getTransferFrom.add1>
    <cfset getCustAdd.add2 = getTransferFrom.add2>
    <cfset getCustAdd.add3 = getTransferFrom.add3>
    <cfset getCustAdd.add4 = getTransferFrom.add4>
    <cfset getCustAdd.country = "">
    <cfset getCustAdd.postalcode = "">
    <cfset getCustAdd.attn = "">
    <cfset getCustAdd.phone = "">
    <cfset getCustAdd.phonea = "">
    <cfset getCustAdd.fax = "">
    <cfset getCustAdd.e_mail = "">
    <cfset getCustAdd.GSTno = "">
    
<cfelseif getHeaderInfo.rem0 NEQ "">
    <cfif getHeaderInfo.rem0 EQ "Profile">
        <cfquery name="getCustAdd" datasource='#dts#'>
            SELECT 	name,name2,add1,add2,add3,add4,country,postalcode,
                    attn,phone,phonea,fax,e_mail,gstno,vatno 
            FROM #ptype# 
            WHERE custno = '#getHeaderInfo.custno#'; 
        </cfquery>
    <cfelse>
        <cfquery name="getCustAdd" datasource='#dts#'>
            SELECT 	a.name,'' AS name2,a.add1,a.add2,a.add3,a.add4,a.country,a.postalcode,
                    a.attn,a.phone,a.phonea,a.fax,b.e_mail,a.gstno,vatno
            FROM address a			
            LEFT JOIN #ptype# AS b ON a.custno = b.custno
            WHERE a.code = '#getHeaderInfo.rem0#';
        </cfquery>
    </cfif>
<cfelse>
    <cfset getCustAdd.name = getHeaderInfo.frem0>
    <cfset getCustAdd.name2 = getHeaderInfo.frem1>
    <cfset getCustAdd.add1 = getHeaderInfo.frem2>
    <cfset getCustAdd.add2 = getHeaderInfo.frem3>
    <cfset getCustAdd.add3 = getHeaderInfo.frem4>
    <cfset getCustAdd.add4 = getHeaderInfo.frem5>
    <cfset getCustAdd.country = getHeaderInfo.country>
    <cfset getCustAdd.postalcode = getHeaderInfo.postalcode>
    <cfset getCustAdd.attn = getHeaderInfo.rem2>
    <cfset getCustAdd.phone = getHeaderInfo.rem4>
    <cfset getCustAdd.phonea = getHeaderInfo.phonea>
    <cfset getCustAdd.fax = getHeaderInfo.frem6>
    <cfset getCustAdd.e_mail = getHeaderInfo.e_mail>
    <cfset getCustAdd.GSTno = getHeaderInfo.b_GSTno>
</cfif>
    
<cfif getHeaderInfo.type EQ "TR">
    <cfquery name="getTransferTo" datasource='#dts#'>
       SELECT location,desp,addr1 AS add1,addr2 AS add2,addr3 AS add3,addr4 AS add4   
       FROM iclocation 
       WHERE location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.rem2#">
    </cfquery>
    
    <cfset getDeliveryAdd.name = getHeaderInfo.name>
    <cfset getDeliveryAdd.name2 = getTransferTo.location &"-"& getTransferTo.desp>
    <cfset getDeliveryAdd.add1 = getTransferTo.add1>
    <cfset getDeliveryAdd.add2 = getTransferTo.add2>
    <cfset getDeliveryAdd.add3 = getTransferTo.add3>
    <cfset getDeliveryAdd.add4 = getTransferTo.add4>
    <cfset getDeliveryAdd.country = "">
    <cfset getDeliveryAdd.postalcode = "">
    <cfset getDeliveryAdd.attn = "">
    <cfset getDeliveryAdd.phone = "">
    <cfset getDeliveryAdd.phonea = "">
    <cfset getDeliveryAdd.fax = "">
    <cfset getDeliveryAdd.d_email = "">
    <cfset getDeliveryAdd.GSTno = "">
    
<cfelseif getHeaderInfo.rem1 NEQ "">
    <cfif getHeaderInfo.rem1 eq "Profile">
        <cfquery name="getDeliveryAdd" datasource='#dts#'>
            SELECT  name,name2,daddr1 AS add1,daddr2 AS add2,daddr3 AS add3,daddr4 AS add4,d_country AS country,d_postalcode AS postalcode,
                    dattn AS attn,dphone AS phone,contact AS phonea,dfax AS fax,d_email,gstno,vatno
            FROM #ptype#
            WHERE custno = '#getHeaderInfo.custno#';
        </cfquery>
    <cfelse>
        <cfquery name="getDeliveryAdd" datasource='#dts#'>
            SELECT 	a.name,'' as name2,a.add1,a.add2,a.add3,a.add4,a.country,a.postalcode,
                    a.attn,a.phone,b.contact AS phonea,a.fax,b.d_email,a.gstno,vatno
            FROM address a			
            LEFT JOIN #ptype# AS b ON a.custno = b.custno
            WHERE a.code = '#getHeaderInfo.rem1#';
        </cfquery>
    </cfif>
<cfelse>
    <cfset getDeliveryAdd.name = getHeaderInfo.frem7>
    <cfset getDeliveryAdd.name2 = getHeaderInfo.frem8>
    <cfset getDeliveryAdd.add1 = getHeaderInfo.comm0>
    <cfset getDeliveryAdd.add2 = getHeaderInfo.comm1>
    <cfset getDeliveryAdd.add3 = getHeaderInfo.comm2>
    <cfset getDeliveryAdd.add4 = getHeaderInfo.comm3>
    <cfset getDeliveryAdd.country = getHeaderInfo.d_country>
    <cfset getDeliveryAdd.postalcode = getHeaderInfo.d_postalcode>
    <cfset getDeliveryAdd.attn = getHeaderInfo.rem3>
    <cfset getDeliveryAdd.phone = getHeaderInfo.rem12>
    <cfset getDeliveryAdd.phonea = getHeaderInfo.d_phone2>
    <cfset getDeliveryAdd.fax = getHeaderInfo.comm4>
    <cfset getDeliveryAdd.d_email = getHeaderInfo.d_email>
    <cfset getDeliveryAdd.GSTno = getHeaderInfo.d_GSTno>
</cfif>