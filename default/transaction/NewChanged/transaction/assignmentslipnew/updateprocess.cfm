
<cfif isdefined('url.empno')>
<cfset dts = replace(dts,'_i','_p')>
<cfset dts_main = "payroll_main">
<cfquery name="clearpay" datasource="#dts#">
UPDATE paytra1 SET 
BRATE = null,
BRATE2 = null, 
BACKPAY = null,
OOB = null,
WDAY = null,
WDAY2 = null,
DW = null,
DW2 = null,
PH = null,
AL = null,
ALHR = null,
MC = null,
MT = null,
CC = null,
MR = null,
PT = null,
CL = null,
HL = null,
AD = null,
EX = null,
LS = null,
OPLD = null,
OPL = null,
NPL = null,
NPL2 = null,
AB = null,
ONPLD = null,
ONPL = null,
NS = null,
ALTAWDAY = null,
ALTAWRATE = null,
ALTAWAMT = null,
DWAWADJ = null,
ALBFTMP = null,
MCBFTMP = null,
WORKHR = null,
LATEHR = null,
EARLYHR = null,
NOPAYHR = null,
RATE1 = null,
RATE2 = null,
RATE3 = null,
RATE4 = null,
RATE5 = null,
RATE6 = null,
HR1 = null,
HR2 = null,
HR3 = null, 
HR4 = null,
HR5 = null,
HR6 = null,
DIRFEE = null,
AW101= null,
AW102 = null,
AW103 = null,
AW104= null,
AW105 = null,
AW106 = null,
AW107 = null, 
AW108= null,
AW109= null,
AW110 = null,
AW111= null,
AW112 = null,
AW113 = null,
AW114 = null,
AW115 = null,
AW116 = null,
AW117 = null,
DED101 = null,
DED102 = null,
DED103 = null,
DED104 = null,
DED105 = null,
DED106 = null,
DED107 = null,
DED108 = null,
DED109 = null,
DED110 = null,
DED111= null,
DED112= null,
DED113 = null,
DED114 = null,
DED115 = null,
MESS = null,
MESS1 = null,
FIXOESP = null,
SHIFTA = null,
SHIFTB = null,
SHIFTC = null,
SHIFTD = null,
SHIFTE = null,
SHIFTF = null,
SHIFTG = null,
SHIFTH = null,
SHIFTI = null,
SHIFTJ = null,
SHIFTK= null,
SHIFTL= null,
SHIFTM= null,
SHIFTN= null,
SHIFTO= null,
SHIFTP= null,
SHIFTQ= null,
SHIFTR= null,
SHIFTS= null,
SHIFTT= null,
TIPPOINT= null,
CLTIPOINT= null,
TIPRATE= null,
MFUND= null,
DFUND= null,
ZAKAT_BF= null,
ZAKAT_BFN= null,
PIECEPAY= null,
BASICPAY= null,
FULLPAY= null,
NPLPAY= null,
OT1= null,
OT2= null,
OT3= null,
OT4= null,
OT5= null,
OT6= null,
OTPAY= null,
EPFWW= null,
EPFCC= null,
EPFWWEXT= null,
EPFCCEXT= null,
EPGWW= null,
EPGCC= null,
SOASOWW= null,
SOASOCC= null,
SOBSOWW= null,
SOBSOCC= null,
SOCSOWW= null,
SOCSOCC= null,
SODSOWW= null,
SODSOCC= null,
SOESOWW= null,
SOESOCC= null,
UNIONWW= null,
UNIONCC= null,
ADVANCE= null,
ADVPAY= null,
TIPAMT= null,
ITAXPCB= null,
ITAXPCBADJ= null,
TAW= null,
TXOTPAY= null,
TXAW= null,
TXDED= null,
TDED= null,
TDEDU= null,
GROSSPAY= null,
NETPAY= null,
EPF_PAY= null,
EPF_PAY_A= null,
CCSTAT1= null,
CCSTAT2= null,
CCSTAT3= null,
PENCEN= null,
PROJECT= null,
BANKCHARGE= null,
ADVDAY= null,
PM_CODE= null,
TMONTH= null,
UDRATE1= null,
UDRATE2= null,
UDRATE3= null,
UDRATE4= null,
UDRATE5= null,
UDRATE6= null,
UDRATE7= null,
UDRATE8= null,
UDRATE9= null,
UDRATE10= null,
UDRATE11= null,
UDRATE12= null,
UDRATE13= null,
UDRATE14= null,
UDRATE15= null,
UDRATE16= null,
UDRATE17= null,
UDRATE18= null,
UDRATE19= null,
UDRATE20= null,
UDRATE21= null,
UDRATE22= null,
UDRATE23= null,
UDRATE24= null,
UDRATE25= null,
UDRATE26= null,
UDRATE27= null,
UDRATE28= null,
UDRATE29= null,
UDRATE30= null,
PAYYES = "",
cpf_amt=null,
hourrate=null,
total_late_h=null,
total_earlyD_h=null,
total_noP_h=null,
total_work_h=null,
additionalwages=null
WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfquery name="clearpay" datasource="#dts#">
UPDATE paytran SET 
BRATE = null,
BRATE2 = null, 
BACKPAY = null,
OOB = null,
WDAY = null,
WDAY2 = null,
DW = null,
DW2 = null,
PH = null,
AL = null,
ALHR = null,
MC = null,
MT = null,
CC = null,
MR = null,
PT = null,
CL = null,
HL = null,
AD = null,
EX = null,
LS = null,
OPLD = null,
OPL = null,
NPL = null,
NPL2 = null,
AB = null,
ONPLD = null,
ONPL = null,
NS = null,
ALTAWDAY = null,
ALTAWRATE = null,
ALTAWAMT = null,
DWAWADJ = null,
ALBFTMP = null,
MCBFTMP = null,
WORKHR = null,
LATEHR = null,
EARLYHR = null,
NOPAYHR = null,
RATE1 = null,
RATE2 = null,
RATE3 = null,
RATE4 = null,
RATE5 = null,
RATE6 = null,
HR1 = null,
HR2 = null,
HR3 = null, 
HR4 = null,
HR5 = null,
HR6 = null,
DIRFEE = null,
AW101= null,
AW102 = null,
AW103 = null,
AW104= null,
AW105 = null,
AW106 = null,
AW107 = null, 
AW108= null,
AW109= null,
AW110 = null,
AW111= null,
AW112 = null,
AW113 = null,
AW114 = null,
AW115 = null,
AW116 = null,
AW117 = null,
DED101 = null,
DED102 = null,
DED103 = null,
DED104 = null,
DED105 = null,
DED106 = null,
DED107 = null,
DED108 = null,
DED109 = null,
DED110 = null,
DED111= null,
DED112= null,
DED113 = null,
DED114 = null,
DED115 = null,
MESS = null,
MESS1 = null,
FIXOESP = null,
SHIFTA = null,
SHIFTB = null,
SHIFTC = null,
SHIFTD = null,
SHIFTE = null,
SHIFTF = null,
SHIFTG = null,
SHIFTH = null,
SHIFTI = null,
SHIFTJ = null,
SHIFTK= null,
SHIFTL= null,
SHIFTM= null,
SHIFTN= null,
SHIFTO= null,
SHIFTP= null,
SHIFTQ= null,
SHIFTR= null,
SHIFTS= null,
SHIFTT= null,
TIPPOINT= null,
CLTIPOINT= null,
TIPRATE= null,
MFUND= null,
DFUND= null,
ZAKAT_BF= null,
ZAKAT_BFN= null,
PIECEPAY= null,
BASICPAY= null,
FULLPAY= null,
NPLPAY= null,
OT1= null,
OT2= null,
OT3= null,
OT4= null,
OT5= null,
OT6= null,
OTPAY= null,
EPFWW= null,
EPFCC= null,
EPFWWEXT= null,
EPFCCEXT= null,
EPGWW= null,
EPGCC= null,
SOASOWW= null,
SOASOCC= null,
SOBSOWW= null,
SOBSOCC= null,
SOCSOWW= null,
SOCSOCC= null,
SODSOWW= null,
SODSOCC= null,
SOESOWW= null,
SOESOCC= null,
UNIONWW= null,
UNIONCC= null,
ADVANCE= null,
ADVPAY= null,
TIPAMT= null,
ITAXPCB= null,
ITAXPCBADJ= null,
TAW= null,
TXOTPAY= null,
TXAW= null,
TXDED= null,
TDED= null,
TDEDU= null,
GROSSPAY= null,
NETPAY= null,
EPF_PAY= null,
EPF_PAY_A= null,
CCSTAT1= null,
CCSTAT2= null,
CCSTAT3= null,
PENCEN= null,
PROJECT= null,
BANKCHARGE= null,
ADVDAY= null,
PM_CODE= null,
TMONTH= null,
UDRATE1= null,
UDRATE2= null,
UDRATE3= null,
UDRATE4= null,
UDRATE5= null,
UDRATE6= null,
UDRATE7= null,
UDRATE8= null,
UDRATE9= null,
UDRATE10= null,
UDRATE11= null,
UDRATE12= null,
UDRATE13= null,
UDRATE14= null,
UDRATE15= null,
UDRATE16= null,
UDRATE17= null,
UDRATE18= null,
UDRATE19= null,
UDRATE20= null,
UDRATE21= null,
UDRATE22= null,
UDRATE23= null,
UDRATE24= null,
UDRATE25= null,
UDRATE26= null,
UDRATE27= null,
UDRATE28= null,
UDRATE29= null,
UDRATE30= null,
PAYYES = "",
cpf_amt=null,
hourrate=null,
total_late_h=null,
total_earlyD_h=null,
total_noP_h=null,
total_work_h=null,
additionalwages=null
WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfloop from="1" to="6" index="a">

