<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		    <script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/interface/e.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
			
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery-1.3.2.min.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>

		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
  //检查IP地址的数量是否和订单的IP数量匹配
		function checkonipnum(){
		    var n;
			var ipnum=document.getElementById("serverIpNum").value;
			var serip=document.getElementById("serverIp").value;
			if(serip==null || serip==""){
				document.getElementById("serverIpMsg").innerHTML="请选择IP地址！"; 
			}else{
			//alert("serip="+serip);
			var arr=new Array();
			arr=serip.split(",");
		    if(arr[1]==""){
		    n=arr.length-1;
		    }else{
		    n=arr.length;
		    }
			if(arr[1]!="undefined"){
			if(n>ipnum){
				document.getElementById("serverIpMsg").innerHTML="您选择的IP数已经超过啦！";
				document.getElementById("serverIp").value="";
			}else if(n==ipnum)
			{
				document.getElementById("serverIpMsg").innerHTML="您已经选满啦！"+n+"/"+ipnum;
			}
			else
			{
				///document.getElementById("iplist").innerHTML=n+"/"+ipnum;
				document.getElementById("serverIpMsg").innerHTML="请选择足够的IP地址！";
			}
			}else{
			   document.getElementById("serverIpMsg").innerHTML="请选择足够的IP地址！"; 
			}
			}
		}

  //填写IP地址
  function getAllIps(){
		     //alert("ips");	
		    var str= window.showModalDialog("./serm/pager/showIPs.jsp","选择IP号","height=300,width=600,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no,edge=sunken"); 
		     $('#serverIp').val(str);
		//     checkonipnum();
		}
		
  
  function show(){
     $("#tab2").html("");
     $.post('<%=request.getContextPath()%>/getAllHousesUpserver.do',{},function(data){
         if(data!=null){
           $("#house").val("");
           
           $("#electhouse").show();
           $("#tab2").html(data);
         }
     });
    
  }
		   
   function hideelecthouse(){
      $("#electhouse").hide();
    }
    
    
    var electid = "";
    function checkdata(obj){
       var eid = obj.id;
       if(obj.checked==true){
          electid+=eid+",";
       }else if(obj.checked==false){
          electid=electid.replace(eid+",","");
       }else{}
       $("#house").attr("value",electid);
    }
    
    //获取机房下面的机柜
    function getCbt(){
       var electhouse = $("#house").val();
       if(electhouse==""){
          alert("请先选择机房/房间!");
          return;
       }
        $.post('<%=request.getContextPath()%>/showCabinetUpserver.do',{'electid':electhouse},function(data){
            $("#cabinet").show();
            if(data!=null){
               $("#cab2").val("");
               $("#tab3").html(data);
            }
        });
    }
    
    //选中机柜
    var caid = "";
    function checkcab(obj){
      var cid = obj.id;
      if(obj.checked==true){
         caid+=cid+",";
      }else if(obj.checked==false){
         caid=caid.replace(cid+",","");
      }else{}
      $("#cab2").attr("value",caid);
    }
    
    //关闭机柜的层
    function hidecabinet(){
      $("#cabinet").hide();
      
    }
    
    
    
    
    
    
    
    $(function(){
		   $('#tuphouse').click(function(){
		      if(document.getElementById("tuphouse").options.length==1){
		      e.getAllHouses("getms",function(res){
		          //alert(res);
		          $('#tuphouse').empty();
		           $('#tuphouse').append('<option value="0">请选择</option>');
		          $('#tuphouse').append(res);
		      });
		      }
		   });
		  
		   $('#tuphouse').change(function(){
		       var sect = $('#tuphouse').children('option:selected').val();
		      // alert("sect="+sect);
		       e.getAllCabinets(sect+"",function(result){
		            //alert(result);
		            $('#Tupcabscaid').empty();
		            $('#Tupcabscaid').append(result);
		       });
		   });
		   $('#Tupcabscaid').change(function(){
		        var cabs = $('#Tupcabscaid').children('option:selected').val();
		        var serid= $('#saleOrderNum').val();
		        if(cabs!=0){
		           if(serid!=""){
			        e.autoAllotSpase((cabs+","+serid),function(resut){
			          // alert(resut);
			           var arr = new Array();
			           arr=resut.split(",");
			           if(arr[1]=='no'){
			              $('#Tupcabscaid').next().html(arr[0]);
			           }else{
				  //         $('#Tupcabscaid').next().html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				           $('#marknums').val(resut);
				           $('#aaa').html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				           $('#tx1').val(arr[0]);
				           $('#tx2').val(arr[1]);
				        }
			        });
			        }else{
			             alert("请选择销售订单号");
			       }
			    }
		   });
		});
		
		
