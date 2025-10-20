<cfsetting showdebugoutput="true">

<html>
    <head>
        <title>Mass Update Leave Entitlement</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
        <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
        <script src="/scripts/CalendarControl.js" language="javascript"></script>
        <link rel="stylesheet" href="/latest/css/select2/select2.css" />  
        <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>   
        <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>  
        <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
        
        <style>
        th{
            text-align:left;
            font-size:13px;
        }

        .checktd{
            text-align: center;
            vertical-align: middle;
        }
        </style>
            
        <script type="text/javascript">                
            function validate(){
              if(document.getElementById('placementlist').value==''){
                alert("Your Placement's No. cannot be blank.");
                document.getElementById('placementlist').focus();
                return false;
              }

              function getDateObject(dateString,dateSeperator)
                {
                //This function return a date object after accepting 
                //a date string ans dateseparator as arguments
                var curValue=dateString;
                var sepChar=dateSeperator;
                var curPos=0;
                var cDate,cMonth,cYear;

                //extract day portion
                curPos=dateString.indexOf(sepChar);
                cDate=dateString.substring(0,curPos);

                //extract month portion 
                endPos=dateString.indexOf(sepChar,curPos+1); cMonth=dateString.substring(curPos+1,endPos);

                //extract year portion 
                curPos=endPos;
                endPos=curPos+5; 
                cYear=curValue.substring(curPos+1,endPos);

                //Create Date Object
                dtObject=new Date(cYear,cMonth,cDate); 
                return dtObject;
                }

              return true;
            }

            function checkboxaction(boxvalue, type){
                
                if(type == 'leave'){
                    var boxname = boxvalue+'update';                                    //remove/insert name for leave entitlement

                    if(document.getElementById(boxname).checked){

                        jQuery("#"+boxvalue+'update').attr('name', boxvalue+'update');
                        jQuery("#"+boxvalue+'entitle').attr('name', boxvalue+'entitle');
                        jQuery("#"+boxvalue+'payable1').attr('name', boxvalue+'payable1');
                        jQuery("#"+boxvalue+'billable1').attr('name', boxvalue+'billable1');
                        jQuery("#"+boxvalue+'date').prop('disabled', false);
                        jQuery("#"+boxvalue+'days').attr('name', boxvalue+'days');
                        jQuery("#"+boxvalue+'totaldays').attr('name', boxvalue+'totaldays');
                        jQuery("#"+boxvalue+'earndays').attr('name', boxvalue+'earndays');
                        jQuery("#"+boxvalue+'remarks').attr('name', boxvalue+'remarks');
                        if(boxvalue == 'AL'){
                            jQuery("#"+boxvalue+'bfdays').attr('name', boxvalue+'bfdays');
                            jQuery("#"+boxvalue+'type').attr('name', boxvalue+'type');
                            jQuery("#"+boxvalue+'bfable').attr('name', boxvalue+'bfable');
                        }

                    }
                    else{

                        jQuery("#"+boxvalue+'update').removeAttr('name');
                        jQuery("#"+boxvalue+'entitle').removeAttr('name');
                        jQuery("#"+boxvalue+'payable1').removeAttr('name');
                        jQuery("#"+boxvalue+'billable1').removeAttr('name');
                        jQuery("#"+boxvalue+'date').prop('disabled', true);
                        jQuery("#"+boxvalue+'days').removeAttr('name');
                        if(boxvalue == 'AL'){
                            jQuery("#"+boxvalue+'bfdays').removeAttr('name');
                            jQuery("#"+boxvalue+'type').removeAttr('name');
                            jQuery("#"+boxvalue+'bfable').removeAttr('name');
                        }
                        jQuery("#"+boxvalue+'totaldays').removeAttr('name');
                        jQuery("#"+boxvalue+'earndays').removeAttr('name');
                        jQuery("#"+boxvalue+'remarks').removeAttr('name');

                    }
                }
                else{
                    var boxname = boxvalue+'change';                    //remove/insert name for pic tagging
                    
                    if(document.getElementById(boxname).checked){
                        jQuery("#"+boxvalue+'change').attr('name', boxvalue+'change');
                        jQuery("#"+boxvalue).attr('name', boxvalue);
                        jQuery("#"+boxvalue+'Email').attr('name', boxvalue+'Email');
                    }
                    else{
                        jQuery("#"+boxvalue+'update').removeAttr('name');
                        jQuery("#"+boxvalue).removeAttr('name');
                        jQuery("#"+boxvalue+'Email').removeAttr('name');
                    }
                }

            }
            
            function getHRmgrEmail(id){
                jQuery.post("/default/maintenance/placementnew/AutoFillHrMgr.cfc?method=FillHrMgr&ReturnFormat=json",{"id":id},function(response){

                        document.getElementById("hrMgrEmail").value = response.EMAIL;
                        },"JSON");
            }
            
            function fillemail(tagging,inputid){
                document.getElementById(inputid+'Email').value = tagging;
            }
        </script>
