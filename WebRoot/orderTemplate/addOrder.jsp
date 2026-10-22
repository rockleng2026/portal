<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gb2312"%>
    <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
<title>Insert title here</title>

</head>


<body >
       
<iframe scrolling="auto" id="ifrm" frameborder="0" width="100%" height="100%"></iframe>'

<script>
function aaa(){
document.getElementById("ifrm").src = "aa.jsp;
}
</script> 
       
		<table style="MARGIN-TOP: 8px" width="100%" bgcolor="#cccccc" >
			<tr><td colspan="4" align="center"><h3>添加订单</h3></td></tr>
			<tr>
				<td width="20%" align="right">
					订单类型：
				</td>
				<td width="30%" align="left">
					<select>
						<option>aaaa</option>
						<option>aaaa</option>
						<option>aaaa</option>
					</select>
				</td>
				<td width="20%" align="right">
					套餐类型：
				</td>
				<td width="30%" align="left">
					<select onchange="addtaocan()"  >
						<option >套餐a</option>
						<option>套餐b</option>
						<option>套餐c</option>
					</select>
				</td>
			</tr>
				<tr>
				<td align="right">
					付费类型：	
				</td>
				<td align="left">
					<select>
						<option>dddd</option>
						<option>dddd</option>
						<option>dddd</option>
					</select>
				</td>
				<td align="right">
					备注：	
				</td>
				<td align="left" >
					<textarea style= "height:60px "  id="messagecontent" name="messagecontent"  ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<table width="100%">
				<tr>
					<td width="25%">
						套餐名称
					</td>
					<td width="25%">
						开始时间
					</td>
					<td width="25%">
						结束时间
					</td>
					<td width="25%">
						描述
					</td>
					</tr>
				</table>
				<table width="100%">
				<tr>
					<td width="25%">
						套餐A
					</td>
					<td width="25%">
						2010-2-2
					</td>
					<td width="25%">
						2010-8-9
					</td>
					<td width="25%">
						部分产品优惠
					</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td colspan="4" id="addtr">
					<table  width="100%">
						<tr>
							<td width="20%">
								产品
								
								<input value="取值" type="button" onclick="quzhi()" />
							</td>
							<td width="20%">
								单价
							</td>
							<td width="20%">
								描述
							</td>
							<td width="20%">
								购买数量
							</td>
								<td width="20%">
								选择	
							</td>
						</tr>
						</table>
						<table id="taocantable">
						<tr>
						<td width="20%">
								a产品
								<input id="" name="" type="hidden"/>
							</td>
							<td width="20%">
								20元（个）
							</td>
							<td width="20%">
								优惠5元
							</td>
							<td width="20%">
								<input id="" name="" type="text" style="width: 25%"/>
							</td>
							<td width="20%">
								<input id='' name='a' type="checkbox" value="1"/>
							</td>
						</tr>
						<tr>
						<td width="20%">
								b产品
								<input id="" name="" type="hidden"/>
							</td>
							<td width="20%">
								20元（个）
							</td>
							<td width="20%">
								优惠5元
							</td>
							<td width="20%">
								<input id="" name="" type="text" style="width: 25%"/>
							</td>
							<td width="20%">
								<input id='' name='a' type="checkbox" value="2"/>
							</td>
						</tr>
						<tr>
						<td width="20%">
								c产品
								<input id="" name="" type="hidden"/>
							</td>
							<td width="20%">
								20元（个）
							</td>
							<td width="20%">
								优惠5元
							</td>
							<td width="20%">
								<input id="" name="" type="text" style="width: 25%"/>
							</td>
							<td width="20%">
								<input id='' name='a' type="checkbox" value="3"/>
							</td>
						</tr>
						<tr>
						<td width="20%">
								d产品
								<input id="" name="" type="hidden"/>
							</td>
							<td width="20%">
								20元（个）
							</td>
							<td width="20%">
								此产品没有优惠
							</td>
							<td width="20%">
								<input id="" name="" type="text" style="width: 25%"/>
							</td>
							<td width="20%">
								<input id='' name='a' type="checkbox" value="4"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</body>
<script type="text/javascript">
function addtaocan()
{
	var aa="<table id='taocantable'><tr><td width='20%'>d产品</td><td width='20%'>20元（个）</td><td width='20%'>优惠5元</td><td width='20%'><input id='' name='' type='text' style='width: 25%'/></td><td width='20%'><input id='' name='a' type='checkbox' value='dd'/></td></tr></table>";
	$("#taocantable").remove();
	$("#addtr").append(aa);
}
function quzhi()
{
	var inputs = document.getElementsByName("a");
	for(var i=0;i<inputs.length;i++)
	{
		if(inputs[i].checked)
		{
			alert(inputs[i].value);
		}
	}
}
</script>
</html>