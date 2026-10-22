<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云服务</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="litscloud/css/main.css" />
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="litscloud/js/slides.jquery.js"></script>
<script type="text/javascript" src="litscloud/js/top.js"></script>

<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->


<script type="text/javascript">
 $(document).ready(function(){  
        var menuYloc = $("#lserver").offset().top;  
        $(window).scroll(function (){  
            var offsetTop = $(window).scrollTop() +"px"; 			
            $("#lserver").animate({top:offsetTop},{duration:0,queue:false});  
        });  
    });  	
</script>



<style type="text/css">
.ad{
color:#fff; background-image:url(litscloud/images/ly_106.jpg); background-repeat:no-repeat;
}
.ad2{

background-image:url(images/ly_197.gif); color:#fff;

}
.msc{
top:0%;
left:0%;
background-color:#0C9;
width: 100%;
height: 500%;
position: absolute;
z-index: 1001;

}
.jgc{
top:60%;
left:20%;
width: 806px;
height: 500px;
position: absolute;
z-index: 10000;
}
</style>
<script type="text/javascript">

$(document).ready(function(){ 
	$(".c1").click(function(){
	var val=$(this).text();//

	 $(".c1").each(function(){
	  var val1=$(this).text();
	  
	  if(val1==val){//(); :;
		
		  $(this).css("background-image","url(litscloud/images/ly_106.jpg)");
	 
	  }else{
	    $(this).css("background-image","");
	  }
	  
	  });
	  
	});
});


var divlist=["d1","d2","d3","d4","d5","d6","d7"];
function changediv(a){

 for(var i=0;i<divlist.length;i++){
	  
           if(divlist[i]==a){
            
					$("#"+divlist[i]).show();					
					
               }else{

            		$("#"+divlist[i]).hide();
                   }
     

	 }
	

	
}

function shopdiv(sgcode){//gen
  sgcode1='SP-2013020200010';
   var  url="litscloud/litscloudgetprodutCustomerServerC.Action?sgcode="+sgcode1+"&tt="+(new Date()).getTime();
    
    	 $("#jgc").show();	
    	 $("#jgc").load(url);

    	 
}
function colsediv(){

	 $("#jgc").hide();	


	
}
function spxq(sgcode){
	
	sgcode1='SP-2013020200010';
	location.href="<%=path %>/litscloud/web/litscloudgetprodutCustomerServerC.Action?page=page&sgcode="+sgcode1+"&tt="+(new Date()).getTime();
	    




	
}
</script>
</head>

