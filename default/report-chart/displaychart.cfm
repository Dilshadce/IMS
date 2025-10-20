<html>
<head>
<title><cfoutput>Customer Sales Chart</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>

<body>
<cfif isdefined('form.chart')>
<cfset charttype=form.chart>
<cfelse>
<cfset charttype='bar'>
</cfif>

<h1>Customer Monthly Sales Chart</h1>
<cfoutput>
  
<form name="chartform" id="chartform" action="displaychart.cfm" method="post">
  
    <input type="hidden" id="Custfrom" name="Custfrom" value="#form.Custfrom#">
    <input type="hidden" id="chart" name="chart" value="#charttype#">
    <input type="hidden" id="periodfrom" name="periodfrom" value="#form.periodfrom#">
    <input type="hidden" id="periodto" name="periodto" value="#form.periodto#">

<input type="button" name="Bar" id="Bar" value="Bar" onClick="document.getElementById('chart').value=this.value;chartform.submit();"> &nbsp;&nbsp;<input type="button" name="Pie" id="Pie" value="Pie" onClick="document.getElementById('chart').value=this.value;form.submit();"> &nbsp;&nbsp;<input type="button" name="Line" id="Line" value="Line" onClick="document.getElementById('chart').value=this.value;form.submit();">&nbsp;&nbsp;<input type="button" name="horizontalbar" id="horizontalbar" value="horizontalbar" onClick="document.getElementById('chart').value=this.value;form.submit();">
</form>
</cfoutput>

	<cfquery name="getInfo" datasource="#dts#">
		SELECT SUM(a.invgross)-sum(a.discount) as grand,(ifnull(b.grand,0)-ifnull(c.grand,0)) as total,a.custno,a.fperiod,a.name 
        FROM artran AS a
  
         LEFT JOIN 
        	(SELECT SUM(invgross)-sum(discount) as grand,custno,fperiod,name FROM artran 
        		WHERE (type = 'inv' or type = 'cs' or type = 'dn') 
                AND (void='' or void is null) 
                <cfif form.periodfrom neq "" and form.periodto neq "">
                AND fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
                </cfif>  
                AND custno = '#form.Custfrom#'
                GROUP BY fperiod ) AS b ON a.fperiod=b.fperiod
                
                LEFT JOIN 
                    (SELECT SUM(invgross)-sum(discount) as grand,custno,fperiod,name FROM artran 
                    WHERE (type = 'CN')
                    AND (void='' or void is null) 
                    <cfif form.periodfrom neq "" and form.periodto neq "">
                    AND fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
                    </cfif> 
                    AND custno = '#form.Custfrom#'
                    GROUP BY fperiod ) AS c ON a.fperiod=c.fperiod
       
       	WHERE a.custno = '#form.Custfrom#'
        <cfif form.periodfrom neq "" and form.periodto neq "">
        AND a.fperiod >= '#form.periodfrom#' and a.fperiod <= '#form.periodto#'
        </cfif>
        GROUP BY a.fperiod 
        ORDER BY a.fperiod;
	</cfquery>
    <cfoutput>
    <h2>Customer : #form.Custfrom# - #getInfo.name#</h2>
	</cfoutput>
    
    <cfchart backgroundcolor="eff8ff" fontsize="12" xAxisTitle="Month" yAxisTitle="Value" title="" showborder="no" show3d="no" chartheight="500" chartwidth="1500">
	<cfchartseries type="#charttype#" query="getInfo" valueColumn="total" itemColumn="fperiod" colorlist="1E90FF,48D1CC,F08080,DDA0DD,008000,996699,CCCC99,FFCCCC,333366,FFFF33"/></cfchart>
    
</body>
</html>