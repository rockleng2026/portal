<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.*" pageEncoding="GBK"%>

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
		$("#customers").attr("value",emps);
		
}








function changedeptSelect(nowinput,divid)
{
var id=nowinput.value;
document.getElementById(divid).innerHTML =deptlist[id];
//在div中添加内容


}
function SearchInput()
{
  
  var textSuggest=document.getElementById("textSuggest").value;
  if(textSuggest!=null && textSuggest!="")
  {
    window.location.href='<%=request.getContextPath()%>/selectByInputCustomer.do?textSuggest='+textSuggest;
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
							<font face="Agency FB"><input type="hidden" id="receiveValue" value="NoValue" name="receiveValue"><input type="hidden" id="selectValue" value="2" name="selectValue"><input type="hidden" id="currentUserIds" name="currentUserIds"><input type="hidden" id="aaaa" name="aaaa"><input type="hidden" id="currentBranchId" name="currentBranchId"><input type="hidden" id="currentDeptTree" name="currentDeptTree"></font>
							
							
							
							
							
							<DIV class=OperateArea>
								<DIV id=SearchInputArea>
									<font face="Agency FB"><input id="textSuggest" class="SearchInput" name="keyWord" autocomplete="off"></font>
									<IMG id=search_icon border=0
										src="<%=request.getContextPath()%>/images/message/search.gif" onclick="SearchInput()">
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
											
											<DIV style="DISPLAY:block;PADDING-RIGHT: 10px;OVERFLOW-Y: auto; PADDING-LEFT: 10px;height: 220px" id=module_10 class=moduleContainer>
											  
										 
												<c:forEach items="${cusList}" var="data" varStatus="status">
												        <c:if test="${data.del !='1'}">
											           <input type="checkbox" id="${data.customerId }" value="${data.customerId }" name="checkbox" onclick="onckdeladdemp(this,'${data.customerId }','${data.customerName}')"/>  ${data.customerName}<br/>
											           </c:if>
												</c:forEach>
												
											</DIV>
										</LI>

										

						</UL>
						
					</DIV>
				</CENTER>
			</DIV>
