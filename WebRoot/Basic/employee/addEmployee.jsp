<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.vo.EmployeeGrade,com.fuao.fajxc.vo.Employee"%>
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
</script>
		<meta content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</HEAD>
	<BODY>
		<form action="addemp.do" id="form1" name="form1" method="post">
			<input type="hidden" id="uuid" name="uuid" value="${showemp.uuid}"
				width="200" />
			<c:if test="${empty showemp}">
				<input type="hidden" value="0" name="isLoginAccount" id="islogin">
			</c:if>
			<c:if test="${not empty showemp}">
				<input type="hidden" value="${showemp.isLoginAccount }"
					name="isLoginAccount" id="islogin">
			</c:if>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
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
											&nbsp;员工资料(带*号的为必填项)
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
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="15%" height=30 align=right>
											<input type="hidden" id="id" name="id" value="${showemp.id }" />
											<input type="hidden" value="0" name="delflag" />
											<input type="hidden" name="empuuid" value="${showemp.uuid}" />
											姓名：
										</TD>
										<TD width="35%" class=category>
											<INPUT class="category" onblur="checkValueByRules('name','','nameMsg')"
												style="WIDTH: 200px" id="name" name="name"
												value="${showemp.name }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
										</TD>
										<TD width="15%" height=30 align=right>
											民族：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('nation','','nationMsg')"
												style="WIDTH: 200px" id="nation" name="nation"
												value="${showemp.nation }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="nationMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											身份证号码：
										</TD>
										<TD width="35%" class=category>
											<INPUT
												onblur="isokCard()"
												style="WIDTH: 200px" id="cardid" name="cardid"
												value="${showemp.cardid }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="cardidMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											健康状况：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('health','','healthMsg')"
												style="WIDTH: 200px" id="health" name="health"
												value="${showemp.health }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="healthMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											性别：
										</TD>
										<TD width="35%" class=category>
											<c:if test="${showemp.sex==1||showemp.sex==null}">
											男:<input checked="checked" style="BORDER: 0px" type="radio"
													value="1" id="sex" name="sex" />
											女：<input style="BORDER: 0px" type="radio" id="sex" name="sex"
													value="2" />
											</c:if>
											<c:if test="${showemp.sex==2}">
											男:<input style="BORDER: 0px" type="radio" value="1" id="sex"
													name="sex" />
											女：<input checked="checked" style="BORDER: 0px" type="radio"
													id="sex" name="sex" value="2" />
											</c:if>
										</TD>
										<TD align=right width="15%" height=30>
											身高(CM)：
										</TD>
										<TD width="35%" class=category>
											<INPUT
												onblur="checkValueByRules('stature',['float'],'statureMsg')"
												style="WIDTH: 200px" id="stature" name="stature"
												value="${showemp.stature }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="statureMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											入职时间：
										</TD>
										<TD width="25%" class=category>
											<c:set var="birthDate1" scope="request"
												value="${showemp.entryTime}" />
											<c:if test="${birthDate1!=null}">
												<INPUT
													onblur="checkValueByRules('entryTime','','entryTimeMsg')"
													style="WIDTH: 150px" id="entryTime" name="entryTime"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"
													value="${showemp.entryTime}">
											</c:if>
											<c:if test="${birthDate1==null}">
												<INPUT
													onblur="checkValueByRules('entryTime','','entryTimeMsg')"
													style="WIDTH: 150px" id="entryTime" name="entryTime"
													value="${showemp.entryTime}"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
											</c:if>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="entryTimeMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											是否离职：
										</TD>
										<TD width="35%" class=category>
											在职:
											<input type="radio" id="isLeave" name="isLeave" value="1"
												onclick="leaveRow()" style="BORDER: 0px"
												<c:if test="${showemp.isLeave==1||showemp.isLeave==null}">checked="checked"</c:if> />
											离职：
											<input type="radio" id="isLeave" name="isLeave" value="0"
												onclick="leaveRow()" style="BORDER: 0px"
												<c:if test="${showemp.isLeave==0}">checked="checked"</c:if> />
										</TD>
									</TR>
									<TR id="leaveRowShow"
										style="<c:if test="${showemp.isLeave!=0}">display:none;</c:if>">
										<TD align=right width="15%" height=30>
											离职时间
										</TD>
										<TD width="35%" class=category>
											<c:set var="birthDate1" scope="request"
												value="${showemp.leaveTime}" />
											<c:if test="${birthDate1!=null}">
												<INPUT style="WIDTH: 150px" id="leaveTime" name="leaveTime"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"
													value="${showemp.leaveTime}">
											</c:if>
											<c:if test="${birthDate1==null}">
												<INPUT style="WIDTH: 150px" id="leaveTime" name="leaveTime"
													value="${showemp.leaveTime}"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
											</c:if>
											&nbsp;
										</TD>
										<TD align=right width="15%" height=30>
											离职原因：
										</TD>
										<TD width="25%" class=category>
											<s:textarea cols="50" id="leaveReason" name="leaveReason"
												rows="7" value="%{#request.showemp.leaveReason}"></s:textarea>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											联系电话：
										</TD>
										<TD width="25%" class=category>
											<INPUT style="WIDTH: 200px" id="tel" name="tel"
												value="${showemp.tel }"
												onblur="checkValueByRules('tel',['phone'],'telMsg')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT id="telMsg" color=#ff0000></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											体重(Kg)：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('heft',['float'],'heftMsg')"
												style="WIDTH: 200px" id="heft" name="heft"
												value="${showemp.heft }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="heftMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											年龄：
										</TD>
										<TD width="25%" class=category>
											<INPUT style="WIDTH: 200px" id="age" name="age"
												value="${showemp.age }"
												onblur="ageisok()">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="ageMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											婚否：
										</TD>
										<TD width="35%" class=category>
											<c:if test="${showemp.married==1}">
											已婚:<input checked="checked" style="BORDER: 0px" type="radio"
													value="1" id="married" name="married" />
											未婚：<input style="BORDER: 0px" type="radio" id="married"
													name="married" value="2" />
											</c:if>
											<c:if test="${showemp.married==2||showemp.married==null}">
											已婚:<input style="BORDER: 0px" type="radio" value="1"
													id="married" name="married" />
											未婚：<input checked="checked" style="BORDER: 0px" type="radio"
													id="married" name="married" value="2" />
											</c:if>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											学历：
										</TD>
										<TD width="25%" class=category>
											<s:select theme="simple" name="education" id="education"
												list="#{'初中':'初中','高中':'高中','中专':'中专','专科':'专科','本科':'本科','硕士':'硕士','博士':'博士','其他':'其他'}"
												value="{#request.showemp.education}"
												onblur="checkValueByRules('education','','educationMsg')"
												headerKey="" headerValue="请选择"
												cssClass="validate[required] text-input">
											</s:select>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="educationMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											户籍地：
										</TD>
										<TD width="35%" class=category>
											<INPUT style="WIDTH: 200px" id="censusreg" name="censusreg"
												value="${showemp.censusreg }"
												onblur="checkValueByRules('censusreg','','censusregMsg')" />
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="censusregMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right height=30>
											部门：
										</td>
										<td width="25%" class="category" >
											<select cssClass="category" onblur="checkValueByRules('depid','','depMsg')"   id="depid" name="depid">
											
											</select>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="depMsg"></FONT>
										</td>
										<TD align=right width="15%">
											职位：
										</TD>
										<TD width="35%" align=left class=category>
											<select id="position" name="position"
												style="width: 90px;">
