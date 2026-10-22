<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<title>无标题文档</title>
<script type="text/javascript" src="<%=basePath%>potal/js/coverComment.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery-1.6.min.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/new.js"></script>
<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/index.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/style.css" />
<script type="text/javascript" src="<%=basePath%>potal/js/options.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/check.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/tuodong.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery.js"></script>
<script type="text/javascript">
  function showfj(){
  
      document.getElementById("scfjc").style.display="block"; 
   
  }
  function delfj(a,id){
  
      $.ajax({
	        type:'post',
	        url:'delfjNewportalCustomer1.do',
	        data:{custidcard:id,delnr:a},
	        success:function(res){
	        location.reload();
	     			
	        	
	        }
	  });
  
  
  
  
  }
   function showfj1(){
  
  
   document.getElementById("scfjc1").style.display="block"; 
  }
  function hidescfj(){
  document.getElementById("scfjc").style.display="none"; 
  // document.getElementById("scfjc1").style.display="none"; 
  }
     function showgz(val){
 
      $("#custid").val(val);
   			 var mouseX = event.clientX;  
			 var mouseY = event.clientY;
			 
	document.getElementById("showgz").style.position="absolute";
	document.getElementById("showgz").style.top=(mouseY-47)+"px";
	
	
	document.getElementById("showgz").style.display="block"; 
     
     }
     function chaxun(){
     filterform.submit();
     
     }
     function addcus(){
              location.href="newportaladdcustomerNewportalCustomer1.do";
          //$("#addorUpdb").load(url);
		 //document.getElementById('addorUpdSuppersb').style.display="block";
     
     }
     
     function updatacustomer(id){
            location.href="updatacustomersNewportalCustomer1.do?customerid="+id;
            //$("#addorUpdb").load(url);
			//document.getElementById('addorUpdSuppersb').style.display="block";
     }
     function seecustomerdetails(id,cusid){
     
              var url="seecustomerdetailsNewportalCustomer1.do?customerid="+id+"&customertypeid="+cusid+"&dept=dept";
           $("#addorUpdb").load(url);
			document.getElementById('addorUpdSuppersb').style.display="block";
     
     }
     function addfollow(){
     var custid=$("#custid").val();
     document.getElementById("showgz").style.display="none"; 
        var url="<%=basePath%>potal/page/customer/addfollow.jsp?custid="+custid;
            $("#addorUpd0").load(url);
			 //showDiv('addorUpdSuppers',1000,6.5,5); 
			 document.getElementById('addorUpdSuppers0').style.display="block";
     }
     function seefollow1(a){
     
     $("#custid").val(a);
     seefollow();
     }
     function seefollow(){
     document.getElementById("showgz").style.display="none"; 
     		var custid=$("#custid").val();
     		var empid=$("#empid").val();
         var url="seefollowNewportalCustomer1.do?custid="+custid+"&empid="+empid;
            $("#addorUpda").load(url);
			 document.getElementById('addorUpdSuppersa').style.display="block";
     
     }
     function addfollow2(){
     var custid=$("#custid").val();
      document.getElementById("showgz").style.display="none"; 
         var url="<%=basePath%>potal/page/customer/addcustomerjj.jsp?custid="+custid;  
       $("#addorUpd0").load(url);
			 document.getElementById('addorUpdSuppers0').style.display="block";
     }
     function seefollow2(){
      document.getElementById("showgz").style.display="none"; 
      	var custid=$("#custid").val();
     		var empid=$("#empid").val();
         var url="customerjjNewportalCustomer1.do?custid="+custid+"&empid="+empid;
        
        $("#addorUpda").load(url);
			 document.getElementById('addorUpdSuppersa').style.display="block";
     }

function removeDiv0(){
 //document.getElementById('addorUpdSuppersa').style.display="none";
//document.getElementById('addorUpdSuppersb').style.display="none";
//	document.getElementById('addorUpdSuppers0').style.display="none";
  var a=$("#pageNo").val();
  var b=$("#customertype").val();
   location.href="deptcustomerlistNewportalCustomer1.do?pageNo="+a+"&customerType2="+b;
}

function plyj(){


var ids="";
if(confirm("确定批量移交所选的客户吗？")==true){
  
      $("input[@type=checkbox][@checked]").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出    		
  	 	ids=ids+$(this).val()+",";
   }); 
   if(ids==""){
   
   alert("至少选择一个客户移交，谢谢！");
   }else{
       var url="<%=basePath%>potal/page/customer/addallcustomerjj.jsp?custid="+ids;  
       $("#addorUpd0").load(url);
			 document.getElementById('addorUpdSuppers0').style.display="block";
			 }
     }
   
    
    
}
  



