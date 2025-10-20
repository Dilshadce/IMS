<cfsetting showdebugoutput="no">
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <link rel="stylesheet" type="text/css" href="target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
	
	
	
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	<script type="text/javascript" src="jquery.sortable.min.js"></script>
	
	<script type="text/javascript">
	
			$(function () {
				$(".source, .target").sortable({
					connectWith: ".connected"
				});
			});
			
			
			
			$('.source li').dblclick(function() {
				var litem = $(this).clone();
				litem.appendTo($('.target'));
				$(this).remove();
			});
			
			$('.target li').dblclick(function() {
				var litem = $(this).clone();
				litem.appendTo($('.source'));
				$(this).remove();
			});
			
	</script>

<cfquery name="getpolist" datasource="#dts#">
	SELECT * FROM manpowerpolink where pono=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">
</cfquery>



<cfquery name="getcustno" datasource="#dts#">
			SELECT custno,poamount from manpowerpo where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#" />
</cfquery>

<cfset jolist=valuelist(getpolist.jono)>
<cfquery name="getjolist" datasource="#dts#">
            SELECT placementno
            FROM placement
            WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustno.custno#" />
            AND placementno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#jolist#">)
			order by placementno
</cfquery>

<cfquery name="getjoamount" datasource="#dts#">
		SELECT ifnull(sum(custtotal),0) as custtotal FROM assignmentslip
		WHERE placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#jolist#">)
</cfquery>
                

									
									
<cfoutput>
	<div class="col-sm-6">
		
	</div>
	<div class="col-sm-3">
		PO Amount
	</div>
	
	<div class="col-sm-3">
		Total JO Amount
	</div>
	<div class="col-sm-6">
		
	</div>
	<div class="col-sm-3">
		<input type="text" name="poamount" id="poamount" value="#getcustno.poamount#" readonly>
	</div>
	
	<div class="col-sm-3">
		<input type="text" name="joamount" id="joamount" value="#getjoamount.custtotal#" readonly>
	</div>

		<div class="form-group">
		<label for="pono" class="col-sm-6 control-label" style="text-align: center;" >JO Listing</label>
		<label for="pono" class="col-sm-6 control-label" style="text-align: center;" >In PO List</label>
		</div>
									
	<div class="form-group">
		<div class="col-sm-6">
		<ul class="source connected">
		<cfloop query="getjolist">
			<li>#placementno#</li>
		</cfloop>
		</ul>
	</div>
	<div class="col-sm-6">
		<ul class="target connected">
		<cfloop query="getpolist">
		<li>#jono#</li>
		</cfloop>
		</ul>
	</div>
	
	
	
</div>	
</cfoutput>