<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
.msc {
	top: 0%;
	left: 0%;
	background-color: #0C9;
	width: 100%;
	height: 500%;
	position: absolute;
	z-index: 1001;
}

.jgc {
	top: 150%;
	left: 15%;
	width: 806px;
	height: 500px;
	position: absolute;
	z-index: 10000;
}
</style>
<script type="text/javascipt">
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
</script>
</head>

	<body>
		<div class="ly_body">
			<!------------------------------------------头部公用代码------------------------------------------------------------>
			<jsp:include page="/litscloud/tpl/top5.jsp"></jsp:include>
			<!----------------------------------------------------------------内容开始------------------------------------------------------>
 			 <input  type="hidden" id="first_spec_str" name="first_spec_str" value="${first_spec_str }" /><!-- 最后生成的属性字符串 -->
		     <input  type="hidden" id="second_spec_str" name="second_spec_str" value="${second_spec_str }" /><!-- 最后生成的属性字符串 -->
			<input type="hidden"  id="strge" name="strge" value="${strge} "/>
						<div class="ly_imiddle">
				<div class="ly_dh" style="height: 4px; overflow: hidden;">
				</div>
				<div class="ly_dhn">
					当前位置：
					<a href="javascript:void(0);">首页</a> >
					<a href="litscloud/tpl/serve.jsp">云服务</a> > 商品详情
				</div>
				<!--指引开始-->
				<div class="ly_zy" style="margin-top: 10px;">
					<div class="ly_zyl"></div>
					<div class="ly_zyc">
						<ul>
							<li class="fwq_zy">
								<a href="javascript:void(0);">购买信息</a>
							</li>
							<li class="fwq_zy">
								<a href="javascript:void(0);">累计评价</a>
							</li>
							<li class="fwq_zy">
								<a href="javascript:void(0);">月成交量</a>
							</li>
							<li class="fwq_zy">
								<a href="javascript:void(0);">服务质量</a>
							</li>
							<li class="fwq_zy">
								<a href="javascript:void(0);">给我推荐</a>
							</li>
							<li class="fwq_zy">
								<a href="javascript:void(0);">售后服务</a>
							</li>
						</ul>
					</div>
					<div class="ly_zyr"></div>
				</div>
				<!--详情内容开始-->
				<div class="vew">
					<!-- <div class="vew_t">${sa.sgname }</div> -->
					<div class="vew_c">
						<div class="vew_cl">
							<div class="vew_clt">
								<img id="imgashow" src="litscloud/images/zf_25.gif" />
							</div>
							<div class="vew_cld">
								<ul>
									<li>
										<a href="javascript:void(0);"><img id="imga2"
												src="litscloud/images/zf_26.gif" />
										</a>
									</li>
									<li>
										<a href="javascript:void(0);"><img id="imga3"
												src="litscloud/images/zf_26.gif" />
										</a>
									</li>
									<li>
										<a href="javascript:void(0);"><img id="imga4"
												src="litscloud/images/zf_26.gif" />
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="vew_cr">
							<div class="vew_crt">
								<h1>
								${sa.sgname }
								</h1>
							</div>
							<div class="vew_crt">
								<div class="vew_crtl">
									价格 :
								</div>
								<div class="vew_crtr">
										<span id="allmoney">${sa.sgPrice}</span> 元
								</div>
							</div>
							<!-- 规格S -->
							<div class="vew_crt" id="ggdiv">
							</div>
							<!-- 规格E -->
						
							<!-- 配送功能和特效待开发S -->
							<div class="vew_crt">
								<div class="vew_crtl">
									配送 :
								</div>
								<div class="vew_crtr">
									<select name="ps"
										style="border: solid 1px #c9c9c9; color: #7fac4e;">
										<option value="1">
											至 &nbsp;深圳
										</option>
										<option value="2">
											至 &nbsp;广州
										</option>
										<option value="3">
											至 &nbsp;湖南
										</option>
										<option value="4">
											至 &nbsp;东莞
										</option>
									</select>
									商家承担运费
								</div>
							</div>
                     
							<!-- 配送功能和特效待开发S -->

							<div class="vew_crt">
								<div class="vew_crtl">
									月销量 :
								</div>
								<div class="vew_crtr">
									<span>${saled_month_amount}</span> ${sa.sgUnit }
									
								</div>
							</div>

							<div class="vew_crt">
								<div class="vew_crtl">
									评价 :
								</div>
								<div class="vew_crtr" style="color: #ff6600; font-weight: bold;">
									<img src="litscloud/images/log_40.gif" />
									<img src="litscloud/images/log_40.gif" />
									<img src="litscloud/images/log_40.gif" />
									<img src="litscloud/images/log_40.gif" />
									<img src="litscloud/images/log_40.gif" />
									5分
								</div>
							</div>
							<div class="vew_crt">
								<div class="vew_crtl">
									数量 :
								</div>
								<div class="vew_crtr">
									<select name="ps"
										style="border: solid 1px #c9c9c9; color: #7fac4e;">
										<option value="1">
											1
										</option>
										<option value="2">
											2
										</option>
										<option value="3">
											3
										</option>
										<option value="4">
											4
										</option>
									</select>
									件 （库存${remaining_amount }${sa.sgUnit }）
								</div>
							</div>

							<div class="vew_crc">
								<div class="vew_crcl"></div>
								<div class="vew_crcc">
									<a href="javascript:void(0);">立即购买</a>
								</div>
								<div class="vew_crcr"></div>
							</div>
							<!-- 服务承诺S -->
							<div class="vew_crd">
								<div class="vew_crdl"></div>
								<div class="vew_crdc">
									<p></p>
									服务
									<br />
									承诺
								</div>
								<div class="vew_crdm">
									<div class="vew_crdm_l">
										<a href="javascript:void(0);">商品保证<br />
											<img src="litscloud/images/zf_27.gif" />
										</a>
									</div>
									<div class="vew_crdm_r">
										<a href="javascript:void(0);">退款权益<br />
											<img src="litscloud/images/zf_28.gif" />
										</a>
									</div>
								</div>
								<div class="vew_crdr"></div>
							</div>
							<!-- 服务承诺S -->
						</div>
					</div>
					<div class="vew_m">
						<div class="vew_mc">
							<div class="vew_mct"></div>
							<div class="vew_mcc">
								<div class="vew_mcc_t">
									产品参数:
								</div>
								<div class="vew_mcc_d">
									<ul>
										<c:set value="0" var="ba"></c:set>
										<s:iterator value="#request.getpropertys" var="mp" status="pm">
											<li>
												<div class="vew_mcc_dl">
													<s:property value="#mp.value[0]" />
													：
												</div>
												<div class="vew_mcc_dr">
													<s:property value="#mp.value[1]" />
												</div>
											</li>
											<c:if test="${((pm.index+1)/3)==0}"></ul><ul></c:if>
										</s:iterator>
									</ul>
								</div>
							</div>
							<div class="vew_mcd"></div>
						</div>
					</div>


					<div class="vew_d"></div>
				</div>
				
				<!--详情内容结束-->
				<!-- 描述 -->
				<div class="qiehuan" id="xx4" style="display: block;">
					<div class="ly_m_bgp">
						<div class="ly_m_bgp_t"></div>
						<div class="ly_m_bgp_c">
							<div class="ly_m_bgp_cu"></div>
							<div class="ly_m_bgp_ch">
							</div>
							<div class="ly_m_bgp_ct">
								<img src="litscloud/images/ly_91.jpg" style="margin-top: 15px;" />
								商品详情
							</div>
							<div class="ly_m_bgp_cd">
								<div class="ly_m_bgp_cdt"></div>
								<div class="ly_m_bgp_cdc">
									<div class="ly_m_bgp_cdc_n">
										${sa.sgDetails }
									</div>
								</div>
								<div class="ly_m_bgp_cdd"></div>
							</div>
						</div>
						<div class="ly_m_bgp_d"></div>
					</div>
					<div class="ly_m_jbt">
						<span>技术优势</span>
					</div>
					<div class="ly_m_jszc">

					</div>
					<div class="ly_n_weibu"></div>
					<div class="ly_m_jbt">
						<span>机房简介</span>
					</div>
					<div class="ly_m_jfjj">

						<div class="ly_m_jfjj_d"></div>
					</div>
					<div class="ly_m_jbt">
						<span>机房实景图片</span>
					</div>
					<div class="ly_m_jft">

					</div>
					<div class="ly_n_weibu"
						style="margin-bottom: 50px; background-image: none;"></div>
				</div>
				<!-- 描述结束 -->
				<input type="hidden" id="imgs" name="imgs" value="${sa.sgImg}" />
			</div>
			<!-- 底部公用代码  -->
			<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
			<!-- 底部结束 -->
		</div>
	</body>
