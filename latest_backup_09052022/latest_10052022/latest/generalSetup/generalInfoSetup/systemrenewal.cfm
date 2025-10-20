<!---header css--->
<style>
.subsdiv{
            margin-bottom: 50px;    
        }
</style>        

<cfset product= "">
<cfset system= "crm,payroll,ams,ims">
<cfloop list="#system#" index="a">
	<cfif findnocase(a,"#CGI.SERVER_NAME#") gt 0>
        <cfset product= a.toUpperCase()>
    </cfif>
</cfloop>

<cfset dts= "">
<cfset currcode= "">
<cfset dblist= "netsm_c,net_c">
<cfloop list="#dblist#" index="aa">
	<cfquery name="getsubscription" datasource="#aa#">
        SELECT a.#product#,b.id,b.period_from,b.period_to 
        FROM userdatabase AS a
        LEFT JOIN (SELECT id,period_from,period_to 
        FROM webbasecontract) AS b
        ON a.custno=b.id 
        WHERE a.comid= <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(hcomid,'_i','')#"> 
        ORDER BY b.period_to desc;
    </cfquery>
    
    <cfif getsubscription.recordcount gte 1>
    	<cfset dts="#aa#">
        <cfif dts eq "netsm_c">
        	<cfset currcode= "MYR">
        <cfelseif dts eq "net_c">
        	<cfset currcode= "SGD">
        </cfif>
    	<cfbreak>
    </cfif>
</cfloop>

<cfoutput>
<!--- Panel for Contract Info --->
<div class="panel-group">
<div class="panel panel-default">
    <div class="panel-heading" data-toggle="collapse" href="##subscriptionTemplateCollapse">
        <h4 class="panel-title accordion-toggle">Contract Information</h4>
    </div>
    
	<cfif getsubscription.recordcount eq 0>
        <h1>Please contact us at accounts@netiquette.com.sg</h1>
        <cfabort>
    </cfif>
    
    <cfset userno='getsubscription.#product#'>
    <cfset periodfrom= dateformat(getsubscription.period_from, "DD/MM/YYYY")>
    <cfset periodto= dateformat(getsubscription.period_to, "DD/MM/YYYY")>
    
    <cfquery name="getpaypal" datasource="net_c">
        SELECT new_periodfrom,new_periodto,new_noofuser  
        FROM paypaltracking 
        WHERE hcomid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(hcomid,'_i','')#"> 
        AND item_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#product#"> 
        AND old_periodfrom = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getsubscription.period_from, 'YYYY-MM-DD')#"> 
        AND old_periodto = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getsubscription.period_to, 'YYYY-MM-DD')#"> 
        AND pay_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="Completed"> 
        ORDER BY id DESC
    </cfquery>
    
    <cfif getpaypal.recordcount gte 1>
        <cfset userno=getpaypal.new_noofuser> 
        <cfset periodfrom="#dateformat(getpaypal.new_periodfrom, 'DD/MM/YYYY')#">
        <cfset periodto="#dateformat(getpaypal.new_periodto, 'DD/MM/YYYY')#">
    </cfif>
    
    <cfquery name="getdbinfo" datasource="#dts#">
        SELECT comid,comname,#product# 
        FROM userdatabase 
        WHERE custno= <cfqueryparam cfsqltype="cf_sql_integer" value="#getsubscription.id#">
    </cfquery>

<!--- Continue panel information --->
    <div id="subscriptionTemplateCollapse" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="row">
                <div class="subsdiv col-sm-12">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <label class="col-sm-11 col-xs-12 control-label"><h4 style="padding:0px;margin:0px">Contract Information</h4><p style="color: ##aaa">The user contract databases are shown</p></label>
                        <div class="col-sm-1"></div>
                    </div>   
                    
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-7 col-xs-12" >
                        <table style="width: 100%" id="subsdb">
                            <thead>
                                <tr>
                                    <th style="width: 30%;background-color: ##777; color:white;">Comid</th>
                                    <th style="width: 50%;background-color: ##777; color:white;">Company Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="getdbinfo">
                                <tr>
                                    <td>#getdbinfo.comid#</td>
                                    <td>#getdbinfo.comname#</td>
                                </tr>
                                </cfloop>
                            </tbody>
                        </table>    
                        </div>
                        <div class="col-sm-3"></div>
                    </div>
                </div>
                        
                    
                <div class="subsdiv col-sm-12">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <label class="col-sm-11 col-xs-12 control-label"><h4 style="padding:0px;margin:0px">Contract Period</h4></label>
                        <div class="col-sm-1"></div>
                    </div>   
                    
                    <cfform class="form-horizontal row" name="subscriptionyearform" id="subscriptionyearform" role="form" action="https://crm.netiquette.com.sg/paymentprocess.cfm" method="post">
                        <div class="col-sm-2"></div>
                        <label for="subsperiod" class="col-sm-2">Current Subscription Period</label>                
                        <label id="subsperiod" class="col-sm-3" name="subsperiod">#periodfrom# - #periodto#</label>             
                        <div class="col-sm-3">
                            <input type="hidden" name="hid_product" id="hid_product1" value="#product#">
                            <input type="hidden" name="hid_currcode" id="hid_currcode1" value="#currcode#">            
                            <input type="hidden" name="hid_comid" id="hid_comid1" value="#replace(hcomid,'_i','')#">
                            <input type="hidden" name="hid_id" id="hid_id1" value="#getsubscription.id#">
                            <input type="submit" name="renew_btn" id="renew_btn" value="Renew" class="btn btn-info">                                    
                        </div>
                        <div class="col-sm-2"></div>
                    </cfform>
                </div>
                    
                
                <div class="subsdiv col-sm-12">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <label class="col-sm-11 col-xs-12 control-label"><h4 style="padding:0px;margin:0px">#product# Users</h4><p style="color: ##aaa">The number of #product# users are shown</p></label>
                        <div class="col-sm-1"></div>
                    </div>
                    
                    <cfform class="form-horizontal row" name="subscriptionuserform" id="subscriptionuserform" role="form" action="https://crm.netiquette.com.sg/paymentprocess.cfm" method="post">
                        <div class="col-sm-2"></div>
                        <label for="subsuser" class="col-sm-2">No of #product# users</label>
                        <label class="col-sm-3" id="subsuser" name="subsuser">#userno#</label>                  
                        <div class="col-sm-3">
                            <input type="hidden" name="hid_product" id="hid_product2" value="#product#">
                            <input type="hidden" name="hid_currcode" id="hid_currcode2" value="#currcode#">
                            <input type="hidden" name="hid_comid" id="hid_comid2" value="#replace(hcomid,'_i','')#">
                            <input type="hidden" name="hid_id" id="hid_id2" value="#getsubscription.id#">
                            <input type="submit" name="adduser_btn" id="adduser_btn" value="Add" class="btn btn-info">                                      
                        </div>
                        <div class="col-sm-2"></div>
                    </cfform>
                </div> 
            </div>
        </div>
      
    </div>
</div>
</div>
</cfoutput>