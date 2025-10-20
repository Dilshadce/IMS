<cfset list = "%Accenture%,
%HPMM%,
%IBM%,
%SCGS%,
%Venture%,
%L'Oreal%,
%Intel%,
%Ericsson%,
%CSC%,
%Samsung%,
%Ipsos%,
%BAT%,
%DiGi%,
%Unisys%,
%CEVA%,
%3M%,
%VADS%,
%Uber%,
%Carefusion%,
%BAE%,
%DHL%,
%Olympus%,
%BT%,
%Boston%,
%Honeywell%,
%Mindpearl%,
%GEIM%,
%KellyOCG%,
%CB%,
%NCR%,
%Lenovo%,
%AMEX%,
%Teka%,
%Sudong%,
%Wincor%,
%Experis US%,
%PUIG%,
%ExxonMobil%,
%Wyeth%,
%Ceedtec%,
%BeMyGuest%,
%Schneider%,
%Nestle%,
%eBay%,
%Kintetsu%,
%MSD%,
%Sodexo%,
%EntServ%,
%Suria KLCC%,
%Mediabrands%,
%Dell%,
%S.C.Johnson%,
%Amway%,
%Palco%,
%Prometric%,
%Danone%,
%Keysight%,
%Texas%,
%Emerald%,
%Volvo%,
%Essai%,
%Halyard%,
%Artesyn%,
%Syngenta Crop%,
%Fraser%,
%B Braun%,
%HP PPS%,
%Seagate%,
%ManpowerGroup%,
%Manpower Hong Kong%,
%JETRO%,
%Hino%,
%Collabera%,
%Appraisal%,
%Mobike%,
%Compargo%,
%NCSI%,
%Agilent%,
%Manpower Australia%,
%HFC Prestige%,
%Celestica%,
%Salesforce.com%,
%Synopsys%,
%Cook Asia%,
%SWIFT%,
%MARS%,
%Khazanah%,
%Memsstar%,
%Tarkett%,
%Pan Asia%,
%UXP%,
%Bafco%,
%Aleris%,
%Mezza%,
%Allegis%,
%Bibliotheca%,
%Seminal Research%,
%Technip%,
%Cogdev%,
%Kidzania%,
%AXA%,
%Wong%,
%Sanofi%,
%Syngenta%,
%Reckitt%,
%WG Services%,
%Mondelez%,
%Cochlear%,
%CPA Australia%,
%Han System Design%,
%Dialog%,
%Lafarge%,
%Bosch%,
%Elster%,
%Bank of New York%,
%Aon%,
%Linde%,
%Standard Chartered%,
%Green Packet%,
%Bp%,
%Harsco%,
%Renault%,
%Cargill%,
%Lodging%,
%ATS Automation%,
%Bloomberg%,
%KHAZANAH %,
%ServiceRocket%,
%(blank)%,
%FPT Far East%,
%Parker Hannifin%,
%Enza%,
%ITW Meritex%,
%Elantas Malaysia%,
%Asian Business Software%,
%Parker%,
%O&M%,
%Air Products%,
%Straits%,
%Enza Zaden%,
%Viacom%,
%Citibank%,
%Interglobe Technologies%,
%Arrow Components%,
%Oracle%,
%Exxon%,
%ITW%,
%Teleperfomance%,
%RS Component%,
%Dow Chemical%,
%Synaptics%,
%Quantum%,
%Professional Fee%,
%Royal Bird's Nest%,
%Right%,
%IIA Malaysia%,
%Promo Tec%,
%Tractus Asia%,
%Bruker%,
%Focus Software%,
%Interglobe%,
%Resource Data Mngt%,
%Schaeffler%
">
    
<!---Prepare temp excel file to write data--->
<cfset currentDirectory = "#Hrootpath#\Excel_Report_JO\">
    
<cfset timenow = "#DateTimeFormat(now(), 'yyyymmddhhnnss')#">
    
<cfif DirectoryExists(currentDirectory) eq false>
    <cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<!---Prepare temp excel file to write data--->
    
<cfloop index='a' list="#list#">
    
<cfset data = SpreadSheetNew(true)>
    
<cfquery name="getdata" datasource="#dts#">
    select placementno,custno,custname,empno,empname,pm "price_id",
    startdate,completedate,pm.dbcandidtype,
    case when jobpostype ='1' 
    then "Temp" 
    else 
        case when jobpostype ='2' 
        then "Contract" 
        else 
            case when jobpostype ='3' 
            then "Perm" 
            else
                case when jobpostype ='5' 
                then "Wage Master" 
                else "" end
            end
        end
    end as Type
    from placement p
    left join ftcandidate pm
    on p.empno=pm.dbcandno
    where custname like "#trim(a)#" and empno<>'0'
</cfquery>
    
<cfif getdata.recordcount neq 0>
    
    <cfset SpreadSheetAddRow(data, "JO No,Client ID,Client Name,Cand ID,Cand Name,Price Structure ID,Start Date,End Date,Local/Foreigner,Contract Type")>

    <cfset SpreadSheetAddRows(data, getdata)>

    <cfspreadsheet action="write" sheetname="Data" filename="#HRootPath#\Excel_Report_JO\JO_Listing_#trim(replace(a,'%','','all'))#_#timenow#.xlsx" name="data" overwrite="true">
    
</cfif>
    
</cfloop>