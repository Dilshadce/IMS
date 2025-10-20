<cfoutput>
        <!---Change Billing Address--->
    <div class="modal fade" id="myModalBillingAddress" tabindex="-1" role="dialog" aria-labelledby="myModalBillingAddress" aria-hidden="true">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myModalBillingAddressLabel">Billing Address</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                    	<div class="form-group">
                            <label for="nameLabel" class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-8">
                            	<input type="text" class="form-control input-sm" id="name" name="name" placeholder="Name">
                            	<input type="text" class="form-control input-sm" id="name2" name="name2" placeholder="Name 2">
                        	</div>
						</div>
                        <div class="form-group">
                            <label for="attnLabel" class="col-sm-2 control-label">Attention</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="attn" name="attn" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add1Label" class="col-sm-2 control-label">Address</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="add1" name="add1" placeholder="Street Address" maxlength="35">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add2" class="col-sm-2 control-label"></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="add2" name="add2" placeholder="Apt, Suite, Bldg." maxlength="35">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add3" class="col-sm-2 control-label"></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="add3" name="add3" placeholder="Additional Address Information" maxlength="35">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="add4" class="col-sm-2 control-label"></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="add4" name="add4" placeholder="Town/City" maxlength="35">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"></label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control input-sm" id="country" name="country" placeholder="Country" maxlength="25">											
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control input-sm" id="postalcode" name="postalcode" placeholder="Postal Code" maxlength="25">
                            </div>
                        </div>	
                        <div class="form-group">
                            <label for="phone" class="col-sm-2 control-label">Phone</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control input-sm" id="phone" name="phone" placeholder="Primary Phone Number" maxlength="25">
                            </div>
                            <label for="fax" class="col-sm-1 control-label">Fax</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control input-sm" id="fax" name="fax" placeholder="Fax Number" maxlength="25">
                            </div>
                            
                        </div>
                        <div class="form-group">
                         	<label for="hp" class="col-sm-2 control-label">HP</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control input-sm" id="hp" name="hp" placeholder="Mobile Number" maxlength="25">
                            </div> 
                            <label for="email" class="col-sm-1 control-label">Email</label>
                            <div class="col-sm-4">
                                <input type="email" class="form-control input-sm" id="email" name="email" placeholder="Email Address" maxlength="100">
                            </div>  
                        </div>								
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="submit_billing_address">Save</button>
                  </div>
			</div>
		</div>
	</div>
</cfoutput>