

//确认修改
function edit(url){
	alert(1);
	if(!addValidators()){
		return false;
	}
	var id = $("#id").val();
	//alert(id);
	var isLeave = 1;
	var ve = document.getElementsByName("isLeave");
	for(var i=0; i<ve.length; i++){ 
		if(ve[i].type=='radio'){
			if(ve[i].checked==true){
				isLeave = ve[i].value;
			}
		}
	}
	var allids =document.getElementsByName('fjjtcyids');
	var vids = "";	// 记录所有的IDS
	var j = 0;		// 方法内部全局变量 累积+了多少个
	for(var i=0;i<allids.length;i++){
		vids += allids[i].value+",";
		j++;
	}
	alert(2);
	vids = vids.substring(0,vids.length-1);
	var delflag=0;
	var serializeform1 = $("#form1").serialize();
	//alert(serializeform1);
	document.form1.action=url;
	$("#form1").submit();
}

//勾选所有要删除项
function CheckAll(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall' && e.name != 'duall' && e.name != 'duqu')
	    	e.checked = form.chkall.checked; 
	  }
}

//勾选所有要接收项
function duquAll(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'duall' && e.name != 'chkall' && e.name != 'ids')
	    	e.checked = form.duall.checked; 
	  }
}


//删除所选信息
function del(url,href){
	var all=document.getElementsByName('ids');
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++){
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0){
		delflag=true;
	}
	if(!delflag){
		alert("请选择要操作的记录！");
		return false;
	}
	if(!delflag){
		return false;
	}
	$.post(url,{ids:allId},
	function (data)
	{
		if(data==1)
		{
			alert('操作成功！');
			window.location.href=href;
		}else if(data == 2){
			
		}
		if(data == 2)
		{
			alert("请将入库单的入库详细先删除");
		}
		else 
		{
//			alert('删除失败！');
			window.location.href=href;
			window.location.href=href;
		}
	});
}

function deldept(id,url,href){
   //alert(id+url+href);
	alert(1111);
   var delflag=true;
   if(id == null){
   	 delflag = false;
   	 alert("请选择部门");
   	 return false;
   }
	delflag=confirm("是否确定要删除？");
	if(!delflag)
		return false;
	$.post(url,{ids:id},
	function (data)
	{
		if(data==0){
			alert('删除成功！');
			window.location.href=href;
		}else if(data == 2)
		{
			alert("请将入库单的入库详细先删除");
		}
		else {
			alert('删除失败！');
		}
	});
}
//标识为已读所选信息
function duqumess(url,href){
	var delflag=false;
	
	var all=document.getElementsByName('duqu');

	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++)
	{
	
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0)
	{
		delflag=true;
	}
		
	if(!delflag)
	{
		alert("请选数据记录！");
		return false;
	}
	alert("你选中了"+allId.length+"数据");
	delflag=confirm("是否确定要标识为已读？");
	if(!delflag)
		return false;
	$.post(url,{duqu:allId},
	function (data)
	{
		if(data==0){
			alert('操作成功！');
			window.location.href=href;
		}
		else {
			alert('操作失败！');
		}
	});
}


//修改部门信息
function editdep(url)
{
	if(!checkadd())
		return false;
	var empid=$("#empid").val();
	
	var id=$("#id").val();
	var name=encodeURI($("#name").val());
	var tel=$("#tel").val();
	var delflag=0;
	var time=$("#time").val();
	var depNo=$("#depNo").val();
	var parentId=$("#parentId").val();
	var filialemark=$("#filialemark").val();
	var fmark=$("#fmark").val();
	var ptext=$("#ptext").val();
	var url=url;
	$.post(url,{id:id,name:name,tel:tel,delflag:delflag,'employee.id':empid,time:time,depNo:depNo,parentId:parentId,filialemark:filialemark,ptext:ptext,fmark:fmark},
		function (data)
		{
		//alert(data);	
		if(data==0){
				alert('修改成功！');
				window.location.href="getAllstatisticsDepartment.do";
			}
			else{
				alert('修改失败！');
			}
		});
}

