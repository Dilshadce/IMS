// JavaScript Document
$(document).ready(function(e) {	
	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'NO','mData':'type','bSortable':true,'sWidth':'5%'},
				{'aTargets':[1],'sTitle':'TRANSACTION','mData':'type','bSortable':true,'sWidth':'10%'},
				{'aTargets':[2],'sTitle':'TITLE','mData':'display_name','bSortable':true,'sWidth':'15%'},
				{'aTargets':[3],'sTitle':'FILE NAME','mData':'file_name','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'TYPE','mData':'format','bSortable':true,'sWidth':'7%'},
				{'aTargets':[5],'sTitle':'UPDATED ON','mData':'updated_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'UPDATED BY','mData':'updated_by','bSortable':true,'sWidth':'10%'},
				{
					'aTargets':[7],
					'sTitle':'ACTION',
					'mData':'type',
					'bSortable':false,
					'sWidth':'7%',
					'mRender':function(data,type,row){
						return 	'';
					}
				}
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
					{"name":"dts","value":dts}
				);
        	},
			'sAjaxSource':'addBillFormat.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', 'Search')
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