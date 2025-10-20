<cfoutput>
 	<!--- Logout Confirmation--->
    <div class="modal fade" id="myLogout" tabindex="-1" role="dialog" aria-labelledby="myLogout" aria-hidden="true">
		<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    <h4 class="modal-title" id="myLogoutLabel">IMS Logo</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="row">
                            <label for="logoutMessage" class="control-label">
                            	ARE YOU SURE YOU WANT TO LOG OUT ?
                            </label>
                        </div>				
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button type="button" data-dismiss="modal">Close</button>
                    <button type="button" >Save</button>
                  </div>
			</div>
		</div>
	</div>
</cfoutput>