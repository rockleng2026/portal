//
//function showoneDialog1(url){
//	   var Height = 625;
//	   var Width = 600;
//	   //--------------left位置 
//	   //screen.availHeight声明了显示浏览器的屏幕的可用宽度       
//	   var dleft =(screen.availHeight-Height)/3;
//	   
//	   //--------------top位置 
//	   var dtop =(screen.availWidth-Width)/3
//	   ;
//	   //---------------
//	   
//	   var node = window.showModalDialog(url,window,"scrollbars=yes;resizable=no;help=no;status=no;center=yes;dialogTop=25;dialogLeft="+ dleft +";dialogTop="+ dtop +";dialogHeight="+Height+"px;dialogWidth="+Width+"px;");
//
//}     
//
//	  /** 
//	   * 关闭模态窗口时的操作，由模态窗口调用
//	   */
//	  function closeModal(obj){
//	   var storeData = new Array();
//	   storeData.push([obj.areaid,obj.areaname]);
//	   Ext.getCmp('areaid').store.loadData(storeData);
//	   Ext.getCmp('areaid').setValue(obj.areaid);
//	   Ext.getCmp('areaid').setRawValue(obj.areaname);
//	  }    
//	  function aaa(name){
//		  $('#salesmanEmp').attr('value', name);
//		}
 
	  

  




function showoneDialog(url)
{
	returnvalues= showModalDialog(url,"","dialogWidth=900px;dialogHeight=600px");
	return returnvalues;
}

function getvalue(allvalue,id) 
{
	

	if(allvalue!=undefined)
	{
		window.returnValue=allvalue;
	}
	window.close();
}



function changeColor(id)
{
	//alert("id"+id);
	var cs=$("tr");
	for(var i=0;i<cs.length;i++)
	{
		if(cs[i].id!=null&&cs[i].id!="")
		if(cs[i].id!=id)
		{
			$("#"+id).css("background", "");
		}
		else
		{
			$("#"+id).css("background", "red");
		}
	}
		
}


function returnSome(url,val,id,gsname,model,pname,type,servloc)
{
	
	
	var depId=$('#depId').val();
	if(depId!=null&&depId!="")
	{
		url+="&addH="+depId;
	}
	if(model=='depremove')
	{
		$("#editTabs tr:gt(0)").remove();
	}
	var returnvalue=showoneDialog(url);
	if(returnvalue!=undefined)
	{
		var array=returnvalue.split(',');
		$("#"+id).attr("value",array[0]);
		$("#"+val).attr("value",array[1]);
		if(gsname != null && gsname != ''){
			$("#"+gsname).attr("value",array[2]);
		}
		if(val=="cus"&&id=="cusname"&&gsname=="cuscomp")
		{
		
			$("#"+model).attr("value",array[3]);
			$("#"+pname).attr("value",array[4]);
			$("#"+type).attr("value",array[5]);
			return;
		}
	
		valdateProduct(array[1]);
		if(model!=null&&model!=""&&pname!=null&&pname!=""&&type!=null&&type!="")
		{
			$("#"+model).html(array[4]);
			$("#"+pname).html(array[2]);
			$("#"+type).html(array[3]);
		}
		if(pname!=null&&pname!="")
		{
			$("#"+pname).attr("value",array[2]);
		}
	
		if(array[5]!=null&&array[5]!="")
		{	
			$.post("findServiceLocationOutbound.do",{"serverid":array[0],"mark":array[6],"parentid":array[5]},
					function(data){
				   //alert("data"+data);
				    var datali=data.split('#');
			       $("#"+servloc).attr("value",datali[0]);
					var ipli=datali[1].split(';');
					var ipss="";
					for(var i=0;i<ipli.length;i++)
					{
						var s=ipli[i].split(',');
						ipss+="<input type='checkbox' id='serverIp' name='serverIp' value="+s[0]+"#"+s[1]+" />"+s[1]+"&nbsp;&nbsp;";
					}  
					
					document.getElementById("liip").innerHTML=ipss;
			});
		}
	}
}
function selectinfo(url,val)
{	
	//var str1=document.getElementById(""+val+"").value;
	var str1 = $.trim($("#"+val).val());
	//alert(str1+"sss");
var str=encodeURI(encodeURI(str1));
	var url=""+url+"="+str+"";
	
	$("#dialog-modal").load(url);
}
function cusshow(cuscomp,cusname,cus,phone,cardid,cusempname,empid)
{
	
	$("#cuscomp").attr("value",cuscomp);
	$("#cusname").attr("value",cusname);
	$("#cus").attr("value",cus);
	$("#phone").attr("value",phone);
	$("#cardid").attr("value",cardid);
	$("#cusempname").attr("value",cusempname);
	$("#cusid").attr("value",cusname);
	
	$("#customer").attr("value",cuscomp);
	$("#dfdb").attr("value",cus);
	$("#empName").html(cusempname);
	$("#empid").attr("value",empid);
	
	
	$("#dianji").click();
	
	
	
}	
function selectemp(id,name)
{
	$("#empid").attr("value",id);//employeeByEmpId employeeByEmp
	$("#emp").attr("value",name);
	$("#employeeByEmp").attr("value",name);
	$("#employeeByEmpId").attr("value",id);
	//alert(22);
	$("#dianji").click();
}


