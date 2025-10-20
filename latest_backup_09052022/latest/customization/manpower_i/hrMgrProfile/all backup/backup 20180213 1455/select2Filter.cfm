<cfoutput>    
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
		function formatResult(result){
			return result.customerNo + " - " + result.name; 
		};
		
		function formatSelection(result){
			return result.customerNo + " - " + result.name; 
		};
		
		function formatResult2(result){
			return result.CompID; 
		};
		
		function formatSelection2(result){
			return result.CompID; 
		};
		
		
		jQuery.noConflict();
		(function($){
  			jQuery(document).ready(function($) {
				$('.custnoFilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/customization/manpower_i/docLink/filterClient.cfc',
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
								url:'/latest/customization/manpower_i/docLink/filterClient.cfc',
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
					formatResult:formatResult,
					formatSelection:formatSelection,
					minimumInputLength:0,
					width:'100%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#custno#');
				
				
				$('.comIDFilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/customization/manpower_i/hrMgrProfile/filterDTS.cfc',
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
								url:'/latest/customization/manpower_i/hrMgrProfile/filterDTS.cfc',
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
					formatResult:formatResult2,
					formatSelection:formatSelection2,
					minimumInputLength:0,
					width:'100%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#comID#');
			});
		})(jQuery);
    </script>
</cfoutput>