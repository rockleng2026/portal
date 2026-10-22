function showInfo2(id)
{
	var url = "goSeeReply2WorkLogNewportal.do?id="+id;
	window.location.href=url+"&tt="+(new Date()).getTime();
}
function showInfo(id)
{
		
 	   $("#workId").val(id);
 	   $("#workId1").val(id);
		var url = "goDealWorkLogNewportal.do";
		 $("#pageid").css("display","");
		$.post(url,{id:id},function (data){
		
		$("#contentF"+id+"").html(data);	
		$("#button"+id+"").remove(); 	
		$("#td"+id+"").append("<input type='button' id='bt"+id+"' onClick='closeaa("+id+")' value='关闭'>");
		});
	}
	function cleanC(){
	$("#contentF").html("<br/>");
}
	
	
function closeaa(id)
{	 $("#pageid").css("display","none");
	$("#contentF"+id+"").html("");
	$("#bt"+id+"").remove();
	$("#td"+id+"").append("<input style='margin-left: 25px;' name='button' id='button"+id+"' type='button' class='PopupButton2' onClick='showInfo("+id+")' value='详情查看'>");

}
function chselect()
{
 var vals = $("#selecttage").val();
 //var vals1 = $("#selecttage1").val();
 if(vals=='1' ){
  $("#selecttage").attr("value","0");
 }else{
     $("#selecttage").attr("value","1");
     }
}
function showInput(obj){
  var v = $("#"+obj.id).find("input,select").get(0); 
    var inputid = v.id;
    $("#"+inputid).css("display","");
}
function displayIput(obj){
  var v = $("#"+obj.id).find("input,select").get(0); 
    var inputid = v.id;
    var vals = $("#selecttage").val();
    //alert(vals);
    if(vals != '1'){
    $("#"+inputid).css("display","none");
    }
}

function selectemp(pageNo){

$("#form1 select").css("display","none");
   
var formdata = $("#form1").serialize();

formdata = encodeURI(formdata);
 $.ajax({
	  type: "POST",
	  url: "obscureselectWorkLogNewportal.do",
	  data:formdata,
	  success: function(data){
	  var data1 = new Array();
	  data1 = data.split("#");
		$("#infotable").html(data1[0]);
		$("#page").html(data1[1]);
	  }
	 });
	 //$("#selecttage1").attr("value","0");
}





var W = screen.width;//取得屏幕分辨率宽度
var H = screen.height;//取得屏幕分辨率高度

function M(id){
    return document.getElementById(id);//用M()方法代替document.getElementById(id)
}
function MC(t){
   return document.createElement(t);//用MC()方法代替document.createElement(t)
};
//判断浏览器是否为IE
function isIE(){
      return (document.all && window.ActiveXObject && !window.opera) ? true : false;
} 
//取得页面的高宽
function getBodySize(){
   var bodySize = [];
   with(document.documentElement) {
    bodySize[0] = (scrollWidth>clientWidth)?scrollWidth:clientWidth;//如果滚动条的宽度大于页面的宽度，

//取得滚动条的宽度，否则取页面宽度
    bodySize[1] = (scrollHeight>clientHeight)?scrollHeight:clientHeight;//如果滚动条的高度大于页面的高

//度，取得滚动条的高度，否则取高度
   }
   return bodySize;
}
//创建遮盖层
function popCoverDiv(){
	//alert(1);
   if (M("cover_div")) {
   //如果存在遮盖层，则让其显示 
    M("cover_div").style.display = 'block';
   } else {
   //否则创建遮盖层
    var coverDiv = MC('div');
    document.body.appendChild(coverDiv);
    coverDiv.id = 'cover_div';
    with(coverDiv.style) {
     position = 'absolute';
     background = '#CCCCCC';
     left = '0px';
     top = '0px';
     var bodySize = getBodySize();
     width = bodySize[0] + 'px'
     height = bodySize[1] + 'px';
     zIndex = 0;
     if (isIE()) {
      filter = "Alpha(Opacity=60)";//IE逆境
     } else {
      opacity = 0.6;
     }
    }
   }
   
}

 

//让登陆层显示为块 
    function showLogin()
    {
                var login=M("login");
            login.style.display = "block";
    }

//设置DIV层的样式
function change(){
          var login = M("login");
      login.style.position = "absolute";
      login.style.border = "1px solid #CCCCCC";
      login.style.background ="#F6F6F6";
      var i=0;
          var bodySize = getBodySize();
      //login.style.left = (bodySize[0]-i*i*4)/2+"px";
     // login.style.top = (bodySize[1]/2-100-i*i)+"px";
      login.style.width =  i*i*4 + "px";
      login.style.height = i*i*1.5 + "px";
     
      popChange(i);
}


