<html>
<head>
<title>View Profit Margin Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<SCRIPT type="text/javascript">
	function Chk_S_Tax1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_Tax1.value=Str;
			}
  		}
  		return true;
	}

	function Chk_S_Tax2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_Tax2.value=Str;
			}
  		}
  		return true;
	}

	function Chk_S_Tax3()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
    		if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_Tax3.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_S_Tax4()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_Tax4.value=Str;
   	 		}
  		}
  		return true;
	}

	function Chk_S_ZR1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_ZR1.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_S_ZR2()
	{
  		var Str=prompt("Please enter a value :","0.00")

  		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_ZR2.value=Str;
			}
  		}
  		return true;
	}

	function Chk_S_EX1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_EX1.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_S_EX2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.S_EX2.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_P_Tax1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_Tax1.value=Str;
			}
  		}
  		return true;
	}

	function Chk_P_Tax2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_Tax2.value=Str;
			}
  		}
  		return true;
	}

	function Chk_P_Tax3()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
    		if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_Tax3.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_P_Tax4()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
		else
		{
	  		document.form.P_Tax4.value=Str;
    	}
  	}
  	return true;
	}

	function Chk_P_ZR1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_ZR1.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_P_ZR2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_ZR2.value=Str;
			}
  		}
  		return true;
	}

	function Chk_P_MES1()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_MES1.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_P_MES2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_MES2.value=Str;
			}
  		}
  		return true;
	}

	function Chk_P_EX1()
	{
  		var Str=prompt("Please enter a value :","0.00")

  		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_EX1.value=Str;
    		}
  		}
  		return true;
	}

	function Chk_P_EX2()
	{
  		var Str=prompt("Please enter a value :","0.00")

		if (Str!=null && Str!="")
		{
			if (isNaN(Str))
			{
	  			alert('Error. Please enter a number.');
			}
			else
			{
	  			document.form.P_EX2.value=Str;
    		}
  		}
  		return true;
	}
</script>

<cfparam name="s_taxnet1" default="0">
<cfparam name="s_taxnet2" default="0">
<cfparam name="s_zrnet1" default="0">
<cfparam name="s_zrnet2" default="0">
<cfparam name="s_exnet1" default="0">
<cfparam name="s_exnet2" default="0">
<cfparam name="s_mesnet1" default="0">
<cfparam name="s_mesnet2" default="0">
<cfparam name="p_taxnet1" default="0">
<cfparam name="p_taxnet2" default="0">
<cfparam name="p_zrnet1" default="0">
<cfparam name="p_zrnet2" default="0">
<cfparam name="p_exnet1" default="0">
<cfparam name="p_exnet2" default="0">
<cfparam name="p_mesnet1" default="0">
<cfparam name="p_mesnet2" default="0">

<body>
<cfform action="TaxTotal_View.cfm" method="post" name="form">
	<cfquery name='getHeader' datasource='#dts#'>
    	select * from artran
    	where (type = 'RC' or type = 'PR' or type = 'INV' or type = 'CN' or type = 'DN' or type = 'CS')
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	  	and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    	</cfif>
		order by fperiod
  	</cfquery>

  	<cfoutput>
    	<input name="periodfrom" type="hidden" value="#form.periodfrom#">
    	<input name="periodto" type="hidden" value="#form.periodto#">
  	</cfoutput>

<!--- <cfquery name='ClearRPMargin' datasource='#dts#'>
  truncate r_pmargin
