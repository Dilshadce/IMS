// JavaScript Document
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
				{'aTargets':[0],'sTitle':empno.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'13%'},
				{'aTargets':[1],'sTitle':empname.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'26%',
				'aoColumnDefs':[
					{'mData': 'empno', 'aTargets':[0]},
					{'mData': 'name', 'aTargets':[1]}],
					'mRender':function(data,type,full){
						return '<a href="eformreportEmployeeDetails.cfm?empno='+full.empno+'&name='+full.name+'">'+ full.name +'</a>';
					}
				},
				{'aTargets':[2],'sTitle':emailsent.toUpperCase(),'mData':'emailsent','bSortable':true,'sWidth':'13%'},
				{'aTargets':[3],'sTitle':eformupdated.toUpperCase(),'mData':'requested_on','bSortable':true,'sWidth':'19%'},
				{'aTargets':[4],'sTitle':pbupdated.toUpperCase(),'mData':'dbcandupdate','bSortable':true,'sWidth':'13%'}
				/*{'aTargets':[1],
					'sTitle':empname.toUpperCase(),
					'mData':'custname',
					'bSortable':true,
					'sWidth':'26%',
					'aoColumnDefs':[
					 {'mData': 'custno', 'aTargets':[0]}, //to specify column 0 to get the data at that column
					 {'mData': 'custname', 'aTargets':[1]}],
					'mRender':function(data,type,full){
						return '<a href="listTimesheetreportdetails.cfm?custno='+ full.custno +'">'+ full.custname +'</a>';
					}
					/*'mRender':function(data,type,row){
						return '<a href="listTimesheetreportdetails.cfm?custno=#custno#" target="_blank">#custname#</a>';
					}
				},
				
				
				{'aTargets':[2],'sTitle':placementcount.toUpperCase(),'mData':'placementcount','bSortable':true,'sWidth':'18%'},
				{'aTargets':[3],'sTitle':recordcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.validatecount+'';
				}
				},
				{'aTargets':[4],'sTitle':approvecount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,object){
					return ''+object.approvecount+'';
					},
				}*/
				/*{ for action column - email, edit, delete
					'aTargets':[4],
					'sTitle':action.toUpperCase(),
					'mData':'userID',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-envelope btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to reset password for this hiring manager?\')){window.open(\'\/latest\/customization\/manpower_i\/hrMgrProfile\/resetEmail.cfm?action=update&id='+escape(encodeURIComponent(row.id))+'\',\'_self\');}"></span>'+
								'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'\/latest\/customization\/manpower_i\/hrMgrProfile\/hrMgrDetail.cfm?action=update&id='+escape(encodeURIComponent(row.id))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this hiring manager?\')){window.open(\'\/latest\/customization\/manpower_i\/hrMgrProfile\/hrMgrProcess.cfm?action=delete&id='+escape(encodeURIComponent(row.id))+'\',\'_self\');}"></span>';
					}
				}*/ 
        	],
			'bAutoWidth':true,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listEmp"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"empnoform","value":empnoform}/*,
					{"name":"clientto","value":clientto},
					{"name":"empfrom","value":empfrom},
					{"name":"empto","value":empto}*/
				);
        	},
			'sAjaxSource':'/eformreport/eformreportEmployee.cfc',
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