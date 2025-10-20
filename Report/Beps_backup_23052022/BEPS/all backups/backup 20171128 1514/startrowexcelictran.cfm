<cfoutput>
<cfif left(getictran.refno,1) eq '5' or mid(getictran.refno,3,1) eq '5'>
    <cfwddx action = "cfml2wddx" input = "MSS" output = "wddxText100">
<cfelseif left(getictran.refno,1) eq '6' or mid(getictran.refno,3,1) eq '6'>
    <cfwddx action = "cfml2wddx" input = "MBS" output = "wddxText100">
<cfelseif left(getictran.refno,1) eq '2' or mid(getictran.refno,3,1) eq '2'>
    <cfwddx action = "cfml2wddx" input = "TC" output = "wddxText100">
<cfelse>
    <cfwddx action = "cfml2wddx" input = "APMR" output = "wddxText100">
</cfif>
<cfwddx action = "cfml2wddx" input = "" output = "wddxText200">
<cfif getictran.custname neq ''>
<cfwddx action = "cfml2wddx" input = "#getictran.custname#" output = "wddxText300">
<cfelse>
<cfwddx action = "cfml2wddx" input = "#getictran.name#" output = "wddxText300">
</cfif>
<cfwddx action = "cfml2wddx" input = "#getictran.custno#" output = "wddxText400">
<cfif getictran.brem1 neq ''>
    <cfquery name="getplacement" datasource="#dts#">
        SELECT * FROM placement 
        WHERE placementno="#getictran.brem1#"
    </cfquery>
    <cfwddx action = "cfml2wddx" input = "#getictran.brem1#" output = "wddxText500">
    <cfquery name="getpricename" datasource="#dts#">
        SELECT pricename FROM manpowerpricematrix 
        WHERE priceid="#getplacement.pm#"
    </cfquery>    
    <cfwddx action = "cfml2wddx" input = "#getpricename.pricename#" output = "wddxText600">
    <cfwddx action = "cfml2wddx" input = "#getplacement.empname#" output = "wddxText700">
    <cfwddx action = "cfml2wddx" input = "#getplacement.empno#" output = "wddxText800">
<cfelse>
    <cfwddx action = "cfml2wddx" input = "#getictran.placementno#" output = "wddxText500">
    <cfwddx action = "cfml2wddx" input = "#getictran.pricename#" output = "wddxText600">
    <cfwddx action = "cfml2wddx" input = "#getictran.empname#" output = "wddxText700">
    <cfwddx action = "cfml2wddx" input = "#getictran.empno#" output = "wddxText800">
</cfif>
<cfwddx action = "cfml2wddx" input = "#getictran.brem6#" output = "wddxText900">
<cfwddx action = "cfml2wddx" input = "#getictran.brem3#" output = "wddxText1000">
<cfwddx action = "cfml2wddx" input = "#getictran.dlocation#" output = "wddxText1100">
<cfwddx action = "cfml2wddx" input = "#getictran.arrem5#" output = "wddxText1200">
<cfwddx action = "cfml2wddx" input = "#getictran.icrefno#" output = "wddxText1300">
<cfwddx action = "cfml2wddx" input = "#getictran.fperiod#" output = "wddxText1400">
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
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText1400#</Data></Cell>
</cfoutput>