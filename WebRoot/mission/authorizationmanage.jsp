<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
	String path = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>

<html>
  <head>
    <title>授权管理</title>
    <jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js1.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
		
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
		//alert(money);
		var empid=$("#selectempid").val();
		//alert(typeid+"?"+deptid+"?"+money);
		var explain = encodeURI($("#remark").val());
		var tt = new Date().getTime();
		var url = "getAuthorization2emp.do?tt="+tt;
		$.get(url,{
		   deptid:deptid,
		   typeid:typeid,
		   empid:empid,
		   money:money,
		   explain:explain
		},function(data){
		    if(data == 0){
			    alert("添加业务成功");
				var url2= "getAuthorizationmissiontype.do?deptid="+deptid+"&tt="+tt;
				$("#postionDiv").load(url2);
			}else if(data==1){
				alert("修改业务成功");
				var url3 = "getAuthorizationmissiontype.do?deptid="+deptid+"&tt="+tt;
				$("#postionDiv").load(url3);
			}else{
				alert("操作错误!");
			}
			
		});
		}
		function checkmoney(){
		  var money11=($("#money").val());
		  var money22=($("#money2").val());
		  if(parseInt(money11)>parseInt(money22)){
		  $("#money").val(money22);
		  }
		}
		
		function updataOperationTo(typeid,typename,empname,empid,money,explain){
	    $("#money").val(money);
	    $("#remark").val(explain);
	    $("#type").append("<option value='"+typeid+"' selected>"+typename+"</option>");	
	    $("#selectempid").append("<option value='"+empid+"' selected>"+empname+"</option>");	
		}
		
		function delOperationDepartTo(empid,typeid,temp){
		if(confirm("确定删除该业务")){
		        var url="delOperationTOemp.do?empid="+empid+"&typeid="+typeid+"&temp="+temp;
		        $.get(url,{
				   empid:empid,
				   typeid:typeid,
				   temp:temp
		        },function(data){
		                    if(data==0){
		                    alert("操作成功");
		                    var tt = new Date().getTime();
							var url2 = "getAuthorizationmissiontype.do?deptid="+temp+"&tt="+tt;
							$("#postionDiv").load(url2);
		                   }
		        
		        });
		}
		
		}
		
		function checkdata(){
		      var typeid=$("#type").val();
		      if(typeid==-1){
		      alert("请选择业务类型");
		      return false;
		      }   
		      var empid=$("#selectempid").val();
		      if(empid==-1){
		      alert("请选择员工");
		      return false;
		      } 
		      var explains=$("#remark").val();
		      if(explains==""){
		      alert("请选择业务说明");
		      return false;
		      }
		      addOpera();
		}
		
   </script>
  </head>
  
<body onload="setdivwidth();">
	  <form  onsubmit="return checkjd()"   method="POST">
	  <table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="2" class="tableStyle" id="youshuju" >
	      <tr>
	      <td align="center">序号</td>
	      <td align="center">授权部门</td>
	      <td align="center">被授权员工</td>
	      <td align="center">业务类型</td>
	      <td align="center">录入审核额度</td>
	      <td align="center">操作</td>
	      </tr>
	      <c:forEach items="${DepartToEmplist}" var="data" varStatus="count">
	      <tr>
	      <td align="center">${count.count}</td>
	      <td align="center">${deptname}</td>
	      <td align="center">${data.employee.name}</td>
	      <td align="center">${data.type.name}</td>
	      <td align="center">${data.money}</td>
	      <td align="center"><a href="javascript:updataOperationTo('${data.type.id}','${data.type.name}','${data.employee.name}','${data.employee.id}','${data.money}','${data.explain}')">修改</a>&nbsp;&nbsp;<a href="javascript:delOperationDepartTo(${data.employee.id},${data.type.id},${data.temp});">删除</a></td>
	      </tr>
	      </c:forEach>
      </table>
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr>
			   <td>当前部门:</td>
			   <td align="left"><input type="text" value="${deptname}" readonly="readonly"  name="deptname"/>
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
		      <td align="left">选择员工:</td>
		      <td align="left">
		        <select name="selectemp" id="selectempid">
		          <option value="-1" style="width: 150px">请选择</option>
		          <c:forEach items="${employeelist}" var="data">
		            <option value="${data.id}" style="width: 150px">${data.name}</option>
		          </c:forEach>
		        </select>
		      </td>
		    </tr>    
			<tr>
			   <td>录入审核额度:</td>
			   <td align="left">
			       <input type="text" name="money" id="money" style="width: 135px;"  value="0" onkeyup="shuzi('money')" onblur="checkmoney();" /><span style="color: red;">不填则为0--最大上限额度：<c:if test="${oper!=null}">${oper.money}<input type="hidden" name="money2" id="money2" value="${oper.money}"/></c:if><c:if test="${oper==null}">部门没有录入金额</c:if></span>
			   </td>
			</tr>
			<tr>
			  <td>业务说明：</td>
			  <td align="left">
			     <textarea cols="40" rows="8" id="remark" name="explain"></textarea>
			  </td>
			</tr>
			
			<tr>
			   <td align="center" colspan="2">
			      <button onclick="checkdata();" ><span class="icon_save">保存</span></button>
			   </td>
			</tr>
		</table>
      </form>
       
	
	
	</body>
</html>
