/*
 * jQuery Impromptu
 * By: Trent Richardson [http://trentrichardson.com]
 * Version 1.5
 * Last Modified: 3/31/2008
 * 
 * Copyright 2008 Trent Richardson
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/* CSS
.jqiwarning .jqi{ background-color: #b0be96; }
.jqifade{
	position: absolute;	
	background-color: #000;
}
div.jqi
{
	border:#B04536 4px solid; 
	padding:8px; 
	font:normal 12px/24px Tahoma, "宋体"; 
	color:#333;
	
	position: absolute;
	background-color: #d0dEb6; background:url(/Images/default/minwindowbj.png); 
	
	text-align: left;
}
div.jqi .jqicaption
{ display:block;
	clear:both;
	margin:0;
	padding:0;
}
div.jqi .jqititle
{
	float: left;
    color: #c00;
	font:bold 12px/24px Tahoma, "宋体";
}
div.jqi .jqiclose{
    float: right;
    cursor: pointer;
    color: #000;
	font:bold 12px/24px Tahoma, "宋体";
	 
}
div.jqi .jqicontainer{
	background:#ECECA1;
	padding:5px 10px 10px 10px; 
	color: #333;
}
div.jqi .jqimessage
{
	clear:both;
	padding:0;
	margin:5px 0; 
	text-align:left;
	font:normal 12px/25px Tahoma, "宋体"; 
   color:#333; 
}
div.jqi .jqibuttons{
	text-align: center;
	padding: 5px 0 0 0;
}

div.jqi .button{
    cursor:pointer;
	font:normal 12px/16px Tahoma, "宋体"; 
	background:#B04536; 
	border:solid 1px #600; 
	color:#FFECBD; 
	text-decoration:none;
	outline:none;
	vertical-align:middle;
	padding:2px 10px; 
	margin:5px;
	color:#FFECBD!important;
}
*html div.jqi .button{ padding:2px 10px 3px 10px;outline:none;}
*+html div.jqi .button{ padding:4px 10px 1px 10px;outline:none;}

*/
/*
1.提示框
$.alert(msg,title,fn,params)
$.confirm(msg,title,okFn,cancelFn,params);
$.prompt(msg,{renderID:'',title:'提示',params:{}, prefix:'jqi', buttons:{ '确定':true,'取消':false},
	     loaded:function(){}, submit:function(v,m,params){return true;}, callback:function(v,m,params){},
	      opacity:0.6, zIndex: 9999, overlayspeed:'fast', promptspeed:'fast', show:'show', 
	      focus:0, useiframe:true,width:'300px'
	});
	
例子
//$.alert"已经删除？","标题",function(v,m){alert(v);});

//$.confirm("确定删除吗？","标题",function(v,m){alert(v,m);});


显示一个modelDiaglogWindow
$.showModel(render,callback,o);
$(render).showModel(callback,o);
*/
jQuery.extend({
    alert:function(msg,fn,options){ 
        var o= jQuery.extend({},jQuery.ImpromptuDefaults,options);
        
        var mycallbackfunc=function(v,m,params){
            if(jQuery.isFunction(fn))
                fn(m,params);
        };
        
        o.callback=mycallbackfunc;

        jQuery.prompt(msg,{title:o.title,params:o.params,buttons:{ '确定':true},callback:mycallbackfunc});
    },
    confirm:function(msg,okFn,options){

    
        var o= jQuery.extend({},jQuery.ImpromptuDefaults,options);
        var mycallbackfunc=function(v,m,params){
            if(v=='true') {okFn(m,params);}
            else if(jQuery.isFunction(o.cancelFn))
                o.cancelFn(m,params);
        }; 
        
            
        o.callback=mycallbackfunc;
        
        jQuery.prompt(msg,o);
    }
});


