var map;
var marker;

$(document).ready(function(){
	initialize();		
});

function initialize() {
	console.log("initialize");
	console.log(gon.latitude);
	console.log(gon.longitude);
	
	var coor = new google.maps.LatLng(gon.latitude,gon.longitude);

	var mapOptions = {
    	center: coor,
        zoom: 14
    };
    
    map = new google.maps.Map(document.getElementById("map-canvas-show"), mapOptions);

    marker = new google.maps.Marker({
    	position: coor,
    	draggable: true,
    	animation: google.maps.Animation.DROP,
    	map: map,
    	title: "location"
    });
    google.maps.event.addListener(marker,'click',toggleBounce);
};

function toggleBounce(){
	if (marker.getAnimation() != null){
		marker.setAnimation(null);
	} else{
		marker.setAnimation(google.maps.Animation.BOUNCE);
	}
};
