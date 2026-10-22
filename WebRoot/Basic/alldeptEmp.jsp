<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
   <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
	
<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript">
	function getdept(){
		var url = "getalldeptDepartment.do";//urlµÿ÷∑
		$.post(url,{
			},function(data){
					 $("#deptSelect").append($.trim(data));
			});
	}
getdept();
function getemp(){
   var nowDate = (new Date()).getTime();
   var deptid = $("#deptSelect").val();
   var url = "getdeptEmpDepartment.do";
   $("#empSelect").empty();
   $.post(url,{
	    deptid:deptid
	},function(data){
	 $("#empSelect").append(data);
	 });
}

</script>


