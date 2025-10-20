<cfoutput>
    <div class="modal modal-lg fade" id="myModalCreateCustomer" tabindex="-1" role="dialog" aria-labelledby="myModalCreateCustomer" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myModalCreateCustomerLabel">Create #target#</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="custnoLabel" class="col-sm-4 control-label">#target# No.</label>
                            <div class="col-sm-4">
                               <input type="text" class="form-control input-sm" id="create_custno" name="create_custno" placeholder="XXXX/XXX" maxlength="8" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="nameLabel" class="col-sm-4 control-label">Name</label>
                            <div class="col-sm-6">
                               <input type="text" class="form-control input-sm" id="create_name" name="create_name" placeholder="Name Line 1" maxlength="40">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name2Label" class="col-sm-4 control-label"></label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control input-sm" id="create_name2" name="create_name2" placeholder="Name Line 2" maxlength="40">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="attnLabel" class="col-sm-4 control-label">Attention</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_attn" name="create_attn" placeholder="Attention">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add1Label" class="col-sm-4 control-label">Address</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_add1" name="create_add1" placeholder="Street Address" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add2" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_add2" name="create_add2" placeholder="Apt, Suite, Bldg." maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add3" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_add3" name="create_add3" placeholder="Additional Address Information" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add4" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_add4" name="create_add4" placeholder="Town/City" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label"></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control input-sm" id="create_country" name="create_country" placeholder="Country" maxlength="25">											
                                </div>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control input-sm" id="create_postalcode" name="create_postalcode" placeholder="Postal Code" maxlength="25">
                                </div>
                            </div>	
                            <div class="form-group">
                                <label for="phone" class="col-sm-4 control-label">Phone</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_phone" name="create_phone" placeholder="Primary Phone Number" maxlength="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="hp" class="col-sm-4 control-label">HP</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_hp" name="create_hp" placeholder="Mobile Number" maxlength="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fax" class="col-sm-4 control-label">Fax</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_fax" name="create_fax" placeholder="Fax Number" maxlength="25">
                                </div>
                            </div>								
                            <div class="form-group">
                                <label for="email" class="col-sm-4 control-label">Email</label>
                                <div class="col-sm-8">
                                    <input type="email" class="form-control input-sm" id="create_email" name="create_email" placeholder="Email Address" maxlength="100">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="d_attn" class="col-sm-4 control-label">Delivery Attention</label>
                                <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="create_d_attn" name="create_d_attn" placeholder="Delivery Attention">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_add1" class="col-sm-4 control-label">Delivery Address</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_add1" name="create_d_add1" placeholder="Street Address" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_add2" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_add2" name="create_d_add2" placeholder="Apt, Suite, Bldg." maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_add3" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_add3" name="create_d_add3" placeholder="Additional Address Information" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_add4" class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_add4" name="create_d_add4" placeholder="Town/City" maxlength="35">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label"></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control input-sm" id="create_d_country" name="create_d_country" placeholder="Country" maxlength="25">											
                                </div>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control input-sm" id="create_d_postalcode" name="create_d_postalcode"  placeholder="Postal Code" maxlength="25">
                                </div>
                            </div>	
                            <div class="form-group">
                                <label for="d_phone" class="col-sm-4 control-label">Delivery Phone</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_phone" name="create_d_phone" placeholder="Primary Phone Number" maxlength="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_hp" class="col-sm-4 control-label">Delivery HP</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_hp" name="create_d_hp" placeholder="Mobile Number" maxlength="25">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="d_fax" class="col-sm-4 control-label">Delivery Fax</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="create_d_fax" name="create_d_fax" placeholder="Fax Number" maxlength="25">
                                </div>
                            </div>								
                            <div class="form-group">
                                <label for="d_email" class="col-sm-4 control-label">Delivery Email</label>
                                <div class="col-sm-8">
                                    <input type="email" class="form-control input-sm" id="create_d_email" name="create_d_email" placeholder="Email Address" maxlength="100">
                                </div>
                            </div>                                    
                        </div>
                    </form>
        
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close_create_target">Close</button>
                    <button type="button" class="btn btn-primary" id="submit_create_target" name="submit_create_target">Save</button>
                  </div>
            </div>
        </div>
    </div>
</cfoutput>