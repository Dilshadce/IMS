<cfoutput>
    <script>
    $(document).ready(function(e) {
        $('.input-group.date').datepicker({
            format: "dd/mm/yyyy",
            todayBtn: "linked",
            autoclose: true,
            todayHighlight: true
        });
        });
            var dts="#dts#";
            var Hlinkams = '#Hlinkams#';
            var limit=10;
            var custno = '';
            var itemno = '';

            function formatResultItem(result){
                    return result.itemno+' - '+result.desp;  
                };

                function formatSelectionItem(result){
                    document.getElementById('desp').value=result.desp;
                    return result.itemno+' - '+result.desp;  
                };

                function formatResultAssign(result){
                    return result.date+' - '+result.refno+' - '+result.empname;  
                };

                function formatSelectionAssign(result){
                    return result.date+' - '+result.refno+' - '+result.empname;  
                };

                function formatResultJO(result){
                    return result.placementno+' - '+result.empname;  
                };

                function formatSelectionJO(result){
                    return result.placementno+' '; 
                };


                $(document).ready(function(e) {
                var itemno = $("##itemno").val();
                    $('.itemFilter').select2({
                                ajax:{
                                    type: 'POST',
                                    url:'filterItem.cfc',
                                    dataType:'json',
                                    data:function(term,page){
                                        return{
                                            method:'listAccount',
                                            returnformat:'json',
                                            dts:dts,
                                            term:term,
                                            itemno:itemno,
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
                                            url:'filterItem.cfc',
                                            dataType:'json',
                                            data:{
                                                method:'getSelectedAccount',
                                                returnformat:'json',
                                                dts:dts,
                                                value:value,
                                            },
                                        }).done(function(data){callback(data);});

                                    };
                                },
                                formatResult:formatResultItem,
                                formatSelection:formatSelectionItem,
                                minimumInputLength:0,
                                width:'off',
                                dropdownCssClass:'bigdrop',
                                dropdownAutoWidth:true,
                            }).select2('val','');

                    var assignrefno = $("##assignrefno").val();
                    $('.AssignFilter').select2({
                                ajax:{
                                    type: 'POST',
                                    url:'filterAssign.cfc',
                                    dataType:'json',
                                    data:function(term,page){
                                        return{
                                            method:'listAccount',
                                            returnformat:'json',
                                            dts:dts,
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
                                            url:'filterAssign.cfc',
                                            dataType:'json',
                                            data:{
                                                method:'getSelectedAccount',
                                                returnformat:'json',
                                                dts:dts,
                                                value:value,
                                            },
                                        }).done(function(data){callback(data);});

                                    };
                                },
                                formatResult:formatResultAssign,
                                formatSelection:formatSelectionAssign,
                                minimumInputLength:0,
                                width:'off',
                                dropdownCssClass:'bigdrop',
                                dropdownAutoWidth:true,
                            }).select2('val','');

                    $('.JOFilter').select2({
                                ajax:{
                                    type: 'POST',
                                    url:'filterJO.cfc',
                                    dataType:'json',
                                    data:function(term,page){
                                        return{
                                            method:'listAccount',
                                            returnformat:'json',
                                            dts:dts,
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
                                            url:'filterJO.cfc',
                                            dataType:'json',
                                            data:{
                                                method:'getSelectedAccount',
                                                returnformat:'json',
                                                dts:dts,
                                                value:value,
                                            },
                                        }).done(function(data){callback(data);});

                                    };
                                },
                                formatResult:formatResultJO,
                                formatSelection:formatSelectionJO,
                                minimumInputLength:0,
                                width:'off',
                                dropdownCssClass:'bigdrop',
                                dropdownAutoWidth:false,
                            }).select2('val','');






            });

            $("##additembtn").click(function () {
                var tran = document.getElementById('tran').value;

                if($("##custno").val() == ''){
                    $('##Msg').html('Please choose a Customer before add item.');
                    $('##AlertModal').modal();
                <!---}else if($("##invoiceno").val() == ''){
                    $('##Msg').html('Please choose an Invoice add item.');
                    $('##AlertModal').modal();--->
                }else if($("##itemno").val() == ''){
                    $('##Msg').html('Please choose an item to add item.');
                    $('##AlertModal').modal();
                }else if ($("##completedate").val() == '' ||$("##startdate").val()==''){
                    $('##Msg').html('Please select Start and Complete Date to add item.');
                    $('##AlertModal').modal();
                }else if ($("##addsingleJO").val() == '' && $("##assignrefno").val()==''){
                    $('##Msg').html('Please select Assignmentslip No. or Placement No. to add item.');
                    $('##AlertModal').modal();
                }else{

                var uuid = $("##uuid").val();
                var refno = $("##refno").val();
                var tran = $("##tran").val();
                var wos_date = $("##wos_date").val();
                var invno = $("##invoiceno").val();
                var bosinvno = $("##bosinvoiceno").val();
                var custno = $("##custno").val();
                if(tran.toLowerCase() == 'dn'){
                    var newcustno = $("##newcustno").val();
                }
                var itemno = $("##itemno").val();
                var desp = $("##desp").val();
                var qty = $("##qty").val();
                var price = $("##price").val();
                var amount = $("##amount").val();
                var startdate = $("##startdate").val();
                var completedate = $("##completedate").val();
                var addsingleJO = $("##addsingleJO").val();
                var assignrefno = $("##assignrefno").val();
                var gstrate = $("##taxper").val();
                var dataString = "refno="+escape(refno);
                dataString = dataString+"&tran="+escape(tran);
                dataString = dataString+"&invno="+escape(invno);
                dataString = dataString+"&bosinvno="+escape(bosinvno);
                dataString = dataString+"&custno="+escape(custno); 
                if(tran.toLowerCase() == 'dn'){
                    dataString = dataString+"&newcustno="+escape(newcustno);
                }
                dataString = dataString+"&startdate="+escape(startdate);
                dataString = dataString+"&completedate="+escape(completedate);
                dataString = dataString+"&assignrefno="+escape(assignrefno);
                dataString = dataString+"&addsingleJO="+addsingleJO;
                dataString = dataString+"&itemno="+itemno;
                dataString = dataString+"&desp="+escape(desp);
                dataString = dataString+"&qty="+qty;
                dataString = dataString+"&price="+price;
                dataString = dataString+"&amount="+amount;
                dataString = dataString+"&wos_date="+wos_date;
                dataString = dataString+"&uuid="+uuid;
                dataString = dataString+"&gstrate="+gstrate;

                if($("##custno").val() != '' && $("##itemno").val() != '' && $("##completedate").val() != '' && $("##startdate").val()!='' &&
                  (assignrefno != '' || addsingleJO != '')){
                        $.ajax({
                            type:"POST",
                            url:"addsingleproductsAjax.cfm",
                            data:dataString,
                            dataType:"html",
                            cache:false,
                            success: function(result){
                                $("##body_section").html(result);
                                calculatefooter();
                            },
                            error: function(jqXHR,textStatus,errorThrown){
                                alert(errorThrown);
                            },
                            complete: function(){

                            }
                        });
                    }
                }
                document.getElementById('additembtn').disabled = false;
                if(document.getElementById('custno').value != ''){
                    document.getElementById('custno').disabled = true;
                }
                if(document.getElementById('invoiceno').value != ''){
                    document.getElementById('invoiceno').disabled = true;
                }
                if(tran.toLowerCase() == 'dn'){
                    if(document.getElementById('newcustno').value != ''){
                        document.getElementById('newcustno').disabled = true;
                    }
                }
            });
                    
    </script>
</cfoutput>