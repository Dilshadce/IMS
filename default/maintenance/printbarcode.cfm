<link rel="StyleSheet" href="barcode.css" type="text/css" />

<script type="text/javascript">
	BARS   = [212222,222122,222221,121223,121322,131222,122213,122312,132212,221213,221312,231212,112232,122132,122231,113222,123122,123221,223211,221132,221231,213212,223112,312131,311222,321122,321221,312212,322112,322211,212123,212321,232121,111323,131123,131321,112313,132113,132311,211313,231113,231311,112133,112331,132131,113123,113321,133121,313121,211331,231131,213113,213311,213131,311123,311321,331121,312113,312311,332111,314111,221411,431111,111224,111422,121124,121421,141122,141221,112214,112412,122114,122411,142112,142211,241211,221114,413111,241112,134111,111242,121142,121241,114212,124112,124211,411212,421112,421211,212141,214121,412121,111143,111341,131141,114113,114311,411113,411311,113141,114131,311141,411131,211412,211214,211232,23311120];
	START_BASE = 38
	STOP       = 106 //BARS[STOP]==23311120 (manually added a zero at the end)
 
	var fromType128 = {
    	A: function(charCode) {
			if (charCode>=0 && charCode<32)
				return charCode+64;
			if (charCode>=32 && charCode<96)
				return charCode-32;
			return charCode;
		},
		B: function(charCode) {
			if (charCode>=32 && charCode<128)
				return charCode-32;
			return charCode;
		},
		C: function(charCode) {
			return charCode;
		}
	};
 
	function code128(code, barcodeType) {
		if (arguments.length<2)
			barcodeType = code128Detect(code);
		if (barcodeType=='C' && code.length%2==1)
			code = '0'+code;
		var a = parseBarcode128(code,  barcodeType);
		return bar2html128(a.join('')) ;//+ '<label>' + code + '</label>';
	}
 
 
	function code128Detect(code) {
		if (/^[0-9]+$/.test(code)) return 'C';
		if (/[a-z]/.test(code)) return 'B';
		return 'A';
	}
 
	function parseBarcode128(barcode, barcodeType) {
		var bars = [];
		bars.add = function(nr) {
			var nrCode = BARS[nr];
			this.check = this.length==0 ? nr : this.check + nr*this.length;
			this.push( nrCode || format("UNDEFINED: %1->%2", nr, nrCode) );
		};
	 
		bars.add(START_BASE + barcodeType.charCodeAt(0));
		for(var i=0; i<barcode.length; i++)
		{
			var code = barcodeType=='C' ? +barcode.substr(i++, 2) : barcode.charCodeAt(i);
			converted = fromType128[barcodeType](code);
			if (isNaN(converted) || converted<0 || converted>106)
				throw new Error(format("Unrecognized character (%1) at position %2 in code '%3'.", code, i, barcode));
			bars.add( converted );
		}
		bars.push(BARS[bars.check % 103], BARS[STOP]);
	 
		return bars;
	}
 
	function format(c) {
		var d=arguments;
		var e= new RegExp("%([1-"+(arguments.length-1)+"])","g");
		return(c+"").replace(e,function(a,b){return d[b]})
	}
 
	function bar2html128(s) {
		for(var pos=0, sb=[]; pos<s.length; pos+=2)
		{
			sb.push('<div class="bar' + s.charAt(pos) + ' space' + s.charAt(pos+1) + '"></div>');
		}
		return sb.join('');
	}

	function encode() {
	  	for(var i=1;i<=document.getElementById("totalrecord").value;i++){
			var strValue = document.getElementById("barcode_input_"+i).value;
		  	var strBarcodeHTML = code128(strValue);
		  	document.getElementById("barcode_"+i).innerHTML = strBarcodeHTML;  
	  	}
	}
</script>

<cfquery name="getGsetup" datasource="#dts#">
	select bcurr 
    from gsetup;
</cfquery>

<cfset currencyCode = getGsetup.bcurr>

<cfquery datasource="#dts#" name="getsettingrecord">
	select * from print_barcode_setting
</cfquery>

<cfif getsettingrecord.recordcount eq 0>
	<cfquery datasource="#dts#" name="insertdisplaysetup">
    	insert into print_barcode_setting (id)
    	values (1)            
	</cfquery>
</cfif>

