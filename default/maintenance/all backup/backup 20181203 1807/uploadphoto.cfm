<form name="upload_picture" action="icitem_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
	<table class="data" align="center" width="779">
		<tr>
        	<th height='20' colspan='8'><div align='center'><strong>Upload Item Photo<img src="../../images/d.gif" name="imgr2" align="center"></strong></div></th>
      	</tr>
		<tr id="r2">
			<td align="center">
				<input type="file" name="picture" size="50" onChange="javascript:uploading_picture(this.value);" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
				<br/>
				<input type="text" name="picture_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="ColdFusion.Window.hide('uploadphotoAjax');javascript:return add_option(document.getElementById('picture_name').value);">
			</td>
		</tr>
	</table>
</form>