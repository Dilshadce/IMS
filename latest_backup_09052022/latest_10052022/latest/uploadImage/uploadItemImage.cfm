<script language="JavaScript">
	
	function uploading_picture(pic_name)
	{
		var new_pic_name1 = new String(pic_name);
		var new_pic_name2 = new_pic_name1.split(/[-,/,\\]/g);
		document.getElementById("picture_name").value=new_pic_name2[new_pic_name2.length-1];
	}
	
	function add_option(pic_name){
		  var detection=0;
		  var totaloption=window.opener.document.getElementById("picture_available").length-1;
	
		  for(var i=0;i<=totaloption;++i){
			  
			  if(window.opener.document.getElementById("picture_available").options[i].value==pic_name){
				  detection=1;
				  break;
			  }
		  }
		  
		  if(detection!=1){
			  
			  var a=new Option(pic_name,pic_name);
			  window.opener.document.getElementById("picture_available").options[window.opener.document.getElementById("picture_available").length]=a;
		  }
		  window.opener.document.getElementById("picture_available").value=pic_name;
		  return true;
		  window.close('/latest/uploadImage/uploadItemImage.cfm');
	}
	
	function change_picture(picture){
	
		var encode_picture = encodeURI(picture);
		show_picture.location="/latest/uploadImage/icitem_image.cfm?pic3="+encode_picture;
	}
</script>		


<form name="uploadItemImage" action="icitem_image.cfm" method="post" enctype="multipart/form-data" target="_self">
	<table class="data" align="center" width="500px">
		<tr>
        	<th height='20' colspan='8'>
            	<div align='center'>
                	<strong>Upload Item's Image</strong>
                    <br />
                    <br />
                </div>
            </th>
      	</tr>
		<tr>
			<td align="center">
				<input type="file" id="picture" name="picture" size="50" onChange="uploading_picture(this.value);" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
				<br/>
				<input type="text" id="picture_name" name="picture_name" size="50" value="">&nbsp;
				<input type="submit" name="Upload" value="Upload" onClick="javascript:return add_option(document.getElementById('picture_name').value);">
			</td>
		</tr>
	</table>
</form>