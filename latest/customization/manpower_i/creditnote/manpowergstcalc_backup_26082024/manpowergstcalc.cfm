<cfset form.taxcode="SR">

<!--- GST percent (taxper)--->

<cfset form.taxper = val(gstper)>
    
<cfset zerotaxmonth = "Jun,Jul,Aug">
        
<cfset zerotaxmyear = 2018>

<cfquery name="gettaxprofile" datasource="#dts#">
SELECT arrem5,arrem7 FROM arcust WHERE custno = "#form.custno#"
</cfquery>

<cfif lcase(tran) eq 'dn' and form.newcustno neq ''>
    <cfquery name="gettaxprofile" datasource="#dts#">
    SELECT arrem5,arrem7 FROM arcust WHERE custno = "#form.newcustno#"
    </cfquery>
</cfif>
    
<cfquery name="getbrem3" datasource="#dts#">
    SELECT refno2,brem3 FROM ictrantempcn 
    WHERE type='#tran#'
    AND uuid="#uuid#"
    LIMIT 1
</cfquery>

<cfif getbrem3.refno2 neq ''>
    <cfquery name="getdate" datasource="#dts#">
       SELECT wos_date FROM artran 
        WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbrem3.refno2#">
    </cfquery>  
</cfif>
     
<cfif gettaxprofile.arrem5 neq "">
    
    <cfset monthsample1 = ["January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"]>

    <cfset monthsample2 = ["Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"]>
        
    <cfif trim(gettaxprofile.arrem7) eq "1" and getbrem3.brem3 neq ''>
                    
        <cfset servperiod = right(getbrem3.brem3,4)>

        <cfif servperiod gt 2018>
        
            <cfset gettaxprofile.arrem5 = "GSTITEMIZED">
            
        <cfelseif servperiod eq 2018>
            
            <cfset tempdate = ReReplaceNoCase(trim(listlast(getbrem3.brem3,'-')),'[^a-zA-Z]','','ALL')>

            <cfset servmonth = arrayFindNoCase(monthsample1,tempdate)>

            <cfif servmonth eq 0>
                <cfset servmonth = arrayFindNoCase(monthsample2,tempdate)>
            </cfif>

            <cfif servmonth gte 9>
                <cfset gettaxprofile.arrem5 = "GSTITEMIZED">
            </cfif>

        </cfif>
                
    </cfif>
               
    <cfif lcase(tran) eq 'dn'> 
        <cfquery name="getdate2" datasource="#dts#">
            SELECT wos_date FROM artran 
            WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
        </cfquery>  

        <cfif trim(gettaxprofile.arrem5) neq "NOTAX" and trim(gettaxprofile.arrem5) neq "GSTBILLRATE" and datediff('d',lsdateformat("31/08/2018",'YYYY-MM-DD', 'en_AU'),lsdateformat((getdate2.wos_date),'YYYY-MM-DD', 'en_AU')) gt 0>
             <cfset gettaxprofile.arrem5 = "GSTITEMIZED">
        </cfif>        
    </cfif>
                
    <cfquery name="gettaxmethod" datasource="#dts#">
     SELECT * FROM taxmethod WHERE taxname = "#gettaxprofile.arrem5#"
     </cfquery>
    
     <cfif gettaxmethod.billtaxable eq "Y">
                    
            <cfquery datasource='#dts#' name="updateictran">
                Update ictrantempcn 
                set 
                taxpec1=#form.taxper#,
                note_a="SR",
                <cfif lcase(tran) eq 'cn'>
                taxamt=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1),
                taxamt_bil=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1)
                <cfelse>
                taxamt=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2),
                taxamt_bil=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2)
                </cfif>                    
                where type='#tran#'
                and uuid="#uuid#"
            </cfquery>
                
            <cfloop index="a" list="#zerotaxmonth#">
                
                <cfquery datasource='#dts#' name="checkzerotaxmonth">
                    select * from ictrantempcn 
                    where type='#tran#'
                    and uuid="#uuid#"
                    and right(brem3,8)='#a# #zerotaxmyear#'
                </cfquery>
                
                
                <cfif checkzerotaxmonth.recordcount neq 0>
                    <cfquery datasource='#dts#' name="updateictran">
                        Update ictrantempcn 
                        set 
                        taxpec1=0.00,
                        taxamt = 0.00,
                        taxamt_bil= 0.00
                        where type='#tran#'
                        and uuid="#uuid#"
                        and right(brem3,8)='#a# #zerotaxmyear#'
                    </cfquery>
                </cfif>
                    
            </cfloop>
                
            <cfif getbrem3.recordcount neq 0>
                <cfif getbrem3.refno2 neq ''>
                    <cfif getdate.recordcount neq 0>
                        <cfif year(getdate.wos_date) eq 2018>
                            <cfif month(getdate.wos_date) gte 6 and month(getdate.wos_date) lte 8>
                                <cfquery datasource='#dts#' name="updateictran">
                                    Update ictrantempcn 
                                    set 
                                    taxpec1=0.00,
                                    taxamt = 0.00,
                                    taxamt_bil= 0.00
                                    where type='#tran#'
                                    and uuid="#uuid#"
                                </cfquery>
                            </cfif>
                        </cfif>
                    </cfif>
                </cfif>
            </cfif>
     <cfelse>

    			<cfquery datasource='#dts#' name="updateictran">
					Update ictrantempcn 
					set 
                    taxpec1=0,
                    note_a="OS",
                    taxamt=0,
                    taxamt_bil=0
					where type='#tran#'
                    and uuid="#uuid#"
		  		</cfquery>
         
	 </cfif>
     
     <cfif gettaxmethod.adminfeetaxable eq "Y">
            <cfquery datasource='#dts#' name="updateictran">
                Update ictrantempcn 
                set 
                taxpec1=6,
                note_a="SR",
                <cfif lcase(tran) eq 'cn'>
                taxamt=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1),
                taxamt_bil=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1)
                <cfelse>
                taxamt=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2),
                taxamt_bil=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2)
                </cfif>
                where  type='#tran#'
                and itemno = "adminfee"
                and uuid ="#uuid#"
            </cfquery>
                    
            <cfloop index="a" list="#zerotaxmonth#">
                
                <cfquery datasource='#dts#' name="checkzerotaxmonth">
                    select * from ictrantempcn 
                    where type='#tran#'
                    and uuid="#uuid#"
                    and itemno = "adminfee"
                    and right(brem3,8)='#a# #zerotaxmyear#'
                </cfquery>
                
                
                <cfif checkzerotaxmonth.recordcount neq 0>
                    <cfquery datasource='#dts#' name="updateictran">
                        Update ictrantempcn 
                        set 
                        taxpec1=0.00,
                        taxamt = 0.00,
                        taxamt_bil= 0.00
                        where type='#tran#'
                        and uuid="#uuid#"
                        and itemno = "adminfee"
                        and right(brem3,8)='#a# #zerotaxmyear#'
                    </cfquery>
                </cfif>
                    
            </cfloop>
                
            <cfif getbrem3.recordcount neq 0>
                <cfif getbrem3.refno2 neq ''>
                    <cfif getdate.recordcount neq 0>
                        <cfif year(getdate.wos_date) eq 2018>
                            <cfif month(getdate.wos_date) gte 6 and month(getdate.wos_date) lte 8>
                                <cfquery datasource='#dts#' name="updateictran">
                                    Update ictrantempcn 
                                    set 
                                    taxpec1=0.00,
                                    taxamt = 0.00,
                                    taxamt_bil= 0.00
                                    where type='#tran#'
                                    and uuid="#uuid#"
                                    and itemno = "adminfee"
                                </cfquery>
                            </cfif>
                        </cfif>
                    </cfif>
                </cfif>
            </cfif>
     <cfelse>
     		<cfquery datasource='#dts#' name="updateictran">
					Update ictrantempcn 
					set 
                    taxpec1=0,
                    note_a="OS",
                    taxamt=0,
                    taxamt_bil=0
					where  type='#tran#' and itemno = "adminfee"
                    and uuid= "#uuid#"
		  		</cfquery>
	 </cfif>
     
     <cfif gettaxmethod.taxableitem eq "Y">
     
         <cfif lcase(tran) eq 'dn'>
            <cfquery name="checkadminfee" datasource="#dts#">
                SELECT * FROM ictrantempcn 
                where type='#tran#'
                and uuid="#uuid#"
                AND itemno = "adminfee"
            </cfquery> 
        </cfif>
         
        <cfquery name="gettaxitem" datasource="#dts#">
        SELECT taxitemid FROM taxmethoditem WHERE taxmethodid = "#gettaxmethod.id#"
            <cfif lcase(tran) eq 'dn'>
            <!---Added by Nieo 20181122 1221, to cater new condition when there is Admin Fee charges separately for itemized tax, there should be no extra SST charges on new items added--->
            <cfif checkadminfee.recordcount neq 0>
                and id < 53
            </cfif>
            <!---Added by Nieo 20181122 1221, to cater new condition when there is Admin Fee charges separately for itemized tax, there should be no extra SST charges on new items added--->
            </cfif>
        </cfquery> 
         
        <cfquery name="gettaxServi" datasource="#dts#">
        SELECT servi FROM icservi 
        </cfquery> 

        <cfif gettaxitem.recordcount neq 0>
            <cfquery datasource='#dts#' name="updateictran">
                Update ictrantempcn 
                set 
                taxpec1=6,
                note_a="SR",
                <cfif lcase(tran) eq 'cn'>
                taxamt=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1),
                taxamt_bil=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1)
                <cfelse>
                taxamt=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2),
                taxamt_bil=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2)
                </cfif>
                where type='#tran#'
                and (
                    replace(itemno,'other - ','') in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
                    <cfif gettaxServi.recordcount neq 0>
                        or itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxServi.servi)#" separator="," list="yes">)
                    </cfif>
                    )
                and uuid= "#uuid#"
            </cfquery>
                    
            <cfloop index="a" list="#zerotaxmonth#">
                
                <cfquery datasource='#dts#' name="checkzerotaxmonth">
                    select * from ictrantempcn 
                    where type='#tran#'
                    and uuid="#uuid#"
                    and right(brem3,8)='#a# #zerotaxmyear#'
                    and trim(right(itemno,3)) in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
                </cfquery>
                
                
                <cfif checkzerotaxmonth.recordcount neq 0>
                    <cfquery datasource='#dts#' name="updateictran">
                        Update ictrantempcn 
                        set 
                        taxpec1=0.00,
                        taxamt = 0.00,
                        taxamt_bil= 0.00
                        where type='#tran#'
                        and uuid="#uuid#"
                        and right(brem3,8)='#a# #zerotaxmyear#'
                        and trim(right(itemno,3)) in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
                    </cfquery>
                </cfif>
                    
            </cfloop>
                    
            <cfif getbrem3.recordcount neq 0> 
                <cfif getbrem3.refno2 neq ''>
                    <cfif getdate.recordcount neq 0>
                        <cfif year(getdate.wos_date) eq 2018>
                            <cfif month(getdate.wos_date) gte 6 and month(getdate.wos_date) lte 8>
                                <cfquery datasource='#dts#' name="updateictran">
                                    Update ictrantempcn 
                                    set 
                                    taxpec1=0.00,
                                    taxamt = 0.00,
                                    taxamt_bil= 0.00
                                    where type='#tran#'
                                    and uuid="#uuid#"
                                    and trim(right(itemno,3)) in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettaxitem.taxitemid)#" separator="," list="yes">)
                                </cfquery>
                            </cfif>
                        </cfif>
                    </cfif>
                </cfif>
            </cfif>

        </cfif>
     </cfif>
     
