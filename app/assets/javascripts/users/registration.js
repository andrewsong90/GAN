var USER_FILE_LIMIT=3;

$(document).ready(function(){

	var user_file_count=0;
	//License agreement pop-up window
	$("a#licenseButton").click(function(e){
		$("#licenseModal").modal('show');	
	});

	$("#resume_help").popover({
		content: "Please upload your resumes or CVs! (maximum of 3)",
		html: true
	});

	$("#skill_help").popover({
		content: "Select a few fields you are interested in or have expertise. You can always change these later.",
		html: true
	});

	$('#picture_help').popover({
		content: "Upload a picture for your profile.<br> This is optional.",
		html: true
	});

	$("#registration_parent_email_help").popover({
		content: "Input either of your parent's email addresses from the time you were a Gann student."
	});

	$("#password_help").popover({
		content: "Password needs to be at least 6 characters"
	});

	//Limit File Upload Count
  $('.upload_link').click(function(e){
    if(user_file_count<USER_FILE_LIMIT){
      user_file_count +=1;
      if(user_file_count==USER_FILE_LIMIT){
        $('.upload_btn').removeClass('btn-primary');
        $('.upload_btn').addClass('btn-warning');
        $('.upload_btn > a').css('cursor','no-drop');
      } 
    }else{
      e.preventDefault();
      return false;
    }
  });

  $('.container').on("click",".remove_upload_link",function(){
    if(user_file_count==USER_FILE_LIMIT){
      $('.upload_btn > a').css('cursor','pointer');
      $('.upload_btn').removeClass('btn-warning');
      $('.upload_btn').addClass('btn-primary');
    }
    user_file_count-=1;
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