<script language="javascript">
function checkValue(){if(document.form1.skeypage.value==''){alert("Please fill with number.");document.form1.skeypage.focus();return false;}return true;}
function del_confirm(){var r=confirm("Press a button");if (r==true){return true;}else{document.write("You pressed Cancel!");}}
function refreshPage(){form1.submit();}
</script>

<cfparam name="Attributes.searchtype" default="">
<cfparam name="Attributes.searchstr" default="">
<cfparam name="Attributes.QueryName" default="Query">
<cfparam name="Attributes.DataSource" default=""> 
<cfparam name="Attributes.QString" default="">
<cfparam name="Attributes.TableFieldList" default="">
<cfparam name="Attributes.ActionButton" default="">

<cfset searchstr = urlencodedformat(searchstr)>
<cfset currentFile=getToken(cgi.PATH_INFO,listlen(cgi.PATH_INFO,"/"),"/")>
<cfset records_per_page=20>
<cfset page_links_shown = 5>
<cfset start_page=1>
<cfset begin_page=1>
<cfset qStr="">
<cfset headerList="">
<cfset widthList="">
<cfset nextItem=false>

<cfloop list="#Attributes.TableFieldList#" index="group" delimiters="||">
	<cfloop list="#group#" index="item" delimiters="!!">
		<cfif not nextItem>
			<cfset qStr=listappend(qStr,item)>
			<cfset headerList=listappend(headerList,listgetat(item,listlen(item," ")," "))>
			<cfset nextItem=true>
		<cfelse>
			<cfset widthList=listappend(widthList,listgetat(item,listlen(item," ")," "))>
			<cfset nextItem=false>
		</cfif>
	</cfloop>
	<cfif nextItem><cfset widthList=listappend(widthList,"1*")><cfset nextItem=false></cfif>
</cfloop>

<cfif isdefined("form.results_list")><cfset records_per_page=form.results_list>
<cfelseif isdefined("url.list")><cfset records_per_page = url.list>
<cfelse><cfset records_per_page=20>
</cfif>

<cfif isdefined("form.skeypage")><cfset begin_page = form.skeypage><cfif form.skeypage eq 1><cfset begin_page=1></cfif>
<cfelseif isdefined("url.page")><cfset begin_page=url.page>
<cfelse><cfset url.page=1>
</cfif>
		
<cfset start_record=begin_page*records_per_page-records_per_page>

<cfquery name="#Attributes.QueryName#" datasource="#Attributes.DataSource#">
	select SQL_CALC_FOUND_ROWS * from
	(
		#preservesinglequotes(Attributes.QString)#
	) as r
	LIMIT #start_record#, #records_per_page#
</cfquery>

<cfquery name="get_count" datasource="#Attributes.DataSource#">
 	SELECT FOUND_ROWS() as records;
</cfquery>

<cfset total_pages=ceiling(get_count.records/records_per_page)>
<cfset show_pages=min(page_links_shown,total_pages)>

<table width="98%" cellpadding="3" cellspacing="1" class="data">
	<tr>
		<th width="4%">#</th>
		<cfloop from="1" to="#listlen(headerList)#" index="i"><cfoutput><th width="#listgetat(widthList,i)#">#ReplaceNoCase(listgetat(headerList,i),"_"," ","all")#</th></cfoutput></cfloop>
		<cfif Attributes.ActionButton neq ""><th>Action</th></cfif>
	</tr>
	<cfoutput query="#Attributes.QueryName#">
	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td align="center">#start_record+currentrow#</td>
		<cfloop index="ColumnHeadings" list="#headerList#"><td>#evaluate(ColumnHeadings)#</td></cfloop>
		<cfif Attributes.ActionButton neq ""><td align="right" nowrap>#evaluate(DE(Attributes.ActionButton))#</td></cfif>
	</tr>
	</cfoutput>
</table>
<cfoutput>
	<cfform name="form1" action='#currentFile#?list=&searchtype=#searchtype#&searchstr=#searchstr#' method='post' onsubmit="return checkValue();">
		Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field." onChange="document.getElementById('Display_sel').style.visibility='visible'">
		<strong id='Display_sel' style="visibility:hidden">Display 
			<select name="results_list">
			<option value="20">20</option>
			<option value="50" <cfif records_per_page eq '50'>selected</cfif>>50</option>
			<option value="100" <cfif records_per_page eq '100'>selected</cfif>>100</option>
			</select> results per page.
			<input type="submit" name="submit" value="Submit">
		</strong>
		<div align="center">
		<cfif begin_page EQ 1>&nbsp;[Previous]
		<cfelse>
			&nbsp;<a href="#currentFile#?page=1&list=#records_per_page#&searchtype=#searchtype#&searchstr=#searchstr#">[First Page]</a>
			&nbsp;<a href="#currentFile#?page=#begin_page-1#&list=#records_per_page#&searchtype=#searchtype#&searchstr=#searchstr#">[Previous]</a>
		</cfif>
	
		<cfif begin_page+int(show_pages/2)-1 GTE total_pages>
			<cfset start_page=total_pages-show_pages+1>
		<cfelseif begin_page+1 GT show_pages>
			<cfset start_page=begin_page-int(show_pages/2)>
		</cfif>
		<cfset end_page=start_page+show_pages-1>
		<cfloop from="#start_page#" to="#end_page#" index="i">
			<cfif begin_page EQ i>#i#<cfelse><a href="#currentFile#?page=#i#&list=#records_per_page#&searchtype=#searchtype#&searchstr=#searchstr#">#i#</a></cfif>
		</cfloop>
	
		<cfif begin_page*records_per_page LT get_count.records>
			&nbsp;<a href="#currentFile#?page=#begin_page+1#&list=#records_per_page#&searchtype=#searchtype#&searchstr=#searchstr#">[Next]</a>
			&nbsp;<a href="#currentFile#?tran=INV&page=#total_pages#&list=#records_per_page#&searchtype=#searchtype#&searchstr=#searchstr#">[Last Page]</a>
		<cfelse>
			&nbsp;[Next]
		</cfif>
		</div>
	</cfform>
</cfoutput>