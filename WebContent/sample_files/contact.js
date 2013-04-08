var globalX = 0;
var xDiff = 0;
var lastPhotoX = 0;
var containerToMove = null;
var movementXCoord = 0;
var startedMoving;
var	finishedMoving;
var timeDiff;
var moved = false;
var movementTimer;
var totalDistance = 0;
var movementIntervalOne;
var movementIntervalTwo;
var loadShopping = 0;
var index = 1;
var temp = 0;

$(document).ready(function() {

	$("span.photo_info, div#overlay").css("opacity", 0);
	$("a.left, a.right").css("opacity", 0.60).hover(function() {
		$(this).css("opacity", 1);
	},
	function() {
		$(this).css("opacity", 0.6);	
	});
	$("div.contact").width($(window).width() - 120);
	//$("div.contact").hide();
	//$("#backhome").hide();
	
	//$("div.photo, div.shoppingphoto").each(function() {
	//	var curWidth = $(this).parent("div.category_container, div.category_container_shopping").width();
	//	$(this).parent("div.category_container, div.category_container_shopping").width(curWidth + 10);
	//	initializeImage($(this));
	//});
	
	
	
//	$(window).resize(function(){
//  		var windowWidth = $(window).width();
//  		var containerWidth = $("div.full_container").eq(0).width();
//  		var individualWidth = (containerWidth / 2) - 25;
//  		$("div#clients, div#twitter").css("width", individualWidth + "px");
  		
//  		if ((individualWidth * 2) + 50 == containerWidth)
 // 			$("div#clients").css("margin-right", "50px");
//  		else
 // 			$("div#clients").css("margin-right", "51px");
  			
//  		$("div#tweet").each(function() {
 // 			var parentHeight = $(this).parent("div").height() - 90;
//  			var thisHeight = $(this).height();
 // 			var topMargin = (parentHeight - thisHeight) / 2;
//  			var bottomMargin = topMargin;// - 10;
//  			$(this).css("padding-top", topMargin + "px");
//  			$(this).css("padding-bottom", bottomMargin + "px");
//  		});	
//	}).trigger("resize");
	
	/*
		$("#contactlink").click(function(){			
			$("#backhome").show(100);
			$("#look_container").height(200);
			$("#shopping_container").height(200);
			$("#other_container").height(200);
			$("#look_container").removeClass("container");
			$("#shopping_container").removeClass("container");
			$("#other_container").removeClass("container");
			$("#look_container").hide(500);
			$("#shopping_container").hide(500);
			$("#other_container").hide(500);
			$("div.contact").show(300);
									 
		});
	
	$("#collectionlink").click(function(){
			expandCollection();		
	});
	
	//$("#shoppinglink").click(function(){
	//		expandShopping();
		
	//});

	$("#otherlink").click(function(){
			expandAbout();
	});
	
	$("#backhome").click(function() {
			resetPage();
	});
	*/
	
/*	$("div.category_container").mousedown(function(e) {
		if (containerToMove != null)
			containerToMove.stop();
			
		moved = false;	
		globalX = e.pageX;
		containerToMove = $(this);
		startedMoving = new Date().getTime();
	});
*/	
//	$("embed").click(function(e) {
//		$().trigger("mouseup");
//	});	
	
/*	$().mouseup(function(e) {
		clearTimeout(movementTimer);
		finishedMoving = new Date().getTime();
		
		if (containerToMove != null) {
			if (containerToMove.position().left > 0) {
				containerToMove.animate({left: "0px"}, 250, "swing");
				containerToMove = null;
			}
			else if ((containerToMove.position().left + containerToMove.width()) < ($(window).width() - 110)) {
				var position = ($(window).width() - 110) - containerToMove.width()
				containerToMove.animate({left: position + "px"}, 250, "swing");
				containerToMove = null;
			}
			else {
				timeDiff = finishedMoving - startedMoving;
				var momentumRatio = totalDistance / timeDiff;
				var momentumDist = ($(window).width() / 2) * momentumRatio;
				var momentumTime = 1000 / momentumRatio;
				var currentPos = containerToMove.position().left;
				var newPos = currentPos + momentumDist;
				if (momentumRatio != 0) {
					if (newPos > 0)
						containerToMove.animate({left: "150px"}, 250, "swing", doneMoving);
					else if ((newPos + containerToMove.width()) < ($(window).width() - 110)) {
						newPos = ($(window).width() - 260) - containerToMove.width()
						containerToMove.animate({left: newPos + "px"}, 250, "swing", doneMoving);
					}
					else
						containerToMove.animate({left: newPos + "px"}, 1000, "swing", doneMoving);
				}
					
			}
			
		}
		
		globalX = 0;
		xDiff = 0;
		totalDistance = 0;
		if (moved) {
			//moved = false;
			return false;
		}
	});
*/	
/*	$().mousemove(function(e) {		
		if (globalX != 0 && containerToMove != null) {
			clearTimeout(movementTimer);
			var oldXDiff = xDiff;
			xDiff = e.pageX - globalX;
			movementXCoord = containerToMove.position().left + xDiff;
			containerToMove.css("left", movementXCoord + "px");
			globalX = e.pageX;
							
			if (xDiff != 0) {
				moved = true;
				if ((oldXDiff > 0 && xDiff < 0) || (oldXDiff < 0 && xDiff > 0))
					movementTimerElapsed();
				totalDistance = totalDistance + xDiff;
				movementTimer = setTimeout("movementTimerElapsed();", 50);
				return false;
			}
		}
	});
*/	
	$("div.photo_overlay").hover(
		function() {
			$(this).children("span.photo_info").stop().animate({opacity: 0.75}, 400);
		},
		function() {
			$(this).children("span.photo_info").stop().animate({opacity: 0}, 400);
		}
	);
	
	$("div.photo").click(function() {
		if(!moved) {
			var leftPos = -($(this).position().left);
			if ((leftPos + $(this).parents("div.category_container").width()) < ($(window).width() - 110)) {
				var position = ($(window).width() - 110) - $(this).parents("div.category_container").width()
				$(this).parents("div.category_container").animate({left: position + "px"}, 250, "swing");
			}
			else {
				if ($(this).parents("div.category_container").position().left != leftPos)
					$(this).parents("div.category_container").animate({left: leftPos + "px"}, 250, "swing");
				else if ($(this).prev("div.photo, div.video").length > 0 && !$(this).hasClass('video')) {
					leftPos = -($(this).prev("div.photo, div.video").position().left);	
					$(this).parents("div.category_container").animate({left: leftPos + "px"}, 250, "swing");
				}
			}				
				
		}
	});
	
	$("a[href*=#]").each(function() {
		var anchor = $(this).attr("href").replace('#', '');
		if (anchor != '') {
			$(this).click(function() {
				$("body, html").animate({scrollTop: ($("a[name=" + anchor + "]").offset().top - 60)}, 750, "swing");
				return false;
			});
		}
		else {
			$(this).click(function() {
				return false;
			});	
		}
	});	
	
	$("div.container, div.container_shopping, div.bigContainer").hover(function() {
		$(this).children("a.left, a.right").show();
	},
	function() {
		$(this).children("a.left, a.right").hide(); 
	});
	
	  
	$("a.left").click(function() {
		var fakeKey = {which:37};
		handleKeyPress(fakeKey);
	});
	
	$("a.right").click(function() {
		var fakeKey = {which:39};
		handleKeyPress(fakeKey);
	});
  
  $().keydown(function(e) {
  	handleKeyPress(e);	
  });
  
/*  $("#submit").click(function(){
  		$("#formstatus").text("");
  			
		var name = $("#name").val();
		var email = $("#email").val();
		var message = $("#message").val();
		
		if (name == "")
			$("#formstatus").text("Please enter your name.");
		else if (email == "")
			$("#formstatus").text("Please enter your email address.");
		else if (message == "")
			$("#formstatus").text("Please enter a message.");
		else {
		
		$(this).attr("disabled", true);	
		var dataString = 'name='+ name + '&email=' + email + '&message=' + message;  
		//alert (dataString);return false;  
		$.ajax({  
  			type: "POST",  
  			url: "formprocess.php",  
  			data: dataString,  
  			success: function() {  
    			$("#formstatus").text("Thanks!");
    			$("#message").val("");
    			$("#submit").attr("disabled", false);
 		 	},
 		 	error: function(e) {
 		 		$("#formstatus").text("An error occurred. Please email quack@duckduckcollective.com");
 		 		$("#submit").attr("disabled", false);
 		 	}  
		});
		
		}
		
		return false;
	});
*/  
});



