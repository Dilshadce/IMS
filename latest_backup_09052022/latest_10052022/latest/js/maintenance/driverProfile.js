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
				{'aTargets':[0],'sTitle':driverno.toUpperCase(),'mData':'driverno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[1],'sTitle':name.toUpperCase(),'mData':'name','bSortable':true,'sWidth':'30%'},
				{'aTargets':[2],'sTitle':customerno.toUpperCase(),'mData':'customerno','bSortable':true,'sWidth':'10%'},
				{'aTargets':[3],'sTitle':'PHONE','mData':'phone','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':'HP','mData':'contact','bSortable':true,'sWidth':'10%'},
				
						{'aTargets':[5],'sTitle':"Joint Date",'mData':'expiredate','bSortable':true,'sWidth':'10%',
						"fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
							var currentdate = new Date(); 
							var datetime = (currentdate.getFullYear()-3)+"-"+ (currentdate.getMonth()+1)+"-"+currentdate.getDate();
							 if (sData < datetime) { $(nTd).css('color', 'red');}
							 else{$(nTd).css('color', 'green');} 
							 } 
						},
				{
					'aTargets':[6],
					'sTitle':action.toUpperCase(),
					'mData':'driverno',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'\/latest\/maintenance\/driver.cfm?action=update&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/latest\/maintenance\/driverProcess.cfm?action=delete&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
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
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/latest/maintenance/driverProfile.cfc',
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