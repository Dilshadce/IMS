<cfoutput>    
<cfloop from="1" to="#form.totalrecord#" index="a">

<cfquery name="checkexist" datasource="#dts#">
          select * from proseragree where refno='#jsstringformat(evaluate("form.refno#a#"))#'
          </cfquery>
<cfif checkexist.recordcount eq 0>
<cfquery name="insertproseragree" datasource="#dts#">
          insert into proseragree (wos_date,argmno,refno,billingdate,invamt,serv
          <cfloop from="1" to="#form.totalqty#" index="b">
          ,qty#b#
          </cfloop>
          ) values ('#dateformat(evaluate("form.date#a#"),'yyyy/mm/dd')#','#jsstringformat(evaluate("form.argmno#a#"))#','#jsstringformat(evaluate("form.refno#a#"))#','#jsstringformat(evaluate("form.billing#a#"))#','#jsstringformat(evaluate("form.amt#a#"))#',
          '#jsstringformat(evaluate("form.serv#a#"))#'
          <cfloop from="1" to="#form.totalqty#" index="b">
          ,'#jsstringformat(evaluate("form.qty#b#z#a#"))#'
          </cfloop>
          )
</cfquery>
<cfelse>
<cfquery name="updateproseragree" datasource="#dts#">
          update proseragree set serv='#jsstringformat(evaluate("form.serv#a#"))#'
          <cfloop from="1" to="#form.totalqty#" index="b">
          ,qty#b#='#jsstringformat(evaluate("form.qty#b#z#a#"))#'
          </cfloop>
          where refno='#jsstringformat(evaluate("form.refno#a#"))#'
</cfquery>
</cfif>
</cfloop>





</cfoutput>