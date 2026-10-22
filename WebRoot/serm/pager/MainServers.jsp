<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.City"%>
<%@page import="com.fuao.fajxc.vo.ElectHouse"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>机房管理页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
	<script type='text/javascript' src='<%=basePath %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=basePath %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=basePath %>/dwr/util.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/serm/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/serm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/serverJs.js"></script>
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" media="all" href="<%=basePath%>serm/css/mainstyle.css" />
	<script type="text/javascript">

  // ajax请求 后台传数据到页面
  function selElectHouse(obj){
    var name=obj.name;
    $.post("cms/creteLeftMenuServers.do",{"city.name":city,'house.electName':name},
           function(result){
             
           });
  }
   function showCity(obj){
      var m,n;
      var i = obj;
      var cityname=obj.value;  
      m=$("#m"+i).val();  //m superid
      n=$("#n"+i).val();  // n  主键
      $.post('cms/showCityServers.do',{'city.id':n,'city.superid':m},function(data){
         if(data!=null || data!=""){
          $('#allcity li').remove();
          var arr = new Array();
          arr = data.split(",");
          for(var i=0;i<arr.length;i++){
              if(arr[i]!=""){
                 $('#allcity').append('<li style="width:60px;" >'+arr[i]+'</li>');
              }
          }
          }
              
      });
   }
     function getCitys(obj,ps){
	      //alert("ps="+obj+","+ps);
	      var path = $('#bathpath').val();
	      if(ps==-1){
	          //alert("ps="+ps);
	          obj.href=path+"cms/creteLeftMenuServers.do?city.id=0&suces=no";
	      }
	  }

var jq=function(id) {
   return document.getElementById(id);
}


function show_menuB(numB){
    $('#getAreas').show();
	for(j=0;j<100;j++){
		 if(j!=numB){
			if(jq('Bli0'+j)){
		  jq('Bli0'+j).style.display='none';
		  jq('Bf0'+j).style.background='url(<%=basePath%>serm/img/bg01.jpg)';
		}
		 }
	}
	if(jq('Bli0'+numB)){   
		if(jq('Bli0'+numB).style.display=='block'){
		  jq('Bli0'+numB).style.display='none';
		 jq('Bf0'+numB).style.background='url(<%=basePath%>serm/img/bg01.jpg)';
		}else {
		  jq('Bli0'+numB).style.display='block';
		  jq('Bf0'+numB).style.background='url(<%=basePath%>serm/img/bg01over.jpg)';
          classSelt();
		}
	}
}
 function jqjq(str){ return document.getElementsByTagName(str);}
 var timer;
 function changeMenu(thisObj,num){
  if(thisObj.className=="over") return false;
  showCity(thisObj.id);
  hids(thisObj);
  thisObj.className="over";
  if(num>5){
     $('.over').addClass('pbtop');
  }
  jq("c"+(num)).className="block";
  jq("c"+(num)).onmouseover=function(){clearTimeout(timer);}
  jq("c"+(num)).onmouseout=function(){timer=setTimeout(function(){hids(thisObj);},500)}
  thisObj.onmouseout=function(){timer=setTimeout(function(){hids(thisObj);},4000)}
  
 }
 function hids(thisObj){
  clearTimeout(timer);
  var tabObj=thisObj.parentNode.getAttribute("id");
  var obj_dt=jq(tabObj).getElementsByTagName("dt");
  for(var i=0;i<obj_dt.length;i++){
   obj_dt[i].className="normal";
   jq("c"+(i)).className="none";
  }
 }
