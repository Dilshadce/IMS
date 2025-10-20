// JavaScript Document
$(document).ready(function(e) {

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'id','bSortable':true,'bVisible':true,'sWidth':'10%'},
				{'aTargets':[1],'sTitle':'EMAIL SUBJECT','mData':'subject','bSortable':true,'sWidth':'75%'},
				{'aTargets':[2],'sTitle':'CAMID','mData':'camid','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{
					'aTargets':[3],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'15%',
					'mRender':function(data,type,row){						
						return 	'<span class="glyphicon glyphicon-send btn btn-link" title="CHOOSE EMAIL TO SEND" '+
								'onclick="window.open(\'\/account\/sendemail.cfm?&camid='+row.camid+'&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-file btn btn-link" title="EMAIL CONTENT" '+
								'onclick="window.open(\'\/account\/emailProfile.cfm?&type=Update&camid='+row.camid+'&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/account\/emailsave.cfm?type=delete&camid='+row.camid+'&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
								
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
					{"name":"method","value":"listCampaign"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"camid","value":camid}
				);
        	},
			'sAjaxSource':'/account/EmailMarketing.cfc',
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