_copyflocation = "/ajax/functions/copyf.cfm";
_tranflocation = "/ajax/functions/tranf.cfm";
_commonflocation = "/ajax/functions/commonf.cfm";
_crmflocation = "/ajax/functions/crmf.cfm";
_reportflocation = "/ajax/functions/reportf.cfm";
_maintenanceflocation = "/ajax/functions/maintenancef.cfm";
_fdipxflocation = "/ajax/functions/fdipxf.cfm";

function errorHandler(message)
{
	$('disabledZone').style.visibility = 'hidden';
    if (typeof message == "object" && message.name == "Error" && message.description)
    {
        alert("Error: " + message.description);
    }
    else
    {
        alert(message);
    }
};
