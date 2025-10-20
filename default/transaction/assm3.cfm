<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1071,1110,1111,1116,1112,120,1113,65,1114,1096,482,1082,592,1099,1115,702,592,1108">
<cfinclude template="/latest/words.cfm">
<html>
<head>
<title><cfoutput>#words[1071]#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	function data_validation() {
		<!--- INSERT COMPULSORY LOCATION CHECKING --->
		<cfinclude template = "transaction_setting_checking/compulsory_location_assm3.cfm">
		<!--- INSERT COMPULSORY LOCATION CHECKING --->
	}
</script>
</head>
<cfoutput>
<cfquery datasource="#dts#" name="getGeneralInfo">
	SELECT *
	FROM gsetup;
</cfquery>

<cfparam name="pricehis1" default="">
<cfparam name="pricehis2" default="">
<cfparam name="pricehis3" default="">
<cfparam name="disc1" default="">
<cfparam name="disc2" default="">
<cfparam name="disc3" default="">
<cfparam name="date1" default="">
<cfparam name="date2" default="">
<cfparam name="date3" default="">
<cfparam name="itembal" default="0">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0"> 
<cfparam name="CSqty" default="0"> 
<cfparam name="ISSqty" default="0"> 
<cfparam name="trinqty" default="0"> 
<cfparam name="troutqty" default="0">
<cfparam name="oaiqty" default="0">
<cfparam name="oarqty" default="0">
<cfparam name="balonhand" default="0">

<cfquery datasource="#dts#" name="getlocation">
	SELECT location 
    FROM iclocation
</cfquery>

<cfoutput>
	<cfif url.type1 eq "Add">
		<cfquery datasource='#dts#' name="checkitemExist">
			SELECT * 
            FROM ictran 
            WHERE refno = '#nexttranno#' AND itemno = '#itemno#' AND type = 'ISS'
		</cfquery>

		<cfif checkitemExist.recordcount GT 0>
			<div align="center"><h3>#words[1110]#</h3>
			<input type="button" name="back" value="#words[1111]#" onClick="javascript:history.back()"></div>
			<cfabort>
		</cfif> 
		<cfquery datasource="#dts#" name="getproductdetails">
			SELECT * 
            FROM icitem 
            WHERE itemno = '#itemno#'
		</cfquery>
		<cfquery datasource='#dts#' name="getpricehis">
			SELECT * 
            FROM ictran 
            WHERE itemno= '#itemno#' 
            ORDER BY wos_date DESC
		</cfquery>
		<cfquery name="getitembal" datasource="#dts#">
			SELECT qtybf 
            FROM icitem 
            WHERE itemno = '#itemno#'
		</cfquery>
		<cfset itemno = itemno>
		<cfset desp="">
		<cfset despa="">
		<cfset xlocation="">
		<cfset qty="0">
		<cfset price="0">
		<cfset dono="">
		<cfset gst_item="">
		<cfset totalup="">
		<cfset dispec1="0">
		<cfset taxpec1="0">
		<cfset wos_grouop="">
		<cfset category="">
		<cfset area="">
		<cfset shelf="">
		<cfset mode="Add">
		<cfset button="Add">
		<cfset modeWords="#words[1116]#">
	</cfif>
	<cfif getpricehis.recordcount gt 0>
		<cfloop query="getpricehis" startrow="1" endrow="1">
			<cfset pricehis1 = numberformat(price,"____.__")>
			<cfset date1 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc1 = dispec1>
		</cfloop>
		
		<cfloop query="getpricehis" startrow="2" endrow="2">
			<cfset pricehis2 = numberformat(price,"____.__")>
			<cfset date2 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc2 = dispec1>
		</cfloop>
		
		<cfloop query="getpricehis" startrow="3" endrow="3">
			<cfset pricehis3 = numberformat(price,"____.__")>
			<cfset date3 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc3 = dispec1>
		</cfloop>		
	</cfif>
	<cfif getitembal.qtybf neq "">
		<cfset itembal = getitembal.qtybf>	
	</cfif> 
	<cfquery name="getrc" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type ="RC" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getrc.recordcount gt 0>
		<cfif getrc.sumqty neq "">
			<cfset RCqty = getrc.sumqty>
		</cfif>
	</cfif>
	<cfquery name="getpr" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "PR" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getpr.recordcount gt 0>
		<cfif getpr.sumqty neq "">
			<cfset PRqty = getpr.sumqty>
		</cfif>
	</cfif>
	<cfquery name="getdo" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "DO" AND toinv = "" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getdo.recordcount gt 0>
		<cfif getdo.sumqty neq "">
			<cfset DOqty = getdo.sumqty>
		</cfif>
	</cfif>
	<cfquery name="getinv" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "INV" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getinv.recordcount gt 0>
		<cfif getinv.sumqty neq "">
			<cfset INVqty = getinv.sumqty>
		</cfif>
	</cfif>
	<cfquery name="getcn" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "CN" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getcn.recordcount gt 0>
		<cfif getcn.sumqty neq "">
			<cfset CNqty = getcn.sumqty>
		</cfif>
	</cfif>
	<cfquery name="getdn" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "DN" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getdn.recordcount gt 0>
		<cfif getdn.sumqty neq "">
			<cfset DNqty = getdn.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="getcs" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "CS" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getcs.recordcount gt 0>
		<cfif getcs.sumqty neq "">
			<cfset CSqty = getcs.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="getiss" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "ISS" AND itemno = "#itemno#" AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getiss.recordcount gt 0>
		<cfif getiss.sumqty neq "">
			<cfset ISSqty = getiss.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="gettrin" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "TRIN" AND itemno = '#itemno#' AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif gettrin.recordcount gt 0>
		<cfif gettrin.sumqty neq "">
			<cfset trinqty = gettrin.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="gettrout" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "TROU" AND itemno = '#itemno#' AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif gettrout.recordcount gt 0>
		<cfif gettrout.sumqty neq "">
			<cfset troutqty = gettrout.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="getoai" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "OAI" AND itemno = '#itemno#' AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getoai.recordcount gt 0>
		<cfif getoai.sumqty neq "">
			<cfset oaiqty = getoai.sumqty>
		</cfif>		
	</cfif>
	<cfquery name="getoar" datasource="#dts#">
		SELECT sum(qty) AS sumqty 
        FROM ictran 
        WHERE type = "OAR" AND itemno = '#itemno#' AND fperiod <> '99' AND (void='' OR void IS NULL)
	</cfquery>
	<cfif getoar.recordcount gt 0>
		<cfif getoar.sumqty neq "">
			<cfset oarqty = getoar.sumqty>
		</cfif>		
	</cfif>
	<!--- <cfset balonhand = itembal + rcqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty>  ---> 
	<cfset balonhand = itembal + rcqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty + trinqty - troutqty + oaiqty - oarqty>  
