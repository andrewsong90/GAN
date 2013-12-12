$(document).ready(function(){

	//License agreement pop-up window
	$("a#licenseButton").click(function(e){
		$("#licenseModal").modal('show');	
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