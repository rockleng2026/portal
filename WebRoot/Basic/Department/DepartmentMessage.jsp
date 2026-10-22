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
		<title>部门菜单-JSTREE</title>
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
	</head>
	<body>
	<div>
	<p>
		<a href="javascript: d.openAll();">打开 all</a> |
		<a href="javascript: d.closeAll();" >关闭 all</a>
	</p>
	
	<script type="text/javascript">
	        var d = new dTree('d','<%=path%>/dtree/skins/default','','/img/tree'); 
	        d.add(0,-1,'top','','Pictures I\'ve taken over the years','_blank','<%=path%>/dtree/skins/default/img/tree/base.gif','<%=path%>/dtree/skins/default/img/tree/folderopen.gif','<%=path%>/dtree/skins/default/img/tree/imgfolder.gif');
		    <c:forEach items="${deptlist}" var="data">
		  	 d.add('${data.id}','${data.parentId}','${data.name} &nbsp;&nbsp;&nbsp;&nbsp;${data.depNo} &nbsp;&nbsp;&nbsp;&nbsp;<a href="showDepartment.do?id=${data.id}&mark=new">添加</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="showDepartment.do?id=${data.id}&mark=edit">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick=\"deldept(\'${data.id}\',\'deljlDepartment.do\',\'getAllstatisticsDepartment.do?funid=116\')" >删除</a>&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0);\" onclick=\"showbox(${data.id})\" >管理职位</a>','Deptemp.do?deptid=${data.id}','点击跳转到部门员工页面','right','','',false);
		   </c:forEach> 
			document.write(d);
	</script>
	</div>
	<div id="floatDiv">
<script type="text/javascript">
function showbox(id){
	    alert(id);
		$("#TB_overlayBG").css({
			display:"block",height:$(document).height()
		});
		$(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		});
		var tt = (new Date()).getTime();
		    var url = "getDeptPosition.do?deptid="+id+"&tt="+tt;
			$("#postionDiv").load(url);
	} 
$(function(){
	
	
	$(".close").click(function(){
		$("#TB_overlayBG").css("display","none");
		$(".box ").css("display","none");
	});
	$(".submitclick").click(function(){
	   if(addValidators2('form0')){
	   	var content  = $("#content0").val();
	   	if( content == null || content == ''){
	   		alert("请填写工作概述!");
	   		return false;
	   	}
	   	//alert(content);
	   	var reg=new RegExp("<br />","g"); 
	   	content = content.replace(reg,"\r\n");
	   	$("#workcontent0").val(content);
	   	//
	   	//var url = "xx.do?tt"+(new Date().getTime());
	   	//$.post(url,{},function(data){});
	   	 $("#form0").submit();
	   }
	});
});
</script>
<p><style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
a{color:#5e5e5e;text-decoration:none;}
a:hover{color:#3366cc;text-decoration:underline;}
/* box */
.box{position:absolute;width:468px;left:50%;height:auto;z-index:100;background-color:#fff;border:1px #8FA4F5 solid;padding:1px;}
.box h2{height:25px;font-size:14px;background-color:#3366cc;position:relative;padding-left:10px;line-height:25px;color:#fff;}
.box h2 a{position:absolute;right:5px;font-size:12px;color:#fff;}
.box .mainlist{padding:10px;}
.box .mainlist li{height:24px;line-height:24px;}
.box .mainlist li span{margin:0 5px 0 0;font-family:"宋体";font-size:12px;font-weight:400;color:#ddd;}
#TB_overlayBG{background-color:#666;position:absolute;z-index:99;left:0;top:0;display:none;width:100%;height:100%;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
</style></p>
<div id="TB_overlayBG">&nbsp;</div>
<div style="display:none" class="box">
<h2>职位管理<a class="close" href="#">关闭</a></h2>
<div class="mainlist" id="postionDiv">

</div>
<div>
</div>
</div>
</div>
	
	<script type="text/javascript">
		function loadUrl(id){
		    alert(id);
			var tt = (new Date()).getTime();
		    var url = "getDeptPosition.do?deptid="+id+"&tt="+tt;
			$("#postionDiv").load(url);
			$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    $(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		   });
		}
	</script>
	</body>
</html>