$.ajaxSetup ({  
    cache: false  
}); 

$(document).ready(function(){
  $(".soundcloud").each(function( index ){
    var element = this;
    var target = $(this).data('soundcloud');
    $.ajax({
      url: "http://soundcloud.com/oembed.json",
      data: {url: target, color: "000000"},
      success: function (response) {
        var iframe = response.html;
        $(element).html(response.html);
      },
      dataType: "json"
    });
  });
});

// .text().trim()


