<cfquery name="gettaxprofile" datasource="#dts#">
SELECT arrem5,arrem7 FROM arcust WHERE custno = "#url.custno#"
</cfquery>

<div>
<cfif gettaxprofile.arrem5 neq "">
    
    <cfif trim(gettaxprofile.arrem7) eq "1" and datediff('d',lsdateformat("31/08/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((url.completedate),'YYYY-MM-DD', 'en_AU')) gt 0>
         <cfset gettaxprofile.arrem5 = "GSTITEMIZED">
    </cfif>
    
    <cfquery name="gettaxmethod" datasource="#dts#">
    SELECT * FROM taxmethod WHERE taxname = "#gettaxprofile.arrem5#"
    </cfquery>    
    
    <cfif gettaxmethod.taxableitem eq "Y">
     
     	<cfquery name="gettaxitem" datasource="#dts#">
        SELECT group_concat(taxitemid) taxitemid  FROM taxmethoditem WHERE taxmethodid = "#gettaxmethod.id#"
        </cfquery> 
        
        <cfoutput>
        <input type="hidden" name="taxitem" id="taxitem" value="#gettaxitem.taxitemid#"/>
        </cfoutput>
       
    <cfelse>
        
        <input type="hidden" name="taxitem" id="taxitem" value=""/>
        
    </cfif>
        
<cfelse>
        
    <input type="hidden" name="taxitem" id="taxitem" value=""/>
    
</cfif>
</div>
        