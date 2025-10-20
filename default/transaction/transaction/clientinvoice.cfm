<!---<cfoutput>#url.type#---------#url.invno#---------</cfoutput>--->
<cfset invoicemonth2=createdate(right(url.invoicedate,4),mid(url.invoicedate,4,2),left(url.invoicedate,2))>
<cfset invoicemonth1=month(invoicemonth2)>
<cfset invoiceyear=year(url.invoicedate)>
<cfset custno=url.custno>
<cfset invoicedate=url.invoicedate>
<cfset invno=url.invno>
<cfset type=url.type>

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

<cfquery name="getlist" datasource="#dts#">
SELECT empno,activity,skillset FROM emptimesheet
</cfquery>

<cfquery name="getproject" datasource="#dts#">
SELECT * FROM
(SELECT catid,custno,hourlyrate,dailyrate,monthlyrate,ot1rate,ot2rate FROM clientworkerrate WHERE custno='#custno#') as a
LEFT JOIN
(SELECT source,project,custno,letterreference,quotationreference,quotationdate,letterreferencedate FROM #target_project#)as b
ON a.custno=b.custno
LEFT JOIN
(SELECT project,costcentreid,costcentre FROM overhead)as c
ON b.source=c.project
LEFT JOIN
(SELECT source,empno,payratetype FROM employeeplacement) as d
ON c.project=d.source
LEFT JOIN
(SELECT catid,catname FROM workcategory) as e
ON a.catid=e.catid
LEFT JOIN
(SELECT empno,name FROM #replace(dts,'_i','_p')#.pmast)as f
ON d.empno=f.empno
LEFT JOIN
(SELECT distinct(activity),empno,skillset,month,year FROM emptimesheet)as g
ON f.empno=g.empno and c.costcentreid=g.activity and e.catid=g.skillset
WHERE <!--- g.empno IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.empno)#" list="yes" separator=",">) 
and g.activity IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.activity)#" list="yes" separator=",">) 
and g.skillset IN ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.skillset)#" list="yes" separator=",">)
and ---> g.month='#invoicemonth#'and g.year='#invoiceyear#'
GROUP BY b.source,f.empno,a.catid
<!---GROUP BY a.catid,b.source,c.costcentre,d.payratetype ORDER BY b.source--->
</cfquery>

<cfoutput>
<cfset proj = ''>
<cfform name="detail" action="invoicedetail.cfm" method="post">
<cfif getproject.recordcount neq 0>
<cfloop query="getproject">
<cfquery name="gettotaltime" datasource="#dts#">
SELECT SUM(((timeto*60)+minb)-((timefrom*60)+mina)) as totaltime,SUM(ot1) as totalot1,SUM(ot2) as totalot2 FROM emptimesheet WHERE activity
='#getproject.costcentreid#'
AND month='#invoicemonth#' AND year='#invoiceyear#' AND skillset='#getproject.catid#'
</cfquery>

<cfquery name="gettotalday" datasource="#dts#">
SELECT COUNT(DISTINCT day) as totalday FROM emptimesheet WHERE activity
='#getproject.costcentreid#'
AND month='#invoicemonth#' AND year='#invoiceyear#' AND activity <> '' AND skillset='#getproject.catid#'
</cfquery>
 
