<cfoutput>
	<script type="text/javascript">
		var dts='#dts#';
		var table='';
	<!---	var table='icitem';--->
		var Hitemgroup='#Hitemgroup#';
		var limit=10;
    <!---<cfloop from="1" to="2" index="aa">--->
        <!---function formatResult5(result){
            return result.itemNo+' - '+result.desp;  
        };
        
        function formatSelection5(result){
			$('##description').val(result.desp);
            return result.itemNo+' - '+result.desp;  
        };--->
		
		function formatResult(result){
            return result.empno+ " - " +result.name;
        };
        
        function formatSelection(result){
			<!---$('##description').val(result.desp);--->
            return result.empno+ " - " +result.name;
        };
        
        $(document).ready(function(e) {
            $('.EmployeeFilter').select2({
                ajax:{
                    type: 'POST',
                    url:'filterEmp.cfc',
                    dataType:'json',
                    data:function(term,page){
                        return{
                            method:'listAccount',
                            returnformat:'json',
                            dts:dts,
							Hitemgroup:Hitemgroup,
                            table:table,
                            term:term,
                            limit:limit,
                            page:page-1,
                        };
                    },
                    results:function(data,page){
                        var more=((page-1)*limit)<data.total;
                        return{
                            results:data.result,
                            more:more
                        };
                    }
                },
                initSelection: function(element, callback) {
                    var value=$(element).val();
                    if(value!=''){
                        $.ajax({
                            type:'POST',
                            url:'filterEmp.cfc',
                            dataType:'json',
                            data:{
                                method:'getSelectedAccount',
                                returnformat:'json',
                                dts:dts,
								Hitemgroup:Hitemgroup,
                                table:table,
								Hlinkams:Hlinkams,
                                value:value,
                            },
                        }).done(function(data){callback(data);});
                    };
                },
                formatResult:formatResult,
                formatSelection:formatSelection,
                minimumInputLength:0,
                width:'off',
                dropdownCssClass:'bigdrop',
                dropdownAutoWidth:true,
				placeholder:"Choose a Employee",
				
              	
            });
               		
            
        });
		<!---</cloop>--->
    </script>
</cfoutput>
