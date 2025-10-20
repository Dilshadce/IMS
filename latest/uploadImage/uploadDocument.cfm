<script language='JavaScript'>	
    function add_option2(doc_name){
	
		var detection=0;
		var totaloption=window.opener.document.getElementById("document_available").length-1;
	
		for(var i=0;i<=totaloption;++i){
			
			if(window.opener.document.getElementById("document_available").options[i].value==doc_name){
				detection=1;
				break;
			}
		}
		
		if(detection!=1){
			var a=new Option(doc_name,doc_name);
			window.opener.document.getElementById("document_available").options[window.opener.document.getElementById("document_available").length]=a;
		}
		window.opener.document.getElementById("document_available").value=doc_name;
		return true;
	}
	
	function change_picture(picture){
	
		var encode_picture = encodeURI(picture);
		show_picture.location="/latest/uploadImage/icitem_image.cfm?pic3="+encode_picture;
	}
</script>

<form name="uploadDocumentForm" action="icitem_document.cfm" method="post" enctype="multipart/form-data" target="_self">
	<table class="data" align="center" width="500px">
		<tr>
        	<th height='20' colspan='8'>
            	<div align='center'>
                	<strong>Upload Document</strong>
                </div>
            </th>
      	</tr>
		<tr>
			<td align="center">
				<input type="file" name="document" size="50" onChange="uploading_document(this.value);" accept="application/msword,application/excel">
				<br/>
				<input type="text" name="document_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="ColdFusion.Window.hide('uploaddocumentAjax');javascript:return add_option(document.getElementById('document_name').value);">
			</td>
		</tr>
	</table>
</form>