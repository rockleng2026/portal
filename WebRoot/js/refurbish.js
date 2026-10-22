
//刷新提醒功能
function refurbishtable()
{
	$.post("sendRefsendmes.do",function (data)
			{
				$(".bgred").remove();
				if(data!=0){
					$("#sendmes").append(data);
				}
			});
	//setTimeout("refurbishtable()", 10000);

	$.post("soWanringsaleOrder.do",function(data){
		if(data!=0){
			$("#sendmes").append(data);
		}
	});
}
