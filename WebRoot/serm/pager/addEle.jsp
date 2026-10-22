<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>增加机柜</title>
	<script type='text/javascript' src='<%=path %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
	<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/easyui.css">
	<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript"
			src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
  <script type="text/javascript"><!--
 function onblurInfoCa(){
			var electname =$('#electname').val();
			if(electname!=""){
			var electname1 = encodeURI(electname,"utf-8");
			$.ajax({
				  type: "POST",
				  url:"cms/show_addAjaxname.do",
				  data:{
				  		"electname":electname1
				  },
				  success: function(data){
				       $('#aaaa').html(data);			  		
				  }
				 });
				 }else{
				     $('#aaaa').html('名称不能为空!');
				 }
	}
 function onclickAjax(){
		var electname = encodeURI($('#electname').val(),"utf-8");
		var electPosition = encodeURI($('#electPosition').val(),"utf-8");
		var electTel = encodeURI($('#electTel').val(),"utf-8");
		var electAdmin = encodeURI($('#electAdmin').val(),"utf-8");
		var electPhone = encodeURI($('#electPhone').val(),"utf-8");
				if(electname == "")
				{
					$('#lbl1').show();
					return false;
				}
				if(electPosition == "")
				{
					$("#lbl2").show();
					return false;
				}
				if(electTel == "" || isNaN(electTel))
				{
					$('#lbl3').show();
					return false;
				}
				if(electAdmin == "")
				{
					$('#lbl4').show();
					return false;
				}
				var reg =/^0{0,1}(13[0-9]|15[0-9])[0-9]{8}$/; 
				if(electPhone == "" || isNaN(electPhone) || !reg.test(electPhone))
				{
					$('#lbl5').show();
					return false;
				}
			$('#casubmit').submit();
	}
	
