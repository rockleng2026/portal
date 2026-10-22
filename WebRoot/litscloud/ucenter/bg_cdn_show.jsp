<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-CDN订单详细）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/handlejson.js"></script>
<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/cascadingmenu.js"></script>
<script type="text/javascript" 	src="litscloud/js/cdn.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->

<script type="text/javascript">
function openService(id,num)
{
	$.post("openServiceCDNsaleOrderAction.do",{id:id,num:num},function(data){
		if(data==0&&num==1)
		{
			alert("开启成功");
			location.reload();
		}
		else if(data==0&&num==2)
		{
			alert("关闭成功");
			location.reload();
		}
		else if(num==1)
		{
			 alert("开启失败");
			 location.reload();
		}
		else
		{
			 alert("关闭失败");
			 location.reload();
		}
	});
}
</script>


</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->
	<div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="<%=path %>/index.html" target="_parent">首页</a>>会员中心</div> 
          <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
          <div class="bg_wd" > <!-- 945框架 -->
             <div class="ly_xxt"> 
               <div class="ly_xxtl">CDN订单详情</div>        
             </div>
              <!-- 详情内容开始 -->
              <div class="cdn_li">  <!-- 基本信息 -->
                <div class="cdn_li_t">基本信息</div>
                <div class="cdn_li_c"><img src="litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="cdn_li_m">
                <dl><dt>CDN编号：</dt><dd>${cdnsale.saleOrderNo }</dd><dt>申请时间：</dt><dd>${cdnsale.time }</dd></dl>
                <dl><dt>IP区间数：</dt><dd>${cdnsale.IPinterval}</dd><dt>PV区间数：</dt><dd>${cdnsale.PVinterval}</dd></dl>
                <dl><dt>附件平均数：</dt><dd>${cdnsale.accessoryfile }</dd><dt>多数文件大小：</dt><dd>${cdnsale.mostfile}</dd></dl>
                <dl><dt>加速：</dt><dd>${jiasu }</dd><dt>备案号：</dt><dd>${cdnsale.recordsNO}</dd></dl>
                <dl><dt>开始运行时间：</dt><dd><c:if test="${cdnsale.starttime == null || cdnsale.starttime =='' }">暂无</c:if>${cdnsale.starttime }</dd><dt>结束运行时间：</dt><dd><c:if test="${cdnsale.endtime == null || cdnsale.endtime =='' }">暂无</c:if>${cdnsale.endtime }</dd></dl>
                <dl><dt>实际价格：</dt><dd><span>${cdnsale.price }</span>元</dd>
                <dt>付费类型：</dt><dd>
                <c:if test="${cdnsale.setmeal.chargeType==0 }">免费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==1 }">赠送</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==2 }">预付费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==3 }">后付费</c:if>
                </dd></dl>
                <dl><dt>服务状态：</dt><dd>
                <c:if test="${cdnsale.serverFlag=='1' }">开启</c:if>
				<c:if test="${cdnsale.serverFlag=='2' }">关闭</c:if>
				<c:if test="${cdnsale.auditingState==1 }">
					
					<c:if test="${cdnsale.writeflag==1}">
					<c:if test="${cdnsale.serverFlag==2 }">
						<input type="button" value="开启服务"  onclick="openService(${cdnsale.id},1)"/>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${cdnsale.auditingState==1 }">
					
					<c:if test="${cdnsale.writeflag==1}">
				<c:if  test="${cdnsale.serverFlag==1 }"> 
					<input type="button" value="关闭服务"  onclick="openService(${cdnsale.id},2)"/>
					</c:if>
				</c:if>
				</c:if>
				</dd>
                <dt>审核状态：</dt><dd>
                <c:if test="${cdnsale.auditingState==0 }">未审核</c:if>
				<c:if test="${cdnsale.auditingState==1 }">审核通过</c:if>
				<c:if test="${cdnsale.auditingState==2 }">审核未通过</c:if>
				<c:if test="${cdnsale.auditingState==8 }">审核中</c:if>
                </dd></dl>
                <dl><dt>客户域名：</dt><dd>${cdnsale.cuRealmName }</dd><dt>系统域名：</dt><dd>${cdnsale.syRealmName }</dd></dl>
                <dl><dt>套餐名：</dt><dd>${cdnsale.setmeal.name }</dd><dt>域名类型：</dt><dd>${cdnsale.setmeal.realmtype.name }</dd></dl>
                <dl><dt>套餐描述：</dt><dd style="width:795px;">${cdnsale.setmeal.describe }</dd></dl>
                </div>
              </div>
              
              <div class="cdn_li">  <!-- 套餐详情1 -->
                <div class="cdn_li_t">套餐详情</div>
                <div class="cdn_li_c"><img src="litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="cdn_li_d">
                    <table width="945" border="0" cellpadding="0" cellspacing="0" class="cnd_li_table">
                      <tr style="background-color:#dcdcdc;"><th width="25%">名称</th><th width="25%">流量</th><th width="25%">带宽</th><th width="25%" style="border-radius:0px 5px 0px 0px;">HIT连接数</th></tr>
                      <c:forEach items="${property}" var="datapro" varStatus="s">
                      <tr <c:if test="${(s.index %2)==1}">style="background:#f6f6f6;"</c:if> ><td>${datapro.name }</td><td>${datapro.flow }</td><td>${datapro.bandwidth }</td><td>${datapro.hitnum }</td></tr>
                      </c:forEach>
                   </table>
                </div>
              </div>
           
             <div class="cdn_li">  <!-- 套餐详情2	 -->
                <div class="cdn_li_t">域名IP</div>
                <div class="cdn_li_c"><img src="litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="cdn_li_d">
                    <table width="945" border="0" cellpadding="0" cellspacing="0" class="cnd_li_table">
                      <tr style="background-color:#dcdcdc;"><th width="25%">IP</th><th width="25%">端口</th><th width="25%">IP所在地</th><th width="25%" style="border-radius:0px 5px 0px 0px;">运营商</th></tr>
                      <c:forEach items="${cdnlist}" var="cdnip" varStatus="s">
                      <tr <c:if test="${(s.index %2)==1}">style="background:#f6f6f6;"</c:if>><td>${cdnip.ip}</td><td>${cdnip.port}</td><td>${cdnip.address}</td><td>${cdnip.tmoblie }</td></tr>
                      </c:forEach>
                    </table>
                </div>
              </div>
              
              
              
                <div class="cdn_li">  <!-- 缓存规则	 -->
                <div class="cdn_li_t">缓存规则</div>
                <div class="cdn_li_c"><img src="litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="cdn_li_d">
                    <table width="945" border="0" cellpadding="0" cellspacing="0" class="cnd_li_table">
                      <tr style="background-color:#dcdcdc;"><th width="15%">是否缓存</th><th width="70%">缓存内容</th><th width="15%" style="border-radius:0px 5px 0px 0px;">缓存时间</th></tr>
                      <c:if test="${cachelist==null}">
				 		<tr>
							<td colspan="3">没有缓存规则！！！</td>
						</tr>
					</c:if>
					<c:forEach items="${cachelist}" var="datacache" varStatus="s">
						<tr <c:if test="${(s.index %2)==1}">style="background:#f6f6f6;"</c:if>>
						<td>
							<c:if test="${datacache.cacheflag==1 }">缓存</c:if>
							<c:if test="${datacache.cacheflag==2 }">不缓存</c:if>
						</td><td>${datacache.cachecontent }</td><td><span>${datacache.contentime }</span></td></tr>
					</c:forEach>
                    </table>
                </div>
              </div>
              
              
              
                 <div class="cdn_li">  <!-- 回源IP	 -->
                <div class="cdn_li_t">回源IP</div>
                <div class="cdn_li_c"><img src="litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="cdn_li_d">
                    <table width="945" border="0" cellpadding="0" cellspacing="0" class="cnd_li_table">
                      <tr style="background-color:#dcdcdc;"><th width="25%">运营商</th><th width="25%">大地区</th><th width="50%" style="border-radius:0px 5px 0px 0px;">回源IP</th></tr>
                      <c:if test="${districtlist==null}">
                      <tr>
						<td colspan="3">没有回源IP！！！</td>
						</tr>
					  </c:if>
					<c:forEach items="${districtlist}" var="datadis" varStatus="s">
					<tr  <c:if test="${(s.index %2)==1}">style="background:#f6f6f6;"</c:if>><td>${datadis.tmoblie }</td><td>${datadis.districtName }</td><td>${datadis.ip }</td></tr>
					</c:forEach>
					</table>
                </div>
              </div>
             <div class="cdn_an"> <!-- 返回按钮 -->
                <div class="cdn_ann"><a href="javascript:history.go(-1);">返 回</a></div>
             </div> 
              
              
          </div>         
               
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
   
<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