function expandCollection() {
			$("#backhome").show(100);
			$("div.contact").hide(100);
			
			$("#other_container").height(200);
			$("#other_container").hide(500);
			$("#other_container").removeClass("container");

			$("#shopping_container").height(200);
			$("#shopping_container").hide(500);
			$("#shopping_container").removeClass("container");
			
			$("#look_container").height(630);
			$("#look_container").show(500);
			$("#look_container").addClass("container");
			
			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("#look_container div.category_container").width(0);
			index = 1; 
			$("#look_container div.category_container div.photo img").each(function(){
				
				$(this).attr("src","sample_files/look/b" + index.toString() + ".jpg");
				index++;
				var curWidth = $("#look_container div.category_container").width();
				$("#look_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
				//alert("add new one finished");
			});		


}
function expandShopping(){
	
			$("#backhome").show(100);
			$("div.contact").hide(100);
			
			$("#other_container").height(200);
			$("#other_container").hide(500);
			$("#other_container").removeClass("container");

			$("#look_container").height(200);
			$("#look_container").hide(500);
			$("#look_container").removeClass("container");
			
			$("#shopping_container").height(630);
			$("#shopping_container").show(500);
			$("#shopping_container").addClass("container");
			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
			     
				$(this).attr("src","");
				// alert("delete orginal photo finished");
			});
			$("div.category_container_shopping").width(0);
			index = 1; 
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
				
				$(this).attr("src","sample_files/shopping/b" + index.toString() + ".jpg");
				index++;
				var curWidth = $("div.category_container_shopping").width();
				$("div.category_container_shopping").width(curWidth + 10);
				initializeImage($(this).parent("div.shoppingphoto"));
				//alert("add new one finished");
			});
	
	}