</cfquery> --->
<!--- <cfset monthnow = month(now())> --->
<!---   <cfoutput query = 'getHeader'>  --->

	<cfif isdefined('form.S_Tax1')>
		<cfset S_Tax1 = val(form.S_Tax1)>
		<cfset S_Tax2 = val(form.S_Tax2)>
		<cfset S_Tax3 = val(form.S_Tax3)>
		<cfset S_Tax4 = val(form.S_Tax4)>
		<cfset S_ZR1 = val(form.S_ZR1)>
		<cfset S_ZR2 = val(form.S_ZR2)>
		<cfset S_EX1 = val(form.S_EX1)>
		<cfset S_EX2 = val(form.S_EX2)>
		<cfset P_Tax1 = val(form.P_Tax1)>
		<cfset P_Tax2 = val(form.P_Tax2)>
		<cfset P_Tax3 = val(form.P_Tax3)>
		<cfset P_Tax4 = val(form.P_Tax4)>
		<cfset P_ZR1 = val(form.P_ZR1)>
		<cfset P_ZR2 = val(form.P_ZR2)>
		<cfset P_MES1 = val(form.P_MES1)>
		<cfset P_MES2 = val(form.P_MES2)>
		<cfset P_EX1 = val(form.P_EX1)>
		<cfset P_EX2 = val(form.P_EX2)>
  	<cfelse>
<!---<input name="S_Tax1" type="hidden" value="0">
    <input name="S_Tax2" type="hidden" value="0">
    <input name="S_Tax3" type="hidden" value="0">
    <input name="S_Tax4" type="hidden" value="0">
    <input name="S_ZR1" type="hidden" value="0">
    <input name="S_ZR2" type="hidden" value="0">
    <input name="S_EX1" type="hidden" value="0">
    <input name="S_EX2" type="hidden" value="0"> --->
		<cfset S_Tax1 = 0>
		<cfset S_Tax2 = 0>
		<cfset S_Tax3 = 0>
		<cfset S_Tax4 = 0>
		<cfset S_ZR1 = 0>
		<cfset S_ZR2 = 0>
		<cfset S_EX1 = 0>
		<cfset S_EX2 = 0>
