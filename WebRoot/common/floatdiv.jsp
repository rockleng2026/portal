<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<LINK href="<%=request.getContextPath() %>/Css/jquery-ui-1.8.2.custom.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.position.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.dialog.js"></script>

<style>
#dialog-modal{
	display:none;
	text-align: center;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	padding: 0px;
	background-image: url(../images/bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
}
#dialog-modal input{
	vertical-align: middle;
}
#dialog-modal cite {
	font-weight: normal;
	color: #999;
	font-style: normal;
}
#dialog-modal form,#dialog-modal dt,#dialog-modal dd,#dialog-modal dl,#dialog-modal h1,#dialog-modal h2,#dialog-modal h3,#dialog-modal h4,#dialog-modal h5,#dialog-modal p {
	margin: 0px;
	padding: 0px;
}
#dialog-modal .input-set {
	margin: 0px;
	padding: 0px;
	border: 1px solid ;
	line-height: 19px;
	height: 19px;
}
#dialog-modal .textarea-set {
	border: 1px solid #ccc;
	overflow: auto;
	padding: 2px 1px;
}
</style>
<script type="text/javascript">
	function submitdescrib(){
		var id = $("#meid").val();
		var describe = $("#describe").val();
		var status = $("#mestatus").val();
		if(describe == null || describe == ''){
			alert("请填写描述信息!");
			$("#describe").focus();
			return false;
		}
		//var url = "completemission.do";
		//describe = encodeURI(encodeURI(describe));
		//$.post(url,{id:id,status:status,describe:describe},
		//function(data){
		//	if(data == 0){
		//		alert("提交成功");
		//		window.location.href="getmyreceivemission.do";
		//	}else if(data == 1){
		//		alert("提交错误,请联系管理员!");
		//		return false;
		//	}else{
		//		alert("网络错误");
		//		return false;
			//}
		//});
		$("#applyInfoForm").submit();
	}
</script>
<div id="dialog-modal" title="提交完成任务信息反馈">
 <form action="<%=request.getContextPath() %>/completemission.do" method="post" id="applyInfoForm">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
  	<td align="center" valign="top">反馈描述：</td>
  </tr>
  <tr>
  <input type="hidden" name="meid" id="meid" />
  <td align="center" >
  <textarea id ="describe" name="describe" rows="11" class="textarea-set" style="width:450px;"></textarea>
  </td>
  </tr>
  <tr>
 	<td colspan="1">
 	</td> 
  </tr>
  <tr>
   <td align="center" height="28"><input type="button"  value="提  交"  class="submit-set" onclick="submitdescrib()"/></td>
  </tr>
</table>
</form>
</div>
<script type="text/javascript">
</script>

