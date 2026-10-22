<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function showcontent(divid){
		//alert(divid);
		for(i=1;i<6;i++){
			$("#c_t"+i).removeClass("about_tc_xz");
			$("#c_"+i).hide();
		}
		
		$("#c_t"+divid).addClass("about_tc_xz");
		$("#c_"+divid).show();
	}
</script>
<a name="top"></a>
<div class="t_bod">  <!-- t_bod 网页头部导航部分 -->
      <div class="bod_width">
        <div class="bod_logo">
        
        <a href="#">  <img src="cms/ender/image/ed_03.gif" alt="LOGO" title="公司logo" /> </a>
        </div>
        <div class="t_right">
           <div class="t_right_t">
           <script type="text/javascript">
				function postToWb(){
				//activity.intro这是取得Action穿过来的值，如果想取当前标题改为document.title
				//var _t = encodeURI(document.title);//这是取得Action穿过来的值，如果想取当前标题改为document.title
				var _t = encodeURI("恩德-专注酒店用品");//这是取得Action穿过来的值，如果想取当前标题改为document.title
				//var sss = document.location.toString();
				var sss = "<%=basePath%>";
				//alert(sss);//&amp; &#38;
				//var sss1 = sss.replace(/&/g,"\\&");
				//alert("aaa"+sss1);
				var _url = encodeURI(sss);
				var _appkey = encodeURI("appkey");//你从腾讯获得的appkey
				var _pic = encodeURI('');//（列如：var _pic='图片url1|图片url2|图片url3....）
				var _site = '';//你的网站地址
				var _u = 'http://v.t.qq.com/share/share.php?title='+_t+'&url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic;
				window.open( _u,'转播到腾讯微博', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
				}
			</script>
           <span class="t_Share"><a href="javascript:void(0)" onclick="postToWb();" class="tmblog"><img src="cms/ender/image/ed_05.gif" alt="分享到腾讯微博" title="分享到腾讯微博" /></a></span>
           <span class="t_Share">
           	<a href="javascript:void((function(s,d,e,r,l,p,t,z,c) {var%20f='http://v.t.sina.com.cn/share/share.php?appkey=962772401',u=z||d.location,p=['&url=',e(u),'& title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'& content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a() {if(!window.open([f,p].join(''),'mb', ['toolbar=0,status=0,resizable=1,width=600,height=500,left=',(s.width- 600)/2,',top=',(s.height-600)/2].join('')))u.href=[f,p].join('');}; if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();}) (screen,document,encodeURIComponent,'','','www.ender.com','恩德-专注酒店用品','','utf-8'));" alt="分享到新浪微博" title="分享到新浪微博"> 
				<img src="cms/ender/image/ed_06.gif" alt="分享到新浪微博" title="分享到新浪微博" />
			</a>
           </span>
           <h1 class="t_iphone">+86-755-3366 6980</h1>
           </div>
           <!-- 导航开始 -->
           <a name="top_menu" id="top_menu"></a>
           <div class="t_menu"><ul>
             <li  class="menu_er" ><span class="menu_eng"><a href="#">首页<br /><em>HOME</em></a></span>
             
             </li>     
            <li class="menu_er" onmouseover="this.className='menu_er active_cat'" onmouseout="this.className='menu_er'"><a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=42">产品中心<br /><em>PRODUCTS</em></a>
              	<div class="h3_cat"><ul>
              	<c:forEach items="${productcenter}" var="ss">
					<li>
						<a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${ss.classid }">${ss.classname }</a>
					</li>
				</c:forEach>
				</ul></div>
             </li>
             <li class="menu_er"  onmouseover="this.className='menu_er active_cat'" onmouseout="this.className='menu_er'"><a href="cms/ender/about_us.jsp#top_menu">关于我们<br /><em>ABOUT US</em></a>
             <div class="h3_cat"><ul>
        		<li>
					<a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('1')">公司介绍</a>
				</li>
				<li>
					<a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('2')">联系我们</a>
				</li>
				<li>
					<a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('3')">支付方式</a>
				</li>
				<li>
					<a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('4')">合作伙伴</a>
				</li>
				<li>
					<a href="cms/ender/about_us.jsp#top_menu" onclick="showcontent('5')">公司资质</a>
				</li>                        
              </ul></div>
             </li>
             
             <li class="menu_er" onmouseover="this.className='menu_er active_cat'" onmouseout="this.className='menu_er'">
                <a href="cms/web/showlistwebnews.do?match_name=webnews&classid=50">
                	行业动态<br /><em>NEWS</em>
                </a>
	            <div class="h3_cat" style="margin-left:-312px;"><ul style="background:url(image/ed_08.gif) no-repeat -190px top;">
	            	<ul style="background:url(image/ed_08.gif) no-repeat -190px top;">
			            <c:forEach items="${industrynews}" var="ss">
							<li>
							<a href="cms/web/showlistwebnews.do?match_name=webnews&classid=${ss.classid }">${ss.classname }
							</a>
							</li>
						</c:forEach>
	              	</ul>
	             </div>
             </li>
           </ul></div>
        </div>
        <div class="t_erweima"><img src="cms/ender/image/ed_26.gif" title="扫一扫有惊喜" alt="扫一扫有惊喜" /></div>        
      </div> 
   </div>