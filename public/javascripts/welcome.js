$(document).ready(function(){

  $("body").css({
    opacity:0.0
  })
  .animate({
    opacity:1.0
  }, 1000);

 	$("#new_message").hide();
	/*
  $("a").mouseover( function(){ 
      $(this).animate({ 
        color: "#02EAFF",
      }, 200);
  })
  .mouseout(function(){ 
     $(this).animate({ 
        color: "#F5F5F5",
      }, 300);
  });
	*/
	$("a[rel='hello']").click( function(){
		$("#new_message").slideToggle("slow", function(){
			resetMessage();
		});
		
		return false;
	});
	
	$("a[rel='not']").click( function(){
		 $("#new_message").slideToggle("slow", function(){
			resetMessage();
		});
			
		return false;
	});
	
	$("textarea").focus( function(){
		$(this).text("");
		$(this).css({
			color:"#333"
		});
	});
	
	$('textarea').growable();
	
	$('#thanks').hide();
	$('#thanks').slideDown('fast',function(){
			setTimeout(function(){
				$('#thanks').slideUp('fast');
			},2000);
	});
	
	
	
});

function resetMessage(){
	$("textarea").text("Hi. My name is Curious.")
	.css({
		color:"#ccc"
	});
	$.scrollTo("#new_message",{duration:500});
}