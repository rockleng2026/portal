// JavaScript Document
	$(function(){
		// tr为 tr.wd_xx 和 name 为 color的时候可以进入跳转消息信息详情
		$("tr.over").click(function(event){
			if(!$(event.target).is("input"))
			{
				if(this.id!=""&&this.id.length>0){
					window.location.href="getReceiverByRidmessage.do?rid="+this.id+"&tmp="+this.name;
				}
			}
			
		});
		
		// 表格行颜色的变换
		$("tr.over").hover(
			function(){
				$(this).css("background","#C0E967");	
			},
			function(){
				$(this).css("background","");		
			}
		);
		
	});
	
	
	
	
	 //勾选所有要删除项
	function CheckA(form)  {
		  for (var i=0;i<form.elements.length;i++)    {
		    var e = form.elements[i];
		    if (e.name != 'chkall')
		    	e.checked = form.chkall.checked; 
		  }
	}
	// 读取操作
	function dq(){
		var count=$("input[type=checkbox][name=ids][checked]").length;
		if(count<=0){
			alert("请选择消息！");
			return false;
		}
		form2.action="updateMessageStatemessage.do";
	}
	// 删除操作
	function del(){
		var count=$("input[type=checkbox][name=ids][checked]").length;
		if(count<=0){
			alert("请选择消息！");
			return false;
		}
		if(confirm("确定要删除吗？删除以后不能恢复！")){
			form2.action="del2message.do";
		}
	}
		
		function out()
		{
			$(".main").hide();	
		}