</script>
	<script type="text/javascript">
	        $(function(){ 
	          $('#electIds').click(function(){
	              //alert(998);
	            if(document.getElementById('electIds').options.length==1){
	              var ms=$('#eletid').val();
	              //alert("ms="+ms);
	              e.ReAtRoom(ms,function(res){
	                  //alert(res);
	                  $('#electIds').append(res);
	              });
	            }
	          });
	        });
	     
			function onClickCabinet()
			{ 
			   // alert("来");
				var caname = $('#caname').val();
				var casz = $('#casz').val();
				var pmax = $('#pmax').val();
				var bwmax = $('#bwmax').val();
				var btt=0;
				if(caname == "")
				{
				   // alert(1);
					$('#lbl1').show();
					btt=0;
				}
				else if($('#electIds').val()==0){
				        // alert(2);
				        $('#rom1').html('请选择房间号');
				       btt=0;
				}
				else if(casz == "" || isNaN(casz))
				{
					$("#lbl2").show();
					return false;
				}
				else if(pmax == "" || isNaN(pmax))
				{
					$('#lbl3').show();
					btt=0;
				}
				else if(bwmax == "" || isNaN(bwmax))
				{
					$('#lbl4').show();
					btt=0;
				}else if($('#addOrupdCabs').html()=="修改机柜信息"){
					   document.getElementById("apForm").action="cms/show_updateCa.do";
					    var caids=$('#cabsid').val();
					   	e.getUpdSize((caids+","+casz),function(result){
					   	   //alert("resu="+result);
					   	   if(result=="no"){
					   	     $("#lbl2").show();
	  						  btt=0;
	  					   }else{
	  					       document.getElementById("apForm").submit();
	  					   }
					   });
				}else{
				   btt=1;
				}
				if(btt==1){
					if($('#addOrupdCabs').html()=="增加机柜信息"){
					   document.getElementById("apForm").action="cms/show_createCabint.do";
					}
				    document.getElementById("apForm").submit();
				}

			}
			
			function fucsC(obj,num)
			{
				var temp = num;
				var a = obj.value;
				var str = "#lbl"+temp;
				if(a == "")
				{
					$(str).show();
					return false;
				}
				if(a != "")
				{
					$(str).hide();
				}
				
			}
<!--			function checkIsInteger(str) -->
<!--        	{ -->
<!--                //如果为空，则通过校验 -->
<!--                if(str == "") -->
<!--                return true; -->
<!--               if(/^(\-?)(\d+)$/.test(str)) -->
<!--               return true; -->
<!--             else -->
<!--               return false; -->
<!--         } -->
<!--         String.prototype.trim = function() -->
<!--        { -->
<!--                return this.replace(/(^[\s]*)|([\s]*$)/g, ""); -->
<!--        } -->
<!--        $("myButton").onclick=function(){ -->
<!--             -->
<!--            if(checkIsInteger($("myInput").value.trim())){ -->
<!--              //  alert("成功"); -->
<!--            }else{ -->
<!--                alert("只能是数字"); -->
<!--            } -->
<!--        } -->
<!--		}-->