function delcust(){
if(confirm("确定删除所勾选的意向客户吗？")==true){
  var ids="";
      $("input[@type=checkbox][@checked]").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出 

   		
  	 	ids=ids+$(this).val()+",";
   }); 
    

     $.ajax({
           type:'post',
           url:'delcustNewportalCustomer1.do',
           data:{ids:ids},
           success:function(res){
              location.reload();
           }
        })
        }
        }

    $(function () { 
    
    $('#custname1').keydown(function(e){
if(e.keyCode==13){
   filterform.submit(); //处理事件
}
}); 
$('#custname2').keydown(function(e){
if(e.keyCode==13){
   filterform.submit(); //处理事件
}
}); 

               
    
    		  $(".changecolor1").bind("click", function () { 
               $(".changecolor1").css("background-color","#50a806");
            });
              $(".changecolor2").bind("click", function () { 
               $(".changecolor2").css("background-color","#50a806");
            });
            // 全选 
            $("#btnCheckAll").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", true); 
            }); 
              
            // 全不选 
            $("#btnCheckNone").bind("click", function () { 
                $("[name = ids]:checkbox").attr("checked", false); 
            }); 
  
            // 反选 
            $("#btnCheckReverse").bind("click", function () { 
                $("[name = ids]:checkbox").each(function () { 
                    $(this).attr("checked", !$(this).attr("checked")); 
                }); 
            }); 
  
            // 全不选 
            $("#btnSubmit").bind("click", function () { 
                var result = new Array(); 
                $("[name = ids]:checkbox").each(function () { 
                    if ($(this).is(":checked")) { 
                        result.push($(this).attr("value")); 
                    } 
                }); 
  
                alert(result.join(",")); 
            }); 
        }); 
        
        function changepage(a,b,c){
        if(a!="" && a!=null){
        if(a>b){
        alert("所填页数大于总页数");
        }else{
        location.href="deptcustomerlistNewportalCustomer1.do?pageNo="+a+"&customerType2="+c;
        }
        }
        }
        function cheacka(a){
        
        if(a.checked==true){
         $("[name = ids]:checkbox").attr("checked", true); 
        
        }else{
           $("[name = ids]:checkbox").attr("checked", false); 
        }
        }
        function nextpage(npage,apage,type){
        var npage1=npage+1;
        if(npage+1>apage){
        
        }else{
         location.href="deptcustomerlistNewportalCustomer1.do?pageNo="+npage1+"&customerType2="+type;
        
        }
        
        
        }
    </script> 



</head>

<body style="background-color: white;">




<div class="content">

