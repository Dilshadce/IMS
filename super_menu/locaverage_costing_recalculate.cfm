<html>
<head>
<title>Location Average Costing Calculation After Year-End</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" src="../scripts/date_format.js"></script>

</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,fifocal,costingcn,costingoai from gsetup
</cfquery>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR'">
</cfif>

<body>
<form action="" method="post" onSubmit="if(confirm('Are you sure want to Recalculate Location Moving Average?')){ColdFusion.Window.show('processing');return true;} else {return false;}">
<H1>Location Moving Average Costing Calculation After Year-End</H1>

<h3>Caution: This Function Will Recalculate All The Cost and Update The Table locqdbf. Only for Location Moving Average Costing Method. <br>
	You Have To Do This Function After the Year End Process.
</h3>
	<table>
		<tr>
			<td>Current Closing Date</td>
			<td>:</td>
			<td><input type="text" name="closingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		<tr>
			<td>Last Closing Date</td>
			<td>:</td>
			<td><input type="text" name="lastclosingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		
		<tr><td colspan="3"><input type="submit" name="submit" value="Recalculate"></td></tr>
	</table>
</form>

<cfif submit eq 'Recalculate'>
	<cfif form.lastclosingdate eq "">
		Please insert the Last Closing Date!<cfabort>
	</cfif>
	<cfif form.closingdate eq "">
		Please insert the Current Closing Date!<cfabort>
	</cfif>
    
	<cfset date1 = createDate(ListGetAt(form.closingdate,3,"/"),ListGetAt(form.closingdate,2,"/"),ListGetAt(form.closingdate,1,"/"))>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	
    
    <cfset currentDirectory = "C:\Inetpub\wwwroot\IMS\super_menu\backupdata\"& dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_RECALLOCMOVING.sql">
<cfset currentdirfile=currentDirectory&"\"&filename>

<cfset currentURL =  CGI.SERVER_NAME>
<cfif mid(currentURL,'4','3') eq "pro">
<cfset serverhost = "localhost">
<cfset servername = "root">
<cfset serverpass = "Toapayoh831">
<cfelseif mid(currentURL,'4','1') eq "2">
<cfset serverhost = "169.254.228.112">
<cfset servername = "appserver2">
<cfset serverpass = "Nickel266(">
<cfelse>
<cfset serverhost = "169.254.228.112">
<cfset servername = "appserver1">
<cfset serverpass = "Nickel266(">
</cfif>

<cfexecute name = "C:\inetpub\wwwroot\IMS\mysqldump"
    arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts#" outputfile="#currentdirfile#" timeout="720">
</cfexecute>

<cfset filesize = GetFileInfo('#currentdirfile#').size >

<cfif filesize lt 200000>
<h1>Backup Failed! Please contact System Administrator!</h1>
<cfabort>
</cfif>

<!---New Moving calculation--->
            <cfset date1 = createDate(ListGetAt(form.closingdate,3,"/"),ListGetAt(form.closingdate,2,"/"),ListGetAt(form.closingdate,1,"/"))>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	
    <!---New Moving calculation--->
            
<cfquery name="getitem" datasource="#dts#">
	select itemno,location from locqdbf
</cfquery>
            	
