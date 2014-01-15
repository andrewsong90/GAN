var add_favorites_url = "/opportunities/add_to_favorites/"
var remove_favorites_url = "/opportunities/remove_from_favorites/"

var add_to_favorites = function(opportunity_id){
	$.ajax({
		url: add_favorites_url+opportunity_id,
		success: function(data){
			
			$('#'+opportunity_id).removeClass('btn-primary');
			$('#'+opportunity_id).removeClass('add_favorite_btn');

			$('#'+opportunity_id).addClass('remove_favorite_btn');
			$('#'+opportunity_id).addClass('btn-success');
			$('#'+opportunity_id).html("<span class='btn-label'><i class='fa fa-check'></i></span>Saved");
		},
		type: 'GET'		
	})
};

var remove_from_favorites = function(opportunity_id){
	$.ajax({
		url: remove_favorites_url+opportunity_id,
		success: function(data){
			

			$('#'+opportunity_id).removeClass('btn-success');
			$('#'+opportunity_id).removeClass('remove_favorite_btn');

			$('#'+opportunity_id).addClass('add_favorite_btn');
			$('#'+opportunity_id).addClass('btn-primary');
			$('#'+opportunity_id).html("<span class='btn-label'><i class='fa fa-plus'></i></span>Save");
		},
		type: 'POST'		
	})
};


$(document).ready(function(){

	console.log($(window).scrollTop());

	$(".super-container").on("click",".add_favorite_btn",function(e){
		console.log("clicked "+e.target.id);
		add_to_favorites(e.target.id);
	});

	$(".super-container").on("click",".remove_favorite_btn",function(e){
		remove_from_favorites(e.target.id);
	});

	$(".super-container").jumpto({
		firstLevel: "> h2",
		secondLevel: false,
		innerWrapper: ".container",
		offset: 5,
		animate: 1000,
		navContainer: false,
		anchorTopPadding: 60,
		showTitle: "Jump to",
		closeButton: false	
	});

	// $("select").minimalect({
	// 	theme: "bubble"
	// });

});