<!---<input name="P_Tax1" type="hidden" value="0">
    <input name="P_Tax2" type="hidden" value="0">
    <input name="P_Tax3" type="hidden" value="0">
    <input name="P_Tax4" type="hidden" value="0">
    <input name="P_ZR1" type="hidden" value="0">
    <input name="P_ZR2" type="hidden" value="0">
    <input name="P_MES1" type="hidden" value="0">
    <input name="P_MES2" type="hidden" value="0">
    <input name="P_EX1" type="hidden" value="0">
    <input name="P_EX2" type="hidden" value="0"> --->
		<cfset P_Tax1 = 0>
		<cfset P_Tax2 = 0>
		<cfset P_Tax3 = 0>
		<cfset P_Tax4 = 0>
		<cfset P_ZR1 = 0>
		<cfset P_ZR2 = 0>
		<cfset P_MES1 = 0>
		<cfset P_MES2 = 0>
		<cfset P_EX1 = 0>
		<cfset P_EX2 = 0>

	<cfquery name='getS_Tax1' datasource='#dts#'>
		select sum(net) as sumnet, sum(tax) as sumtax from artran where (type = 'INV' or type = 'DN' or type = 'CS') and note = 'STAX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_Tax1.recordcount gt 0>
      	<cfif getS_Tax1.sumtax neq ''>
	    	<cfset S_TAX1 = numberformat(getS_Tax1.sumtax,".__")>
      	</cfif>

	  	<cfif getS_Tax1.sumnet neq ''>
	    	<cfset S_TAXnet1 = numberformat(getS_Tax1.sumnet,".__")>
      	</cfif>
		<!---<cfif #getS_Tax1.sumtax# neq ''>
	    <cfset S_TAX3 = #getS_Tax1.sumtax#>
      	</cfif> --->
    </cfif>

    <cfquery name='getS_Tax2' datasource='#dts#'>
      	select sum(net)as sumnet,sum(tax)as sumtax from artran where type = 'CN' and note = 'STAX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_Tax2.recordcount gt 0>
      	<cfif getS_Tax2.sumtax neq ''>
	    	<cfset S_TAX2 = numberformat(getS_Tax2.sumtax,".__")>
      	</cfif>

		<cfif getS_Tax2.sumnet neq ''>
	    	<cfset S_TAXnet2 = numberformat(getS_Tax2.sumnet,".__")>
      	</cfif>
		<!---<cfif getS_Tax2.sumtax neq ''>
	    <cfset S_TAX4 = #getS_Tax2.sumtax#>
      	</cfif> --->
    </cfif>

	<cfquery name='getS_ZR1' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where (type = 'INV' or type = 'DN' or type = 'CS') and note = 'ZR'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_ZR1.recordcount gt 0>
      	<cfif getS_ZR1.sumtax neq ''>
	    	<cfset S_ZR1 = numberformat(getS_ZR1.sumtax,".__")>
      	</cfif>

		<cfif getS_ZR1.sumnet neq ''>
	    	<cfset S_ZRnet1 = numberformat(getS_ZR1.sumnet,".__")>
      	</cfif>
    </cfif>

    <cfquery name='getS_ZR2' datasource='#dts#'>
      	select sum(net) as sumnet, sum(tax)as sumtax from artran where type = 'CN' and note = 'ZR'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_ZR2.recordcount gt 0>
      	<cfif getS_ZR2.sumtax neq ''>
	    	<cfset S_ZR2 = numberformat(getS_ZR2.sumtax,".__")>
      	</cfif>

	  	<cfif getS_ZR2.sumnet neq ''>
	    	<cfset S_ZRnet2 = numberformat(getS_ZR2.sumnet,".__")>
      	</cfif>
    </cfif>

	<cfquery name='getS_EX1' datasource='#dts#'>
      	select sum(net) as sumnet, sum(tax)as sumtax from artran where (type = 'INV' or type = 'DN' or type = 'CS') and note = 'EX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_EX1.recordcount gt 0>
      	<cfif getS_EX1.sumtax neq ''>
	    	<cfset S_EX1 = numberformat(getS_EX1.sumtax,".__")>
      	</cfif>

		<cfif getS_EX1.sumnet neq ''>
	    	<cfset S_EXnet1 = numberformat(getS_EX1.sumnet,".__")>
      	</cfif>
    </cfif>

    <cfquery name='getS_EX2' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'CN' and note = 'EX'
  		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getS_EX2.recordcount gt 0>
      	<cfif getS_EX2.sumtax neq ''>
	  		<cfset S_EX2 = numberformat(getS_EX2.sumtax,".__")>
      	</cfif>

		<cfif getS_EX2.sumnet neq ''>
	    	<cfset S_EXnet2 = numberformat(getS_EX2.sumnet,".__")>
      	</cfif>
    </cfif>

	<cfquery name='getP_Tax1' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'RC' and note = 'STAX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_Tax1.recordcount gt 0>
    	<cfif getP_Tax1.sumtax neq ''>
	    	<cfset P_TAX1 = numberformat(getP_Tax1.sumtax,".__")>
      	</cfif>

		<cfif getP_Tax1.sumnet neq ''>
	    	<cfset P_TAXnet1 = numberformat(getP_Tax1.sumnet,".__")>
      	</cfif>
		<!---<cfif #getP_Tax1.sumtax# neq ''>
	    <cfset P_TAX3 = #getP_Tax1.sumtax#>
      	</cfif> --->
    </cfif>

    <cfquery name='getP_Tax2' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'PR' and note = 'STAX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_Tax2.recordcount gt 0>
      	<cfif getP_Tax2.sumtax neq ''>
	    	<cfset P_TAX2 = numberformat(getP_Tax2.sumtax,".__")>
      	</cfif>

		<cfif getP_Tax2.sumnet neq ''>
	    	<cfset P_TAXnet2 = numberformat(getP_Tax2.sumnet,".__")>
      	</cfif>
		<!---<cfif getP_Tax2.sumtax neq ''>
	    <cfset P_TAX2 = #getP_Tax2.sumtax#>
      	</cfif> --->
    </cfif>

	<cfquery name='getP_ZR1' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'RC' and note = 'ZR'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_ZR1.recordcount gt 0>
      	<cfif getP_ZR1.sumtax neq ''>
	    	<cfset P_ZR1 = numberformat(getP_ZR1.sumtax,".__")>
      	</cfif>

		<cfif getP_ZR1.sumnet neq ''>
	    	<cfset P_ZRnet1 = numberformat(getP_ZR1.sumnet,".__")>
      	</cfif>
    </cfif>

    <cfquery name='getP_ZR2' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'PR' and note = 'ZR'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_ZR2.recordcount gt 0>
      	<cfif getP_ZR2.sumtax neq ''>
	    	<cfset P_ZR2 = numberformat(getP_ZR2.sumtax,".__")>
      	</cfif>

		<cfif getP_ZR2.sumnet neq ''>
	    	<cfset P_ZRnet2 = numberformat(getP_ZR2.sumnet,".__")>
      	</cfif>
    </cfif>

	<cfquery name='getP_MES1' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'RC' and frem9 <> ''
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
     	</cfif>
    </cfquery>

	<cfif getP_MES1.recordcount gt 0>
      	<cfif getP_MES1.sumtax neq ''>
	    	<cfset P_MES1 = numberformat(getP_MES1.sumtax,".__")>
      	</cfif>

		<cfif getP_MES1.sumnet neq ''>
	    	<cfset P_MESnet1 = numberformat(getP_MES1.sumnet,".__")>
      	</cfif>
    </cfif>

    <cfquery name='getP_MES2' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'PR' and frem9 <> ''
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_MES2.recordcount gt 0>
      	<cfif getP_MES2.sumtax neq ''>
	    	<cfset P_MES2 = numberformat(getP_MES2.sumtax,".__")>
      	</cfif>

		<cfif getP_MES2.sumnet neq ''>
	    	<cfset P_MESnet2 = numberformat(getP_MES2.sumnet,".__")>
      	</cfif>
    </cfif>

	<cfquery name='getP_EX1' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'RC' and note = 'EX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_EX1.recordcount gt 0>
      	<cfif getP_EX1.sumtax neq ''>
	    	<cfset P_EX1 = numberformat(getP_EX1.sumtax,".__")>
      	</cfif>

		<cfif getP_EX1.sumnet neq ''>
	    	<cfset P_EXnet1 = numberformat(getP_EX1.sumnet,".__")>
      	</cfif>
    </cfif>

    <cfquery name='getP_EX2' datasource='#dts#'>
      	select sum(net) as sumnet,sum(tax)as sumtax from artran where type = 'PR' and note = 'EX'
		<cfif form.periodfrom neq '' and form.periodto neq ''>
	    and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
      	</cfif>
    </cfquery>

	<cfif getP_EX2.recordcount gt 0>
      	<cfif getP_EX2.sumtax neq ''>
	  		<cfset P_EX2 = numberformat(getP_EX2.sumtax,".__")>
      	</cfif>

		<cfif getP_EX2.sumnet neq ''>
	    	<cfset P_EXnet2 = numberformat(getP_EX2.sumnet,".__")>
      	</cfif>
    </cfif>
