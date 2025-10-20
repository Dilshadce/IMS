<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript">
	function AssignGrade(itemno,frrefno,frtype,totype,frtrancode){
		var opt = 'Width=800px, Height=400px, scrollbars=no, status=no';
		window.open('dsp_updategradeitem.cfm?itemno=' + escape(itemno) + '&frtype=' + frtype + '&frrefno=' + frrefno + '&frtrancode=' + frtrancode + '&totype=' + totype, '',opt);	
	}
</script>

</head>

<cfparam name="counter" default="">
<cfparam name="fr_type" default="">
<cfparam name="ft_type" default="">
<cfparam name="fr_refno" default="">
<cfparam name="nextrefno" default="">
<cfparam name="f_cdate" default="">
<cfparam name="bylocation" default="">

<cfquery name="getgsetup2" datasource='#dts#'>
  	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<!--- fr_type: From Type; ft_type: To Type --->
<!--- FROM DO --->
<cfif fr_type eq "DO">
	<cfset updateFromType="Delivery Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV">
	    <cfset msg1="and (shipped+writeoff) < qty">
	</cfif>
<!--- FROM SO --->
<cfelseif fr_type eq "SO">
	<cfset updateFromType="Sales Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	<!--- TO DO --->
	<cfelseif ft_type eq "DO">
		<cfset updateToType="Delivery Order">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	<!--- TO PO --->
	<cfelseif ft_type eq "PO">
		<cfset updateToType="Purchase Order">
	    <cfset tt_type="PO">
	    <cfset msg1="and a.exported = '' and a.toinv = ''">
	</cfif>
<!--- FROM PO --->
<cfelseif fr_type eq "PO">
	<cfset updateFromType="Purchase Order">
	<!--- TO RC --->
	<cfif ft_type eq "RC">
		<cfset updateToType="Purchase Receive">
	    <cfset tt_type="RC">
	    <cfset msg1="and (shipped+writeoff) < qty">
	</cfif>
<!--- FROM QUO --->
<cfelseif fr_type eq "QUO">
	<cfset updateFromType="Quotation">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	<cfelseif ft_type eq "SO">
		<cfset updateToType="Sales Order">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	</cfif>
</cfif>

<cfoutput><h1>Update to #updateToType#</h1></cfoutput>
<body>
	<cfset mylist= listchangedelims(checkbox,"",",")>
	<cfset cnt=listlen(mylist,";")>
	
	<cfform action="update3.cfm" method="post" name="updatepage">
		<cfoutput>
		<input type="hidden" name="counter" value="#counter#">
        <input type="hidden" name="fr_type" value="#fr_type#">
        <input type="hidden" name="fr_refno" value="#fr_refno#">
        <input type="hidden" name="f_cdate" value="#f_cdate#">
        <input type="hidden" name="ft_type" value="#ft_type#">
        <input type="hidden" name="nextrefno" value="#nextrefno#">
		<input type="hidden" name="checkbox" value="#convertquote(form.checkbox)#">		
		<input type="hidden" name="bylocation" value="#bylocation#">
		<p>#updateToType# No : <font size="2">#nextrefno#</font></p>
			
		<table class="data" align="center">
			<tr> 
				<th>#updateFromType#</th>
				<th>Date</th>
				<th>Customer No</th>
				<th>Item No</th>
				<th>Item Description</th>
				<th>Qty Order</th>
				<th>Qty Outstanding</th>          
				<th>Qty To Fulfill</th> 
				<th>Price (FC)</th> 
				<th>Price</th>					
        		<th>User</th>
			</tr>
		</cfoutput> 
			
		<cfloop from="1" to="#cnt#" index="i" step="+2">           
			<cfif trim(listgetat(mylist,i,";")) eq 'YHFTOKCF'>
				<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			    <cfset xParam1 = ''>
			<cfelse>
			    <cfset xParam1 = listgetat(mylist,i,";")>
			</cfif>
				
			<cfset xParam2 = listgetat(mylist,i+1,";")>

			<cfquery datasource="#dts#" name="getupdate">
				Select a.*,b.userid from ictran a,artran b
				where a.type=b.type and a.refno=b.refno  
				and a.refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#">  
				and a.type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
				and a.itemno = '#xParam1#' 
				and a.trancode = '#xParam2#' 
				#msg1#
			</cfquery>
				
			<cfoutput query="getupdate"> 
				<cfquery datasource="#dts#" name="getupqty">
            		select sum(qty)as sumqty 
					from iclink 
					where frrefno = '#getupdate.refno#'
           		 	and frtype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">  
					and type in (#ListQualify(tt_type,"'")#) 
					and itemno = '#getupdate.itemno#' 
					and frtrancode = '#getupdate.trancode#'
            	</cfquery>
            		
				<cfif getupqty.sumqty neq "">
              		<cfset upqty = getupqty.sumqty>
              	<cfelse>
              		<cfset upqty = 0>
            	</cfif>

				<cfif getupdate.recordcount gt 0>
					<cfset order = getupdate.qty - val(getupdate.writeoff)>
				<cfelse>
					<cfset order = 0>
				</cfif>
					
				<cfset qtytoful = order - upqty>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"> 					 
            		<td>#refno#</td>
           			<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
           			<td>#custno#</td>
					<td>#itemno#</td>
					<td nowrap>#desp#</td>
					<td><div align="center">#qty#</div></td>					
					<td><div align="center">#qtytoful#</div></td>
					<input type="hidden" name="qtytoful" value="#qtytoful#">
						
                    <cfquery name="getigrade" datasource="#dts#">
                    	select * from igrade 
                       	where type= '#getupdate.type#' and refno = '#getupdate.refno#'
                        and itemno = '#getupdate.itemno#' and trancode = '#getupdate.trancode#'
                    </cfquery>
					<cfif getigrade.recordcount neq 0>
						<cfset qtytoful = 0>
					<cfelse>
						<cfset qtytoful = qtytoful>
					</cfif>
					<input type="hidden" name="grdcolumnlist_#fr_type#_#refno#_#trancode#" id="grdcolumnlist_#fr_type#_#fr_refno#_#trancode#" value="">
            		<input type="hidden" name="grdvaluelist_#fr_type#_#refno#_#trancode#" id="grdvaluelist_#fr_type#_#fr_refno#_#trancode#" value="">
					<input type="hidden" name="totalrecord_#fr_type#_#refno#_#trancode#" id="totalrecord_#fr_type#_#fr_refno#_#trancode#" value="0">
					<input type="hidden" name="bgrdcolumnlist_#fr_type#_#refno#_#trancode#" id="bgrdcolumnlist_#fr_type#_#fr_refno#_#trancode#" value="">
					<td>
						<input type="text" name="fulfill" id="fulfill_#ft_type#_#refno#_#trancode#" value="#qtytoful#" <cfif getigrade.recordcount neq 0>readonly</cfif>>
						<cfif getigrade.recordcount neq 0>
							<input type="button" value="Grade" onClick="AssignGrade('#itemno#','#refno#','#ft_type#','INV','#getupdate.trancode#');">
						</cfif>
					</td>
					<td><div align="right">#numberformat(price_bil,"__,___" & stDecl_UPrice)#</div></td>
					<td>#numberformat(price,"__,___" & stDecl_UPrice)#</td>
					<cfquery name="getid" datasource="#dts#">
						select userid from artran where refno = '#refno#'
					</cfquery>
					<td>#getid.userid#</td>
				</tr>
			</cfoutput> 
		</cfloop>
			<tr>             
				<td colspan="5"><div align="right">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit"></div>
				</td>
			</tr>
		</table>
	</cfform>
</body>
</html>