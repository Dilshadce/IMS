// JavaScript Document
$(document).ready(function(e) {

	var	redirect = 'caseProcess.cfm';

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'CASE NO','mData':'caseno','bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'CASE NO','mData':'caseno','bSortable':true,'sWidth':'7%'},
				{'aTargets':[2],'sTitle':'OPEN DATE/TIME','mData':'created_on','bSortable':true,'sWidth':'10%'},
				{'aTargets':[3],'sTitle':'CLOSE DATE/TIME','mData':'closed_on','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':'DURATION OPENED','mData':'duration','bSearchable':false,'bSortable':false,'sWidth':'10%'},
				{'aTargets':[5],'sTitle':'BRAND','mData':'brandno','bSortable':true,'sWidth':'8%'},
				{'aTargets':[6],'sTitle':'COMPANY','mData':'contact','bSortable':true,'sWidth':'10%',
					'mRender':function(data,type,object){
						var cont='';						
						if(object.custname!=''){
							cont=cont+object.custname+'<br />';
						}
						if(object.contact!=''){
							cont=cont+object.contact+'<br />';
						}
						if(cont!=''){
							cont=cont.substring(0, cont.length-6)
						}
						return cont;
					}
				},
				{'aTargets':[7],'sTitle':'CASE TYPE','mData':'type','bSortable':true,'sWidth':'9%'},
				{'aTargets':[8],'sTitle':'CASE SUBJECT','mData':'subject','bSortable':true,'sWidth':'9%'},
				{'aTargets':[9],'sTitle':'STATUS','mData':'status','bSortable':true,'sWidth':'9%'},
				{'aTargets':[10],'sTitle':'CASE OWNER','mData':'owner','bSortable':true,'sWidth':'9%'},
				{'aTargets':[11],'sTitle':'CUSTOMER NAME','mData':'custname','bSortable':false,'bVisible':false},
				{
					
					'aTargets':[12],
					'sTitle':'ACTION',
					'mData':'caseno',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						if(Dedit =='T' && Ddelete =='T'){
								return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/case\/case.cfm?&action=Update&caseno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/case\/caseProcess.cfm?action=delete&caseno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
						else if(Dedit =='T' && Ddelete =='F'){
								return '<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/case\/case.cfm?&action=Update&caseno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
						else if(Dedit =='F' && Ddelete =='T'){
								return '<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/case\/caseProcess.cfm?action=delete&caseno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
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
					{"name":"method","value":"listCase"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''}
				);
        	},
			'sAjaxSource':'/case/caseProfile.cfc',
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