<cfquery name="getinvoiceinfo" datasource="#dts#">
SELECT empno,sourceproject,catid FROM ictran WHERE empno='#getproject.empno#' and sourceproject='#getproject.source#' and catid='#getproject.catid#'
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
<table width="80%" border="1" style="border-collapse:collapse" align="center">
<cfif proj neq source>
<tr><td colspan="15"><div align="left"><b>Project : #getproject.project#</b></div></td></tr>
  <tr>
   <td><div style="width:73px" align="center"><b>Action</b></div></td>
    <td><div style="width:73px" align="center"><b>Employee Name</b></div></td> 
    <td><div style="width:100px" align="center"><b>Work Category</b></div></td>
    <td><div style="width:73px" align="center"><b>Working Days</b></div></td>
    <td><div style="width:73px" align="center"><b>Working Hours</b></div></td>
    <td><div style="width:73px" align="center"><b>Employee Rate Type</b></div></td>
    <td><div style="width:100px" align="center"><b>Rate</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 1.5</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 1.5 Rate</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 1.5 Amount</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 2.0</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 2.0 Rate</b></div></td>
    <td><div style="width:73px" align="center"><b>Overtime 2.0 Amount</b></div></td>
    <td><div style="width:73px" align="center"><b>Total Pay exclude overtime</b></div></td>
    <td><div style="width:73px" align="center"><b>Grand Pay</b></div></td>
   
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
  <td><div style="width:73px" align="center">
   <cfif getinvoiceinfo.recordcount eq 0>
    <input type="checkbox" name="checkboxvalue#getproject.currentrow#" id="checkboxvalue#getproject.currentrow#" value="1">
    <cfelse>
    <input type="checkbox" name="checkboxvalue#getproject.currentrow#" id="checkboxvalue#getproject.currentrow#" checked disabled="disabled">
    </cfif></div></td>
    <td><div style="width:73px" align="center">#getproject.name#</div></td>
    <td><div style="width:100px" align="center">#getproject.catname#</div></td> 
    <td><div style="width:73px" align="center">#gettotalday.totalday#</div></td>
    <td><div style="width:73px" align="center">#numberformat(totaltime1,'.__')#</div></td>
    <td><div style="width:73px" align="center">#getproject.payratetype#</div></td> 
    <!--- get rate --->
    <td><div style="width:100px" align="center">
	<cfif getproject.hourlyrate neq '0.00' and getproject.payratetype eq 'hourly'>#numberformat(val(getproject.hourlyrate),'.__')#/hour
	<cfelseif getproject.dailyrate neq '0.00' and getproject.payratetype eq 'daily'>#numberformat(val(getproject.dailyrate),'.__')#/day
	<cfelseif getproject.monthlyrate neq '0.00' and getproject.payratetype eq 'monthly'>#numberformat(val(getproject.monthlyrate),'.__')#/month<cfelse>0.00</cfif></div>
    </td>

   <!--- get total ot1 --->
    <td><div style="width:73px" align="center">#numberformat(gettotaltime.totalot1,'.__')#</div></td>
    
    <!--- get ot one rate --->
    <td><div style="width:73px" align="center">
    <cfif hourlyrateotone neq '0.00' and getproject.payratetype eq 'hourly'>#numberformat(val(hourlyrateotone),'.__')#</cfif>
    <cfif dailyrateotone neq '0.00' and getproject.payratetype eq 'daily'>#numberformat(val(dailyrateotone),'.__')#</cfif>
    <cfif monthlyrateotone neq '0.00' and getproject.payratetype eq 'monthly'>#numberformat(val(monthlyrateotone),'.__')#</cfif>
    <cfif hourlyrateotone eq '0.00' and getproject.payratetype eq 'hourly'>0.00</cfif>
    <cfif dailyrateotone eq '0.00' and getproject.payratetype eq 'daily'>0.00</cfif>
    <cfif monthlyrateotone eq '0.00' and getproject.payratetype eq 'monthly'>0.00</cfif></div>
    </td> 
    
    <!--- get total amount ot1 --->	
	<cfset totalamountot1=0.00>
    <cfif hourlyrateotone neq '0.00' and getproject.payratetype eq 'hourly'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(hourlyrateotone)>
    </cfif>
    <cfif dailyrateotone neq '0.00' and getproject.payratetype eq 'daily'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(dailyrateotone)>
    </cfif>
    <cfif monthlyrateotone neq '0.00' and getproject.payratetype eq 'monthly'>
    <cfset totalamountot1=val(gettotaltime.totalot1)*val(monthlyrateotone)>
    </cfif>

    <td><div style="width:73px" align="center">#numberformat(totalamountot1,'.__')#</div></td>
    
    <!--- total ot2 --->
    <td><div style="width:73px" align="center">#numberformat(gettotaltime.totalot2,'.__')#</div></td>
    <td><div style="width:73px" align="center">
    <!--- ot2 rate --->
    <cfif hourlyrateottwo neq '0.00' and getproject.payratetype eq 'hourly'>#numberformat(val(hourlyrateottwo),'.__')#</cfif>
    <cfif dailyrateottwo neq '0.00' and getproject.payratetype eq 'daily'>#numberformat(val(dailyrateottwo),'.__')#</cfif>
    <cfif monthlyrateottwo neq '0.00' and getproject.payratetype eq 'monthly'>#numberformat(val(monthlyrateottwo),'.__')#</cfif>
    <cfif hourlyrateottwo eq '0.00' and getproject.payratetype eq 'hourly'>0.00</cfif>
    <cfif dailyrateottwo eq '0.00' and getproject.payratetype eq 'daily'>0.00</cfif>
    <cfif monthlyrateottwo eq '0.00' and getproject.payratetype eq 'monthly'>0.00</cfif>
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
    <td><div style="width:73px" align="center">#numberformat(totalamountot2,'.__')#</div></td>
    <cfset basic=0>
    <!--- basic --->
    <cfif getproject.payratetype eq 'hourly'>
    <cfset basic=val(getproject.hourlyrate)*totaltime1></cfif>
    <cfif getproject.payratetype eq 'daily' >
    <cfset basic=val(getproject.dailyrate)*gettotalday.totalday></cfif>
    <cfif getproject.payratetype eq 'monthly'> 
    <cfset basic=val(getproject.monthlyrate)></cfif>
    <td><div style="width:73px" align="center">#numberformat(basic,'.__')#</div></td>
   
   <cfset grandamount=0> 
    <!--- grand amount --->
    <cfif getproject.payratetype eq 'hourly'>
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <cfif getproject.payratetype eq 'daily' >
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <cfif getproject.payratetype eq 'monthly' > 
    <cfset grandamount=basic+totalamountot1+totalamountot2></cfif>
    <td><div style="width:73px" align="center">#numberformat(grandamount,'.__')#</div></td>
    

    
  </tr>

   
    <input type="hidden" name="grandamount#getproject.currentrow#" id="grandamount#getproject.currentrow#" value="#numberformat(grandamount,'.__')#" />
    <input type="hidden" name="empno#getproject.currentrow#" id="empno#getproject.currentrow#" value="#getproject.empno#" />
    <input type="hidden" name="source#getproject.currentrow#" id="source#getproject.currentrow#" value="#getproject.source#" />
    <input type="hidden" name="catid#getproject.currentrow#" id="catid#getproject.currentrow#" value="#getproject.catid#" />
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
</cfif>

    <input type="hidden" name="totalota#getproject.currentrow#" id="totalota#getproject.currentrow#" value="#numberformat(gettotaltime.totalot1,'.__')#" />  
    
