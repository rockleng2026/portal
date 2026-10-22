
var i=1;
var allType;
//加载页面时查找出所有类型
function tabload(str)
{
	var url = "selectcommodityTpye.do";//url地址
	$.post(url,{
		},function(data){
			  allType=$.trim(data);
			  if(str!=null)
				  $("#type"+str+"").append(allType);
		});
}

//读取类型
function getType(str)
{
	tabload();
	$("#type"+str+"").append(allType);
}

//添加行时加载类型列表
function editTab(tes)
{
	
	var selId=$("#selId").val();
	var tr;
	if(selId!=null&&selId!="")
	{
		i=++selId;
		document.getElementById("selId").value="";
	}
	var a=i++;
	if(tes=='tes')
	{
		tr="<tr id='tr"+a+"'>" +
		"<td><select id='type"+a+"' name='type' onchange='getModel(\""+a+"\")'></select></td>" +
		"<td><select id='model"+a+"' name=\"model\" onchange='modelcount(\""+a+"\")'></select></td>" +
		"<td><input id='datacount"+a+"' name='datacount' readonly='readonly' /></td>" +
		"<td><input id='factcount"+a+"' name='factcount' onblur='calcu(\""+a+"\")' value=0 size=''/></td>" +
		"<td><input id='count"+a+"'  name='count' readonly='readonly' value=0 size=''/></td>" +
		"<td><input id='remarks"+a+"' name='remarks' value='-----' onblur='editHX(\"remarks"+a+"\")' /></td>" +
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td></tr>";
	}
	else if(tes=='out')
	{
		var depId=$('#depId').val();
		if(depId!=null&&depId!="")
		{
			tr="<tr id='tr"+a+"'>" +
			"<td><input id='code"+a+"' name='code'  onclick=\"completemission3('showDialogOutbound.do?mark=commodity','"+a+"')\"   /><input type='hidden' id='codeId"+a+"' name='codeId' /></td>" +
			"<td><input id='pname"+a+"' name='pname'></input></td>" +
			"<td><input id='pmodel"+a+"'  name='pmodel' ></input></td>" +
			"<td><input id='ptype"+a+"'  name='ptype' ></input></td>" +
			"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td></tr>";
		}
		else
			alert("请选择仓库！");
	}
	else if(tes=='PorL')
	{
		tr="<tr id='tr"+a+"'>" +
		"<td><input onclick=\"completemission3('showDialogOutbound.do?mark=commodity','"+a+"')\"    id='code"+a+"' name='code' /><input type='hidden' id='codeId"+a+"' name='codeId' /></td>" +
		"<td><input id='pname"+a+"' name='pname'></input></td>" +
		"<td><input id='pmodel"+a+"'  name='pmodel' ></input></td>" +
		"<td><input id='ptype"+a+"'  name='ptype' ></input></td>" +
		"<td><input id='desc"+a+"' name='desc' value='-----' onblur='editHX(\"desc"+a+"\")'/></td>" +
		"<td><input id='dispose"+a+"' name='dispose' value='-----' onblur='editHX(\"dispose"+a+"\")'/></td>" +
		"<td><input id='price"+a+"' onblur='editSums(\""+a+"\")' name='price' value='0.00' /></td>" +
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td></tr>";
	}
	else if(tes=='warehousingaddtable'){       //新购商品入库
//		var depId=$('#depId').val();
//		var storageType=$('#storageType').val();
//		var emp=$('#emp').val();
//		var time = $('#time').val();
//		if(depId==null||depId==""||storageType=='-1'||emp==null||emp==""||time==null||time==""){
//			alert("请先填写完入库单");
//			return;
//		}onclick="returnSome('showDialogOutbound.do?mark=custom','cus','cusname')"
		tr="<tr id='tr"+a+"'>" +
		"<td>" +
				
				" <input  type=\"text\"  id='piciNo"+a+"' name='piciNo'   readonly='readonly' " +
				"  onclick=\"completemission3('showDialogOutbound.do?mark=toOrder&num="+a+"','"+a+"')\" onblur=\"checkValueByRules('piciNo"+a+"','','piciNoMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"piciNoMsg\" color=#ff0000></FONT>  " + 
				"<input type=\"hidden\"  id=\"toOrderId"+a+"\"name=\"toOrderId\" />" +
				"<input type=\"hidden\" id=\"code"+a+"\" name=\"code\" />" +
				
		"</td>"+
		"<td><input type=\"text\" id='toOrderNum"+a+"' name='toOrderNum'  readonly='readonly' /></td>" +
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td>" +
				"</tr>";
	 //alert(tr);
	}
	else if(tes == 'customerTabs')//客户商品入库添加TR
	{
		tr="<tr id='tr"+a+"'>" +
		
		"<td><input type=\"hidden\" id=\"models"+a+"\" name=\"models\" /><input type=\"text\" id='model"+a+"' name='model'  readonly='readonly' onclick='showWind("+a+")' onblur=\"checkValueByRules('model"+a+"','','modelMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"modelMsg\" color=#ff0000></FONT></td>" +
		"<td><input type=\"text\" id='barcode"+a+"' name='barcode' onblur=\"checkValueByRules('barcode"+a+"','valBarcodeCommodity.do','barcodeMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"barcodeMsg\" color=#ff0000></FONT></td>"+
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td>" +
				"</tr>";
		//alert(tr);
		$("#customerTabs").append(tr);
		return;
		
	}else if(tes == "totherTabs")  //其他入库
	{
		var id = $("#storageType").find("option:selected").val();

		if(id ==-1)
		{
			alert("请选择入库类型");
			return;
		}
		tr="<tr id='tr"+a+"'>" +
		"<td><input type=\"text\" id='barcode"+a+"' name='barcode' onblur=\"checkValueByRules('barcode"+a+"','','barcodeMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"barcodeMsg\" color=#ff0000></FONT></td>"+
		
		"<td><input  type=\"text\"  id='model"+a+"' name='model' onclick='showWind("+a+")'   readonly='readonly' " +
				"onclick=\" returnToOrder('showDialogWarehousing.do?mark=toOrder'," +
				" 'toOrderId"+a+"', " +
				" 'toOrderNum"+a+"', " +
				" 'piciNo"+a+"' " +
				") \"  onblur=\"checkValueByRules('model"+a+"','','modelMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"modelMsg\" color=#ff0000></FONT>" + 
				"<input type=\"hidden\"  id=\"models"+a+"\"name=\"models\" /></td>"+
	
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td>" +
				"</tr>";
		$("#totherTabs").append(tr);
		return;
	}else if(tes == "surplusabsTabs")//报溢入库
	{
		tr="<tr id='tr"+a+"'>" +

		"<td><input  type=\"text\"  id='income"+a+"' name='income'  readonly='readonly' " +
				"onclick=\"completemission3('showDialogOutbound.do?mark=income&num="+a+"','"+a+"')\"  onblur=\"checkValueByRules('income"+a+"','','incomeMsg')\"/><FONT color=#ff0000>*</FONT><FONT id=\"incomeMsg\" color=#ff0000></FONT> " + 
				"<input type=\"hidden\"  id=\"incomeid"+a+"\"name=\"incomeid\" /></td>"+
	
		"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td>" +
				"</tr>";
		//alert(tr);
		$("#surplusabsTabs").append(tr);
		return;
		
	}
	else
	{
		tr="<tr id='tr"+a+"'>" +
			"<td><select id='type"+a+"' name='type' onchange='getModel(\""+a+"\")'></select></td>" +
			"<td><select id='model"+a+"' name=\"model\" onchange='valdateModel(\""+a+"\")'></select></td>" +
			"<td><input id='infoprice"+a+"' name='infoprice' onblur='onesum(\""+a+"\")' value='0.00' size=''/></td>" +
			"<td><input id='discount"+a+"' name='discount' onblur='onesum(\""+a+"\")' value='1.0' size=''/></td>" +
			"<td><input id='count"+a+"' name='count' onblur='onesum(\""+a+"\")' value='1' size=''/></td>" +
			"<td><input id='sum"+a+"' name='sum' onblur='onesum(\""+a+"\")' value='0.00' size=''/></td>" +
			"<td><input value='删除' class=button type='button'  onclick='delTr(\""+a+"\")' /></td></tr>";
	}
	$("#editTabs").append(tr);
	$("#type"+a+"").append(allType);
	$("#model"+a+"").append("<option>请选择</option>");
	
}

