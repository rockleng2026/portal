<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 对比页面 </title>
<style type="text/css">
<style>

body{

	font-family:"Courier New", Courier, monospace;

	margin:0px;

	letter-spacing:0.3px;

	text-align:center;

	font-size:10px;

}



#head{

	height:40px;width:100%;

	background:#b2d2f7;

	text-align:left;

	border-bottom:#3575e4  solid 2px;
}



#middle{

	height:100%;

	width:100%;
	
	margin-bottom:20px;
}

a{
text-decoration:none;
}

#tb 

{

	width:100%;height:100%;

    border-collapse: collapse;

  }

th{ border: 1px solid 
#999;width:17%; text-align:center;

font-weight:1000;}

td{border: 1px solid #999;;width:28%;text-align:center; }

li{ list-style:none;}


</style>

</head>



<body>

	<div id="head" >
			<lable style="margin-left:15px;height:30px; font-size:23px; text-align:center; width:100px; line-height:30px;font-weight:2000;">日志对比</lable>
	</div>

    <div id="middle">

    	<table id="tb"  cellpadding="8" >

			<tr>

				<td colspan="4" height="10" style=" border:0;" >&nbsp;</td>

            </tr>

        	<tr>

            	<td colspan="4" style="text-align:left;font-weight:1000; font-size:18px; background:#d5e7fb;height:25px;margin-left:20px; border-bottom:#99b4f0 solid 2px;">&nbsp;&nbsp;&nbsp;日志的基本信息</td>

            </tr>

            <tr>

            	<th>日志序号 </th>

                <td> ${workLog1.id}</td>

                <td>${workLog2.id}</td>

                <td>${workLog3.id}</td>

          <!--      <td>${workLog4.id}</td>-->

            </tr>
			<tr>

            	<th> 员工名称 </th>

                <td>${workLog1.employeeByEmpId.name}</td>

                <td>${workLog2.employeeByEmpId.name}</td>

                <td>${workLog3.employeeByEmpId.name}</td>

              <!--   <td>${workLog4.employeeByEmpId.name}</td>-->

            </tr>
            
            <tr>

            	<th> 日志添加时间  </th>

                <td>${workLog1.recordTime}</td>

                <td>${workLog2.recordTime}</td>

                <td>${workLog3.recordTime}</td>

            <!--     <td>${workLog4.recordTime}</td>-->

            </tr>
			
            <tr>

            	<th>日志类型</th>
				
                <td>
	                <c:if test="${workLog1.type == 0}">工作日志</c:if>
					<c:if test="${workLog1.type == 1}">工作周志</c:if>
					<c:if test="${workLog1.type == 2}">工作月志</c:if>
				</td>

                <td>
	                <c:if test="${workLog2.type == 0}">工作日志</c:if>
					<c:if test="${workLog2.type == 1}">工作周志</c:if>
					<c:if test="${workLog2.type == 2}">工作月志</c:if>
				</td>

                <td>
	                <c:if test="${workLog3.type == 0}">工作日志</c:if>
					<c:if test="${workLog3.type == 1}">工作周志</c:if>
					<c:if test="${workLog3.type == 2}">工作月志</c:if>
				</td>

            <!--    <td>
	                <c:if test="${workLog4.type == 0}">工作日志</c:if>
					<c:if test="${workLog4.type == 1}">工作周志</c:if>
					<c:if test="${workLog4.type == 2}">工作月志</c:if>
				</td>-->

            </tr>


			           <tr>
					<th> 工作一</th>
					<td>
					 <c:if test="${logSign11!=null}">
						<table style="font-size:12px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign11.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign11.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign11.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					<td>
					 <c:if test="${logSign21!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign21.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign21.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign21.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					 <td>
					 <c:if test="${logSign31!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign31.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign31.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign31.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
            </tr>
                     <tr>
					<th> 工作二</th>
					<td>
						 <c:if test="${logSign12!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign12.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign12.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign12.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					<td>
					 <c:if test="${logSign22!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign22.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign22.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign22.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					 <td>
					 <c:if test="${logSign32!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign32.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign32.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign32.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
            </tr>
                     <tr>
					<th> 工作三 </th>
					<td>
					<c:if test="${logSign13!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign13.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign13.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign13.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					<td>
					<c:if test="${logSign23!=null}">
					<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign23.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign23.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign23.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					 <td>
					  <c:if test="${logSign33!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign33.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign33.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign33.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
            </tr>
                          <tr>
					<th> 工作四</th>
					<td>
					 <c:if test="${logSign14!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign14.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign14.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign14.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					<td>
					 <c:if test="${logSign24!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign24.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign24.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign24.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					 <td>
					 <c:if test="${logSign34!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign34.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign34.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign34.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
            </tr>
                        <tr>
					<th> 工作五 </th>
					
					<td>
					<c:if test="${logSign15!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign15.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign15.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign15.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					<td>
						<c:if test="${logSign25!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign25.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign25.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign25.content}</td>
							</tr>
						</table>
						</c:if>
					 </td>
					 <td>
					 <c:if test="${logSign35!=null}">
						<table style="font-size:13px; border:0px;">
							<tr style="border:0px;">
								<th style="border:0px;">开始时间:</td>
								<td style="border:0px;">${logSign35.beginTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">结束时间:</td>
								<td style="border:0px;">${logSign35.endTime}</td>
							</tr>
							<tr style="border:0px;">
								<th style="border:0px;">工作内容:</th>
								<td style="border:0px;">${logSign35.content}</td>
							</tr>
						</table>
					 </td>
					 </c:if>
            </tr>
            <tr>

            	<th style="height:200px;"> 个人总结 </th>

                 <td style="font-size:14px;"><!--  <textarea rows="6" cols="20" id="content">
                	
               </textarea>-->${workLog1.workresult}</td>

                <td>
                		${workLog2.workresult}
              </td>

                <td>
                		${workLog3.workresult}
                </td>

                <!--      <td><textarea rows="6" cols="20" id="content">
                	${workLog4.workresult}
                </textarea></td>-->

            </tr>
<%--
            <tr>

                <td colspan="4"  style=" border:0;">&nbsp;</td>

            </tr>

            <tr>

                    <td colspan="4" style="text-align:left;font-weight:1000; font-size:18px; background:#d5e7fb;height:27px;margin-left:40px; border-bottom:#99b4f0 solid 2px;">&nbsp;&nbsp;&nbsp; 批阅信息 </td>

            </tr>

            <tr>

            	<th>批阅日志员工</th>

                <td>${workLog1.employeeByReplier.name}</td>

                <td>${workLog2.employeeByReplier.name}</td>

                <td>${workLog3.employeeByReplier.name}</td>

               <!--   <td>${workLog4.employeeByReplier.name}</td>-->

            </tr>

            <tr>

            	<th>批注时间</th>

                <td>${workLog1.replyTime}</td>

                <td>${workLog2.replyTime}</td>

                <td>${workLog3.replyTime}</td>

               <!--  <td>${workLog4.replyTime}</td> -->

            </tr>

            <tr>

            	<th style="height:40px;">批阅内容</th>

                <td>${workLog1.replyContent}</td>

                <td>${workLog2.replyContent}</td>

                <td>${workLog3.replyContent}</td>
                
               <!--   <td>${workLog4.replyContent}</td> -->

            </tr> --%>
			<tr style=" height:50px;">
				<td colspan="4"  style="border:0px; font-size:15px;">
					<p:pages url="contrastWorkLog.do"/>
				</td>
			</tr>
        </table>
   </div>
	
	  <div style="position:absolute;right:20px;top:8px;z-index:999px; width:50px;height:40px;">
	  	<a href="selectOtherWorkLog.do" style="width:100%;height:100%;text-align:center; line-height:40px;"> 返回 </a>
	  </div>	
</body>
</html>