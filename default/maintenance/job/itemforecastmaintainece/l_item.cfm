<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>

<cfswitch expression="#form.period#">
	<cfcase value="1">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth21" method="getmonthcust" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="productfrom" value="#form.productfrom#">
			<cfinvokeargument name="productto" value="#form.productto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
		</cfinvoke>
	</cfcase>
	<cfcase value="2">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth22" method="getmonthcust" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="productfrom" value="#form.productfrom#">
			<cfinvokeargument name="productto" value="#form.productto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
		</cfinvoke>
	</cfcase>
	<cfcase value="3">
		<cfloop index="a" from="1" to="6">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth23" method="getmonthcust" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="productfrom" value="#form.productfrom#">
			<cfinvokeargument name="productto" value="#form.productto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
		</cfinvoke>
	</cfcase>
	<cfcase value="4">
		<cfloop index="a" from="1" to="18">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonth24" method="getmonthcust" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="productfrom" value="#form.productfrom#">
			<cfinvokeargument name="productto" value="#form.productto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
		</cfinvoke>
	</cfcase>
     <cfcase value="5">
		<cfloop index="a" from="1" to="1">
			<cfset monthtotal[a] = 0>
		</cfloop>
		<cfinvoke component="salesmonthbymonth" method="getmonthcust" returnvariable="getitem">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="lastaccyear" value="#getgeneral.lastaccyear#">
			<cfinvokeargument name="productfrom" value="#form.productfrom#">
			<cfinvokeargument name="productto" value="#form.productto#">
			<cfinvokeargument name="include" value="#IIF(isdefined('form.include'),'form.include',DE(isdefined('form.include')))#">
			<cfinvokeargument name="include0" value="#IIF(isdefined('form.include0'),'form.include0',DE(isdefined('form.include0')))#">
			<cfinvokeargument name="target_arcust" value="#target_arcust#">
            <cfinvokeargument name="period" value="#form.poption#">
		</cfinvoke>
	</cfcase>
</cfswitch>

<html>
<head>
<title>Item Forecast Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="1" cellspacing="0" cellpadding="2">
	<tr>
	<cfif isdefined("form.include")>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Item Forecast Report</strong></font></div></td>
    <cfelse>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Item Forecast Report</strong></font></div></td>
	</cfif>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		<cfswitch expression="#form.period#">
				<cfcase value="1">PERIOD 1 - 6</cfcase>
				<cfcase value="2">PERIOD 7 - 12</cfcase>
				<cfcase value="3">PERIOD 13 - 18</cfcase>
                <cfcase value="5">Period #form.poption#</cfcase>
				<cfdefaultcase>ONE YEAR</cfdefaultcase>
			</cfswitch>
	  	</font></div>	  	</td>
    </tr>
    <cfif form.productfrom neq "" and form.productto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Item No: #form.productfrom# - #form.productto#</font></div></td>
        </tr>
    </cfif>

    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td rowspan="2"><font size="2" face="Times New Roman, Times, serif">ITEM NO</font></td>
      	<td rowspan="2"><font size="2" face="Times New Roman, Times, serif">MAT'L</font></td>
        <td rowspan="2"><font size="2" face="Times New Roman, Times, serif">CIF<br>US$</font></td>
		<cfswitch expression="#form.period#">
			<cfcase value="1">
				<cfloop index="l" from="1" to="6">
					<td colspan="3"><div align="Center"><font size="4" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="2">
				<cfloop index="l" from="7" to="12">
					<td colspan="3"><div align="Center"><font size="4" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfcase value="3">
				<cfloop index="l" from="13" to="18">
					<td colspan="3"><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
            <cfcase value="5">
				<cfloop index="l" from="#form.poption#" to="#form.poption#">
					<td colspan="3"><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="l" from="1" to="18">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(dateadd('m',l,getgeneral.lastaccyear),"mmm yy")#</font></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
	  			
    </tr>
    <cfswitch expression="#form.period#">
			<cfcase value="1,2,3">
        <tr>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        </tr>
        </cfcase>