//选择类型时改变型号选项
function getModel(str){
	
	try{
		   var type = $("#type"+str).val();
		   var url = "selectcommodityModel.do";
		   $("#model"+str+"")[0].length=0;
		   $.post(url,{
			    deptid:type
			},function(data){
					$("#model"+str+"").append(data);
			 });
			 }catch(err){
	  	     alert("错误信息："+err.message);
	  	   }
   }


//选择的型号是否相同的判断
function valdateModel(str)
{
	var selId=$("#selId").val();
	var k;
	if(selId!=undefined&&selId!=''&&selId!=null)
		k=Number(selId)+1;
	else
		k=i;
	for(var j=1;j<k;j++){
		if(j!=str){
			if($("#model"+j+"").val()==$("#model"+str+"").val()){
				alert("该型号的产品已选择，请重新选择！");
			    $("#model"+str+"")[0].length=0;
			    getModel(str);
			    return "1";
			}
		}
	}
}

//判断单据中的产品是否唯一
function valdateProduct(code)
{
	var selId=$("#selId").val();
	var k;
	if(selId!=undefined&&selId!=''&&selId!=null)
		k=Number(selId)+1;
	else
		k=i;
	var tes=0;
	for(var j=1;j<k;j++){
		if($('#code'+j).val()==code){
			tes++;
			if(tes>1){
				alert("该产品已选择，请重新选择！");
				$("#tr"+j).remove();
			}
		}
	}
}