<body>
<div class="ly_body" id="mainbody">
  <!-- 头部公用代码 -->
    <jsp:include page="/litscloud/tpl/top4.jsp"></jsp:include> 
    <!-- 内容开始 -->

  <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>   
     </div>
          <div class="ly_dh">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > 云服务
      </div>
      <div class="ly_m_bgp">
       <div class="ly_m_bgp_t"></div>
     <div class="ly_m_bgp_c">
       <div class="ly_m_bgp_cu"></div>
         <div class="ly_m_bgp_ch"><ul>
            <li><a class="c1" href="javascript:changediv('d1')" ><img src="litscloud/images/zh_15.gif" />蚌埠电信</a></li>
            <li><a class="c1" href="javascript:changediv('d2')"><img src="litscloud/images/zh_16.gif" />天长电信</a></li>
            <li><a class="c1" href="javascript:changediv('d3')"><img src="litscloud/images/zh_16.gif" />铜陵联通</a></li>
            <li><a class="c1" href="javascript:changediv('d4')"><img src="litscloud/images/zh_17.gif" />天长双线</a></li>
            <li><a class="c1" href="javascript:changediv('d5')"><img src="litscloud/images/zh_20.gif" />香港新世界</a></li>
            <li><a class="c1" href="javascript:changediv('d6')"><img src="litscloud/images/zh_18.gif" />韩国服务器</a></li>
            <li><a class="c1" id="c1" href="javascript:changediv('d7')"><img src="litscloud/images/zh_19.gif" />美国服务器</a></li>
          </ul></div>
          <div class="ly_m_bgp_ct"><img src="litscloud/images/ly_91.jpg" style="margin-top:15px;" /><a name="ss"></a>服务器热门机型推荐</div>        
          <div class="ly_m_bgp_cd">
            <div class="ly_m_bgp_cdt"></div>
            <div class="ly_m_bgp_cdc">
              <!-- 蚌埠电信 --> <div class="ly_m_bgp_cdc_n" id="d1" style="display: block"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
             <!-- 天长电信 -->  <div class="ly_m_bgp_cdc_n" id="d2" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
               <!-- 铜陵联通 -->  <div class="ly_m_bgp_cdc_n" id="d3" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="litscloud/msg/no_function.jsp">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
               <!-- 天长双线 -->  <div class="ly_m_bgp_cdc_n" id="d4" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                <!-- 香港新世界 -->  <div class="ly_m_bgp_cdc_n" id="d5" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                <!-- 韩国服务器 -->  <div class="ly_m_bgp_cdc_n" id="d6" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">  韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">  韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                  <!-- 美国服务器 -->  <div class="ly_m_bgp_cdc_n" id="d7" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv(1)">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
            </div>
            <div class="ly_m_bgp_cdd"></div>
          </div>
       </div>
      <div class="ly_m_bgp_d"></div>
      </div>
    <div class="ly_n_mbt">
       <div class="ly_n_mbtc" style="line-height:50px;"><a name="idc" href="index.html" style="line-height:72px;"><p></p>IDC</a></div>
    </div>  
    <div class="ly_n_idc"><ul>
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">服务器租用</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_54.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1);">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">服务器托管</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_58.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>
          
          
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">大带宽</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_59.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">云主机</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_60.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>
          
          
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">BGP(多线)+CDN</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_61.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">机柜</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_59.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="javascript:shopdiv(1)">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>  
      </ul>
    </div> 
     
     <!---------------------------CDN开始------------------------------>
       <div class="ly_n_mbt">
       <div class="ly_n_mbtc" style="line-height:80px;"> <a name="cdn" href="litscloud/tpl/index.jsp" style="line-height:72px;">CDN</a></div>
    </div>
     <div class="ly_n_cdn"><ul>
       <li>
         <div class="ly_n_cdn_l">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_62.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <a href="litscloud/tpl/lmtjs_jt.jsp"><div class="ly_n_cdn_lnrt">CDN网页加速</div></a>
                 <div class="ly_n_cdn_lnrc">互联网的访问速度取决于众多的因素，包括Internet网络传输质量、国内南北互通问题、网站服务器性能、网站出口带宽、网页程序架构和网页内容类型...</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="litscloud/tpl/lmtjs_jt.jsp"> >>静态内容加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="litscloud/tpl/lmtjs_dt.jsp"> >> 动态内容加速</a></span></div>
              </div>
            </div>
         </div>
         <!----------------------右边开始------------------------->
         
         <div class="ly_n_cdn_l" style="float:right;">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_63.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <a href="litscloud/tpl/lmtjs_db.jsp"><div class="ly_n_cdn_lnrt">CDN流媒体加速</div></a>
                 <div class="ly_n_cdn_lnrc">随着宽带接入普及，电影、音乐、体育等媒体点播成为互联网上重要的应用，作为一种新的传媒方式。越来越多的媒体内容提供商通过网络来提供点播与直播服务，网民也可随时随地的通过互联网观看喜欢的内容，所有应用中对网络互联质量和实时性要求高...</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="litscloud/tpl/lmtjs_db.jsp"> >>流媒体点播加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="litscloud/tpl/lmtjs_zb.jsp"> >>流媒体直播加速</a></span></div>
              </div>
            </div>
         </div>         
       </li>
       
       
         <li>
         <div class="ly_n_cdn_l">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_64.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <a href="litscloud/tpl/lmtjs_bjxz.jsp"><div class="ly_n_cdn_lnrt">CDN文件传输加速</div></a>
                 <div class="ly_n_cdn_lnrc">随着互联网业务的不断发展，文件的上传和下载成为互联网上重要的业务之一。网站经常需要让网民便捷的发布文件，同时对于网站发布的内容希望能够提供用户快速的下载...
