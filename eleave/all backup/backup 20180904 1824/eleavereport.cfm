<cfsetting showDebugOutput="Yes">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
        <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
        <link rel="stylesheet" href="/latest/css/select2/select2.css" />
        
        <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
        <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
        <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
        
        <cfoutput>
            <script type="text/javascript">
                var dts='#dts#';
                var dsname='#Replace(dts, "_i", "_p")#';
                var targetTable='leavelist';
                var hrootpath="#Replace(HRootPath, '\', '/', 'ALL')#";
            </script>
        </cfoutput>
        <script type="text/javascript" src="/eleave/eleavereport.js"></script>
        
        <style>
            .notice li {
                font-size: 15px;
            }
            
            td {
                align-content: "center";
            }
        </style>
    </head>
    
    <body>
        <cfoutput>
            <cfinclude template="/latest/filter/filterCustomer.cfm">
            <cfinclude template="/latest/filter/filterEmployee.cfm">
            <cfinclude template="/latest/filter/filterPONO.cfm">
                
            <h1 align="center">
                <a>Leave Report</a>
            </h1>

            <div class="container" style="width: 700px">
                <form name="form1" id="form1"  action="eleavereportprocess.cfm" method="post" target="_blank">
                    <table align="center" class="table table-bordered" >

                        <tr class="active">
                            <th>Client</th>
                            <td colspan="100%" align="center">
                                <input type="hidden" id="customerFrom" name="customerFrom" class="customerFilter" data-placeholder="[FROM] -- Choose a Customer&nbsp;&nbsp;&nbsp;" />
                                <input type="hidden" id="customerTo" name="customerTo" class="customerFilter" data-placeholder="[TO] -- Choose a Customer&nbsp;&nbsp;&nbsp;" />     
                           </td>
                        </tr>

                        <!---<tr>
                            <td colspan="100%"><hr></td>
                        </tr>--->

                        <tr class="active">
                            <th>Employee</th>
                            <td colspan="100%" align="center">
                                <input type="hidden" id="empFrom" name="empFrom" class="employeeFilter" data-placeholder="[FROM] -- Choose an Employee&nbsp;"/>
                                <input type="hidden" id="empTo" name="empTo" class="employeeFilter" data-placeholder="[TO] -- Choose an Employee&nbsp;"/>     
                           </td>
                        <tr>

                        <!---<tr>
                            <td colspan="100%"><hr></td>
                        </tr>--->

                        <tr class="active">
                            <th>PO Number</th>
                            <td colspan="100%" align="center">
                                <input type="hidden" id="PONOFrom" name="PONOFrom" class="PONOfilter" data-placeholder="[FROM] -- Choose a PO Number"/>
                                <input type="hidden" id="PONOTo" name="PONOTo" class="PONOfilter" data-placeholder="[TO] -- Choose a PO Number"/>     
                           </td>
                        <tr>

                        <!---<tr>
                            <td colspan="100%"><hr></td>
                        </tr> --->   
                        
                        <tr class="active">
                            <th>Customer List</th>
                            <td colspan="100%" align="center">
                                <input name="custlist" id="custlist" type="text" style="max-width: 481px;" size="90"
                                       placeholder="300033881,300033991,300033771,300033111,...">
                           </td>
                        <tr>    
                        
                        <tr class="active">
                            <th>Employee List</th>
                            <td colspan="100%" align="center">
                                <input name="emplist" id="emplist" type="text" style="max-width: 481px;" size="90"
                                       placeholder="100130476,100131212,100131229,100131215,...">     
                           </td>
                        <tr>
                            
                        <tr class="active">
                            <th>Filter Out Employee List</th>
                            <td colspan="100%" align="center">
                                <input name="filteremplist" id="filteremplist" type="text" style="max-width: 481px;" size="90"
                                       placeholder="100130476,100131212,100131229,100131215,...">     
                           </td>
                        <tr>
                            
                        <tr class="active">
                            <td colspan="100%" align="center">
                                <input type="submit" name="Leave_Report" id="Leave_Report" value="Leave Report">&nbsp;&nbsp;
                                <input type="submit" name="Leave_Report" id="Leave_Report_att" value="Leave Report with attachment"><br />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
                
            <div class="container">
                <div class="page-header">
                    <h1 align="center">
                        Quick Leave Check
                    </h1>
                </div>

                <table class="table table-bordered table-hover" id="resultTable" style="width:100%; table-layout: fixed">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <hr/><br><h1>Leave Report Updates</h1>
            <div class="notice">
                <ul>
                    <li>2018-07-16</li>
                    <ul>
                        <li>Added employee no, customer no, and filter out employee no field to further filter out result.</li>
                        <li>Customer List: Fill in customer/client no to generate report based on the list entered.</li>
                        <li>Employee List: Fill in employee no to generate report based on the list entered.</li>
                        <li>Filter Out Employee List: Fill in employee list to exclude employee/associate out from report.</li>
                        <li>The new filter can work together with previous employee, client and PO NO filter or can be used as standalone filter.</li>
                    </ul>
                    
                    <li>2018-07-11</li>
                    <ul>
                        <li>Added quick leave check section to search for leave.</li>
                    </ul>
                    
                    <li>2018-07-09</li>
                    <ul>
                        <li>Added leave balance into leave report (based on JO).</li>
                        <li>You can download leave report along with attachement now by clicking on "Leave Report with attachment".</li>
                        <li>You can filter report by PO Number now.</li>
                    </ul>
                </ul>
            </div>
        </cfoutput>
    </body>
</html>