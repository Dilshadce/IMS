// JavaScript Document
$(document).ready(function(e) {
	
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'NO'.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'10%',
                'mRender':function(data,type,object){
						return ''+object.CurrentRow+'';
					}
                },
				{'aTargets':[1],'sTitle':'EMP NO','mData':'empno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'NAME','mData':'empname','bSortable':true,'sWidth':'15%'},				
				{'aTargets':[3],'sTitle':'PLACEMENT NO.','mData':'placementno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'CLIENT NO','mData':'custno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[5],'sTitle':'CLIENT NAME','mData':'custname','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'SUBMITTED ON','mData':'created_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[7],'sTitle':'APPROVED ON','mData':'updated_on','bSortable':true,'sWidth':'15%'},
                {'aTargets':[8],'sTitle':'VALIDATED ON','mData':'validated_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[9],'sTitle':'MONTH','mData':'tmonth','bSortable':true,'sWidth':'15%'},
				{'aTargets':[10],'sTitle':'DATE START','mData':'start','bSortable':true,'sWidth':'15%'},
				{'aTargets':[11],'sTitle':'DATE END','mData':'end','bSortable':true,'sWidth':'15%'},
				{'aTargets':[12],'sTitle':'TIMESHEET','mData':'empno','bSortable':true,'sWidth':'15%',
				'mRender':function(data,type,full){
						return '<span class="glyphicon glyphicon-search btn btn-link" title="VIEW" '+ 
									'onclick="window.open(\'\/latest\/customization\/manpower_i\/mpapproval\/TimesheetApprovalView.cfm?pno='+escape(encodeURIComponent(full.placementno))+'&datestart='+escape(encodeURIComponent(full.start))+'&dateend='+escape(encodeURIComponent(full.end))+'&tmonth='+escape(encodeURIComponent(full.tmonth1))+'\',\'_blank\');"> </span>';
					}
				
				},
				{'aTargets':[13],'sTitle':'HM REMARKS','mData':'MGMTREMARKS','bSortable':true,'sWidth':'15%'},
				{'aTargets':[14],'sTitle':'MP REMARKS','mData':'mpremarks','bSortable':true,'sWidth':'15%',}
        	],
			'bAutoWidth':false,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listAccount"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"dsname","value":dsname},
					{"name":"targetTable","value":targetTable},
					{"name":"huserid","value":huserid}
				);
        	},
			'sAjaxSource':'/latest/customization/manpower_i/mpapproval/ProcessTimesheetRecord.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', 'SEARCH')
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