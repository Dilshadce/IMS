<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="artran" default="">
<cfparam name="ictran" default="">
<cfparam name="arpso" default="">
<cfparam name="icpso" default="">
<cfparam name="Icitem" default="">
<cfparam name="Customer" default="">
<cfparam name="Supplier" default="">
<cfparam name="Iccate" default="">
<cfparam name="Icgroup" default="">
<cfparam name="Icagent" default="">
<cfparam name="Iclocate" default="">
<cfparam name="billmat" default="">
<cfparam name="currency" default="">
<cfparam name="ictrancmt" default="">
<cfparam name="icpsocmt" default="">
<cfparam name="iclink" default="">
<cfparam name="icserial" default="">
<cfparam name="fifoopq" default="">
<cfparam name="icl3p" default="">
<cfparam name="comment" default="">
<cfparam name="icservi" default="">
<cfparam name="address" default="">

<cfparam name="artran1" default="">
<cfparam name="ictran1" default="">
<cfparam name="arpso1" default="">
<cfparam name="icpso1" default="">
<cfparam name="Icitem1" default="">
<cfparam name="Customer1" default="">
<cfparam name="Supplier1" default="">
<cfparam name="Iccate1" default="">
<cfparam name="Icgroup1" default="">
<cfparam name="Icagent1" default="">
<cfparam name="Iclocate1" default="">
<cfparam name="billmat1" default="">
<cfparam name="currency1" default="">
<cfparam name="ictrancmt1" default="">
<cfparam name="icpsocmt1" default="">
<cfparam name="iclink1" default="">
<cfparam name="icserial1" default="">
<cfparam name="fifoopq1" default="">
<cfparam name="icl3p1" default="">
<cfparam name="comment1" default="">
<cfparam name="icservi1" default="">
<cfparam name="address1" default="">

<cfparam name="delartran" default="">
<cfparam name="delictran" default="">
<cfparam name="delarpso" default="">
<cfparam name="delicpso" default="">
<cfparam name="delIcitem" default="">
<cfparam name="delCustomer" default="">
<cfparam name="delSupplier" default="">
<cfparam name="delIccate" default="">
<cfparam name="delIcgroup" default="">
<cfparam name="delIcagent" default="">
<cfparam name="delIclocate" default="">
<cfparam name="delbillmat" default="">
<cfparam name="delcurrency" default="">
<cfparam name="delictrancmt" default="">
<cfparam name="delicpsocmt" default="">
<cfparam name="deliclink" default="">
<cfparam name="delicserial" default="">
<cfparam name="delfifoopq" default="">
<cfparam name="delicl3p" default="">
<cfparam name="delcomment" default="">
<cfparam name="delicservi" default="">
<cfparam name="deladdress" default="">
<body>

<h1 align="center">Import UBS table to Web Order System</h1>

