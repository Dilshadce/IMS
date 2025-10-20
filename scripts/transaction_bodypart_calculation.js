function getDiscountControl()
{
	var d1=document.form1.dispec1;
	var d2=document.form1.dispec2;
	var d3=document.form1.dispec3;
	var ttld=document.form1.discamt;
	
	try
	{
		if(isNaN(d1.value) || isNaN(d2.value) || isNaN(d3.value) || isNaN(ttld.value))
		{
			alert("The value is not a number. Please try again");
			
			if(isNaN(d1.value))
			{
				d1.value="";
			}
			else if(isNaN(d2.value))
			{
				d2.value="";
			}
			else if(isNaN(d3.value))
			{
				d3.value="";
			}
			else
			{	
				ttld.value="";
			}
			getDiscountControl();
		}
		else if(((d1.value*1)+(d2.value*1)+(d3.value*1))>(document.form1.discountlimit.value*1) && document.getElementById('discountlimitcontrol').value=="0")
		{
			ColdFusion.Window.show('discvalidatepass');
			d1.value="0";
			d2.value="0";
			d3.value="0";

			getDiscountControl();

			
		}

		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))!=0)
		{
			ttld.readOnly=true;
			ttld.style.backgroundColor="#FFFF99";
			getDiscount();
		}
		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))==0 && window.event.srcElement.id!="discamt_id")
		{
			ttld.value=0;
			ttld.readOnly=false;
			ttld.style.backgroundColor="";
			getDiscount();
		}
		else
		{
			if(window.event.srcElement.id=="discamt_id")
			{
				ttld.readOnly=false;
				ttld.style.backgroundColor="";
				getDiscount();
			}
		}
	}
	
	catch(err)
	{
		ttld.readOnly=false;
		ttld.style.backgroundColor="";
		getDiscount();
	}
	
}

function getDiscountControl2()
{
	var d1=document.form1.dispec1;
	var d2=document.form1.dispec2;
	var d3=document.form1.dispec3;
	var ttld=document.form1.discamt;
	
	try
	{
		if(isNaN(d1.value) || isNaN(d2.value) || isNaN(d3.value) || isNaN(ttld.value))
		{
			alert("The value is not a number. Please try again");
			
			if(isNaN(d1.value))
			{
				d1.value="";
			}
			else if(isNaN(d2.value))
			{
				d2.value="";
			}
			else if(isNaN(d3.value))
			{
				d3.value="";
			}
			else
			{	
				ttld.value="";
			}
			getDiscountControl();
		}
		
		else if(((d1.value*1)+(d2.value*1)+(d3.value*1))>(document.form1.discountlimit.value*1) && document.getElementById('discountlimitcontrol').value=="0")
		{
			
			ColdFusion.Window.show('discvalidatepass');
			d1.value="0";
			d2.value="0";
			d3.value="0";

			getDiscountControl();

			
		}

		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))!=0)
		{
			ttld.readOnly=true;
			ttld.style.backgroundColor="#FFFF99";
			getDiscount();
		}
		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))==0 && window.event.srcElement.id!="discamt_id")
		{
			ttld.value=0;
			ttld.readOnly=true;
			ttld.style.backgroundColor="#FFFF99";
			getDiscount();
		}
		else
		{
			if(window.event.srcElement.id=="discamt_id")
			{
				ttld.readOnly=true;
				ttld.style.backgroundColor="#FFFF99";
				getDiscount();
			}
		}
	}
	
	catch(err)
	{
		ttld.readOnly=true;
		ttld.style.backgroundColor="#FFFF99";
		getDiscount();
	}
	
}

function getDiscountControl3()
{
	var d1=document.form1.dispec1;
	var d2=document.form1.dispec2;
	var d3=document.form1.dispec3;
	var ttld=document.form1.discamt;
	
	try
	{
		if(isNaN(d1.value) || isNaN(d2.value) || isNaN(d3.value) || isNaN(ttld.value))
		{
			alert("The value is not a number. Please try again");
			
			if(isNaN(d1.value))
			{
				d1.value="";
			}
			else if(isNaN(d2.value))
			{
				d2.value="";
			}
			else if(isNaN(d3.value))
			{
				d3.value="";
			}
			else
			{	
				ttld.value="";
			}
			getDiscountControl3();
		}

		else if(((d1.value*1)+(d2.value*1)+(d3.value*1))>(document.form1.discountlimit.value*1) && document.getElementById('discountlimitcontrol').value=="0")
		{

			ColdFusion.Window.show('discvalidatepass');
			d1.value="0";
			d2.value="0";
			d3.value="0";

			getDiscountControl3();

			
		}

		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))!=0)
		{
			ttld.readOnly=true;
			ttld.style.backgroundColor="#FFFF99";
			getDiscount2();
		}
		else if((parseFloat(d1.value)+parseFloat(d2.value)+parseFloat(d3.value))==0 && window.event.srcElement.id!="discamt_id")
		{
			ttld.value=0;
			ttld.readOnly=false;
			ttld.style.backgroundColor="";
			getDiscount2();
		}
		else
		{
			if(window.event.srcElement.id=="discamt_id")
			{
				ttld.readOnly=false;
				ttld.style.backgroundColor="";
				getDiscount2();
			}
		}
	}
	
	catch(err)
	{
		ttld.readOnly=false;
		ttld.style.backgroundColor="";
		getDiscount2();
	}
	
}

