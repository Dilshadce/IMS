<cfscript>
/**
 * Validates if a string is a valid time in 12- or 24-hour format
 * 
 * @param time      time string to check format (Required)
 * @param formatOption      argument to check if 12 or 24 hr format required (Optional)
 * @return Returns a boolean. 
 * @author Mosh Teitelbaum (mosh.teitelbaum@evoch.com) 
 * @version 0, March 4, 2010 
 */
function isTime(time) {
    var found=0;
    if ( (arrayLen(arguments) eq 2) AND (arguments[2] is "12")) {
        found=reFindNoCase("^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [ap]m))$", arguments.time);
    } else if ( (arrayLen(Arguments) eq 2) AND (Arguments[2] is "24")) {
        found=reFindNoCase("^([01]\d|2[0-3])(:[0-5]\d){0,2}$", arguments.time);
    } else {
        found=reFindNoCase("^([01]\d|2[0-3])(:[0-5]\d){0,2}$|^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [ap]m))$", arguments.time);
    }
    if (found GT 0)
        return true;
    else
        return false;
}
</cfscript>