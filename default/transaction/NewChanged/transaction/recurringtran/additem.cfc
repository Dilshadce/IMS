<cfcomponent output="false">
	
	<cffunction name="getItem" access="remote" returntype="any">
		<cfargument name="page" required="yes">
      	<cfargument name="pageSize" required="yes">
    	<cfargument name="gridsortcolumn" required="yes">
	    <cfargument name="gridsortdirection" required="yes">
	    <cfargument name="rowbill" required="no" default="">
        <cfargument name="rowtype" required="no" default="">
        <cfargument name="dts" required="no" default="">
        <cfargument name="rowcustno" required="no" default="">
		<cfset refnolen = len(rowbill)>
        <cfif refnolen eq 0>
        <cfset refnolen = 3>
		</cfif>
        <cfset rowbill = right(rowbill,refnolen - 2)>
	    <cfquery name="selUsers" datasource="#dts#">
			SELECT
				concat(' ',itemno) as itemno,
                desp,
                despa,
                qty_bil,
                price_bil,
                trancode,
                amt_bil
			FROM
				currictran
			<cfif Arguments.rowbill NEQ "">
				WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Arguments.rowcustno#">
			</cfif>
			<cfif Arguments.gridsortcolumn NEQ "">
				ORDER BY #Arguments.gridsortcolumn# #Arguments.gridsortdirection#
			</cfif>
		</cfquery>
		
		<cfreturn queryconvertforgrid(selUsers,Arguments.page,Arguments.pagesize)/>
	    
	</cffunction>
	
	<cffunction name="getItemColumns" access="remote" returntype="any">
    
		<cfargument name="dts" required="no">
		<cfquery name="selUsers" datasource="#dts#" result="selResult">
			SELECT
				itemno,
                desp
			FROM
				currictran
		</cfquery>
		
		<cfset selColumns = QueryNew("ColumnName,ColumnID")>
		
		<cfloop list="#selResult.columnList#" index="listIndex">
			<cfset temp = QueryAddRow(selColumns,1)>
			<cfset temp = QuerySetCell(selColumns,"ColumnName","#listIndex#")>
			<cfset temp = QuerySetCell(selColumns,"ColumnID","#Val(selColumns.RecordCount-1)#")>
		</cfloop>
		
		<cfreturn selColumns>
		
	</cffunction>
    
    <cffunction name="editItem" access="remote">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
        <cfargument name="dts" required="no">
		<cfargument name="HuserID" required="no">
        <cfargument name="rowbill" required="no" default="">
        <cfargument name="rowtype" required="no" default="">
        <cfargument name="rowcustno" required="no" default="">
        <!--- Local variables --->
        <cfset var colname="">
        <cfset var value="">
		<cfset SetLocale("English (UK)")>
		<cfset currentdatetime = '#lsdateformat(now(), "YYYY-MM-DD")# #timeformat(now(), "HH:MM:SS")#'>
        <!--- Process gridaction --->
        <cfset refnolen = len(rowbill)>
        <cfset rowbill = right(rowbill,refnolen - 2)>
        <cfswitch expression="#ARGUMENTS.gridaction#">
            <!--- Process updates --->
            <cfcase value="U">
                <!--- Get column name and value --->
                <cfset colname=StructKeyList(ARGUMENTS.gridchanged)>
                <cfset value=ARGUMENTS.gridchanged[colname]>
                
                <cfquery datasource="#dts#">
                UPDATE currictran
                SET #colname# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#value#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ARGUMENTS.gridrow.itemno)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.trancode#">
                </cfquery>
                <cfif colname eq "qty_bil" or colname eq "price_bil"> 
                <cfquery name="updatesub" datasource="#dts#">
                SELECT * FROM currictran 
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ARGUMENTS.gridrow.itemno)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.trancode#"> 
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfset qty = updatesub.qty_bil * updatesub.factor1 / updatesub.factor2 >
                <cfset price = updatesub.price_bil * updatesub.currrate>
                <cfset amt1_bil = updatesub.qty_bil * updatesub.price_bil>
                
                <cfset amt1 = amt1_bil * updatesub.currrate>
                <cfset namt1_bil = amt1_bil>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec1/100)>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec2/100)>
                <cfset namt1_bil = namt1_bil - (namt1_bil * updatesub.dispec3/100)>
                <cfset disamt_bil = amt1_bil - namt1_bil>
                <cfif disamt_bil eq 0>
                <cfset disamt_bil = updatesub.disamt_bil>
				</cfif>
				<cfset amt_bil = namt1_bil > 
				<cfif updatesub.taxincl neq "T">
				<cfset taxamt_bil = amt_bil * updatesub.taxpec1/100 >
                <cfelse>
                <cfset taxamt_bil = amt_bil * (updatesub.taxpec1/(100 + (updatesub.taxpec1 * 1))) >
				</cfif>
                <cfset amt = amt_bil * updatesub.currrate>
                <cfset disamt = disamt_bil * updatesub.currrate>
				<cfset taxamt = taxamt_bil * updatesub.currrate >
				
               
               	<cfquery name="updatedetail" datasource="#dts#">
                UPDATE currictran
                SET
                qty = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qty#">,
                amt1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt1_bil#">,
                amt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt_bil#">,
                price = <cfqueryparam cfsqltype="cf_sql_varchar" value="#price#">,
                amt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt1#">,
                amt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#amt#">,
                disamt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disamt_bil#">,
                disamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disamt#">,
                taxamt_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamt_bil#">,
                taxamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxamt#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ARGUMENTS.gridrow.itemno)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.trancode#"> 
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfquery name="getitempertax" datasource="#dts#">
                SELECT wpitemtax FROM gsetup
                </cfquery>
                
                <cfquery name="getsum" datasource="#dts#">
                SELECT sum(amt_bil) as sumamt,sum(taxamt_bil) as taxamt FROM currictran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfquery name="getTax" datasource="#dts#">
                SELECT currrate,disp1,disp2,disp3,taxp1,taxincl FROM currartran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfset gross_bil = getsum.sumamt>
                <cfset ngross_bil = gross_bil>
                <cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp1/100)>
                <cfset disc1_bil = gross_bil - ngross_bil>
				<cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp2/100)>
                <cfset disc2_bil = gross_bil - ngross_bil - disc1_bil>
                <cfset ngross_bil = ngross_bil - (ngross_bil * getTax.disp3/100)>
                <cfset disc3_bil = gross_bil - ngross_bil - disc2_bil-disc1_bil>
                <cfset disc_bil = gross_bil - ngross_bil>
                <cfset net_bil = ngross_bil>
                <cfif getitempertax.wpitemtax neq "1">
                <cfif getTax.taxincl eq "T">
                <cfset tax1_bil = net_bil * (getTax.taxp1/(100+getTax.taxp1))>
                <cfset grand_bil = net_bil>
                <cfelse>
                <cfset tax1_bil = net_bil * (getTax.taxp1/100)>
                <cfset grand_bil = net_bil + tax1_bil>
				</cfif>
                <cfelse>
                <cfset tax1_bil = getsum.taxamt>
                <cfset grand_bil = net_bil + tax1_bil>
                </cfif>
                <cfset tax_bil = tax1_bil>
                <cfset invgross = gross_bil * getTax.currrate>
                <cfset discount1 = disc1_bil * getTax.currrate>
                <cfset discount2 = disc2_bil * getTax.currrate>
                <cfset discount3 = disc3_bil * getTax.currrate>
                <cfset discount = disc_bil * getTax.currrate>
                <cfset net = net_bil * getTax.currrate>
                <cfset tax = tax_bil * getTax.currrate>
                <cfset grand = grand_bil * getTax.currrate>
                <cfif rowtype eq "rc" or rowtype eq "pr" or rowtype eq "po">
                <cfset debitamt = 0>
                <cfset creditamt = grand>
				<cfelse>
                <cfset debitamt = grand>
                <cfset creditamt = 0>
                </cfif>
                
                <cfquery name="getSum" datasource="#dts#">
                Update currartran
                SET
                gross_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
                disc1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
                disc2_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
                disc3_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
                disc_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
                net_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
                tax1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
                grand_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
                invgross = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
                discount1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
                discount2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
                discount3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
                discount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
                net = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
                tax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
                grand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
                debitamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
                creditamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
				</cfif>
                
            </cfcase>
            <!--- Process deletes --->
            <cfcase value="D">
                <!--- Perform actual delete --->
                <cfquery datasource="#dts#">
                DELETE FROM currictran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(ARGUMENTS.gridrow.itemno)#">
                and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.gridrow.trancode#"> 
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                 <cfquery name="getitempertax" datasource="#dts#">
                SELECT wpitemtax FROM gsetup
                </cfquery>
                
                <cfquery name="getsum" datasource="#dts#">
                SELECT sum(amt_bil) as sumamt,sum(taxamt_bil) as taxamt FROM currictran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfquery name="getTax" datasource="#dts#">
                SELECT currrate,disp1,disp2,disp3,taxp1,taxincl FROM currartran
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
                <cfset gross_bil = val(getsum.sumamt)>
                <cfset ngross_bil = val(gross_bil)>
                <cfset ngross_bil = ngross_bil - (ngross_bil * val(getTax.disp1)/100)>
                <cfset disc1_bil = gross_bil - ngross_bil>
				<cfset ngross_bil = ngross_bil - (ngross_bil * val(getTax.disp2)/100)>
                <cfset disc2_bil = gross_bil - ngross_bil - val(disc1_bil)>
                <cfset ngross_bil = ngross_bil - (ngross_bil * val(getTax.disp3)/100)>
                <cfset disc3_bil = gross_bil - ngross_bil - disc2_bil-disc1_bil>
                <cfset disc_bil = gross_bil - ngross_bil>
                <cfset net_bil = ngross_bil>
                <cfif getitempertax.wpitemtax neq "1">
                <cfif getTax.taxincl eq "T">
                <cfset tax1_bil = net_bil * (getTax.taxp1/(100+getTax.taxp1))>
                <cfset grand_bil = net_bil>
                <cfelse>
                <cfset tax1_bil = net_bil * (getTax.taxp1/100)>
                <cfset grand_bil = net_bil + tax1_bil>
				</cfif>
                <cfelse>
                <cfset tax1_bil = getsum.taxamt>
                <cfset grand_bil = net_bil + tax1_bil>
                </cfif>
                <cfset tax_bil = tax1_bil>
                <cfset invgross = gross_bil * getTax.currrate>
                <cfset discount1 = disc1_bil * getTax.currrate>
                <cfset discount2 = disc2_bil * getTax.currrate>
                <cfset discount3 = disc3_bil * getTax.currrate>
                <cfset discount = disc_bil * getTax.currrate>
                <cfset net = net_bil * getTax.currrate>
                <cfset tax = tax_bil * getTax.currrate>
                <cfset grand = grand_bil * getTax.currrate>
                <cfif rowtype eq "rc" or rowtype eq "pr" or rowtype eq "po">
                <cfset debitamt = 0>
                <cfset creditamt = grand>
				<cfelse>
                <cfset debitamt = grand>
                <cfset creditamt = 0>
                </cfif>
                
                <cfquery name="getSum" datasource="#dts#">
                Update currartran
                SET
                gross_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gross_bil#">,
                disc1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc1_bil#">,
                disc2_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc2_bil#">,
                disc3_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc3_bil#">,
                disc_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#disc_bil#">,
                net_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net_bil#">,
                tax1_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax1_bil#">,
                grand_bil = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand_bil#">,
                invgross = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invgross#">,
                discount1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount1#">,
                discount2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount2#">,
                discount3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount3#">,
                discount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#discount#">,
                net = <cfqueryparam cfsqltype="cf_sql_varchar" value="#net#">,
                tax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tax#">,
                grand = <cfqueryparam cfsqltype="cf_sql_varchar" value="#grand#">,
                debitamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#debitamt#">,
                creditamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#creditamt#">
                WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowbill#">
                and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowtype#">
                and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowcustno#">
                </cfquery>
                
            </cfcase>
        </cfswitch>
        
    </cffunction>

	
</cfcomponent>