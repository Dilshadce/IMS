// JavaScript Document
$(document).ready(function(e) {

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'username','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'USER NAME','mData':'username','bSortable':true,'sWidth':'43%'},
				{'aTargets':[2],'sTitle':'LAST LOGIN TIME','mData':'userLogTime','bSortable':true,'sWidth':'42%'},			
				{
					
					'aTargets':[3],
					'sTitle':'VIEW LOG',
					'mData':'username',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'15%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-list-alt btn btn-link" title="View Log" '+
									'onclick="window.open(\'\/report\/singleusageProfile.cfm?&username='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';
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
					{"name":"method","value":"listUsage"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"acccreate","value":acccreate}
				);
        	},
			'sAjaxSource':'/report/usageProfile.cfc',
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


function Change(username)
{
    $.ajax({
        url : 'trackmodal.cfm',
        data:{"username":username},
        type: 'GET',

        success: function(data){
            $('#trackmodal').html(data);
        }
    });
}