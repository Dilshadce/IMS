// JavaScript Document
$(document).ready(function(e) {
	
	if(Dsearch =='T'){
		Dsearch = true;
	}else{
		Dsearch = false;
	}

	var	redirect = 'enduserProcess.cfm';

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'driverno','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'END USER NO','mData':'driverno','bSortable':true,'sWidth':'13%'},
				{
					'aTargets':[2],
					'sTitle':'NAME',
					'mData':'name',
					'bSortable':true,
					'sWidth':'14%',
					'mRender':function(data,type,object){
						return object.name+' '+object.name2;
					}
				},
				{'aTargets':[3],'sTitle':'ATTENTION','mData':'attn','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':'CUSTOMER NO','mData':'customerno','bSortable':true,'sWidth':'13%'},
				{
					'aTargets':[5],
					'sTitle':'ADDRESS',
					'mData':'add1',
					'bSortable':true,
					'sWidth':'15%',
					'mRender':function(data,type,object){
						var address='';
						if(object.add1!=''){
							address=address+object.add1+'<br />';
						}
						if(object.add2!=''){
							address=address+object.add2+'<br />';
						}
						if(object.add3!=''){
							address=address+object.add3+'<br />';
						}
						if(address!=''){
							address=address.substring(0, address.length-6)
						}
						return address;
					}
				},
				{'aTargets':[6],'sTitle':'CONTACT','mData':'contact','bSortable':true,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':'EMAIL','mData':'e_mail','bSortable':true,'sWidth':'15%'},
				{
					
					'aTargets':[8],
					'sTitle':'ACTION',
					'mData':'driverno',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						if(Dedit =='T' && Ddelete =='T'){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/enduser\/enduser.cfm?&action=Update&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/enduser\/enduserProcess.cfm?action=delete&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
							else if(Dedit =='T' && Ddelete =='F'){
								return '<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/enduser\/enduser.cfm?&action=Update&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
							else if(Dedit =='F' && Ddelete =='T'){
								return '<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/enduser\/enduserProcess.cfm?action=delete&driverno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
							else{
								return "";
							}
					}
				}
        	],
			'bAutoWidth':false,
			'bFilter':Dsearch,
			'bDestroy':true,
			'bProcessing':true,
			'bServerSide':true,
			'bStateSave':false,
			'fnServerParams':function(aoData){
				aoData.push(
					{"name":"method","value":"listEnduser"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/enduser/enduserProfile.cfc',
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