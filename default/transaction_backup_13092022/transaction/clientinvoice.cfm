<!---<cfoutput>#url.type#---------#url.invno#---------</cfoutput>--->
<cfinclude template="/object/dateobject.cfm">
<cfset invoicemonth2=createdate(right(url.invoicedate,4),mid(url.invoicedate,4,2),left(url.invoicedate,2))>
<cfset invoicemonth1=month(invoicemonth2)>
<cfset invoiceyear=year(url.invoicedate)>
<cfset custno=url.custno>
<cfset invoicedate=url.invoicedate>
<cfset invno=url.invno>
<cfset type=url.type>
<cfoutput>
<cfform name="tsform1" id="tsform1" method="post" action="/default/transaction/clientinvoice.cfm?custno=#url.custno#&invoicedate=#url.invoicedate#&type=#url.type#&invno=#url.invno#">
<table>
<tr>
<th align="left">Date From :</th>
<td><cfset datestart = dateformat(createdate(invoiceyear,invoicemonth1,1),'dd/mm/yyyy')>
<cfif isdefined('form.tsdatefrom')>
<cfset datestart = form.tsdatefrom>
</cfif>
<cfinput type="text" name="tsdatefrom" id="tsdatefrom" value="#datestart#" validate="eurodate" required="yes" message="Date From is Invalid / Required!">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('tsdatefrom'));">
				(DD/MM/YYYY)</td>
</tr>
<tr>
<th align="left">Date To :</th>
<td><cfset dateend = dateformat(createdate(invoiceyear,invoicemonth1,daysinmonth(createdate(invoiceyear,invoicemonth1,1))),'dd/mm/yyyy')>
<cfif isdefined('form.tsdateto')>
<cfset dateend = form.tsdateto>
</cfif>
<cfinput type="text" name="tsdateto" id="tsdateto" value="#dateend#" message="Date To is Invalid / Required!">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('tsdateto'));"></td>
</tr>

<tr>
<td colspan="2" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Change">
</td>
</tr>
</table>



</cfform>
</cfoutput>
<!---<cfset type='inv'>
<cfset invno='989898'>
<cfset custno='301'>
<cfset invoiceyear='2014'>
<cfset invoicemonth1='01'>
<cfset invoicedate='2012/12/12'>--->

<cfif left(invoicemonth1,1) eq '0'>
<cfset invoicemonth=ReplaceNoCase(invoicemonth1,'0','')>
<cfelse>
<cfset invoicemonth=month(invoicemonth2)>
</cfif>

<!--- <cfquery name="getlist" datasource="#dts#">
SELECT empno,activity,skillset FROM emptimesheet
</cfquery> --->

<cfquery name="getproject" datasource="#dts#">
SELECT * FROM
(SELECT catid,custno,hourlyrate,dailyrate,monthlyrate,ot1rate,ot2rate,sunphrate,"daily" as payratetype FROM clientworkerrate WHERE custno='#custno#') as a
LEFT JOIN
(SELECT source,project,custno,letterreference,quotationreference,quotationdate,letterreferencedate FROM #target_project#)as b
ON a.custno=b.custno
LEFT JOIN
(SELECT project,costcentreid,costcentre FROM overhead)as c
ON b.source=c.project
<!--- LEFT JOIN
(SELECT source,empno,payratetype FROM employeeplacement) as d
ON c.project=d.source --->
LEFT JOIN
(SELECT catid,catname FROM workcategory) as e
ON a.catid=e.catid
LEFT JOIN
(SELECT activity,empno,skillset,month,year,day,realdate,groupdata FROM emptimesheet WHERE 
month='#invoicemonth#'and year='#invoiceyear#'
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#trim(dateformatnew(form.tsdatefrom,'yyyy-mm-dd'))#" and "#trim(dateformatnew(form.tsdateto,'yyyy-mm-dd'))#"
</cfif>
group by empno,activity,skillset,groupdata
)as g
ON <!--- f.empno=g.empno and  --->c.costcentreid=g.activity and e.catid=g.skillset
LEFT JOIN
(SELECT empno,name FROM #replace(dts,'_i','_p')#.pmast)as f
ON g.empno=f.empno

WHERE <!--- g.empno IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.empno)#" list="yes" separator=",">) 
and g.activity IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.activity)#" list="yes" separator=",">) 
and g.skillset IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.skillset)#" list="yes" separator=",">)
and ---> g.month='#invoicemonth#'and g.year='#invoiceyear#'
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and g.realdate BETWEEN  "#trim(dateformatnew(form.tsdatefrom,'yyyy-mm-dd'))#" and "#trim(dateformatnew(form.tsdateto,'yyyy-mm-dd'))#"
</cfif>
GROUP BY b.source,f.empno,a.catid,g.groupdata
<!---GROUP BY a.catid,b.source,c.costcentre,d.payratetype ORDER BY b.source--->
</cfquery>


