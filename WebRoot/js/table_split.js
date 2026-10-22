$(function(){
	
	$('.tableStyle').tableRenderer()
	//自定义树形表格
	$(".cusTreeTable").each(function(){
		$(this).find('tr').filter(":has(table)").hide();
		if($(this).attr("trClick")=="true"){
			$(this).find("tr").eq(0).nextAll().not(":has(table)").each(function(){
				$(this).addClass("hand");
				$(this).hover(function(){
					$(this).addClass('highlight');
				}, function(){
					$(this).removeClass('highlight');
				});
				$(this).click(function(){
					if($(this).next().css("display")=="none"){
						$(this).next().show();
						if($(this).parents("table").attr("ohterClose")!="false"){
							$(this).parents("table").find(".img_remove2").attr("title","点击展开");
							$(this).parents("table").find(".img_remove2").addClass("img_add2");
							$(this).parents("table").find(".img_remove2").removeClass("img_remove2");
							$(this).next().nextAll().filter(":has(table)").hide();
							$(this).next().prevAll().filter(":has(table)").hide();
							
						}
						$(this).find(".img_add2").each(function(){
							$(this).attr("title","点击收缩");
							$(this).removeClass("img_add2");
							$(this).addClass("img_remove2");
						});
					}
					else{
						$(this).next().hide();
						$(this).find(".img_remove2").each(function(){
							$(this).removeClass("img_remove2");
							$(this).addClass("img_add2");
							$(this).attr("title","点击展开");
						});
					}
					enableTooltips();
					hideTooltip();
				});
			});
		}
		else{
			$(this).find(".img_add2").click(function(){
				if($(this).parents("tr").next().css("display")=="none"){
					$(this).parents("tr").next().show();
					if($(this).parents("table").attr("ohterClose")!="false"){
						$(this).parents("table").find(".img_remove2").attr("title","点击展开");
						$(this).parents("table").find(".img_remove2").addClass("img_add2");
						$(this).parents("table").find(".img_remove2").removeClass("img_remove2");
						$(this).parents("tr").next().nextAll().filter(":has(table)").hide();
						$(this).parents("tr").next().prevAll().filter(":has(table)").hide();
						
					}
					$(this).attr("title","点击收缩");
					$(this).removeClass("img_add2");
					$(this).addClass("img_remove2");
				}
				else{
					$(this).parents("tr").next().hide();
					$(this).removeClass("img_remove2");
					$(this).addClass("img_add2");
					$(this).attr("title","点击展开");
				}
				enableTooltips();
				hideTooltip();
			});
		}
	});
		
});