<cfloop query="getitem">
            <cfquery name="getqtybf" datasource="#dts#">
			select ifnull(locqfield,0) as qtybf,itemno,ifnull(avcost2,0) as avcost2 from locqdbf_last_year where itemno='#getitem.itemno#' and location='#getitem.location#' and LastAccDate = "#dateformat(date1,'yyyy-mm-dd')#"
			limit 1
            </cfquery>
            
          
            
            <cfset movingunitcost=val(getqtybf.avcost2)>
            <cfset movingbal=val(getqtybf.qtybf)>
            
            <cfquery name="getmovingictran" datasource="#dts#">
			select 
		    a.amt,a.qty,a.toinv,
            a.type,a.refno,a.itemno,a.trancode
			from ictran a

			where a.itemno='#getitem.itemno#' 
            and a.location='#getitem.location#'
			and (a.void = '' or a.void is null)
			and (a.linecode = '' or a.linecode is null)
			and a.type not in ('QUO','SO','PO','SAM')
			and a.fperiod='99'
            and a.wos_date > "#dateformat(date3,'yyyy-mm-dd')#"
			and a.wos_date <= "#dateformat(date1,'yyyy-mm-dd')#"
			order by a.wos_date,a.trdatetime
			</cfquery>
            
        <cfloop query="getmovingictran">
        
        <cfif isdefined('form.dodate')>
  		<cfif type eq "INV">
  		<cfquery name="checkexist2" datasource="#dts#">
  		select toinv,refno,type,itemno from ictran a  where refno ='#getmovingictran.refno#' and itemno =			
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getmovingictran.itemno#"> and type = "#getmovingictran.type#" and 
        trancode = "#getmovingictran.trancode#" and (dono = "" or dono is null or dono not in (select 
        frrefno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by frrefno))
  		</cfquery>
  		</cfif>
  		</cfif>
        <!---exclude CN --->
        <cfif getgeneral.costingcn neq 'Y'>
        
        	<cfif getmovingictran.type eq "CN">
            <cfif (val(movingbal)+val(getmovingictran.qty)) gt 0>
            <cfset movingunitcost=val(movingunitcost)>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "CN">
            <cfif (val(movingbal)+val(getmovingictran.qty)) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+val(getmovingictran.qty))>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+val(getmovingictran.amt))/(movingbal+val(getmovingictran.qty))>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+val(getmovingictran.qty)>
            </cfif>
        </cfif>
        
        <cfif getgeneral.costingOAI neq 'Y'>
            <cfif getmovingictran.type eq "OAI">
			<cfif (movingbal+getmovingictran.qty) gt 0>
            <cfset movingunitcost=movingunitcost>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        <cfelse>
        	<cfif getmovingictran.type eq "OAI">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        </cfif>
        
			<cfif getmovingictran.type eq "RC" or getmovingictran.type eq "TRIN">
            <cfif (movingbal+getmovingictran.qty) gt 0>
            <cfif movingbal lt 0>
            <cfset movingunitcost=((0*movingunitcost)+getmovingictran.amt)/(0+getmovingictran.qty)>
            <cfelse>
            <cfset movingunitcost=((movingbal*movingunitcost)+getmovingictran.amt)/(movingbal+getmovingictran.qty)>
            </cfif>
            <cfelse>
            <cfset movingunitcost=0>
            </cfif>
            
            <cfset movingbal=movingbal+getmovingictran.qty>
            </cfif>
        
        
        <cfif (type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU" or type eq "SO")>
        
        <cfif isdefined('form.dodate')>
                    
        <cfif getmovingictran.type eq "DO">
        	<cfset movingbal=movingbal-getmovingictran.qty>
		<cfelseif getmovingictran.type eq "INV" and checkexist2.recordcount eq 0>
        <cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        <cfelse>
        
        <cfif getmovingictran.type eq "DO" and getmovingictran.toinv neq "">
		<cfelse>
	    <cfset movingbal=movingbal-getmovingictran.qty>
	    </cfif>
        
        </cfif>
        </cfif>
        
       
        
        
        </cfloop>
        
		<cfset getitem.stockbalance=val(movingbal)*val(movingunitcost)>
        <cfset getitem.ucost=val(movingunitcost)>
		
        <cfquery name="update" datasource="#dts#">
        update locqdbf set avcost2 = '#val(movingunitcost)#' where itemno='#getitem.itemno#' and location='#getitem.location#'
        </cfquery>
        
        
        </cfloop>
    
    
	You have finish the recalculate. 
</cfif>
</body>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
</cfwindow>
</html>