<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="fulfill" default="">

<cfquery name="getgsetup2" datasource='#dts#'>
  	Select * from gsetup2
</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = ".">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<body>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM

	from GSetup
</cfquery>

<!--- t1: Transaction From; t2: Transaction To --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<h1>Update to <cfoutput>#gettranname.lINV#</cfoutput></h1>

	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>

	<cfif isdefined("form.invset")>
		<cfset trancode = form.invset>

		<cfif form.invset eq "invno">
			<cfset tranarun = "invarun">
		<cfelseif form.invset eq "invno_2">
			<cfset tranarun = "invarun_2">
		<cfelseif form.invset eq "invno_3">
			<cfset tranarun = "invarun_3">
		<cfelseif form.invset eq "invno_4">
			<cfset tranarun = "invarun_4">
		<cfelseif form.invset eq "invno_5">
			<cfset tranarun = "invarun_5">
		<cfelseif form.invset eq "invno_6">
			<cfset tranarun = "invarun_6">
		</cfif>
	<cfelse>
		<cfset trancode = "invno">
		<cfset tranarun = "invarun">
	</cfif>
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
		
	<!--- ADD ON 130608, TITLE FOR EXPORT FROM PO TO DO --->
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>

	<cfset trancode = "dono">
	<cfset tranarun = "doarun">
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<h1>Update to <cfoutput>#gettranname.lRC#</cfoutput></h1>

	<cfif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	</cfif>

	<cfset trancode = "rcno">
	<cfset tranarun = "rcarun">
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "po">
	<h1>Update to <cfoutput>#gettranname.lPO#</cfoutput></h1>

	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
	</cfif>

	<cfset trancode = "pono">
	<cfset tranarun = "poarun">
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<h1>Update to <cfoutput>#gettranname.lSO#</cfoutput></h1>

	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	</cfif>

	<cfset trancode = "sono">
	<cfset tranarun = "soarun">
</cfif>

<!--- REMARK ON 230608 AND REPLACE WITH THE BELOW ONE --->
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as tranno, #tranarun# as arun from GSetup
</cfquery--->

<cfif isdefined("form.invset")>
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#t2#'
		and counter = '#invset#'
	</cfquery> --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = '#invset#'
	</cfquery>
	<cfset counter = invset>
<cfelse>
	
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = '#t2#'
		and counter = 1
	</cfquery> --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = 1
	</cfquery>
	
	<cfset invset = 1>
	<cfset counter = 1>
</cfif>

<cfoutput>
<cfif url.t2 eq "DO">
	<cfif url.t1 eq "PO">
		<form action="updateA.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#" method="post">
			<h1>Search Refno: 
				&nbsp;&nbsp;From&nbsp;&nbsp;<input type="text" name="refnofr" value="">
				&nbsp;&nbsp;To&nbsp;&nbsp;<input type="text" name="refnoto" value="">
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Search" value="Search">
			</h1>
		</form>
	</cfif>
</cfif>
</cfoutput>

<br><br>It will display all transactions in the select <cfoutput>#type#</cfoutput>.



