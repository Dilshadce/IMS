<cfcomponent>
	<cffunction name="aging6monthpro" returntype="string">
		<cfargument name="dts" required="yes">
        <cfargument name="tf_fperiod" required="no">
        <cfargument name="nofrom" required="no">
        <cfargument name="noto" required="no">
        <cfargument name="area" required="no">
        <cfargument name="agent" required="no">
		<cfargument name="agingtype" required="no">
		<cfargument name="fcurrbills1" required="no">
        
        <cftry>
        <cfif agingtype eq "Debtors">
        <cfset arapTBL = "arcust">
        <cfset postTBL = "arpost">
        <cfset payTBL = "arpay">
        <cfelse>
        <cfset arapTBL = "apvend">
        <cfset postTBL = "appost">
        <cfset payTBL = "appay">
		</cfif>
        
        <cfquery name="getgsetup" datasource="#dts#">
            SELECT period,LastAccYear from gsetup
        </cfquery>
 		
        <cfif tf_fperiod eq "">
            <cfset period = getgsetup.period>
        <cfelse>
            <cfset period = tf_fperiod>
        </cfif>
        
        <cfset pccurr = DateAdd('m', #period#, "#getgsetup.LastAccYear#")>
        <cfset pdmont = dateformat(pccurr,"mm")>
        <cfset pdmont2 = dateformat(pccurr,"dd-mm-yyyy")>
        <cfset pyear = #dateformat(pdmont2,"yyyy")#>
        <Cfset pall = dateformat(pccurr,"yyyy-mm-dd")>
        <cfset loopnumfrom = period - 11>
        
        <cfset currperioddate = dateadd("m", period, getgsetup.lastaccyear)>
        
        <cfquery name="getaccheader" datasource="#dts#">
            SELECT DISTINCT a.accno,b.NAME,b.NAME2,b.add1,b.add2,b.add3,b.add4,b.contact,b.phone,if(b.crlimit = 0,'-',b.crlimit) as crlimit,b.term
            FROM #postTBL# AS a, #arapTBL# AS b
            WHERE a.accno = b.custno
            <cfif nofrom neq "">
                AND a.accno >= '#nofrom#'
            </cfif>
            <cfif noto neq "">
                AND a.accno <= '#noto#'
            </cfif>
            <cfif area neq "">
                AND b.area = '#area#'
            </cfif>
            <cfif agent neq "">
                AND b.agent = '#agent#'
            </cfif>
            ORDER BY accno
        </cfquery>
        
        <cfset fivemthsaging=0>
        <cfset balance=0>
        <cfset totalof5 = 0>
		<cfset totalof4 = 0>
		<cfset totalof3 = 0>
		<cfset totalof2 = 0>
		<cfset totalof1 = 0>
		<cfset totalof0 = 0>
        <cfset totalmtdpay = 0>
        <cfset totalpdc = 0>
        <cfset totalmidsales = 0>
        <cfset totalytdsales = 0>
        <cfset totalbalance =  0 >
        
        <cfquery name="truncatetbl" datasource="#dts#">
        truncate aging6
        </cfquery>
        
        <cfloop query="getaccheader">
        
            <cfquery name="getgldata" datasource="#dts#">
                select lastybal from gldata where accno='#getaccheader.accno#'
            </cfquery>
            
            <cfquery name="getarcust" datasource="#dts#">
                select contact,daddr1,daddr2,daddr3,area,agent from #arapTBL# where custno='#getaccheader.accno#'
            </cfquery>
            
            <cfquery name="getacctotal" datasource="#dts#">
                SELECT DISTINCT a.accno,b.mtdpay,c.mtdsales,d.ytdsales,e.balance
                FROM #postTBL# AS a
                
                LEFT JOIN
                (SELECT accno, SUM(a.creditamt) AS mtdpay
                FROM #postTBL# AS a
                WHERE a.fperiod = '#period#'
                
                AND a.accext = ""
                GROUP by a.accno)AS b
                ON b.accno = a.accno
                
                LEFT JOIN
                (SELECT accno,SUM(debitamt) AS mtdsales
                FROM #postTBL#
                WHERE fperiod = '#period#'
                and araptype = 'I'
                AND accext = ""
                GROUP by accno)AS c
                ON c.accno = a.accno
                
                LEFT JOIN
                (SELECT accno,SUM(debitamt) AS ytdsales
                FROM #postTBL#
                WHERE fperiod <= '#period#'
                and araptype = 'I'
                AND accext = ""
                GROUP by accno) AS d
                ON d.accno = a.accno
                
                LEFT JOIN
                    (SELECT accno,SUM(COALESCE(debitamt,0)-COALESCE(creditamt,0))+#val(getgldata.lastybal)# AS balance
                    FROM #postTBL# AS z
                    WHERE accext = ""
                        AND paystatus = ""
                        AND fperiod <= '#period#'
                    GROUP by accno
                    ) AS e
                ON e.accno = a.accno
                
                WHERE a.accno = '#getaccheader.accno#'
            </cfquery>
            
            <cfquery name="getlastpay" datasource="#dts#">
            SELECT kdate from #payTBL# where  kdate < '#pall#' and accext = "" and custno = '#getaccheader.accno#'
            order by kdate DESC
            </cfquery>
            
			<cfset j = 0>
			<cfset lastSelectedDate = dateformat(Createdate(year(pall),month(pall),daysinmonth(pall)), "yyyy-mm-dd")>
			<cfloop from="0" to="5" index="i">
	
				<cfset lastAccYear_monthBegin = dateformat(dateadd('m',-i,Createdate(year(pall),month(pall),01)), "yyyy-mm-dd")>
				<cfset lastAccYear_monthEnd = dateformat(dateadd("d",-1,dateadd("m",-i+1,Createdate(year(pall),month(pall),01))), "yyyy-mm-dd")>
	
				<cfquery datasource="#dts#" name="getaging#i#">
					<cfif agingtype eq "Debtors">
					select sum(debitamt)-(sum(creditamt)-sum(invamt2))-sum(invamt1) as aging from (
					<cfelse>
					select sum(creditamt)-(sum(debitamt)-sum(invamt2)*-1)-sum(invamt1)*-1 as aging from (
					</cfif>
						select a.debitamt, a.creditamt, coalesce(b.invamt1, 0) as invamt1, coalesce(c.invamt2, 0) as invamt2 from (
							select accno, reference, refext, accext, araptype, debitamt, creditamt, post_id from #postTBL#
							where accno = '#getaccheader.accno#'
							<cfif i eq 5>
							and date <='#lastAccYear_monthEnd#'
							<cfelse>
							and date between '#lastAccYear_monthBegin#' and '#lastAccYear_monthEnd#'
							</cfif>
							<cfif arguments.fcurrbills1 eq 1>
							and accext = 'F'
							<cfelse>
							and accext <> 'F'
							</cfif>
						) as a left join (
							select custno, billno1, billnoext1, billtype, sum(invamt1) as invamt1, billno_postid from (
								SELECT a.accno, a.reference, a.refext, a.araptype, b.billno_postid, 
								b.custno, b.billno AS billno1, b.billnoext AS billnoext1, b.billtype, coalesce(b.invamt1, 0) as invamt1 FROM (
									SELECT accno, reference, refext, araptype, accext, debitamt, creditamt, post_id FROM #postTBL#
									WHERE accno = '#getaccheader.accno#'
									<cfif i eq 5>
									and date <='#lastAccYear_monthEnd#'
									<cfelse>
									and date between '#lastAccYear_monthBegin#' and '#lastAccYear_monthEnd#'
									</cfif>
									<cfif arguments.fcurrbills1 eq 1>
									and accext = 'F'
									<cfelse>
									and accext <> 'F'
									</cfif>
								) AS a LEFT JOIN (
									SELECT custno, billno, billnoext, billtype, accext, invamt AS invamt1, billno_postid FROM #payTBL# WHERE
									kdate <= '#lastSelectedDate#' and billdate <= '#lastSelectedDate#'
									<cfif arguments.fcurrbills1 eq 1>
									and accext = 'F'
									<cfelse>
									and accext <> 'F'
									</cfif>
								) AS b
								ON a.accno=b.custno AND a.reference=b.billno AND a.accext=b.accext AND a.refext=b.billnoext
								AND IF(b.billno_postid !=0, b.billno_postid=a.post_id, 0=0)
							) as a group by custno, billno1, billnoext1, billtype
						) as b
						on a.accno=b.custno and a.reference=b.billno1 and a.refext=b.billnoext1
						AND IF(b.billno_postid !=0, b.billno_postid=a.post_id, 0=0)
						left join (
							select custno, refno1, refext1, type, sum(invamt2) as invamt2, refno_postid from (
								SELECT a.accno, a.reference, a.refext, a.araptype, c.refno_postid,
								c.custno, c.refno AS refno1, c.refext AS refext1, c.type, coalesce(c.invamt2, 0) as invamt2 FROM (
									SELECT accno, reference, refext, araptype, accext, debitamt, creditamt, post_id FROM #postTBL#
									WHERE accno = '#getaccheader.accno#'
									<cfif i eq 5>
									and date <='#lastAccYear_monthEnd#'
									<cfelse>
									and date between '#lastAccYear_monthBegin#' and '#lastAccYear_monthEnd#'
									</cfif>
									<cfif arguments.fcurrbills1 eq 1>
									and accext = 'F'
									<cfelse>
									and accext <> 'F'
									</cfif>
								) AS a LEFT JOIN (
									SELECT custno, refno, refext, TYPE, accext, invamt AS invamt2, refno_postid FROM #payTBL# WHERE
									kdate <= '#lastSelectedDate#' and billdate <= '#lastSelectedDate#'
									<cfif arguments.fcurrbills1 eq 1>
									and accext = 'F'
									<cfelse>
									and accext <> 'F'
									</cfif>
								) AS c
								ON a.accno=c.custno AND a.reference=c.refno AND a.accext=c.accext AND a.refext=c.refext
								AND IF(c.refno_postid !=0, c.refno_postid=a.post_id, 0=0)
							) as a group by custno, refno1, refext1, type
						) as c
						on a.accno=c.custno and a.reference=c.refno1 and a.refext=c.refext1
						AND IF(c.refno_postid !=0, c.refno_postid=a.post_id, 0=0)
					) as a
				</cfquery>
			</cfloop>
		
            <!--- <cfquery datasource="#dts#" name="getaging">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod='#period#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod='#period#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod='#period#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery>
            <cfquery datasource="#dts#" name="getaging1">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod='#period-1#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod='#period-1#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod='#period-1#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery>
            <cfquery datasource="#dts#" name="getaging2">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod='#period-2#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod='#period-2#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod='#period-2#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery>
            <cfquery datasource="#dts#" name="getaging3">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod='#period-3#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod='#period-3#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod='#period-3#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery>
            <cfquery datasource="#dts#" name="getaging4">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod='#period-4#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod='#period-4#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod='#period-4#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery>
            <cfquery datasource="#dts#" name="getaging5">
                select Round(amt-invamt1+invamt2,2) as aging from(
                select sum(COALESCE(b.invamt,0))as invamt1 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.billno and a.refext=b.billnoext
                where fperiod<='#period-5#' and a.accext = "" and accno = '#getaccheader.accno#')as a ,
               (select sum(COALESCE(b.invamt,0)) as invamt2 from #postTBL# as a left join 
                (select * from #payTBL# where billdate < '#pall#' and custno='#getaccheader.accno#' and accext = "") as b on a.reference =b.refno and a.refext=b.refext
                where fperiod<='#period-5#' and a.accext = "" and accno = '#getaccheader.accno#')as b,
               (select sum(COALESCE(a.debitamt,0))-sum(COALESCE(a.creditamt,0)) as amt from #postTBL# as a 
                where fperiod<='#period-5#' and a.accext = "" and accno = '#getaccheader.accno#')as c
            </cfquery> --->
            
			<cfset totalof5 = totalof5 + val(getaging5.aging)>
			<cfset totalof4 = totalof4 + val(getaging4.aging)>
			<cfset totalof3 = totalof3 + val(getaging3.aging)>
            <cfset totalof2 = totalof2 + val(getaging2.aging)>
			<cfset totalof1 = totalof1 + val(getaging1.aging)>
			<cfset totalof0 = totalof0 + val(getaging0.aging)>
            <cfset totalbalance =  val(getaging5.aging) +val(getaging4.aging) +val(getaging3.aging) +val(getaging2.aging) +val(getaging1.aging) +val(getaging0.aging) >
            <cfset totalmtdpay = totalmtdpay + val(getacctotal.mtdpay)>
            <cfset totalpdc = totalpdc + 0>
            <cfset totalmidsales = totalmidsales + val(getacctotal.mtdsales)>
            <cfset totalytdsales = totalytdsales + val(getacctotal.ytdsales)>
			
            
            
            <cfquery name="insertTemp" datasource="#dts#">
            INSERT INTO
            aging6
            (
            arapno,
            name,
            name2,
            month5,
            month4,
            month3,
            month2,
            month1,
            current,
            balance,
            pdc,
            mtdpay,
            mtdsales,
            ytdsales,
            telephone,
            lastpay,
            crlimit,
            terms,
            contact,
            address,
            area,
            agent
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.accno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.name#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.name2#">,
            <cfset aging5 = numberformat(getaging5.aging, ",.__")>
			<cfif getaging5.aging eq 0>
			<cfset aging5 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging5#">,
            <cfset aging4 = numberformat(getaging4.aging, ",.__")>
			<cfif getaging4.aging eq 0>
			<cfset aging4 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging4#">,
            <cfset aging3 = numberformat(getaging3.aging, ",.__")>
			<cfif getaging3.aging eq 0>
			<cfset aging3 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging3#">,
            <cfset aging2 = numberformat(getaging2.aging, ",.__")>
			<cfif getaging2.aging eq 0>
			<cfset aging2 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging2#">,
            <cfset aging1 = numberformat(getaging1.aging, ",.__")>
			<cfif getaging1.aging eq 0>
			<cfset aging1 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging1#">,
            <cfset aging = numberformat(getaging0.aging, ",.__")>
			<cfif getaging0.aging eq 0>
			<cfset aging = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(round(totalbalance*1000)/1000, ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="0.00">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(getacctotal.mtdpay), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(getacctotal.mtdsales), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(getacctotal.ytdsales), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.phone#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(getlastpay.kdate, "YYYY-MM-DD")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.crlimit#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaccheader.term#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarcust.contact#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarcust.daddr1# #getarcust.daddr2# #getarcust.daddr3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarcust.area#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarcust.agent#">
            )
            
            </cfquery>
            
            </cfloop>
            <cfset overalltotal = totalof5 +totalof4 +totalof3 +totalof2 +totalof1 +totalof0>
            <cfquery name="insertTotal" datasource="#dts#">
            INSERT INTO
            aging6
            (
            arapno,
            name,
            name2,
            month5,
            month4,
            month3,
            month2,
            month1,
            current,
            balance,
            pdc,
            mtdpay,
            mtdsales,
            ytdsales,
            telephone,
            lastpay,
            crlimit,
            terms,
            contact,
            address,
            area,
            agent
            )
            VALUES
            (
            "",
            "",
            "",
            <cfset aging5 = numberformat(totalof5, ",.__")>
			<cfif totalof5 eq 0>
			<cfset aging5 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging5#">,
            <cfset aging4 = numberformat(totalof4, ",.__")>
			<cfif totalof4 eq 0>
			<cfset aging4 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging4#">,
            <cfset aging3 = numberformat(totalof3, ",.__")>
			<cfif totalof3 eq 0>
			<cfset aging3 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging3#">,
            <cfset aging2 = numberformat(totalof2, ",.__")>
			<cfif totalof2 eq 0>
			<cfset aging2 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging2#">,
            <cfset aging1 = numberformat(totalof1, ",.__")>
			<cfif totalof1 eq 0>
			<cfset aging1 = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging1#">,
            <cfset aging = numberformat(totalof0, ",.__")>
			<cfif totalof0 eq 0>
			<cfset aging = "-">
			</cfif>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#aging#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(round(overalltotal*1000)/1000, ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalpdc), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalmtdpay), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalmidsales), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#numberformat(val(totalytdsales), ",.__")#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="">
            )
            </cfquery>
            
            
            <cfset result = "SUCCESS" >
            <cfcatch type="any">
            <cfset result = "FAIL" >
            </cfcatch>
            
            </cftry>
            
            <cfreturn result >
	</cffunction>
    
    <cffunction name="getAging6" returntype="query">
    <cfargument name="dts" required="yes">
    <cfquery name="getALLAging" datasource="#dts#">
    SELECT * FROM aging6
    </cfquery>
    
    <cfreturn getAllAging>
    
    </cffunction>
</cfcomponent>	