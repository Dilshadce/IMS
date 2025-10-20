<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	
	<link href="general.css" media="screen" rel="stylesheet" type="text/css" />
</head>

<cfparam name="alcreate" default="0">
<cfparam name="aledit" default="0">
<cfparam name="aldelete" default="0">
<cfparam name="alown" default="0">

<cfif tran eq "INV">
	<cfset tran = "INV">
	<cfset tranname = "Invoice">
	<cfset trancode = "invno">
	
	<cfif getpin2.h2401 eq "T">
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2402 eq "T">
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2403 eq "T">
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2404 eq "T">
  		<cfset alown = 1>
 	</cfif>
</cfif>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select 
	delinvoice,
	invsecure,
	printoption,
	invoneset 
	from gsetup
</cfquery>

<cfparam name="url.page" default="1">
<cfparam name="records_per_page" default="20">
<cfset page_links_shown = 5>

<cfif isdefined("form.results_list")>
<cfset records_per_page = #form.results_list#>
<cfelseif isdefined("url.list")>
<cfset records_per_page = #url.list#>
<cfelse>
<cfset records_per_page = 20>
</cfif>

		<cfif isdefined("form.skeypage")>
			<cfset begin_page = form.skeypage>
			<cfif form.skeypage eq "1">
				<cfset begin_page = "1">
			</cfif>
		</cfif>
		<cfif isdefined("url.page") and not isdefined("form.skeypage")>
		<cfset begin_page = url.page>
		</cfif>
		
<cfset start_record = begin_page * records_per_page - records_per_page>
<!---{ this query really belongs within the main query, but for simplicity, and easy compatibility with MySQL 4.0 and
lower, I left it seperate.} --->

<cfquery datasource='#dts#' name="get_count">
 SELECT COUNT(refno) AS records FROM artran
 where type='#tran#' 
	<cfif alown eq 1>
	and (artran.userid='#huserid#' or ucase(artran.agenno)='#ucase(huserid)#')
	</cfif>
</cfquery>

<!---{ the main query gets the data we need. notice the dynamic use of LIMIT }--->
<cfquery datasource='#dts#' name="getjob">
	select 
	artran.type,
	artran.refno,
	artran.refno2,
	artran.agenno,
	artran.wos_date,
	artran.fperiod,
	artran.custno,
	artran.name,
	artran.userid,
	artran.posted,
	toinv,
	(select phone from customer where customerno=artran.custno) as phone 
	from artran 
	where type='#tran#' 
	<cfif alown eq 1>
	and (artran.userid='#huserid#' or ucase(artran.agenno)='#ucase(huserid)#')
	</cfif>
	<!--- and fperiod <> '99' ---> 
	order by refno desc
	LIMIT #start_record#, #records_per_page#
</cfquery>

<cfset total_pages = ceiling(get_count.records / records_per_page)>
<cfparam name="start_page" default="1">
<cfparam name="begin_page" default="1">
<cfparam name="show_pages" default="#min(page_links_shown,total_pages)#">

<body>

<div id="container">


<div id="container2">

<div id="content">

		<h2>Easy Pagination with MySQL</h2>
		<div class="codebox">
			<div style="padding:5px;">
	This working example of the pagination code has been modified only in the html used and the placement of the page links.<br/>
</div>

 <table width="100%" cellpadding="3" cellspacing="1" class="example_table">
  			<tr>
				<td colspan="11"><div align="center"><font color="#FFFFFF" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>#tranname#</cfoutput></strong></font></div></td>
  			</tr>
	<tr class="table_color_1">
		<td align="center" width="20"><b>#</b></td>
		<td><b><cfoutput>#tranname# No</cfoutput></b></td>
		<td><b>Refno2</b></td>
		<td><b>Agent</b></td>
		<td><b>Date</b></td>
		<td><b>Period</b></td>
		<td><b>
		<cfif tran eq "rc" or tran eq "pr" or tran eq "po">
			Supplier Name
		<cfelse>
			Customer Name
		</cfif></b>
		</td>
		<td><b>Phone</b></td>
		<td><b>User</b></td>
		<td><b>Status</b></td>
		<td><b>Action</b></td>
	</tr>



<!---{ loop over the query to output the data. start_record + currentrow gives us the 'corrected' row number }--->
<cfoutput>
<cfloop query="getjob">
	<tr class="table_color_1">
		<td align="center">#start_record + currentrow#</td>
		<td>#refno#</td>
		<td>#refno2#</td>
		<td>#agenno#</td>
		<td>#dateformat(wos_date,"dd-mm-yyyy")#</td>
		<td>#fperiod#</td>
		<td>#custno# - #name#</td>
		<td>#phone#</td>
  		<td>#userid#</td>
		<td align="center">
		<cfif tran eq 'DO' and toinv neq ''>
				Y
		</cfif>
		<cfif (tran eq 'INV' or tran eq 'RC' or tran eq 'CS' or tran eq 'CN' or tran eq 'DN') and posted neq ''>
				P
		</cfif>
		</td>