<!--												onblur="checkValueByRules('position','','positionMsg')"-->
												<option value="">
													---请选择---
												</option>
											</select>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="positionMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right height=30>
											员工工号：
										</td>
										<TD width="25%" class=category>
											<INPUT style="WIDTH: 150px" id="empNo" name="empNo"
												value="${showemp.empNo }"
												onblur="checkValueByRules('empNo','cknoemp.do','empNoMsg')" />
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="empNoMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											计算机水平：
										</TD>
										<TD width="35%" class=category>
											<INPUT style="WIDTH: 200px" id="computeleve"
												name="computeleve" value="${showemp.computeleve }"
												onblur="checkValueByRules('computeleve','','computeleveMsg')" />
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="computeleveMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											生日：
										</TD>
										<TD width="25%" class=category>
											<c:set var="birthDate1" scope="request"
												value="${showemp.birth}" />
											<c:if test="${birthDate1!=null}">
												<INPUT
													onblur="checkValueByRules('birth',['birth'],'birthMsg')"
													style="WIDTH: 150px" id="birth" name="birth"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"
													value="${showemp.birth}">
											</c:if>
											<c:if test="${birthDate1==null}">
												<INPUT
													onblur="checkValueByRules('birth',['birth'],'birthMsg')"
													style="WIDTH: 150px" id="birth" name="birth"
													value="${showemp.birth}"
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
											</c:if>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="birthMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											家庭地址：
										</TD>
										<TD width="35%" class=category>
											<INPUT style="WIDTH: 200px" id="place" name="place"
												value="${showemp.place }"
												onblur="checkValueByRules('place','','placeMsg')">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="placeMsg"></FONT>
										</TD>
									</TR>
									<tr>
										<TD width="25%" align=right height=30>
											创建日期：
										</TD>
										<TD width="25%" class=category>
											<c:if test="${showemp.time==null}">
												<%
													String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
																.format(Calendar.getInstance().getTime());
												%>
												<INPUT readonly="readonly" style="WIDTH: 150px" id="time"
													name="time" value="<%=date%>">
											&nbsp;
										</c:if>
											<c:if test="${showemp.time!=null}">
												<INPUT readonly="readonly" style="WIDTH: 150px" id="time"
													name="time" value="${showemp.time }">
											&nbsp;
											</c:if>
										</TD>
										<TD align=right width="15%" height=30>
											现居地：
										</TD>
										<TD width="35%" class=category>
											<INPUT style="WIDTH: 200px" id="nowplace" name="nowplace"
												value="${showemp.nowplace }"
												onblur="checkValueByRules('nowplace','','nowplaceMsg')">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="nowplaceMsg"></FONT>
										</TD>
									</tr>
									<TR>
										<td width="25%" align=right>
											E-mail：
										</td>
										<TD width="25%" class=category>
											<input onblur="emailisok()"
												id="email" name="email" value="${showemp.email }" />
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="cemail"></FONT>
										</TD>

										<TD align=right width="15%" height=30>
											英语水平：
										</TD>
										<TD width="35%" class=category>
											<INPUT style="WIDTH: 200px" id="engleve" name="engleve"
												value="${showemp.engleve }"
												onblur="checkValueByRules('engleve','[email]','engleveMsg')" />
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="engleveMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right>
											员工级别：
										</td>
										<TD width="25%" class=category>
										
					
									
													
											<c:forEach items="${list1}" var="list2">
											<c:if test="${showemp.empgrade.gradeNum eq list2.gradeNum}">
												<INPUT style="WIDTH: 150px" id="empgrade" 
												
												value="${list2.gradeName}"
												readonly="readonly">	
											<input type="hidden" name="empgrade1" id="empgrade1" value="${list2.gradeNum}"> 	
											</c:if>
											
											
											</c:forEach>
											<c:if test="${empty showemp.empgrade.gradeNum}">
												<INPUT style="WIDTH: 150px" id="empgrade" 
												
												value="十一级"
												readonly="readonly">		
											</c:if>
											<SELECT name="emplevel" id="emplevel">
											
											<c:forEach items="${list1}" var="list1">
											
											<option value="${list1.gradeNum}">${list1.gradeName}</option>
											
											
											</c:forEach>
											
											</SELECT>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="urgenttelMsg"></FONT>
										</TD>
										<TD align=right width="15%">
											技能特长：
										</TD>
										<TD width="35%" align=left class=category>
											<s:textarea cols="50" id="specialty" name="specialty"
												rows="7" value="%{#request.showemp.specialty}"></s:textarea>
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right>
											紧急联系电话：
										</td>
										<TD width="25%" class=category>
											<INPUT style="WIDTH: 150px" id="urgenttel" name="urgenttel"
												value="${showemp.urgenttel }"
												onblur="checkValueByRules('urgenttel',['tel'],'urgenttelMsg')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000
												id="urgenttelMsg"></FONT>
										</TD>
										<!-- <td width="25%" align=right>
										分配职位
										职位管理 </td>
										<Td>
								          <select name="empworkposition">
								           <c:forEach items="${list3}" var="list3">
								           <c:if test="${list3.employee.id==showemp.id}">
								             <option value="-1">当前职位：${list3.workposition.name}(${list3.workposition.department.name})</option>
								             </c:if>
								           </c:forEach>
								          <option >选择职位</option>
								          <c:forEach items="${list2}" var="list2">
										  <option value="${list2.id}">${list2.name}(${list2.department.name})</option>
										 </c:forEach>
										</select>
										</TD>
										-->
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<br>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD>
							<br>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
				
				
				<div id="fmarkdiv">
				<div>
					<jsp:include page="../fieldRemarkAddorUpdate.jsp"></jsp:include>
				</div>
			</div>
			
	
		
	 </form>

	
		<table>
		<tr>
		 <td>
		<input type="button" value="显示上传图片" onclick="showphoto()"/>
		</td>
		 <td id="showimg1"> 暂无可显示的信息</td>
		</tr>
		
		<tr>
		<td colspan="2"><jsp:include page="/Basic/employee/uploadphoto.jsp"></jsp:include></td>
		</tr>
		</table>
		
		   
	
		
	
		