//让DIV层大小循环增大
function popChange(i){
      var login = M("login");
          var bodySize = getBodySize();
      //login.style.left = (bodySize[0]-i*i*4)/2+"px";
      //login.style.top = (bodySize[1]/2-100-i*i)+"px";
      login.style.width = i*i*2.0 + "px";
      login.style.height = i*i*1.8+ "px";
      if(i<=10){
           i++;
           setTimeout("popChange("+i+")",10);//设置超时10毫秒
      }
     
}



function getScrollTop()
{
    var scrollTop=0;
    if(document.documentElement&&document.documentElement.scrollTop)
    {
        scrollTop=document.documentElement.scrollTop;
    }
    else if(document.body)
    {
        scrollTop=document.body.scrollTop;
    }
    return scrollTop;
}



function mout()
{
	var workLog = M("workLog");
	workLog.style.display ="none";
}



function t(p)
{
	var id = $(p).val();	
	$.ajax({         
		 type:"post", 
		 async:true,
		 data:{departmentID:id},          
		 url:"getEmployeeByDepartmentIDWorkLogNewportal.do",         
		 dataType: "html",         
		 success: function(data)        
		 {               
			$("#employeeID").html(data);
		 }  
		});
}
function ttt(p)
{
	var id = $(p).val();	
	alert(10);
	$.ajax({         
		 type:"post", 
		 async:true,
		 data:{departmentID:id},          
		 url:"getEmployeeByDepartmentID1WorkLogNewportal.do",         
		 dataType: "html",         
		 success: function(data)        
		 {               
			$("#employeeID").html(data);
		 }  
		});
}


function movetop(id)
 {
 	   $("#"+id).css("display","");
 }
 function movedown(id)
 {
 	 $("#"+id).css("display","none");
 }
 function topWork()
 {
 	
 	var workId=document.getElementById("workId").value;
 	var workId1=document.getElementById("workId1").value;
 	var url="selectTopWorkWorkLog.do";
 	$.post(url,{workId:workId},function (data){
 	if(data==0)
 	{
 		alert("已经是第一条了！！");
 	}
 	else
 	{
 		 data1 = data.split("@");
 		  $("#workId").val(data1[0]);
		$("#contentF"+workId1+"").html(data1[1]);
		
 	}
 	});
 }
  function downWork()
 {
 	var workId=document.getElementById("workId").value;
 	var workId1=document.getElementById("workId1").value;
 	var url="selectDownWorkWorkLogNewportal.do";
 	$.post(url,{workId:workId},function (data){
 	if(data==1)
 	{
 		alert("已经是最后一条了！！");
 	}
 	else
 	{
 		 data1 = data.split("@");
 		  $("#workId").val(data1[0]);
		$("#contentF"+workId1+"").html(data1[1]);
		
 	}
 	});
 }

 function startMove(o,e){
	
  var wb;
  if(document.all && e.button==1) wb=true;
  else if(e.button==0) wb=true;
  if(wb)
  {
    var x_pos=parseInt(e.clientX-o.parentNode.offsetLeft);
    var y_pos=parseInt(e.clientY-o.parentNode.offsetTop);
    if(y_pos<=o.offsetHeight)
    {
      document.documentElement.onmousemove=function(mEvent)
      {
        var eEvent=(document.all)?event:mEvent;
        o.parentNode.style.left=eEvent.clientX-x_pos+"px";
        o.parentNode.style.top=eEvent.clientY-y_pos+"px";
      }
    }
  }
}

function stopMove(o,e)
{
  document.documentElement.onmousemove=null;
}

/* 进行对比所用到的js */


function q()
{
	if(judge())
	{
		f();
		
		if(result)
		{	
			if(info.indexOf("是")=='-1')
			{
				alert(info);
			}
			else
			{
				if(confirm(info))
				{
					contrast();
				}
			}
		}
		else
		{
			contrast();
		}
	}
}


function judge()
{
	var j = 0;
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			j++;
		}
	}
	
	if(j>0 ){
		return true;
	}else{
		alert("请您先选择要对比的日志!");
		return false;
	}
}

function  f()
{
	
	var s = "";
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	
		 $.ajax({         
		 type:"post", 
		 async:false,
		 data:{ids:s},          
		 url:"judgeWorkLogNewportal.do",         
		 dataType: "html",         
		 success: function(data)        
		 {             
			 info = data;
			 //result = ('1'== data)?false:true;
			 
			 if(data=='1')
			{
				 result = false;
			}
			 else
			{
				result = true;
			}
		 }  
		});
}

function contrast()
{
	
	var s = "";
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	
		window.location.href="getWorkInfoWorkLogNewportal.do?ids="+s;
}
/**
*	下面由lzy页面整理而来2013-1-28
*/
//表格里面颜色变化
$(function(){
	$("[type=checkbox]").css("border","0");
	$("[name=view]").mouseover(function(){
		$(this).css("color","red");
	});
	$("[name=view]").mouseout(function(){
		$(this).css("color","#4FA805");
	});
});
function sendPageCount(selectNode)
{
	var pageCount = $(selectNode).val();
	window.location.href = "selectOtherWorkLog.do?pageCount="+pageCount;
	$(selectNode).attr("selected","selected");
}

