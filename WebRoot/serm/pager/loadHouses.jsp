<%@page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s"  uri="/struts-tags"    %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'loadHouses.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  	<script type='text/javascript' src='<%=basePath %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=basePath %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=basePath %>/dwr/util.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/serm/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/serm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/serverJs.js"></script>
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" media="all" href="<%=basePath%>serm/css/mainstyle.css" />
    <script>
    //显示机房信息
function showElectInfo(msn){
	//alert(msn+"=msn0");
	var ug =navigator.userAgent.toLowerCase();
	var IEs=(/msie/);
	var mx,my;
	if(IEs.test(ug)){
	   mx=event.clientX+document.body.scrollLeft;
	   my=event.clientY+document.body.scrollTop;
	   //alert("IE"+mx+","+my);	
	}else{
		 mx=event.clientX+document.documentElement.scrollLeft;
		 my=event.clientY+document.documentElement.scrollTop;
		 //alert("IE2"+mx+","+my);	
	}
	$('.houses_Pop').css('left',mx);
	$('.houses_Pop').css('top',my);
	  //$('#eletids').val(msn);
	  parent.getcitile(msn);
	  var mst = new Array();
	  $.ajax({
		 type:"post",
		 url:"cms/getElectPropertyServers.do",
		 data:{strNameString : msn},
		 success:function(res){
			$('.Room_Pop').hide(1000);
		    EleResived();
		    mst = res.split(",");
		    $('#eleid1').html(mst[0]);
		    $('#eleid2').html(mst[1]);
		    $('#eleid3').html(mst[2]);
		    $('#eleid4').html(mst[3]);
		    $('#eleid5').html(mst[4]);
	     }
	  }); 
}
//显示机柜信息
function showCabitInfo(mps){
   // alert(mps+"=msn");
	var ug = navigator.userAgent.toLowerCase();
	var IEs=(/msie/);
	var mx,my;
	if(IEs.test(ug)){
	   mx=event.clientX+document.body.scrollLeft;
	   my=event.clientY+document.body.scrollTop;
	 //  alert("IE"+mx+","+my);	
	}else{
		 mx=event.clientX+document.documentElement.scrollLeft;
		 my=event.clientY+document.documentElement.scrollTop;
		 //alert("IE"+mx+","+my);	
	}
	$('.Room_Pop').css('left',(mx+60));
	$('.Room_Pop').css('top',(my+10));
	showdirect(mps);
}
function showdirect(mss){
	parent.getciticb(mss);
	 var pst = new Array();
	 $.ajax({
		 type:"post",
		 url:"cms/getCabitPropertyServers.do",
		 data:{strNameString : mss},
		 success:function(result){
		    $('.houses_Pop').hide();
		    cabResived();
		    pst = result.split(",");
		    $('#cabint1').html(pst[0]);
		    $('#cabint2').html(pst[1]);
		    $('#cabint3').html(pst[2]);
		    $('#cabint4').html(pst[3]);
		    $('#cabint5').html(pst[4]);
		    //$('#cabint6').html(pst[5]);
		    //$('#cabint7').html(pst[6]);
	     }
	  }); 
}
       function showho(ms){
         showElectInfo(ms);
       }
       function showcb(mn){
          //alert(mn);
         showCabitInfo(mn);
       }
       window.onload=function(){
           var va=document.getElementById("cityids").value;
          // alert("va="+va);
           parent.getcitids(va);
       }
     
    </script>
  </head>
  
  <body>
 <input type="hidden" id="cityids" value="<%=request.getSession().getAttribute("ctids") %>"/>
<!-- 显示     idle是上架正常运行， full是故障，normal是未使用或下架-->
 <s:if test="#session.houseList.size!=0">
 <s:iterator value="#session.houseList" var="ho" status="pms">
  <s:set value="#ho.houseRoom.substring(0,2)" var="rocode"/>
<div class="jfleft">
<s:if test="#ho.supID == 0">
<s:iterator value="#session.roomList" var="rost">
<s:if test="#rost.houseRoom.substring(0,2)== #rocode && #rost.supID == 1">
<div class="jf ">
<div class="Room"><s:property value="#rost.houseName"/></div><!--房间名字-->
<ul>
<s:iterator value="#session.cabList" var="ca" status="var">
<s:if test="#ca.elehid == #rost.houid">
<li><a href="<%=basePath%>cms/show_servChange.do?caid=<s:property value="#ca.cabID"/>" target="parent"><img src="<%=basePath%>serm/img/normal.jpg" onmousemove="showcb(<s:property value="#ca.cabID"/>)" ></a></li>
 </s:if>
