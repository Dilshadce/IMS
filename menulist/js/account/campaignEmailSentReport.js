// JavaScript Document
$(document).ready(function(e) {

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'id','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'CAMPAIGN NAME','mData':'camname','bSortable':true,'sWidth':'20%'},
				{'aTargets':[2],'sTitle':'CAMPAIGN DESP','mData':'camdesp','bSortable':true,'sWidth':'20%'},
				{'aTargets':[3],'sTitle':'CAMPAIGN FROM','mData':'camfrom','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'CAMPAIGN TO','mData':'camto','bSortable':true,'sWidth':'15%'},
				{'aTargets':[5],'sTitle':'SELECTED EMAILS','mData':'semail','bSortable':false,'sWidth':'10%'},
				{'aTargets':[6],'sTitle':'EMAILS SENT','mData':'emails','bSortable':false,'sWidth':'10%'},
				{
					
					'aTargets':[7],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){						
						/*return 	'<span class="glyphicon glyphicon-eye-open btn btn-link" data-toggle="modal" data-target=".bs-example-modal-sm" '+
								'onclick="window.open(\'\/account\/emailmodal.cfm?&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';*/
						return 	'<span class="glyphicon glyphicon-eye-open btn btn-link" title="VIEW" data-toggle="modal" data-target=".bs-example-modal-sm" data-id="'+row.id+'" '+'onclick="Change('+row.id+');" ></span>';
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
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/account/campaignEmailSentReport.cfc',
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

function Change(id)
{
    $.ajax({
        url : 'emailmodal.cfm',
        data:{"id":id},
        type: 'GET',

        success: function(data){
            $('#emailmodal').html(data);
        }
    });
}
