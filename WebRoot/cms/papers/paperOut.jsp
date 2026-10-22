<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">
		<title>文章发布</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/checkform-demo.css">
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="./cms/js/paperOut.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.checkform.js"></script>

		<style type="text/css">
		  @import url("cms/css/admin.css");
		  #upfile{
		    display: none;
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
		</style>
	</head>
<body>
<div id="weizhi" >
<div id="weizhiwz">当前位置&nbsp;&gt;&gt;&nbsp;内容部&nbsp;>>&nbsp;信息发布</div>
 </div>
<div class="conSet">
	<form action="" method="post" id="form1" name="form1" >
	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="space tableBg">
		
		<tr><td align="left" nowrap class="bg0" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;文章日期：
		<span>
		<%
		  SimpleDateFormat simple = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  String str=simple.format(new Date());
		  pageContext.setAttribute("strs",str);
		 %>
		<input name="news.senddate" id="senddate" type="text" value="${strs }" />
		文章的初始发布日期
		<input type="hidden" name="mark" id="mark" value="save"/>
		<input type="hidden" name="news.cid" id="cid" value="${news.cid}"/>
		<input type="hidden" name="news.contents" id="contents"/>
		<input type="hidden" name="news.smalltext" id="smalltext"/>
		<input type="hidden" name="news.newUrl" id="ulss" value="${news.newUrl }">
		<span id="datemsg" style="color:red;"></span>
		</span>
		</td>
		</tr>
  		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;标&nbsp;&nbsp;&nbsp;题：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span>
		<input type="text" name="news.title" id="title" size="50" value="${news.title }" />
		<span id="titlemsg" style="color:red;"></span>
		</span>
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;副标题：&nbsp;&nbsp;&nbsp;&nbsp;
		<span>
		<input type="text" name="news.ftitle" id="ftitle" size="50" value="${news.ftitle }" />
		<span id="ftitlemsg" style="color:red;"></span>
		</span>
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;文章来源：
		<span>
		<input type="text" name="news.source" id="source" size="50" value="${news.source }" />
		<span id="sourcemsg" style="color:red;"></span>
		</span>
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;所属栏目：
		<span>
		  <select name="news.classes.classid" id="typeid" style="width:100px;">		  
		      <option value="${news.classid }">${news.classes.classname }</option>
		  </select>
		  <span id="contentmsg" style="color:red;"></span>
		 </span> 
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;文章简介：<span id="papermsg" style="color:red;">	
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0" colspan="2">
	
				<FCK:editor instanceName="messagesmalltext" inputName="messagesmalltext" height="300px" basePath="/fckeditor" >
					<jsp:attribute name="value">
					${news.smalltext }
					</jsp:attribute>
				</FCK:editor>
			</td>
		</tr>
		<tr>
		
		<td align="left" nowrap class="bg0">&nbsp;&nbsp;&nbsp;&nbsp;显示设置：
        <span style="padding-left:10px;">
        <c:choose>
		<c:when test="${news.showflag eq 1}">
		      <input type="radio" id="showflag" name="news.showflag" value="0" >&nbsp;显示
			  <input type="radio" id="showflag" name="news.showflag" value="1" checked="checked"/>&nbsp;不显示
		</c:when>
		<c:otherwise>
		      <input type="radio" id="showflag" name="news.showflag" value="0" checked="checked">&nbsp;显示
			  <input type="radio" id="showflag" name="news.showflag" value="1"  />&nbsp;不显示
		</c:otherwise>
        </c:choose>
		</span>	  
			 </td>
		</tr>
	 
	   <tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;关 键 字：
		<span>
		<input type="text" name="news.keyboard" id="keybord" size="50" value="${news.keyboard }"  onblur="getdou(this.value)"/>不超过5个，用“,"逗号隔开,每次增加后也要加一个逗号。
		</span>
		</td></tr>
        <!-- 设置优先级 -->
        
        
        <tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;优 先 级：
		<span>
		<c:choose>
		<c:when test="${news.sequence == null || news.sequence == '' || news.sequence eq 0 }">
			<input type="text" name="news.sequence" id="sequence" size="10" value="0"  onblur="checkseq(this.value)"/>只能是范围为0~999的数字 默认为0 优先级越大越在前面。
		</c:when>
		<c:otherwise>
			<input type="text" name="news.sequence" id="sequence" size="10" value="${news.sequence }"  onblur="checkseq(this.value)"/>只能是范围为0~999的数字 默认为0 优先级越大越在前面。
		</c:otherwise>
		</c:choose>
		<span id="seqmsg" style="color:red;"></span>
		</span>
		</td></tr>
           
		</table>
		   <input type="hidden" id="imgs" value="${news.titlepic }" />
		   <input  type="hidden" id="img1" name="img1" value="" />
		   <input  type="hidden" id="img2" name="img2" value="" />
		   <input  type="hidden" id="img3" name="img3" value="" />
		   <input  type="hidden" id="img4" name="img4" value="" />
		   <input  type="hidden" id="img5" name="img5" value="" />
		   <input  type="hidden" id="img6" name="img6" value="" />
		</form>
		<form method="post" id="formadds" name="formadds" action="">
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="space tableBg">	
		
		<!-- 上传图片区域S -->
		
		<tr><td align="left" nowrap class="bg0"  colspan="2">
		
	      <dl>
	      	<dt class="bg0"></dt>
	      	<dd>
	      		图片上传：<input id="fileupload" name="fileupload"  type="file" class="fa_input"  />
	      		<input type="button" onclick="uploadImage()" class="fa_buttom" value="上传"/>
	      		<input id="ico" name="ico" class="fa_buttom" type="hidden" />
	      		<div id="tipDiv"></div>
	      		<em>*请使用500k以内的图片，800*800像素 图片太大影响上传速度，以及浏览打开速度</em>
	      		<em id="imgMsg"></em>
	      	</dd>
	      </dl>
	      <dl><dt></dt><dd><ul class="fa_picture">
	        <div id="showpath">
	        </div>
	        商品图片：
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
	    </td></tr>
		<!-- 上传图片区域E -->
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;文章内容：<span id="contentsmsg" style="color:red;">	
		</td>
		</tr> 
		
		<tr><td align="left" nowrap class="bg0" colspan="2">
	
		<FCK:editor instanceName="messagecontent" inputName="messagecontent" height="600px" basePath="/fckeditor">
		<jsp:attribute name="value">
		${news.contents }
		</jsp:attribute>
		</FCK:editor>
		</td></tr>
		<tr>
             <td colspan="2" align="center" nowrap class="bg1">
		        <input type="button" class="save_but" value="保 存" onClick="checkform()">
             </td>
           </tr>
	</table>
	</form>
</body>
<script type="text/javascript">
var pjpath = "<%=path %>";
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
});
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
	//alert(files);
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
					    url : "cms/uploadcmsbg.do",
						type : "POST",
						dataType : "script",
						success : function(msg) {
							if (msg.indexOf("#") > 0) {
								var data = msg.split("#");
								$("#tipDiv").html(data[0]);
								var pathi=pjpath;
								var va=data[1];
							    if(img1==null||img1==''){
							   $('#imga1').attr('src',va);
							   $('#img1').attr('value',va);
							   alert(va);
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
			//alert(5555);
			$("#formadds").ajaxSubmit(options);
			return false;
		});
	}
</script>
</html>
