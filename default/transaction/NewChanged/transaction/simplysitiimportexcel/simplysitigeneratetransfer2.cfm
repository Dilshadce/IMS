<!---Generate Maximum --->

<cfif radio1 eq 'generateitem'>
<cfquery name="insertmax" datasource="#dts#">
insert ignore into maxqty_temp
	(
		itemno,
		location
	)
    (
    SELECT itemno,location FROM icitem a,iclocation b
    where 0=0
    <cfif form.locationfrom neq '' and form.locationto neq ''>
    and b.location between '#form.locationfrom#' and  '#form.locationto#'
    </cfif>
    <cfif form.itemfrom neq '' and form.itemto neq ''>
    and a.itemno between '#form.itemfrom#' and  '#form.itemto#'
    </cfif>
    order by itemno
    )
</cfquery>
<script type="text/javascript">
alert('All location item has been generated');
window.close();
</script>

</cfif>
<cfif radio1 eq 'generatemax'>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<cfquery name="truncatemax" datasource="#dts#">
update maxqty_temp set maxqty=0,reloadqty=0
</cfquery>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
 group by frrefno
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery name="getbal" datasource="#dts#">
select 
	a.itemno,
	b.location,
	c.lastbalance,c.salesqty,c.balance
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
    <cfif form.locationfrom neq '' and form.locationto neq ''>
    and location between '#form.locationfrom#' and  '#form.locationto#'
    </cfif>
    <cfif form.itemfrom neq '' and form.itemto neq ''>
    and itemno between '#form.itemfrom#' and  '#form.itemto#'
    </cfif>

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as lastbalance,
        (ifnull(a.locqfield,0)+ifnull(e.sum_in,0)-ifnull(f.sum_out,0)) as balance,		
        ifnull(d.salesqty,0) as salesqty
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
            and fperiod < '#form.period#'
			<cfif form.locationfrom neq '' and form.locationto neq ''>
    		and location between '#form.locationfrom#' and  '#form.locationto#'
    		</cfif>
    		<cfif form.itemfrom neq '' and form.itemto neq ''>
    		and itemno between '#form.itemfrom#' and  '#form.itemto#'
    		</cfif>
            and (void = "" or void is null)
and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
			and fperiod<>'99'
            and fperiod < '#form.period#'
            <cfif form.locationfrom neq '' and form.locationto neq ''>
    		and location between '#form.locationfrom#' and  '#form.locationto#'
    		</cfif>
    		<cfif form.itemfrom neq '' and form.itemto neq ''>
    		and itemno between '#form.itemfrom#' and  '#form.itemto#'
    		</cfif>
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
        
        left join
		(
			select 
			sum(qty) as salesqty,itemno,location
			
			from ictran 
			
			where type ='SAM'
			and fperiod<>'99'
            and fperiod = '#form.period#'
            <cfif form.locationfrom neq '' and form.locationto neq ''>
    		and location between '#form.locationfrom#' and  '#form.locationto#'
    		</cfif>
    		<cfif form.itemfrom neq '' and form.itemto neq ''>
    		and itemno between '#form.itemfrom#' and  '#form.itemto#'
    		</cfif>
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as d on a.location=d.location and a.itemno=d.itemno 
		
        left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
            and fperiod <= '#form.period#'
			<cfif form.locationfrom neq '' and form.locationto neq ''>
    		and location between '#form.locationfrom#' and  '#form.locationto#'
    		</cfif>
    		<cfif form.itemfrom neq '' and form.itemto neq ''>
    		and itemno between '#form.itemfrom#' and  '#form.itemto#'
    		</cfif>
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as e on a.location=e.location and a.itemno=e.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
			and fperiod<>'99'
            and fperiod <= '#form.period#'
            <cfif form.locationfrom neq '' and form.locationto neq ''>
    		and location between '#form.locationfrom#' and  '#form.locationto#'
    		</cfif>
    		<cfif form.itemfrom neq '' and form.itemto neq ''>
    		and itemno between '#form.itemfrom#' and  '#form.itemto#'
    		</cfif>
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as f on a.location=f.location and a.itemno=f.itemno 
        
        
		where a.itemno=a.itemno
        <cfif form.locationfrom neq '' and form.locationto neq ''>
    	and a.location between '#form.locationfrom#' and  '#form.locationto#'
    	</cfif>
    	<cfif form.itemfrom neq '' and form.itemto neq ''>
    	and a.itemno between '#form.itemfrom#' and  '#form.itemto#'
    	</cfif>
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
    <cfif form.locationfrom neq '' and form.locationto neq ''>
    and b.location between '#form.locationfrom#' and  '#form.locationto#'
    </cfif>
    <cfif form.itemfrom neq '' and form.itemto neq ''>
    and a.itemno between '#form.itemfrom#' and  '#form.itemto#'
    </cfif>
	order by a.itemno;
</cfquery>
<!---
<script type="text/javascript">
var updateurl = 'completeajax.cfm?;
new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Update Item'); },		
		
		onComplete: function(transport){
		calculatefooter();
		refreshlist();
        }
      })