function mov(url,id)
{	
	var Form1 = M("Form1");
	var workLog = M("workLog");
	workLog.style.top = Form1.offsetTop+getScrollTop()+ 37+"px";
	workLog.style.right = 189+"px";
	$.ajax({         
		 type:"post", 
		 async:false,
		 data:{workID:id},          
		 url:"getTitle1WorkLog.do",         
		 dataType: "html",         
		 success: function(data)        
		 {             
			 $("#title_left").html(data);
		 }  
		});
	 $.ajax({         
		 type:"post", 
		 async:false,
		 data:{workID:id},          
		 url:"getTitleWorkLog.do",         
		 dataType:"html",         
		 success: function(data)        
		 {             
			 $("#title").html(data);
		 }  
		});
	$.post(url,{workID:id},
	function (data)
	{
		//alert(data);
		$("#workLogContent").html(data);
		workLog.style.display = "block";
	});
}
function showInfo3(id)
{
	var url = "goAddNewReplyWorkLogNewportal.do?id="+id;
	window.location.href=url+"&tt="+(new Date()).getTime();
}
var info = "";
var result;
//打开DIV层
function p()
{
	if(count())
	{
		y();
		
		if(result)
		{
			if(info.indexOf("是")=='-1')
			{
				alert(info);
			}
			else
			{
				if(confirm(info))
				{
					change();
			        showLogin();
			        popCoverDiv();
			        void(0);//不进行任何操作,如：<a href="#">aaa</a>
				}
			}
		}
		else
		{
			change();
	        showLogin();
	       	popCoverDiv();
	        void(0);//不进行任何操作,如：<a href="#">aaa</a>
		}   
	}
}
function pi()
{
	change();
    showLogin();
    popCoverDiv();
    void(0);
}
function y()
{
	var s = "";
	var all2 = $("[id=ids]");
	for(var i = 0; i < all2.length;i++)
	{ 
		var v = $(all2[i]).attr("checked");
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	if(s.length<=0){
		alert("请选择日志！");
	}
	else{
		 $.ajax({         
			 type:"post", 
			 async:false,
			 data:{ids:s},          
			 url:"checkWorkLogNewportal.do",         
			 dataType: "html",         
			 success: function(data)        
			 {               
				 info = data;
				if(data=='1')
				{
					 window.location.href="batchreplyWorkLogNewportal.do?ids="+s;
				}
				else
				{
					if(confirm(data)){
					    window.location.href="batchreplyWorkLogNewportal.do?ids="+s;
					}
				}
			 }  
			});
	 }
}
function back()
{
	document.getElementById("login").style.display = 'none';
	document.getElementById("cover_div").style.display = 'none';
}
function commit(url)
{
	//alert(1);
	var s = "";
	var all2 = $("[id=ids]");
	for(var i = 0; i < all2.length;i++)
	{ 
		var v = $(all2[i]).attr("checked");
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	var content = $("#content").val();
	content = encodeURI(encodeURI(content));
	if(content=="%2520")
	{
		alert("不能为空!");
		return;
	}
	$.post(url,{ids:s,replycontent:content},
	function (data)
	{
		 window.location.href="selectOtherWorkLogNewportal.do";
	});
}
function count()
{
	//var all=document.getElementsByName('ids');
	var j = 0;
	var all2 = $("[id=ids]");
	for(var i = 0; i < all2.length;i++)
	{ 
		var v = $(all2[i]).attr("checked");
		if(v=='checked')
		{
			j++;
		}
	}
	if(j>0){
		return true;
	}else{
		alert("请您先选择要批阅的日志");
		return false;
	}
}
//勾选所有要删除项
function CheckA(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall')
	    	e.checked = form.chkall.checked; 
	  }
}
// 删除日志
function delWorkLog(){
	// 获取选中的任务
	var logcheck=document.getElementsByName("ids");
	var logstr="";
	for(var i=0;i<logcheck.length;i++){
		if(logcheck[i].checked==true){
			logstr+=logcheck[i].value+",";
		}
	}
	if(window.confirm("您确定要删除吗？")){
		$.ajax({
			  type: "post",
			  url: "delTaskProject.do",
			  data: {
				  "taskstr":taskstr
				  },
			  success: function(data){						  
			    	alert(data);
			    	window.location.href="<%=path%>/publishtaskTaskProject.do";
			  }
	   });
	}
}
//切换样式
function changestyle(obj){
	 $("#cxrz").removeClass("active");
	 $("#cxzz").removeClass("active");
	 $("#cxyz").removeClass("active");
	 $("#"+obj.id).addClass("active");
}
//切换a标签的样式
function changeOutStyle(obj){
	$("#td"+obj.id).children("a").css("color","red");;
}
function changeMoveStyle(obj){
	$("#td"+obj.id).children("a").css("color","#4FA805");;
}
function topquery(){
	$("#Form1").submit();
}