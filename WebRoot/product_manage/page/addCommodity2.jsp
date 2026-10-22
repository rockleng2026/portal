<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />  
<title>发布商品</title>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="<%=path %>/js/util/ckbrowserutil.js"></script>
<script type="text/javascript" src="<%=path %>/product_manage/js/commodity.js"></script>
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
	margin-bottom:5px;	
	}
.fa_lei_li a{	
	margin-top:2px;
	color:#000;
	padding:2.5px 5px;
	margin-right:3px;
	border:solid 1px #f4f9fd;
	font-size:12px;
	}
.fa_lei_li span{
	
	font-size:12px;	
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
	width:106px;
	height:106px;
	border:solid 1px #004779;
	background:#fff;
	}
.fa_picture_t img{
	width:106px;
	height:106px;
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
	width:150px;
	text-align:right;
	float:left;
	height:25px;
	line-height:25px;	
	}
.fa_zong dd{
	width:710px;
	float:left;
	height:auto;
	overflow:hidden;
	line-height:25px;	
	}																																			
</style>
</head>

<body>
<div class="fa_boder">
   <div class="fa_wrt fa_width fa_top"><span></span>发布商品</div>
   <div class="fa_width fa_body">
      <form id="mainform" action="" method="post" name="mainform">
      <dl><dt>商品编码：</dt><dd><input id="sgcode" class="fa_input"  name="sgcode" value="${spNum}"  readonly="readonly" /><em>*</em></dd></dl>
      <dl><dt>商品类目：</dt><dd>
      	<div class="fa_leit">
        <input type="hidden" name="sa.selname" id="selname" />
        <input type="hidden" name="modify" id="modify" value="${modify}"/>
        <input type="hidden" name="sgid" value="${sa.sgId}" />
		<input type="hidden" id="goods_dictid" name="goods_dictid" value="${sa.goods_dict.gdId}"/>
        <input type="text" size="30"  id="textfield2" class="fa_input" value="请输入查询内容"  onFocus="if(this.value=='请输入查询内容')this.value=''" onBlur="if(this.value=='')this.value='请输入查询内容'" onkeyup="if(event.keyCode==13)document.getElementById('buton1').focus();"/> <input type="submit" value="查询" class="fa_buttom" id="buton1" onclick="selectClass1()"/><em>*注：单机显示下一级，双击显示类目属性。</em></div>
        <div class="fa_leid"><ul>
          <li id="li_1">
	          <input type="hidden" id="p_level1" value="${fn:length(goods_dict)}"/>
	          <input type="hidden" id="p_position1" value="1"/>
	          <ul class="fa_lei_li">
		          <c:forEach items="${goods_dict}" var="goods" varStatus="status">
		          	<c:if test="${goods.gdSuperId==null}">
		          		<li id="li_1_${status.index}">
		          			<a href="javascript:void(0);" id="${goods.gdId}" name="${goods.gdId}" ondblclick="showDictAttribute(this.name,${status.index },1,1,'${goods.gdnames }')" title="双击显示属性" >${goods.gdnames }</a><c:if test="${goods.gdSchilds == 1}"><span onclick="shownext(${goods.gdId },${status.index },1)"  title="点击显示下一类目">>></span></c:if>
		          			<!-- onclick="shownext(this.name,${status.index },1)"  -->
		          		</li>
		          	
		          	</c:if>
		          	
		          </c:forEach>
	                       
	          </ul>
          </li>
          <li id="li_2">
	          <input type="hidden" id="p_level2" value="0"/>
	          <input type="hidden" id="p_position2" value="0"/>    
          </li>
          <li id="li_3">
          <input type="hidden" id="p_level3" value="0"/>
	      <input type="hidden" id="p_position3" value="0"/>   
          	
          </li>
          <li id="li_4" style="display: none">
          	<input type="hidden" id="p_level4" value="0"/>
	        <input type="hidden" id="p_position4" value="0"/>
          	<ul class="fa_lei_li">
	            <li class="fa_yes"><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li class="fa_no">网店/网络服务/软件</li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>      
	          </ul>
          </li>
          <li id="li_5" style="display: none">
          	<input type="hidden" id="p_level5" value="0"/>
	      	<input type="hidden" id="p_position5" value="0"/>
          	<ul class="fa_lei_li">
	            <li class="fa_yes"><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li class="fa_no">网店/网络服务/软件</li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>
	            <li><a href="#">网店/网络服务/软件<span>>></span></a></li>      
	          </ul>
          </li>
          <li id="li_6" style="display: none">
          	<input type="hidden" id="p_level6" value="0"/>
	      	<input type="hidden" id="p_position6" value="0"/>
          </li>
          <li id="li_7" style="display: none">
          	<input type="hidden" id="p_level7" value="0"/>
	      	<input type="hidden" id="p_position7" value="0"/>
          </li>
          <li id="li_8" style="display: none">
          	<input type="hidden" id="p_level8" value="0"/>
	      	<input type="hidden" id="p_position8" value="0"/>
          </li>
          <li id="li_9" style="display: none">
          	<input type="hidden" id="p_level9" value="0"/>
	      	<input type="hidden" id="p_position9" value="0"/>
          </li>
          <li id="li_10" style="display: none">
          	<input type="hidden" id="p_level10" value="0"/>
	      	<input type="hidden" id="p_position10" value="0"/>
          </li>
        </ul>
        </div>
      </dd></dl>
      <dl><dt>当前类目：</dt><dd id="dict_path">${sa.goods_dict.gdnames }</dd></dl>
      <dl><dt>商品名称：</dt><dd><input id="sgname" class="fa_input" name="sgname" onblur="checksgname();" value="${sa.sgname}"/><em>*</em><em id="sgnameMsg"></em></dd></dl>
      <dl><dt>商品规格：</dt><dd><input id="sgNorms"  class="fa_input" name="sgNorms" onblur="checksgNorms();"  value="${sa.sgNorms}"/><em >*</em><em id="sgNormsMsg"></em></dd></dl>
      <dl><dt>商品单位：</dt><dd><input id="sgUnit" class="fa_input" name="sgUnit" onblur="checksgUnit();" value="${sa.sgUnit}"/><em>*</em><em  id="sgUnitMsg"></em></dd></dl>
      <dl><dt>商品价格：</dt><dd><input id="sgPrice" class="fa_input" name="sgPrice" onblur="checksgPrice();" value="${sa.sgPrice}"/><em>*</em><em  id="sgPriceMsg"></em></dd></dl>
      <dl><dt>商品数量：</dt><dd><input id="sgnumbers" class="fa_input" name="sgnumbers" onblur="checksgNumber();" value="${sa.sgnumbers}"/><em>*</em><em  id="sgNumberMsg"></em></dd></dl>
      <dl><dt>录入人：</dt><dd><input id="sgUsername" class="fa_input" name="sgUsername" readonly="readonly" <c:if test='${sa.sgUsername == null || sa.sgUsername == "" }'>value='${emp.name }'</c:if><c:if test='${sa.sgUsername != null && sa.sgUsername !="" }'>value='${sa.sgUsername }'</c:if> /><em>*</em></dd></dl>
      <dl><dt>商品状态：</dt><dd>
      <select class="input_select" id="sgStat" name="sgStat">
	      <option value="0"  <c:if test="${sa.sgStat==0}">selected="selected"</c:if> >仓库中商品</option>
	      <option value="2"  <c:if test="${sa.sgStat==1}">selected="selected"</c:if> >发布待审核</option>
      </select>
      <em>*</em><em id="sgStatMsg"></em></dd></dl>
      <dl>
      	<dt>出库类型：</dt>
      	<dd>
	      <label><input type="radio" name="sgchecks" id="sgchecks" value="1" <c:if test="${sa.sgchecks1==1}">checked</c:if> />IDC上架</label>
	      <label><input type="radio" name="sgchecks" id="sgchecks" value="0" <c:if test="${sa.sgchecks1==0}">checked</c:if>/>销售出库</label>
	      <em>*</em><em id="outtypeMsg"></em>
	      </dd>
	  </dl>
	  <dl id="checkYes" style="display:none">
      	<dt>上架类型</dt>
      	<dd>
	      <label><input type="radio" name="sgchecks1" id="sgchecks1" value="1" <c:if test="${sa.sgchecks2==1}">checked</c:if>/>托管</label>
	      <label><input type="radio" name="sgchecks1" id="sgchecks1" value="2" <c:if test="${sa.sgchecks2==2}">checked</c:if>/>租用</label>
	      <em>*</em><em id="vartypeMsg"></em>
	      </dd>
	  </dl>
      <dl>
      	<% Date date= new Date();
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
           String str=sdf.format(date);
        %>
      	<dt>创建时间：</dt>
      	<dd>${sa.sgtime }<input type="hidden" class="fa_input" id="sgtime" name="sgtime" value="<%=str %>" readonly="readonly"/><em></em></dd></dl> 
      		<textarea  id="sgDetails" name="sgDetails" style="height: 50; width: 600px;display: none;">
		   </textarea>
		   <textarea id="productgevalue" name="productgevalue" style="height: 50; width: 600px;display: none;">
		   </textarea>
		   <input type="hidden" id="imgs" value="${sa.sgImg }" />
		   <input  type="hidden" id="img1" name="img1" value="" />
		   <input  type="hidden" id="img2" name="img2" value="" />
		   <input  type="hidden" id="img3" name="img3" value="" />
		   <input  type="hidden" id="img4" name="img4" value="" />
		   <input  type="hidden" id="img5" name="img5" value="" />
		   <input  type="hidden" id="img6" name="img6" value="" />
		   <input  type="hidden" id="attrstr" name="attrstr" value="${sa.sgAttribute }" /><!-- 最后生成的属性字符串 -->
		   <input  type="text" id="first_spec_str" name="first_spec_str" value="${first_spec_str }" /><!-- 最后生成的属性字符串 -->
		   <input  type="hidden" id="second_spec_str" name="second_spec_str" value="${second_spec_str }" /><!-- 最后生成的属性字符串 -->
		   <input type="hidden" id="sgPuttime" name="sgPuttime" value="${sa.sgPuttime}" /><!-- 发布时间 -->
      </form>
      <form method="post" id="formadds" name="formadds" action="">
      <dl>
      	<dt>图片上传：</dt>
      	<dd>
      		<input id="fileupload" name="fileupload"  type="file" class="fa_input"  />
      		<input type="button" onclick="uploadImage()" class="fa_buttom" value="上传"/>
      		<input id="ico" name="ico" class="fa_buttom" type="hidden" />
      		<div id="tipDiv"></div>
      		<em>*请使用500k以内的图片，800*800像素，可以在宝贝详情里面有宝贝放大功能。</em>
      		<em id="imgMsg"></em>
      	</dd>
      </dl>
      <dl><dt>商品图片：</dt><dd><ul class="fa_picture">
        <div id="showpath">
        </div>
        <li>
        	<div class="fa_picture_t"><img  alt="图片规格" src="<%=path %>/product_manage/img/imggg.jpg" width="106" height="106"/></div>
        	<div class="fa_picture_d">
        		图片规格
        	</div>
        </li>
        <li>
        	<div class="fa_picture_t"><img id="imga1" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(1)"/>
        	</div>
        </li>
         <li>
        	<div class="fa_picture_t"><img id="imga2" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(2)"/>
        	</div>
        </li>
         <li>
        	<div class="fa_picture_t"><img id="imga3" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(3)"/>
        	</div>
        </li>
         <li>
        	<div class="fa_picture_t"><img id="imga4" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(4)"/>
        	</div>
        </li>
         <li>
        	<div class="fa_picture_t"><img id="imga5" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(5)"/>
        	</div>
        </li>
        <li>
        	<div class="fa_picture_t"><img id="imga6" alt="图片规格" src="<%=path %>/product_manage/img/noneimg.jpg"/></div>
        	<div class="fa_picture_d">
        		<input type="button" class="fa_buttom" value="删除此图片" onclick="delectimg(6)"/>
        	</div>
        </li>
           
      	</ul>
      </dd>
     </dl>
     </form>
      <dl><dt>商品详情：</dt>
          <dd>
      		<FCK:editor  inputName="txtarea" instanceName="txtarea" height="300px;">
				<jsp:attribute name="value" >${sa.sgDetails}</jsp:attribute>
			</FCK:editor>
      	  </dd>
      </dl>
      <dl><dt></dt><dd><em>*</em><em id="spxqMsg"></em>请填写商品详情</dd></dl>
      <dl><dt>商品特殊属性：</dt><dd>
      
      
        <div class="fa_zong" id="dict_attr">
        ${html_attr_str }
        </div>
        
      
      </dd></dl>
      <dl>
      	<dt>商品规格：</dt>
      	<dd>
      		<div class="fa_zong" id="dict_spec">
      		${html_spec_str }
      		</div>
      	</dd>
      </dl>
      <dl><dt>商品规则：</dt><dd>
      	<table class="fa_table">
        <thead>
        	<tr>
        		<th width="15%">计费周期</th><th width="15%">线路</th><th width="15%">价格</th><th width="15%">数量</th><th width="40%">备注</th>
       		</tr>
       	</thead>
        <tbody id="tablist">
        </tbody>
      </table></dd></dl>      
   </div>
  <input type="hidden" id="cfg_str" name="cfg_str" value="${cfg_str }"/>
   <div class="fa_footer fa_width">
     <input type="button" value="确定" class="fa_buttoms" onclick="getValue()" id="butnform" style="margin-right:20px;" /> <input type="reset" value="重新填写" class="fa_buttoms" />
   </div>
   <dl><dt>规格源码：(测试用)</dt><dd><textarea class="input_texta" id="specarea" name="specarea">${html_spec_str }</textarea></dd></dl>
   