</cfif>
<!---<font color="#000000" size="1" face="Arial, Helvetica, sans-serif">
    Print Date: <cfoutput>#dateformat(now(),"DD/MM/YY")#</cfoutput>
  </font> --->
<p align="center"><font color="##000000" size="3" face="Arial, Helvetica, sans-serif"><strong>View Tax Totals</strong></font></p>
<cfoutput>
<table align="center" border="0" width="100%">
	<tr>
    	<td colspan="8"><hr></td>
	</tr>
      <!---       <tr>
        <td width="20%"><font size="2" face="Arial, Helvetica, sans-serif">Payment
          Made To GST</font></td>
        <td width="18%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td width="5%">&nbsp;</td>
        <td width="15%"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#S_tax1#</label>
            </font></div></td>
        <td width="10%"><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">PM</font></div></td>
        <td width="9%"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td width="18%"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td width="5%">&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><div align="right">
            <input name="PM" type="button" value="Change">
          </div></td>
        <td>&nbsp;</td>
        <td><div align="right"></div></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr> --->
	<tr>
		<td><font size="2" face="Arial, Helvetica, sans-serif">Standard-Rated Sales</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="StaxReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(S_Taxnet1,'_,__.__')#</a></label>
            <input name="S_Tax1" type="hidden" value="#numberformat(S_Taxnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_Tax1" type="button" value="Change" onClick="JavaScript:Chk_S_Tax1()"> --->
          </div></td>
        <cfset T_S_Sales = S_Taxnet1 - S_Taxnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_S_Sales,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">STAX</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">Sales
            Tax</font></div></td>
        <cfset S_TAX3 = S_Tax1>
		<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            #numberformat(S_Tax1,'_,__.__')#
            <label></label>
            <input name="S_Tax3" type="hidden" value="#numberformat(S_Tax1,'_.__')#">
            </font></div></td>
        <td> <div align="right">
            <!--- <input name="txtS_Tax3" type="button" value="Change" onClick="JavaScript:Chk_S_Tax3()"> --->
          </div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(S_Taxnet2,'_,__.__')#</label>
            <input name="S_Tax2" type="hidden" value="#numberformat(S_Taxnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_Tax2" type="button" value="Change" onClick="JavaScript:Chk_S_Tax2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
		<!--- <cfset S_TAX4 = #S_Taxnet2# * 0.05> --->
		<cfset S_TAX4 = S_Tax2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(S_Tax2,'_,__.__')#</label>
            <input name="S_Tax4" type="hidden" value="#numberformat(S_Tax2,'_.__')#">
            </font></div></td>
        <td> <div align="right">
            <!--- <input name="txtS_Tax4" type="button" value="Change" onClick="JavaScript:Chk_S_Tax4()"> --->
          </div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Zero-Rated Sales</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="ZRReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(S_ZRnet1,'_,__.__')#</a></label>
            <input name="S_ZR1" type="hidden" value="#numberformat(S_ZRnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_ZR1" type="button" value="Change" onClick="JavaScript:Chk_S_ZR1()"> --->
          </div></td>
        <cfset T_S_ZR = S_ZRnet1 - S_ZRnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            #numberformat(T_S_ZR,'_,__.__')#
            <label></label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">ZR</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <cfset Total_STax = S_Tax3 - S_Tax4>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(Total_STax,'_,__.__')#</label>
            </font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(S_ZRnet2,'_,__.__')#</label>
            <input name="S_ZR2" type="hidden" value="#numberformat(S_ZRnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_ZR2" type="button" value="Change" onClick="JavaScript:Chk_S_ZR2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Exempt Sales</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="EXReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(S_EXnet1,'_,__.__')#</a></label>
            <input name="S_EX1" type="hidden" value="#numberformat(S_EXnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_EX1" type="button" value="Change" onClick="JavaScript:Chk_S_EX1()"> --->
          </div></td>
        <cfset T_S_EX = S_EXnet1 - S_EXnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_S_EX,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">EX</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;
            </font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(S_EXnet2,'_,__.__')#</label>
            <input name="S_EX2" type="hidden" value="#numberformat(S_EX2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtS_EX2" type="button" value="Change" onClick="JavaScript:Chk_S_EX2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Total Sales</font></td>
        <td><div align="right"></div></td>
        <td><div align="center"></div></td>
        <cfset GTotal_Sales = T_S_Sales + T_S_ZR + T_S_EX>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(GTotal_Sales,'_,__.__')#</label>
            </font></div></td>
        <td>&nbsp;</td>
        <td><div align="right"></div></td>
        <td><div align="right"></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <tr>
        <td colspan="8">&nbsp;</td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Taxable Purchases</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="PStaxReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(P_Taxnet1,'_,__.__')#</a></label>
            <input name="P_Tax1" type="hidden" value="#numberformat(P_Taxnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_Tax1" type="button" value="Change" onClick="JavaScript:Chk_P_Tax1()"> --->
          </div></td>
        <cfset T_P_Sales = P_Taxnet1 - P_Taxnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_P_Sales,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">PTAX</font></div></td>
        <td rowspan="2"><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">Purchases
            Tax</font></div>
          <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <cfset P_TAX3 = P_Tax1>
		<td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_Tax1,'_,__.__')#</label>
            <input name="P_Tax3" type="hidden" value="#numberformat(P_Tax1,'_.__')#">
            </font></div></td>
        <td> <div align="right">
            <!--- <input name="txtP_Tax3" type="button" value="Change" onClick="JavaScript:Chk_P_Tax3()"> --->
          </div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_Taxnet2,'_,__.__')#</label>
            <input name="P_Tax2" type="hidden" value="#numberformat(P_Taxnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_Tax2" type="button" value="Change" onClick="JavaScript:Chk_P_Tax2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
		<cfset P_TAX4 = P_Tax2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_Tax2,'_,__.__')#</label>
            <input name="P_Tax4" type="hidden" value="#numberformat(P_Tax2,'_.__')#">
            </font></div></td>
        <td> <div align="right">
            <!--- <input name="txtP_Tax4" type="button" value="Change" onClick="JavaScript:Chk_P_Tax4()"> --->
          </div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Zero-Rated Purchases</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="pZRReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(P_ZRnet1,'_,__.__')#</a></label>
            <input name="P_ZR1" type="hidden" value="#numberformat(P_ZRnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_ZR1" type="button" value="Change" onClick="JavaScript:Chk_P_ZR1()"> --->
          </div></td>
        <cfset T_P_ZR = P_ZRnet1 - P_ZRnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_P_ZR,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">ZR</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <cfset Total_PTax = P_Tax3 - P_Tax4>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            #numberformat(Total_PTax,'_,__.__')#
            <label></label>
            </font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_ZRnet2,'_,__.__')#</label>
            <input name="P_ZR2" type="hidden" value="#numberformat(P_ZRnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_ZR2" type="button" value="Change" onClick="JavaScript:Chk_P_ZR2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td rowspan="2"><font size="2" face="Arial, Helvetica, sans-serif">Major
          Exporter Scheme Purchases</font><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="PMESReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(P_MESnet1,'_,__.__')#</a></label>
            <input name="P_MES1" type="hidden" value="#numberformat(P_MESnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_MES1" type="button" value="Change" onClick="JavaScript:Chk_P_MES1()"> --->
          </div></td>
        <cfset T_P_MES = P_MESnet1 - P_MESnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_P_MES,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">MES</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;
            </font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_MESnet2,'_,__.__')#</label>
            <input name="P_MES2" type="hidden" value="#numberformat(P_MESnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_MES2" type="button" value="Change" onClick="JavaScript:Chk_P_MES2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Exempt Purchases</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label><a href="PEXReport.cfm?pfrom=#periodfrom#&pto=#periodto#" target="_blank">#numberformat(P_EXnet1,'_,__.__')#</a></label>
            <input name="P_EX1" type="hidden" value="#numberformat(P_EXnet1,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_EX1" type="button" value="Change" onClick="JavaScript:Chk_P_EX1()"> --->
          </div></td>
        <cfset T_P_EX = P_EXnet1 - P_EXnet2>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(T_P_EX,'_,__.__')#</label>
            </font></div></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">EX</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;
            </font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td> <div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(P_EXnet2,'_,__.__')#</label>
            <input name="P_EX2" type="hidden" value="#numberformat(P_EXnet2,'_.__')#">
            </font></div></td>
        <td><div align="center">
            <!--- <input name="txtP_EX2" type="button" value="Change" onClick="JavaScript:Chk_P_EX2()"> --->
          </div></td>
        <td><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
        <td><div align="center"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">&nbsp;</font></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <tr>
        <td><font size="2" face="Arial, Helvetica, sans-serif">Total Purchases</font></td>
        <td><div align="right"></div></td>
        <td><div align="center"></div></td>
        <cfset GTotal_Purchases = T_P_Sales + T_P_ZR + T_P_MES + T_P_EX>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <label>#numberformat(GTotal_Purchases,'_,__.__')#</label>
            </font></div></td>
        <td>&nbsp;</td>
        <td><div align="right"></div></td>
        <td><div align="right"></div></td>
        <td><div align="right"></div></td>
      </tr>
      <tr>
        <td colspan="8"><hr></td>
      </tr>
      <tr>
        <cfset STvsPT = Total_STax - Total_PTax>
        <cfif STvsPT eq 0>
          <cfset Str = ''>
          <cfelseif STvsPT gt 0>
          <cfset Str = 'SALES TAX EXCEED PURCHASES TAX BY :'>
          <cfelse>
          <cfset Str = 'PURCHASES TAX EXCEED SALES TAX BY :'>
          <cfset STvsPT = Total_PTax - Total_STax>
        </cfif>
        <td colspan="3"><font size="2" face="Arial, Helvetica, sans-serif">#Str#</font></td>
        <td><div align="right"><font size="2" face="Arial, Helvetica, sans-serif">
            <cfif STvsPT neq 0>
              <label>#numberformat(STvsPT,'_,__.__')#</label>
            </cfif>
            </font></div></td>
        <td>&nbsp;</td>
        <td><div align="right"></div></td>
        <td><div align="right"></div></td>
        <td><div align="right">
            <!--- <input type="Submit" name="Submit" value="Update"> --->
          </div></td>
      </tr>
    </table>