<cfoutput>
<!---
SELECT * FROM
(SELECT catid,custno,hourlyrate,dailyrate,monthlyrate,ot1rate,ot2rate,sunphrate,"daily" as payratetype FROM clientworkerrate WHERE custno='#custno#') as a
LEFT JOIN
(SELECT source,project,custno,letterreference,quotationreference,quotationdate,letterreferencedate FROM #target_project#)as b
ON a.custno=b.custno
LEFT JOIN
(SELECT project,costcentreid,costcentre FROM overhead)as c
ON b.source=c.project
<!--- LEFT JOIN
(SELECT source,empno,payratetype FROM employeeplacement) as d
ON c.project=d.source --->
LEFT JOIN
(SELECT catid,catname FROM workcategory) as e
ON a.catid=e.catid
LEFT JOIN
(SELECT distinct(activity),empno,skillset,month,year,day,realdate FROM emptimesheet WHERE 
month='#invoicemonth#'and year='#invoiceyear#'
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#trim(dateformatnew(form.tsdatefrom,'yyyy-mm-dd'))#" and "#trim(dateformatnew(form.tsdateto,'yyyy-mm-dd'))#"
</cfif>
)as g
ON <!--- f.empno=g.empno and  --->c.costcentreid=g.activity and e.catid=g.skillset
LEFT JOIN
(SELECT empno,name FROM #replace(dts,'_i','_p')#.pmast)as f
ON g.empno=f.empno

WHERE <!--- g.empno IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.empno)#" list="yes" separator=",">) 
and g.activity IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.activity)#" list="yes" separator=",">) 
and g.skillset IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.skillset)#" list="yes" separator=",">)
and ---> g.month='#invoicemonth#'and g.year='#invoiceyear#'
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and g.realdate BETWEEN  "#trim(dateformatnew(form.tsdatefrom,'yyyy-mm-dd'))#" and "#trim(dateformatnew(form.tsdateto,'yyyy-mm-dd'))#"
</cfif>
GROUP BY b.source,f.empno,a.catid
<!---GROUP BY a.catid,b.source,c.costcentre,d.payratetype ORDER BY b.source--->
--->

<cfset proj = ''>
<cfform name="detail" action="invoicedetail.cfm" method="post">
<cfif getproject.recordcount neq 0>
<table width="80%" border="1" style="border-collapse:collapse" align="center">
<cfquery name="getpubdate" datasource="#replace(dts,'_i','_p')#">
     SELECT hol_date FROM holtable WHERE hol_date between '#dateformatnew(datestart,'yyyy-mm-dd')#' 
        AND '#dateformatnew(dateend,'yyyy-mm-dd')#' order by hol_date  
    </cfquery>
    
    <cfset publist = "">
    <cfif getpubdate.recordcount neq 0>
    	<cfloop query="getpubdate">
        <cfset publist=publist&dateformat(hol_date,'yyyy-mm-dd')>
        <cfif getpubdate.recordcount neq getpubdate.currentrow>
        <cfset publist=publist&",">
        </cfif>
        </cfloop>
	</cfif>
    
    <cfset sunlist = "">
    <cfset getdatediff = datediff('d',createdate(listlast(datestart,'/'),listgetat(datestart,'2','/'),listfirst(datestart,'/')),createdate(listlast(dateend,'/'),listgetat(dateend,'2','/'),listfirst(dateend,'/')))>
    <cfset newstartdate = createdate(listlast(datestart,'/'),listgetat(datestart,'2','/'),listfirst(datestart,'/'))>
    <cfloop from="0" to="#getdatediff#" index="a">
    <cfset newtsdate = dateadd('d',a,newstartdate)>
    <cfif dayofweek(newtsdate) eq 1>
    <cfset sunlist = sunlist&dateformat(newtsdate,'yyyy-mm-dd')&",">
	</cfif>
    </cfloop>
    
