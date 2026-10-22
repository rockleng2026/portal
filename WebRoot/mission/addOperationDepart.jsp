<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.vo.Scheduleplan"%>
<%@page import="com.fuao.fajxc.vo.Taskplan_saleorder"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
	String path = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>

<html>
  <head>
    <title>部门业务审核</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
    <jsp:include page="/common/inc_js1.jsp" flush="true" ></jsp:include>
    <jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
	
	 function checkData(){
  
     var typeid= $("#type").val();
     if(typeid==-1){
      alert("请选择类型");
       return false;
     }
     
         var money1 = $("#money1").val();
     if(money1==""){
        alert("请填写一月份额度!");
        return false;
     }
      
        var money2 = $("#money2").val();
     if( money2==""){
        alert("请填写二月份额度!");
        return false;
     }
          var money3 = $("#money3").val();
     if( money3==""){
        alert("请填写三月份额度!");
        return false;
     }
          var money4 = $("#money4").val();
     if(money4==""){
        alert("请填写四月份额度!");
        return false;
     }
          var money5 = $("#money5").val();
     if(money5==""){
        alert("请填写五月份额度!");
        return false;
     }
          var money6 = $("#money6").val();
     if(money6==""){
        alert("请填写六月份额度!");
        return false;
     }
          var money7 = $("#money7").val();
     if(money7==""){
        alert("请填写七月份额度!");
        return false;
     }
          var money8 = $("#money8").val();
     if(money8==""){
        alert("请填写八月份额度!");
        return false;
     }
          var money9 = $("#money9").val();
     if(money9==""){
        alert("请填写九月份额度!");
        return false;
     }
          var money10 = $("#money10").val();
     if(money10==""){
        alert("请填写十月份额度!");
        return false;
     }
          var money11 = $("#money11").val();
     if(money11==""){
        alert("请填写十一月份额度!");
        return false;
     }
          var money12 = $("#money12").val();
     if( money12==""){
        alert("请填写十二月份额度!");
        return false;
     }
          var jd1 = $("#jd1").val();
     if( jd1==""){
        alert("请填写第一季度额度!");
        return false;
     }
     var jd11=parseInt(jd1); 
     if(jd11<=parseInt(money1)||jd11<=parseInt(money2)||jd11<=parseInt(money3)||jd11<=parseInt(money4)||jd11<=parseInt(money5)||jd11<=parseInt(money6)||jd11<=parseInt(money7)||jd11<=parseInt(money8)||jd11<=parseInt(money9)||jd11<=parseInt(money10)||jd11<=parseInt(money11)||jd11<=parseInt(money12)){
        alert("第一季度额度不能小于月额度");
        return false;
     }
          var jd2= $("#jd2").val();
     if(jd2==""){
        alert("请填写第二季度额度!");
        return false;
     }
          var jd22=parseInt(jd2); 
     if(jd22<=parseInt(money1)||jd22<=parseInt(money2)||jd22<=parseInt(money3)||jd22<=parseInt(money4)||jd22<=parseInt(money5)||jd22<=parseInt(money6)||jd22<=parseInt(money7)||jd22<=parseInt(money8)||jd22<=parseInt(money9)||jd22<=parseInt(money10)||jd22<=parseInt(money11)||jd22<=parseInt(money12)){
        alert("第二季度额度不能小于月额度");
        return false;
     }
     
          var jd3 = $("#jd3").val();
     if(jd3==""){
        alert("请填写第三季度额度!");
        return false;
     }
          var jd33=parseInt(jd3); 
     if(jd33<=parseInt(money1)||jd33<=parseInt(money2)||jd33<=parseInt(money3)||jd33<=parseInt(money4)||jd33<=parseInt(money5)||jd33<=parseInt(money6)||jd33<=parseInt(money7)||jd33<=parseInt(money8)||jd33<=parseInt(money9)||jd33<=parseInt(money10)||jd33<=parseInt(money11)||jd33<=parseInt(money12)){
        alert("第三季度额度不能小于月额度");
        return false;
     }
     
          var jd4 = $("#jd4").val();
     if(jd4==""){
        alert("请填写第四季度额度!");
        return false;
     }
      var jd44=parseInt(jd4); 
     if(jd44<=parseInt(money1)||jd44<=parseInt(money2)||jd44<=parseInt(money3)||jd44<=parseInt(money4)||jd44<=parseInt(money5)||jd44<=parseInt(money6)||jd44<=parseInt(money7)||jd44<=parseInt(money8)||jd44<=parseInt(money9)||jd44<=parseInt(money10)||jd44<=parseInt(money11)||jd44<=parseInt(money12)){
        alert("第四季度额度不能小于月额度");
        return false;
     }
     
          var sbn = $("#sbn").val();
     if(sbn==""){
        alert("请填写上半年额度!");
        return false;
     }
      var sbn1=parseInt(sbn); 
     if(sbn1<=parseInt(money1)||sbn1<=parseInt(money2)||sbn1<=parseInt(money3)||sbn1<=parseInt(money4)||sbn1<=parseInt(money5)||sbn1<=parseInt(money6)||sbn1<=parseInt(money7)||sbn1<=parseInt(money8)||sbn1<=parseInt(money9)||sbn1<=parseInt(money10)||sbn1<=parseInt(money11)||sbn1<=parseInt(money12)||sbn1<=parseInt(jd1)||sbn1<=parseInt(jd2)||sbn1<=parseInt(jd3)||sbn1<=parseInt(jd4)){
        alert("上半年额度不能小于月、季度额度");
        return false;
     }
          var xbn= $("#xbn").val();
     if(xbn==""){
        alert("请填写下半年额度!");
        return false;
     }
      var xbn1=parseInt(xbn); 
     if(xbn1<=parseInt(money1)||xbn1<=parseInt(money2)||xbn1<=parseInt(money3)||xbn1<=parseInt(money4)||xbn1<=parseInt(money5)||xbn1<=parseInt(money6)||xbn1<=parseInt(money7)||xbn1<=parseInt(money8)||xbn1<=parseInt(money9)||xbn1<=parseInt(money10)||xbn1<=parseInt(money11)||xbn1<=parseInt(money12)||xbn1<=parseInt(jd1)||xbn1<=parseInt(jd2)||xbn1<=parseInt(jd3)||xbn1<=parseInt(jd4)){
        alert("下半年额度不能小于月、季度额度");
        return false;
     }
     
          var year = $("#year").val();
     if(year==""){
        alert("请填写全年审核额度!");
        return false;
     }
     var year1=parseInt(year); 
     if(year1<=parseInt(money1)||year1<=parseInt(money2)||year1<=parseInt(money3)||year1<=parseInt(money4)||year1<=parseInt(money5)||year1<=parseInt(money6)||year1<=parseInt(money7)||year1<=parseInt(money8)||year1<=parseInt(money9)||year1<=parseInt(money10)||year1<=parseInt(money11)||year1<=parseInt(money12)||year1<=parseInt(jd1)||year1<=parseInt(jd2)||year1<=parseInt(jd3)||year1<=parseInt(jd4)||year1<=parseInt(sbn)||year1<=parseInt(xbn)){
        alert("全年额度不能小于月、季度、上下半年额度");
        return false;
     }
          var remark=$("#remark").val();
     if(remark==""){
     alert("请填写业务说明");
     return false;
     }
     addOpera();
     
   }
	
	
	
		
		// 判断输入的只能是数字
		function shuzi(inputname){
			var zhi=document.all(inputname).value;
				if(zhi.length>0 && isNaN(zhi)==true){
				document.all(inputname).value=zhi.substring(0,zhi.length-1);
				shuzi(inputname);
				}
		}
		
		function addOpera(){
		var deptid = $("#dept").val();
		var typeid = $("#type").val();
		var money=$("#money").val();
		var money1=$("#money1").val();
		var money2=$("#money2").val();
		var money3=$("#money3").val();
		var money4=$("#money4").val();
		var money5=$("#money5").val();
		var money6=$("#money6").val();
		var money7=$("#money7").val();
		var money8=$("#money8").val();
		var money9=$("#money9").val();
		var money10=$("#money10").val();
		var money11=$("#money11").val();
		var money12=$("#money12").val();
		var jd1=$("#jd1").val();
		var jd2=$("#jd2").val();
		var jd3=$("#jd3").val();
		var jd4=$("#jd4").val();
		var sbn=$("#sbn").val();
		var xbn=$("#xbn").val();
		var year=$("#year").val();
		//alert(typeid+"?"+deptid+"?"+money);
		var explain = encodeURI($("#remark").val());
		var tt = new Date().getTime();
		var url = "addOperation2missiontype.do?tt="+tt;
		$.get(url,{
		   deptid:deptid,
		   typeid:typeid,
		   money:money,
		   explain:explain,
		   money1:money1,
		   money2:money2,
		   money3:money3,
		   money4:money4,		  
		   money5:money5,
		   money6:money6,
		   money7:money7,
		   money8:money8,
		   money9:money9,
		   money10:money10,
		   money11:money11,
		   money12:money12,
		   jd1:jd1,
		   jd2:jd2,
		   jd3:jd3,
		   jd4:jd4,
		   sbn:sbn,
		   xbn:xbn,
		   year:year
		},function(data){
			if(data == 0){
			    alert("添加部门业务成功");
				var url2 = "addOperationmissiontype.do?deptid="+deptid+"&tt="+tt;
				$("#postionDiv").load(url2);
			}else if(data==1){
				alert("修改部门业务成功");
				var url3 = "addOperationmissiontype.do?deptid="+deptid+"&tt="+tt;
				$("#postionDiv").load(url3);
			}else{
				alert("操作错误!");
			}
			
		});
		}
		function updataOperation(typeid,typename,money,explain,id,temp){
	    $("#money").val(money);
	    $("#remark").val(explain);
	    $("#type").append("<option value='"+typeid+"' selected>"+typename+"</option>");	
	    var tt = new Date().getTime();
	    var url="getAuditlinesmissiontype.do";	
	    $.get(url,{
	               tt:tt,
				   id:id,
				   temp:temp
		        },function(data){
		        var a = new Array(); 
		        a=data.split(",");
		        $("#money1").val(a[0]);
		        $("#money2").val(a[1]);
		        $("#money3").val(a[2]);
		        $("#money4").val(a[3]);
		        $("#money5").val(a[4]);
		        $("#money6").val(a[5]);
		        $("#money7").val(a[6]);
		        $("#money8").val(a[7]);
		        $("#money9").val(a[8]);
		        $("#money10").val(a[9]);
		        $("#money11").val(a[10]);
		        $("#money12").val(a[11]);
		        $("#jd1").val(a[12]);
		        $("#jd2").val(a[13]);
		        $("#jd3").val(a[14]);
		        $("#jd4").val(a[15]);
		        $("#sbn").val(a[16]);
		        $("#xbn").val(a[17]);
		        $("#year").val(a[18]);
		        });
	    
		}
		

		function delOperationDepart(typeid,depid){
		if(confirm("确定删除该业务")){
		        var url="delOperationmissiontype.do?deptid="+depid+"&typeid="+typeid;
		        $.post(url,{
				   deptid:depid,
				   typeid:typeid
		        },function(data){
		                    if(data==0){
		                    alert("操作成功");
		                    var tt = new Date().getTime();
							var url2 = "addOperationmissiontype.do?deptid="+depid+"&tt="+tt;
							$("#postionDiv").load(url2);
		                   }
		        
		        });
		}
		
		}
   </script>
  </head>
  