<cfif val(form.barcodewidth) eq 0>
	<cfset form.barcodewidth=2>
</cfif>

<cfquery datasource="#dts#" name="SaveGeneralInfo">
	update print_barcode_setting 
    set no_copies='#form.noofcopy#', spacing="#val(form.spacing)#", top_spacing="#val(form.topspacing)#", left_spacing="#form.leftspacing#",
        font_size="#form.fontsize#", barcodewidth="#form.barcodewidth#"   
        <cfif isdefined("form.hdwide")>
        	,wide_version = '1'
        <cfelse>
         	,wide_version = '0'
		</cfif>
        
        <cfif isdefined("form.barcode")>
        	,bar_code = '1'
        <cfelse>
         	,bar_code = '0'
		</cfif>
        
        <cfif isdefined("form.format2")>
        	,format_2 = '1'
        <cfelse>
         	,format_2 = '0'
		</cfif>
        
        <cfif isdefined("form.format3")>
        	,format_3 = '1'
        <cfelse>
         	,format_3 = '0'
		</cfif>
        
        <cfif isdefined("form.format4")>
        	,format_4 = '1'
        <cfelse>
         	,format_4 = '0'
		</cfif>
        
        <cfif isdefined("form.format5")>
        	,format_5 = '1'
        <cfelse>
         	,format_5 = '0'
		</cfif>
        
        <cfif isdefined("form.format6")>
        	,format_6 = '1'
        <cfelse>
         	,format_6 = '0'
		</cfif>
        <cfif isdefined("form.format7")>
        	,format_7 = '1'
        <cfelse>
         	,format_7 = '0'
		</cfif>
        <cfif isdefined("form.minisize")>
        	,minisize = '1'
        <cfelse>
         	,minisize = '0'
		</cfif>
</cfquery>

<cfif form.rcno neq ''>
	<cfquery name="MyQuery" datasource="#dts#">
		select itemno,qty,desp,despa,price,unit,(select sizeid from icitem where itemno=a.itemno) as sizeid,
               (select packing from icitem where itemno=a.itemno) as packing,despa,category,
               (select barcode from icitem where itemno=a.itemno) as barcode,(select aitemno from icitem where itemno=a.itemno) as aitemno,
               (select remark1 from icitem where itemno=a.itemno) as remark1,(select supp from icitem where itemno=a.itemno) as supp 
        from ictran as a
	    where 1=1
    	<cfif trim(form.rcno) neq "">
			and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rcno#">
		</cfif>
    	and type="#form.reftype#"
		order by itemno
	</cfquery>
<cfelse>
	<cfquery name="MyQuery" datasource="#dts#">
		select itemno,desp,despa,price,unit,sizeid,despa,category,barcode,packing,aitemno,1 as qty,remark1 
        from icitem as a
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			where itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
		</cfif>
		<cfif val(form.noofcopy) gt 1>
			<cfloop from="2" to="#val(form.noofcopy)#" index="i">
				union all
				select itemno,desp,despa,price,unit,sizeid,despa,category,barcode,packing,aitemno,1 as qty,remark1 from icitem as a
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					where itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
				</cfif>
			</cfloop>
		</cfif>
		order by itemno
	</cfquery>
</cfif>

