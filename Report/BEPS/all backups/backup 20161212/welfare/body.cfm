<cfoutput>
<tr>
          <td align="center">#getplacement.placementno#</td>
          <td align="center" >#getplacement.consultant#</td>
          <td align="center" >#getplacement.custno#</td>
          <td align="center" >#getplacement.custname#</td>
          <td align="center" >#getplacement.empno#</td>
          <td align="center" >#getplacement.empname#</td>
          <td align="center" >#evaluate('getplacement.welfare#a#')#</td>
          <td align="center" >#dateformat(evaluate('getplacement.welfareclaimdate#a#'),'dd/mm/yyyy')#</td>
           <td align="center" >#dateformat(evaluate('getplacement.welfareclaimeddate#a#'),'dd/mm/yyyy')#</td>
            <td align="center" >#dateformat(evaluate('getplacement.welfaredisdate#a#'),'dd/mm/yyyy')#</td>
            
          <td align="center" >
		<cfif evaluate('getplacement.welfareeg#a#') eq "Y" and evaluate('getplacement.welfaredisq#a#') neq "Y">
        Yes<cfelse>No</cfif>
		</td>
        </tr>
</cfoutput>