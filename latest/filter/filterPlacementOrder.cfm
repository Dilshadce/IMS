<cfoutput>
	<script type="text/javascript">
		var Hlinkams='#Hlinkams#';
		var dts='#dts#';
		var table='placement';
		var limit=10;
	</script>
</cfoutput>

<script type="text/javascript">

	function formatResult26(result){
		 return result.id;  
	};
	
	function formatSelection26(result){
		$('#description').val(result.id);
		return result.id;
	};
	
	$(document).ready(function(e) {
		$('.placementOrderFilter').select2({
			ajax:{
				type: 'POST',
				url:'/latest/filter/filterPlacementOrder.cfc',
				dataType:'json',
				data:function(term,page){
					return{
						method:'listPlacementNo',
						returnformat:'json',
						Hlinkams:Hlinkams,
						dts:dts,
						table:table,
						term:term,
						limit:limit,
						page:page-1,
					};
				},
				results:function(data,page){
					console.log(data,page);
				
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
						url:'/latest/filter/filterPlacementOrder.cfc',
						dataType:'json',
						data:{
							method:'listAccount',
							returnformat:'json',
							Hlinkams:Hlinkams,
							dts:dts,
							table:table,
							value:value,
						},
					}).done(function(data){
						console.log(data);
						callback(data);});
				};
			},
			formatResult:formatResult26,
			formatSelection:formatSelection26,
			minimumInputLength:0,
			width:'off',
			dropdownCssClass:'bigdrop',
			dropdownAutoWidth:true,
			placeholder:"Choose an placement no",
			allowClear:true,			
					
		});
	});
</script>
