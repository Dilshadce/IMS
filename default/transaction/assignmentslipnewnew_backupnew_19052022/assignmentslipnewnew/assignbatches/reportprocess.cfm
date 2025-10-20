<cfoutput>
    <script type="text/javascript">
function markallbox(boxcheck)
{
	var checkboxelement = document.getElementsByTagName('input');
	if(boxcheck == true)
	{	
		for(var i=0;i<checkboxelement.length;i++)
		{
			checkboxelement[i].checked = true;
		}
	}
	else
	{
		for(var i=0;i<=checkboxelement.length-1;i++)
		{
			checkboxelement[i].checked = false;
		}
	}

}    
    
function markallboxbycustname(checkbox,value)
{
	var checkboxelement = document.getElementsByClassName(value);

    
	if(checkbox == true)
	{	
		for(var i=0;i<checkboxelement.length;i++)
		{
			checkboxelement[i].checked = true;
            
		}
	}
	else
	{
		for(var i=0;i<=checkboxelement.length-1;i++)
		{
			checkboxelement[i].checked = false;
            
		}
	}

}  
 
// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("myBtn").style.display = "block";
    } else {
        document.getElementById("myBtn").style.display = "none";
    }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
}
        
</script> 
<style>
##myBtn {
    display: none; /* Hidden by default */
    position: fixed; /* Fixed/sticky position */
    bottom: 20px; /* Place the button at the bottom of the page */
    right: 30px; /* Place the button 30px from the right */
    z-index: 99; /* Make sure it does not overlap */
    border: none; /* Remove borders */
    outline: none; /* Remove outline */
    background-color: ##00abcc; /* Set a background color */
    color: white; /* Text color */
    cursor: pointer; /* Add a mouse pointer on hover */
    padding: 15px; /* Some padding */
    border-radius: 10px; /* Rounded corners */
    font-size: 18px; /* Increase font size */
}
</style>
    
<cfset datestart = createdate(listlast(form.datefrom,'/'),listgetat(form.datefrom,'2','/'),listfirst(form.datefrom,'/'))>
  <cfset dateend = createdate(listlast(form.dateto,'/'),listgetat(form.dateto,'2','/'),listfirst(form.dateto,'/'))>
   

<cfif form.paymeth neq "">
<cfquery name="getempno" datasource="#replace(dts,'_i','_p')#">
SELECT empno FROM pmast WHERE paymeth = "#form.paymeth#"
</cfquery>  
</cfif>
<cfquery name="getassign" datasource="#dts#">
SELECT * FROM assignmentslip
WHERE (batches = "" or batches is null)
and paydate = "#form.paydate#"
and assignmentslipdate BETWEEN "#dateformat(datestart,'YYYY-MM-DD')#" and "#dateformat(dateend,'YYYY-MM-DD')#"
<cfif form.paymeth neq "">
and empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempno.empno)#" separator="," list="yes">)
</cfif>
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
and empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
<cfif form.placementfrom neq "" and form.placementto neq "">
and Placementno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementto#">
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
ORDER BY custname,branch    
</cfquery>
<h1>Assign Batches</h1>
<h3>Giro Pay Date : #form.giropaydate#</h3>
    
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
    
<form name="markassignment" id="markassignment" action="/default/transaction/assignmentslipnewnew//assignbatches/markassign.cfm" method="post">
<input type="hidden" name="giropaydate" id="giropaydate" value="#form.giropaydate#" />
<table cellpadding=5px border="0" align="center" width="80%" class="data">
<tr>
<th>No.</th>
<th>Ref No</th>
<th>Date</th>
<th>Customer</th>
<th>Emp No</th>
<th>Name</th>
<th>Placement No</th>
<th>Entity</th>
<th><input type="checkbox" name="markall" id="markall" onchange="markallbox(this.checked);"  />Mark All</th>    
</tr> 
<tr>
<td colspan="9"><hr></td>
</tr>  
<cfset tempcust = "">
<cfset tempentity = "">
    
<cfloop query="getassign">
 
<cfif getassign.custname neq tempcust or getassign.branch neq tempentity>
    <tr>
        <td colspan="3">
        </td>
        <th>#getassign.custname#</th> 
        
        <td colspan="3">
        </td>
        <th>#getassign.branch#</th> 
        <cfset classname = ReReplaceNoCase(getassign.custname&getassign.branch,'[^a-zA-Z\\,]','','ALL')>
     <th><input type="checkbox" name="checkboxcustname" id="checkboxcustname"  value="#classname#" onchange="markallboxbycustname(this.checked,this.value);" ></th>
    </tr>
    <cfset tempcust = getassign.custname>
    <cfset tempentity = getassign.branch> 
            

</cfif>        
<tr>
<td>#getassign.currentrow#</td>    
<td>#getassign.refno#</td>
<td>#dateformat(getassign.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getassign.custname#</td>    
<td>#getassign.empno#</td>
<td>#getassign.empname#</td> 
<td>#getassign.placementno#</td>
<cfif getassign.branch eq 'mbs'>
    <td style="color: red"><strong>#getassign.branch#</strong></td>
<cfelseif getassign.branch eq 'tc'>
    <td style="color: deepskyblue"><strong>#getassign.branch#</strong></td>
<cfelse>
    <td><strong>#getassign.branch#</strong></td>
</cfif>
<td>

<input type="checkbox" name="asnrefno" id="asnrefno" class="#classname#" value="#getassign.refno#" />    
</td>    
</tr>
</cfloop>  
<td colspan="100%" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Assign" />
      
</td>
</tr>
</table>
</form>
</cfoutput>