// JavaScript Document
$(document).ready(function(e) {

	var	redirect = 'leadProcess.cfm';
	
	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'id','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'LEAD NAME','mData':'leadname','bSortable':true,'sWidth':'14%'},
				{'aTargets':[2],'sTitle':'CONTACT PERSON','mData':'contact','bSortable':true,'sWidth':'14%'},
				{'aTargets':[3],'sTitle':'PHONE NO','mData':'phone','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':'OWNER','mData':'leadowner','bSortable':true,'sWidth':'12%'},
				{'aTargets':[5],'sTitle':'LEAD STATUS','mData':'leadstatus','bSortable':true,'sWidth':'10%'},
				{'aTargets':[6],'sTitle':'LEAD SOURCE','mData':'leadsource','bSortable':true,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':'LEAD DATE','mData':'date','bSortable':true,'sWidth':'10%'},
				{'aTargets':[8],'sTitle':'INVITED BY','mData':'invited_by','bSortable':true,'bVisible':true,'sWidth':'10%',
					'mRender':function(data,type,row){
						if(row.invited_by != "Empty"){
					return '<span class="glyphicon glyphicon-search btn btn-link" title="VIEW DETAIL" '+ 
									'onclick="window.open(\'\/lead\/viewinviteddetail.cfm?id='+escape(encodeURIComponent(data))+'\',\'_self\');"> </span>';
					}
					else{
						return "";
						}
					}
					
				},
				{
					'aTargets':[9],
					'sTitle':'UPDATE',
					'mData':'id',
					'bSortable':false,
					'sWidth':'10%',
					'mRender':function(data,type,row){
					if(H1029 =='T'){
						if(row.updated =='N')	{			
							return	'<span class="glyphicon glyphicon-ok-sign btn btn-link" title="UPDATE TO OPPORTUNITY" '+
									'onclick="if(confirm(\'Are you sure you wish to Update to Opportunity?\')){window.open(\'\/lead\/updateleadProcess.cfm?id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}	
						else{
							return "YES";
							}
						}
					else{
						return "";
						}
					}
				},
				{
					
					'aTargets':[10],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
					if(Dedit =='T' && Ddelete =='T'){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/lead\/lead.cfm?&action=Update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/lead\/leadProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
					else if(Dedit =='T' && Ddelete =='F'){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/lead\/lead.cfm?&action=Update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
					else if(Dedit =='F' && Ddelete =='T'){			
						return	'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/lead\/leadProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}		
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
					{"name":"method","value":"listLead"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"H1001","value":H1001},
					{"name":"acccreate","value":acccreate},
					{"name":"hlinkims","value":hlinkims},
					{"name":"hlinkams","value":hlinkams}
				);
        	},
			'sAjaxSource':'/lead/leadProfile.cfc',
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