<td align="right" nowrap>
		  			<cfif getgeneralinfo.printoption eq 1>
						<a href="/default/transaction/transaction3c.cfm?tran=#tran#&nexttranno=#refno#" target="_blank">Print</a>&nbsp;
					<cfelse>
						<a href="/billformat/#dts#/transactionformat.cfm?tran=#tran#&nexttranno=#refno#" target="_blank">Print</a>&nbsp;
					</cfif>
 	  	  			<cfif hcomid eq 'msd' and tran eq "RC" and getpin2.h2101 eq 'T'>
	  	    			|&nbsp;<a href="../reports/grn_note.cfm?tran=#tran#&nexttranno=#refno#">GRN Note</a>&nbsp;
 		  			</cfif>
		  			<cfif aledit eq 1>
		  				<a href="/default/transaction/transaction1.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
							<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit
						</a>
					</cfif>
            		<cfif aldelete eq 1>
						<a href="/default/transaction/transaction1.cfm?tran=#tran#&ttype=Delete&refno=#refno#&custno=#URLEncodedFormat(getjob.custno)#&first=0">
							<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete
						</a>
					</cfif>
				</td>
	</tr>

</cfloop>
</table>
<hr>
<!---{ Next Page - this in is too simple - if page we are on page 1,
there are no more previous pages, so show text instead of the link --->
<div class="links">


<cfform action='pages.cfm?tran=INV&list=' method='post'>

Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field." onChange="document.getElementById('Display_sel').style.visibility = 'visible'">


<cfif begin_page EQ 1>
&nbsp;[Previous]
<cfelse>
&nbsp;<a href="pages.cfm?tran=INV&page=#begin_page-1#&list=#records_per_page#">[Previous]</a>
</cfif>

<!---{ Page Numbers - this section makes the page number links.
We could just show every page link, but what if there are 100?
We want to limit it to a reasonable number, and all pages will
still be easily accessible. This code will not work with if
Easy Pagination with MySQL Page 5 of 7
http://www.lot-o-nothin.com/cfml/tutorials/index.cfm/id/6_14/ 12/06/2007
show_pages LT 3, but will work fine no matter how many records
query returns }--->
<cfif begin_page + int(show_pages / 2) - 1 GTE total_pages>
<cfset start_page = total_pages - show_pages + 1>
<cfelseif begin_page + 1 GT show_pages>
<cfset start_page = begin_page - int(show_pages / 2)>
</cfif>
<cfset end_page = start_page + show_pages - 1>
<cfloop from="#start_page#" to="#end_page#" index="i">
<!---{ This cfif makes the current page text only. Other pages get a link to them. }--->
<cfif begin_page EQ i>
#i#
<cfelse>
<a href="pages.cfm?tran=INV&page=#i#&list=#records_per_page#">#i#</a>
</cfif>
</cfloop>

<!---{ Previous Page - another really easy one }--->
<cfif begin_page * records_per_page LT get_count.records>
&nbsp;<a href="pages.cfm?tran=INV&page=#begin_page+1#&list=#records_per_page#">[Next]</a>
<cfelse>
&nbsp;[Next]
</cfif>

<div align="right">


<!---{ First Page Link }--->
&nbsp;<a href="pages.cfm?tran=INV&page=1&list=#records_per_page#">[First Page]</a>

<!---{ Last Page Link }--->
&nbsp;<a href="pages.cfm?tran=INV&page=#total_pages#&list=#records_per_page#">[Last Page]</a>

<div id='Display_sel' style="visibility:hidden ">
        <td colspan="3"><strong>Display <cfselect name="results_list">
            <option value="20" default <Cfoutput><Cfif records_per_page eq '20'>selected</cfif></Cfoutput>>20</option>
            <option value="50" <Cfoutput><Cfif records_per_page eq '50'>selected</cfif></Cfoutput>>50</option>
            <option value="100" <Cfoutput><Cfif records_per_page eq '100'>selected</cfif></Cfoutput>>100</option>
          </cfselect> results per page.</strong> </td>
		  
		<cfinput type="submit" name="submit" value="Submit">
		  </div> 
</div>


</cfform>
<hr>
	</div>	</div>
	


	</div>
	</cfoutput>
</body>