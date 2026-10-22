	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>入库列表</title>
   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
  <base href="<%=basePath%>">
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
<link href="<%=basePath%>potal/css/stylecrk.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.d2 {
	z-index: 100004;
	position: absolute;
	left: 15%;
	top: 22%;
}
.ttd{
width: 100px;
}
</style>
<script type="text/javascript">
function aa(sid)
{    for(var i=0;i<allid.length;i++){

	 for(var j=0;j<100;j++){
		    $("#d"+list[i]+j).remove();
			$("#d"+list[i]+j).hide();
   		  	
			$("#d"+allid[i]).remove();
				$("#d"+allid[i]).hide();
 		    $("#"+allid[i]).remove();
				$("#"+allid[i]).hide();
	 }
   }
	
 list=[];
 alist=[];
	var  optionID=	document.getElementById(sid).value;	
	 document.getElementById("cgzb").style.display="none";
	  document.getElementById("ckzh").style.display="none";
	   document.getElementById("khtg").style.display="none";
	   document.getElementById("sbhk").style.display="none";
	 document.getElementById(optionID).style.display="";
}
function addcg(a){//添加仓库层
  if(a=="1"){
	$("#myFrames").attr("src","<%=basePath%>selectdeptosalegoods.do");
	$("#addrow1").css("display","block");	
	}else{
	$("#myFrames").attr("src","<%=basePath%>selectdeptosalegoods.do?div=div");
	$("#addrow1").css("display","block");	
	
	}
	

}
	function addckd(){//出库单
	
		$("#myFrames").attr("src","<%=basePath%>selectckdsalegoods.do");
	$("#addrow1").css("display","block");	
	
	
	}

	function addcust(){//客户列表
		$("#myFrames").attr("src","<%=basePath%>selectcustsalegoods.do?cust=cust");
	$("#addrow1").css("display","block");	

	
	}
function addproduct(){
	
	var val1=$("#depid").val();
	if(val1=='' || val1==null){
		alert("请先选择仓库！");
		return;
		}
			$("#myFrames").attr("src","<%=basePath%>selectproductsalegoods.do?depotid="+val1);
	$("#addrow1").css("display","block");	
	
}