<div id="fjdiv">
			<jsp:include page="/Basic/employee/uploadfiles.jsp"></jsp:include>
		</div>
		
		
		<div class="divFJ"
			style="text-align: center; margin-top: 5px; margin-bottom: 5px; border: 1px #9CF solid;">
			<div style="width: 100%; line-height: 25px; height: 30px;">
				<c:if test="${showemp==null}">
					<input type="button" value="确认添加 "
						onclick="addemployee('addemp.do')"
						style="width: 100px; margin-top: 3px;" />
				</c:if>
				<c:if test="${showemp!=null}">
					<input type="button" value="确认修改" onclick="edit('editemp.do')"
						style="width: 100px; margin-top: 3px;" />
				</c:if>
				<input type=reset value=" 重  置"
					style="width: 100px; margin-top: 3px;" />
			</div>
		</div>
		<div id="dialog" title="错误信息提示">
			<p></p>
		</div>

		<script type="text/javascript">
	jQuery(document).ready(function() {
	
	$("#emplevel").change(function(){
	
	 var val=$("#emplevel").find("option:selected").text();
	 var  a=$("#emplevel").val();
	 document.getElementById("empgrade").value=val;
	 document.getElementById("empgrade1").value=a;
	
	})
	
	
	
	
	});
		function  showphoto(){
		$.post('showphotoemp.do',function(data){
		$('#showimg1').html(data);
		 
		});
		}
		  
		
		
		
		
		
		