<cfif isdefined('form.hdwide')>
	<cfif isdefined('form.format2')>
    	<cfloop from="1" to="#val(form.topspacing)#" index="i">
			<br />
		</cfloop>
        
        <cfloop query="MyQuery" >
			<cfoutput>
				<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table>
						<tr>
                        	<td width="#val(form.leftspacing)#"></td>
                            <td style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.category#</td>
                            <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">
								<cfif lcase(HcomID) eq "ssuni_i">
									<cftry>Size : #listgetat(MyQuery.itemno,2,'-')#<cfcatch></cfcatch></cftry>
								<cfelse>
									<cftry>Size : #listgetat(MyQuery.itemno,3,'-')#<cfcatch></cfcatch></cftry>
								</cfif>
                            </td>
                        </tr>
						<cfif isdefined('form.CSS')>
							<cfif isdefined('form.barcode')>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.barcode#" id="barcode_input_#MyQuery.currentrow#"></input>
							<cfelse>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.itemno#" id="barcode_input_#MyQuery.currentrow#"></input>
							</cfif>
							<tr>
                            	<td width="#val(form.leftspacing)#"></td>
                                <td colspan="2"><div class="barcode128h" id="barcode_#MyQuery.currentrow#"></div></td>
                            </tr>
						<cfelse>
							<cfif isdefined('form.barcode')>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                     </tr>
								<cfelse>
									<tr>
                                    	<td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                     </tr>
								</cfif>
								<tr>
                                	<td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</td>
                                 </tr>
							<cfelse>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
								<tr>
                                	<td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                                 </tr>
							</cfif>
						</cfif>
					</table>
					<cfloop from="1" to="#val(form.spacing)#" index="i">
						<br />
					</cfloop>
				</cfloop>
			</cfoutput>
		</cfloop>
	<cfelseif isdefined('form.format3')>
    	<cfloop from="1" to="#val(form.topspacing)#" index="i">
        	<br />
        </cfloop>
		<cfloop query="MyQuery" >
			<cfoutput>
            	<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table>
						<tr>
                        	<td align="center" colspan="2" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">
                            	<strong>#currencyCode# #numberformat(MyQuery.price,',_.__')#</strong>
                            </td>
                        </tr>
						<tr>
                        	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.desp# #MyQuery.despa#</td>
                        </tr>
						<cfif isdefined('form.CSS')>
							<cfif isdefined('form.barcode')>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.barcode#" id="barcode_input_#MyQuery.currentrow#"></input>
							<cfelse>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.itemno#" id="barcode_input_#MyQuery.currentrow#"></input>
							</cfif>
                            <tr>
                            	<td colspan="2" align="center"><div class="barcode128h" id="barcode_#MyQuery.currentrow#"></div></td>
                            </tr>
						<cfelse>
							<cfif isdefined('form.barcode')>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
								<tr>
                                	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</td>
                                </tr>
							<cfelse>
								<cfif lcase(hcomid) eq "hodaka_i">
                                	<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
								<tr>
                                	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                                </tr>
							</cfif>
						</cfif>
					</table>
					<cfloop from="1" to="#val(form.spacing)#" index="i">
						<br />
					</cfloop>
				</cfloop>
			</cfoutput>
		</cfloop>
	<cfelseif isdefined('form.format4')>
    
    	<cfloop from="1" to="#val(form.topspacing)#" index="i">
			<br />
		</cfloop>
        <cfloop query="MyQuery" >
        <div <cfif recordcount neq currentRow>style="page-break-after:always;"</cfif>>
			<cfoutput>
				<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table>
						<cfif lcase(hcomid) eq "hodaka_i">
							<tr>
                            	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                            </tr>
						<cfelse>
							<tr>
                            	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                            </tr>
						</cfif>
						<tr>
                        	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                        </tr>
                        
                            <!---<tr>
                                <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.desp#</td>
                            </tr>--->
                        
						<tr>
                        	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">
                            	<strong>#currencyCode# #numberformat(MyQuery.price,',_.__')#</strong>
                            </td>
                        </tr>
						<cfif dts EQ "umwstaffshop_i">
                        	<tr>
                            	<td align="Center" style="font-size:#fontsize-2#px;line-height:#fontsize-2#px;">Price Inclusive GST</td>
                            </tr>  
                        </cfif>
					</table>
					<cfif recordcount neq currentRow>
						<cfloop from="1" to="#val(form.spacing)#" index="i">
							<br />
						</cfloop>
					</cfif>
				</cfloop>
			</cfoutput>
        </div>
		</cfloop>
	<cfelseif isdefined('form.format7')>
    	<cfloop from="1" to="#val(form.topspacing)#" index="i">
			<br />
		</cfloop>
        <cfloop query="MyQuery" >
			<cfoutput>
				<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table border="1">
						<tr>
                        	<td colspan="2" align="left" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">Item : #MyQuery.itemno#</td>
                        </tr>
						<tr>
                        	<td colspan="2" align="left" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">Description : #MyQuery.desp#</strong></td>
                        </tr>
						<tr>
                        	<td colspan="2" align="left" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">Manufacturing Date :</td>
                        </tr>
						<tr>
                        	<td colspan="2" align="left" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">Expiry Date :</strong></td>
                        </tr>
						<tr>
                        	<td colspan="2" align="center">
								<cfif isdefined('form.barcode')>
									<input style="margin-left:45px" type="hidden"  value="#MyQuery.barcode#" id="barcode_input_#MyQuery.currentrow#"></input>
								<cfelse>
									<input style="margin-left:45px" type="hidden"  value="#MyQuery.itemno#" id="barcode_input_#MyQuery.currentrow#"></input>
								</cfif>
								<div class="barcode128h" id="barcode_#MyQuery.currentrow#"></div>
								<cfif isdefined('form.barcode')>
                                    <font style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</font>
                                <cfelse>
                                    <font style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</font>
                                </cfif>
                            </td>
                        </tr>
					</table>
					<cfif recordcount neq currentRow>
						<cfloop from="1" to="#val(form.spacing)#" index="i">
							<br />
						</cfloop>
					</cfif>
				</cfloop>
			</cfoutput>
		</cfloop>
	<cfelseif isdefined('form.format5')>
        <cfloop from="1" to="#val(form.topspacing)#" index="i">
            <br />
        </cfloop>
        <cfloop query="MyQuery" >
			<cfoutput>
				<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table>
                    	<tr>
                        	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                        </tr>
						<cfif isdefined('form.CSS')>
							<cfif isdefined('form.barcode')>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.barcode#" id="barcode_input_#MyQuery.currentrow#"></input>
							<cfelse>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.itemno#" id="barcode_input_#MyQuery.currentrow#"></input>
							</cfif>
                            <tr>
                                <td colspan="2" align="center"><div class="barcode128h" id="barcode_#MyQuery.currentrow#"></div></td>
                            </tr>
						<cfelse>
							<cfif isdefined('form.barcode')>
								<cfif lcase(hcomid) eq "hodaka_i">
                                	<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelseif lcase(hcomid) eq "tcds_i">
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode4.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
							<cfelse>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelseif lcase(hcomid) eq "tcds_i">
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode4.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td colspan="2" align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
							</cfif>
						</cfif>
						<tr>
                        	<td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</td>
                        </tr>
					</table>
					<cfif recordcount neq currentRow>
						<cfloop from="1" to="#val(form.spacing)#" index="i">
							<br />
						</cfloop>
					</cfif>
				</cfloop>
			</cfoutput>
		</cfloop>
	<cfelseif isdefined('form.format6')>
    	<cfloop from="1" to="#val(form.topspacing)#" index="i">
			<br />
        </cfloop>
        <cfloop query="MyQuery" >
			<cfoutput>
				<cfloop from="1" to="#MyQuery.qty#" index="z">
					<table>
                    	<tr>
                        	<td colspan="2" align="left" style="font-size:36px">#MyQuery.desp#</td>
                        </tr>
						<tr>
                        	<td width="1"></td><td align="left" style="font-size:72px">&nbsp;<strong>$#numberformat(MyQuery.price,'.__')#</strong></td>
                        </tr>
						<cfif isdefined('form.CSS')>
							<cfif isdefined('form.barcode')>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.barcode#" id="barcode_input_#MyQuery.currentrow#"></input>
							<cfelse>
								<input style="margin-left:45px" type="hidden"  value="#MyQuery.itemno#" id="barcode_input_#MyQuery.currentrow#"></input>
							</cfif>
                            <tr>
                                <td></td>
                                <td align="center"><div class="barcode128h" id="barcode_#MyQuery.currentrow#"></div></td>
                             </tr>
						<cfelse>
							<cfif isdefined('form.barcode')>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td></td>
                                        <td align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                    </tr>
								<cfelse>
									<tr>
                                    	<td></td>
                                        <td align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" /></td>
                                     </tr>
								</cfif>
							<cfelse>
								<cfif lcase(hcomid) eq "hodaka_i">
									<tr>
                                    	<td></td>
                                        <td align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                   	</tr>
								<cfelse>
									<tr>
                                    	<td></td>
                                        <td align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" /></td>
                                    </tr>
								</cfif>
							</cfif>
						</cfif>
					</table>
					<cfif recordcount neq currentRow>
						<cfloop from="1" to="#val(form.spacing)#" index="i">
							<br />
						</cfloop>
					</cfif>
				</cfloop>
			</cfoutput>
		</cfloop>
	<cfelseif isdefined('form.minisize')>
    	<cfif lcase(hcomid) eq "hwangkit_i">
            <cfloop query="MyQuery" >
                <cfoutput>
                    <cfloop from="1" to="#MyQuery.qty#" index="z">
                        <cfif myquery.recordcount neq myquery.currentrow>
                            <div style="page-break-after:always;margin-top:0px;margin-left:-10px;">
                        <cfelse>
                            <div style="margin-top:0px;margin-left:-10px;">
                        </cfif>
                        <table style="font-family:'Arial Black', Gadget, sans-serif" cellpadding="1" cellspacing="0">
                            <cfif MyQuery.remark1 neq "">
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.remark1#</td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="25"></td><td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.remark1#</td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="25"></td><td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.remark1#</td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                 </tr>
                            </cfif>
                            <tr>
                                <td width="#val(form.leftspacing)#"></td>
                                <td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.itemno#</td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                <td width="25"></td><td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.itemno#</td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                <td width="25"></td><td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.itemno#</td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                            </tr>
                            <tr>
                                <td width="#val(form.leftspacing)#"></td><td style="font-size:#fontsize+6#px;line-height:#fontsize+2#px;" align="center">
                                    <cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#
                                </td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                <td width="25"></td><td style="font-size:#fontsize+6#px;line-height:#fontsize+2#px;" align="center">
                                    <cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#
                                </td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                <td width="25"></td><td style="font-size:#fontsize+6#px;line-height:#fontsize+2#px;" align="center">
                                    <cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#
                                </td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                            </tr>
                            <tr>
                                <cfif isdefined('form.barcode')>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" height="20" width="#form.barcodewidth#" />
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" height="20" width="#form.barcodewidth#" />
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" height="20" width="#form.barcodewidth#" />
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                <cfelse>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" height="20" width="#form.barcodewidth#" />\
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" height="20" width="#form.barcodewidth#" />
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                    <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                        <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" height="20" width="#form.barcodewidth#" />
                                    </td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                </cfif>
                            </tr>
                        </table>
                        </div>
                    </cfloop>
                </cfoutput>
            </cfloop>
		<cfelseif lcase(hcomid) eq "showcase_i">
            <cfloop query="MyQuery" >
                <cfoutput>
                    <cfloop from="1" to="#MyQuery.qty#" index="z">
                        <cfif myquery.recordcount neq myquery.currentrow>
                            <div style="page-break-after:always;margin-top:6px;">
                        <cfelse>
                            <div style="margin-top:6px;">
                        </cfif>
                        <table style="font-family:'Arial Black', Gadget, sans-serif" >
                            <tr>
                                <td width="#val(form.leftspacing)#"></td><td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.desp#</td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                            </tr>
                            <tr>
                                <td width="#val(form.leftspacing)#"></td><td style="font-size:#fontsize+6#px;line-height:#fontsize+2#px;" align="center">
                                    <cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#</td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                            </tr>
                            <cfif isdefined('form.barcode')>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td><td height="17px"  align="center">
                                        <img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" width="100" />
                                    </td>
                                 </tr>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                                </tr>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.remark1#</td>
                                </tr>
                            <cfelse>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td><td height="17px"  align="center">
                                        <img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" width="100" />
                                    </td>
                                 </tr>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                                </tr>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.remark1#</td>
                                </tr>
                            </cfif>
                        </table>
                        </div>
                    </cfloop>
                </cfoutput>
            </cfloop>
        <cfelse>
            <cfloop query="MyQuery" >
                <cfoutput>
                    <cfloop from="1" to="#MyQuery.qty#" index="z">
                        <cfif lcase(hcomid) eq "briey_i">
                            <cfif myquery.recordcount neq myquery.currentrow>
                                <div style="page-break-after:always;margin-top:6px;margin-left:-10px;">
                            <cfelse>
                                <div style="margin-top:6px;margin-left:-10px;">
                            </cfif>
                        <cfelseif lcase(hcomid) eq "tcmr0327_i">
                            <cfif myquery.currentrow eq 1>
                                <div style="page-break-after:always;margin-top:-8px;margin-left:-10px;">
                            <cfelseif myquery.recordcount neq myquery.currentrow>
                                <div style="page-break-after:always;margin-top:16px;margin-left:-10px;">
                            <cfelse>
                                <div style="margin-top:6px;margin-left:-10px;">
                            </cfif>
                        <cfelse>
                            <cfif myquery.recordcount neq myquery.currentrow>
                                <div style="page-break-after:always;margin-top:6px;">
                            <cfelse>
                                <div style="margin-top:6px;margin-bottom:-20px;">
                            </cfif>
                        </cfif>
                        <table style="font-family:'Arial Black', Gadget, sans-serif" >
                            <cfif lcase(hcomid) neq "briey_i">
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td style="font-size:#fontsize#px;line-height:#fontsize#px;" align="center" width="20">#MyQuery.desp#</td>
                                    <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                                </tr>
                            </cfif>
                            <tr>
                                <td width="#val(form.leftspacing)#"></td>
                                <td style="font-size:#fontsize+6#px;line-height:#fontsize+2#px;" align="center">
                                    <cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#
                                </td>
                                <td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td>
                            </tr>
                            <cfif isdefined('form.barcode')>
                                <cfif lcase(hcomid) eq "briey_i">
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                            <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" width="#form.barcodewidth#" />
                                        </td>
                                    </tr>
                                <cfelseif lcase(hcomid) eq "tcmr0327_i">
                                    <tr><td width="#val(form.leftspacing)#"></td>
                                        <td height="17px"  align="center">
                                            <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" width="100" />
                                        </td>
                                    </tr>
                                <cfelse>
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td>
                                        <td height="17px"  align="center">
                                            <img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" width="100" />
                                        </td>
                                    </tr>
                                </cfif>
                                <cfif lcase(hcomid) neq "briey_i">
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</td>
                                    </tr>
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.remark1#</td>
                                    </tr>
                                </cfif>
                            <cfelse>
                                <cfif lcase(hcomid) eq "briey_i" >
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td><td height="20px"  align="center">
                                            <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" width="#form.barcodewidth#" />
                                        </td>
                                    </tr>
                                <cfelseif lcase(hcomid) eq "tcmr0327_i">
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td><td height="17px"  align="center">
                                            <img src="barcodebriey.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" width="100" />
                                        </td>
                                    </tr>
                                <cfelse>
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td><td height="17px"  align="center">
                                            <img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" width="100" />
                                        </td>
                                    </tr>
                                </cfif>
                                <tr>
                                    <td width="#val(form.leftspacing)#"></td>
                                    <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                                </tr>
                                <cfif lcase(hcomid) neq "briey_i">
                                    <tr>
                                        <td width="#val(form.leftspacing)#"></td>
                                        <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.remark1#</td>
                                    </tr>
                                </cfif>
                            </cfif>
                        </table>
                        </div>
                    </cfloop>
                </cfoutput>
            </cfloop>
        </cfif>
	<cfelse>
    	<cfloop query="MyQuery">
			<cfoutput>
                <cfloop from="1" to="#MyQuery.qty#" index="z">
                    <cfif lcase(hcomid) eq "hodaka_i">
                        <table>
                            <tr>
                                <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td>
                            </tr>
                            <cfif isdefined('form.barcode')>
                                <tr>
                                    <td colspan="2" align="center">
                                    	<img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" />
                                    </td>
                                </tr>
                            <cfelse>
                                <tr>
                                    <td colspan="2" align="center">
                                    	<img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" />
                                    </td>
                                </tr>
                            </cfif>
                            <tr>
                                <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.desp#</td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.despa#</td>
                            </tr>
                        </table>
                    <cfelse>
                        <cfif isdefined('form.barcode')>
                            <img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=#form.barcodewidth#" />
                            <br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#MyQuery.itemno#<br /><br/><br/>
                        <cfelse>
                            <img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=#form.barcodewidth#" />
                            <br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#MyQuery.barcode#<br /><br/><br/>
                        </cfif>
                    </cfif>
                </cfloop>
            </cfoutput>
    	</cfloop>
	</cfif>
<cfelse>
	<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    	<cfreport template="printBarcodekjc.cfr" format="PDF" query="MyQuery">
		</cfreport>
	<cfelse>
		<cfreport template="printBarcode.cfr" format="PDF" query="MyQuery">
		</cfreport>
	</cfif>
</cfif>

<cfoutput>
	<input type="hidden" value="#MyQuery.recordcount#" id="totalrecord" />
</cfoutput>

<script type="text/javascript">
	encode();
</script>