//删除指定行
function delTr(str)
{
	//alert(2222);
	if(document.getElementById("price")!=null&&document.getElementById("price")!="")
	{
		var ss=$("#sum"+str+"").val();
		var sumss=document.getElementById("price").value-ss;
		document.getElementById("price").value=sumss;
	}
	$("#tr"+str).remove();
}

//改变审核状态
function SH()
{
	var lab=document.getElementById('sh');
	var flag=confirm("是否确定审核通过?");
	//alert(flag);
	if(flag)
	{
		lab.innerHTML="已审核";
		document.getElementById('auditingState').value="已审核";
		$("#YI").attr("disabled",true);
	}
}

//改变审核状态
function SHPorL()
{
	var lab=document.getElementById('sh');
	var flag=confirm("是否确定审核通过?");
	//alert(flag);
	if(flag)
	{
		lab.innerHTML="已审核";
		document.getElementById('auditingState').value="1";
		$("#YI").attr("disabled",true);
	}
}


//添加采购订单或修改采购订单
function addPurOrder(url)
{
	 var cont=encodeURI(cont,"utf-8");
	  
	//alert(1111);
	if(!addValidators())
		return false;
	var sedit=$("#sedit").val();
	//采购订单数据
	var purOrderNo=$("#CKBum").val();
	var auditingState=$("#auditingState").val();
	//alert(auditingState);
	var supplier=$("#supid").val();
	var employee=$("#empid").val();
	var orderTime=$("#orderTime").val();
	var deliveryTime=$("#deliveryTime").val();
	var price=$("#price").val();
	var remarks1=$("#remarks").val();//添加备注
	 var remarks=encodeURI(remarks1,"utf-8");
	
	var account=$("#account").val();//账号
	
	var accountName1=$("#accountName").val();//账号名称
	 var accountName=encodeURI(accountName1,"utf-8");
	
	var accountType1=$("#accountType").val();//账号类别
	 var accountType=encodeURI(accountType1,"utf-8");
	
	
	var delflag=0;
	//采购详细数据
	var model=document.getElementsByName("model");
	var infoprice=document.getElementsByName("infoprice");
	var discount=document.getElementsByName("discount");
	var count=document.getElementsByName("count");
	var sum=document.getElementsByName("sum");
	
	var applyArray=$('#applyArray').val();
	
	
	var modelArr=new Array();
	var infopriceArr=new Array();
	var discountArr=new Array();
	var countArr=new Array();
	var sumArr=new Array();
	
	var allLength=model.length;
	for(var aa=0;aa<allLength;aa++)
	{
		modelArr[aa]=model[aa].value;
		infopriceArr[aa]=infoprice[aa].value; 
		discountArr[aa]=discount[aa].value;
		countArr[aa]=count[aa].value;
		sumArr[aa]=sum[aa].value;
	}
	if(modelArr.length>0)
	{
		for(var ii=0;ii<modelArr.length;ii++)
		{
			if(modelArr[ii]=="")
			{
				alert("请选择型号！");
				return false;
			}	
		}
		$.post(url,{mode:modelArr.join("-"),infoprice:infopriceArr.join("-"),discount:discountArr.join("-"),
			count:countArr.join("-"),sum:sumArr.join("-"),purOrderNo:purOrderNo,auditingState:auditingState,'supplier.id':supplier,
			'employee.id':employee,orderTime:orderTime,deliveryTime:deliveryTime,price:price,
			remarks:remarks,account:account,accountName:accountName,accountType:accountType
			,delflag:delflag,id:sedit,applyArray:applyArray},
			function (data)
			{
				//alert("dataMarker:"+data);
				if(data==0||data==2){
		            alert('操作成功！');
		            window.location.href="getPurchaseOrder.do?funid=54";
				}
				else 
					alert('操作失败！');
			});
	}
	else
		alert("请添加采购产品！");
}


