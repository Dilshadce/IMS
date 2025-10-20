// JavaScript Document
$(document).ready(function(e) {

	var	redirect = 'productProcess.cfm';

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'itemno','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'ITEM NO','mData':'itemno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'DESCRIPTION','mData':'desp','bSortable':true,'sWidth':'15%'},
				{'aTargets':[3],'sTitle':'CATEGORY','mData':'category','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'GROUP','mData':'wos_group','bSortable':true,'sWidth':'15%'},
				{'aTargets':[5],'sTitle':'UNIT','mData':'unit','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'SELLING PRICE','mData':'price','bSortable':true,'sWidth':'15%'},
				{
					
					'aTargets':[7],
					'sTitle':'ACTION',
					'mData':'itemno',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						if(Dedit =='T' && Ddelete =='T'){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/product\/product.cfm?&action=Update&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/product\/productProcess.cfm?action=delete&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
							else if(Dedit =='T' && Ddelete =='F'){
								return '<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/product\/product.cfm?&action=Update&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
							else if(Dedit =='F' && Ddelete =='T'){
								return '<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/product\/productProcess.cfm?action=delete&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
							else{
								return "";
							}
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
					{"name":"method","value":"listProduct"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/product/productProfile.cfc',
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