<form name="form" action="import.cfm" method="post" enctype="multipart/form-data">

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <th height="27">File Name</th>
      <th>Get File from local disk</th>
      <th>FTP File to server</th>
      <th>Import File into Database</th>
      <th>Delete File At server</th>
    </tr>
    <tr>
      <td height="27"><font size="2">1. Artran9.csv</font></td>
      <td><font size="2">
        <input type="file" name="artranb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="artran1" value="FTP Artran">
        </font></td>
      <td><font size="2">
        <input type="submit" name="artran" value="Import Artran">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delartran" value="Delete Artran">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">2. Ictran9.csv</font></td>
      <td><font size="2">
        <input type="file" name="ictranb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="ictran1" value="FTP Ictran">
        </font></td>
      <td><font size="2">
        <input type="submit" name="ictran" value="Import Ictran">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delictran" value="Delete Ictran">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">3. Arpso9.csv</font></td>
      <td><font size="2">
        <input type="file" name="arpsob" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="arpso1" value="FTP Arpso">
        </font></td>
      <td><font size="2">
        <input type="submit" name="arpso" value="Import Arpso">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delarpso" value="Delete Arpso">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">4. Icpso9.csv</font></td>
      <td><font size="2">
        <input type="file" name="icpsob" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="icpso1" value="FTP Icpso">
        </font></td>
      <td><font size="2">
        <input type="submit" name="icpso" value="Import Icpso">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delicpso" value="Delete Icpso">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">5. Icitem9.csv</font></td>
      <td><font size="2">
        <input type="file" name="icitemb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icitem1" value="FTP Icitem">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icitem" value="Import Icitem">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delicitem" value="Delete Icitem">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">6. Arcust9.csv(UBS)</font></td>
      <td><font size="2">
        <input type="file" name="customerb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Customer1" value="FTP Customer">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Customer" value="Import Customer">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delcustomer" value="Delete Customer">
        </font></td>
    </tr>
    <tr>
      <td height="27" nowrap><font size="2">7. Apvend9.csv(UBS)</font></td>
      <td><font size="2">
        <input type="file" name="supplierb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Supplier1" value="FTP Supplier">
        </font></td>
      <td><font size="2"> 
        <input type="submit" name="Supplier" value="Import Supplier">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delsupplier" value="Delete Supplier">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">8. Iccate9.csv</font></td>
      <td><font size="2">
        <input type="file" name="iccateb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iccate1" value="FTP Iccate">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iccate" value="Import Iccate">
        </font></td>
      <td><font size="2">
        <input type="submit" name="deliccate" value="Delete Iccate">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">9. Icgroup9.csv </font></td>
      <td><font size="2">
        <input type="file" name="icgroupb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icgroup1" value="FTP Icgroup">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icgroup" value="Import Icgroup">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delicgroup" value="Delete Icgroup">
        </font></td>
    </tr>
    <tr>
      <td height="27"><font size="2">10. Icagent9.csv</font></td>
      <td><font size="2">
        <input type="file" name="icagentb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icagent1" value="FTP Icagent">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icagent" value="Import Icagent">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delicagent" value="Delete Icagent">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">11. Iclocate9.csv</font></td>
      <td><font size="2">
        <input type="file" name="iclocateb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iclocate1" value="FTP Iclocate">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iclocate" value="Import Iclocate">
        </font></td>
      <td><font size="2">
        <input type="submit" name="deliclocate" value="Delete Iclocate">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">12. Billmat9.csv</font></td>
      <td><font size="2">
        <input type="file" name="billmatb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="billmat1" value="FTP Billmat">
        </font></td>
      <td><font size="2">
        <input type="submit" name="billmat" value="Import Billmat">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delbillmat" value="Delete Billmat">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">13. Currency9.csv</font></td>
      <td><font size="2">
        <input type="file" name="Currencyb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Currency1" value="FTP Currency">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Currency" value="Import Currency">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delCurrency" value="Delete Currency">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">14. Ictrancmt.csv</font></td>
      <td><font size="2">
        <input type="file" name="Ictrancmtb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Ictrancmt1" value="FTP Ictrancmt">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Ictrancmt" value="Import Ictrancmt">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delIctrancmt" value="Delete Ictrancmt">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">15. Icpsocmt.csv</font></td>
      <td><font size="2">
        <input type="file" name="Icpsocmtb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icpsocmt1" value="FTP Icpsocmt">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icpsocmt" value="Import Icpsocmt">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delIcpsocmt" value="Delete Icpsocmt">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">16. Iclink9.csv</font></td>
      <td><font size="2">
        <input type="file" name="Iclinkb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iclink1" value="FTP Iclink">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Iclink" value="Import Iclink">
        </font></td>
      <td><font size="2">
        <input type="submit" name="deliclink" value="Delete Iclink">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">17. Icserial9.csv</font></td>
      <td><font size="2">
        <input type="file" name="Icserialb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icserial1" value="FTP Icserial">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icserial" value="Import Icserial">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delicserial" value="Delete Icserial">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">18. Fifoopq.csv</font></td>
      <td><font size="2">
        <input type="file" name="Fifoopqb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Fifoopq1" value="FTP Fifoopq">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Fifoopq" value="Import Fifoopq">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delFifoopq" value="Delete Fifoopq">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">19. Icl3p.csv</font></td>
      <td><font size="2">
        <input type="file" name="Icl3pb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icl3p1" value="FTP Icl3p">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icl3p" value="Import Icl3p">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delIcl3p" value="Delete Icl3p">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">20. Comment.csv</font></td>
      <td><font size="2">
        <input type="file" name="commentb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="comment1" value="FTP Comment">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Comment" value="Import Comment">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delComment" value="Delete Comment">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">21. Icservi.csv</font></td>
      <td><font size="2">
        <input type="file" name="Icservib" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icservi1" value="FTP Icservi">
        </font></td>
      <td><font size="2">
        <input type="submit" name="Icservi" value="Import Icservi">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delIcservi" value="Delete Icservi">
        </font></td>
    </tr>
	<tr>
      <td height="27"><font size="2">22. Address.csv</font></td>
      <td><font size="2">
        <input type="file" name="addressb" size="25">
        </font></td>
      <td><font size="2">
        <input type="submit" name="address1" value="FTP Address">
        </font></td>
      <td><font size="2">
        <input type="submit" name="address" value="Import Address">
        </font></td>
      <td><font size="2">
        <input type="submit" name="delAddress" value="Delete Address">
        </font></td>
    </tr>
  </table> 
  