<cfcase value="5">
 <tr>
        <td><div align="right">B/F</div></td>
        <td><div align="right">ETA</div></td>
        <td><div align="right">OUT</div></td>
        </tr>
        </cfcase>
		</cfswitch>
	<cfloop query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.fprice,",_.__")#</font></td>
<cfswitch expression="#form.period#">
				<cfcase value="1,2,3" delimiters=",">
					<td><div align="right">#lsnumberformat(getitem.qtybfperiod1,",")#</div></td>
                    <cfif #getitem.p1_period1# neq "">
					<td><div align="right">#lsnumberformat(getitem.p1_period1,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod1,",")#</div></td>
					<td><div align="right">#lsnumberformat(getitem.qtybfperiod2,",")#</div></td>
                    <cfif #getitem.p2_period2# neq "">
					<td><div align="right">#lsnumberformat(getitem.p2_period2,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod2,",")#</div></td>
					<td><div align="right">#lsnumberformat(getitem.qtybfperiod3,",")#</div></td>
                    <cfif #getitem.p3_period3# neq "">
					<td><div align="right">#lsnumberformat(getitem.p3_period3,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod3,",")#</div></td>
                    <td><div align="right">#lsnumberformat(getitem.qtybfperiod4,",")#</div></td>
                    <cfif #getitem.p4_period4# neq "">
					<td><div align="right">#lsnumberformat(getitem.p4_period4,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod4,",")#</div></td>
                    <td><div align="right">#lsnumberformat(getitem.qtybfperiod5,",")#</div></td>
                    <cfif #getitem.p5_period5# neq "">
					<td><div align="right">#lsnumberformat(getitem.p5_period5,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod5,",")#</div></td>
                    <td><div align="right">#lsnumberformat(getitem.qtybfperiod6,",")#</div></td>
                    <cfif #getitem.p6_period6# neq "">
					<td><div align="right">#lsnumberformat(getitem.p6_period6,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod6,",")#</div></td>
                    

				</cfcase>
                <cfcase value="5">
					<td><div align="right">#lsnumberformat(getitem.qtybfperiod1,",")#</div></td>
                    <cfif #getitem.p1_period1# neq "">
					<td><div align="right">#lsnumberformat(getitem.p1_period1,",")#</div></td>
                    <cfelse>
                    <td><div align="right">0</div></td>
                    </cfif>
					<td><div align="right">#lsnumberformat(getitem.qoutperiod1,",")#</div></td>
                </cfcase>
				<cfdefaultcase>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td><div align="right"></div></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><div align="right"></div></td>
					
				</cfdefaultcase>
			</cfswitch>
		</tr>

	</cfloop>
<cfswitch expression="#form.period#">
				<cfcase value="1,2,3" delimiters=",">
    <tr>
		<td colspan="2"><b>Order To CBT</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        </tr>
    	
            <tr>
		<td colspan="2"><b>Kawafuji</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        </tr>
        
            <tr>
		<td colspan="2"><b>D.C Hering</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        </tr>
        </cfcase>
         <cfcase value="5">
        <tr>
		<td colspan="2"><b>Order To CBT</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        </tr>
        <tr>
		<td colspan="2"><b>Kawafuji</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        </tr>
        <tr>
		<td colspan="2"><b>D.C Hering</b></td>
		<td>US$</td>
		<td colspan="3">&nbsp;</td>
        </tr>
         </cfcase>
         </cfswitch>
		<cfswitch expression="#form.period#">
			<cfcase value="1,2,3" delimiters=",">
				<cfloop index="a" from="1" to="6">
					<td><div align="right"></div></td>
				</cfloop>
			</cfcase>
		<cfcase value="5">

					<td><div align="right"></div></td>
			</cfcase>
			<cfdefaultcase>
				<cfloop index="a" from="1" to="18">
					<td><div align="right"></div></td>
				</cfloop>
			</cfdefaultcase>
		</cfswitch>
		<td><div align="right"></div></td>
	</tr>
</table>
</cfoutput>

<cfif getitem.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>