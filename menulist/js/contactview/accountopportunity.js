// JavaScript Document
$(document).ready(function(e) {

	var resultTable1=$('#resultTable1')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'id','bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'OPPORTUNITY TYPE','mData':'type','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'OPPORTUNITY NAME','mData':'opportunityname','bSortable':true,'sWidth':'15%'},
				{
					'aTargets':[3],
					'sTitle':'STAGE/POSSIBILITY',
					'mData':'stage',
					'bSortable':true,
					'sWidth':'15%',
					'mRender':function(data,type,object){
						return object.stage+' / '+object.posibility;
					}
				},
				{'aTargets':[4],'sTitle':'DATE/TIME OPENED','mData':'duration','bSearchable':false,'bSortable':false,'sWidth':'10%'},
				{'aTargets':[5],'sTitle':'CLOSE DATE','mData':'closedate','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'AMOUNT','mData':'amount','bSortable':true,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':'OWNER','mData':'owner','bSortable':true,'sWidth':'10%'},
				{
					
					'aTargets':[8],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
									'onclick="window.open(\'\/opportunity\/opportunity.cfm?&action=Update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
									'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
									'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/opportunity\/opportunityProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
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
					{"name":"method","value":"listOpp"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"accno","value":''+accno+''}
				);
        	},
			'sAjaxSource':'/contactview/accountopportunity.cfc',
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