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
<title>立云-后台（自助管理-添加CDN订单）</title>
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
$(document).ready(function(){ 
	 
	  document.getElementById("a1").className = "aBackgroundImage";
	  document.getElementById("a1").style.color= "#000000";
	  
	});
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
          <jsp:include page="/litscloud/ucenter/menu_3.jsp"></jsp:include> 
          <form method=post  action="" >
          <div class="bg_wd">
             <div id="content1">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()" style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">基本配置</a></li>
               <li><a onclick="div2()"  >缓存配置（可选）</a></li>
                <li><a onclick="div3()" >回源配置（可选）</a></li>
               <li><a  onclick="div4()">细节功能（可选）</a></li>
               <li><a  onclick="div5()">防盗链配置（可选）</a></li>
             </ul></div>             
             <div class="cdn_c">
         <div class="dcn_m"> <!-- 头部第一个横列 -->
         <dl>
           <dt>源站域名：</dt><dd><input id="cuRealmName" name="cuRealmName" type="text" class="dcn_yz" value="" onblur="determine()"/></dd><dt>CDN服务开启状态：</dt><dd>
           <select name="" id="switch" class="dcn_fwq" value="this.value" style="display: none" >
							<option value="2" selected="selected">关闭</option>
           </select><input disabled="disabled" value="关闭" style="size: 5px" /></dd>
           
         </dl>
       </div>
       <div class="dcn_c" id="addaddress1">  <!-- 第三个表单输入列表 -->
         <div class="dcn_ct"> <div class="dcn_cl">请 输 入 源 站 IP：</div>
          <div class="dcn_cr dcn_an"><input type="text" value="" id="IP1" name="" onblur="Ipaddress(1)" class="dcn_yz" style="margin-right:10px;" /> 端口： <input type="text" id="duankou1" name="" value="80" class="dcn_yz" style="width:80px; float:none;" /> <sub class="dcn_xib">(有多个IP请点击后面增加按钮)</sub> <a href="javascript:void(0);" style="margin-right:90px;"  onclick="jianshaoIP()">减少</a><a href="javascript:void(0);" onclick="add()">增加</a> </div></div>
          <div class="dcn_ct">
          <div class="dcn_cl">源站服务器机房位置：</div>
          <div class="dcn_cr" ><input type="text" value="" id="IPaddress1" name="" disabled="disabled" class="dcn_yz" style="margin-right:10px;" /> <sub class="dcn_xib" style="float:left; margin-right:10px;">(地址有误请右边选择修正)</sub> <select id="yunyingshang1" name="" value="this.value" class="dcn_fwq">
             <option value="0">运营商</option>
			<option value="华数">华数</option>
			<option value="电信">电信</option>
			<option value="单线">单线</option>
			<option value="联通">联通</option>
			<option value="教育网">教育网</option>
			<option value="移动">移动</option>
			<option value="铁通">铁通</option>
			<option value="网通">网通</option>
			<option value="搜索引擎">搜索引擎</option>
			<option value="分省">分省</option>
			<option value="分大洲">分大洲</option>
			<option value="长城宽带">长城宽带</option>
			<option value="其他">其他</option>
           </select>
           <div  style="display:none">
						<select  id="national1" name="tzfxx[0].tzfgj"
							style="width: 70px;">
							<option>
								国家
							</option>
						</select>
						<select id="national2" name="tzfxx[0].tzfsf"
							style="width: 80px;">
							<option>
								省份、州
							</option>
						</select>
						<select id="national3" name="tzfxx[0].tzfgj"
							style="width: 85px;">
							<option>
								市(区县)
							</option>
						</select>
				</div>
           </div>
           </div>
       </div>
       <div class="dcn_m"> <!-- 第三个表单输入列表 -->
       <dl>
         <dt>月均IP区间数：</dt><dd><input type="text" class="dcn_yz" value="如：1-1.5万" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"  id="IPqujian"  name=""/></dd><dt>月均PV区间数：</dt><dd><input type="text" class="dcn_yz" value="如：1-1.5万" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"   id="PVqujian"  name=""/></dd></dl><dl>
         <dt>附件大小（可选）：</dt><dd><input type="text" class="dcn_yz" value="如：1-4M，5-20M等，论坛博客" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" style="width:190px;"  id="fujiandaxiao"  name="" /></dd><dt>文件大小(可选)：</dt><dd><input type="text" class="dcn_yz" value="如：1-4M，5-20M等，下载类" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" style="width:190px;"  id="wenjiandaxiao"  name="" /></dd>
         </dl><dl>
         <dt>加速地区：</dt><dd><select  id="address" name="" class="dcn_fwq" style="width:190px;">
             <option value="国内加速">国内加速</option>
             <option value="国外加速">国外加速</option>
           </select></dd><dt>备案号：</dt><dd style="height:30px;"><input type="text" class="dcn_yz" value="" id="beianhao" name="" /><span>*国内请输入备案</span></dd></dl><dl>
         <dt>CDN加速需求类型：</dt><dd>
         <s:select onchange="xuanze()" id="yumingleixing" name="realmtypeid" list="#request.realmtypelist" listKey="id" listValue="name" headerKey="0" headerValue="请选择！！"  
					   class="dcn_fwq" style="width:100px;"	 value="%{'',#request.realmtype.name}">
		</s:select>
         <span>仅"纯静态"类型可选"免费"套餐。 </span></dd><dt>套餐选择：</dt><dd><select id="taocanleixing" name="" value="this.value" onchange="xuanze()" class="dcn_fwq" >
             		<option value="4">请选择！！</option>
							<option value="0" >免费</option>
							<option value="1">赠送</option>
							<option value="2">预费</option>
							<option value="3">后费</option>
           </select></dd>
       </dl>
       </div>
       <div class="dcn_ct dcn_top">  <!-- 表格输出 -->
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="dcn_table" id="taocan">
           <tr class="dcn_tr  dcn_hb"><th class="dcn_tcen dcn_th">套餐名称</th><th class="dcn_tcen dcn_th">加速类型</th><th class="dcn_tcen dcn_th">开始时间</th><th class="dcn_tcen dcn_th">结束时间</th><th class="dcn_tcen dcn_th">套餐描述</th><th class="dcn_tcen dcn_th">套餐时长</th><th class="dcn_tcen dcn_th">实际价格</th><th class="dcn_tcen dcn_th">原价</th><th class="dcn_tcen dcn_th">选择</th></tr>  
           </table>        
       </div>                    
      </div>
     </div>
     <div id="content2" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()">基本配置</a></li>
               <li><a onclick="div2()" style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">缓存配置（可选）</a></li>
               <li><a onclick="div3()" >回源配置（可选）</a></li>
               <li><a  onclick="div4()">细节功能（可选）</a></li>
               <li><a  onclick="div5()">防盗链配置（可选）</a></li>
             </ul></div>             
             <div class="cdn_c">             
       <p class="dcn_ct div_ts"><span>提示：</span><br />&nbsp;&nbsp;&nbsp;&nbsp;以下输入缓存规则，(如果不懂操作可以不填写,让我司技术人员为你后台分析填写) </p> <!-- 提示 -->
    <div class="dcn_gz"> <!-- 增加缓存规则 -->
    <span class="dcn_pf dcn_an"> <!-- 按钮浮动 -->
      <a href="javascript:void(0);"  onclick="inserttr()">增加一行</a><a href="javascript:void(0);" onclick="jianshao()">减少一行</a>
    </span>
     <h3>填写缓存规则：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp;操作说明：按照是否缓存——缓存内容(URL/目录/文件类型等)<br />
      &nbsp;&nbsp;&nbsp;&nbsp;缓存时间顺序输入;如果有很多具体需求，请点击"增加一行"功能添加
    </div>
   <div class="dcn_zc dcn_top dcn_ct"> <!-- 增加行表格 -->
       <table width="100%" border="0" cellpadding="0" cellspacing="0" id="hcrule">
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun1" name="" value="this.value" onblur="shifou(this.value,2)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test1" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time1" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei1" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun2" name="" value="this.value" onblur="shifou(this.value,2)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test2" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time2" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei2" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun3" name="" value="this.value" onblur="shifou(this.value,3)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test3" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time3" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei3" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun4" name="" value="this.value" onblur="shifou(this.value,4)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test4" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time4" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei4" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun5" name="" value="this.value" onblur="shifou(this.value,5)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test5" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time5" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei5" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="huancun6" name="" value="this.value" onblur="shifou(this.value,6)" class="dcn_fwq" style="width:120px;"><option value="0">是否缓存</option><option value="1" >缓存</option><option value="2">不缓存</option></select></td>
         <td width="58%" class="dcn_bottom"><input id="test6" name="" type="text" title="CDNrefresh"  value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:530px;" /></td>
         <td width="14%" class="dcn_bottom" ><input id="time6" name="" type="text"  value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:120px;" /> </td>
         <td width="14%" class="dcn_bottom" ><select id="timedanwei6" name="" value="this.value"  class="dcn_fwq" style="width:120px;"><option value="0">时间单位</option><option value="h">小时</option><option value="d">天</option><option value="m">月</option></select></td>
       </tr>
       </table>
   </div>                     
             </div>
             </div>
             
             
             
             <div id="content3" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()">基本配置</a></li>
               <li><a onclick="div2()" >缓存配置（可选）</a></li>
               <li><a onclick="div3()"  style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">回源配置（可选）</a></li>
               <li><a  onclick="div4()">细节功能（可选）</a></li>
               <li><a  onclick="div5()">防盗链配置（可选）</a></li>
             </ul></div>             
             <div class="cdn_c">             
       <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
    <span class="dcn_pf dcn_an" style="margin-top:15px;"> <!-- 按钮浮动 -->
      <a href="javascript:void(0);"  onclick="insert1()">增加一行</a><a href="javascript:void(0);" onclick="jianshao1()">减少一行</a>
    </span>
     <h3>请选择地区：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp;(按照运营商,大地区,回源Ip顺序输入)——（可选择输入）<br />
    </div>
   <div class="dcn_zc dcn_top dcn_ct"> <!-- 增加行表格 -->
       <table width="100%" border="0" cellpadding="0" cellspacing="0" id="hysz">
        <tr class="dcn_tr"><td width="20%" class="dcn_bottom"><select id="operator1" name="" value="this.value" class="dcn_fwq" style="width:180px;">
             <option value="0">请选择运营商！</option>
							<option value="华数">华数</option>
							<option value="电信">电信</option>
							<option value="单线">单线</option>
							<option value="联通">联通</option>
							<option value="教育网">教育网</option>
							<option value="移动">移动</option>
							<option value="铁通">铁通</option>
							<option value="网通">网通</option>
							<option value="搜索引擎">搜索引擎</option>
							<option value="分省">分省</option>
							<option value="分大洲">分大洲</option>
							<option value="长城宽带">长城宽带</option>
           </select> </td><td width="20%" class="dcn_bottom">
           <select id="daaddress1" name="" class="dcn_fwq" style="width:180px;">
             <option value="0">请选择地区！</option>
			<c:forEach items="${disname}" var="dislist">
				<option value="${dislist }">${dislist }</option>
			</c:forEach>
           </select>
           </td><td width="35%" class="dcn_bottom"><input id="huiyuan1" name="" type="text" value="" class="dcn_yz" style="width:330px;" /></td><td width="20%" class="dcn_xib dcn_bottom">回源IP<span>(多个IP请用/分割)</span></td></tr>
       </table>
   </div>  
             </div>
             </div>
             
             
             <div id="content4" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()">基本配置</a></li>
               <li><a onclick="div2()" >缓存配置（可选）</a></li>
               <li><a onclick="div3()" >回源配置（可选）</a></li>
               <li><a  onclick="div4()"  style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">细节功能（可选）</a></li>
               <li><a  onclick="div5()">防盗链配置（可选）</a></li>
             </ul></div>             
             <div class="cdn_c">             
      <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
     <h3>功能测试中：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp; 商业用户请直接提交客服后台配置1.<br />
    </div>
             </div>
             </div>
             
             
             
                 <div id="content5" style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div1()">基本配置</a></li>
               <li><a onclick="div2()" >缓存配置（可选）</a></li>
               <li><a onclick="div3()" >回源配置（可选）</a></li>
               <li><a  onclick="div4()" >细节功能（可选）</a></li>
               <li><a  onclick="div5()"  style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">防盗链配置（可选）</a></li>
             </ul></div>             
             <div class="cdn_c">             
      <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
     <h3>功能测试中：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp; 商业用户请直接提交客服后台配置2.<br />
    </div>
             </div>
             </div>
             
             
             
             
             <div class="cdn_d"> 
                <input id="" name=""  type="button" value="提交"  onclick="addCDN()" class="cdn_sub" />
                <input id="" name="" type="reset" value="重置" class="cdn_sub" />
             </div>
          </div>         
         </form>    
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
   
<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