//update      
	       function resetSelct(){
	             var se = document.getElementById("electIds").options;
	            // alert("e="+se.length+","+$('#selct').val());
	             for(var i=0;i<se.length;i++){
	                 if(se[i].value == $('#selct').val()){
	                     // document.getElementById("apForm").reset();
	                      se[i].selected=true;
	                 }
	             }
	           var cb =$('#cabsid').val();
	          $.getJSON('cms/show_updateCaUI.do',{upcabitid:cb},function callback(res){
				    // alert("res="+res.hid);
					 $('#caid').val(res.cid);
					 $('#eids').val(res.hid);
					 $('#caname').val(res.name);
					 $('#casz').val(res.size);
					 $('#pmax').val(res.max);
					 $('#bwmax').val(res.wmax);
	             });
	        }
	        
        function chang(obj){
            if(obj.id=="ip"){
	          $('#jfm').css("color","#499ceb");
	          $('#khm').css("color","#499ceb");
	          $('#dz').css("color","#499ceb");
	          $('#writeCont').html('&nbsp;&nbsp;&nbsp;<font size="3">IP:</font>');
              $('#choisesc').html('>&nbsp;IP');
		    }
		    if(obj.id=="jfm"){
		      $('#ip').css("color","#499ceb");
	          $('#khm').css("color","#499ceb");
	          $('#dz').css("color","#499ceb");
	          $('#writeCont').html('&nbsp;&nbsp;<font size="3">机房名:</font>');
	          $('#choisesc').html('>&nbsp;机房名');
		    }
		    if(obj.id=="khm"){
		      $('#jfm').css("color","#499ceb");
	          $('#ip').css("color","#499ceb");
	          $('#dz').css("color","#499ceb");
	          $('#writeCont').html('&nbsp;&nbsp;<font size="3">客户名:</font>');
	          $('#choisesc').html('>&nbsp;客户名');
		    }
		    if(obj.id=="dz"){
		      $('#jfm').css("color","#499ceb");
	          $('#khm').css("color","#499ceb");
	          $('#ip').css("color","#499ceb");
	          $('#writeCont').html('&nbsp;&nbsp;<font size="3">管理员:</font>');
	          $('#choisesc').html('>&nbsp;管理员');
	          
		    }
		    $('#showCounts').html('');
			$("#rightlist").html("");
	        $("#splt").html("");
		    $('#showFonts').hide();
		    $("#cont").val('');
		    $('#'+obj.id).css("color","green");    
		    $("#zdm").val(obj.id);
		    $("#cont").show();
		    $('#showSec').show();
		}
	function classSelt(){
	           $('#showFonts').hide();
		       $('#jfm').css("color","#499ceb");
	           $('#khm').css("color","#499ceb");
	           $('#dz').css("color","#499ceb");
	           $('#writeCont').html('&nbsp;&nbsp;&nbsp;<font size="3">IP:</font>');
	           //$('#choisesc').html('>&nbsp;IP');
		       $('#ip').css("color","green");    
		       $("#zdm").val("ip");
		       $("#cont").show();
		       $('#showSec').show();
	}
	function splitpag(pms,pages){
	   var strin="";
	   var zdm= $("#zdm").val();
	   var cont=$("#cont").val();// 要查找的内容
	   //$('#showCounts').html('');
	   //$('#showCounts1').html('');
	   //$("#splt").html('');
	  // $("#splt1").html('');
	   cont=encodeURI(cont,"utf-8");
	   if(pms>=3 && pms<=pages){
	         if(pms>(pages-2)&& pms<=pages){
	            if(pms==(pages-1)){
	                strin+='<div style="float:left;display: inline;">';
	                for(var m=pms-2;m<pms;m++){
	                 strin+='<a href="javascript:splitpag('+m+','+pages+');"  style="color:green;font-size:14px;"  id="pg'+m+'">['+m+']</a>&nbsp;&nbsp;'; 
	                }
				    strin+='<a href="javascript:splitpag('+pms+','+pages+');"  style="color:green;font-size:14px;"  id="pg'+pms+'">['+pms+']</a>&nbsp;&nbsp;'; 
	                strin+='<a href="javascript:splitpag('+(pms+1)+','+pages+');"  id="pg'+(pms+1)+'">['+(pms+1)+']</a>&nbsp;&nbsp;<div>';
	            }
	            if(pms == pages){
	                strin+='<div style="float:left;display: inline;">';
	               for(var m=pms-2;m<pms;m++){
	                 strin+='<a href="javascript:splitpag('+m+','+pages+');"  style="color:green;font-size:14px;"  id="pg'+m+'">['+m+']</a>&nbsp;&nbsp;'; 
	               }
	               strin+='<a href="javascript:splitpag('+m+','+pages+');"  style="color:green;font-size:14px;"  id="pg'+m+'">['+m+']</a>&nbsp;&nbsp;';
	               strin+='<div>';   
	            }
	            $("#splt").html(strin);
	            $("#splt1").html(strin);
	            
	         }else{ //4以上
	          strin+='<div style="float:left;display: inline;">';
		     for(var i=(pms-2);i<=(pms+2);i++){
		        if(i==pms){
				   strin+='<a href="javascript:splitpag('+i+','+pages+');"  style="color:green;font-size:14px;"  id="pg'+i+'">['+i+']</a>&nbsp;&nbsp;'; 
		         }else{
				  strin+='<a href="javascript:splitpag('+i+','+pages+');"  id="pg'+i+'">['+i+']</a>&nbsp;&nbsp;'; 
		        }
		        
		     }
		     strin+='<div>';
		     //alert("strin="+strin);
		     $("#splt").html(strin);
		      $("#splt1").html(strin);
	     }
	     for(var p=1;p<=pages;p++){
		     $('#pg'+p).css({color:"#499ceb",fontSize:"12px"});
	     }
	   }else{
	   if(pages<=5){
		for(var j=0;j<pages;j++){
			if(j==0){
				strin+="<div style='float:left;display: inline;'>";
				strin+="<a href='javascript:splitpag("+(j+1)+","+pages+");'  style='color:green;font-size:14px;' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
			}else{
				strin+="<a href='javascript:splitpag("+(j+1)+","+pages+");' id='pg"+(j+1)+"'>["+(j+1)+"]</a>&nbsp;&nbsp;"; 
			}
		}
		strin+="</div>";
		$("#splt").html(strin);
		$("#splt1").html(strin);
		}
	        for(var k=1;k<=pages;k++){
	           $('#pg'+k).css({color:"#499ceb",fontSize:"12px"});
	        }
	   }
	    $('#showCounts').html("&nbsp;当前页/总页数&nbsp;<font color='green'>"+pms+"/"+pages+"</font>页");
	     $('#showCounts1').html("&nbsp;当前页/总页数&nbsp;<font color='green'>"+pms+"/"+pages+"</font>页");
	    $('#pg'+pms).css("color","green");
	    $('#pg'+pms).css("fontSize","14");
	   if(zdm!=""){
		   $.ajax({
			  type: "post",
			  url: "cms/dealSplitPageServers.do",
			  data: {"pags":pms,"cotents":cont,"condits":zdm},
			  success: function(data){	
					  //alert(data);
					  $("#rightlist").html("");
					  $("#rightlist").html(data);
				 }
			 });
		}else{
		    $.ajax({
			  type: "post",
			  url: "cms/fuzzyByZdServers.do",
			  data: {"pags":pms},
			  success: function(datas){	
					  // alert("d2="+datas);
					  $("#rightlist1").html("");
					  $("#rightlist1").html(datas);
		          }
			 });
		}
	}
	function search(){
			$("#alldiv div").hide();
			$('#showCounts').html('');
			var zdm= $("#zdm").val();
			var cont=$("#cont").val();// 要查找的内容
			$("#rightCont").html(cont);
			cont=encodeURI(cont,"utf-8");
			$("#rightSear").show();
			 $.ajax({
				  type: "post",
				  url: "cms/searchByZdServers.do",
				  data: {
					  "content":cont,
					  "zdm":zdm
					  },
				  success: function(data){	
						  $("#rightlist").html("");
						  $("#splt").html("");
                          $('#showCounts').html("");
						  if(arrs='undefined' || arrs!=''){
						    var arrs = data.split("^");
						    $("#rightlist").html(arrs[0]);
						    $("#splt").html(arrs[1]);
						    $('#showCounts').html("&nbsp;当前页/总页数&nbsp;<font color='green'>"+1+"/"+arrs[2]+"</font>页");
						  }
						  $('#showFonts').show();
					 }
				 });
		}
        //function propertyID(ms){
         //alert(ms);
        // location.href="cms/showselctContentServers.do?eltID="+ms;
     //}
     function conditionOnclick(){
        $('#retAllsel').hide();
        $('#IsAllSel').show();
        show_menuB(81);
     }
     function fuzzySel(){
        $('#IsAllSel').hide();
        $('#retAllsel').show();
        var content=$('#fname').val();
        content=encodeURI(content,"utf-8");
        ///alert(content);
        $.ajax({
           type:'post',
           url:'cms/fuzzyAllConditionServers.do',
           data:{"contents":content},
           success:function(res){
              // alert("ressel="+res);
               $("#zdm").val("");
               $("#cont").val(content);
               jq('Bli081').style.display='block';
		       jq('Bf081').style.background='url(<%=basePath%>serm/img/bg01over.jpg)';
               $("#rightlist1").html("");
               $('#showCounts1').html("");
			   $("#splt1").html("");
			  if(res=='undefined' || res!=''){
			    var arrs = res.split("^");
			    $("#rightlist1").html(arrs[0]);
			    $("#splt1").html(arrs[1]);
			    $('#showCounts1').html("&nbsp;当前页/总页数&nbsp;<font color='green'>"+1+"/"+arrs[2]+"</font>页");
			  }
			  $('#showFonts1').show();
           }
        });
        }
    
	</script>
