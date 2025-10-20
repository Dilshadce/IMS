<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
			function formatResultEmployee(result){
				return result.empno+' - '+result.name; 
			};
			
			function formatSelectionEmployee(result){
				$('##name').val(result.name);
				return result.empno+' - '+result.name;  
			};
		
			$(document).ready(function(e) {
				$('.employeeFilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/filter/filterEmployee.cfc',
						dataType:'json',
						data:function(term,page){
							return{
								method:'listAccount',
								returnformat:'json',
								dts:dts,
								Hlinkams:Hlinkams,
								term:term,
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
								url:'/latest/filter/filterEmployee.cfc',
								dataType:'json',
								data:{
									method:'getSelectedAccount',
									returnformat:'json',
									dts:dts,
									value:value,
									Hlinkams:Hlinkams,
								},
							}).done(function(data){callback(data);});
						};
					},
					formatResult:formatResultEmployee,
					formatSelection:formatSelectionEmployee,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an Employee",
					
					<cfif NOT IsDefined('employee')>
						<cfset employee="">
					</cfif>
					
				}).select2('val','#employee#');
			});
    </script>
</cfoutput>