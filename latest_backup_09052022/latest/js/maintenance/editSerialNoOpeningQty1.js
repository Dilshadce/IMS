// JavaScript Document
$(document).ready(function(e) {
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'SERIAL NO','mData':'serialno','bSortable':true,'sWidth':'25%'},
				{'aTargets':[1],'sTitle':'LOCATION','mData':'location','bSortable':true,'sWidth':'20%'},
				{'aTargets':[2],'sTitle':'DATE','mData':'wos_date','bSortable':true,'sWidth':'20%'},
				{'aTargets':[3],'sTitle':'ITEM NO','mData':'itemno','bSortable':true,'sWidth':'20%','bVisible':false},
        		{
					'aTargets':[4],
					'sTitle':'ACTION',
					'mData':'serialno',
					'bSortable':false,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'\/latest\/maintenance\/addSerialNo.cfm?action=update&serialno='+escape(encodeURIComponent(data))+'&location='+escape(encodeURIComponent(row.location))+'&itemno='+encodeURIComponent(row.itemno)+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this serial no?\')){window.open(\'\/latest\/maintenance\/addSerialNoProcess.cfm?action=delete&serialno='+escape(encodeURIComponent(data))+'&location='+escape(encodeURIComponent(row.location))+'&itemno='+encodeURIComponent(row.itemno)+'\',\'_self\');}"></span>';
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
					{"name":"method","value":"listAccount"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"itemno","value":''+itemno+''},
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/latest/maintenance/editSerialNoOpeningQty1.cfc',
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