function  expandAbout() {
			$("#backhome").show(100);
			$("div.contact").hide(100);

			$("#look_container").height(200);
			$("#look_container").hide(500);
			$("#look_container").removeClass("container");
			
			$("#shopping_container").height(200);
			$("#shopping_container").hide(500);
			$("#shopping_container").removeClass("container");
			
			$("#other_container").height(630);
			$("#other_container").show(500);
			$("#other_container").addClass("container");

			
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("#other_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("#other_container div.category_container").width(0);
			index = 1; 
			$("#other_container div.category_container div.photo img").each(function(){
				if(index <5)
					temp = 40 + index;
				if(index >4)
					temp = index - 4;
					
				$(this).attr("src","sample_files/other/b" + temp.toString() + ".jpg");
				index++;
				var curWidth = $("#other_container div.category_container").width();
				$("#other_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
				//alert("add new one finished");
			});		
}
function resetPage() {
			globalX = 0;
			xDiff = 0;
			lastPhotoX = 0;
 			containerToMove = null;
 			movementXCoord = 0;
 			startedMoving = 0;
			finishedMoving = 0;
 			timeDiff = 0;
 			moved = false;
			movementTimer = null;
			totalDistance = 0;
			
			$("div.contact").hide(100);
			$("#backhome").hide(100);
			
			$("#look_container").show(500);
			$("#shopping_container").show(500);
			$("#other_container").show(500);
			
			$("#look_container").addClass("container");
			$("#shopping_container").addClass("container");
			$("#other_container").addClass("container");
			
			$("#look_container").height(200);
			$("#shopping_container").height(200);
			$("#other_container").height(200);
			
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){   
				$(this).attr("src","");
				// alert("delete orginal photo finished");
			});
			$("#other_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","");
			});
			
			$("#look_container div.category_container").width(0);
			$("div.category_container_shopping").width(0);
			$("#other_container div.category_container").width(0);
			
			index = 1;
			$("#look_container div.category_container div.photo img").each(function(){   
				$(this).attr("src","sample_files/look/" + index.toString() + ".jpg");
				index++;
				var curWidth = $("#look_container div.category_container").width();
				$("#look_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
			});
			index = 1;
			$("div.container div.category_container_shopping div.shoppingphoto img").each(function(){
				
				$(this).attr("src","sample_files/shopping/" + index.toString() + ".jpg");
				index++;
				var curWidth = $("div.category_container_shopping").width();
				$("div.category_container_shopping").width(curWidth + 10);
				initializeImage($(this).parent("div.shoppingphoto"));
				//alert("add new one finished");
			});
			index = 1;
			$("#other_container div.category_container div.photo img").each(function(){ 
				if(index <5)
					temp = 40 + index;
				if(index >4)
					temp = index - 4;
					  
				$(this).attr("src","sample_files/other/" + temp.toString() + ".jpg");
				index++;
				var curWidth = $("#other_container div.category_container").width();
				$("#other_container div.category_container").width(curWidth + 10);
				initializeImage($(this).parent("div.photo"));
			});
}