//添加部门时验证是否为分公司
function checkadd(){
	var a=$("input[name='fiiale']").attr("checked");
	var b=$("#ptext").val();
	var fmark=$("#fmark").val();
	if(a=='checked'){
	 	var filialemark=$("#filialemark").val();
		if(filialemark=="" || filialemark==null){
			alert("请填写公司代号！");
			return false;
		}
		else{
			if(b!="" && b!=null){
				if(fmark=="" || fmark==null){
					alert("请填写部门代号！");
					return false;
				}
			}
			return addValidators();
		}
	}
	else{
		if(b!="" && b!=null){
			if(fmark=="" || fmark==null){
				alert("请填写部门代号！");
				return false;
			}
		}
		return addValidators();
	}
		
}

//修改付款单信息
function editpays(url)
{
	alert("aaa");
	if(!addValidators())
		return false;
	var payNo=$("#payNo").val();
	var id=$("#id").val();
	var del=0;
	var paymentAmount=$("#paymentAmount").val();
	var empL=$("#empid").val(); 
	var purId=$("#purOrderid").val();
	var defrayMode=encodeURI($("#defrayMode").val());
	var account=$("#account").val();
	var time=$("#time").val();
	var inputTime=$("#inputTime").val();
	var auditingState=$("#auditingState").val();
	var missid = $("#missid").val();
	var missids = $("#paytype").children('option:selected').val();
	$.post(url,{id:id,payNo:payNo,del:del,paymentAmount:paymentAmount,'employee.id':empL,purId:purId,defrayMode:defrayMode,
		time:time,account:account,inputTime:inputTime,auditingState:auditingState,missids:missids},
		function (data)
		{
			if(data==0){
				alert('修改成功！');
				window.location.href="selectpay.do?funid=42";
			}
			else{
				alert('修改失败！');
			}
		});
}

/**
 * 添加或修改出库单
 */
function addorEditOutBound(url)
{
	if(!addValidators())
		return false;
	var oid=$('#oid').val();
	var CKBum=$('#CKBum').val();
	var dep=$('#depId').val();
	var outt=$('#outType').val();
	var empL=$('#empId').val();
	var time=$('#time').val();
	var sum=$('#sum').val();
	var remark=encodeURI($('#remark').val());
	var auditingState=$("#auditingState").val();
	//alert("state"+auditingState);
	var delflag=0;
	
	//盘点单详细数据
	var proId=document.getElementsByName("codeId");
	
	

	var proIdArr=new Array();
	
	var allLength=proId.length;
	for(var aa=0;aa<allLength;aa++)
	{
		
		proIdArr[aa]=proId[aa].value;
	}
	if(proIdArr.length>0)
	{
		for(var ii=0;ii<proIdArr.length;ii++)
		{
			if(proIdArr[ii]=="")
			{
				alert("请选择型号！");
				return false;
			}
		}
			$.post(url,{proId:proIdArr.join(',')
				,outboundNo:CKBum,'allType.id':outt,sum:sum,remark:remark,'depot.id':dep,'employee.id':empL,time:time,delflag:delflag,id:oid,auditingState:auditingState},
			function (data)
			{
		    	if(data=='0'||data=='2'){
		    		alert("操作成功");
		    		window.location.href="outBoundInfoOutbound.do?funid=69";
		    	}
			});
	}
	else
		alert("请添加出库产品！");
}



/**
 * 添加或修改入库单
 */
