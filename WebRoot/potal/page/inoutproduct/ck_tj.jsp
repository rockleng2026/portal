
<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer"
	pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page
	import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
		<base href="<%=basePath%>">
		<title>新增出库</title>
		   <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
		<link href="<%=basePath%>potal/css/stylecrk.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=basePath%>js/validators.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.js"></script>
		

		
<style type="text/css">
.d2 {
	z-index: 100004;
	position: absolute;
	left: 15%;
	top: 22%;
}

</style>
<script type="text/javascript">
function addcg(){
	$("#myFrames").attr("src","<%=basePath%>selectdeptosalegoods.do");
	$("#addrow1").css("display","block");	
	
	
}
var id=1;
var list=[];//
var allmonery=0.0;
function selectdepot1(a,b,c,d,e,f) {
	var intd= parseFloat(d);
	alert(f);
	for(var i=0;i<list.length;i++){	
		var  zf=list[i];	
		alert(zf);	
		if(zf==f){
			alert("请不要重复添加该商品，谢谢！");
			return;
			}
		}
	allmonery+=intd;
	list.push(f);
	var begin="<div class='ck_vew_trd' style='display:block' id='"+f+"'><div class='ck_vew_tdd_q' >"+id+"</div>";//商品名称
	 	begin+="<div class='ck_vew_tdd_w'>"+a+"</div>";
	    begin+="<div class='ck_vew_tdd_e'>"+b+"</div>";
	    begin+="<div class='ck_vew_tdd_r'>"+c+"</div>";
	    begin+="<div class='ck_vew_tdd_t'>"+d+"<em>(元)</em></div>";
	    begin+="<div class='ck_vew_tdd_y'>1</div>";
	    begin+="<div class='ck_vew_tdd_u'><a href='javascript:delproduct("+f+",+"+d+")'>删除</a></div></div>";
	  	$("#cksl").val(list.length);
		$("#addrow0").append(begin);
		
		$("#ckzj").val(allmonery);
		
	 id+=1;
	document.getElementById('addrow2').style.display='none'; 
	
}
function delproduct(id,money){
	var intd= parseFloat(money);
	for(var i=0;i<list.length;i++){	
		var  zf=list[i];		
		if(zf==id){
			list.splice(i, 1);
		
			}
		}
	allmonery=allmonery-intd;
	$("#ckzj").val(allmonery);
	$("#cksl").val(list.length);
	$("#"+id).remove();
	$("#"+id).hide();
	document.getElementById(id).style.display='none'; 
}
function sub(){
	$("sub").action = "<%=basePath%>selectdeptosalegoods.do";
	
	$("sub").submit();

	}
function closediv()
{ alert(2);
	document.getElementById('addrow2').style.display='none';
}
function addproduct(){
	
	var val1=$("#depid").val();
	if(val1=='' || val1==null){
		alert("请先选择仓库！");
		return;
		}
	$("#myFrames").attr("src","<%=basePath%>selectproduct1salegoods.do?depotid="+val1);
	$("#addrow1").css("display","block");	

  //$("#addrow2").load(url);
  //$("#addrow2").css("display","block");
}
function addck(){


if($("#dep").val()==''){
	alert("请选择仓库！");
	 return;
	}
		if(list.length==0){
				alert("请至少选择一个商品！");
				return;
			}
		if($("#cksj").val()==''){
			 $("#time").show();
			 return;
			}else{
			   $("#time").hide();
				}		
	 var plist="";
	 for(var i=0;i<list.length;i++){
		
		 plist+=list[i]+",";
	}
	$("#productlist").val(plist);	
	$("#form2").submit();
}
function cecktime(){

	if($("#cksj").val()==''){
		 $("#time").show();
		 return;
		}else{
		   $("#time").hide();
			}			
}

</script>

	</head>

 <%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 

java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

