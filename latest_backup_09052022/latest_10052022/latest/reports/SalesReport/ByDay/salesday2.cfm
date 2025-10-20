<cfswitch expression="#form.result#">
    <cfcase value="HTML">
        <html>
        <head>
        <title>End User Sales By Week Report</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
        <style type="text/css" media="print">
            .noprint { display: none; }
        </style>
        </head>
        
        <cfquery name="getgeneral" datasource="#dts#">
            select cost,compro,lastaccyear from gsetup
        </cfquery>
        
        <cfset fccurr = DateAdd('m', form.periodfrom, "#getgeneral.LastAccYear#")>
        
        <cfquery name="getgsetup2" datasource='#dts#'>
            select * from gsetup2
        </cfquery>
        
        <cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
        <cfset stDecl_UPrice = ",___.">
        
        <cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
            <cfset stDecl_UPrice = stDecl_UPrice & "_">
        </cfloop>
        
        <body>
        <cfoutput>
        <h1 align="center">PRINT #url.trantype# SALES DAILY REPORT (Excluded DN/CN)</h1>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">MONTH: #dateformat(fccurr,"mmm yy")#</font></div></td>
            </tr>
            <cfif form.enduserfrom neq "" and form.enduserto neq "">
                <tr>
                    <td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">END USER: #form.enduserfrom# - #form.enduserto#</font></div></td>
                </tr>
            </cfif>
            <tr>
                <td colspan="90%"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td colspan="10%"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
            </tr>
            <tr>
                <td colspan="100%"><hr></td>
            </tr>
        
            <cfset lastyear = year(getgeneral.lastaccyear)>
            <cfset lastmonth = month(getgeneral.lastaccyear)>
            <cfset lastday = 1>
            <cfset selectedmonth = val(form.periodfrom)>
            <cfset count = 1>
            <cfset nodays = arraynew(1)>
            
            <cfset lastmonth = lastmonth + selectedmonth>
            
            <cfif lastmonth gt 24>
                <cfset lastyear = lastyear + 2>
                <cfset lastmonth = lastmonth -24>
                <cfelseif lastmonth gt 12>
                <cfset lastyear = lastyear + 1>
                <cfset lastmonth = lastmonth -12>
            </cfif>
            
            <cfset days = firstdayofmonth(createdate(lastyear,lastmonth,lastday))-2>
            
            <cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
            
            
            
            <cfloop index="a" from="1" to="#totalday#">
                <cfset nodays[a] = a>
            </cfloop>
        
            <cfset newtime = createdate(lastyear,1,1) + days>
        
            <tr>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO.</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
            <cfloop index="a" from="1" to="#totalday#">
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(lastyear,lastmonth,a),'DD/MM/YYYY')#</font></div></td>
            </cfloop>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
            </tr>
            <tr>
                <td colspan="100%"><hr></td>
            </tr>
        
        <!---<cfquery name="getdriver" datasource="#dts#">
            select * from driver where 0=0
            <cfif form.enduserfrom neq "" and form.enduserto neq "">
             and driverno >='#form.enduserfrom#' and driverno <='#form.enduserto#'
            </cfif>
            group by driverno order by driverno
        </cfquery>--->
        <cfquery name="getdriver" datasource="#dts#">
            select a.van, b.driverno, b.name
            from artran a 
            left join driver b on a.van = b.driverno
            where 0=0
            <cfif form.enduserfrom neq "" and form.enduserto neq "">
            	and a.van >='#form.enduserfrom#' and a.van <='#form.enduserto#'
            </cfif>
            group by a.van order by a.van
        </cfquery>
        
        <cfset total = arraynew(1)>
        <cfset subtotal = arraynew(1)>
        
        <cfloop index="a" from="1" to="#totalday#">
            <cfset total[a] = 0>
        </cfloop>
        
        <cfloop query="getdriver">
            <cfset van = getdriver.van>
        
            <cfloop index="a" from="1" to="#totalday#">
                <cfset subtotal[a] = 0>
            </cfloop>
        
            <cfquery name="getintran" datasource="#dts#">
                select wos_date,invgross as amt from artran
                where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and van = '#van#' and (void = '' or void is null)
                and (type = 'INV' or type = 'CS' or type = 'CN')
                order by fperiod
            </cfquery>
        
            <cfloop query="getintran">
                <cfset checkday = day(getintran.wos_date)>
                <cfloop index="a" from="1" to="#totalday#">
                    <cfif nodays[a] eq checkday>
                        <cfset subtotal[a] = subtotal[a] + val(getintran.amt)>
                        <cfset total[a] = total[a] + val(getintran.amt)>
                    </cfif>
                </cfloop>
            </cfloop>
        
            <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdriver.driverno#</font></div></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdriver.name#</font></div></td>
                <cfloop index="a" from="1" to="#totalday#">
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal[a],stDecl_UPrice)#</font></div></td>
                </cfloop>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(subtotal),stDecl_UPrice)#</font></div></td>
            </tr>
            <cfflush>
        </cfloop>
            <tr>
                <td colspan="100%"><hr></td>
            </tr>
            <tr>
                <td></td>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
                <cfloop index="a" from="1" to="#totalday#">
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(total[a],",.__")#</strong></font></div></td>
                </cfloop>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(total),",.__")#</strong></font></div></td>
            </tr>
        </table>
        
        <cfif getdriver.recordcount eq 0>
            <h3>Sorry, No records were found.</h3>
        </cfif>
        </cfoutput>
        <br>
        <br>
        <div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
        <p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
        </body>
        </html>
    </cfcase>
    <cfcase value="PDF">
        <cfquery name="getGSetup" datasource="#dts#">
            select compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno from gsetup 
        </cfquery>
        <cfquery name="getgeneral" datasource="#dts#">
            select lastaccyear,filterall from gsetup
        </cfquery>
        
        
        <cfset lastyear = year(getgeneral.lastaccyear)>
            <cfset lastmonth = month(getgeneral.lastaccyear)>
            <cfset lastday = 1>
            <cfset selectedmonth = val(form.periodfrom)>
            <cfset count = 1>
            <cfset nodays = arraynew(1)>
            <cfset lastmonth = lastmonth + selectedmonth>
            <cfif lastmonth gt 24>
                <cfset lastyear = lastyear + 2>
                <cfset lastmonth = lastmonth -24>
                <cfelseif lastmonth gt 12>
                <cfset lastyear = lastyear + 1>
                <cfset lastmonth = lastmonth -12>
            </cfif>
        
            <cfset firstdate = dateformat(createdate(lastyear,lastmonth,1),'DD/MM/YYYY')>
            
            <cfset totalday = daysinmonth(createdate(lastyear,lastmonth,1))>
            <cfset lastdate = dateformat(createdate(lastyear,lastmonth,totalday),'DD/MM/YYYY')>
        
        
        
        <cfoutput>
        
        <cfquery name="MyQuery" datasource="#dts#">
        
        
        
        
        select ifnull(amt,0)-ifnull(cn_amt,0) AS grandAmt,ifnull(tax,0)-ifnull(cn_tax,0) AS tax,ifnull(grand,0)-ifnull(cn_grand,0) AS grand,aa.van,aa.wos_date from (
        		
                select wos_date,van from artran
                where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and (void = '' or void is null)
                and (type = 'INV' or type = 'CS' or type = 'CN')
                group by van,wos_date
                order by van,wos_date) as aa
                
                LEFT JOIN(
                	select wos_date,IFNULL(sum(invgross),0) as amt,IFNULL(sum(tax),0) as tax, IFNULL(sum(grand),0) as grand,van from artran
                    where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and (void = '' or void is null)
                    and (type = 'INV' or type = 'CS')
                    group by van,wos_date
                    order by van,wos_date) as bb ON aa.van=bb.van AND aa.wos_date=bb.wos_date
                    
                    LEFT JOIN(
                        select wos_date,IFNULL(sum(invgross),0) as cn_amt,IFNULL(sum(tax),0) as cn_tax, IFNULL(sum(grand),0) as cn_grand,van from artran
                        where wos_date > #getgeneral.lastaccyear# and fperiod = '#form.periodfrom#' and (void = '' or void is null)
                        and (type = 'CN')
                        group by van,wos_date
                        order by van,wos_date) as cc ON aa.van=cc.van AND aa.wos_date=cc.wos_date
                
              
        </cfquery>
        
        </cfoutput>
        
        <cfset reportname = "salesday2.cfr">
        
        <cfreport template="#reportname#" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
            <cfreportparam name="compro" value="#getGSetup.compro#">
            <cfreportparam name="compro2" value="#getGSetup.compro2#">
            <cfreportparam name="compro3" value="#getGSetup.compro3#">
            <cfreportparam name="compro4" value="#getGSetup.compro4#">
            <cfreportparam name="compro5" value="#getGSetup.compro5#">
            <cfreportparam name="compro6" value="#getGSetup.compro6#">
            <cfreportparam name="compro7" value="#getGSetup.compro7#">
            <cfreportparam name="datefrom" value="#firstdate#">
            <cfreportparam name="dateto" value="#lastdate#">
            <cfreportparam name="dts" value="#form.periodfrom#">
            <cfreportparam name="gstno" value="#getGSetup.gstno#">
        </cfreport>
    </cfcase>
</cfswitch>