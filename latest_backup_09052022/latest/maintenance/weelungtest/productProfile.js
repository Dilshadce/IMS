// JavaScript Document
$(document).ready(function(e) {
	
	 $('#example-multiple-selected').multiselect({
	  		onChange: function(option, checked, select) {
			var oTable = $('#resultTable').dataTable();
			
			var bVis = oTable.fnSettings().aoColumns[option.val()].bVisible;
    		oTable.fnSetColumnVis( option.val(), checked ? true : false );
			
			
            }
	 });
	
	if(display =='T'){
		visibleC = true;
	}else{
		visibleC = false;
	}		
	var resultTable=$('#resultTable')
		.dataTable({
			//responsive: true,
			'scrollX':true,
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				
				{
					'aTargets':[0],
					'sTitle':itemno.toUpperCase(),
					'mData':'itemno',
					'bSortable':true,
					'sWidth':'15%',
					'mRender':function(data,type,row){
						return 	'<a '+
								'href="window.open(\'\/..\/..\/..\/..\/..\/default\/report-stock\/stockcard3.cfm?itemno='+escape(encodeURIComponent(data))+'&itembal='+row.qtybf+'&pf=&pt=&cf=&ct=&pef=&pet=&gpf=&gpt=&df=&dt=&sf=&st=&thislastaccdate=&dodate=Y\'" target="\'_blank\'");">'+data+'</a>';
					}
				},
				
				
				{'aTargets':[1],'sTitle':productcode.toUpperCase(),'mData':'aitemno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':description.toUpperCase(),'mData':'desp','bSortable':true,'sWidth':'15%'},
				{'aTargets':[3],'sTitle':brand.toUpperCase(),'mData':'brand','bSortable':true,'sWidth':'10%'},
				{'aTargets':[4],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'10%'},
				{'aTargets':[5],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'10%'},
				{'aTargets':[6],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'10%'},
				{'aTargets':[7],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'10%'},
				{'aTargets':[8],'sTitle':category.toUpperCase(),'mData':'category','bSortable':true,'sWidth':'10%'},
				{
					'aTargets':[9],
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
				},
				{'aTargets':[10],'mData':'qtybf','bSortable':true,'bVisible':false}
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
			'sAjaxSource':'/latest/maintenance/weelungtest/productProfile.cfc',
			'sServerMethod':'POST',
        	'sScrollX':'100%'
		})
		.fadeIn();
		
		$(window).resize(function() {
			resultTable.fnDraw(false)        
		});
		
		/*
		new FixedColumns( resultTable, {
 		"columns": 1
 		} );*/

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