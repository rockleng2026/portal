// JavaScript Document
	$(function(){
		$("tr.wd_xx").click(function(event){
			if(!$(event.target).is("input"))
			{
				window.location.href="messageView.jsp";
			}
		});
		
		$("tr[name=color]").hover(
				function(){
					$(this).css("background","#C0E967");	
				},
				function(){
					$(this).css("background","");	
				}
			);	
	});

       //全选
		function checkAll(){
			$("input:checkbox").attr("checked","checked");
		}
		
		//反选
		function inverseSelection(){
			$("input:checkbox").removeAttr("checked");	
		}
		
		function trDel()
		{
			var $valNode = $(".tab_border tr:gt(0) :checkbox:checked");
			if($valNode.length==0)
			{
				alert("您没有选择！");	
			}
			else if($valNode.length>0)
			{
				$(".tab_border tr:gt(0) :checkbox:checked").each(function(index)
				{
					if($(this).attr("name")=="lastcheckbox"){
						return;
					}
					$(this).parent().parent().parent().parent().remove();	
				});
			}
		}