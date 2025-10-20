<html lang="en">
<head>

<title>Create Content</title>
<link rel="stylesheet" type="text/css" href="resources/css/reset-min.css" />
<link rel="stylesheet" type="text/css" href="resources/welcome.css"/>
<script type="text/javascript" src="../jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">

tinyMCE.init({
		// General options
		mode : "exact",
		elements : "content",
		theme : "advanced",
		skin : "o2k7",
		skin_variant : "silver",
		plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,inlinepopups,autosave",

		// Theme options
		theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>

</head>
<body>
	<cfquery name="getData" datasource="main">
			select * from help
			where menu_Id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.menu_id#">
		</cfquery>	
	
    <div class="col">
	<form method="post" action="cr8content_process.cfm?menu_id=<cfoutput>#getData.menu_id#</cfoutput>&type=create">
        <div class="block">
        <h3 class="block-title">Create Content</h3>
        <div class="block-body">
           Title : <input type="text" name="title" value="<cfoutput>#getData.title#</cfoutput>">
            
        </div>
        </div>
        <div class="block">
     	<div class="block-body">
           Simple Description : <br><textarea id="desp"  rows="2" cols="50" name="desp"><cfoutput>#getData.simple_desp#</cfoutput></textarea>
            
        </div>
        </div>
        <div class="block">
        <div class="block-body">
           Content: <br><textarea id="content" name="content" rows="15" cols="80" style="width: 80%"><cfoutput>#getData.content#</cfoutput></textarea>
            
           
              <p>&nbsp;</p>
           
        </div>
        </div>
		<input type="submit" name="save" value="Submit" />
	<input type="reset" name="reset" value="Reset" />
	<input type="button" value="Back" onClick="javascript:history.back();">
</form>
		
    </div>
  	
</body>
</html>