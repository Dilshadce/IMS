<html>
<head>
<title>Customer Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>

<cfquery datasource='#dts#' name="getgeneral">
	Select lsize as layer from gsetup
</cfquery>

<script language="JavaScript">

function makehour(dayvar)
{
	
	var timefrom = parseFloat(document.getElementById('starthr'+dayvar).value);
	var minfrom = (parseFloat(document.getElementById('startmin'+dayvar).value)/60+0.000001).toFixed(3);
	
	timefrom = parseFloat(timefrom) + parseFloat(minfrom);
	
	var timeto = parseFloat(document.getElementById('endhr'+dayvar).value);
	var minto = (parseFloat(document.getElementById('endmin'+dayvar).value)/60+0.000001).toFixed(3);

	timeto = parseFloat(timeto) + parseFloat(minto);
	
	if(timefrom <= timeto)
	{
		var totalindex =  parseFloat(timeto) - parseFloat(timefrom);
	}
	else
	{
		var totalindex = document.getElementById('starthr'+dayvar).options.length-parseFloat(timefrom) + parseFloat(timeto);
	}
	
	
	var totalhour = parseFloat((parseFloat(totalindex)+0.000001).toFixed(2));
	
	if(document.getElementById('breakh'+dayvar).value == '')
	{
		document.getElementById('workh'+dayvar).value = totalhour;
	}
	else
	{
	document.getElementById('workh'+dayvar).value = totalhour-parseFloat(document.getElementById('breakh'+dayvar).value);
	}
}


	function validate()
	{	<cfoutput>
		if(document.CustomerForm.sizeid.value=='') <!--- QCH if(document.sizeidtable2Form.sizeid.value=='') --->
		{
			alert("Your #getgeneral.layer#'s No. cannot be blank.");
			document.CustomerForm.sizeid.focus();
			return false;
		}
		</cfoutput>
		return true;
	}
	
</script>