(function($) {
	$.fn.tableRenderer = function() {
		return this.each(function() {
			
			$(this).find('th').addClass("th");
				if($(this).find('tr').eq(1).find("td").eq(0).find('input[type="checkbox"]').length==1){
					if($(this).attr("useCheckBox")!="false"){
						$(this).attr("useCheckBox","true");
					}
					if($(this).attr("useMultColor")!="false"){
						$(this).attr("useMultColor","true");
					}
				}
				if($(this).find('tr').eq(1).find("td").eq(0).find('input[type="radio"]').length==1){
					if($(this).attr("useRadio")!="false"){
						$(this).attr("useRadio","true");
					}
				}
				if ($(this).attr("formMode") == "true") {//表单布局模式1
					$(this).attr("useColor", "false");
					$(this).attr("useHover", "false");
					$(this).attr("useClick", "false");
					$(this).find("th").css({
						"fontWeight": "bold",
						"text-align": "center"
					});
					$(this).find("tr").not("tr:last").find("td:even").css("text-align", "right");
					if($(this).attr("footer")!=null){
						if($(this).attr("footer")=="left"){
							$(this).find("tr:last").find("td").css("text-align", "left");
						}
						else if($(this).attr("footer")=="right"){
							$(this).find("tr:last").find("td").css("text-align", "right");
						}
						else if($(this).attr("footer")=="center"){
							$(this).find("tr:last").find("td").css("text-align", "center");
						}
						else if($(this).attr("footer")=="normal"){
							$(this).find("tr:last").find("td:even").css("text-align", "right");
						}
					}
					else{
						$(this).find("tr:last").find("td").css("text-align", "center");
					}
					$(this).find("td").css({
						"paddingTop": "3px",
						"paddingBottom": "3px"
					});
				}
				if ($(this).attr("transMode") == "true"){//表单布局模式2
					$(this).attr("useColor", "false");
					$(this).attr("useHover", "false");
					$(this).attr("useClick", "false");
					$(this).find("th").css({
						"fontWeight": "bold",
						"text-align": "center"
					});
					$(this).css({
						"border":"none",
						"backgroundColor":"transparent"
					});
					$(this).find("tr").css({
						"border":"none",
						"backgroundColor":"transparent"
					});
					$(this).find("tr").not("tr:last").find("td:even").css("text-align", "right");
					if($(this).attr("footer")!=null){
						if($(this).attr("footer")=="left"){
							$(this).find("tr:last").find("td").css("text-align", "left");
						}
						else if($(this).attr("footer")=="right"){
							$(this).find("tr:last").find("td").css("text-align", "right");
						}
						else if($(this).attr("footer")=="center"){
							$(this).find("tr:last").find("td").css("text-align", "center");
						}
						else if($(this).attr("footer")=="normal"){
							$(this).find("tr:last").find("td:even").css("text-align", "right");
						}
					}
					else{
						$(this).find("tr:last").find("td").css("text-align", "center");
					}
					$(this).find("td").css({
						"paddingTop": "3px",
						"paddingBottom": "3px",
						"border":"none"
					});
				}
				if ($(this).attr("useColor") != "false") {//默认隔行换色
					$(this).find('tr:even').addClass('odd');
				}
				if ($(this).attr("useHover") != "false") {//默认鼠标移入变色
					$(this).find('tr').hover(function(){
						$(this).addClass('highlight');
					}, function(){
						$(this).removeClass('highlight');
					});
				}
				if ($(this).attr("sortMode") == "true") {//排序模式
					$(this).find('th').filter(":has(span)").hover(function(){
						$(this).removeClass("th");
						$(this).addClass("th_over");
					}, function(){
						$(this).removeClass("th_over");
						$(this).addClass("th");
					});
					$(this).find('th span').addClass("sort_off");
					$(this).find('th').click(function(){
					
					});
				}
				
				if ($(this).attr("useClick") != "false") {//useClick默认为true
					$(this).attr("useClick", "true");
				}
				if ($(this).attr("useClick") == "true" && $(this).attr("useMultColor") == "true") {//如果useClick与useMultColor都为true则useClick为false
					$(this).attr("useClick", "false");
				}
				if ($(this).attr("useRadio") != "true") {//useRadio默认为false
					$(this).attr("useRadio", "false");
				}
				if ($(this).attr("useCheckBox") != "true") {//useCheckBox默认为false
					$(this).attr("useCheckBox", "false");
				}
				
				if ($(this).attr("useClick") != "false") {//useClick为false时useRadio即使为true也不生效
					if ($(this).attr("useRadio") == "false") {//如果useRadio不做设置（为false）则采用单行点击变色模式
						$(this).find("tr").click(function(){
							$(this).siblings().removeClass('selected');
							$(this).addClass('selected');
						});
					}
					else {//如果useRadio为true则采取radio模式
						$(this).find('input[type="radio"]:checked').parents('tr').addClass('selected');
						$(this).find("tr").click(function(){
							$(this).siblings().removeClass('selected');
							$(this).addClass('selected');
							$(this).find('input[type="radio"]').attr('checked', 'checked');
						});
					}
				}
				if ($(this).attr("useMultColor") == "true") {
					if ($(this).attr("useCheckBox") == "false") {//如果checkBox为false采用普通多选模式
						$(this).find("tr").click(function(){
							$(this).toggleClass('selected');
						});
					}
					else {//如果checkBox为true采用checkBox多项模式
						$(this).find('input[type="checkbox"]:checked').parents('tr').addClass('selected');
						if($(this).find("th").length>0){
							var $checkIcon=$('');//<span class="img_checkAllOff" title="点击全选"></span>
							$(this).find("th").eq(0).html("");
							$(this).find("th").eq(0).append($checkIcon);
							try {
								enableTooltips();
							}
							catch(e){}
							if ($(this).attr("headFixMode") == "true"){
								$checkIcon.toggle(function(){
									$("table:[class=tableStyle]").find("tr").each(function(){
										$(this).addClass('selected');
										$(this).find('input[type="checkbox"]').attr('checked', 'checked');
									});
									$(this).removeClass("img_checkAllOff");
									$(this).addClass("img_checkAllOn");
									$(this).attr("title","取消全选");
									try {
										hideTooltip();
										enableTooltips();
									}
									catch(e){}
								},function(){
									$("table:[class=tableStyle]").find("tr").each(function(){
										if ($(this).hasClass('selected')) {
											$(this).removeClass('selected');
											$(this).find('input[type="checkbox"]').removeAttr('checked');
										}
									});
									$(this).removeClass("img_checkAllOn");
									$(this).addClass("img_checkAllOff");
									$(this).attr("title","点击全选");
									try {
										hideTooltip();
										enableTooltips();
									}
									catch(e){}
								});
							}else{
								$checkIcon.toggle(function(){
									$(this).parents('table').find("tr").each(function(){
										$(this).addClass('selected');
										$(this).find('input[type="checkbox"]').attr('checked', 'checked');
									});
									$(this).removeClass("img_checkAllOff");
									$(this).addClass("img_checkAllOn");
									$(this).attr("title","取消全选");
									try {
										hideTooltip();
										enableTooltips();
									}
									catch(e){}
								},function(){
									$(this).parents('table').find("tr").each(function(){
										if ($(this).hasClass('selected')) {
											$(this).removeClass('selected');
											$(this).find('input[type="checkbox"]').removeAttr('checked');
										}
									});
									$(this).removeClass("img_checkAllOn");
									$(this).addClass("img_checkAllOff");
									$(this).attr("title","点击全选");
									try {
										hideTooltip();
										enableTooltips();
									}
									catch(e){}
								});
							}
						}
						$(this).find("tr:has(td)").find('input[type="checkbox"]').unbind("click");
						$(this).find("tr:has(td)").find('input[type="checkbox"]').bind("click",function(){
							if ($(this).parents("tr").hasClass('selected')) {
								$(this).parents("tr").removeClass('selected');
							}
							else {
								$(this).parents("tr").addClass('selected');
							}
						})
					}
				}
		});
	};
})(jQuery);

function tableRefresh(compId){
	var $curTable;
	if(typeof(compId)=="object"){
		$curTable=compId;
	}
	else{
		$curTable=$("#"+compId);
	}
	$curTable.tableRenderer();
}
