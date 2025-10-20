// JavaScript Document

jQuery.noConflict();
(function($) {
  $(function() {

var keyPressed="";
var limit = 100;
$(document).ready(function(e) {
	$('#custno').select2({
		ajax:{
			type: 'POST',
			url:'simpleNew.cfc',
			dataType:'json',
			data:function(term,page){
				return{
					method:'listMatchedTargets',
					returnformat:'json',
					dts:dts,
					target:target,
					targetTable:targetTable,
					term:term,
					limit:limit,
					page:page-1
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
			var custno=$(element).val();
			if(custno!=''){
				$.ajax({
					type:'POST',
					url:'simpleNew.cfc',
					dataType:'json',
					data:{
						method:'getSelectedTarget',
						returnformat:'json',
						dts:dts,
						targetTable:targetTable,
						custno:custno
					}
				}).done(function(data){callback(data);});
			};
		},
		//minimumInputLength: 1,
		width: '100%',
		formatResult: function (data) {
        	return data.text;
    	},	
		allowClear: true,
		placeholder: "Click here to search.",	
	});
	
	$('#custno').change(function(e) {
		var custno=$('#custno').select2('val');
		var targetTable=$("#targetTable").val();
		if (custno=='createNewTarget'){
			$("#target_div").css("display","none");
			$("#create_target_div").css("display","block");
		}else{
			var dataString="action=getTargetDetail&targetTable="+targetTable+"&custno="+custno;
			$.ajax({
				type:"POST",
				url:"simpleNewAjax.cfm",
				data:dataString,
				dataType:"json",
				cache:false,
				success: function(result){
					var custinfo="";				
					
					if(result.ADD1!=""){
						custinfo=custinfo+result.ADD1+"<br />";
					};
					if(result.ADD2!=""){
						custinfo=custinfo+result.ADD2+"<br />";
					};
					if(result.ADD3!=""){
						custinfo=custinfo+result.ADD3+"<br />";
					};
					if(result.ADD4!=""){
						custinfo=custinfo+result.ADD4+"<br />";
					};
					if(result.COUNTRY!=" "){
						custinfo=custinfo+result.COUNTRY+"<br />";
					};
					if(result.ATTN!=""){
						custinfo=custinfo+"Attn: "+result.ATTN+"<br />";
					};										
					if(custinfo==''){
						custinfo='<b>Click to add address.</b>';
					};

					
					$('#custinfo').html(custinfo);
					//$('#term').val(result.TERM);
					$("#currcode").val(result.CURRCODE);
					$("#currrate").val(result.CURRRATE);
				},
				error: function(jqXHR,textStatus,errorThrown){
					alert(errorThrown);
				}
			});
		};
    });
	
		
	function formatResult(result){
	return result.itemno+' - '+result.desp; 
	};
	function formatSelection(result){
		return result.itemno+' - '+result.desp; 
	};


	$(document).ready(function(e) {
	
	$('#expressservicelist').on("change",function(e){bluradditem(e.val);});
	
	$('.itemno').select2({
		ajax:{
			type: 'POST',
			url:'simpleNew.cfc',
			dataType:'json',
			data:function(term,page){
				return{
					method:'listitem',
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
					url:'simpleNew.cfc',
					dataType:'json',
					data:{
						method:'getSelecteditem',
						returnformat:'json',
						dts:dts,
						value:value,
					},
				}).done(function(data){callback(data);});
			};
		},
		formatResult:formatResult,
		formatSelection:formatSelection,
		minimumInputLength:0,
		width:'300',
		dropdownCssClass:'bigdrop',
		dropdownAutoWidth:true,
	}).select2('val','test');
	
	<!--- $("#focus_btn").click(function () { $("#expressservicelist").select2("open"); }); --->
	<!---$('#expressservicelist').select2('open');--->
	});
	
	
	
	
	
});

  });
})(jQuery);