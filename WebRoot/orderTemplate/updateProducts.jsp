<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添单据</title>
<script type="text/javascript">
var count=2;
function addtr()
{
	var aa="<tr id='tr"+count+"'><td width='20%' align='right'>产品名称：</td><td width='10%' align='left'><input id='name"+count+"' name='' type='text'/>";
		aa+="</td><td width='10%' align='right'>产品单价：</td><td align='left' width='10%'><input id='price"+count+"' name='' type='text' /></td></tr>";
		$("#addtr").append(aa);
		count++;
}
function deltr()
{
	$("#tr"+(count-1)+"").remove();
	count--;
}
function addchanpin()
{
	var chanpinname="";
	var price="";
	var leixing=document.getElementById("orderleixing").value;
		if(leixing==0)
		{
			alert("请选择订单类型");
			return false;
		}
	var name=document.getElementById("name").value;
	if(name==null||name=="")
	{
		alert("产品类型名称不能为空");
		return false;
	}
	for(var i=1;i<count;i++)
	{
		if(document.getElementById("name"+i+"").value==null||document.getElementById("name"+i+"").value=="")
			{
				alert("产品名称不能为空");
				return false;
			}
		if(document.getElementById("price"+i+"").value==null||document.getElementById("price"+i+"").value=="")
			{
				alert("产品单价不能为空");
				return false;
			}
		if(i==(count-1))
		{
			
			chanpinname+=document.getElementById("name"+i+"").value;
			
			price+=document.getElementById("price"+i+"").value;	
		}
		else
		{
			chanpinname+=document.getElementById("name"+i+"").value+",";
			price+=document.getElementById("price"+i+"").value+",";
		}
	}
	var url="";
	$.post(url,{
	chanpinname:chanpinnanme,//产品的名称
	price:price, //产品的价格
	leixing:leixing, //订单类型
	name:name //产品类型的名称
	},function(data){
		if(data==1)
		{
			alert("增加成功");
			window.location.href='<%=request.getContextPath()%>';
		}
		else{
			alert("增加失败");
		}
	});
}
</script>

</head>
<body>
		<table width="60%">
			<tr>
				<td width="40%" colspan="4" align="center">
					<h3>
						修改产品
					</h3>
				</td>
			</tr>
			<tr>
				<td width="20%" align="right">
					订单类型：
				</td>
				<td width="10%" align="left">
					CDN类型

				</td>
				<td width="10%" align="right">
					产品类型名称：
				</td>
				<td align="left" width="10%">
					销售产品
				</td>
			</tr>
			<tr>
				<td width="40%" colspan="4" align="center">
				<FONT color=#ff0000>增加、减少产品&nbsp;&nbsp;</FONT>
					<input id="" name="" type="button" value="增加一行" onclick="addtr()" />
					<input id="" name="" type="button" value="减少一行" onclick="deltr()" />
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table id="addtr" width="80%">
					<tr >
						<td width="20%" align="right">
							产品名称：
						</td>
						<td width="10%" align="left">
							<input id="name1" name="" type="text"/>
						</td>
						<td width="10%" align="right">
							产品单价：
						</td>
						<td align="left" width="10%">
							<input id="price1" name="" type="text" />
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<input id="" name="" type="button" value="提交" onclick="addchanpin()" />
					<input id="" name="" type="reset" value="重置" />
				</td>
			</tr>
		</table>
	</body>
</html>