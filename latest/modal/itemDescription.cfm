<cfquery name="getGsetup" datasource="#dts#">
    SELECT brem1,brem2,brem3,brem4 
    FROM gsetup;
</cfquery>  

<cfoutput>
 	<!---Item Description, Description 2, Comment--->
    <div class="modal fade" id="myItemDescription" tabindex="-1" role="dialog" aria-labelledby="myItemDescription" aria-hidden="true">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myItemDescriptionLabel">Item Description (Additional)</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                    	<input type="hidden" id="uuid_value" name="uuid_value">
                        <input type="hidden" id="itemno_value" name="itemno_value">
                        <input type="hidden" id="trancode_value" name="trancode_value">
                        <div class="form-group">
                            <label for="desplabel" class="col-sm-4 control-label">Description 2</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control input-sm" id="despa_input" name="despa_input" placeholder="Description 2">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="commentLabel" class="col-sm-4 control-label">Comment</label>
                            <div class="col-sm-8">
                            	<textarea class="form-control" id="comment_input" name="comment_input" rows="8"></textarea>
                            </div>
                        </div>	
                        <div class="form-group">
                        	<cfloop index="i" from="1" to="4">
                                <label for="bodyRemark#i#Label" class="col-sm-4 control-label">#evaluate('getGsetup.brem#i#')#</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control input-sm" id="brem#i#_input" name="bodyRemark#i#_input" placeholder="Body Remark #i#">
                                </div>
                            </cfloop>    
                        </div>							
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveItemDescription">Save</button>
                  </div>
			</div>
		</div>
	</div>
</cfoutput>