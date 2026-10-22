/*上传文件后缀名检测*/
function JerqueFileFix(filefix,fixrule)
{   
    for(var i=0,k=filefix.length;i<fixrule.length-k;i++)
    {        
        if(fixrule.substring(i,i+k) == filefix)
        {
            return true;
        }
    }    
    return false;
}

/*获取文件后缀名*/
function GetFilePostfix(filename)
{
    return filename.substring(filename.lastIndexOf("."));
}

/*
将Json或一个数组绑定到select的子项
id　Select的id如"#City"
o　要绑定的Json或数组对象如[{Text:"北京",Value:"010"},...]
t	Select在o中对应的文本域，默认为Text
v　Select在o中对应的值域，默认为Value
*/
var BindSelect=function(id,o,t,v){
	var options;
	if(!t) t="Text";
	if(!v) v="Value";
	var s=$(id).get(0);
	s.options.length=0;
	if(o==null)return;
	for (var i = 0; i < o.length; ++ i) {
		s.options.add(new Option(o[i][t],o[i][v]));
	}
};
/*JQuery扩展

*/
$.postJSON = function(url, data, callback) {
	$.post(url, data, callback, "json");
};

//验证email
function checkemail(email)
{
    var rec = /\b(^(\S+@).+((\.com)|(\.net)|(\.org)|(\.info)|(\.edu)|(\.mil)|(\.gov)|(\.biz)|(\.ws)|(\.us)|(\.tv)|(\.cc)|(\..{2,2}))$)\b/;
    return rec.test(email);
}

//显示并居中加雾
function show_center(el,height,width)
{
    if( height == undefined)
    {
        height =0 ;
    }
    if(width == undefined)
    {
        width = 0 ;
    }
    if($("#dd_light").length==0)
    {
        var html='<div id=dd_light style="display:none;z-index: 9998;filter: alpha(opacity=70);left: 0px;position: absolute;top: 0px;background-color: #ccc;moz-opacity: 0.8;opacity: .80;"></div>';
        $(document.body).append(html);
        $('#dd_light').css('width',window.screen.availWidth-30);
        $('#dd_light').css('height',20000); 
    }
    $('#dd_light').show();//创建并显示雾
    $('#'+el).show();
    $('#'+el).css('left',(window.screen.availWidth-$('#'+el).width())/2);
    if($.browser.msie)
    {
        $('#'+el).css('top',document.documentElement.scrollTop+window.screen.availHeight/2-$('#'+el).height()/2);
    }
    else
    {
        $('#'+el).css('top',document.body.scrollTop+window.screen.availHeight/2-$('#'+el).height()/2);
    }
    var el=$('#'+el);//给el的父元素添加一个iframe(重要)
    if($("#block___iframe").length==0)//如果block___iframe不存在，则添加一个
    {
        el.parent().append('<iframe id="block___iframe" style="display:none;position:absolute;z-index:5000"></iframe>');
    }
    //设置iframe的样式
    var frame=$("#block___iframe");
    frame.css("left",el.css('left'));
    frame.css("top",el.css('top'));
    frame.width(el.width()+width);
    frame.height(el.height()+height);
    frame.show();
}

function close_center(el)
{
    $('#'+el).hide();
    $('#dd_light').hide();
    $("#block___iframe").hide();
}

function show_center_nw(el)
{
    $('#'+el).fadeIn('slow');
    $('#'+el).css('left',(window.screen.availWidth-$('#'+el).width())/2);
    if($.browser.msie)
    {
        $('#'+el).css('top',document.documentElement.scrollTop+window.screen.availHeight/2-$('#'+el).height()/2);
    }
    else
    {
        $('#'+el).css('top',document.body.scrollTop+window.screen.availHeight/2-$('#'+el).height()/2);
    }
    var el=$('#'+el);
    if($("#block___iframe").length==0)
    {
        el.parent().append('<iframe id="block___iframe" style="display:none;position:absolute;z-index:5000"></iframe>');
    }
    var frame=$("#block___iframe");
    frame.css("left",el.css('left'));
    frame.css("top",el.css('top'));
    frame.width(el.width());
    frame.height(el.height());
    frame.show();
}

function close_center_nw(el)
{
    $('#'+el).fadeOut('slow');
    $("#block___iframe").hide();
}


//获得event兼容ff和ie的对象
function getEvent()
{   
    if($.browser.msie)
    {
        return window.event;
    }
    func=getEvent.caller;            
    while(func!=null)
    {    
        var arg0=func.arguments[0];
        if(arg0)
        {
            if((arg0.constructor==Event || arg0.constructor ==MouseEvent)|| (typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation))
            {    
                return arg0;
            }
        }
        func=func.caller;
    }
    return null;
} 

//跳转页面
function goto_page(obj,fun,pcount)
{
    var e=getEvent();
    if(e.keyCode!=8&&e.keyCode==13)
    {
        if(obj.value=='')
        {
            alert('请输入页码!!!');
            obj.focus();
            return;
        }
        if(isNaN(obj.value))
        {
            alert('页码必须为整数!!!');
            obj.focus();
            return;
        }
        if(parseInt(obj.value)>pcount||parseInt(obj.value)<1)
        {
            alert('页码必须在1-'+pcount+'之间');
            obj.focus();
            return;
        }
        eval(fun+'('+obj.value+')');
        window.location='#';
    }
}

//去掉字符串前后的空格
function trim(str)
{
    return str.replace(/(^\s*)|(\s*$)/g,"");
}  
//有JS找对象
function GetObj(id)
{
    return document.getElementById(id);
}


//$("#x").html(" 1%x","2222")则为" 12222x"类似string.format
(function($) {
	
	function replace(handler, args) {
		return handler.apply(this, args.length < 2 ? args : [$.format(args[0], $.makeArray(args).slice(1))]);
	}
	
	var oldhtml = $.fn.html,
		oldtext = $.fn.text;
	
	$.fn.extend({
		html: function() {
			return replace.call(this, oldhtml, arguments);
		},
		text: function(text) {
			return replace.call(this, oldtext, arguments);
		}
	});
	
	$.format = function(value, args) {
		var counter = 0;
		return value.replace(/%/g, function(char, pos, value) {
			var before = value.charAt(pos - 1),
				after = value.charAt(pos + 1);
			if( before == "%" )
				return "%";
			if( after == "%" )
				return "";
			return args[counter++]
		});
	}

})(jQuery);

function delHtmlTag(str)
{
    return str.replace(/<[^>]+>/g,"");//去掉所有的html标记
} 

//更简洁的区分双字节和单字节（只显示当前内容为多少个字节）
//str_Write：用来接受输入内容
//str_ReaderLength:规定的字节数
function StrMethod_Liuwei(str_Write,str_ReaderLength)
{
    var str=str_Write; //document.getElementById(str_Write).value;
    var bytesCount=0;
    for (var i = 0; i < str.length; i++)
    {
        var c = str.charAt(i);
        if (/^[\u0000-\u00ff]$/.test(c))   //匹配双字节
        {
            bytesCount += 1;
        }
        else
        {
            bytesCount += 2;
        }
        if(bytesCount>str_ReaderLength)
        {

            str = str.substring(0,i-3)+"..."; 
            return str;
        }
        
    }
    return str;
}