function selectckd1(a,b,c,d){//选择出库单。出库单id 名字 员工 danhao 
    $("#ckd").val(d);
	$("#dep1").val(b);
	$("#ckdemp").val(c);
	$.ajax({
          url:'selectckdnrsalegoods.do',  //ajax请求获取详情,得到值加入到产品显示层中。
   		  type:'post',
   		  data:{purOrder:d},
   		  success:function(retu){
   	      
   		   var reu=new Array();
   		   var reu1=new Array();
   	
   		  $("#rucj").val(reu[0]);//入库总价
   		  
		  	   for(var i=0;i<list.length;i++){
		$("#d"+list[i]).remove();
			$("#d"+list[i]).hide();

}
   		 reu1=retu.split("|");
   			  for(var k=0;k<reu1.length-1;k++){
   			  if(reu1!="" && reu1!=null){
   			  var  stt=reu1[k];
   		
   			  reu=stt.split(",");
   			  
   		 
   		
   		
   		  list=[];
   	
	
   		  list.push(reu[5]);//加入层中
   	
	var begin="<div class='ck_vew_trd' style='display:block' id='d"+reu[5]+"'><div class='ck_vew_tdd_q' >"+"</div>";//商品名称
	 	begin+="<div class='ck_vew_tdd_w'>"+reu[3]+"</div>";
	    begin+="<div class='ck_vew_tdd_e'>"+reu[3]+"</div>";
	    begin+="<div class='ck_vew_tdd_r'>"+reu[5]+"</div>";
	    begin+="<div class='ck_vew_tdd_t'>"+reu[0]+"<em>(元)</em></div>";
	    begin+="<div class='ck_vew_tdd_y'>"+reu[4]+"</div>";
	    begin+="<div class='ck_vew_tdd_u'>暂无操作</div></div>";
   	
   		  var divid=$("#selectID1").val();//取到下拉选择框的值，判断是那个层，把商品添加到相应的值里面
	  
		 $("#ckzh").append(begin);
		  }
   			  }
   		  }
   
   });
	document.getElementById('addrow2').style.display='none'; //弹出层消失

}
var id=1;
var list=[];//id的集合
var allmonery=0.0;
var allid=[];
function selectdepot1(a,b,c,d,e,f) {//添加商品
	var intd= parseFloat(d);
	allid.push(f);
	for(var i=0;i<list.length;i++){	//判断不能重复
		var  zf=list[i];	
		alert(zf);	
		if(zf==f){
			alert("请不要重复添加，谢谢！");
			return;
			}
		}
	allmonery+=intd;
	list.push(f);//加入层中
	list.push(",");
	var begin="<div class='ck_vew_trd' style='display:block' id='"+f+"'><div class='ck_vew_tdd_q' >"+id+"</div>";//商品名称
	 	begin+="<div class='ck_vew_tdd_w'>"+a+"</div>";
	    begin+="<div class='ck_vew_tdd_e'>"+b+"</div>";
	    begin+="<div class='ck_vew_tdd_r'>"+c+"</div>";
	     begin+="<div class='ck_vew_tdd_y'>"+d+"</div>";
	    begin+="<div class='ck_vew_tdd_t'><input type='text' id='t"+f+"'  name='t"+f+"' class='ttd' style='width: 100'/></div>";
	   
	    begin+="<div class='ck_vew_tdd_u'><a href='javascript:delproduct("+f+",+"+d+")'>删除</a></div></div>";
	  	$("#cksl").val(list.length);
	  	
	  	var divid=$("#selectID1").val();//取到下拉选择框的值，判断是那个层，把商品添加到相应的值里面
	  	
		$("#"+divid).append(begin);
		$("#sl"+divid).val(list.length);
		$("#jg"+divid).val(allmonery);
		

	 $("#id"+divid).val(id);
	 	 id+=1; 
	document.getElementById('addrow2').style.display='none'; //弹出层消失
	
}

var o=0;
function selectpruOrder(purOrder,price,name,id){//根据请购单。找到对应详细信息，然后生成对应的商品
		 $("#empname").val(name);
		 $("#empid").val(id);
		$("#purorderno").val(purOrder);
      $.ajax({
          url:'selectpruOinfosalegoods.do',  //ajax请求获取详情,得到值加入到产品显示层中。
   		  type:'post',
   		  data:{purOrder:purOrder},
   		  success:function(retu){
   	         alert(retu);
   		   var reu=new Array();
   		   
   		 reu=retu.split(",");
   		  $("#rukd").val(reu[2]);//入库数量
   		  var sl=1;
   		 
   		  if(reu[2]!=""){
   		  
   		  sl=reu[2];
   		  }
   		  $("#rucj").val(reu[0]);//入库总价
   		  o+=1;
   		  	   for(var i=0;i<list.length;i++){
   	   		  	 for(var j=0;j<100;j++){
			    $("#d"+list[i]+j).remove();
				$("#d"+list[i]+j).hide();
   	   		  	 }
              }
   		  list=[];
   	
	
   		  list.push(reu[5]);//加入层中
   	      alert(reu[5]);
   		  for(var i=0;i<sl;i++){
	var begin="<div class='ck_vew_trd' style='display:block' id='d"+reu[5]+i+"'><div class='ck_vew_tdd_q' >"+(i+1)+"</div>";//商品名称
	 	begin+="<div class='ck_vew_tdd_w'>"+reu[3]+"</div>";
	    begin+="<div class='ck_vew_tdd_e'>"+reu[4]+"</div>";
	    begin+="<div class='ck_vew_tdd_r'>"+reu[4]+"</div>";
	    begin+="<div class='ck_vew_tdd_t'><em>(元)</em></div>";
	    begin+="<div class='ck_vew_tdd_y'><input type='text' id='rt"+i+"'  name='rt"+i+"' class='ttd' style='width: 100'/></div>";
	    begin+="<div class='ck_vew_tdd_u'><a href='javascript:delproduct(d"+reu[5]+")'>暂无操作</a></div></div>";
   		 
   		  var divid=$("#selectID1").val();//取到下拉选择框的值，判断是那个层，把商品添加到相应的值里面
	  
		 $("#cgzb").append(begin);
		  }
		  
   		  }
   
   });
   document.getElementById('addrow2').style.display='none'; //弹出层消失
}
function delproduct(id){//删除选中商品
	list=[];
	$("#d"+id).remove();
	$("#d"+id).hide();
	document.getElementById(id).style.display='none'; 
}
function sub11(){//提交
  var  strid="";
 	  var divid=$("#selectID1").val();
 	
 	  if(divid=="khtg" ||  divid=="cgzb"){
 	  if(divid=="khtg"){
 	  if($("#custname").val()==""){
 	  
 	    alert("客户不能为空!");
 	    return;
 	  }
 	  }
 	  if(list.length<=0){
 	  alert("请选择至少一个商品入库");
 	  return;
 	  
 	  }
 	  }
 	  if(divid!="ckzh"){
  for(var i=0;i<list.length;i++){
    strid+=list[i];  
    if($("#t"+list[i]).val()==""){
    
    alert("条形码不能为空！谢谢");
    return;
    }
  }
  }
	$("#idlist").val(strid);
	$("#f1").submit();

	}
