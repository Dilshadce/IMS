// JavaScript Document
$(document).ready(function(e) {

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				
				{'aTargets':[0],'sTitle':'ID','mData':'id','bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'CONTACT NAME','mData':'contactname','bSortable':true,'sWidth':'20%'},
				{
					'aTargets':[2],
					'sTitle':'ACCOUNT NAME',
					'mData':'accno',
					'bSortable':true,
					'sWidth':'20%',
					'mRender':function(data,type,object){
						return object.accno+' '+object.arname;
					}
				},
				{'aTargets':[3],'sTitle':'NAME 2','mData':'arname','bVisible':false},
				{'aTargets':[4],'sTitle':'PHONE','mData':'c_phone','bSortable':true,'sWidth':'15%'},
				{'aTargets':[5],'sTitle':'MOBILE','mData':'c_mobile','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'EMAIL','mData':'c_email','bSortable':true,'sWidth':'20%'},
				{
					
					'aTargets':[7],
					'sTitle':'VIEW',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
							return 	'<span class="glyphicon glyphicon-eye-open btn btn-link" title="VIEW" '+
									'onclick="window.open(\'\/contactview\/index.cfm?id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';
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
					{"name":"method","value":"listContactView"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"H1016","value":H1016},
					{"name":"acccreate","value":acccreate}
					
				);
        	},
			'sAjaxSource':'/contactview/ContactDetail.cfc',
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