<cfquery name="getgrosspay" datasource="#dts#">
SELECT grosspay,empno,paydate,nsded,aw115,aw116,aw117 FROM payweek#a# WHERE grosspay <> "0" and grosspay is not null and grosspay <> "" and payyes = "Y" and paydate <> "" and paydate is not null 
and empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfloop query="getgrosspay">

<cfquery name="updatepay" datasource="#dts#">
UPDATE #getgrosspay.paydate# SET 
DW = "15",
WDAY = "15",
NPL = "15",
workhr = 0,
latehr = 0,
earlyhr = 0,
nopayhr = 0,
AW#val(100 + a)# = #val(getgrosspay.grosspay)-val(getgrosspay.aw115)-val(getgrosspay.aw116)-val(getgrosspay.aw117)#,
AW115 = coalesce(AW115,0) + #val(getgrosspay.aw115)#,
AW116 = coalesce(AW116,0) + #val(getgrosspay.aw116)#,
AW117 = coalesce(AW117,0) + #val(getgrosspay.aw117)#,
PAYYES = "Y"
,ded101 = coalesce(ded101,0) +#val(getgrosspay.nsded)#
WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgrosspay.empno#">
</cfquery>

<cfquery name="updatepaytype" datasource="#dts#">
UPDATE pmast SET payrtype = "M" WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgrosspay.empno#">
</cfquery>

