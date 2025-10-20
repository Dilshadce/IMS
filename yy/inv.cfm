<cfsetting showDebugOutput="No">


<cfquery datasource="manpower_i" name="getAssignment">
	SELECT * FROM manpower_i.assignmentslip limit 10;
</cfquery>
<html>
	<head>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
			$(document).ready(function(){
						var raw = JSON.parse('<cfoutput>#serializeJson(getAssignment)#</cfoutput>');
						var columns = raw.COLUMNS;
						var data = raw.DATA;

						var struct = [];

						for(var i = 0; i < data.length; i++){
							struct[i] = {};
							for(var j = 0; j< columns.length; j++){
								struct[i][columns[j]] = data[i][j];
							}
						}

						for(var i =0; i < struct.length; i++){
							sendForm(struct[i]);
						}



			});

			function sendForm(data){

				$.post(
				"formDump.cfm",
				data,
				function(response){
					console.log(response);
				}
				);
			}


		</script>
	</head>
	<body>

	</body>
</html>

