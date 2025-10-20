<cfset key = url.c>
<cfif url.type eq "customer">
<cfset ptype = "arcust" >
<cfelseif url.type eq "supplier">
<cfset ptype = "apvend" >
</cfif>
	<!--- <cfif type eq "customer"> --->
    <cfquery datasource="#dts#" name="getcustsupp">
    <!--- 
    SELECT * FROM custsupp where accno like '#key#%'
    union
    SELECT * FROM custsupp where desp like '#key#%' --->
    select custno as xcustno,name from #ptype# WHERE custno like '#key#%' or name like '#key#%' order by <cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">custno,name<cfelse>name,custno</cfif>
    
<!---     union
     
     select custno as xcustno,name from #ptype# WHERE ' order by <cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">custno,name<cfelse>name,custno</cfif> --->
    </cfquery>
    
    
    
    <select name="custno" id="custno" onChange="updateDetails(this.value);">
    
    <cfoutput query="getcustsupp">
    <option value="#getcustsupp.xcustno#">
    <cfif lcase(HcomID) eq "glenn_i" or lcase(HcomID) eq "glenndemo_i">#name# - #xcustno#<cfelse>#xcustno# - #name#</cfif></option>
    </cfoutput>
    </select>
    
<!--- <cfelseif type eq "printledger1">
    <cfquery datasource="#dts#" name="getcustsupp">
    
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where accno like '#key#%'
    union
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where desp like '#key#%'
    </cfquery>
	<select name="tf_accnofrom" id="tf_accnofrom" style="width:360px">
    <cfoutput query="getcustsupp">						  
    <option value="#getcustsupp.accno#">
	#getcustsupp.accno# - #getcustsupp.singledesp#</option>
    </cfoutput>
    </select>
<cfelseif type eq "printledger2">
<cfquery datasource="#dts#" name="getcustsupp">
    
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where accno like '#key#%'
    union
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where desp like '#key#%'
    </cfquery>
	<select name="tf_accnoto" id="tf_accnoto" style="width:360px">
    <cfoutput query="getcustsupp">						  
    <option value="#getcustsupp.accno#">
	#getcustsupp.accno# - #getcustsupp.singledesp#</option>
    </cfoutput>
    </select>
<cfelseif type eq "trialbalance1">
<cfquery datasource="#dts#" name="getcustsupp">
    
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where accno like '#key#%'
    union
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where desp like '#key#%'
    </cfquery>
	<select name="accnofrom"  style="width:360px"> 
    <cfoutput query="getcustsupp">						  
    <option value="#getcustsupp.accno#">
	#getcustsupp.accno# - #getcustsupp.singledesp#</option>
    </cfoutput>
    </select>
<cfelseif type eq "trialbalance2">
<cfquery datasource="#dts#" name="getcustsupp">
    
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where accno like '#key#%'
    union
    SELECT *,concat(COALESCE(desp,''), ' ', COALESCE(desp2,'')) as singledesp FROM custsupp where desp like '#key#%'
    
    </cfquery>
	<select name="accnoto"  style="width:360px">
    <cfoutput query="getcustsupp">						  
    <option value="#getcustsupp.accno#">
	#getcustsupp.accno# - #getcustsupp.singledesp#</option>
    </cfoutput>
    </select>

<cfelseif type eq "statement1">
<cfset custtable = "">
<cfif isdefined("url.type2")>
<cfif url.type2 eq "Debtor">
<cfset custtable = "arcust">
<cfelse>
<cfset custtable = "apvend">
</cfif>
</cfif>
<cfquery name="getdata" datasource="#dts#">
	
    SELECT custno,custno as accno,concat(COALESCE(name,''), ' ', COALESCE(name2,'')) as singledesp FROM #custtable# where custno like '#key#%'
    union
    SELECT custno,custno as accno,concat(COALESCE(name,''), ' ', COALESCE(name2,'')) as singledesp FROM #custtable# where name like '#key#%'
     
</cfquery>
<select name="nofrom"  style="width:360px">
          <cfoutput query="getdata">						  
          <option value="#getdata.accno#">
			#getdata.accno# - #getdata.singledesp#</option>
           </cfoutput>
      </select>
<cfelseif type eq "statement2">
<cfset custtable = "">
<cfif isdefined("url.type2")>
<cfif url.type2 eq "Debtor">
<cfset custtable = "arcust">
<cfelse>
<cfset custtable = "apvend">
</cfif>
</cfif>
<cfquery name="getdata" datasource="#dts#">
	
    SELECT custno,custno as accno,concat(COALESCE(name,''), ' ', COALESCE(name2,'')) as singledesp FROM #custtable# where custno like '#key#%'
    union
    SELECT custno,custno as accno,concat(COALESCE(name,''), ' ', COALESCE(name2,'')) as singledesp FROM #custtable# where name like '#key#%'
     
</cfquery>
<select name="noto" style="width:360px">
          <cfoutput query="getdata">						  
          <option value="#getdata.accno#">
			#getdata.accno# - #getdata.singledesp#</option>
           </cfoutput>
      </select>
</cfif>
 --->







<cfsetting showdebugoutput="no">