<cfelse>
    <cfquery datasource='#dts#' name="updateictran">
        Update ictrantempcn 
        set 
        taxpec1=6,
        note_a="SR",
        <cfif lcase(tran) eq 'cn'>
        taxamt=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1),
        taxamt_bil=(round((round((coalesce(amt_bil,'0')*-1)+0.000001,2) * 6/100)+0.000001,2)*-1)
        <cfelse>
        taxamt=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2),
        taxamt_bil=round((round(coalesce(amt_bil,'0')+0.000001,2) * 6/100)+0.000001,2)
        </cfif>
        where  type='#tran#'
        and uuid= "#uuid#"
    </cfquery>

    <cfloop index="a" list="#zerotaxmonth#">

        <cfquery datasource='#dts#' name="checkzerotaxmonth">
            select * from ictrantempcn 
            where type='#tran#'
            and uuid="#uuid#"
            and right(brem3,8)='#a# #zerotaxmyear#'
        </cfquery>


        <cfif checkzerotaxmonth.recordcount neq 0>
            <cfquery datasource='#dts#' name="updateictran">
                Update ictrantempcn 
                set 
                taxpec1=0.00,
                taxamt = 0.00,
                taxamt_bil= 0.00
                where type='#tran#'
                and uuid="#uuid#"
                and right(brem3,8)='#a# #zerotaxmyear#'
            </cfquery>
        </cfif>

    </cfloop>
        
    <cfif getbrem3.recordcount neq 0>
        <cfif getbrem3.refno2 neq ''>
            <cfif getdate.recordcount neq 0>
                <cfif year(getdate.wos_date) eq 2018>
                    <cfif month(getdate.wos_date) gte 6 and month(getdate.wos_date) lte 8>
                        <cfquery datasource='#dts#' name="updateictran">
                            Update ictrantempcn 
                            set 
                            taxpec1=0.00,
                            taxamt = 0.00,
                            taxamt_bil= 0.00
                            where type='#tran#'
                            and uuid="#uuid#"
                        </cfquery>
                    </cfif>
                </cfif>
            </cfif>
        </cfif>
    </cfif>
</cfif>
    
    