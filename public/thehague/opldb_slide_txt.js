$(document).ready(function(){

	//Hide (Collapse) the toggle containers on load
	$(".slideText").hide(); 

	//Slide up and down on click
	$("img.slideImg").click(function(){
		$(this.parentNode).next("a").next(".slideText").slideToggle("slow");
		var imgsrc = $(this).attr('src');
		var matches = imgsrc.match(/collapsed.jpg/);
		if (!matches) {
			var newsrc = imgsrc.replace('expanded.jpg','collapsed.jpg')
 			$(this).attr('src',newsrc);
		} else {
			var newsrc = imgsrc.replace('collapsed.jpg','expanded.jpg')
 			$(this).attr('src',newsrc);
		}
	});

});