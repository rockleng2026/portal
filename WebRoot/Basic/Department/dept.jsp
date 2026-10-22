<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
		<LINK rel=stylesheet type=text/css
			href="<%=request.getContextPath()%>/Css/message/mainWin.css"
			media=screen>
		<LINK rel=stylesheet type=text/css
			href="<%=request.getContextPath()%>/Css/message/0219.css"
			media=screen>
		<BASE target=_self>
	<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
<SCRIPT language=javascript>
//接收员工数组字符串
var receivernames="";
var emps="";
var depts="";
var deptlist = new Array();　 
<c:forEach items="${depts}" var="data" varStatus="status">
	var dept${data.id}="";
	var deptempck${data.id}="";
	<c:if test="${data.delflag!=1}">
		<c:forEach items="${data.employees}" var="data1">
			<c:if test="${data1.delflag!=1}">
			<c:if test="${data1.isLeave !=0}">
				dept${data.id}+="|"+${data1.id}+"|";
				deptempck${data.id}+="<input type=\"checkbox\" name=\"emp_dept${data1.id}\" id=\"emp_dept${data1.id}\" value=\"emp_dept${data1.id}\" onclick=\"onckdeladdemp(this,'${data1.id}','${data1.name}')\"/>${data1.name}</br>";
				</c:if>
			</c:if>
		</c:forEach>
	</c:if>
	deptlist["dept${data.id}"] =deptempck${data.id}; 
</c:forEach>




//增加或删除接收员工
function onckdeladdemp(nowinput,empid,empname)
{
	//判断当前是删除还是添加员工
	//添加员工
	if(nowinput.checked==true){
		emps+="|"+empid+"|";
		receivernames+=empname+",";
	}else if(nowinput.checked==false)//删除员工
	{
		emps=emps.replace("|"+empid+"|","")
		receivernames=receivernames.replace(empname+",","")
	}else
	{
	}
		$("#receiver").attr("value",receivernames);
		$("#ryid").attr("value",emps);
}

//添加或删除接收部门
function onckdeladddept(nowinput,deptid,deptname)
{
	//判断当前是删除还是添加员工
	//添加员工
	if(nowinput.checked==true){
		emps+=deptid;
		receivernames+=deptname+",";
	}
	//删除员工
	if(nowinput.checked==false){
		emps=emps.replace(deptid,"");
		receivernames=receivernames.replace(deptname+",","")
	}
	$("#receiver").attr("value",receivernames);
	$("#ryid").attr("value",emps);
}

function changedeptSelect(nowinput,divid)
{
var id=nowinput.value;
document.getElementById(divid).innerHTML =deptlist[id];
//在div中添加内容


}
function SearchInput()
{
  alert("模糊查询");
  var textSuggest=document.getElementById("textSuggest").value;
  if(textSuggest!=null && textSuggest!="")
  {
    window.location.href='<%=request.getContextPath()%>/selectByInputmessage.do?textSuggest='+textSuggest;
  }
}
</SCRIPT>

<DIV id=MainArea>
	<INPUT id=markName_all disabled value=全体人员 type=hidden name=markName_all>
	<INPUT id=markName_select disabled value=请选择人员 type=hidden name=markName_select>
	<INPUT id=selectRadioValue value=2 type=hidden name=selectRadioValue>
	<BR>
	<CENTER>
<DIV class=OutsideBorder>
	<DIV class=InsideBorder>
		<INPUT id=receiveValue value=NoValue type=hidden
			name=receiveValue>
		<INPUT id=selectValue value=2 type=hidden name=selectValue>
		<INPUT id=currentUserIds type=hidden name=currentUserIds>
		<INPUT id=aaaa type=hidden name=aaaa>
		<INPUT id=currentBranchId type=hidden name=currentBranchId>
		<INPUT id=currentDeptTree type=hidden name=currentDeptTree>
		<DIV class=OperateArea>
			<DIV id=SearchInputArea>
				<INPUT id=textSuggest class=SearchInput name=keyWord />
				<IMG id=search_icon border=0
					src="<%=request.getContextPath()%>/images/message/search.gif"   onclick="SearchInput()"/>
		</DIV>


