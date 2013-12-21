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