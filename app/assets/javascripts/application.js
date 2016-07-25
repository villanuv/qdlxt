// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function getProductInfo(productId, productTags){
  if ($('#' + productId + '-lc').is(":checked")) {
    var lcTag = true;
  } else {
    var lcTag = false;
  }
  if ($('#' + productId + '-l4l4u').is(":checked")) {
    var l4l4uTag = true;
  } else {
    var l4l4uTag = false;
  }
  var prodString = productId + ' ' + lcTag + ' ' + l4l4uTag;
  var prodJson = { 
    "product": {
      "id": productId,
      "tags": productTags + ', lc__' + lcTag + ', l4l4u__' + l4l4uTag
    }
  };
  $.ajax({
      url: "/webhooks/" + productId + ".json",
      type: "POST",
      data: JSON.stringify(prodJson),
      contentType: "application/json"
  })
  .done(function(){
    alert(JSON.stringify(prodJson, null, 4));
  })
  .fail(function(){
    alert("error");
  });

}    