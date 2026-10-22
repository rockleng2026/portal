<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-服务器租用</title>
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
<script type="text/javascript" src="litscloud/js/showdiv.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript"> 
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<style type="text/css">
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
top:150%;
left:15%;
width: 806px;
height: 500px;
position: absolute;
z-index: 10000;
}
</style>
<script type="text/javascript">
//点击购买
function shopdiv(sgcode){//gen
  //sgcode1='SP-2013020200010';
  //验证是否选中规格
  var first_spec_str = $("#first_spec_str").val();
  var second_spec_str = $("#second_spec_str").val();
  var spec_str = $("#spec_checkstr").val();
  if(first_spec_str != '' || second_spec_str != ''){
  	//alert("存在规格");
  	alert(spec_str);
  	 
  	if(spec_str == ''){
  		alert("请选择规格!");
  		return ;
  	}
  }
  var shuliang = $("#shuliang").val();
  //alert(shuliang);
  shuliang = $.trim(shuliang);
  if( shuliang == ''){
  	alert("请填写数量!");
  	return;
  }
  var regex = /^\d+$/;
  if(shuliang == '0' ||  !regex.test(shuliang)){
  	alert("请正确填写数量!");
  	return;
  }
  alert("go");
  $("#orderform").submit();
  //window.location.href="<%=path %>/litscloud/web/litscloudcreatorderCustomerServerC.Action?sgid="+a+"&amoney="+allmoney;
  //window.location.href="<%=path%>/litscloud/ucenter/bg_order_confirm.jsp";
  return false;
  
  //验证数量
  //验证
   alert(sgcode);
   var  url="<%=path%>/litscloud/web/litscloudgetprodutCustomerServerC.Action?sgcode="+sgcode+"&tt="+(new Date()).getTime();
    	 $("#jgc").show();	
    	 $("#jgc").load(url);
   
}
function colsediv(){
	 $("#jgc").hide();	
} 
function viewpic(sgcode){
	alert(123);
	//var regex = /^\d+$/;
   	//alert(regex.test("0 "));
    //return false;
	window.open("<%=path%>/litscloud/web/viewtitlepicproductManager.Action?sgcode="+sgcode);
}
function showpic2(imgsrc){
	alert(imgsrc);
	
	$('#imga1').attr('src',imgsrc);
}
function showpic(id,serail,imglength){
	//alert(serail);
	for(i=0;i<imglength;i++){
		$("#ali-"+(i+1)).removeClass("ret_vew_ld_yes");
	}
	$("#ali-"+serail).addClass("ret_vew_ld_yes");
	var imglist = $("#"+id).children("img");
	//alert( imglist[0].src);
	$('#imga1').attr('src',imglist[0].src);
}
function tj(a){

var allmoney=$("#money").text();
location.href="<%=path %>/litscloud/web/addorderCustomerServerC.Action?sgid="+a+"&amoney="+allmoney;
	
}
</script>
</head>

