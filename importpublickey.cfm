<cfexecute name="C:\Program Files (x86)\GnuPG\bin\gpg.exe" 
           arguments="--import C:\NEWSYSTEM\IMS\publickey.asc" 
            errorFile="C:\TEMP\GnuPG_error\test_bat_error.txt"  
           timeout="0">
        </cfexecute>