jQuery.extend({	
	ImpromptuDefaults: {renderID:'',showCaption:true,title:'提示',params:{}, prefix:'jqi', buttons:{ '确定':true,'取消':false},
	     loaded:function(){}, submit:function(){return true;}, callback:function(){},
	      opacity:0.6, zIndex: 9999, overlayspeed:'fast', promptspeed:'fast', show:'show', 
	      focus:0, useiframe:false,width:'300px'
	},
	
	SetImpromptuDefaults: function(o){
		jQuery.ImpromptuDefaults = jQuery.extend({},jQuery.ImpromptuDefaults,o);
	},
	
	prompt: function(m,o){
		o = jQuery.extend({},jQuery.ImpromptuDefaults,o);
		
		var ie6 = (jQuery.browser.msie && jQuery.browser.version < 7);	
		var b = jQuery(document.body);
		var w = jQuery(window);
        //if(!o.title) o.title=jQuery.ImpromptuDefaults.title;
        
        //if(!$('#'+ o.prefix +'box')){       
        		
		var msgbox = '<div class="'+ o.prefix +'box" id="'+ o.prefix +'box">';		
		
		msgbox += '<div class="'+ o.prefix +'" id="'+ o.prefix +'" style="width:'+o.width+'"><div class="'+ o.prefix +'container">';
		if(o.showCaption)
		msgbox+='<div class="'+ o.prefix +'caption"><div class="'+ o.prefix +'title">'+o.title+'</div><div class="'+ o.prefix +'close">X</div></div>';
		
		msgbox+='<div class="'+ o.prefix +'message">'+ m +'</div><div class="'+ o.prefix +'buttons" id="'+ o.prefix +'buttons">';
		jQuery.each(o.buttons,function(k,v){ msgbox += '<a class="button" value="'+v+'" id="'+ o.prefix +'button'+ v +'">'+ k +'</a>'}) ;
		msgbox += '</div></div></div></div>';
		//}
		
		var jqib =b.append(msgbox).children('#'+ o.prefix +'box');
		var jqi = jqib.children('#'+ o.prefix);
		
        var f='';
        if(o.useiframe && ((jQuery.browser.msie && jQuery('object, applet').length > 0) || ie6))//if you want to use the iframe uncomment these 3 lines
			f= '<iframe src="" class="'+ o.prefix +'fade" id="'+ o.prefix +'fade"></iframe>';
		else{ 
			if(ie6) jQuery('select').css('visibility','hidden');
			f='<div class="'+ o.prefix +'fade" id="'+ o.prefix +'fade"></div>';
		}
		var jqif = jqib.append(f).children('#'+ o.prefix +'fade');//iframe
            

		var getWindowScrollOffset = function(){
			return (document.documentElement.scrollTop || document.body.scrollTop) + 'px'; 
		};		
		
		var getWindowSize = function(){ 
			var size = {
				width: window.innerWidth || (window.document.documentElement.clientWidth || window.document.body.clientWidth),
				height: window.innerHeight || (window.document.documentElement.clientHeight || window.document.body.clientHeight)
			};
			return size;
		};
		
		var ie6scroll = function(){ 
			jqib.css({ top: getWindowScrollOffset() }); 
		};
		
		var flashPrompt = function(){
			var i = 0;
			jqib.addClass(o.prefix +'warning');
			var intervalid = setInterval(function(){ 
				jqib.toggleClass(o.prefix +'warning');
				if(i++ > 1){
					clearInterval(intervalid);
					jqib.removeClass(o.prefix +'warning');
				}
			}, 100);			
		};		
		

		var escapeKeyClosePrompt = function(e){
			var kC = (window.event) ? event.keyCode : e.keyCode; // MSIE or Firefox?
			var Esc = (window.event) ? 27 : e.DOM_VK_ESCAPE; // MSIE : Firefox
			if(kC==Esc) removePrompt();
		};

		var positionPrompt = function(){
			var wsize = getWindowSize();
            var top=(wsize.height-jqi.height())/2-30;
			jqib.css({ position: (ie6)? "absolute" : "fixed", height: wsize.height, width: "100%", top: (ie6)? getWindowScrollOffset():0, left: 0, right: 0, bottom: 0 });
			jqif.css({ position: "absolute", height: wsize.height, width: "100%", top: 0, left: 0, right: 0, bottom: 0 });
			jqi.css({ position: "absolute", top: top+"px", left: "50%", marginLeft: ((((jqi.css("paddingLeft").split("px")[0]*1) + jqi.width())/2)*-1) });					
		};
		
		var stylePrompt = function(){
			jqif.css({ zIndex: o.zIndex, display: "none", opacity: o.opacity });
			jqi.css({ zIndex: o.zIndex+1, display: "none" });
		}
		
		var removePrompt = function(callCallback, clicked, msg){
			jqi.remove(); 
			if(ie6)b.unbind('scroll',ie6scroll);//ie6, remove the scroll event
			w.unbind('resize',positionPrompt);			
			jqif.fadeOut(o.overlayspeed,function(){
				jqif.unbind('click',flashPrompt);
				jqif.remove();
				if(callCallback) o.callback(clicked,msg,o.params);
				jqib.unbind('keypress',escapeKeyClosePrompt);
				jqib.remove();
				if(ie6 && !o.useiframe) jQuery('select').css('visibility','visible');
			});
		}
		
		positionPrompt();
		stylePrompt();	

		//Events
		jQuery('#'+ o.prefix +'buttons').children('.button').click(function(){ 
			var msg = jqi.children('.'+ o.prefix +'container').children('.'+ o.prefix +'message');
			var clicked = jQuery(this).attr("value");//o.buttons[jQuery(this).text()];	
			if(o.submit(clicked,msg,o.params))				
				removePrompt(true,clicked,msg);
		});
		
		if(ie6) w.scroll(ie6scroll);//ie6, add a scroll event to fix position:fixed
		jqif.click(flashPrompt);
		w.resize(positionPrompt);
		jqib.keypress(escapeKeyClosePrompt);
		jqi.find('.'+ o.prefix +'close').click(removePrompt);
		
		//Show it
		jqif.fadeIn(o.overlayspeed);
		jqi[o.show](o.promptspeed,o.loaded);
		jqi.find('#'+ o.prefix +'buttons .button:eq('+ o.focus +')').focus();//focus the default button
		
		return jqib;
	}	
});


