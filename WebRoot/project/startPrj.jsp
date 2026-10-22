<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/js/check/css/validationEngine.jquery.css"
			type="text/css" />
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/js/check/css/template.css"
			type="text/css" type="text/css" />


		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/handlejson.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/date2.js" charset="GBK">
</script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/cascadingmenu.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js" charset="GBK">
</script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js">
</script>
		<script
			src="<%=request.getContextPath()%>/js/check/js/languages/jquery.validationEngine-zh_TW.js"
			type="text/javascript" charset="GBK">
</script>
		<script
			src="<%=request.getContextPath()%>/js/check/js/jquery.validationEngine.js"
			type="text/javascript" charset="GBK">
</script>
		<LINK href="<%=request.getContextPath()%>/Css/style.css"
			type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<script>
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
		categorylist('depid','${showemp.department.id}','');
		jQuery("#form1").validationEngine('attach', {
			promptPosition : "topLeft"
		});
		
		groupsgrade('position', '${showemp.groups.groupId}', '');
	});
</script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}

.divFJ {
	width: 100%;
	font-size: 12px;
}

.divHang {
	width: 100%;
	height: 30px;
	border-top: 1px #9CF solid;
	border-right: 1px #9CF solid;
}

.divLie {
	width: 18%;
	height: 30px;
	float: left;
	line-height: 25px;
	border-left: 1px #9CF solid;
}

.divLieInput {
	width: 90%;
	margin-top: 5px;
	border: 0px;
}
</STYLE>
		<script type="text/javascript">

/**
 * 等级类型
 * @return
 */
function groupsgrade(objid, editid, url) {
	$.getJSON("getGroupsGradeHandleJson.do", function(data) {
		$.each(data, function(i, item) {
			if (1 == item.superGroupId) {
				if (editid == item.groupId) {
					$("#" + objid).append(
							"<option value='" + item.groupId + "' selected>"
									+ item.groupName + "</option>");
				} else {
					$("#" + objid).append(
							"<option value='" + item.groupId + "'>"
									+ item.groupName + "</option>");
				}
				buildGroupsGrade(1, item.child, objid, editid);
			}
		});
	});
}

function buildGroupsGrade(len, data, objid, editid) {
	var prefix = "|";
	for ( var i = 0; i < len; i++) {
		prefix += "--";
	}
	$.each(data, function(i, item) {
		if (0 < item.child.length) {
			if (editid == item.groupId) {
				$('#' + objid).append(
						"<option value=" + item.groupId + " selected>" + prefix
								+ item.groupName + "</option>");
			} else {
				$('#' + objid).append(
						"<option value=" + item.groupId + ">" + prefix
								+ item.groupName + "</option>");
			}
			buildGroupsGrade(len + 1, item.child, objid, editid);
		}
	});
}

 //清空参与人员
 function qk(){
    $("#receiver").val("");
 }
 function changid(obj){
    $("#emp").attr("id","emp0");
    $("#"+obj.id).attr("id","emp");
 }
 

 
 
 
