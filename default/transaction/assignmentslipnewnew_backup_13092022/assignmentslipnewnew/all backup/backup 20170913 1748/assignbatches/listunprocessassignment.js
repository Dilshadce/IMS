// JavaScript Document
$(document).ready(function(e) {	
	if(displaymultiselect =='T'){
	$('#example-multiple-selected option[value="0"]').prop('disabled', true);
	$('#example-multiple-selected').multiselect({
		onChange: function(option, checked, select) {
			var oTable = $('#resultTable').dataTable();

			var bVis = oTable.fnSettings().aoColumns[option.val()].bVisible;
			oTable.fnSetColumnVis( option.val(), checked ? true : false );
		}
	 });
	}
	
	var resultTable=$('#resultTable')
		.dataTable({
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[				
				/*{
					'aTargets':[0],
					'sTitle':refno.toUpperCase(),
					'mData':'refno',
					'bSortable':true,
					'sWidth':'15%',
					'bVisible':document.getElementById("0").selected,
					'mRender':function(data,type,row){
						return 	'<a '+
								'href="window.open(\'\/..\/..\/..\/..\/..\/default\/report-stock\/stockcard3.cfm?itemno='+escape(encodeURIComponent(data))+'&itembal='+row.qtybf+'&pf=&pt=&cf=&ct=&pef=&pet=&gpf=&gpt=&df=&dt=&sf=&st=&thislastaccdate=&dodate=Y\'" target="\'_blank\'");">'+data+'</a>';
					}
				},*/	
				{'aTargets':[0],'sTitle':'Reference No','mData':'refno','bSortable':true,'sWidth':'12%','bVisible':document.getElementById("0").selected},
				{'aTargets':[1],'sTitle':'Invoice Date','mData':'assignmentslipdate','bSortable':true,'sWidth':'12%','bVisible':document.getElementById("1").selected},
				{'aTargets':[2],'sTitle':'Placement No','mData':'placementno','bSortable':true,'sWidth':'12%','bVisible':document.getElementById("2").selected},				
				{'aTargets':[3],'sTitle':'Customer No','mData':'custno','bSortable':true,'sWidth':'12%','bVisible':document.getElementById("3").selected},
				{'aTargets':[4],'sTitle':'Employee Name','mData':'empname','bSortable':true,'sWidth':'18%','bVisible':document.getElementById("4").selected},
				{'aTargets':[5],'sTitle':'Batch No','mData':'batches','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("5").selected},
				{'aTargets':[6],'sTitle':'Status','mData':'locked','bSortable':true,'sWidth':'10%','bVisible':document.getElementById("6").selected},
				{
					'aTargets':[7],
					'sTitle':action.toUpperCase(),
					'mData':'refno',
					'bSortable':false,
					'bVisible':true,
					'sWidth':'10%',
					'mRender':function(data,type,row){
						return 	'<span class="glyphicon glyphicon-pencil btn btn-link" '+
								'onclick="window.open(\'po.cfm?action=update&refno='+escape(encodeURIComponent(data))+'\',\'_self\');"></span>'+
								'<span class="glyphicon glyphicon-remove btn btn-link" '+
								'onclick="if(confirm(\'Are you sure you wish to delete this product?\')){window.open(\'poProcess.cfm?action=delete&refno='+escape(encodeURIComponent(data))+'\',\'_self\');}"></span>';
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
			'sAjaxSource':'listunprocessassignment.cfc',
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