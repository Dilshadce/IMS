<cfoutput>    
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		
		function formatResult(result){
			return result.userID + " - " + result.userName; 
		};
		
		function formatSelection(result){
			return result.userID + " - " + result.userName; 
		};
		
		function formatResult2(result){
			return result.userName + " - " + result.userEmail; 
		};
		
		function formatSelection2(result){
			return result.userName + " - " + result.userEmail; 
		};
		
        /*Added by Nieo 20171115 1135*/
        function formatResultPS(result){
			return result.priceID + " - " + result.priceName; 
		};
		
		function formatSelectionPS(result){
			return result.priceID + " - " + result.priceName; 
		};
        /*Added by Nieo 20171115 1135*/
		
		jQuery.noConflict();
		(function($){
  			jQuery(document).ready(function($) {
				$('.hrMgrFilter').select2({
					ajax:{
						type: 'POST',
						url:'filterHmUser.cfc',
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
								url:'filterHmUser.cfc',
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
					width:'80%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#hrMgr#');
				
				$('.mpPicFilter').select2({
					ajax:{
						type: 'POST',
						url:'filterUser.cfc',
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
								url:'filterUser.cfc',
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
					width:'80%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#mpPIC#');
				
				$('.mpPicFilter2').select2({
					ajax:{
						type: 'POST',
						url:'filterUser.cfc',
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
								url:'filterUser.cfc',
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
					width:'80%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#mpPic2#');
				
				$('.mpPicSpFilter').select2({
					ajax:{
						type: 'POST',
						url:'filterUser.cfc',
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
								url:'filterUser.cfc',
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
					width:'80%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an User ID",					
				}).select2('val','#mpPicSp#');
                
                /*Added by Nieo 20171115 1135*/
                $('.mpPriceFilter').select2({
					ajax:{
						type: 'POST',
						url:'filterPriceStructure.cfc',
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
								url:'filterPriceStructure.cfc',
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
					formatResult:formatResultPS,
					formatSelection:formatSelectionPS,
					minimumInputLength:0,
					width:'40%',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose an Price Structure",
                    allowClear: "true",
				}).select2('val','#pm#');
                /*Added by Nieo 20171115 1135*/
			});
		})(jQuery);
    </script>
</cfoutput>