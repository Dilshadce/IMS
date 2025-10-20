<cfoutput>
    <div class="row" id="body_section">  
        <table class="itemTable">
            <thead>
                <tr class="itemTableTR">
                    <th class="th_one itemTableTH">Invoice Number</th>
                    <th class="th_two itemTableTH">Item Number</th>
                    <th class="th_three itemTableTH">Description</th>
                    <th class="th_four itemTableTH">Quantity</th>
                    <th class="th_five itemTableTH">Price</th>
                    <th class="th_seven itemTableTH">Amount</th>
                    <th class="th_two itemTableTH">Placement No.</th>                                            
                    <th class="th_seven itemTableTH">Action<br><input type="button" name="deletebtnall" id="deletebtnall" onClick="deletelist()" value=" Delete "/><br><div>Select All <input type="checkbox" name="checkAll" id="checkAll" value="checkAll" onclick="checkall(this.value)"/></div></th>
                </tr>
            </thead>
            <tbody id="item_table_body">
                <cfif isdefined('getictrantemp')>
                    <cfloop query="getictrantemp">
                    <tr id="#trancode#" class="edit_tr last_edit_tr">
                        <td class="td_one">
                            #refno2#
                        </td>
                        <td class="td_one">
                            #itemno#
                        </td>
                        <td class="td_seven">
                            #desp#
                        </td>
                        <td class="td_seven">
                            <a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.id#';ColdFusion.Window.show('changeqty');getfocus5();">
                            #qty_bil#
                            </a>
                        </td>
                        <td class="td_seven">
                            <a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.id#';ColdFusion.Window.show('changeprice');getfocus4();">
                            #numberformat(val(getictrantemp.price_bil),',.__')#
                            </a>

                        </td>
                        <td class="td_seven">

                            #numberformat(val(getictrantemp.amt_bil),',.__')#

                        </td>
                        <td class="td_seven">
                            <cfquery name="getplacementno" datasource="#dts#">
                                SELECT placementno FROM assignmentslip 
                                WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictrantemp.brem6#">
                            </cfquery>
                                
                            <input type="hidden" id="placementno#getictrantemp.brem6##getictrantemp.trancode#" name="placementno#getictrantemp.brem6##getictrantemp.trancode#" class="JOFilter <cfif getictrantemp.brem6 eq ''>placementno#getictrantemp.brem1#<cfelse>placementno#getplacementno.placementno#</cfif>" value="<cfif getictrantemp.brem6 eq ''>#getictrantemp.brem1#<cfelse>#getplacementno.placementno#</cfif>" placeholder="Select a placement" <cfif getictrantemp.brem6 eq ''>onchange=" $('.placementno#getictrantemp.brem1#').each(function(){
$(this).select2('val',$('##placementno#getictrantemp.brem6##getictrantemp.trancode#').val());
                                });"<cfelse>onchange=" $('.placementno#getplacementno.placementno#').each(function(){
$(this).select2('val',$('##placementno#getictrantemp.brem6##getictrantemp.trancode#').val());
                                });"</cfif>
                            />
                        </td>
                        <td class="td_seven">
                        <input type="button" name="deletebtn#getictrantemp.id#" id="deletebtn#getictrantemp.id#" onClick="if(confirm('Confirm Delete This Item?')){deleterow('#getictrantemp.id#')}" value="Delete"/>
                        <img id="updatebtn#getictrantemp.id#" name="updatebtn#getictrantemp.id#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;">
                        <br>
                        <input type="checkbox" class="deleteall" name="checkdeletebtn" id="checkdeletebtn" value="#getictrantemp.id#"/>

                        </td>
                    </tr>     
                </cfloop>
                </cfif>
                <tr class="itemTableList">
                    <td colspan="2">
                        <div class="col-sm-12">
                            <input type="hidden" id="itemno" name="itemno" class="itemFilter" value="" placeholder="Select an item" />
                        </div>
                    </td>
                    <td class="td_three">
                    <div class="col-sm-9">
                    <input type="text" id="desp" name="desp" value="" placeholder="Item description" />
                    </div>
                    </td>
                    <td class="td_four">
                    <div class="col-sm-9">
                    <input type="number" id="qty" name="qty" step="0.01" value="1" min="1" max="5"/>
                    </div>
                    </td>
                    <td class="td_five">
                    <div class="col-sm-9">
                    <input type="number" id="price" name="price" step="0.01" value="0.00" min="1" max="5" onkeyup="calcamount()"/>
                    </div>
                    </td>
                    <td class="td_six">
                    <div class="col-sm-9">
                    <input type="number" id="amount" name="amount" step="0.01" value="0.00" min="1" max="5"/>
                    </div>
                    </td>
                    <td>
                        <input type="hidden" id="addsingleJO" name="addsingleJO" class="JOFilter" value="" placeholder="Select a placement"/>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                <td colspan="2">
                Period Start:<br />
                <div class="col-sm-12">
                    <div class="input-group date">       
                        <input type="text" class="form-control input-sm" id="startdate" name="startdate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>											
                </div>
                </td>
                <td colspan="2">
                Period End:<br /> 
                <div class="col-sm-12">
                    <div class="input-group date">       
                        <input type="text" class="form-control input-sm" id="completedate" name="completedate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>											
                </div>
                </td>
                <td colspan="2">
                <div class="col-sm-12">
                    <input type="hidden" id="assignrefno" name="assignrefno" class="AssignFilter" value="" placeholder="Select a assignmentslip" />
                </div>
                </td>
                <td class="td_seven" colspan="2">
                    <div class="col-sm-12">
                    <input type="button" class="form-control input-sm"  id="additembtn" name="additembtn" onclick="document.getElementById('additembtn').disabled = true;" value="Add Item" />
                    </div>
                </td>
                </tr>
            </tbody>
                
        </table>
    </div>
</cfoutput>