<!--全部员工 -->
<DIV id=ItemListArea>
	<UL>
		<LI id=allUsers>
			<SPAN style="CURSOR: pointer" id=link_10
				onclick=menuClick(10);>&nbsp;&nbsp;<IMG id=link_10Img
					border=0
					src="<%=request.getContextPath()%>/images/message/arrow_close.gif">&nbsp;所有人员列表
		</SPAN>
		<DIV style="DISPLAY: none;PADDING-RIGHT: 10px;OVERFLOW-Y: auto; PADDING-LEFT: 10px;height: 220px" id=module_10 class=moduleContainer>
			<c:forEach items="${depts}" var="data" varStatus="status">
			<c:if test="${data.delflag!=1}">
				<c:forEach items="${data.employees}" var="data1">
						<c:if test="${data1.delflag!=1}">
						<c:if test="${data1.isLeave !=0}">
							<input type="checkbox" name="emp_${data1.id}" id="emp_${data1.id}" value="emp_${data1.id}" onClick="onckdeladdemp(this,'${data1.id}','${data1.name}')"/>${data1.name}</br>
							</c:if>
						</c:if>
				</c:forEach>
			</c:if>
			</c:forEach>
		</DIV>
	</LI>
<!-- 选择部门 -->
<LI id=deptUserLI>
	<SPAN style="CURSOR: pointer;" id=link_1 onclick=menuClick(1);>&nbsp;&nbsp;<IMG id=link_1Img border=0 src="<%=request.getContextPath()%>/images/message/arrow_open.gif">
			&nbsp;选择部门 </SPAN>
<DIV style="DISPLAY: none;PADDING-RIGHT: 10px;OVERFLOW-Y: auto; PADDING-LEFT: 10px;height:220px;" id=module_1>
												
												
<!-- 部门功能树 -->											
<div class="dtree">
<a href="javascript:treedatas.openAll();">打开部门</a> | <a href="javascript:treedatas.closeAll();">关闭所有部门</a>
</div>
<div id="deptsdiv">
	<script type="text/javascript">	
		treedatas= new dTree('treedatas');
		treedatas.add('0','-1','全部部门');
	</script>
	<c:forEach items="${depts}" var="data" varStatus="status">	
		<c:if test="${data.delflag!=1}">
			<script>
			treedatas.add("${data.id}","${data.parentId}","<input type=checkbox name=dept_${data.id} id=dept_${data.id} onclick=\"onckdeladddept(this,dept${data.id},\'${data.name}\')\"/>${data.name}<img src=\'<%=request.getContextPath()%>/images/message/home_arrow.png\'>","","","","","","");	
			<c:forEach items="${data.employees}" var="data1">	
			<c:if test="${data1.delflag!=1}">
			 <c:if test="${data1.isLeave !=0}">  
			treedatas.add("${data.id}_e${data.id}","${data.id}","<input type=checkbox name=emp_${data1.id} id=emp_${data1.id} value=emp_${data1.id} onclick=\"onckdeladdemp(this,\'${data1.id}\',\'${data1.name}\')\"/>${data1.name}<img src=\'<%=request.getContextPath()%>/images/message/mail__plus.png\'>","","","","","","");
			</c:if>
			</c:if>
			</c:forEach>
			
			</script>
		</c:if>
	</c:forEach>
	<script language="javascript">
		document.getElementById("deptsdiv").innerHTML =treedatas;
	</script>
	</div>
