var USER_FILE_COUNT=3;

$(document).ready(function(){

	//License agreement pop-up window
	$("a#licenseButton").click(function(e){
		$("#licenseModal").modal('show');	
	});

	$("#resume_help").popover({
		content: "Please upload your resumes or CVs! (maximum of 3)",
		html: true
	});

	//Limit File Upload Count
  $('.add_fields').click(function(e){
    if(FileCount<USER_FILE_COUNT){
      FileCount +=1;
      if(FileCount==USER_FILE_COUNT){
        $('.upload_btn').removeClass('btn-primary');
        $('.upload_btn').css('background-color','grey');
        $('.upload_btn > a').css('cursor','no-drop');
      } 
    }else{
      e.preventDefault();
      return false;
    }
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