</script>
		<meta content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js"></script>
		<script language="javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
	</HEAD>
	<BODY>
		<div style="display:none;position: absolute;left: 450px;top: 140px;" id="sub-dept">
        </div>
        
		<form action="/FAJxc/startPrj.do" id="form1" name="form1" method="post" enctype="multipart/form-data">
			
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0 style="table-layout:fixed;Word-wrap:break-word;word-break;break-all;">
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;发起项目:
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="15%" height=30 align=right>
											项目名称：
										</TD>
										<TD width="35%" class=category>
											<INPUT class="validate[required] text-input"
												style="WIDTH: 200px" id="prjname" name="project.prjname"
												value="">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
										</TD>
										<TD width="15%" height=30 align=right>
											项目负责人：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('nation','','nationMsg')"
												style="WIDTH: 200px" id="emp1" name="project.prjmanager"
												value="" onclick="changid(this),completemission('showDialogWarehousing.do?mark=employee','')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="nationMsg"></FONT>
										</TD>
									</TR>
									<tr>
									    <td width="15%" height=30 align=right>发起人</td>
									    <td width="35%" class=category>
									        <input name="project.startperson" value="${emp.name}" style="width: 200px" readonly="readonly"/>
									    </td>
									    <td width="15%" height=30 align=right>项目所属部门：</td>
									    <td width="35%" class=category>
									        <input type="text" value="技术部" id="dept"/> 
									    </td>
									    
									</tr>
									<TR>
										<TD align=right width="15%" height=30>
											项目类型：
										</TD>
										<TD width="35%" class=category>
											<INPUT
												onblur="isokCard()"
												style="WIDTH: 200px" id="cardid" name="project.prjtype"
												value="">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="cardidMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											开始时间：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('health','','healthMsg')"
												style="WIDTH: 200px" id="" name="project.begintime"
												value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" readonly="true">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="healthMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											结束时间：
										</TD>
										<TD width="35%" class=category>
											<INPUT class="validate[required] text-input"
												style="WIDTH: 200px" id="endtime" name="project.endtime"
												value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" readonly="true">
										</TD>
										<TD align=right width="15%" height=30>
											预计结束时间：
										</TD>
										<TD width="35%" class=category>
											<INPUT
												onblur="checkValueByRules('stature',['float'],'statureMsg')"
												style="WIDTH: 200px" id="" name="project.yjendtime"
												value="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" readonly="true">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="statureMsg"></FONT>
										</TD>
									</TR>
									
									<TR id="leaveRowShow">
										<TD align=right width="50%" height=30>
											参与人员:
										</TD>
										<TD width="100%">
										  <input type="hidden" name="cyr" id="ryid" value="">
										  <input type="text" name="people" id="receiver" style="width: 200px" readonly="true"/>    <input type="button"  onclick="qk()" value="清空"/>
										</TD>
										<TD align=right width="15%" height=30>
											监督领导名称：
										</TD>
										<TD width="25%" class=category>
											<input type="text" name="project.leadname" id="emp2" onclick="changid(this),completemission('showDialogWarehousing.do?mark=prjemp','')" style="width: 200px"/>
										</TD>
									</TR>
									<TR>
									<TD align=right width="15%">
											项目功能：
										</TD>
										<TD width="35%" align=left class=category>
											<textarea cols="50" id="specialty" name="project.prjfunction"
												rows="7" value=""></textarea>
										</TD>
										
										<TD align=right width="15%">
											项目描述：
										</TD>
										<TD width="35%" align=left class=category>
											<textarea cols="50" id="specialty" name="project.prjdes"
												rows="7" value=""></textarea>
										</TD>
									</TR>
									<tr>
									<td width="50">
									  <s:file name="upload" label="文件上传" size="20"/>
									</td>
									</tr>
									
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<br>
						</TD>
					</TR>
				
				</TBODY>
				<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
			</TABLE>
			<div id="fmarkdiv">
			</div>
			
				<div class="divFJ"
			style="text-align: center; margin-top: 5px; margin-bottom: 5px; border: 1px #9CF solid;">
			<div style="width: 100%; line-height: 25px; height: 30px;">
					<input type="submit" value="确认添加 "
						style="width: 100px; margin-top: 3px;"/>
			
				      
				<input type=reset value=" 重  置"
					style="width: 100px; margin-top: 3px;" />
			</div>
		</div>
		
		</form>
        
		 <script type="text/javascript">
		   $("#sub-dept").load("alldeptmessageDepartment.do");
		   $(function(){
		      $("#receiver").click(function(){
		          $("#sub-dept").show();
		      });
		       $("#specialty,#lend,#endtime").click(function(){
		          $("#sub-dept").hide();
		      });
		   })
		 </script>
		
        
	
		</div>
		<div id="dialog" title="错误信息提示">
			<p></p>
		</div>

		<script type="text/javascript">
function leaveRow() {
	e = event.srcElement;
	if (e.value == 1) {//zaizhi
		document.getElementById("leaveRowShow").style.display = "none";
	} else {// lizhi
		document.getElementById("leaveRowShow").style.display = "";
	}
}
function addemployee(url) { 
	// 序列化form表单
	var serializeform1 = $("#form1").serialize();
	//return;
	$("#form1").submit();
}


}

}



</script>

	</BODY>

</HTML>
