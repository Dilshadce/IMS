<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1633, 186, 1641, 1642, 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665, 1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1678, 1802,2055,2056,4000,4001">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle="#words[1633]#">
<cfset pageAction="Update">

<cfif Hlinkams eq "Y">
    <cfquery name="getGLdata" datasource="#replace(LCASE(dts),'_i','_a','all')#">
        SELECT accno,desp,desp2 
        FROM gldata 
        WHERE accno NOT IN (SELECT custno 
                            FROM arcust 
                            ORDER BY custno) 
        AND accno NOT IN (SELECT custno 
                          FROM apvend 
                          ORDER BY custno)
        ORDER BY accno;
    </cfquery>
</cfif>
<cfquery name="getGsetup" datasource="#dts#">
	SELECT * 
	FROM gsetup;
</cfquery>

<cfset creditSales = getGsetup.creditsales>
<cfset cashSales = getGsetup.cashsales>
<cfset salesReturn = getGsetup.salesreturn>
<cfset salesDiscount = getGsetup.discsales>
<cfset salesTax = getGsetup.gstsales>
<cfloop index="i" from="15" to="21">
	<cfset 'miscCharges#i#' = evaluate('getGsetup.custmisc#i-14#')>
</cfloop>

<cfset purchase = getGsetup.purchasereceive>
<cfset purchaseReturn = getGsetup.purchasereturn>
<cfset purchaseDiscount = getGsetup.discpur>
<cfset purchaseTax = getGsetup.gstpurchase>
<cfloop index="i" from="34" to="40">
	<cfset 'miscCharges#i#' = evaluate('getGsetup.suppmisc#i-33#')>
</cfloop>

<cfset cash = getGsetup.cashaccount>
<cfset deposit = getGsetup.depositaccount>
<cfset cheque = getGsetup.chequeaccount>
<cfset creditCard1 = getGsetup.creditcardaccount1>
<cfset creditCard2 = getGsetup.creditcardaccount2>
<cfset debitCard = getGsetup.debitcardaccount>
<cfset cashVoucher = getGsetup.cashvoucheraccount>
<cfset withOutTax = getGsetup.withholdingtaxaccount>
<cfset bankaccount = getGsetup.bankaccount>
<cfset roundingaccount = getGsetup.roundingaccount>
<cfset expensesaccount = getGsetup.expensesaccount>

<cfset title10 = "#words[1641]#">
<cfset titlePlaceHolder10 = "#words[1661]#">
<cfset id10 = "creditSales">
<cfset title11 = "#words[1642]#">
<cfset titlePlaceHolder11 = "#words[1662]#">
<cfset id11 = "cashSales">
<cfset title12 = "#words[186]#">
<cfset titlePlaceHolder12 = "#words[1802]#">
<cfset id12 = "salesReturn">
<cfset title13 = "#words[1643]#">
<cfset titlePlaceHolder13 = "#words[1663]#">
<cfset id13 = "salesDiscount">
<cfset title14 = "#words[1644]#">
<cfset titlePlaceHolder14 = "#words[1664]#">
<cfset id14 = "salesTax">
<cfloop index="i" from="15" to="21">
    <cfset 'title#i#' = '#words[i+1619]#'>
    <cfset 'titlePlaceHolder#i#' = '#words[1678]#'><!---#words[i+1671]#--->
    <cfset 'id#i#' = 'miscCharges#i#'>
</cfloop>   

<cfset title30 = "#words[1645]#">
<cfset titlePlaceHolder30 = "#words[1665]#">
<cfset id30 = "purchase">
<cfset title31 = "#words[1646]#">
<cfset titlePlaceHolder31 = "#words[1666]#">
<cfset id31 = "purchaseReturn">
<cfset title32 = "#words[1647]#">
<cfset titlePlaceHolder32 = "#words[1667]#">
<cfset id32 = "purchaseDiscount">
<cfset title33 = "#words[1648]#">
<cfset titlePlaceHolder33 = "#words[1668]#">
<cfset id33 = "purchaseTax">
<cfloop index="i" from="34" to="40">
    <cfset 'title#i#' = '#words[i+1600]#'>
    <cfset 'titlePlaceHolder#i#' = '#words[1678]#'><!---#words[i+1652]#--->
    <cfset 'id#i#' = 'miscCharges#i#'>
</cfloop> 

