function Reset()
{
    var f=document.forms[0];//alert(f.id);
    f.reset();
}
function getTD()
{
   var newtd=document.createElement("td");
   newtd.setAttribute("align","center");
   newtd.style.backgroundColor="#ffffff";
   newtd.className="font02";
   return newtd;
}

function getTD2()
{
   var newtd=document.createElement("td");
   newtd.setAttribute("align","center");
   newtd.colSpan=5;
   newtd.style.backgroundColor="#ffffff";
   newtd.className="font02";
   return newtd;
}



function addProElement() 
{	 
      var table1 = document.getElementById('bill');
      var proStart=document.getElementById("ProCount");
      var maxNO=proStart.value;
      var item1=document.getElementById('item1');
      
      var endidx=table1.rows.length;
      var newtr =table1.insertRow(endidx);
      
      newtr.id="pro"+maxNO;
      proStart.value=parseInt(maxNO)+1;
       newtd=getTD();
      newtd.innerHTML='<input name="types" id="types'+maxNO+'" type="hidden" value="" /><input name="type" id="type'+maxNO+'" readonly="readonly" type="text" onclick="completemission2('+maxNO+')"/>';
      newtr.appendChild(newtd);
       newtd=getTD();
      newtd.innerHTML='<input name="models" id="models'+maxNO+'" type="hidden" value=""  /><input name="model" id="model'+maxNO+'" readonly="readonly" type="text"  />';
      newtr.appendChild(newtd);
       newtd=getTD();
      newtd.innerHTML='<input type="text" name="num" />';
      newtr.appendChild(newtd);
       
      newtd=getTD2();
      newtd.innerHTML='<a href="javascript:CancelTr(\''+newtr.id+'\')">删除</a>';
      newtr.appendChild(newtd);
 }
 
 function CancelTr(id)
 {   
     var dtr = document.getElementById(id);
     $("#"+id).remove();
     //dtr.parentNode.removeChild(dtr);
 }

 function sub()
 {
    var employeeByEmployeeId=$("#empid").val();
    var time=$("#time").val();
    var remark=$("#remark").val();
    var modes=document.getElementsByName('models');
    if(modes.length<1)
    {
    	alert("请添加要购买的商品");
    	return;
    }
  	var allmodels=new Array();
 	var j=0;
 	for(var i=0;i<modes.length;i++)
 	{
 			allmodels[j]=modes[i].value;
 			j++;
 	}
 	var types=document.getElementsByName('types');
  	var alltypes=new Array();
 	var j1=0;
 	for(var i=0;i<types.length;i++)
 	{
 	if(types[i].value=="" || types[i].value == null)
 	{
 	alert("请选择商品");
 	return;
 	}
 			alltypes[j1]=types[i].value;
 			j1++;
 	}
 	var nums=document.getElementsByName('num');
 	var allnums=new Array();
 	var j2=0;
 	for(var i=0;i<nums.length;i++)
 	{
 	if(nums[i].value=="" || nums[i].value==null)
 	{
 	alert("请输入数量");
 	return;
 	}
 	allnums[j2]=nums[i].value;
 	j2++;
 	}
 var url="addRejectioning.do";
 var stralltypes=alltypes.join("-");
 var strallmodels = allmodels.join("-");
 var strallallnums = allnums.join("-");
       if(allmodels.length == alltypes.length && alltypes.length == allnums.length){     
 $.post(url,{
 alltypes:stralltypes,
 allmodels:strallmodels,
 allnums:strallallnums,
 empid:employeeByEmployeeId,
 time:time,
 remark:encodeURI(remark)
 },function(date){

href();

 }
 );
 }else
 {
 alert("输入参数不匹配");
 return;
 }
 }
function update()
{
    var employeeByEmployeeId=$("#empid").val();
    var time=$("#time").val();
    var remark=$("#remark").val();
    var modes=document.getElementsByName('models');
    if(modes.length<1 )
    {
    	alert("请选择要购买的商品");
    	return;
    }
    var applybuyId=$("#applyBuyid").val();
  	var allmodels=new Array();
 	var j=0;
 	for(var i=0;i<modes.length;i++)
 	{
 			allmodels[j]=modes[i].value;
 			j++;
 	}
 	var types=document.getElementsByName('types');
  	var alltypes=new Array();
 	var j1=0;
 	for(var i=0;i<types.length;i++)
 	{
 	if(types[i].value=="" || types[i].value == null)
 	{
 	alert("请选择商品");
 	return;
 	}
 			alltypes[j1]=types[i].value;
 			j1++;
 	}
 	var nums=document.getElementsByName('num');
 	var allnums=new Array();
 	var j2=0;
 	for(var i=0;i<nums.length;i++)
 	{
 	if(nums[i].value=="" || nums[i].value==null)
 	{
 	alert("请输入数量");
 	return;
 	}
 	allnums[j2]=nums[i].value;
 	j2++;
 	}
 	 var applyBuyInfoId=modes=document.getElementsByName('applyBuyInfoID');
   	var allapplyBuyInfos=new Array();
  	var j3=0;
  	for(var i=0;i<applyBuyInfoId.length;i++)
  	{
  		allapplyBuyInfos[j3]=modes[i].value;
  			j3++;
  	}
  	
 var url="updateRejectioning.do";
 var stralltypes=alltypes.join("-");
 var strallmodels = allmodels.join("-");
 var strallallnums = allnums.join("-");
 var strallapplyBuyInfos = allapplyBuyInfos.join("-");
       if(allmodels.length == alltypes.length && alltypes.length == allnums.length){     
 $.post(url,{
 alltypes:stralltypes,
 allmodels:strallmodels,
 allnums:strallallnums,
 allapplyBuyInfos:strallapplyBuyInfos,
 empid:employeeByEmployeeId,
 applybuyId:applybuyId,
 time:time,
 remark:remark
 },function(date){


	href();


 }
 );
 }else
 {
 alert("输入参数不匹配");
 return;
 }
 }

function del(id,objid)
{
	var url="delApplyBuyInfoRejectioning.do";
$.post(url,{id:id},function(date)
		{
	CancelTr(objid);
	
		})
}