<!--- 	<input name="T_S_Sales" type="hidden" value="#form.T_S_Sales#">
	<input name="T_S_ZR" type="hidden" value="#form.T_S_ZR#">
	<input name="T_S_EX" type="hidden" value="#form.T_S_EX#">
	<input name="Total_STax" type="hidden" value="#form.Total_STax#">
	<input name="GTotal_Sales" type="hidden" value="#form.GTotal_Sales#">

	<input name="T_P_Sales" type="hidden" value="#form.T_P_Sales#">
	<input name="T_P_ZR" type="hidden" value="#form.T_P_ZR#">
	<input name="T_P_MES" type="hidden" value="#form.T_P_MES#">
	<input name="T_P_EX" type="hidden" value="#form.T_P_EX#">
	<input name="Total_PTax" type="hidden" value="#form.Total_PTax#">
	<input name="GTotal_Purchases" type="hidden" value="#form.GTotal_Purchases#"> --->
  </cfoutput>
</cfform>

<cfform action="TaxTotal_View2.cfm" method="post" name="form1">
  <cfoutput>
  <cfquery name='getgeneral' datasource='#dts#'>
    select compro from gsetup
  </cfquery>

  <input name="periodfrom" type="hidden" value="#form.periodfrom#">
  <input name="periodto" type="hidden" value="#form.periodto#">
  <input name="Company" type="hidden" value="#getgeneral.compro#">
  <input name="Str" type="hidden" value="#Str#">
  <input name="STvsPT" type="hidden" value="#STvsPT#">

