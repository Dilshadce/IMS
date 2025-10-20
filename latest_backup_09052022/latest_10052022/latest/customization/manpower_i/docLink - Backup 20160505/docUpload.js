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
				{'aTargets':[0],'sTitle':"id".toUpperCase(),'mData':'id','bSortable':true,'sWidth':'10%'},
				{'aTargets':[1],'sTitle':fileName.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'20%'},
				{'aTargets':[2],'sTitle':desp.toUpperCase(),'mData':'desp','bSortable':true,'sWidth':'30%'},
				{'aTargets':[3],'sTitle':uploadedBy.toUpperCase(),'mData':'uploaded_by','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':uploadedOn.toUpperCase(),'mData':'uploaded_on','bSortable':true,'sWidth':'10%'},
				{
					'aTargets':[5],
					'sTitle':action.toUpperCase(),
					'mData':'id',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'20%',
					'mRender':function(data,type,row){
						return 	'<a class="glyphicon glyphicon-cloud-download btn btn-link"' + 'href="\/docUpload\/'+dts+'\/'+row.name+'"' + 'download> Download</a>' + 
						'<span class="glyphicon glyphicon-remove btn btn-link"' +'onclick="if(confirm(\'Are you sure you wish to delete this document?\\nDeleted doc cannot be recovered.\')){window.open(\'\/latest\/customization\/manpower_i\/docLink\/uploadDocProcess.cfm?action=delete&action2='+action2+'&id='+escape(encodeURIComponent(row.id))+'&id2='+id2+'&uuid=' + docUuid + '\',\'_self\');}"> Delete</span>';
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
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable},
					{"name":"docUuid","value":docUuid}
				);
        	},
			'sAjaxSource':'/latest/customization/manpower_i/docLink/docUpload.cfc',
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