<body>
<div class="ly_body" id="mainbody">
 <!------------------------------------------头部公用代码------------------------------------------------------------>
  <jsp:include page="/litscloud/tpl/htmltop.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>
 <div class="ly_imiddle">
     
        <div class="ly_dh" style="height:4px; overflow:hidden;">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="index.html">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 商品详情
      </div>            
   <!--指引开始-->  
    <div class="ly_bg_writ">   
      <div class="ly_zy" style="margin-top:10px;">
        <div class="ly_zyl"></div>
        <div class="ly_zyc"><ul>
           <li class="fwq_zy"><a href="javascript:void(0);">购买信息</a></li>
           <li class="fwq_zy"><a href="javascript:void(0);" onclick="javascript:alert('此功能暂未开通');">累计评价3</a></li>
           <li class="fwq_zy"><a href="javascript:void(0);" onclick="javascript:alert('此功能暂未开通');">月成交15件</a></li>
           <li class="fwq_zy"><a href="javascript:void(0);" onclick="javascript:alert('此功能暂未开通');">服务质量</a></li>
           <li class="fwq_zy"><a href="javascript:void(0);" onclick="javascript:alert('此功能暂未开通');">给我推荐</a></li>
           <li class="fwq_zy"><a href="javascript:void(0);" onclick="javascript:alert('此功能暂未开通');">售后服务</a></li>
        </ul></div>
        <div class="ly_zyr"></div>
        </div>
        <!--详情内容开始--> 
       <div class="ret_vew">
       	<input  type="hidden" id="first_spec_str" name="first_spec_str" value="${first_spec_str }" /><!-- 最后生成的属性字符串 -->
	    <input  type="hidden" id="second_spec_str" name="second_spec_str" value="${second_spec_str }" /><!-- 最后生成的属性字符串 -->
		<input type="hidden"  id="strge" name="strge" value="${strge} "/>
		
           <form action="litscloud/web/buildorderCustomerServerC.Action" id="orderform" method="post">
           <input  type="hidden" id="spec_checkstr" name="spec_checkstr" value="" />
           <input  type="hidden" id="sgid" name="sgid" value="${sa.sgId }" />
           <input  type="hidden" id="sgcode" name="sgcode" value="${sa.sgcode }" />
           <input type="hidden"  id="permoney" name="permoney" value="${sa.sgPrice }"/>
           <h1>${sa.sgname }</h1>
           <div class="ret_vew_t">
           <!-- 产品规格输出 -->
              <div class="ret_vew_l">
                <div class="ret_vew_lt"><img  id="imgashow"  src="${thumbarra[0] }" alt="mm" title="mm"  onclick="viewpic('${sa.sgcode }')"/></div>
                <div class="ret_vew_ld"><ul>
                  <c:forEach items="${thumbarra}" var="ss" varStatus="i">
                  	<li id="ali-${i.index+1 }" <c:if test='${i.index+1 == 1 }'>class="ret_vew_ld_yes"</c:if>>
                  	<a href="javascript:void(0);" id="ahref${i.index+1 }" onclick="showpic(this.id,${i.index+1 },${thumblength })"><img  id="imga${i.index+1 }" src="${ss }"  alt="ss" title="ss" /></a>
                  	</li>
                  </c:forEach>
                </ul></div>
              </div>
              
            <!-- 右边内容 -->  
              <div class="ret_vew_r">
                 <div class="ret_vew_rt"><ul>
                   <li><span class="rev_l">原&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;价：</span><span class="rev_r"><em style="color:#666;font-style:normal;">￥</em><em class="rev_jg_s">${sa.sgPrice}</em>元</span></li>
                   <li><span class="rev_l">促&nbsp; 销 &nbsp;价：</span><span class="rev_r"><em class="rev_hui">￥</em><em class="rev_jg" id="allmoney">${sa.sgPrice}</em></span></li>
                   <li><span class="rev_l">物流运费：</span><span class="rev_r">广东深圳 | 至<input type="text" value="广东 深圳" class="rev_txt" /> 卖家承担运费 卖家承诺7天内发货</span></li>
                   <li><span class="rev_l">30天售出：</span><span class="rev_r"><em class="rev_num">${saled_month_amount}</em>${sa.sgUnit }</span></li>
                   <li><span class="rev_l">评&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;价：</span>
                    
                   <span class="rev_r">
                   <!--
                   <img class="rev_r_img" src="litscloud/images/zh_26.gif" alt="xx" title="xx" /><img class="rev_r_img" src="litscloud/images/zh_26.gif" alt="xx" title="xx" /><img class="rev_r_img" src="litscloud/images/zh_26.gif" alt="xx" title="xx" /><img class="rev_r_img" src="litscloud/images/zh_26.gif" alt="xx" title="xx" /><img class="rev_r_img" src="litscloud/images/zh_26.gif" alt="xx" title="xx" /> 4.9分 | 4条评价
                   -->
                   	暂未开通
                   </span>
                   </li> 
                   <li><span class="rev_l">规&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;格：</span><span class="rev_r"  id="ggdiv"></span></li>
                   <li><span class="rev_l">宝贝类型：</span><span class="rev_r">全新 | 439次浏览</span></li>
                   <li><span class="rev_l">支付方式：</span><span class="rev_r">快捷支付 | 网银支付</span></li>
                   <li><span class="rev_l">购买数量：</span><span class="rev_r"><input type="text" class="rev_txt" id="shuliang" name="shuliang" value="1" style="text-align:left;text-indent:5px;width:40px;" />${sa.sgUnit } （库存${remaining_amount }${sa.sgUnit }）</span></li>
                 </ul></div>
                <div class="ret_vew_rc"><ul>
                  <li><a href="javascript:void(0);" onclick="shopdiv('${sa.sgcode }')" target="_parent""><img src="litscloud/images/zh_28.gif" alt="立即购买" title="立即购买" /></a></li>
                  <li><a href="javascript:void(0);"><img src="litscloud/images/zh_29.gif" alt="加入购物车" title="加入购物车" /></a></li>
                </ul></div>
               
                <div class="vew_crd">
               <div class="vew_crdl"></div> 
               <div class="vew_crdc"><p></p>服务<br />承诺</div> 
               <div class="vew_crdm">
                  <div class="vew_crdm_l"><a href="javascript:void(0);">商品保证<br><img src="litscloud/images/zf_27.gif"></a></div> 
                  <div class="vew_crdm_r"><a href="javascript:void(0);">退款权益<br><img src="litscloud/images/zf_28.gif"></a></div> 
               </div> 
               <div class="vew_crdr"></div> 
           </div> 
              </div>
           </div>
            </form> 
           <div class="ret_vew_d">
              <div class="ret_vew_dt">产品参数：</div>
              <div class="ret_vew_dc"><span></span></div>
              <div class="ret_vew_dd">
              <dl>
              <s:iterator value="#request.getpropertys" var="mp" status="pm">
                 <dt><s:property value="#mp.value[0]" />：</dt><dd>
                 	 <s:property value="#mp.value[1]" /></dd>
                 <c:if test="${((pm.index+1)/3)==0}"></dl><dl></c:if>
              </s:iterator>
              </dl>
              </div>
           </div>
       </div>      
      <!--详情内容结束-->
     <div class="ly_m_bgp">
       <div class="ly_m_bgp_t"></div>
       <div class="ly_m_bgp_c">
       <div class="ly_m_bgp_cu"></div>
         <div class="ly_m_bgp_ct"><img src="litscloud/images/ly_91.jpg" style="margin-top:15px;" /><a name="ss"></a>商品详情</div>        
          <div class="ly_m_bgp_cd">
            <div class="ly_m_bgp_cdt"></div>
            <div class="ly_m_bgp_cdc">
               ${sa.sgDetails }
            </div>
            <div class="ly_m_bgp_cdd"></div>
          </div>
       </div>
       <div class="ly_m_bgp_d"></div>
     </div>
    <div class="ly_m_jbt"><span>技术优势</span></div>
    <div class="ly_m_jszc">
      <div class="ly_m_jszc_t"></div>
      <div class="ly_m_jszc_d">
        
      </div>
    </div>   
    <div class="ly_n_weibu"></div>
    <div class="ly_m_jbt"><span>机房简介</span></div> 
    <div class="ly_m_jfjj">
      
    </div>
    <div class="ly_n_weibu" style="margin-bottom:50px; background-image:none;"></div>
   </div>  
   </div>
         <!-- 确定层S -->
		<div id="jgc" class="jgc" style="display: none">
		</div>
		<!-- 确定层E -->
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
<script type="text/javascript">
	var chk_value=[];//放机房的id值 第一规格的key
	var chk_text=[];//机房的text 第一规格的text
	var xv_value=[];//宽带value的list 第二规格的ID
	var xv_text=[];//宽带text的list 第二规格的text
	
	var checkbox1="";
	var checkbox2="";
	
                
	 $(document).ready(function() {
		//初始化放值
		
		var strge1=$("#strge").val();//规格字段
		var first_spec_str = $("#first_spec_str").val();
		var second_spec_str = $("#second_spec_str").val();
		//alert(first_spec_str);
		//alert(second_spec_str);
		if(first_spec_str != ""){
			var firstarra1 =  first_spec_str.split(",");
			chk_value = [];
			chk_text = [];
			//alert(chk_text+"--");
			for(i=0;i<firstarra1.length;i++){
				var firstarra2 = firstarra1[i].split("-");
				chk_value.push(firstarra2[0]);
			    chk_text.push(firstarra2[1]);
			   checkbox1=firstarra2[2];
			}
		
		}
		if(second_spec_str != ""){
			xv_value = [];
			xv_text = [];
			var secondarra1 =  second_spec_str.split(",");
			for(i=0;i<secondarra1.length;i++){
				var secondarra2 = secondarra1[i].split("-");
				xv_value.push(secondarra2[0]);
				xv_text.push(secondarra2[1]);
				 checkbox2=secondarra2[2];
			}
		}
        if(strge1!=""){
     	   var strge = strge1.substring(0, strge1.length-1);
     	   var  ggdivstr = "";
     	   //alert(ggdivstr);
     	   var strgelist=strge.split("|");
     	   //alert(strge);
     	   for(var i=0;i<strgelist.length;i++){
     		   if(strgelist[i]!="undefined" && strgelist[i]!=null && strgelist[i]!=""  ){
     				var  strgetdel=strgelist[i].split(",");//一条属性
					var checkv1=strgetdel[0];//多选框1的value值
					var checkv2=strgetdel[1];//多选框1的value值
					var moneynum=strgetdel[2];//价格
				
					if(checkv2!=""){
						ggdivstr +=  "<a id='gga"+i+"' href='javascript:void(0);' onclick='chengetmoney("+moneynum+",this.id)'  value='"+moneynum+"' >"+chk_text[checkv1-1]+"("+xv_text[checkv2-1]+")"+"</a>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;     ";
		    			//$("#ggdiv").append("");
					}else{
						ggdivstr += "<a id='gga"+i+"' href='javascript:void(0);' onclick='chengetmoney("+moneynum+",this.id)'  value='"+moneynum+"' >"+chk_text[checkv1-1]+"</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;   ";
						//$("#ggdiv").append("规格：");
     				}
         		}	
         	}
         	//alert(ggdivstr);
         	$("#ggdiv").append(ggdivstr);
         }
         //alert(2121);
        });
		function chengetmoney(money,id){//根据选择的套餐修改价格
			//alert(id);
			var specstr = $("#"+id).html();
			//alert(specstr);
			$("#allmoney").text(money);
			$("#permoney").val(money);
			$("#spec_checkstr").val(specstr);
		} 
</script>
</body>
</html>