<!--- The coding below provide updating of DO or SO to Invoice --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<!--- Coding here is for update to Invoice --->
	<!--- t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO --->
	<cfif url.t1 eq "DO">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and toinv = '' order by refno
	  	</cfquery>

	  	<cfform action="update3.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
	  		<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>

			<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		    	<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="20" size="8"></td>
				</tr>
		  	</cfif>
			<tr>
            	<td colspan="5">
			  		<div align="right">
		  	    	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              		</div>
				</td>
          	</tr>
        </table>
	</cfform>
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">
		<!--- <cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and shipped < qty group by refno order by refno
		</cfquery> --->
		<cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and (shipped+writeoff) < qty group by refno order by refno
		</cfquery>

		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>

			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>

			<table class="data" align="center">
				<tr>
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>To Bill</th>
					<!--- <th>Qty To Fulfill</th>  --->
					<th>User</th>
				</tr>
			</cfoutput>

			<cfoutput query="getupdate">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#refno#</td>
					<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
					<td>#custno#</td>
					<cfif trim(itemno) eq ''>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
						<cfset xitemno = 'YHFTOKCF'>
					<cfelse>
						<cfset xitemno = itemno>
					</cfif>

					<td><input type="checkbox" name="checkbox" value="#refno#;"></td>

					<cfquery name="getid" datasource="#dts#">
						select userid from artran where refno = '#refno#'
					</cfquery>
					<td>#getid.userid#</td>
				</tr>
			</cfoutput>
				<tr>
					<td colspan="3">
					<div align="right">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
					</div>
					</td>
				</tr>
			</table>
		</cfform>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
		<cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and shipped < qty group by refno order by refno
		</cfquery>

		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>

			<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>

			<table class="data" align="center">
				<tr>
					<th>#type#</th>
					<th>Date</th>
					<th>Customer No</th>
					<th>To Bill</th>
					<th>User</th>
				</tr>
			</cfoutput>

			<cfoutput query="getupdate">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#refno#</td>
					<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
					<td>#custno#</td>
					<cfif trim(#itemno#) eq ''>
						<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
						<cfset xitemno = 'YHFTOKCF'>
					<cfelse>
						<cfset xitemno = itemno>
					</cfif>
					<td><input type="checkbox" name="checkbox" value="#refno#;"></td>

					<cfquery name="getid" datasource="#dts#">
						select userid from artran where refno = '#refno#'
					</cfquery>

					<td>#getid.userid#</td>
				</tr>
				</cfoutput>
		  		<tr>
            		<td colspan="3">
			  			<div align="right">
                		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              			</div>
					</td>
          		</tr>
			</table>
		</cfform>
	<!--- t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfelseif url.t1 eq "PO">
		<!--- <cfquery datasource="#dts#" name="getupdate">
			Select b.* 
			from artran a, ictran b 
			where a.refno = b.refno and a.type = b.type and a.custno = '#url.custno#' and a.type = '#t1#'
			and a.order_cl = '' and a.exported = '' and b.exported = '' and b.toinv = '' 
			group by a.refno order by a.refno
	  	</cfquery> --->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran  
			where custno = '#url.custno#' and type = '#t1#'
			and order_cl = '' and exported = ''
			order by refno
	  	</cfquery>
	  	
	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Invoice No : <font size="2">#getGeneralInfo.tranno#</font></p>

			<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Supplier No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
            	</tr>
          	</cfoutput>
		  	<tr>
            	<td colspan="3">
			  	<div align="right">
               	 	<input type="reset" name="Submit2" value="Reset">
                	<input type="submit" name="Submit" value="Submit">
              	</div>
				</td>
          	</tr>
        	</table>
	  	</cfform>
	</cfif>
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<!--- Coding here is for update to DO --->
	<cfif url.t1 eq "SO">
	  	<!--- <cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and shipped < qty 
			group by refno 
			order by refno
	  	</cfquery> --->
	  	
	  	<cfquery datasource="#dts#" name="getupdate">
			Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,
			if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
			left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
			where i.custno = '#url.custno#' and i.type='#t1#' and (shipped+writeoff) < qty 
			group by refno 
			order by refno
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

        	<table class="data" align="center">
			<tr>
				<th>#type#</th>
				<th>Date</th>
				<th>Customer No</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#wos_date#</td>
              		<td>#custno#</td>
			  		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
					<td>#userid#</td>
          		</tr>
          	</cfoutput>
			<tr>
				<td colspan="3">
				<div align="right">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
		</cfform>
	<!--- ADD ON 130608, THE TRANSACTION FOR EXPORT FROM PO TO DO --->
	<cfelseif url.t1 eq "PO">
		<cfif isdefined("form.Search")>
			<cfquery datasource="#dts#" name="exactResult">
				Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,i.name,
				if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
				left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
				where i.type='#t1#' and shipped < qty 
				and i.refno between '#form.refnofr#' and '#form.refnoto#'
				group by refno 
				order by refno
	  		</cfquery>

			<h2>Result</h2>
			<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
        	<p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

        	<table class="data" align="center" width="60%">
			<tr>
				<th>#type#</th>
				<th>Date</th>
				<th>Supplier Name</th>
				<th>To Bill</th>
				<th>User</th>
			</tr>
          	</cfoutput>

		  	<cfoutput query="exactResult">
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    <cfset xitemno=itemno>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#wos_date#</td>
              		<td>#custno# - #name#</td>
			  		<td align="center"><input type="checkbox" name="checkbox" value="#refno#;"></td>
					<td align="center">#userid#</td>
          		</tr>
          	</cfoutput>
			<tr>
				<td colspan="3">
				<div align="center">
					<input type="reset" name="Submit2" value="Reset">
					<input type="submit" name="Submit" value="Submit">
				</div>
				</td>
			</tr>
        	</table>
			</cfform>
		<cfelse>
			<cfquery datasource="#dts#" name="getupdate">
				Select i.refno,date_format(i.wos_date,'%d/%m/%y') as wos_date,i.custno,i.name,
				if(i.itemno='',"YHFTOKCF",i.itemno) as itemno,a.userid from ictran i
				left join artran a on (i.type=a.type and i.refno=a.refno and i.custno=a.custno)
				where i.type='#t1#' and shipped < qty 
				group by refno 
				order by refno
				limit 50
	  		</cfquery>

	  		<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#" method="post" name="updatepage">
				<cfoutput>
        		<p>Last Delivery Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

        		<table class="data" align="center" width="60%">
				<tr>
					<th>#type#</th>
					<th>Date</th>
					<th>Supplier Name</th>
					<th>To Bill</th>
					<th>User</th>
				</tr>
          		</cfoutput>

			  	<cfoutput query="getupdate">
		  			<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    	<cfset xitemno=itemno>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              			<td>#refno#</td>
              			<td>#wos_date#</td>
              			<td>#custno# - #name#</td>
			  			<td align="center"><input type="checkbox" name="checkbox" value="#refno#;"></td>
						<td align="center">#userid#</td>
          			</tr>
          		</cfoutput>
				<tr>
					<td colspan="3">
					<div align="center">
						<input type="reset" name="Submit2" value="Reset">
						<input type="submit" name="Submit" value="Submit">
					</div>
					</td>
				</tr>
        		</table>
			</cfform>
		</cfif>
	</cfif>
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<!--- Coding here is for update to Purchase Order --->
	<cfif url.t1 eq "PO">
		<!--- <cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and shipped < qty group by refno order by refno
	  	</cfquery> --->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from ictran where custno = '#url.custno#' and type = '#t1#' and (shipped+writeoff) < qty group by refno order by refno
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Receive No : <font size="2">#getGeneralInfo.tranno#</font></p>

        	<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Supplier No</th>
              		<th>To Bill</th>
              		<th>User</th>
            	</tr>
          </cfoutput>

		  <cfoutput query="getupdate">
		  		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
			</cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
                		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
	  	</cfform>
	</cfif>
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<!--- Coding here is for update to DO --->
	<cfif url.t1 eq "SO">
	  	<cfquery datasource="#dts#" name="getupdate">
			Select b.* from artran a, ictran b where a.refno = b.refno and a.type = b.type and a.custno = '#url.custno#' and a.type = '#t1#'
			and a.order_cl = '' and a.exported = '' and b.exported = '' and b.toinv = '' group by a.refno order by a.refno
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&custno=#URLEncodedFormat(url.custno)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
			<cfif isdefined("form.invset")>
				<input type="hidden" name="invset" value="#invset#">
			</cfif>
        	<p>Last Purchase Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

			<table class="data" align="center">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>To Bill</th>
             	 	<th>User</th>
           	 	</tr>
          	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<cfif trim(itemno) eq ''>
			    		<!--- Just assign a value, because ColdFusion ignores empty list elements and will use in update2a.cfm--->
			    		<cfset xitemno = 'YHFTOKCF'>
			  		<cfelse>
			    		<cfset xitemno = itemno>
			  		</cfif>

			  		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
              		<cfquery name="getid" datasource="#dts#">
                		select userid from artran where refno = '#refno#'
              		</cfquery>

					<td>#getid.userid#</td>
            	</tr>
          </cfoutput>
		  		<tr>
            		<td colspan="3">
			  		<div align="right">
               	 		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
	  	</cfform>
	</cfif>
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<cfif url.t1 eq "QUO" and lcase(HcomID) neq "steel_i">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and order_cl = '' order by refno
	  	</cfquery>
        <cfif getgsetup.quoChooseItem eq 1>
		<cfset updateurl = "update2.cfm" >
        <cfelse>
        <cfset updateurl = "update3.cfm" >
        </cfif>
	  	<cfform action="#updateurl#?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
        	<p>Last Sales Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
	<cfelseif url.t1 eq "QUO" and lcase(HcomID) eq "steel_i">
	  	<!--- Get information on the outstanding unbill DO--->
	  	<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' and order_cl = '' order by refno
	  	</cfquery>

	  	<cfform action="update2.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#&trancode=#URLEncodedFormat(trancode)#&invset=#URLEncodedFormat(invset)#" method="post" name="updatepage">
			<cfoutput>
        	<p>Last Sales Order No : <font size="2">#getGeneralInfo.tranno#</font></p>

        	<table class="data" align="center" width="50%">
            	<tr>
              		<th>#type#</th>
              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	</cfoutput>

		  	<cfoutput query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfoutput>
				<tr>
            		<td colspan="5">
			  		<div align="right">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
      	</cfform>
	</cfif>
</cfif>
</body>
</html>