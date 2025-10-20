<cfquery name="clearit_cos" datasource="#dts#">
update ictran SET it_cos = 0
WHERE fperiod = "01" 
and type = "CN" 
and (void = "" or void is null)
and (linecode = "" or linecode is null)
order by trdatetime
</cfquery>

<cfquery name="getitemno" datasource="#dts#">
SELECT itemno,refno,trancode,itemcount,trdatetime,qty,type,trdatetime,wos_date FROM ictran 
WHERE fperiod = "01" 
and type = "CN" 
and (void = "" or void is null)
and (linecode = "" or linecode is null)
and itemno <> "IK-CN-BCI-1451Y"
order by trdatetime
</cfquery>

<cfloop query="getitemno">

<cfquery name="checkitemsv" datasource="#dts#">
SELECT itemtype FROM icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#">
</cfquery>
<cfif checkitemsv.itemtype neq "SV">

 <cfquery name="getmomentstockval" datasource="#dts#">
    SELECT coalesce(a.qtybf,0)+coalesce(c.totalqty,0)-coalesce(b.totalreturnqty,0) as qty, coalesce(a.qtybf * a.ucost,0)+coalesce(c.totalamt,0)-coalesce(b.totalreturnamt,0) as amt,a.purc,a.stock,a.itemtype,d.outqty from (
    SELECT qtybf,ucost,itemno,purc,stock,itemtype FROM icitem  WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 	
    ) as a
    LEFT JOIN
    (
	select sum(qty) as totalreturnqty, sum(amt) as totalreturnamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and type = "PR"
    and trdatetime <= "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
    group by itemno
    ) as b
    on a.itemno = b.itemno
    LEFT JOIN
    (
    select sum(qty) as totalqty, sum(if(type = "CN",it_cos,amt)) as totalamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "RC" or type = "OAI" or type = "CN")
    and trdatetime <= "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
    <cfif getitemno.type eq "CN">
    and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.refno#"> and type <> "#getitemno.type#"
    </cfif>
    group by itemno
    )
    as c
    on a.itemno = c.itemno    
    LEFT JOIN
    (
    select sum(qty) as outqty, itemno  FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "INV" or type = "ISS" or type = "DN" or type = "CS" or type = "DO" or type = "OAR")
    and trdatetime <= "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
    group by itemno
    )
    as d
    on a.itemno = d.itemno
</cfquery>

<cfif val(getmomentstockval.qty) lte 0>
 <cfquery name="getnextstockin" datasource="#dts#">
    SELECT trdatetime FROM ictran WHERE 
    (type = "RC" or type = "CN" or type = "OAI")
    and trdatetime > "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
    and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    order by trdatetime
    </cfquery>
    
    <cfif getnextstockin.recordcount neq 0>
    <cfquery name="getmomentstockval" datasource="#dts#">
    SELECT coalesce(a.qtybf,0)+coalesce(c.totalqty,0)-coalesce(b.totalreturnqty,0) as qty, coalesce(a.qtybf * a.ucost,0)+coalesce(c.totalamt,0)-coalesce(b.totalreturnamt,0) as amt,a.purc,a.stock,a.itemtype from (
    SELECT <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif>qtybf,<cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)> 0 as </cfif>ucost,itemno,purc,stock,itemtype FROM icitem  WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 	
    ) as a
    LEFT JOIN
    (
	select sum(qty) as totalreturnqty, sum(amt) as totalreturnamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and type = "PR"
    <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
    and trdatetime >= "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
	</cfif>
    and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#"
    group by itemno
    ) as b
    on a.itemno = b.itemno
    LEFT JOIN
    (
    select sum(qty) as totalqty, sum(if(type = "CN",it_cos,amt)) as totalamt,itemno FROM ictran 
    WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and fperiod <> 99 
    and (void = "" or void is null)
    and (linecode = "" or linecode is null)
    and (type = "RC" or type = "OAI" or type = "CN")
      <cfif getitemno.type eq "CN">
    and refno <> <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.refno#"> and type <> "#getitemno.type#"
    </cfif>
     <cfif val(getmomentstockval.qty) lt val(getmomentstockval.outqty)>
    and trdatetime >= "#dateformat(getitemno.trdatetime,'YYYY-MM-DD')# #timeformat(getitemno.trdatetime,'HH:MM:SS')#"
	</cfif>
    and trdatetime <= "#dateformat(getnextstockin.trdatetime,'YYYY-MM-DD')# #timeformat(getnextstockin.trdatetime,'HH:MM:SS')#"
    group by itemno
    )
    as c
    on a.itemno = c.itemno
    </cfquery>
    
    </cfif>
    </cfif>
    
    <cfif getmomentstockval.qty lte 0 >
    <cfoutput>
    #getitemno.itemno# - #getitemno.refno# - #getitemno.itemcount#
    </cfoutput>
    <cfabort>
	</cfif>

	<cfset currentunitstock = val(getmomentstockval.amt)/val(getmomentstockval.qty) * val(getitemno.qty)>
    
    <cfquery name="updateictran" datasource="#dts#">
    UPDATE ictran SET it_cos = "#val(currentunitstock)#"
    WHERE 
    itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemno#"> 
    and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.refno#">
    and type = "CN" 
    and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.trancode#"> 
    and itemcount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemno.itemcount#">
    </cfquery>

</cfif>

</cfloop>

