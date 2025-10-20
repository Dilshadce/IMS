<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.refno')>
	<cfset URLrefno = trim(urldecode(url.refno))>
</cfif>

<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>
    
<!---Added by Nieo 20190410 1357, to control CN and DN creation--->
<cfset paydts=replace(dts,'_i','_p','all')>
<cfquery name="gqry" datasource="payroll_main">
SELECT mmonth,myear from gsetup where comp_id = '#replace(HcomID,'_i','')#'
</cfquery>
    
<cfif findnocase('#right(gqry.myear,2)#',dts)>
    <cfoutput>
        <h3>Transaction already closed for year of #gqry.myear#.</br>Please fly to current year to create #ucase(url.tran)#.</h3>
    </cfoutput>    
    <cfabort>
</cfif>
<!---Added by Nieo 20190410 1357, to control CN and DN creation--->

<cfset getgsetup.wpitemtax="1">

<cfquery name="getusers" datasource='main'>
    SELECT * 
    FROM users
	WHERE userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(dts)#">;
</cfquery>

<cfquery datasource="#dts#" name="getlastusedno">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = "#url.tran#"
			and counter = '1'
</cfquery>

    <cfinvoke component="cfc.refno" method="processNum" oldNum="#getlastusedno.tranno#" returnvariable="newnextNum" />
    <cfset actual_nexttranno = newnextNum>
        <cfif (getlastusedno.refnocode2 neq "" or getlastusedno.refnocode neq "") and getlastusedno.presuffixuse eq "1">
			<cfset nexttranno = getlastusedno.refnocode&actual_nexttranno&getlastusedno.refnocode2>
        <cfelse>
            <cfset nexttranno = actual_nexttranno>
		</cfif>
        <cfset tranarun_1 = getlastusedno.arun>

<cfset nexttranno = tostring(nexttranno)>


<cfset uuid = createuuid()>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>Create New Credit Note</cfoutput></title>
    <!---<link rel="stylesheet" href="/latest/css/form.css" />--->
    <!---<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>--->
	<script type="text/javascript" src="jquery-3.2.0.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    
	<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
    <!---<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>--->
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>


	<link rel="stylesheet" type="text/css" href="creditnote.css"/>
    
	<script>
	$(document).ready(function(e) {
	$('.input-group.date').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		autoclose: true,
		todayHighlight: true
	});
	});
	
	
	function validatefield(){
	
	alert(document.getElementById('custno').value);
	
	}
	
	
	
	
	</script>
	
	
	
