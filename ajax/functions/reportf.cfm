<cfinclude template="../core/cfajax.cfm">

<cffunction name="productlookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">

	<cfquery name="getdealer_menu" datasource="#dts#">
		select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
	</cfquery>
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getItem" datasource="#dts#">
			SELECT itemno,<cfif dts eq "vsolutionspteltd_i">concat(itemno,",",itemno," - ",aitemno,' ------',desp)<cfelse>concat(itemno,",",itemno," - ",desp)</cfif> as desp FROM icitem
			where 
			<cfif dts eq "mhca_i">desp like '#arguments.inputtext#%' or despa like '%#arguments.inputtext#%' <cfelse>itemno like '#arguments.inputtext#%' </cfif>
			and (nonstkitem<>'T' or nonstkitem is null)and (itemtype <> "SV" or itemtype is null)
			order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
		</cfquery>
	<cfelse>
		<cfquery name="getItem" datasource="#dts#">
        	SELECT "" as itemno," ,Choose a product" as desp
            union all
			SELECT itemno,concat(itemno,",",itemno," - ",desp) as desp FROM icitem
			where (nonstkitem<>'T' or nonstkitem is null) and (itemtype <> "SV" or itemtype is null)
			order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
		</cfquery>
	</cfif>
	
	<cfset model = ArrayNew(1)>
	<cfif getItem.recordcount eq 0>
		<cfset ArrayAppend(model," ,Choose a product")>
   	<cfelse>
      	 <cfset model = ListToArray(ValueList(getItem.desp, Chr(31) ), Chr(31) ) />
	</cfif>

	
	<cfreturn model>
</cffunction>

<cffunction name="productCodeLookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">

	<cfquery name="getdealer_menu" datasource="#dts#">
		select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
	</cfquery>
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getItem" datasource="#dts#">
			SELECT aitemno,concat(aitemno," - ",desp) as desp 
            FROM icitem
			where 
			<cfif dts eq "mhca_i">desp like '#arguments.inputtext#%' or despa like '%#arguments.inputtext#%' <cfelse>aitemno like '#arguments.inputtext#%' </cfif>
			and (nonstkitem<>'T' or nonstkitem is null)and (itemtype <> "SV" or itemtype is null)
			order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>aitemno</cfif>
		</cfquery>
	<cfelse>
		<cfquery name="getItem" datasource="#dts#">
        	SELECT "" as aitemno," ,Choose a product" as desp
            union all
			SELECT aitemno,concat(aitemno,",",aitemno," - ",desp) as desp FROM icitem
			where (nonstkitem<>'T' or nonstkitem is null) and (itemtype <> "SV" or itemtype is null)
			order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>aitemno</cfif>
		</cfquery>
	</cfif>
	
	<cfset model = ArrayNew(1)>
	<cfif getItem.recordcount eq 0>
		<cfset ArrayAppend(model," ,Choose a product")>
   	<cfelse>
      	 <cfset model = ListToArray(ValueList(getItem.desp, Chr(31) ), Chr(31) ) />
	</cfif>

	
	<cfreturn model>
</cffunction>

