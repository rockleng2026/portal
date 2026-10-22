<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.vo.Scheduleplan"%>
<%@page import="com.fuao.fajxc.vo.Taskplan_saleorder"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
	String path = request.getContextPath();
%>
<%
request.getSession().removeAttribute("abcname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>

<html>
  <head>
    <title>修改任务进度</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
		function nsrmx(){
			window.location.href="<%=path%>/newproject/startproject/a.jsp";
		}
		// 验证
		function checkjd(){
			var jd= $("#jd").val();
			var schedule=$("#schedule").val();
			var zjd=parseInt(jd)+parseInt(schedule);
			var remark=$("#remark").val();
			var temp1=encodeURI(remark,"utf-8");
            $("#temp1").val(temp1);
			if(jd.length<=0){
				$("#jdmsg").html("请输入完成的进度！");
				return false;
			}
			if(zjd>100){
				$("#jd").val(100);
			}
		} 
		function getjd(){
			var jd= $("#jd").val();
			var schedule=$("#schedule").val();
			var num=parseInt(jd);
			var zjd=parseInt(jd)+parseInt(schedule);
			
			if(num<0){
				$("#jd").val(0);
			}
			if(zjd>100){
				var sub=parseInt(100-schedule);
				$("#jd").val(sub);
			
			}
		
		}
		function checknum(){
		    var jd= $("#jd").val();
            var reg = new RegExp("^[0-9]*$");
         if(!reg.test(jd)){
            $("#jd").val(0);
            }
            if(!/^[0-9]*$/.test(jd)){
            $("#jd").val(0);
            }
		}
		function showfj(name){
	        window.location.href="downloadTaskUpload.do?url="+name;
        }

		// 判断输入的只能是数字
		function shuzi(inputname){
			var zhi=document.all(inputname).value;
				if(zhi.length>0 && isNaN(zhi)==true){
				document.all(inputname).value=zhi.substring(0,zhi.length-1);
				shuzi(inputname);
				}
		}
		
		function sel2(){
		    var taskid = $("#saleorder").val();
		    var temp2 = document.getElementById("ethip").options[window.document.getElementById("ethip").selectedIndex].value;
		    if(temp2==-1){
		      return;
		    }
            var url = "<%=path%>/"+temp2+"&taskid="+taskid;
			showWindwoButton('id','','900','550',url);
		}
		
		function saleorderInfo(obj,obj2){
		 //  var temp2 = document.getElementById("ethip").options[window.document.getElementById("ethip").selectedIndex].value;
		 //  alert(temp2);
		   $.post("saleorderInfoTaskProject.do",{'id':obj,'marker':obj2},function(result){
		        var url = result+"&id="+obj;
		        window.location.href = url;
		   });
		}
		
		//关闭子窗体,刷新父窗体
		function reload(){
		  parent.location.reload();
		}
		
		//修改任务进度 13.5.18 14032
	 	function  changejd(){
	 		var oldjd=$("#schedule").val();
        var newjd= $("#newjd").val();
		
        var reg = new RegExp("^[0-9]*$");
        if(newjd==""){
			alert("请填写进度在进行修改！");
			
            }else{
                if(!reg.test(newjd)){//判断是不是数字

					alert("请填写数字格式的进度");
					$("#newjd").val("");
					return;
                    }else if(newjd.length>2){
						if(newjd!="100"){
							alert("完成进度0--100之间");
							 $("#newjd").val("");
							return;
						}
                        }

				$("#jd").val(newjd);
				$("#jd1").text(newjd+"%");
				$("#schedule").val(newjd);
				$("#newjd").val("");
                }
             

		 	}
   </script>
  </head>
  
<body onload="setdivwidth();">
	<table  width="99%" align="center"    border="0" cellspacing="0" cellpadding="0" id="tablesearch" >		
	    <tr>
	    <jsp:include page="/common/loading.jsp"></jsp:include>
	    <td class="result-border" align="center" >
	    <div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
	     <%
		        //得到当前时间
		        java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		        Date now=new Date();
		        String nowstr=dateFormat2.format(now);
		    	List loglist=(List)request.getAttribute("loglist");
		    	NewTask tas=(NewTask)request.getAttribute("task");
		        if(loglist.size()>0){
		   %>
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
		   <tr >
				<th align="left" colspan="7">
				   
					进度日志详情<%=loglist.size() %>篇[<%=tas.getBegintime() %>至<%=nowstr %>]
				</th>
			</tr>
			<tr align="center">
			   <td>任务</td>
			   <td>任务负责人</td>
			   <td>日志标题</td>
			   <td>任务进度</td>
			   <td>日志时间</td>
			   <td>附件</td>
			   <td>操作</td>
			</tr>
			<%
				for(int i=0;i<loglist.size();i++){
					Scheduleplan schel=(Scheduleplan)loglist.get(i);
					
			%>
				<tr align="center">
					<td>
						<%=schel.getTmp() %>
					</td>					
					<td>
						<%=schel.getEmployee().getName() %>
					</td>
					<td>
						<%
							if(schel.getSubjecttitle()==null){
						%>
							无
						<%}else{ %>
							<%=schel.getSubjecttitle() %>
						<%} %>
					</td>
					<td>
						<%=schel.getIsplan() %>%
					</td>
					<td>
						<%
							if(schel.getSubjecttitle()==null){
						%>
							无
						<%}else{ %>
							<%=schel.getBegintime() %>至<%=schel.getEndtime() %>
						<%} %>
						
					</td>
					<!-- 
					<td>
					 <textarea rows="5" cols="5" style="display: none;" id="tsid"><c:forEach items="${ts}" var="ts2">${ts2.saleorderid},</c:forEach></textarea>
					  <c:forEach items="${ts}" var="ts">
					    <a href="javascript:saleorderInfo(${ts.saleorderid},'${ts.flag}')">${ts.saleorderid}</a>,
					  </c:forEach>
					</td>
					 -->
					<td align="left">
					  <a href="javascript:void();" style="text-decoration:none;" title="<%=schel.getTmp1() %>" onclick="showfj('<%=schel.getTmp3() %>')"><%if(schel.getTmp1()!=null){ %> <%=schel.getTmp1().length()>7?schel.getTmp1().substring(0,7)+"...":schel.getTmp1() %><%} %></a>
					</td>
					<td>
						<%
							if(schel.getSubjecttitle()==null && schel.getBegintime().equals(nowstr)){
						%>
							<a href="javascript:void(0)" title=""><font color="red">日志会同步进度</font></a>
						<%} %>
						<%
							if(schel.getSubjecttitle()==null && !schel.getBegintime().equals(nowstr)){
						%>
							这天没写日志
						<%} %>
						<%
							if(schel.getSubjecttitle()!=null ){
						%>
							<a href="<%=path %>/showworklog.do?style=0&schedulId=<%=schel.getId() %>" title="点击查看日志详情">查看详情</a>
						<%} %>
						
					</td>
				</tr>
			<%} %>
			<tr>			
				<td id="page" colspan="7" align="center">
					<pp:pages1 url="handleTaskTaskProject.do" param="taskid=${task.id }&openmethod=1"/>	
				</td>
			</tr>
		</table>
		<%}else{ %>
			暂时没有添加工作日志。。。
		<%} %>
		
		</div>
		 <span><a href="<%=path %>/listnewProject.do" title="点击查看项目列表">我的项目</a> << <a href="<%=path %>/selectTaskProject.do?pid=-2" title="查看任务">任务列表</a> << <a href="<%=path%>/waitapptaskTaskProject.do" title="查看任务审批状态">待批任务</a> << 任务办理</span>
		</td>
		
		<% 
			// 如果进度到了100则不能再对任务进行变更了
			if(tas.getSchedule()<100){ %>
		<td class="result-border" align="center" >
	    <div id="resulthight">
	    <!-- 上传附件 -->
	    <div>
				<jsp:include page="uploadfiles.jsp" flush="true"></jsp:include>
		</div>
	  <form  action="updateJDTaskProject.do" onsubmit="return checkjd()"  enctype="multipart/form-data">
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr >
				<th colspan="2">
					添加任务进度
				</th>
			</tr>
			<tr>
			   <th>当前负责人:</th>
			   <td align="left">${task.emp.name }</td>
			</tr>
			<tr>
			   <th>当前时间:</th>
			   <td align="left"><%=nowstr %></td>
			</tr>
			<tr>
			   <th>完成任务:</th>
			   <td align="left">
			       <input type="hidden" id="${filepaths}" value="${filepaths}" />
			       <input type="hidden" id="saleorder" name="newtask.id" value="${task.id }" />
			       <input type="hidden" id="schedule" value="${task.schedule }" />
			       <input name="newtask.schedule" id="jd" value="${task.schedule }" type="hidden" style="width: 25px;" /><font style="color: red;font-size: 8px" >当前任务进度</font><span id="jd1">${task.schedule}%</span><span style="color: red;" id="jdmsg">*</span>
			       <input type="text" value="" id="newjd" onchange="changejd()" name="newjd" size="50" style="width: 50" /><span>(请填入现完成的进度)</span>
			   </td>
			</tr>
			<tr>
			   <th>任务花费金额:</th>
			   <td align="left">
			       <input type="text" name="newtask.temp"  style="width: 60px;"  value="0" onkeyup="shuzi('newtask.temp')"  /><span style="color: red;">项目不牵涉金额则填0</span>
			   </td>
			</tr>
			<tr>
			  <th>申请金额的原因</th>
			  <td align="left">
			     <textarea cols="10" rows="5" id="remark"></textarea>
			     <input type="hidden" name="newtask.temp1" id="temp1" value="" />
			  </td>
			</tr>
			
			<!-- 项目管理二期工作==>订单类型 -->
		    <tr>
		      <th align="right">订单类型:</th>
		      <td align="left">
		        <select id="ethip" onchange="sel2()">
		          <option value="-1">请选择</option>
		          <c:forEach items="${marklist}" var="mark">
		            <option value="${mark.temp2}">${mark.aname}</option>
		          </c:forEach>
		        </select>
		      </td>
		    </tr>  
			
			<tr>
			   <th align="center" colspan="2">
			      <button type="submit"><span class="icon_save">保存</span></button>
			      <button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
			      <button type="button"  onclick="javascript:history.go(-1)"><span class="icon_back">返回</span></button>
			   </th>
			</tr>
		</table>
      </form>
       
		</div>
		</td>
		<%} %>
		</tr>
	</table>
	
	</body>
</html>
