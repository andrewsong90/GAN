// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.navgoco
//= require jquery.cookie
//= require twitter/bootstrap
//= require bowser
//= require cocoon
//= require jquery.fs.naver
// require opportunities/index
//= require jasny-bootstrap
//= require tinymce

$(document).ready(function(){

	$(".navigation").naver({
		maxWidth: "980px",
		labels: {
			closed: "Menu",
			open: "Close"
		},
	});

});