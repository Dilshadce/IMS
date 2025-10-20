<cfif getGeneralInfo.cost eq "FIXED">

<cfquery name="update_fixed_cost" datasource="#dts#">
			update ictran,
			(select itemno,ucost from icitem 
			where itemno='#form.itemno#') as cost 
			set ictran.it_cos=(ictran.qty*cost.ucost) 
			where ictran.itemno=cost.itemno and (ictran.toinv='' or ictran.toinv is null) and (ictran.void = '' or ictran.void is null) and (ictran.type='DO' or ictran.type='ISS' or ictran.type='INV' or ictran.type='CS' or ictran.type='DN' or ictran.type='CN')
			;
</cfquery>

<cfelseif getGeneralInfo.cost eq "MONTH">

		<cfquery name="truncate_monthcost_table" datasource="#dts#">
			truncate monthcost;
		</cfquery>
		
		<cfquery name="calculate_item_info" datasource="#dts#">
			
			select a.itemno,a.avcost,a.qtybf,(ifnull(a.qtybf,0)*ifnull(a.avcost,0)),0,
			0,ifnull(b.sumqty1,0),ifnull(b.sumamt1,0),ifnull(b.oqty1,0),0,ifnull(c.sumqty2,0),ifnull(c.sumamt2,0),ifnull(c.oqty2,0),0,ifnull(d.sumqty3,0),ifnull(d.sumamt3,0),ifnull(d.oqty3,0),
			0,ifnull(e.sumqty4,0),ifnull(e.sumamt4,0),ifnull(e.oqty4,0),0,ifnull(f.sumqty5,0),ifnull(f.sumamt5,0),ifnull(f.oqty5,0),0,ifnull(g.sumqty6,0),ifnull(g.sumamt6,0),ifnull(g.oqty6,0),
			0,ifnull(h.sumqty7,0),ifnull(h.sumamt7,0),ifnull(h.oqty7,0),0,ifnull(i.sumqty8,0),ifnull(i.sumamt8,0),ifnull(i.oqty8,0),0,ifnull(j.sumqty9,0),ifnull(j.sumamt9,0),ifnull(j.oqty9,0),
			0,ifnull(k.sumqty10,0),ifnull(k.sumamt10,0),ifnull(k.oqty10,0),0,ifnull(l.sumqty11,0),ifnull(l.sumamt11,0),ifnull(l.oqty11,0),0,ifnull(m.sumqty12,0),ifnull(m.sumamt12,0),ifnull(m.oqty12,0),
			0,ifnull(n.sumqty13,0),ifnull(n.sumamt13,0),ifnull(n.oqty13,0),0,ifnull(o.sumqty14,0),ifnull(o.sumamt14,0),ifnull(o.oqty14,0),0,ifnull(p.sumqty15,0),ifnull(p.sumamt15,0),ifnull(p.oqty15,0),
			0,ifnull(q.sumqty16,0),ifnull(q.sumamt16,0),ifnull(q.oqty16,0),0,ifnull(r.sumqty17,0),ifnull(r.sumamt17,0),ifnull(r.oqty17,0),0,ifnull(s.sumqty18,0),ifnull(s.sumamt18,0),
			(ifnull(a.qtybf,0)*ifnull(a.avcost,0)),a.qtybf,a.avcost 
			from icitem as a 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty1,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt1,d.oqty1 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='01' and (type='RC' or type='OAI') and (void = '' or void is null)  
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='01' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty1 from ictran where fperiod='01' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as b on a.itemno=b.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty2,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt2,d.oqty2 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='02' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='02' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty2 from ictran where fperiod='02' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as c on a.itemno=c.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty3,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt3,d.oqty3 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='03' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='03' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty3 from ictran where fperiod='03' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as d on a.itemno=d.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty4,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt4,d.oqty4 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='04' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='04' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty4 from ictran where fperiod='04' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as e on a.itemno=e.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty5,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt5,d.oqty5 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='05' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='05' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty5 from ictran where fperiod='05' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as f on a.itemno=f.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty6,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt6,d.oqty6 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='06' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='06' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty6 from ictran where fperiod='06' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as g on a.itemno=g.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty7,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt7,d.oqty7 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='07' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='07' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty7 from ictran where fperiod='07' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as h on a.itemno=h.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty8,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt8,d.oqty8 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='08' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='08' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty8 from ictran where fperiod='08' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as i on a.itemno=i.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty9,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt9,d.oqty9 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='09' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='09' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty9 from ictran where fperiod='09' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as j on a.itemno=j.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty10,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt10,d.oqty10 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='10' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='10' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty10 from ictran where fperiod='10' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as k on a.itemno=k.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty11,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt11,d.oqty11 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='11' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='11' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty11 from ictran where fperiod='11' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as l on a.itemno=l.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty12,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt12,d.oqty12 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='12' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='12' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty12 from ictran where fperiod='12' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as m on a.itemno=m.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty13,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt13,d.oqty13 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='13' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='13' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty13 from ictran where fperiod='13' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as n on a.itemno=n.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty14,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt14,d.oqty14 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='14' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='14' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty14 from ictran where fperiod='14' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as o on a.itemno=o.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty15,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt15,d.oqty15 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='15' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='15' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty15 from ictran where fperiod='15' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as p on a.itemno=p.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty16,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt16,d.oqty16 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='16' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='16' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty16 from ictran where fperiod='16' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as q on a.itemno=q.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty17,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt17,d.oqty17 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='17' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='17' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty17 from ictran where fperiod='17' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as r on a.itemno=r.itemno 
			left join 
			(
				select a.itemno,(ifnull(b.qty1,0)-ifnull(c.qty2,0)) as sumqty18,(ifnull(b.amt1,0)-ifnull(c.amt2,0)) as sumamt18,d.oqty18 from icitem as a 
				left join 
				(select itemno,sum(qty)as qty1,sum(amt)as amt1 from ictran where fperiod='18' and (type='RC' or type='OAI') and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as b on a.itemno=b.itemno
				left join 
				(select itemno,sum(qty)as qty2,sum(amt)as amt2 from ictran where fperiod='18' and type='PR' and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as c on a.itemno=c.itemno 
				left join 
				(select itemno,sum(qty)as oqty18 from ictran where fperiod='18' and (type='INV' or type='CS' or type='DN' or type='DO' or type='ISS') and (toinv='' or toinv is null) and (void = '' or void is null) 
                and itemno='#form.itemno#'
                group by itemno) as d on a.itemno=d.itemno
				where a.itemno='#form.itemno#'
			) as s on a.itemno=s.itemno 
			where a.itemno='#form.itemno#'
            order by a.itemno
		</cfquery>
		
		<!--- Calculate Month Cost --->
		<cfloop index="a" from="1" to="18">
			<cfquery name="calculate_month_cost" datasource="#dts#">
				update monthcost set 
				cost#a#=((cumamt+amt#a#-(oqty#a-1#*cumcost))/(cumqty+qty#a#-oqty#a-1#)), 
				cumamt=if((cumqty+qty#a#-oqty#a-1#)=0,0,(cumamt+amt#a#-(oqty#a-1#*cumcost))), 
				cumqty=(cumqty+qty#a#-oqty#a-1#), 
				cumcost=cost#a#;
			</cfquery>
		</cfloop>
		
		<!--- Update Month Cost --->
		<cfquery name="update_month_cost" datasource="#dts#">
			update ictran,(select itemno,cost1,cost2,cost3,cost4,cost5,cost6,cost7,cost8,cost9,cost10,cost11,cost12,cost13,cost14,cost15,cost16,cost17,cost18 from monthcost)as cost 
			set ictran.it_cos=ictran.qty*(case ictran.fperiod when '01' then cost.cost1 when '02' then cost.cost2 when '03' then cost.cost3 when '04' then cost.cost4 when '05' then cost.cost5 when '06' then cost.cost6 when '07' then cost.cost7 when '08' then cost.cost8 when '09' then cost.cost9 when '10' then cost.cost10 when '11' then cost.cost11 when '12' then cost.cost12 when '13' then cost.cost13 when '14' then cost.cost14 when '15' then cost.cost15 when '16' then cost.cost16 when '17' then cost.cost17 else cost.cost18 end) 
			where ictran.itemno=cost.itemno and (ictran.void = '' or ictran.void is null) and (ictran.toinv='' or ictran.toinv is null) and (ictran.type='DO' or ictran.type='ISS' or ictran.type='INV' or ictran.type='CS' or ictran.type='DN' or ictran.type='CN');
		</cfquery>



<cfelseif getGeneralInfo.cost eq "MOVING">


			<cfset critirial = "where a.itemno='#form.itemno#'">
			<cfset critirial1 = "and itemno='#form.itemno#'">
		
		<!--- Get Moving Item --->
		<cfquery name="calitcostgetitem" datasource="#dts#">
			select a.itemno,ifnull(a.avcost2,0) as avcost2,ifnull(a.qtybf,0) as qtybf,(ifnull(a.avcost2,0)*ifnull(a.qtybf,0)) as cumtotal 
			from icitem as a,
			(select itemno from ictran where 
            (toinv='' or toinv is null) 
            and (void = '' or void is null) 
			and itemno='#form.itemno#'
            and fperiod <> "99"
            and (linecode <> 'SV' or linecode is null)
			and (type='RC' or type='OAI' or type='CN' or type='INV' or type='DO' or type='CS' or type='DN' or type='ISS' or type='OAR' or type='PR') group by itemno
            ) as b 
			where a.itemno=b.itemno order by a.itemno;
		</cfquery>
		
		<cfloop query="calitcostgetitem">
			<cfset cumqty = calitcostgetitem.qtybf>
			<cfset cumamt = calitcostgetitem.cumtotal>
			<cfset cost = calitcostgetitem.avcost2>
			
			<!--- Get Relevent Cost --->
			<cfquery name="getictran" datasource="#dts#">
				select type,refno,(date_format(wos_date,'%Y-%m-%d')) as wos_date,trancode,itemno,ifnull(qty,0) as qty,ifnull(amt,0) as amt 
				from ictran 
				where itemno='#calitcostgetitem.itemno#' and (type='RC' or type='OAI' or type='CN' or type='INV' or type='DO' or type='CS' or type='DN' or type='ISS' or type='OAR' or type='PR')
                and (toinv='' or toinv is null) 
            	and (void = '' or void is null)
            	and fperiod <> "99"
                and (linecode <> 'SV' or linecode is null)
                order by wos_date,trdatetime,trancode;
			</cfquery>
			
			<!--- Calculate Cost --->
			<cfloop query="getictran">
				<cfswitch expression="#getictran.type#">
					<cfcase value="RC,OAI,CN" delimiters=",">
						<cfset cumqty = cumqty + getictran.qty>
						<cfset cumamt = cumamt + getictran.amt>
						
						<cfswitch expression="#cumqty#">
							<cfcase value="0"><cfset cost = 0></cfcase>
							<cfdefaultcase><cfset cost = cumamt/cumqty></cfdefaultcase>
						</cfswitch>
					</cfcase>
					
					<cfdefaultcase>
						<cfset cumqty = cumqty - getictran.qty>
						<cfset cumamt = cumamt - (cost*getictran.qty)>
						
						<cfif cumqty lt 0>
							<cfset cost = 0>
                            <cfelseif cumqty eq 0 and val(getictran.qty) neq 0>
                            <cfset cost = cost>
                            <cfelseif cumqty eq 0>
                            <cfset cost = 0>
                            <cfelse>
							<cfset cost = cumamt/cumqty>
						</cfif>
                        <cfif cost lt 0>
                        <cfset cost = 0>
                        </cfif>
						
						<!--- Update Cost --->
						<cfquery name="update_cost" datasource="#dts#">
							update ictran set it_cos=(qty*#cost#)
							where type='#getictran.type#' and refno='#getictran.refno#' and itemno='#getictran.itemno#' 
							and wos_date='#getictran.wos_date#' and trancode='#getictran.trancode#';
						</cfquery>
					</cfdefaultcase>
				</cfswitch>
				
				<cfif cumqty eq 0>
					<cfset cumamt = 0>
				</cfif>
			</cfloop>
		</cfloop>

<cfelseif getGeneralInfo.cost eq "FIFO">

<cfquery name="getgeneral" datasource="#dts#">
			select 
			date_format(lastaccyear,'%Y-%m-%d') as lastaccyear,CNbaseonprice
			from gsetup;
		</cfquery>
		
		<cfquery name="calitcostgetitem" datasource="#dts#">
			select 
			a.itemno,
			ifnull(a.qtybf,0) as qtybf 
			from icitem as a,
			(
				select 
				itemno 
				from ictran 
				where 
				type in ('RC','OAI','CN','INV','DO','CS','DN','ISS','OAR','PR')
				and (toinv='' or toinv is null) 
				and (void = '' or void is null) 
				and itemno='#form.itemno#'			
				group by itemno
			) as b 
			where a.itemno=b.itemno 
			order by a.itemno;
		</cfquery>

		<cfloop query="calitcostgetitem">
			<cfset itemno = calitcostgetitem.itemno>
			
			<cfif calitcostgetitem.qtybf neq 0>
				<cfquery name="check_bfcost" datasource="#dts#">
					select 
					ffq11,ffc11,	ffq12,ffc12,	ffq13,ffc13,	ffq14,ffc14,	ffq15,ffc15,
					ffq16,ffc16,	ffq17,ffc17,	ffq18,ffc18,	ffq19,ffc19,	ffq20,ffc20,
					ffq21,ffc21,	ffq22,ffc22,	ffq23,ffc23,	ffq24,ffc24,	ffq25,ffc25,
					ffq26,ffc26,	ffq27,ffc27,	ffq28,ffc28,	ffq29,ffc29,	ffq30,ffc30,
					ffq31,ffc31,	ffq32,ffc32,	ffq33,ffc33,	ffq34,ffc34,	ffq35,ffc35,
					ffq36,ffc36,	ffq37,ffc37,	ffq38,ffc38,	ffq39,ffc39,	ffq40,ffc40,
					ffq41,ffc41,	ffq42,ffc42,	ffq43,ffc43,	ffq44,ffc44,	ffq45,ffc45,
					ffq46,ffc46,	ffq47,ffc47,	ffq48,ffc48,	ffq49,ffc49,	ffq50,ffc50
					from fifoopq 
					where itemno='#itemno#';
				</cfquery>
			</cfif>

			<cfquery name="getstockout" datasource="#dts#">
				select 
				type,
				refno,
				itemcount,
				ifnull(qty,0) as qty,
				ifnull(amt,0) as amt
				from ictran 
				where itemno='#itemno#'
				and wos_date > "#getgeneral.lastaccyear#"
				and (void = '' or void is null) and (toinv='' or toinv is null) 
				and type in ('INV','CS','DN','PR','DO','ISS','OAR')
				order by wos_date,trdatetime,refno,itemcount;
			</cfquery>
			
			<cfquery name="getstockin" datasource="#dts#">
				<cfif calitcostgetitem.qtybf neq 0 and check_bfcost.recordcount neq 0>
					select 
					type,
					refno,
					itemcount,
					counter,
					qty,
					amt,
					it_cos,
                    trdatetime,
					wos_date 
					from 
					(
					<cfloop index="a" from="11" to="50">
						<cfif evaluate("check_bfcost.ffq#a#") neq 0>
							(
								select 
								'RC' as type,
								'' as refno,
								'0' as itemcount,
								'#a#' as counter,
								ffq#a# as qty,
								(ffq#a#*ffc#a#) as amt,
								ffc#a# as it_cos,
                                '#getgeneral.lastaccyear#' as trdatetime,
								'#getgeneral.lastaccyear#' as wos_date
								from fifoopq 
								where itemno='#itemno#'
							)
							union
						</cfif>
					</cfloop>
						(
							select 
							type,
							refno,
							itemcount,
							'1' as counter,
							ifnull(qty,0) as qty,
                           
                            ifnull(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                           
							it_cos,
                            trdatetime,
							wos_date 
							from ictran 
							where itemno='#itemno#' and 
							<cfif dts eq "chemline_i">
                            wos_date > "2010-11-01"
                            <cfelse>
                            wos_date > "#getgeneral.lastaccyear#"
                            </cfif>
							and (void = '' or void is null) 
							and type in ('RC','CN','OAI')
							order by wos_date,trdatetime,refno,itemcount
						)
					) as a 
					order by wos_date,refno,itemcount,counter desc;
				<cfelse>
					select 
					type,
					refno,
					itemcount,
					'1' as counter,
					ifnull(qty,0) as qty,
                    
                            ifnull(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                    
					it_cos,
                    trdatetime,
                    wos_date
					from ictran 
					where itemno='#itemno#' and 
                    <cfif dts eq "chemline_i">
                   	wos_date > "2010-11-01"
					<cfelse>
					wos_date > "#getgeneral.lastaccyear#"
                    </cfif>
					and (void = '' or void is null) 
					and type in ('RC','CN','OAI')
					order by wos_date,trdatetime,refno,itemcount;
				</cfif>
			</cfquery>
	
			<cfloop query="getstockin">
				<cfif getstockin.type eq "CN">
                 
					<cfset refno = getstockin.refno>
					<cfset itemcount2 = getstockin.itemcount>
					<cfset cnqty = getstockin.qty>
					<cfset cnamt = getstockin.amt>
					<cfset count = getstockin.currentrow>
					<cfset count = count - 1>
					<cfif count neq 0>
                    <cfif getstockout.recordcount eq 0>
                    <cftry>
                    <cfquery datasource="#dts#" name="emptyall">
                    truncate fifotemp
                    </cfquery>
                    <cfquery name="getstockoutcount" datasource="#dts#">
                    select 
                    type,
                    refno,
                    itemcount,
                    ifnull(qty,0) as qty,
                    ifnull(amt,0) as amt
                    from ictran 
                    where itemno='#itemno#'
                    and wos_date > "#getgeneral.lastaccyear#"
                    and (void = '' or void is null) and (toinv='' or toinv is null) 
                    and type in ('INV','CS','DN','PR','DO','ISS','OAR')
                    and trdatetime < "#getstockin.trdatetime#"
                    order by wos_date,trdatetime,refno,itemcount;
                    </cfquery>
             
					<cfloop query="getstockin" startrow="1" endrow="#count#">
                    <cfquery name="insertin" datasource="#dts#">
                    INSERT INTO fifotemp (lastin,lastamt,balance)
                    values(
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getstockin.qty)#">,
                    <cfif getstockin.type eq "CN">
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getstockin.it_cos)#">,
					<cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getstockin.amt)#">,
                    </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(getstockin.qty)#">
                    )
                    </cfquery>
                    </cfloop>
                    <cfset countin = 1>
                    
                    <cfquery name="getfifotemp" datasource="#dts#">
                    SELECT * FROM fifotemp
                    </cfquery>
                    
                    <cfloop query="getstockoutcount">
                    <cfset loopcontrol = 1>
                    <cfset balanceoutqty = getstockoutcount.qty>
                    <cfloop condition="loopcontrol GT 0" >
                    
                        <cfloop query="getfifotemp" startrow="#countin#"  endrow="#countin#">
							<cfset balanceleft = getfifotemp.balance - balanceoutqty>
								<cfif balanceleft lt 0>
									<cfset updatedata = 0>
                                    <cfset countin = countin + 1>
                                    <cfset balanceoutqty = abs(balanceleft)>
                                    <cfif getfifotemp.recordcount lt countin>
                                    <cfset loopcontrol = 0>
									</cfif>
                                <cfelse>
									<cfset updatedata = balanceleft >
										<cfif balanceleft eq 0>
                                        <cfset countin = countin + 1>
                                        </cfif>
                               		<cfset loopcontrol = 0>
                                </cfif>
                            <cfquery name="updatebalance" datasource="#dts#">
                            Update fifotemp SET balance = "#updatedata#" WHERE id = "#getfifotemp.currentrow#"
                            </cfquery>
                        </cfloop>
                    </cfloop>
					<cfif getfifotemp.recordcount lt countin>
                    <cfbreak >
                    </cfif>
                    </cfloop>
                    <cfquery name="calculateuseable" datasource="#dts#">
                    Update fifotemp SET useable = (lastin - balance)
                    </cfquery>
                    <cfquery name="gettemplast" datasource="#dts#">
                    SELECT * FROM fifotemp where useable <> 0 order by id desc
                    </cfquery>
                    <cfset openqty = cnqty>
                    <cfset cncost = 0>
                    <cfloop query="gettemplast">
                    <cfset openqty = openqty - gettemplast.useable>
                    <cfif openqty lte 0>
                    <cfset useableqty = gettemplast.useable - abs(openqty)>
                    <cfset cncost = cncost + useableqty * (gettemplast.lastamt/gettemplast.lastin)>
                    <cfbreak>
					<cfelse>
                    <cfset cncost = cncost + gettemplast.useable * (gettemplast.lastamt/gettemplast.lastin)>
					</cfif>
                    </cfloop>
                    <cfset cost = cncost>
                    
                  <cfquery datasource="#dts#" name="emptyall">
                    truncate fifotemp
                    </cfquery>
                    <cfcatch type="any">
                    
                    
					<cfloop query="getstockin" startrow="#count#" endrow="#count#">
               			
                        
							<cfif getstockin.type eq "CN">
								<cfset inqty = inqty>
								<cfset inamt = inamt>
							<cfelse>
								<cfset inqty = getstockin.qty>
								<cfset inamt = getstockin.amt>
							</cfif>
                            			
						</cfloop>
						
						<cfif inamt eq 0 or inqty eq 0>
							<cfset cost = 0>
						<cfelse>
							<!--- REMARK ON 220908 --->
							<!--- <cfset cost = (inamt/inqty)*cnqty> --->
							<cfif val(inqty) neq 0>
								<cfset cost = (inamt/inqty)*cnqty>
							<cfelse>
								<cfset cost = 0>
							</cfif>
						</cfif>
                        </cfcatch>
						</cftry>
                        <cfelse>
                        <cfloop query="getstockin" startrow="#count#" endrow="#count#">
               			
                        
							<cfif getstockin.type eq "CN">
								<cfset inqty = inqty>
								<cfset inamt = inamt>
							<cfelse>
								<cfset inqty = getstockin.qty>
								<cfset inamt = getstockin.amt>
							</cfif>
                            			
						</cfloop>
						
						<cfif inamt eq 0 or inqty eq 0>
							<cfset cost = 0>
						<cfelse>
							<!--- REMARK ON 220908 --->
							<!--- <cfset cost = (inamt/inqty)*cnqty> --->
							<cfif val(inqty) neq 0>
								<cfset cost = (inamt/inqty)*cnqty>
							<cfelse>
								<cfset cost = 0>
							</cfif>
						</cfif>
                        </cfif>
                        
                        <cfquery name="checkcn10" datasource="#dts#">
                        SELECT invlinklist,invcnitem FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and refno='#refno#' 
                        and itemcount='#itemcount2#'
                        </cfquery>
                        
                        <cfif checkcn10.invlinklist neq ''>
                        
                        <cfquery name="getinvitcos" datasource="#dts#">
                        select it_cos from ictran where type='INV'
                        and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkcn10.invlinklist#">
                        and itemcount = '#checkcn10.invcnitem#'
                        </cfquery>
                        <cfquery name="updaterecord1" datasource="#dts#">
							update ictran set 
							it_cos='#getinvitcos.it_cos*qty#'
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount2#';
						</cfquery>
                        
                        <cfelse>
						<cfquery name="updaterecord1" datasource="#dts#">
							update ictran set 
                            <cfif getgeneral.CNbaseonprice eq '1'>
                            it_cos=amt
                            <cfelse>
							it_cos='#cost#'
                            </cfif> 
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount2#';
						</cfquery>
                        </cfif>
                        
					<cfelse>
						<cfset inqty = cnqty>
						<cfset inamt = cnamt>
						<cfquery name="updaterecord2" datasource="#dts#">
							update ictran 
							set it_cos=0 
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount2#';
						</cfquery>
					</cfif>
				</cfif>
			</cfloop>
			
			<cfquery name="getstockin" datasource="#dts#">
				<cfif calitcostgetitem.qtybf neq 0 and check_bfcost.recordcount neq 0>
					select 
					type,
					refno,
					itemcount,
					counter,
					qty,
					amt,
					it_cos,
					wos_date 
					from 
					(
					<cfloop index="a" from="11" to="50">
						<cfif evaluate("check_bfcost.ffq#a#") neq 0>
							(
								select 
								'RC' as type,
								'' as refno,
								'0' as itemcount,
								'#a#' as counter,
								ffq#a# as qty,
								(ffq#a#*ffc#a#) as amt,
								ffc#a# as it_cos,
								'#getgeneral.lastaccyear#' as wos_date
								from fifoopq 
								where itemno='#itemno#'
							)
							union
						</cfif>
					</cfloop>
						(
							select 
							type,
							refno,
							itemcount,
							'1' as counter,
							ifnull(qty,0) as qty,
                            
                            ifnull(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                           
							it_cos,
							wos_date 
							from ictran 
							where itemno='#itemno#' and 
							wos_date > "#getgeneral.lastaccyear#"
							and (void = '' or void is null) 
							and type in ('RC','CN','OAI')
							order by wos_date,trdatetime,refno,itemcount
						)
					) as a 
					order by wos_date,refno,itemcount,counter desc;
				<cfelse>
					select 
					type,
					refno,
					itemcount,
					'1' as counter,
					ifnull(qty,0) as qty,
                   
                            ifnull(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                    
					it_cos 
					from ictran 
					where itemno='#itemno#' and 
					wos_date > "#getgeneral.lastaccyear#"
					and (void = '' or void is null) 
					and type in ('RC','CN','OAI')
					order by wos_date,trdatetime,refno,itemcount;
				</cfif>
			</cfquery>
			
			<cfset stockoutcount = getstockout.recordcount>
			<cfset stockincount = getstockin.recordcount>
			<!--- <cfset suminqty = calitcostgetitem.qtybf> --->
			<cfset suminqty = 0>
			<cfset countin = 1>
			<cfset countout = 1>
			<cfset oqty = 0>
			<cfset iqty = 0>
			
			<cfloop condition="countout lte stockoutcount">
				<cfif oqty eq 0>
					<cfset cost = 0>
				</cfif>
				<cfif countin gt stockincount>
					<cfbreak>
				</cfif>
				<cfloop query="getstockout" startrow="#countout#" endrow="#stockoutcount#">
					<cfset refno = getstockout.refno>
					<cfset itemcount2 = getstockout.itemcount>
					<cfset otype = getstockout.type>
					<cfset outqty = getstockout.qty>

					<cfif suminqty gte outqty><!---bf qty eq gte stockout qty--->
						<cfset suminqty = suminqty - outqty>
                        <cfif otype eq "INV">
						<cfquery name="checkcn" datasource="#dts#">
                        SELECT qty,amt FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and invlinklist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                        and invcnitem = '#itemcount2#'
                        </cfquery>   
                        </cfif>
						<cfquery name="updaterecord" datasource="#dts#">
							update ictran 
							set 
                            <cfif otype eq "INV">
								<cfif checkcn.recordcount eq 1>
                                it_cos=if(qty != 0 and qty >= #val(checkcn.qty)#,(qty-#val(checkcn.qty)#)*(#val(cost)#/qty),#val(cost)#)
                                ,cnamt = <cfqueryparam cfsqltype="cf_sql_double" value="#val(checkcn.amt)#">
                                ,cnqty = <cfqueryparam cfsqltype="cf_sql_double" value="#val(checkcn.qty)#">
                                <cfelse>
                                it_cos='#cost#' 
								</cfif>
                            <cfelse>
                            it_cos='#cost#' 
                            </cfif>
							where type='#otype#' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount2#';
						</cfquery>
						
						<cfset countout = countout + 1>
						<cfset countin = 1>
					<cfelse><!---bf qty eq 0--->
						<cfif suminqty neq 0>
							<cfset oqty = outqty - suminqty>
							<cfset cost = cost + 0>
							<cfset suminqty = 0>
							<cfset countout = countout>
							<cfset countin = 1>
						<cfelse>
                        
							<cfloop query="getstockin" startrow="#countin#" endrow="#stockincount#">
								<cfset inqty = getstockin.qty>
								<cfset iamt = getstockin.amt>
								<cfset itype = getstockin.type>

								<cfif oqty neq 0>
									<cfif inqty gte oqty>
										<cfset iqty = inqty - oqty>
										<cfif itype eq "CN">
											<cfif getstockin.it_cos neq 0>
												<!--- REMARK ON 220908 --->
												<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*oqty)> --->
												<cfif val(inqty) neq 0>
													<cfset cost = cost + ((getstockin.it_cos/inqty)*oqty)>
												<cfelse>
													<cfset cost = cost>
												</cfif>
											<cfelse>
												<cfset cost = cost + 0>
											</cfif>
										<cfelse>
											<!--- REMARK ON 220908 --->
											<!--- <cfset cost = cost + ((iamt/inqty)*oqty)> --->
											<cfif val(inqty) neq 0>
												<cfset cost = cost + ((iamt/inqty)*oqty)>
											<cfelse>
												<cfset cost = cost + 0>
											</cfif>
										</cfif>
										<cfset oqty = 0>
										<cfif iqty eq 0>
											<cfset countin = countin +1>
											<cfset countout = countout + 1>
										<cfelse>
											<cfset countin = countin>
											<cfset countout = countout + 1>
										</cfif>
										<cfbreak>
									<cfelse>
										<cfset oqty = oqty - inqty>
										<cfif itype eq "CN">
											<cfif getstockin.it_cos neq 0>
												<!--- REMARK ON 220908 --->
												<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)> --->
												<cfif val(inqty) neq 0>
													<cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)>
												<cfelse>
													<cfset cost = cost + 0>
												</cfif>
											<cfelse>
												<cfset cost = cost + 0>
											</cfif>
										<cfelse>
											<cfset cost = cost + iamt>
										</cfif>
										<cfset countin = countin + 1>
										<cfset countout = countout>
										<cfbreak>
									</cfif>
								<cfelse>
									<cfif iqty neq 0><!----iqty neq 0--->
										<cfif iqty gte outqty>
											<cfif otype eq "DO">
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- REMARK ON 220908 --->
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- REMARK ON 220908 --->
													<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
												<cfset iqty = iqty - (outqty-1)>
											<cfelse>
												<cfset iqty = iqty - outqty>
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
											</cfif>
											<cfif iqty eq 0>
												<cfset countout = countout + 1>
												<cfset countin = countin + 1>
											<cfelse>
												<cfset countout = countout + 1>
												<cfset countin = countin>
											</cfif>
											<cfbreak>
										<cfelse>
											<cfif otype eq "DO">
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<cfset cost = cost + ((iamt/inqty)*outqty)>
												</cfif>
												<cfset oqty = (outqty - 1) - iqty>
											<cfelse>
												<cfset oqty = outqty - iqty>
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- REMARK ON 220908 --->
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*iqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*iqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- REMARK ON 220908 --->
													<!--- <cfset cost = cost + ((iamt/inqty)*iqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*iqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
											</cfif>
											<cfif oqty eq 0>
												<cfset countout = countout +1>
												<cfset countin = countin + 1>
											<cfelse>
												<cfset countout = countout>
												<cfset countin = countin + 1>
											</cfif>
											<cfbreak>
										</cfif>
									<cfelse><!----iqty eq 0--->
										<cfif inqty gte outqty>
											<cfif otype eq "DO">
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
												<cfset iqty = inqty - (outqty - 1)>
											<cfelse>
												<cfset iqty = inqty - outqty>
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- REMARK ON 220908 --->
													<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
											</cfif>
											<cfif iqty eq 0>
												<cfset countin = countin + 1>
												<cfset countout = countout + 1>
											<cfelse>
												<cfset countin = countin>
												<cfset countout = countout + 1>
											</cfif>
											<cfbreak>
										<cfelse>
											<cfif otype eq "DO">
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<!--- REMARK ON 220908 --->
													<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((iamt/inqty)*outqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												</cfif>
												<cfset oqty = (outqty - 1) - inqty>
											<cfelse>
												<cfset oqty = outqty - inqty>
												<cfif itype eq "CN">
													<cfif getstockin.it_cos neq 0>
														<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<cfset cost = cost + iamt>
												</cfif>
											</cfif>
											<cfif oqty eq 0>
												<cfset countin = countin + 1>
												<cfset countout = countout +1>
											<cfelse>
												<cfset countin = countin + 1>
												<cfset countout = countout>
											</cfif>
											<cfbreak>
										</cfif>
									</cfif>
								</cfif>
							</cfloop><!---Next Stockin--->
						</cfif>
					</cfif>
                    <cfif otype eq "INV">
						<cfquery name="checkcn" datasource="#dts#">
                        SELECT qty,amt FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and invlinklist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                        and invcnitem = '#itemcount2#'
                        </cfquery>   
                        </cfif>
					<cfquery name="updaterecord" datasource="#dts#">
						update ictran set 
						 
                        <cfif otype eq "INV">
							<cfif checkcn.recordcount eq 1>
                            it_cos=if(qty != 0 and qty >= #val(checkcn.qty)#,(qty-#val(checkcn.qty)#)*(#val(cost)#/qty),#val(cost)#)
                        	,cnamt = <cfqueryparam cfsqltype="cf_sql_double" value="#val(checkcn.amt)#">
                            ,cnqty = <cfqueryparam cfsqltype="cf_sql_double" value="#val(checkcn.qty)#">
							<cfelse>
                            it_cos='#cost#'
							</cfif>
                         <cfelse>
                         it_cos='#cost#'   
                         </cfif>
						where type='#otype#' 
						and refno='#refno#' 
						and itemno='#itemno#' 
						and itemcount='#itemcount2#';
					</cfquery>
					<cfbreak>
				</cfloop><!---Next Stockout--->
			</cfloop>
		</cfloop><!---Next Item--->


<cfelse>



<cfquery name="getgeneral" datasource="#dts#">
			select date_format(lastaccyear,'%Y-%m-%d') as lastaccyear from gsetup;
		</cfquery>
		
		<cfquery name="calitcostgetitem" datasource="#dts#">
			select a.itemno,ifnull(a.qtybf,0) as qtybf 
			from icitem as a,
			(select itemno from ictran where (toinv='' or toinv is null) and (void = '' or void is null) 
			and itemno='#form.itemno#'			
			and (type='RC' or type='OAI' or type='CN' or type='INV' or type='DO' or type='CS' or type='DN' or type='ISS' or type='OAR' or type='PR') group by itemno) as b 
			where a.itemno=b.itemno order by a.itemno;
		</cfquery>
		
		<cfloop query="calitcostgetitem">
			<cfset itemno = calitcostgetitem.itemno>
				
			<cfquery name="getstockout" datasource="#dts#">
				select refno,itemcount,type,qty,amt,wos_date 
                from ictran 
                where wos_date > "#getgeneral.lastaccyear#" 
				and (type="inv" or type="cs" or type="dn" or type="pr" or type="do" or type="iss" or type="oar") 
				and itemno = '#itemno#' and (toinv='' or toinv is null) and (void = '' or void is null)
				order by wos_date,trdatetime,refno,itemcount
			</cfquery>
			
			<cfquery name="getstockin" datasource="#dts#">
				select refno,itemcount,type,price,qty,(amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7) as amt,it_cos from ictran where wos_date > "#getgeneral.lastaccyear#" 
				and (type = 'RC' or type = 'CN' or type='OAI') and itemno = '#itemno#' and (void = '' or void is null)
				order by wos_date,trdatetime,refno,itemcount
			</cfquery>
			
			<cfloop query="getstockin">
				<cfif getstockin.type eq "CN">
					<cfset refno = getstockin.refno>
					<cfset itemcount2 = getstockin.itemcount>
					<cfset cnqty = getstockin.qty>
					<cfset count = getstockin.currentrow>
					<cfset count = count - 1>
					<cfif count neq 0>
						<cfloop query="getstockin" startrow="#count#" endrow="#count#">
							<cfif getstockin.type eq "CN">
								<cfset inqty = inqty>
								<cfset inamt = inamt>
							<cfelse>
								<cfset inqty = getstockin.qty>
								<cfset inamt = getstockin.amt>
							</cfif>
						</cfloop>
						<!--- <cfset cost = (inamt/inqty)*cnqty> --->
						<cfif val(inqty) neq 0>
							<cfset cost = (inamt/inqty)*cnqty>
						<cfelse>
							<cfset cost = 0>
						</cfif>
						<cfquery name="updaterecord" datasource="#dts#">
							update ictran set it_cos = "#cost#" where refno = "#refno#" and itemno = '#itemno#' and itemcount = '#itemcount2#'
						</cfquery>
					<cfelse>
						<cfquery name="updaterecord" datasource="#dts#">
							update ictran set it_cos = 0 where refno = "#refno#" and itemno = '#itemno#' and itemcount = '#itemcount2#'
						</cfquery>
					</cfif>
				</cfif>
			</cfloop>
			
			<cfquery name="getstockin" datasource="#dts#">
				select refno,itemcount,type,price,qty,(amt+m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7) as amt,it_cos from ictran where wos_date > "#getgeneral.lastaccyear#" 
				and (type = 'RC' or type = 'CN' or type='OAI') and itemno = '#itemno#' and (void = '' or void is null)
				order by wos_date,trdatetime,refno,itemcount
			</cfquery>
			
			<cfset count = getstockin.recordcount>
			<cfset stockoutcount = getstockout.recordcount>
			<cfset stockincount = 1>
	
			<cfif val(calitcostgetitem.qtybf) neq 0>
				<cfset suminqty = val(calitcostgetitem.qtybf)>
			<cfelse>
				<cfset suminqty = 0>
			</cfif>
	
			<cfset countin = getstockin.recordcount>
			<cfset countout = 1>
			<cfset oqty = 0>
			<cfset iqty = 0>
			
			<cfloop condition="countout lte stockoutcount">
				<cfif oqty eq 0>
					<cfset cost = 0>
				</cfif>
				<cfif countin lt stockincount>
					<cfbreak>
				</cfif>
				<cfloop query="getstockout" startrow="#countout#" endrow="#stockoutcount#">
					<cfset refno = getstockout.refno>
					<cfset itemcount2 = getstockout.itemcount>
					<cfset otype = getstockout.type>
					<cfset outqty = val(getstockout.qty)>
					
					<cfif suminqty gte outqty><!---bf qty eq gte stockout qty--->
						<cfset suminqty = suminqty - outqty>
						
						<cfquery name="updaterecord" datasource="#dts#">
							update ictran set it_cos = "#cost#" where refno = "#refno#" and itemno = '#itemno#' and itemcount='#itemcount2#'
						</cfquery>
						<cfset countout = countout + 1>
						<cfset countin = getstockin.recordcount>
					<cfelse><!---bf qty eq 0--->
						<cfif suminqty neq 0>
							<cfset oqty = outqty - suminqty>
							<cfset cost = cost + 0>
							<cfset suminqty = 0>
							<cfset countout = countout>
							<cfset countin = getstockin.recordcount>
						<cfelse>
							<cfloop condition="countin gte 1">
								<cfloop query="getstockin" startrow="#countin#" endrow="#countin#">
									<cfset inqty = val(getstockin.qty)>
									<cfset iamt = val(getstockin.amt)>
									<cfset itype = getstockin.type>
									
									<cfif oqty neq 0>
										<cfif inqty gte oqty>
											<cfset iqty = inqty - oqty>
											
											<cfif itype eq "CN">
												<cfif getstockin.it_cos neq 0>
													<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*oqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((getstockin.it_cos/inqty)*oqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<cfset cost = cost + 0>
												</cfif>
											<cfelse>
												<!--- <cfset cost = cost + ((iamt/inqty)*oqty)> --->
												<cfif val(inqty) neq 0>
													<cfset cost = cost + ((iamt/inqty)*oqty)>
												<cfelse>
													<cfset cost = cost + 0>
												</cfif>
											</cfif>
											
											<cfset oqty = 0>
											
											<cfif iqty eq 0>
												<cfset countin = countin - 1>
												<cfset countout = countout + 1>
											<cfelse>
												<cfset countin = countin>
												<cfset countout = countout + 1>
											</cfif>
											
											<cfbreak>
										<cfelse>
											<cfset oqty = oqty - inqty>
											
											<cfif itype eq "CN">
												<cfif getstockin.it_cos neq 0>
													<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)> --->
													<cfif val(inqty) neq 0>
														<cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)>
													<cfelse>
														<cfset cost = cost + 0>
													</cfif>
												<cfelse>
													<cfset cost = cost + 0>
												</cfif>
											<cfelse>
												<cfset cost = cost + iamt>
											</cfif>
											
											<cfset countin = countin - 1>
											<cfset countout = countout>
											<cfbreak>
										</cfif>
									<cfelse>
										<cfif iqty neq 0><!----iqty neq 0--->
											<cfif iqty gte outqty>
												<cfif otype eq "DO">
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
													
													<cfset iqty = iqty - (outqty-1)>
												<cfelse>
													<cfset iqty = iqty - outqty>
													
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
												</cfif>
												
												<cfif iqty eq 0>
													<cfset countout = countout + 1>
													<cfset countin = countin - 1>
												<cfelse>
													<cfset countout = countout + 1>
													<cfset countin = countin>
												</cfif>
												
												<cfbreak>
											<cfelse>
												
												<cfif otype eq "DO">
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
													
													<cfset oqty = (outqty - 1) - iqty>
												<cfelse>
													<cfset oqty = outqty - iqty>
													
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*iqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*iqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*iqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*iqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
												</cfif>
												
												<cfif oqty eq 0>
													<cfset countout = countout + 1>
													<cfset countin = countin - 1>
												<cfelse>
													<cfset countout = countout>
													<cfset countin = countin - 1>
												</cfif>
												
												<cfbreak>
											</cfif>
										<cfelse><!----iqty eq 0--->
											<cfif inqty gte outqty>
												
												<cfif otype eq "DO">
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
													
													<cfset iqty = inqty - (outqty - 1)>
												<cfelse>
													<cfset iqty = inqty - outqty>
													
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
												</cfif>
												
												<cfif iqty eq 0>
													<cfset countin = countin - 1>
													<cfset countout = countout + 1>
												<cfelse>
													<cfset countin = countin>
													<cfset countout = countout + 1>
												</cfif>
												<cfbreak>
											<cfelse>
												
												<cfif otype eq "DO">
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*outqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<!--- <cfset cost = cost + ((iamt/inqty)*outqty)> --->
														<cfif val(inqty) neq 0>
															<cfset cost = cost + ((iamt/inqty)*outqty)>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													</cfif>
													
													<cfset oqty = (outqty - 1) - inqty>
												<cfelse>
													<cfset oqty = outqty - inqty>
													
													<cfif itype eq "CN">
														<cfif getstockin.it_cos neq 0>
															<!--- <cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)> --->
															<cfif val(inqty) neq 0>
																<cfset cost = cost + ((getstockin.it_cos/inqty)*inqty)>
															<cfelse>
																<cfset cost = cost + 0>
															</cfif>
														<cfelse>
															<cfset cost = cost + 0>
														</cfif>
													<cfelse>
														<cfset cost = cost + iamt>
													</cfif>
												</cfif>
												
												<cfif oqty eq 0>
													<cfset countin = countin - 1>
													<cfset countout = countout + 1>
												<cfelse>
													<cfset countin = countin - 1>
													<cfset countout = countout>
												</cfif>
												<cfbreak>
											</cfif>
										</cfif>
									</cfif>
								</cfloop><!---Next Stockin--->
								<cfbreak>
							</cfloop>
						</cfif>
					</cfif>
					
					<cfquery name="updaterecord" datasource="#dts#">
						update ictran set it_cos = "#cost#" where refno = "#refno#" and itemno = '#itemno#' and itemcount = '#itemcount2#'
					</cfquery>
					
					<cfbreak>
				</cfloop><!---Next Stockout--->
			</cfloop>
		</cfloop><!---Next Item--->

</cfif>