</script>
<cfoutput>
<div id="completeajax"></div>
</cfoutput>--->

<cfloop query="getbal">
<!---  <cfoutput>
#val(getbal.lastbalance)# #val(getbal.balance)# #val(getbal.salesqty)#<br/>
</cfoutput>  --->

<cfset maxqtynow=val(getbal.lastbalance)+val(getbal.salesqty)>
<cfif val(form.adjust) neq 0>
<cfset maxqtynow=int(val(maxqtynow) * val(form.adjust) / 100)>
</cfif>

<cfset reloadqtynow=maxqtynow-getbal.balance>

<cfif val(getbal.lastbalance) eq 0>
<cfset reloadqtynow=form.newqty>
</cfif>

<cfif val(reloadqtynow) lt 0>
<cfset reloadqtynow = 0>
</cfif>

<cfquery name="updateitem" datasource="#dts#">
update maxqty_temp set maxqty='#maxqtynow#',reloadqty='#reloadqtynow#' where itemno='#getbal.itemno#' and location='#getbal.location#'
</cfquery>

</cfloop>
<script type="text/javascript">
alert('Generate Maximum has been done');
window.close();
</script>
<!--- End Generate Maximum --->
<!---Generate Report --->
<cfelseif radio1 eq 'generatereport'>

<html>
<head>
<title>Item Needed to Generate Transfer Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfparam name="row" default="0">
<cfparam name="ttpoohso" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfquery name="gettran" datasource="#dts#">
	select sum(reloadqty) as reloadqty,itemno from maxqty_temp group by itemno
</cfquery>
<body>
<cfset z=1>
<table width="100%" border="0" align="center" cellspacing="0">
	<cfoutput>
    <tr>
    	<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Item Needed to Generate Transfer Report</strong></font></div></td>
    </tr>
    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq "">
          	<font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font> </cfif></td>
      	<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr><td colspan="100%"><br></td></tr>
  	</cfoutput>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
    <td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
	    <td><font size="2" face="Times New Roman, Times, serif">ITEM NO</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">BALANCE QTY</font></td>
	    <td><font size="2" face="Times New Roman, Times, serif">REQUIRED QTY</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REMAINING QTY</font></td>
        
	</tr>
  	<tr>
    	<td colspan="100%"><hr></td>
  	</tr>
  	<tr>
    	<td colspan="5"></td>
    </tr>
	<cfoutput query="gettran">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td><font size="2" face="Times New Roman, Times, serif">#z#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#gettran.itemno#</font></td>
      <cfquery name="getdoupdated" datasource="#dts#">
	  SELECT frrefno FROM iclink WHERE frtype = "DO" 
 	  group by frrefno and itemno='#gettran.itemno#'
	  </cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>      
      
      <cfquery name="getbal" datasource="#dts#">
select 
	a.itemno,
	b.location,
	c.balance
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		and itemno='#gettran.itemno#' 
		and location = '#form.delocationfr#'

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
        (ifnull(a.locqfield,0)+ifnull(e.sum_in,0)-ifnull(f.sum_out,0)) as balance
		from locqdbf as a 
		
        left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
            <!--- and fperiod <= '#form.period#' --->
			and itemno='#gettran.itemno#' 
			and location = '#form.delocationfr#'
			and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as e on a.location=e.location and a.itemno=e.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
			and fperiod<>'99'
           <!---  and fperiod < '#form.period#' --->
			and itemno='#gettran.itemno#' 
			and location = '#form.delocationfr#'
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as f on a.location=f.location and a.itemno=f.itemno 
        
        
		where a.itemno=a.itemno
		and a.itemno='#gettran.itemno#' 
		and a.location = '#form.delocationfr#'
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	and b.location = '#form.delocationfr#'
    and a.itemno='#gettran.itemno#' 
	order by a.itemno;
</cfquery>      
       
      
            <td><font size="2" face="Times New Roman, Times, serif">#getbal.balance#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#gettran.reloadqty#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#val(getbal.balance)-val(gettran.reloadqty)#</font></td>
	</tr>
    <cfset z=z+1>
  </cfoutput>
</table>
</body>
</html>



<!--- End Generate Report --->
<!---Generate Transfer --->
<cfelseif radio1 eq 'generatetr'>

<cfquery name="getlocation" datasource="#dts#">
	 select location from maxqty_temp where reloadqty<>0 group by location
</cfquery>

<cfquery name="getdoupdated" datasource="#dts#">
	  SELECT frrefno FROM iclink WHERE frtype = "DO" 
 	  group by frrefno
	  </cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>      
      
      <cfquery name="getbal" datasource="#dts#">