function returnSome1(url,val,id,pname,date,ipnum,price,comname,linkname,phone,comid)
{
	var returnvalue=showoneDialog(url);
	
	if(returnvalue!=undefined)
	{
		var array=returnvalue.split(',');
		$("#"+pname).attr("value",array[0]);
		$("#"+val).attr("value",array[1]);
		$("#"+id).attr("value",array[2]);
		$("#"+date).attr("value",array[3]);
		$("#"+ipnum).attr("value",array[4]);
		$("#"+price).attr("value",array[5]);
		$("#"+comname).attr("value",array[6]);
		$("#"+linkname).attr("value",array[7]);
		$("#"+phone).attr("value",array[8]);
		$("#"+comid).attr("value",array[9]);
	}
}

function returnSome2(url,val,id,gsname,model,pname,type,servloc)
{

	var depId=$('#depId').val();
	if(depId!=null&&depId!="")
	{
		url+="&addH="+depId;
	}
	if(model=='depremove')
	{
		$("#editTabs tr:gt(0)").remove();
	}
	var returnvalue=showoneDialog(url);
	if(returnvalue!=undefined)
	{
		
		var array=returnvalue.split(',');
		
		$("#"+id).attr("value",array[0]);
		$("#"+val).attr("value",array[1]);
		if(gsname != null && gsname != ''){
			$("#"+gsname).attr("value",array[2]);
		}
		if(val=="cus"&&id=="cusname"&&gsname=="cuscomp")
		{
			$("#"+model).attr("value",array[3]);
			$("#"+pname).attr("value",array[4]);
			$("#"+type).attr("value",array[5]);
			return;
		}
		valdateProduct(array[1]);
		if(model!=null&&model!=""&&pname!=null&&pname!=""&&type!=null&&type!="")
		{
			$("#"+model).html(array[4]);
			$("#"+pname).html(array[2]);
			$("#"+type).html(array[3]);
		}
		if(pname!=null&&pname!="")
		{
			$("#"+pname).attr("value",array[2]);
		}
		
//		if(array[5]!=null&&array[5]!="")
//		{	
//			$.post("findServiceLocationOutbound.do",{"serverid":array[0],"mark":array[6],"parentid":array[5]},
//					function(data){
//					var datali=data.split('#');
//					$("#"+servloc).attr("value",datali[0]);
//				//	document.getElementById("foselo").innerHTML="<input id='serverLocation' name='serverLocation' value='"+datali[0]+"'  />";
//					var ipli=datali[1].split(';');
//					var ipss="";
//					for(var i=0;i<ipli.length;i++)
//					{
//						var s=ipli[i].split(',');
//						ipss+="<input type='checkbox' id='serverIp' name='serverIp' value="+s[0]+"#"+s[1]+" />"+s[1]+"&nbsp;&nbsp;";
//					}  
//					document.getElementById("liip").innerHTML=ipss;
//			});
//		}
	}
}


function getvaluebatchexp(allvalue,id, batchexp, typename, modelname, price, count, modelid)
{
	if(allvalue!=undefined)
	{
		window.returnValue=allvalue;
	}
	window.close();
}


function returnBatchexp(url,batchexpidi,batchexpi,typei,modeli,pricei, counti, modelidi )
{
	
	var q = 0;
	var batchexptrid = $('#batchexpId'+batchexpidi).val();
	var returnvalue=showoneDialog(url);
	if(returnvalue!=undefined)
	{
		var array=returnvalue.split(',');
		$("#"+batchexpidi).attr("value",array[0]);
		$("#"+batchexpi).attr("value",array[1]);
		$("#"+typei).attr("value",array[2]);
		$("#"+modeli).attr("value",array[3]);
		$("#"+pricei).attr("value",array[4]);
		$("#"+counti).attr("value",array[5]);
		$("#"+modelidi).attr("value",array[6]);
	}
	
}

function getvalueToOrder(allvalue,toOrderId,toOrderNum, piciNo)
{
	if(allvalue!=undefined)
	{
		window.returnValue=allvalue;
	}
	window.close();
}

function returnToOrder(url,toOrderId, toOrderNum, piciNo )
{
	var date = new Date();
	var returnvalue=showoneDialog(url+"&t="+date);
	if(returnvalue!=undefined)
	{
		
		var array=returnvalue.split(',');
		$("#"+toOrderId).attr("value",array[0]);
		$("#"+toOrderNum).attr("value",array[1]);
		$("#"+piciNo).attr("value",array[2]);
		
	}
	
}

function showPriceReg(url)
{
	returnvalues= showModalDialog(url,"","dialogWidth=500px;dialogHeight=300px");
	if(returnvalues!=undefined)
	{
		var arry=returnvalues.split(",");
		$("#typeName").attr("value",arry[0]);
		$("#modelId").attr("value",arry[1]);
		$("#modelName").attr("value",arry[2]);
		$("#importprice").attr("value",arry[3]);
	}
}

function showWind(obj) {
	$("#dialog-modal").dialog({modal: true,hide:'slide',heigth:600,width:1000});
	alert(obj);
	$("#dialog-modal").load("showCommodity.do?num="+obj);
              // var returnvalue= showModalDialog("showCommodity.do"); 
//alert(returnvalue[0]+"-"+returnvalue[1]+"-"+returnvalue[2]+"-"+returnvalue[3]);
//
//$("#types"+obj).val(returnvalue[0]);
//$("#models"+obj).attr("value",returnvalue[3]);
//$("#type"+obj).attr("value",returnvalue[1]);
//$("#model"+obj).attr("value",returnvalue[2]);     
}








