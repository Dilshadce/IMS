<cfoutput>
    
<cfset dts2=replace(dts,'_i','','all')>
    
<cfquery name="company_details" datasource="payroll_main">
    SELECT * FROM gsetup WHERE comp_id = "#dts2#"
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
    SELECT empno,pm FROM placement WHERE placementno = "#url.placementno#"
</cfquery>
    
<cfset adminfeelist = "1,20,21">
<cfset otlist = "22,23,24,25,26,27">
<cfset govlist = "15,16,42">
<cfquery name="geticshelf" datasource="#dts#">
    SELECT shelf as id FROM icshelf 
    WHERE shelf NOT IN (#adminfeelist#,#otlist#,#govlist#)
</cfquery>
    
<cfif getplacement.pm neq "">
    <cfquery name="getpm" datasource="#dts#">
    SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and left(itemid,2) = "OT"
    </cfquery>

  <cfloop query="geticshelf">
        <cfset "a#geticshelf.id#" = 0>
    </cfloop>

    <cfquery name="getprevassign" datasource="#dts#">
        SELECT * FROM assignmentslip 
        WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#"> 
        and payrollperiod=#company_details.mmonth#
        and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
    </cfquery>  

    <cfloop query="getprevassign">
        <cfloop index='a' from='1' to='6'>
            <cfif evaluate('getprevassign.fixawee#a#') neq 0>
                <cfif isdefined("a#evaluate('getprevassign.fixawcode#a#')#")>
                    <cfset "a#evaluate('getprevassign.fixawcode#a#')#" = val(evaluate("a#evaluate('getprevassign.fixawcode#a#')#")) + val(evaluate('getprevassign.fixawee#a#'))>
                    a#evaluate('getprevassign.fixawcode#a#')#: #evaluate("a#evaluate('getprevassign.fixawcode#a#')#")#<br>
                </cfif>
            </cfif>
        </cfloop>
    </cfloop>

    <cfloop query="getprevassign">
        <cfloop index='a' from='1' to='18'>
            <cfif evaluate('getprevassign.awee#a#') neq 0>
                <cfif isdefined("a#evaluate('getprevassign.allowance#a#')#")>
                    <cfset "a#evaluate('getprevassign.allowance#a#')#" = val(evaluate("a#evaluate('getprevassign.allowance#a#')#")) + val(evaluate('getprevassign.awee#a#'))>
                    a#evaluate('getprevassign.allowance#a#')#: #evaluate("a#evaluate('getprevassign.allowance#a#')#")#<br>
                </cfif>
            </cfif>
        </cfloop>
    </cfloop> 
        
    <cfset selfbasic = 0>        
    <cfset custbasic = 0>
        
    <cfloop query="getprevassign">
        <cfif evaluate('getprevassign.selfsalary') neq 0>
            <cfset selfbasic = val(selfbasic) + val(evaluate('getprevassign.selfsalary'))>
            selfbasic: #selfbasic#<br>
        </cfif>
            
        <cfif evaluate('getprevassign.custsalary') neq 0>
            <cfset custbasic = val(custbasic) + val(evaluate('getprevassign.custsalary'))>
            custbasic: #custbasic#<br>
        </cfif>
    </cfloop>
            
    <cfif evaluate('url.selfsalary') neq 0>
        <cfset selfbasic = val(selfbasic) + val(evaluate('url.selfsalary'))>
        selfbasic; #selfbasic#<br>
    </cfif>

    <cfif evaluate('url.custsalary') neq 0>
        <cfset custbasic = val(custbasic) + val(evaluate('url.custsalary'))>
        custbasic: #custbasic#<br>
    </cfif>
        
    <cfloop index='a' from='1' to='6'>
        <cfif evaluate('url.fixawee#a#') neq 0>
            <cfset "a#evaluate('url.fixawcode#a#')#" = val(evaluate("a#evaluate('url.fixawcode#a#')#")) + val(evaluate('url.fixawee#a#'))>
            a#evaluate('url.fixawcode#a#')#: #evaluate("a#evaluate('url.fixawcode#a#')#")#<br>
        </cfif>
    </cfloop>
        
    <cfloop index='a' from='1' to='18'>
        <cfif evaluate('url.awee#a#') neq 0>
            <cfset "a#evaluate('url.allowance#a#')#" = val(evaluate("a#evaluate('url.allowance#a#')#")) + val(evaluate('url.awee#a#'))>
            a#evaluate('url.allowance#a#')#: #evaluate("a#evaluate('url.allowance#a#')#")#<br>
        </cfif>
    </cfloop>
        
    <cfset selfusualpay = val(evaluate('url.selfusualpay'))>
        
    <cfset BASIC = selfusualpay>

    <CFSET RATEYEE = selfbasic>
    <CFSET RATEYER = custbasic>
        
    <cfloop query="getpm">
        <cfif getpm.itemid eq "OT1">
            <cfif getpm.payable eq "Y">
            

            <cfset selfotrate1= numberformat(evaluate('#replace(replace(getpm.payableamt,'=',''),'%','/100','all')#'),'.__')>
            
            <input type="hidden" name="xselfotrate1" id="xselfotrate1" value="#selfotrate1#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate1= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate1" id="xcustotrate1" value="#custotrate1#">
            </cfif>
        <cfelseif getpm.itemid eq "OT15"> <!---Added new itemname for OT, [20170508, Alvin]--->
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate2= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate2" id="xselfotrate2" value="#selfotrate2#">
            </cfif>

            <cfif getpm.billable eq "Y">
            				
            <cfset custotrate2= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate2" id="xcustotrate2" value="#custotrate2#">

            </cfif>
        <cfelseif getpm.itemid eq "OT2">	<!---Added new itemname for OT, [20170508, Alvin]--->
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate3= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate3" id="xselfotrate3" value="#selfotrate3#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate3= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate3" id="xcustotrate3" value="#custotrate3#">
            </cfif>
        <cfelseif getpm.itemid eq "OT3">	<!---Added new itemname for OT, [20170508, Alvin]--->
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate4= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate4" id="xselfotrate4" value="#selfotrate4#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate4= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate4" id="xcustotrate4" value="#custotrate4#">
            </cfif>

        <cfelseif getpm.itemid eq "OT5">
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate5= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate5" id="xselfotrate5" value="#selfotrate5#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate5= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate5" id="xcustotrate5" value="#custotrate5#">
            </cfif>

        <cfelseif getpm.itemid eq "OT6">
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate6= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate6" id="xselfotrate6" value="#selfotrate6#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate6= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate6" id="xcustotrate6" value="#custotrate6#">
            </cfif>
        <cfelseif getpm.itemid eq "OT7">
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate7= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate7" id="xselfotrate7" value="#selfotrate7#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate7= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate7" id="xcustotrate7" value="#custotrate7#">
            </cfif>
        <cfelseif getpm.itemid eq "OT8">
            <cfif getpm.payable eq "Y">
            
            <cfset selfotrate8= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xselfotrate8" id="xselfotrate8" value="#selfotrate8#">
            </cfif>

            <cfif getpm.billable eq "Y">
            
            <cfset custotrate8= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                
            <input type="hidden" name="xcustotrate8" id="xcustotrate8" value="#custotrate8#">
            </cfif>
        </cfif>
    </cfloop>
                
    <cfloop index="a" from="1" to="8">
        <cfif not isdefined('selfotrate#a#')>
            <input type="hidden" name="xselfotrate#a#" id="xselfotrate#a#" value="0.00">
            <input type="hidden" name="xcustotrate#a#" id="xcustotrate#a#" value="0.00">
        </cfif>
    </cfloop>
</cfif>
    
</cfoutput>