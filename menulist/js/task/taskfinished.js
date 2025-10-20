// JavaScript Document
$(document).ready(function(e) {

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'TASK ID','mData':'taskid','bSortable':true,'sWidth':'10%'},
				{'aTargets':[1],'sTitle':'TASK NAME','mData':'taskname','bSortable':true,'sWidth':'10%'},
				{'aTargets':[2],'sTitle':'FOR','mData':'comname','bSortable':true,'sWidth':'10%'},
				{'aTargets':[3],'sTitle':'DATE ASSIGNED','mData':'dateassign','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':'DATE NEEDED','mData':'eft','bSortable':true,'sWidth':'10%'},
				{'aTargets':[5],'sTitle':'ASSIGNED TO','mData':'assignto','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'ASSIGNED BY','mData':'assignby','bSortable':true,'sWidth':'15%'},
				{'aTargets':[7],'sTitle':'STATUS','mData':'status','bSortable':true,'sWidth':'10%'},
        	],
			'bAutoWidth':false,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listTask"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"authuser","value":''+authuser+''}
				);
        	},
			'sAjaxSource':'/task/taskfinished.cfc',
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