<body onload="setdivwidth();">
      <table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle" id="youshuju" >
      <tr>
      <td align="center">序号</td>
      <td align="center">部门名称</td>
      <td align="center">业务类型</td>
      <td align="center">单次审核额度</td>
      <td align="center">操作</td>
      </tr>
      <c:forEach items="${operationDepartmentlist}" var="data" varStatus="count">
      <tr>
      <td align="center">${count.count}</td>
      <td align="center">${deptname}</td>
      <td align="center">${data.type.name}</td>
      <td align="center">${data.money}</td>
      <td align="center"><a href="javascript:updataOperation('${data.type.id}','${data.type.name}','${data.money}','${data.explain}',${data.id },1)">修改</a>&nbsp;&nbsp;<a href="javascript:delOperationDepart(${data.type.id},${data.dept.id})">删除</a></td>
      </tr>
      </c:forEach>
      </table>
      <form action="" method="get" name="form1" id="form1">
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle" id="youshuju" >
			<tr>
			   <td align="left">当前部门:</td>
			   <td align="left"><input type="text" value="${deptname}" readonly="readonly"  name="deptname" id="OperationDepart"/>
			    <input type="hidden" name="deptid" id="dept" value="${deptid }"/>
			   </td>
			</tr>
			<tr>
		      <td align="left">选择业务类型:</td>
		      <td align="left">
		        <select name="typeid" id="type">
		          <option value="-1" style="width: 150px">请选择</option>
		          <c:forEach items="${missiontypelist}" var="data">
		            <option value="${data.id}" style="width: 150px">${data.name}</option>
		          </c:forEach>
		        </select>
		      </td>
		    </tr>  
			<tr>
			   <td>单次审核额度:</td>
			   <td align="left">
			       <input type="text" name="money" id="money" style="width: 135px;"  value="0" onkeyup="shuzi('money')"  /><span style="color: red;">不填则为0</span>
			   </td>
			</tr>
			<tr>
			   <td align="left">月审核额度：</td>
			   <td>
			       <table  style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle" id="youshuju" >
			           <tr>
			              <td>1月<input type="text" name="money1" id="money1" onkeyup="shuzi('money1')" style="width: 50px;" /></td>
			              <td>2月<input type="text" name="money2" id="money2"  onkeyup="shuzi('money2')" style="width: 50px;" /></td>
			              <td>3月<input type="text" name="money3" id="money3"  onkeyup="shuzi('money3')" style="width: 50px;" /></td>
			              <td>4月<input type="text" name="money4" id="money4"  onkeyup="shuzi('money4')" style="width: 50px;" /></td>
			           </tr>
			           <tr>
			              <td>5月<input type="text" name="money5" id="money5"   onkeyup="shuzi('money5')" style="width: 50px;" /></td>
			              <td>6月<input type="text" name="money6" id="money6"  onkeyup="shuzi('money6')" style="width: 50px;" /></td>
			              <td>7月<input type="text" name="money7" id="money7"  onkeyup="shuzi('money7')" style="width: 50px;" /></td>
			              <td>8月<input type="text" name="money8" id="money8"  onkeyup="shuzi('money8')" style="width: 50px;" /></td>
			           </tr>
			           <tr>
			              <td>9月<input type="text" name="money9" id="money9"  onkeyup="shuzi('money9')" style="width: 50px;" /></td>
			              <td>10月<input type="text" name="money10" id="money10"  onkeyup="shuzi('money10')" style="width: 50px;" /></td>
			              <td>11月<input type="text" name="money11" id="money11"  onkeyup="shuzi('money11')" style="width: 50px;" /></td>
			              <td>12月<input type="text" name="money12" id="money12"  onkeyup="shuzi('money12')" style="width: 50px;" /></td>
			           </tr>
			       </table>
			   </td>
			</tr>
			<tr>
			   <td align="left">季审核额度：</td>
			   <td>
			   	  <table  style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			           <tr>
			              <td>(1-3)月:<br/><input type="text" type="text" name="jd1" id="jd1"  onkeyup="shuzi('jd1')"  style="width: 50px;" /></td>
			              <td>(4-6)月:<br/><input type="text" name="jd2" id="jd2"  onkeyup="shuzi('jd2')"  style="width: 50px;" /></td>
			              <td>(7-9)月:<br/><input type="text" name="jd3" id="jd3"  onkeyup="shuzi('jd3')"  style="width: 50px;" /></td>
			              <td>(10-12)月:<br/><input type="text" name="jd4" id="jd4"  onkeyup="shuzi('jd4')"  style="width: 50px;" /></td>
			           </tr>
			       </table>
			   </td>
			</tr>
			<tr>
			   <td align="left">半年审核额度：</td>
			   <td>
			   	  <table  style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			           <tr>
			              <td>上半年(1-6)月：<input type="text" name="sbn" id="sbn"  onkeyup="shuzi('sbn')"  style="width: 50px;" /></td>
			              <td>下半年(7-12)月：<input type="text" name="xbn" id="xbn"  onkeyup="shuzi('xbn')"  style="width: 50px;" /></td>
			           </tr>
			       </table>
			   </td>
			</tr>
			<tr>
			   <td align="left">年度审核额度：</td>
			   <td>
			   	  <input type="text" name="year" id="year"  onkeyup="shuzi('year')"  value="" />
			   </td>
			</tr>
			<tr>
			  <td align="left">业务说明：</td>
			  <td align="left">
			     <textarea cols="40" rows="8" id="remark" name="explain"></textarea>
			  </td>
			</tr>
			
			<tr>
			   <td align="center" colspan="2">
			      <button onclick="checkData()" ><span class="icon_save">保存</span></button>
			   </td>
			</tr>
		</table>
       </form>
	
	
	</body>
</html>
