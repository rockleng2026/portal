

/**
 * 弹出层js
 */
 function popupDiv(div_id) {
     var div_obj = $("#" + div_id);
    
     //窗口宽度,高度
     var winWidth = $(window).width();
     var winHeight = $(window).height();
     //弹出的div的宽度,高度
     var popHeight = div_obj.height();
 var popWidth = div_obj.width();
     div_obj.animate({ opacity: "show", left: (winWidth-popWidth) / 2, top: (winHeight-popHeight)/2,width:popWidth,height:popHeight}, 300);     

 }       
function hideDiv(div_id) {
     $("#" + div_id).animate({opacity: "hide" }, 300);
 }
//点击x的时候调用（清除check）
function hideDiv2(div_id,str) {
    $("#" + div_id).animate({opacity: "hide" }, 300);
    $("#aut"+str+"").attr("checked",false);
}



//选择复选框时触发审核事件
function checkClick(mark)
{	
	 var tab = $("#tab").val();
	 var filed = $("#filed").val();
	 var orderName = $("#orderName").val();
		var flag=confirm("确定提交吗？");
		if(flag){
			autditingVal(tab,filed,orderName,mark);					
		}
		else{
			$("#aut"+str+"").attr("checked",false);
			hideDiv("pop_div"+str);
		}

}
function autditingVal(tab,filed,orderName,marks)
{
	var orderNo=$("#orderNo").val();
	//alert(orderNo);
	var textare=encodeURI($("#describe").val());
	var price=$("#price").val();
	$.post("auditingValAuditing.do",{orderNo:orderNo,tab:tab,filed:filed,orderName:orderName,tmp:textare,marks:marks,price:price},
			function (data){
		    if(data==0){
		        alert("审核成功！");
		        history.go(0);
		    }
		    else if(data==1){
		    	alert("最终审核成功！");
    			history.go(0);
		    }
		    else if(data==2){
		    	alert("审核出错！");
		    
		    }
		    else if(data==3){
		    	alert("你不是该部门的员工无法审核！");
		    	
		    }
		    else if(data==4){
		    	alert("请等待前一个部门审核通过再审核！");
		    	
		    }
		    else if(data==6){
		    	alert("该单据的审核机制已被删除，请重新添加审核机制！");
		    	
		    }else if(data==7){
		    	alert("请等待上一个部门审核后在审核");
		    	
		    }else if(data==10){
		    	alert("审核不通过，金额不足！");
		    	history.go(0);
		    }
		    else {
		    	alert("您没有审核该单据的权限！");
		    	
		    }
	});
}




/**
 * 接收
 * @return
 */
function incepttime(str,tab,sv,storageNo)
{	
	$.post("inceptAuditing.do",{
		orderNo:str,
		tab:tab,
		state:sv,
		No:storageNo
		},
	function (data){
		if(data=="0"){
			alert("接收成功！");
			history.go(0);
		}
		else
			alert("接收失败！");
	});
}







