// JavaScript Document


       //全选
		function checkAll(){
			$("#content input:checkbox").attr("checked","checked");
		}
		
		//反选
		function inverseSelection(){
			$("input:checkbox").removeAttr("checked");	
		}
		
		//
		$(function(){
			$("tr.td_bottom_b,[name=color]").hover(
				function(){
					$(this).css("background","#C0E967");	
				},
				function(){
					$(this).css("background","");	
				}
			);	
		});
		
		
		//删除
		function trDel()
		{
			var $valNode = $("#content tr:gt(0) :checkbox:checked");
			
			if($valNode.length==0)
			{
				alert("您没有选择！");	
			}
			else if($valNode.length>0)
			{
				$valNode.each(function(index)
				{
					//alert($(this).parent().parent().parent().html());
					if($(this).parent().is("td"))
					{
						$(this).parent().parent().remove();
					}
					else{
						$(this).parent().parent().parent().remove();
					}
					
				});
			}
		}
		
		//返回
		function goback()
		{
			window.back();
		}