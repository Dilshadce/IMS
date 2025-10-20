$(document).ready(function(e) {	
	$(".mhover").tooltip({
		delay: { show: 300, hide: 0 },
		placement:"top",
		title: function(){
					var tooltipsID = this.id	
					var returnresult = ""	
					$.ajax({
						type:'POST',
						async:false,
						url:'/../../latest/tooltip/tooltip.cfm',
						dataType:'HTML',
						data:'tool='+tooltipsID,
						cache:false,
						success:function(result){								
							returnresult = result
							
						},
						error: function(jqXHR,textStatus,errorThrown){
							alert(errorThrown);
						}  	
					});
					 return returnresult
				}
	});
});	
		
	 
	
		
	
	

	



