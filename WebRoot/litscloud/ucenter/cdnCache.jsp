<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-CDN缓存刷新</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/litscloud/js/updateCU.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCo	mmand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
$(document).ready(function(){
    
    document.getElementById("a5").className = "aBackgroundImage";
	  document.getElementById("a5").style.color= "#000000";
});
function div1(){
	document.getElementById("div1").style.display="block";
	document.getElementById("div2").style.display="none";
	document.getElementById("div3").style.display="none";
	document.getElementById("div4").style.display="none";
	document.getElementById("div5").style.display="none";	
	}
function div2(){
	document.getElementById("div2").style.display="block";
	document.getElementById("div1").style.display="none";
	document.getElementById("div3").style.display="none";
	document.getElementById("div4").style.display="none";
	document.getElementById("div5").style.display="none";	
	}
function div3(){
	document.getElementById("div3").style.display="block";
	document.getElementById("div2").style.display="none";
	document.getElementById("div1").style.display="none";
	document.getElementById("div4").style.display="none";
	document.getElementById("div5").style.display="none";	
	}
function div4(){
	document.getElementById("div4").style.display="block";
	document.getElementById("div2").style.display="none";
	document.getElementById("div3").style.display="none";
	document.getElementById("div1").style.display="none";
	document.getElementById("div5").style.display="none";	
	}
function div5(){
	document.getElementById("div5").style.display="block";
	document.getElementById("div2").style.display="none";
	document.getElementById("div3").style.display="none";
	document.getElementById("div4").style.display="none";
	document.getElementById("div1").style.display="none";	
	}
