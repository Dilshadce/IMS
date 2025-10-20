// JavaScript Document

$(document).ready(function(e) {
	
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[5, 10, 15, 20, -1], [5, 10, 15, 20, 'All']],
            'aaSorting':[[5, 'desc']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'NO'.toUpperCase(),'mData':'placementno','bSortable':false,'sWidth':'7%',
                'mRender':function(data,type,object){
						return ''+object.CurrentRow+'';
					}
                },
				{'aTargets':[1],'sTitle':'PLACEMENT','mData':'placementno','bSortable':true,'sWidth':'19%'},
				{'aTargets':[2],'sTitle':'NAME','mData':'empname','bSortable':true,'sWidth':'15%'},				
				{'aTargets':[3],'sTitle':'LEAVE','mData':'leavetype','bSortable':true,'sWidth':'12%'},
				{'aTargets':[4],'sTitle':'DAYS','mData':'days','bSortable':true,'sWidth':'12%'},
				{'aTargets':[5],'sTitle':'START DATE','mData':'startdate','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'START TIME','mData':'startampm','bSortable':false,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':'END DATE','mData':'enddate','bSortable':true,'sWidth':'15%'},
				{'aTargets':[8],'sTitle':'END TIME','mData':'endampm','bSortable':false,'sWidth':'10%'},
				{'aTargets':[9],'sTitle':'STATUS','mData':'status','bSortable':true,'sWidth':'15%'},
				{'aTargets':[10],'sTitle':'REMARKS','mData':'remarks','bSortable':false,'sWidth':'15%'},
				{'aTargets':[11],'sTitle':'HM REMARKS','mData':'mgmtremarks','bSortable':false,'sWidth':'15%'},
				{'aTargets':[12],'sTitle':'DOCUMENT','mData':'placementno','bSortable':false,'sWidth':'15%',
				'mRender':function(data,type,full){
                    if(full.signdoc != ""){
                        return '<a href="/eleave/getitem.cfm?item='+full.signdoc+'" target="_blank">'+
                            '<span class="glyphicon glyphicon-search btn btn-link" title="VIEW">VIEW</span></a>';
                    }
                    else {
                        return '';
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
					{"name":"method","value":"listAccount"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":dts},
					{"name":"dsname","value":dsname},
					{"name":"targetTable","value":targetTable},
					{"name":"hrootpath","value":hrootpath}
				);
        	},
			'sAjaxSource':'/eleave/eleavereport.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		var datatable = $('.dataTable');
        // SEARCH - Add the placeholder for Search and Turn this into in-line formcontrol
        var search_input = datatable.closest('.dataTables_wrapper').find('div[id$=_filter] input');
        search_input.attr('placeholder', 'SEARCH')
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