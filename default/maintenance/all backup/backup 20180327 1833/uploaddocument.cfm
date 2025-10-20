<form name="upload_document" action="icitem_document.cfm" method="post" enctype="multipart/form-data" target="_blank">
	<table class="data" align="center" width="779">
		<tr>
        	<th height='20' colspan='8'><div align='center'><strong>Upload Document</strong></div></th>
      	</tr>
		<tr id="r2">
			<td align="center">
				<input type="file" name="document" size="50" onChange="javascript:uploading_document(this.value);" accept="application/msword,application/excel">
				<br/>
				<input type="text" name="document_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="ColdFusion.Window.hide('uploaddocumentAjax');javascript:return add_option2(document.getElementById('document_name').value);">
			</td>
		</tr>
	</table>
</form>