var dateThemeColor="blue";
$(function(){
	
	var focusFlag;
	$("input:text[class='date'],input:text[class='date90'],input:text[class='date90_ny'],input:text[class='cusDate']").each(function(){
		$(this).hover(
			function() {
				if(focusFlag!=$(this)[0]){
					$(this).addClass("date_hover");
				}
				},
			function(){
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("date_hover");
				}
				}
		);
		$(this).focus(function(){
			focusFlag=$(this)[0];
			$(this).removeClass("date_hover");
			$(this).addClass("date_click");
		});
		$(this).blur(function(){
			focusFlag=null;
			$(this).removeClass("date_click");
		});
	});
	
	
	var prePath="/XNDS/";
	if($(".date").length>0){
		var scrpt = document.createElement("script");  
	  	scrpt.type="text/javascript";
	  	scrpt.src= prePath+"js/datePicker/WdatePicker.js";
	  	//alert(scrpt.src);
	  	document.body.appendChild(scrpt); 
		$(".date").each(function(){
			var dateFormat="yyyy-MM-dd";
			if($(this).attr("dateFmt")!=null){
				dateFormat=$(this).attr("dateFmt");
			}
			$(this).focus(function(){
				WdatePicker({
					skin:dateThemeColor,isShowClear:true,dateFmt:dateFormat,
					onpicked:function(dp){
						$(this).blur();
					}
				});
			});
		});
	}
	if($(".date90").length>0){
		var scrpt = document.createElement("script");  
	  	scrpt.type="text/javascript";
	  	scrpt.src= prePath+"js/datePicker/WdatePicker.js";  
	  	document.body.appendChild(scrpt); 
		$(".date90").each(function(){
			var dateFormat="yyyy-MM-dd";
			if($(this).attr("dateFmt")!=null){
				dateFormat=$(this).attr("dateFmt");
			}
			$(this).focus(function(){
				WdatePicker({
					skin:dateThemeColor,isShowClear:true,dateFmt:dateFormat,
					onpicked:function(dp){
						$(this).blur();
					}
				});
			});
		});
	}
	if($(".date90_ny").length>0){
		var scrpt = document.createElement("script");  
	  	scrpt.type="text/javascript";
	  	scrpt.src= prePath+"js/datePicker/WdatePicker.js";  
	  	document.body.appendChild(scrpt); 
		$(".date90_ny").each(function(){
			var dateFormat="yyyy-MM";
			if($(this).attr("dateFmt")!=null){
				dateFormat=$(this).attr("dateFmt");
			}
			$(this).focus(function(){
				WdatePicker({
					skin:dateThemeColor,isShowClear:true,dateFmt:dateFormat,
					onpicked:function(dp){
						$(this).blur();
					}
				});
			});
		});
	}
	
});
