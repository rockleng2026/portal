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
		<script language="javascript" type="text/javascript"
			src="<%=basePath%>js/My97DatePicker/WdatePicker.js"></script>
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
   //alert(123123);
  $.post("pdm/undercarriageproductManager.do",{'id':id},function(data){
  if(data==1){
       alert('下架成功！');
      $('#upload'+id).html('下架');
      location.reload();
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
   function clearall(){
       $('#sgcode').val('');
        $('#sgname1').val('');
         $('#uptime').val('');
          $('#ftime').val('');
       
   }
   function showdiv(a){
	   
			$("#d"+a).show();

	   }
   function closediv(a){

	   $("#d"+a).hide();
	   $("#d4").hide();
	   }
   function showdiv1(a,b,c,beg,end){
	   $("#d4").show();
	   $("#sgname").text(b);
	   $("#sgid").val(a);
	   if(c==0 || c=='' || c==null){
	   $("#sgzt").text("未促销");
	   $("#d5").show();
	   $("#d6").hide();
	   }else{
		   $("#sgzt").text("促销：商品促销期("+beg+"/"+end+")");
		   $("#d6").show();
		   $("#d5").hide();
		   }
	   
	   }

   function subcx(){
		var t1=$("#t1").val();
		var t2=$("#t2").val();
	    var sgid=$("#sgid").val();
	    var cxprice=$("#cxprice").val();
	    
   if(t1!="" && t2!= "" && cxprice!=""){

	   if(isNaN(cxprice)){

		   alert("价格不是数字类型！");
			return;
		    }
		$.ajax({
			url:'pdm/changesproductManager.do',
			data:{t1:t1,t2:t2,sgid:sgid,cxprice:cxprice},
			type:'post',
			success:function(res){
			    
				location.reload();

				}



			});
   }else{

		alert("不允许有空值!");

	   }



	   }
  function delcx(){
	   var sgid=$("#sgid").val();
	   $.ajax({
			url:'pdm/delcxproductManager.do',
			data:{sgid:sgid},
			type:'post',
			success:function(res){
			    
				location.reload();

				}



			});



	  }
   
   
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
    .d3{ 
   position:absolute;
   z-index: 10000;
   top:200px;
   left:500px;
   width:400px;
   height:200px;
   margin-left:5px;
   background-color: #FFFFFF;
   
   }
   .d4{ 
   position:absolute;
   z-index: 10000;
   top:200px;
   left:500px;
   width:400px;
   height:200px;
   margin-left:5px;
   background-color: #FFFFFF;
   
   }
   table tr{
     height: 10px;
   }
   
   </style>
  </head>
     
  <body>
     <form action="pdm/List1productManager.do?s=123" onsubmit="f();" name="form1" method="post">
        <input type="hidden" id="i1" value="0">
        <table width="1056" height="154">
         <tr>
          <td colspan="6" style="background-color: #87C5E9" height="18px;"><span style="">商品列表</span></td>
         </tr>
           <tr> 
           
              <td>商品编号：</td><td><input type="text" name="sgcode" id="sgcode" /></td><td>商品名称：</td><td><input type="text" name="sgname1" id="sgname1" ></td>
           
           </tr>
      <tr> 
              <td>创建时间：</td>
              
                <td>
                  <INPUT  type="text" style="WIDTH: 150px" id="uptime" name="ctime" 
												onclick="WdatePicker()">
											<FONT color=#ff0000></FONT> 点击输入框获取时间<FONT color=#ff0000 id="upMsg"></FONT>
                </td>
              
              <td>发布时间：</td>
              
              <td>
              <INPUT type="text" style="WIDTH: 150px" id="ftime" name="ftime" 
												onclick="WdatePicker({minDate:'#F{$dp.$D(\'uptime\')||\'2000-10-01\'}'})">
												<FONT color=#ff0000></FONT> 点击输入框获取时间<FONT color=#ff0000 id="downMsg"></FONT>
              </td>
           </tr>
       <tr> 
          <td colspan="6" align="center" height="70px;">
          <input type="submit"  value="查询">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" onclick="clearall()" value="清空"> </td>
       </tr>    
        </table>
        </form>
        
        <hr/>
   
        <table width="1056"  bordercolor="#7D7D7D" cellpadding="0" cellspacing="0" border="1">
        
           <tr style=" background: #D5F1FC; height:  38px;" align="center" style="font-weight:" >
              <td>商品编码</td><td>商品名称</td><td>商品类别</td><td>商品价格</td>
              
              <td>创建时间</td><td>发布时间</td><td>促销状态</td><td>商品状态</td><td>操作</td> 
           </tr>
         
           
           <c:forEach items="${pages.pageList}" var="data">
             
            <tr align="center" style="height: 34px;" bordercolor="#7D7D7D"  bgcolor="#ffffff" onMouseMove="javascript:this.bgColor='#E5FED5';" onMouseOut="javascript:this.bgColor='#ffffff';" >
              <td>${data.sgcode }</td><td>${data.sgname }</td><td>${data.goods_dict.gdnames}</td><td>${data.sgPrice }</td>
              <td>${data.sgtime }</td>
              <td>
              <font id="${data.sgId}">${data.sgPuttime }</font>
              <input id="sgdate${data.sgId}" type="hidden" value="${data.sgPuttime }">
              
              </td>
              <td> <c:if test="${data.isActivity==0}">未促销</c:if>
              <c:if test="${data.isActivity==1}">
            
              <p onmouseup="showdiv('${data.sgId }')">
             
              
              <c:if test="${data.activityStart<date1 && data.activityEnd<date1 }" >促销已结束</c:if>
              
             <c:if test="${data.activityEnd>date1 && data.activityStart>date1 }" >促销未开始</c:if>
             <c:if test="${data.activityStart>=date1 && data.activityEnd<=date1 }" >
                             正在促销
             
             </c:if>
              <c:if test="${data.activityStart<=date1 && data.activityEnd>=date1 }" >
                             正在促销
             
             </c:if>
              </p>
              </c:if>
              </td>

              <div style="display: none" id="d${data.sgId }" class="d3">
                                   促销价格：${data.activityPrice}<br/>
           		   开始时间：${data.activityStart}<br/>
          	   	   结束时间: ${data.activityEnd}<br/>
          	   	   
          	   	   <br/><input type="button" onclick="closediv('${data.sgId }')" value="关闭"/>
               
              </div>
              
              <td>
                <font id="upload${data.sgId}">
              <c:if test="${data.sgStat==0}">仓库中商品</c:if>
              <c:if test="${data.sgStat==1}">出售中商品</c:if>
              <c:if test="${data.sgStat==2}">发布待审核</c:if>
                </font>
<!--                  <font>-->
<!--                  <c:if test="${data.sgCheckGoods==0}">待审核</c:if>-->
<!--                   <c:if test="${data.sgCheckGoods==1}">已通过</c:if>-->
<!--                  </font>-->
              </td>
              <!--  
              <td>  <a href="javascript:;" onclick="undercarriage(${data.sgId });">下架</a> <a href="pdm/detailsproductManager.do?id=${data.sgId }&goodsNo=${data.sgcode }&info=info" >详情</a> <a href="pdm/detailsproductManager.do?id=${data.sgId}&goodsNo=${data.sgcode }&info=info" >代客购买</a></td>
              -->
              
              <td><a href="javascript:;" onclick="undercarriage(${data.sgId });" style="text-decoration:none;">下架</a> <a href="pdm/details2productManager.do?id=${data.sgId }&goodsNo=${data.sgcode }&info=info" style="text-decoration:none;">详情</a> <a href="javascript:showdiv1('${data.sgId }','${data.sgname }',${data.isActivity},'${data.activityStart}','${data.activityEnd}')">促销操作</a></td>
             <!--
              <td><a href="pdm/detailsproductManager.do?id=${data.sgId }&goodsNo=${data.sgcode }&info=info" style="text-decoration:none;">详情</a></td>
              -->
           </tr>
     
           
           </c:forEach>
        
        <tr style="background: #D5F1FC; height:  38px;">
			<td id="page" colspan="9" align="center"><p:pages url="pdm/List1productManager.do" /></td>
        </tr>
				
        </table>
        
        <div class="d2" id="d2" style=" background: black; display: none; ">
        </div>
        <div class="d4" id="d4"  style="display: none;">
                商品名称：<span id="sgname"></span><br/>
                促销状态：<span id="sgzt"></span><br/>
                <input type="hidden" id="sgid"/>
         <div id="d5" style="display: none">    
                促销价格:<input type="text" value="" id="cxprice"/><br/>
                 开始日期:<input id="t1" type="text" value="" onclick='WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss"})'/><br/>   
                 结束日期:<input id="t2" type="text" value="" onclick='WdatePicker({dateFmt:"yyyy-MM-dd HH:mm:ss"})'/><br/>      
        <input type="button" value="确认促销" onclick="subcx()"/></div>   
        
        <div  id="d6" style="display: none"> <input type="button" onclick="delcx()" value="取消促销"/></div>
         <input type="button"  value="关闭" onclick="closediv(1)"/>
        
        
        </div>
  </body>
</html>
