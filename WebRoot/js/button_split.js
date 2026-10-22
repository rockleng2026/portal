var broswerFlag;
$(function(){
	//判断浏览器
	 if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
            var bb = window.navigator.userAgent.substring(30, 33);
            if(bb=="6.0"){
				broswerFlag="IE6";
			}
			else if(bb=="7.0"){
				broswerFlag="IE7";
			}
			else if(bb=="8.0"){
				broswerFlag="IE8";
			}
        }
        else if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
                broswerFlag="Firefox";
            }
        else if (window.navigator.userAgent.indexOf("Opera") >= 0) {
            broswerFlag="Opera";
        }
        else if (window.navigator.userAgent.indexOf("Safari") >= 1) {
           broswerFlag="Safari";
        }
        else {
            broswerFlag="Other";
        }
	//button模式按钮
	var focusFlag;
	$("button").each(function(){
			if($(this).attr("class")==""){
				$(this).addClass("button");
				var btnTextNum=_getStrLength($(this).text());
				if(btnTextNum<5){
					$(this).width(60);
				}
				
				var textNum=0;
				var textWidth=50;
				textNum=_getStrLength($(this).filter(":has(span)").find("span").text());
				if(textNum!=0){
					textWidth=20+7*textNum+10;
				}
				if(broswerFlag=="Firefox"||broswerFlag=="Opera"||broswerFlag=="Safari"){
					$(this).filter(":has(span)").css({
						"paddingLeft":"5px",
						"width":textWidth+8+"px"
					});
				}
				else{
					$(this).filter(":has(span)").css({
						"paddingLeft":"5px",
						"width":textWidth+"px"
					});
				}
				
				$(this).filter(":has(span)").find("span").css({
					"cursor":"default"
				});
			}
	});
	
	//按钮加样式并且修正2个字以内的按钮宽度
	$("input:button[class=''],input:submit[class=''],input:reset[class='']" ).each(function(){
		$(this).addClass("button");
		var btnTextNum=_getStrLength($(this).val());
		if(btnTextNum<5){
			$(this).width(60);
		}
	});
	
	//input模式按钮
	$("input:button[class='button'],input:submit[class='button'],input:reset[class='button'],button[class='button']").each(function(){
		
		$(this).hover(
			function() {
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("button");
					$(this).addClass("button_hover");
				}
				},
			function(){
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("button_hover");
					$(this).addClass("button");
				}
				}
		);
		$(this).focus(function(){
			$(this).removeClass("button");
			$(this).addClass("button_hover");
		});
		$(this).blur(function(){
			$(this).removeClass("button_hover");
			$(this).addClass("button");
		});
	});
})
function _getStrLength(str){
	var i;
	var len;
	for(i=0,len=0;i<str.length;i++){
		if(str.charCodeAt(i)<128){
			len++;
		}
		else{
			len=len+2;
		}
	}
	return len;
}