<cfset title50 = "#words[1649]#">
<cfset titlePlaceHolder50 = "#words[1669]#">
<cfset id50 = "cash">
<cfset title51 = "#words[1650]#">
<cfset titlePlaceHolder51 = "#words[1670]#">
<cfset id51 = "deposit">
<cfset title52 = "#words[1651]#">
<cfset titlePlaceHolder52 = "#words[1671]#">
<cfset id52 = "cheque">
<cfset title53 = "#words[1652]#">
<cfset titlePlaceHolder53 = "#words[1672]#">
<cfset id53 = "creditCard1">
<cfset title54 = "#words[1653]#">
<cfset titlePlaceHolder54 = "#words[1673]#">
<cfset id54 = "creditCard2">
<cfset title55 = "#words[1654]#">
<cfset titlePlaceHolder55 = "#words[1674]#">
<cfset id55 = "debitCard">
<cfset title56 = "#words[1655]#">
<cfset titlePlaceHolder56 = "#words[1675]#">
<cfset id56 = "cashVoucher">
<cfset title57 = "#words[1656]#">
<cfset titlePlaceHolder57 = "#words[1676]#">
<cfset id57 = "withOutTax">
<cfset title58 = "#words[1657]#">
<cfset titlePlaceHolder58 = "#words[1677]#">
<cfset id58 = "bankAccount">
<cfset title59 = "#words[2055]#">
<cfset titlePlaceHolder59 = "#words[2056]#">
<cfset id59 = "roundingaccount">

<cfset title60 = "#words[4000]#">
<cfset titlePlaceHolder60 = "#words[4001]#">
<cfset id60 = "expensesaccount">

<cfset panelTitle1 = "#words[1658]#">
<cfset panelTitle2 = "#words[1659]#">
<cfset panelTitle3 = "#words[1660]#">
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->

	<cfoutput>
    <title>#pageTitle#</title>
    </cfoutput>
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
</head>

<body class="container">
<cfoutput>
	<cfform class="form-horizontal" role="form" id="amsDefaultSetupForm" name="amsDefaultSetupForm" action="amsDefaultSetupProcess.cfm" method="post">
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
        <div class="panel-group">
        	<cfloop index="i" from="1" to="3">
                <div class="panel panel-default">
                    <div class="panel-heading" data-toggle="collapse" href="##panel#i#Collapse">
                        <h4 class="panel-title accordion-toggle">#evaluate('panelTitle#i#')#</h4>
                    </div>
                    <div id="panel#i#Collapse" class="panel-collapse collapse in">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-8">	
									<cfif i EQ 1>
                                      <cfset startingLoop = 10>
                                      <cfset endLoop = 21>
                                    <cfelseif i EQ 2>
                                      <cfset startingLoop = 30>
                                      <cfset endLoop = 40>
                                    <cfelseif i EQ 3>
                                      <cfset startingLoop = 50>
                                      <cfset endLoop = 60>    
                                    </cfif>	
                                    <cfloop index="i" from="#startingLoop#" to="#endLoop#">					
                                        <div class="form-group">
                                            <label for="" class="col-sm-4 control-label">#evaluate('title#i#')#</label>
                                            <div class="col-sm-8">		
                                            	<cfif Hlinkams eq "Y">	
                                                    <select class="form-control input-sm" id="#evaluate('id#i#')#" name="#evaluate('id#i#')#">
                                                        <option value="">#evaluate('titlePlaceHolder#i#')#</option>
                                                        <cfloop query="getGLdata">
                                                        	<cfset value=evaluate('id#i#')>
                                                            <option value="#getGLdata.accno#" <cfif getGLdata.accno EQ #evaluate('#value#')#>selected</cfif>>#getGLdata.accno# - #getGLdata.desp#</option>
                                                        </cfloop>
                                                    </select>	
                                                <cfelse>
                                                	<cfset value=evaluate('id#i#')>
                                                	<cfinput type="text" id="#evaluate('id#i#')#" name="#evaluate('id#i#')#" value="#evaluate('#value#')#" mask="????/???" maxlength="8">    
                                                </cfif>    
                                            </div>
                                        </div>	  
                                    </cfloop>                                                                          
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        	</cfloop>        
        </div>
        <div class="pull-right">
            <input type="submit" value="#pageAction#" class="btn btn-primary"/>
            <input type="button" value="Cancel" onclick="window.location='/latest/body/bodymenu.cfm?id=60100'" class="btn btn-default" />
        </div>
    </cfform> 
</cfoutput>
</body>
</html>

