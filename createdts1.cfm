
<cfquery name="getdata" datasource="main">
select userbranch from users where linktoams <> "" group by userbranch
</cfquery>
<cfloop query="getdata">
       <cfset linkdb = replacenocase('#getdata.userbranch#',"_i","_a","all") >
        <cfquery name="select_key" datasource="main">
        SELECT * FROM sec
        </cfquery>
        
        <cfset key = decrypt(#select_key.enc#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
        <cfset dbkey = decrypt(#select_key.dbkey#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
        
        <cfscript>
          adminObj = createObject("component","cfide.adminapi.administrator");
          adminObj.login("#key#");
          myObj = createObject("component","cfide.adminapi.datasource");
          myObj.setMySQL5(driver="MySQL5", 
          name="#linkdb#", 
          host = "10.0.0.15", 
          port = "3306",
          database = "#linkdb#",
          username = "ams2",
          password = "#key#",
          args = "zeroDateTimeBehavior=convertToNull",
          login_timeout = "29",
          timeout = "23",
          interval = 6,
          buffer = "64000",
          blob_buffer = "64000",
          description = "MYSQL 5",
          pooling = true,
          enableMaxConnections = "false",
          maxConnections = "3000",
          disable = false,
          storedProc = true,
          alter = true,
          grant = true,
          select = true,
          update = true,
          create = true,
          delete = true,
          drop = true,
          revoke = true);
        </cfscript>
</cfloop>