</s:iterator>
</ul>
</div>
</s:if>
</s:iterator>
<div class="clear"></div>
 </s:if>
<s:if test="#ho.showcode.substring(2,4)=='00' && #ho.supID == 0">
<p style="text-align:center; font-size:14px; font-weight:bold; padding-top:20px;"><a href="javascript:parent.updthouses(<s:property value="#ho.houid"/>)" onmouseover="showho(<s:property value="#ho.houid"/>)" style="text-decoration:underline"><s:property value="#ho.houseName"/></a></p>
</s:if>
</div>
<!-- 需要加判断 -->
<s:if test="#pms.index%2!=0">
<div class="jfmiddle"></div>
</s:if>
</s:iterator>
</s:if>
<s:else>
 <div style="width:100%;text-align: center;color:red;font-size:24px;float: left;margin-top: 15px;"><img alt="" src="<%=basePath%>serm/img/cofee.png"/>放松一下，暂时未找到信息。</div>
</s:else>

<!--弹出框-->
<input type="hidden" id="cabsids"/>
<div class="Room_Pop">
<a href="javascript:parent.updatElet();" class="Room_Pop_Btn01">修改机柜</a>
<a href="javascript:parent.deleteElects();" class="Room_Pop_Btn02">删除机柜</a>
<div class="Room_Center">
   <table border="0" cellspacing="0" cellpadding="0"
		id="jiguixx-tb" align="right" style="font-size:12px;">
		<tr>
			<td class="jiguixxtd1">
				所属房间名称:
			</td>
			<td class="jiguixxtd2">
				<span id="cabint1"></span>
			</td>
		</tr>
		<tr>
			<td width="62" class="jiguixxtd1">
				机柜名称：
			</td>
			<td width="98" class="jiguixxtd2">
				<span id="cabint2"></span>
			</td>
		</tr>
		<tr>
			<td class="jiguixxtd1">
				机柜大小：
			</td>
			<td class="jiguixxtd2">
				<span id="cabint3"></span>
				U
			</td>
		</tr>
		<tr>
			<td class="jiguixxtd1">
				最大功率：
			</td>
			<td class="jiguixxtd2">
				<span id="cabint4"></span>
				W
			</td>
		</tr>
		<tr>
			<td class="jiguixxtd1">
				最大带宽：
			</td>
			<td class="jiguixxtd2">
			<span id="cabint5"></span>
				M
			</td>
		</tr>
		<!--  
		<tr>
			<td class="jiguixxtd1">
				最大容纳数：
			</td>
			<td class="jiguixxtd2">
				<span id="cabint6"></span>
				个
			</td>
		</tr>
		<tr>
			<td class="jiguixxtd1">
				已占柜号数：
			</td>
			<td class="jiguixxtd2">
				<span id="cabint7"></span>
				个
			</td>
		</tr>
		-->
	</table>
    </div>
</div>
<!--结束-->
<!--弹出框-->
<input type="hidden" id="eletids"/>
<div class="houses_Pop">
<a href="javascript:parent.addEle();" class="Room_Pop_Btn01">增加机柜</a>
<a href="javascript:parent.delHouses();" class="Room_Pop_Btn02">删除机房</a>
<div class="Room_Center">
 <table width="175" border="0" cellspacing="0" cellpadding="0"
						id="jiguixx-tb" align="right" style="font-size:12px;">
						<tr>
							<td class="jiguixxtd1">
								机房名称
							</td>
							<td class="jiguixxtd2">
								<span id="eleid1"></span>
							</td>
						</tr>
						<tr>
							<td width="62" class="jiguixxtd1">
								机房所在地：
							</td>
							<td width="98" class="jiguixxtd2">
								<span id="eleid2"></span>
							</td>
						</tr>
						<tr>
							<td class="jiguixxtd1">
								机房座机：
							</td>
							<td class="jiguixxtd2">
					             <span id="eleid3"></span>
							</td>
						</tr>
						<tr>
							<td class="jiguixxtd1">
								管理员姓名：
							</td>
							<td class="jiguixxtd2">
								<span id="eleid4"></span>
							</td>
						</tr>
						<tr>
							<td class="jiguixxtd1">
								管理员手机：
							</td>
							<td class="jiguixxtd2">
							     <span id="eleid5"></span>
							</td>
						</tr>
					</table>
 </div>
</div>
<!--结束-->
  </body>
</html>
