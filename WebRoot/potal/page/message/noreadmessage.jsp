<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Messagereceiver"%>
<%@page import="com.fuao.fajxc.utilinterface.PublicMissionType"%>
<%@page import="com.fuao.fajxc.bussiness.message.MessageBussiness"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.Scheduleplan"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
MessageBussiness messageBussiness=(MessageBussiness)request.getAttribute("messageBussiness");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<style type="text/css">
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:12px; font-weight:bold; text-decoration:none}
.dow_nr{width:725px; border:1px solid #455c32;  float:left; color:black;}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF;height: 26px;}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#5da500; }
.ahovestyle{ color:red; }
.tc_rightb{border-right:1px solid #c3c3c3;}
#dow_nr a{clor:black;}
/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;} 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.tab ul li { width:90px; line-height:25px; float:left;text-align:center; background-color:#E8E8E8; margin-left:2px;}
.tab ul  .active{ background-color:#4FA805; color:white; font-size:12px; }
.tab div{ clear:both; border-top:1px solid #4FA805; }
<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:22px; font-size:12px;width:60px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{color:#4FA805; line-height:25px; font-size:12px;height:25px;
text-align:center;cursor:hand;margin:3px; width:100%;}
 a{text-decoration: none;}
.msgshow_green .c2{background:url(images/c2.png) no-repeat 100px 0px; height:11px; position:relative; margin-bottom:-1px;  z-index:1; }
.size{ font-size:12px;}
 .dvr{ float:right; margin-right:5px;}
 a{text-decoration: none;}
.borderstyle{
   border:1px solid #ccc;
   width:400px; height:60px;
}
</style>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="<%=path %>/potal/js/newPortalworkLogJs.js"></script>
<script type="text/javascript">
 //勾选所有要删除项
function CheckA(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall')
	    	e.checked = form.chkall.checked; 
	  }
}
// 读取操作
function dq(){
	var count=$("input[type=checkbox][name=ids][checked]").length;
	if(count<=0){
		alert("请选择消息！");
		return false;
	}
	form2.action="updateMessageStatemessage.do";
}
function back(obj){
    $("#fb"+obj.name).show();
}
function hide(obj){
    $("#fb"+obj.name).hide();
}
// 发表回复
function fbmessage(id){
	var content=encodeURI($("#content"+id).val(),"utf-8");
	 $.ajax({
		  type: "post",
		  url: "replymessage.do",
		  data: {
			  "id":id,
			  "content":content
			  },
		  success: function(data){
				  if(data=="0"){
				  	alert("回复成功！");
					$("#fb"+id).hide();
				  }else{
					alert("回复失败！");
				  }
	      }
     });
}
</script>
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;消息模块&gt;<span class="wzcs">未读消息</span>

<div class="dow_nr">
 <form id="form2" name=form2 action="" method="post" onsubmit="return dq();">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">   
    <tr>
      <td  width="10%" align="center" class="tc_top tc_rightb">消息类型</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">消息标题</td>
      <td  width="50%" align="center" class="tc_top tc_rightb">消息内容</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">操作</td>
      <td  width="10%" align="center" class="tc_top tc_rightb">读取</td>
    </tr>
    <%
      Pages pages=(Pages)request.getAttribute("pagemess");
      if(pages!=null && pages.getPageList()!=null && pages.getPageList().size()<=0){
    %>
		<tr><td align="center" colspan="5" class="tc_rightb">暂无未读消息............</td></tr>
    <%} %>
	<%if(pages!=null && pages.getPageList()!=null){ 	   
	     List messlist=pages.getPageList();
	     for(int i=0;i<messlist.size();i++){
	       Messagereceiver receiver=(Messagereceiver)messlist.get(i);	
	  %>
	    <tr>
	      <td class="tc_footb tc_rightb" align="center"><%=receiver.getMessage().getMessagetypeByMessagetype().getType() %></td>
	      <td class="tc_footb tc_rightb" align="left">
	          <% 
	             // 得到发送当前消息人的上级领导，如果是日志消息并且是上级领导的时候则可从这直接看日志详情并添加批注
	             int empid=Integer.parseInt(receiver.getMessage().getSender());
	             Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
	             Employee nowemp = (Employee) request.getSession().getAttribute("emp");
	             if(emp.getDepartment().getEmployee()==null){
	            	 emp.getDepartment().setEmployee(emp);
	             }
	          if(receiver.getMessage().getMessagetypeByMessagetype().getMessagetypeid().equals(PublicMissionType.typeid) && !emp.getDepartment().getEmployee().getId().equals(nowemp.getId())){ %>
	                                               投诉建议
	          <%}else if(receiver.getMessage().getMessagetypeByMessagetype().getMessagetypeid().equals(PublicMissionType.typeid) && emp.getDepartment().getEmployee().getId().equals(nowemp.getId())){ %>
	              <a href="<%=receiver.getMessage().getTitleweb() %>">查看详情</a>
	          <%}else if(receiver.getMessage().getMessagetypeByMessagetype().getMessagetypeid().equals(PublicMissionType.plantype)){
	        	  Scheduleplan plan=null;
	        	  if(receiver.getPlanid()!=null){
			          int planid=receiver.getPlanid();
			          plan=(Scheduleplan)messageBussiness.getEmp(Scheduleplan.class,planid);
	        	  }
	        	  if(plan!=null && plan.getEmployee().getDepartment().getEmployee().getId().equals(nowemp.getId())){
	          %>
	          	  <a href="<%=receiver.getMessage().getTmp3() %>"><%=receiver.getMessage().getTitleweb() %></a>
	          <%}}else{ %>
	             <%=receiver.getMessage().getTitleweb() %>
	          <%} %>&nbsp;
	      </td>
	      <td class="tc_footb tc_rightb" align="left"  style="word-break:break-all;word-wrap:break-word">
	          <%=receiver.getMessage().getMessagecontent() %><br/>
	          <table style="display: none;" width="100%" border="0" cellspacing="0" cellpadding="0" id="fb<%=receiver.getReceiverid() %>">
			          <tr>
			            <td>
			              <table>
			              <tr><td align="center">
			                <textarea id="content<%=receiver.getReceiverid() %>" class="borderstyle" style="overflow:auto;"></textarea></td>
			              </tr>
			              <tr>
			                <td align="right">
			                   <input type="button" name="<%=receiver.getReceiverid() %>" value="取消" style="border:1px solid #70ba10;" onclick="hide(this)" />
			                   <input type="button" value="发表" style="border:1px solid #70ba10;" onclick="fbmessage(<%=receiver.getReceiverid() %>)"/>
			                </td>
			             </tr>
			              </table>  
			            </td>
			          </tr>
			  </table>
	      </td>
	      <td class="tc_footb tc_rightb" align="center">
	         <a href="javascript:void();" name="<%=receiver.getReceiverid() %>"  onclick="back(this)">回复</a>&nbsp;
	         <a href="<%=path %>/historymessage.do?messageid=<%=receiver.getMessage().getMessageid() %>">消息记录</a>
	      </td>
		  <td class="tc_footb tc_rightb" align="center"><input type="checkbox" name="ids" value="<%=receiver.getReceiverid() %>" /></td>
		</tr>
		<%} %>
	<tr>
	   <td id="pageNo" colspan="5">
	       <p:pages url="noreadMessagemessage.do?funid=14" />&nbsp;&nbsp;
	       <span style="float:right;">
		        <input id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
												onclick="CheckA(this.form)" type=checkbox value=select name=chkall />全选/反选&nbsp;
			    <input type="submit" class="gb_bt"  value="读取">
		    </span>
	   </td>
	</tr>
	  <%} %>
  </table>
</form>
</div>
</div>
