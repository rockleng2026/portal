<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：栏目管理
	 创建 人：陈星
	 创建时间：2012-08-21
 -->
<html>
	<head>
		<base href="<%=basePath%>">

		<title>栏目管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style type="text/css">
		@import url("cms/css/admin.css");
		</style>
		<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
		<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="./cms/js/titleManage.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.checkform.js"></script>
		<link rel="stylesheet" type="text/css" href="./cms/css/checkform-demo.css">
		<style type="text/css">
		.nShow {
			display: none;
		}
		#outlian{
		   display:none;
		}
		</style>
			</head>
			<body>
				<div id="weizhi">
					<div id="weizhiwz">
						当前位置&nbsp;&gt;&gt;&nbsp;内容部&nbsp;&gt;&gt;&nbsp;栏目管理
						<input type="hidden" name="basepath" id="basepath" value="<%=path %>">
					</div>
				</div>
				<div style="width:100%; height:90%;">
					<table id="dd">
					</table>
				</div>
				<br>
				<div id="nn">
					<div id="w" class="easyui-window" title="输入界面" iconCls="icon-save"
						style="width: 500px; height: 200px; padding: 5px; background: #fafafa;">
						<div class="easyui-layout" fit="true">
							<div region="center" border="false"
								style="padding: 10px; background: #fff; border: 1px solid #ccc;">
								<form id="ff" name="foms"
									action=""
									method="post">
									<br>
									<br>
									<div class="conSet">
										<table width="100%" border="0" align="center" cellpadding="3"
											cellspacing="1" class="space tableBg">
											<tr>
												<td align="right" nowrap class="bg3">
													父ID：
												</td>
												<td align="left" class="bg0">
													<select name="classes.superid" id="superid" >
														<c:forEach items="${clist}" var="ss">
															<option value="${ss.classid }">${ss.classname }</option>
														</c:forEach>
													</select>
												    <span id="clasid" style="color: red;"></span>
												</td>
											</tr>
											<tr>
												<td align="right" nowrap class="bg3">
													栏目名称(*)：
												</td>
												<td align="left" class="bg0">
													<input type=text name="classes.classname" id="typename"
														style="width: 200" maxlength="20">
													<input type=hidden name="mark" id="mark" value="save">
													<input type=hidden name="classes.classid" id="classid" value="">
													<input type=hidden name="kindid" id="kindid" value="0">
													<span id="tnmsg" style="color: red;"></span>
												</td>
											</tr>
											<tr>
												<td align="right" nowrap class="bg3">
													英文名称(*)：
												</td>
												<td align="left" class="bg0">
													<input type=text name="classes.engname" id="engname"
														style="width: 200" maxlength="20">
													<span id="engmsg" style="color: red;"></span>
												</td>
											</tr>
											<tr>
												<td align="right" nowrap class="bg3">
													优先级(*)：
												</td>
												<td align="left" class="bg0">
												<c:choose>
												<c:when test="${news.islastest == null || news.islastest == '' || news.islastest eq 0 }">
													<input type=text name="classes.islastest" id="islastest"
														style="width: 50" maxlength="3" onblur="checklast(this.value)" value="0">只能是范围为0~999的数字 默认为0 优先级越大越在前面。
												</c:when>
												<c:otherwise>
													<input type=text name="classes.islastest" id="islastest"
														style="width: 50" maxlength="3" onblur="checklast(this.value)" value="${news.islastest }">只能是范围为0~999的数字 默认为0 优先级越大越在前面。
												</c:otherwise>
												</c:choose>
													<span id="lastmsg" style="color: red;"></span>
												</td>
											</tr>
											<tr>
												<td align="right" class="bg3">
													是否外链：
												</td>
												<td class="bg0">
													<input type="radio" name="classes.isout" id="isout" value="1" onclick="getoutlian()"/>
													是<div id="outlian"><input type="text" id="outpath" name="classes.outpath" value="输入外链地址" style="color:#999;"onclick="if(this.value=='输入外链地址'){this.value='';}"></div>
													<input type="radio" name="classes.isout" id="isout" value="0"
														onclick="getoutlian()" checked />
													否
													
												</td>
											</tr>
											<tr>
												<td align="right" class="bg3">
													是否显示：
												</td>
												<td class="bg0">
													<input type="radio" name="classes.showflag" id="showflag"
														value="0" />
													是
													<input type="radio" name="classes.showflag" id="showflag"
														value="1" />
													否
													<span id="opmsg" style="color: red;"></span>
												</td>
											</tr>
		
											<tr>
												<td colspan="2" align="center" nowrap class="bg1">
													<input type="button" class="save_but" id="subs" onclick="checkform()">
												</td>
											</tr>
										</table>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