</form>
<cfif artran eq 'Import Artran'>
	<cfquery name="delearpso" datasource="#dts#">
		delete from tempar
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/artran9.csv" into table tempar fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	
	<cfquery name="deleartran" datasource="#dts#">
		delete from artran
	</cfquery>
	
	<cfquery name="gettemp" datasource="#dts#">
		select * from tempar
	</cfquery>
	
	<cfoutput query="gettemp">
		<cfset left1 = left(#wos_date#,5)>
		<cfset dd = right(#left1#,2)>
		<cfset mm = left(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tmm = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tdd = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#">
		<cfquery name="insertartran" datasource="#dts#">
		 	insert into artran values ('#type#','#refno#','#refno2#','#trancode#','#custno#','#numberformat(fperiod,"00")#',
			"#newdate#",'#desp#','#despa#','#agenno#','#area#','#source#','#job#','#currrate#',
			'#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#',
			'#net_bil#','#tax1_bil#','#tax2_bil#','#tax3_bil#','#tax_bil#','#grand_bil#','#debit_bil#',
			'#credit_bil#','#invgross#','#disp1#','#disp2#','#disp3#','#discount1#','#discount2#',
			'#discount3#','#discount#','#net#',
			'#tax1#','#tax2#','#tax3#','#tax#','#taxp1#',
			'#taxp2#','#taxp3#','#grand#','#debitamt#','#creditamt#','#mc1_bil#','#mc2_bil#','#m_charge1#',
			'#m_charge2#','#cs_pm_cash#','#cs_pm_cheq#','#cs_pm_crcd#','#cs_pm_crc2#','#cs_pm_dbcd#',
			'#cs_pm_vouc#','#deposit#','#cs_pm_debt#','#cs_pm_wht#','#checkno#','#impstage#','#billcost#',
			'#billsale#','','#paidamt#','#refno3#','#age#','#note#','#term#','#iscash#','#van#',
			'#del_by#','','','#urgency#','#currrate2#','#staxacc#','#supp1#',
			'#supp2#','#pono#','#dono#','#rem0#','#rem1#','#rem2#','#rem3#',
			'#rem4#','#rem5#','#rem6#','#rem7#','#rem8#','#rem9#','#rem10#','#rem11#','#rem12#','#frem0#',
			'#frem1#','#frem2#','#frem3#','#frem4#','#frem5#','#frem6#','#frem7#',
			'#frem8#','#frem9#','#comm1#','#comm2#','#comm3#','#comm4#','#id#','#generated#','#toinv#',
			'#order_cl#','','','','','#last_year#','#posted#',
			'#printed#','#lokstatus#','#void#','#name#','#pono2#','#dono2#','#csgtrans#','#taxincl#',
			'#tableno#','#cashier#','#member#','#counter#','#tourgroup#','#newdatetime#','#time#','#xtrcost#',
			'#xtrcost2#','#point#','#userid#','#bperiod#','#vperiod#','','','','','')
		</cfquery>
	</cfoutput> 
	<cfquery name="delearpso" datasource="#dts#">
		delete from tempar
	</cfquery>
	<cfquery name="updatecomm" datasource="#dts#">
		update artran set comm0='',comm1='',comm2='',comm3='',comm4='' 
	</cfquery>
	<h2>You have import Artran9 successfully.</h2>	
	
</cfif>
<cfif Ictran eq 'Import Ictran'>
	<cfquery name="deleicpso" datasource="#dts#">
		delete from tempictran
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/ictran9.csv" into table tempictran fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="deleictran" datasource="#dts#">
		delete from ictran
	</cfquery>
	<cfquery name="gettemp" datasource="#dts#">
		select * from tempictran order by type,refno,itemcount 
	</cfquery>
	<!--- order by type,refno,itemcount --->
	<cfoutput query="gettemp">
		<cfset left1 = left(#wos_date#,5)>
		<cfset dd = right(#left1#,2)>
		<cfset mm = left(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tmm = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tdd = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#">
		
		<cfset left1 = left(#dodate#,5)>
		<cfset dd = right(#left1#,2)>
		<cfset mm = left(#left1#,2)>
		<cfset yy = right(#dodate#,4)>
		<cfset newdodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset left1 = left(#sodate#,5)>
		<cfset dd = right(#left1#,2)>
		<cfset mm = left(#left1#,2)>
		<cfset yy = right(#sodate#,4)>
		<cfset newsodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfquery name="insertictran" datasource="#dts#">
			insert into ictran values ('#type#', '#refno#' , '#refno2#' ,'#trancode#','#custno#','#numberformat(fperiod,"00")#',
			'#newdate#','#currrate#','#itemcount#','#linecode#','#itemno#','#desp#','#despa#','#agenno#',
			'#location#','#source#','#job#','#sign#','#qty_bil#','#price_bil#','#unit_bil#',
			'#amt1_bil#','#dispec1#','#dispec2#','#dispec3#','#disamt_bil#','#amt_bil#','#taxpec1#',
			'#taxpec2#','#taxpec3#','#taxamt_bil#','#impstage#','#qty#','#price#','#unit#','#amt1#','#disamt#',
			'#amt#','#taxamt#','#factor1#','#factor2#','#dono#', '#newdodate#' , '#newsodate#' , '#brem1#' , '#brem2#' ,
			'#brem3#' , '#brem4#' , '#packing#' , '#note1#' , '#note2#' , '#gltradac#' ,'#updcost#','#gst_item#',
			'#totalup#','#withsn#','#grade#','#pur_price#','#qty1#','#qty2#','#qty3#','#qty4#','#qty5#',
			'#qty6#','#qty7#','#qty_ret#','#tempfigi#', '#sercost#' , '#m_charge1#' , '#m_charge2#' ,'#adtcost1#',
			'#adtcost2#','#it_cos#','#av_cost#','#batchcode#','','#point#','#inv_disc#',
			'#inv_tax#','#supp#','#edi_cou1#','#writeoff#','#toship#','#shipped#','#name#','#del_by#',
			'#van#','#generated#','#ud_qty#', '#toinv#' , '' , '' , '' ,
			'' , '#brk_to#' ,'#sv_part#','#last_year#','#void#','#sono#','#mc1_bil#','#mc2_bil#',
			'#userid#','#damt#','#oldbill#','#wos_group#','#category#','#area#','#shelf#','#temp#',
			'#temp1#','#body#','#totalgroup#','#mark#','#type_seq#','#promoter#','#tableno#','#member#',
			'#tourgroup#','#newdatetime#','#time#','#bomno#','#tostring(comment)#')
		</cfquery>
	</cfoutput>
	<!--- <cfquery name="updatesono" datasource="#dts#">
		update ictran set sono = 'SONO' where sono = "" 
	</cfquery>
	<cfquery name="updatedono" datasource="#dts#">
		update ictran set dono = 'DONO' where dono = "" 
	</cfquery> --->
	<cfquery name="deleicpso" datasource="#dts#">
		delete from tempictran
	</cfquery>
	<h2>You have import Ictran9 successfully.</h2>
</cfif>

<cfif Arpso eq 'Import Arpso'>
	<cfquery name="delearpso" datasource="#dts#">
		delete from tempar
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/arpso9.csv" into table tempar fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="updatetemp" datasource="#dts#">
		update tempar set type = 'QUO' where type = 'QO'
	</cfquery>
	
	<cfquery name="gettemp" datasource="#dts#">
		select * from tempar
	</cfquery>
	
	<cfoutput query="gettemp">
		<!--- <cfset left1 = left(#wos_date#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tdd = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tmm = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#"> --->
		<cfset left1 = left(#wos_date#,5)>
		<cfset mm = left(#left1#,2)>
		<cfset dd = right(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tmm = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tdd = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#">
		<cfquery name="insertartran" datasource="#dts#">
		 	insert into artran values ('#type#','#refno#','#refno2#','#trancode#','#custno#','#numberformat(fperiod,"00")#',
			'#newdate#','#desp#','#despa#','#agenno#','#area#','#source#','#job#','#currrate#',
			'#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#',
			'#net_bil#','#tax1_bil#','#tax2_bil#','#tax3_bil#','#tax_bil#','#grand_bil#','#debit_bil#',
			'#credit_bil#','#invgross#','#disp1#','#disp2#','#disp3#','#discount1#','#discount2#',
			'#discount3#','#discount#','#net#',
			'#tax1#','#tax2#','#tax3#','#tax#','#taxp1#',
			'#taxp2#','#taxp3#','#grand#','#debitamt#','#creditamt#','#mc1_bil#','#mc2_bil#','#m_charge1#',
			'#m_charge2#','#cs_pm_cash#','#cs_pm_cheq#','#cs_pm_crcd#','#cs_pm_crc2#','#cs_pm_dbcd#',
			'#cs_pm_vouc#','#deposit#','#cs_pm_debt#','#cs_pm_wht#','#checkno#','#impstage#','#billcost#',
			'#billsale#','','#paidamt#','#refno3#','#age#','#note#','#term#','#iscash#','#van#',
			'#del_by#','','','#urgency#','#currrate2#','#staxacc#','#supp1#',
			'#supp2#','#pono#','#dono#','#rem0#','#rem1#','#rem2#','#rem3#',
			'#rem4#','#rem5#','#rem6#','#rem7#','#rem8#','#rem9#','#rem10#','#rem11#','#rem12#','#frem0#',
			'#frem1#','#frem2#','#frem3#','#frem4#','#frem5#','#frem6#','#frem7#',
			'#frem8#','#frem9#','#comm1#','#comm2#','#comm3#','#comm4#','#id#','#generated#','#toinv#',
			'#order_cl#','','','','','#last_year#','#posted#',
			'#printed#','#lokstatus#','#void#','#name#','#pono2#','#dono2#','#csgtrans#','#taxincl#',
			'#tableno#','#cashier#','#member#','#counter#','#tourgroup#','#newdatetime#','#time#','#xtrcost#',
			'#xtrcost2#','#point#','#userid#','#bperiod#','#vperiod#','','','','','')
		</cfquery>
	</cfoutput> 
	<cfquery name="delearpso" datasource="#dts#">
		delete from tempar
	</cfquery>
	<cfquery name="updatecomm" datasource="#dts#">
		update artran set comm0='',comm1='',comm2='',comm3='',comm4='' 
	</cfquery>
	<h2>You have import Arpso9 successfully.</h2>
</cfif>
<cfif Icpso eq 'Import Icpso'>
	<cfquery name="deleicpso" datasource="#dts#">
		delete from tempictran
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icpso9.csv" into table tempictran fields terminated by '@'  enclosed by '^'  lines terminated by '\r\n';
	</cfquery>
	<cfquery name="updatetemp" datasource="#dts#">
		update tempictran set type = 'QUO' where type = 'QO'
	</cfquery>
	<cfquery name="gettemp" datasource="#dts#">
		select * from tempictran order by type,refno,itemcount 
	</cfquery>
	<cfoutput query="gettemp">
		<cfset left1 = left(#wos_date#,5)>
		<cfset mm = left(#left1#,2)>
		<cfset dd = right(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tmm = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tdd = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#">
		
		<cfset left1 = left(#dodate#,5)>
		<cfset mm = left(#left1#,2)>
		<cfset dd = right(#left1#,2)>
		<cfset yy = right(#dodate#,4)>
		<cfset newdodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset left1 = left(#sodate#,5)>
		<cfset mm = left(#left1#,2)>
		<cfset dd = right(#left1#,2)>
		<cfset yy = right(#sodate#,4)>
		<cfset newsodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<!--- <cfset left1 = left(#wos_date#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset time = right(trdatetime,8)>
		<cfset tdate = left(trdatetime,10)>
		<cfset tdd = left(trdatetime,2)>
		<cfset tyy = right(tdate,4)>
		<cfset tmmdd = left(tdate,5)>
		<cfset tmm = right(tmmdd,2)>
		<cfset newdatetime = "#tyy#"&"-"&"#tmm#"&"-"&"#tdd#"&" "&"#time#">
		
		<cfset left1 = left(#dodate#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#dodate#,4)>
		<cfset newdodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfset left1 = left(#sodate#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#sodate#,4)>
		<cfset newsodate = "#yy#"&"-"&"#mm#"&"-"&"#dd#"> --->
		
		<cfquery name="insertictran" datasource="#dts#">
			insert into ictran values ('#type#','#refno#','#refno2#','#trancode#','#custno#','#numberformat(fperiod,"00")#',
			'#newdate#','#currrate#','#itemcount#','#linecode#','#itemno#','#desp#','#despa#','#agenno#',
			'#location#','#source#','#job#','#sign#','#qty_bil#','#price_bil#','#unit_bil#',
			'#amt1_bil#','#dispec1#','#dispec2#','#dispec3#','#disamt_bil#','#amt_bil#','#taxpec1#',
			'#taxpec2#','#taxpec3#','#taxamt_bil#','#impstage#','#qty#','#price#','#unit#','#amt1#','#disamt#',
			'#amt#','#taxamt#','#factor1#','#factor2#','#dono#','#newdodate#','#newsodate#','#brem1#','#brem2#',
			'#brem3#','#brem4#','#packing#','#note1#','#note2#','#gltradac#','#updcost#','#gst_item#',
			'#totalup#','#withsn#','#grade#','#pur_price#','#qty1#','#qty2#','#qty3#','#qty4#','#qty5#',
			'#qty6#','#qty7#','#qty_ret#','#tempfigi#','#sercost#','#m_charge1#','#m_charge2#','#adtcost1#',
			'#adtcost2#','#it_cos#','#av_cost#','#batchcode#','','#point#','#inv_disc#',
			'#inv_tax#','#supp#','#edi_cou1#','#writeoff#','#toship#','#shipped#','#name#','#del_by#',
			'#van#','#generated#','#ud_qty#','#toinv#','','','',
			'','#brk_to#','#sv_part#','#last_year#','#void#','#sono#','#mc1_bil#','#mc2_bil#',
			'#userid#','#damt#','#oldbill#','#wos_group#','#category#','#area#','#shelf#','#temp#',
			'#temp1#','#body#','#totalgroup#','#mark#','#type_seq#','#promoter#','#tableno#','#member#',
			'#tourgroup#','#newdatetime#','#time#','#bomno#','#tostring(comment)#')
		</cfquery>
	</cfoutput>
	<cfquery name="deleicpso" datasource="#dts#">
		delete from tempictran
	</cfquery>
	<h2>You have import Icpso9 successfully.</h2>
</cfif>
<cfif Icitem eq 'Import Icitem'>
	<cfquery name="deleitem" datasource="#dts#">
		delete from icitem
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icitem9.csv" into table Icitem fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Icitem9 successfully.</h2>
</cfif>
<cfif Customer eq 'Import Customer'>
	<cfquery name="delecust" datasource="#dts#">
		delete from tempcust
	</cfquery>
	<cfquery name="delecust" datasource="#dts#">
		delete from customer
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/arcust9.csv" into table tempcust fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/arcust9.csv" into table customer fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	
	<cfquery name="getdata" datasource="#dts#">
		select customerno,date from tempcust
	</cfquery>
	
	<cfoutput query="getdata">
	
		<cfset left1 = left(#date#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfquery name="updatecust" datasource="#dts#">
			update customer set date = '#newdate#' where customerno = '#customerno#'
		</cfquery>		
		
	</cfoutput>
	<cfquery name="delecust" datasource="#dts#">
		delete from tempcust
	</cfquery>
	<cfquery name="updatecust" datasource="#dts#">
		update customer set currcode = 'SGD' where currcode = ''
	</cfquery>
	<h2>You have import Arcust9 successfully.</h2>	
</cfif>
<cfif Supplier eq 'Import Supplier'>
	<cfquery name="delesupp" datasource="#dts#">
		delete from tempsupp
	</cfquery>
	<cfquery name="delesupp" datasource="#dts#">
		delete from supplier
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/apvend9.csv" into table tempsupp fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/apvend9.csv" into table supplier fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="getdata" datasource="#dts#">
		select customerno,date from tempsupp
	</cfquery>
	
	<cfoutput query="getdata">
	
		<cfset left1 = left(#date#,5)>
		<cfset dd = left(#left1#,2)>
		<cfset mm = right(#left1#,2)>
		<cfset yy = right(#date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfquery name="updatecust" datasource="#dts#">
			update supplier set date = '#newdate#' where customerno = '#customerno#'
		</cfquery>		
		
	</cfoutput>
	<cfquery name="delesupp" datasource="#dts#">
		delete from tempsupp
	</cfquery>
	<cfquery name="updatesupp" datasource="#dts#">
		update supplier set currcode = 'SGD' where currcode = ''
	</cfquery>
	<h2>You have import Apvend9 successfully.</h2>
</cfif>
<cfif Iccate eq 'Import Iccate'>
	<cfquery name="delecate" datasource="#dts#">
		delete from iccate
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/iccate9.csv" into table Iccate fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Iccate9 successfully.</h2>
</cfif>
<cfif Icgroup eq 'Import Icgroup'>
	<cfquery name="delegroup" datasource="#dts#">
		delete from icgroup
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icgroup9.csv" into table icgroup fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Icgroup9 successfully.</h2>
</cfif>
<cfif Icagent eq 'Import Icagent'>
	<cfquery name="deleagent" datasource="#dts#">
		delete from icagent
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icagent9.csv" into table icagent fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Icagent9 successfully.</h2>
</cfif>
<cfif Iclocate eq 'Import Iclocate'>
	<cfquery name="delelocate" datasource="#dts#">
		delete from iclocation
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/iclocate9.csv" into table iclocation fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Iclocate9 successfully.</h2>
</cfif>
<cfif billmat eq 'Import billmat'>
	<cfquery name="delebillmat" datasource="#dts#">
		delete from billmat
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/Billmat9.csv" into table billmat fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Billmat9 successfully.</h2>
</cfif>
<cfif Currency eq 'Import Currency'>
	<cfquery name="deleCurrency" datasource="#dts#">
		delete from Currencyrate
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/Currency9.csv" into table Currencyrate fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Currency9 successfully.</h2>
</cfif>
<cfif ictrancmt eq 'Import ictrancmt'>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/ictrancmt.csv" into table commen1 fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Ictrancmt successfully.</h2>
</cfif>
<cfif icpsocmt eq 'Import icpsocmt'>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icpsocmt.csv" into table commen1 fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="delete_unwanted_comment" datasource="#dts#">
		delete from commen1 where comment in('',null);
	</cfquery>
	<h2>You have import Icpsocmt successfully.</h2>
</cfif>
<cfif iclink eq 'Import iclink'>
	<cfquery name="deldata" datasource="#dts#">
		delete from iclink
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/iclink9.csv" into table tempiclink fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="gettemp" datasource="#dts#">
		select * from tempiclink order by type,refno
	</cfquery>
	<cfoutput query="gettemp">
		<cfset left1 = left(#wos_date#,5)>
		<cfset mm = left(#left1#,2)>
		<cfset dd = right(#left1#,2)>
		<cfset yy = right(#wos_date#,4)>
		<cfset newdate = "#yy#"&"-"&"#mm#"&"-"&"#dd#">
		
		<cfquery name="insertictran" datasource="#dts#">
			insert into iclink values('#type#','#refno#','#trancode#','#newdate#','#frtype#',
			'#frrefno#','#frtrancode#','#frdate#','#itemno#','#qty#')
		</cfquery>
	
	</cfoutput>
	<cfquery name="deltempiclink" datasource="#dts#">
		delete from tempiclink
	</cfquery>
	<h2>You have import Iclink successfully.</h2>
</cfif>
<cfif icserial eq 'Import icserial'>
	<cfquery name="deldata" datasource="#dts#">
		delete from iserial
	</cfquery>
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icserial9.csv" into table iserial fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Icserial successfully.</h2>
</cfif>
<cfif fifoopq eq 'Import Fifoopq'>
	<cfquery name="deldata" datasource="#dts#">
		delete from fifoopq
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/fifoopq.csv" into table fifoopq fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Fifoopq successfully.</h2>
</cfif>
<cfif Icl3p eq 'Import Icl3p'>
	<cfquery name="deldata" datasource="#dts#">
		delete from tempicl3p
	</cfquery>
	<cfquery name="deldata" datasource="#dts#">
		delete from icl3p2
	</cfquery>
	<cfquery name="deldata" datasource="#dts#">
		delete from icl3p
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icl3P.csv" into table tempicl3p fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
	</cfquery>
	<cfquery name="getdata" datasource="#dts#">
		select * from tempicl3p
	</cfquery>
	<cfloop query="getdata">
		<cfset newldate1 = '0000-00-00'>
		<cfset newldate2 = '0000-00-00'>
		<cfset newldate3 = '0000-00-00'>
		<cfset newldate4 = '0000-00-00'>
		<cfset newldate5 = '0000-00-00'>
		<cfset newldate6 = '0000-00-00'>
		<cfset newldate7 = '0000-00-00'>
		<cfset newldate8 = '0000-00-00'>
		<cfset newldate9 = '0000-00-00'>
		<cfif ltype1 neq ''>		
			<cfset left1 = left(#ldate1#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate1#,2)>
			<cfset newldate1 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype2 neq ''>
			<cfset left1 = left(#ldate2#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate2#,2)>
			<cfset newldate2 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">
		</cfif>
		<cfif ltype3 neq ''>
			<cfset left1 = left(#ldate3#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate3#,2)>
			<cfset newldate3 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype4 neq ''>
			<cfset left1 = left(#ldate4#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate4#,2)>
			<cfset newldate4 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype5 neq ''>
			<cfset left1 = left(#ldate5#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate5#,2)>
			<cfset newldate5 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype6 neq ''>
			<cfset left1 = left(#ldate6#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate6#,2)>
			<cfset newldate6 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype7 neq ''>
			<cfset left1 = left(#ldate7#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate7#,2)>
			<cfset newldate7 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype8 neq ''>
			<cfset left1 = left(#ldate8#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate8#,2)>
			<cfset newldate8 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		<cfif ltype9 neq ''>
			<cfset left1 = left(#ldate9#,5)>
			<cfset mm = left(#left1#,2)>
			<cfset dd = right(#left1#,2)>
			<cfset yy = right(#ldate9#,2)>
			<cfset newldate9 = "20"&"#yy#"&"-"&"#mm#"&"-"&"#dd#">		
		</cfif>
		
		<cfquery name="upate" datasource="#dts#">
			update tempicl3p set ldate1='#newldate1#',ldate2='#newldate2#',ldate3='#newldate3#',
			ldate4='#newldate4#',ldate5='#newldate5#',ldate6='#newldate6#',ldate7='#newldate7#',
			ldate8='#newldate8#',ldate9='#newldate9#' where itemno = '#itemno#' and custno = '#custno#'
		</cfquery>	
	
	</cfloop>
	<cfquery name="export" datasource="#dts#">
		select * into outfile "C:/icl3p3.csv" fields terminated by ',' enclosed by '|' lines terminated by '\r\n' from tempicl3p where custno like '4%' order by custno;
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/icl3P3.csv" into table icl3p fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	
	<cfquery name="export" datasource="#dts#">
		select * into outfile "C:/icl3p4.csv" fields terminated by ',' enclosed by '|' lines terminated by '\r\n' from tempicl3p where custno like '3%' order by custno;
	</cfquery>	
	<cfquery name="import2" datasource="#dts#">
		load data infile "C:/icl3P4.csv" into table icl3p2 fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	
	<h2>You have import Icl3p successfully.</h2>
</cfif>
<cfif Comment eq 'Import Comment'>
	<cfquery name="deldata" datasource="#dts#">
		delete from comments
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/Comment.csv" into table Comments fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Comment successfully.</h2>
</cfif>
<cfif Icservi eq 'Import Icservi'>
	<cfquery name="deldata" datasource="#dts#">
		delete from Icservi
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/Icservi.csv" into table Icservi fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Icservi successfully.</h2>
</cfif>
<cfif Address eq 'Import Address'>
	<cfquery name="deldata" datasource="#dts#">
		delete from Address
	</cfquery>	
	<cfquery name="import" datasource="#dts#">
		load data infile "C:/address.csv" into table address fields terminated by ',' enclosed by '|' lines terminated by '\r\n';
	</cfquery>
	<h2>You have import Address successfully.</h2>
</cfif>
<!--- FTP --->

<cfif artran1 eq 'FTP Artran'>
	<CFFILE DESTINATION="C:\artran9.csv" ACTION="UPLOAD" FILEFIELD="form.artranb" attributes="normal">
	<h2>You have FTP Artran9 successfully.</h2>	
</cfif>
<cfif Ictran1 eq 'FTP Ictran'>
	<CFFILE DESTINATION="C:\ictran9.csv" ACTION="UPLOAD" FILEFIELD="form.ictranb" attributes="normal">
	<h2>You have FTP Ictran9 successfully.</h2>
</cfif>
<cfif Arpso1 eq 'FTP Arpso'>
	<CFFILE DESTINATION="C:\Arpso9.csv" ACTION="UPLOAD" FILEFIELD="form.Arpsob" attributes="normal">
	<h2>You have FTP Arpso9 successfully.</h2>
</cfif>
<cfif Icpso1 eq 'FTP Icpso'>
	<CFFILE DESTINATION="C:\Icpso9.csv" ACTION="UPLOAD" FILEFIELD="form.Icpsob" attributes="normal">
	<h2>You have FTP Icpso9 successfully.</h2>
</cfif>
<cfif Icitem1 eq 'FTP Icitem'>
	<CFFILE DESTINATION="C:\Icitem9.csv" ACTION="UPLOAD" FILEFIELD="form.Icitemb" attributes="normal">
	<h2>You have FTP Icitem9 successfully.</h2>
</cfif>
<cfif Customer1 eq 'FTP Customer'>	
	<CFFILE DESTINATION="C:\arcust9.csv" ACTION="UPLOAD" FILEFIELD="form.customerb" attributes="normal">
	<h2>You have FTP Arcust9 successfully.</h2>	
</cfif>
<cfif Supplier1 eq 'FTP Supplier'>
	<CFFILE DESTINATION="C:\apvend9.csv" ACTION="UPLOAD" FILEFIELD="form.supplierb" attributes="normal">
	<h2>You have FTP Apvend9 successfully.</h2>
</cfif>
<cfif Iccate1 eq 'FTP Iccate'>
	<CFFILE DESTINATION="C:\Iccate9.csv" ACTION="UPLOAD" FILEFIELD="form.Iccateb" attributes="normal">
	<h2>You have FTP Iccate9 successfully.</h2>
</cfif>
<cfif Icgroup1 eq 'FTP Icgroup'>
	<CFFILE DESTINATION="C:\Icgroup9.csv" ACTION="UPLOAD" FILEFIELD="form.Icgroupb" attributes="normal">
	<h2>You have FTP Icgroup9 successfully.</h2>
</cfif>
<cfif Icagent1 eq 'FTP Icagent'>
	<CFFILE DESTINATION="C:\Icagent9.csv" ACTION="UPLOAD" FILEFIELD="form.Icagentb" attributes="normal">
	<h2>You have FTP Icagent9 successfully.</h2>
</cfif>
<cfif Iclocate1 eq 'FTP Iclocate'>
	<CFFILE DESTINATION="C:\Iclocate9.csv" ACTION="UPLOAD" FILEFIELD="form.Iclocateb" attributes="normal">
	<h2>You have FTP Iclocate9 successfully.</h2>
</cfif>
<cfif billmat1 eq 'FTP Billmat'>
	<CFFILE DESTINATION="C:\billmat9.csv" ACTION="UPLOAD" FILEFIELD="form.billmatb" attributes="normal">
	<h2>You have FTP Billmat9 successfully.</h2>
</cfif>
<cfif Currency1 eq 'FTP Currency'>
	<CFFILE DESTINATION="C:\Currency9.csv" ACTION="UPLOAD" FILEFIELD="form.Currencyb" attributes="normal">
	<h2>You have FTP Currency9 successfully.</h2>
</cfif>
<cfif Ictrancmt1 eq 'FTP Ictrancmt'>
	<CFFILE DESTINATION="C:\ictrancmt.csv" ACTION="UPLOAD" FILEFIELD="form.ictrancmtb" attributes="normal">
	<h2>You have FTP Ictrancmt successfully.</h2>
</cfif>
<cfif Icpsocmt1 eq 'FTP Icpsocmt'>
	<CFFILE DESTINATION="C:\icpsocmt.csv" ACTION="UPLOAD" FILEFIELD="form.icpsocmtb" attributes="normal">
	<h2>You have FTP Icpsocmt successfully.</h2>
</cfif>
<cfif Iclink1 eq 'FTP Iclink'>
	<CFFILE DESTINATION="C:\iclink9.csv" ACTION="UPLOAD" FILEFIELD="form.iclinkb" attributes="normal">
	<h2>You have FTP Iclink successfully.</h2>
</cfif>
<cfif Icserial1 eq 'FTP Icserial'>
	<CFFILE DESTINATION="C:\icserial9.csv" ACTION="UPLOAD" FILEFIELD="form.icserialb" attributes="normal">
	<h2>You have FTP Icserial successfully.</h2>
</cfif>
<cfif Fifoopq1 eq 'FTP Fifoopq'>
	<CFFILE DESTINATION="C:\fifoopq.csv" ACTION="UPLOAD" FILEFIELD="form.fifoopqb" attributes="normal">
	<h2>You have FTP Fifoopq successfully.</h2>
</cfif>
<cfif Icl3p1 eq 'FTP Icl3p'>
	<CFFILE DESTINATION="C:\icl3p.csv" ACTION="UPLOAD" FILEFIELD="form.icl3pb" attributes="normal">
	<h2>You have FTP Icl3p successfully.</h2>
</cfif>
<cfif Comment1 eq 'FTP Comment'>
	<CFFILE DESTINATION="C:\Comment.csv" ACTION="UPLOAD" FILEFIELD="form.Commentb" attributes="normal">
	<h2>You have FTP Comment successfully.</h2>
</cfif>
<cfif Icservi1 eq 'FTP Icservi'>
	<CFFILE DESTINATION="C:\Icservi.csv" ACTION="UPLOAD" FILEFIELD="form.Icservib" attributes="normal">
	<h2>You have FTP Icservi successfully.</h2>
</cfif>
<cfif Address1 eq 'FTP Address'>
	<CFFILE DESTINATION="C:\address.csv" ACTION="UPLOAD" FILEFIELD="form.Addressb" attributes="normal">
	<h2>You have FTP Address successfully.</h2>
</cfif>

<!--- DELETE --->

<cfif delartran eq 'Delete Artran'>
	<cffile action = "delete" file = "C:\artran9.csv">
	<h2>You have deleted Artran9 successfully.</h2>	 
</cfif>

<cfif delictran eq 'Delete Ictran'>
	<cffile action = "delete" file = "C:\ictran9.csv">
	<h2>You have deleted Ictran9 successfully.</h2>	 
</cfif>

<cfif delarpso eq 'Delete Arpso'>
	<cffile action = "delete" file = "C:\arpso9.csv">
	<h2>You have deleted Arpso9 successfully.</h2>	 
</cfif>

<cfif delicpso eq 'Delete Icpso'>
	<cffile action = "delete" file = "C:\icpso9.csv">
	<h2>You have deleted Icpso9 successfully.</h2>	 
</cfif>

<cfif delicitem eq 'Delete Icitem'>
	<cffile action = "delete" file = "C:\icitem9.csv">
	<h2>You have deleted Icitem9 successfully.</h2>	 
</cfif>

<cfif delcustomer eq 'Delete Customer'>
	<cffile action = "delete" file = "C:\arcust9.csv">
	<h2>You have deleted Arcust9 successfully.</h2>	 
</cfif>

<cfif delsupplier eq 'Delete Supplier'>
	<cffile action = "delete" file = "C:\apvend9.csv">
	<h2>You have deleted Apvend9 successfully.</h2>	 
</cfif>

<cfif deliccate eq 'Delete Iccate'>
	<cffile action = "delete" file = "C:\iccate9.csv">
	<h2>You have deleted Iccate9 successfully.</h2>	 
</cfif>

<cfif delicgroup eq 'Delete Icgroup'>
	<cffile action = "delete" file = "C:\icgroup9.csv">
	<h2>You have deleted Icgroup9 successfully.</h2>	 
</cfif>

<cfif delicagent eq 'Delete Icagent'>
	<cffile action = "delete" file = "C:\icagent9.csv">
	<h2>You have deleted Icagent9 successfully.</h2>	 
</cfif>

<cfif deliclocate eq 'Delete Iclocate'>
	<cffile action = "delete" file = "C:\iclocate9.csv">
	<h2>You have deleted Iclocate9 successfully.</h2>	 
</cfif>

<cfif delbillmat eq 'Delete Billmat'>
	<cffile action = "delete" file = "C:\billmat9.csv">
	<h2>You have deleted Billmat9 successfully.</h2>	 
</cfif>

<cfif delcurrency eq 'Delete Currency'>
	<cffile action = "delete" file = "C:\Currency9.csv">
	<h2>You have deleted Currency9 successfully.</h2>	 
</cfif>

<cfif delictrancmt eq 'Delete Ictrancmt'>
	<cffile action = "delete" file = "C:\ictrancmt.csv">
	<h2>You have deleted Ictrancmt successfully.</h2>	 
</cfif>

<cfif delicpsocmt eq 'Delete Icpsocmt'>
	<cffile action = "delete" file = "C:\icpsocmt.csv">
	<h2>You have deleted Icpsocmt successfully.</h2>	 
</cfif>

<cfif deliclink eq 'Delete Iclink'>
	<cffile action = "delete" file = "C:\iclink9.csv">
	<h2>You have deleted Iclink successfully.</h2>	 
</cfif>

<cfif delicserial eq 'Delete Icserial'>
	<cffile action = "delete" file = "C:\icserial9.csv">
	<h2>You have deleted Icserial successfully.</h2>	 
</cfif>
<cfif delfifoopq eq 'Delete Fifoopq'>
	<cffile action = "delete" file = "C:\fifoopq.csv">
	<h2>You have deleted Fifoopq successfully.</h2>	 
</cfif>
<cfif delicl3p eq 'Delete Icl3p'>
	<cffile action = "delete" file = "C:\icl3p.csv">
	<h2>You have deleted Icl3p successfully.</h2>	 
</cfif>
<cfif delComment eq 'Delete Comment'>
	<cffile action = "delete" file = "C:\Comment.csv">
	<h2>You have deleted Comment successfully.</h2>	 
</cfif>
<cfif delIcservi eq 'Delete Icservi'>
	<cffile action = "delete" file = "C:\Icservi.csv">
	<h2>You have deleted Icservi successfully.</h2>	 
</cfif>
<cfif delAddress eq 'Delete Address'>
	<cffile action = "delete" file = "C:\address.csv">
	<h2>You have deleted Address successfully.</h2>	 
</cfif>
</body>
</html>
