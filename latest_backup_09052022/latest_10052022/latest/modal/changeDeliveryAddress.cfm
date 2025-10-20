<cfoutput>
 	<!---Change Delivery Address--->
	<div class="modal fade" id="myModalDeliveryAddress" tabindex="-1" role="dialog" aria-labelledby="myModalDeliveryAddress" aria-hidden="true">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myModalDeliveryAddressLabel">Delivery Address</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                   		<div class="form-group">
							<label for="d_nameLabel" class="col-sm-2 control-label">Name</label>
							<div class="col-sm-8">
							<input type="text" class="form-control input-sm" id="d_name" name="d_name" placeholder="Delivery Name">
                            <input type="text" class="form-control input-sm" id="d_name2" name="d_name2" placeholder="Delivery Name 2">
							</div>
						</div>
						<div class="form-group">
							<label for="d_attnLabel" class="col-sm-2 control-label">Attention</label>
							<div class="col-sm-8">
							<input type="text" class="form-control input-sm" id="d_attn" name="d_attn">
							</div>
						</div>
						<div class="form-group">
							<label for="d_add1Label" class="col-sm-2 control-label">Address</label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm" id="d_add1" name="d_add1" placeholder="Street Address" maxlength="35">
							</div>
						</div>
						<div class="form-group">
							<label for="d_add2Label" class="col-sm-2 control-label"></label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm" id="d_add2" name="d_add2" placeholder="Apt, Suite, Bldg." maxlength="35">
							</div>
						</div>
						<div class="form-group">
							<label for="d_add3Label" class="col-sm-2 control-label"></label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm" id="d_add3" name="d_add3" placeholder="Additional Address Information" maxlength="35">
							</div>
						</div>
						<div class="form-group">
							<label for="d_add4Label" class="col-sm-2 control-label"></label>
							<div class="col-sm-8">
								<input type="text" class="form-control input-sm" id="d_add4" name="d_add4" placeholder="Town/City" maxlength="35">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"></label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_country" name="d_country" placeholder="Country" maxlength="25">											
							</div>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_postalcode" name="d_postalcode" placeholder="Postal Code" maxlength="25">
							</div>
						</div>	
						<div class="form-group">
							<label for="d_phoneLabel" class="col-sm-2 control-label">Phone</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_phone" name="d_phone" placeholder="Primary Phone Number" maxlength="25">
							</div>
                            <label for="d_faxLabel" class="col-sm-1 control-label">Fax</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_fax" name="d_fax" placeholder="Fax Number" maxlength="25">
							</div>
						</div>
						<div class="form-group">
							 <label for="d_hpLabel" class="col-sm-2 control-label">HP</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_hp" name="d_hp" placeholder="Mobile Number" maxlength="25">
							</div>
                            <label for="d_emailLabel" class="col-sm-1 control-label">Email</label>
							<div class="col-sm-4">
								<input type="text" class="form-control input-sm" id="d_email" name="d_email" placeholder="Email Address" maxlength="100">
							</div>
						</div>								
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="submit_delivery_address">Save</button>
                  </div>
			</div>
		</div>
	</div>
</cfoutput>