<div class="middlebox">
<div class="middtop">
<span>您的位置<a class="gray" href="#">：首页></a><a href="#" class="gray">办公桌面></a><a href="#" class="gray">销售管理><a href="#" class="gray">客户档案></a><a href="#" class="orange">客户信息列表</a></span>
<form id="filterform" name="filterform" method="post" action="mycustomerlistNewportalCustomer1.do">
<dl>
<dd>客户姓名</dd>
<dt><input name="name"  id="custname1" type="text" class="textbox" /></dt>
</dl>
<dl>
<dd>&nbsp;</dd>
</dl>
<dl>
<dd>公司名称</dd>
<dt><input type="hidden"  name=customerType2 id="company" value="${customertype }"/><input class="textbox" type="text" id="custname2"  name="company" id="company"/></dt>
</dl>
<p><a href="javascript:chaxun()" onclick="chaxun()" class="inquiry">查询</a>
<a href="javascript:addcus()" class="new" onclick="addcus()">新增</a></p>
</form>
</div>
<style>
a{color: black;text-decoration:none; }
.bg_tb { width:790px; margin:0 auto; border-bottom:2px solid #50a806;}
.yx_kh { width:110px; line-height:25px; text-align:center; color:#fff; background-color:#50a806; font-weight:bold; float:left;}
.zs_kh { width:110px; line-height:25px; text-align:center; color:#000; background-color:#e8e8e8; font-weight:bold; float:left; border-left:2px solid #fff;}
</style>
<div class="text">
<div class="bg_tb">
<c:if test="${customertype==1}">
<ul>
<li class="yx_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=1" class="changecolor1">意向客户</a>
</li>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=2" class="changecolor2">试用客户</a>
</li>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=3" class="changecolor3">正式客户</a></li>
<!-- 
<li class="zs_kh"><a href="mycustomerlistNewportalCustomer1.do?customerType2=4" class="changecolor4">审核客户</a>
</li>
 -->
</ul>
</c:if>
<c:if test="${customertype==2}">
<ul>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=1" class="changecolor1">意向客户</a>
</li>
<li class="yx_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=2" class="changecolor2">试用客户</a>
</li>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=3" class="changecolor3">正式客户</a></li>
<!-- </li>
<li class="zs_kh"><a href="mycustomerlistNewportalCustomer1.do?customerType2=4" class="changecolor4">审核客户</a>
</li>
 -->
</ul>
</c:if>
<c:if test="${customertype==3}">
<ul>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=1" class="changecolor1">意向客户</a>
</li>
<li class="zs_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=2" class="changecolor2">试用客户</a>
</li>
<li class="yx_kh"><a href="deptcustomerlistNewportalCustomer1.do?customerType2=3" class="changecolor3">正式客户</a></li>
<!-- </li>
<li class="zs_kh"><a href="mycustomerlistNewportalCustomer1.do?customerType2=4" class="changecolor4">审核客户</a>
</li>
 -->
</ul>
</c:if>
</div>
<table border="0" align="center"  cellpadding="0" cellspacing="0" class="bk">
  <tr>
    <td width="39" height="26" align="center" class="hbj ybk zbk">选择</td>
    <td width="79" height="26" align="center" class="hbj ybk">客户姓名</td>
    <td width="85" height="26" align="center" class="hbj ybk">客户类型</td>
    <td width="170" height="26" align="center" class="hbj ybk">公司名称</td>
    <td width="84" height="26" align="center" class="hbj ybk">业务人员</td>
    <c:if test="${customertype==1}"><td width="100" height="26" align="center" class="hbj ybk">最近跟踪时间</td></c:if>
    <c:if test="${customertype!=1}"><td width="100" height="26" align="center" class="hbj ybk">移动电话</td></c:if>
    <td width="95" height="26" align="center" class="hbj ybk">建立时间</td>
    <td width="121" height="26" align="center" class="hbj">操作</td>
  </tr>
  <input type="hidden" id="custid"/>
  <%  
  String s=(String)request.getAttribute("customertype");
  session.setAttribute("customerType2",s); %>
  <input type="hidden" id="empid" value="${emp.id }"/>
  <input type="hidden" value="${customertype}" id="customertype"/>
  <input type="hidden" value="${pageNo}" id="pageNo"/> 
  <c:forEach items="${newcustomerlist1}" var="data">
	<tr>
	    <td width="39" height="25" align="center" class="ybk zbk">
	    <input name="ids" type="checkbox" id="ids"  class="check" value="${data.customerId}"/>
	   
        </td>
		<td width="79" height="25" align="center" class="ybk">
			${data.realName}
		</td>
        <c:if test="${data.customerType2==3}">
	    <td width="85" height="25" align="center" class="ybk">
			       正式客户
		</td>
		</c:if>
		<c:if test="${data.customerType2==1}">
	    <td width="85" height="25" align="center" class="ybk">
			       意向客户
		</td>
		</c:if>
		<c:if test="${data.customerType2==2}">
	    <td width="85" height="25" align="center" class="ybk">
			       试用客户
		</td>
		</c:if>
		<c:if test="${data.customerType2==4}">
	    <td width="85" height="25" align="center" class="ybk">
			       审核客户
		</td>
		</c:if>
		
		<td width="170" height="25" align="center" class="ybk">
			${data.customerCompany}
		</td>
		<td width="84" height="25" align="center" class="ybk">
			${data.employee.name}
		</td>
		 
		 <c:set value="1" var="custnum"></c:set>
		 <c:if test="${data.customerType2==1}">
		 <td width="100" height="25" align="center" class="ybk">
		 <c:forEach items="${list1}" var="list1">
		  <c:if test="${data.customerId==list1.customer.customerId}">
		  <c:if test="${custnum<2}">
		  <c:set value="${custnum+1}" var="custnum"></c:set>
			<a href="javascript:seefollow1(${data.customerId})">${list1.date} &nbsp;</a>
			</c:if>
		
		  </c:if>
		 
		 </c:forEach>
		 
		</td>
		 </c:if>
		 	 <c:if test="${data.customerType2!=1}">
		<td width="100" height="25" align="center" class="ybk">
			${data.mobilePhone}
		</td>
		</c:if>
		<td width="95" height="25" align="center" class="ybk">
			${data.date}
		</td>
		<td width="121" height="25" align="center" class="ybk">
					<ul id="jsddm1" class="jsgd" >
					<li></li><li><a href="javascript:seecustomerdetails(${data.customerId},'${data.customerType2}')" >详情</a></li>
					
					<c:if test="${bmqx==1}">	<a href="javascript:updatacustomer(${data.customerId})" >修改</a></c:if>
					<!--<li class="gz">
				
					<a  onclick="showgz(${data.customerId})">跟踪</a>
					
					</li>
					  -->
					</ul>
	    </td>
     </tr>
 
  </c:forEach>
     
 
  <tr>
    <td colspan="8" class="hbj2">&nbsp;</td>
    </tr>
  <tr>
    <td width="45" height="45" align="center"><input name="" type="checkbox" id="CheckAll" value="" onclick="cheacka(this)" class="check"/></td>
    <td width="120" height="45"  ><a href="#" id="btnCheckAll">全选</a> <a href="#" id="btnCheckReverse">反选</a><c:if test="${customertype==1 && bmqx==1}">  <a href="javascript:delcust()">&nbsp;&nbsp;删除</a><a href="javascript:plyj()">&nbsp;&nbsp;批量移交</a></c:if></td>
    <td height="45" colspan="6" align="center" class="foot">[ 共${allline} 条记录    <a href="deptcustomerlistNewportalCustomer1.do?pageNo=1&customerType2=${customertype }">首页</a>    <a href="deptcustomerlistNewportalCustomer1.do?pageNo=${pageNo-1 }&customerType2=${customertype }">上一页</a>   <a href="javascript:nextpage(${pageNo},${gageNoall},${customertype })" >下一页</a>    <a href="deptcustomerlistNewportalCustomer1.do?pageNo=${gageNoall}&customerType2=${customertype }">尾页</a>    页数：${pageNo}/${gageNoall}页     <!--    <input name="" type="text"  class="textbox3"/> 条记录/页   -->     转到  <input name="" type="text"  class="textbox3" value="" onblur="changepage(this.value,${gageNoall},${customertype })"/>        页     打印 ] </td>
    </tr>
</table>
</div>
</div>



</div>
 <div id="showgz" class="aa"  style="display:none;z-index: 10001">
  	<ul class="new_1 dw1">
							<li class="gz"><dl>
					   <dd>客户跟进</dd>
					   <dt><span><a href="javascript:addfollow()" onclick="addfollow()" >&nbsp;&nbsp;新增</a></span><span><a href="javascript:seefollow()" onclick="seefollow()" >&nbsp;&nbsp;查看</a></span></dt>
					   </dl>
					   <dl>
					   <dd>客户交接</dd>
					   <dt><span><a href="javascript:addfollow2()" onclick="addfollow2()" >&nbsp;&nbsp;新增</a></span><span><a href="javascript:seefollow2()" onclick="seefollow2()" >&nbsp;&nbsp;查看</a></span></dt>
					   </dl>
					   
				</li>
						</ul>
  </div>


<!-- 弹出层 -->
<style type="text/css">
.aa{
position:absolute;
z-index:10001;
left:5%;
}
.d{
width:800px;
height:930px;
z-index:10001;
display:none;
background-color:#c2c2c2;
ilter: alpha(opacity=45); opacity:0.45; position:absolute;top:0px;left:0px; 
}
html { overflow-x:hidden; }
.d1{
width:452px;
position:absolute;
background-color:white;
z-index:20000;
left:25%;
}
.d2{
width:624px;
position:absolute;
background-color:white;
z-index:20000;
left:10%;
top:5%;
}
.d3{
width:800px;
position:absolute;
background-color:white;
z-index:20000;
left:0%;
}
</style>
			<div class="d"  id="addorUpdSuppers0">
			   <div  class="d1" id="addorUpd0"></div>
			</div>
			<div class="d"  id="addorUpdSuppersa">
			   <div  class="d2" id="addorUpda"></div>
			</div>
			<div class="d"  id="addorUpdSuppersb">
			   <div  class="d3" id="addorUpdb"></div>
			</div>
  
			<div class="d" id="addorUpdSuppers">
			   <div  class="d1" id="addorUpd"></div>
			</div>
		    <div id="addorUpdSuppers2">
			   <div id="addorUpd2"></div>
			</div>
</body>
</html>
