$(document).ready(function(){

  // search sliders

  $("#years").slider({ from: 18, to: 80, step: 1, smooth: true, round: 0, dimension: "&nbsp;$", skin: "plastic", dimension: '&nbsp;años' });
  $("#kms").slider({ from: 0, to: 200, step: 20, round: 1, skin: "plastic", dimension: '&nbsp;kms' });


  // modal calls

  $('.reply a').click(function(e){
    e.preventDefault();
  });

  //$('#fast-reply').modal('show');

});