//计算总价格
function onesum(str)
{
	var price=$("#infoprice"+str);
	var discount=$("#discount"+str);
	var count=$("#count"+str);
	var reg="/^-?\d*\.?\d+$/";

	
	if(price.val()=="")
		price.val('0.00');
	if(discount.val()=="")
		discount.val('1.0');
	if(count.val()=="")
		count.val('0');
	var sum=price.val()*discount.val()*count.val();
	if(sum==0)
		sum='0.00';
	
    var sums=0;
    
	document.getElementById("sum"+str).value=sum;
	
	var su=document.getElementsByName('sum');
    for(var jj=0;jj<su.length;jj++)
    {
    	sums+=Number(su[jj].value);
    }
	document.getElementById("price").value=sums;
}

//单击model的select标签将option赋给该select
function typeSel(str)
{
	$("#type"+str+"").empty();
	$("#type"+str+"").append(allType);
}

//删除采购订单详细记录
function delData(infoId,str)
{
	var url="delPurInfoPurchaseOrder.do";
	$.post(url,{infoId:infoId},
	function (data)
	{
		if(data==0)
		{
			delTr(str);
		}
	});
}



//选中行并且让获取其中对象的主键id
var betr="";
function gettr(id)
{
	if(betr!=""){
	$("#tr"+betr).css("background", "");
	}
	$("#tr"+id).css("background", "red");
	betr=id;
	return betr;
}

/**
 * 弹出请购单信息
 * @param obj
 * @return
 */
function pleaseOrder()
{
    window.location.href='pleasePurchaseOrder.do';
}

//勾选所有要删除项
function CheckAll(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall')
	    	e.checked = form.chkall.checked; 
	  }
}

/**
 * 获取要复制的请购Id
 */
function copys(url)
{
	var delflag=false;
	//获得复制多选按钮的集合
	var all=document.getElementsByName('allplease');
	
	var allId=new Array();
	var j=0;
	//拿出多选中被选中的项
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
		alert("请选择要复制的记录！");
		return false;
	}
	delflag=confirm("是否确定要复制？");
	if(!delflag)
	{
		return false;
	}
	var aj=allId.join('-');
	url+="?allplease="+aj;
	//alert(url);
	window.location.href=url;
}