<cfoutput>
	<script type="text/javascript">
		var dts="#dts#";
		var Hlinkams = '#Hlinkams#';
		var limit=10;
		var custno = '';
		var itemno = '';
		
			function formatResult2(result){
				return result.customerNo+' - '+result.name+' '+result.name2; 
			};
			
			function formatSelection2(result){
				return result.customerNo+' - '+result.name+' '+result.name2;  
			};
			
			function formatResultINV(result){
				return result.wos_date+' - '+result.refno; 
			};
			
			function formatSelectionINV(result){                
				return result.wos_date+' - '+result.refno;  
			};
			
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
				return result.placementno+' - '+result.empname; 
			};
			
			function calcamount(){
				var fields = [
                "price","qty"
                ];

                for(var i = 0; i < fields.length;i++){
                    if(isNaN(document.getElementById(fields[i]).value) && document.getElementById(fields[i]).value.charAt(0) != '-')
                    {
                        document.getElementById(fields[i]).value = 0.00;
                    }
                    /*if(document.getElementById(fields[i]).value == ''){
                        document.getElementById(fields[i]).value = 0.00;
                    }*/

                }
                
                var itemamount = document.getElementById('price').value * document.getElementById('qty').value;
				document.getElementById('amount').value=itemamount.toFixed(2);
			};
		
			$(document).ready(function(e) {
				$('.customerFilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/filter/filterCustomer.cfc',
						dataType:'json',
						data:function(term,page){
							return{
								method:'listAccount',
								returnformat:'json',
								dts:dts,
								Hlinkams:Hlinkams,
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
								url:'/latest/filter/filterCustomer.cfc',
								dataType:'json',
								data:{
									method:'getSelectedAccount',
									returnformat:'json',
									dts:dts,
									value:value,
									Hlinkams:Hlinkams,
								},
							}).done(function(data){callback(data);});
						};
					},
					formatResult:formatResult2,
					formatSelection:formatSelection2,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose a Customer",
					
				}).on('change', function (e) {
				var custno = $("##custno").val();
					$('.invoiceFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterInvoice.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										custno:custno,
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
										url:'filterInvoice.cfc',
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
							formatResult:formatResultINV,
							formatSelection:formatSelectionINV,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).select2('val','');
				});
                
				
				
						
						$('.invoiceFilter').select2({
							ajax:{
								type: 'POST',
								url:'filterInvoice.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										custno:custno,
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
										url:'filterInvoice.cfc',
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
							formatResult:formatResultINV,
							formatSelection:formatSelectionINV,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
						}).on('change',function(e){
                            var inv = $('##invoiceno').val();
                            checkinv(inv,'#url.tran#');
                        });
						
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
			
			
				$("##addinvbtn").click(function () {

				
					var uuid = $("##uuid").val();
					var refno = $("##refno").val();
					var tran = $("##tran").val();
					var invno = $("##invoiceno").val();
                    var bosinvno = $("##bosinvoiceno").val();
					var custno = $("##custno").val();
                    var gstrate = $("##taxper").val();
                    if(tran.toLowerCase() == 'dn'){
                        var newcustno = $("##newcustno").val();
                    }
					var dataString = "refno="+escape(refno);
					dataString = dataString+"&tran="+escape(tran);
					dataString = dataString+"&invno="+escape(invno);
                    dataString = dataString+"&bosinvoiceno="+escape(bosinvoiceno);
					dataString = dataString+"&custno="+escape(custno);
                    dataString = dataString+"&gstrate="+escape(gstrate);
                    if(tran.toLowerCase() == 'dn'){
                        dataString = dataString+"&newcustno="+escape(newcustno);
                    }
					dataString = dataString+"&uuid="+uuid;

				$.ajax({
					type:"POST",
					url:"addproductsAjax.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){
						$("##body_section").html(result);
						calculatefooter();
						if(document.getElementById('custno').value != ''){
							document.getElementById('custno').disabled = true;
						}
						/*if(document.getElementById('invoiceno').value != ''){
							document.getElementById('invoiceno').disabled = true;
						}*/
                        if(tran.toLowerCase() == 'dn'){
                            if(document.getElementById('newcustno').value != ''){
                                document.getElementById('newcustno').disabled = true;
                            }
                        }
                        setgstrate();
                        
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						
					}
				});
				});
                
				
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
					dataString = dataString+"&itemno="+itemno;
					dataString = dataString+"&desp="+escape(desp);
					dataString = dataString+"&qty="+qty;
					dataString = dataString+"&price="+price;
					dataString = dataString+"&amount="+amount;
                    dataString = dataString+"&addsingleJO="+addsingleJO;
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
                                    setgstrate();
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
                    if(tran.toLowerCase() == 'dn'){
                        if(document.getElementById('newcustno').value != ''){
                            document.getElementById('newcustno').disabled = true;
                        }
                    }
					if(document.getElementById('invoiceno').value != ''){
						document.getElementById('invoiceno').disabled = true;
					}
				});
				
				
			});
			
			function trim(strval)
			{
			return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
			}
                    
            function setgstrate(){
                document.getElementById('taxper').disabled =false;
                
                var input=document.getElementById('hidtaxper').value;
                var output=document.getElementById('taxper').options;
                
                for(var i=0;i<output.length;i++) {
                    if(output[i].text.indexOf(input)>=0){
                        document.getElementById('taxper').options[i].selected=true;
                        break;
                    }
                }
            }			
			
			
			function calculatefooter()
			{
			document.getElementById('gross').value = document.getElementById('hidsubtotal').value;
			<cfif getgsetup.wpitemtax eq "1">
            document.getElementById('taxamt').value = document.getElementById('hidtaxtotal').value;
			</cfif>
			var hiditemcount = document.getElementById('hiditemcount').value * 1;
			if (hiditemcount == 0)
			{
			document.getElementById('Submit').disabled = true;
			}
			else
			{
			
			document.getElementById('Submit').disabled = false;
			}
			calcdisc();
			caltax();
			calcfoot();
			}
			
			
			function calcdisc()
			{
			var gross = document.getElementById('gross').value * 1;
			var dispec1 = document.getElementById('dispec1').value * 1;
			var dispec2 = document.getElementById('dispec2').value * 1;
			var dispec3 = document.getElementById('dispec3').value * 1;
			var disamt = document.getElementById('disamt_bil');
			var net = document.getElementById('net');
			var disval = 0;
			
			disval = gross - (gross * (dispec1/100));
			document.getElementById('disbil1').value = gross * (dispec1/100);
			disval = disval - (disval * (dispec2 /100));
			document.getElementById('disbil2').value =disval * (dispec2 /100);
			disval = disval - (disval * (dispec3 /100));
			document.getElementById('disbil3').value = disval * (dispec3 /100);
			net.value = disval.toFixed(2);
			disamtlas = gross - disval;
			disamt.value = disamtlas.toFixed(2);
			
			}
			
			function caltax()
			{
			
			var net = document.getElementById('net').value;
			var taxincl = false;
			var taxper = document.getElementById('taxper').value;
			var taxamt = document.getElementById('taxamt');
			var grand = document.getElementById('grand');
			var taxval = 0;
			taxper = parseFloat(taxper);
			net = parseFloat(net);

			/*if (taxincl == true)
			{
			taxval = ((taxper/(100+taxper))*net).toFixed(2);
			taxamt.value = taxval;
			grand.value = net.toFixed(2);
			}
			else
			{
			taxval = ((taxper/100)*net).toFixed(2);
			taxamt.value = taxval;
			var netb = (net * 1) + (taxval * 1);
			grand.value =netb.toFixed(2);
			}*/
			}
			
			function calcfoot()
			{
			var gross = document.getElementById('gross').value * 1;
			var disamt = document.getElementById('disamt_bil').value * 1;
			
			var net = document.getElementById('net');
			var taxamt = document.getElementById('taxamt').value * 1;
			var grand = document.getElementById('grand');
			net.value = (gross-disamt).toFixed(2);

			var taxincl = false;
			if(taxincl == true)
			{
			
			grand.value = net.value;
			
			}
			else
			{
			var netb = ((net.value * 1) + (taxamt * 1));
			grand.value = netb.toFixed(2);
			}

			
			}
			
			function getDiscount()
			{
			var subtotal=document.getElementById("amtfordiscount").value;
			var d1=document.getElementById("disp1").value;
			var d2=document.getElementById("disp2").value;
			var d3=document.getElementById("disp3").value;
			var ttld=document.getElementById("disamt_bil1").value;
			var totaldiscount=0;
			var temp=0;

			if((parseFloat(d1)+parseFloat(d2)+parseFloat(d3))!=0)
			{

				temp=(subtotal*d1/100).toFixed(2);
				totaldiscount=temp;
				temp=(subtotal-totaldiscount).toFixed(2);
				temp=(temp*d2/100).toFixed(2);
				totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(2);
				temp=(subtotal-totaldiscount).toFixed(2);
				temp=(temp*d3/100).toFixed(2);
				totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(2);

			}
			else
			{

				totaldiscount=0;
			}
			document.getElementById("disamt_bil1").value= totaldiscount;
			}
			
			
			function deleterow(rowno)
			{

				var uuid = document.getElementById('uuid').value;

				var dataString = 'uuid='+escape(uuid)+'&trancode='+rowno;
			
				$.ajax({
					type:"POST",
					url:"deleterow.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){
						
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
					}
				});
				
			}
                    
            function deletelist() {
                adddeletelist();
                
                var uuid = document.getElementById('uuid').value;
                var selected = document.getElementById('selected').value;
                var tran = document.getElementById('tran').value;
                var dataString = "deletelist="+escape(selected);
                dataString = dataString+"&tran="+escape(tran);
                dataString = dataString+"&uuid="+uuid;
                

				$.ajax({
					type:"POST",
					url:"deleterow.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
					}
				});
            }
                    
            function adddeletelist() {
                
                var selected = '';
                
                var list = $("input[name='checkdeletebtn']:checked");
                
                var length = list.length;
                
                $("input[name='checkdeletebtn']:checked").each(function(index)
                {
                    if (index === (length - 1)) {
                        selected = selected + $(this).val();
                    }else{
                        selected = selected + $(this).val()+',';
                    }
                    
                });
                
                document.getElementById('selected').value = selected;
            }
			
			function recalculateamt()
			{
			var dataString = 'uuid=#URLEncodedFormat(uuid)#&tran='+document.getElementById('tran').value+"&custno="+document.getElementById('custno').value+"&invno="+document.getElementById('invoiceno').value+"&gstrate="+document.getElementById('taxper').value;
            if(document.getElementById('tran').value.toLowerCase() == 'dn'){
                dataString = dataString+"&newcustno="+escape(document.getElementById('newcustno').value);
            }
			
			$.ajax({
					type:"POST",
					url:"recalculateAjax.cfm",
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
						calculatefooter();
					}
			});

			}
			
			function updateprice(uuid,trancode,price)
			{
				var dataString = 'trancode='+trancode+'&uuid='+uuid+'&price='+price;

				$.ajax({
					type:"POST",
					url:"updateprice.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changeprice');
					}
				});
			}
			
			function updateprice2(e,uuid,trancode,price)
			{
			if(e.keyCode==13){
			var dataString = 'trancode='+trancode+'&uuid='+uuid+'&price='+price;

				$.ajax({
					type:"POST",
					url:"updateprice.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){

					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changeprice');
					}
				});
			
			}
			}
				
			function updateqty(uuid,trancode,qty)
				{
				var dataString = 'trancode='+trancode+'&uuid='+uuid+'&qty='+qty;
				
				
				$.ajax({
					type:"POST",
					url:"updateqty.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){

					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changeqty');
					}
				});
			}
			
			function updateqty2(e,uuid,trancode,qty)
			{
			if(e.keyCode==13){
			var dataString = 'trancode='+trancode+'&uuid='+uuid+'&qty='+qty;

				$.ajax({
					type:"POST",
					url:"updateqty.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){

					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changeqty');
					}
				});
			}
			}
				
			function updatediscount(uuid,trancode,discount,disp1,disp2,disp3)
				{
				var dataString = 'trancode='+trancode+'&uuid='+uuid+'&disamt_bil1='+discount+'&disp1='+disp1+'&disp2='+disp2+'&disp3='+disp3;
				
				
				$.ajax({
					type:"POST",
					url:"changediscountprocess.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){

					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changediscount');
					}
				});
				
			}
			
			function updatediscount2(e,uuid,trancode,discount,disp1,disp2,disp3)
			{
			if(e.keyCode==13){


			var dataString = 'trancode='+trancode+'&uuid='+uuid+'&disamt_bil1='+discount+'&disp1='+disp1+'&disp2='+disp2+'&disp3='+disp3;
				
				$.ajax({
					type:"POST",
					url:"changediscountprocess.cfm",
					data:dataString,
					dataType:"html",
					cache:false,
					success: function(result){

					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						recalculateamt();
						ColdFusion.Window.hide('changediscount');
					}
				});
			}
			}
			
			
			function getfocus4()
			{

			setTimeout("document.getElementById('price_bil1').select();",500);

			}

			function getfocus5()
			{

			setTimeout("document.getElementById('qty_bil1').select();",500);

			}

			function getfocus6()
			{

			setTimeout("document.getElementById('disp1').select();",500);

			}
                    
            function checkall(checkboxType)<!---function to select checkbox--->
            {
                if(checkboxType == "checkAll")
                {
                    if($('##checkAll').is(":checked") == true)
                    {
                        $(".deleteall").prop("checked",true);
                    }
                    else
                    {
                        $(".deleteall").prop("checked", false);
                    }
                }

            }
			
            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function() {scrollFunction()};

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    document.getElementById("myBtn").style.display = "block";
                } else {
                    document.getElementById("myBtn").style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0; // For Safari
                document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
            }
			
    </script>
    <style>
    ##myBtn {
        display: none; /* Hidden by default */
        position: fixed; /* Fixed/sticky position */
        bottom: 20px; /* Place the button at the bottom of the page */
        right: 30px; /* Place the button 30px from the right */
        z-index: 99; /* Make sure it does not overlap */
        border: none; /* Remove borders */
        outline: none; /* Remove outline */
        background-color: ##357ebd; /* Set a background color */
        color: white; /* Text color */
        cursor: pointer; /* Add a mouse pointer on hover */
        padding: 15px; /* Some padding */
        border-radius: 10px; /* Rounded corners */
        font-size: 15px; /* Increase font size */
    }

    ##myBtn:hover {
        background-color: ##428bca; /* Add a dark-grey background on hover */
    }
        
    </style>