</cfloop>
</cfloop>

<cfquery name="updatepaytran" datasource="#dts#">
UPDATE paytra1 as p1, paytran as p2 SET 
p2.wday = 1,
p2.dw = 1,
p2.npl = 1,
p2.payyes = "Y",
p2.workhr = 0,
p2.latehr = 0,
p2.earlyhr = 0,
p2.nopayhr = 0
WHERE p1.empno=p2.empno 
and p1.payyes = "Y"
and p2.payyes <> "Y"
and p1.empno  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfset hcomid = replace(dts,'_p','')>

<cfquery name="get_now_month" datasource="#dts_main#">
    SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery> 

<cfset HuserCcode = get_now_month.ccode>
<cfset hpin = 0>
<!--- 1st Half --->

<!--- PROCESS PAY PAYTRA1 --->
<cfinvoke component="cfc.processPay1" method="updatePay" empno="#URLDECODE(url.empno)#" db="#dts#" 
db1="#dts_main#" compid= "#HcomID#" returnvariable="name" compccode="#HuserCcode#"/>


<!--- PROCESS PAY PAY_TM --->
<cfquery name="getempnoall" datasource="#dts#">
SELECT empno FROM pmast WHERE confid >= #hpin# and paystatus="A" and empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfquery name="getepfcat" datasource="#dts#">
SELECT epfcat FROM pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfloop query="getempnoall">
<cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#getempnoall.empno#" db="#dts#"  
db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />
</cfloop>

