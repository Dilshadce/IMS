// JavaScript Document
function declineremark(tmonth, placementno)
{
	var remarks = '';
	remarks = prompt('Please key in reason for cancel.');
	if(remarks != null){ window.open('/latest/customization/manpower_i/mpapproval/TimesheetApprovalProcess.cfm?type=dec&pno='+escape(encodeURIComponent(placementno))+'&remarks='+remarks+'&id='+escape(encodeURIComponent(tmonth)),'_self');
	
	}
	return remarks; 
}
$(document).ready(function(e) {
	
	
/*	alert(Dedit);
	alert(Ddelete);*/
	
	var	redirect = 'customerProcess.cfm';
	
	var resultTable=$('#resultTable')
		.dataTable({
			'aLengthMenu':[[10, 25, 50, 100, -1], [10, 25, 50, 100, 'All']],
			'aoColumnDefs':[
				{'aTargets':[0],'sTitle':'NO','mData':'empno','bSortable':true,'sWidth':'10%',
				'mRender':function(data,type,object){
						return ''+object.CurrentRow+'';
					}
				
				},
				{'aTargets':[1],'sTitle':'EMPLOYEE','mData':'empno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[2],'sTitle':'EMPNAME','mData':'empname','bSortable':true,'sWidth':'15%'},				
				{'aTargets':[3],'sTitle':'PLACEMENT NO.','mData':'placementno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[4],'sTitle':'CUSTOMER','mData':'custno','bSortable':true,'sWidth':'15%'},
				{'aTargets':[5],'sTitle':'CUSTNAME','mData':'custname','bSortable':true,'sWidth':'15%'},
				{'aTargets':[6],'sTitle':'SUBMITED ON','mData':'created_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[7],'sTitle':'APPROVED ON','mData':'updated_on','bSortable':true,'sWidth':'15%'},
				{'aTargets':[8],'sTitle':'MONTH','mData':'tmonth','bSortable':true,'sWidth':'15%'},
				{'aTargets':[9],'sTitle':'DATE START','mData':'start','bSortable':true,'sWidth':'15%'},
				{'aTargets':[10],'sTitle':'DATE END','mData':'end','bSortable':true,'sWidth':'15%'},
				{'aTargets':[11],'sTitle':'TIMESHEET','mData':'empno','bSortable':true,'sWidth':'15%',
				'mRender':function(data,type,full){
						return '<span class="glyphicon glyphicon-search btn btn-link" title="VIEW" '+ 
									'onclick="window.open(\'\/latest\/customization\/manpower_i\/mpapproval\/TimesheetApprovalView.cfm?pno='+escape(encodeURIComponent(full.placementno))+'&datestart='+escape(encodeURIComponent(full.start))+'&dateend='+escape(encodeURIComponent(full.end))+'&tmonth='+escape(encodeURIComponent(full.tmonth1))+'\',\'_blank\');"> </span>';
					}
				
				},
				{'aTargets':[12],'sTitle':'HM REMARKS','mData':'MGMTREMARKS','bSortable':true,'sWidth':'15%'},
				{'aTargets':[13],'sTitle':'ACTION','mData':'empno','bSortable':false,'bVisible':true,'sWidth':'15%',				
					'mRender': function(data,type,full){
						
						/*var textbox_id = "management_"+row.tmonth1+"_"+row.placementno;
						var remark_text = document.getElementById(textbox_id).value;*/
						/*console.log('management_'+object.tmonth1+'_'+object.placementno);*/
						
						
						
						return '<span class="glyphicon glyphicon-ok btn btn-link" title="Process" '+
									'onclick="if(confirm(\'Confirm Process?\')){window.open(\'\/default\/transaction\/assignmentslipnewnew\/Assignmentsliptable2.cfm?type=Create&pno='+escape(encodeURIComponent(full.placementno))+'&id='+escape(encodeURIComponent(full.tmonth1))+'&firstday='+escape(encodeURIComponent(full.start))+'&lastday='+escape(encodeURIComponent(full.end))+'\',\'_self\');}"></span>'
                                    
                                    +'<span class="glyphicon glyphicon-repeat btn btn-link" title="Backdated Processing" '+
									'onclick="if(confirm(\'Confirm Backdated Processing?\')){window.open(\'\/default\/transaction\/assignmentslipnewnew\/Assignmentsliptable2.cfm?type=Create&pno='+escape(encodeURIComponent(full.placementno))+'&id='+escape(encodeURIComponent(full.tmonth1))+'&firstday='+escape(encodeURIComponent(full.start))+'&lastday='+escape(encodeURIComponent(full.end))+'&backdated=Yes'+'\',\'_self\');}"></span>'
									
									+'<span class="glyphicon glyphicon-remove btn btn-link" title="CANCEL" '+
									'onclick=" declineremark('+full.tmonth1+','+full.placementno+') ;"></span>';
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
					{"name":"dts2","value":''+dts2+''},
					{"name":"targetTable","value":''+targetTable+''},
					{"name":"huserid","value":huserid}
				);
        	},
			'sAjaxSource':'/latest/customization/manpower_i/mpapproval/TimesheetApprovalMainT.cfc',
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