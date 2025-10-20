// JavaScript Document
$(document).ready(function(e) {

	var	redirect = 'opportunityProcess.cfm';

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				
				{'aTargets':[0],'sTitle':'ID','mData':'id','bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'OPPORTUNITY OWNER','mData':'owner','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'AGENT','mData':'lagent','bSortable':true,'sWidth':'15%'},
				{'aTargets':[3],'sTitle':'OPPORTUNITY NAME','mData':'opportunityname','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'PHONE','mData':'phone','bSortable':true,'sWidth':'10%'},
				{'aTargets':[5],'sTitle':'OPPORTUNITY DATE','mData':'created_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'STAGE','mData':'stage','bSortable':true,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':'POSSIBILITY','mData':'posibility','bSortable':true,'sWidth':'10%'},
				{
					
					'aTargets':[8],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						if(Dedit =='T' && Ddelete =='T'){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
									'onclick="window.open(\'\/opportunity\/opportunity.cfm?&action=Update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
									'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
									'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/opportunity\/opportunityProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
						else if(Dedit =='T' && Ddelete =='F'){
							return '<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
									'onclick="window.open(\'\/opportunity\/opportunity.cfm?&action=Update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
						else if(Dedit =='F' && Ddelete =='T'){
							return '<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
									'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/opportunity\/opportunityProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
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
					{"name":"method","value":"listOpportunity"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"H1253","value":H1253},
					{"name":"acccreate","value":acccreate}
					
				);
        	},
			'sAjaxSource':'/opportunity/opportunityProfile.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		//.fnSort([[1,'desc']]);
		
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