</cfoutput>

<body>
<cfform name="form1" method="post" action="assm4.cfm?nDateCreate=#nDateCreate#" onsubmit="JavaScript:return data_validation();">
    <cfquery name="getbom" datasource="#dts#">
        SELECT * 
        FROM billmat 
        WHERE itemno = '#form.itemno#' AND bomno = '#form.bomno#' 
        GROUP BY itemno,bomno,bmitemno 
        ORDER BY bmitemno
    </cfquery>
    <cfset totalprice = 0>
    <cfif getproductdetails.bom_cost neq "">
        <cfset xbomcost = getproductdetails.bom_cost>
    <cfelse>
        <cfset xbomcost = 0>
    </cfif>
    <cfloop query="getbom">	
        <cfquery name="getitem" datasource="#dts#">
            SELECT * 
            FROM icitem 
            WHERE itemno = '#bmitemno#'
        </cfquery>
		<cfif isdefined('form.movingavrg')>
        <cfquery name="getdoupdated" datasource="#dts#">
            SELECT frrefno FROM iclink WHERE frtype = "DO" 
            and itemno = '#bmitemno#' 
            group by frrefno
            </cfquery>
            <cfset billupdated=valuelist(getdoupdated.frrefno)>
        <cfif getGeneralInfo.cost eq "FIFO">
            
            
                 <cfquery name="getbmitembalance" datasource="#dts#">
                    select 
                    ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                    from icitem as a
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalin 
                        from ictran 
                        where type in ('RC','CN','OAI','TRIN') 
                        and itemno='#bmitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        group by itemno
                    ) as b on a.itemno=b.itemno
                    
                    left join 
                    (
                        select itemno,sum(qty) as sumtotalout 
                        from ictran 
                        where
                                (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
                                (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                        and itemno='#bmitemno#' 
                        and fperiod<>'99'
                        and (void = '' or void is null)
                        and (linecode="" or linecode is null)
                        group by itemno
                    ) as c on a.itemno=c.itemno
                    
                    where a.itemno='#bmitemno#' 
                    and (a.itemtype <> 'SV' or a.itemtype is null)
                 </cfquery>
                 
                 <cfquery name="getlastrc" datasource="#dts#">
                    select 
                    a.qty,a.toinv,if(a.type = "CN",a.it_cos/qty,a.amt)as amt,(amt/qty) as price,
                    a.type,a.refno,a.itemno,a.trancode
                    from ictran a
                    
                    where a.itemno='#bmitemno#' 
                    and (a.void = '' or a.void is null) 
                    and (a.linecode = '' or a.linecode is null)
                    and a.type in ('RC','OAI','CN')
                    and a.fperiod<>'99'
                    
                    order by a.wos_date desc,a.trdatetime desc
                </cfquery>
                <cfset fifobalance=getbmitembalance.balance>
                
                <cfset itemprice=0>
                
                <!---getfrombill--->
                <cfloop query="getlastrc">
                <cfif fifobalance gt 0>
                <cfset itemprice = getlastrc.price>
                <cfbreak>
                </cfif>
                </cfloop>
                
                <cfif fifobalance gt 0>
                <cfquery name="getfifocost" datasource="#dts#">
                    select * from fifoopq where itemno="#bmitemno#" 
                </cfquery>
                
                <cfloop from="11" to="50" index="z">
                    <cfif fifobalance gt 0>
                    <cfset itemprice = val(evaluate('getfifocost.ffc#z#'))>
                    <cfbreak>
                    </cfif>
                </cfloop>
                
                
                </cfif>
                
            <cfelse>
        
        <!--- Get average moving cost --->
   	<cfquery name="getqtybf" datasource="#dts#">
			select avcost2,qtybf FROM icitem
			where itemno='#bmitemno#'
			 limit 1
    </cfquery>
    <cfset movingunitcost=getqtybf.avcost2>
    <cfset movingbal=getqtybf.qtybf>
    
    <cfquery name="getmovingictran" datasource="#dts#">
			select 
			a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a,artran b
            
			where a.itemno='#bmitemno#' 
            and a.refno=b.refno and a.type=b.type
			and (a.void = '' or a.void is null) 
			and (a.linecode = '' or a.linecode is null)
			and 

                (a.type in ('DO','DN','PR','CS','ISS','OAR','TROU','RC','CN','OAI','TRIN') or 
				(a.type='INV' and (a.dono = "" or a.dono is null or a.dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))

			and a.fperiod<>'99'
			and a.wos_date > #getGeneralInfo.lastaccyear#
			
			order by b.wos_date,b.trdatetime
	</cfquery>
    
    <cfloop query="getmovingictran">
        
        <!---exclude CN --->
        <cfif getGeneralInfo.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        </cfif>
        
        <cfif getGeneralInfo.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
	    <cfset movingbal=movingbal-getmovingictran.qty>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        
        </cfloop>
    
    
    
    <!--- end of average moving cost --->
            </cfif>
        </cfif>

		<cfif isdefined('form.movingavrg')>
        <cfif getGeneralInfo.cost eq "FIFO">
        <cfelse>
            <cfif movingbal gt 0>
            <cfset itemprice = movingbal*movingunitcost>
            <cfelse>
            <cfset itemprice = 0>
            </cfif>
        </cfif>
        <cfelse>
			<cfif getitem.price neq "">
                <cfset itemprice = getitem.ucost>
            <cfelse>		
                <cfset itemprice = 0>
            </cfif>
        </cfif>
        <cfset amt1_bil = bmqty * itemprice * currrate>
        <cfset totalprice = totalprice + amt1_bil>
        
    </cfloop>

<!--- <cfset totalprice = totalprice + xbomcost> --->
  	<input type="hidden" name="bomno" value="#form.bomno#">
  	<input type="hidden" name="desp" value="#form.desp#">
  	<input type="hidden" name="despa" value="#form.despa#">
  	<input type="hidden" name="custno" value="ASSM/999">
  	<input type="hidden" name="nexttranno" value="#nexttranno#">
  	<input type="hidden" name="invoicedate" value="#invoicedate#">
  	<input type="hidden" name="readperiod" value="#form.readperiod#">
  	<input type="hidden" name="currrate" value="#currrate#">
  	<input type="hidden" name="refno3" value="#refno3#">
  	
	<cfif mode eq "Add">
    	<input type="hidden" name="mode" value="ADD">
    <cfelseif mode eq "Edit">
    	<input type ="hidden" name="mode" value="Edit">
    <cfelse>
    	<input type="hidden" name="mode" value="Delete">
  	</cfif>
  	
	<table align="center" class="data">
    	<tr> 
      		<th colspan="6">#words[1112]#</th>
    	</tr>
    	<tr> 
      		<th width="73" height="37">#words[120]#</th>
      		<td colspan="3">#itemno#<input type="hidden" name="itemno" value="#itemno#"></td>
      		<th width="129">#words[1113]#</th>
      		<td width="60"><input name="balance" type="text" size="6" maxlength="10" value="#balonhand#" readonly></td>
    	</tr>
    	<tr> 
      		<th rowspan="2">#words[65]#</th>
      		<td colspan="3" nowrap><input name="desp2" type="text" value="#getproductdetails.desp#" size="40" maxlength="40"></td>
      		<th>#words[1114]#</th>
      		<td><cfinput name="qty" type="text" id="qty" size="6" maxlength="10" value="#qty#" required="yes" message="Please key in the quantity." validate="integer"></td>
    	</tr>
    	<tr> 
      		<td colspan="3" nowrap><input type="text" name="despa2" value="#getproductdetails.despa#" size="40" maxlength="40"></td> 
			<th>#words[1096]#</th>
      		<td><input name="price" type="text" size="6" maxlength="10" value="#numberformat(val(totalprice)+val(getproductdetails.bom_cost),".__")#"></td>
    	</tr>
    	<tr> 
      		<th>#words[482]#</th>
      		<td colspan="3">
				<select name="location">
          			<option value="">#words[1082]#</option>
          			<cfloop query="getlocation"> 
            			<option value="#getlocation.location#">#location#</option>
          			</cfloop>
				</select>
			</td>
      		<th>#words[592]# (%)</th>
      		<td><input name="dispec1" type="text" value="#dispec1#" size="6" maxlength="3"></td>
    	</tr>
        <tr>
            <th>#getgeneralinfo.brem1#</th>
            <td><input type="text" name="brem1" id="brem1" value=""></td>
            <th>#getgeneralinfo.brem2#</th>
            <td>
            <cfif lcase(hcomid) eq "amalax_i">
                <select name="brem2" id="brem2">
                    <option value="">Choose a Status</option>
                    <option value="Kit" >Kit</option>
                    <option value="FOC" >FOC</option>
                </select>
            <cfelse>
                <input type="text" name="brem2" id="brem2" value="">
            </cfif>
            </td>
        </tr>
        <tr> 
        	<th></th>
        	<td></td>
        	<td></td>
        	<td></td>
        	<th>#words[1099]# (%)</th>
        	<td><input name="taxpec1" type="text" value="#taxpec1#" size="6" maxlength="3"></td>
      	</tr>
      	<tr> 
        	<th colspan="4">#words[1115]#</th>
      	</tr>
      	<tr> 
        	<td><strong>#words[702]#</strong></td>
        	<td width="72"><strong>#words[1096]#</strong></td>
        	<td width="95">&nbsp;</td>
        	<td width="95"><strong>#words[592]# %</strong></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date1#</td>
        	<td>#pricehis1#</td>
        	<td>&nbsp;</td>
        	<td>#disc1#</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date2#</td>
        	<td>#pricehis2#</td>
        	<td>&nbsp;</td>
        	<td>#disc2#</td>
        	<td></td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date3#</td>
        	<td>#pricehis3#</td>
        	<td>&nbsp;</td>
        	<td>#disc3#</td>
        	<td></td>
        	<td>&nbsp;</td>
      	</tr>
        <tr>
        <td style="visibility:hidden">#words[1108]#<input type="checkbox" name="movingavrg" id="movingavrg" <cfif isdefined('form.movingavrg')>checked</cfif>></td>
        </tr>
      	<tr> 
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td><input type="button" name="back2" value="#words[1111]#" onClick="javascript:history.back()">
            <input type="submit" name="Submit" value="#modeWords#"></td> 
      	</tr>
  	</table>
</cfform>

</body>
</cfoutput>
</html>