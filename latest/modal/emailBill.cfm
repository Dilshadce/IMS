<cfoutput>
 	<!---Email Bill--->
    <div class="modal  modal-lg fade" id="myEmailBill" tabindex="-1" role="dialog" aria-labelledby="myEmailBill" aria-hidden="true">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myEmailBillLabel">Email **Transaction Type**</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="emailFromLabel" class="col-sm-2 control-label">From</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control input-sm" id="emailFrom" name="emailFrom" placeholder="Email From">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="emailToLabel" class="col-sm-2 control-label">To</label>
                            <div class="col-sm-10">
                            	<input type="text" class="form-control input-sm" id="emailTo" name="emailTo" placeholder="Email To (Separate multiple emails with commas)">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="emailSubjectLabel" class="col-sm-2 control-label">Subject</label>
                            <div class="col-sm-10">
                            	<input type="text" class="form-control input-sm" id="emailSubjectLabel" name="emailSubjectLabel" placeholder="Email Subject">
                            </div>
                        </div>	
                        <div class="form-group">
                            <label for="emailBodyLabel" class="col-sm-2 control-label">Body</label>
                            <div class="col-sm-10">
                            	<textarea class="form-control" id="emailBody" name="emailBody" rows="10"></textarea>
                            </div>
                        </div>				
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="sendEmail">Send</button>
                  </div>
			</div>
		</div>
	</div>
</cfoutput>