</head>

<body>
 <%
	String electid = request.getParameter("electid");
	request.setAttribute("temp",electid);
 %>
<input type="hidden" id="bathpath" value="<%=basePath%>"/>
<div class="topnav">
<div class="topnav_left">收藏本地址　 |　  用户名：<%=request.getSession().getAttribute("loginName") %>　  |　  退出  　|　  更多</div>
<div class="topnav_right">信息[15]　   |  　 内部系统   　|　   帮助 
<!--工弹信息弹窗
<div class="Gd_Pop">
	<div class="Gd_Title">信息[15]</div>
    <ul>
    	<li>1.<a href="#">您有新的工单</a></li>
        <li>2.<a href="#">您有新的工单</a></li>
        <li>3.<a href="#">您有新的工单</a></li>
        <li>4.<a href="#">您有新的工单</a></li>
    </ul>
</div>-->
<!--工弹信息弹窗-->
</div>

</div>
<div class="header">
<div class="logo"><img src="<%=basePath%>serm/img/logo.jpg" /></div>
<div class="search">
<!-- 混合查询 -->
<label style="float:left; "><input type="text" id="fname" style="background:url(<%=basePath%>serm/img/searchbar.jpg) no-repeat; height:36px; width:565px; line-height:36px; font-size:24px; color:#333;" onkeyup="if(event.keyCode==13){fuzzySel();}"/></label>
<label style="float:left; margin-left:15px;"><img src="<%=basePath%>serm/img/search.jpg" onclick="fuzzySel()"/></label>
</div>
</div>
<div class="clear"></div>
<div class="contant">