function closediv()
{
	document.getElementById('addrow2').style.display='none';
}
function addproduct(){//商品列表层。
	
	var val1=$("#depid").val();
	if(val1=='' || val1==null){
		alert("请先选择仓库！");
		return;
		}
	$("#myFrames").attr("src","<%=basePath%>selectproductsalegoods.do?depotid="+val1);
	$("#addrow1").css("display","block");	
	
}
function addpurOrder(){//采购单列表层
$("#myFrames").attr("src","<%=basePath%>selectpurOrdersalegoods.do");
	$("#addrow1").css("display","block");	
   

}
function selectcust(a,b,c){//选择客户 客户id，客户名称，员工名字，员工ide
$("#custname").val(b);
$("#custid").val(a);
$("#phone").val(c);
document.getElementById('addrow2').style.display='none';
}
</script>
</head>
<body> 
    <%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 

java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

String str_date1 = formatter.format(currentTime); //将日期时间格式化 
     %>

  <div class="bk">
    <div class="bs">
      <div class="bs_t">您的位置：<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>新增入库</span></div>
      <form action="addstorageWarehousing.do" method="post" id="f1" name="f1">
      <div class="ck_xz">
         <div class="ck_xzt"><dl>
           <dt>入库单号：</dt><dd><input type="text" name="storageNo"  class="rk_txt" value="${RKNo }" /><input type="hidden" id="idlist" name="idlist"/></dd><dt>入库日期：</dt><dd><input type="text"  id="time1" value="<%=str_date1 %>" name="storageDate" class="txt_ck" onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})' onblur="cecktime()"/><span id="tim1e" style="display: none"><font color="red" >*请选择时间</font></span></dd>
           <dt>仓库位置：</dt><dd><input id="dep" name="dep"
								class="txt_ck" onclick="addcg(1)">
								<input type="hidden" value="" id="depid" name="depid"/></dd><dt>入库类型：</dt><dd>
      
<select name="menu1" onChange="aa('selectID1')" id="selectID1" value="this.value"> 
<option value="cgzb" selected>采购储备</option>
<option value="ckzh">仓库转换</option>
<option value="khtg">客户托管</option>
<option value="sbhk">设备回库</option>
</select>
 </dd></dl> 
      </div></div>     
