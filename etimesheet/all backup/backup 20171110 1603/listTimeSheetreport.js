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
				{'aTargets':[0],'sTitle':custno.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'13%'},
				{'aTargets':[1],'sTitle':custname.toUpperCase(),'mData':'custname','bSortable':true,'sWidth':'26%',
					'aoColumnDefs':[
					 {'mData': 'custno', 'aTargets':[0]}, //to specify column 0 to get the data at that column
					 {'mData': 'custname', 'aTargets':[1]}],
					'mRender':function(data,type,full){
						return '<a href="listTimesheetreportdetails.cfm?custno='+ full.custno +'&period='+monthselected+'&year='+yearselected+'">'+ full.custname +'</a>';
					}
					/*'mRender':function(data,type,row){
						return '<a href="listTimesheetreportdetails.cfm?custno=#custno#" target="_blank">#custname#</a>';
					}*/
				},
				
				
				{'aTargets':[2],'sTitle':placementcount.toUpperCase(),'mData':'placementcount','bSortable':true,'sWidth':'18%'},
				{'aTargets':[3],'sTitle':submittedcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.submittedcount+'';
				}
				},
				{'aTargets':[4],'sTitle':approvedcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,object){
					return ''+object.approvedcount+'';
					},
				},
                {'aTargets':[5],'sTitle':savedcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,object){
					return ''+object.savedcount+'';
					},
				},
                {'aTargets':[6],'sTitle':rejectedcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,object){
					return ''+object.rejectedcount+'';
					},
				},
                {'aTargets':[7],'sTitle':processedcount.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,object){
					return ''+object.processedcount+'';
					},
				},
                {'aTargets':[8],'sTitle':summary.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'25%',
				'mRender':function(data,type,full){
					return '<a target="_blank" href="timesheetstatus.cfm?custno='+ full.custno +'&period='+monthselected+'&year='+yearselected+'">Excel</a>';
					},
				}
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
					{"name":"method","value":"listTime"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"clientfrom","value":clientfrom},
					{"name":"clientto","value":clientto},
					{"name":"empfrom","value":empfrom},
					{"name":"empto","value":empto},
                    {"name":"reportyear","value":yearselected},
                    {"name":"reportmonth","value":monthselected}
				);
        	},
			'sAjaxSource':'/etimesheet/listTimesheetreport.cfc',
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