<!---   <cfif isdefined('form.S_Tax1')>
	<input name="S_Tax1" type="hidden" value="#form.S_Tax1#">
	<input name="S_Tax2" type="hidden" value="#form.S_Tax2#">
	<input name="S_Tax3" type="hidden" value="#form.S_Tax3#">
	<input name="S_Tax4" type="hidden" value="#form.S_Tax4#">
	<input name="S_ZR1" type="hidden" value="#form.S_ZR1#">
	<input name="S_ZR2" type="hidden" value="#form.S_ZR2#">
	<input name="S_EX1" type="hidden" value="#form.S_EX1#">
	<input name="S_EX2" type="hidden" value="#form.S_EX2#">
	<input name="T_S_Sales" type="hidden" value="#form.T_S_Sales#">
	<input name="T_S_ZR" type="hidden" value="#form.T_S_ZR#">
	<input name="T_S_EX" type="hidden" value="#form.T_S_EX#">
	<input name="Total_STax" type="hidden" value="#form.Total_STax#">
	<input name="GTotal_Sales" type="hidden" value="#form.GTotal_Sales#">

	<input name="P_Tax1" type="hidden" value="#form.P_Tax1#">
	<input name="P_Tax2" type="hidden" value="#form.P_Tax2#">
	<input name="P_Tax3" type="hidden" value="#form.P_Tax3#">
	<input name="P_Tax4" type="hidden" value="#form.P_Tax4#">
	<input name="P_ZR1" type="hidden" value="#form.P_ZR1#">
	<input name="P_ZR2" type="hidden" value="#form.P_ZR2#">
	<input name="P_MES1" type="hidden" value="#form.P_MES1#">
	<input name="P_MES2" type="hidden" value="#form.P_MES2#">
	<input name="P_EX1" type="hidden" value="#form.P_EX1#">
	<input name="P_EX2" type="hidden" value="#form.P_EX2#">
	<input name="T_P_Sales" type="hidden" value="#form.T_P_Sales#">
	<input name="T_P_ZR" type="hidden" value="#form.T_P_ZR#">
	<input name="T_P_MES" type="hidden" value="#form.T_P_MES#">
	<input name="T_P_EX" type="hidden" value="#form.T_P_EX#">
	<input name="Total_PTax" type="hidden" value="#form.Total_PTax#">
	<input name="GTotal_Purchases" type="hidden" value="#form.GTotal_Purchases#">
  <cfelse> --->
	<input name="S_Tax1" type="hidden" value="#S_Taxnet1#">
	<input name="S_Tax2" type="hidden" value="#S_Taxnet2#">
	<input name="S_Tax3" type="hidden" value="#S_Tax1#">
	<input name="S_Tax4" type="hidden" value="#S_Tax2#">
	<input name="S_ZR1" type="hidden" value="#S_ZRnet1#">
	<input name="S_ZR2" type="hidden" value="#S_ZRnet2#">
	<input name="S_EX1" type="hidden" value="#S_EXnet1#">
	<input name="S_EX2" type="hidden" value="#S_EXnet2#">
	<input name="T_S_Sales" type="hidden" value="#T_S_Sales#">
	<input name="T_S_ZR" type="hidden" value="#T_S_ZR#">
	<input name="T_S_EX" type="hidden" value="#T_S_EX#">
	<input name="Total_STax" type="hidden" value="#Total_STax#">
	<input name="GTotal_Sales" type="hidden" value="#GTotal_Sales#">
	<input name="P_Tax1" type="hidden" value="#P_Taxnet1#">
	<input name="P_Tax2" type="hidden" value="#P_Taxnet2#">
	<input name="P_Tax3" type="hidden" value="#P_Tax1#">
	<input name="P_Tax4" type="hidden" value="#P_Tax2#">
	<input name="P_ZR1" type="hidden" value="#P_ZRnet1#">
	<input name="P_ZR2" type="hidden" value="#P_ZRnet2#">
	<input name="P_MES1" type="hidden" value="#P_MESnet1#">
	<input name="P_MES2" type="hidden" value="#P_MESnet2#">
	<input name="P_EX1" type="hidden" value="#P_EXnet1#">
	<input name="P_EX2" type="hidden" value="#P_EXnet2#">
	<input name="T_P_Sales" type="hidden" value="#T_P_Sales#">
	<input name="T_P_ZR" type="hidden" value="#T_P_ZR#">
	<input name="T_P_MES" type="hidden" value="#T_P_MES#">
	<input name="T_P_EX" type="hidden" value="#T_P_EX#">
	<input name="Total_PTax" type="hidden" value="#Total_PTax#">
	<input name="GTotal_Purchases" type="hidden" value="#GTotal_Purchases#">
<!---   </cfif> --->

  <table align="center" border="0" width="100%">
    <tr>
	  <td> <div align="right">
          <input type="Submit" name="Submit" value="Print">
        </div></td>
	</tr>
  </table>
  </cfoutput>
</cfform>
</body>
</html>