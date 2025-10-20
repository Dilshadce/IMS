function getCashCount()
{
	var cash=document.getElementById("cash").value;
	var cheque=!isNaN(parseFloat(document.getElementById("cheque").value)) ? parseFloat(document.getElementById("cheque").value) : 0;
	var cashcd=!isNaN(parseFloat(document.getElementById("cashcd").value)) ? parseFloat(document.getElementById("cashcd").value) : 0;

	var credit_card1=!isNaN(parseFloat(document.getElementById("credit_card1").value)) ? parseFloat(document.getElementById("credit_card1").value) : 0;
	var credit_card2=!isNaN(parseFloat(document.getElementById("credit_card2").value)) ? parseFloat(document.getElementById("credit_card2").value) : 0;
	var debit_card=!isNaN(parseFloat(document.getElementById("debit_card").value)) ? parseFloat(document.getElementById("debit_card").value) : 0;
	var telegraph_transfer=!isNaN(parseFloat(document.getElementById("telegraph_transfer").value)) ? parseFloat(document.getElementById("telegraph_transfer").value) : 0;
	var gift_voucher=!isNaN(parseFloat(document.getElementById("gift_voucher").value)) ? parseFloat(document.getElementById("gift_voucher").value) : 0;
	var dep=!isNaN(parseFloat(document.getElementById("deposit").value)) ? parseFloat(document.getElementById("deposit").value) : 0;
	var grand=parseFloat(document.getElementById("viewGrand").value);
	var debt=0;
	
	if(cash=="")
	{
		debt=(grand-cheque-cashcd-credit_card1-credit_card2-telegraph_transfer-gift_voucher-dep-debit_card).toFixed(fixnum);
	}
	else if(isNaN(cash))
	{
		alert("The value is not a number. Please try again");
		document.getElementById("cash").value=cash.substr(0,cash.length-1);
		cash=!isNaN(parseFloat(document.getElementById("cash").value)) ? parseFloat(document.getElementById("cash").value) : 0;
		debt=(grand-cash-cheque-cashcd-credit_card1-credit_card2-telegraph_transfer-gift_voucher-dep-debit_card).toFixed(fixnum);
	}
	else
	{
		debt=(grand-cash-cheque-cashcd-credit_card1-credit_card2-telegraph_transfer-gift_voucher-dep-debit_card).toFixed(fixnum);
	}
	
	document.getElementById("debt").value=debt;
	

}