<cfoutput>    
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
		function formatResult(result){
			return result.doctype; 
		};
		
		function formatSelection(result){
			return result.doctype; 
		};
		
		function formatResult2(result){
			return result.customerNo + " - " + result.name; 
		};
		
		function formatSelection2(result){
			return result.customerNo + " - " + result.name; 
		};
		
		function formatResult3(result){
			return result.empno + " - " + result.name; 
		};
		
		function formatSelection3(result){
			return result.empno + " - " + result.name; 
		};
	
		$(document).ready(function(e) {
			$('.docTypeFilter').select2({
				ajax:{
					type: 'POST',
					url:'filterDocType.cfc',
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
							url:'filterDocType.cfc',
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
				placeholder:"Choose a Doc Type",					
			}).select2('val','#docType#');
			
			$('.clientFilter').select2({
				ajax:{
					type: 'POST',
					url:'filterClient.cfc',
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
							url:'filterClient.cfc',
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
				placeholder:"Choose a Client",					
			}).select2('val','#xclient#');
			
			$('.associateFilter').select2({
				ajax:{
					type: 'POST',
					url:'filterAssociate.cfc',
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
							url:'filterAssociate.cfc',
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
				formatResult:formatResult3,
				formatSelection:formatSelection3,
				minimumInputLength:0,
				width:'100%',
				dropdownCssClass:'bigdrop',
				dropdownAutoWidth:true,
				placeholder:"Choose an Associate",					
			}).select2('val','#associate#');
		});
    </script>
</cfoutput>