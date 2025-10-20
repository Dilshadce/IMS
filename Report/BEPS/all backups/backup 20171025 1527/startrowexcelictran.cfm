<cfoutput>
<cfwddx action = "cfml2wddx" input = "#getictran.rem30#" output = "wddxText100">
<cfwddx action = "cfml2wddx" input = "" output = "wddxText200">
<cfif getictran.custname neq ''>
<cfwddx action = "cfml2wddx" input = "#getictran.custname#" output = "wddxText300">
<cfelse>
<cfwddx action = "cfml2wddx" input = "#getictran.name#" output = "wddxText300">
</cfif>
<cfwddx action = "cfml2wddx" input = "#getictran.custno#" output = "wddxText400">
<cfif getictran.brem1 neq ''>
    <cfwddx action = "cfml2wddx" input = "#getictran.brem1#" output = "wddxText500">
    <cfquery name="getpricename" datasource="#dts#">
        SELECT pricename FROM manpowerpricematrix 
        WHERE priceid="#getictran.pm#"
    </cfquery>
    <cfwddx action = "cfml2wddx" input = "#getictran.pricename#" output = "wddxText600">
<cfelse>
    <cfwddx action = "cfml2wddx" input = "#getictran.placementno#" output = "wddxText500">
    <cfwddx action = "cfml2wddx" input = "#getictran.pricename#" output = "wddxText600">
</cfif>
<cfwddx action = "cfml2wddx" input = "#getictran.empname#" output = "wddxText700">
<cfwddx action = "cfml2wddx" input = "#getictran.empno#" output = "wddxText800">
<cfwddx action = "cfml2wddx" input = "#getictran.brem6#" output = "wddxText900">
<cfwddx action = "cfml2wddx" input = "#dateformat(getictran.startdate,'dd/mm/yyyy')# - #dateformat(getictran.completedate,'dd/mm/yyyy')#" output = "wddxText1000">
<cfwddx action = "cfml2wddx" input = "#getictran.dlocation#" output = "wddxText1100">
<cfwddx action = "cfml2wddx" input = "#getictran.arrem5#" output = "wddxText1200">
    <cfwddx action = "cfml2wddx" input = "#getictran.icrefno#" output = "wddxText1300">
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText100#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1100#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText200#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1300#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText300#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText400#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1200#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText500#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText600#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText700#</Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText800#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText900#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText1000#</Data></Cell>
</cfoutput>