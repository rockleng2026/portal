<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.Tresourcecheck"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<title>项目问题详情</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
    </head>
    <script type="text/javascript">
  //修改
	function updatequest(obj)
	{
		var questid = obj;
		var url = "updatequestionQuestionProject.do?questids="+questid;
		showWindwoButton('id1','修改问题列表','800','550',url);
	}
<%--  详情	--%>
	function updatequest(obj)
	{
		var rcid = obj;
		var url = "detailRCReCheck.do?rcid="+rcid;
		showWindwoButton('id1','资源核实单详情','800','550',url);
	}
	
	//删除
	function delRC(obj)
	{
		var rcid = obj;
		$.ajax({
			type:"POST",
			url:"delRCReCheck.do",
			data:{
				"rcid":rcid
			},
			success:function(data)
			{
				if(data =="1")
				{
					alert("删除成功!");
					window.location.href="selectReCheck.do";
				}else
				{
					alert("删除问题失败");
				}
			}
		});
	}
	
	
	function uploadstate(obj)
	{
		
	}

	//个人信息
	function Onedetails(obj){
		var questid3 = obj;
		var url = "findByquestionQuestionProject.do?questid3="+questid3;  
		showWindwoButton('id','问题详情','800','550',url);  
	}
	function selectBy()
	{
		var qname = encodeURI($("#empname").val(),"utf-8");
		$("#hidename").val(qname);
		form1.action="<%=path%>/selectReCheck.do";
		form1.submit();
	}
	function changModel()
	{	
		var modelid =$("#models").children('option:selected').val();
		$("#modelid").val(modelid);
	}
    </script>      
<body>
<form action="" method="post" id="form1" name="form1">
<input type="hidden" value="" name="hidename" id="hidename"/>
<input type="hidden" value="" name="modelid" id="modelid">
<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
	<div class="searchDiv"  id="searchDiv" >
	<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0"　class="tableStyle"  cellpadding="0" id="youshuju" >
	    <tr>
	       <th align="left">核查编号：</th>
	       <td>
				<input type="text" id="rvid" name="rvid" value="${rvid}" />
		   </td>
		    <th align="left">申请人：</th>
	       <td>
				<input type="text" id="empname" name="empname" value="${empname}" />
		   </td>
	    
			   <th>资源类型:</th>
			   <td>
					<select id="models" onchange="changModel();">
						<option value="-1">--请选择--</option>
						<c:forEach items="${listModel}" var="lmodel">
							<option value="${lmodel.model}" <c:if test="${lmodel.model ==modelid}">selected</c:if>>${lmodel.name}</option>
						</c:forEach>
					</select>
			   </td>
		</tr>
		<tr class="height24">
			<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
				<button type="button" onclick="selectBy();" ><span class="icon_find">查询</span></button>
				<button  type="button" onclick="resetjsp();"  ><span  class="icon_clear">清空</span></button>
			</td>
		</tr>
	</table>
</div></div>
     <div id="resulthight">
     	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	        <tr>
	           <td colspan="6" align="left">
	            	<h3>资源核查单</h3>
	           </td>
	           <td colspan="1" align="center" >
	           		<a  href="<%=request.getContextPath()%>/addUIReCheck.do">添加</a>
	           </td>
	        </tr>
	    	<tr>
	    		<th>核查编号</th>
	    		<th>申请人</th>
	    		<th>商品名称</th>
	    		<th>地区</th>
	    		<th>仓库</th>
	    		<th>状态</th>
	    		<th>操作</th>
	    	</tr>
	    	<% 
	    		List listRC = (List) request.getAttribute("listRC"); 
		    	if(listRC !=null && listRC.size()>0)
		    	{
		    		for(int i= 0 ; i <listRC.size();i++)
		    		{
		    			Tresourcecheck trc = (Tresourcecheck) listRC.get(i);
	    	%>
	    	<tr align="center">
	    		<td><%=trc.getRvid()%></td>
	    		<td><%=trc.getEmpid().getName()%></td>
	    		<td><%=trc.getSaleGoods().getSgname()%></td>
	    		<td><%=trc.getCity().getName()%></td>
	    		<td><%=trc.getDepot().getName()%></td>
	    		<td>
	    			<%if(trc.getIsstate().equals("0")){ %>
	    				未审批
	    			<%} %>
	    			<%if(trc.getIsstate().equals("1")){ %>
	    				已审批
	    			<%} %>
	    			<%if(trc.getIsstate().equals("2")){ %>
	    				已回复
	    			<%} %>
	    			<%if(trc.getIsstate().equals("3")){ %>
	    				拒绝批
	    			<%} %>
	    		</td>
	    		<td>
	    			<%if(trc.getIsstate().equals("0")){ %>
	    				<a href="updateUIRCReCheck.do?rcid=<%=trc.getId()%>">变更</a>&nbsp;
	    			<%} %>
	    			<a href="detailRCReCheck.do?rcid=<%=trc.getId()%>">详情</a>&nbsp;
	    			<%if(trc.getIsstate().equals("1") && !"".equals(trc.getConent())){ %>
	    				<a href="resultUIRCReCheck.do?rcid=<%=trc.getId()%>">回复</a>&nbsp;
	    			<%} %>
	    			<%if(!("1").equals(trc.getIsstate()) && !("2").equals(trc.getIsstate())){ %>
	    				<a href="#" onclick="delRC('<%=trc.getId()%>');">删除</a>
	    			<%} %>
	    		</td>
	    	</tr>
	    	<%} %>
	    	<tr>
	    		<td id="page" colspan="8" align="center"><p:pages url="selectReCheck.do?funid=14" /></td>
	    	</tr>
	    	
	    	<%} else{%>
	    		<tr>
	    			<td colspan="8" align="center">查无数据</td>
	    		</tr>
			<%} %>
	</table>
	</div>
</form>
	</body>

</html>