function addCdnCache(num){
	var  yuming=document.getElementById("yuming"+num+"").value;
	var  neirong1=document.getElementById("neirong"+num+"").value;
	var neirong=encodeURI(neirong1);
	var Expression=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
		var objExp=new RegExp(Expression);
		if(objExp.test(yuming)==false){
			alert("域名不合法");
			return;
		}
		if(neirong==''||neirong==null)
		{
			alert("内容不能为空");
			return;
			}
		if(num==1||num==3||num==5)
		{
			if(neirong.indexOf(".")<0)
			{	
				alert("文件名称错误");
				return;			
				}	
			}
	$.post("clearCache2mission.Action",{
	 		name:yuming,
	 		urllist:neirong,
	 		type:num},function(data){
		if(data=='0')
		{
			alert("操作成功");
		location.reload();
		}
		else if(data=='1')
		{
			alert("网络错误");
			location.reload();
		}
		else if(data=='2')
		{
			alert("参数错误");
			location.reload();
		}
		else if(data=='3')
		{
			alert("服务未开启");
			location.reload();
			}
		else if(data=='4')
		{
			alert("服务器出错！！请稍后在试");
			location.reload();
			}
	 		});
}
</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <!-- 菜单1S -->
          <jsp:include page="/litscloud/ucenter/menu_3.jsp"></jsp:include>
          <!-- 菜单1E -->
          <div class="bg_d">
              <div class="bg_wd">
             <div id="div1">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" style="background-image:url(<%=path %>/litscloud/images/cdn_01.gif); color:#fff;">文件刷新</a></li>
               <li><a onclick="div2()"  >目录刷新</a></li>
               <li><a onclick="div3()"  >删除文件</a></li>
               <li><a onclick="div4()"  >删除目录</a></li>
               <li><a onclick="div5()"  >增加文件刷新</a></li>
             </ul></div>             
             <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">刷新文件：文件以/开头。 <span>例如：/cms/old.html</span><br />
             
             <select id="yuming1" name="yuming1" value="this.value">
             	<option value="0">请选择</option>
             	<c:forEach items="${cdnSaleOrder}" var="data">
             	<option value="http://${data.cuRealmName }">http://${data.cuRealmName }</option>	
             	</c:forEach>
             </select>
             
             <span>注意：推送的内容要区分大小写！ (多个地址请用|分割)</span></div>              
              <div class="ugx_m"><textarea class="ugx_text" id="neirong1"></textarea></div>
              <!-- 
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei1" value="是" /> <label>是</label><input type="radio" value="否" name="nei1"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times1" id="times1" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>     
               -->          
             </div>
             <div class="cdn_d"> 
                <input type="button" value="提 交" onclick="addCdnCache(1)" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
             </div>
             </div>
             
             
               <div id="div2" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" >文件刷新</a></li>
               <li><a onclick="div2()" style="background-image:url(<%=path %>/litscloud/images/cdn_01.gif); color:#fff;" >目录刷新</a></li>
               <li><a onclick="div3()"  >删除文件</a></li>
               <li><a onclick="div4()"  >删除目录</a></li>
               <li><a onclick="div5()"  >增加文件刷新</a></li>
             </ul></div>             
               <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">目录刷新：目录以/开头。 <span>例如：/cms/old</span><br />
             <select id="yuming2" name="yuming2" value="this.value">
             	<option value="0">请选择</option>
             	<c:forEach items="${cdnSaleOrder}" var="data">
             	<option value="http://${data.cuRealmName }">http://${data.cuRealmName }</option>	
             	</c:forEach>
             </select><span>注意：推送的内容要区分大小写！(多个地址请用|分割)</span></div>              
              <div class="ugx_m"><textarea class="ugx_text" id="neirong2"></textarea></div>
              <!-- 
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei2" value="是" /> <label>是</label><input type="radio" value="否" name="nei2"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times1" id="times1" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>     
               -->              
             </div>
             <div class="cdn_d"> 
                <input type="submit" value="提 交" onclick="addCdnCache(2)" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
             </div>
             </div>
             <div id="div3" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" >文件刷新</a></li>
               <li><a onclick="div2()" >目录刷新</a></li>
               <li><a onclick="div3()"  style="background-image:url(<%=path %>/litscloud/images/cdn_01.gif); color:#fff;" >删除文件</a></li>
               <li><a onclick="div4()"  >删除目录</a></li>
               <li><a onclick="div5()"  >增加文件刷新</a></li>
             </ul></div>             
               <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">删除文件：文件以/开头。 <span>例如：/cms/old.html</span><br />
             <select id="yuming3" name="yuming3" value="this.value">
             	<option value="0">请选择</option>
             	<c:forEach items="${cdnSaleOrder}" var="data">
             	<option value="http://${data.cuRealmName }">http://${data.cuRealmName }</option>	
             	</c:forEach>
             </select><span>注意：推送的内容要区分大小写！(多个地址请用|分割)</span></div>              
              <div class="ugx_m"><textarea class="ugx_text" id="neirong3"></textarea></div>
              <!-- 
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei3" value="是" /> <label>是</label><input type="radio" value="否" name="nei3"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times1" id="times1" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>     
               -->               
             </div>
             <div class="cdn_d"> 
                <input type="submit" value="提 交" onclick="addCdnCache(3)" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
             </div>
             </div>
             <div id="div4" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" >文件刷新</a></li>
               <li><a onclick="div2()"  >目录刷新</a></li>
               <li><a onclick="div3()"  >删除文件</a></li>
               <li><a onclick="div4()" style="background-image:url(<%=path %>/litscloud/images/cdn_01.gif); color:#fff;"  >删除目录</a></li>
               <li><a onclick="div5()"  >增加文件刷新</a></li>
             </ul></div>             
               <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">删除目录：目录以/开头。 <span>例如：/old</span><br />
             <select id="yuming4" name="yuming4" value="this.value">
             	<option value="0">请选择</option>
             	<c:forEach items="${cdnSaleOrder}" var="data">
             	<option value="http://${data.cuRealmName }">http://${data.cuRealmName }</option>	
             	</c:forEach>
             </select><span>注意：推送的内容要区分大小写！(多个地址请用|分割)</span></div>              
              <div class="ugx_m"><textarea class="ugx_text" id="neirong4"></textarea></div>
              <!-- 
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei4" value="是" /> <label>是</label><input type="radio" value="否" name="nei4"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times1" id="times1" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>     
               -->              
             </div>
             <div class="cdn_d"> 
                <input type="submit" value="提 交" onclick="addCdnCache(4)" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
             </div>
             </div>
             <div id="div5" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" >文件刷新</a></li>
               <li><a onclick="div2()" >目录刷新</a></li>
               <li><a onclick="div3()"  >删除文件</a></li>
               <li><a onclick="div4()"  >删除目录</a></li>
               <li><a onclick="div5()" style="background-image:url(<%=path %>/litscloud/images/cdn_01.gif); color:#fff;"  >新增缓存文件</a></li>
             </ul></div>             
               <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">新增缓存文件：文本框的内容以/开头。 <span>例如：/index.html</span><br />
             <select id="yuming5" name="yuming5" value="this.value">
             	<option value="0">请选择</option>
             	<c:forEach items="${cdnSaleOrder}" var="data">
             	<option value="http://${data.cuRealmName }">http://${data.cuRealmName }</option>	
             	</c:forEach>
             </select>
             <span>注意：推送的内容要区分大小写！(多个地址请用|分割 eg /index.html|flist.html)</span></div>              
              <div class="ugx_m"><textarea class="ugx_text" id="neirong5"></textarea></div>
              <!-- 
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei5" value="是" /> <label>是</label><input type="radio" value="否" name="nei5"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times1" id="times1" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>     
               -->              
             </div>
             <div class="cdn_d"> 
                <input type="submit" value="提 交" onclick="addCdnCache(5)" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
             </div>
             </div>
             <div>
              <div> 
                <table width="100%"  border=1 cellSpacing=1 cellPadding=4
										align="center"  style="font-size: 14px;">
									<tr align="center">
										<td width="8%">
										 操作人
										</td>
										<td width="15%">
										 缓存域名
										</td>
										<td width="22%">
										 缓存内容
										</td>
										<td width="10%">
										操作功能
										</td>
										<td width="15%">
										地域、线路
										</td>
										<td width="10%">
										操作结果
										</td>
										<td width="20%">
										 操作时间
										</td>
									</tr>
										<c:forEach items="${updatecache}" var="data">
										
										<tr align="center">
										<td >
										 <c:if test="${data.customer==null}">公司内部人员</c:if>
													<c:if test="${data.customer!=null}">${data.customer.realName}</c:if>
										</td>
										<td >
										${data.domain }
										</td>
										<td >
											${data.content }
										</td>
										<td>
											${data.tmp }
										</td>
										<td>
											${data.tmp1 }
										</td>
										<td >
										<c:if test="${data.result=='0'}">处理成功</c:if>
													<c:if test="${data.result=='-1'}">网络错误</c:if>
													<c:if test="${data.result=='-2'}">参数错误</c:if>
													<c:if test="${data.result=='-3'}">网络出错</c:if>
													<c:if test="${data.result=='-4'}">服务出错</c:if>
													<c:if test="${data.result=='1'}">服务未开启</c:if>
													<c:if test="${data.result=='500'}">服务器错误</c:if>
										</td>
										<td >
										 ${data.time }
										</td>
									</tr>
											</c:forEach>
									</table>
             </div>
             </div>
             </div>
      </div>  
    </div>
   </div>
<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
