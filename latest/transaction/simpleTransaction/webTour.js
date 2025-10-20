$(document).ready(function(e) {
	
	$(document).on('click', '#takeTour' , function () {
		
			var tour = new Tour({
				keyboard:false,
				storage:false,
				redirect: function(){
					document.location.href = '/latest/transaction/simpleTransaction2/simpleTransaction.cfm?action=+"#action#"+"&type=" + "#type#"';				
								 },
				steps: [
				  		  {
							orphan: true,
							title: "New To Simple Transaction ?",
							content: "Fear not! You'll be up and running in no time. <br/> Take this 2 minute step-by-step tour.",
							backdrop: true, 
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',
						  },
						  {
							element: "#Step1", 
							title: "First",
							content: "Please select a [" + target + "]",
							backdrop: true ,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',
							onNext: function (tour) {
								
								$('#create').prop('disabled', true);
								},
						   },
						   {
							element:"#Step2", 
							title: "Default Running Number",
							content: "Do you know you can insert this manually too ? Press [Next]",
							placement:"bottom",
							backdrop: true ,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',
						  },
						   {
							element: "#Step3", 
							title: "Here !!",
							content: "Select the first option [Ref No Set] and click [Next]",
							placement:"left",
							backdrop: true,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" disabled data-role="next">Next &raquo;</button></div></div></div>',
						  },
						  {
							element: "#Step2", 
							title: "There You Go",
							content: "Now.. You can type in the number manually.",
							placement:"bottom",
							backdrop: true,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" disabled data-role="next">Next &raquo;</button></div></div></div>',
						  },
						  { /*Currency*/
							element: "#Step4", 
							title: "Using Multi Currency ?",
							content: "Select any currency other than your local currency",
							placement:"bottom",
							backdrop: true 	,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',
						  },
						   { /*Currency*/
							element: "#Step5", 
							title: "Hold It Right There !",
							content:"You need to key in the currency rate over here. <br />E.g 3.80 (1 USD equals 3.80 MYR)" ,
							placement: "bottom",
							backdrop: true ,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',				
						  },
						   {
							element: "#1",
							title: "Bravo !!",
							content: "Easy right? Now let's move on to second part. <br/>Select an Item or a Service and fill in the details (e.g quantity,price)",
							placement:"top",
							backdrop: true,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',	
						  },
						   {
							element: "#Step6", 
							title: "Need Further Discount ?",
							content: "Here You Go !! <br> You can have multiple discount rate(s) combined together.",
							placement: "top",
							backdrop: true,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',	
						  },
						   {
							element: "#Step7", 
							title: "Opsss..Seem Like We Are Missing Something",
							content: "You can type in <strong>Term and Conditions</strong> here.",
							placement: "top",
							backdrop: true,
							template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><div class="popover-navigation"><div class="btn-group col-sm-12" style="padding-bottom:10px;"><button class="btn btn-sm btn-default col-sm-6" data-role="prev">&laquo; Prev</button><button class="btn btn-sm btn-default col-sm-6" data-role="next">Next &raquo;</button></div></div></div>',
						  },
						   {
							element: "#finalStep",
							title: "Hurrayy Simple Right ?",
							content: "This is a tutorial so we have disabled the [Create] button. <br />Click [End Tour] and start creating real transaction(s)",
							placement: "top",
							backdrop: true
							}
				]
			});
						tour.init();// Initialize the tour
						tour.start();// Start the tour		
		});	
			
			$(document).on('keyup', '#refno' , function () {
					
					if( $('#refno').val().length != 0)
						{
						$('button.btn-default[data-role=next]').prop("disabled", false)
						}
					else {
						$('button.btn-default[data-role=next]').prop("disabled", true)
						
						}
			});
			
			$(document).on('change', '#RefNoSet' , function () {
					
					if( $('#RefNoSet option:selected').text() == 'Ref No Set')
						{
						$('button.btn-default[data-role=next]').prop("disabled", false)
						}
					else {
						$('button.btn-default[data-role=next]').prop("disabled", true)
						
						}
			});
			
			$(document).on('click', 'button.btn-default[data-role=end]', function() {
  				parent.document.location.href = '/latest/transaction/simpleTransaction2/simpleTransaction.cfm?action=' + action +'&type='+ type;
			});
			
	 }); 