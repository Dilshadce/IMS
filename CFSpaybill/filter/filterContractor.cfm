<script type="text/javascript">
	var Hlinkams='#Hlinkams#';
	var dts='#dts#';
	var table='cfsemp';
	var limit=10;

	function formatResult27(result){
		 return result.name;  
	};
	
	function formatSelection27(result){
		$('#description').val(result.name);
		return result.name;
	};
	<cfoutput>
	$(document).ready(function(e) {
		$('.conprofile').select2({
			ajax:{
				type: 'POST',
				url:'/CFSpaybill/filter/filterContractor.cfc',
				dataType:'json',
				data:function(term,page){
					return{
						method:'listContractor',
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
						url:'/CFSpaybill/filter/filterContractor.cfc',
						dataType:'json',
						data:{
							method:'getSelectedAccount',
							returnformat:'json',
							Hlinkams:Hlinkams,
							dts:dts,
							table:table,
							value:value,
						},
					}).done(function(data){
						console.log(data);
						callback(data);});
				}
			},
			formatResult:formatResult27,
			formatSelection:formatSelection27,
			minimumInputLength:0,
			width:'off',
			dropdownCssClass:'bigdrop',
			dropdownAutoWidth:true,
			placeholder:"Choose an Contractor",
			allowClear:true,			
					
		}).select2('val',"<cfif isdefined('empno')>#empno#</cfif>");
	});
	</cfoutput>
</script>

