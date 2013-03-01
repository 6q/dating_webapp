$(document).ready(function(){

  // search sliders

  $("#years").slider({ 
      from: 18, 
      to: 80, 
      step: 1, 
      smooth: true, 
      round: 0, 
      dimension: "&nbsp;$", 
      skin: "plastic", 
      dimension: '&nbsp;años',
      scale: ['|','|','|','|','|','|','|','|'],
      onstatechange: function(){
        console.log($("#years").val().split(';')[0]);
        $('#years').parent().parent().find('label span').text(' entre ' + $("#years").val().split(';')[0] + ' y ' + $("#years").val().split(';')[1]);
      }
    });

  $("#kms").slider({ 
    from: 0, 
    to: 500, 
    step: 10, 
    round: 1, 
    skin: "plastic", 
    dimension: '&nbsp;kms',
    scale: ['|','|','|','|','|','|','|','|'],
    onstatechange: function(){
      $('#kms').parent().parent().find('label span').text($("#kms").val().split(';')[0] + 'kms');
      //console.log($("#kms").val().split(';')[0]);
    }
  });

  jQuery("#altura").slider({ from: 160, to: 220, step: 5, smooth: true, round: 0, dimension: "&nbsp;$", skin: "plastic", dimension: '&nbsp;cm' });
  jQuery("#afinidad").slider({ from: 0, to: 100, step: 5, round: 1, skin: "plastic", dimension: '&nbsp;%' });
  jQuery("#points, #points2").slider({ from: 1, to: 5, step: 0.5, round: 1, skin: "plastic" });

  // modal calls

  $('.reply a').click(function(e){
    e.preventDefault();
  });

  $('.block a').click(function(e){
  	e.preventDefault();
  });

  //$('#user-block').modal('show');

});