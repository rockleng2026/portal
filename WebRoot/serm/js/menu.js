$(document).ready(function(){
	 $('#addcup').window({
		   closed: true 
	 });
	document.oncontextmenu = function () { return false; }
	//显示弹出机柜
	for(var m=0;m<100;m++){
	$('#m'+m).contextMenu('p'+m, {
	      onContextMenu: function(e) {
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

	//机柜
	$('#x'+m).contextMenu('co'+m, {
	      onContextMenu: function(e) {
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
	//显示弹出机房
	$('#bigDiv').contextMenu('houses', {
	      onContextMenu: function(e) {
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
$(document).ready(function(){
	 $('#addaa').window({
		   closed: true 
	 });
	document.oncontextmenu = function () { return false; }
	//显示弹出机柜
	for(var m=0;m<100;m++){
	$('#m'+m).contextMenu('p'+m, {
	      onContextMenu: function(e) {
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

	//机柜
	$('#x'+m).contextMenu('co'+m, {
	      onContextMenu: function(e) {
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
	//显示弹出机房
	$('#bigDiv').contextMenu('houses', {
	      onContextMenu: function(e) {
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


//增加机柜
function dealID(ps){
   $("#addcup").window({
			title: '机柜信息界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			inline:true,
			zIndex:10000,
			minimizable:false,
			maximizable:false
		});
	 $('#zjjigui-but').click(function(){
		 var caname = $('#caname').val();
		 var casz = $('#casz').val();
		 var pmax = $('#pmax').val();
		 var bwmax = $('#bwmax').val();
		 window.location.href ="cms/show_createCabint.do?caname="+caname+"&&casz="+casz+"&&pmax="+pmax+"&&bwmax="+bwmax+"&&ps="+ps;
	 });
}
//增加机房
function addhouses(){
	//alert("addh");
	$('#addaa').window({
		title: '机房信息界面',
		width: 500,
		modal: true,
		shadow: false,
		closed: false,
		height: 340,
		inline:true,
		zIndex:10000,
		minimizable:false,
		maximizable:false
	});
	$('#sumbitForm').click(function(){
		///alert("aa");
		var electname = $('#electname').val();
		var electPosition = $('#electPosition').val();
		var electTel = $('#electTel').val();
		var electAdmin = $('#electAdmin').val();
		var electPhone = $('#electPhone').val();
//		window.location.href = "cms/show_addEle.do?electname="+electname+"&&electPosition="+electPosition+"&&electTel="+electTel+"&&electAdmin="+electAdmin+"&&electPhone="+electPhone;
		
		$.ajax({
			  type: "POST",
			  url:"cms/show_addEle.do?electname="+electname+"&electPosition="+electPosition+"&electTel="+electTel+"&electAdmin="+electAdmin+"&electPhone="+electPhone,
			  success: function(data){
				$('#bbbb').html(data);
			  }
			 });
	});
}
//删除机房
function delhouseID(hid){
	var bool = window.confirm("你确定要删除吗？");
	if(bool)
	{
		window.location.href ="cms/show_delCabint.do?electid="+hid;	
	}
}
//修改机柜
function addcabinetID(cid){
	//alert("cid="+cid)
}
//删除机柜
function delcabinetID(cid){
	//alert("did="+cid);
	
}