<cfloop query="getproject">
<cfset phday = 0>
<cfset phtime = 0 >
<cfset phot15 = 0>
<cfset phot20 = 0>


<cfquery name="gettotaltime" datasource="#dts#">
SELECT offday,SUM(((timeto*60)+minb)-((timefrom*60)+mina)) as totaltime,SUM(ot1) as totalot1,SUM(ot2) as totalot2,timesheetid FROM emptimesheet WHERE activity ='#getproject.costcentreid#' 
AND month='#invoicemonth#' AND year='#invoiceyear#' AND skillset='#getproject.catid#' AND groupdata = '#getproject.groupdata#'  and empno = "#getproject.empno#"
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#dateformatnew(form.tsdatefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.tsdateto,'yyyy-mm-dd')#"
</cfif>
</cfquery>

<cfquery name="gettotaltimesunph" datasource="#dts#">
SELECT SUM(((timeto*60)+minb)-((timefrom*60)+mina)) as totaltime,SUM(ot1) as totalot1,SUM(ot2) as totalot2,timesheetid FROM emptimesheet WHERE activity ='#getproject.costcentreid#' and <cfif gettotaltime.offday eq "">(realdate in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#publist#">) or realdate in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#sunlist#">) )<cfelse>
offday = "off"
</cfif>
AND month='#invoicemonth#' AND year='#invoiceyear#' AND skillset='#getproject.catid#' AND groupdata = '#getproject.groupdata#'   and empno = "#getproject.empno#"
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#dateformatnew(form.tsdatefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.tsdateto,'yyyy-mm-dd')#"
</cfif>
</cfquery>


<cfset phtime = val(gettotaltimesunph.totaltime)/60 >
<cfset phot15 = val(gettotaltimesunph.totalot1)>
<cfset phot20 = val(gettotaltimesunph.totalot2)>

<cfquery name="gettotalday" datasource="#dts#">
SELECT COUNT(realdate)/2 as totalday FROM emptimesheet WHERE activity
='#getproject.costcentreid#'
AND month='#invoicemonth#' AND year='#invoiceyear#' AND 
<cfif gettotaltime.offday eq "">(realdate not in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#publist#">) and realdate not in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#sunlist#">) )<cfelse>offday="no"</cfif> and  activity <> '' AND skillset='#getproject.catid#' AND groupdata = '#getproject.groupdata#'  and empno = "#getproject.empno#"
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#dateformatnew(form.tsdatefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.tsdateto,'yyyy-mm-dd')#"
</cfif>
</cfquery>
 
 
 <cfquery name="gettotaldaysunph" datasource="#dts#">
SELECT COUNT(realdate)/2 as totalday FROM emptimesheet WHERE  activity ='#getproject.costcentreid#' and <cfif gettotaltime.offday eq "">(realdate in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#publist#">) or realdate in (<cfqueryparam cfsqltype="cf_sql_date" list="yes" separator="," value="#sunlist#">) )<cfelse>offday="off"</cfif>
AND month='#invoicemonth#' AND year='#invoiceyear#' AND activity <> '' AND skillset='#getproject.catid#' AND groupdata = '#getproject.groupdata#'   and empno = "#getproject.empno#"
<cfif isdefined('form.tsdatefrom') and isdefined('form.tsdateto')>
and realdate BETWEEN  "#dateformatnew(form.tsdatefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.tsdateto,'yyyy-mm-dd')#"
</cfif>
</cfquery>


<cfset phday = val(gettotaldaysunph.totalday)>


<cfquery name="getinvoiceinfo" datasource="#dts#">
SELECT empno,sourceproject,catid FROM ictran WHERE empno='#getproject.empno#' and sourceproject='#getproject.source#' and catid='#getproject.catid#'
and brem3 = "#datestart#"
</cfquery>

 <cfset totaltime1=val(gettotaltime.totaltime)/60>
 <cfif getproject.payratetype eq 'hourly'>
 <cfset hourrate=getproject.hourlyrate>
 <cfelseif getproject.payratetype eq 'daily' >
 <cfset dayrate=getproject.dailyrate>
 <cfelseif getproject.payratetype eq 'monthly' > 
 <cfset monthlyrate=getproject.monthlyrate> 
 <cfelse>
 </cfif>

<!---<cfif getproject.hourlyrate neq '0.00' or  getproject.dailyrate neq '0.00' or  getproject.monthlyrate neq '0.00'>--->

<cfif proj neq source>
<tr><td colspan="20"><div align="left"><b>Project : #getproject.project#</b></div></td></tr>
  <tr>
   <td rowspan="2" valign="bottom"><div align="center"><b>Action</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>Employee<br>
 ID</b></div></td> 
    <td rowspan="2" valign="bottom"><div align="center"><b>Employee<br>
 Name</b></div></td> 
    <td rowspan="2" valign="bottom"><div align="center"><b>Work <br>
Category</b></div></td>
<td rowspan="2" valign="bottom"><div align="center"><b>Group</b></div></td>
    <td style="display:none" rowspan="2" valign="bottom"><div  align="center"><b>Emp<br>
 Rate <br>
Type</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>Working <br>
Days</b></div></td>
    <td style="display:none" rowspan="2" valign="bottom"><div align="center"><b>Working <br>
Hours</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>Rate</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>OT <br>
1.5</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>OT <br>
1.5 <br>
Rate</b></div></td>
    <td rowspan="2" valign="bottom"><div  align="center"><b>OT<br>
 1.5 <br>
Amt</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>OT <br>
2.0</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>OT <br>
2.0 <br>
Rate</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>OT <br>
2.0 <br>
Amt</b></div></td>
    <td colspan="3 " valign="bottom"><div align="center"><b>Sunday/ Public Holiday</b></div></td>
    <td rowspan="2" valign="bottom"><div  align="center"><b>Total Pay <br>
exclude OT</b></div></td>
    <td rowspan="2" valign="bottom"><div align="center"><b>Grand <br>
Pay</b></div></td>
   
  </tr>
  <tr>
  <td valign="bottom"><div align="center"><b>WD</b></div></td>
<!---     <td  valign="bottom" style="display:none"><div align="center"><b>WH</b></div></td> --->
    <td  valign="bottom"><div style="width:100px" align="center"><b>Rate</b></div></td>
    <td  valign="bottom"><div style="width:100px" align="center"><b>PH Total</b></div></td>
   
  </tr>
 </cfif>

 <cfif isdefined ('getproject.dailyrate')>
 <cfif val(getproject.ot1rate) neq 0>
 <cfset dailyrateotone=val(getproject.ot1rate)>
 <cfelse>
 <cfset dailyrateotone=(getproject.dailyrate*26*12/2288)*1.5>
 </cfif>
 <cfif val(getproject.ot2rate) neq 0>
 <cfset dailyrateottwo=val(getproject.ot2rate)>
 <cfelse>
 <cfset dailyrateottwo=(getproject.dailyrate*26*12/2288)*2.0> 
 </cfif>
 </cfif>


 <cfif isdefined ('getproject.hourlyrate')>
 <cfif val(getproject.ot1rate) neq 0>
 <cfset hourlyrateotone=val(getproject.ot1rate)>
 <cfelse> 
 <cfset hourlyrateotone=1.5*getproject.hourlyrate>
 </cfif>
 <cfif val(getproject.ot2rate) neq 0>
  <cfset hourlyrateottwo=val(getproject.ot2rate)>
 <cfelse>
 <cfset hourlyrateottwo=2.0*getproject.hourlyrate>
 </cfif>
 </cfif>

 <cfif isdefined ('getproject.monthlyrate')>
 <cfif getproject.monthlyrate neq 0.00>
 <cfif val(getproject.ot1rate) neq 0>
 <cfset monthlyrateotone=val(getproject.ot1rate)>
 <cfelse>
 <cfset monthlyrateotone=(getproject.monthlyrate*12/2288)*1.5>
 </cfif> 
 <cfif val(getproject.ot2rate) neq 0>
 <cfset monthlyrateottwo=val(getproject.ot2rate)>
 <cfelse>
 <cfset monthlyrateottwo=(getproject.monthlyrate*12/2288)*2.0>
 </cfif>
 <cfelse>
 <cfset monthlyrateotone=0.00> 
 <cfset monthlyrateottwo=0.00>
 </cfif>
 </cfif>

  <tr>
  <td><div align="center">
   <cfif getinvoiceinfo.recordcount eq 0>
    <input type="checkbox" name="checkboxvalue#getproject.currentrow#" id="checkboxvalue#getproject.currentrow#" value="1">
    <cfelse>
    <input type="checkbox" name="checkboxvalue#getproject.currentrow#" id="checkboxvalue#getproject.currentrow#" checked disabled="disabled">
    </cfif></div></td>
    <td><div align="center">#getproject.empno#</div></td>
    <td><div align="center">#getproject.name#</div></td>
    <td><div style="width:100px" align="center">#getproject.catname#</div></td>   
     <td><div style="width:100px" align="center">#getproject.groupdata#</div></td>  
    <td style="display:none"><div align="center">#getproject.payratetype#</div></td> 
    <td><div align="center">#gettotalday.totalday#</div></td>
    <td  style="display:none"><div align="center">#numberformat(totaltime1,'.__')#</div></td>
  
    <!--- get rate --->
    <td><div style="width:100px" align="center">
	<cfif getproject.hourlyrate neq '0.00' and getproject.payratetype eq 'hourly'>#numberformat(val(getproject.hourlyrate),'.__')#/hour
	<cfelseif getproject.dailyrate neq '0.00' and getproject.payratetype eq 'daily'>#numberformat(val(getproject.dailyrate),'.__')#/day
	<cfelseif getproject.monthlyrate neq '0.00' and getproject.payratetype eq 'monthly'>#numberformat(val(getproject.monthlyrate),'.__')#/month<cfelse>0.00</cfif></div>
    </td>

   <!--- get total ot1 --->
    <td><div align="center">#numberformat(gettotaltime.totalot1,'.__')#</div></td>
    
    <!--- get ot one rate --->
    <td><div align="center">
    <cfif hourlyrateotone neq '0.000' and getproject.payratetype eq 'hourly'>#numberformat(val(hourlyrateotone),'.___')#</cfif>
    <cfif dailyrateotone neq '0.000' and getproject.payratetype eq 'daily'>#numberformat(val(dailyrateotone),'.___')#</cfif>
    <cfif monthlyrateotone neq '0.000' and getproject.payratetype eq 'monthly'>#numberformat(val(monthlyrateotone),'.___')#</cfif>
    <cfif hourlyrateotone eq '0.000' and getproject.payratetype eq 'hourly'>0.00</cfif>
    <cfif dailyrateotone eq '0.00' and getproject.payratetype eq 'daily'>0.00</cfif>
    <cfif monthlyrateotone eq '0.000' and getproject.payratetype eq 'monthly'>0.00</cfif></div>
    </td> 
    
    <!--- get total amount ot1 --->	
	<cfset totalamountot1=0.00>
    <cfif hourlyrateotone neq '0.000' and getproject.payratetype eq 'hourly'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(hourlyrateotone)>
    </cfif>
    <cfif dailyrateotone neq '0.000' and getproject.payratetype eq 'daily'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(dailyrateotone)>
    </cfif>
    <cfif monthlyrateotone neq '0.000' and getproject.payratetype eq 'monthly'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(monthlyrateotone)>
    </cfif>

    <td><div align="center">#numberformat(totalamountot1,'.__')#</div></td>
    
    <!--- total ot2 --->
    <td><div align="center">#numberformat(gettotaltime.totalot2,'.__')#</div></td>
    <td><div align="center">
    <!--- ot2 rate --->
    <cfif hourlyrateottwo neq '0.000' and getproject.payratetype eq 'hourly'>#numberformat(val(hourlyrateottwo),'.___')#</cfif>
    <cfif dailyrateottwo neq '0.000' and getproject.payratetype eq 'daily'>#numberformat(val(dailyrateottwo),'.___')#</cfif>
    <cfif monthlyrateottwo neq '0.000' and getproject.payratetype eq 'monthly'>#numberformat(val(monthlyrateottwo),'.___')#</cfif>
    <cfif hourlyrateottwo eq '0.000' and getproject.payratetype eq 'hourly'>0.000</cfif>
    <cfif dailyrateottwo eq '0.000' and getproject.payratetype eq 'daily'>0.000</cfif>
    <cfif monthlyrateottwo eq '0.000' and getproject.payratetype eq 'monthly'>0.000</cfif>
    </div>
    </td>
   
    <!--- total amount ot2 --->
	<cfset totalamountot2=0.00>
    <cfif hourlyrateottwo neq '0.00' and getproject.payratetype eq 'hourly'>
    <cfset totalamountot2=val(gettotaltime.totalot2)*val(hourlyrateottwo)></cfif>
    <cfif dailyrateottwo neq '0.00' and getproject.payratetype eq 'daily'>
    <cfset totalamountot2=val(gettotaltime.totalot2)*val(dailyrateottwo)></cfif>
    <cfif monthlyrateottwo neq '0.00' and getproject.payratetype eq 'monthly'>
    <cfset totalamountot2=val(gettotaltime.totalot2)*val(monthlyrateottwo)>
    </cfif>
    <td><div align="center">#numberformat(totalamountot2,'.__')#</div></td>
    
    
    <!---PH--->
    <td><div align="center">#phday#</div></td>
<!---     <td style="display:none"><div align="center">#numberformat(phtime,'.__')#</div></td> --->
    
  
    <!--- get ph rate --->
    <cfset phrate = 0.00>
    <cfif val(getproject.sunphrate) neq 0>
    <cfset phrate = numberformat(getproject.sunphrate,'.__')>
    <cfelse> 
	<cfif getproject.hourlyrate neq '0.00' and getproject.payratetype eq 'hourly'>
    <cfset phrate = numberformat(val(getproject.hourlyrate)*2,'.__') >
	<cfelseif getproject.dailyrate neq '0.00' and getproject.payratetype eq 'daily'>
      <cfset phrate = numberformat(val(getproject.dailyrate)*2,'.__') >
	<cfelseif getproject.monthlyrate neq '0.00' and getproject.payratetype eq 'monthly'>
<cfset phrate = numberformat((val(getproject.monthlyrate)*12/2288)*2*8,'.__')><cfelse><cfset phrate = 0.00>

</cfif>
</cfif>

<td><div  align="center">#numberformat(phrate,'.__')#</div></td>
 <cfset phbasic=0>
<cfif getproject.payratetype eq 'hourly'>
    <cfset phbasic=val(phrate)*phtime></cfif>
    <cfif getproject.payratetype eq 'daily' or getproject.payratetype eq 'monthly' >
    <cfset phbasic=val(phrate)*phday></cfif>
    <td><div  align="center">#numberformat(phbasic,'.__')#</div></td>
  
    <!---ph--->
    
    <cfset basic=0>
    <!--- basic --->
    <cfif getproject.payratetype eq 'hourly'>
    <cfset basic=val(getproject.hourlyrate)*totaltime1></cfif>
    <cfif getproject.payratetype eq 'daily' >
    <cfset basic=val(getproject.dailyrate)*gettotalday.totalday></cfif>
    <cfif getproject.payratetype eq 'monthly'> 
    <cfset basic=val(getproject.monthlyrate)></cfif>
    <cfset basic = basic + phbasic>
    <td><div align="center">#numberformat(basic,'.__')#</div></td>
   
   <cfset grandamount=0> 
    <!--- grand amount --->
    <cfif getproject.payratetype eq 'hourly'>
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <cfif getproject.payratetype eq 'daily' >
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <cfif getproject.payratetype eq 'monthly' > 
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <td><div align="center">#numberformat(grandamount,'.__')#</div>
   
    
<input type="hidden" name="phday#getproject.currentrow#" id="phday#getproject.currentrow#" value="#phday#" />
<input type="hidden" name="phtime#getproject.currentrow#" id="phtime#getproject.currentrow#" value="#phtime#" />
<input type="hidden" name="phrate#getproject.currentrow#" id="phrate#getproject.currentrow#" value="#phrate#" />
<input type="hidden" name="phbasic#getproject.currentrow#" id="phbasic#getproject.currentrow#" value="#phbasic#" />

   <input type="hidden" name="timesheetid#getproject.currentrow#" id="timesheetid#getproject.currentrow#" value="#gettotaltime.timesheetid#" />
    <input type="hidden" name="grandamount#getproject.currentrow#" id="grandamount#getproject.currentrow#" value="#numberformat(grandamount,'.__')#" />
    <input type="hidden" name="empno#getproject.currentrow#" id="empno#getproject.currentrow#" value="#getproject.empno#" />
    <input type="hidden" name="source#getproject.currentrow#" id="source#getproject.currentrow#" value="#getproject.source#" />
    <input type="hidden" name="catid#getproject.currentrow#" id="catid#getproject.currentrow#" value="#getproject.catid#" />
    <input type="hidden" name="groupdata#getproject.currentrow#" id="groupdata#getproject.currentrow#" value="#getproject.groupdata#" />
    
    <input type="hidden" name="project#getproject.currentrow#" id="project#getproject.currentrow#" value="#getproject.project#" />

    <input type="hidden" name="letterreference#getproject.currentrow#" id="letterreference#getproject.currentrow#" value="#getproject.letterreference#" />
    <input type="hidden" name="letterreferencedate#getproject.currentrow#" id="letterreferencedate#getproject.currentrow#" value="#getproject.letterreferencedate#" />
    <input type="hidden" name="quotationreference#getproject.currentrow#" id="quotationreference#getproject.currentrow#" value="#getproject.quotationreference#" />
    <input type="hidden" name="quotationdate#getproject.currentrow#" id="quotationdate#getproject.currentrow#" value="#getproject.quotationdate#" />  
    <input type="hidden" name="payratetype#getproject.currentrow#" id="payratetype#getproject.currentrow#" value="#getproject.payratetype#" /> 

<!---day--->
<cfif getproject.payratetype eq 'hourly'>
    <input type="hidden" name="wday#getproject.currentrow#" id="wday#getproject.currentrow#" value="#numberformat(totaltime1,'.__')#" /> 
	<cfelseif getproject.payratetype eq 'daily'>
    <input type="hidden" name="wday#getproject.currentrow#" id="wday#getproject.currentrow#" value="#gettotalday.totalday#" />
	<cfelseif getproject.payratetype eq 'monthly'>
    <input type="hidden" name="wday#getproject.currentrow#" id="wday#getproject.currentrow#" value="26" />
</cfif>

<!---rate--->
<cfif getproject.hourlyrate neq '0.00' and getproject.payratetype eq 'hourly'>
    <input type="hidden" name="wrate#getproject.currentrow#" id="wrate#getproject.currentrow#" value="#numberformat(val(getproject.hourlyrate),'.__')#" />
	<cfelseif getproject.dailyrate neq '0.00' and getproject.payratetype eq 'daily'>
    <input type="hidden" name="wrate#getproject.currentrow#" id="wrate#getproject.currentrow#" value="#numberformat(val(getproject.dailyrate),'.__')#" /> 
    <cfelseif getproject.monthlyrate neq '0.00' and getproject.payratetype eq 'monthly'>
    <input type="hidden" name="wrate#getproject.currentrow#" id="wrate#getproject.currentrow#" value="#numberformat(val(getproject.monthlyrate),'.__')#" />  
	<cfelse>
    <input type="hidden" name="wrate#getproject.currentrow#" id="wrate#getproject.currentrow#" value="0" />  
</cfif>

    <input type="hidden" name="totalota#getproject.currentrow#" id="totalota#getproject.currentrow#" value="#numberformat(gettotaltime.totalot1,'.__')#" />  
    
<!--- rate ot1   --->
	<cfif isdefined('hourlyrateotone') and hourlyrateotone neq '0.00' and getproject.payratetype eq 'hourly'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(hourlyrateotone),'.___')#" />  
    </cfif>
    <cfif isdefined('dailyrateotone') and dailyrateotone neq '0.00' and getproject.payratetype eq 'daily'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(dailyrateotone),'.___')#" />
    </cfif>
    <cfif isdefined('monthlyrateotone') and monthlyrateotone neq '0.00' and getproject.payratetype eq 'monthly'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(monthlyrateotone),'.___')#" />
    </cfif>
    <cfif hourlyrateotone eq '0.00' and dailyrateotone eq '0.00' and monthlyrateotone eq '0.00'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="0.00" />
    </cfif>
     
    <input type="hidden" name="totalotb#getproject.currentrow#" id="totalotb#getproject.currentrow#" value="#numberformat(gettotaltime.totalot2,'.__')#" />
	
	<!--- rate ot2   --->
    <cfif isdefined('hourlyrateottwo') and hourlyrateottwo neq '0.00' and getproject.payratetype eq 'hourly'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(hourlyrateottwo),'.___')#" /> 
    </cfif>
    <cfif isdefined('dailyrateottwo') and dailyrateottwo neq '0.00' and getproject.payratetype eq 'daily'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(dailyrateottwo),'.___')#" /> 
    </cfif>
    <cfif isdefined('monthlyrateottwo') and monthlyrateottwo neq '0.00' and getproject.payratetype eq 'monthly'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(monthlyrateottwo),'.___')#" /> 
    </cfif>
    <cfif hourlyrateottwo eq '0.00' and dailyrateottwo eq '0.00' and monthlyrateottwo eq '0.00'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="0.00" />
    </cfif>
    </td>

  </tr>




<cfset proj=source> 
</cfloop>
 </table> 
  <input type="hidden" name="tsstartdate" id="tsstartdate" value="#datestart#">
    <input type="hidden" name="tsenddate" id="tsenddate" value="#dateend#">
 <input type="hidden" name="totalrecord" id="totalrecord" value="#getproject.recordcount#">
 <input type="hidden" name="type" id="type" value="#type#">
 <input type="hidden" name="invno" id="invno" value="#invno#">
 <input type="hidden" name="custno" id="custno" value="#custno#">
 <input type="hidden" name="invoicedate" id="invoicedate" value="#invoicedate#">
 

 
<div align="center">
  <input name="submit" id="submit" type="submit" value="Retrieve"></div>
  <cfelse><h2>No records were founds</h2>
</cfif>
</cfform>
</cfoutput>
