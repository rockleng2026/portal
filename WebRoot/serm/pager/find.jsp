<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'find.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	    var path;
		function updateEle(electid)
		{   
			 window.location.href = path+"cms/show_seleEle.do?electid="+electid;
		}
		function findCabinet(caid)
		{
		   //alert("caid="+caid+","+path);
			$.ajax({
				  type: "POST",
				  url:path+"cms/show_seleCab.do",
				  data:{
				  		cabinetId:caid
				  },
				  success: function(data){
				       //alert(data);
				       $('#showSelt').show();
				  	   $('#cabint').append(data);	  		
				  }
				 });
		}
		$(document).ready(function(){
		    var hs =<%= request.getParameter("deid")%> 
		    path=$('#hidn').val();
			$('#cabint').change(function(){
				var caid = $(this).children('option:selected').val();
				window.location.href = path+"cms/show_updateU.do?caid="+caid;
			});
			if(hs!="" || hs!='undefine'){
			 $.ajax({
				   type:'post',
				   url:path+'cms/show_loadHouses.do', //加载机房
				   data:{strinID : hs},
				   success:function(res){
				       var arrs=new Array();
				       arrs=res.split(",");
				       $('#eleho').val(arrs[1]);
					   $('#showHouseOrRoom').append(arrs[0]);
				   }
			});
			}
		});
		function onchangeC()
		{
			var caid = $('#cabint option:selected').val();
			//alert("ca="+caid);
			window.location.href = path+"cms/show_updateU.do?caid="+caid;
		}
		//触发机房
		function clickHouses(){
		var path = $('#hidn').val();
		var hsm = $('#hsect').val();
		//alert("号="+hs);
		 $.ajax({
			   type:'post',
			   url:path+'cms/show_loadRooms.do', //加载房间
			   data:{strinID : hsm},
			   success:function(res){
			      $('#rsect').empty();
				  $('#rsect').append(res);
			   }
		   });
	   }
	   //提交
	function subHouseRooms(){
	var path = $('#hidn').val();
	alert("option="+$('#hsect option:selected').val());
	if($('#hsect option:selected').val()!=0 && $('#rsect option:selected').val()!=0){
		$('#roomOrHouseForm').attr('action',path+'cms/show_conDelHouse.do');
		$('#elehousn').val($('#eleho').val());
        document.getElementById("roomOrHouseForm").submit();
	}else{ 
		$('#roomOrHouseForm').attr('action','javascript:void(0);');
	    alert('请选择机房和房间.');
	}
   }	
	</script>
	
  </head>
  <body>
    <input type="hidden" id="hidn" value="<%=basePath%>">
    <input type='hidden' id='eleho'/>
   	${arrMessager }
   	<br/>
   	<div style="display:none;" id="showSelt">
   	   <select id='cabint' onchange='onchangeC();'></select>
   	</div>
   	<div id="addcup">
   		<div style="position: absolute;width: 100px;height: 50px;" id="updateEc11"></div>
   	</div>
   	<!-- 加载机房和机柜选项 -->
	<div id="showHouseOrRoom">
	  
	</div>
  </body>
</html>
