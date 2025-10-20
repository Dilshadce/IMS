<cfoutput>
<cfwddx action = "cfml2wddx" input = "#getassignment.branch#" output = "wddxText1">
<cfwddx action = "cfml2wddx" input = "#getassignment.batches#" output = "wddxText2">
<cfwddx action = "cfml2wddx" input = "#getassignment.custname#" output = "wddxText3">
<cfwddx action = "cfml2wddx" input = "#getassignment.custno#" output = "wddxText4">
<cfwddx action = "cfml2wddx" input = "#getassignment.placementno#" output = "wddxText5">
<cfwddx action = "cfml2wddx" input = "#getassignment.pricename#" output = "wddxText6">
<cfwddx action = "cfml2wddx" input = "#getassignment.empname#" output = "wddxText7">
<cfwddx action = "cfml2wddx" input = "#getassignment.empno#" output = "wddxText8">
<cfwddx action = "cfml2wddx" input = "#getassignment.refno#" output = "wddxText9">
<cfwddx action = "cfml2wddx" input = "#dateformat(getassignment.startdate,'dd/mm/yyyy')# - #dateformat(getassignment.completedate,'dd/mm/yyyy')#" output = "wddxText10">
<cfwddx action = "cfml2wddx" input = "#getassignment.location#" output = "wddxText11">
<cfwddx action = "cfml2wddx" input = "#getassignment.arrem5#" output = "wddxText12">
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText11#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText4#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText12#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText6#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText7#</Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText8#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText9#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText10#</Data></Cell>
</cfoutput>