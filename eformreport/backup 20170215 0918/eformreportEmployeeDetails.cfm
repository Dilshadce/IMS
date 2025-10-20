<cfset targetTable="pmast">
<cfset pageTitle="Personal Information">
<cfset pageTitle2="Tax Information">
<cfset pageTitle3="Other Information">
<cfset empno = trim("#url.empno#")>
<!---created [15/1/2017, Alvin]--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    
    <cfset dts_p=replace(dts,'_i', '_p')>
    
    <!---changed some variable name and value--->
    <cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
            var display='T';
			var empno = '#empno#';
            var targetTable='#targetTable#';
			//personal information
            var empname ='Name';
			var address1 ='Adress1';
			var address2 ='Address2';
			var dob = 'Date of Birth';
			var gender = 'Gender';
			var race = 'Race';
			var origincountry = "Country of Origin";
			var contactno = 'Contact No';
			var personalemail = 'Personal Email';
			var workemail = 'Work Email';
			var maritalstatus = 'Marital Status';
			var nricpassport = 'Passport No / IC No';
			var passportexpiry = 'Passport Expiring Date';
			var secondpassport = 'Second Passport';
			var highesteducation = 'Highest Education';
			var nationality = 'Nationality';
			var emergencycontactperson = 'Emergency Contact Person';
			var emergencycontactno = 'Emergency Contact No';
			var originalcountryadd1 = 'Address of Original Country';
			var originalcountryadd2 = 'Address of Original Country';
			
			//tax information
			var taxno = 'Tax no';
			var taxbranch = 'Tax Branch';
			var spouseworking = 'Spouse Working';
			var spousename = 'Spouse Name';
			var spouseic = 'Spouse IC';
			var spousedisable = 'Spouse Disable';
			var numberofchild = 'Number of Child';
			var childbelow18 = 'Child below 18';
			var childstudy = 'Child Study';
			var childstudydiploma = 'Child Study Diploma Above';
			var disabledchild = "Disabled Child";
			var disabledchildstudy = 'Disabled Child Study';
			
			//Other information
			var epfno = 'EPF No';	
			var countrypub = 'Country Public Holiday Observe';
			var countryserve = 'Country Serve';
			var hiringmanagername = 'Hiring Manager Name';
			var hiringmanageremail = 'Hiring Manager Email';
			var employmentpassnno = 'Employment Pass No';
			var employmentvalidfrom = 'Employment Pass Valid From';
			var employmentvalidto = 'Employment Pass Valid To';
			var bankname = 'Bank Name';
			var bankaccountno = 'Bank Account No';
			var bankbeneficialname = 'Bank Beneficial Name';
			var workplacedepartment = 'Work Place Department';
			var designation = 'Designation';

            var SEARCH='Search';
        </script>
    </cfoutput>
    <script type="text/javascript" src="/eformreport/eformreportEmployeeDetails.js"></script>
    
</head>
<body>
<cfoutput>
	<cfsetting showdebugoutput="yes">
	<div class="container">
		<div class="page-header">
			<h2>  
            
				#pageTitle# - #empno# - #url.name#
				
				</div>
			</h2>
		</div>
		<div class="container">
			<table class="table table-bordered table-hover" id="resultTable" style="width:100%">
				<thead>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
    
    <div class="container">
		<div class="page-header">
			<h2>  
            
				#pageTitle2# - #empno# - #url.name#
				
				</div>
			</h2>
		</div>
		<div class="container">
			<table class="table table-bordered table-hover" id="resultTable2" style="width:100%">
				<thead>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
    
    <div class="container">
		<div class="page-header">
			<h2>  
            
				#pageTitle3# - #empno# - #url.name#
				
				</div>
			</h2>
		</div>
		<div class="container">
			<table class="table table-bordered table-hover" id="resultTable3" style="width:100%">
				<thead>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</cfoutput>

</body>
</html>