/**
 * 选项型号查找相应仓库的数量
 */
function modelcount(str)
{
	if(valdateModel(str)!="1"){
		var depId=$('#depId').val();
		if(depId==null||depId=="")
		{
			alert("请选择仓库");
		}
		else
		{
			$("#datacount"+str+"").attr("value",0);
			$("#factcount"+str+"").attr("value",0);
			$("#count"+str+"").attr("value",0);
			if($("#model"+str+"").val()!=null&&$("#model"+str+"").val()!="")
			{
				var modelId=$("#model"+str+"").val();
				var url = "somecommodityModel.do";
				$.post(url,{depId:depId,modelId:modelId},
						function (data)
						{
							$("#datacount"+str+"").attr("value",data);
						});
			}
		}
	}
}

/**
 * 计算盘盈盘亏(实际数量-账面数量)
 */
function calcu(str)
{
	var fact=$("#factcount"+str+"").val();
	if(!/^\d+$/g.test(fact))
	{
		//alert(1111);
		$("#factcount"+str+"").attr("value",0);
		$("#count"+str+"").attr("value",0);
		return ;
	}
	if(fact!=null&&fact!="")
	{
		//alert(2222);
		var data=$("#datacount"+str+"").val();
		var count=fact-data;
		//alert(count);
		$("#count"+str+"").attr("value",count);
	}
}

/**
 * 添加或修改盘点单
 */
function addOreditStat(url)
{
	//alert(url);
	if(!addValidators())
		return false;
	var sedit=$("#sedit").val();
	//盘点单数据
	var PDNo=$("#PDNo").val();
	var statMethod=encodeURI($("#statMethod").val());
	var depId=$("#depId").val();
	var empId=$("#empId").val();
	var time=$("#time").val();
	var remark=encodeURI($("#remark").val());
	var delflag=0;
	//盘点单详细数据
	var model=document.getElementsByName("model");
	var factcount=document.getElementsByName("factcount");
	var datacount=document.getElementsByName("datacount");
	var count=document.getElementsByName("count");
	var markInfo=document.getElementsByName("remarks");
	
	var modelArr=new Array();
	var factcountArr=new Array();
	var datacountArr=new Array();
	var countArr=new Array();
	var markInfoArr=new Array();
	
	var allLength=model.length;
	for(var aa=0;aa<allLength;aa++)
	{
		modelArr[aa]=model[aa].value;
		factcountArr[aa]=factcount[aa].value;
		datacountArr[aa]=datacount[aa].value;
		countArr[aa]=count[aa].value;
		markInfoArr[aa]=markInfo[aa].value;
	}
	if(modelArr.length>0)
	{
		for(var ii=0;ii<modelArr.length;ii++)
		{
			if(modelArr[ii]=="")
			{
				alert("请选择型号！");
				return false;
			}
		}
		$.post(url,{mode:modelArr.join("-"),factcount:factcountArr.join("-"),datacount:datacountArr.join("-"),
			count:countArr.join(","),markInfo:encodeURI(markInfoArr.join("-")),statNo:PDNo,statType:statMethod,'depot.id':depId,
			'employee.id':empId,statTime:time,remark:remark,delflag:delflag,id:sedit},
			function (data)
			{
				if(data==0){
		            alert('操作成功！');
		            window.location.href="selectStat.do?funid=77";
				}
				else
					alert('操作失败！');
			});
	}
	else
		alert("请添加盘点产品！");
}

//删除盘点单详细记录
function delStatData(infoId,str)
{
	if(confirm("确实要删除吗?")){
	var url="delInfoStat.do";
	$.post(url,{infoId:infoId},
	function (data)
	{
		if(data==0)
		{
			delTr(str);
		}
	});
}else
	return;
}
//删除出库单详细记录
function delOutInfoData(infoId,str)
{
	var url="delInfoOutbound.do";
	$.post(url,{infoId:infoId},
	function (data)
	{
		if(data==0)
		{
			delTr(str);
		}
	});
}

