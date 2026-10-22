function bangding()
{
	if(confirm("确定要绑定手机吗？")==true)
  	{
		
  		$.post("bangdingPhoneCustomerServer.Action",{},function(data){
  				if(data=="1")
  				{
					alert("开启手机登录成功！！！");  				
  				}
  				else
  				{
  					alert("开启手机登录失败失败！！！");
  				}
  				location.reload();
  			});
  			
  	}

}