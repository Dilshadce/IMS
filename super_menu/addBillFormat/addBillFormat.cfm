<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>Add .CFR Bill</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <!---<script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="/latest/js/jeditable/jquery.jeditable.mini.js"></script>--->
    <cfoutput>
        <script type="text/javascript">
            var dts='#dts#';
			var authUser='#getAuthUser()#';
        </script>
    </cfoutput>
    <!---<script type="text/javascript" src="addBillFormat.js"></script>--->
    <script type="text/javascript" src="dropzone.js"></script>
    <link rel="stylesheet" href="/super_menu/addBillFormat/dropzone.css" />
    
    <script>
	$(document).ready(function(e) {
		Dropzone.autoDiscover = false;
		$('#file-dropzone').dropzone({
			url:'/super_menu/addBillFormat/uploadProcess.cfm',
			paramName: "uploadfile",
			maxFilesize: 1,
			maxThumbnailFilesize: 1,
			maxFiles: 1,
			accept: function(file, done) {
				
						var validExtension = ["cfr"];
						var fileName = file.name;											// split the filename on "."
						var userInputFileExtension = fileName.split(".");
						
						if (userInputFileExtension.length > 1) {									// if there are at least two pieces to the file name, continue the check
						
							var fileExtension = userInputFileExtension[userInputFileExtension.length-1];		// get the extension
							
							if($.inArray(fileExtension, validExtension) >= 0){				// if the extension is in the array, return true, if not, return false
								alert(11);
								// true
							}
							else{
								alert(22);
								// false
							}
						}
						else {
							alert(999);
						}
			},
			dictDefaultMessage: "... Click or Drop Here ...",
			init: function() {
				this.on('drop', function(file) {
					/*$.ajax({
						type:'POST',
						url:'/super_menu/addBillFormat/uploadProcess.cfm',
						cache:false,
						success: function(result){
							alert('success uploaded');
						},
						error: function(jqXHR,textStatus,errorThrown){
							alert(errorThrown);
						},
						complete: function(){
						}
					});*/
			  });
			  
/*			  this.on('success', function(file, json) {
				  alert(123);
			  });
			  
			  this.on('drop', function(file) {
				alert('file');
			  }); */
			}
		  });
	});
    </script>
    
</head>

<body>
	<cfoutput>
        <div class="container">
            <div class="page-header">
                <h2> Add .CFR Bill </h2>
            </div>

            <form class="dropzone" id="file-dropzone" method="POST" enctype="multipart/form-data"></form>
           
<!---            <div class="container">
                <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>--->
        </div>
    </cfoutput>
</body>
</html>