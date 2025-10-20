<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1760, 1272, 1761, 1762, 1763, 1764, 1855, 1856, 1857, 11">
<cfinclude template="/latest/words.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <cfoutput><title>#words[1760]#</title></cfoutput>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/general/chartofaccount.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="/latest/js/jeditable/jquery.jeditable.mini.js"></script>
    <cfoutput>
        <script type="text/javascript">
            var dts='#dts#';
			var authUser='#getAuthUser()#';
			var menuid = '#words[1855]#';
			var menuname = '#words[1855]#';
			var newmenuname = '#words[1856]#';
			var menulevel = '#words[1857]#';
			var SEARCH = '#words[11]#';
        </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/js/generalSetup/generalInfoSetup/userDefinedMenu.js"></script>
</head>
<body>
<cfoutput>
    <div class="container">
        <div class="page-header">
            <h2>
                #words[1760]#
                <span class="glyphicon glyphicon-question-sign btn-link"></span>
                <span class="glyphicon glyphicon-facetime-video btn-link"></span>
            </h2>
        </div>
        <ul class="nav nav-tabs">
            <li id="allNav" class="active"><a id="allButton" class="navButton">#words[1272]#</a></li>
            <li id="level1Nav"><a id="level1Button" class="navButton">#words[1761]#</a></li>
            <li id="level2Nav"><a id="level2Button" class="navButton">#words[1762]#</a></li>
            <li id="level3Nav"><a id="level3Button" class="navButton">#words[1763]#</a></li>
            <li id="level4Nav"><a id="level4Button" class="navButton">#words[1764]#</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade in active">
                <div class="container">
                    <div id="alert" class="alert alert-danger fade in" style="display:none;">
                        <button type="button" class="close" aria-hidden="true">&times;</button>
                        <h4></h4>
                        <p></p>
                    </div>
                    <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </cfoutput>
</body>
</html>