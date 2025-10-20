$(document).ready(function(){
	for( var iCount = 0; iCount < 3; iCount++){
		if(iCount == 0){
			var decimalValue = $('#pricedecpoint').val();
			var decimalControlId = $('#decimalControl');
			var addZero = "";
		}
		else if(iCount == 1){
			var decimalValue = $('#totalamtdecpoint').val();
			var decimalControlId = $('#decimalDiscount');
			var addZero = "";
		}
		else{
			var decimalValue = $('#totaldecpoint').val();
			var decimalControlId = $('#decimalTotal');
			var addZero = "";
		}
		for (var jCount = 0; jCount < decimalValue; jCount++) { 
			addZero = "0" + addZero ;
			decimalControlId.html('.'+addZero);
		}
		if (decimalValue == 0){
			decimalControlId.html('none');
		}
	}
		
	$('#GenerateRevision').change(function(){
		if(this.checked)
			$('#showList1').fadeIn('slow');
		else
			$('#showList1').fadeOut('slow');
	});
		
	$('#recompriceup').change(function(){
		if(this.checked)
			$('#showList2').fadeIn('slow');
		else
			$('#showList2').fadeOut('slow');
	});
		
	$('#tempSubmit').on('click',function(){
		$('#generalSetupform').submit();
	});
	
	$(document).on('click', '#tempReset', function() {
		window.location.href ='TransactionNew.cfm';			
	});
	
	$('#postinglist, #costinglist, #reportlist, #poslist').on('click',function(){
		$('div.tab-content>div.tab-pane.active').removeClass('active');
		$('ul.nav.nav-tabs>li.active').removeClass('active');
	});
			
	function activaTab(tab){
		$('.nav-tabs a[href="#' + tab + '"]').tab('show');
	};

		activaTab('transaction');
		activaTab('tax');
		$('tax').tab();
		
	$('[data-dismiss=modal] , #myModal').on('click',function(){
		$('#headerStick').show()
	})	
	
	
	$('#wpitemtax').on('change', function() { 
		/*alert("Warning !! Changing this may result in incorrect tax amount for your transactions. Consultant our support team :)");*/
		$('#headerStick').hide()
		$('#myModal').modal('show'); 
		
		
		if(this.checked)
			$('#itemTaxOnly').fadeIn('slow');
		else
			$('#itemTaxOnly').fadeOut('slow');
	});
	
	$('input').iCheck({
		radioClass: 'iradio_square-blue',
		increaseArea: '20%' 
	});
	
	$('input').on('ifChecked', function(event){
		if($(this).val() == 'fifo'){
			$('#fifoCalculation').fadeIn('slow');
		}
		else{
			$('#fifoCalculation').fadeOut('slow');
		}
	});

	$('[data-toggle="tab"]').on('click',function(){
		
		var tab_id = this.id
		
		if(tab_id == 'transactionMain'){
			$('#numberStyle').removeClass("active");
			$('#tax').addClass("active");
			$('#transaction_tabs a[href="#tax"]').tab('show')
			
		}
		else if(tab_id == 'referenceMain'){
			$('#tax').removeClass("active");
			$('#numberStyle').addClass("active");
			$('#referenceNumber a[href="#numberStyle"]').tab('show')
			
		}
		else { 
			$('[data-toggle="tab"]').removeClass("active");
		}
	
	});
	
	$('#printapproveamt').autoNumeric('init',
	 	{
			vMin: '0.00', 
			mDec: '2',
		 	wEmpty: 'zero',
		 }
	 );  

	 $('#pricedecpoint,#totalamtdecpoint,#totaldecpoint,#desplimit,#commentlimit,#termlimit,#disclimit,#memberpointamt').autoNumeric('init',
	 	{
			vMin: '0', 
			mDec: '0',
		 	wEmpty: 'zero',
		 }
	 );  
	
	$('#pricedecpoint,#totalamtdecpoint,#totaldecpoint').on('keyup', function(e){

		var codepattern = new RegExp(/^\d*$/g);
		var decimalValue = $(this).val();
		var decimalId = this.id;
		if(decimalId=="pricedecpoint"){
			var decimalControlId = $('#decimalControl');
		}
		else if(decimalId=="totalamtdecpoint"){
			var decimalControlId = $('#decimalDiscount');
		}
		else{
			var decimalControlId = $('#decimalTotal');
		}
		decimalControlId.html("");
		var addZero = "";		
		//
		 if(!decimalValue.match(codepattern) || decimalValue > 10 ){
			 $(this).val("");
		 }
		 else{
			for (i = 0; i < decimalValue; i++) {	
				addZero = "0" + addZero ;
				decimalControlId.html('.'+addZero);
			}		
			if (decimalValue == 0) {
				decimalControlId.html('none');
			}
		 }
		
	});	
}); 
		
		