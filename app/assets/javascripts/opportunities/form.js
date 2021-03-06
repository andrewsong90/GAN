var start_date;
var end_date;
var OPPORTUNITY_UPLOAD_LIMIT=1;
var SPONSOR_LIMIT=4;

$(document).ready(function(){

  var opportunity_upload_count=0;
  var sponsor_count=1;

  $('#opportunity_files_help').popover({
    content: "Upload documents for supplementary descriptions (maximum of 2)<br>These will be both downloadable and viewable.",
    html: true
  });

  $('#opportunity_time_help').popover({
    content: "You have two options!<br><strong>Flexible:</strong> Start & end dates can be mutually agreed upon.<br><strong>Range:</strong> Select the available range for dates",
    html: true
  });

  $('#opportunity_skills_help').popover({
    content:"You may choose multiple options",
    html: true
  });

  $('#sponsor_help').popover({
    content: "Please input the name of your organization's contact person with the Gann Academy",
    html: true
  });

  $('#additional_contact').popover({
    content:"Fill in the email address of someone else who should receive inquiries from alumni",
    html: true
  });

  //Limit File Upload Count
  $('.upload_link').click(function(e){
    if(opportunity_upload_count<OPPORTUNITY_UPLOAD_LIMIT){
      opportunity_upload_count +=1;
      if(opportunity_upload_count==OPPORTUNITY_UPLOAD_LIMIT){
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
    if(opportunity_upload_count==OPPORTUNITY_UPLOAD_LIMIT){
      $('.upload_btn > a').css('cursor','pointer');
      $('.upload_btn').removeClass('btn-warning');
      $('.upload_btn').addClass('btn-primary');
    }
    opportunity_upload_count-=1;
  });



  $("#opportunity_fromtime").datepicker({
      onSelect: function(dateText, inst){
        start_date = new Date($(this).val());
      },
      dateFormat: "yy-mm-dd"
    });

  $("#opportunity_totime").datepicker({
      onSelect: function(dateText,inst){
        end_date= new Date($(this).val());
      },
      dateFormat: "yy-mm-dd",
      minDate: simple() //RangeStart(start_date)
    });

  $("input[name=time_type]:radio").change(function(){
    if($("#time_type_range").prop("checked")){
      $("#opportunity_fromtime").prop("disabled",false);
      $("#opportunity_totime").prop("disabled",false);
    }else{
      $("#opportunity_fromtime").prop("disabled",true);
      $("#opportunity_totime").prop("disabled",true); 
    }
  }); 

  initialize();
  console.log("hello");
});

function simple(){
  return 0;
}


function initialize() {
  
  var latitude=$(".gmap").data('lat');
  var longitude=$(".gmap").data('long');

  if(latitude=='' && longitude == ''){
    latitude = 42.394658;
    longitude = -71.216648;
  }

  var coordinate = new google.maps.LatLng(latitude, longitude)

  var mapOptions = {
    center: coordinate,
    zoom: 14
  };

  var map = new google.maps.Map(document.getElementById('map-canvas-new'),
    mapOptions);

  var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));

  var types = document.getElementById('type-selector');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var desc="<h4>Gann Academy</h4>333 Forest Street, Waltham, MA";

  var infowindow = new google.maps.InfoWindow({
    content: desc 
  });

  var marker = new google.maps.Marker({
    map: map,
    position: coordinate,
    draggable: true,
    animation: google.maps.Animation.DROP,
    title: 'Gann Academy'

  });

  google.maps.event.addListener(marker,'click',function(){
    infowindow.open(map, marker);
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });

  //The radoi buttons are not required if one option

  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.
  function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    google.maps.event.addDomListener(radioButton, 'click', function() {
      autocomplete.setTypes(types);
    });
  }

  setupClickListener('changetype-all', []);
  setupClickListener('changetype-establishment', ['establishment']);
  setupClickListener('changetype-geocode', ['geocode']);
}
