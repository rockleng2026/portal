<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
 <div class="footer">
<div class="footer-n">
<ul class="ul1">
	<li class="li1">Links</li>
    <li class="li2">业务管理平台</li>
    <li class="li-a"><a href="#">在线工单</a></li>
    <li class="li-a"><a href="#">咨询帮助</a></li>
    <li class="li-a"><a href="#">充值付费</a></li>
    <li class="li-a"><a href="#">合作投资</a></li>
    <li class="li-a"><a href="#">培训交流</a></li>
</ul>
<ul class="ul1 ul2">
	<li class="li1">Navigate</li>
    <li class="li2">方案中心</li>
    <li class="li-a"><a href="#">游戏行业方案</a></li>
    <li class="li-a"><a href="#">小微企业方案</a></li>
    <li class="li-a"><a href="#">政府单位方案</a></li>
    <li class="li-a"><a href="#">文公平台方案</a></li>
    <li class="li-a"><a href="#">家庭个人方案</a></li>
</ul>
<ul class="ul1 ul3">
	<li class="li1">Superiority</li>
    <li class="li2">关注并推荐我们</li>
    <li class="li-text"><a href="#">现在我们陆续开通各手机、PC、平台业务
平台，您可以通过关注和转发我们的微博、
微信，获取最新产品和方案，并且可以通过
推荐客户和推荐人才到我司领取神秘大礼包
（万元现金、IPHONE、S4、IPAD……想有就有！）</a></li>
</ul>
<ul class="ul4">
	<li><img src="<%=path %>/tuan/img/f.gif" /><a href="#">请访问我们在facebook上</a></li>
    <li><img src="<%=path %>/tuan/img/v.gif" /><a href="#">请访问我们在facebook上</a></li>
    <li><img src="<%=path %>/tuan/img/yun.gif" /></li>
    <li style="color:#777">Copyright &copy; 2008-2013 ItsCloud INC.Corp</li>
    <li style="color:#969696">中华云计算平台by点点滴滴即时云</li>
</ul>
</div>
</div>
<!-- 在线客服S -->
<LINK rel=stylesheet type=text/css href="kfonline/common.css" />
<SCRIPT type=text/javascript src="kfonline/jquery.js"></SCRIPT>
<SCRIPT type=text/javascript src="kfonline/kefu.js"></SCRIPT>
<DIV id=floatTools class=float0831>
<DIV class=floatL><A id=aFloatTools_Show class=btnOpen 
title=查看在线客服 
onclick="javascript:$('#divFloatToolsView').animate({width: 'show', opacity: 'show'}, 'normal',function(){ $('#divFloatToolsView').show();kf_setCookie('RightFloatShown', 0, '', '/', 'www.91200.cn'); });$('#aFloatTools_Show').attr('style','display:none');$('#aFloatTools_Hide').attr('style','display:block');" 
href="javascript:void(0);">展开</A> <A style="DISPLAY: none" id=aFloatTools_Hide class=btnCtn 
title=隐藏在线客服 
onclick="javascript:$('#divFloatToolsView').animate({width: 'hide', opacity: 'hide'}, 'normal',function(){ $('#divFloatToolsView').hide();kf_setCookie('RightFloatShown', 1, '', '/', 'www.91200.cn'); });$('#aFloatTools_Show').attr('style','display:block');$('#aFloatTools_Hide').attr('style','display:none');" 
href="javascript:void(0);">收缩</A> </DIV>
<DIV id=divFloatToolsView class=floatR style="DISPLAY: none">
    <DIV class=tp></DIV>
    <DIV class=cn>
      <UL>
        <LI class=top>
          <H3 class=titZx>QQ咨询</H3>
        </LI>
        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:537029160:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=537029160&Menu=yes" target="_blank">售前客服</a></LI>
                <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:296064621:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=296064621&Menu=yes" target="_blank">售前客服</a></LI>
                        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:419718285:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=419718285&Menu=yes" target="_blank">售前客服</a></LI>                      
        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:2292135944:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=2292135944&Menu=yes" target="_blank">售前客服</a></LI>
        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:2292135944:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=2292135944&Menu=yes" target="_blank">售后客服</a></LI>
        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:537029160:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=537029160&Menu=yes" target="_blank">售后客服</a></LI>
                <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:537029160:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=537029160&Menu=yes" target="_blank">渠道</a></LI>
                        <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:419718285:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=419718285&Menu=yes" target="_blank">财务</a></LI>
                                <LI><a><img border="0" src="http://wpa.qq.com/pa?p=2:9395381:52" align="absmiddle" /></a> <a  href="http://wpa.qq.com/msgrd?v=3&uin=9395381&Menu=yes" target="_blank">投诉建议</a></LI>
        <LI><a>&nbsp;<img border="0" src="http://amos.alicdn.com/online.aw?v=2&uid=idctao&site=cntaobao&s=2&charset=utf-8" align="absmiddle" /></a> <a  href="http://www.taobao.com/webww/ww.php?ver=3&touid=idctao&siteid=cntaobao&status=2&charset=utf-8" target="_blank">&nbsp;旺旺客服</a></LI>
        
      </UL>
      <UL>
        <LI>
          <H3 class=titDh>电话咨询</H3>
        </LI>
        <LI><SPAN class=icoTl>075529558715</SPAN> </LI>
      </UL>
    </DIV>
  </DIV>
</DIV>
<!-- 在线客服E -->
<script src="http://s11.cnzz.com/stat.php?id=5573135&web_id=5573135&show=pic" language="JavaScript"></script>