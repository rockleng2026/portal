var ck=0;
$(document).ready(function(){
	//document.oncontextmenu=function(){return false;}
	for(var m=0;m<100;m++){
	$('#psat'+m).contextMenu('past'+m, {
	      onContextMenu: function(e) {
		    $('#yesornoshow').hide();
	        if ($(e.target).attr('id') == 'dontShow') return false;
	        else return true;
	      },

	      onShowMenu: function(e, menu) {
	        if ($(e.target).attr('id') == 'showOne') {
	          $('#item_2, #item_3', menu).remove();
	        }
	        return menu;
	      }

	    });
	
	$('#waitin'+m).contextMenu('watn'+m, {
	      onContextMenu: function(e) {
		$('#yesornoshow').hide();
	        if ($(e.target).attr('id') == 'dontShow') return false;
	        else return true;
	      },
	      onShowMenu: function(e, menu) {
	        if ($(e.target).attr('id') == 'showOne') {
	          $('#item_2, #item_3', menu).remove();
	        }
	        return menu;
	      }

	    });
	}
	$('#jiguimid').contextMenu('writerInFo',{
	     onContextMenu: function(e) {
		$('#yesornoshow').hide();
        if ($(e.target).attr('id') == 'dontShow') return false;
        else return true;
      },
      onShowMenu: function(e, menu) {
        if ($(e.target).attr('id') == 'showOne') {
          $('#item_2, #item_3', menu).remove();
        }
        return menu;
      }
	});
});

//查询信息
function showserverInfo(pms){
	//alert(pms);
var fg="ser";
var path=$('#hidPath').val();
$.ajax({
   type:"post",
   url:"cms/show_showallServer.do",
   data:{strinID : pms,strinFlag : fg},
   success:function(result){
   		$('#yesornoshow').show(100);
   		document.getElementById("iframForms").submit();
	   },
	error:function(){
		   $('#yesornoshow').show(100);
		   //$('#yesornoshow').load(path+"serm/pager/selserverInfomation.jsp");
    }
});

}
//填写上架单
function writeUpserver(cmp){
	//alert("cmp="+cmp);
	 $('#yesornoshow').hide();
     var path=$('#hidPath').val();
     ck++;
	 if(ck%2!=0){
		 $('#upserverList').show(100);
		 $('#cassids').val(cmp);
		 $('#ifrForm2').attr("action",path+"cms/show_putCabitId.do");
		 document.getElementById("ifrForm2").submit();
	 }else{
		 $('#upserverList').hide(50);
	 }
	// $('#iframUpServerList').attr("src","./serm/pager/upservers.jsp?cabid="+cmp);
}
//转移服务
function moveSer(){
	
}
//下架
function lowerDown(ms){
	//alert(ms);
	var path=$('#hidPath').val();
	location.href=path+"cms/show_downListservs.do?upss="+ms;
}
//上架
function upserv(ms,ps){
var m=0;
if(ps==2){
  $.messager.confirm('提示','你确定要上架吗 ？',function(p){
	  if(p){
		  $.ajax({
			   type:"post",
			   url:"cms/frontupServerStat.do",
			   data:{strinID : ms},
			   success:function(result){
				 $.messager.alert('提示',result.arrMessager,'info',function(){
					top.location.reload();
				 });
			   }
			});
		
	  }
  });
}else{
	$.messager.alert('提示','此服务器已上架，不能重复上架','info');
}
}

function operSers(me,pm){
	if(me==1){
		$('#isShowOrHide'+pm).show();
	}else{
		$('#isorups'+pm).show();
	}
}
function outOperser(ms,pm){
	if(ms==1){
		$('#isShowOrHide'+pm).hide();
	}else{
		$('#isorups'+pm).hide();
	}
}