<!-- No1 -->
<div class="ck_xmm" id="cgzb" style="display:block;">
<div class="ck_xzt"><dl>
<dt>入库数量：</dt><dd><input type="text" readonly="readonly" id="rukd" name="xgrksl" class="rk_txt" value="0" /></dd><dt>产品总价：</dt><dd><input type="text" name="price1" id="rkcj" class="rk_txt"  value="0"/></dd>
           <dt>采购单号：</dt><dd><input type="text" id="purorderno" name="purorderno" class="rk_txt"  onclick="addpurOrder()"/></dd><dt>采购人员：</dt><dd><input type="text" id="empname" name="empname" class="rk_txt" /><input name="empid" type="hidden" id="empid" value=""/></dd>
           <dt>备注：</dt><p class="txt_bzp"><textarea class="txt_bz"></textarea></p>
           <p style="width:640px; float:left; height:25px; line-height:25px; text-align:right; color:#000; font-size:12px; margin-bottom:10px;">经办人：${emp.name}</p>
</dl></div>
<div class="ck_zxc"><span></span></div>
<div class="ck_zxm">
           <div class="ck_vew_trt" id="cgzb">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								商品名称
							</div>
							<div class="ck_vew_tdt_e">
								商品类别
							</div>
							<div class="ck_vew_tdt_r">
								商品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
								条形码
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
         </div>

  
</div>

<!-- No2 -->

<div class="ck_xmm" id="ckzh" style="display:none;">
<div class="ck_xzt"><dl>
  <dt>入库数量：</dt><dd><input type="text" name="rukd" class="rk_txt" /></dd><dt>产品总价：</dt><dd><input type="text" id="rkcj" value="0" name="productPriceSum" class="rk_txt" /></dd>
           <dt>出库单号：</dt><dd><input  onclick="addckd()" id="ckd" type="text" name="cukd" class="rk_txt" /></dd><dt>原仓库：</dt><dd>
          <input id="dep1" name="dep1"
								class="txt_ck" onclick="addcg1()">
								<input type="hidden" value="" id="depid1" name="depid1"/>
           </select></dd>
<dt>原库管员：</dt><p style="width:714px; height:30px; float:left; margin-bottom:10px; margin-left:5px;"><input type="text"  id="ckdemp" name="ckdemp" class="rk_txt" /></p>
           <dt>备注：</dt><p class="txt_bzp"><textarea class="txt_bz"></textarea></p>
           <p style="width:640px; float:left; height:25px; line-height:25px; text-align:right; color:#000; font-size:12px; margin-bottom:10px;">经办人：${emp.name}</p>
</dl></div>
         <div class="ck_zxc"><span></span></div>
<div class="ck_zxm">
           <div class="ck_zxtable" >
             <div class="ck_vew_trt">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								商品名称
							</div>
							<div class="ck_vew_tdt_e">
								商品类别
							</div>
							<div class="ck_vew_tdt_r">
								商品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
								条形码
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
          
           </div>
         </div>
       
</div>

<!-- No3  -->
<div class="ck_xmm" id="khtg" style="display:none;">
<div class="ck_xzt"><dl>
 <dt>入库数量：</dt><dd><input type="text" readonly="readonly" name="slckzh" id="slckzh" class="rk_txt" /></dd><dt>产品总价：</dt><dd><input type="text" name="price2"class="rk_txt"  value="0"/></dd>
           <dt>客户姓名：</dt><dd><input type="text" onclick="addcust()" id="custname" name="custname" class="rk_txt" /><input type="hidden" name="custid" id="custid"/></dd><dt>客户电话：</dt><dd><input type="text" id="phone" name="phone" class="rk_txt" /></dd>         
           <dt>备注：</dt><p class="txt_bzp"><textarea class="txt_bz"></textarea></p>
           <p style="width:640px; float:left; height:25px; line-height:25px; text-align:right; color:#000; font-size:12px; margin-bottom:10px;">经办人：${emp.name}</p>
</dl></div>
         <div class="ck_zxc"><span><input type="button" class="hh_button" onclick="addproduct()"   value="添加一行"/></span></div>
<div class="ck_zxm">
           <div class="ck_zxtable">
              <div class="ck_zxtr_t"  id="ckzh">
              <div class="ck_vew_trt">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								商品名称
							</div>
							<div class="ck_vew_tdt_e">
								商品类别
							</div>
							<div class="ck_vew_tdt_r">
								商品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
							条形码
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
              </div>
             
           </div>
         </div>
         
</div>
<!-- No3 -->
  <div class="ck_xmm" id="ckcb" style="display:none;">