function leaveRow() {
	e = event.srcElement;
	if (e.value == 1) {//zaizhi
		document.getElementById("leaveRowShow").style.display = "none";
	} else {// lizhi
		document.getElementById("leaveRowShow").style.display = "";
	}
}
function addemployee(url) { // 添加员工信息
	if (!addValidators()) {
		return false;
	}
	// 序列化form表单
	var serializeform1 = $("#form1").serialize();
	//return;
	$("#form1").submit();
}
function isokCard()
{
	var cardid=document.getElementById("cardid").value;
	if(isIdCardNo(cardid)!=true)
	{
			 $("#cardidMsg").html("输入有误！！");
			 return false;
	}
	else
	{
		 $("#cardidMsg").html("");
	}
	
}
 function isIdCardNo(num) 
    { 
        var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1); 
        var error; 
        var varArray = new Array(); 
        var intValue; 
        var lngProduct = 0; 
        var intCheckDigit; 
        var intStrLen = num.length; 
        var idNumber = num; 
        // initialize 
        if ((intStrLen != 15) && (intStrLen != 18)) 
        { 
       	 //$("#cardidMsg").html("长度不正确！！");
            return false; 
        } 
        // check and set value 
        for(i=0;i<intStrLen;i++) 
        { 
            varArray[i] = idNumber.charAt(i); 
            if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) 
            { 
                return false; 
            } 
            else if (i < 17) 
            { 
                varArray[i] = varArray[i]*factorArr[i]; 
            } 
        } 
       
        if (intStrLen == 18) 
        { 
            //check date 
            var date8 = idNumber.substring(6,14); 
            
            if (checkDate(date8) == false) 
            { 
                //error = "身份证中日期信息不正确！."; 
                //$("#cardidMsg").html("身份证中日期信息不正确！！");
                return false; 
            } 
            // calculate the sum of the products 
            for(i=0;i<17;i++) 
            { 
                lngProduct = lngProduct + varArray[i]; 
            } 
            // calculate the check digit 
            intCheckDigit = 12 - lngProduct % 11; 
            switch (intCheckDigit) 
            { 
                case 10: 
                intCheckDigit = 'X'; 
                break; 
                case 11: 
                intCheckDigit = 0; 
                break; 
                case 12: 
                intCheckDigit = 1; 
                break; 
            } 
            // check last digit 
            if (varArray[17].toUpperCase() != intCheckDigit) 
            { 
                return false; 
            } 
       } 
       else
        {   //length is 15 
            //check date 
            var date6 = idNumber.substring(6,12); 
            if (checkDate(date6) == false) 
            { 
                //alert("身份证日期信息有误！."); 
                //$("#cardidMsg").html("身份证日期信息有误！！");
                return false; 
            } 
        } 
        return true; 
    } 
        function checkDate(date) 
    { 
        return true; 
    } 

function checkreg(){
	
	
	if(regpwd()&&regpwd2()&&regsfz()&&realname()){
		return true;
	}
	else
	{
		return false;
	}
}
function emailisok()
{
	
	var email=document.getElementById("email").value;
	if (email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
	{
		$("#cemail").html("");
		return true;
	}
	else
	{
		 $("#cemail").html("输入有误！！");
		 return false;
	}

	
}
function ageisok()
{
	var age=document.getElementById("age").value;
	if(age>15&&age<81)
	{
		$("#ageMsg").html("");
		return true;
	}
	else
	{
		$("#ageMsg").html("请输入16 - 80 的数字！！");
		return false;
	}
}
</script>
	</BODY>

</HTML>
