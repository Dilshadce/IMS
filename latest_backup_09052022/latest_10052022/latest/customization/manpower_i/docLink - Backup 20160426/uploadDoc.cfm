<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Upload Document</title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<style>
	.btn-file {
		position: relative;
		overflow: hidden;
	}
	
	.btn-file input[type=file] {
		position: absolute;
		top: 0;
		right: 0;
		min-width: 100%;
		min-height: 100%;
		font-size: 100px;
		text-align: right;
		filter: alpha(opacity=0);
		opacity: 0;
		outline: none;
		background: white;
		cursor: inherit;
		display: block;
	}
</style>
</head>

<body>
<cfoutput>
<div class="container">
	<form class="form-horizontal" id="uploadDocForm" name="uploadDocForm" action="uploadDocProcess.cfm?action=upload" method="post" enctype="multipart/form-data" onSubmit="return isUpload()">
    	<div class="row">
            <div class="col-sm-6">
                <div>
                    <span>&nbsp;</span>
                </div>   
                <div class="input-group">
                    <input type="text" class="form-control" id="filePath" name="filePath" readonly>
                    <span class="input-group-btn">
                        <span class="btn btn-primary btn-file">
                            Browse&hellip; <input type="file" id="fileUpload" name="fileUpload" onChange="uploadingDoc(this.value)">
                        </span>
                    </span>
                </div>  
                <div>
                    <span>&nbsp;</span>
                </div>          
                <div class="input-group">	
                    <span class="input-group-addon">									
                         <label class="col-sm-4 control-label" for="fileName">File Name</label>
                     </span>     
                    <input type="text" class="form-control" id="fileName" name="fileName">                                                       
                </div> 
            </div>
    	</div>    
        <div class="col-sm-6">
        	<div>
                <span>&nbsp;</span>
            </div>
        	<div class="pull-right">
                <input type="hidden" id="hidId" name="hidId" value="#url.id#" />
                <input type="hidden" id="hidUuid" name="hidUuid" value="#url.uuid#" />
                <input type="hidden" id="hidDocType" name="hidDocType" value="#url.docType#" />
                <input type="hidden" id="hidClient" name="hidClient" value="#url.client#" />
                <input type="hidden" id="hidAssociate" name="hidAssociate" value="#url.associate#" />
                <input type="hidden" id="hidDocOwner" name="hidDocOwner" value="#url.docOwner#" />
                <input type="hidden" id="hidExpiryDate" name="hidExpiryDate" value="#url.expiryDate#" />
                <input type="hidden" id="hidEmail" name="hidEmail" value="#url.email#" />
                <input type="hidden" id="hidStartDate" name="hidStartDate" value="#url.startDate#" />
                <input type="hidden" id="hidMonthsBefore" name="hidMonthsBefore" value="#url.monthsBefore#" />
                <input type="hidden" id="hidFrequency" name="hidFrequency" value="#url.frequency#" />
                <input type="hidden" id="hidAction" name="hidAction" value="#url.action#" />
                <button type="submit" class="btn btn-primary" id="upload" name="upload">Upload</button>
                <button type="button" class="btn btn-default" onClick="closeWindow()">Cancel</button>
            </div>
        </div>        
    </form>
</div>

<script type="text/javascript">
	<!---function uploadingDoc(docName){
		var newDocName = new String(docName);
		var newDocName2 = newDocName.split(/[-,/,\\]/g);
		document.getElementById("filePath").value = newDocName;
		document.getElementById("fileName").value = newDocName2[newDocName2.length-1];
	}
	
	function closeWindow(){
		close();
	}--->
</script>
</cfoutput>
</body>
</html>