function handleKeyPress(e) {
	if(e.which == 39 || e.which == 37) {
  		if ($("a.left:visible").next("div.category_container, div.category_container_shopping").length > 0) {
  			var theContainer = $("a.left:visible").next("div.category_container, div.category_container_shopping");
  			var containerLeft = theContainer.position().left;
  			theContainer.stop();
  			if (e.which == 39) {
  				var found = false;
  					//alert(containerLeft);
  					theContainer.children("div.photo, div.shoppingphoto").each(function() {
  						if (($(this).offset().left - 60) > 0 && !found) {
  							found = true;
  							containerLeft = -($(this).position().left);
  						}
  						//alert($(this).offset().left - 60);
  					});
  				//containerLeft = containerLeft - 100;
  				theContainer.animate({left: containerLeft + "px"}, 200, "swing");
  			}
  			else if (e.which == 37) {
  				theContainer.children("div.photo, div.shoppingphoto").each(function() {
  					if (($(this).offset().left - 60) < 0)
  						containerLeft = -($(this).position().left);	
  				});
  				theContainer.animate({left: containerLeft + "px"}, 200, "swing");
  			}
  		}
	}
}

function moveRight(movingSpeed) {
  var left = containerToMove.position().left - movingSpeed;
  if ((left + containerToMove.width()) >= ($(window).width() - 160))
    containerToMove.css("left", left + "px");
}

function moveLeft(movingSpeed) {
  var left = containerToMove.position().left + movingSpeed;
  if (left <= 50)
    containerToMove.css("left", left + "px");
}

function doneMoving() {
	if (containerToMove != null) {
			if (containerToMove.position().left > 0)
				containerToMove.animate({left: "0px"}, 250, "swing");
			else if ((containerToMove.position().left + containerToMove.width()) < ($(window).width() - 110)) {
				var position = ($(window).width() - 110) - containerToMove.width()
				containerToMove.animate({left: position + "px"}, 250, "swing");
			}
			containerToMove = null;
		}
}

function initializeImage(image) {
	if (image.width() > 0) {
		var curWidth = image.parent("div.category_container, div.category_container_shopping").width();
		image.parent("div.category_container, div.category_container_shopping").width(curWidth + image.width());
		image.children("div.photo_overlay").css("background-color", "transparent");

		if (curWidth + image.width() > $(window).width()) {
      		if (image.siblings("div.loader").length > 0) {
        		loadAnimation(image);        
      		}
    	} 
	}
	else {
		setTimeout(function() { initializeImage(image); }, 5);
	}
}


function movementTimerElapsed() {
	startedMoving = new Date().getTime();
	totalDistance = 0;	
}

function loadAnimation(image) {
  if ($("div.container:animated").length == 0) {
    image.siblings("div.loader").remove();
    image.parents("div.container").animate({
      width: $(window).width() - 120,
      height: image.height() + 'px'
    }, 500, "swing", function() { $(this).css("width", "auto") });
  }
  else {
    setTimeout(function() { loadAnimation(image) }, 250);
  }
}

function doneLoading(e) {
  alert(e.css("position"));
}