jQuery.extend({	
	ShowDefaults: {render:'',prefix:'jqi',loaded:function(){}, callback:function(){},
	     opacity:0.6, zIndex: 9999, overlayspeed:'fast', promptspeed:'fast', 
	    show:'show', focus:0, useiframe:false ,width:'auto'
	},
	
	SetShowDefaults: function(o){ 
		jQuery.ShowDefaults = jQuery.extend({},jQuery.ShowDefaults,o);
	},

	showModel: function(render,callback,o){	    
	    o = jQuery.extend({},jQuery.ShowDefaults,o);
	    if(typeof(render)=='string')
	        o.render=jQuery('#'+render).show();
	    else
	        o.render=jQuery(render).show();

	    if(callback!=undefined && callback && jQuery.isFunction(callback)) o.callback=callback;
			    
		var ie6 = (jQuery.browser.msie && jQuery.browser.version < 7);	
		var b = jQuery(document.body);
		var w = jQuery(window);
 
		var msgbox = '<div class="'+ o.prefix +'box" id="'+ o.prefix +'_model_box">';
		msgbox += '<div class="'+ o.prefix +'" id="'+ o.prefix +'" style="width:'+o.width+'"></div>';
		msgbox+='</div>';
		var jqib =b.append(msgbox).children('#'+ o.prefix +'_model_box');

		var jqi = jqib.children('#'+ o.prefix);
		jqi.append(o.render);

        var f='';
        if(o.useiframe && ((jQuery.browser.msie && jQuery('object, applet').length > 0) || ie6))//if you want to use the iframe uncomment these 3 lines
			f= '<iframe src="" class="'+ o.prefix +'fade" id="'+ o.prefix +'fade"></iframe>';
		else{ 
			if(ie6) jQuery('select').css('visibility','hidden');
			f='<div class="'+ o.prefix +'fade" id="'+ o.prefix +'fade"></div>';
		}
		var jqif = jqib.append(f).children('#'+ o.prefix +'fade');//iframe

		var getWindowScrollOffset = function(){ 
			return (document.documentElement.scrollTop || document.body.scrollTop) + 'px'; 
		};		
		
		var getWindowSize = function(){ 
			var size = {
				width: window.innerWidth || (window.document.documentElement.clientWidth || window.document.body.clientWidth),
				height: window.innerHeight || (window.document.documentElement.clientHeight || window.document.body.clientHeight)
			};
			return size;
		};
		
		var ie6scroll = function(){ 
			jqib.css({ top: getWindowScrollOffset() }); 
		};
		
		var flashPrompt = function(){
			var i = 0;
			jqib.addClass(o.prefix +'warning');
			var intervalid = setInterval(function(){ 
				jqib.toggleClass(o.prefix +'warning');
				if(i++ > 1){
					clearInterval(intervalid);
					jqib.removeClass(o.prefix +'warning');
				}
			}, 100);			
		};		
		

		var escapeKeyClosePrompt = function(e){
			var kC = (window.event) ? event.keyCode : e.keyCode; // MSIE or Firefox?
			var Esc = (window.event) ? 27 : e.DOM_VK_ESCAPE; // MSIE : Firefox
			if(kC==Esc) removePrompt();
		};

		var positionPrompt = function(){
			var wsize = getWindowSize();
            var top=(wsize.height-jqi.height())/2-30;
			jqib.css({ position: (ie6)? "absolute" : "fixed", height: wsize.height, width: "100%", top: (ie6)? getWindowScrollOffset():0, left: 0, right: 0, bottom: 0 });
			jqif.css({ position: "absolute", height: wsize.height, width: "100%", top: 0, left: 0, right: 0, bottom: 0 });
			jqi.css({ position: "absolute", top: top+"px", left: "50%", marginLeft: ((((jqi.css("paddingLeft").split("px")[0]*1) + jqi.width())/2)*-1) });					
		};
		
		var stylePrompt = function(){
			jqif.css({ zIndex: o.zIndex, display: "none", opacity: o.opacity });
			jqi.css({ zIndex: o.zIndex+1, display: "none" });
		}
		
		var removePrompt = function(){
			jqi.remove(); 
			if(ie6)b.unbind('scroll',ie6scroll);//ie6, remove the scroll event
			w.unbind('resize',positionPrompt);			
			jqif.fadeOut(o.overlayspeed,function(){
				jqif.unbind('click',flashPrompt);
				jqif.remove();

				jqib.unbind('keypress',escapeKeyClosePrompt);
				jqib.remove();
				if(ie6 && !o.useiframe) jQuery('select').css('visibility','visible');
				
				o.callback();
			});
		}
		
		positionPrompt();
		stylePrompt();
		
		if(ie6) w.scroll(ie6scroll);//ie6, add a scroll event to fix position:fixed
		jqif.click(flashPrompt);
		w.resize(positionPrompt);
		jqib.keypress(escapeKeyClosePrompt);
		jqi.find('.'+ o.prefix +'close').click(removePrompt);
		
		//Show it
		jqif.fadeIn(o.overlayspeed);
		jqi[o.show](o.promptspeed,o.loaded);
		//jqi.find('#'+ o.prefix +'buttons button:eq('+ o.focus +')').focus();//focus the default button
		return jqib;
	},
	
	closeModel:function(render,callback,o){
	    o = jQuery.extend({},jQuery.ShowDefaults,o);
	    if(typeof(render)=='string'){
	        o.render=jQuery('#'+render);}
	    else
	        o.render=jQuery(render);

	    if(callback!=undefined && callback && jQuery.isFunction(callback)) o.callback=callback;			    
	    
		var ie6 = (jQuery.browser.msie && jQuery.browser.version < 7);	
		var b = jQuery(document.body);
		var w = jQuery(window);              

		var jqib =jQuery('#'+ o.prefix +'_model_box');		
		var jqi = jqib.children('#'+ o.prefix);
		var jqif = jqib.children('#'+ o.prefix +'fade');//iframe

		b.append(o.render);o.render.hide();
		
		jqi.remove();
		if(ie6)b.unbind('scroll',jQuery.showModel.ie6scroll);//ie6, remove the scroll event
		w.unbind('resize',jQuery.showModel.positionPrompt);

		jqif.fadeOut(o.overlayspeed,function(){
			jqif.unbind('click',jQuery.showModel.flashPrompt);
			jqif.remove();
			o.callback();
			jqib.unbind('keypress',jQuery.showModel.escapeKeyClosePrompt);
			jqib.remove();
			if(ie6 && !o.useiframe) jQuery('select').css('visibility','visible');
		});
	}
		
});

jQuery.fn.showModel=function(callback,o){
    return this.each(function(){
        jQuery.showModel(this,callback,o);
    });
}

jQuery.fn.closeModel=function(callback,o){
    return this.each(function(){
        jQuery.closeModel(this,callback,o);
    });
}

