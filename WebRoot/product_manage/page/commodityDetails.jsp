<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<style type="text/css">
html, body, div, span,applet, object, iframe, h1, h2, h3,      

h4, h5, h6, p,blockquote, pre, a, acronym,      

address, big, cite, code,del, dfn, em, font, img, ins,      

kbd, q, s, samp, small,strike, strong, sub, sup, tt,      

var, dl, dt, dd,  ul,li, fieldset, form, label, legend,      

table, caption, tbody,tfoot, thead, tr, th, td , input,div{      

margin: 0;      

padding: 0;      

border: 0;      

outline: 0;
font-size:12px;      

font-weight:inherit;      

font-style: inherit;      

font-size: 100%;      

font-family:Arial, Helvetica, sans-serif,"宋体";    

vertical-align:baselinebaseline;      

}      

:focus { outline:0;}      

a, a:link, a:visited,a:hover, a:active{text-decoration:none; font-family:Arial, Helvetica, sans-serif,"宋体";}      

table { border-collapse:separate;border-spacing: 0px;}      

th, td {text-align: left;font-weight: normal;}      

img, iframe {border:none; text-decoration:none;}      

ul {list-style:none;}      

input, textarea, select,button {font-size: 100%;font-family: inherit;}      

select {margin:inherit;}      