<div class="left" id="LeftBox">

<div class="left02">
	
<div class="left02down">
<div class="left02down01"><a  onclick="show_menuB(80)" href="<%=basePath %>serm/pager/loadHouses.jsp" target="loadhouses"><div id="Bf080" class="left02down01_img">地区  <span id="positions"></span></div></a></div>
<div class="left02down01_xia noneBox" id="Bli080">
 <% 
List citylist = (List)request.getSession().getAttribute("slist");
 %>
<input type="hidden" id="s" vlaue="<%=citylist.size()%>"/>
<ul style="width:300px; height:200px; margin-top:15px;">
<dl id="warpper">
 <%
List<Object[]> objlist = (List<Object[]>)request.getSession().getAttribute("city");
for(int i=0;i<citylist.size();i++){
  City city=(City)citylist.get(i);
   %>
    
  <dt onMouseOver="changeMenu(this,0);" id="<%=i %>">
    <input type="hidden" id="m<%=i%>" value="<%=city.getSuperid() %>"/>
    <input type="hidden" id="n<%=i%>" value="<%=city.getId()%>"/>
    <span><a onclick="getCitys(this,<%=city.getSuperid() %>)" target="loadhouses"><%=city.getName()%></a></span>
  </dt>
  
  <dd id="c<%=i %>" class="none">
   <ul id="allcity">       
 
   </ul>
  </dd>
  <%} %>
 </dl>
 <!-- 结束 -->
 <div class="clear"></div>
</ul>
</div>
<div class="left02down01"><a onClick="conditionOnclick()" href="javascript:void(0);"><div id="Bf081" class="left02down01_img">分类搜索  <span id="choisesc">&nbsp;>&nbsp;IP</span></div></a></div>
<div class="left02down01_xia1 noneBox" id="Bli081" >
<div id="IsAllSel">
<ul>
<p style="text-align:center;"><a href="javascript:void();" onclick="chang(this)"  name="bip" id="ip">IP</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="jfm" name="bjfm" onclick="chang(this)"  href="javascript:void();">机房名</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a  href="javascript:void();" onclick="chang(this);" name="bkhm" id="khm">客户名</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a  href="javascript:void();" onclick="chang(this);" name="bdz" id="dz">管理员</a> </p>
<input type="hidden" value="ip" id="zdm"/>

<div style="float:left"><span id="writeCont"></span><input type="text"  id="cont" onkeyup="if(event.keyCode=='13'){search()}" name="cont" style="height:25px; width:170px; line-height:25px; font-size:14px; color:#333;display: none; border:1px solid #000000; "/></div>

<label id="showSec" style="float:left; margin-left:15px;display: none;"><a href="javascript:search();"><img src="<%=basePath%>serm/img/search2.jpg" /></a></label>

