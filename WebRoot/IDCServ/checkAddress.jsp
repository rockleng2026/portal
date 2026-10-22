<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="<%=request.getContextPath() %>/IDCServ/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/IDCServ/js/chinaprovinces_0.2.1.js"></script>
		
	
<script type="text/javascript">


    var  f3=true;
function checkcode(){
    var  num=/^[1-9][0-9]{5}$/;
   var str1=$('#postalcode').val();
  if(!str1){
  $('#postalcode1').html("邮编不能为空");
  f3=false;
  }else if(num.test(str1)){
  $('#postalcode1').html("*");
  f3=true;
  }else{
  $('#postalcode1').html("邮编格式不正确");
  f3=false;
  }

}



var  f4=true;
function checkmoble(){
 var  num=/^1[3|4|5|8][0-9]\d{4,8}$/;
   var mobile=$('#mobile').val();
   if(mobile==""){
   $('#mobile1').html("手机不能为空");
   f4=false;
   }else if(num.test(mobile)){     
    $('#mobile1').html("*");   
    f4=true;
   }else{
   $('#mobile1').html("手机输入格式不正确");
   f4=false;
   }
}


var  f5=true;
function checkmoble1(){
 var  num=/^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/;
   var phone=$('#phone').val();
   if(phone==""){
   $('#phone1').html("");
   f5=true;
   }else if(num.test(phone)){     
    $('#phone1').html("*");   
    f5=true;
   }else{
   $('#phone1').html("*格式不正确,座机格式为010-1234567");
   f5=false;
   }
}

   function submitf(){
   
    var str= $('#netherlands1').val();
    if(!str){
    }else{
   var province=$('#demo2_province').val();
     var city=$('#demo2_city').val();
      var area=$('#demo2_area').val();      
      var str=province+" "+city+" "+area
     $('#netherlands').attr('value',str);
     if(province=='香港特别行政区'||province=='澳门特别行政区'||province=='台湾省'){    
          if(province=="" || $('#mobile').val()==""  || $('#particularAddress').val()=="" || $('#consignee').val()==""){
          alert("请把信息填写完整.");
          return;
     }else if(f3==false){
          $('#postalcode1').html("邮编格式不正确");
         return;    
     }else{
 
        if(f4==false){
        $('#mobile1').html("手机输入格式不正确");          
        return;
        }else{     
          if(!f5){
             $('#phone1').html("*格式不正确,座机格式为010-1234567");
             return;        
          }
        }

          form2.submit(); 
          return;
      }  
     }
     
      if(province=="" || city=="" || area=="" || $('#mobile').val()=="" || $('#particularAddress').val()=="" || $('#consignee').val()==""){
          alert("请把信息填写完整.");
          return;
     }else  if(f3==false){
   
          $('#postalcode1').html("邮编格式不正确");
         return;    
     }else{
 
        
        if(f4==false){
        $('#mobile1').html("手机输入格式不正确");          
        return;
        }else{     
          if(!f5){
             $('#phone1').html("*格式不正确,座机格式为010-1234567");
             return;        
          }
        }

          form2.submit(); 
          return;
      }
     
    }
 if($('#mobile').val()=="" || $('#particularAddress').val()=="" || $('#consignee').val()==""){
          alert("请把信息填写完整.");
     }else if(f3==false){
    
          $('#postalcode1').html("邮编格式不正确");
         return;    
     }else{
 
        
        if(f4==false){
        $('#mobile1').html("手机输入格式不正确");          
        return;
        }else{     
          if(!f5){
             $('#phone1').html("*格式不正确,座机格式为010-1234567");
             return;        
          }
        }

          form2.submit(); 
          return;
      } 
   }
</script>

<script>
   
   var f1=false;
  function consigneeval(){
   var s= $('#consignee').val();
    if(!s){
    $('#consignee1').html("收信人不能为空");
    f1=false;
    }else{
    $('#consignee1').html("*");
    f1=true;

    }
  }
  
  var f2=false;
  function checkpar(){
  var str=$('#particularAddress').val();
  if(!str){
  $('#particularAddress1').html("详细地址不能为空");
  f2=false;
  }else{
  $('#particularAddress1').html("*");
  f2=true;
  }
  
  
  }