select 
	a.itemno,
	b.location,
	c.balance
	
	from icitem as a 
	
	left join 
	(
		select 
		location,
		itemno,
		(select desp from iclocation where location=locqdbf.location) as locationdesp 
		from locqdbf
		where itemno=itemno 
		and location = '#form.delocationfr#'

	) as b on a.itemno=b.itemno 
	
	left join 
	(
		select 
		a.location,
		a.itemno,
        (ifnull(a.locqfield,0)+ifnull(e.sum_in,0)-ifnull(f.sum_out,0)) as balance
		from locqdbf as a 
		
        left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod<>'99'
            <!--- and fperiod < '#form.period#' --->
			and location = '#form.delocationfr#'
			and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as e on a.location=e.location and a.itemno=e.itemno
		
		left join
		(
			select 
			location,
            category,
            wos_group,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where 
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
			and fperiod<>'99'
            <!--- and fperiod < '#form.period#' --->
			and location = '#form.delocationfr#'
            and (void = "" or void is null)
			and (linecode = "" or linecode is null)
			group by location,itemno
			order by location,itemno
		) as f on a.location=f.location and a.itemno=f.itemno 
        
        
		where a.itemno=a.itemno
		and a.location = '#form.delocationfr#'
	) as c on a.itemno=c.itemno and b.location=c.location 
	
	where a.itemno=a.itemno 
	and b.location<>''
	and b.location = '#form.delocationfr#'
	order by a.itemno;
</cfquery>
<cfset locationbal = StructNew()>

<cfloop query="getbal">
<cfset locationbal[getbal.itemno]=getbal.balance>
<cfoutput>
</cfoutput>
</cfloop>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear from gsetup
</cfquery>

<cfset datenow=createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2))>
<cfset thisperioddate=dateformat(datenow,'yyyy-mm-dd')>


<cfloop query="getlocation">

	<cfquery datasource="#dts#" name="getGeneralInfo">
			select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
            from refnoset
			where type = 'TR'
			and counter = '1'
		</cfquery>
        
        <cfset newrefno=getGeneralInfo.tranno>
        
        <cfquery name="checkexistrefno" datasource="#dts#">