//删除入库单详细记录
function delStorageInfoData(infoId,str, toOrderid,type)
{
	if(confirm("是否确定要删除？"))
	{
		var url="delInfoWarehousing.do";
		$.post(url,{infoId:infoId, id:toOrderid, type:type},
		function (data)
		{alert(data);
			if(data != '' && data==0)
			{
				delTr(str);
				alert("删除成功");
			}else{
				alert("删除失败");
			}
		});
	}
	
}

//传递入库详表ID transfer
function transferStorageInfoData(infoId,str)
{
	alert("CM： --->     --->    --->   获得的 infoId是： " + infoId);
	var url="transferStorageInfoWarehousing.do";
	$.post(url,{infoId:infoId},
	function (data)
	{
		if(data==0)
		{
			delTr(str);
		}
	});
}



//计算出库单总价格
function outSum(str)
{
	var count=$("#count"+str+"");
	var price=$("#price"+str+"");
	if(price.val()=="")
		price.val('0.00');
	if(count.val()=="")
		count.val('0');
	var sum=price.val()*count.val();
	if(sum==0)
		sum='0.00';
	
    var sums=0;
    //这里的你那边tr字符串拼接没问题了就取消注释
	document.getElementById("zong"+str).value = sum;
	
	var su=document.getElementsByName('zong');
    for(var jj=0;jj<su.length;jj++)
    {
    	sums+=Number(su[jj].value);
    }
	document.getElementById("sum").value=sums;
}

/**
 * 添加或修改报损报溢单
 */
function addOreditPorL(url)
{
	//alert(url);
	if(!addValidators())
		return false;
	var sedit=$("#sedit").val();
	//报损单数据
	var PorLNo=$('#PorLNo').val();
	var auditingState=$('#auditingState').val();
	//alert(auditingState);
	var statMethod=$('#statMethod').val();
	var empId=$('#empId').val();
	var time=$('#time').val();
	var sum=$('#sum').val();
	var remark=encodeURI($('#remark').val());
	var delflag=0;
	
	
	
	//报损单详细数据
	var codeId=document.getElementsByName("codeId");
	var desc=document.getElementsByName("desc");
	var dispose=document.getElementsByName("dispose");
	var price=document.getElementsByName("price");
	
	var codeIdArr=new Array();
	var descArr=new Array();
	var disposeArr=new Array();
	var priceArr=new Array();
	
	var allLength=codeId.length;
	for(var aa=0;aa<allLength;aa++)
	{
		codeIdArr[aa]=codeId[aa].value;
		descArr[aa]=desc[aa].value;
		disposeArr[aa]=dispose[aa].value;
		priceArr[aa]=price[aa].value;
	}
	if(codeIdArr.length>0)
	{
		for(var ii=0;ii<codeIdArr.length;ii++)
		{
			if(codeIdArr[ii]=="")
			{
				alert("请选择产品！");
				return false;
			}
		}
		
		$.post(url,{code:codeIdArr.join(","),desc:encodeURI(descArr.join(",")),dispose:encodeURI(disposeArr.join(",")),
			price:priceArr.join(","),ruinNo:PorLNo,auditing:auditingState,profitOrLoss:statMethod,
			'employee.id':empId,rtime:time,remark:remark,delflag:delflag,sum:sum,id:sedit},
			function (data)
			{
				if(data==0||data==2){
		            alert('操作成功！');
		            window.location.href="queryTheDamage.do?funid=78";
				}
				else
					alert('操作失败！');
			});
	}
	else
		alert("请添加盘点产品！");
}

/**
 * 报损报溢单修改总价格
 */
function editSums(str)
{
	var price=$("#price"+str);
	if(price.val()=="")
		price.val('0.00');
	var sums=0;
	var su=document.getElementsByName('price');
    for(var jj=0;jj<su.length;jj++)
    {
    	sums+=Number(su[jj].value);
    }
    $("#sum").attr("value",sums);
}

