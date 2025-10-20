<cfsetting showdebugoutput="yes">

    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">


<cfif isdefined('action')>
    
<cfquery name="getapprovallist" datasource="#dts#">
    SELECT group_concat(userid) userid FROM approvalusers
</cfquery>
    
<cfset list = listToArray(getapprovallist.userid)>

<cfif ArrayContains(list,getauthuser())>
<cfif action eq "add">
<cfquery name="exist" datasource="#dts#">
SELECT itemid FROM manpowerpricematrixdetail WHERE priceid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
and itemid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemid#" />
</cfquery>
<cfif exist.recordcount neq 0>
<cfabort showerror="Item existed!">
</cfif>
    
<!---Added by Nieo 20180823 1657, Formula validation--->
<cfset errormsg ="Wrong Formula Format. Please check symbols or Item is not created in MP4U. E.g. () must comes in a set">
    
<!--Sample Variables--->
<cfquery name="gqry" datasource="payroll_main">
SELECT mmonth,myear from gsetup where comp_id = '#HcomID#'
</cfquery>
    
<CFSET RATEYEE = 1000>
<CFSET RATEYER = 1000>
<cfset BASIC = 1000>
<cfset SALARY = 1000>
<cfset BASICPAY = 1000>
<cfset EPFYEE = 1000>
<cfset EPFYER = 1000>
<cfset SOCSOYEE = 1000>
<cfset SOCSOYER = 1000>
<cfset EISYEE = 1000>
<cfset EISYER = 1000>
<cfset EPF_TOTAL = 1000>
<cfset SOCSO_TOTAL = 1000>
<cfset OT1 = 1000>
<cfset OT15 = 1000>
<cfset OT2 = 1000>
<cfset OT3 = 1000>
<cfset OT5 = 1000>
<cfset OT6 = 1000>
<cfset OT7 = 1000>
<cfset OT8 = 1000>

<cfset AW_TOTAL = 1000>
<cfset OT_TOTAL = 1000>
<cfset GROSSPAY = 1000>
<cfset NETPAY = 1000>
<cfset NPL = 1000>
    
<cfset SOCSO_OT = 0>
<cfset TOTALFIXAW = 0>
<cfset TOTALVARAW = 0>
    
<cfset EPF_FIXAW = 0>
<cfset EPF_VARAW = 0>
<cfset SOCSO_FIXAW = 0>
<cfset SOCSO_VARAW = 0>
<cfset EIS_FIXAW = 0>
<cfset EIS_VARAW = 0>
    
<cfset ALLAWEXC = 0>
<cfset ADMINFEE = 0>
    
<cfset SELFSALARY = 0>
<cfset CUSTOMTOTALFIXAW = 0>
<cfset TOTALNPL = 0>
    
<cfquery name="getallowance" datasource="#dts#">
SELECT shelf as id FROM icshelf
</cfquery>

<cfloop query="getallowance">
    <CFSET "A#id#" = 1000>
</cfloop>
    
<cfquery name="getcate" datasource="#dts#">
SELECT cate as id FROM iccate
</cfquery>
    
<cfloop query="getcate">
    <CFSET "B#id#" = 1000>
</cfloop>
    
<!--Sample Variables--->
    
<cfloop index="formula" list="payadminfee,billadminfee,payableamt,billableamt">
    <cfif left(evaluate(formula),1) eq "=">
        <cfset con = evaluate(formula)>
        <cfset con = right(con,len(con)-1)>
        <cfset con = Replace(con,"<="," lte ","all") >
        <cfset con = Replace(con,">="," gte ","all") >
        <cfset con = Replace(con,">"," gt ","all") >
        <cfset con = Replace(con,"<"," lt ","all") >
        <cfset con = Replace(con,"!="," neq ","all") >
        <cfset con = Replace(con,"="," eq ","all") >
        
        <!---<cftry>--->
            <cfset test = val(evaluate(con))>

            <!---<cfcatch type="any">
                <cfabort showerror="#errormsg#">
            </cfcatch>
        </cftry>--->
        
    <cfelse>
        <!---<cftry>--->
            <cfset test = val(evaluate(formula))>
            <!---<cfcatch type="any">
                <cfabort showerror="#errormsg#">
            </cfcatch>
        </cftry>--->
    </cfif>
    
