$(document).ready(function() {
			$("div.buy").width($(window).width() - 120);	
			
			var optionsItem_pic = {
				zoomWidth: 300,
				zoomHeight: 400,
				xOffset: 10,
				yOffset: 0,
				title: false,
				position: "right" //and MORE OPTIONS
			};
			var optionsItem_pic_flat = {
				zoomWidth: 300,
				zoomHeight: 400,
			    xOffset: 10,
			    yOffset: 0,
				title: false,
			    position: "right" //and MORE OPTIONS
				};
			
			$('#item_pic').jqzoom(optionsItem_pic);
			$('#item_pic_flat').jqzoom(optionsItem_pic_flat);	
			
			$('a.color_options').click(function () {
				var color = $(this).attr('color');
				$(".colorsSelector").val(color);
				//return false;
				color = color.replace(/ /g, "_");			
				var pid = $('#input_pid').val();
				var item_pic_href = $('#item_pic').attr('href'); 
				item_pic_href = item_pic_href.substring(0, item_pic_href.lastIndexOf("/") + 1); 			
				var item_pic_img_src = $('#item_pic > img').attr('src');
				item_pic_img_src = item_pic_img_src.substring(0, item_pic_img_src.lastIndexOf("/") + 1); 
				
				var gallery_regular_content = " <a id='item_pic' href='"+ item_pic_href+ pid + 'b_' + color + '.jpg' + "' class='showPic' title='ZoomIn'><img src='" + item_pic_img_src + pid + '_' + color  + '.jpg'+"'></a>";
				var gallery_flat_content = "  <a id='item_pic_flat' href='"+ item_pic_href+ pid + '_flatb_' + color + '.jpg' +"' class='showPic' title='ZoomIn'><img src='" + item_pic_img_src + pid + '_flat_' + color  + '.jpg' + "'></a> "; 
				$('#gallery_regular').empty();
				$('#gallery_regular').html(gallery_regular_content);
				
				$('#gallery_flat').empty();
				$('#gallery_flat').html(gallery_flat_content);
												
				var optionsItem_pic = {
				    	zoomWidth: 300,
				    	zoomHeight: 400,
			            xOffset: 10,
			            yOffset: 0,
						title: false,
			            position: "right" //and MORE OPTIONS
				};
				var optionsItem_pic_flat = {
				    	zoomWidth: 300,
				    	zoomHeight: 400,
			            xOffset: 10,
			            yOffset: 0,
						title: false,
			            position: "right" //and MORE OPTIONS
				};
				
				$('#item_pic').jqzoom(optionsItem_pic);
				$('#item_pic_flat').jqzoom(optionsItem_pic_flat);	
				return false;
			});
			
			$('#btn_outofstock_notify_email').click(function () {
				var productid, color_size, email; 
				productid = $('#input_pid').val();
				color_size = $('#color_size').text().split(':');
				email = $('#outofstock_notify_email').val();
				
				//alert(productid); 
				//alert(color_size[0]); 
				//alert(color_size[1]);
				//alert(email);
				
				//return false;
				
				$.ajax({
					type: 		"post",
					url: 		"AddOutofStockNotifyEmail.jsp",
					data: 		"color=" + color_size[0] + "&size=" + color_size[1] + "&email=" + email+"&productid="+ productid,
					success:	function(msg) {
					  	$('#info_display').remove();
					  	alert('your email is saved, we will notify you via email when the item is back.');
						//$('#error_info').html('<h2>your email is saved, we will notify you via email when the item is back.</h2>');
						//$('#outofstock_notify_email_container').html('');
/*						if($.trim(msg) == "code used")
						{
							alert("coupon code you input is currently being used, please try to enter other code");
							return;
						}
						var offDetail = off < 1? (off*100).toFixed() + '% OFF ' : off + ' Dollars OFF';  
						var display = '<br/><span style="font-size: 25px">' + offDetail + ' Coupon Code: <span style="color:red">'+$.trim(msg)+ '</span> is ready, Please save it as reference.</span><br/>';
						$('#resultarea').append(display);
						$('#gobacklinkarea').show("slow");*/
						
					}
				});	
			});
			   
})

function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=500,width=550,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,location=no,directories=no,status=yes')
}