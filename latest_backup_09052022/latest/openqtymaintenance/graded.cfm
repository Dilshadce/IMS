<cfif isdefined("form.submit") and form.submit eq "Submit">
	<script language="javascript" type="text/javascript">
		var a = confirm("Are You Sure ?");
		if(a == false)
		{
			javascript:history.back();
		}
	</script>
	
	<cfupdate datasource="#dts#" tablename="itemgrd" 
	formfields="itemno,grd11,grd12,grd13,grd14,grd15,grd16,grd17,grd18,grd19,grd20,
						grd21,grd22,grd23,grd24,grd25,grd26,grd27,grd28,grd29,grd30,
						grd31,grd32,grd33,grd34,grd35,grd36,grd37,grd38,grd39,grd40,
						grd41,grd42,grd43,grd44,grd45,grd46,grd47,grd48,grd49,grd50,
						grd51,grd52,grd53,grd54,grd55,grd56,grd57,grd58,grd59,grd60,
						grd61,grd62,grd63,grd64,grd65,grd66,grd67,grd68,grd69,grd70">
						
	<cfset sumgrd = form.grd11 + form.grd12 + form.grd13 + form.grd14 + form.grd15 + form.grd16 + form.grd17 + form.grd18 + form.grd19 + form.grd20 +
					form.grd21 + form.grd22 + form.grd23 + form.grd24 + form.grd25 + form.grd26 + form.grd27 + form.grd28 + form.grd29 + form.grd30 +
					form.grd31 + form.grd32 + form.grd33 + form.grd34 + form.grd35 + form.grd36 + form.grd37 + form.grd38 + form.grd39 + form.grd40 +
					form.grd41 + form.grd42 + form.grd43 + form.grd44 + form.grd45 + form.grd46 + form.grd47 + form.grd48 + form.grd49 + form.grd50 +
					form.grd51 + form.grd52 + form.grd53 + form.grd54 + form.grd55 + form.grd56 + form.grd57 + form.grd58 + form.grd59 + form.grd60 +
					form.grd61 + form.grd62 + form.grd63 + form.grd64 + form.grd65 + form.grd66 + form.grd67 + form.grd68 + form.grd69 + form.grd70>
					
	<cfquery name="updateicitem" datasource="#dts#">
		update icitem set 
		qtybf='#sumgrd#' 
		where itemno='#form.itemno#';
	</cfquery>
	
	<form name="done" action="fifoopq.cfm" method="post"></form>
	<script>
		done.submit();
	</script>
</cfif>

<html>
<head>
<title>Graded Item Quantity Maintenance</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="getitem" datasource="#dts#">
	select * 
	from itemgrd 
	where itemno='#form.itemno#';
</cfquery>

<cfquery name="getitemgrd" datasource="#dts#">
	select * 
	from icgroup 
	where wos_group=(select wos_group from itemgrd where itemno='#form.itemno#');
</cfquery>

<cfoutput>
<h1 align="center">Enter Graded Item Qty B/F For Item <font color="red">#form.itemno#</font></h1>

