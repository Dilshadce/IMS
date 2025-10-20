<!---created [15/1/2017, Alvin]--->
<cfcomponent>
    <cffunction name="listDetails" access="remote" returntype="struct"> 
        <!---<cfset dts=form.dts>--->
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>--->
        <cfset dts=#replace(form.dts,'_i','_p')#>
        <cfset targetTable=form.targetTable>
        <cfset custno = form.custno>
            
        <cfset sLimit="">
        <cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
            <cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
        </cfif>		
        
        <cfset sOrder="">
        <cfif IsDefined("form.iSortCol_0")>
            <cfset sOrder="ORDER BY `">
            <cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
                <cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
                    <cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
                        <cfif Evaluate('form.sSortDir_'&i) EQ "asc">
                            <cfset sOrder=sOrder&"` ASC,`">
                        <cfelse>
                            <cfset sOrder=sOrder&"` DESC,`">
                        </cfif>
                </cfif>
            </cfloop>
            <cfset sOrder=Left(sOrder,Len(sOrder)-2)>
            <cfif sOrder EQ "ORDER BY `">
                <cfset sOrder="">
            </cfif>  
        </cfif>
        
        <cfset sWhere="">
		<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
            <cfset sWhere=" WHERE (">
            <cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
                <cfif Evaluate('form.bSearchable_'&i) EQ "true">
                    <cfset sWhere=sWhere&'aa.'&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&form.sSearch&"%"" OR ">
                </cfif>
            </cfloop>
            <cfset sWhere=Left(sWhere,Len(sWhere)-4)>
            <cfset sWhere=sWhere&")">
        </cfif>
            
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM
            (	SELECT pmast.name, pmast.add1, pmast.add2, pmast.dbirth, pmast.sex, pmast.race, pmast.Country_code_address, pmast.phone, pmast.email, pmast.workemail, pmast.mstatus, pmast.nricn, pmast.passprt_to, pmast.passport, pmast.edu, pmast.national, pmast.econtact, pmast.etelno, pmast.eadd1, pmast.eadd2,
            			pmast.itaxno, pmast.itaxbran, pmast.sname, pmast.sdisble, pmast.numchild, pmast.num_child, pmast.child_edu_m, pmast.child_edu_f, pmast.child_disable, pmast.child_edu_disable,
                        pmast.epfno, pmast.pbholiday, pmast.countryserve, pmast.wpermit, pmast.wp_from, pmast.wp_to, pmast.bankcode, pmast.bankaccno, pmast.bankbefname
                        ,pmt.empno, ft.dbcandupdate, pb.requested_on, emp.emailsent
            	FROM emp_users as emp
                LEFT JOIN #replace(dts,'_p','_i')#.placement as pmt ON emp.empno = pmt.empno
                LEFT JOIN #targetTable# as pmast ON emp.empno = pmast.empno
                LEFT JOIN #replace(dts,'_p','_i')#.ftcandidate ft ON emp.empno = ft.dbcandno
                LEFT JOIN pbupdated pb ON pb.empno = emp.empno
                WHERE pmt.custno = #custno#
                AND emp.emailsent <> '0000-00-00 00:00:00'
                
                GROUP BY emp.empno
            ) AS aa
                        
            #sWhere#
            #sOrder#
            #sLimit#
        </cfquery>
    
        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        
        <cfquery name="getTotalDataSetLength" datasource="#dts#">
            SELECT COUNT(empno) AS iTotal
            FROM #targetTable#
        </cfquery>   
        
        <!---custom query--->
        
        <cfquery name="getRace" datasource="#dts#">
        	SELECT racedesp 
            FROM race
            where racecode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getfiltereddataset.race#">
        </cfquery>
        
        <cfquery name="getCountry" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT concat(CCODE, ' - ' , CNAME) as Country_code_address
            FROM councode
            where ccode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.Country_code_address#">
        </cfquery>
        
        <cfquery name="getNationality" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT concat(CCODE, ' - ' , CNAME) as national
            FROM councode
            where ccode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.national#">
        </cfquery>
        
        <cfquery name="getCountryPub" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT concat(CCODE, ' - ' , CNAME) as pbholiday
            FROM councode
            where ccode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.pbholiday#">
        </cfquery>
        
        <cfquery name="getCountryServe" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT concat(CCODE, ' - ' , CNAME) as countryserve
            FROM councode
            where ccode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.countryserve#">
        </cfquery>
        
        <cfquery name="getPlacement" datasource="#replace(dts,'_p','_i')#">
            SELECT hrmgr, department, position 
            FROM placement 
            WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.empno#"> 
            ORDER BY completedate desc limit 1
        </cfquery>

        <cfquery name="getHMdetails" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT username, userid
            FROM hmusers 
            WHERE entryid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getPlacement.hrmgr#">
        </cfquery>
        
        <cfquery name="getBankList" datasource="#replace(dts,'manpower_p','payroll_main')#">
            SELECT concat(bankname,'-',bankcode)as bankname
            FROM bankcodemy
            WHERE bankcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getFilteredDataSet.bankcode#">
        </cfquery>
        
        <!---end of custom query--->   
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
            
            <cfset data=StructNew()>
            <!---personal information--->
			<cfset data["name"]=name>
            <cfset data["emailsent"]=#dateformat(emailsent, 'dd/mm/yyyy - hh:mm:ss')#>
            <cfset data["requested_on"]=#dateformat(requested_on, 'dd/mm/yyyy - hh:mm:ss')#>
            <cfset data["dbcandupdate"]=#dateformat(dbcandupdate, 'dd/mm/yyyy - hh:mm:ss')#>
            <cfset data["add1"]=add1>
            <cfset data["add2"]=add2>
            <cfset data["dbirth"]=#dateformat(dbirth, 'dd/mm/yyyy')#>
            <cfif #sex# eq 'M'>
            	<cfset data["sex"]='Male'>
            <cfelse>
            	<cfset data["sex"]='Female'>
            </cfif>
          	<cfset data["race"]=#getRace.racedesp#>
            <cfset data["Country_code_address"]="#getCountry.Country_code_address#">
            <cfset data["phone"]=phone>
            <cfset data["email"]=email>
            <cfset data["workemail"]=workemail> 
            <cfif #mstatus# eq 'M'>
            	<cfset data["mstatus"]="Married">  
            <cfelseif #mstatus# eq 'S'>
            	<cfset data["mstatus"]="Single"> 
            <cfelse>
            	<cfset data["mstatus"]="Married">
            </cfif>       
            <cfset data["nricn"]=nricn>
            <cfset data["passprt_to"]=#dateformat(passprt_to, 'dd/mm/yyyy')#>
            <cfset data["passport"]=passport>
            <cfset data["edu"]=edu>
            <cfset data["national"]="#getNationality.national#">
            <cfset data["econtact"]=econtact>
            <cfset data["etelno"]=etelno>
            <cfset data["eadd1"]=eadd1>
            <cfset data["eadd2"]=eadd2>
            
            <!---tax information--->
			<cfset data["itaxno"]=itaxno>
            <cfset data["itaxbran"]=itaxbran>
            <cfif #sname# neq "">
            	<cfset data["spousework"]='No '> <!---adding space to yes and no to prevent it to be interpreted as true false--->
            <cfelse>
            	<cfset data["spousework"]="Yes ">
            </cfif>
            <cfset data["sname"]=sname>
            <cfset data["sdisble"]=sdisble>
            <cfset data["numchild"]=numchild>
            <cfset data["num_child"]=num_child>
            <cfset data["child_edu_m"]=child_edu_m>
            <cfset data["child_edu_f"]=child_edu_f>
            <cfset data["child_disable"]=child_disable>
            <cfset data["child_edu_disable"]=child_edu_disable>
            
            <!---other information--->
            <cfset data["epfno"]=epfno>
            <cfset data["pbholiday"]="#getCountryPub.pbholiday#">
            <cfset data["countryserve"]="#getCountryServe.countryserve#">
            <cfset data["username"]="#getHMdetails.username#">
            <cfset data["userid"]="#getHMdetails.userid#">
            <cfset data["wpermit"]=wpermit>
            <cfset data["wp_from"]=wp_from>
            <cfset data["wp_to"]=wp_to>
            <cfset data["bankcode"]="#getBankList.bankname#">
            <cfset data["bankaccno"]=bankaccno>
            <cfset data["bankbefname"]=bankbefname>
            <cfset data["department"]="#getPlacement.department#">
            <cfset data["position"]="#getPlacement.position#">
            
            <cfset ArrayAppend(aaData,data)>
        </cfloop>
        
        <cfset output=StructNew()>
        <cfset output["sEcho"]=form.sEcho>
        <cfset output["iTotalRecords"]=getTotalDataSetLength.iTotal>
        <cfset output["iTotalDisplayRecords"]=getFilteredDataSetLength.iFilteredTotal>
        <cfset output["aaData"]=aaData>
        <cfreturn output>
    </cffunction>
</cfcomponent>