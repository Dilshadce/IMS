<cfoutput>
<div id="checkicfield"></div>
<!---<script type="text/javascript" src="/javascripts/prototypenew.js"></script>--->
<script type="text/javascript">
function checkinv(invoiceno,type)
{
	/*var ajaxurl = 'checkinvprocess.cfm?invoiceno='+invoiceno+'&type='+type;
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
		if(document.getElementById('invoiceexist').value != '')
		{
			if(confirm('Duplicate '+type.uppercase().bold()+' Found!\n\n'+document.getElementById('invoiceexist').value+'\n\nAre You sure you want to continue?') == false)
            {
            document.getElementById('invoiceno').value = '';
            }
		
		}
        }
      })*/
    
    var dataString = 'invoiceno='+invoiceno+'&type='+type;
    
    $.ajax({
            type:"get",
            url:'checkinvprocess.cfm',
            data:dataString,
            dataType:"html",
            cache:false,
            success: function(data){
                document.getElementById('checkicfield').innerHTML = data;
            },
            error: function(jqXHR,textStatus,errorThrown){
                alert(errorThrown);
            },
            complete: function(){
                var invresult = $('##invoiceexist').val();
                if(invresult != '')
                {
                    if(confirm('Duplicate '+type.toUpperCase()+' Found!\n\n'+invresult+'\n\nAre You sure you want to continue?') == false)
                    {
                    document.getElementById('invoiceno').value = '';
                    }

                }
            }
        });
}
</script>
</cfoutput>