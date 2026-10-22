/**
 * @function :  lhgdialog 公共JS
 * @name :  Niedongbo
 * @type : javaScript
 * @time : 2011 - 2 - 22
 */

/**
 * 公共弹出框JS
 * @param {} id  自定义对话框ID属性，要保证在页面中是唯一的，不能和页面中任何元素的id相同
 * @param {} title 标题内容 默认值 ：'lhgdialog弹出窗口'
 * @param {} width 设置内窗口的宽度 默认值 ：400 
 * @param {} height  设置窗口的高度  默认值 ：300
 * @param {} PageHref URL连接地址 路径是内容页面文件相对于调用窗口插件的路径或也可使用绝对路径
 * @param {} page 指定窗口弹出时的页面的window对象，如果是在框架中，你可以指定框架中的任意页面，如不指定则在框架的最顶层页面弹出
 */  

 /**
 * 关闭当前打开的窗口
 */
function closeWindeows(bool){ 
	//alert(parent.document.body.innerHTML);
	if(bool){parent.document.frames['frmright'].showPage(1);} //frmright
	var dlg = frameElement.lhgDG;	
	dlg.cancel(0);	 
}

/*
function showWindows(id,title,width,height,PageHref)
{
	idid="d"+idid+1;
	var dlgone = frameElement.lhgDG;
	//如果宽度 OR 高度 为空
	var _Width = width == '' || width == null ? '400' : width; 
	var _Height = height == '' || height == null ? '300' : height; 
	var dlg = new J('#youshuju').dialog({  //J('#btn1').dialog({
        id: idid, 
        title: title,
        width : _Width,
        height : _Height,
        page: PageHref,
        parent:dlgone,
        rang: true,//是否限制挪动与定位范围
        cover:true,//开启锁屏。中断用户对话框之外的交互，用于显示非常重要的操作/消息
        resize : false//是否允许拖动改变窗口大小
	});
	dlg.ShowDialog();
} */

/**
 * 带返回按钮的窗体
 * @param {} id
 * @param {} title
 * @param {} width
 * @param {} height
 * @param {} PageHref
 */
var openwidth=window.screen.width;
var openheight=window.screen.height*0.7;
var idid=2;
var openjsp=true;
function showWindwoButton(id,title,width,height,PageHref,url){
	var openjsp=false;
	idid="d"+idid+1;
	//如果宽度 OR 高度 为空
	var leftpx=width<openwidth?((openwidth-width)/2):(3);
	var _Width =width<openwidth?width:openwidth-0; 
	var _Height =height<400?400:height;
	var dg = null;
	if(dg==null){ 
		var dlg_L = new J.dialog({ //dg.curWin.J('#btn1',document).      J('#youshuju')
	        id: idid, 
	        left:leftpx,
	        title: title,
	        width : _Width,
	        height : _Height,
	        page: PageHref,
	        rang: true,//是否限制挪动与定位范围
	        cover:true//开启锁屏。中断用户对话框之外的交互，用于显示非常重要的操作/消息
		});  
		dlg_L.ShowDialog(url,width,height);		openjsp=true;
	}else{ 
		/*var dlg_L = new dg.curWin.J.dialog({//dg.curWin.J('#btn1',document).      J('#youshuju')
	        id: idid, 
	        title: title,
	        width : _Width,
	        height : _Height,
	        page: PageHref,
	        rang: true,//是否限制挪动与定位范围
	        cover:true//开启锁屏。中断用户对话框之外的交互，用于显示非常重要的操作/消息	       
		}  );  */
		dlg_L.ShowDialog(dlg_L,url,width,height);openjsp=true; 
	}	
}

