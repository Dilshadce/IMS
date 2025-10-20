// JavaScript Document
$(document).ready(function(e) {

	var	redirect = 'contactProcess.cfm';

	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'ID','mData':'id','bSortable':true,'bVisible':false,'sWidth':'0%'},
				{'aTargets':[1],'sTitle':'ACCOUNT','mData':'accno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'NAME','mData':'contactname','bSortable':true,'sWidth':'15%'},
				{
					'aTargets':[3],
					'sTitle':'BILLING ADDRESS',
					'mData':'b_add1',
					'bSortable':true,
					'sWidth':'25%',
					'mRender':function(data,type,object){
						var address='';
						if(object.b_add1!=''){
							address=address+object.b_add1+'<br />';
						}
						if(object.b_add2!=''){
							address=address+object.b_add2+'<br />';
						}
						if(object.b_add3!=''){
							address=address+object.b_add3+'<br />';
						}
						if(object.b_add4!=''){
							address=address+object.b_add4+'<br />';
						}
						if(object.b_city!=''){
							address=address+object.b_city+'<br />';
						}
						if(object.b_state!=''){
							address=address+object.b_state+'<br />';
						}
						if(object.b_country!='' && object.b_postalcode!=''){
							address=address+object.b_country+' '+object.b_postalcode;
						}
						if(address!=''){
							address=address.substring(0, address.length-6)
						}
						return address;
					}
				},
				{'aTargets':[4],'sTitle':'ADDRESS2','mData':'b_add2','bSortable':true,'bVisible':false},
				{'aTargets':[5],'sTitle':'ADDRESS3','mData':'b_add3','bSortable':true,'bVisible':false},
				{'aTargets':[6],'sTitle':'ADDRESS4','mData':'b_add4','bSortable':true,'bVisible':false},
				{'aTargets':[7],'sTitle':'CITY','mData':'b_city','bSortable':true,'bVisible':false},
				{'aTargets':[8],'sTitle':'STATE','mData':'b_state','bSortable':true,'bVisible':false},
				{'aTargets':[9],'sTitle':'COUNTRY','mData':'b_country','bSortable':true,'bVisible':false},
				{'aTargets':[10],'sTitle':'POSTALCODE','mData':'b_postalcode','bSortable':true,'bVisible':false},
				{
					'aTargets':[11],
					'sTitle':'CONTACT',
					'mData':'c_phone',
					'bSortable':true,
					'sWidth':'15%',
					'mRender':function(data,type,object){
						var contact='';
						var counter=1;
						if(object.c_phone!=''){
							contact=contact+'['+counter+'] '+object.c_phone+'<br />';
							counter++;
						}
						if(object.c_mobile!=''){
							contact=contact+'['+counter+'] '+object.c_mobile+'<br />'
							counter++;
						}
						if(contact!=''){
							contact=contact.substring(0, contact.length-6)
						}
						return contact;
					}
				},
				{'aTargets':[12],'sTitle':'CONTACT2','mData':'c_mobile','bSortable':true,'bVisible':false},
				{'aTargets':[13],'sTitle':'EMAIL','mData':'c_email','bSortable':true,'sWidth':'20%'},
				{
					
					'aTargets':[14],
					'sTitle':'ACTION',
					'mData':'id',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						if(Dedit =='T' && Ddelete =='T'){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/account\/contact.cfm?&action=update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/account\/contactProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
						else if(Dedit =='T' && Ddelete =='F'){
							return 	'<span class="glyphicon glyphicon-pencil btn btn-link" title="EDIT" '+
								'onclick="window.open(\'\/account\/contact.cfm?&action=update&id='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>';}
						else if(Dedit =='F' && Ddelete =='T'){
							return 	'<span class="glyphicon glyphicon-remove btn btn-link" title="DELETE" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/account\/contactProcess.cfm?action=delete&id='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';}
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
					{"name":"method","value":"listAccount"},
					{"name":"returnformat","value":"json"},
					{"name":"dts","value":''+dts+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"Down","value":Down},
					{"name":"acccreate","value":acccreate}
				);
        	},
			'sAjaxSource':'/account/contactProfile.cfc',
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