String str_date1 = formatter.format(currentTime); //将日期时间格式化 
     %>

	<body>
		<div class="bk">
			<form action="addOutbound.do?" method="post" id="form2">
			<div class="bs">
				<div class="bs_t">
					您的位置：
					<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>新增出库</span>
				</div>
			
				<div class="bsy">
					<div class="ck_vew_t">
						<dl>
							<dt>
								出库单号：
							</dt>
							<dd>
							<input type="hidden" value="11" name="newadd"/>
								<input type="text" class="txt_ck" id="CKBum" name="CKBum"
									value="${CKNo }" readonly="readonly" />
							</dd>
							<dt>
								出库时间：
							</dt>
							<dd>
								<input type="text" id="cksj" name="cksj" class="txt_ck" onclick='WdatePicker({dateFmt:"yyyy-MM-dd"})' value="<%=str_date1 %>" onblur="cecktime()"/><span id="time">*<font color="red" style="display: none">请选择时间</font></span>
							</dd>
							<dt>
								仓库位置：
							</dt>
							<dd>
								<input id="dep" name="dep"
								class="txt_ck" onclick="addcg()">
								<input type="hidden" value="" id="depid" name="depid"/>
							</dd>
							<dt>
								出库类型：
							</dt>
							<dd>
								<select name="cklx"
									style="width: 167px; border: solid 1px #b3b3b3;">
									<option value="1">
										上架出库
									</option>
									<option value="2">
										销售出库
									</option>
									<option value="3">
										报损出库
									</option>
									<option value="4">
										盘亏出库
									</option>
									<option value="4">
										借出出库
									</option>
								</select>
							</dd>
							<dt>
								产品数量：
							</dt>
							<dd>
								<input readonly="readonly" type="text" id="cksl" name="cksl" class="txt_ck" />
							</dd>
							<dt>
								产品总价：
							</dt>
							<dd>
								<input readonly="readonly" type="text" id="ckzj" name="ckzj" class="txt_ck" />
							</dd>
							<dt>
								出库备注：
							</dt>
							<p class="ck_bz">
								<textarea class="ck_txt" name="bz">                     
                    </textarea>
							</p>
							<p class="ck_db">
								经办人：<input type="hidden" name="emp" value="${emp.id} "/>
								<span>${emp.name }</span>
							</p>
						</dl>
					</div>
					<%
						int i = 0;
					%>
					<div class="ck_vew_d">
						<div class="ck_vew_dt">
						<input type="hidden" value="" id="productlist"  name="productlist"/>
							<span><input type="button" value="添加一行" onclick="addproduct()" class="hh_button" />
							</span>
							<label>
								条形码：
							</label>
							<input type="text" onclick="addproduct()"/>
								
							<input type="button" class="hh_button" onclick="addproduct()" value="确定添加" />
						</div>
						<div class="ck_vew_trt">
							<div class="ck_vew_tdt_q">
								序列号
							</div>
							<div class="ck_vew_tdt_w">
								产品名称
							</div>
							<div class="ck_vew_tdt_e">
								产品编码
							</div>
							<div class="ck_vew_tdt_r">
								产品型号
							</div>
							<div class="ck_vew_tdt_t">
								单价
							</div>
							<div class="ck_vew_tdt_y">
								数量
							</div>
							<div class="ck_vew_tdt_u">
								操作
							</div>
						</div>
						<div class="ck_vew_tabled" id="addrow0">
							
							</div>
							
						</div>
					</div>
					<div align="center"><br/> <input type="button" onclick="addck()" class="hh_button" value="确定"/></div>
				</div>
			</div>
		</div>
</form>
		<div id="addrow1" class="d2" style="display: none;">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrames" src=""
				style="width: 623px; height: 410px;"></iframe>
		</div>
		<div class="d2" style="display: none;" id="addrow2">
		   <iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrames" src=""
				style="width: 623px; height: 410px;"></iframe>
		</div>
	</body>
</html>
