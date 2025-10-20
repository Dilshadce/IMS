<script>

		var toword='77575.10';
		
		var th = ['','thousand','million', 'billion','trillion'];
		var dg = ['zero','one','two','three','four', 'five','six','seven','eight','nine']; 
		var tn = ['ten','eleven','twelve','thirteen', 'fourteen','fifteen','sixteen', 'seventeen','eighteen','nineteen'];
		var tw = ['twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety']; 
		var s = toword; 		
		var x = s.substr(0,s.indexOf(".")).length;	
		var z = s.substr(0,x);    		
		var zd = s.substr(parseFloat(x+1),2);
		var w_num = new Array();
			for(var i=0; i<x; i++){
				w_num.push(s.substr(i,1));	
			}
		var cents_p = s.substr(x+2,2);
		var sk = 0;
		var d_sk = 0;
		var c = 0;
		var finalOutput = new Array();  
		
		if(s <= 0){
        	str = 'Negative';
		 	s = Abs(s);
		 	s = val(s);
      	}
		else{	
			str = '';
      	}

		if (s != 0){	
			for (var i=1; i <=5; i++){
				alert(1);
				
				if (zd == 00){
				   if(c = 1){    
						str = str.push("and ");
						alert(1);
				   }
				}
				
				if (((x+1)-i) % 3 == 2){
					
					if (w_num[i] == '1'){
						finalOutput.push(tn[w_num[i+1]+1]);
						finalOutput.push(' ');
						i=i+1; 
						sk=1;
						alert(2);
					}
					else if (w_num[i] != 0){
						var value = tw[w_num[i]-2];
						finalOutput.push(value.toString());
						finalOutput.push(' ');
						sk=1;
						alert(3);
					}  
					c=c+1;
				}

				else if (w_num[i] != -1){
					alert(4);
					finalOutput.push(dg[w_num[i]+1]);
					finalOutput.push(' ');
					
					if (((x+1)-i) % 3 == 0) {
						finalOutput.push("hundred ");	 
					}
					sk=1; 
					c=c+1;
				}
				
				else if (w_num[i] == -1){
					alert(5);
					c=c+1;
				}
				
				/*if (((x-i)-2) % 3 == 1){
					if (sk){
						str = listAppend(str, th[((x-i)/3)+1]); 
						str = listAppend(str, ' '); 
					}
					sk=0;
					c=0;
				}*/
			}
			
			if (zd != 00){
				if (x != len(s)){
					
					y = len(s);
					
					if (z != 0){
						finalOutput.push("and ");
					}
					
					for (i=1; i <= 2; i=i+1){
						if ((3-i) % 3 == 2){
							if (d_num.indexOf(i) == '1'){
								finalOutput.push(tn[d_num.indexOf(i+1)+1]); 
								i=i+1; 
								d_sk=1;
							} 
							else if (d_num.indexOf(i) != 0){
								finalOutput.push(tw[d_num.indexOf(i)-1]); 
								d_sk=1;
							}
						}
						else if (d_num.indexOf(i) != 0){
							finalOutput.push(dg[d_num.indexOf(i)+1]);
							d_sk=1;
						} 
					}
					
					if (zd == 01){
						finalOutput.push(' cent');
					}
					else {
						finalOutput.push(' cents');
					}
				}
			}
			<!---if(len(str) != 0){ 
				if(right(str,4) = 'and '){
					intstr=Len(str);
					countstr=intstr-4;
					str=Left(str,countstr);
				}
			}
			str = listAppend(str, ' only');
			toword = Replace(str, ",", "", "All");--->
			
			alert(finalOutput[0]);
	}
	
</script>

<cfoutput>
	<cfset s = '77575.10'>
    <cfset x = Find('.', s)-1>
    <cfset z = MID(s,'1','5')>	
    <cfset w_num = REReplace(s, "[T]*",",","ALL")> 	
    <cfset cents_p = MID(s, x+2, 2)>
    <cfset d_num = REReplace(cents_p, "[T]*",",","ALL")> 		
    
    s: #s# 						<br />
    x: #x# 						<br />
    z: #z#						<br />
    zd: #MID(s, x+2, 2)#		<br />
    cents_p: #cents_p#	<br />
    
    w_num: #w_num#											<br />
	w_num2: #RemoveChars(w_num, ((len(s)*2)+1), 1)#			<br />
	w_num3: #RemoveChars(w_num, 1, 1)#						<br />
    
    d_num = #d_num#											<br />
    d_num = #RemoveChars(d_num, ((len(cents_p)*2)+1), 1)#	<br />
    d_num = #RemoveChars(d_num, 1, 1)#						<br />
    
</cfoutput>