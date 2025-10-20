     <cfset trancodestart = 0>
	 <cfif val(getgross.custsalary) neq 0> 
     <!---Salary---->
     <cfset xqty=1>
     <cfif getgross.invdesp2 eq "">
     <cfif getgross.paymenttype eq 'hr'>
     <cfset xqty=val(getgross.custsalaryhrs)>
     <cfelseif getgross.paymenttype eq 'day' >
     <cfset xqty=val(getgross.custsalaryday)>
     </cfif>
     
     <cfset xprice=val(getgross.custsalary)>
     <cfif getgross.paymenttype eq 'hr'>
     <cfset xprice=val(getgross.custusualpay)>
     <cfelseif getgross.paymenttype eq 'day' >
     <cfset xprice=val(getgross.custusualpay)>
     </cfif>
     <cfelse>
     <cfset xprice = Numberformat(getgross.custsalary,'_.__')>
     </cfif>
     
     <cfquery name="getposition" datasource="#dts#">
select position from placement where placementno='#getgross.placementno#'
</cfquery>

     <cfset trancodestart = 0>
     
     <cfif val(getgross.firstrate) neq 0 and val(getgross.secondrate) neq 0>
     
     <cfset trancodestart = trancodestart + 1>
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        (
            type,
            refno,
            itemno,
            desp,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            'Salary', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.empname# - #getposition.position# #getgross.invdesp#">, 
            '#val(xqty)#',
            #Numberformat(val(getgross.firstrate),'.__')#, 
             #Numberformat(val(getgross.firstrate),'.__')#,
            "#uuid#"
            )
   	 </cfquery>
     
     
      <cfset trancodestart = trancodestart + 1>
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        (
            type,
            refno,
            itemno,
            desp,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            'Salary', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.empname# - #getposition.position# #getgross.invdesp2#">, 
            '#val(xqty)#',
            #Numberformat(val(getgross.secondrate),'.__')#, 
             #Numberformat(val(getgross.secondrate),'.__')#,
            "#uuid#"
            )
   	 </cfquery>
     
     <cfelse>
	 <cfset trancodestart = trancodestart + 1>
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        (
            type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            'Salary', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.empname# - #getposition.position# #getgross.invdesp#">, 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.invdesp2#">, 
            '#val(xqty)#',
            #Numberformat(val(xprice),'.__')#, 
             #Numberformat(val(getgross.custsalary),'.__')#,
          	"#uuid#"
            )
   	 </cfquery>
     </cfif>
     </cfif>
     
     
     <cfloop from="1" to="10" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif evaluate('getgross.lvltype#i#') neq "" and val(evaluate('getgross.lvltotaler#i#')) neq 0 and val(evaluate('getgross.lvlerdayhr#i#')) neq 0 and val(evaluate('getgross.lvlerrate#i#')) neq 0 >
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            (
                type,
                refno,
                itemno,
                desp,
                desp2,
                qty,
                price,
                amount,
                uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                'leave#i#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.lvldesp#i#')#">, 
                '', 
                '1',
                #Numberformat(evaluate('getgross.lvltotaler#i#'),'.__')#, 
                 #Numberformat(evaluate('getgross.lvltotaler#i#'),'.__')#,
               '#uuid#'
                )
         </cfquery>
     </cfif>
     </cfloop>
     
     
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.custottotal) neq 0> 
     <cfset OTDESP = "Over Time">
     <cfloop from="1" to="4" index="i">
     <cfset trancodestart = trancodestart + 1>
     <cfif val(evaluate('getgross.custotrate#i#')) neq 0 and val(evaluate('getgross.custothour#i#')) neq 0 and val(evaluate('getgross.custot#i#')) neq 0>
     <cfset  OTDESP = OTDESP&" (#numberformat(val(evaluate('getgross.custothour#i#')),'.__')#Hrs x S$#numberformat(val(evaluate('getgross.custotrate#i#')),'.__')#) ">
     </cfif>
     </cfloop>
     <!---OT---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        (
            type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'OT', 
            '#OTDESP#', 
            '', 
            '1',
            #Numberformat(val(getgross.custottotal),'.__')#, 
             #Numberformat(val(getgross.custottotal),'.__')#,
          '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     <!--- Fixed allowance --->
     
     <cfloop from="1" to="3" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif evaluate('getgross.fixawcode#i#') neq "" and val(evaluate('getgross.fixawer#i#')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            (
                 type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                'allowancefix#i#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.fixawdesp#i#')#">, 
                '', 
                '1',
                #Numberformat(evaluate('getgross.fixawer#i#'),'.__')#, 
                 #Numberformat(evaluate('getgross.fixawer#i#'),'.__')#,
              '#uuid#'
                )
         </cfquery>
     </cfif>
     </cfloop>     
     
     
     <cfloop from="1" to="3" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif evaluate('getgross.allowance#i#') neq "" and val(evaluate('getgross.awer#i#')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                
                'allowancevar#i#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.allowancedesp#i#')#">, 
                '',
                '1',
                #Numberformat(evaluate('getgross.awer#i#'),'.__')#, 
                 #Numberformat(evaluate('getgross.awer#i#'),'.__')#,
               '#uuid#'
                )
         </cfquery>
     </cfif>
     </cfloop>
     
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.custallowancerate4) neq 0>
     <!---Allowance 4---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'allowance4', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.aw104desp#">, 
            '', 
            '1',
            #Numberformat(val(getgross.custallowancerate4),'.__')#, 
             #Numberformat(val(getgross.custallowancerate4),'.__')#,
            '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     <cfset trancodestart = trancodestart + 1>
      <cfif val(getgross.custallowancerate5) neq 0>
     <!---Allowance 5---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'allowance5', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.aw105desp#">, 
            '', 
            '1',
            #Numberformat(val(getgross.custallowancerate5),'.__')#, 
             #Numberformat(val(getgross.custallowancerate5),'.__')#,
            '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     <cfset trancodestart = trancodestart + 1>
      <cfif val(getgross.custallowancerate6) neq 0>
     <!---Allowance 6---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'allowance6', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.aw106desp#">, 
            '',
            '1',
            #Numberformat(val(getgross.custallowancerate6),'.__')#, 
             #Numberformat(val(getgross.custallowancerate6),'.__')#,
          '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.custpayback) neq 0> 
     <!---BACK PAY---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'backoverpay', 
            <cfif val(getgross.custpayback) lt 0>'Over Pay'<cfelse>'Back Pay'</cfif>, 
            '', 
            '1',
            #Numberformat(val(getgross.custpayback),'.__')#, 
             #Numberformat(val(getgross.custpayback),'.__')#,
          '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.custcpf) neq 0 or val(getgross.adminfee) neq 0 or val(getgross.custsdf) neq 0> 
     <!---CPF---->
     <cfset description = "">
     <cfif val(getgross.custcpf) neq 0>
     <cfset description = description&"CPF">
     </cfif>
     <cfif val(getgross.custsdf) neq 0>
     <cfif description neq "">
     <cfset description = description&" + ">
	 </cfif>
     <cfset description = description&"SDF">
     </cfif>
     <cfif val(getgross.adminfee) neq 0>
     <cfif description neq "">
     <cfset description = description&" + ">
	 </cfif>
     <cfset description = description&"Admin Fee">
     </cfif>
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'CPF', 
            '#description#', 
            '', 
            '1',
            #Numberformat(val(getgross.custcpf)+val(getgross.adminfee)+val(getgross.custsdf),'.__')#, 
             #Numberformat(val(getgross.custcpf)+val(getgross.adminfee)+val(getgross.custsdf),'.__')#,
            '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     <cfset trancodestart = trancodestart + 1>
     <!--- <cfif val(getgross.custsdf) neq 0>
     <!---SDF---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'SDF', 
            'SDF', 
            '', 
            '1',
            #Numberformat(val(getgross.custsdf),'.__')#, 
             #Numberformat(val(getgross.custsdf),'.__')#,
           '#uuid#'
            )
   	 </cfquery>
     </cfif> --->
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.nscustded) neq 0>
     <!---NS DEDUCTION---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'NS', 
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.nsdeddesp#">, 
            '', 
            '1',
            #Numberformat(val(getgross.nscustded)*-1,'.__')#, 
             #Numberformat(val(getgross.nscustded)*-1,'.__')#,
           '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
      <cfset trancodestart = trancodestart + 1>
     <!--- <cfif val(getgross.adminfee) neq 0>
     <!---Admin Fee---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'adminfee', 
            'Admin Fee', 
            '', 
            '1',
            #Numberformat(val(getgross.adminfee),'.__')#, 
             #Numberformat(val(getgross.adminfee),'.__')#,
           '#uuid#'
            )
   	 </cfquery>
     </cfif> --->
     
     
     <cfloop from="1" to="3" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif evaluate('getgross.billitem#i#') neq "" and val(evaluate('getgross.billitemamt#i#')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                
                'monthlybill#i#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.billitemdesp#i#')#">, 
                '', 
                '1',
                #Numberformat(evaluate('getgross.billitemamt#i#'),'.__')#, 
                 #Numberformat(evaluate('getgross.billitemamt#i#'),'.__')#,
             '#uuid#'
                )
         </cfquery>
     </cfif>
     </cfloop>
     
     
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.addchargecust) neq 0 or val(getgross.addchargecust2) neq 0 or val(getgross.addchargecust3) neq 0>
     
      <cfset description = "">
     <cfif val(getgross.addchargecust) neq 0>
     <cfset description = description&addchargedesp>
     </cfif>
     <cfif val(getgross.addchargecust2) neq 0>
     <cfif description neq "">
     <cfset description = description&" , ">
	 </cfif>
     <cfset description = description&addchargedesp2>
     </cfif>
     <cfif val(getgross.addchargecust3) neq 0>
     <cfif description neq "">
     <cfset description = description&" , ">
	 </cfif>
     <cfset description = description&addchargedesp3>
     </cfif>
     
     <!---other 1---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'other', 
            '#description#', 
            '', 
            '1',
            #Numberformat(val(getgross.addchargecust)+val(getgross.addchargecust2)+val(getgross.addchargecust3),'.__')#, 
             #Numberformat(val(getgross.addchargecust)+val(getgross.addchargecust2)+val(getgross.addchargecust3),'.__')#,
            '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     
     
     
     
     <cfset trancodestart = trancodestart + 1>
     <!--- <cfif val(getgross.addchargecust2) neq 0>
     
     <!---other 2---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'other2', 
            '#addchargedesp2#', 
            '', 
            '1',
            #Numberformat(val(getgross.addchargecust2),'.__')#, 
             #Numberformat(val(getgross.addchargecust2),'.__')#,
       		'#uuid#'
            )
   	 </cfquery>
     </cfif> --->
     
     <cfset trancodestart = trancodestart + 1>
     <!--- <cfif val(getgross.addchargecust3) neq 0>
     <!---other 3---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'other3', 
            '#addchargedesp3#', 
            '',
            '1',
            #Numberformat(val(getgross.addchargecust3),'.__')#, 
             #Numberformat(val(getgross.addchargecust3),'.__')#,
           '#uuid#'
            )
   	 </cfquery>
     </cfif> --->
     
     <cfset trancodestart = trancodestart + 1>
     <cfif val(getgross.rebate) neq 0>
     <!---Rebate---->
     <cfquery name="inserttempcreatebiitem" datasource="#dts#">
        insert into tempcreatebiitem
        ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
            )
            values
            (
            'INV',
            '#getgross.refno#',
            
            'rebate', 
            'Rebate', 
            '',
            '1',
            #Numberformat(val(getgross.rebate)*-1,'.__')#, 
             #Numberformat(val(getgross.rebate)*-1,'.__')#,
           '#uuid#'
            )
   	 </cfquery>
     </cfif>
     
     
     <cfloop from="1" to="3" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif val(evaluate('getgross.dedcust#i#')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                
                'dedcust#i#', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.ded#i#desp')#">, 
                '',
                '1',
                #Numberformat(evaluate('getgross.dedcust#i#')*-1,'.__')#, 
                 #Numberformat(evaluate('getgross.dedcust#i#')*-1,'.__')#,
               '#uuid#'
                )
         </cfquery>
     </cfif>
     </cfloop>
     
     <cfloop list="pb,aws" index="i">
     <cfset trancodestart = trancodestart + 1>
	 <cfif val(evaluate('getgross.#i#eramt')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                
                '#i#amt', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getgross.#i#text')#">, 
                '',
                '1',
                #Numberformat(evaluate('getgross.#i#eramt'),'.__')#, 
                 #Numberformat(evaluate('getgross.#i#eramt'),'.__')#,
               '#uuid#'
                )
         </cfquery>
         
         
     </cfif>
     
     <cfset trancodestart = trancodestart + 1>
	 <cfif val(evaluate('getgross.total#i#misc')) neq 0>
          <cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            ( type,
            refno,
            itemno,
            desp,
            desp2,
            qty,
            price,
            amount,
            uuid
                )
                values
                (
                'INV',
                '#getgross.refno#',
                
                '#i#miscamt', 
                <cfif i eq "pb">
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.bonusmisctext#">, 
                <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getgross.awsmisctext#">, 
                </cfif>
                '', 
                '1',
                #Numberformat(evaluate('getgross.total#i#misc'),'.__')#, 
                 #Numberformat(evaluate('getgross.total#i#misc'),'.__')#,
               '#uuid#'
                )
         </cfquery>
         
         
     </cfif>
     </cfloop>
     
     