<body>
			
		<cfoutput>
			<cfif #url.type# eq "Edit">
				<cfquery datasource='#dts#' name="getitem">
					Select * from icsizeid where sizeid='#url.sizeid#'
				</cfquery>
				<cfset sizeid=#getitem.sizeid#>
				<cfset desp=#getitem.desp#>
				<cfset size1=#getitem.size1#>
                <cfset size2=#getitem.size2#>
                <cfset size3=#getitem.size3#>
                <cfset size4=#getitem.size4#>
                <cfset size5=#getitem.size5#>
                <cfset size6=#getitem.size6#>
                <cfset size7=#getitem.size7#>
                <cfset size8=#getitem.size8#>
                <cfset size9=#getitem.size9#>
                <cfset size10=#getitem.size10#>
                <cfset size11=#getitem.size11#>
                <cfset size12=#getitem.size12#>
                <cfset size13=#getitem.size13#>
                <cfset size14=#getitem.size14#>
                <cfset size15=#getitem.size15#>
                <cfset size16=#getitem.size16#>
                <cfset size17=#getitem.size17#>
                <cfset size18=#getitem.size18#>
                <cfset size19=#getitem.size19#>
                <cfset size20=#getitem.size20#>
                <cfset size21=#getitem.size21#>
                <cfset size22=#getitem.size22#>
                <cfset size23=#getitem.size23#>
                <cfset size24=#getitem.size24#>
                <cfset size25=#getitem.size25#>
                <cfset size26=#getitem.size26#>
                <cfset size27=#getitem.size27#>
                <cfset size28=#getitem.size28#>
                <cfset size29=#getitem.size29#>
                <cfset size30=#getitem.size30#>
				<cfset mode="Edit">
				<cfset title="Edit Item">
				<cfset button="Edit">
				<cfloop from="1" to="7" index="i">
                <cfset "daytype#i#" = evaluate('getitem.daytype#i#')>
                <cfset "starttime#i#" = evaluate('getitem.starttime#i#')>
                <cfset "endtime#i#" = evaluate('getitem.endtime#i#')>
                <cfset "breakh#i#" = evaluate('getitem.breakh#i#')>
                <cfset "workh#i#" = evaluate('getitem.workh#i#')>
                </cfloop>
                
                <cfset typelist = "WD,OD,RD,PH">
                <cfloop list="#typelist#" index="i">
                <cfloop from="1" to="8" index="a">
                <cfset "#i#OT#a#" = evaluate('getitem.#i#OT#a#')>
                </cfloop>
                </cfloop>
                
                <cfloop from="1" to="30" index="i">
                <cfif evaluate('getitem.phdate#i#') neq "">
				<cfset "phdate#i#" = dateformat(evaluate('getitem.phdate#i#'),'dd/mm/yyyy')>
                <cfelse>
                <cfset "phdate#i#" = "">
                </cfif>
                <cfset "phdesp#i#" = evaluate('getitem.phdesp#i#')>
                </cfloop>
				
			</cfif>
			<cfif #url.type# eq "Delete">
				<cfquery datasource='#dts#' name="getitem">
					Select * from icsizeid where sizeid='#url.sizeid#'
				</cfquery>
				<cfset sizeid=#getitem.sizeid#>
				<cfset desp=#getitem.desp#>
				<cfset size1=#getitem.size1#>
                <cfset size2=#getitem.size2#>
                <cfset size3=#getitem.size3#>
                <cfset size4=#getitem.size4#>
                <cfset size5=#getitem.size5#>
                <cfset size6=#getitem.size6#>
                <cfset size7=#getitem.size7#>
                <cfset size8=#getitem.size8#>
                <cfset size9=#getitem.size9#>
                <cfset size10=#getitem.size10#>
                <cfset size11=#getitem.size11#>
                <cfset size12=#getitem.size12#>
                <cfset size13=#getitem.size13#>
                <cfset size14=#getitem.size14#>
                <cfset size15=#getitem.size15#>
                <cfset size16=#getitem.size16#>
                <cfset size17=#getitem.size17#>
                <cfset size18=#getitem.size18#>
                <cfset size19=#getitem.size19#>
                <cfset size20=#getitem.size20#>
                <cfset size21=#getitem.size21#>
                <cfset size22=#getitem.size22#>
                <cfset size23=#getitem.size23#>
                <cfset size24=#getitem.size24#>
                <cfset size25=#getitem.size25#>
                <cfset size26=#getitem.size26#>
                <cfset size27=#getitem.size27#>
                <cfset size28=#getitem.size28#>
                <cfset size29=#getitem.size29#>
                <cfset size30=#getitem.size30#>
				<cfset mode="Delete">
				<cfset title="Delete Item">
				<cfset button="Delete">
                <cfloop from="1" to="7" index="i">
                <cfset "daytype#i#" = evaluate('getitem.daytype#i#')>
                <cfset "starttime#i#" = evaluate('getitem.starttime#i#')>
                <cfset "endtime#i#" = evaluate('getitem.endtime#i#')>
                <cfset "breakh#i#" = evaluate('getitem.breakh#i#')>
                <cfset "workh#i#" = evaluate('getitem.workh#i#')>
                </cfloop>
						
                <cfset typelist = "WD,OD,RD,PH">
                <cfloop list="#typelist#" index="i">
                <cfloop from="1" to="8" index="a">
                <cfset "#i#OT#a#" = evaluate('getitem.#i#OT#a#')>
                </cfloop>
                </cfloop>
                
                 <cfloop from="1" to="30" index="i">
                <cfif evaluate('getitem.phdate#i#') neq "">
				<cfset "phdate#i#" = dateformat(evaluate('getitem.phdate#i#'),'dd/mm/yyyy')>
                <cfelse>
                <cfset "phdate#i#" = "">
                </cfif>
                <cfset "phdesp#i#" = evaluate('getitem.phdesp#i#')>
                </cfloop>
				
			</cfif>
			
			
  <cfif #url.type# eq "Create">   
    
    			<cfset sizeid="">
				<cfset desp="">
				<cfset size1=''>
                <cfset size2=''>
                <cfset size3=''>
                <cfset size4=''>
                <cfset size5=''>
                <cfset size6=''>
                <cfset size7=''>
                <cfset size8=''>
                <cfset size9=''>
                <cfset size10=''>
                <cfset size11=''>
                <cfset size12=''>
                <cfset size13=''>
                <cfset size14=''>
                <cfset size15=''>
                <cfset size16=''>
                <cfset size17=''>
                <cfset size18=''>
                <cfset size19=''>
                <cfset size20=''>
                <cfset size21=''>
                <cfset size22=''>
                <cfset size23=''>
                <cfset size24=''>
                <cfset size25=''>
                <cfset size26=''>
                <cfset size27=''>
                <cfset size28=''>
                <cfset size29=''>
                <cfset size30=''>
                
                
				<cfset mode="Create">
				<cfset title="Create Item">
				<cfset button="Create">
                
                <cfloop from="1" to="7" index="i">
                <cfset "daytype#i#" = "WD">
                <cfset "starttime#i#" = "00:00">
                <cfset "endtime#i#" = "00:00">
                <cfset "breakh#i#" = "0">
                <cfset "workh#i#" = "0">
                </cfloop>
                
                <cfset typelist = "WD,OD,RD,PH">
                <cfloop list="#typelist#" index="i">
                <cfloop from="1" to="8" index="a">
                <cfset "#i#OT#a#" = 0>
                </cfloop>
                </cfloop>
                
                <cfloop from="1" to="30" index="i">
                <cfset "phdate#i#" = "">
                <cfset "phdesp#i#" = "">
                </cfloop>
			
			</cfif>

			<h1>#title#</h1>
			
  <h4><cfif getpin2.h1610 eq 'T'><a href="sizeidtable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif><cfif getpin2.h1620 eq 'T'>|| <a href="sizeidtable.cfm?">List 
    all #getgeneral.layer#</a> </cfif><cfif getpin2.h1630 eq 'T'>|| <a href="s_sizeidtable.cfm?type=icsizeid">Search For #getgeneral.layer#</a></cfif>
   <cfif getpin2.h1630 eq 'T'>|| <a href="p_size.cfm">#getgeneral.layer# Listing </a></cfif></h4>
