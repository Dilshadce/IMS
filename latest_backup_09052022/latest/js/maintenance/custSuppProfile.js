// JavaScript Document
$(document).ready(function(e) {
	
	if(displaymultiselect =='T'){
	$('#example-multiple-selected option[value="0"]').prop('disabled', true);
	
	$('#example-multiple-selected').multiselect({
		onChange: function(option, checked, select) {
			var oTable = $('#resultTable').dataTable();

			var bVis = oTable.fnSettings().aoColumns[option.val()].bVisible;
			oTable.fnSetColumnVis( option.val(), checked ? true : false );
			
			(function( $ ) {
				$(function() {
					$.ajax({
						type:'POST',
						url:'/latest/maintenance/updateDisplaySetup.cfm',
						data:{
							type:"custSuppProfile",
							optionVal:option.val(),
							checked:checked
						},
						dataType:'html',
						cache:false,
						async: true,
						success: function(result){						
						
						},
						error: function(jqXHR,textStatus,errorThrown){
							alert(errorThrown);
						},
						complete: function(){
						
						}
					});
				});
			})(jQuery)
		}
	 });
	}
	if(display =='T'){
		visibleC = true;
	}else{
		visibleC = false;
	}
	if(target=='Customer'){
		redirect = 'customerProcess.cfm';
	}else{
		redirect = 'supplierProcess.cfm';
	}
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':account.toUpperCase(),'mData':'custno','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("0").selected},
				{
					'aTargets':[1],
					'sTitle':targerWords.toUpperCase(),
					'mData':'name',
					'bSortable':true,
					'sWidth':'20%',
					'bVisible':document.getElementById("1").selected,
					'mRender':function(data,type,object){
						return object.name+' '+object.name2;
					}
				},
				{
					'aTargets':[2],
					'sTitle':address.toUpperCase(),
					'mData':'add1',
					'bSortable':true,
					'sWidth':'20%',
					'bVisible':document.getElementById("2").selected,
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
						if(object.add4!=''){
							address=address+object.add4+'<br />';
						}
						if(address!=''){
							address=address.substring(0, address.length-6)
						}
						return address;
					}
				},
				{'aTargets':[3],'sTitle':telephone.toUpperCase(),'mData':'phone','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("3").selected},
				{'aTargets':[4],'sTitle':contact.toUpperCase(),'mData':'phonea','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("4").selected},
				{'aTargets':[5],'sTitle':agent.toUpperCase(),'mData':'agent','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("5").selected},
				{'aTargets':[6],'sTitle':endUser.toUpperCase(),'mData':'end_user','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("6").selected},
				{'aTargets':[7],'sTitle':currency.toUpperCase(),'mData':'currcode','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("7").selected},
				{'aTargets':[8],'sTitle':attention.toUpperCase(),'mData':'attn','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("8").selected},
				{'aTargets':[9],'sTitle':fax.toUpperCase(),'mData':'fax','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("9").selected},
				{'aTargets':[10],'sTitle':term.toUpperCase(),'mData':'term','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("10").selected},
				{'aTargets':[11],'sTitle':area.toUpperCase(),'mData':'area','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("11").selected},
				{'aTargets':[12],'sTitle':business.toUpperCase(),'mData':'business','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("12").selected},	
				{'aTargets':[13],'sTitle':createdOn.toUpperCase(),'mData':'created_on','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("13").selected},
				{
					'aTargets':[14],
					'sTitle':action.toUpperCase(),
					'mData':'custno',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'\/latest\/maintenance\/target.cfm?target='+target+'&action=update&menuID='+escape(encodeURIComponent(menuID))+'&custno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this?\')){window.open(\'\/latest\/maintenance\/'+redirect+'?action=delete&menuID='+escape(encodeURIComponent(menuID))+'&custno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
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
					{"name":"dts","value":dts},
					{"name":"targetTable","value":targetTable}
				);
        	},
			'sAjaxSource':'/latest/maintenance/custSuppProfile.cfc',
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