</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="litscloud/tpl/lmtjs_bjxz.jsp"> >>标准下载加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="litscloud/tpl/lmtjs_https.jsp"> >>HTTPS加速</a></span></div>
              </div>
            </div>
         </div>
         <!----------------------右边开始------------------------->
         
         <div class="ly_n_cdn_l" style="float:right;">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_65.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <a href="litscloud/msg/no_function.jsp"><div class="ly_n_cdn_lnrt">CDN增值产品</div></a>
                 <div class="ly_n_cdn_lnrc">具有Internet技术的飞速发展，单纯靠提高单台服务器的性能已不能满足要求，网站开始采用大量的服务器来同时实现Web应用...
</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="litscloud/msg/no_function.jsp"> >>智能DNS服务</a></span><span class="blue" style="float:right; text-align:right;"><a href="litscloud/msg/no_function.jsp"> >>网页压缩产品</a></span></div>
              <div class="ly_n_cdn_lnrd"><span class="blue"><a href="litscloud/msg/no_function.jsp"> >>SLL加速产品</a></span><span class="blue" style="float:right; text-align:right;"><a href="litscloud/msg/no_function.jsp"> >>区域策略产品</a></span></div>   
              </div>
            </div>
         </div>         
       </li>
     
     </ul></div>
 </div>
<div id="msc" class="msc" style="display: none">

</div>
<div id="jgc" class="jgc" style="display: none">
<div class="zf_xy">
   <div class="zf_xyt"><span><a href="#">关闭</a></span>确认订单</div>
   <div class="zf_xyc"> 
      <div class="zf_gm">
         <div class="zf_gmt">
           <div class="zf_gmt_t">
              <div class="zf_gmt_tq">配置</div>
              <div class="zf_gmt_tw"><select name="fw_lx" style="margin:5px auto;">
                <option value="1">电信</option>
                <option value="2">网通</option>
                <option value="3">移动</option>
             </select></div>
              <div class="zf_gmt_te"><select name="fw_sc" style="margin:5px auto;">
                <option value="1">时长</option>
                <option value="2">年</option>
                <option value="3">月</option>
                <option value="4">日</option>
             </select></div>
              <div class="zf_gmt_tr"><select name="fw_lx" style="margin:5px auto;">
                <option value="1">数量</option>
                <option value="2">1</option>
                <option value="3">2</option>
             </select><strong></strong></div>
              <div class="zf_gmt_tt">价格</div>
           </div>

           <div class="zf_gmt_c">
               <div class="zf_gmt_cq">
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">:</div>
                    <div class="zf_gmt_cqtr">至强5520</div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">内存:</div>
                    <div class="zf_gmt_cqtr">8G</div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">硬盘:</div>
                    <div class="zf_gmt_cqtr">256G</div>
                  </div>
                   <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">操作系统:</div>
                    <div class="zf_gmt_cqtr">windows linux </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">带宽:</div>
                    <div class="zf_gmt_cqtr">百M独享（99%可用） </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">IP地址:</div>
                    <div class="zf_gmt_cqtr"> 一个免费IP   </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">机房:</div>
                    <div class="zf_gmt_cqtr"> 广东电信，山东联通     </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">网卡:</div>
                    <div class="zf_gmt_cqtr"> 双千兆网卡     </div>
                  </div>    
               </div>
               <div class="zf_gmt_cw">电信</div>
               <div class="zf_gmt_ce">1年</div>
               <div class="zf_gmt_cr">1</div>
               <div class="zf_gmt_ct">19999元</div>
           </div>
           <div class="zf_gmt_d">总费用：<span>19999</span>元</div>
         </div>
         <div class="zf_gmd">
           <div class="zf_gmdl"><a href="#">确 &nbsp; 认</a></div>
           <div class="zf_gmdr"><a href="#">取 &nbsp; 消</a></div>
         </div>
      </div>
   </div>
   <div class="zf_xyd"></div>
</div>
</div>
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
<script type="text/javascript">
 $(document).ready(function(){  
        var menuYloc = $("#lserver").offset().top;  
        $(window).scroll(function (){  
            var offsetTop = $(window).scrollTop() +"px"; 			
            $("#lserver").animate({top:offsetTop},{duration:0,queue:false});  
        });  
    });  
</script>