<p style="height:50px;" >&nbsp;</p>
<div id="show" style="height:0px; overflow:hidden"></div>
<p id="showFonts" style="border-top: dashed 1px #9ac5ee; width:378px; padding-top:30px; padding-left:20px;display: none;"><b>你所查的内容是：<span id="rightCont"></span></p>
<p> 

<!--第一条-->
<div id="rightlist" style="margin-top:12px;margin-left:30px;" >
</div>
<div id="splt" style="margin-left:30px;display: inline;float:left;">
</div>
<div style="float:left;display: inline;" id="showCounts"></div>
</ul>
</div>
<!-- 显示全查非条件 -->
<div id="retAllsel">
<div id="rightlist1" style="margin-top:12px;margin-left:30px;" >
</div>
<div id="splt1" style="margin-left:30px;display: inline;float:left;">
</div>
<div style="float:left;display: inline;" id="showCounts1"></div>
</div>
</div>        
</div>
</div>  
<div style=" border-top:dashed 1px #9ac5ee; height:61px; line-height:28px; padding-top:15px" >
 <p style="text-align:center; color:#666; font-size:14px; line-height:28px;">Fuao 机房管理 - <a href="#">帮助</a></p>         <p style="text-align:center; color:#666; font-size:14px;line-height:28px;">Fuao - @2012 Fuao - <a href="#">使用条款</a> - <a href="#">隐私权政策</a></p></div>
</div>
<!-- 机柜 增加修改-->
<input type="hidden" id="eletid"/>
<input type="hidden" id="cabsid"/>
<div id="showDivs">
<div id="formwrapper">
<img src="<%=basePath%>serm/img/deletes.png" title="关闭" onclick="remDiv()" style="position:absolute;left:480px;z-index: 20000;top:5px;"/>
<h3 style="font-weight:normal"><span id="addOrupdCabs"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（带*号的必填）</h3>
<form  method="post" name="apForm" id="apForm">
 <input type="hidden" id="caid" name="cabinet.caid"/>
 <input type="hidden" id="selct"/>
 <input type="hidden" id="eids"/>
<fieldset>
<div>
<div>
<label for="01" class="lamb">房间名：</label>
<select style="width:130px;margin-left:-25px;#margin-left:4px;_margin-left:4px" name="electHouse.electId" id="electIds" ></select>
<span>*</span><span id="rom1" style="font-size: 12px;color: red;margin-left:15px;"></span>
</div>
<div>
<label for="02" class="lamb">机柜名称：</label><input name="cabinet.caname" onblur="fucsC(this,1);" type="text" id="caname"  size="20" maxlength="30" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">*</font>
<label id="lbl1" style="font-size: 12px;color: red;display: none;">机柜名不能为空</label>
</div>
<div>
<label for="04" class="lamb">机柜大小：</label><input name="cabinet.casz" type="text" id="casz" onblur="fucsC(this,2);" size="20" maxlength="150" /><font color="#FFFFFF">(U)</font>
<span>*</span><label id="lbl2" style="font-size: 12px;color: red;display: none;">机柜大小需写数字或数字太小</label>
</div>
<div>
<label for="04" class="lamb">最大功率：</label><input name="cabinet.pmax" type="text" id="pmax" onblur="fucsC(this,3);" size="20" maxlength="150" /><font color="#FFFFFF">(W)</font>
<span>*</span>
<label id="lbl3" style="font-size: 12px;color: red;display: none;">机柜功率需写数字</label>
</div>
<div>
<label for="04" class="lamb">最大宽带：</label>
<input name="cabinet.bwmax" type="text" id="bwmax" onblur="fucsC(this,4);" size="20" maxlength="150" /><font color="#FFFFFF">(M)</font>
<span>*</span>
<label id="lbl4" style="font-size: 12px;color: red;display: none;">机柜带宽需写数字</label>
</div>
</div>
<div class="enter">
<a href="javascript:onClickCabinet();"><img  name="submitLogin" id="submitLogin"/></a>
<a href="javascript:resetSelct();"><img  src="<%=basePath%>serm/img/reset.jpg"></a>
</div>
</fieldset>
</form>
</div>
</div>
<div id="right">
<!-- 
<img src="<%=basePath%>serm/img/map1.jpg" />
 -->
<!-- 结束 -->
 <input type="hidden" id="cityid" />
