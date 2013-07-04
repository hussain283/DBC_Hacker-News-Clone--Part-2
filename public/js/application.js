$(document).ready(function () {

  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });


  $('.postvote').on('click',function(){
    var id = $('#show').attr('data-id')
    var value = $(this).attr('data-value');
    $('#show').find('.postvote').hide();
    $.ajax({
      url: "/posts/vote/create",
      type: 'post',
      data : {id: id, value: value}
    }).done(function(score) {
      console.log(score);
      $('.post_score').text(score);
    });
  });

  $('.commentvote').on('click',function(){
    var id = $(this).closest('.comment').attr('data-id');
    var value = $(this).attr('data-value');
    var self = this

    $.ajax({
      url: "/posts/comments/vote/create",
      type: 'post',
      data : {id: id, value: value}
    }).done(function(score) {
      console.log(score);
      $(self).closest('.comment').find('.comment_score').text(score);
    });
  });

});
