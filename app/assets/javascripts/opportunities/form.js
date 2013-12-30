var start_date;
var end_date;
var OPPORTUNITY_UPLOAD_LIMIT=3;
var SPONSOR_LIMIT=4;

$(document).ready(function(){

  var opportunity_upload_count=0;
  var sponsor_count=1;

  window.ClientSideValidations.callbacks.form.fail = function(form,eventData){
    console.log("FAILED!");
  }

  $('#opportunity_files_help').popover({
    content: "Upload documents for supplementary descriptions (maximum of 3)<br>These will be both downloadable and viewable.",
    html: true
  });

  $('#opportunity_time_help').popover({
    content: "You have two options!<br><strong>Flexible:</strong> Make appointments later on<br><strong>Range:</strong> Select the available range for dates",
    html: true
  });

  $('#opportunity_skills_help').popover({
    content:"Please select at least one of the following fields",
    html: true
  })

  $('#sponsor_help').popover({
    content: "Sponsors!<br>Please type in contact info for the sponsors",
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


  //Limit Sponsor Count
  $('.sponsor_link').click(function(e){
    if(sponsor_count<SPONSOR_LIMIT){
      sponsor_count +=1;
      if(sponsor_count==SPONSOR_LIMIT){
        $('.sponsor_btn').removeClass('btn-primary');
        $('.sponsor_btn').addClass('btn-warning');
        $('.sponsor_btn > a').css('cursor','no-drop');
      } 
    }else{
      e.preventDefault();
      return false;
    }
  });

  $('.container').on("click",".remove_sponsor_link",function(){
    if(sponsor_count==SPONSOR_LIMIT){
      $('.sponsor_btn > a').css('cursor','pointer');
      $('.sponsor_btn').removeClass('btn-warning');
      $('.sponsor_btn').addClass('btn-primary');
    }
    sponsor_count-=1;
  });



  $("#opportunity_fromtime").datepicker({
      onSelect: function(dateText, inst){
        start_date = new Date($(this).val());
      },
      dateFormat: "yy-mm-dd",
      maxDate: RangeEnd(end_date)
    });

  $("#opportunity_totime").datepicker({
      onSelect: function(dateText,inst){
        end_date= new Date($(this).val());
      },
      dateFormat: "yy-mm-dd",
      minDate: simple() //RangeStart(start_date)
    });

  $("input[name=time_type]:radio").change(function(){
    console.log("CHANGED");
    if($("#time_type_range").prop("checked")){
      $("#opportunity_fromtime").prop("disabled",false);
      $("#opportunity_totime").prop("disabled",false);
    }else{
      $("#opportunity_fromtime").prop("disabled",true);
      $("#opportunity_totime").prop("disabled",true); 
    }
  }); 

  initialize();

});

function simple(){
  console.log("Simple");
  return 0;
}

function RangeEnd(end){
  console.log("RANGEEND")
  if (end==undefined)
    return null;
  else
    end_date =end;
    return end_date;
}

function RangeStart(start){
  console.log("RANGESTART")
  if (start==undefined)
    return null;
  else
    start_date = start;
    console.log("Startdate"+start_date+" "+start);
    return start_date;
}

function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(42.359184, -71.093544),
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

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map
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

// google.maps.event.addDomListener(window,'load',initialize);