<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
			function formatResultPO(result){
				return result.po_no; 
			};
			
			function formatSelectionPO(result){
				return result.po_no;  
			};
		
			$(document).ready(function(e) {
				$('.PONOfilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/filter/filterPONO.cfc',
						dataType:'json',
						data:function(term,page){
							return{
								method:'listAccount',
								returnformat:'json',
								dts:dts,
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
								url:'/latest/filter/filterPONO.cfc',
								dataType:'json',
								data:{
									method:'getSelectedAccount',
									returnformat:'json',
									dts:dts,
									value:value,
								},
							}).done(function(data){callback(data);});
						};
					},
					formatResult:formatResultPO,
					formatSelection:formatSelectionPO,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					
				});
			});
    </script>
</cfoutput>