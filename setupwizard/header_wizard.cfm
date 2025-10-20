<head>
<style>
body{
	margin:0;
	padding:0;
}
.header_main{
	margin:0;
	padding:0;
	width:100%;
	height:67px;
	background-color:#cc425d;
}
.header_main p{
	padding-left:20px;
	font-size:20px;
	font-family:Helvetica, Arial, Sans-Serif;
	color:#FFF;
	float:left;
}
.header_main img{
	float:right;
	margin:0; 
}
.nav_bar{
	margin:0;
	padding:0;
	float:left;
	width:100%;
}
ul {
	margin:0;
	padding:0;
		 	
}
ul li { 
	display:inline-block;
	*display:inline;
	*float:left;
	zoom:1;
	height:30px;
	line-height:30px;
	width:220px;
	margin:1px 1px 0 0;
	text-indent:25px;
	position: relative; 
}
ul li:before {
	content:"";
	height:0;
	width:0;
	position:absolute;
	left:-2px;
	border-style: solid;
	border-width:15px 0 15px 15px;
	border-color: transparent transparent transparent #fff;
    z-index: 0;
	
}
ul li:first-child:before { 
	border-color:transparent;
}
	
ul li a:after { 
	content: " "; 
	height:0;
	width:0;
	position:absolute;
	right:-15px;
	border-style:solid;
	border-width:15px 0 15px 15px;
	border-color: transparent transparent transparent #999;
    z-index: 10;
}

ul li a{ 
font-size:12px;
z-index:100;
text-decoration:none;
color:#FFF;
font-family:Segoe UI;
}

ul li a {
    display: block;
    background: #999;
}
/*selected*/	
ul #list_menu1 a {
    background: #333;
}

ul #list_menu1 a:after {
    border-color: transparent transparent transparent #333; 
}


/*.breadcrumb li a:hover,.breadcrumb li a:active { 
background: #666;
}

.breadcrumb li a:hover:after { 
border-left-color: #666 !important;
 }

<style>.breadcrumb li a:after { 
border-left-color: #666 !important;
}*/

</style>
</head>

<cfoutput>
<cfquery name="getgsetup" datasource="#dts#">
	SELECT * FROM gsetup
</cfquery>
<div class="header_main">
    	<p>#getgsetup.compro#</p>
        <img name="imslogo" id="imslogo" src="/images/IMS_header.png" alt="imslogo">
    </div>
    <cfif not isdefined("url.type")><cfset url.type = 0></cfif>
    <div class="nav_bar">
        <ul class="breadcrumb">
        	<li <cfif url.type eq "w1">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 1>href="wizard1.cfm?type=w1"</cfif>>Company Profile</a></li>			
            <li <cfif url.type eq "w2">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 2>href="wizard2.cfm?type=w2"</cfif>>Company Logo/Bill Format</a></li>
			<li <cfif url.type eq "w3">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 3>href="wizard3.cfm?type=w3"</cfif>>Advance Feature Activation</a></li>
			<li <cfif url.type eq "w4">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 4>href="wizard4.cfm?type=w4"</cfif>>Transaction & Stock Control</a></li>
			<li <cfif url.type eq "w5">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 5>href="wizard5.cfm?type=w5"</cfif>>Import Master File</a></li>
			<li <cfif url.type eq "w6">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 6>href="wizard6.cfm?type=w6"</cfif>>User Setup</a></li>
			<li <cfif url.type eq "w7">id="list_menu1"</cfif>><a <cfif right(url.type,1) gt 7>href="wizard7.cfm?type=w7"</cfif>>User Define Setup</a></li>
		</ul>
    </div>

</cfoutput>