<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addcdn.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	<link href="CDN-portal/css/style.css" rel="stylesheet" type="text/css" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function div1(){
	document.getElementById("bsic").style.display="block";
	document.getElementById("cache").style.display="none";
	document.getElementById("back").style.display="none";
	document.getElementById("details").style.display="none";
	document.getElementById("door").style.display="none";	
	}
function div2(){
	document.getElementById("bsic").style.display="none";
	document.getElementById("cache").style.display="block";
	document.getElementById("back").style.display="none";
	document.getElementById("details").style.display="none";
	document.getElementById("door").style.display="none";	
	}	
function div3(){
	document.getElementById("bsic").style.display="none";
	document.getElementById("cache").style.display="none";
	document.getElementById("back").style.display="block";
	document.getElementById("details").style.display="none";
	document.getElementById("door").style.display="none";	
	}
function div4(){
	document.getElementById("bsic").style.display="none";
	document.getElementById("cache").style.display="none";
	document.getElementById("back").style.display="none";
	document.getElementById("details").style.display="block";
	document.getElementById("door").style.display="none";	
	}
function div5(){
	document.getElementById("bsic").style.display="none";
	document.getElementById("cache").style.display="none";
	document.getElementById("back").style.display="none";
	document.getElementById("details").style.display="none";
	document.getElementById("door").style.display="block";	
	}				
