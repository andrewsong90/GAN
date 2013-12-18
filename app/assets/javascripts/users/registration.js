$(document).ready(function(){

	//License agreement pop-up window
	$("a#licenseButton").click(function(e){
		$("#licenseModal").modal('show');	
	});

	$("#resume_help").popover({
		content: "Please upload your resumes or CVs! (maximum of 3)",
		html: true
	});

	//Force phone format (from Jasny Bootstrap)
	$("#phone").inputmask({
		mask: '(999)-999-9999'
	});

	//Validation scheme
	$("#confirmation_form").submit(function(e){
		if($('#license').prop('checked')){
			return true;
		}else{
			$('#warningModal').modal('show');
			return false;
		}
	});
	
});