function addorEditWarehousing(url)
{
	//获取入库单数据
	var sid=$('#sid').val();		// 获取入库单ID 如果是修改，就能获取到 ，
	var RKBum=$('#RKBum').val();	// 入库单号
	var dep=$('#depId').val();		// 创库ID
	var storaget=$('#storageType').val();// 入库类型
	var empL=$('#empId').val();		// 员工id
	var time=$('#time').val();		// 入库时间
	var sum=$('#sum').val();		// 入库总价格
	var remark=encodeURI($('#remark').val());
	var delflag=0;
	var storageVerify = 0;
	
//	alert("添加和修改入库单JS  cm --->   \n sid="+sid+"  ---> RKBum="+RKBum+"  ---> dep="+dep+" ---> storaget="+storaget+" --> " +
//			"empL="+empL+"   --> time="+time+"    -->  sum="+sum+"  -->remark="+remark+"   ");

	
	
	//获取入库单详细数据
	var piciNo = document.getElementsByName("piciNo");	// 获得批次号 
	var toOrderId = document.getElementsByName("toOrderId");	// 获得到货单号  
	var count = document.getElementsByName("count");	// 获取输入的数值
	var code =document.getElementsByName("code");		// 获取条形码	CZP
	
	
	
	
	// 声明数组
	var batchexpIdArr = new Array();
	var typeArr=new Array();
	var modelArr=new Array();
	var priceArr=new Array();
	var countinputArr=new Array();
	var codeArr=new Array();
	var modelIdArr = new Array();
	
	var allLength = model.length;
	for(var i = 0; i < allLength; i++){
		batchexpIdArr[i] = batchexpId[i].value;
		typeArr[i] = type[i].value;
		modelArr[i] = model[i].value;
		priceArr[i] = price[i].value;
		countinputArr[i] = countinput[i].value;
		codeArr[i] = code[i].value;
		modelIdArr[i] = modelId[i].value;

//		alert("cm ---> batchexpIdArr="+batchexpIdArr[i]+"  ---> typeArr="+typeArr[i]+"  ---> modelArr="+modelArr[i]+ 
//				" ---> priceArr="+priceArr[i]+" --> " + "countinputArr="+countinputArr[i]+"   --> codeArr="+codeArr[i]+ 
//				"  -->  modelIdArr = "+modelIdArr[i] + " ");
	}
	
	$.post(url,{strBatchexpId:batchexpIdArr.join(","),strModeId:modelIdArr.join(','),
		strPrice:priceArr.join(","),strCountinput:countinputArr.join(","),    strCode:codeArr.join(','),  
		storageNo:RKBum, 'depot.id':dep,'allType.id':storaget,'employee.id':empL,
		storageDate:time,productPriceSum:sum,delflag:delflag,storageVerify:storageVerify,storageId:sid,storageRemark:remark},
		function (data)
		{
			if(data==0){
	            alert('操作成功！');
	            window.location.href="warehousingInfoWarehousing.do";
			}
			else{
				alert('操作失败！');
				window.location.href="warehousingInfoWarehousing.do";
			}
		});
}

//验证该单据是否已经进入审核流程，如果是不能修改
function valEdit(orderNo,href)
{
	if(orderNo!=undefined&&orderNo!=null&&orderNo!=''){
		$.post("valEditAuditing.do",{orderNo:orderNo},
		function (data){
			//alert(data);
			//if(data==0){
			//	alert("该单据已进入审核流程，无法修改！");
			//}
			//else{
				window.location.href=href;
			//}
		});
	}
	else{
		window.location.href=href;
	}
}

//执行审核完成后的操作
function executePass(url,orderNo)
{
	if(url!=undefined){
    	$.post(url,{orderNo:orderNo},
    	function (data){
    		if(data==0){
    			alert("出库成功！");
    			history.go(0);
    		}
    		else
    			alert("由于涉及的产品正在使用状态所有无法删除！");
    	});
	}
}

//执行上架
function executeServer(url,id,proId)
{
	if(url!=undefined){
    	$.post(url,{proId:proId,upId:id},
    	function (data1){
    	
    		if(data1==0){
    			
    			alert("执行成功！");
    			history.go(0);
    		}
    		else
    			alert("执行失败！");
    	});
	}
}

/**
 * 执行故障转接
 * @conkOutNo  故障单号
 * @state 状态
 */