</script>
  </head>
  
  <body>
 <div class="bodyer">  <!-- 框架，自动伸长！左右居中！头部居顶 套框架时可以修改样式为float:left -->
   <div class="seactioner">  <!-- 内容里面框架！距离两边，我用里面再加一个div，不怎么喜欢用padding，用padding容易混绕！-->
     <div class="tab-qx" id="bsic"> <!-- 第一个ID开始 -->
       <div class="dcn_tab"><ul>  <!-- 选项卡切换 -->
          <li><span class="dcn_tabl" style="background-color:#a4c606;"><a style="background-image:url(images/cdn_01.jpg);color:#fff;" onclick="div1()">基本配置</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div2()">缓存配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div3()">回源配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div4()">细节功能(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div5()">防盗链配置(可选)</a></span></li>
       </ul></div>
     
       <div class="dcn_m"> <!-- 头部第一个横列 -->
         <dl>
           <dt>源站域名：</dt><dd><input name="yzym" type="text" class="dcn_yz" value="" /></dd><dt>CDN服务开启状态：</dt><dd><select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择</option>
             <option value="开启">开启</option>
             <option value="不开启">不开启</option>
           </select></dd>
         </dl>
       </div>
       <div class="dcn_c">  <!-- 第三个表单输入列表 -->
         <div class="dcn_ct"> <div class="dcn_cl">请 输 入 源 站 IP：</div>
          <div class="dcn_cr dcn_an"><input type="text" value="" name="yzip" class="dcn_yz" style="margin-right:10px;" /> 端口： <input type="text" name="dk" value="" class="dcn_yz" style="width:80px; float:none;" /> <sub class="dcn_xib">(有多个IP请点击后面增加按钮)</sub> <a href="#">增加</a> <a href="#">减少</a></div></div>
          <div class="dcn_ct">
          <div class="dcn_cl">源站服务器机房位置：</div>
          <div class="dcn_cr"><input type="text" value="" name="jfwz" class="dcn_yz" style="margin-right:10px;" /> <sub class="dcn_xib" style="float:left; margin-right:10px;">(地址有误请右边选择修正)</sub> <select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择</option>
             <option value="运营商">运营商</option>
             <option value="开发商">不开启</option>
           </select> </div>
           </div>
       </div>
       <div class="dcn_m"> <!-- 第三个表单输入列表 -->
       <dl>
         <dt>月均IP区间数：</dt><dd><input type="text" class="dcn_yz" value="如：1-1.5万" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"  name="ipqjs"/></dd><dt>月均PV区间数：</dt><dd><input type="text" class="dcn_yz" value="如：1-1.5万" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"   name="pvqjs"/></dd></dl><dl>
         <dt>附件大小（可选）：</dt><dd><input type="text" class="dcn_yz" value="如：1-4M，5-20M等，论坛博客" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" style="width:190px;"  name="fjdx"/></dd><dt>文件大小(可选)：</dt><dd><input type="text" class="dcn_yz" value="如：1-4M，5-20M等，下载类" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" style="width:190px;"  name="wjdx"/></dd>
         </dl><dl>
         <dt>加速地区：</dt><dd><select id="dcn_jsdq" class="dcn_fwq" name="jsdq" style="width:190px;">
             <option selected="selected">请选择</option>
             <option value="国内加速">国内加速</option>
             <option value="国外加速">国外加速</option>
           </select></dd><dt>备案号：</dt><dd style="height:30px;"><input type="text" class="dcn_yz" value="" name="bah" /><span>*国内请输入备案</span></dd></dl><dl>
         <dt>CDN加速需求类型：</dt><dd><select id="dcn_xql" name="dcn_xql" class="dcn_fwq" style="width:100px;">
             <option selected="selected">请选择</option>
             <option value="类型1">类型1</option>
             <option value="类型2">类型2</option>
           </select><span>仅"纯静态"类型可选"免费"套餐。 </span></dd><dt>套餐选择：</dt><dd><select id="dcn_xql" name="dcn_tc" class="dcn_fwq" >
             <option selected="selected">请选择</option>
             <option value="套餐1">套餐1</option>
             <option value="套餐2">套餐2</option>
           </select></dd>
       </dl>
       </div>
       <div class="dcn_ct dcn_top">  <!-- 表格输出 -->
           <table width="100%" border="0" cellpadding="0" cellspacing="0" class="dcn_table" >
           <tr class="dcn_tr  dcn_hb"><th class="dcn_tcen dcn_th">套餐名称</th><th class="dcn_tcen dcn_th">加速类型</th><th class="dcn_tcen dcn_th">开始时间</th><th class="dcn_tcen dcn_th">结束时间</th><th class="dcn_tcen dcn_th">套餐描述</th><th class="dcn_tcen dcn_th">套餐时长</th><th class="dcn_tcen dcn_th">实际价格</th><th class="dcn_tcen dcn_th">原价</th></tr>  
           <tr><td class="dcn_td dcn_tcen">免费</td><td class="dcn_td dcn_tcen">纯静态</td><td class="dcn_td dcn_tcen">2013-06-12</td><td class="dcn_td dcn_tcen">2013-08-15</td><td class="dcn_td dcn_tcen">暖气进睦人日常工作是不进行朝野....</td><td class="dcn_td dcn_tcen">1年</td><td class="dcn_td dcn_tcen">656</td><td class="dcn_td dcn_tcen">950</td></tr> 
           <tr><td class="dcn_td dcn_tcen">免费</td><td class="dcn_td dcn_tcen">纯静态</td><td class="dcn_td dcn_tcen">2013-06-12</td><td class="dcn_td dcn_tcen">2013-08-15</td><td class="dcn_td dcn_tcen">暖气进睦人日常工作是不进行朝野....</td><td class="dcn_td dcn_tcen">1年</td><td class="dcn_td dcn_tcen">656</td><td class="dcn_td dcn_tcen">950</td></tr>  
           <tr><td class="dcn_td dcn_tcen">免费</td><td class="dcn_td dcn_tcen">纯静态</td><td class="dcn_td dcn_tcen">2013-06-12</td><td class="dcn_td dcn_tcen">2013-08-15</td><td class="dcn_td dcn_tcen">暖气进睦人日常工作是不进行朝野....</td><td class="dcn_td dcn_tcen">1年</td><td class="dcn_td dcn_tcen">656</td><td class="dcn_td dcn_tcen">950</td></tr>  
           <tr><td class="dcn_td dcn_tcen">免费</td><td class="dcn_td dcn_tcen">纯静态</td><td class="dcn_td dcn_tcen">2013-06-12</td><td class="dcn_td dcn_tcen">2013-08-15</td><td class="dcn_td dcn_tcen">暖气进睦人日常工作是不进行朝野....</td><td class="dcn_td dcn_tcen">1年</td><td class="dcn_td dcn_tcen">656</td><td class="dcn_td dcn_tcen">950</td></tr>  
           <tr><td class="dcn_td dcn_tcen">免费</td><td class="dcn_td dcn_tcen">纯静态</td><td class="dcn_td dcn_tcen">2013-06-12</td><td class="dcn_td dcn_tcen">2013-08-15</td><td class="dcn_td dcn_tcen">暖气进睦人日常工作是不进行朝野....</td><td class="dcn_td dcn_tcen">1年</td><td class="dcn_td dcn_tcen">656</td><td class="dcn_td dcn_tcen">950</td></tr>          
           </table>        
       </div>             
       </div>  <!-- 基本配置完毕 -->      
       
       
       <div class="tab-qx" id="cache" style="display:none;"> <!-- 第二个ID开始 -->
       <div class="dcn_tab"><ul>  <!-- 选项卡切换 -->
          <li><span class="dcn_tabl" ><a onclick="div1()">基本配置</a></span></li>
          <li><span class="dcn_tabl" style="background-color:#a4c606;"><a onclick="div2()"  style="background-image:url(images/cdn_01.jpg);color:#fff;">缓存配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div3()">回源配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div4()">细节功能(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div5()">防盗链配置(可选)</a></span></li>
       </ul></div>
     
       <p class="dcn_ct div_ts"><span>提示：</span><br />&nbsp;&nbsp;&nbsp;&nbsp;以下输入缓存规则，(如果不懂操作可以不填写,让我司技术人员为你后台分析填写) </p> <!-- 提示 -->
    <div class="dcn_gz"> <!-- 增加缓存规则 -->
    <span class="dcn_pf dcn_an"> <!-- 按钮浮动 -->
      <a href="#">增加一行</a><a href="#">减少一行</a>
    </span>
     <h3>填写缓存规则：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp;操作说明：按照是否缓存——缓存内容(URL/目录/文件类型等)<br />
      &nbsp;&nbsp;&nbsp;&nbsp;缓存时间顺序输入;如果有很多具体需求，请点击"增加一行"功能添加
    </div>
   <div class="dcn_zc dcn_top dcn_ct"> <!-- 增加行表格 -->
       <table width="794" border="0" cellpadding="0" cellspacing="0">
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">是否缓存</option><option value="是">是</option><option value="否">否</option></select></td>
         <td width="58%" class="dcn_bottom"><input type="text" name="text_srgz" value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:450px;" /></td>
         <td width="14%" class="dcn_bottom" ><input type="text" name="text_srgz" value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:90px;" /> </td>
         <td width="14%"><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">时间单位</option><option value="月">月</option><option value="年">年</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">是否缓存</option><option value="是">是</option><option value="否">否</option></select></td>
         <td width="58%" class="dcn_bottom"><input type="text" name="text_srgz" value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:450px;" /></td>
         <td width="14%" class="dcn_bottom" ><input type="text" name="text_srgz" value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:90px;" /> </td>
         <td width="14%"><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">时间单位</option><option value="月">月</option><option value="年">年</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">是否缓存</option><option value="是">是</option><option value="否">否</option></select></td>
         <td width="58%" class="dcn_bottom"><input type="text" name="text_srgz" value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:450px;" /></td>
         <td width="14%" class="dcn_bottom" ><input type="text" name="text_srgz" value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:90px;" /> </td>
         <td width="14%"><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">时间单位</option><option value="月">月</option><option value="年">年</option></select></td>
       </tr>
       <tr class="dcn_tr">
         <td width="14%"  class="dcn_bottom" ><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">是否缓存</option><option value="是">是</option><option value="否">否</option></select></td>
         <td width="58%" class="dcn_bottom"><input type="text" name="text_srgz" value="输入缓存规则，文件类型：[任意字符].(bmq\jpg\png\gif\css\js)" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:450px;" /></td>
         <td width="14%" class="dcn_bottom" ><input type="text" name="text_srgz" value="输入数字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="dcn_yz" style="width:90px;" /> </td>
         <td width="14%"><select id="dcn_fwq" class="dcn_fwq" style="width:95px;"><option selected="selected">时间单位</option><option value="月">月</option><option value="年">年</option></select></td>
       </tr>
       </table>
   </div>              
       </div>   <!-- 缓存配置完毕 -->
       
       
       
        <div class="tab-qx" id="back" style="display:none;"> <!-- 第三个ID开始 -->
       <div class="dcn_tab"><ul>  <!-- 选项卡切换 -->
          <li><span class="dcn_tabl" ><a onclick="div1()">基本配置</a></span></li>
          <li><span class="dcn_tabl" ><a onclick="div2()">缓存配置(可选)</a></span></li>
          <li><span class="dcn_tabl" style="background-color:#a4c606;"><a onclick="div3()" style="background-image:url(images/cdn_01.jpg);color:#fff;">回源配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div4()">细节功能(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div5()">防盗链配置(可选)</a></span></li>
       </ul></div>
     
       <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
    <span class="dcn_pf dcn_an" style="margin-top:15px;"> <!-- 按钮浮动 -->
      <a href="#">增加一行</a><a href="#">减少一行</a>
    </span>
     <h3>请选择地区：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp;(按照运营商,大地区,回源Ip顺序输入)——（可选择输入）<br />
    </div>
   <div class="dcn_zc dcn_top dcn_ct"> <!-- 增加行表格 -->
       <table width="794" border="0" cellpadding="0" cellspacing="0">
        <tr class="dcn_tr"><td width="20%" class="dcn_bottom"><select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择运营商</option>
             <option value="电信">电信</option>
             <option value="联通">联通</option>
           </select> </td><td width="20%" class="dcn_bottom">
           <select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择地区</option>
             <option value="广州">广州</option>
             <option value="湖南">湖南</option>
           </select>
           </td><td width="35%" class="dcn_bottom"><input type="text" value="" name="text_sr" class="dcn_yz" style="width:270px;" /></td><td width="20%" class="dcn_xib dcn_bottom">回源IP<span>(多个IP请用/分割)</span></td></tr>
           <tr class="dcn_tr"><td width="20%" class="dcn_bottom"><select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择运营商</option>
             <option value="电信">电信</option>
             <option value="联通">联通</option>
           </select> </td><td width="20%" class="dcn_bottom">
           <select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择地区</option>
             <option value="广州">广州</option>
             <option value="湖南">湖南</option>
           </select>
           </td><td width="35%" class="dcn_bottom"><input type="text" value="" name="text_sr" class="dcn_yz" style="width:270px;" /></td><td width="20%" class="dcn_xib dcn_bottom">回源IP<span>(多个IP请用/分割)</span></td></tr>
           <tr class="dcn_tr"><td width="20%" class="dcn_bottom"><select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择运营商</option>
             <option value="电信">电信</option>
             <option value="联通">联通</option>
           </select> </td><td width="20%" class="dcn_bottom">
           <select id="dcn_fwq" class="dcn_fwq">
             <option selected="selected">请选择地区</option>
             <option value="广州">广州</option>
             <option value="湖南">湖南</option>
           </select>
           </td><td width="35%" class="dcn_bottom"><input type="text" value="" name="text_sr" class="dcn_yz" style="width:270px;" /></td><td width="20%" class="dcn_xib dcn_bottom">回源IP<span>(多个IP请用/分割)</span></td></tr>       
       </table>
   </div>  
       </div>   <!-- 回源配置 -->
       
       
       
               <div class="tab-qx" id="details" style="display:none;"> <!-- 第四个ID开始 -->
       <div class="dcn_tab"><ul>  <!-- 选项卡切换 -->
          <li><span class="dcn_tabl" ><a onclick="div1()">基本配置</a></span></li>
          <li><span class="dcn_tabl" ><a onclick="div2()">缓存配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div3()" >回源配置(可选)</a></span></li>
          <li><span class="dcn_tabl"  style="background-color:#a4c606;"><a onclick="div4()" style="background-image:url(images/cdn_01.jpg);color:#fff;">细节功能(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div5()">防盗链配置(可选)</a></span></li>
       </ul></div>     
        <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
     <h3>功能测试中：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp; 商业用户请直接提交客服后台配置.<br />
    </div>
       </div>   <!-- 细节功能完毕 -->
       
       
       
           <div class="tab-qx" id="door" style="display:none;"> <!-- 第四个ID开始 -->
       <div class="dcn_tab"><ul>  <!-- 选项卡切换 -->
          <li><span class="dcn_tabl" ><a onclick="div1()">基本配置</a></span></li>
          <li><span class="dcn_tabl" ><a onclick="div2()">缓存配置(可选)</a></span></li>
          <li><span class="dcn_tabl"><a onclick="div3()" >回源配置(可选)</a></span></li>
          <li><span class="dcn_tabl"  ><a onclick="div4()" >细节功能(可选)</a></span></li>
          <li><span class="dcn_tabl" style="background-color:#a4c606;"><a onclick="div5()" style="background-image:url(images/cdn_01.jpg);color:#fff;">防盗链配置(可选)</a></span></li>
       </ul></div>
     
        <div class="dcn_gz dcn_top"> <!-- 增加缓存规则 -->
     <h3>功能测试中：</h3>
      &nbsp;&nbsp;&nbsp;&nbsp; 商业用户请直接提交客服后台配置.<br />
    </div>
       </div>   <!-- 防盗链配置完毕 -->
       
       
       
       
       
       
       
       
       
       
   <div class="dcn_d">
         <input name="tj" type="submit" value="提交" class="dcn_submit"  />
      <input name="cz" type="reset" class="dcn_submit" value="重置"  />
      </div>
   </div>
</div>
  </body>
</html>
