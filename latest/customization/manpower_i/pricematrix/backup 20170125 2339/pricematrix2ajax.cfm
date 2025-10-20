<cfsetting showdebugoutput="no">

    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">


<cfif isdefined('action')>


<cfif action eq "add">
<cfquery name="exist" datasource="#dts#">
SELECT itemid FROM manpowerpricematrixdetail WHERE priceid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
and itemid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemid#" />
</cfquery>
<cfif exist.recordcount neq 0>
<cfabort showerror="Item existed!">
</cfif>
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
<cfquery name="getpriceiddetail" datasource="#dts#">
			DELETE FROM manpowerpricematrixdetail WHERE
			priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
			AND trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trancode#" />
</cfquery>
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
											<cfif Find("Allowance", getpriceiddetail.itemname) or Find("B-", getpriceiddetail.itemid)>#getpriceiddetail.itemid# </cfif>#getpriceiddetail.itemname#
										</div>
										<div class="col-sm-1" align="center">
											#getpriceiddetail.payable#
										</div>
										<div class="col-sm-2" align="right">
											#getpriceiddetail.payableamt#
										</div>
										<!--- <div class="col-sm-2" align="right">
											#getpriceiddetail.payadminfee#
										</div> --->
										
										<div class="col-sm-1" align="center">
											#getpriceiddetail.billable#
										</div>
										<div class="col-sm-2" align="right">
											#getpriceiddetail.billableamt#
										</div>
										<div class="col-sm-2" align="right">
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