<cfoutput>        
        <body>
            <h1 align="center">Mass Update Leave Entitlement</h1>
            <cfset headerlist = "">
            <cfset hrMgr = ''>
            <cfset hrMgrEmail = ''>
            <cfset mpPIC = ''>
            <cfset mpPICEmail = ''>
            <cfset mpPIC2 = ''>
            <cfset mpPICEmail2 = ''>
            <cfset mpPicSp = ''>
            <cfset mpPicSpEmail = ''>
            <cfset pm = ''>
            <cfinclude template="select2Filter.cfm">
                
            <cfform name="PlacementForm" id="PlacementForm" action="massupdateprocess.cfm" method="post" onsubmit="return validate()">

                <table id="leavetable" align="center" width="100%">
                    <tr>
                        <td></td>
                        <th>Placement No:</th>
                        <td colspan="100%">
                            <textarea id="placementlist" name="placementlist" rows="4" required style="resize: none;width: 100%" 
                             placeholder="Enter placementno delimited by comma without any spaces in between and end without any comma &##10E.g. 200144970,200139667,200139710,200144850,200144892....200144696"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th>Update Leave</th>
                        <th>Leave Type</th>
                        <th>Entitled</th>
                        <th>Payable</th>
                        <th>Billable</th>
                        <th>Claimable from Date &nbsp;&nbsp;&nbsp;</th>
                        <th>Days<br> <font size="-2">(Pro-rate to contract duration)</font></th>
                        <th>Carry Forward</th>
                        <th>Total</th>
                        <th>Earned</th>
                        <th>Earn Type</th>
                        <th>Carry Forward</th>
                        <th>Remarks</th>    
                    </tr>

                    <cfquery name="leavelist" datasource="#dts#">
                    SELECT * FROM iccostcode ORDER BY costcode
                    </cfquery>


                    <cfloop query="leavelist">
                        <cfset i = '#leavelist.costcode#'>
                        <cfset headerlist = "#ListAppend(headerlist, leavelist.costcode, ',')#">
                        <tr>
                            <td class="checktd"><input type="checkbox" id="#i#update" value="#i#" onchange="checkboxaction(this.value, 'leave')"></td>
                            <th>#leavelist.Desp# </th>
                            <td class="checktd"><input type="checkbox" id="#i#entitle"></td>
                            <td class="checktd"><input type="checkbox" id="#i#payable1"></td>
                            <td class="checktd"><input type="checkbox" id="#i#billable1"></td>
                            <td>
                                <cfinput size="12" type="text" id="#i#date" name="#i#date" value="" validate="eurodate" disabled message="Claimable from Date is Invalid">
                                &nbsp;
                                <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('#i#date'));">
                            </td>
                            <td>
                                <!---<input type="text" size="5" name="#i#days" id="#i#days" value="" onKeyUp="document.getElementById('#i#totaldays').value=parseFloat(this.value)<cfif i eq "AL">+parseFloat(document.getElementById('#i#bfdays').value)</cfif>">--->
                                <input type="text" size="5" id="#i#days" value="" 
                                 onKeyUp="if('#i#' == 'AL'){
                                            if(document.getElementById('#i#bfdays').value != ''){
                                                document.getElementById('#i#totaldays').value=parseFloat(this.value) + parseFloat(document.getElementById('#i#bfdays').value);
                                            }
                                            else{
                                                document.getElementById('#i#totaldays').value = parseFloat(this.value);
                                            }
                                          }
                                          else{
                                            document.getElementById('#i#totaldays').value = parseFloat(this.value);
                                          }">
                            </td>
                            <td>
                                <cfif i eq "AL">
                                    <!---<input type="text" size="5" name="#i#bfdays" id="#i#bfdays" value=""  onKeyUp="document.getElementById('#i#totaldays').value=parseFloat(this.value)+parseFloat(document.getElementById('#i#days').value)">--->
                                    <input type="text" size="5" id="#i#bfdays" value="" 
                                     onKeyUp="if(document.getElementById('#i#days').value != ''){
                                                document.getElementById('#i#totaldays').value = parseFloat(this.value) +
                                                parseFloat(document.getElementById('#i#days').value);
                                              }
                                              else{
                                                document.getElementById('#i#totaldays').value = parseFloat(this.value);
                                              }">
                                </cfif>
                            </td>
                            <td><input type="text" size="5" id="#i#totaldays" value=""></td>
                            <td class="checktd"><input type="checkbox" name="#i#earndays" id="#i#earndays"></td>
                            <td> 
                                <cfif i eq "AL">
                                <select id="#i#type" style="width:80px">
                                    <option value="lmwd">Last Month Work Done</option>
                                    <option value="tmwd">This Month Work Done</option>
                                </select>
                                </cfif>
                            </td>
                              <td class="checktd">
                                <cfif i eq "AL">
                                    <input type="checkbox" id="#i#bfable">
                                </cfif>
                              </td>
                            <td>
                                <input type="text" id="#i#remarks" value="" >
                            </td>
                        </tr>
                    </cfloop>

                    <tr>
                        <th>Update PIC Tagging</th>
                        <th></th>
                        <th colspan="4">PIC tagging</th>
                        <th colspan="3">PIC Email</th>
                    </tr>
                    <tr>
                        <td class="checktd"><input type="checkbox" id="hrMgrchange" value="hrMgr" onchange="checkboxaction(this.value, 'tagging')"></td>
                        <th>Hiring Manager</th>
                        <td colspan="4">
                            <input type="hidden" id="hrMgr" class="hrMgrFilter" data-placeholder="Hiring Manager" .
                                   onchange="getHRmgrEmail(this.value);" >
                        </td>
                        <td colspan="3"><input type="text" id="hrMgrEmail" readonly value=""></td>
                    </tr>
                    <tr>
                        <td class="checktd"><input type="checkbox" id="mpPICchange" value="mpPIC" onchange="checkboxaction(this.value, 'tagging')"></td>
                        <th>MP PIC (Primary)</th>
                        <td colspan="4">
                            <input type="hidden" id="mpPIC" class="mpPicFilter" data-placeholder="MP PIC Primary" 
                                   onchange="fillemail(this.value, this.id)" />
                        </td>
                        <td colspan="3"><input type="text" id="mpPICEmail" readonly value=""></td>
                    </tr>
                    <tr>
                        <td class="checktd"><input type="checkbox" id="mpPIC2change" value="mpPIC2" onchange="checkboxaction(this.value, 'tagging')"></td>
                        <th>MP PIC (Secondary)</th>
                        <td colspan="4">
                            <input type="hidden" id="mpPIC2" class="mpPicFilter2" data-placeholder="MP PIC Secondary" 
                                   onchange="fillemail(this.value, this.id)"/>
                        </td>
                        <td colspan="3"><input type="text" id="mpPIC2Email" readonly value=""></td>
                    </tr>
                    <tr>
                        <td class="checktd"><input type="checkbox" id="mpPicSpchange" value="mpPicSp" onchange="checkboxaction(this.value, 'tagging')"></td>
                        <th>MP Supervisor</th>
                        <td colspan="4">
                            <input type="hidden" id="mpPicSp" class="mpPicSpFilter" data-placeholder="MP PIC Supervisor" 
                                   onchange="fillemail(this.value, this.id)"/>
                        </td>
                        <td colspan="3"><input type="text" id="mpPicSpEmail" readonly value=""></td>
                    </tr>
                            
                    <tr></tr>
                    <tr><th></th></tr>
                </table>
                <br /><center><input type="submit" name="Save" id="Save" value="Update"></center>
            </cfform>
        </body>
    </head>
</html>    
</cfoutput>