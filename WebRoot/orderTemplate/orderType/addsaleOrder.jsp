<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addsaleOrder.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	

  </head>
  <script type="text/javascript" src="<%=request.getContextPath() %>/cdn/js/jquery-1.3.2.min.js"></script>

<script type="text/javascript">
	function al()
	{
		alert("jquery");	
	}
	function taocan()
	{
　		　window.open ('setMealInfo1.html') 
	}
</script>
<style type="text/css">	
.divclass{
	OVERFLOW:auto;
		scrollbar-face-color: #FFFFFF;
        scrollbar-shadow-color: #D2E5F4;
        scrollbar-highlight-color: #D2E5F4;
        scrollbar-3dlight-color: #FFFFFF;
        scrollbar-darkshadow-color: #FFFFFF;
        scrollbar-track-color: #FFFFFF;
		scrollbar-arrow-color: #D2E5F4;

	}

</style>
  <body>
	<table width="1000" border="0" cellpadding="0" cellspacing="0"  align="center">
  <tr>
    <td align="center" colspan="4"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; " >
        <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:988px;">
          <h3>增加订单</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
        <tr>
        	<td align="right" width="250" height="30"> 
            	单据类型：
            </td>
            <td align="left" width="250">
            	<select>
                	<option>请选择！！</option>
                    <option>销售订单</option>
                    <option>CDN订单</option>
                </select>
            </td>
            <td align="right" width="100">
            	套餐类型：
            </td>
            <td align="left" width="400">
            	<select onblur="al()">
                	<option>请选择！！</option>
                    <option>免费</option>
                    <option>赠送</option>
                </select>
            </td>
        </tr>
        <tr style="background:#fff;">
        	<td align="right" width="250" height="30">
            	付费类型：
            </td>
            <td  align="left" width="250">
            	<select>
                	<option>请选择！！</option>
                	<option>预付</option>
                    <option>后付</option>
                    <option>免费</option>
                    <option>赠送</option>
                </select>
            </td>
        	<td  align="right" width="100">
            	销售人员：
            </td>
            <td  align="left" width="400">
            	<input id="xiaoshou" name="" type="text"/><FONT color=#ff0000>（可选填写）</FONT>
            </td>
        </tr>
        <tr>
        	<td align="right" width="250">
            	客户姓名：
            </td>
            <td  align="left" width="250">
            	<input id="" name="" type="text"/>
                <input id="" name="" type="hidden"0/>
            </td>
        	<td  align="right" width="100">
            	订单描述：
            </td>
            <td  align="left" width="400">
            	<textarea style="height:50px;width:200px;"></textarea>
            </td>
        </tr>
        <tr>
        	<td colspan="4">
            	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                	<td colspan="8" height="15"></td>
                </tr>
                	<!--<tr>
                    	<td colspan="8" align="center" class="dt08" height="30">套餐</td>
                    </tr>-->
                    <tr class="dt08">
                    	<td width="15%" align="center" height="30">
                        	套餐名称
                        </td>
                        <td width="10%" align="center">
                        	活动开始时间
                        </td>
                        <td width="10%" align="center">
                        	活动结束时间
                        </td>
                        <td width="30%" align="center">
                        	套餐描述
                        </td>
                        <td width="10%" align="center">
                        	使用时长
                        </td>
                        <td width="10%" align="center">
                        	原价
                        </td>
                        <td width="10%" align="center">
                        	实际价格
                        </td>
                        <td width="5%" align="center">
                        	选择
                        </td>
                    <tr>
                     <tr>
                    	<td width="15%" align="center" height="30
                        ">
                        	<a href="#" onclick="taocan()">套餐a</a>
                        </td>
                        <td width="10%" align="center">
                        	2012-2-10
                        </td>
                        <td width="10%" align="center">
                	       2012-3-10
                        </td>
                        <td width="30%" align="center">
                        	因为迟到就的罚扫厕所，特此优惠办会员卡<a href="javascript:void(0)" id="jtip2" onclick="add(2)">详细信息</a>
                        	 <div id="alerts2" style="position:absolute; z-index:2; width:400px; height:100px;
                         	 background-color:#fff;  border:1px dashed #0166d4;display:none" class="divclass">
							<div align="right">
                            <span onclick="document.getElementById('alerts2').style.display='none'" style="color: #993333; font-weight:bold">关闭</span>
                            </div >提示弹出层2</div>
                        </td>
                        <td width="10%" align="center">
                        	1个月
                        </td>
                        <td width="10%" align="center">
                        	300
                        </td>
                        <td width="10%" align="center">
                        	1毛
                        </td>
                        
                    <tr>
                     
                   
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
