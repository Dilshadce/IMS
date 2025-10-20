<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>

<cfif url.type eq 'add'>

<cfif trim(url.serialno) neq ''>

<cfquery name="checkexistserialno" datasource="#dts#">
select sum(sign) as qty from iserial where itemno='#url.itemno#' and serialno='#url.serialno#'
</cfquery>

<cfif checkexistserialno.qty gt 0>
<h3>Serial No Already Existed</h3>
<cfelse>

<cfquery name="gettrandetail" datasource="#dts#">
select * from receivetemp where uuid='#url.uuid#' and trancode='#url.trancode#'
</cfquery>

<cfquery name="checktotalserialno" datasource="#dts#">
select ifnull(count(serialno),0) as totalserial from iserialtemp where uuid='#url.uuid#' and trancode='#url.trancode#'
</cfquery>

<!---checkamount of serial---><cfif checktotalserialno.totalserial lt gettrandetail.qty><!--- --->

<cfquery name="inserttempserial" datasource="#dts#">
insert into iserialtemp 
(type,refno,trancode,custno,fperiod,wos_date,itemno,serialno,agenno,location,currrate,sign,price,uuid) 
values ('#gettrandetail.type#','#gettrandetail.refno#','#gettrandetail.trancode#','#gettrandetail.custno#','#gettrandetail.fperiod#',
'0000-00-00','#gettrandetail.itemno#','#url.serialno#','#gettrandetail.agenno#','#gettrandetail.location#', 
'#gettrandetail.currrate#','1','#gettrandetail.price#','#url.uuid#')

</cfquery>
<cfelse>
<h3>Serial No added is more than Qty</h3>
</cfif>
</cfif>

<cfelse>
<h3>Serial No cannot be empty</h3>
</cfif>

<cfelseif url.type eq 'multiadd'>

<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#val(len(url.runningnumfr))#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>

<cfset steploop = 1>
	<cfif url.runningnumfr gt url.runningnumto>
	<cfset steploop = -1>
	</cfif>
    <cfquery name="checktotalserialno" datasource="#dts#">
	select ifnull(count(serialno),0) as totalserial from iserialtemp where uuid='#url.uuid#' and trancode='#url.trancode#'
	</cfquery>
    <cfquery name="gettrandetail" datasource="#dts#">
	select * from receivetemp where uuid='#url.uuid#' and trancode='#url.trancode#'
	</cfquery>
    
	<cfset count=checktotalserialno.totalserial>
    <cfif checktotalserialno.totalserial lt gettrandetail.qty>
    <cfloop from="#val(url.runningnumfr)#" to="#val(url.runningnumto)#" step="#steploop#" index="i">
	<cfset serialnum = url.prefix&numberformat(i,stDecl_UPrice)&url.endfix>
    

		 <cfquery name="serialExist" datasource="#dts#">
			select sum(sign) as qty from iserial where itemno='#url.itemno#' and serialno='#serialnum#'
		</cfquery>
		<cfif serialExist.qty gt 0>
        <h3>Serial No Already Existed</h3>
			
		 <cfelse>
			<cfquery name="insertserial" datasource="#dts#">
            insert into iserialtemp 
(type,refno,trancode,custno,fperiod,wos_date,itemno,serialno,agenno,location,currrate,sign,price,uuid) 
values ('#gettrandetail.type#','#gettrandetail.refno#','#gettrandetail.trancode#','#gettrandetail.custno#','#gettrandetail.fperiod#',
'0000-00-00','#gettrandetail.itemno#','#serialnum#','#gettrandetail.agenno#','#gettrandetail.location#', 
'#gettrandetail.currrate#','1','#gettrandetail.price#','#url.uuid#')
			</cfquery>
		</cfif> 
		
    <cfset count=count+1>
    <cfif count gte gettrandetail.qty>
    <cfbreak>
    </cfif>
    </cfloop>
	</cfif>

<cfelse>

<cfquery name="deletetempserial" datasource="#dts#">
delete from iserialtemp where uuid='#url.uuid#' and trancode='#url.trancode#' and itemno='#url.itemno#' and serialno='#url.serialno#'

</cfquery>

</cfif>



<cfquery name="gettempserialno" datasource="#dts#">
select * from iserialtemp where uuid='#url.uuid#' and trancode='#url.trancode#'
</cfquery>
		<cfoutput>
		<table class="data">
		<tr>
        	
			<th>Serial No</th>
            <th>Action</th>
		</tr>
		
        <cfloop query="gettempserialno">
		<tr>
			<td>#gettempserialno.serialno#</td>
			<td><input type="button" name="add_text" value="Delete" onClick="ajaxFunction(document.getElementById('addserialajaxfield'),'/default/transaction/dissemble/serialajax.cfm?uuid=#url.uuid#&trancode=#url.trancode#&itemno='+escape(encodeURI(document.getElementById('serialitemno').value))+'&serialno=#gettempserialno.serialno#&type=delete');"></td>
		</tr>
        </cfloop>
		
		</table>
        </cfoutput>