<div class="ck_xzt"><dl>
 <dt>入库数量：</dt><dd><input readonly="readonly" type="text" name="slkhtg" id="slkhtg" class="rk_txt"  value="1"/></dd><dt>产品总价：</dt><dd><input type="text" name="price3" class="rk_txt" value="0" /></dd>
           <dt>客户姓名：</dt><dd><input type="text" name="custname" id="custname" class="rk_txt" onclick="addcust()"/></dd><dt>客户电话：</dt><dd><input type="text" id="phone" name="rukd" class="rk_txt" /></dd>         
           <dt>备注：</dt><p class="txt_bzp"><textarea class="txt_bz"></textarea></p>
           <p style="width:640px; float:left; height:25px; line-height:25px; text-align:right; color:#000; font-size:12px; margin-bottom:10px;">经办人：${emp.name}</p>
</dl></div>
<div class="ck_zxc"><span><input type="button" class="hh_button" value="添加一行" onclick="addproduct()" /></span><label>产品名称：</label><input type="text" name="cpmc" value="" class="rk_txt" style="width:140px; margin-right:10px;" /><label>数量：</label><input type="text" name="cpmc" value="" class="rk_txt" style="width:140px; margin-right:10px;" /> <input type="button" name="bd" value="添加" class="hh_button" /></div>
<div class="ck_zxm">
           <div class="ck_zxtable" id="khtg">
              <div class="ck_vew_trt">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								商品名称
							</div>
							<div class="ck_vew_tdt_e">
								商品类别
							</div>
							<div class="ck_vew_tdt_r">
								商品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
								条形码
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
           
           </div>
         </div>
      
</div>
<!-- No4 -->
<div class="ck_xmm" id="sbhk" style="display:none;">
<div class="ck_xzt"><dl>
<dt>入库数量：</dt><dd><input readonly="readonly" type="text" id="slsbhk" name="slsbhk" class="rk_txt" /></dd><dt>产品总价：</dt><dd><input type="text" name="price4"  class="rk_txt"  value="0"/></dd>
           <dt>配置核查：</dt><dd style="width:714px;"><input type="radio" name="qew" value=无误" checked="checked"><label>无误</label><input type="radio" name="qew" value=有误"><label>有误</label></dd>
           <p style="width:764px; margin-left:30px; height:auto; line-height:20px; margin-bottom:10px; overflow:hidden; color:#f60; font-size:12px;">注：配置核查无误时，库存状态自动更改为入库，有误时，库存状态为冻结，有误时把有误的配置写在备注里，方便相关人员进行处理！</p>
           <dt>备注：</dt><p class="txt_bzp"><textarea class="txt_bz"></textarea></p>
           <p style="width:640px; float:left; height:25px; line-height:25px; text-align:right; color:#000; font-size:12px; margin-bottom:10px;">经办人：${emp.name}</p>
           </dl></div>
<div class="ck_zxc"><span><input type="button" class="hh_button" value="添加一行" /></span><label>条形码：</label><input type="text" name="txm" class="rk_txt" style="width:140px; margin-right:10px;" onclick="addproduct()" /> <input type="button" name="an" value="确定添加" onclick="addproduct()" class="hh_button" /></div>
<div class="ck_zxm">
           <div class="ck_zxtable" id="sbhk">
              <div class="ck_vew_trt">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								商品名称
							</div>
							<div class="ck_vew_tdt_e">
								商品类别
							</div>
							<div class="ck_vew_tdt_r">
								商品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
								条形码
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
           </div>
         </div>
         
</div>

<div id="addrow1" class="d2" style="display: none;">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrames" src=""
				style="width: 623px; height: 410px;"></iframe>
		</div>
		<div class="d2" style="display: none;" id="addrow2">
		   
		</div>


 </div> 

      <div class="ck_zxd">
           <input type="button"  onclick="sub11()" class="hh_button" value="保 存"  />  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <input type="button" class="hh_button" value="取 消"  />
         </div>
           
    </div>
    </form>
  </div>

</body>
</html>