</div>
</body>
<script type="text/javascript">
	var pjpath = "<%=path %>";
	function shownext(gdid,sid,level){
		
		build_dict_li(gdid,sid,level,pjpath);
	}
	function showDictAttribute(gdid,sid,level,flag,gdname){
		//调用commodity.js方法
		//alert(12324);
		$("#goods_dictid").val(gdid);
		//alert(gdname);
		$("#dict_path").html(gdname);
		
		//alert("showDictAttribute");
		//alert($("#goods_dictid").val());
		
		build_attr_and_spec2(gdid,sid,level,flag,pjpath);
		
	}
	//测试类
	function selectClass1(){
		//alert(111);
		//alert($('#sgDetails').text());
		
		
		
	}
	function buildresultStr(){
		tag_i=[];
		tag_s=[];
		tag_c=[];
		tag_r=[];//i-input s-select c-checkbox r-radio
		label_i=[];
		label_s=[];
		label_c=[];
		label_r=[];
		var cfgstr = $("#cfg_str").val();
		if(cfgstr == "无"){
			alert("无配置参数，有可能是数据问题，有可能是该商品类目无属性");
			return "";
		}
		var cfgstr1 = cfgstr.split(",");//第一次分割
		for(i=0;i<cfgstr1.length;i++){
			var  ss = cfgstr1[i].split("-");
			ss[0];//序号
			ss[1];//标签类型
			ss[2];//label
			if(ss[1]=="1"){//文本框
				tag_i.push(ss[0]);
				label_i.push(ss[2]);				
			}else if(ss[1]=="2"){//文本框
				tag_s.push(ss[0]);
				label_s.push(ss[2]);				
			}else if(ss[1]=="3"){//文本框
				tag_c.push(ss[0]);
				label_c.push(ss[2]);				
			}else if(ss[1]=="4"){//文本框
				tag_r.push(ss[0]);
				label_r.push(ss[2]);				
			}
			
		}

		
		var i_str = "";
		var s_str = "";
		var c_str = "";
		var r_str = "";
		//alert(tag_i.length);
		//alert(tag_s.length);
		//alert(tag_c.length);
		//alert(tag_r.length);
		for(i=0;i<tag_i.length;i++){
			var str = $("#input"+tag_i[i]).val();//得到文本中的值
			if(str == ""){
				str="无";
			}
			i_str += "1|"+tag_i[i]+"|"+label_i[i]+"|"+str;
			i_str +=";";
		}
		for(i=0;i<tag_s.length;i++){
			//alert(tag_s[i]);
			var str = $("#select"+tag_s[i]).val();//得到下拉选中的值
			//alert(str);
			if(str == ""){
				str="无";
			}
			//alert(label_s[i]);
			s_str += "2|"+tag_s[i]+"|"+label_s[i]+"|"+str;
			s_str +=";";
			//alert(s_str);
		}
		for(i=0;i<tag_c.length;i++){
			var str ="";
			$($("input[name='checkbox"+tag_c[i]+"']:checked")).each(function(){
	    	     
	    	     str+=this.value + ',';
	    	     //alert("name=checkbx"+i+chkid+" "+ss);
	    	});
	    	//alert("str="+str);
	    	if($.trim(str) == ''){
	    		//alert("checkobx为空");
	    		str ="无";
	    	}else{
				str = replaceblank(str);
		    }
	    	c_str += "3|"+tag_c[i]+"|"+label_c[i]+"|"+str;
			c_str +=";";
		}
		for(i=0;i<tag_r.length;i++){
			var tt = $("input:radio[name='radio"+tag_r[i]+"']:checked").val();
			//alert("tt="+tt);
			var str = $("input:radio[name='radio"+tag_r[i]+"']:checked").val();//得到单选中的值
			if(typeof(str)== "undefined" || str == ""){
				//alert("为空");
				str="无";
			}
			r_str += "4|"+tag_r[i]+"|"+label_r[i]+"|"+str;
			r_str +=";";
		}
		i_str = replaceblank(i_str);
		s_str = replaceblank(s_str);
		c_str = replaceblank(c_str);
		r_str = replaceblank(r_str);
		return i_str+"@"+s_str+"@"+c_str+"@"+r_str;
	}
	
	function replaceblank(str){
		if($.trim(str) == ""){
			str = "无";
		}else{
			str = str.substring(0,str.length-1);
		}
		return str;
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
		  for(i=1; i<imgvalue.length; i++){
		     $('#img'+i).attr('value',imgvalue[i]);
		  }
		}

		$("#butnform").click(function(){
	    	
	     	var oEditor = FCKeditorAPI.GetInstance('txtarea'); 
 	    	var detail1=oEditor.GetXHTML(true);
	     	//var detail1=$('#txtarea').te
	     	//alert("|"+$("#productgevalue").val()+"|为空");
	     	var str=$("#productgevalue").val();
	     	//alert(str.length);
	     	if(str=="  "){
		     		//alert("222222");
					return false;
		     	}
	     	//alert(121212);
	      	//alert(checkimg()+","+ checksgPrice() +","+ checksgUnit()+","+ checksgNorms() +","+ checksgname() +","+ checkgoods_dictid() +","+ checkspxq(detail1) +","+ checksgNumber());
	     	if(checkgoods_dictid()&&checksgname()&&checksgNorms()&&checksgUnit()&&checksgPrice() && checksgNumber()&&check_out()&&checkimg()&&checkspxq(detail1) && $("#productgevalue").val()!=""){
				$("#sgDetails").text(detail1);
				var ss = buildresultStr();
				//return;//测试用
				//alert("ss="+ss);
				$("#attrstr").val(ss);
				//alert(pjpath+"/pdm/add2productManager.do");
	            var url = pjpath+"/pdm/add2productManager.do";
	            $('#mainform').attr("action",url);
	            $('#mainform').attr("target","");
	            //alert($("#checkboxvalue").val());
	            document.forms["mainform"].submit();
	     	
	     	}else{
	         	//alert(flag1+","+flag2+","+flag3+","+flag4);
	         	alert("请完善资料");
	     	}
		     	
	    });


      	$('input:radio').click(function(){
	         if($('input:radio[name="sgchecks"]:checked').val()==1){
	               $('#checkYes').show(500);
	         }
	           if($('input:radio[name="sgchecks"]:checked').val()==0){
	               $('#checkYes').hide(200);
	         }
	     });

	      
		   
	});
	//验证
	 function checkgoods_dictid(){
	   var values= $('#goods_dictid').val();
	   if(values==""){
	       $('#goods_dictidMsg').html('商品类别不能为空，请选择!');
	       return false;
	   }else{
	        $('#goods_dictidMsg').html('商品类别已选');
	        return true;
	    }
	 }

	//商品名称
	   function checksgname(){
	    var values= $('#sgname').val();
	     if(values==""){
	     $('#sgnameMsg').html('商品名称不能为空!');
			return false;
	     }else{
		     $('#sgnameMsg').html('填写正确');
		     return true;
	     }
	   }
	   
	// 商品规格  -->
	   function checksgNorms(){
	    var values= $('#sgNorms').val();
	      if(values==""){
	        $('#sgNormsMsg').html('商品规格不能为空!');
	        return false;
	      }else{
	         $('#sgNormsMsg').html('填写正确');
	          return true;
	          }
	   }
	   
	  // 商品单位  --> class='iput_1' 
	   function checksgUnit(){
	    var values= $('#sgUnit').val();
	      if(values==""){
	        $('#sgUnitMsg').html('商品单位不能为空!');
	        return true;
	      }else{
	        $('#sgUnitMsg').html('填写正确');
	        return true;
	        }
	   }
	    //商品价格  -->
		function checksgPrice(){
	    	var values= $('#sgPrice').val();
	      	if(values==""){
	        $('#sgPriceMsg').html('商品价格不能为空!');
	        return false;
	      	}else{
	         	var num=/^[0-9]+(.[0-9]{1,3})?$/;
	         	if(num.test(values)){   
	            	$('#sgPriceMsg').html('填写正确');
	            return true;
	         	}else{
	            $('#sgPriceMsg').html('填写数字');
	            return false;
	         	}
	     	}
	   }
	//商品数量
   function checksgNumber(){
	      if($('#sgnumbers').val()!=""){
	         var num=/^[0-9]*$/;
	         if(num.test($('#sgnumbers').val())){   
	              $('#sgNumberMsg').html('填写正确');
	               return true;
	         }else{
	              $('#sgNumberMsg').html('填写数字');
	              return false;
	         }
	         
	      }else{
	         $('#sgNumberMsg').html('此项不能为空');
	      }
	       return false;
	   }
	//验证出库类型
	function check_out(){
		 //alert($('input:radio[name="sgchecks"]:checked').val());
         if($('input:radio[name="sgchecks"]:checked').val() == 'undefined' ){
         		$('#outtypeMsg').html("请选择出库类型");
               return false;
         }else if($('input:radio[name="sgchecks"]:checked').val()==1){//上架 则验证二级类型必选
         	
         	if($('input:radio[name="sgchecks1"]:checked').val()== 'undefined'){
  				 $('#vartypeMsg').html("请选择二级类型");
  				 return false;      	
         	}
         }
         //alert("check_out :true");
         return true;
	}
	//上传图片验证
	function checkimg(){
	    var img1= $('#img1').val();
	    var img2= $('#img2').val();
	    var img3= $('#img3').val();
	    var img4= $('#img4').val();
	    var img5= $('#img5').val();
	    var img6= $('#img6').val();
	    if(img1!='' || img2!='' || img3!='' || img4!='' || img5!=''|| img6!=''){
	    	$('#imgMsg').html('填写正确');
	        return true;
	     }else{
	        //alert(99999999999999);
	        $('#imgMsg').html('图片至少上传一张!'); 
	        return false;
	     }
	}

