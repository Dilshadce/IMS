<cfsetting showdebugoutput="no">
<cfoutput>

<cfquery name='getgroup' datasource='#dts#'>
    select wos_group,desp from icgroup
    where 0=0
    <cfif Hitemgroup neq ''>
    and wos_group='#Hitemgroup#'
    </cfif>
    
    and 
    (
    (category='#url.category#' or category2='#url.category#' or category3='#url.category#' or category4='#url.category#' or category5='#url.category#' or category6='#url.category#' or category7='#url.category#' or category8='#url.category#' or category9='#url.category#' or category10='#url.category#') or
    (
    (category='' or category is null) and
    (category2='' or category2 is null) and
    (category3='' or category3 is null) and
    (category4='' or category4 is null) and
    (category5='' or category5 is null) and
    (category6='' or category6 is null) and
    (category7='' or category7 is null) and
    (category8='' or category8 is null) and
    (category9='' or category9 is null) and
    (category10='' or category10 is null) 
    )
    )
    order by wos_group
</cfquery>


<select name='WOS_GROUP' id="WOS_GROUP">
            <option value=''>-</option>
            <cfloop query='getgroup'>
              <option value='#wos_group#'<cfif wos_group eq url.xgroup>selected</cfif>>#wos_group# - #desp#</option>
            </cfloop>
</select>
</cfoutput>