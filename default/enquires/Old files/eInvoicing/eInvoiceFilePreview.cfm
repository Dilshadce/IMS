<cfquery name="getgeneral" datasource="#dts#">
	select invoicedatafile from gsetup
</cfquery>
<cfoutput>
   <textarea cols="100" rows="25" readonly="readonly" wrap="off">#fileread("#HRootPath#\eInvoicing\#dts#\iv3600#getGeneral.invoiceDataFile#.dat")#
   </textarea> 
   </cfoutput>