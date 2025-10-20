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
							type:"productProfile",
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
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[				
				{
					'aTargets':[0],
					'sTitle':itemno.toUpperCase(),
					'mData':'itemno',
					'bSortable':true,
					'sWidth':'15%',
					'bVisible':document.getElementById("0").selected,
					'mRender':function(data,type,row){
						return 	'<a '+
								'href="window.open(\'\/..\/..\/..\/..\/..\/default\/report-stock\/stockcard3.cfm?itemno='+escape(encodeURIComponent(data))+'&itembal='+row.qtybf+'&pf=&pt=&cf=&ct=&pef=&pet=&gpf=&gpt=&df=&dt=&sf=&st=&thislastaccdate=&dodate=Y\'" target="\'_blank\'");">'+data+'</a>';
					}
				},	
				{'aTargets':[1],'sTitle':productcode.toUpperCase(),'mData':'aitemno','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("1").selected},
				{'aTargets':[2],'sTitle':description.toUpperCase(),'mData':'desp','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("2").selected},				
				{'aTargets':[3],'sTitle':comment.toUpperCase(),'mData':'comment','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("3").selected},
				{'aTargets':[4],'sTitle':brand.toUpperCase(),'mData':'brand','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("4").selected},
				{'aTargets':[5],'sTitle':model.toUpperCase(),'mData':'shelf','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("5").selected},
				{'aTargets':[6],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("6").selected},
				{'aTargets':[7],'sTitle':group.toUpperCase(),'mData':'wos_group','bSortable':true,'sWidth':'20%','bVisible':document.getElementById("7").selected},
				{'aTargets':[8],'sTitle':material.toUpperCase(),'mData':'colorid','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("8").selected},
				{'aTargets':[9],'sTitle':rating.toUpperCase(),'mData':'costcode','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("9").selected},
				{'aTargets':[10],'sTitle':size.toUpperCase(),'mData':'sizeid','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("10").selected},
				{'aTargets':[11],'sTitle':cost.toUpperCase(),'mData':'ucost','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("11").selected},
				{'aTargets':[12],'sTitle':price.toUpperCase(),'mData':'price','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("12").selected},

				{'aTargets':[13],'sTitle':unit.toUpperCase(),'mData':'unit','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("13").selected},
				{'aTargets':[14],'sTitle':qtyBF.toUpperCase(),'mData':'qtybf','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("14").selected},
				{'aTargets':[15],'sTitle':unitSP2.toUpperCase(),'mData':'price2','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("15").selected},
				{'aTargets':[16],'sTitle':supplier.toUpperCase(),'mData':'supp','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("16").selected},
				
				{'aTargets':[17],'sTitle':discontinueItem.toUpperCase(),'mData':'nonstkitem','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("17").selected},
				{'aTargets':[18],'sTitle':itemPacking.toUpperCase(),'mData':'packing','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("18").selected},
				{'aTargets':[19],'sTitle':foreignCurrency.toUpperCase(),'mData':'fcurrcode','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("19").selected},				
				{'aTargets':[20],'sTitle':foreignUnitPrice.toUpperCase(),'mData':'fprice','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("20").selected},				
				{'aTargets':[21],'sTitle':foreignSellPrice.toUpperCase(),'mData':'fucost','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("21").selected},				
				{'aTargets':[22],'sTitle':showOnHand.toUpperCase(),'mData':'onhand','bSortable':true,'sWidth':'15%','bVisible':document.getElementById("22").selected},
				{
					'aTargets':[23],
					'sTitle':action.toUpperCase(),
					'mData':'itemno',
					'bSortable':false,
					'bVisible':visibleC,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'\/latest\/maintenance\/product.cfm?action=update&menuID='+escape(encodeURIComponent(menuID))+'&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this product?\')){window.open(\'\/latest\/maintenance\/productProcess.cfm?action=delete&menuID='+escape(encodeURIComponent(menuID))+'&itemno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
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
					{"name":"hitemgroup","value":hitemgroup},
					{"name":"targetTable","value":targetTable}
				);
        	},
			'sAjaxSource':'/latest/maintenance/productProfile.cfc',
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