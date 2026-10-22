<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<LINK href="<%=request.getContextPath() %>/Css/jquery-ui-1.8.2.custom.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.position.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.dialog.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#dialog-modal{
	display:none;
	text-align: center;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: 0px;
	padding: 0px;
	background-image: url(../../images/bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
}
</style>
<script type="text/javascript">
	function submitdescrib(){
		var id = $("#meid").val();
		//var describe = $("#describe").val();
		var status = $("#mestatus").val();
		
		var oEditor = FCKeditorAPI.GetInstance("describe"); 
    	var describe = oEditor.GetXHTML();
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

<div id="dialog-modal"  title="你想要的标题">

</div>
<script type="text/javascript">
	function completemission(id,status)
	{
		//$("#meid").val(id);
		//$("#mestatus").val(status);
		var url = ""+id+"&tt="+(new Date()).getTime();
		//var url = "foreGroundFolder/shop/home/myhome.jsp?tt="+(new Date()).getTime();
		
		$("#dialog-modal").dialog({modal: true,hide:'slide',heigth:600,width:1000});
		$("#dialog-modal").load(url);
	}
	
	
		function completemission2(status)
	{
		//$("#meid").val(id);
		//$("#mestatus").val(status);
		var url = "showCommodity.do?tt="+(new Date()).getTime();
		//var url = "foreGroundFolder/shop/home/myhome.jsp?tt="+(new Date()).getTime();
	
		$("#dialog-modal").dialog({modal: true,hide:'slide',heigth:600,width:1000});
		$("#dialog-modal").load(url);
		$("#num").val(status);
		
		
		
		
	}
		function completemission3(id,status)
	{
		//$("#meid").val(id);
		//$("#mestatus").val(status);
		var url = ""+id+"&tt="+(new Date()).getTime();
		//var url = "foreGroundFolder/shop/home/myhome.jsp?tt="+(new Date()).getTime();
	
		$("#dialog-modal").dialog({modal: true,hide:'slide',heigth:600,width:1000});
		$("#dialog-modal").load(url);
		$("#num").val(status);
		
		
		
		
	}
</script>

