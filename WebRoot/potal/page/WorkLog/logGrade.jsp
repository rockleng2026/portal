<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>日志评分页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/potal/page/WorkLog/jquery.js"></script>
	<script type="text/javascript" src="<%=path%>/potal/js/comment.js"></script>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif;}
/*quiz style*/
.quiz{border:solid 1px #ccc;height:400px;width:500px;}
.pf{font-size:14px;height:26px;border-bottom:solid 1px #e8e8e8;padding-left:20px;background:#3c8301;color:#FFFFFF;position:relative;}
.quiz_content{padding-top:10px;padding-left:20px;position:relative;height:205px;}
.quiz_content .btm{border:none;width:100px;height:33px;background:url(<%=path%>/potal/images/btn.gif) no-repeat;margin:10px 0 0 64px;display:inline;cursor:pointer;}
.quiz_content li.full-comment{position:relative;z-index:99;height:41px;}
.quiz_content li.cate_l{height:24px;line-height:24px;padding-bottom:10px;}
.quiz_content li.cate_l dl dt{float:left;}
.quiz_content li.cate_l dl dd{float:left;padding-right:15px;}
.quiz_content li.cate_l dl dd label{cursor:pointer;}
.quiz_content .l_text{height:120px;position:relative;padding-left:18px;}
.quiz_content .l_text .m_flo{float:left;width:47px;}
.quiz_content .l_text .text{width:450px;height:109px;border:solid 1px #ccc;}
.quiz_content .l_text .tr{position:absolute;bottom:-18px;right:40px;}
/*goods-comm-stars style*/
.goods-comm{height:41px;position:relative;z-index:7;}
.goods-comm-stars{line-height:25px;padding-left:12px;height:41px;position:absolute;top:0px;left:0;width:400px;}
.goods-comm-stars .star_l{float:left;display:inline-block;margin-right:5px;display:inline;}
.goods-comm-stars .star_choose{float:left;display:inline-block;}
/* rater star */
.rater-star{position:relative;list-style:none;margin:0;padding:0;background-repeat:repeat-x;background-position:left top;float:left;}
.rater-star-item, .rater-star-item-current, .rater-star-item-hover{position:absolute;top:0;left:0;background-repeat:repeat-x;}
.rater-star-item{background-position: -100% -100%;}
.rater-star-item-hover{background-position:0 -48px;cursor:pointer;}
.rater-star-item-current{background-position:0 -48px;cursor:pointer;}
.rater-star-item-current.rater-star-happy{background-position:0 -25px;}
.rater-star-item-hover.rater-star-happy{background-position:0 -25px;}
.rater-star-item-current.rater-star-full{background-position:0 -72px;}
/* popinfo */
.popinfo{display:none;position:absolute;top:30px;background:url(<%=path%>/potal/images/comment/infobox-bg.gif) no-repeat;padding-top:8px;width:192px;margin-left:-14px;}
.popinfo .info-box{border:1px solid #f00;border-top:0;padding:0 5px;color:#F60;background:#FFF;}
.popinfo .info-box div{color:#333;}
.rater-click-tips{font:12px/25px;color:#333;margin-left:10px;background:url(<%=path%>/potal/images/comment/infobox-bg-l.gif) no-repeat 0 0;width:125px;height:34px;padding-left:300px;overflow:hidden;}
.rater-click-tips span{display:block;background:#FFF9DD url(<%=path%>/potal/images/comment/infobox-bg-l-r.gif) no-repeat 100% 0;height:34px;line-height:34px;padding-right:5px;}
.rater-star-item-tips{background:url(<%=path%>/potal/images/comment/star-tips.gif) no-repeat 0 0;height:41px;overflow:hidden;}
.cur.rater-star-item-tips{display:block;}	
.rater-star-result{color:#FF6600;font-weight:bold;padding-left:10px;float:left;}
<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; width:40px;height:22px; line-height:15px; text-align:center;}
 a{text-decoration: none;}
.wzls { color:#3b8801;}
</style>

<script type="text/javascript">
// 弹出层

</script>
</head>
  
<body>   
<div class="quiz">
	<div class="pf"><span style="font-weight: bold;line-height: 10px;">请评分</span><a style="margin-left: 420px;font-size: 24px;line-height:24px; color: #ffffff" href="javascript:removeDiv('addorUpdSuppers');">×</a></div> 
	<div class="quiz_content">
		<form action="" id="" method="post">
			<div class="goods-comm">
				<div class="goods-comm-stars">
					<span class="star_l">满意度：</span>
					<div id="rate-comm-1" class="rate-comm" border="1px solid red"></div>
				    <input type="hidden" name="grade" id="StarNum" value="" />
					<input type="hidden" id="path" value="<%=path %>" />
				</div>
			</div>
			<pre>
  <span class="wzls">以下是评分标准：</span>
	<span class="wzls">1:</span>错一个字扣0.5分。
	<span class="wzls">2:</span>条理不清，语句不通扣2分。
	<span class="wzls">3:</span>条理不清，语句不通扣2分。
	<span class="wzls">4:</span>条理不清，语句不通扣2分。
	<span class="wzls">5:</span>条理不清，语句不通扣2分。
	<span class="wzls">6:</span>条理不清，语句不通扣2分。
	<span class="wzls">7:</span>条理不清，语句不通扣2分。
	<span class="wzls">8:</span>条理不清，语句不通扣2分。
	<span class="wzls">9:</span>条理不清，语句不通扣2分。
	
</pre>
			<center><input type="button" class="gb_bt"  onclick="piyue()" value="确认"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="gb_bt" type="button" onclick="removeDiv('addorUpdSuppers')" value="关闭"></input></center>
		</form>
	</div><!--quiz_content end-->
</div><!--quiz end-->
  </body>
</html>
