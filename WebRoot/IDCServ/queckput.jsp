<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'queckput.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body{margin:0 auto; }
	dl,dd,dt,p{padding:0px; margin:0px;}
	.on{width:100%;margin-left:10%;background-position:center; background:url(<%=basePath%>IDCServ/image/onbj.jpg) no-repeat; height:36px; position:relative;margin-top:20px;}
	.on span{float:left; font-size:12px; font-weight:bold;color: #ffffff}
	.on_1{position:relative; left:20px; top:12px;}
	.on_2{position:relative; left:100px; top:12px;}
	.on_3{position:relative; left:170px; top:12px;}
	.on_4{position:relative; left:255px; top:12px;}
	.on_5{position:relative; left:340px; top:12px;}
	.box{width:96%; float:left; border:2px solid #e1e1e1; padding:0px 2% 0 2%; margin-top:10px;}
	.top{width:100%;margin-left:30%;margin-top:20px; height:30px; line-height:30px;  font-size:14px; font-weight:bold;}
    .lines{
		border-bottom:1px solid #e2e3de;width:100%;
		}
	.bottom{width:100%; float:left}
	.bottom dl{width:100%; float:left; line-height:30px; font-weight:bold; font-size:12px}
	.bottom dd{width:20%; float:left; }
	.bottom dt{width:80%; float:left;}
	.bottom dt span{color:#f8a53f}
	.bottom dt p{float:left; height:22px; font-size:12px; color:#404040; font-weight:normal; line-height:22px; border:1px solid #ffcc7f; background:url(<%=basePath%>IDCServ/image/deng.jpg) no-repeat 2px 3px; padding-left:20px; padding-right:20px;}
	.bottom dt p a{color:#3366cc; font-size:12px; text-decoration:none}
	#companys {
        display: inline;	
        float: left;
	}
     #companys input{
        border:1px solid #e1e1e1;
	}
	#contents{
	    margin-left:30px;
        display: inline;
        float: left;	
	}
    #contents input{
        border:1px solid #e1e1e1;	
	}
	</style>
	</head>
	<body>
	<jsp:include page="head.jsp"></jsp:include>
	<div class="on">
	<span class="on_1">1.业务订单</span>
	<span class="on_2">2.订单确认</span>
	<span class="on_3">3.付款页面</span>
	<span class="on_4">4.配送</span>
	<span class="on_5">5.等待上架</span>
	</div>
	<div class="box">
	<div class="top">
	<div id="companys">
	          输入物流公司:<input type="text" value="顺丰快递" />
	</div>  
	<div id="contents">
	          输入运单号码:<input type="text" value="121545115454"/>
	</div>  
	<input type="button" style=" margin-left:15px;border: 2px; background-image: url(<%=basePath%>IDCServ/image/sels.jpg);width:39px;height:20px;"/>
	</div>
	<div class="lines"></div>
	<div class="bottom">
	<dl>
	<dd>物流跟踪:</dd>
	<dt>2012-12-14 21:22:28 快件入仓</dt>
	</dl>
	<dl>
	<dd>&nbsp;</dd>
	<dt>2012-12-14 21:22:28 快件入仓</dt>
	</dl>
	<dl>
	<dd>&nbsp;</dd>
	<dt>2012-12-14 21:22:28 快件入仓</dt>
	</dl>
	<dl>
	<dd>&nbsp;</dd>
	<dt><span>2012-12-29 15:25:36 派件成功</span></dt>
	</dl>
	<dl>
	<dd>&nbsp;</dd>
	<dt><p>以上信息由物流公司提供，如无跟踪信息或有疑问，请查询<a href="#">顺丰速运</a>官方网站或联系其公示电话</p></dt>
	</dl>
	</div>
	</div>
		<div class="Detailed_B" style="float:right;margin-right: 60px;">
			<a id="btnSave" href="" ><img src="<%=path %>/IDCServ/image/confim.gif"/></a>
	</div>
	<jsp:include page="bottom.jsp"></jsp:include>
	</body>
	</html>
