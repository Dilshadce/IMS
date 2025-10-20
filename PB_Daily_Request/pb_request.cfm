<cfsetting showdebugoutput="True" requesttimeout="0">

<html>
    <head>
        <link rel="stylesheet" href="/latest/css/bootstrap-3.3.7/bootstrap.min.css">
        <link rel="stylesheet" href="/latest/css/bootstrap-datetimepicker-3.1.3/bootstrap-datetimepicker-3.1.3.min.css">
        <link rel="stylesheet" href="/latest/css/bootstrap-validator-0.5.3/bootstrapValidator.min.css">
        <link rel="stylesheet" href="/latest/css/custom-style/custom-button.css">
        
        <script type="text/javascript" src="/latest/js/jquery/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="/latest/js/bootstrap-3.3.7/bootstrap.min.js"></script>
        <script type="text/javascript" src="/latest/js/momentjs-2.10.2/momentjs-2.10.2.min.js"></script>
        <script type="text/javascript" src="/latest/js/bootstrap-datetimepicker-3.1.3/bootstrap-datetimepicker-3.1.3.min.js"></script>
        <script type="text/javascript" src="/latest/js/bootstrap-validator-v0.5.3/bootstrapValidator.min.js"></script>
        
        <script>
            var bindDateRangeValidation = function (f, s, e) {
            if(!(f instanceof jQuery)){
                    console.log("Not passing a jQuery object");
            }

            var jqForm = f,
                startDateId = s,
                endDateId = e;

            var checkDateRange = function (startDate, endDate) {
                var isValid = (startDate != "" && endDate != "") ? startDate <= endDate : true;
                return isValid;
            }

            var bindValidator = function () {
                var bstpValidate = jqForm.data('bootstrapValidator');
                var validateFields = {
                    startDate: {
                        validators: {
                            notEmpty: { message: 'This field is required.' },
                            callback: {
                                message: 'Start Date must less than or equal to End Date.',
                                callback: function (startDate, validator, $field) {
                                    return checkDateRange(startDate, $('#' + endDateId).val())
                                }
                            }
                        }
                    },
                    endDate: {
                        validators: {
                            notEmpty: { message: 'This field is required.' },
                            callback: {
                                message: 'End Date must greater than or equal to Start Date.',
                                callback: function (endDate, validator, $field) {
                                    return checkDateRange($('#' + startDateId).val(), endDate);
                                }
                            }
                        }
                    },
                    customize: {
                        validators: {
                            customize: { message: 'customize.' }
                        }
                    }
                }
                if (!bstpValidate) {
                    jqForm.bootstrapValidator({
                        excluded: [':disabled'], 
                    })
                }

                jqForm.bootstrapValidator('addField', startDateId, validateFields.startDate);
                jqForm.bootstrapValidator('addField', endDateId, validateFields.endDate);

            };

            var hookValidatorEvt = function () {
                var dateBlur = function (e, bundleDateId, action) {
                    jqForm.bootstrapValidator('revalidateField', e.target.id);
                }

                $('#' + startDateId).on("dp.change dp.update blur", function (e) {
                    $('#' + endDateId).data("DateTimePicker").setMinDate(e.date);
                    dateBlur(e, endDateId);
                });

                $('#' + endDateId).on("dp.change dp.update blur", function (e) {
                    $('#' + startDateId).data("DateTimePicker").setMaxDate(e.date);
                    dateBlur(e, startDateId);
                });
            }

            bindValidator();
            hookValidatorEvt();
        };


        $(function () {
            var sd = moment().add(-1, 'day');
            var ed = moment().add(-1, 'day');
            //var ed = new Date();  //original js

            $('#startDate').datetimepicker({ 
              pickTime: false, 
              format: "YYYY-MM-DD", 
              defaultDate: sd, 
              maxDate: ed 
            });

            $('#endDate').datetimepicker({ 
              pickTime: false, 
              format: "YYYY-MM-DD", 
              defaultDate: ed, 
              minDate: sd,
              maxDate: ed
            });

            //passing 1.jquery form object, 2.start date dom Id, 3.end date dom Id
            bindDateRangeValidation($("#form"), 'startDate', 'endDate');
        });
        </script>
        
        <style>
            .form-group {
                margin-top: 20px;
                margin-left: 25%;
                text-align: center;
            }
            
            .submitbtn {
                background-color: #f0606d;
            }
            
            .submitbtn {
                -webkit-box-shadow: 0 4px #d85662;
                box-shadow: 0 4px #d85662;
            }
            
            .submitbtn:hover {
                -webkit-box-shadow: 0 2px #d85662;
                box-shadow: 0 2px #d85662;
            }
        </style>
    </head>
    
    <body>
        <form id="form1" name="form" class="form-inline" action="pb_request_process.cfm" method="post" target="_blank">
            <div class="form-group">
                <center>
                    <label for="startDate">Start Date</label>
                    <input id="startDate" name="startDate" type="text" class="form-control" />
                    &nbsp;
                    <label for="endDate">End Date</label>
                    <input id="endDate" name="endDate" type="text" class="form-control" />

                    <br>
                    <br>
                    <button type="button" class="submitbtn" id="submitbtn" onclick="$('#form1').submit();">
                        Download PB Request File
                    </button>
                </center>
            </div>
        </form>
    </body>
</html>