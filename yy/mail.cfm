<cfset mailAttributes = {
from="mp4u@manpower.com",
to="cyyang94@hotmail.com",
subject="test",
port=25,
server="mail-apac01.manpower.com",
password="Manpower60",
username="mp4u"

}
/>

<cfmail
attributeCollection="#mailAttributes#"
>test asedaf</cfmail>