function changeover(conkOutNo,state,starturl,endurl,status,parentid,conid)
{
	var depid=$("#seldep").val();
	var empid=$("#selemp").val();

	var handleDetail=encodeURI($("#handleDetail"+status).val());
	if(handleDetail==undefined||handleDetail=='undefined')
		handleDetail=null;
	if(handleDetail==""){
		alert("请填写处理结果。。");
		return false;
	}
	
	if(state=='3'){
		depid=$("#dep").val();
		empid=$("#emp").val();
	}
	if(depid==undefined)
		depid=null;
	if(empid==''&&state=='2'){
		alert('请选择员工！');
		return false;
	}
	
	if(state=='-1'){
		depid=null;
	}

	if(parentid!=undefined && parentid!=null && parentid!=''){
		empid=$("#emp").val();
		handleDetail=encodeURI($("#kefudetail").val());
		if(handleDetail=='')
		{
			alert("请填写内容！");
			return false;
		}
		
	}

	$.post(starturl,{depid:depid,empid:empid,state:state,conkOutNo:conkOutNo,handleDetail:handleDetail,parentid:parentid,conid:conid},
	function(data){
		
		if(data==0){
			alert("操作成功！");
			window.location.href=endurl;
		}
		else{
			alert("系统繁忙。。。");
		}
	});
}

/**
 * 转接部门退回
 * @conkOutNo  故障单号
 * @state 状态
 */
function goback(conkOutNo,state,starturl,endurl,status)
{
	
	var empid=$("#selemp").val();
	var handleDetail=encodeURI($("#detial"+status).val());
	var flag=confirm("是否确定退回？");	
	if(flag){
		if(handleDetail==undefined||handleDetail=='undefined')
			handleDetail=null;
		if(handleDetail==""){
			alert("请填写处理结果。。");
			return false;
		}
		
		if(state=='-1'){
			depid=null;
		}
		$.post(starturl,{depid:depid,empid:empid,state:state,conkOutNo:conkOutNo,handleDetail:handleDetail},
		function(data){
			if(data==0){
				alert("操作成功！");
				window.location.href=endurl;
			}
			else
				alert("系统繁忙。。。");
		});
	}
}

/**
 * 转接下个部门
 */
function nextdep(conid,conkOutNo,state,starturl,endurl,parentid)
{
	
	var depid=$("#seldep").val();
	var empid=$("#selemp").val();
	alert(state+"   "+empid);
	if(empid==''&&state=='2'){
		alert('请选择员工！');
		return false;
	}
	$.post(starturl,{empid:empid,depid:depid,conkOutNo:conkOutNo,state:state,parentid:parentid,conid:conid},
	function (data){
		if(data==0){
			alert("操作成功！");
			window.location.href=endurl;
		}
		else
			alert("系统繁忙。。。");
	});
}

/**
 * 转接处理
 */
function handde(conkOutNo,state,starturl,endurl,status)
{
	var depid;
	var empid;
	var detail=encodeURI($("#detial"+status+"").val());
	if(state=='3'){
		depid=$("#dep").val();
		empid=$("#emp").val();
	}
	if(empid==''&&state=='2'){
		alert('请选择员工！');
		return false;
	}
	$.post(starturl,{conkOutNo:conkOutNo,depid:depid,empid:empid,state:state,handleDetail:detail},
			function (data){
					
					if(data==0){
						alert("操作成功！");
						window.location.href=endurl;
					}
					else
						alert("系统繁忙。。。");
				});
}

/**
 * 联动员工
 */
function handemp(id,url)
{
	var id=$("#"+id).val();
	var selemp=$("#selemp");
	selemp.empty();
	$.post(url,{deptid:id},
			function (data)
			{
				selemp.append(data);
			});
}

//删除所选信息
function delmes(url,href){
	
	var delflag=false;
	
	var all=document.getElementsByName('ids');
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++)
	{
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0)
		delflag=true;
	if(!delflag)
	{
		alert("请选择要删除的记录！");
		return false;
	}
	delflag=confirm("是否确定要删除？");
	if(!delflag)
		return false;
	$.post(url,{ids:allId},
	function (data)
	{
		alert(data);
		if(data==0){
			alert('删除成功！');
			window.location.href=href;
		}else if(data == 2)
		{
			alert("请将入库单的入库详细先删除");
		}
		else {
			alert('删除失败！');
		}
	});
}





