<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <style type="text/css">
     br{
       color: #D8F0FC;
     }
     
     #d2{
      filter:Alpha(opacity=30);
     }
    
 
    </style>
    
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>

   <script type="text/javascript">
   function release(id){
    var sgdate=$('#sgdate'+id).val();
    if(!sgdate){
     $.post("pdm/releaseproductManager.do",{'id':id},function(data){
     $('#'+id).html(data);
     $('#sgdate'+id).attr('value',data);
     alert('商品发布成功');
     });
    }else{
    alert('该商品已发布');return;
    }
   }
   
   function undercarriage(id){
  var seeyou = 123;
  $.post("pdm/undercarriageproductManager.do",{'id':id,'seeyou':seeyou},function(data){
  if(data==1){
  alert('上架成功！');
      $('#upload'+id).html('出售中商品');
  }else{
    alert('操作失败,请稍后重试..');
  }
  });
   }
   
   
   </script>
    
   <script type="text/javascript"> 
   $(function(){
     $.post('pdm/checkValproductManager.do',function(data){
       var va=data.split("|");
       var sacode=va[0];
       var saname=va[1];
       var ctime=va[2];
       var ftime=va[3];
       if(sacode==null||sacode==" "){
       $('#sgcode').attr('value',"");
       }else{
       $('#sgcode').attr('value',sacode);
       }
       if(saname==null||saname==" "){
       $('#sgname1').attr('value',"");
       }else{
       $('#sgname1').attr('value',saname);
       }
       if(ctime==null||ctime==""){
       $('#uptime').attr('value',"");
       }else{
       $('#uptime').attr('value',ctime);
       }
       
       if(ftime==null||ftime==""){
       $('#ftime').attr('value',"");
       }else{
       $('#ftime').attr('value',ftime);
       }
     });
   });
   
   
   
 
   </script>
   
   
   <style type="text/css">
   .d1{ 
   position:absolute;
   z-index: 1000;
   top:25%;
   left:150;
   background-color: #FFFFFF;
   
   }
   .d2{ 
   position:absolute;
   z-index: 500;
   top:0;
   left:0;
   width:100%;
   height:100%;
   margin-left:5px;
   background-color: #7D7D7D;
   
   }
   table tr{
     height: 10px;
   }
   
   </style>
  </head>
  
  <body>
     <form action="pdm/ListproductManager.do?s=123" onsubmit="f();" name="form1" method="post">
        <input type="hidden" id="i1" value="0">
        <table width="1056" height="154">
         <tr>
          <td colspan="6" style="background-color: #87C5E9" height="18px;"><span style="">商品列表</span></td>
         </tr>
           <tr> 
           
              <td>商品编号：</td><td><input name="sgcode" id="sgcode" /></td><td>商品名称：</td><td><input name="sgname1" id="sgname1" ></td>
           
           </tr>
      <tr> 
              <td>创建时间：</td>
              
                <td>
                  <INPUT  style="WIDTH: 150px" id="uptime" name="ctime" 
                  
												onclick="WdatePicker()">
											<FONT color=#ff0000></FONT> 点击输入框获取时间<FONT color=#ff0000 id="upMsg"></FONT>
                </td>
              
              <td>发布时间：</td>
              
              <td>
              <INPUT  style="WIDTH: 150px" id="ftime" name="ftime" 
												onclick="WdatePicker({minDate:'#F{$dp.$D(\'uptime\')||\'2000-10-01\'}'})">
												<FONT color=#ff0000></FONT> 点击输入框获取时间<FONT color=#ff0000 id="downMsg"></FONT>
              </td>
           </tr>
       <tr> 
          <td colspan="6" align="center" height="70px;">
          <input type="submit"  value="查询">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="清空"> </td>
       </tr>    
        </table>
        </form>
        
        <hr/>
   
        <table width="1056"  bordercolor="#7D7D7D" cellpadding="0" cellspacing="0" border="1">
        
           <tr style=" background: #D5F1FC; height:  38px;" align="center" style="font-weight:" >
              <td>商品编码</td><td>商品名称</td><td>商品类别</td><td>商品价格</td>
              
              <td>创建时间</td><td>发布时间</td><td>审核状态</td><td>操作</td> 
           </tr>
         
           
           <c:forEach items="${pages.pageList}" var="data">
             
            <tr align="center" style="height: 34px;" bordercolor="#7D7D7D"  bgcolor="#ffffff" onMouseMove="javascript:this.bgColor='#E5FED5';" onMouseOut="javascript:this.bgColor='#ffffff';" >
              <td>${data.sgcode }</td><td>${data.sgname }</td><td>${data.goods_dict.gdId}</td><td>${data.sgPrice }</td>
              <td>${data.sgtime }</td>
              <td>
              <font id="${data.sgId}">${data.sgPuttime }</font>
              <input id="sgdate${data.sgId}" type="hidden" value="${data.sgPuttime }">
              
              </td><td>
<!--                <font id="upload${data.sgId}">-->
<!--              <c:if test="${data.sgStat==0}">仓库中商品</c:if>-->
<!--              <c:if test="${data.sgStat==1}">出售中商品</c:if>-->
<!--              <c:if test="${data.sgStat==2}">下架</c:if>-->
<!--                </font>-->
                  <font>
                    <c:if test="${data.sgStat==0}">仓库中商品</c:if>
                    <c:if test="${data.sgStat==1}">出售中商品</c:if>
                  </font>

              </td>
              <td> <a href="pdm/alterproductManager.do?id=${data.sgId }">修改</a> <a href="pdm/detailsproductManager.do?id=${data.sgId }" >详情</a></td>
           </tr>
     
           
           </c:forEach>
        
        <tr style="background: #D5F1FC; height:  38px;">
			<td id="page" colspan="8" align="center"> <p:pages url="../pdm/ListproductManager.do" /> </td>
        </tr>
				
        </table>
        
        <div class="d2" id="d2" style=" background: black; display: none; ">
        </div>
  </body>
</html>