</script>


</head>	
<% request.setCharacterEncoding("gbk");
	response.setCharacterEncoding("gbk");
%>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<BODY>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
				
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;运维单详细信息
										</TD>
										<TD align=right>
											&nbsp;<a href="javascript:history.go(-1);">返回</a>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD>						
						</TD>
						<TD>
	<!-- form开始 -->		<form action="<%=request.getContextPath() %>/updateYwUpserver.do" method="post" id="form1">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border="1" >
								<TBODY>
									<tr>
										<td width="20%" height="30" align="right">
											编号：
										</td>
										<td width="20%" height="30" align="left"  class=category>
											${operate.id}
											<input type="hidden" name="operate.id" value="${operate.id }"/>
										</td>
										<td width="20%" height="30" align="right">
											上架单编号：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											${operate.upserver.upNo}
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											运维单号：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${operate.operateNo}
										</td>
										<td width="20%" height="30" align="right">
											销售订单号：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${operate.saleOrders.soNums}
											<input type="hidden" id="saleOrderNum" value="${operate.saleOrders.soId}"/>
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											上架员工：
										</td>
										<td width="30" height="30" align="left"  class=category >
											${operate.employee.name}
										</td>
										<td width="20%" height="30" align="right">
											上架时间：
										</td>
										<td width="30" height="30" align="left"  class=category>
											<input type="text" name="operate.uptime" value="" onclick="WdatePicker()"/>
											
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											下架时间：
										</td>
										<td  width="30%" class=category  >
											<input type="text" name="operate.downtime" value="" onclick="WdatePicker()"/>
										</td>
										<TD width="20%" height=30 align=right>
											所属仓库：
										</TD>
										<TD width="30%" class=category>
											${operate.depot.name}
										</TD>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											商品名称：
										</td>
										<td  width="30%" class=category   class=category >
											${operate.product.property.id}
										</td>

										<td  width="20%"  height=30 align=right >
											IP地址：
										</td>
										<td  width="30%" class=category >
										    <input type="hidden" id="serverIpNum" value="${operate.upserver.soOrders.ipnum}"/>
											<input type="text" id="serverIp" name="operate.ipAddress"/>
											<input type="button" id="address" value="选择IP" onclick="getAllIps()"/>
											请单击”选择“按钮&nbsp;&nbsp;
											<FONT color=#ff0000 id="serverIpMsg"></FONT>
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											机房/房间：
										</td>
										<td  colspan="1" class=category >
											<select id="tuphouse" name="operate.housesAndRooms">
													<option value="${upserver.housesAndRooms }"
														selected="selected">
														${upserver.housesAndRoomsID }
													</option>
												</select>
												
												
										</td>
										<td width="20%"  height=30 align=right>
											机柜：
										</td>
										<td  width="30%" class=category >
										<input type="hidden" name="operate.markNum" id="marknums" />
										    <select
													onblur="checkValueByRules('Tupcabscaid','','cabids')"
													id="Tupcabscaid" name="operate.jgh" onclick="funshow()">
													<c:forEach items="${allcabnt }" var="ct">
														<option value="${ct.caid }"
															<c:if test="${upserver.jgh==ct.caid }">selected</c:if>>
															${ct.caname }
														</option>
													</c:forEach>
												</select>
												
												<span id="aaa"></span>
										</td>
									</tr>

									<TR>
										<TD align=right height=30>
											交换机名称：
										</TD>
										<TD class=category> 
											<input type="text" name="operate.jhj" />
										</TD>
										
										<TD align=right height=30>
											端口号：
										</TD>
										<TD class=category> 
											<input type="text" name="operate.port" />
										</TD>
									</TR>     
									    
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category> 
											<textarea rows="5" cols="5" name="operate.temp" style="width: 100px;height: 30px;"></textarea>
										</TD>
										<tr>
										  <td colspan="4" align="center">
										    <input type="submit" value="提交"/>
										  </td>
										</tr>
									</TR>             
								</TBODY>
							</TABLE>
		<!-- form结束 -->	</form>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
			
  <div id="electhouse" style="position: absolute;left: 500px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;">选择机房/房间</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideelecthouse();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;left:80px;"><input type="button" id="sure" value="确定" onclick="hideelecthouse()"/></div>
   </div>
   </div>
   
   <!-- 显示机柜的层 -->
   <div id="cabinet" style="position: absolute;left: 1000px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;">选择机柜</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hidecabinet();" style="text-decoration: none;">关闭</a></div>
   </div>
   <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab3" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;left:80px;"><input type="button" id="sure" value="确定" onclick="hidecabinet()"/></div>
   </div>
   </div>
			
	</BODY>
</HTML>
