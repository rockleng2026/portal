<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.List"%>
<%
	String path = request.getContextPath();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
	<base target="_self" />
	<title>填写内容</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript">
	
	function save(dutyid){		
		document.frm.action = '<%=path %>/DUTYAction.do?method=addUserTorole&dutyid='+dutyid; 
		jspcha(true);
        frm.submit();
		
	}
	function sellexists(dutyid){//flag
		jspcha(true);
		document.getElementById("flag").value=1;
		document.frm.action = '<%=path %>/DUTYAction.do?method=listAllUser&roleId='+dutyid; 
        frm.submit();		
	}
	function sell(){//flag
		jspcha(true);
		document.getElementById("flag").value='all';
		document.frm.action = '<%=path %>/DUTYAction.do?method=listAllUser'; 
        frm.submit();		
	}
	
	//"组"复选框全选
	function checkAll(check){
		var checkedValues=document.getElementById("checkedValues");
		var chk=document.getElementsByName("checkone");
		var len=chk.length;
		for(var m=0;m<len;m++){
			checkedValues.value=checkedValues.value.replace(eval("/(,)?("+chk[m].value+")(,)/"),"$1");				
			if(check.checked){
			  chk[m].checked=true;
			  checkedValues.value+=chk[m].value+",";
			} else {
				chk[m].checked=false;
			}
		}
		
	}
 
  	//单击复选框时触发该事件
	function checkedValue(check){
		var checkedValues=document.getElementById("checkedValues");
		if(check.checked){
			checkedValues.value+=check.value+",";
		} else {
			checkedValues.value=checkedValues.value.replace(eval("/(,)?("+check.value+")(,)/"),"$1");
		}
	}
	
	</script>
	</head>
	<body onload="setdivwidth()"> 
	<table  width="99%" align="center"    border="0" cellspacing="0" cellpadding="0" id="tablesearch" >
		<tr>
		<td class="result-border" align="center" >
	    <div id="box2" class="box2" style='border:#89aad7 1px solid;margin-bottom: 10px;'  >
			
		<form action="<%=path %>/DUTYAction.do?method=listAllUser" name="frm" method="post">

		
		<table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0" class="resultList">
		<tr>
		<th>所在机关：</th>
					<td> 机关
					</td>
			<th>用户编码</th>
			<td>
			    <input type="text" name="userbm" value="双魂牵梦萦"/>
			</td>
			
		</tr>
		<tr>
			<td colspan="6" align="center">
			    <button name="cha" class="button"><span class="icon_find">查询已有用户</span></button>
			    <button name="cha" class="button" onclick="sell()"><span class="icon_find">查询所有</span></button>
				<button name='cha'  class="button"  ><span class="icon_save">保存</span></button>
				<button type="button"   onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
			</td>
		</tr>
		</table>
		</form>
		</div>
    </td>
    </tr>
    
    <tr>
    <td class="result-border" align="center" >
    <jsp:include page="/common/loading.jsp"></jsp:include>
	<div id="resulthight">
	<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
		<tr >
			<th>
				序号
			</th>
			<th>
				用户编码
			</th>
			<th>
				用户名称
			</th>
			<th>
				单位
			</th>
		</tr>
			<tr >
				<td align="center">
					<input type='checkbox' name='checkone' value='aaaa'   onclick="checkedValue(this)" />
				</td>
				<td align="left">
					fdsa
				</td>
				<td align="left">
					fdsa
				</td>
				<td>
					fdsa
				</td>
				
			</tr>
		
		<tr >
			<td colspan="6" align="right">
				fdsa
			</td>
		</tr>
	</table>
	
	</div>
	</td>
	</tr>
	</table>
	</body>

</html>
