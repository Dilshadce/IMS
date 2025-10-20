<cfcomponent>
	<cffunction name="calculate_first_in_fist_out_cost">
		<cfargument name="dts" required="yes">
		<cfargument name="itemfrom" required="yes">
		<cfargument name="itemto" required="yes">
		
		<cfquery name="getgeneral" datasource="#arguments.dts#">
			select 
			date_format(lastaccyear,'%Y-%m-%d') as lastaccyear,CNbaseonprice
			from gsetup;
		</cfquery>
		
		<cfquery name="getitem" datasource="#arguments.dts#">
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
				<cfif arguments.itemfrom neq "" and arguments.itemto neq "">
					and itemno between '#arguments.itemfrom#' and '#arguments.itemto#' 
				</cfif>			
				group by itemno
			) as b 
			where a.itemno=b.itemno 
			order by a.itemno;
		</cfquery>

		<cfloop query="getitem">
			<cfset itemno = getitem.itemno>
            <cfset cost=0>
			
            <cfset qtyremain=getitem.qtybf>
            
			<cfif getitem.qtybf neq 0>
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

			<cfquery name="getstockout" datasource="#arguments.dts#">
				select 
				type,
				refno,
				itemcount,
				ifnull(qty,0) as qty,
				ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt
				from ictran 
				where itemno='#itemno#'
				and wos_date > "#getgeneral.lastaccyear#"
				and (void = '' or void is null) and (toinv='' or toinv is null) 
				and type in ('INV','CS','DN','PR','DO','ISS','OAR')
                <!---added by lung 20130104--->
                and qty <> 0
                <!--- --->
				order by wos_date,trdatetime,refno,itemcount;
			</cfquery>
			
			<cfquery name="getstockin" datasource="#arguments.dts#">
				<cfif getitem.qtybf neq 0 and check_bfcost.recordcount neq 0>
					select 
					type,
					refno,
					itemcount,
					counter,
					qty,
					amt,
					it_cos,
                    trdatetime,
					wos_date,
                    dono
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
								'#getgeneral.lastaccyear#' as wos_date,
                                '' as dono
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
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
							it_cos,
                            trdatetime,
							wos_date,
                            dono
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
                    <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                    <cfelse>
					ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                    </cfif>
					it_cos,
                    trdatetime,
                    wos_date,
                    dono
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
					<cfset itemcount = getstockin.itemcount>
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
                    ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt
                    from ictran 
                    where itemno='#itemno#'
                    and wos_date > "#getgeneral.lastaccyear#"
                    and (void = '' or void is null) and (toinv='' or toinv is null) 
                    and type in ('INV','CS','DN','PR','DO','ISS','OAR')
                    <!---added by lung 20130104--->
                	and qty <> 0
                	<!--- --->
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
                    
                    	
                        <!--- added by lung--->
                        <cfloop query="getstockin" startrow="#getstockin.currentrow#" endrow="#getstockin.currentrow#">
                        <cfif getstockin.type eq "CN">
                        <cftry>
                        <!---get oldest item profile qty cost--->
                         <cfquery name="getcnin" datasource="#dts#">
                         	select * from (
                         	select 
							'' as type,'' as refno,'' as itemcount,
							ifnull(qtybf,0) as qty,
							ifnull(qtybf*ucost,0) as amt,
                            0 as it_cos,
                            thisaccdate as trdatetime,
							thisaccdate as wos_date 
							from icitem_last_year 
							where itemno='#itemno#'
							order by thisaccdate
                            limit 1
                            )as a
                         
                         	UNION ALL
                            select 
							type,refno,itemcount,
							ifnull(qty,0) as qty,
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
                            it_cos,
                            trdatetime,
							wos_date 
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime < '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','OAI')
							order by wos_date desc,trdatetime desc,refno,itemcount desc
                            </cfquery>
                            <cfcatch>
                            <cfquery name="getcnin" datasource="#dts#">
                            select 
							type,
							ifnull(qty,0) as qty,
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
                            it_cos,
                            trdatetime,
							wos_date 
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime < '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','OAI')
							order by wos_date desc,trdatetime desc,refno,itemcount desc
                            </cfquery>
                            </cfcatch>
                            </cftry>
                            
                            <cfquery name="getremainqty" datasource="#dts#">
                            select a.qtybf+ifnull(b.qtyin,0)-ifnull(c.qtyout,0) as bal from icitem as a
                            left join (
                            select 
							sum(qty) as qtyin,itemno
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime <= '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','CN','OAI')
                            and fperiod<>'99'
                            )as b on a.itemno=b.itemno
                            left join (
                            select 
                            sum(qty) as qtyout,itemno
                            from ictran 
                            where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime <= '#getstockin.trdatetime#'
                            and fperiod<>'99'
                            and (void = '' or void is null) and (toinv='' or toinv is null) 
                            and type in ('INV','CS','DN','PR','DO','ISS','OAR')

                            )as c on a.itemno=c.itemno
                            where a.itemno='#itemno#'
                            </cfquery>
                            
                            
                            	<cfset inqty = getremainqty.bal>
                                <cfset remainqty1=getremainqty.bal>
                                <cfset remainamt1=0>
                                <cfloop query="getcnin">
                                <cfif remainqty1 neq 0>
                                <cfif getcnin.qty lte remainqty1>
                                    <cfset remainamt1=remainamt1+getcnin.amt>
                                	<cfset remainqty1=remainqty1-getcnin.qty>   
                                <cfelse>
                                    <cfset remainamt1=remainamt1+(remainqty1*(getcnin.amt/getcnin.qty))>
                                	<cfset remainqty1=0>
                                </cfif>
                                </cfif>
                                </cfloop>
                                <cfset inamt = remainamt1>
                           
                            <cfelse>
                            <cfloop query="getstockin" startrow="#count#" endrow="#count#">
							<cfif getstockin.type eq "CN">
                            <!---
								<cfset inqty = inqty>
								<cfset inamt = inamt>
                            --->
							<cfelse>
								<cfset inqty = getstockin.qty>
								<cfset inamt = getstockin.amt>
							</cfif>		
							</cfloop>
                        </cfif>
                        </cfloop>
                        <!--- --->
                        
						
						
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
                        
                        
                        <!--- added by lung--->
                        <cfloop query="getstockin" startrow="#getstockin.currentrow#" endrow="#getstockin.currentrow#">
                        <cfif getstockin.type eq "CN">
                        <cftry>
                         <cfquery name="getcnin" datasource="#dts#">
                         	select * from (
                         	select 
							'' as type,'' as refno,'' as itemcount,
							ifnull(qtybf,0) as qty,
							ifnull(qtybf*ucost,0) as amt,
                            0 as it_cos,
                            thisaccdate as trdatetime,
							thisaccdate as wos_date 
							from icitem_last_year 
							where itemno='#itemno#'
							order by thisaccdate
                            limit 1
                            )as a
                         
                         	UNION ALL
                            
                            select 
							type,refno,itemcount,
							ifnull(qty,0) as qty,
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
                            it_cos,
                            trdatetime,
							wos_date 
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime < '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','OAI')
							order by wos_date desc,trdatetime desc,refno,itemcount desc
                            </cfquery>

                        <cfcatch>
                         <cfquery name="getcnin" datasource="#dts#">
                            select 
							type,
							ifnull(qty,0) as qty,
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
                            it_cos,
                            trdatetime,
							wos_date 
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime < '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','OAI')
							order by wos_date desc,trdatetime desc,refno,itemcount desc
                            </cfquery>
                            </cfcatch>
                            </cftry>
                            <cfquery name="getremainqty" datasource="#dts#">
                            select a.qtybf+ifnull(b.qtyin,0)-ifnull(c.qtyout,0) as bal from icitem as a
                            left join (
                            select 
							sum(qty) as qtyin,itemno
							from ictran 
							where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime <= '#getstockin.trdatetime#'
							and (void = '' or void is null) 
							and type in ('RC','CN','OAI')
                            and fperiod<>'99'
                            )as b on a.itemno=b.itemno
                            left join (
                            select 
                            sum(qty) as qtyout,itemno
                            from ictran 
                            where itemno='#itemno#'
                            and wos_date <= '#dateformat(getstockin.wos_date,'yyyy-mm-dd')#'
                            and trdatetime <= '#getstockin.trdatetime#'
                            and fperiod<>'99'
                            and (void = '' or void is null) and (toinv='' or toinv is null) 
                            and type in ('INV','CS','DN','PR','DO','ISS','OAR')

                            )as c on a.itemno=c.itemno
                            where a.itemno='#itemno#'
                            </cfquery>
                            
                            
                            	<cfset inqty = getremainqty.bal>
                                <cfset remainqty1=getremainqty.bal>
                                <cfset remainamt1=0>
                                <cfloop query="getcnin">
                                <cfif remainqty1 neq 0>
                                <cfif getcnin.qty lte remainqty1>
                                    <cfset remainamt1=remainamt1+getcnin.amt>
                                	<cfset remainqty1=remainqty1-getcnin.qty>   
                                <cfelse>
                                	<cfif val(getcnin.qty) EQ 0>
                                    	<cfset quantity = 1>
                                    <cfelse>
                                    	<cfset quantity = val(getcnin.qty)>    
                                    </cfif>
                                    <cfset remainamt1=remainamt1+(remainqty1*(val(getcnin.amt)/val(quantity)))>
                                	<cfset remainqty1=0>
                                </cfif>
                                </cfif>
                                </cfloop>
                                <cfset inamt = remainamt1>
                             
                            <cfelse>
                            <cfloop query="getstockin" startrow="#count#" endrow="#count#">
							<cfif getstockin.type eq "CN">
                            <!---
								<cfset inqty = inqty>
								<cfset inamt = inamt>
                            --->
							<cfelse>
								<cfset inqty = getstockin.qty>
								<cfset inamt = getstockin.amt>
							</cfif>		
							</cfloop>
                        </cfif>
                        </cfloop>
                        <!--- --->
                        
                        
                        
						
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
                        and itemcount='#itemcount#'
                        </cfquery>
                        <cfif checkcn10.invlinklist neq ''>
                        
                        <cfquery name="getinvitcos" datasource="#dts#">
                        select it_cos/qty as it_cos from ictran where type='INV'
                        and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkcn10.invlinklist#">
                        and itemcount = '#checkcn10.invcnitem#'
                        </cfquery>
                        <cfquery name="updaterecord1" datasource="#dts#">
							update ictran set 
							it_cos='#val(getinvitcos.it_cos)*val(qty)#'
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount#';
						</cfquery>
                        
                        <cfelse>
                        <!---new to solved cn cost problem 20150206--->
                        <cfquery name="getcncostfromlastrc" datasource="#dts#">
								select it_cos/qty as cost from ictran where 
                                type in ("INV","CS")
                                and wos_date<="#wos_date#"
								and itemno='#itemno#'
                                and qty<>0
                                order by wos_date desc limit 1
						</cfquery>
                        
                        <cfset cost=val(getcncostfromlastrc.cost)*val(cnqty)>
						<!--- --->
						<cfif cost eq 0>
                        <cfquery name="getcost" datasource="#dts#">
                        select ucost from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        </cfquery>
                        <cfset cost=getcost.ucost*cnqty>
                        </cfif>
                        
						

						<cfquery name="updaterecord1" datasource="#arguments.dts#">
							update ictran set 
                            <cfif getgeneral.CNbaseonprice eq '1'>
                            it_cos=amt
                            <cfelse>
							it_cos='#cost#'
                            </cfif> 
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount#';
						</cfquery>
                        </cfif>

                        
					<cfelse>
                    	
                    
						<cfset inqty = cnqty>
						<cfset inamt = cnamt>
                        <cfif not isdefined('cost')>
                        <cfquery name="getcost" datasource="#dts#">
                        select ucost from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        </cfquery>
                        <cfset cost=getcost.ucost*inqty>
                        </cfif>
                        
                        <cfif cost eq 0>
                        <cfquery name="getcost" datasource="#dts#">
                        select ucost from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        </cfquery>
                        <cfset cost=getcost.ucost*inqty>
                        </cfif>
                        
                        
                        <cfquery name="checkcn10" datasource="#dts#">
                        SELECT invlinklist,invcnitem FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and refno='#refno#' 
                        and itemcount='#itemcount#'
                        </cfquery>
                        <cfif checkcn10.invlinklist neq ''>
                        
                        <cfquery name="getinvitcos" datasource="#dts#">
                        select it_cos/qty as it_cos from ictran where type='INV'
                        and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkcn10.invlinklist#">
                        and itemcount = '#checkcn10.invcnitem#'
                        </cfquery>
                        <cfquery name="updaterecord1" datasource="#dts#">
							update ictran set 
							it_cos='#val(getinvitcos.it_cos)*val(qty)#'
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount#';
						</cfquery>
                        <cfelse>
                        
                        <!---new to solved cn cost problem 20150206--->
                        <cfquery name="getcncostfromlastrc" datasource="#dts#">
								select it_cos/qty as cost from ictran where 
                                type in ("INV","CS")
                                and wos_date<="#wos_date#"
								and itemno='#itemno#'
                                and qty<>0
                                order by wos_date desc limit 1
						</cfquery>
                        
                        <cfset cost=val(getcncostfromlastrc.cost)*val(cnqty)>
						<!--- --->
                        
						<cfquery name="updaterecord2" datasource="#arguments.dts#">
							update ictran 
							set 
                            <cfif getgeneral.CNbaseonprice eq '1'>
                            it_cos=amt
                            <cfelse>
							it_cos=#cost#
                            </cfif> 
                            
							where type='CN' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount#';
						</cfquery>
                        </cfif>
					</cfif>
				</cfif>
			</cfloop>
			
			<cfquery name="getstockin" datasource="#arguments.dts#">
				<cfif getitem.qtybf neq 0 and check_bfcost.recordcount neq 0>
					select 
					type,
					refno,
					itemcount,
					counter,
					qty,
					amt,
					it_cos,
					wos_date,
                    dono
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
								'#getgeneral.lastaccyear#' as wos_date,
                                '' as dono
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
                            <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                            <cfelse>
							ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                            </cfif>
							it_cos,
							wos_date,
                            dono
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
                    <cfif isdefined ('form.cbincludecharge')>
                            ifnull(if(taxincl="T",amt-taxamt,amt)+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7,0) as amt,
                    <cfelse>
					ifnull(if(taxincl="T",amt-taxamt,amt),0) as amt,
                    </cfif>
					it_cos,
                    dono
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
			<!--- <cfset suminqty = getitem.qtybf> --->
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
					<cfset itemcount = getstockout.itemcount>
					<cfset otype = getstockout.type>
					<cfset outqty = getstockout.qty>

					<cfif suminqty gte outqty><!---bf qty eq gte stockout qty--->
						<cfset suminqty = suminqty - outqty>
                        <cfif otype eq "INV">
						<cfquery name="checkcn" datasource="#dts#">
                        SELECT qty,if(taxincl="T",amt-taxamt,amt) as amt FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and invlinklist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                        and invcnitem = '#itemcount#'
                        </cfquery>   
                        </cfif>
						<cfquery name="updaterecord" datasource="#arguments.dts#">
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
                            ,pono='#getstockin.dono#'
							where type='#otype#' 
							and refno='#refno#' 
							and itemno='#itemno#' 
							and itemcount='#itemcount#';
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
                        SELECT qty,if(taxincl="T",amt-taxamt,amt) as amt FROM ictran WHERE 
                        type = "CN"
                        and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">
                        and invlinklist = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                        and invcnitem = '#itemcount#'
                        </cfquery>   
                        </cfif>
                        
					<cfquery name="updaterecord" datasource="#arguments.dts#">
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
                         ,pono='#getstockin.dono#'
						where type='#otype#' 
						and refno='#refno#' 
						and itemno='#itemno#' 
						and itemcount='#itemcount#';
					</cfquery>
					<cfbreak>
				</cfloop><!---Next Stockout--->
			</cfloop>
		</cfloop><!---Next Item--->
		
		<cfreturn 0>
	</cffunction>
</cfcomponent>	