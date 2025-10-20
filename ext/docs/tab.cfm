<html>


<head>

<cfajaximport scriptSrc="/CFIDE/scripts">

<script language="javascript">
<!---     getValue = function(el)
    {
        for(i=0;i<eval("document.layouts." + el + ".length");i++){
            if(eval("document.layouts." + el + "[i].checked")){
                return eval("document.layouts." + el + "[i].value");
            }
        }
    } --->

    createTab = function(parentTab)
    {
        
       
       
        var index = ColdFusion.Layout.getTabLayout(parentTab).getCount()+1;
        var tabName = "tab" + index;
        var tabTitle = "Tab " + index;
        var tabUrl = "tabUrl.cfm?index="+index;
        var tabStyle = "background-color:white ;color:black ;font-size:12px";
        var configObject = {inithide:false,selected:true,closable:true,style:tabStyle};
        ColdFusion.Layout.createTab(parentTab,tabName,tabTitle,tabUrl,configObject);
    }
</script>
</head>



<cfparam name="fontsize" default="12px">

<cfset style = "font-size:#fontsize#">

<body>
<cflayout type="tab" name="tabLayout" tabHeight="100">
    <cflayoutarea name="tab1" title="Tab 1" align="left" style="#style#" closable=true>
        
    </cflayoutarea>
</cflayout>

<cfform name="layouts">

    <cfoutput>
    <br>
    <input type="button" name="CreateTab" onClick="javascript:createTab('tabLayout');" value="Create Tab">
    </cfoutput>
</cfform>
</body>
</html>