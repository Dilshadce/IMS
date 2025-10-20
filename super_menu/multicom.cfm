<cfajaximport tags="cfform">
<cfif (HUserGrpID eq "SUPER" and left(huserid,5) eq "ultra")>
	<cfif isdefined('url.type')>
        <cfquery datasource='main' name="getmulticompany">
            SELECT * 
            FROM multicomusers 
            WHERE userid="#url.id#"
        </cfquery>
    	<cfset xuserid = getmulticompany.userid>
    	<cfset comlist = getmulticompany.comlist>
    <cfelse>
    	<cfset xuserid = "">
    	<cfset comlist = "">
    </cfif>  
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Mutiple Company</title>
    <link rel="stylesheet" href="/stylesheet/stylesheet.css"/>
    <script language="javascript">
    function validate() {
        if(document.userForm.userID.value=='') {
            alert("User Id cannot be blank.");
            document.userForm.userID.focus();
            return false;			
        }
        return true;
    }
    
    function capturecomid() {
        var listlen = 0;
        try {
            listlen = document.multicomlistform.multicompicklist.length;
        }
        catch(err) {
            if(document.getElementById('multicompicklist').checked == true){
                document.getElementById('multicom').value = document.getElementById('multicompicklist').value;
                ColdFusion.Window.hide('searchmulticom');
                return true;
            }
            else{
                alert('No Company Selected');
                return true;
            }
        }
        var multicomlist = "";
        var multicomlistvar = document.multicomlistform.multicompicklist;
        for(var i=0;i<listlen;i++) {
            if(multicomlistvar[i].checked == true) {
                if(multicomlist != '') {
                    multicomlist +=',';
                }
                multicomlist +=multicomlistvar[i].value;
            }
        }
        if(multicomlist == '') {
            document.getElementById('multicom').value = '';
            ColdFusion.Window.hide('searchmulticom');
            return true;
        }
        document.getElementById('multicom').value = '';
        document.getElementById('multicom').value = multicomlist;
        ColdFusion.Window.hide('searchmulticom');
        }
        
    function searchSel(fieldid,textid) {
        var input=document.getElementById(textid).value.toLowerCase();
        var output=document.getElementById(fieldid).options;
        for(var i=0;i<output.length;i++) {
            if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
                output[i].selected=true;
                break;
            }
            if(document.getElementById(textid).value==''){
                output[0].selected=true;
            }
        }
    }
    </script>
    </head>
    
    <body>
    <h1>Multiple Company</h1>
    <hr>
    <cfoutput>
        <cfquery datasource='main' name="getuserid">
            SELECT userid,userbranch, userbranch as a 
            FROM Users
            WHERE userDept NOT IN ('ck','kalam_a','steel05_a','steel_a')
            AND userGrpID="admin"
            ORDER BY userbranch,userid
        </cfquery>
        <cfform name="userForm" action="multicomProcess.cfm" method="post" onsubmit="return validate()">
            <table border="0" >
                <tr>
                    <th>User Id :</th>
                    <td>
                        <select name="userid" id="userid">
                            <cfloop query="getuserid">
                            <option value="#getuserid.userid#" <cfif xuserid eq getuserid.userid>selected</cfif>>#getuserid.userbranch# - #getuserid.userid#</option>
                            </cfloop>
                        </select>
                        <input name="search_Sel" id="search_Sel" value="" onKeyUp="searchSel('userid','search_Sel');" />
                    </td>
                </tr>            
                <tr> 
                    <th>Multi Company List:</th>
                    <td>
                        <input type="text" name="multicom" id="multicom" size="60" value="#comlist#" readonly> &nbsp;     
                        <input type="button" name="multicombtn" id="multicombtn"  value="Choose Company" onClick="ColdFusion.Window.show('searchmulticom');">
                    </td>
                </tr>
                <tr>
                    <td colspan="100%" align="center">
                        <cfif isdefined('url.type')>
                        <input type="button" name="cancel_btn" id="cancel_btn" value="Cancel" onClick="window.location.href='multicom.cfm';">
                        </cfif>&nbsp;&nbsp;<input type="submit" name="sub_btn" id="sub_btn" value="<cfif isdefined('url.type')>#url.type#<cfelse>Create</cfif>" >
                    </td>
                </tr>                
            </table>
        </cfform>
        
        <br /><br />
        <cfquery datasource='main' name="getData">
            SELECT * 
            FROM multicomusers 
        </cfquery>
        <cfif isdefined("form.status")>
            <h1><font color="FF0000">#form.status#</font></h1>
        </cfif>    
        <table border="0">
            <tr>
                <th>No</th>
                <th>UserID</th>		
                <th>Multi Company List</th>			
                <th>Action</th>					
            </tr>
            
            <cfloop query="getData">
                <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='##99FF00';">
                    <td>#getData.currentrow#</td>
                    <td>#getData.userid#</td>
                    <td><!--- #getData.comlist#<br /> --->
                        <cfloop from="1" to="#listLen(getData.comlist)#" index="l">
                            #listgetat(getData.comlist,l,",")#<cfif l neq listLen(getData.comlist)>,</cfif><cfif l MOD 10 eq 0><br /></cfif>
                        </cfloop>            
                    </td>
                    <td>
                        <a href="/super_menu/multicom.cfm?type=Edit&id=#getData.userid#">Edit</a>&nbsp;
                        <a href="/super_menu/multicom.cfm?type=Delete&id=#getData.userid#">Delete</a>
                    </td>
                </tr>
            </cfloop>
        </table>
    </cfoutput>     
    </body>
    </html>
    <cfif (HUserGrpID eq "SUPER" and left(huserid,5) eq "ultra")>
        <cfwindow center="true" width="600" height="400" name="searchmulticom" refreshOnShow="true" closable="true" modal="false" title="Add Company" initshow="false"
            source="/default/admin/multicompany.cfm?comlist={multicom}" />
        <!--- <cfwindow center="true" width="600" height="400" name="searchUser" refreshOnShow="true" closable="true" modal="false" title="Search User" initshow="false"
                source="/admin/multicompany3.cfm" /> --->        
    </cfif>
</cfif>