<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Messagereceiver"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>项目邀请消息</title>
    <jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <script type="text/javascript">
  //点击同意
	  function agree(obj){
	    var pid=obj.name;
	   $.post('agreenewProject.do',{'messpid':pid},function(result){
	         if(result=="SUCCESS"){
	           alert("成功!");
	           window.location.href="<%=request.getContextPath()%>/showMessagenewProject.do";
	         }
	         if(result=="ERROR"){
	           alert("失败!");
	           window.location.href="<%=request.getContextPath()%>/showMessagenewProject.do";
	         }
	     });
	  }
	  
	  //点击拒绝
	  function unagree(obj){
		 
	    var pid=obj.name;
	    $.post('<%=request.getContextPath()%>/unagreenewProject.do',{'messpid2':pid},
	    function(result){
	       if(result=="SUCCESS"){
	         alert("您已成功拒绝了该项目的邀请!");
	         window.location.href="<%=request.getContextPath()%>/showMessagenewProject.do";
	       }
	       if(result=="ERROR"){
	         alert("拒绝失败!");
	         window.location.href="<%=request.getContextPath()%>/showMessagenewProject.do";
	       }
	    });
	  }
	  //下载附件
		function projectInfo(id,id2){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id+"&projectstatus="+id2;
		}
		
		//新需求,点击办理,弹出层,列出当前登录人所在部门的所有员工
		  function banli(){
		     $.post('getempByzgnewProject.do',{},function(data){
		          if(data!=null && data!=""){
		             $("#tab3").html(data);
		             $("#cyemp").show();
		          }else{
		            $("#tab3").html("");
		            $("#cyemp").show();
		          }
		          
		       });
		  }
		  
		  
		  var empid = "";
		  function checkdata(obj){
		     var eid = obj.id;
		     if(obj.checked==true){
		       empid += eid+",";
		     }else if(obj.checked==false){
		       empid=empid.replace(eid+",","");
		     }else{}
		     $("#empid").attr("value",empid);
		  }
		  
		  function closecyemp(){
		    $("#cyemp").hide();
		  }
		  
		  function addcyr(){
		    var empid =$("#empid").val();
		    var projectid =$("#projectid").val();
		    $.post('addcyrnewProject.do',{'empid':empid,'projectid':projectid},function(result){
		      alert("SUCCESS");
		    });
		  }
		  
	</script>
  <body onload="setdivwidth();">
    <table id="youshuju" style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle">
      <tr>
        <td colspan="9" align="left">当前位置:新项目管理>>我的项目消息</td>
      </tr>
      <tr>
        <th>消息编号</th>
        <th>所属项目</th>
        <th>发送类型</th>
        <th>消息标题</th>
        <th>发布时间</th>
        <th>内容</th>
        <th>读取状态</th>
        <th>操作</th>
      </tr>
      
      <% 
           List messlist=(List)request.getAttribute("recordlist");
           for(int i=0;i<messlist.size();i++){
              Messagereceiver rec=(Messagereceiver)messlist.get(i);
      %>
      <tr>
        <td>
       
        <%=rec.getMessage().getMessageid() %>
        </td>
        <td>
        <input type="hidden" id="projectid" value="<%=rec.getProject().getId() %>"/>
			<a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('<%=rec.getProject().getId() %>','<%=rec.getProject().getProjectstatus() %>')">
			  <%=rec.getProject().getProjectname() %>
			</a>
		</td>

        <td>员工消息</td>
        <td>
           <%=rec.getMessage().getTitleweb() %>
        </td>
        <td>
           <%
              SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              Timestamp releasettime = rec.getMessage().getReleasetime();
              String time = sdf.format(releasettime); 
            %>
           <%=time %>
        </td>
        <td align="left" style="word-break:break-all;word-wrap:break-word">
        <%=rec.getMessage().getMessagecontent() %>
         
        </td>        
        <td>
           <% if(rec.getReadfalg().equals("0")){%>未读取<%} %>
           <% if(rec.getReadfalg().equals("1")){%>已读取<%} %>
        </td>
        <td>
            <input type="hidden" id="empid"/>
            <input type="button" name="<%=rec.getProject().getId() %>" id="agree" onclick="agree(this)" value="接受"/>
            <input type="button" name="<%=rec.getProject().getId() %>" id="unagree" onclick="unagree(this)" value="拒绝"/>
        </td>
      </tr>
     
      <% }%>
       <tr>
		<td id="page" colspan="8" align="center"><p:pages url="showMessagenewProject.do?&funid=14" /></td>
	  </tr>
    </table>
    
    <!-- 主管分配人员 -->
    <div id="cyemp" style="position: absolute;left: 700px;top: 80px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:left;font-weight:bold;">选择员工列表</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:closecyemp();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab3" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
     
     <div style="position:absolute;top:250px;left:0px;display: block;">
       <input type="button" value="确定" onclick="addcyr()"/>
     </div>
   </div>
   
   </div>
   
   
  </body>
</html>