</script>
<script type="text/javascript">
  $(function(){
      $('#divc2').hide();
      var str= $('#netherlands').val();
       var    s= str.split(" ");
     if(!s[0]){
     }else{
       $('#divc1').append("<select id='sele1' style=' border: 1px solid #DEDEDE;' ><option>"+s[0]+"</option></select>&nbsp;&nbsp;");
     
     }
     if(!s[1]){
     }else{
       $('#divc1').append("<select id='sele1' style=' border: 1px solid #DEDEDE;'><option>"+s[1]+"</option></select>&nbsp;&nbsp; ");
     }
     if(!s[2]){
     }else{
       $('#divc1').append("<select id='sele1' style=' border: 1px solid #DEDEDE;' ><option>"+s[2]+"</option></select>");
     }
  });  
  
  
  $(function(){
    $('#sele1').click(function(){
    $('#divc2').show();
    $('#divc1').hide();
    $('#netherlands1').attr('value','321');
    });
  });
  
  
</script>


</head>
  
  <body>
      <jsp:include page="head.jsp"></jsp:include>
     <jsp:include page="left.jsp"></jsp:include>
     <form action="uplateAddressCustomerServer.Action" name="form2" method="post">

      <div class="dd1303"><span style="width:130px;">收货地址详情</span><a href="javascript:;" onclick="submitf()" >[确定]</a></div>
        <br/>
       <div>
        <h4 style="margin-left: 480px;">收获地址记录</h4>
        <table style="margin-left: 240px; border: solid #7D7D7D 1px;width: 600px;">
        <tr>
           <td width="100px;" align="center">收信人</td><td width="200px;" align="center">详细地址</td>
           <td width="300px;" align="center">操作</td>
        </tr >
        <c:forEach items="${dal}" var="d">
         <tr>
           <td align="center">${d.consignee}</td><td align="center">${d.particularAddress }</td>
           
           <td align="center"><a href="<%=basePath%>useAddressCustomerServer.Action?id=${d.addressId}">[使用该地址]</a>     
           <c:if test="${count>1}" >
           <a onclick="if(confirm('确定删除？'))window.location='<%=basePath%>delAddressCustomerServer.Action?id=${d.addressId}'"> [删除地址]</a>
           </c:if>
           
           </td>
        </tr>
        </c:forEach>
     </table>
     </div>
      
      <div class="dd1302">
<div class="dd1308">
    <ul>
    
      <li>
        <dl>
          <dt>收货人:</dt>
          <dd>  
          <input type="hidden" name="id" value="${deli.addressId}" />
            <input name="consignee" id="consignee" onblur="consigneeval()" type="text" value="${deli.consignee}" /><span class="dd1008" id="consignee1">*</span>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
      <li>
        <dl>
          <dt>地区:</dt>
          <dd>
        <div  id="divc2">
          <span id='demo21'></span>
            <input id="demo2_province" name="demo2_province" type="hidden"/> <input type="hidden" id="demo2_city" name="demo2_city"  /> 
        <input type="hidden" id="demo2_area" name="demo2_area"  />
       <input type="hidden" name="netherlands" id="netherlands" value="${deli.netherlands}"/>
        <input type="hidden" name="netherlands1" id="netherlands1"/>
        </div>
        <div id="divc1">
         
        </div>
        
        
          </dd>
          <dd><span class="dd1008">*</span></dd>
        </dl>
        <div class="clear"></div>
      </li>
      <li>
        <dl>
          <dt>详细地址:</dt>
          <dd>
            <input style="width:315px;" name="particularAddress" id="particularAddress" onblur="checkpar()" type="text" value="${deli.particularAddress}" /><span class="dd1008" id="particularAddress1">*</span>
            <span class="dd1010">详细地址为必填项</span>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
      <li>
        <dl>
          <dt>邮政编码:</dt>
          <dd>
            <input style="width:100px;" name="postalcode"  onblur="checkcode()" id="postalcode" type="text" value="${deli.postalcode}"  /><span class="dd1008" id="postalcode1">*</span>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
      <li>
        <dl>
          <dt>手机:</dt>
          <dd>
            <input style="width:140px;" name="mobile" onblur="checkmoble()" id="mobile" type="text" value="${deli.mobile}" /><span class="dd1008" id="mobile1">*</span>
          </dd>
          <dt>座机:</dt>
          <dd>
            <input style="width:140px;" name="phones" onblur="checkmoble1()" id="phone" type="text"  value="${deli.phones}"/><span class="dd1008" id="phone1"></span>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
    </ul>    
  </div>
  </div>
<jsp:include page="bottom.jsp"></jsp:include>
</form>
<script>  
	$("#demo21").chinaprovinces({valueType:'name',change:function(province,city,area){
		$("#demo2_province").val(province);
		
		$("#demo2_city").val(city);
		$("#demo2_area").val(area);
	}});

</script>  
  </body>
</html>

