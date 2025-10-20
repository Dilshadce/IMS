function validate(){
	if($('#custprofile').val() == ''){
		$('#Msg').html('Please choose a Customer.');
		$('#AlertModal').modal();
	}else if($('#empno').val() == ''){
		$('#Msg').html('Please choose a Contractor.');
		$('#AlertModal').modal();
	}else if($('#payrate').val() == ''){
		$('#Msg').html('Please enter Pay Rate.');
		$('#AlertModal').modal();
	}else if($('#billrate').val() == ''){
		$('#Msg').html('Please enter Bill Rate.');
		$('#AlertModal').modal();
	}else if($('#ratetype').val() == ''){
		$('#Msg').html('Please select a Rate Type.');
		$('#AlertModal').modal();
	}else if($('#adminfee').val() == ''){
		$('#Msg').html('Please enter Admin Fee rate.');
		$('#AlertModal').modal();
	}else{
		cfsform.submit();
	};
};