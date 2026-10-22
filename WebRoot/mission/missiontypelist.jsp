<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>任务类型菜单-JSTREE</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.js"></script>
		<script type="text/javascript" src="<%=path%>/dtree/dtree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<link rel="stylesheet" type="text/css"	href="<%=path%>/dtree/dtree.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/validators.js"></script>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	</head>
<body>
	<p>
		<a href="javascript: d.openAll(),t.openAll();">打开 all</a> |
		<a href="javascript: d.closeAll(),t.closeAll();" >关闭 all</a>
	</p>
	<div id="ld" style="width: 500px; display: none;">
		<span>
			父级：<span id="fj"> <input type="text" id="" name="" value=""></span> 
			<span id="zj">添加子级：<input type="text" id="child" value=""> </span>
			<button type="button" onclick="addtype()" ><span class="icon_save">保存</span></button>
		</span>
	</div>
	<script type="text/javascript">
		var d = new dTree('d','<%=path%>/dtree/skins/default','','/img/tree');
		var t = new dTree('t','<%=path%>/dtree/skins/default','','/img/tree');
		 <c:forEach items="${missiontypelist}" var="data">
		    <c:if test="${data.id==1 || data.id==2}">		   
		    	d.add('${data.id}','${data.superid}','${data.name}  <a href="javascript:void(0);" name="${data.name}" id="${data.id}" onclick="addNode(this,0,0)"><img src=<%=path%>/icons/add.gif></img>添加</a>','','','right','','',false);
		    </c:if>
		    <c:if test="${data.id!=1 || data.id!=2}">
		  	    d.add('${data.id}','${data.superid}','${data.name}  <a href="javascript:void(0);" name="${data.name}" id="${data.id}" onclick="addNode(this,0,0)"><img src=<%=path%>/icons/add.gif></img>添加</a>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" name="${data.name}" id="${data.id}" onclick="addNode(this,0,1)"><img src=<%=path%>/icons/edit.gif></img>修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:del(${data.id},0);"><img src=<%=path%>/icons/delete.gif></img>删除</a>','getMissionmissiontype.do?mid=${data.id}','','right','','',false);
		  	</c:if> 
		  	<c:if test="${data.id==3}">
			  	<c:forEach items="${deptlist}" var="dept">
			  	t.add('${dept.id}','${dept.parentId}','${dept.name} <a href="javascript:void(0);" name="${dept.name}" id="${dept.id}" onclick="addNode(this,1,0)"><img src=<%=path%>/icons/add.gif></img>添加</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:void(0);" name="${dept.name}" id="${dept.id}" onclick="addNode(this,1,1)"><img src=<%=path%>/icons/edit.gif></img>修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:del(${dept.id},1);"><img src=<%=path%>/icons/delete.gif></img>删除</a>','Deptemp.do?deptid=${dept.id}','点击跳转到部门员工页面','right','','',false);
			   </c:forEach> 
				document.write(t);
			</c:if>
		 </c:forEach> 
			document.write(d);
			// flag 是判断传过来的是添加部门还是添加别的，flag标识部门是１，其它是０。isadd判断是点击的是添加还是修改0添加，1修改
			function addNode(obj,flag,isadd){
				var name=obj.name;
				$("#child").val("");// 清空子级
				$("#ld").show();
				$("#fj input").attr("id",obj.id);
				$("#"+obj.id).attr("name",flag); //flag标识部门是１，其它是０.
				$("#"+obj.id).val(name);
				if(isadd==0){
					$("#zj").show();
					$("#"+obj.id).attr("readonly","readonly");
				}
				if(isadd==1){
					$("#zj").hide();
					$("#"+obj.id).attr("readonly","");
				}
			}

			// ajax 请求到missionaction里
			function addtype(){
				var superid= $("#fj input").attr("id");// 父类id
				var child=$("#child").val(); // 得到子级
				var supername=$("#fj input").val();//父类名称
				var flag=$("#fj input").attr("name");
				window.location.href="<%=path%>/addTypemissiontype.do?superid="+superid+"&child="+child+"&supername="+supername+"&flag="+flag+"";
			}

			// 删除节点,flag判断是类型还是部门。1部门，0类型
			function del(id,flag){
			   if(confirm("确实要删除吗?")){
				   window.location.href="<%=path%>/delTypemissiontype.do?id="+id+"&flag="+flag+"";
		       }else{
		       }
			}
	</script>
	
</body>
</html>