function getDiscount2()
{
	var subtotal=document.form1.price.value;
	var oldprice = parseFloat(subtotal).toFixed(fixnum);
	var qty=document.form1.qty.value;
	var d1=document.form1.dispec1.value;
	var d2=document.form1.dispec2.value;
	var d3=document.form1.dispec3.value;
	var ttld=document.form1.discamt.value;
	var totaldiscount=0;
	var temp=0;
	
	if((parseFloat(d1)+parseFloat(d2)+parseFloat(d3))!=0)
	{
		temp=((subtotal)-((subtotal)*((100-d1)/100)).toFixed(fixnumdisc));
		totaldiscount=temp;
		temp=(subtotal-totaldiscount).toFixed(fixnumdisc);
		
		temp=((temp)-(temp*((100-d2)/100)).toFixed(fixnumdisc));
		
		totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(fixnumdisc);
		
		temp=(subtotal-totaldiscount).toFixed(fixnumdisc);
		temp=((temp)-(temp*((100-d3)/100)).toFixed(fixnumdisc));
		
		var oriprice = (parseFloat(oldprice)-(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(fixnumdisc)).toFixed(fixnumdisc)*qty;
		totaldiscount= ((parseFloat(oldprice) * qty) - parseFloat(oriprice)).toFixed(fixnumdisc);
		//totaldiscount=((parseFloat(totaldiscount)+parseFloat(temp)).toFixed(fixnumdisc)*qty).toFixed(fixnumdisc);
	}
	else
	{
		totaldiscount=ttld;
	}
	document.form1.discamt.value=totaldiscount;
	getTax();
}



function getDiscount()
{
	var subtotal=document.form1.amt.value;
	var d1=document.form1.dispec1.value;
	var d2=document.form1.dispec2.value;
	var d3=document.form1.dispec3.value;
	var ttld=document.form1.discamt.value;
	var totaldiscount=0;
	var temp=0;
	
	if((parseFloat(d1)+parseFloat(d2)+parseFloat(d3))!=0)
	{
		temp=(subtotal*d1/100).toFixed(fixnum);
		totaldiscount=temp;
		temp=(subtotal-totaldiscount).toFixed(fixnum);
		temp=(temp*d2/100).toFixed(fixnum);
		totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(fixnum);
		temp=(subtotal-totaldiscount).toFixed(fixnum);
		temp=(temp*d3/100).toFixed(fixnum);
		totaldiscount=(parseFloat(totaldiscount)+parseFloat(temp)).toFixed(fixnumdisc);
	}
	else
	{
		totaldiscount=ttld;
	}
	document.form1.discamt.value=totaldiscount;
	getTax();
}

function checkqty(){
	if(parseFloat(document.form1.qty.value) > 0 || parseFloat(document.form1.qty.value) < 0){
		var temp_amt = parseFloat(document.form1.qty.value) * parseFloat(document.form1.pri6.value);
		document.form1.amt.value = temp_amt.toFixed(2);
		if(document.form1.enableeditamount.value == 0){ 
		document.form1.amt.readOnly =true;
		}
		else
		{
		document.form1.amt.readOnly =false;	
		}
	}else if(parseFloat(document.form1.qty.value) == 0){
		document.form1.amt.value = 0;
		document.form1.amt.readOnly =false;
	}
	getDiscount();
	getTax1();
}

function checkqtybsssb(){
	if(parseFloat(document.form1.crequestdate.value) > 0 || parseFloat(document.form1.crequestdate.value) < 0){
		var temp_amt = parseFloat(document.form1.crequestdate.value) * parseFloat(document.form1.pri6.value);
		document.form1.amt.value = ((Math.floor(temp_amt*100))/100).toFixed(2);
		if(document.form1.enableeditamount.value == 0){ 
		document.form1.amt.readOnly =true;
		}
		else
		{
		document.form1.amt.readOnly =false;	
		}
	}else if(parseFloat(document.form1.qty.value) == 0){
		document.form1.amt.value = 0;
		document.form1.amt.readOnly =false;
	}
	getDiscount();
	getTaxbsssb();
}

function checkqtytopsteel(){
	if(parseFloat(document.form1.qty.value) > 0){
		var temp_amt = parseFloat(document.form1.qty.value) * parseFloat(document.form1.pri6.value);
		document.form1.amt.value = temp_amt.toFixed(2); 
		document.form1.amt.readOnly =false;

			
	}else if(parseFloat(document.form1.qty.value) == 0){
		document.form1.amt.value = 0;
		document.form1.amt.readOnly =false;
	}
	getDiscount();
	getTax1();
}

function getTax(){
	var subtotal=parseFloat(document.form1.amt.value);
	var totaldiscount=parseFloat(document.form1.discamt.value);
	var ptax=parseFloat(document.form1.taxpec1.value);
	subtotal=subtotal-totaldiscount;
	var temp=0;
	if(document.form1.taxincl.checked==true){
		temp=(subtotal*ptax/(100+ptax)).toFixed(2);
		document.form1.itemtotalamt.value = (subtotal - temp).toFixed(2);
		
	}else{
		temp=(subtotal*ptax/100).toFixed(2);
		document.form1.itemtotalamt.value = (parseFloat(subtotal) + parseFloat(temp)).toFixed(2);
	}
	document.form1.taxamt_bil.value=temp;
	try{
		getIndoTax()
	}
	catch(err){
	}
}

/*
 * Function: Calculate Indonesia Tax, PPH
 */
function getIndoTax(){
	var subtotal=parseFloat(document.form1.amt.value);
	var totaldiscount=parseFloat(document.form1.discamt.value);
	var ptax=parseFloat(document.form1.selectPPH.options[document.form1.selectPPH.selectedIndex].title);
	
	if(isNaN(ptax)){
		document.getElementById('pph_amt_bil').value=0.00;	
	}
	else{
		subtotal=subtotal-totaldiscount;
		var temp=0;
		if(document.form1.taxincl.checked==true){
			temp=(subtotal*ptax/(100+ptax)).toFixed(2);		
		}else{
			temp=(subtotal*ptax/100).toFixed(2);
		}
		document.getElementById('pph_amt_bil').value=temp;	
	}
}

function getTax1(){
	if(parseFloat(document.form1.qty.value) > 0){
		var temp_amt = (parseFloat(document.form1.qty.value) * parseFloat(document.form1.pri6.value))+0.000001;
		document.form1.amt.value = temp_amt.toFixed(2); 
			
	}else if(parseFloat(document.form1.qty.value) == 0){
		document.form1.amt.value = 0;
		document.form1.amt.readOnly =false;
	}
	
	getDiscount();
	var subtotal=parseFloat(document.form1.amt.value);
	var totaldiscount=parseFloat(document.form1.discamt.value);
	var ptax=parseFloat(document.form1.taxpec1.value);
	subtotal=subtotal-totaldiscount;
	var temp=0;
	if(document.form1.taxincl.checked==true){
		temp=(subtotal*ptax/(100+ptax)).toFixed(2);
		document.form1.itemtotalamt.value = (subtotal - temp).toFixed(2);
	}else{
		temp=(subtotal*ptax/100).toFixed(2);
		document.form1.itemtotalamt.value = (parseFloat(subtotal) + parseFloat(temp)).toFixed(2);
	}
	document.form1.taxamt_bil.value=temp;
}

function getTaxbsssb(){
	if(parseFloat(document.form1.crequestdate.value) > 0){
		var temp_amt = (parseFloat(document.form1.crequestdate.value) * parseFloat(document.form1.pri6.value))+0.000001;
		document.form1.amt.value = ((Math.floor(temp_amt*100))/100).toFixed(2);
			
	}else if(parseFloat(document.form1.crequestdate.value) == 0){
		document.form1.amt.value = 0;
		document.form1.amt.readOnly =false;
	}
	
	getDiscount();
	var subtotal=parseFloat(document.form1.amt.value);
	var totaldiscount=parseFloat(document.form1.discamt.value);
	var ptax=parseFloat(document.form1.taxpec1.value);
	subtotal=subtotal-totaldiscount;
	var temp=0;
	if(document.form1.taxincl.checked==true){
		temp=(subtotal*ptax/(100+ptax)).toFixed(2);
		document.form1.itemtotalamt.value = (subtotal - temp).toFixed(2);
	}else{
		temp=(subtotal*ptax/100).toFixed(2);
		document.form1.itemtotalamt.value = (parseFloat(subtotal) + parseFloat(temp)).toFixed(2);
	}
	document.form1.taxamt_bil.value=temp;
}

function getTaxControl()
{
	var ptax=document.form1.taxpec1;
	var ttltax=document.form1.taxamt_bil;
	var stax=document.form1.selecttax.value;

	if(stax!="ZR" && stax!="NTAX" && stax!="ZPTAX" && stax!="ZSTAX")
	{
		ptax.value=gstvalue;
	}
	else{
		ptax.value=0;
	}
	getTax();
}