</DIV>
</LI>																				
									
										<LI id=UserByDept>
											<SPAN style="CURSOR: pointer;" id=link_2 onclick=menuClick(2); >&nbsp;&nbsp;<IMG
													id=link_2Img border=0
													src="<%=request.getContextPath()%>/images/message/arrow_close.gif">
												&nbsp;按部门选择人员 </SPAN>
											<TABLE style="DISPLAY: none" id=module_2 border=0
												cellPadding=0 width="100%" SPACEPADDING="0">
												<TBODY>
													<TR height=20>
														<TD height=20>
															<SELECT style="HEIGHT: 20px" id=groupNameList
																class=SelectStyle onChange="changedeptSelect(this,'deptVsEmp')";
																name=groupNameList>
																<OPTION value=>
																	请选择部门
																</OPTION>
															<c:forEach items="${depts}" var="data" varStatus="status">	
																<c:if test="${data.delflag!=1}">
																<OPTION value="dept${data.id}">
																	${data.name}
																</OPTION>
																</c:if>
															</c:forEach>
																
															</SELECT>
														</TD>
													</TR>
													<TR style="CURSOR: pointer" height=20>
														<TD id=test_2 onclick=testSelect();>
															显示当前部门人员
														</TD>
													</TR>
													<TR>
														<TD>
														<div id="deptVsEmp">
															
														</div>
														</TD>
													</TR>
												</TBODY>
											</TABLE>
										</LI>
										<!--  
										<LI id=groupUserLI>
											<SPAN style="CURSOR: pointer" id=link_3 class=active
												onclick=menuClick(3);>&nbsp;&nbsp;<IMG id=link_3Img
													border=0
													src="<%=request.getContextPath()%>/images/message/arrow_close.gif">
												&nbsp;按岗位选择人员 </SPAN>
											<DIV id=module_3>
												<DIV style="HEIGHT: 20px">
													<SELECT style="HEIGHT: 20px" id=roleList class=SelectStyle
														onchange=changeSelect(3,this); name=roleList>
														<OPTION selected value=;5QXO;>
															总经理
														</OPTION>
														<OPTION value=;J7QC;>
															--财务总监
														</OPTION>
													</SELECT>
												</DIV>
												<SELECT id=leftList_3 ondblclick=UserMove(0); multiple
													name=leftList_3></SELECT>
											</DIV>
										</LI>										
										
																				
										<LI id=roleUserLI>
											<SPAN style="CURSOR: pointer" id=link_4 onclick=menuClick(4);>&nbsp;&nbsp;<IMG
													style="CURSOR: pointer" id=link_4Img border=0
													src="<%=request.getContextPath()%>/images/message/arrow_close.gif">
												&nbsp;通讯组 </SPAN>
											<DIV style="DISPLAY: none" id=module_4>
												<DIV style="HEIGHT: 20px">
													<SELECT style="HEIGHT: 20px" id=groupList class=SelectStyle
														onchange=changeSelect(4,this); name=groupList>
														<OPTION selected>
															系统管理员组
														</OPTION>
														<OPTION>
															生产事业部
														</OPTION>
													</SELECT>
												</DIV>
												
												<SELECT id=leftList_4 ondblclick=UserMove(0); multiple
													name=leftList_4>
												</SELECT>
											</DIV>
										</LI>
										
										<LI id=roleUserLI>
											<SPAN style="CURSOR: pointer" id=link_4 onclick=menuClick(4);>&nbsp;&nbsp;<IMG
													style="CURSOR: pointer" id=link_4Img border=0
													src="<%=request.getContextPath()%>/images/message/arrow_close.gif">
												&nbsp;通讯组 </SPAN>
											<DIV style="DISPLAY: none" id=module_4>
												<DIV style="HEIGHT: 20px">
													<SELECT style="HEIGHT: 20px" id=groupList class=SelectStyle
														onchange=changeSelect(4,this); name=groupList>
														<OPTION selected>
															系统管理员组
														</OPTION>
														<OPTION>
															生产事业部
														</OPTION>
													</SELECT>
												</DIV>
												
												<SELECT id=leftList_4 ondblclick=UserMove(0); multiple
													name=leftList_4>
												</SELECT>
											</DIV>
										</LI>
										-->
									</UL>
								</DIV>
							</DIV>
						</DIV>
					</DIV>
				</CENTER>
			</DIV>