/**
 * 入库单 计算 总价格
 */
function editWahousingSums(str)
{
	var price=$("#price"+str);
	var count = $("#count"+str);
	if(price.val()=="" || price.val()==null  ){
		price.val('0.00');
	}
	var pricesum = 0;
	if(price.val()!="" && count.val()!=""){
		pricesum = price.val() * count.val();
	}
	var sums=0;
	var su=document.getElementsByName('price');
    for(var jj=0;jj<su.length;jj++)
    {
    	sums+=Number(pricesum);
    }
    $("#sum").attr("value",sums);
}



/**
 * -----
 */
function editHX(tem1)
{
	var t1=$("#"+tem1);
	if(t1.val()=='')
		t1.attr('value','-----');
}

/**
 * 计算某个型号的采购价格
 */
function enumPrice()
{
	var typeId=$('#typea').val();
	var modelId=$('#modela').val();
	var url="enumRugpriceReg.do";
	$.post(url,{modelId:modelId},
			function (data){
	            $("#importprice").attr("value",data);
	        });
}

/**
 * 关闭模式窗口将参数传回
 */
function closeP()
{
	var typeId=$("#typea").val();
	var modelId=$("#modela").val();
	var typeName=$("#typea option[value='"+typeId+"']").html();
	var modeName=$("#modela option[value='"+modelId+"']").html();
	var importprice=$("#importprice").val();
	
	if(importprice==""||importprice==null)
	{
		alert("请选择型号计算价格！");
	}
	else
	{
		var data=typeName+","+modelId+","+modeName+","+importprice;
		if(data!=null&&data!=""&&data!=undefined)
			window.returnValue=data;
		window.close();
	}
}

/**
 * 添加价格调整
 */
function addoreditPriceReq()
{
	if(!addValidators())
		return false;
	var modelId=$("#modelId").val();
	var importprice=$("#importprice").val();
	var saleprice=$("#saleprice").val();
	var empId=$("#empId").val();
	var time=$("#time").val();
	var url="addpriceReg.do";
	var delflag=0;
	var id=$('#sedit').val();
	var pNo=$('#pNo').val();
	var auditingState=$('#auditingState').val();
	//alert("PNo:"+pNo);
	//alert("audtiting:"+auditingState);
	if(id!=null&&id!="")
	{
		$.post("editpriceReg.do",{'model.model':modelId,'employee.id':empId,importprice:importprice,saleprice:saleprice,rtime:time,delflag:delflag,id:id,priceRegNo:pNo,auditingState:auditingState},
				function (data){
			if(data==0||data==2){
				alert("更新该型号的价格记录成功！");
				window.location.href="selectpriceReg.do?funid=185";
			}
			else
				alert("失败！");
		});
	}
	else
	{
		$.post("lookuppriceReg.do",{'model.model':modelId},
		function (data)
		{
			if(data==0||data==2)
			{
				var flag=confirm("存在该型号的价格记录，是否替换为新的价格记录");
				if(flag){
					$.post(url,{'model.model':modelId,'employee.id':empId,importprice:importprice,saleprice:saleprice,rtime:time,delflag:delflag,mark:'have1',priceRegNo:pNo,auditingState:auditingState},
							function (data){
						if(data==0||data==2){
							alert("替换该型号的价格记录成功！");
							window.location.href="selectpriceReg.do?funid=185";
						}
						else
							alert("替换该型号的价格记录失败！");
					});
				}
			}
			else{
				$.post(url,{'model.model':modelId,'employee.id':empId,importprice:importprice,saleprice:saleprice,rtime:time,delflag:delflag,priceRegNo:pNo,auditingState:auditingState},
						function (data){
					if(data==0||data==2){
						alert("添加该型号的价格记录成功！");
						window.location.href="selectpriceReg.do?funid=185";
					}
					else
						alert("添加该型号的价格记录失败！");
				});
			}
		});
	}
}

/**
 * 添加/修改上架单
 */
