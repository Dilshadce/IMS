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
				{'aTargets':[0],'sTitle':empno.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'10%'},
				{'aTargets':[1],'sTitle':empname.toUpperCase(),'mData':'empname','bSortable':true,'sWidth':'10%'},
				{'aTargets':[2],'sTitle':phone.toUpperCase(),'mData':'phone','bSortable':true,'sWidth':'10%'},
				{'aTargets':[3],'sTitle':email.toUpperCase(),'mData':'email','bSortable':true,'sWidth':'10%'},
				//{'aTargets':[4],'sTitle':timesheetstatus.toUpperCase(),'mData':'status','bSortable':true,'sWidth':'10%'},
                {'aTargets':[4],'sTitle':timesheetstatus.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.status+'';
				}
				},
				{'aTargets':[5],'sTitle':hmname.toUpperCase(),'mData':'hmname','bSortable':true,'sWidth':'10%'},
				{'aTargets':[6],'sTitle':hmemail.toUpperCase(),'mData':'hmemail','bSortable':true,'sWidth':'10%'},
				//{'aTargets':[7],'sTitle':submitdate.toUpperCase(),'mData':'submitdate','bSortable':true,'sWidth':'10%'},
                {'aTargets':[7],'sTitle':submitdate.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.submitdate+'';
				}
				},
				//{'aTargets':[8],'sTitle':updateddate.toUpperCase(),'mData':'updateddate','bSortable':true,'sWidth':'26%'},
                {'aTargets':[8],'sTitle':updateddate.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.updateddate+'';
				}
				},
				//{'aTargets':[9],'sTitle':timesheetperiod.toUpperCase(),'mData':'tmonth','bSortable':true,'sWidth':'15%'}
                {'aTargets':[9],'sTitle':timesheetperiod.toUpperCase(),'mData':'empno','bSortable':true,'sWidth':'19%',
				'mRender':function(data,type,object){
					return ''+object.tmonth+'';
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
					{"name":"custno", "value":custno},
					{"name":"targetTable","value":targetTable},
                    {"name":"monthselected", "value":monthselected},
                    {"name":"yearselected", "value":yearselected}
				);
        	},
			'sAjaxSource':'/etimesheet/listTimeSheetreportdetails.cfc',
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