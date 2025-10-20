// JavaScript Document
$(document).ready(function(e) {
	var HuserID = userID;
	var firstFive = HuserID.substring(0,5); 
	if(firstFive == 'ultra'){
		visibleC = true;
	}else{
		visibleC = false;	
	}
	if(gotocolumn == '1' || firstFive == 'ultra'){
		visibleC = true;
	}else{
		visibleC = false;
	}	
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{
					'aTargets':[0],
					'sTitle':companyid.toUpperCase(),
					'mData':'userbranch',
					'bSortable':true,
					'sWidth':'10%',
					'mRender':function(data,ftype,row){
						return '<a href="/latest/generalSetup/userMaintenance/userAdministration2.cfm?comid='+escape(encodeURIComponent(data))+'",target="_self">'+data+'</a>';
					}
				},
				{'aTargets':[1],'sTitle':companyname.toUpperCase(),'mData':'compro','bSortable':true,'sWidth':'20%'},
				{'aTargets':[2],'sTitle':lastclosingdate.toUpperCase(),'mData':'lastaccyear','bSortable':true,'sWidth':'12%'},
				{'aTargets':[3],'sTitle':period.toUpperCase(),'mData':'period','bSortable':true,'sWidth':'5%'},
				{'aTargets':[4],'sTitle':remark.toUpperCase(),'mData':'remark','bSortable':true,'bVisible':visibleC,'sWidth':'5%'},
				{
					'aTargets':[5],
					'sTitle':action.toUpperCase(),
					'mData':'userbranch',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'5%',
					'mRender':function(data,type,row){
							return 	'<span class="glyphicon glyphicon-plane btn btn-link" '+
									'onclick="if(confirm(\'Are you sure you want to go to '+data+' ?\')){window.open(\'\/latest\/generalSetup\/userMaintenance\/GOTO.cfm?comid='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';	
					}
				}
				
        	],
			'bAutoWidth':true,
			'bFilter':true,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			
			/*Overwrite default display*/
			'oLanguage': {
      			'sInfoFiltered': ''
    		},
			
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listAccount"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"userGroup","value":''+userGroup+''},
					{"name":"userID","value":''+userID+''},
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/latest/generalSetup/userMaintenance/userAdministration.cfc',
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