</cfoutput>
    
	
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
	
	
    
</head>

<body class="container">
    <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<cfoutput>

<!-- Modal -->
  <div class="modal fade" id="AlertModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Note</h4>
        </div>
        <div class="modal-body" id='Msg'>
          <p></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

<cfform id="form" name="form" class="form-horizontal"  action="process.cfm" method="post" >
	<div class="page-header">
		<h3>Create <cfif tran eq "CN">Credit Note<cfelse>Debit Note</cfif></h3>
		<input type="hidden" name="uuid" id="uuid" value="#uuid#">
		<input type="hidden" name="tran" id="tran" value="#tran#">
		<input type="hidden" name="hidtrancode" id="hidtrancode" value="">
        <input type="hidden" name="selected" id="selected" value="">
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Details</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	<div class="form-group">
										<label for="refno" class="col-sm-2 control-label" style="display:none">#url.tran# number</label>
										<div class="col-sm-4" style="display:none">
										
											<cfinput type="text" class="form-control input-sm" id="refno" name="refno"  placeholder="PO Number" value="#nexttranno#" readonly required="true" message="Please Key In PO Number">									
										</div>
										<label for="wos_date" class="col-sm-2 control-label">Date</label>
										<div class="col-sm-2">
											<div class="input-group date">       
                                                <input type="text" class="form-control input-sm" id="wos_date" name="wos_date" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>											
										</div>
                                        <label for="reason" class="col-sm-3 control-label">Reason</label>
                                        <div class="col-sm-3">
                                            <input type="text" id="reason" name="reason" value="" />
                                        </div>
									</div>
                                    
                                    <div class="form-group">
                                        <label for="custno" class="col-sm-2 control-label">Customer No</label>
                                        <div class="col-sm-10">
                                            <input type="hidden" id="custno" name="custno" class="customerFilter" value="" placeholder="Customer" />
                                        </div>
										
									</div>
                                    
                                    <cfif lcase(tran) eq 'dn'>
                                    <div class="form-group">
										<label for="custno" class="col-sm-2 control-label">New Customer No. <br>(If Any Changes, Optional)</label>
                                        <div class="col-sm-10">
                                            <input type="hidden" id="newcustno" name="newcustno" class="customerFilter" value="" placeholder="Customer" />
                                        </div>
										
									</div>
                                    </cfif>
                                        
									
									<div class="form-group">
										<label for="invoiceno" class="col-sm-2 control-label">MP4U Invoice</label>
                                        <div class="col-sm-3">
                                            <input type="hidden" id="invoiceno" name="invoiceno" class="invoiceFilter" value="" placeholder="Search MP4U Invoice" />
                                        </div>
									</div>
                                    <div class="form-group">
										<label for="bosinvoiceno" class="col-sm-2 control-label">BOS Invoice</label>
                                        <div class="col-sm-3">
                                            <input type="text" id="bosinvoiceno" name="bosinvoiceno" value="" placeholder="Key in BOS Invoice Here" />
                                        </div>
										<div class="col-sm-1">
                                            <input type="button"  class="form-control input-sm" id="addinvbtn" name="addinvbtn" value="Add" />
                                        </div>
									</div>
									

            					</div>
            				</div>
                		</div>
						<form>
							<!---<div class="row" id="body_section">  
								<table class="itemTable">
									<thead>
										<tr class="itemTableTR">
											<th class="th_one itemTableTH">Invoice Number</th>
											<th class="th_two itemTableTH">Item Number</th>
											<th class="th_three itemTableTH">Description</th>
											<th class="th_four itemTableTH">Quantity</th>
											<th class="th_five itemTableTH">Price</th>
											<th class="th_six itemTableTH">Amount</th>
                                            <th class="th_two itemTableTH">Placement No.</th> 
											<th class="th_seven itemTableTH">Action</th>
										</tr>
									</thead>
									<tbody id="item_table_body">
                                    <tr class="itemTableList">
                                        <td colspan="2">
                                            <div class="col-sm-12">
                                                <input type="hidden" id="itemno" name="itemno" class="itemFilter" value="" placeholder="Select an item" />
                                            </div>
                                        </td>
                                        <td class="td_three">
                                        <div class="col-sm-9">
                                        <input type="text" id="desp" name="desp" value="" placeholder="Item description" />
                                        </div>
                                        </td>
                                        <td class="td_four">
                                        <div class="col-sm-9">
                                        <input type="number" id="qty" name="qty" step="0.01" value="1" min="1" max="5"/>
                                        </div>
                                        </td>
                                        <td class="td_five">
                                        <div class="col-sm-9">
                                        <input type="number" id="price" name="price" step="0.01" value="0.00" min="1" max="5" onkeyup="calcamount()"/>
                                        </div>
                                        </td>
                                        <td class="td_six">
                                        <div class="col-sm-9">
                                        <input type="number" id="amount" name="amount" step="0.01" value="0.00" min="1" max="5"/>
                                        </div>
                                        </td>
                                        <td>
                                            <input type="hidden" id="addsingleJO" name="addsingleJO" class="JOFilter" value="" placeholder="Select a placement"/>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td colspan="2">
                                    Period Start:<br />
                                    <div class="col-sm-12">
                                        <div class="input-group date">       
                                            <input type="text" class="form-control input-sm" id="startdate" name="startdate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>											
                                    </div>
                                    </td>
                                    <td colspan="2">
                                    Period End:<br /> 
                                    <div class="col-sm-12">
                                        <div class="input-group date">       
                                            <input type="text" class="form-control input-sm" id="completedate" name="completedate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>											
                                    </div>
                                    </td>
                                    <td colspan="2">
                                    <div class="col-sm-12">
                                        <input type="hidden" id="assignrefno" name="assignrefno" class="AssignFilter" value="" placeholder="Select a assignmentslip" />
                                    </div>
                                    </td>
                                    <td class="td_seven" colspan="2">
                                        <div class="col-sm-12">
                                        <input type="button" class="form-control input-sm"  id="additembtn" name="additembtn" onclick="document.getElementById('additembtn').disabled = true;" value="Add Item" />
                                        </div>
                                    </td>
                                    </tr>
                                </tbody>
								</table>
							</div>--->
                            <cfinclude template="creditnotetablebody.cfm">
						</form> 
						
						<div class="panel-body " >
							<div class="row">
								<div class="col-sm-12"> 
                                 	<div class="form-group">
										<div class="col-sm-5">
										</div>
										<label for="gross" class="col-sm-2 control-label">Gross Amount</label>
										<div class="col-sm-3">
										</div>
										<div class="col-sm-2">
											<cfinput type="text" class="form-control input-sm" id="gross" name="gross"  placeholder="Gross Amount" value="0.00" readonly>									
										</div>
									</div>
									
									<div class="form-group" style="display:none">
										<div class="col-sm-5">
										</div>
										<label for="disamt_bil" class="col-sm-2 control-label">Discount</label>
										<div class="col-sm-1"></div>
										<div class="col-sm-2">
											<div class="col-sm-9">
											<cfinput type="text" name="dispec1" id="dispec1" class="form-control input-sm" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();" /><input type="hidden" name="disbil1" id="disbil1" />
											</div>
											<label for="disp" class="col-sm-2 control-label">%</label>
											</div>
											<cfinput type="hidden" name="dispec2" id="dispec2" class="form-control input-sm" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil2" id="disbil2" />
											<cfinput type="hidden" name="dispec3" id="dispec3" class="form-control input-sm" value="0" validate="float" validateat="onblur" message="Please key in numeric value" onKeyUp="calcdisc();caltax();calcfoot();"/><input type="hidden" name="disbil3" id="disbil3" />
										
										<div class="col-sm-2">
											<cfinput type="text" class="form-control input-sm" id="disamt_bil" name="disamt_bil"  placeholder="Discount Amount" value="0.00">		
											</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">
										</div>
										<label for="net" class="col-sm-2 control-label">Net</label>
										<div class="col-sm-3">
										</div>
										<div class="col-sm-2">
											<cfinput type="text" class="form-control input-sm" id="net" name="net"  placeholder="Net" value="0.00" readonly>									
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">
										</div>
										<label for="tax" class="col-sm-2 control-label">Tax</label>
										<div class="col-sm-3">
										<cfif getgsetup.wpitemtax neq "1">
											  <cfquery name="getTaxCode" datasource="#dts#">
											  SELECT "" as code, "" as rate1
											  union all
											  SELECT code,rate1 FROM #target_taxtable#
											  </cfquery>
											  <cfquery name="getdf" datasource="#dts#">
													SELECT df_salestax,df_purchasetax FROM gsetup
													</cfquery>
													
													<cfquery name="taxrate" datasource="#dts#">
													
													<cfif (tran eq 'RC' or tran eq 'PO' or tran eq 'PR') and getdf.df_purchasetax neq "">
													SELECT 
													"#getdf.df_purchasetax#" as code
													 union all
													<cfelseif tran eq 'DN' or tran eq 'CN'>
													<cfelseif getdf.df_salestax neq "">
													SELECT 
													"#getdf.df_salestax#" as code
													 union all
													</cfif>
													SELECT code FROM #target_taxtable# 
													<cfif tran eq 'RC' or tran eq 'PO' or tran eq 'PR' >
													WHERE tax_type <> "ST"
													<cfif getdf.df_purchasetax neq "">
													and code <> "#getdf.df_purchasetax#"
													</cfif>
													<cfelseif tran eq 'DN' or tran eq 'CN' >
													<cfelse>
													WHERE tax_type <> "PT"
													<cfif getdf.df_purchasetax neq "">
													and code <> "#getdf.df_salestax#"
													</cfif>
													</cfif>
													</cfquery>
												<div class="col-sm-2">
												<input type="checkbox" name="taxincl" id="taxincl" value="T" onClick="caltax()" <cfif getgsetup.taxincluded eq "Y">checked </cfif> />
												</div>
												<div class="col-sm-5">
												
												<cfselect name="taxcode" class="form-control input-sm" id="taxcode" query="taxrate" value="code" display="code" onChange="setTimeout('caltax()',500);" bindonload="yes"/>
												</div>
												<div class="col-sm-5">
												<cfinput type="text" name="taxper" id="taxper" class="form-control input-sm" value="0" size="8" bind="CFC:tax.getTax('#dts#','#target_taxtable#',{taxcode})" onKeyUp="caltax()" bindonload="yes" />
												</div>
										<cfelse>
											<div class="col-sm-5">
												<input type="text" class="form-control input-sm" name="taxcode" id="taxcode" value="SR" readonly>
                                            </div>
                                            <div class="col-sm-5">
												<select class="form-control input-sm" name="taxper" id="taxper" onchange="recalculateamt()" disabled>
                                                    <option id="6" value="6">6%</option>
                                                    <option id="0" value="0">0%</option>
                                                </select>
											</div>
										</cfif>
										</div>
										<div class="col-sm-2">
										<cfinput type="text" name="taxamt" id="taxamt" class="form-control input-sm" value="0.00" size="10" onKeyUp="calcfoot();" readonly />  
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-5">
										</div>
										
										<label for="gross_bil" class="col-sm-2 control-label">Grand</label>
										<div class="col-sm-3">
										</div>
										<div class="col-sm-2">
											<cfinput type="text" class="form-control input-sm" id="grand" name="grand"  placeholder="Grand Amount" value="0.00" readonly>									
										</div>
									</div>
            					</div>
            				</div>
                		</div>
						
						
                	</div>					
				</div>
				 
			</div>
			
            <hr>
            <div class="pull-right">
				<input type="button" name="Submit" id="Submit" value="Create" onClick="this.disabled=true;var tran = document.getElementById('tran').value;
                var reason = trim(document.getElementById('reason').value);
                if(document.getElementById('wos_date').value == ''){
                    $('##Msg').html('Please select a '+'Date'.bold()+' in order to create '+tran.toUpperCase());
                    $('##AlertModal').modal();  
                    this.disabled=false;
                }else if(document.getElementById('custno').value == ''){
                    $('##Msg').html('Please select a '+'Customer'.bold()+' in order to create '+tran.toUpperCase());
                    $('##AlertModal').modal();
                    this.disabled=false;
                }else if(reason == ''){
                    $('##Msg').html('Please enter a '+'Reason'.bold()+' in order to create '+tran.toUpperCase());
                    $('##AlertModal').modal();
                    this.disabled=false;
                }else if(reason.length > 450){
                    $('##Msg').html('Reason has more than 450 characters');
                    $('##AlertModal').modal();
                    this.disabled=false;
                }else if(document.getElementById('gross').value == 0){
                    $('##Msg').html('The Gross Amount is '+'0.00'.bold()+'. Please add items to create '+tran.toUpperCase());
                    $('##AlertModal').modal();
                    this.disabled=false;
                }else{                                                                                       
				document.getElementById('custno').disabled = false;
                if(tran.toLowerCase() == 'dn')document.getElementById('newcustno').disabled = false;
				document.getElementById('invoiceno').disabled = false;
                document.getElementById('form').submit();
                };" class="btn btn-primary">
				<input type="button" value="Cancel" onclick="window.location=''" class="btn btn-default" />
            </div>
        
</cfform>

</cfoutput>
</body>
</html>
<cfoutput>
<cfwindow  width="500" height="200" name="changeprice" refreshOnShow="true"  modal="true" RESIZABLE="true" title="Edit Price" initshow="false" source="changeprice.cfm?trancode={hidtrancode}&uuid=#uuid#" />
<cfwindow  width="500" height="200" name="changeqty" refreshOnShow="true"  modal="true" RESIZABLE="true" title="Edit Qty" initshow="false" source="changeqty.cfm?trancode={hidtrancode}&uuid=#uuid#" />
<cfwindow  width="500" height="700" name="changediscount" refreshOnShow="true"  modal="true" title="Edit Discount" initshow="false" source="changediscount.cfm?trancode={hidtrancode}&uuid=#uuid#" />
</cfoutput>

<cfinclude template="checkinv.cfm">	
                                        
                                        
