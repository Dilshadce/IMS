
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Contact Us</title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/latest/css/body/contact.css" />
<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/body/contact.js"></script>

<cfset comid = replace(getHQstatus.userbranch,'_i','')>
<cfquery name="getInviteFriend" datasource="main">
	SELECT companyid, partnerid
    FROM invitefriend
    WHERE companyid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#comid#">;
</cfquery>

<cfquery name="getPartner" datasource="net_c">
	SELECT address,contact,fax,email FROM partner
    WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getInviteFriend.partnerid#">
</cfquery>
</head>

<cfoutput>
	<body>
		<div class="container"><br />
			<div class="row">
				<div class="col-sm-8">
					<div class="row">
						<h4>Contact Us</h4>
						<p class="text-muted">
							#getPartner.address#
						</p>
						<p class="text-muted">
							<cfif getPartner.contact neq "">Contact: #getPartner.contact#</cfif>
							<cfif getPartner.fax neq ""><br />Fax: #getPartner.fax#</cfif>
						</p>
						<p class="text-muted">
							<cfif getPartner.email neq "">Email: #getPartner.email#</cfif>
						</p>
						<!--- <p class="text-muted">
							Tel: +65 6223 1157<br />
							Fax: +65 6422 1169
						</p> --->
					</div>
				</div>
			</div>
		</div>
	</body>
</cfoutput>
</html>
