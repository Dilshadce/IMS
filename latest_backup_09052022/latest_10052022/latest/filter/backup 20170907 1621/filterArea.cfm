<cfoutput>
	<script type="text/javascript">
		var dts='#dts#';
		var table='icarea';
		var Hlinkams='#Hlinkams#';
		var limit=10;
	</script>


<script type="text/javascript">

	function formatResult17(result){
		return result.area+' - '+result.desp; 
	};
	
	function formatSelection17(result){
		$('##description').val(result.desp);
		return result.area+' - '+result.desp;  
	};
	
	$(document).ready(function(e) {
		$('.areaFilter').select2({
			ajax:{
				type: 'POST',
				url:'/latest/filter/filterArea.cfc',
				dataType:'json',
				data:function(term,page){
					return{
						method:'listAccount',
						returnformat:'json',
						dts:dts,
						table:table,
						term:term,
						Hlinkams:Hlinkams,
						limit:limit,
						page:page-1,
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
						url:'/latest/filter/filterArea.cfc',
						dataType:'json',
						data:{
							method:'getSelectedAccount',
							returnformat:'json',
							dts:dts,
							table:table,
							Hlinkams:Hlinkams,
							value:value,
						},
					}).done(function(data){callback(data);});
				};
			},
			formatResult:formatResult17,
			formatSelection:formatSelection17,
			minimumInputLength:0,
			width:'off',
			dropdownCssClass:'bigdrop',
			dropdownAutoWidth:true,
			placeholder:"Choose a Area",
				<cfif NOT IsDefined('area')>
					<cfset area = "">	
				</cfif>
					
				}).select2('val','#area#');
	});
</script>
</cfoutput>