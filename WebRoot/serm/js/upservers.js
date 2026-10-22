function checkform()
  {
   $.messager.confirm("提示","你确定提交吗？",function(p){
	   if(p){
    jQuery.checkForm({
        ctrls: [                                   
            {id:"saleOrderNo",type:"mustInput", par:"", msg: "销售单号不能为空"},  
            {id:"possions",type:"mustSelect",par:"0",msg:"请选择仓库位置"},
            {id:"servs",type:"mustSelect",par:"0",msg:"请选择服务器名称"},
            {id:"ipnum",type:"mustInput", par:"", msg: "IP数量不能为空"},
            {id:"bandwidthAmount",type:"mustInput", par:"", msg: "带宽数量不能为空"},
            {id:"ipnum",type:"mustInt", par:"", msg: "IP数量必须写数字"},
            {id:"bandwidthAmount",type:"mustInt", par:"", msg: "带宽数量必须写数字"},
            {id: "port",type:"mustInput", par:"", msg: "端口不能为空"},  
            {id: "jhjname",type:"mustInput", par:"", msg: "交换机名称不能为空"},    
            {id: "serverIp",type:"mustInput", par:"", msg: "IP地址不能为空"},   
            {id:"starts",type:"mustInput", par:"", msg: "服务器位置1不能为空"},
            {id:"ends",type:"mustInput", par:"", msg: "服务器位置2不能为空"}
            ],
        success: function(){ 
    	 var mp=0;
    	 //var pattern=new RegExp("[,]"); 
    	  if($('#maintenancePass').val()==""){
    	     $('#maintenancePass').val("无");
    	  }
    	  if($('#bandwidthThrottling').val()==""){
    	     $('#bandwidthThrottling').val("0");
    	  }
    	  if($('#temps').val()==""){
    	     $('#temps').val("无");
    	  }
    	  if($('#mobile').val()==""){
    	    $('#mobile').val('无');
    	  }
    	 if($('#dows').datebox("getValue")==""){
    		 	mp=1;
    		   	$('#up3').html('');
    	     	$('#up4').html('');
    	     	$('#up6').html('');
    	     	$('#up5').html('');
    	     	$('#up7').html('');
    	     	$('#errors').html('');
    	     	$('#up8').html('');
            	$('#up2').html("日期不能为空");
         }
    	 if($('#bandwidthThrottling').val()>$('#bandwidthAmount').val()){
    		 mp=1;
    		 $.messager.alert('提示','输入的带宽限制必须小于带宽数量','info'); 
    	 }
//    	 if(!pattern.test($('#serverIp').val())){
//    		 mp=1;
//    		 $.messager.alert('提示','输入的IP地址必须用","隔开','info'); 
//    	 }
          if(mp==0){
        		var arrs = new Array();
                var flag=0;
        		arrs=$('#serverIp').val().split(",");
        		//alert("1="+arrs[(arrs.length-1)]);
        		//alert("2="+arrs.length+","+$('#ipnum').val());
        		if(arrs[(arrs.length-1)]=="" && arrs.length==2){
	                 flag=0;  
        		}else if(arrs[(arrs.length-1)]!="" && arrs.length == $('#ipnum').val()){
        			 flag=0;
        		}else{
        			flag=1;
        			$.messager.alert('提示','输入的IP数量和IP地址的数量不一致','info');
        		}	
        		if(flag==0){
        			$('#up2').html("");
                	$('#up3').html('');
                	$('#ser1s').html('');
                	$('#ser2s').html('');
                	$('#up4').html('');
                	$('#up6').html('');
                	$('#up5').html('');
                	$('#up7').html('');
                	$('#up8').html('');
                	$('#errors').html('');
        			//document.getElementById("formss").submit();  
                	$('#formss').form('submit',{
                		url:'cms/show_saveUp.do',
                		onsubmit:function(){ return $('#formss').form('validate');},
                		success:function(result){
                			//alert(result);
                			if(result=='yes'){
                			   $.messager.alert('提示','上架单填写成功','info',function(){
                   				  top.location.reload();
                			   });
                				
                			}
                		}
                	});
        		}
        		//xxx
          }
        },
        failed: function(msg){  
            if(msg=="销售单号不能为空"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#up8').html('');
            	$('#errors').html(msg);
            }
            if(msg=="IP数量不能为空" || msg=="IP数量必须写数字"){
            	$('#up2').html("");
            	$('#up4').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#up8').html('');
            	$('#errors').html('');
            	$('#up3').html(msg);
            }
            if(msg=="带宽数量不能为空" || msg=='带宽数量必须写数字'){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#up8').html('');
            	$('#errors').html('');
            	$('#up4').html(msg);
            }
            if(msg=="端口不能为空"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up4').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#up8').html('');
            	$('#errors').html('');
            	$('#up6').html(msg);
            }
            if(msg=="交换机名称不能为空"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up7').html('');
            	$('#up8').html('');
            	$('#errors').html('');
            	$('#up5').html(msg);
            }
            if(msg=="IP地址不能为空"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up8').html('');
            	$('#errors').html('');
            	$('#up7').html(msg);
            }
            if(msg=="服务器位置1不能为空" || msg =="服务器位置2不能为空"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#errors').html('');
            	$('#up8').html(msg);
            }
            if(msg=="请选择仓库位置"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#errors').html('');
            	$('#up8').html('');
            	$('#ser2s').html('');
            	$('#ser1s').html(msg);
            }
            if(msg=="请选择服务器名称"){
            	$('#up2').html("");
            	$('#up3').html('');
            	$('#up4').html('');
            	$('#up6').html('');
            	$('#up5').html('');
            	$('#up7').html('');
            	$('#errors').html('');
            	$('#up8').html('');
            	$('#ser1s').html('');
            	$('#ser2s').html(msg);
            }
            }
        }); 
        }
        });
        }
function getAllIps(){
    // alert("ips");	
	var path=$('#bathpaths').val();
    var str= window.showModalDialog(path+"serm/pager/showIPs.jsp","选择IP号","height=300,width=600,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no,edge=sunken"); 
     $('#serverIp').val(str);
}
