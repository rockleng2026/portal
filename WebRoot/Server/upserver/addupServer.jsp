<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page
	import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies"%>
<%@ page
	import="com.fuao.fajxc.vo.UpServer,com.fuao.fajxc.vo.Product,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/e.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/util.js'></script>
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
		<script type="text/javascript">
		function checkonipnum()
		{
		    var n;
			var ipnum=document.getElementById("serverIpNum").value;
			var serip=document.getElementById("serverIp").value;
			if(serip==null || serip==""){
				document.getElementById("serverIpMsg").innerHTML="请选择IP地址！"; 
			}else{
			//alert("serip="+serip);
			var arr=new Array();
			arr=serip.split(",");
		    alert("serip="+arr[1]);
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
		function getstoresId(){
		      sers = $('#serverLocation').val();
		      //alert("ss="+sers);
		      e.loadservers((sers+""),function(pms){
		              $('#productids').empty();
		              var ppt = '<option value="0">请选择</option>'
		             if(pms!=""){
		               $('#productids').append(ppt);
		               $('#productids').append(pms);
		             }else{
		              $('#productids').append(ppt);
		             }
		      });
		}
		//上架单时对输入的IP进行验证
		function checkip(){
		  var ip =$('#serverIp').val();
		  $.post('checkIPUpserver.do',
		         {serverIp:ip},
		         function(result){
		         if(result=='ERROR'){
		           alert("IP已存在,不能重复添加!");
		         }
		         });
		}
		function getAllIps(){
		     //alert("ips");	
		    var str= window.showModalDialog("./serm/pager/showIPs.jsp","选择IP号","height=300,width=600,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no,edge=sunken"); 
		     $('#serverIp').val(str);
		     checkonipnum();
		}
		$(function(){
		   alert("aa");
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
		        alert('serid='+serid);
		        if(cabs!=0){
		           if(serid!=""){
			        e.autoAllotSpase((cabs+","+serid),function(resut){
			          // alert(resut);
			           var arr = new Array();
			           arr=resut.split(",");
			           if(arr[1]=='no'){
			              $('#Tupcabscaid').next().html(arr[0]);
			           }else{
			                //alert(resut);
				           $('#Tupcabscaid').next().html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				           $('#marknums').val(resut);
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
		 function checkForms(){
		  
		       if($('#saleOrderNum').val()==""){
		          $('#saleNoMsg').html("销售定单不能为空");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		           return false;
		       }else if($('#serverLocation').val()==0){
		       $('#liip').show();
		       $('#liip').html("仓库位置不能为空");
		       $('#saleNoMsg').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#productids').val()==0){
		       $('#serverMsg').html("服务器名称不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#uptime').val()==""){
		       $('#upMsg').html("上架日期不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#downtime').val()==""){
		       $('#downMsg').html("下架日期不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#serverIpNum').val()==""){
		               $('#serverIpNumMsg').html("IP数不能为空");
		               $('#saleNoMsg').html("");
			          $('#liip').html("");
			          $('#serverMsg').html("");
			          $('#upMsg').html("");
			          $('#downMsg').html("");
			          $('#serverIpMsg').html("");
			          $('#bwCountMsg').html("");
			           $('#cabids').html("");
		               return false;
		       }else if($('#serverIp').val()==""){
		        	$('#serverIpMsg').html("Ip地址不能为空");
		        	$('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#bandwidthAmount').val()==""){
		        	$('#bwCountMsg').html("带宽数量不能为空");
		        	$('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		           $('#cabids').html("");
		             return false;
		       }else if($('#Tupcabscaid').val()==0){
		       		 $('#cabids').html("机柜名称不能为空");
		       		 $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		              return false;
		       }else {
		       	  $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		          $('#cabids').html("");
		            return true;
		       }
		   }
		</SCRIPT>

		<LINK href="<%=request.getContextPath()%>/Css/style.css"
			type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<%
			Cookies ck = new Cookies();
			String empName = ck.getCookie(request, "employeeName");
			String empId = ck.getCookie(request, "employeeId");
		%>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<!-- 遮罩层  -->
		<div style="position: absolute; display: none; left: 0px; top: 0px;"
			id="tranDiv">
			<div
				style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; background-color: #000000; filter: alpha(Opacity = 30)"
				id="tranDivBack">
			</div>
			<div align='center'
				style='position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; background-color: #e5edf5; background-image: url(images/bestnetqywimg/tccbg.gif);'
				id='infoDiv'></div>
		</div>
		<!--层遮罩部分结束  addPurchaseOrder.do-->

		<FORM name=form1
			action="
	     	<c:if test="${upserver==null}">addUpserver.do</c:if>
	        <c:if test="${upserver!=null}">editUpserver.do</c:if>
		"
			method="post" onsubmit="return checkForms()">
			<input type="hidden" value="${upserver.id }" id="upid" name="id">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											<c:if test="${upserver!=null}">
											&nbsp;修改上架单(带*号的为必填项)
										</c:if>
											<c:if test="${upserver==null}">
										&nbsp;新增上架单(带*号的为必填项)
										</c:if>
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border="1">

								<input type="hidden" value="0" name="del" />
								<TBODY>
									<TR>
										<TD width="20%" height=30 align=right>
											上架单号：
										</TD>
										<TD width="30%" class=category>
											<c:if test="${upserver!=null}">
												<INPUT readonly="readonly" style="WIDTH: 200px" id="SJNo"
													name="upNo" value="${upserver.upNo }">
											</c:if>
											<c:if test="${upserver==null}">
												<INPUT readonly="readonly" style="WIDTH: 200px" id="SJNo"
													name="ups.upNo" value="${SJNo }">
											</c:if>
										</TD>
										<TD width="20%" height=30 align=right>
											销售订单号：
										</TD>
										<TD width="30%" class=category>
											<INPUT
												onblur="checkValueByRules('saleOrderNum','','saleNoMsg')"
												onclick="completemission('getSaleOrderListClientOrder.do?auditingState=1&page=addupServer','')"
												style="WIDTH: 200px" id="saleOrderNum"
												name="saleOrder.saleOrderNo"
												value="${upserver.saleOrder.saleOrderNo}">
											<input id="saleOrderid" name="saleOrder.id" type="hidden"
												value="${upserver.saleOrder.id }">
											<FONT color=#ff0000 id="saleNoMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<tr>
										<td width="20%" height="30" align="right">
											单位名称：
										</td>
										<td width="30%" class=category>
											<input id="comname" name="ups.customer.customerCompany"
												value="${upserver.customer.customerCompany }" />
											<input id="comid" name="ups.customer.customerId"
												type="hidden" value="${upserver.customer.customerId }" />
										</td>
										<td width="20%" height="30" align="right">
											联系人：
										</td>
										<td width="30%" class=category>
											<input id="linkname" name="ups.customer.realName"
												value="${upserver.saleOrder.customer.realName }" />
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											联系电话：
										</td>
										<td width="30%" class=category>
											<input id="phone" name="ups.customer.phone"
												value="${upserver.customer.phone }" />
										</td>
										<td width="20%" height="30" align="right">
											销售负责人：
										</td>
										<td width="30%" class=category>
											<!-- <input id="employeename" name="customer.employee.name" value="${upserver.customer.employee.name }"/>
											 -->
											<label id="employeename">
												${upserver.saleOrder.customer.employee.name }
											</label>
										</td>
									</tr>


									<TR>
										<TD width="20%" align=right height=30>
											仓库位置：
										</TD>
										<TD width="30%" class=category>
											<c:if test="${empty upserver}">
												<s:select onchange="getstoresId()"
													onblur="checkValueByRules('serverLocation','','downMsg')"
													id="serverLocation" name="ups.serverLocation"
													cssClass="category" list="#request.serverLocation1"
													value="%{'',#request.serverLocation1.name}" listKey="id"
													listValue="name" headerKey="-1" headerValue="请选择！！"></s:select>
												<font id="liip" style="display: none;"> </font>


												<!-- <s:select  
											   id="serverLocation" name="serverLocation" cssClass="category" 
											   list="#request.serverLocation" listKey="name" listValue="name" 
											   value="%{'',#request.serverLocation.name}" headerKey="" headerValue="请选择" >
											</s:select>
											 -->


											</c:if>
											<c:if test="${upserver!=null }">
												<select
													onblur="checkValueByRules('serverLocation','','downMsg')"
													id="serverLocation" name="ups.serverLocation"
													cssClass="category" onchange="getstoresId()">

													<c:forEach items="${serverLocation1}" var="serlolist">
														<option value="${serlolist.id }"
															<c:if test="${serlolist.id==upserver.serverLocation }">selected='selected'</c:if>>
															${serlolist.name }
														</option>
													</c:forEach>
												</select>
											</c:if>

											<FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="downMsg"></FONT>
										</TD>
										<TD width="20%" height=30 align=right>
											服务器名称：
										</TD>

										<TD width="30%" class=category>
										<c:if test="${empty upserver}">
										    <select onblur="checkValueByRules('productids','','serverMsg')" id="productids" name="ups.product.id" class="category" >
										        <option value="0">请选择</option>
										    </select>
										    <FONT color=#ff0000 id="serverMsg"></FONT><FONT color=#ff0000>*</FONT>
										    </c:if>
									   <c:if test="${upserver!=null}">
										    <select onblur="checkValueByRules('productids','','serverMsg')" id="productids" name="ups.product.id" class="category" >
										             <option value="${fproid }" selected>${fpname }-----${fpbarCode }</option>
										    </select>
										    <FONT color=#ff0000 id="serverMsg"></FONT><FONT color=#ff0000>*</FONT>
									   </c:if>
									   </TD>
											<c:if test="${empty upserver}">
												<select
													onblur="checkValueByRules('productids','','serverMsg')"
													id="productids" name="ups.product.id" class="category">
													<option value="0">
														请选择
													</option>
												</select>
												<FONT color=#ff0000 id="serverMsg"></FONT>
												<FONT color=#ff0000>*</FONT>
											</c:if>
											<c:if test="${upserver!=null}">
												<select
													onblur="checkValueByRules('productids','','serverMsg')"
													id="productids" name="ups.product.id" class="category">
													<option value="${fproid }" selected>
														${fpname }
													</option>
												</select>
												<FONT color=#ff0000 id="serverMsg"></FONT>
												<FONT color=#ff0000>*</FONT>
											</c:if>
										</TD>
									</TR>
									<tr>
										<TD width="20%" align=right height=30>
											上架日期：
										</TD>
										<%
											String bd = "";
										%>
										<c:if test="${upserver!=null}">
											<c:set var="ttime" value="${upserver.uptime}" scope="request"></c:set>
											<%
												java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
															"yyyy-MM-dd");
													bd = formatter.format(request.getAttribute("ttime"));
											%>
										</c:if>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules('uptime',['birth'],'upMsg')"
												style="WIDTH: 150px" id="uptime" name="ups.uptimeString"
												value="<%=bd%>" onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
											<FONT color=#ff0000 id="upMsg"></FONT>
										</TD>

										<TD width="20%" align=right height=30>
											下架日期：
										</TD>
										<%
											String bb = "";
										%>
										<c:if test="${upserver!=null}">
											<c:set var="ttime" value="${upserver.downtime}"
												scope="request"></c:set>
											<%
												java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
															"yyyy-MM-dd");
													bb = formatter.format(request.getAttribute("ttime"));
											%>
										</c:if>
										<TD width="30%" class=category>
											<INPUT
												onblur="checkValueByRules('downtime',['birth'],'downMsg')"
												style="WIDTH: 150px" id="downtime" name="ups.downtimeString"
												value="<%=bb%>"
												onclick="WdatePicker({minDate:'#F{$dp.$D(\'uptime\')||\'2020-10-01\'}'})">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
											<FONT color=#ff0000 id="downMsg"></FONT>
										</TD>

									</TR>

									<TR>
										<TD width="20%" align=right height=30>
											Ip数量：
										</TD>
										<TD width="30%" class=category>
											<INPUT
												onblur="checkValueByRules('serverIpNum',['num'],'serverIpNumMsg')"
												style="WIDTH: 100px" id="serverIpNum" name="ups.ipnum"
												value="${upserver.ipnum }" readonly="readonly">
											<FONT color=#ff0000 id="serverIpNumMsg">*</FONT>
										</TD>
										<TD width="20%" align=right height=30>
											维护口令：
										</TD>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'MpassMsg')"
												style="WIDTH: 200px" id="Mpass" name="ups.maintenancePass"
												value="${upserver.maintenancePass }">
											<FONT color=#ff0000 id="MpassMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="20%" align=right height=30>
											Ip地址：
										</TD>
										<TD class=category colspan="3">
											<INPUT type="text" style="WIDTH: 200px" id="serverIp"
												name="ups.serverIp" value="${upserver.serverIp }" />
											<input type="button" value="选择" onclick="getAllIps()" />
											请单击”选择“按钮&nbsp;&nbsp;
											<FONT color=#ff0000 id="serverIpMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="20%" align=right height=30>
											带宽数量：
										</TD>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'bwCountMsg')"
												style="WIDTH: 200px" id="bandwidthAmount"
												name="ups.bandwidthAmount"
												value="${upserver.bandwidthAmount }">
											<FONT color=#ff0000 id="bwCountMsg"></FONT>
										</TD>

										<TD width="20%" align=right height=30>
											带宽限制：
										</TD>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'bwThroMsg')"
												style="WIDTH: 200px" id="bandwidthThrottling"
												name="ups.bandwidthThrottling"
												value="${upserver.bandwidthThrottling }">
											<FONT color=#ff0000 id="bwThroMsg"></FONT>

										</TD>
									</TR>
									<TR>
										<TD width="20%" align=right>
											上架人员：
										</TD>
										<TD width="30%" class=category>
											<c:if test="${empty upserver}">
												<input id="emp" name="ups.employee.name"
													value="<%=empName%>"
													onblur="checkValueByRules('emp','','empMsg')"
													readonly="readonly">
												<%--
											<input name="upFlag" type="hidden" value=0 />
											<input name="delflag" type="hidden" value=0 />
											--%>
												<input id="empid" name="ups.employee.id" type="hidden"
													value="<%=empId%>" />
												<input name="audtitingFlag" type="hidden" value=0 />
											</c:if>
											<c:if test="${not empty upserver}">
												<input id="emp" name="employee.name"
													value="${upserver.employee.name }"
													onblur="checkValueByRules('emp','','empMsg')">
											</c:if>
										</TD>


										<TD width="20%" align=right>
											备注：
										</TD>
										<TD width="30%" class=category>
											<textarea rows="3" cols="40" id="temp" name="ups.temp">${upserver.temp}</textarea>
										</TD>


									</tr>


									<!-- ytl 8.6新增3个属性 -->
									<tr>
										<td width="20%" align=right>
											交换机名称:
										</td>
										<td>
											<input type="text" style="WIDTH: 200px" id="jhjname"
												name="ups.jhjname" value="${upserver.jhjname}" />
										</td>

										<td width="20%" align="right">
											端口:
										</td>
										<td>
											<input type="text" style="WIDTH: 200px" style="" id="port"
												name="ups.port" value="${upserver.port}" />
										</td>
									</tr>

									<tr>
										<td width="20%" align=right>
											机房&房间名称:
										</td>
										<td>
											<c:if test="${empty upserver}">
												<select id="tuphouse" name="ups.housesAndRooms">
													<option value="0">
														请选择
													</option>
												</select>
											</c:if>
											<c:if test="${upserver !=null}">
												<select id="tuphouse" name="ups.housesAndRooms">
													<option value="${upserver.housesAndRooms }"
														selected="selected">
														${upserver.housesAndRoomsID }
													</option>
												</select>
											</c:if>
										</td>
										<td width="20%" align="right">
											机柜名称:
										</td>
										<td>
											<c:if test="${empty upserver}">
												<input type="hidden" name="ups.marknum" id="marknums" />
												<select
													onblur="checkValueByRules('Tupcabscaid','','cabids')"
													id="Tupcabscaid" name="ups.jgh">
													<option value="0">
														请选择
													</option>
												</select>
											</c:if>
											<!-- 加的 -->
											<c:if test="${upserver!=null }">
												<select
													onblur="checkValueByRules('Tupcabscaid','','cabids')"
													id="Tupcabscaid" name="ups.jgh" onclick="funshow()">
													<c:forEach items="${allcabnt }" var="ct">
														<option value="${ct.caid }"
															<c:if test="${upserver.jgh==ct.caid }">selected</c:if>>
															${ct.caname }
														</option>
													</c:forEach>
												</select>

											</c:if>
											<!-- 结束 -->
											<span id="cabnumbers" style="margin-left: 10px;"></span>
											<c:if test="${upserver!=null }">
												<span id="cabwrite">机柜号:<input type="text"
														name="ups.marknum" id="marknums" readonly="readonly"
														value="${upserver.marknum }" />
												</span>
											</c:if>
											<FONT color=#ff0000 id="cabids"></FONT><font color="red">*</font>

										</td>
									</tr>


									<tr>
										<TD class=category align="center" colspan="4">
											<c:if test="${upserver!=null}">
												<input id="empid" name="ups.employee.id" type="hidden"
													value="${upserver.employee.id }" />
												<input name="ups.upFlag" type="hidden"
													value="${upserver.upFlag }" />
												<input name="ups.delflag" type="hidden"
													value="${upserver.delflag }" />
												<input name="ups.audtitingFlag" type="hidden"
													value="${upserver.audtitingFlag }" />
											</c:if>
											<c:if test="${upserver==null}">
												<input name="ups.upFlag" type="hidden" value="0" />
												<input name="ups.delflag" type="hidden" value="0" />
											</c:if>

											<!-- 
										    <c:if test="${upserver==null}">
											  <INPUT class=button type=button onclick="addOreditUpserver('addUpserver.do')" value="确认添加 ">
											  &nbsp;&nbsp;&nbsp;&nbsp;
										    </c:if>
											<c:if test="${upserver!=null}">
											  <input class="button" type="button" value="确认修改" onclick="addOreditUpserver('editUpserver.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											
											 -->

											<c:if test="${upserver==null}">
												<INPUT class=button type=submit value="确认添加 ">
											  &nbsp;&nbsp;&nbsp;&nbsp;
										    </c:if>
											<c:if test="${upserver!=null}">
												<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>



						</TD>
						<TD>
							<br>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD>
							<br>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
				<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
			</TABLE>


			<!-- 弹出层开始 -->
			<div id="popLayer" style="display: none">
				<span style="padding-left: 20px;"><br />
					<br /> 添加IP &nbsp;&nbsp; </span>
				<table>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td align="right" nowrap class="bg0" nowrap class="bg0"></td>
						<td style="padding-left: 10px;" nowrap class="bg0">
							IP ：
							<input type="text" name="addIp" id="addIp" value="" />
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" nowrap class="bg0">
							&nbsp;
							<font color="red" id="addIpMsg"></font>
						</td>
					</tr>
				</table>
				<br />
				<input type="button" id="commend" onclick="return gteCheckedCb();"
					value="确定" />
				<input type="button" id="qx" onclick="return closeWindow();"
					value="取消" />

			</div>
			<!-- 弹出层结束 -->

			<script type="text/javascript">

	var num = $("#serverIpNum").val();
var ipArray = new Array(num);
var i = 0;
//登陆弹出对话框，并使背景元素不可用
function showWindow(){ 
	var spitnum = $("#serverIp").val();
	var spit = spitnum.split(",");
	var num1 = $("#serverIpNum").val();
	if(num1=="")
	{
		alert("请填写IP数量！");
		return false;
	}
	$("#serverIpMsg").html((spit.length-1)+"/"+num1);
	if((spit.length-1)!=num1)
	{
	 var vid = new Array();
 var ckvid = new Array();
location.href="#";
width = 400;
height = 150;
var windowstr= document.getElementById("popLayer").innerHTML;
document.getElementById("infoDiv").innerHTML=windowstr; 
document.getElementById("infoDiv").style.left=((document.body.clientWidth-width)>0?(document.body.clientWidth-width):0)/2+"px"; 
document.getElementById("infoDiv").style.top=150+"px"; 
document.getElementById("infoDiv").style.zIndex=10001;
document.getElementById("infoDiv").style.width=width; 
document.getElementById("infoDiv").style.height=height; 
document.getElementById("infoDiv").style.border="3px solid #0099ff";
document.getElementById("tranDiv").style.height=document.body.clientHeight+ "px"; 
document.getElementById("tranDiv").style.width=document.body.clientWidth+ "px"; 
document.getElementById("tranDiv").style.display=""; 
document.getElementById("tranDivBack").style.display=""; 
document.getElementById("tranDivBack").style.zIndex=10000;
document.getElementById("infoDiv").style.display=""; 
	}
} 
function closeWindow(){ 
document.getElementById("tranDiv").style.display="none"; 
}

function gteCheckedCb()
{
	var num2 = $("#serverIpNum").val();
	var addIp = $("#addIp").val();
	var ips = $("#serverIp").val();
	if(ips=="")
		{
			ipArray[0] = addIp;
			$("#serverIp").append(addIp+",");
			i++;
			$("#serverIpMsg").html(i+"/"+num2);
			closeWindow();
		}
		else
		{
			var flag = true;
			for(var j=0;j<ipArray.length;j++)
			{
				if(ipArray[j]==addIp)
				{
					$("#addIpMsg").html("您输入的重复的IP，请重新输入！");
					flag = false;
					return ;
				}
			}
			if(flag)
			{
				$("#serverIp").attr("value","");
				$("#serverIp").append(ips+addIp+",");
				i++;
				$("#serverIpMsg").html(i+"/"+num2);
				closeWindow();
			}
		}
}
function resetIp()
{
	var num2 = $("#serverIpNum").val();
	$("#serverIp").attr("value","");
	i=0;
	$("#serverIpMsg").html(i+"/"+num2);
}
			</script>
		</FORM>
		<div id="divfloat"></div>
	</BODY>
</HTML>