--></script>

	  <script type="text/javascript">
	    function RoomLoad(){
			    e.getRoomCode("mss",function(res){
			        document.getElementById("electCode").value=res;
			    });
		 }
         function getHousename(){
            if( document.getElementById("selectEle").options.length==1){
            var arr = new Array();
            e.getCommentHouses("bs",function(rp){
               alert(rp);
               arr = rp.split(",");
               for(var i=0;i<arr.length;i++){
                  if(i%2==0 && arr[i]!=""){
                    var opt=new Option();
                    opt.innerHTML=arr[i];
                    opt.value=arr[(i+1)];
                     document.getElementById("selectEle").appendChild(opt);
                  }
               }
             
            });
            }
        }
        function getvalues(pps){
          e.getEleInfos(pps,function(result){
               //alert(result);
             for(var j=0;j<result.length;){
                 document.getElementById('superid').value=1;
                 document.getElementById('electname').value=result[j];
                 document.getElementById('houname').innerHTML="房间名字：";
                 document.getElementById('electPosition').value=result[j+1];
                 document.getElementById('houposition').innerHTML="房间位置：";
                 document.getElementById('electTel').value=result[j+2];
                 document.getElementById('electAdmin').value=result[j+3];
                 document.getElementById('electPhone').value=result[j+4]; 
                 document.getElementById("electCode").value=result[j+5];
                 break;
             }
          });
        }
			function fucsC(obj,num)
			{
				var temp = num;
				var a = obj.value;
				var str = "#lbl"+temp;
				if(a == "")
				{
					$(str).show();
					return false;
				}
				if(a != "")
				{
					$(str).hide();
				}		
			}
			function resetContent(){
			     alert('1212');
			     document.getElementById('superid').value="";
                 document.getElementById('electname').value="";
                 document.getElementById('electPosition').value="";
                 document.getElementById('electTel').value="";
                 document.getElementById('electAdmin').value="";
                 document.getElementById('electPhone').value=""; 
                 document.getElementById("electCode").value="";
			}
		</script>
	</head>
	<body onload="RoomLoad()">
		<div style="width: 400px; height: 250px;">
			<div style="width: 400px; height: 40px;">
				<div
					style="height: 40px; width: 200px; font-size: 16px; font-weight: bold; text-align: center; line-height: 40px; color: #3fade0; float: left;">
					请输入机房信息
				</div>
				<div
					style="height: 40px; width: 200px; font-size: 12px; line-height: 40px; color: #333; float: left;">
					（带*号的为必填项）
				</div>
			</div>
			<form action="cms/show_addEle.do" method="post" id="casubmit">
			<input type="hidden" name="electHouse.superid" id="superid" value="0"/>
			    <input type="hidden" name="ctid" value="<%=request.getParameter("ctid") %>"/>
				<table width="580" border="0" cellspacing="0" cellpadding="0"
					align="center">
					<tr>
						<td class="zjjf-wz"> <span id="houname">机房名称：</span> </td>
						<td class="zjjf-tx">
							<input name="electHouse.electName" onblur="onblurInfoCa();"
								id="electname" type="text" class="zjjigui-tx" />
							<div id="aaaa" style="font-size: 12px; color: red;"></div>
						</td>
						<td class="zjjf-xh">
							*
						</td>
						<td class="zjjf-bz">
							&nbsp;
						</td>
						<td class="zjjf-ck">
						   选择已使用机房:<select id="selectEle" style="width:100px;" onclick="getHousename()" onchange="getvalues(this.value)"><option value="0">请选择</option></select>
						</td>
					</tr>
					<tr>
						<td class="zjjf-wz">
							<span id="houposition">机房位置：</span>
						</td>
						<td>
							<input name="electHouse.electPosition" type="text" 
								onblur="fucsC(this,2);" id="electPosition" class="zjjf-tx" />
						</td>
						<td class="zjjf-xh">
							*
						</td>
						<td class="zjjf-bz">
							<label id="lbl2"
								style="font-size: 12px; color: red; display: none;">
								机房位置不能为空
							</label>
						</td>
						<td class="zjjf-ck">&nbsp;</td>
					</tr>
					<tr>
						<td class="zjjf-wz">
							机房座机：
						</td>
						<td>
							<input name="electHouse.electTel" type="text"
								onblur="fucsC(this,3);" id="electTel" class="zjjf-tx" />
						</td>
						<td class="zjjf-xh">
							*
						</td>
						<td class="zjjf-bz">
							<label id="lbl3"
								style="font-size: 12px; color: red; display: none;">
								机房座机不能为空或者格式不正确
							</label>
						</td>
						<td class="zjjf-ck">&nbsp;</td>
					</tr>
					<tr>
						<td class="zjjf-wz">
							机房管理员：
						</td>
						<td>
							<input name="electHouse.electAdmin" type="text"
								onblur="fucsC(this,4);" id="electAdmin" class="zjjf-tx" />
						</td>
						<td class="zjjf-xh">
							*
						</td>
						<td class="zjjf-bz">
							<label id="lbl4"
								style="font-size: 12px; color: red; display: none;">
								机房管理员不能为空
							</label>
						</td>
						<td class="zjjf-ck">&nbsp;</td>
					</tr>
					<tr>
						<td class="zjjf-wz">
							机房管理员电话：
						</td>
						<td>
							<input name="electHouse.electAdmPhone" type="text"
								onblur="fucsC(this,5);" id="electPhone" class="zjjf-tx" />
						</td>
						<td class="zjjf-xh">
							*
						</td>
						<td class="zjjf-bz">
							<label id="lbl5"
								style="font-size: 12px; color: red; display: none;">
								管理员电话不能为空或者格式不正确
							</label>
						</td>
						<td class="zjjf-ck">&nbsp;</td>
					</tr>
					<tr>
						<td class="zjjf-wz">
							房间号编码：
						</td>
						<td>
						    <input type="text" class="zjjf-tx" border="0" id="electCode" name="electHouse.electCode" readonly>
						</td>
						<td colspan="3">
                               &nbsp;
						</td>
					</tr>
				</table>

				<div id="zjjf-but-k">
					<div class="zjjf-but1">
						<input type="button" onclick="onclickAjax();" id="sumbitForm"
							value="确定" />
					</div>
					<div class="zjjf-but2">
						<input type="button" value="重置" onclick="onclickAjax()"/>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>

