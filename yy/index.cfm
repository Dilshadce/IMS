<cfsetting showDebugOutput="No">
<html>
	<head>
		YY Checker
		<hr />
		<style>
			html{ width : 100%; overflow-x: hidden; }

			#fill{
				overflow-x : scroll;
			}
			.yellow {
				background-color : #f9da90 !important;
			}
			 .colField{ background-color : 1b4487; color : white; width: 100px; } .colee{ background-color:#FAFAFA; } .coler { background-color : #E9E9E9; } .coldata{ text-align:right; } .border-right{ border : 1px solid #d9d9d9; } #selectorContainer{ height : 300px; width : 95%; overflow-y : scroll; overflow-x : hidden; }
		</style>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
			$(document).ready(function(){
				$("#myForm").on("submit",function(e){
						e.preventDefault();
						$.post(
							"selector.cfm",
							{
								"name" : $("#name").val(),
								"empno" : $("#empno").val(),
								"custno" : $("#custno").val(),
								"where" : $("#where").val(),
								"source" : "assign",
								"custname" : $("#custname").val(),
								"placementno" : $("#placementno").val(),
								"refno" : $("#refno").val(),
								"period" : $("#period").val()

 							},
							function(response){
								$("#selectorContainer").html(response);
								showResults("");
							}
						);
				});
			});


			function showResults(response){
				$("#fill").html(response);
			}
		</script>
	</head>
	<body>
		<div class="row">
			<div class="col-lg-1 col-md-1">
			</div>
			<div class="col-lg-3 col-md-3">
				<form id="myForm" method="POST">
					<table>
						<tr>
							<td>
								placement no
							</td>
							<td>
								<input type="text" id="placementno" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								REF no
							</td>
							<td>
								<input type="text" id="refno" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								Name
							</td>
							<td>
								<input type="text" id="name" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								Empno
							</td>
							<td>
								<input type="text" id="empno" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								Cust no
							</td>
							<td>
								<input type="text" id="custno" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								Cust name
							</td>
							<td>
								<input type="text" id="custname" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								period
							</td>
							<td>
								<input type="number" id="period" class="form-control">
							</td>
						</tr>
						<tr>
							<td>
								Where
							</td>
							<td>
								<textarea id="where" name="where">
								</textarea>
							</td>
						</tr>
					</table>

					<button class="btn btn-info pull-right" type="submit" name="a" value="a">
						<span class="glyphicon glyphicon-play"></span>
					</button>
				</form>
			</div>
			<div  class="col-lg-8 col-md-8">
				<div class="well" id="selectorContainer">
				</div>
			</div>
		</div>
		<br />
		<hr />
		<div id="fill">
		</div>
	</body>
</html>
