<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="x-ua-compatible" content="ie=7" /> 
<style type="text/css">
.box{width:766px; height:442px; background:url(<%=path %>/potal/images/boxbk.jpg) no-repeat;}
.top{width:736px; float:left; height:33px; line-height:33px; font-family:"微软雅黑"; font-size:14px; font-weight:bold; padding-left:30px;
color:#9fe50b}
.top span{color:#FFFFFF; padding-left:15px; background:url(<%=path %>/potal/images/dadian.jpg) no-repeat 4px 7px}
.top a{color:#FFFFFF; text-decoration:none}
.content{width:725px; height:379px;  margin:0 auto; font-size:12px; padding:10px 10px 10px 10px;}
b{font-size:12px; color:#FF0000;}
.biaodan_1{width:418px; height:21px; border:1px solid #e9ecf1; border-top:1px solid #aaadb2}
.biaodan_2{width:418px; height:180px; border:1px solid #e9ecf1; border-top:1px solid #aaadb2; overflow:hidden}
.an{width:53px; height:22px; border:none; background:url(<%=path %>/potal/images/an.jpg) no-repeat}
.blue{background:#f3f7fa}
.searchinput{ border:0px; margin:0px; padding:0px; padding-left: 3px; width: 100px; height:17px;font-family: arial;
	float: left;color: #bebebe;margin-left: 4px; font-size: 8pt; line-height:20px; border:1px solid #e9ecf1; border-top:1px solid #aaadb2}
.searchaction{width: 16px;float: left;height: 18px; background:url(<%=path %>/potal/images/fdj.jpg); border:0px;}
.yui{width:130px; height:20px; border:1px solid #e9ecf1; border-top:1px solid #c3d4e1; background:#f3f7fa; line-height:20px; font-size:12px; margin:0 auto}
.bk1{border:1px solid #e9ecf1}
.topbk{border-top:1px solid #e9ecf1}
rightbk{border-right:1px solid #e9ecf1}
.da{font-size:16px; font-weight:bold; color:#fe5614; padding-left:5px;}
.left{width:560px; height:379px; float:left; margin-top:5px;}
.right{width:150px; float:left; height:360px; margin-left:10px; border:1px solid #e9ecf1; margin-top:5px;}
</style>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript">

function load(){	
	$("#content").load("<%=path%>/noreadMessagemessage.do");	
}
function sendMessage(){
	 $("#content").load("<%=path%>/writelogmessage.do");
}
</script>
<div class="box">
<div id="sendmsg" class="top" style="cursor: pointer;" onclick="sendMessage()">
发送员工消息
<span><a href="#">已发短消息</a></span>
<span><a href="#">已读短信息</a></span>
<span id="noreadmsg"><a href="javascript:load();">未读短信息</a></span>
<span><a href="#">消息草稿箱</a></span>
</div>
<div id="content" class="content">
</div>
</div>
<script type="text/javascript">
   $("#content").load("<%=path%>/writelogmessage.do");
</script>