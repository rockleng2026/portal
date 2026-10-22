<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Messagereceiver"%>
<%@page import="com.fuao.fajxc.bussiness.message.MessageBussiness"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
MessageBussiness messageBussiness=(MessageBussiness)request.getAttribute("messageBussiness");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>收件箱</title>
<SCRIPT type="text/javascript" src="<%=path %>/potal/js/jquery-1.6.min.js"></SCRIPT>
 <link rel="stylesheet" type="text/css" href="<%=path %>/potal/css/commonCss.css"/>
<script src="<%=path %>/potal/js/messageJs.js" type="text/javascript"></script>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
a { text-decoration:none;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
 .msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
  .msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.rz_box{ border-top:2px solid #4FA805;}
.main { width:760px; margin:0 auto;background-color: #fff;}
.yx_bt { line-height:30px; color:#fff; font-size:14px; font-weight:bold; background-color:#295a00;}
.yx_bt span { color:#81f106;}
.yx_bt a { text-decoration:none; color:#fff;}
.y_x { line-height:30px; margin-top:5px; border-top:1px solid #eeb98d;}
.yx_top { background-color:#f4f4f6; border-right:1px solid #c7c8c0; border-bottom:1px solid #c7c8c0;}
.yx_topy { background-color:#f4f4f6; border-bottom:1px solid #c7c8c0;}
.yx_cd { border-bottom:2px solid #e0731e; color:#e1731e; font-size:16px; font-weight:bold; line-height:30px; padding-left:35px;}
.yx_cd span { font-size:12px; font-weight:normal;}
.wd_xx { font-weight:bold;}
.hui{ color:#3b393a; line-height:30px; font-size:12px;}
.hui a{color:#3b393a;}
.hui a:hover{ color:red;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
.yx_xhx { border-bottom:1px solid #e7e7e7;}

</style>
</head>

<body>
<div class="main">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="yx_bt">
  <tr>
    <td width="15%" align="center"><a href="<%=path %>/writelogmessage.do">写消息</a></td>
    <td width="17%" align="center"><a href="<%=path %>/noreadMessagemessage.do"><span>收件箱（${messagecount}）</span></a></td>
    <td width="17%" align="center"><a href="<%=path %>/sendEmailmessage.do">已发送</a></td>
    <td width="17%" align="center"><a href="<%=path %>/delEmailmessage.do">已删除</a></td>
    <td width="17%" align="center"><a href="<%=path %>/caogaoEmailmessage.do">草稿箱</a></td>
    <td width="17%" align="right"><a href="javascript:out()">×</a>&nbsp;&nbsp;</td>
  </tr>
</table>
</div>
<div class="main">
<form id="form2" name=form2 action="" method="post" onsubmit="return dq();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="y_x">
  <tr>
    <td width="10%" align="center" class="yx_top"><label>
      <input type="checkbox" name="checkbox" value="checkbox" />
    </label></td>
    <td width="20%" align="center" class="yx_top">消息类型</td>
    <td width="20%" align="center" class="yx_top">发件人</td>
    <td width="34%" align="center" class="yx_top">主题</td>
    <td width="16%" align="center" class="yx_topy">时间</td>
  </tr>
    <%
       List nowemaillist=(List)request.getAttribute("nowemaillist");
       if(nowemaillist!=null && nowemaillist.size()>0){
    %>
  <tr>
    <td colspan="5" class="yx_cd">今天<span>（<%=nowemaillist.size() %>封）</span></td>
  </tr>
  <%
      // 先遍历出未读的消息
      for(int i=0;i<nowemaillist.size();i++){
    	  Messagereceiver receiver=(Messagereceiver)nowemaillist.get(i);
    	  if(receiver.getReadfalg().equals("0")){
    		  int empid=Integer.parseInt(receiver.getMessage().getSender());
	          Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
  %>
  <tr class="wd_xx over"  id="<%=receiver.getReceiverid() %>">
    <td align="right" class="yx_xhx">
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="50%" align="right"><label>
	          <input type="checkbox"  name="ids"  value="<%=receiver.getReceiverid()%>" />
	        </label></td>
	        <td width="50%"><img src="<%=path %>/potal/images/xtb_xf.jpg" /></td>
	      </tr>
	    </table><label></label>
    </td>
    <td align="center" class="yx_xhx"><%if(receiver.getMessage().getMessagetypeByMessagetype()!=null){%><%=receiver.getMessage().getMessagetypeByMessagetype().getType() %><%}else{ %>部门消息<%} %></td>
    <td align="center" class="yx_xhx"><%=emp.getName() %></td>
    <td class="yx_xhx"><%=receiver.getMessage().getTitleweb() %></td>
    <td align="center" class="yx_xhx"><%=receiver.getMessage().getReleasetime() %></td>
  </tr>
  <%}}
    for(int i=0;i<nowemaillist.size();i++){
    	Messagereceiver receiver=(Messagereceiver)nowemaillist.get(i);	
    	if(receiver.getReadfalg().equals("1")){
    		int empid=Integer.parseInt(receiver.getMessage().getSender());
	        Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
  %>
  <tr class="over" id="<%=receiver.getReceiverid() %>">
    <td align="right" class="yx_xhx">
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="50%" align="right"><label>
	          <input type="checkbox" name="ids"  value="<%=receiver.getReceiverid()%>"/>
	        </label></td>
	        <td width="50%"><img src="<%=path %>/potal/images/xtb_xfy.jpg" /></td>
	      </tr>
	    </table><label></label>
    </td>
    <td align="center" class="yx_xhx"><%if(receiver.getMessage().getMessagetypeByMessagetype()!=null){%><%=receiver.getMessage().getMessagetypeByMessagetype().getType() %><%}else{ %>部门消息<%} %></td>
    <td align="center" class="yx_xhx"><%=emp.getName() %></td>
    <td class="yx_xhx"><%=receiver.getMessage().getTitleweb() %></td>
    <td align="center" class="yx_xhx"><%=receiver.getMessage().getReleasetime() %></td>
  </tr>
  <%}}}else{ %>
   <tr>
      <td colspan="5" class="yx_cd">今天<span>（0封）</span></td>
   </tr>
   <tr class="wd_xx over">
     <td align="center" class="yx_xhx" colspan="5">今天没有邮件信息！</td>
   </tr>
  <%} %>
  <%
  	Pages pagemess=(Pages)request.getAttribute("pages"); 
    if(pagemess!=null && pagemess.getPageList()!=null && pagemess.getPageList().size()>0){
  %>
  <tr>
    <td colspan="5" class="yx_cd">更早<span>（<%=pagemess.getAllCount()%>封）</span></td>
  </tr>
  <%
     // 先遍历出未读消息
     for(int i=0;i<pagemess.getPageList().size();i++){
    	 Messagereceiver receiver=(Messagereceiver)pagemess.getPageList().get(i);
    	 if(receiver.getReadfalg().equals("0")){
    		 int empid=Integer.parseInt(receiver.getMessage().getSender());
	         Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
  %>
  <tr class="wd_xx over"  id="<%=receiver.getReceiverid() %>">
    <td align="right" class="yx_xhx"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50%" align="right"><label>
          <input type="checkbox" name="ids"  value="<%=receiver.getReceiverid()%>" />
        </label></td>
        <td width="50%"><img src="<%=path %>/potal/images/xtb_xf.jpg" alt="xf" /></td>
      </tr>
    </table></td>
   <td align="center" class="yx_xhx"><%if(receiver.getMessage().getMessagetypeByMessagetype()!=null){%><%=receiver.getMessage().getMessagetypeByMessagetype().getType() %><%}else{ %>部门消息<%} %></td>
    <td align="center" class="yx_xhx"><%=emp.getName() %></td>
    <td class="yx_xhx"><%=receiver.getMessage().getTitleweb() %></td>
    <td align="center" class="yx_xhx"><%=receiver.getMessage().getReleasetime() %></td>
  </tr>
  <%}}
    // 遍历已读过的消息
    for(int i=0;i<pagemess.getPageList().size();i++){
    	Messagereceiver receiver=(Messagereceiver)pagemess.getPageList().get(i);
    	if(receiver.getReadfalg().equals("1")){
   		 int empid=Integer.parseInt(receiver.getMessage().getSender());
	     Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
  %>
   <tr class="over" id="<%=receiver.getReceiverid() %>">
    <td align="right" class="yx_xhx">
       <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="50%" align="right"><label>
	          <input type="checkbox" name="ids"  value="<%=receiver.getReceiverid()%>" />
	        </label></td>
	        <td width="50%"><img src="<%=path %>/potal/images/xtb_xfy.jpg" /></td>
	      </tr>
	    </table><label></label>
    </td>
    <td align="center" class="yx_xhx"><%if(receiver.getMessage().getMessagetypeByMessagetype()!=null){%><%=receiver.getMessage().getMessagetypeByMessagetype().getType() %><%}else{ %>部门消息<%} %></td>
    <td align="center" class="yx_xhx"><%=emp.getName() %></td>
    <td class="yx_xhx"><%=receiver.getMessage().getTitleweb() %></td>
    <td align="center" class="yx_xhx"><%=receiver.getMessage().getReleasetime() %></td>
  </tr>
  <%}}}else{ %>
   <tr>
      <td colspan="5" class="yx_cd">更早<span>（0封）</span></td>
   </tr>
   <tr class="wd_xx over">
     <td align="center" class="yx_xhx" colspan="5">没有任何邮件信息！</td>
   </tr>
  <%} %>
  <tr>
    <td colspan="5" align="right">
	    <span style="float:left;">
			        <input id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													onclick="CheckA(this.form)" type=checkbox value=select name=chkall />全选/反选&nbsp;
				    <input type="submit" style="border:1px #ccc solid; background-color:#fff;color:#000;width:30px; height: 20px;"  value="删除">
		</span>
    	<p:pages url="noreadMessagemessage.do?funid=14" />&nbsp;&nbsp;
	    
    </td>
  </tr>
</table>
</form>
</div>
</body>
</html>