<div style="background:#fff;background-repeat:no-repeat; height:583px; border-left:solid 1px #999;border-bottom:dashed 1px #9AC5EE; padding-bottom:5px; width:993px; float: left; ">
<div style="background:#f2f7f9;background-repeat:no-repeat;height:583px; width:993px; border-left:solid 1px #999;border-bottom:dashed 1px #9AC5EE; padding:10px; ">
<!--增加机房按钮-->
<a href="javascript:void(0);" class="AD_room"><img src="<%=basePath%>serm/img/AD_Room.gif" id="getAreas"></a>
<iframe scrolling="auto"  width="100%" height="100%" name="loadhouses" frameborder="0">

</iframe>
</div>
</div>
</div>
<!-- 增加修改机房页面 -->
<div id="addshowDiv">
<div class="formwrapper_Bg">
<div id="wrapperforms">
<img src="<%=basePath%>serm/img/deletes.png" title="关闭" onclick="remDiv()" style="position:absolute;left:580px;z-index: 20000;top:5px;"/>
<h3 style="font-weight:normal;"><span id="houtitles"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（带*号的必填）</h3>
<form action="cms/show_addEle.do" method="post" id="casubmit">
<input type="hidden" name="electHouse.superid" id="superid" value="0"/>
 <input type="hidden" name="ctid" id="ctid" />
 <input type="hidden" name="updEleID" id="elecId" />
<fieldset>
<div>
<div>
<label for="01" class="labn"><span id="houname">机房名称：</span></label>
<input type="text" name="electHouse.electName" onblur="onblurInfoCa()"
		id="electname" size="18" maxlength="20" /><span style="color: red;">*</span>
		<span id="aaaa" style="font-size: 12px; color: red;margin-left:5px;"></span>
</div>
<div>
<label for="02" class="labn"><span id="houposition">机房位置：</span></label>
<input name="electHouse.electPosition" type="text" 
      onblur="fousInf(this.value,2)" id="electPosition" size="18" maxlength="150" /><span style="color: red;">*</span>
<label id="hous2" style="font-size: 12px; color: red; display: none;">
机房位置输入有误
</label>
</div>
<div>
<label for="03" class="labn"><span id="houphones">机房座机：</span></label>
<input name="electHouse.electTel" type="text"
	onblur="fousInf(this.value,3)" id="electTel" size="18" maxlength="150" /><span style="color: red;">*</span>
<label id="hous3" style="font-size: 12px; color: red; display: none;">
机房座机输入有误
</label>
</div>
<div>
<label for="04" class="labn"><span id="houmanages">机房管理员：</span></label>
<input name="electHouse.electAdmin" type="text"
	onblur="fousInf(this.value,4)" id="electAdmin" size="18" maxlength="150" /><span style="color: red;">*</span>
<label id="hous4"
style="font-size: 12px; color: red; display: none;">
管理员输入有误
</label>
</div>
<div>
<label for="04" class="labn">管理员手机：</label>
<input name="electHouse.electAdmPhone" type="text"
onblur="fousInf(this.value,5)" id="electPhone" size="18" maxlength="150" /><span style="color: red;">*</span>
<label id="hous5" style="font-size: 12px; color: red; display: none;">
电话输入有误
</label>
</div>
<div>
<label for="05" class="labn"><span id="houmobiles">机房编码：</span></label>
<input type="text"  border="0" id="electCode" name="electHouse.electCode" readonly size="29" maxlength="150" />
<br/>
</div>
</div>
<div style="float:right;width:150px;" >
<div style="width:160px; color:#F00; font-weight:bold; font-size:14px;" id="houseSels">
选择已使用机房：<br />
<select id="selectEle" style="width:100px;" onclick="getHousename()" onchange="getvalues(this.value)"><option value="0">请选择</option></select>
</div>
</div>
<div class="houenter">
<a href="javascript:onclickAjax();"><img src="<%=basePath%>serm/img/enter.jpg"  style="margin-left:100px" /></a>
<a href="javascript:resetContent();"><img src="<%=basePath%>serm/img/reset.jpg"  style="margin-left:0px" /></a>
</div>
</fieldset>
</form>
</div>
</div>
</div>
<!-- 机房信息 -->


</body>
</html>
