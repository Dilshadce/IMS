<cfset total =0>
<cfhttp method="get" url="https://operation.mp4u.com.my/test.csv" name="csvData">
<cfloop query="csvdata" >
	<cfscript>

			total += csvdata['a'][currentRow];

			if(csvdata['empno'][currentRow] != csvdata['empno'][currentRow + 1]){
				if(total != csvdata['c'][currentRow]){
					WriteOutput(csvdata['empno'][currentRow] & " c " & c & " & " & a & " TO " & total & "<br />");
					total = 0;
				}
			}




	</cfscript>
</cfloop>
