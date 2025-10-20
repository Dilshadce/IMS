<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = '#t2#'
		and counter = 1
	</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  	Select * from gsetup
</cfquery>
<cfquery datasource="#dts#" name="getupdate">
			Select * from artran where custno = '#url.custno#' and type = '#t1#' <!---and generated = ''---> and toinv = '' and order_cl='' and (void = '' or void is null) and #url.searchType# like '%#url.searchStr#%' order by refno
	  	</cfquery>

<cfoutput>
<table class="data" align="center" width="50%">
            	<tr>
              		<th>#url.t1#</th>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <th>Description</th>
                    </cfif>

              		<th>Date</th>
              		<th>Customer No</th>
              		<th>User</th>
              		<th>To Bill</th>
            	</tr>
		  	

		  	<cfloop query="getupdate">
            	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
              		<td>#refno#</td>
                    <cfif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
                    <td>#desp#</td>
                    </cfif>

              		<td>#dateformat(wos_date, "dd/mm/yyyy")#</td>
              		<td>#custno#</td>
              		<td>#userid#</td>
              		<td><input type="checkbox" name="checkbox" id="checkbox" value="#refno#;"></td>
            	</tr>
		  	</cfloop>

		  	<cfif getgeneralinfo.arun neq 1>
		  		<tr>
			  		<th colspan="2">Next Refno</th>
			  		<td colspan="3"><input type="text" name="nextrefno" value="" maxlength="24" size="8"></td>
				</tr>
		  	</cfif>
		  	<cfif getgsetup.quoChooseItem neq 1>
				<tr>
				  	<th>Date</th>
				  	<td colspan="4">
					  	<cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
						<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)
					</td>
				</tr>
			</cfif>
				<tr>
            		<td colspan="5">
			  		<div align="right">
                    <input type="button" name="checkall" value="Check all" onClick="javascript:for (i = 0; i < document.updatepage.checkbox.length; i++)
document.updatepage.checkbox[i].checked=true;">
		  	    		<input type="reset" name="Submit2" value="Reset">
                		<input type="submit" name="Submit" value="Submit">
              		</div>
					</td>
          		</tr>
        	</table>
</cfoutput>