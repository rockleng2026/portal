<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>联系我们</title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="cms/ender/css/style.css" rel="stylesheet" type="text/css" />
<script src="cms/ender/js/jquery.js" type="text/javascript"></script>
<script src="cms/ender/js/zzsc.js" type="text/javascript"></script>
<script type="text/javascript" src="cms/ender/js/lrtk.js"></script>

</head>

<body>
<div class="bodyer"><!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->
   <!-- 头部start -->
      <jsp:include page="menu.jsp"></jsp:include>
   <!-- 头部end -->
   <!-- t_bod结束 -->
   <div class="t_cod">
     <!-- 热卖产品 -->
       <div class="bod_width t_cod_mar">
         <h1 class="bod_width t_cod_title">关于我们<br /><span>ABOUT US</span></h1>
         <div class="bod_width t_cod_x">
            <div class="t_cod_xl"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
            <div class="t_cod_xr"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
         </div>
       </div>
     <!-- 热卖产品完毕 -->
       <div class="bod_width about_t">
         <div class="about_tl"></div>
         <div class="about_tc"><ul>
           <li id="c_t1" class="about_tc_xz"><a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('1')" name="c_about">公司介绍</a></li>
           <li id="c_t2"><a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('2')"  name="c_contact">联系我们</a></li>
           <li id="c_t3"><a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('3')" name="c_pay">支付方式</a></li>
           <li id="c_t4"><a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('4')" name="c_partner">合作伙伴</a></li>
           <li id="c_t5"><a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('5')" name="c_quft">公司资质</a></li>
         </ul></div>
         <div class="about_tl"></div>
       </div>
      <!-- about -->
      <div class="bod_width about_d cont_bj" id="c_1" >
          <img src="cms/ender/pic_img/about_01.gif" alt="关于我们" title="关于我们" align="left" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 深圳市恩元酒店用品有限公司是一家生产销售为一体生产厂家、主要生产不锈钢金属制品及塑料制品木制品，主要生产销售的产品户外垃圾桶、酒店客房用品、酒水车、演讲台及酒店大堂用品、酒店工程地毯、(栏杆座、防滑地垫、不锈钢垃圾桶、多功能洗地机)等环卫类产品,顾客满意是我司的企业之本、让每个客户都成为我公司的永久顾客、是我司的经营宗旨、急客户之所急、想客户之所想、我们愿以优良质量、合理的价格、周到的售后服务竭诚与国内外新老客户携手合作，共创美好未来。顾客满意是我司的企业之本、让每个客户都成为我司的永久顾客、是我司的经营宗旨、急客户之所急、想客户之所想、我们愿以优良质量、合理的价格、周到的售后服务竭诚与国内外新老客户携手合与国内外新老客户携手合作，共创美好未来。顾客满意是我司的企业之本、让每个客户都成为我司的永久顾客、是我司的经营宗旨、急客户之所急、想客户之所想、我们愿以优良质量、合理的价格、周到的售后服务竭诚与国内外新老客户携手合与国内外新老客户携手合作，共创美好未来。顾客满意是我司的企业之本、让每个客户都成为我司的永久顾客、是我司的经营宗旨、急客户之所急、想客户之所想、我们愿以优良质量、合理的价格、周到的售后服务竭诚与国内外新老客户携手合作，共创美好未来！
      </div>
     <!-- contact -->
     <div class="bod_width about_d cont_bj" id="c_2" style="display: none">
         总公司地址：深圳市宝安38区湖滨中路新锦安雅苑三期D1栋03-05商铺 （展厅面积300平方米）<br />
         福田分公司地址：深圳市福田区泥岗路村星湖花园2栋19C办事处<br /><br />
         全国销售热线：0755-33666980（总机） 、 0755-33666981 、 0755-33851821<br />
         传真：0755-33851821<br />
         手机：13699862077(刘小姐) 、 15889333669（戴先生）<br />
         业务邮箱：15986612232sz@163.com 、enyu2013@163.com<br />
         业务QQ： 861335184 、 2215298882 、 619021690 、 1352451323<br />
         公司网站：http://www.eny888.com 、www.ender.com.cn<br />
         公司网址：http://www.szchaobao.com 、 http://www.sznf88.com<br />
         阿里巴巴商铺：www.eny8888.cn.alibaba.com 、 http://wulip5.cn.alibaba.com<br /> 
      </div>
      <!-- pay -->
     <div class="bod_width pay_m" id="c_3" style="display: none">
        <dl><dt><img src="cms/ender/image/ed_28.gif"  align="工商银行" title="工商银行" /></dt><dd>用户名：吴丽萍<br />开户账号：6222-0240-0007-9841-363<br />开户银行：中国工商银行深圳宝安支行</dd></dl> 
      </div>
     <!-- partner -->
     <div class="bod_width par_m" id="c_4" style="display: none">
        <img src="cms/ender/image/ed_30.gif" />
      </div>
     <!-- quft -->
     <div id="c_5" style="display: none">
	     <div class="bod_width par_m" >
	         <!-- 标题信息 -->
	         <div class="bod_width quft_t"><span class="quft_title">公司概况</span></div>
	         <!-- 内容区域 -->
	         <div class="bod_width quft_d">
	            <div class="quft_dt">
	              <h1>深圳市宝安区新安恩元环保设备经营部 <img src="cms/ender/image/ed_31.gif"  alt="诚信通" title="诚信通" /> <span class="quft_chenxintong">第<em>6</em>年</span></h1>
	              <p class="quft_dw quft_text">恩元清洁用品厂座落于中国广东省佛山市南海区,因业务需求于2007年设立深圳销售分公司。工厂配备有先进的五金机械设备和木工设ac备，拥有专业高级工程师和...  <a href="http://eny8888.cn.1688.com/page/creditdetail.htm" target="_blank"><更多></a></p>
	            </div>
	            <div class="quft_dd">
	              <dl><dt>成立时间：</dt><dd>2011年04月20日 <span>[已认证]</span></dd><dt>注册资本：</dt><dd>无需验证 <span>[已认证]</span></dd></dl>
	              <dl><dt>经营范围：</dt><dd>环保设备、劳保用品、酒店用品、（法律、行政...<span>[已认证]</span></dd><dt>经营地址：</dt><dd>广东省深圳市宝安38区湖滨中路D1栋首层25号商铺</dd></dl>
	            </div>
	          </div>
	      </div>
	      <div class="bod_width par_m">
	         <!-- 标题信息 -->
	         <div class="bod_width quft_t"><span class="quft_title">认证信息</span></div>
	         <!-- 内容区域 -->
	         <div class="bod_width quft_d">  
	            <div class="quft_ddt">工商注册信息 <span>该信息于2013年05月02日通过中贸远大专业认证</span></div>          
	            <div class="quft_dd">
	              <dl><dt>公司名称：</dt><dd>深圳市宝安区新安恩元环保设备经营部</dd><dt>注册地址：</dt><dd>中国广东深圳宝安区新安街道湖滨中路西北侧新锦安雅园D区1栋01层03、04号</dd></dl>
	              <dl><dt>注册资本：</dt><dd>无需验资</dd><dt>成立日期：</dt><dd>2011年04月20号</dd></dl>
	              <dl><dt>注册号：</dt><dd>440306806897806</dd><dt>法定代表：</dt><dd>吴在军</dd></dl>
	              <dl><dt>登记机关：</dt><dd>深圳市市场监督管理局宝安分局</dd><dt>企业类型：</dt><dd>个体经营</dd></dl>
	              <dl><dt>营业期限：</dt><dd>长期</dd><dt>年检时间：</dt><dd>2013年（最近）</dd></dl>
	              <dl><dt>经营范围：</dt><dd>环保设备、劳保用品、酒店用品（法律、行政法规、国务院决定禁止的项目除外，限制的项目须得许可后方可经营）</dd><dt>申请人：</dt><dd>姓名：戴小红(先生)<br />部门：销售部<br />职位：经理</dd></dl>
	            </div>
	          </div>
	      </div>
	      <div class="bod_width par_m">
	         <!-- 标题信息 -->
	         <div class="bod_width quft_t"><span class="quft_title">认证信息</span></div>
	         <!-- 内容区域 -->
	         <div class="bod_width quft_d">         
	            <div class="quft_wid quft_qt">基本信息</div>
	            <div class="quft_wid quft_qc">
	              <dl><dt>主营产品或服务：</dt><dd>工业吸尘吸水机；全自动洗地机；地毯抽洗机；高速抛光机；175多功能刷地机；154多功能刷地机；美国泳池清洁机；美国干泡沙发保养机；冷水高压清洗机；手提式的抛光机；塑料脚踏式垃圾桶；榨水车系列；告示牌系列；指示牌系列；果皮箱系列；资料架系列；行李架；客房单品；大堂花瓶；灯箱；洒水车；茶水车；煮餐车；就把车；演讲台系列；手推车系列</dd></dl>
	              <dl><dt>主营行业：</dt><dd>酒店大堂用品、酒店客房用品、环卫垃圾桶、垃圾车、工业吸尘设备、洗地机</dd></dl>
	              <dl><dt>经营模式：</dt><dd>经销批发</dd></dl>
	            </div>
	            <div class="quft_wid quft_qt">行业信息</div>
	            <div class="quft_wid quft_qd">
	              <dl><dt>主要销售区域：</dt><dd>全国</dd><dt>主要销售群体：</dt><dd>酒店、物业、大厦</dd></dl>
	              <dl><dt>年营业额：</dt><dd>人民币301万元/年 - 500万元/年</dd></dl>
	            </div>
	           <div class="quft_wid quft_qt">经营消息</div>
	           <div class="quft_wid quft_qd">
	              <dl><dt>服务区域：</dt><dd>酒店、宾馆</dd><dt>员工人数：</dt><dd>51-100人</dd></dl>
	            </div>
	           <div class="quft_wid quft_qt">公司图片</div>
	           <div class="quft_wid quft_pic"><ul>
	              <li class="zzsc_box_pad"><img src="cms/ender/image/ed_32.gif" alt="公司图片_01" /></li>
	              <li class="zzsc_box_pad"><img src="cms/ender/image/ed_32.gif" alt="公司图片_01" /></li>
	              <li class="zzsc_box_pad"><img src="cms/ender/image/ed_32.gif" alt="公司图片_01" /></li>
	              <li class="zzsc_box_pad zzsc_box_right_mar"><img src="cms/ender/image/ed_32.gif" alt="公司图片_01" /></li>
	           </ul></div> 
	          </div>
	      </div>
	    </div>
      
           
   </div>
   <!-- 内容输出完毕 -->
   <!-- 底部开始 -->
   <jsp:include page="bottum.jsp"></jsp:include>
   <!-- 底部完毕 -->
</div>

</body>
</html>