</html>
<script type="text/javascript">
	var chk_value=[];//放机房的id值 第一规格的key
	var chk_text=[];//机房的text 第一规格的text
	var xv_value=[];//宽带value的list 第二规格的ID
	var xv_text=[];//宽带text的list 第二规格的text
	
	var checkbox1="";
	var checkbox2="";
	
                
	 $(document).ready(function() {
		//初始化放值
		//alert(first_spec_str);
		//alert(second_spec_str);
		var strge1=$("#strge").val();//规格字段
		var first_spec_str = $("#first_spec_str").val();
		var second_spec_str = $("#second_spec_str").val();
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
     	   var  ggdivstr = "规格：";
     	   //alert(ggdivstr);
     	   var strgelist=strge.split("|");
     	   for(var i=0;i<strgelist.length;i++){
     		   if(strgelist[i]!="undefined" && strgelist[i]!=null && strgelist[i]!=""  ){
     				var  strgetdel=strgelist[i].split(",");//一条属性
					var checkv1=strgetdel[0];//多选框1的value值
					var checkv2=strgetdel[1];//多选框1的value值
					var moneynum=strgetdel[2];//价格
				
					if(checkv2!=""){
						ggdivstr +=  "<a href='javascript:chengetmoney("+moneynum+")' onclick='chengetmoney("+moneynum+")'  value='"+moneynum+"' >"+chk_text[checkv1-1]+"("+xv_text[checkv2-1]+")"+"</a>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;     ";
		    			//$("#ggdiv").append("");
					}else{
						ggdivstr += "<a href='javascript:chengetmoney("+moneynum+")' onclick='chengetmoney("+moneynum+")'  value='"+moneynum+"' >"+chk_text[checkv1-1]+"</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;   ";
						//$("#ggdiv").append("规格：");
     				}
         		}	
         	}
         	$("#ggdiv").append(ggdivstr);
         }
         alert(2121);
        });
		function chengetmoney(val){//根据选择的套餐修改价格
			$("#allmoney").text(val);

		}
		
 $(function(){
	//分割图片路径
		var imgs=$('#imgs').val();
		//alert("imgs="+imgs);
		if(imgs != null && imgs != ''){
		  var imgvalue=  imgs.split('|');
		  for(i=1; i<imgvalue.length; i++){
		  if(imgvalue[i]!=""){
		    $('#imga'+i).attr('src',imgvalue[i]);
            }
		  }
		}
	 
	}); 
 
</script>
 