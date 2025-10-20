<cfoutput>
<form name="upload_picture" action="icitem_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
	<table class="data" align="center" width="779">
    <input type="hidden" name="itemnoimage" id="itemnoimage" value="#url.itemno#" />
    <input type="hidden" name="refnoimage" id="refnoimage" value="#url.refno#" />
    <input type="hidden" name="reftypeimage" id="reftypeimage" value="#url.type#" />
    <input type="hidden" name="trancodeimage" id="trancodeimage" value="#url.trancode#" />
		<tr>
        	<th height='20' colspan='8'><div align='center'><strong>Upload Item Photo</strong></div></th>
      	</tr>
		<tr>
			<td align="center">
				<input type="file" name="picture" size="50" onChange="javascript:uploading_picture(this.value);" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
				<br/>
				<input type="text" name="picture_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="javascript:ColdFusion.Window.hide('uploadimage');">
			</td>
		</tr>
	</table>
</form>
</cfoutput>