<cfform name="grademaintenance" action="graded.cfm" method="post">
<table align="center" class="data" width="600">
	<tr align="center">
		<cfif getitemgrd.gradd11 eq "">
			<td>1  .<cfinput name="grd11" validate="float" message="Please Enter Correct Quantity In Field 1 !" type="text" value="#numberformat(getitem.grd11,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>1  .<cfinput name="grd11" validate="float" message="Please Enter Correct Quantity In Field 1 !" type="text" value="#numberformat(getitem.grd11,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd11 + getitem.bgrd11,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd26 eq "">
			<td>16.<cfinput name="grd26" validate="float" message="Please Enter Correct Quantity In Field 16 !" type="text" value="#numberformat(getitem.grd26,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>16.<cfinput name="grd26" validate="float" message="Please Enter Correct Quantity In Field 16 !" type="text" value="#numberformat(getitem.grd26,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd26 + getitem.bgrd26,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd41 eq "">
			<td>31.<cfinput name="grd41" validate="float" message="Please Enter Correct Quantity In Field 31 !" type="text" value="#numberformat(getitem.grd41,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>31.<cfinput name="grd41" validate="float" message="Please Enter Correct Quantity In Field 31 !" type="text" value="#numberformat(getitem.grd41,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd41 + getitem.bgrd41,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd56 eq "">
			<td>46.<cfinput name="grd56" validate="float" message="Please Enter Correct Quantity In Field 46 !" type="text" value="#numberformat(getitem.grd56,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>46.<cfinput name="grd56" validate="float" message="Please Enter Correct Quantity In Field 46 !" type="text" value="#numberformat(getitem.grd56,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd56 + getitem.bgrd56,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd12 eq "">
			<td>2  .<cfinput name="grd12" validate="float" message="Please Enter Correct Quantity In Field 2 !" type="text" value="#numberformat(getitem.grd12,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>2  .<cfinput name="grd12" validate="float" message="Please Enter Correct Quantity In Field 2 !" type="text" value="#numberformat(getitem.grd12,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd12 + getitem.bgrd12,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd27 eq "">
			<td>17.<cfinput name="grd27" validate="float" message="Please Enter Correct Quantity In Field 17 !" type="text" value="#numberformat(getitem.grd27,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>17.<cfinput name="grd27" validate="float" message="Please Enter Correct Quantity In Field 17 !" type="text" value="#numberformat(getitem.grd27,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd27 + getitem.bgrd27,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd42 eq "">
			<td>32.<cfinput name="grd42" validate="float" message="Please Enter Correct Quantity In Field 32 !" type="text" value="#numberformat(getitem.grd42,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>32.<cfinput name="grd42" validate="float" message="Please Enter Correct Quantity In Field 32 !" type="text" value="#numberformat(getitem.grd42,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd42 + getitem.bgrd42,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd57 eq "">
			<td>47.<cfinput name="grd57" validate="float" message="Please Enter Correct Quantity In Field 47 !" type="text" value="#numberformat(getitem.grd57,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>47.<cfinput name="grd57" validate="float" message="Please Enter Correct Quantity In Field 47 !" type="text" value="#numberformat(getitem.grd57,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd57 + getitem.bgrd57,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd13 eq "">
			<td>3  .<cfinput name="grd13" validate="float" message="Please Enter Correct Quantity In Field 3 !" type="text" value="#numberformat(getitem.grd13,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>3  .<cfinput name="grd13" validate="float" message="Please Enter Correct Quantity In Field 3 !" type="text" value="#numberformat(getitem.grd13,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd13 + getitem.bgrd13,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd28 eq "">
			<td>18.<cfinput name="grd28" validate="float" message="Please Enter Correct Quantity In Field 18 !" type="text" value="#numberformat(getitem.grd28,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>18.<cfinput name="grd28" validate="float" message="Please Enter Correct Quantity In Field 18 !" type="text" value="#numberformat(getitem.grd28,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd28 + getitem.bgrd28,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd43 eq "">
			<td>33.<cfinput name="grd43" validate="float" message="Please Enter Correct Quantity In Field 33 !" type="text" value="#numberformat(getitem.grd43,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>33.<cfinput name="grd43" validate="float" message="Please Enter Correct Quantity In Field 33 !" type="text" value="#numberformat(getitem.grd43,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd43 + getitem.bgrd43,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd58 eq "">
			<td>48.<cfinput name="grd58" validate="float" message="Please Enter Correct Quantity In Field 48 !" type="text" value="#numberformat(getitem.grd58,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>48.<cfinput name="grd58" validate="float" message="Please Enter Correct Quantity In Field 48 !" type="text" value="#numberformat(getitem.grd58,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd58 + getitem.bgrd58,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd14 eq "">
			<td>4  .<cfinput name="grd14" validate="float" message="Please Enter Correct Quantity In Field 4 !" type="text" value="#numberformat(getitem.grd14,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>4  .<cfinput name="grd14" validate="float" message="Please Enter Correct Quantity In Field 4 !" type="text" value="#numberformat(getitem.grd14,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd14 + getitem.bgrd14,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd29 eq "">
			<td>19.<cfinput name="grd29" validate="float" message="Please Enter Correct Quantity In Field 19 !" type="text" value="#numberformat(getitem.grd29,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>19.<cfinput name="grd29" validate="float" message="Please Enter Correct Quantity In Field 19 !" type="text" value="#numberformat(getitem.grd29,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd29 + getitem.bgrd29,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd44 eq "">
			<td>34.<cfinput name="grd44" validate="float" message="Please Enter Correct Quantity In Field 34 !" type="text" value="#numberformat(getitem.grd44,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>34.<cfinput name="grd44" validate="float" message="Please Enter Correct Quantity In Field 34 !" type="text" value="#numberformat(getitem.grd44,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd44 + getitem.bgrd44,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd59 eq "">
			<td>49.<cfinput name="grd59" validate="float" message="Please Enter Correct Quantity In Field 49 !" type="text" value="#numberformat(getitem.grd59,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>49.<cfinput name="grd59" validate="float" message="Please Enter Correct Quantity In Field 49 !" type="text" value="#numberformat(getitem.grd59,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd59 + getitem.bgrd59,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd15 eq "">
			<td>5  .<cfinput name="grd15" validate="float" message="Please Enter Correct Quantity In Field 5 !" type="text" value="#numberformat(getitem.grd15,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>5  .<cfinput name="grd15" validate="float" message="Please Enter Correct Quantity In Field 5 !" type="text" value="#numberformat(getitem.grd15,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd15 + getitem.bgrd15,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd30 eq "">
			<td>20.<cfinput name="grd30" validate="float" message="Please Enter Correct Quantity In Field 20 !" type="text" value="#numberformat(getitem.grd30,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>20.<cfinput name="grd30" validate="float" message="Please Enter Correct Quantity In Field 20 !" type="text" value="#numberformat(getitem.grd30,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd30 + getitem.bgrd30,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd45 eq "">
			<td>35.<cfinput name="grd45" validate="float" message="Please Enter Correct Quantity In Field 35 !" type="text" value="#numberformat(getitem.grd45,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>35.<cfinput name="grd45" validate="float" message="Please Enter Correct Quantity In Field 35 !" type="text" value="#numberformat(getitem.grd45,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd45 + getitem.bgrd45,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd60 eq "">
			<td>50.<cfinput name="grd60" validate="float" message="Please Enter Correct Quantity In Field 50 !" type="text" value="#numberformat(getitem.grd60,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>50.<cfinput name="grd60" validate="float" message="Please Enter Correct Quantity In Field 50 !" type="text" value="#numberformat(getitem.grd60,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd60 + getitem.bgrd60,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd16 eq "">
			<td>6  .<cfinput name="grd16" validate="float" message="Please Enter Correct Quantity In Field 6 !" type="text" value="#numberformat(getitem.grd16,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>6  .<cfinput name="grd16" validate="float" message="Please Enter Correct Quantity In Field 6 !" type="text" value="#numberformat(getitem.grd16,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd16 + getitem.bgrd16,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd31 eq "">
			<td>21.<cfinput name="grd31" validate="float" message="Please Enter Correct Quantity In Field 21 !" type="text" value="#numberformat(getitem.grd31,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>21.<cfinput name="grd31" validate="float" message="Please Enter Correct Quantity In Field 21 !" type="text" value="#numberformat(getitem.grd31,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd31 + getitem.bgrd31,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd46 eq "">
			<td>36.<cfinput name="grd46" validate="float" message="Please Enter Correct Quantity In Field 36 !" type="text" value="#numberformat(getitem.grd46,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>36.<cfinput name="grd46" validate="float" message="Please Enter Correct Quantity In Field 36 !" type="text" value="#numberformat(getitem.grd46,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd46 + getitem.bgrd46,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd61 eq "">
			<td>51.<cfinput name="grd61" validate="float" message="Please Enter Correct Quantity In Field 51 !" type="text" value="#numberformat(getitem.grd61,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>51.<cfinput name="grd61" validate="float" message="Please Enter Correct Quantity In Field 51 !" type="text" value="#numberformat(getitem.grd61,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd61 + getitem.bgrd61,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd17 eq "">
			<td>7  .<cfinput name="grd17" validate="float" message="Please Enter Correct Quantity In Field 7 !" type="text" value="#numberformat(getitem.grd17,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>7  .<cfinput name="grd17" validate="float" message="Please Enter Correct Quantity In Field 7 !" type="text" value="#numberformat(getitem.grd17,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd17 + getitem.bgrd17,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd32 eq "">
			<td>22.<cfinput name="grd32" validate="float" message="Please Enter Correct Quantity In Field 22 !" type="text" value="#numberformat(getitem.grd32,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>22.<cfinput name="grd32" validate="float" message="Please Enter Correct Quantity In Field 22 !" type="text" value="#numberformat(getitem.grd32,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd32 + getitem.bgrd32,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd47 eq "">
			<td>37.<cfinput name="grd47" validate="float" message="Please Enter Correct Quantity In Field 37 !" type="text" value="#numberformat(getitem.grd47,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>37.<cfinput name="grd47" validate="float" message="Please Enter Correct Quantity In Field 37 !" type="text" value="#numberformat(getitem.grd47,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd47 + getitem.bgrd47,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd62 eq "">
			<td>52.<cfinput name="grd62" validate="float" message="Please Enter Correct Quantity In Field 52 !" type="text" value="#numberformat(getitem.grd62,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>52.<cfinput name="grd62" validate="float" message="Please Enter Correct Quantity In Field 52 !" type="text" value="#numberformat(getitem.grd62,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd62 + getitem.bgrd62,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd18 eq "">
			<td>8  .<cfinput name="grd18" validate="float" message="Please Enter Correct Quantity In Field 8 !" type="text" value="#numberformat(getitem.grd18,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>8  .<cfinput name="grd18" validate="float" message="Please Enter Correct Quantity In Field 8 !" type="text" value="#numberformat(getitem.grd18,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd18 + getitem.bgrd18,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd33 eq "">
			<td>23.<cfinput name="grd33" validate="float" message="Please Enter Correct Quantity In Field 23 !" type="text" value="#numberformat(getitem.grd33,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>23.<cfinput name="grd33" validate="float" message="Please Enter Correct Quantity In Field 23 !" type="text" value="#numberformat(getitem.grd33,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd33 + getitem.bgrd33,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd48 eq "">
			<td>38.<cfinput name="grd48" validate="float" message="Please Enter Correct Quantity In Field 38 !" type="text" value="#numberformat(getitem.grd48,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>38.<cfinput name="grd48" validate="float" message="Please Enter Correct Quantity In Field 38 !" type="text" value="#numberformat(getitem.grd48,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd48 + getitem.bgrd48,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd63 eq "">
			<td>53.<cfinput name="grd63" validate="float" message="Please Enter Correct Quantity In Field 53 !" type="text" value="#numberformat(getitem.grd63,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>53.<cfinput name="grd63" validate="float" message="Please Enter Correct Quantity In Field 53 !" type="text" value="#numberformat(getitem.grd63,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd63 + getitem.bgrd63,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd19 eq "">
			<td>9  .<cfinput name="grd19" validate="float" message="Please Enter Correct Quantity In Field 9 !" type="text" value="#numberformat(getitem.grd19,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>9  .<cfinput name="grd19" validate="float" message="Please Enter Correct Quantity In Field 9 !" type="text" value="#numberformat(getitem.grd19,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd19 + getitem.bgrd19,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd34 eq "">
			<td>24.<cfinput name="grd34" validate="float" message="Please Enter Correct Quantity In Field 24 !" type="text" value="#numberformat(getitem.grd34,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>24.<cfinput name="grd34" validate="float" message="Please Enter Correct Quantity In Field 24 !" type="text" value="#numberformat(getitem.grd34,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd34 + getitem.bgrd34,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd49 eq "">
			<td>39.<cfinput name="grd49" validate="float" message="Please Enter Correct Quantity In Field 39 !" type="text" value="#numberformat(getitem.grd49,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>39.<cfinput name="grd49" validate="float" message="Please Enter Correct Quantity In Field 39 !" type="text" value="#numberformat(getitem.grd49,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd49 + getitem.bgrd49,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd64 eq "">
			<td>54.<cfinput name="grd64" validate="float" message="Please Enter Correct Quantity In Field 54 !" type="text" value="#numberformat(getitem.grd64,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>54.<cfinput name="grd64" validate="float" message="Please Enter Correct Quantity In Field 54 !" type="text" value="#numberformat(getitem.grd64,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd64 + getitem.bgrd64,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd20 eq "">
			<td>10.<cfinput name="grd20" validate="float" message="Please Enter Correct Quantity In Field 10 !" type="text" value="#numberformat(getitem.grd20,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>10.<cfinput name="grd20" validate="float" message="Please Enter Correct Quantity In Field 10 !" type="text" value="#numberformat(getitem.grd20,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd20 + getitem.bgrd20,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd35 eq "">
			<td>25.<cfinput name="grd35" validate="float" message="Please Enter Correct Quantity In Field 25 !" type="text" value="#numberformat(getitem.grd35,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>25.<cfinput name="grd35" validate="float" message="Please Enter Correct Quantity In Field 25 !" type="text" value="#numberformat(getitem.grd35,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd35 + getitem.bgrd35,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd50 eq "">
			<td>40.<cfinput name="grd50" validate="float" message="Please Enter Correct Quantity In Field 40 !" type="text" value="#numberformat(getitem.grd50,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>40.<cfinput name="grd50" validate="float" message="Please Enter Correct Quantity In Field 40 !" type="text" value="#numberformat(getitem.grd50,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd50 + getitem.bgrd50,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd65 eq "">
			<td>55.<cfinput name="grd65" validate="float" message="Please Enter Correct Quantity In Field 55 !" type="text" value="#numberformat(getitem.grd65,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>55.<cfinput name="grd65" validate="float" message="Please Enter Correct Quantity In Field 55 !" type="text" value="#numberformat(getitem.grd65,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd65 + getitem.bgrd65,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd21 eq "">
			<td>11.<cfinput name="grd21" validate="float" message="Please Enter Correct Quantity In Field 11 !" type="text" value="#numberformat(getitem.grd21,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>11.<cfinput name="grd21" validate="float" message="Please Enter Correct Quantity In Field 11 !" type="text" value="#numberformat(getitem.grd21,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd21 + getitem.bgrd21,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd36 eq "">
			<td>26.<cfinput name="grd36" validate="float" message="Please Enter Correct Quantity In Field 36 !" type="text" value="#numberformat(getitem.grd36,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>26.<cfinput name="grd36" validate="float" message="Please Enter Correct Quantity In Field 36 !" type="text" value="#numberformat(getitem.grd36,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd36 + getitem.bgrd36,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd51 eq "">
			<td>41.<cfinput name="grd51" validate="float" message="Please Enter Correct Quantity In Field 51 !" type="text" value="#numberformat(getitem.grd51,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>41.<cfinput name="grd51" validate="float" message="Please Enter Correct Quantity In Field 51 !" type="text" value="#numberformat(getitem.grd51,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd51 + getitem.bgrd51,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd66 eq "">
			<td>56.<cfinput name="grd66" validate="float" message="Please Enter Correct Quantity In Field 66 !" type="text" value="#numberformat(getitem.grd66,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>56.<cfinput name="grd66" validate="float" message="Please Enter Correct Quantity In Field 66 !" type="text" value="#numberformat(getitem.grd66,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd66 + getitem.bgrd66,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd22 eq "">
			<td>12.<cfinput name="grd22" validate="float" message="Please Enter Correct Quantity In Field 22 !" type="text" value="#numberformat(getitem.grd22,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>12.<cfinput name="grd22" validate="float" message="Please Enter Correct Quantity In Field 22 !" type="text" value="#numberformat(getitem.grd22,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd22 + getitem.bgrd22,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd37 eq "">
			<td>27.<cfinput name="grd37" validate="float" message="Please Enter Correct Quantity In Field 37 !" type="text" value="#numberformat(getitem.grd37,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>27.<cfinput name="grd37" validate="float" message="Please Enter Correct Quantity In Field 37 !" type="text" value="#numberformat(getitem.grd37,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd37 + getitem.bgrd37,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd52 eq "">
			<td>42.<cfinput name="grd52" validate="float" message="Please Enter Correct Quantity In Field 52 !" type="text" value="#numberformat(getitem.grd52,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>42.<cfinput name="grd52" validate="float" message="Please Enter Correct Quantity In Field 52 !" type="text" value="#numberformat(getitem.grd52,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd52 + getitem.bgrd52,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd67 eq "">
			<td>57.<cfinput name="grd67" validate="float" message="Please Enter Correct Quantity In Field 67 !" type="text" value="#numberformat(getitem.grd67,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>57.<cfinput name="grd67" validate="float" message="Please Enter Correct Quantity In Field 67 !" type="text" value="#numberformat(getitem.grd67,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd67 + getitem.bgrd67,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd23 eq "">
			<td>13.<cfinput name="grd23" validate="float" message="Please Enter Correct Quantity In Field 23 !" type="text" value="#numberformat(getitem.grd23,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>13.<cfinput name="grd23" validate="float" message="Please Enter Correct Quantity In Field 23 !" type="text" value="#numberformat(getitem.grd23,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd23 + getitem.bgrd23,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd38 eq "">
			<td>28.<cfinput name="grd38" validate="float" message="Please Enter Correct Quantity In Field 38 !" type="text" value="#numberformat(getitem.grd38,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>28.<cfinput name="grd38" validate="float" message="Please Enter Correct Quantity In Field 38 !" type="text" value="#numberformat(getitem.grd38,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd38 + getitem.bgrd38,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd53 eq "">
			<td>43.<cfinput name="grd53" validate="float" message="Please Enter Correct Quantity In Field 53  !" type="text" value="#numberformat(getitem.grd53,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>43.<cfinput name="grd53" validate="float" message="Please Enter Correct Quantity In Field 53 !" type="text" value="#numberformat(getitem.grd53,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd53 + getitem.bgrd53,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd68 eq "">
			<td>58.<cfinput name="grd68" validate="float" message="Please Enter Correct Quantity In Field 68 !" type="text" value="#numberformat(getitem.grd68,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>58.<cfinput name="grd68" validate="float" message="Please Enter Correct Quantity In Field 68 !" type="text" value="#numberformat(getitem.grd68,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd68 + getitem.bgrd68,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd24 eq "">
			<td>14.<cfinput name="grd24" validate="float" message="Please Enter Correct Quantity In Field 24 !" type="text" value="#numberformat(getitem.grd24,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>14.<cfinput name="grd24" validate="float" message="Please Enter Correct Quantity In Field 24 !" type="text" value="#numberformat(getitem.grd24,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd24 + getitem.bgrd24,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd39 eq "">
			<td>29.<cfinput name="grd39" validate="float" message="Please Enter Correct Quantity In Field 39 !" type="text" value="#numberformat(getitem.grd39,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>29.<cfinput name="grd39" validate="float" message="Please Enter Correct Quantity In Field 39 !" type="text" value="#numberformat(getitem.grd39,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd39 + getitem.bgrd39,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd54 eq "">
			<td>44.<cfinput name="grd54" validate="float" message="Please Enter Correct Quantity In Field 54 !" type="text" value="#numberformat(getitem.grd54,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>44.<cfinput name="grd54" validate="float" message="Please Enter Correct Quantity In Field 54 !" type="text" value="#numberformat(getitem.grd54,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd54 + getitem.bgrd54,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd69 eq "">
			<td>59.<cfinput name="grd69" validate="float" message="Please Enter Correct Quantity In Field 69 !" type="text" value="#numberformat(getitem.grd69,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>59.<cfinput name="grd69" validate="float" message="Please Enter Correct Quantity In Field 69 !" type="text" value="#numberformat(getitem.grd69,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd69 + getitem.bgrd69,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr align="center">
		<cfif getitemgrd.gradd25 eq "">
			<td>15.<cfinput name="grd25" validate="float" message="Please Enter Correct Quantity In Field 25 !" type="text" value="#numberformat(getitem.grd25,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>15.<cfinput name="grd25" validate="float" message="Please Enter Correct Quantity In Field 25 !" type="text" value="#numberformat(getitem.grd25,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd25 + getitem.bgrd25,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd40 eq "">
			<td>30.<cfinput name="grd40" validate="float" message="Please Enter Correct Quantity In Field 40 !" type="text" value="#numberformat(getitem.grd40,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>30.<cfinput name="grd40" validate="float" message="Please Enter Correct Quantity In Field 40 !" type="text" value="#numberformat(getitem.grd40,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd40 + getitem.bgrd40,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd55 eq "">
			<td>45.<cfinput name="grd55" validate="float" message="Please Enter Correct Quantity In Field 55 !" type="text" value="#numberformat(getitem.grd55,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>45.<cfinput name="grd55" validate="float" message="Please Enter Correct Quantity In Field 55 !" type="text" value="#numberformat(getitem.grd55,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd55 + getitem.bgrd55,".___")#" disabled size="15" maxlength="15"></td>
		<cfif getitemgrd.gradd70 eq "">
			<td>60.<cfinput name="grd70" validate="float" message="Please Enter Correct Quantity In Field 70 !" type="text" value="#numberformat(getitem.grd70,".____")#" size="15" maxlength="15" onClick="select();" readonly></td>
		<cfelse>
			<td>60.<cfinput name="grd70" validate="float" message="Please Enter Correct Quantity In Field 70 !" type="text" value="#numberformat(getitem.grd70,".____")#" size="15" maxlength="15" onClick="select();"></td>
		</cfif>
		<td><input name="" type="text" value="#numberformat(getitem.grd70 + getitem.bgrd70,".___")#" disabled size="15" maxlength="15"></td>
	</tr>
	<tr>
		<td colspan="8"><hr></td>
		<input type="hidden" name="itemno" value="#itemno#">
	</tr>
	<tr align="center">
		<td></td>
		<td></td>
		<td></td>
		<td align="center"><input name="submit" type="submit" value="Submit"></td>
		<td align="center"><input name="back" type="button" value="Back" onClick="javascript:history.back();javascript:history.back();"></td>
	</tr>
</table>
</cfform>
</cfoutput>

</body>
</html>