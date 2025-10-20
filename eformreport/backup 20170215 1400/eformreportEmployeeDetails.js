// JavaScript Document<!---created [15/1/2017, Alvin]--->
$(document).ready(function(e) {
	if(display =='T'){
		visibleC = true;
	}else{
		visibleC = false;
	}
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':empname.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'8%'},
				{'aTargets':[1],'sTitle':address1.toUpperCase(),'mData':'add1','bSortable':true,'sWidth':'13%'},
				{'aTargets':[2],'sTitle':address2.toUpperCase(),'mData':'add2','bSortable':true,'sWidth':'13%'},
				{'aTargets':[3],'sTitle':dob.toUpperCase(),'mData':'dbirth','bSortable':true,'sWidth':'8%'},
				{'aTargets':[4],'sTitle':gender.toUpperCase(),'mData':'sex','bSortable':true,'sWidth':'5%'},
				{'aTargets':[5],'sTitle':race.toUpperCase(),'mData':'race','bSortable':true,'sWidth':'5%'},
				{'aTargets':[6],'sTitle':origincountry.toUpperCase(),'mData':'Country_code_address','bSortable':true,'sWidth':'5%'},
				{'aTargets':[7],'sTitle':contactno.toUpperCase(),'mData':'phone','bSortable':true,'sWidth':'5%'},
				{'aTargets':[8],'sTitle':personalemail.toUpperCase(),'mData':'email','bSortable':true,'sWidth':'5%'},
				{'aTargets':[9],'sTitle':workemail.toUpperCase(),'mData':'workemail','bSortable':true,'sWidth':'5%'},
				{'aTargets':[10],'sTitle':maritalstatus.toUpperCase(),'mData':'mstatus','bSortable':true,'sWidth':'5%'},
				{'aTargets':[11],'sTitle':nricpassport.toUpperCase(),'mData':'nricn','bSortable':true,'sWidth':'5%'},
				{'aTargets':[12],'sTitle':passportexpiry.toUpperCase(),'mData':'passprt_to','bSortable':true,'sWidth':'5%'},
				{'aTargets':[13],'sTitle':secondpassport.toUpperCase(),'mData':'passport','bSortable':true,'sWidth':'5%'},
				{'aTargets':[14],'sTitle':highesteducation.toUpperCase(),'mData':'edu','bSortable':true,'sWidth':'5%'},
				{'aTargets':[15],'sTitle':nationality.toUpperCase(),'mData':'national','bSortable':true,'sWidth':'5%'},				
				{'aTargets':[16],'sTitle':emergencycontactperson.toUpperCase(),'mData':'econtact','bSortable':true,'sWidth':'5%'},
				{'aTargets':[17],'sTitle':emergencycontactno.toUpperCase(),'mData':'etelno','bSortable':true,'sWidth':'5%'},
				{'aTargets':[18],'sTitle':originalcountryadd1.toUpperCase(),'mData':'eadd1','bSortable':true,'sWidth':'5%'},
				{'aTargets':[19],'sTitle':originalcountryadd2.toUpperCase(),'mData':'eadd2','bSortable':true,'sWidth':'5%'}	
        	],
			'bAutoWidth':true,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listDetails"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"custno","value":custno}
				);
        	},
			'sAjaxSource':'/eformreport/eformreportEmployeeDetails.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', SEARCH)
        search_input.addClass('form-control input-small')
        search_input.css('width', '250px')
 
        // SEARCH CLEAR - Use an Icon
        var clear_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] a');
        clear_input.html('<i class="icon-remove-circle icon-large"></i>')
        clear_input.css('margin-left', '5px')
 
        // LENGTH - Inline-Form control
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_length] select');
        length_sel.addClass('form-control input-small')
        length_sel.css('width', '75px')
 
        // LENGTH - Info adjust location
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_info]');
        length_sel.css('margin-top', '18px')
});