hr {margin: 0;padding:0;border: 0;color: #000;background-color: #000;height: 1px}
body{
	background:#f4f9fd;	
	}
.fa_boder{
	width:1060px;
	height:auto;
	padding:20px;
	overflow:hidden;
	margin:10px auto;
	font-size:12px;
	border:solid 3px #97C4E3;
	background:#f4f9fd;	
	}
.fa_width{
	width:1060px;
	height:auto;	
	}
.fa_overflow{
	overflow:hidden;	
	}
.fa_wrt{
	font-family:"微软雅黑";	
	}			
.fa_top{
	height:30px;
	line-height:30px;
	font-size:14px;
	color:#4498db;
	line-height:30px;
	border-bottom:solid 1px #98ccf5;		
	}
.fa_top span{
	width:5px;
	height:5px;
	background:#069;
	display:block;
	float:left;	
	position:inherit;
	border-radius:3px;
	margin-top:13px;
	margin-right:5px;
	}
.fa_body{
	margin:8px auto;	
	}	
.fa_body dl{
	width:1060px;
	height:auto;
	overflow:hidden;
	margin-bottom:8px;	
	}
.fa_body dt{
	width:90px;
	float:left;
	height:25px;
	line-height:25px;
	color:#004779;	
	}
.fa_body dd{
	float:left;
	margin-left:5px;
	width:960px;
	height:auto;
	overflow:hidden;
	line-height:25px;
	color:#004779;	
	}
.fa_body em{
	color:#F00;
	margin-left:3px;
	margin-top:-8px;	
	}	
.fa_input{
	border:solid 1px #5794bf;
	height:23px;
	line-height:23px;
	width:220px;
	border-radius:3px;
	text-indent:5px;
	background:#fff;
	color:#000;	
	}
.fa_leit{
	width:960px;
	height:25px;
	line-height:25px;
	margin-bottom:10px;	
	}
.fa_buttom{
	padding:3px 10px;
	color:#000;
	margin:0px 5px;
	border:solid 1px #707070;
	bakcground:#ececec;
	border-radius:3px;	
	}
.fa_buttom:hover{
	background-color:#09F;
	color:#fff;	
	}	
.fa_leid{
	width:960px;
	height:280px;	
	}
.fa_leid ul li{
	width:280px;
	float:left;
	height:280px;
	overflow-y:auto;
	margin-right:20px;
	border:solid 1px #1d699d;
	}
.fa_lei_li{
	width:260px;
	margin-left:2px;
	height:auto;
	margin-top:8px;
	border:none;
	overflow:hidden;
	}
.fa_lei_li li{
	width:260px;
	border:none !important;
	height:auto !important;	
	overflow:hidden;
	text-indent:5px;
	display:block;
	margin-bottom:5px;	
	}
.fa_lei_li em{ margin-left:180px;margin-top:-25px;color:#f60;}		
.fa_lei_li a{	
	display:block;
	color:#000;
	width:255px;
	border:solid 1px #f4f9fd;
	font-size:12px;
	}
.fa_lei_li span{
	margin-left:15px;		
	}

.fa_lei_li a:hover{
	color:#0e6fb0;
	border:solid 1px #7cb6dd;
	}
.fa_yes a{
	color:#0e6fb0;
	border:solid 1px #7cb6dd;	
	}
.fa_no{
	color:#666; !important	
	}
.input_select{
	border:solid 1px #5794bf;
	height:23px;
	line-height:23px;
	width:220px;
	border-radius:3px;
	text-indent:0px;
	margin:0px;
	background:#fff;
	color:#000;		
	}
.fa_body  label{
	float:left;
	height:25px;
	line-height:25px;
	color:#000;
	margin-right:15px;	
	}
.fa_body input{
	margin-right:5px;	
	}
.fa_picture{
	width:960px;
	height:auto;
	overflow:hidden;
	}
.fa_picture li{
	width:130px;
	float:left;
	margin:0px;
	padding:0px;	
	}
.fa_picture_t{
	width:100px;
	height:100px;
	border:solid 1px #004779;
	background:#fff;	
	}
.fa_picture_d{
	width:100px;
	height:30px;
	text-align:center;
	margin-top:8px;	
	}
.input_texta{
	width:880px;
	padding:10px;
	height:150px;
	border:solid 1px #004779;
	line-height:22px;
	color:#000;
	font-size:12px;	
	}
.fa_table{
	width:900px;
	border-left:solid 1px #88ccfc;
	border-top:solid 1px #88ccfc;	
	}
.fa_table th{
	text-align:center;
	border-bottom:solid 1px #88ccfc;
	border-right:solid 1px #88ccfc;
	text-align:center;
	height:26px;
	line-height:26px;
	background:#b9def9;
	color:#105585;
	font-size:12px;
	font-weight:bold;	
	}
.fa_table td{
	text-align:center;
	border-bottom:solid 1px #88ccfc;
	border-right:solid 1px #88ccfc;
	min-height:30px;
	height:26px;
	padding:5px 0px;
	}
.fa_inputs{
	border:solid 1px #5794bf;
	height:23px;
	line-height:23px;
	width:130px;
	text-align:center;
	margin:0px 10px;
	text-indent:5px;
	background:#fff;
	color:#000;		
	}
.fa_footer{
	height:auto;
	margin-top:15px;
	overflow:hidden;
	text-align:center;
	margin-bottom:15px;
	}
.fa_buttoms{
	padding:3px 15px;
	background:#277fd0;
	color:#fff;
	font-family:"微软雅黑";
	border:solid 1px #274969;	
	}
.fa_buttoms:hover{
	background:#0e4f8c;	
	}
.fa_zong{
	width:900px;
	height:auto;
	border:dotted 1px #2b77aa;
	padding:10px 0px;
	overflow:hidden;
	}
.fa_zong dl{
	width:900px;
	height:auto;
	overflow:hidden;	
	}	
.fa_zong dt{
	width:120px;
	text-align:right;
	float:left;
	height:25px;
	line-height:25px;	
	}
.fa_zong dd{
	width:740px;
	float:left;
	height:auto;
	overflow:hidden;
	line-height:25px;	
	}	
.pro_vew{
	margin:8px auto;	
	}	
.pro_vew dl{
	width:1060px;
	height:auto;
	overflow:hidden;
	
	margin-bottom:8px;
	padding:5px 0px;	
	}
.pro_vew dl:hover{background:#c3e2fb;}	
.pro_vew dt{
	width:90px;
	float:left;
	height:25px;
	line-height:25px;
	color:#666;	
	}
.pro_vew dd{
	float:left;
	margin-left:5px;
	width:430px;
	height:auto;
	overflow:hidden;
	line-height:25px;
	color:#004779;	
	}
.pro_attribute{
	width:855px;
	float:left;
	height:auto;
	margin:0px;
	padding:0px;
	overflow:inherit;	
	}
.pro_attribute li{
	height:25PX;
	list-style:none;
	line-height:25px;
	color:#004779;
	text-align:left;
	border-bottom:dotted 1px #004779;
	width:425px;
	margin-right:5px;
	float:left;	
	}
.pro_attribute span{
	color:#333;
	font-size:12px;
	margin-right:8px;
	display:block;
	float:left;
	text-align:left;	
	}
.pro_pro{
	width:950px;
	height:auto;
	list-style:none;
	overflow:inherit;
	float:left;
	margin-left:5px;	
	}
.pro_pro li{
	width:110px;
	float:left;
	list-style:none;
	margin-right:10px;
	margin-bottom:10px;
	height:105px;	
	}
.pro_pro_img{
	width:100px;
	height:100px;
	border:solid 1px #004779;	
	}																																									
</style>
<script type="text/javascript">
     $(function(){
		var imgs=$('#imgs').val();
		alert(imgs);
		  var imgvalue=  imgs.split('|');
		  var imgstr = "";
		    if(imgvalue!=""){
		  for(var i=1; i<imgvalue.length; i++){
		  	if(imgvalue[i]!=""){
		    //$('#imgshow').append("<td><img style='width: 100;height: 100;border: 1px solid;' src='"+imgvalue[i]+"'/></td>");
		    	imgstr +="<li><div class='pro_pro_img'><img src='"+imgvalue[i]+"' /></div></li>";
		  	}
		    }
		    if(imgstr != ""){
		    	$("#imgslist").html(imgstr);
		    }
		  }
		});
	function release(id){
     $.post("pdm/shenheproductManager.do",{'id':id},function(data){
           alert('审核成功');  
     window.location.href="detailsproductManager.do?id="+id;
      $('#shenhe').html('商品审核通过');
     });

   }
   function  fanhui(){
     //window.location.href="/FAJxc/pdm/List1productManager.do?v=3";
      history.go(-1);
   }
  </script>
	</head>
	<body>
		<input type="hidden" id="orderNo" value="${sa.sgcode}" />
		<input type="hidden" id="tab" value="Sale_goods">
		<input type="hidden" id="filed" value="sgCheckGoods">
		<input type="hidden" id="orderName" value="sgcode">
		<input type="hidden" id="imgs" value="${sa.sgImg }" />
		<div class="fa_boder">
			<div class="fa_wrt fa_width fa_top">
				<span></span>商品详情
			</div>
			<div class="fa_width pro_vew">
				<dl>
					<dt>
						商品编号：
					</dt>
					<dd>
						${sa.sgcode}
					</dd>
					<dt>
						商品类型：
					</dt>
					<dd>
						男士服装
					</dd>
				</dl>
				<dl>
					<dt>
						商品属性：
					</dt>
					<dd style="width:855px;"><ol class="pro_attribute">
						<s:iterator value="#request.getpropertys" var="mp" status="pm">
							<li>
								<span><s:property value="#mp.value[0]" />：</span><s:property value="#mp.value[1]" />
							</li>
						</s:iterator>
					</ol>
					</dd>
				</dl>
				<dl>
					<dt>
						商品名称：
					</dt>
					<dd>
						${sa.sgname}
					</dd>
					<dt>
						商品价格/元：
					</dt>
					<dd>
						${sa.sgPrice }
					</dd>
				</dl>
				<dl>
					<dt>
						商品规格：
					</dt>
					<dd>
						${sa.sgNorms}
					</dd>
					<dt>
						商品单位：
					</dt>
					<dd>
						${sa.sgUnit }
					</dd>
				</dl>
				<dl>
					<dt>
						商品规格：
					</dt>
					<dd style="display: none;">
						
					</dd>
					<ol class="pro_attribute">
						<li>
							<span>服务器所在地：</span>北京
						</li>
						<li>
							<span>服务器所在地：</span>北京
						</li>
						<li>
							<span>服务器所在地：</span>北京
						</li>
					</ol>
				</dl>
				<dl>
					<dt>
						录入人：
					</dt>
					<dd>
						${sa.sgUsername}
					</dd>
					<dt>
						商品状态：
					</dt>
					<dd>
						<c:if test="${sa.sgStat==0}">仓库中的商品</c:if>
					    <c:if test="${sa.sgStat==1}">出售中的商品</c:if>
					    <c:if test="${sa.sgStat==2}">发布待审核商品</c:if>
					</dd>
				</dl>
				<dl>
					<dt>
						商品图片：
					</dt>
					<ul class="pro_pro" id="imgslist">
						
						
					</ul>
				</dl>
				<dl>
					<dt>
						数量/单位：
					</dt>
					<dd>
						${sa.sgnumbers }/${sa.sgUnit}
					</dd>
					<dt>
						出货类型：
					</dt>
					<dd>
						<c:if test="${sa.sgchecks1 ==1}">
							<c:if test="${sa.sgchecks2 ==1}">
	                            IDC托管
						     </c:if>
						     <c:if test="${sa.sgchecks2 ==2}">
						        IDC租用
						       </c:if>
						    </c:if>
					    <c:if test="${sa.sgchecks1 ==0}">
					       	销售出库
					    </c:if>
					</dd>
				</dl>
				<dl>
					<dt>
						创建时间：
					</dt>
					<dd>
						${sa.sgtime}
					</dd>
					<dt>
						发布时间：
					</dt>
					<dd>
						${sa.sgPuttime}
					</dd>
				</dl>
				<dl>
					<dt>
						审核状态
					</dt>
					<dd>
						<c:if test="${sa.sgStat==2}">
							<c:if test="${mark=='mark'}">
								<input type="button" value="接收" onClick="incepttime('${sa.sgcode}','Sale_goods','sgStat','sgcode')"/>
								<c:set value="1" var="mflag" scope="session"></c:set>
							</c:if>
							<c:if test="${mark !='mark'}">
								发布待审核
							</c:if>
						</c:if>
						<c:if test="${mflag==1}">
							<c:if test="${mark == 'no' && mark!='mark'}">
								<c:if test="${flage==0 }">
									<input type="button" value="审核"  onclick="completemission('${sa.sgStat}',2)" />
								</c:if>
								<c:if  test="${flage==1 ||flage==2}">
									<span style="color:green;">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if></span>
									<c:if test="${aot.auditingFlag==2}"><span style="color:red;">未通过</span></c:if><span style="color:red;">--审核意见：${aot.tmp }</span>
							   	</c:if>
							</c:if>
						</c:if>
					</dd>
				</dl>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
			</div>
			<div class="fa_footer fa_width">
				<input type="button" value="确定" class="fa_buttoms"
					style="margin-right: 20px;" />
				<input type="reset" value="返回" class="fa_buttoms" />
			</div>
		</div>
	</body>
</html>