<cffunction name="locationlookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	
	<!--- Add On 12-01-2010 --->
	<cfquery name="getdealer_menu" datasource="#dts#">
		select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
	</cfquery>
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getlocation" datasource="#dts#">
			SELECT location,concat(location,",",location," - ",desp) as desp FROM iclocation
			where 
			location like '#arguments.inputtext#%'
            <cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
			and location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery>
	<cfelse>
		<cfquery name="getlocation" datasource="#dts#">
        	SELECT "" as location," ,Choose a Location" as desp
            union all
			SELECT location,concat(location,",",location," - ",desp) as desp FROM iclocation
			<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super' and Huserloc neq "All_loc">
			where location in (#ListQualify(Huserloc,"'",",")#)
			</cfif>
			order by location
		</cfquery>
	</cfif>
	
	<cfset model = ArrayNew(1)>
	<cfif getlocation.recordcount eq 0>
		<cfset ArrayAppend(model," ,Choose a location")>
   	<cfelse>
      	 <cfset model = ListToArray(ValueList(getlocation.desp, Chr(31) ), Chr(31) ) />
	</cfif>

	
	<cfreturn model>
</cffunction>

<cffunction name="enduserlookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getEnduser" datasource="#dts#">
			select * from driver
			where name like '#arguments.inputtext#%'
			order by driverno
		</cfquery>
	<cfelse>
		<cfquery name="getEnduser" datasource="#dts#">
			select * from driver
			order by driverno
		</cfquery>
	</cfif>
	
	<cfset model = ArrayNew(1)>
	<cfif getEnduser.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Choose a End User")>
	</cfif>
	
	<cfloop query="getEnduser">
		<cfset ArrayAppend(model,"#driverno#,#driverno# - #name#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="categorylookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getCate" datasource="#dts#">
			select * from iccate 
			where desp like '#arguments.inputtext#%'
			order by cate
		</cfquery>
	<cfelse>
		<cfquery name="getCate" datasource="#dts#">
			select * from iccate
			order by cate
		</cfquery>
	</cfif>
	
	<cfset model = ArrayNew(1)>
	<cfif getCate.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Choose a Category")>
	</cfif>
	
	<cfloop query="getCate">
		<cfset ArrayAppend(model,"#cate#,#cate# - #desp#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="grouplookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getgroup" datasource="#dts#">
			select wos_group, desp from icgroup 
			where wos_group like '#arguments.inputtext#%'
			order by wos_group
		</cfquery>
	<cfelse>
		<cfquery name="getgroup" datasource="#dts#">
			select wos_group, desp from icgroup 
			order by wos_group
		</cfquery>
	</cfif>
	
		
	<cfset model = ArrayNew(1)>
	<cfif getgroup.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Choose a Group")>
	</cfif>
	
	<cfloop query="getgroup">
		<cfset ArrayAppend(model,"#wos_group#,#wos_group# - #desp#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="supplierlookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	<cfargument name="option" required="yes" type="string">
	
	<!--- Add On 12-01-2010 --->
	<cfquery name="getdealer_menu" datasource="#dts#">
		select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
	</cfquery>
	
	<cfif arguments.inputtext neq "">
		<!--- <cfquery name="getsupp" datasource="#dts#">
    		select custno,name from <cfif arguments.option eq "Supplier">#target_apvend#<cfelse>#target_arcust#</cfif> 
			where name like '#arguments.inputtext#%'
			order by name,custno
		</cfquery> --->
		<cfquery name="getsupp" datasource="#dts#">
    		select custno,name from <cfif arguments.option eq "Supplier">#target_apvend#<cfelse>#target_arcust#</cfif> 
			where name like '%#arguments.inputtext#%'
			
			union
	            
	       	select custno,name from <cfif arguments.option eq "Supplier">#target_apvend#<cfelse>#target_arcust#</cfif> 
			where custno like '%#arguments.inputtext#%'
			
			order by #getdealer_menu.custSuppSortBy#
		</cfquery>
	<cfelse>
		<cfquery name="getsupp" datasource="#dts#">
    		select custno,name from <cfif arguments.option eq "Supplier">#target_apvend#<cfelse>#target_arcust#</cfif>
			order by #getdealer_menu.custSuppSortBy#
		</cfquery>
	</cfif>
		
	<cfset model = ArrayNew(1)>
	<cfif getsupp.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Choose a #arguments.option#")>
	</cfif>
	
	<cfloop query="getsupp">
		<cfset ArrayAppend(model,"#custno#,#custno# - #name#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="serialnolookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputtext" required="yes" type="string">
	
	<cfif arguments.inputtext neq "">
		<cfquery name="getserial" datasource="#dts#">
			select distinct(serialno) from iserial where type <> 'QUO' and type <> 'PO'
			and type <> 'SO'
			and serialno like '#arguments.inputtext#%'
			order by serialno
		</cfquery>
	<cfelse>
		<cfquery name="getserial" datasource="#dts#">
			select distinct(serialno) from iserial where type <> 'QUO' and type <> 'PO'
			and type <> 'SO'
			order by serialno
		</cfquery>
	</cfif>
	
		
	<cfset model = ArrayNew(1)>
	<cfif getserial.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Choose a Serial No")>
	</cfif>
	
	<cfloop query="getserial">
		<cfset ArrayAppend(model,"#serialno#,#serialno#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>
<cffunction name="custrefnolookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="inputCustno" required="yes" type="string">
	<cfargument name="inputType" required="yes" type="string">
	
	<cfquery name="getRefno" datasource="#dts#">
		SELECT refno,refno as rtext 
		FROM artran a 
		where type='#arguments.inputType#' 
		and custno='#arguments.inputCustno#'
		and fperiod <>  '99'
		order by refno
	</cfquery>
		
	<cfset model = ArrayNew(1)>
	<cfset ArrayAppend(model,"--,Please choose one")>
	
	<cfloop query="getRefno">
		<cfset ArrayAppend(model,"#refno#,#rtext#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="permitnolookup" hint="type='keyvalue' jsreturn='array'">
	<cfargument name="type" required="yes" type="string">
	<cfargument name="inputtext" required="yes" type="string">
	
	<cfif arguments.inputtext neq "">
		<cfif arguments.type eq "opening">
			<cfquery name="getpermit" datasource="#dts#">
				select permit_no 
				from obbatch 
				where permit_no <> '' and permit_no like '#arguments.inputtext#%' 
				group by permit_no
			</cfquery>
		<cfelse>
			<cfquery name="getpermit" datasource="#dts#">
	            select brem5 as permit_no from ictran where brem5 <> '' and brem5 like '#arguments.inputtext#%' group by brem5
	            union
	            select brem7 as permit_no from ictran where brem7 <> '' and brem7 like '#arguments.inputtext#%' group by brem7
	            union
	            select brem8 as permit_no from ictran where brem8 <> '' and brem8 like '#arguments.inputtext#%' group by brem8
	            union 
	            select brem9 as permit_no from ictran where brem9 <> '' and brem9 like '#arguments.inputtext#%' group by brem9
	            union
	            select brem10 as permit_no from ictran where brem10 <> '' and brem10 like '#arguments.inputtext#%' group by brem10
			</cfquery>
		</cfif>			
	<cfelse>
		<cfif arguments.type eq "opening">
			<cfquery name="getpermit" datasource="#dts#">
				select permit_no from obbatch where permit_no <> '' group by permit_no
			</cfquery>
		<cfelse>
			<cfquery name="getpermit" datasource="#dts#">
				select brem5 as permit_no from ictran where brem5 <> '' group by brem5
	            union
	            select brem7 as permit_no from ictran where brem7 <> '' group by brem7
	            union
	            select brem8 as permit_no from ictran where brem8 <> '' group by brem8
	            union 
	            select brem9 as permit_no from ictran where brem9 <> '' group by brem9
	            union
	            select brem10 as permit_no from ictran where brem10 <> '' group by brem10
			</cfquery>
		</cfif>
	</cfif>
	
		
	<cfset model = ArrayNew(1)>
	<cfif getpermit.recordcount eq 0 or arguments.inputtext eq "">
		<cfset ArrayAppend(model," ,Please select one")>
	</cfif>
	
	<cfloop query="getpermit">
		<cfset ArrayAppend(model,"#permit_no#,#permit_no#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>