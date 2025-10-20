<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<div style="visibility:hidden" id="ajaxFieldPro">
</div>
<script type="text/javascript">
function loadpost(status)
{
setTimeout("ajaxFunction(document.getElementById('ajaxFieldPro'),'proload.cfm?status='+status);",750);
}
loadpost('load');
</script>