// for second table display
$(document).ready(function(e) {
	if(display =='T'){
		visibleC = true;
	}else{
		visibleC = false;
	}
	var resultTable=$('#resultTable2')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':empname.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'8%'},
				{'aTargets':[1],'sTitle':taxno.toUpperCase(),'mData':'itaxno','bSortable':true,'sWidth':'8%'},
				{'aTargets':[2],'sTitle':taxbranch.toUpperCase(),'mData':'itaxbran','bSortable':true,'sWidth':'8%'},
				{'aTargets':[3],'sTitle':spouseworking.toUpperCase(),'mData':'itaxno','bSortable':true,'sWidth':'8%',
					'mRender':function(data,type,object){
					return ''+object.spousework+'';
					}
				},
				{'aTargets':[4],'sTitle':spousename.toUpperCase(),'mData':'sname','bSortable':true,'sWidth':'8%'},
				{'aTargets':[5],'sTitle':numberofchild.toUpperCase(),'mData':'numchild','bSortable':true,'sWidth':'8%'},
				{'aTargets':[6],'sTitle':childbelow18.toUpperCase(),'mData':'num_child','bSortable':true,'sWidth':'8%'},
				{'aTargets':[7],'sTitle':childstudy.toUpperCase(),'mData':'child_edu_m','bSortable':true,'sWidth':'8%'},
				{'aTargets':[8],'sTitle':childstudydiploma.toUpperCase(),'mData':'child_edu_f','bSortable':true,'sWidth':'8%'},
				{'aTargets':[9],'sTitle':disabledchild.toUpperCase(),'mData':'child_disable','bSortable':true,'sWidth':'8%'},
				{'aTargets':[10],'sTitle':disabledchildstudy.toUpperCase(),'mData':'child_edu_disable','bSortable':true,'sWidth':'8%'}
        	],
			'bAutoWidth':true,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listDetails"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"custno","value":custno}
				);
        	},
			'sAjaxSource':'/eformreport/eformreportEmployeeDetails.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', SEARCH)
        search_input.addClass('form-control input-small')
        search_input.css('width', '250px')
 
        // SEARCH CLEAR - Use an Icon
        var clear_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] a');
        clear_input.html('<i class="icon-remove-circle icon-large"></i>')
        clear_input.css('margin-left', '5px')
 
        // LENGTH - Inline-Form control
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_length] select');
        length_sel.addClass('form-control input-small')
        length_sel.css('width', '75px')
 
        // LENGTH - Info adjust location
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_info]');
        length_sel.css('margin-top', '18px')
});

//for third table display
$(document).ready(function(e) {
	if(display =='T'){
		visibleC = true;
	}else{
		visibleC = false;
	}
	var resultTable=$('#resultTable3')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':empname.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'8%'},
				{'aTargets':[1],'sTitle':epfno.toUpperCase(),'mData':'epfno','bSortable':true,'sWidth':'8%'},
				{'aTargets':[2],'sTitle':countrypub.toUpperCase(),'mData':'pbholiday','bSortable':true,'sWidth':'8%'},
				{'aTargets':[3],'sTitle':countryserve.toUpperCase(),'mData':'countryserve','bSortable':true,'sWidth':'8%'},
				{'aTargets':[4],'sTitle':hiringmanagername.toUpperCase(),'mData':'epfno','bSortable':true,'sWidth':'8%',
					'mRender':function(data,type,object){
					return ''+object.username+'';
					}
				},
				{'aTargets':[5],'sTitle':hiringmanageremail.toUpperCase(),'mData':'epfno','bSortable':true,'sWidth':'8%',
					'mRender':function(data,type,object){
					return ''+object.userid+'';
					}
				},
				{'aTargets':[6],'sTitle':employmentpassnno.toUpperCase(),'mData':'wpermit','bSortable':true,'sWidth':'8%'},
				{'aTargets':[7],'sTitle':employmentvalidfrom.toUpperCase(),'mData':'wp_from','bSortable':true,'sWidth':'8%'},
				{'aTargets':[8],'sTitle':employmentvalidto.toUpperCase(),'mData':'wp_to','bSortable':true,'sWidth':'8%'},
				{'aTargets':[9],'sTitle':bankname.toUpperCase(),'mData':'bankcode','bSortable':true,'sWidth':'8%'},
				{'aTargets':[10],'sTitle':bankaccountno.toUpperCase(),'mData':'bankaccno','bSortable':true,'sWidth':'8%'},
				{'aTargets':[11],'sTitle':bankbeneficialname.toUpperCase(),'mData':'bankbefname','bSortable':true,'sWidth':'8%'},
				{'aTargets':[12],'sTitle':workplacedepartment.toUpperCase(),'mData':'epfno','bSortable':true,'sWidth':'8%',
					'mRender':function(data,type,object){
					return ''+object.department+'';
					}
				},
				{'aTargets':[13],'sTitle':designation.toUpperCase(),'mData':'epfno','bSortable':true,'sWidth':'8%',
					'mRender':function(data,type,object){
					return ''+object.position+'';
					}
				}
        	],
			'bAutoWidth':true,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listDetails"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"custno","value":custno}
				);
        	},
			'sAjaxSource':'/eformreport/eformreportEmployeeDetails.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', SEARCH)
        search_input.addClass('form-control input-small')
        search_input.css('width', '250px')
 
        // SEARCH CLEAR - Use an Icon
        var clear_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] a');
        clear_input.html('<i class="icon-remove-circle icon-large"></i>')
        clear_input.css('margin-left', '5px')
 
        // LENGTH - Inline-Form control
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_length] select');
        length_sel.addClass('form-control input-small')
        length_sel.css('width', '75px')
 
        // LENGTH - Info adjust location
        var length_sel = datatable.closest('.dataTables_wrapper').find('div[id$=_info]');
        length_sel.css('margin-top', '18px')
});