function addOreditUpserver(url)
{
	if(!addValidators())
		return false;
	var SJNo=$('#SJNo').val();
	var saleOrderid=$('#saleOrderid').val();
	var serverId=$('#serverId').val();
	var auditingState=$('#auditingState').val();
	var upstate=$("#upstate").val();
	//alert("3333"+upstate);
	var empid=$('#empid').val();
	var upTime=$('#upTime').val();
	var downTime=$('#downTime').val();
	var Mpass=$('#Mpass').val();
	var bwCount=$('#bwCount').val();
	var bwThro=$('#bwThro').val();
	var delflag=0;
	var upid=$('#upid').val();
	var serverIp=$('#serverIp').val();
	var ipnum = $("#serverIpNum").val();
	//alert(upid);
	
	$.post(url,{upNo:SJNo,saleId:saleOrderid,'product.id':serverId,'employee.id':empid,uptime:upTime,downtime:downTime,maintenancePass:Mpass,
		bandwidthAmount:bwCount,bandwidthThrottling:bwThro,audtitingFlag:auditingState,upFlag:upstate,delflag:delflag,id:upid,serverIp:serverIp,ipnum:ipnum},
			function (data)
			{
				if(data=="0"||data=="2"){
					alert("操作成功！");
					window.location.href="selectUpserver.do?funid=193";
				}
				else
					alert("操作失败！");
			});
}

 

/**
 * 添加/修改
 * @return
 */
function addOreditAll(url,href)
{
	if(!addValidators())
		return false;
	var formData=$("#form1").serialize();
	 $.ajax({
	  type: "POST",
	  url: url,
	  data:formData,
	  success: function(data){
		 if(data==0||data==2)
		 {
			 alert("操作成功！");
			 window.location.href=href;
		 }
		 else
			 alert("操作失败！");
	  }
	 });

}

/**
 * 添加/修改报溢单
 */
function addOrdereditIncome(url,href)
{
	alert(111);
	if(!addValidators())
		return false;
	//采购详细数据
	var model=document.getElementsByName("model");
	var infoprice=document.getElementsByName("price");
	var count=document.getElementsByName("count");
	var sum=document.getElementsByName("sum");
	
	
	var modelArr=new Array();
	var priceArr=new Array();
	var countArr=new Array();
	var sumArr=new Array();
	
	var allLength=model.length;
	for(var aa=0;aa<allLength;aa++)
	{
		modelArr[aa]=model[aa].value;
		priceArr[aa]=infoprice[aa].value;
		countArr[aa]=count[aa].value;
		sumArr[aa]=sum[aa].value;
	}
	if(modelArr.length>0)
	{
		for(var ii=0;ii<modelArr.length;ii++)
		{
			if(modelArr[ii]=="")
			{
				alert("请选择型号！");
				return false;
			}
		}
		var models=modelArr.join(",");
		var prices=priceArr.join(",");
		var counts=countArr.join(",");
		var sums=sumArr.join(",");
		
		var formData=$("#form1").serialize();
		formData+="&models="+models+"&prices="+prices+"&counts="+counts+"&sums="+sums;
		//alert(formData);
		 $.ajax({
		  type: "POST",
		  url: url,
		  data:formData,
		  success: function(data){
			 if(data==0||data==2)
			 {
				 alert("操作成功！");
				 window.location.href=href;
			 }
			 else
				 alert("操作失败！");
		  }
		 });
	}
	else
		alert("请添加报溢产品！");
}

//计算报溢单总价格
function onesumBY(str)
{
	var price=$("#price"+str);
	var count=$("#count"+str);
	if(price.val()=="")
		price.val('0.00');
	if(count.val()=="")
		count.val('0');
	var sum=price.val()*count.val();
	if(sum==0)
		sum='0.00';
	
    var sums=0;
    
	document.getElementById("sum"+str).value=sum;
	
	var su=document.getElementsByName('sum');
    for(var jj=0;jj<su.length;jj++)
    {
    	sums+=Number(su[jj].value);
    }
	document.getElementById("allSum").value=sums;
}