<!--- Empty Pay --->
<cfinvoke component="cfc.emptypay" method="empty_pay" db="#dts#" confid= "#hpin#" returnvariable="updateno" />

<!--- PROCESS PAY SDL --->


<cfif HuserCcode eq "SG">
	<cfif get_now_month.nosdl eq "Y" and getepfcat.epfcat eq "X">
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
   </cfquery>
   <cfset sdl_cfc="success">
	<cfelse>
		<cfinvoke component="cfc.sdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#URLDECODE(url.empno)#" db="#dts#"/>
    </cfif>	
	<cfelse>
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
    </cfquery>
	<cfset sdl_cfc="success">
</cfif>	
				
<cfinvoke component="cfc.project_job_costing" method="cal_project" empno="#URLDECODE(url.empno)#" db="#dts#" 
CPFCC_ADD_PRJ ="#get_now_month.CPFCC_ADD_PRJ#" CPFWW_ADD_PRJ ="#get_now_month.CPFWW_ADD_PRJ#"
qry_tbl_pay="paytra1" proj_pay_qry="proj_rcd_1" compid="#HcomID#" db_main="#dts_main#"
returnvariable="update_proj" />

<!--- 2nd Half --->


	<cfinvoke component="cfc.processPay" method="updatePay" empno="#URLDECODE(url.empno)#" db="#dts#" 
	db1="#dts_main#" compid= "#HcomID#" returnvariable="name" compccode="#HuserCcode#"/>


<cfquery name="getempnoall" datasource="#dts#">
SELECT empno FROM pmast WHERE confid >= #hpin# and paystatus="A" and empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
</cfquery>

<cfloop query="getempnoall">
	<cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#getempnoall.empno#" 
	db="#dts#"  db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />
</cfloop>

<!--- Empty Pay --->
<cfinvoke component="cfc.emptypay" method="empty_pay" db="#dts#" confid= "#hpin#" returnvariable="updateno" />
            

	<cfinvoke component="cfc.fwl_process" method="sum_fwl" returnvariable="fwl_cfc" empno="#URLDECODE(url.empno)#"
					db="#dts#" compid="#HcomID#" db_main="#dts_main#"	/>	
		
	<cfinvoke component="cfc.project_job_costing" method="cal_project" empno="#URLDECODE(url.empno)#" db="#dts#" 
			CPFCC_ADD_PRJ ="#get_now_month.CPFCC_ADD_PRJ#" CPFWW_ADD_PRJ ="#get_now_month.CPFWW_ADD_PRJ#"
				qry_tbl_pay="paytran" proj_pay_qry="proj_rcd" compid="#HcomID#" db_main="#dts_main#"
					returnvariable="update_proj" />
	<cfif HuserCcode eq "SG">
	<cfif get_now_month.nosdl eq "Y" and getepfcat.epfcat eq "X">
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
   </cfquery>
   <cfset sdl_cfc="success">
	<cfelse>
		<cfinvoke component="cfc.sdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#URLDECODE(url.empno)#"
					db="#dts#"/>
    </cfif>	
	<cfelse>
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.empno)#">
       </cfquery>
		<cfset sdl_cfc="success">
	</cfif>	
	
</cfif>