//  商品详情-->
    function checkspxq(v){
    var flag4=false;
      if(v==""){
        $('#spxqMsg').html('商品详情不能为空!');
           flag4=false;
      }else{
    	 $('#spxqMsg').html('填写正确');
    	 flag4=true;
    	 }
    	 return flag4;
   }

	var chk_value=[];//放机房的id值 第一规格的key
	var chk_text=[];//机房的text 第一规格的text
	var xv_value=[];//宽带value的list 第二规格的ID
  	var xv_text=[];//宽带text的list 第二规格的text
	var first_spec_str = $("#first_spec_str").val();
	var second_spec_str = $("#second_spec_str").val();
	var checkbox1="";
	var checkbox2="";
    $(document)
	.ready(
			function() {

				 $("#tablist").append("<tr id='fristtr' style='display:none'><td>1</td><td>1</td><td>1</td><td>1</td><td>1</td></tr>");		
	//初始化放值

	if(first_spec_str != ""){
		var firstarra1 =  first_spec_str.split(",");
		chk_value = [];
		chk_text = [];
		//alert(chk_text+"--");
		for(i=0;i<firstarra1.length;i++){
			var firstarra2 = firstarra1[i].split("-");
			//chk_value.push(firstarra2[0]);
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
			//xv_value.push(secondarra2[0]);
			xv_text.push(secondarra2[1]);
			 checkbox2=secondarra2[2];
		}
	}
	
			});

	function recheboxload(){
	
		var first_spec_str1 = $("#first_spec_str").val();
		var second_spec_str1 = $("#second_spec_str").val();
		 $("#tablist").empty();
		 $("#tablist").append("<tr id='fristtr' style='display:none'><td>1</td><td>1</td><td>1</td><td>1</td><td>1</td></tr>");		
		
		if(first_spec_str1 != ""){
			var firstarra1 =  first_spec_str1.split(",");
			chk_value = [];
			chk_text = [];
			//alert(chk_text+"--");
			for(i=0;i<firstarra1.length;i++){
				var firstarra2 = firstarra1[i].split("-");
				//chk_value.push(firstarra2[0]);
			    chk_text.push(firstarra2[1]);
			   checkbox1=firstarra2[2];
			}
		
		}
		if(second_spec_str1 != ""){
			xv_value = [];
			xv_text = [];
			var secondarra1 =  second_spec_str1.split(",");
			for(i=0;i<secondarra1.length;i++){
				var secondarra2 = secondarra1[i].split("-");
				//xv_value.push(secondarra2[0]);
				xv_text.push(secondarra2[1]);
				 checkbox2=secondarra2[2];
			}
		}
		
			

		}
	function jqchk(id){//jquery获取复选框值
		//alert(id);
  	  	chk_value=[];
    	$("input[name='"+id+"']:checked").each(function(){
        	//alert("chk_valuei="+$(this).val());
  	  		chk_value.push($(this).val());    
  	  	});
  	  	//alert(chk_value);    
  	  //alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value);  
  		addlist();
  	}
  	
	function jqchxl(id){
		//alert("jqchxl");
    	xv_value=[];
		$("input[name='"+id+"']:checked").each(function(){   
			xv_value.push($(this).val());
    	 });			
		//alert(xv_value);    
		addlist();	
    }
    
	function addlist(){//addlist增加list
	  	 var chk=chk_value.length;//第一规格id数组的长度
 		 var  xv=xv_value.length;//第二规格id数组的长度
 	     var  allnum=chk*xv;//生成的二维表格的总长度
 	     //alert("allnum="+allnum);
 	   //$("#tablist").empty();//清空表数据重新加
		$("#tablist").find("tr").each(function(){//4564
			
		var aa=$(this).attr('id');
		if(aa!="fristtr"){
		//alert("aa="+aa);
			for(var i=0;i<chk;i++){
				var stat=chk_value[i];//开头
				//alert("stat="+stat);
				if(xv==0){
					var objtr=stat+"_";
					//alert(aa);
					if(objtr==aa){
						return;
					 // $("#tablist").append("<tr id="+stat+"_' ><td width='15%' align='right'>"+chk_value[i]+"</td><td align='right' width='15%'>"+" "+"</td><td><input tyep='text' id=rq"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=xl"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=bz"+stat+"_  class='fa_inputs'  /></td></tr>");  
					}
					else{
						
					}
				}
				
				for(var j=0;j<xv;j++){
					var end=xv_value[j];//结尾
					var objtr1=stat+"_"+end;//山东联通_1200元/月
					if(objtr1==aa){
						return;
						//$("#tablist").append("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+chk_value[i]+"</td><td width='15%' align='right'>"+xv_value[j]+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  			
					}else{
						// $(this).hide();
					}
				}
			}
		
			$(this).remove();
		}
		});
		for(var i=0;i<chk;i++){
			var stat=chk_value[i];//开头
			if(xv==0){
				var objtr=$("#"+stat+"_");
				//alert("#"+stat+"_.length="+objtr.length);
				if(objtr.length>0){}
				else{
					
					var num1=chk_value[i];//获取机房的值
					//alert(num1+"机房的看key");
					var tdval1=chk_text[num1-1];
					//alert(chk_text[1]);
					
					//alert(tdval1);
					//table1 = document.getElementById("tablist");//table1为table的id
					//var count = table1.rows.length;
					//alert(count);
					//if(coun
					//alert(i+"I");
					if(i==0){

						$("#fristtr").after("<tr id="+stat+"_><td width='15%' align='right'>"+tdval1+"</td><td align='right' width='15%'>"+" "+"</td><td><input tyep='text' id=rq"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=xl"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=bz"+stat+"_  class='fa_inputs'  /></td></tr>");  
						}
					else{
						//alert(chk_value[i-1]);
	
						$("#"+chk_value[i-1]+"_").after("<tr id="+stat+"_><td width='15%' align='right'>"+tdval1+"</td><td align='right' width='15%'>"+" "+"</td><td><input tyep='text' id=rq"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=xl"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=bz"+stat+"_  class='fa_inputs'  /></td></tr>");  


						}
				 	
				}
			}
			for(var j=0;j<xv;j++){
				var end=xv_value[j];//结尾
			
				var objtr1=$("#"+stat+"_"+end);
				//alert("#"+stat+"_"+end+".length="+objtr1.length);
				if(objtr1.length>0){}
				else{
					var num1=chk_value[i];//获取机房的值
					
					var tdval1=chk_text[num1-1];
					var num2=xv_value[j];
					var tdval2=xv_text[num2-1];
					if(j==0){//这个机房下的宽带是第一个，排在上个机房的下面
						if(i==0){
							$("#fristtr").after("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+tdval1+"</td><td width='15%' align='right'>"+tdval2+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  	
							}else{

								$('#'+chk_value[i-1]+"_"+xv_value[xv-1]).after("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+tdval1+"</td><td width='15%' align='right'>"+tdval2+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  	
								}
					
					
					}
					else{
						var  end1=xv_value[j-1];
						$('#'+stat+"_"+end1).after("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+tdval1+"</td><td width='15%' align='right'>"+tdval2+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  	

						}
					
					//$("#tablist").append("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+tdval1+"</td><td width='15%' align='right'>"+tdval2+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  			
				}
			}
		}
      }


	var newstr="";
	function getValue(){
    	var chk=chk_value.length;//周期数组的长度
 		var  xv=xv_value.length;//线路的长度	
		if(chk>0){
			for(var i=0;i<chk;i++){
				if(xv==0){
					if($("#rq"+chk_value[i]+"_").val()=="" || $("#xl"+chk_value[i]+"_").val()=="" || $("#bz"+chk_value[i]+"_").val()==""){
						alert("数量价格备注不能为空");
						newstr="";
						return false;
					}else	if(isNaN($("#rq"+chk_value[i]+"_").val()) || isNaN($("#xl"+chk_value[i]+"_").val())){
						alert("数量价格备注不能为空");
						newstr="";
						return false;
				     }else{
					newstr+=chk_value[i]+","+","+$("#rq"+chk_value[i]+"_").val()+","+$("#xl"+chk_value[i]+"_").val()+","+$("#bz"+chk_value[i]+"_").val()+","+chk_value[i]+"_"+"|";
				     }
					}
				else{
					for(var j=0;j<xv;j++)
					{	
					   if($("#rq"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#xl"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#bz"+chk_value[i]+"_"+xv_value[j]).val()==""){
							alert("数量价格备注不能为空");
							newstr="";
							return false;
					     }else if(isNaN($("#rq"+chk_value[i]+"_"+xv_value[j]).val()) || isNaN($("#xl"+chk_value[i]+"_"+xv_value[j]).val()) ){
							alert("数量价格必须为数字类型");
							newstr="";
							return false;
					     }else{
						 newstr+=chk_value[i]+","+xv_value[j]+","+$("#rq"+chk_value[i]+"_"+xv_value[j]).val()+","
						 +$("#xl"+chk_value[i]+"_"+xv_value[j]).val()+","+$("#bz"+chk_value[i]+"_"+xv_value[j]).val()+","+chk_value[i]+"_"+xv_value[j]+"|";
					     }
						     }
						
				}
		
			}
			if(newstr!=""){
			$("#productgevalue").val(newstr);
			}
			
		}else{
			return false;
		}
     }

	  function uploadImage() {
		  	//alert(111);
	        var img1=$('#img1').val();
			var img2=$('#img2').val();
			var img3=$('#img3').val();
			var img4=$('#img4').val();
			var img5=$('#img5').val();	
			var img6=$('#img6').val();	
			//alert(222);
			if(img1&&img2&&img3&&img4&&img5&&img6!=''){
			 alert("商品图片最多能上传6张 ");
			return ;
			}
			//alert(333);
		var files=$("#fileupload").val();
		if(files == null || files == "")
		{
			alert("请选择要上传的文件");
			return;
		}
		//alert(4444);
		$(document)
			.ready(
					function() {
						var options = {
						    url : "pdm/uploadproductManager.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									$("#tipDiv").html(data[0]);
									var pathi=pjpath;
									var va=pathi+data[1];
								    if(img1==null||img1==''){
								   $('#imga1').attr('src',va);
								   $('#img1').attr('value',va);
								   //alert(va);
								   	}else if(img2==null||img2==''){
								   	$('#imga2').attr('src',va);
								   $('#img2').attr('value',va);
								   	}else if(img3==null||img3==''){
								   	$('#imga3').attr('src',va);
								   $('#img3').attr('value',va);			    
								    }else if(img4==null||img4==''){
								   	$('#imga4').attr('src',va);
								   $('#img4').attr('value',va);			    
								    }else if(img5==null||img5==''){
								   	$('#imga5').attr('src',va);
								   $('#img5').attr('value',va);			    
								    }else if(img6==null||img6==''){
								    	$('#imga6').attr('src',va);
								   		$('#img6').attr('value',va);
								    }else{
								    alert("商品图片最多能上传5张 ");
								    return;
								    }
									$("#showpath").append("<input type='hidden' height='100' width='100' value='<%=path%>/"+data[1]+"'/>");
									$("#ico").attr("value",data[1])
								} else {
									$("#tipDiv").html(msg);
								}
							}
						};
						//alert(options);
						$("#formadds").ajaxSubmit(options);
						
						return false;
					});
	}

   function delectimg(id){
	  var img=$('#img'+id).val();
	  if(!img){
	    alert('您要删除的图片不存在,请先上传！');return;
	  }
	  $('#img'+id).attr('value',"");
	   $('#imga'+id).attr('src',"product_manage/img/noneimg.jpg"); 
	}

	
  </script>
  <% 
					String checkval=request.getAttribute("checkboxval")!=null?(String)request.getAttribute("checkboxval"):"";
					out.print(checkval);
					if(checkval!=""){
					String checklist[]=  checkval.split(",");
					
				
					
					for(int i=0;i<checklist.length;i++){
						if(checklist[i]!=null && !checklist[i].equals("")){
					%>
					<script type="text/javascript">
					
					$(document).ready(function(){

						var checkval1=<%=checklist[i].toString() %>;
						//alert(checkval1+"----ceckbox");
						$("input[name="+checkbox1+"]").each(function(){   
							var valx=$(this).val();//value值
							if(valx==checkval1){
								//alert(valx);
								$(this).attr("checked","checked");						
								}
				    	 });			
						
						 jqchk(checkbox1);
					     jqchxl(checkbox2);
							});
					</script>
					
					<% out.print(111);
					
					
					}}}
					String checkval1=request.getAttribute("checkboxval1")!=null?(String)request.getAttribute("checkboxval1"):"";
					out.print(checkval1);
					if(checkval1!=""){
							String checklist1[]=  checkval1.split(",");
					for(int i=0;i<checklist1.length;i++){
						if(checklist1[i]!=null && !checklist1[i].equals("")){
					%>
					<script type="text/javascript">
					
					$(document).ready(function(){

						var checkval2=<%=checklist1[i].toString() %>;
						//alert(checkval2+"----111ceckbox1");
						$("input[name="+checkbox2+"]").each(function(){   
							var valx1=$(this).val();//value值
							if(valx1==checkval2){
								//alert(valx1);
								$(this).attr("checked","checked");						
								}
				    	 });			
						
					    
						   jqchk(checkbox1);
						     jqchxl(checkbox2);
							});
					</script>
					
					<% out.print(111);
					
					
					}}}
						
						String strge=request.getAttribute("strge")!=null?(String)request.getAttribute("strge"):"";
						if(strge!=""){
						String strgelist[]=strge.split("\\|");
						out.print(strgelist);
						for(int i=0;i<strgelist.length;i++){
							if(strgelist[i]!=null && !strgelist[i].equals("")){
								
								String strgetdel[]=strgelist[i].split(",");
						%>
						<script type="text/javascript">
						
						$(document).ready(function(){

							

							$("#rq"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[2] %>");
							$("#xl"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[3] %>");	
							$("#bz"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[4] %>");	
							
								});
						</script>
						
						<% 
						
						
						}
					
						}
					}%>
         
</html>