</cfoutput>

<cfform name="CustomerForm" action="sizeidprocess.cfm" method="post" onsubmit="return validate()">
	<cfoutput><input type="hidden" name="mode" value="#mode#">
					
	
  <h1 align="center">#getgeneral.layer# Maintenance</h1></cfoutput>
  	
  <table align="center" class="data" width="450">
    <cfoutput> 
      <tr> 
        <td width="20%" nowrap>#getgeneral.layer# :</td>
        <td> <cfif mode eq "Delete" or mode eq "Edit">
            <!--- <h2>#url.sizeid#</h2> --->
            <input type="text" size="40" name="sizeid" value="#url.sizeid#" readonly>
            <cfelse>
            <input type="text" size="40" name="sizeid" value="#sizeid#" maxlength="40">
          </cfif> </td>
      </tr>
      <tr> 
        <td>Description :</td>
        <td><input type="text" size="40" name="desp" value="#desp#" maxlength="40"></td>
      </tr>
      <tr>
      <th colspan="100%"><div align="center">Work Hours</div></th>
      </tr>
      <tr> 
        <td colspan="100%">
        <cfset typelist = "WD,OD,RD">
        <table>
        <tr>
        <th>Type</th>
        <th>Day</th>
        <th>Start Time</th>
        <th>End Time</th>
        <th>Break Time Hour</th>
        <th>Daily Work Hour</th>
        </tr>
        <cfloop from="1" to="7" index="i">
        <tr>
        <td>
        <select name="daytype#i#" id="daytype#i#">
        <cfloop list="#typelist#" index="a">
        <option value="#a#" <cfif evaluate('daytype#i#') eq a>Selected</cfif>>#a#</option>
        </cfloop>
        </select>
        </td>
        <td>
        #DayOfWeekAsString(i)#
        </td>
        <td>
        <select name="starthr#i#" id="starthr#i#" onChange="makehour('#i#');">
                <cfloop from="0" to="23" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif left(evaluate('starttime#i#'),2) eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
        </select>
        <select name="startmin#i#" id="startmin#i#" onChange="makehour('#i#');">
                <cfloop from="0" to="59" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif right(evaluate('starttime#i#'),2) eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
         </select>
        </td>
         <td>
        <select name="endhr#i#" id="endhr#i#" onChange="makehour('#i#');">
                <cfloop from="0" to="23" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif left(evaluate('endtime#i#'),2) eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
        </select>
        <select name="endmin#i#" id="endmin#i#" onChange="makehour('#i#');">
                <cfloop from="0" to="59" index="aaa">
                <option value="#numberformat(aaa,'00')#" <cfif right(evaluate('endtime#i#'),2) eq numberformat(aaa,'00')>Selected</cfif>>#numberformat(aaa,'00')#</option>
                </cfloop>
         </select>
        </td>
        <td>
        <input type="text" name="breakh#i#" id="breakh#i#" value="#val(evaluate('breakh#i#'))#" size="5" onkeyup="makehour('#i#');">
        </td>
        <td>
        <input type="text" name="workh#i#" id="workh#i#" value="#evaluate('workh#i#')#" size="5" readonly>
        </td>
        </tr>
        </cfloop>
        </table>
        </td>
      </tr>
      <tr>
      <th colspan="100%">
      <div align="center">Over Time Formulation</div>
      </th>
      </tr>
      <tr>
      <td colspan="100%">
      <cfset typelist = "WD,OD,RD,PH">
      <table>
      <tr>
      <th>Day</th>
      <th>OT 1.0</th>
      <th>OT 1.5</th>
      <th>OT 2.0</th>
      <th>OT 3.0</th>
      <th>RD 1.0</th>
      <th>RD 2.0</th>
      <th>PH 1.0</th>
      <th>PH 2.0</th>
      </tr>
      <cfloop list="#typelist#" index="i">
      <tr>
      <td>#i#</td>
      <cfloop from="1" to="8" index="a">
      <td>
      <input type="text" name="#i#ot#a#" id="#i#ot#a#" value="#evaluate('#i#ot#a#')#" size="5">
      </td>
      </cfloop>
      </tr>
      </cfloop>
      </table>
      </td>
      </tr>
      <tr>
      <th colspan="100%"><div align="center">Public Holiday</div></th>
      </tr>
      <tr>
      <td colspan="100%">
      <table>
      <tr>
      <th>Date</th>
      <th>Desp</th>
      </tr>
      <cfloop from="1" to="30" index="i">
      <tr>
      <td>
      <input type="text" name="phdate#i#" id="phdate#i#" value="#evaluate('phdate#i#')#" readonly>&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('phdate#i#'));">
      </td>
      <td>
      <input type="text" name="phdesp#i#" id="phdesp#i#" value="#evaluate('phdesp#i#')#" size="40" maxlength="45">
      </td>
      </tr>
      </cfloop>
      </table>
      </td>
      </tr>
      
    </cfoutput> <!--- QCH <CFOUTPUT> </CFOUTPUT> <CFOUTPUT> </CFOUTPUT> <CFOUTPUT> </CFOUTPUT> 
    <CFOUTPUT> </CFOUTPUT> <cfoutput> </cfoutput> <cfoutput> </cfoutput> <cfoutput> 
    </cfoutput> <cfoutput> </cfoutput> <cfoutput> </cfoutput> ---> 
	<cfoutput> 
      <tr> 
        <td colspan="100%" align="center"><input name="submit" type="submit" value="  #button#  "></td>
      </tr>
    </cfoutput> 
  </table>
  <br>
  
  <table align="center" class="data" width="450" style="display:none">
    <cfoutput> 
     <tr>
     <th>Size 1</th>
     <td><input type="text" size="40" name="size1" value="#size1#" maxlength="40"></td>
     <th>Size 11</th>
     
     <td><input type="text" size="40" name="size11" value="#size11#" maxlength="40"></td>
     <th>Size 21</th>
     <td><input type="text" size="40" name="size21" value="#size21#" maxlength="40"></td>
    
     </tr>
     
     <tr>
     <th>Size 2</th>
     <td><input type="text" size="40" name="size2" value="#size2#" maxlength="40"></td>
     <th>Size 12</th>
     
     <td><input type="text" size="40" name="size12" value="#size12#" maxlength="40"></td>
     <th>Size 22</th>
     <td><input type="text" size="40" name="size22" value="#size22#" maxlength="40"></td>
    
     </tr>
     
     <tr>
     <th>Size 3</th>
     <td><input type="text" size="40" name="size3" value="#size3#" maxlength="40"></td>
     <th>Size 13</th>
     
     <td><input type="text" size="40" name="size13" value="#size13#" maxlength="40"></td>
     <th>Size 23</th>
     <td><input type="text" size="40" name="size23" value="#size23#" maxlength="40"></td>
    
     </tr>
     
     
     <tr>
     <th>Size 4</th>
     <td><input type="text" size="40" name="size4" value="#size4#" maxlength="40"></td>
     <th>Size 14</th>
     
     <td><input type="text" size="40" name="size14" value="#size14#" maxlength="40"></td>
     <th>Size 24</th>
     <td><input type="text" size="40" name="size24" value="#size24#" maxlength="40"></td>
    
     </tr>
     
     
     <tr>
     <th>Size 5</th>
     <td><input type="text" size="40" name="size5" value="#size5#" maxlength="40"></td>
     <th>Size 15</th>
     
     <td><input type="text" size="40" name="size15" value="#size15#" maxlength="40"></td>
     <th>Size 25</th>
     <td><input type="text" size="40" name="size25" value="#size25#" maxlength="40"></td>
    
     </tr>
     
     <tr>
     <th>Size 6</th>
     <td><input type="text" size="40" name="size6" value="#size6#" maxlength="40"></td>
     <th>Size 16</th>
     
     <td><input type="text" size="40" name="size16" value="#size16#" maxlength="40"></td>
     <th>Size 26</th>
     <td><input type="text" size="40" name="size26" value="#size26#" maxlength="40"></td>
    
     </tr>
     
     
     <tr>
     <th>Size 7</th>
     <td><input type="text" size="40" name="size7" value="#size7#" maxlength="40"></td>
     <th>Size 17</th>
     
     <td><input type="text" size="40" name="size17" value="#size17#" maxlength="40"></td>
     <th>Size 27</th>
     <td><input type="text" size="40" name="size27" value="#size27#" maxlength="40"></td>
    
     </tr>
     
     <tr>
     <th>Size 8</th>
     <td><input type="text" size="40" name="size8" value="#size8#" maxlength="40"></td>
     <th>Size 18</th>
     
     <td><input type="text" size="40" name="size18" value="#size18#" maxlength="40"></td>
     <th>Size 28</th>
     <td><input type="text" size="40" name="size28" value="#size28#" maxlength="40"></td>
    
     </tr>
     
     <tr>
     <th>Size 9</th>
     <td><input type="text" size="40" name="size9" value="#size9#" maxlength="40"></td>
     <th>Size 19</th>
     
     <td><input type="text" size="40" name="size19" value="#size19#" maxlength="40"></td>
     <th>Size 29</th>
     <td><input type="text" size="40" name="size28" value="#size29#" maxlength="40"></td>
    
     </tr>
     
     
     <tr>
     <th>Size 10</th>
     <td><input type="text" size="40" name="size10" value="#size10#" maxlength="40"></td>
     <th>Size 20</th>
     
     <td><input type="text" size="40" name="size20" value="#size20#" maxlength="40"></td>
     <th>Size 30</th>
     <td><input type="text" size="40" name="size30" value="#size30#" maxlength="40"></td>
    
     </tr>
     
    </cfoutput> 
  </table>
  
</cfform>
			
</body>
</html>
