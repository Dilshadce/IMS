<cfoutput>
<!--- gradient Color --->


<cfset defaultColor = "background-color:##a5def8;
background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIxJSIgc3RvcC1jb2xvcj0iI2E1ZGVmOCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwMGFiY2MiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
background: -moz-linear-gradient(top, ##00abcc  11%, ##a5def8 120%); 
background: -webkit-gradient(linear, left top, left bottom, color-stop(11%,##00abcc), color-stop(120%,##00abcc)); 
background: -webkit-linear-gradient(top,  ##a5def8 11%,##a5def8 120%); 
background: -o-linear-gradient(top,  ##00abcc  11%, ##a5def8 120%); 
background: -ms-linear-gradient(top,  ##00abcc  11%, ##a5def8 120%);
background: linear-gradient(to bottom, ##00abcc  11%, ##a5def8 120%); 
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##00abcc', endColorstr='##a5def8',GradientType=0 );">

<cfset arrColors = ArrayNew( 1 ) />
	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##EF628C 100%);

 
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##EF628C 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##EF628C 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##EF628C));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##EF628C 100%);


background-image: linear-gradient(to top, ##FFFFFF 0%, ##EF628C 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##EF628C',GradientType=0 );
" ) />

	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##C930EF 100%);

 
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##C930EF 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##C930EF 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##C930EF));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##C930EF 100%);


background-image: linear-gradient(to top, ##FFFFFF 0%, ##C930EF 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##C930EF',GradientType=0 );

" ) />

	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##2DBBEF 100%);

 
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##2DBBEF 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##2DBBEF 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##2DBBEF));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##2DBBEF 100%);

filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##2DBBEF',GradientType=0 );
background-image: linear-gradient(to top, ##FFFFFF 0%, ##2DBBEF 100%);" ) />
	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##74EF67 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##74EF67',GradientType=0 );
 
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##74EF67 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##74EF67 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##74EF67));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##74EF67 100%);


background-image: linear-gradient(to top, ##FFFFFF 0%, ##74EF67 100%);" ) />
	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##EAEF51 100%);

 filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##EAEF51',GradientType=0 );
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##EAEF51 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##EAEF51 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##EAEF51));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##EAEF51 100%);


background-image: linear-gradient(to top, ##FFFFFF 0%, ##EAEF51 100%);" ) />
	<cfset ArrayAppend( arrColors, "
background-image: -ms-linear-gradient(bottom, ##FFFFFF 0%, ##FFD769 100%);

 filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='##FFFFFF', endColorstr='##FFD769',GradientType=0 );
background-image: -moz-linear-gradient(bottom, ##FFFFFF 0%, ##FFD769 100%);


background-image: -o-linear-gradient(bottom, ##FFFFFF 0%, ##FFD769 100%);


background-image: -webkit-gradient(linear, left bottom, left top, color-stop(0, ##FFFFFF), color-stop(1, ##FFD769));

 
background-image: -webkit-linear-gradient(bottom, ##FFFFFF 0%, ##FFD769 100%);


background-image: linear-gradient(to top, ##FFFFFF 0%, ##FFD769 100%);" ) />


<!--- gradient Color --->
</cfoutput>