<cfoutput>
	<script type="text/javascript">
		var dts='#dts#';
		var limit=10;
		<cfif IsDefined("targetCN") AND IsDefined("targetDN")>
			var targetCN="#targetCN#";
			var targetDN="#targetDN#";
		<cfelse>
			var targetCN="";
			var targetDN="";
		</cfif>
	</script>
</cfoutput>

<script type="text/javascript">

	function formatResultRefNo(result){		
		return result.refNo;  
	};
	
	function formatSelectionRefNo(result){
		return result.refNo;
	};
	
	$(document).ready(function(e) {
		$('.CNDNFilter').select2({
			ajax:{
				type: 'POST',
				url:'/latest/filter/filterCNDN.cfc',
				dataType:'json',
				data:function(term,page){
					return{
						method:'listCNDN',
						returnformat:'json',
						dts:dts,
						term:term,
						limit:limit,
						page:page-1,
						targetCN:targetCN,
						targetDN:targetDN
					};
				},
				results:function(data,page){
					var more=((page-1)*limit)<data.total;
					return{
						results:data.result,
						more:more
					};
				}
			},
			initSelection: function(element, callback) {
				var value=$(element).val();
				if(value!=''){
					$.ajax({
						type:'POST',
						url:'/latest/filter/filterCNDN.cfc',
						dataType:'json',
						data:{
							method:'getSelectedAccount',
							returnformat:'json',
							dts:dts,
							value:value,
							targetCN:targetCN,
							targetDN:targetDN
						},
					}).done(function(data){callback(data);});
				};
			},
			formatResult:formatResultRefNo,
			formatSelection:formatSelectionRefNo,
			minimumInputLength:0,
			width:'off',
			dropdownCssClass:'bigdrop',
			dropdownAutoWidth:true,
		});
	});
</script>
