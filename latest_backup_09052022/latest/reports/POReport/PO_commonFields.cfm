
	<Row>
        <cfwddx action = "cfml2wddx" input = "#getassignment.branch#" output = "wddxTextbranch">
		<Cell>            
			<Data ss:Type="String"><cfoutput>#wddxTextbranch#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.PO#" output = "wddxTextPO">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextPO#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.candidate#" output = "wddxTextcandidate">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextcandidate#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.clientID#" output = "wddxTextclientID">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextclientID#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.company#" output = "wddxTextcompany">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextcompany#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.HM#" output = "wddxTextHM">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextHM#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.billingName#" output = "wddxTextbillingName">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextbillingName#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#getassignment.dept#" output = "wddxTextdept">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextdept#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getassignment.JO#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getassignment.startdate#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getassignment.enddate#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getassignment.payrollperiod#</cfoutput></Data>
		</Cell>
        <cfwddx action = "cfml2wddx" input = "#label#" output = "wddxTextlabel">
		<Cell>
			<Data ss:Type="String"><cfoutput>#wddxTextlabel#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="Number"><cfoutput>#billQty#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#billRate#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#billAmt#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#payQty#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#payRate#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#payAmt#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#taxable#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfif #taxable# eq 'TRUE'><cfoutput>#getAssignment.taxp1#%</cfoutput><cfelse><cfoutput>0</cfoutput></cfif></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#gstAmt#</cfoutput></Data>
		</Cell>
		<Cell>
            <Data ss:Type="Number"><cfoutput>#lineTotal#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getAssignment.invoiceno#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getAssignment.invoiceIssue#</cfoutput></Data>
		</Cell>
		<Cell>
			<Data ss:Type="String"><cfoutput>#getAssignment.invoiceDue#</cfoutput></Data>
		</Cell>
	</Row>

