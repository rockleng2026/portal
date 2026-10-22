<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
		BODY {
			BACKGROUND-COLOR: #ffffff
		}
		.yj{
		    background-color: #eef7fe;
		}
		</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<script type="text/javascript">
	   //显示填写邀请原因的文本框
	   function showText(){
	     var text = document.getElementById("reason");
	     text.style.display="block";
	   }
	   // 领导改变empid
	    function changid(obj){
		 $("#empid").attr("id","emp3");
  	 	 $("#emp").attr("id","emp0");
    	 $("#"+obj.id).attr("id","emp");
 		}
 		// 移交任务还原empid
 		function yjrw(){
 	 		$("#emp3").attr("id","empid");
 	 	}
 		
 		//选择警告级别
 	    function showPic(){
 	      var v= document.getElementById('yj').value;
 	      if(v==1){
 	       $("#pic").html("<img src='<%=request.getContextPath() %>/img/yellow.gif'>");
 	       }
 	      if(v==2){
 	        $("#pic").html("<img src='<%=request.getContextPath() %>/img/red.gif'>");
 	      }
 	      if(v==0){
 	       $("#pic").html("<img src='<%=request.getContextPath() %>/img/green.gif'>");
 	    }
 		}
 		
 		
 		// 修改项目进度条的展示
 		var count=0;
 		function changejd(){
 	 		var num=$("#num").val();
 		  count=parseInt(num)+parseInt(1);		  
		  if(count>=10){
			 $("#num").val(count);
		     $("#zjd").html("");
		     $("#jindu").html("<img src='<%=request.getContextPath()%>/img/finsh.png' title='任务已完成'  width='40px' height='20px' ></img>");
		  }else{
			$("#num").val(count);
		    document.getElementById("jd").style.width=count*10+'%';
		  }
 		}
 		
	
	</script>
	
	<BODY style="background-color: white;">
		<FORM name=form1 action="<%=request.getContextPath() %>/commitMissionPrj.do" method="post">
			<TABLE align="left" cellSpacing=0 cellPadding=0 style="600px" bgColor=#c4d8ed border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" style="height: 30px">
								<TBODY>
									<TR>
										<TD>
											&nbsp;员工任务分配(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
						</TD>
					</TR>
					<tr>
			            <th colspan="2" align="left"><h4 style="color: #3b6492; margin-left: 20px;">员工任务</h4></th>
			        </tr>
					<TR>
						<TD></TD>
						<TD align="center">
					<table  class="toptable grid" cellSpacing=1 cellPadding=4 align="left" border=1 style="width: 600px;text-align: center;margin-top: -130px;">
	         <tr>
	         　　　　<th align="right" width="25%" height=30>项目名称：</th>         
	           <td align="left" width="75%" class=category>               
	               <input type="hidden" name="prjemp.prj.id" value="${prjemp.prj.id}"/>
	               <input type="text" name="prjemp.prj.prjname" value="${prjemp.prj.prjname }" readonly="readonly" />
	            </td>
	
	         </tr>
	         <tr>
	         <th align="right" width="25%" height=30>员工：</th>
	
	           <td align="left" width="75%" height=30 class=category>
	               
	               <input type="text" name="prjemp.employee.name" id="emp" value="${prjemp.employee.name }" readonly="readonly" />
	               <input id="empid" name="prjemp.employee.id" type="hidden" value="${prjemp.employee.id }" />
	               <input type="button" value="任务移交" class="yj" id="" onclick="yjrw(),showText(),completemission('showDialogWarehousing.do?mark=employee','')"><br/>
	               <input type="text" name="" id="reason" style="display: none;color:red" value="请填写原因" onfocus="javascript:this.value=''"/>
	           </td>
	         </tr>
	         <tr>
	         　　　　<th align="right" width="25%" height=30>警告级别：</th>
	           <td align="left" width="75%" height=30 class=category>
	                 <SPAN style="position: relative;top:6px;left:6px;" id="pic">
	                    <c:if test="${prjemp.warn==0}"><img src="<%=request.getContextPath() %>/img/green.gif"></c:if>
	                    <c:if test="${prjemp.warn==1}"><img src="<%=request.getContextPath() %>/img/yellow.gif"></c:if>
	                    <c:if test="${prjemp.warn==2}"><img src="<%=request.getContextPath() %>/img/red.gif"></c:if>
	                 </SPAN>
	           　　　　　　　<select name="prjemp.warn"  id="yj"  class="yj" style="margin-left: -60px;" onchange="showPic()">
			           　　　　　<option value="0" (${prjemp.warn==0}?'selected')>绿</option>
			           　　　　　<option value="1" (${prjemp.warn==1}?'selected')>黄</option>
	                                 　　　　　<option value="2" (${prjemp.warn==2}?'selected')>红</option> 
	           　　　　　　　</select>
	           </td>
	         </tr>
	         <tr>         
	           <th align="right" width="25%" height=30>项目类型：</th>
	           <td align="left" width="75%" height=30 class=category><input type="text" name="prjemp.prj.prjtype" value="${prjemp.prj.prjtype }" readonly="true" /> 
	           </td>
	         </tr>
	         <tr>
	           <th align="right" width="25%" height="30">任务模块</th>
	           <td align="left" width="75%" height="30" class="category">
	             <input type="text" id="" name="prjemp.prjrw" value="${prjemp.prjrw}"/>
	           </td>
	         </tr>
	         <tr>
	         　　　　<th align="right" width="25%">项目进度：<input type="hidden" id="num" name="prjemp.prjempplan" value="${prjemp.prjempplan }"></td></th>
	           <td align="left" width="75%" class=category id="jindu">
	             <div id="zjd" style="width: 100px;height:15px; border:1px solid #3b6492; " >              
	               <div id="jd" style="width:${prjemp.prjempplan*10}%;height:15px; background-image: url('<%=request.getContextPath()%>/img/jindutiao.jpg');" >
	               </div>
	             </div>
	             <img  id="jiahao" alt="点击增加进度" title="点击增加进度" src="<%=request.getContextPath() %>/img/jiahao2.png" width="18" height="17" style="cursor: pointer;" onclick="changejd()"/>
	            
	           </td>
	           
	         </tr>
	         <tr>
	          <th align="right" width="25%">开始时间：</th>
	           <td align="left" width="75%" class=category><input type="text" name="prjemp.prjbegintime" onclick="WdatePicker()" value="${prjemp.prjbegintime }" />
	           </td>
	         </tr>
	         <tr>
	         　　　　<th align="right" width="25%">结束时间：</th>
	           <td align="left" width="75%" class=category>
	               <input type="text" name="prjemp.prjendtime"  onclick="WdatePicker()" value="${prjemp.prjendtime }"/>
	           </td>  
	         </tr>
	         <tr>
	          <th align="right" width="25%">预计结束时间：</th>
	           <td align="left" width="75%" class=category><input type="text" name="prjemp.prjyjendtime" onclick="WdatePicker()" value="${prjemp.prjyjendtime }" />
	           </td>
	         </tr>
	         <tr>
	         　　　　<th align="right" width="25%">监督领导：</th>
	           <td align="left" width="75%" class=category><input type="text" name="prjemp.leadname" id="emp2" onclick="changid(this),completemission('showDialogWarehousing.do?mark=prjemp','')"　value="${prjemp.leadname }" /></td>
	          
	         </tr>
	         <tr>
	          <th align="right" width="25%">领导评价：</th>
	           <td align="left" width="75%" class=category><textarea name="prjemp.leadevaluate" rows="3" cols="30">${prjemp.leadevaluate }</textarea> </td>
	         </tr>
	         <tr>
	         　　　　<th align="right" width="25%">任务描述：</th>
	           <td align="left" colspan="" width="75%" class=category><textarea name="prjemp.jobdes" rows="3" cols="30">${prjemp.jobdes }</textarea> </td>   
	         </tr>
	         <tr>
	            <td colspan="2" align="center" width="100%">
	               <input type="submit" value="提交" class="yj">
	               <input type="reset" value="重置" class="yj">
	            </td>
	         </tr>
    	  </table> 
							</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
					<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