select refno from artran where type='TR' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#newrefno#">
</cfquery>

		<cfif checkexistrefno.recordcount neq 0>
        
        <cfquery datasource="#dts#" name="getGeneralInfo">
				select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                from refnoset
				where type = 'TR'
				and counter = 1
			</cfquery>
            
        <cfset refnocheck = 0>
        <cfset refno1 = checkexistrefno.refno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno1#" returnvariable="newrefno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="newrefno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newrefno#"> and type = 'TR'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = newrefno>
		</cfif>
        </cfloop>
		</cfif>
        
        
        <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#thisperioddate#" returnvariable="fperiod"/>
        <cfset wos_date = thisperioddate>
        

	<cfquery name="getitem" datasource="#dts#">
    select itemno,reloadqty as qty from maxqty_temp where reloadqty<>0 and location='#getlocation.location#'
    </cfquery>
    <cfset trancode=1>
    
    <cfloop query="getitem">
    <cfif (locationbal[getbal.itemno]-getitem.qty) gt 0>
    
     <cfquery name="getitemdetail" datasource="#dts#">
            select * from icitem where itemno='#getitem.itemno#'
     </cfquery>
    
    <cfquery name="inserttrou" datasource="#dts#">
		insert into ictran
	(
		type,
        refno,
        custno,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        location,
        qty_bil,
        price_bil,
        unit_bil,
        amt1_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
		taxpec1,
        gltradac,
        taxamt_bil,
        qty,
        price,
        unit,
        factor1,
        factor2,
        amt1,
        disamt,
        amt,
        taxamt,
        note_a,
		dono,
        exported,
        exported1,
        sono,
        toinv,
        generated,
        wos_group,
        category,
        brem1,
        brem2,
        brem3,
        brem4,
        packing,
        shelf,
        supp,
        qty1,
        qty2,
        qty3,
        qty4,
        qty5,
        qty6,
        qty7,
        trdatetime,
        sv_part,
        sercost,
        userid,
        sodate,
        dodate,
        adtcost1,
        adtcost2,
        batchcode,
        expdate,
        mc1_bil,
        mc2_bil,
        defective,
        nodisplay,
        title_id,
        title_desp,
        comment,
        m_charge1,
        m_charge2,
        m_charge3,
        m_charge4,
        m_charge5,
        m_charge6,
        m_charge7,
       	mc3_bil,
        mc4_bil,
        mc5_bil,
        mc6_bil,
        mc7_bil,wos_date,fperiod
        )
        values
        (
        'TROU',
        '#newrefno#',
        'Auto',
        #trancode#,#trancode#,
        '',
        '#getitem.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#form.delocationfr#',
        #numberformat(val(getitem.qty),'._____')#,
        #numberformat(val(getitemdetail.ucost),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
        '0',
        '0',
        '0',
        '0',
        #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(getitem.qty),'._____')#,
         #numberformat(val(getitemdetail.ucost),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
            '0',
            #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdetail.wos_group#', 
              '#getitemdetail.category#', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '',
              '', 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              now(),
              '',
              0.00000,
              '#huserid#',
              '0000-00-00',
              '0000-00-00', 
              0.00000, 
              0.00000,
              '',
              '0000-00-00',
              0.00000, 
              0.00000,
              '',
              'N',
              '',
              '',
              '',
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">
        )
    </cfquery>
    
    
    <cfquery name="inserttrin" datasource="#dts#">
		insert into ictran
	(
		type,
        refno,
        custno,
        trancode,
        itemcount,
        linecode,
        itemno,
        desp,
        despa,
        location,
        qty_bil,
        price_bil,
        unit_bil,
        amt1_bil,
        dispec1,
        dispec2,
        dispec3,
        disamt_bil,
        amt_bil,
		taxpec1,
        gltradac,
        taxamt_bil,
        qty,
        price,
        unit,
        factor1,
        factor2,
        amt1,
        disamt,
        amt,
        taxamt,
        note_a,
		dono,
        exported,
        exported1,
        sono,
        toinv,
        generated,
        wos_group,
        category,
        brem1,
        brem2,
        brem3,
        brem4,
        packing,
        shelf,
        supp,
        qty1,
        qty2,
        qty3,
        qty4,
        qty5,
        qty6,
        qty7,
        trdatetime,
        sv_part,
        sercost,
        userid,
        sodate,
        dodate,
        adtcost1,
        adtcost2,
        batchcode,
        expdate,
        mc1_bil,
        mc2_bil,
        defective,
        nodisplay,
        title_id,
        title_desp,
        comment,
        m_charge1,
        m_charge2,
        m_charge3,
        m_charge4,
        m_charge5,
        m_charge6,
        m_charge7,
       	mc3_bil,
        mc4_bil,
        mc5_bil,
        mc6_bil,
        mc7_bil,wos_date,fperiod
        )
        values
        (
        'TRIN',
        '#newrefno#',
        'Auto',
        #trancode#,#trancode#,
        '',
        '#getitem.itemno#', 
        '#REReplace(getitemdetail.desp,"925925925925","%","ALL")#', 
        '#getitemdetail.desp#', 
        '#getlocation.location#',
        #numberformat(val(getitem.qty),'._____')#,
        #numberformat(val(getitemdetail.ucost),'.__')#, 
        '#getitemdetail.unit#',
         #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
        '0',
        '0',
        '0',
        '0',
        #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#, 
        '0',
        '',
        0.00000,
        #numberformat(val(getitem.qty),'._____')#,
         #numberformat(val(getitemdetail.ucost),'.__')#,
          '#getitemdetail.unit#',
          '1',
           '1',
            #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
            '0',
            #numberformat(val(getitem.qty)*val(getitemdetail.ucost),'.__')#,
            0.00000,
            '',
            '',
              '', 
              '0000-00-00', 
              '', 
              '', 
              '', 
              '#getitemdetail.wos_group#', 
              '#getitemdetail.category#', 
              '', 
              '', 
              '', 
              '', 
              '', 
              '',
              '', 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              now(),
              '',
              0.00000,
              '#huserid#',
              '0000-00-00',
              '0000-00-00', 
              0.00000, 
              0.00000,
              '',
              '0000-00-00',
              0.00000, 
              0.00000,
              '',
              'N',
              '',
              '',
              '',
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
              0.00000, 
              0.00000, 
              0.00000, 
              0.00000,
              0.00000,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">, 
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">
        )
    </cfquery>
    
    <cfset trancode=trancode+1>
	</cfif>
    
    </cfloop> 
    
    <cfquery name="gettotalbillamt" datasource="#dts#">
    	select sum(amt) as amt from ictran where type in ('TROU','TRIN') and refno='#newrefno#'
    </cfquery>
    
    <cfquery name="insertartran" datasource="#dts#">
        INSERT INTO artran
(type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,creditcardtype1,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT)
        values
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="TR">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#newrefno#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="Auto">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#wos_date#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalbillamt.amt#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        'Profile',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.delocationfr#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        now(),
        "",
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0'
        )
        </cfquery>
		<cfquery datasource="#dts#" name="updatelastrefno">
				update refnoset set lastUsedNo ='#newrefno#'
				where type = 'TR'
				and counter = 1
			</cfquery>
</cfloop>
<script type="text/javascript">
<cfoutput>
alert('Transfer of period #form.period# has been generated');
</cfoutput>
window.close();
</script>
</cfif>