<!--- rate ot1   --->
	<cfif isdefined('hourlyrateotone') and hourlyrateotone neq '0.00' and getproject.payratetype eq 'hourly'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(hourlyrateotone),'.__')#" />  
    </cfif>
    <cfif isdefined('dailyrateotone') and dailyrateotone neq '0.00' and getproject.payratetype eq 'daily'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(dailyrateotone),'.__')#" />
    </cfif>
    <cfif isdefined('monthlyrateotone') and monthlyrateotone neq '0.00' and getproject.payratetype eq 'monthly'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="#numberformat(val(monthlyrateotone),'.__')#" />
    </cfif>
    <cfif hourlyrateotone eq '0.00' and dailyrateotone eq '0.00' and monthlyrateotone eq '0.00'>
    <input type="hidden" name="rateota#getproject.currentrow#" id="rateota#getproject.currentrow#" value="0.00" />
    </cfif>
     
    <input type="hidden" name="totalotb#getproject.currentrow#" id="totalotb#getproject.currentrow#" value="#numberformat(gettotaltime.totalot2,'.__')#" />
	
	<!--- rate ot2   --->
    <cfif isdefined('hourlyrateottwo') and hourlyrateottwo neq '0.00' and getproject.payratetype eq 'hourly'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(hourlyrateottwo),'.__')#" /> 
    </cfif>
    <cfif isdefined('dailyrateottwo') and dailyrateottwo neq '0.00' and getproject.payratetype eq 'daily'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(dailyrateottwo),'.__')#" /> 
    </cfif>
    <cfif isdefined('monthlyrateottwo') and monthlyrateottwo neq '0.00' and getproject.payratetype eq 'monthly'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="#numberformat(val(monthlyrateottwo),'.__')#" /> 
    </cfif>
    <cfif hourlyrateottwo eq '0.00' and dailyrateottwo eq '0.00' and monthlyrateottwo eq '0.00'>
    <input type="hidden" name="rateotb#getproject.currentrow#" id="rateotb#getproject.currentrow#" value="0.00" />
    </cfif>
</table>


<cfset proj=source> 
</cfloop>  
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
