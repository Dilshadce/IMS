function auto_fill_discount_value()
{
	var view_grand = document.getElementById("viewGrand").value;
	var sub_total = document.getElementById("subtotal").value;
	var total_amt_disc = 0;
	
	if(isNaN(view_grand))
	{
		alert("The value is not a number. Please try again !");
		document.getElementById("viewGrand").value = document.getElementById("viewGrand").value;
		
	}
	else
	{
		total_amt_disc = sub_total - view_grand;
		document.getElementById("totalamtdisc").value = total_amt_disc;
		setTimeout("getDiscount();", 1000);
	}
}