</cfloop>
<!---Added by Nieo 20180823 1657, Formula validation--->
   
<!---Added by Nieo 20181023 1041, to log changes in Price Structure--->
<cfinclude template="logchanges.cfm">
<!---Added by Nieo 20181023 1041, to log changes in Price Structure--->
    
<cfquery name="getpriceiddetail" datasource="#dts#">
    INSERT INTO manpowerpricematrixdetail (priceid, itemid, itemname, trancode, payable, billable, payadminfee, billadminfee, payableamt, billableamt, created_by, created_on,saf)
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemid#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemname#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#payable#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#billable#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#payadminfee#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#billadminfee#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#payableamt#" />,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#billableamt#" />,
    "#huserid#",
    now(),
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#saf#" />
    )
</cfquery>
</cfif>


<cfif action eq "delete">

<!---Added by Nieo 20181023 1041, to log changes in Price Structure--->
<cfinclude template="logchanges.cfm">
<!---Added by Nieo 20181023 1041, to log changes in Price Structure--->

<cfquery name="getpriceiddetail" datasource="#dts#">
			DELETE FROM manpowerpricematrixdetail WHERE
			priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
			AND trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#" />
</cfquery>
</cfif>
</cfif>							
</cfif>							
									
<cfoutput>

<cfquery name="getmaxtrancode" datasource="#dts#">
			SELECT ifnull(max(trancode),0) as trancode from manpowerpricematrixdetail where priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
</cfquery>
<input type="hidden" name="ntrancode" id="ntrancode" value="#getmaxtrancode.trancode+1#">
	
	
<cfquery name="getpriceiddetail" datasource="#dts#">
			SELECT * from manpowerpricematrixdetail where priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
			ORDER by trancode
</cfquery>

				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Details</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	
                                    
                                   <div class="form-group">
										<label for="itemname" class="col-sm-1 pull-left">Item Name</label>
										<label for="itemname" class="col-sm-1 control-label">Payable</label>
										<label for="itemname" class="col-sm-2 control-label">Amount</label>
										<!--- <label for="itemname" class="col-sm-2 control-label">Admin Fee</label> --->
										<label for="itemname" class="col-sm-1 control-label">Billable</label>
										<label for="itemname" class="col-sm-2 control-label">Amount</label>
										<label for="itemname" class="col-sm-2 control-label">Admin Fee</label>
                                        <label for="itemname" class="col-sm-2 control-label">Same Statutory AF<br />
(only applicable for %)</label>
										<label for="itemname" class="col-sm-1 control-label">Action</label>
									</div>
									
									<cfloop query="getpriceiddetail">
									<div class="form-group">
										<div class="col-sm-1" >
											#getpriceiddetail.itemid# - #getpriceiddetail.itemname#
										</div>
										<div class="col-sm-1" align="center">
											#getpriceiddetail.payable#
										</div>
										<div class="col-sm-2" align="right" style="overflow: auto">
											#getpriceiddetail.payableamt#
										</div>
										<!--- <div class="col-sm-2" align="right">
											#getpriceiddetail.payadminfee#
										</div> --->
										
										<div class="col-sm-1" align="center">
											#getpriceiddetail.billable#
										</div>
										<div class="col-sm-2" align="right" style="overflow: auto">
											#getpriceiddetail.billableamt#
										</div>
										<div class="col-sm-2" align="right" style="overflow: auto">
											#getpriceiddetail.billadminfee#
										</div>
                                        <div class="col-sm-2" align="right">
											#getpriceiddetail.saf#
										</div>
										<div class="col-sm-1" align="right">
											<input type="button" id="deletebtn" name="deletebtn" value="Delete" onclick="deleteitem('#getpriceiddetail.trancode#')" />
										</div>
									</div>
									</cfloop>

            					</div>
            				</div>
                		</div>
                	</div>					
				</div>
</cfoutput>