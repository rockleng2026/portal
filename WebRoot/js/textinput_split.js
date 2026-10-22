$(function(){
	//文本框
	var focusFlag;
	$("input:text[class=''],input:password[class=''],input:text[class*=validate],input:password[class*=validate]").each(function(){
		$(this).addClass("textinput");
		$(this).hover(
			function() {
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("textinput");
					$(this).addClass("textinput_hover");
				}
				},
			function(){
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("textinput_hover");
					$(this).addClass("textinput");
				}
				}
		);
		$(this).focus(function(){
			focusFlag=$(this)[0];
			$(this).removeClass("textinput");
			$(this).removeClass("textinput_hover");
			$(this).addClass("textinput_click");
		});
		$(this).blur(function(){
			focusFlag=null;
			$(this).removeClass("textinput_click");
			$(this).addClass("textinput");
		});
		if($(this).attr("clearable")=="true"){
			$(this).clearableTextField();
		}
		if ($(this).attr("maxNum")!=null) {
			$(this).maxlength();
		}
		if($(this).attr("checkStrength")=="true"){
			$(this).password_strength();
		}
		if ($(this).attr("watermark") != null) {
			$(this).watermark('watermark',$(this).attr("watermark"));
		}
	});
	
	//密码框检测大写键
	$("input:password[class='textinput'],input:password[class*=validate]").each(function(){
		$(this).caps(function(caps){
		    if(jQuery.browser.safari) return; 
		    if(caps){
				$.cursorMessage('注意：大写键开启了');
		    }else{
		    }
		});
	});
	
	//文本域
	$("textarea").each(function(){
		if($(this).attr("class")==""){
			$(this).addClass("textarea");
		}
		if ($(this).attr("maxNum")!=null) {
			$(this).maxlength({maxCharacters:parseInt($(this).attr("maxNum"))});
		}
		if ($(this).attr("resize")=="true"){
			$(this).TextAreaResizer();
		}
		if ($(this).attr("autoHeight")=="true"){
			$(this).css({
				height:"auto"
			});
			$(this).attr("rows",5);
			$(this).autoGrow();
		}
		if ($(this).attr("watermark") != null) {
			$(this).watermark('watermark',$(this).attr("watermark"));
		}
	});
	
	//文本域焦点变换
	$("textarea[class='textarea'],textarea[class*='textarea'],textarea[class*=validate]").each(function(){
		
		$(this).hover(
			function() {
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("textarea");
					$(this).addClass("textarea_hover");
				}
				},
			function(){
				if(focusFlag!=$(this)[0]){
					$(this).removeClass("textarea_hover");
					$(this).addClass("textarea");
				}
				}
		);
		$(this).focus(function(){
			focusFlag=$(this)[0];
			$(this).removeClass("textarea");
			$(this).removeClass("textarea_hover");
			$(this).addClass("textarea_click");
		});
		$(this).blur(function(){
			focusFlag=null;
			$(this).removeClass("textarea_click");
			$(this).addClass("textarea");
		});
	});
});








/*文本域改变高度*/
(function($) {
	var textarea, staticOffset;  // added the var declaration for 'staticOffset' thanks to issue logged by dec.
	var iLastMousePos = 0;
	var iMin = 32;
	var grip;
	$.fn.TextAreaResizer = function() {
		return this.each(function() {
		    textarea = $(this).addClass('processed'), staticOffset = null;
		    $(this).wrap('<div class="resizable-textarea"><span></span></div>')
		      .parent().append($('<div class="grippie"></div>').bind("mousedown",{el: this} , startDrag));
		    var grippie = $('div.grippie', $(this).parent())[0];
		    grippie.style.marginRight = (grippie.offsetWidth - $(this)[0].offsetWidth) +'px';
		});
	};
	function startDrag(e) {
		textarea = $(e.data.el);
		textarea.blur();
		iLastMousePos = mousePosition(e).y;
		staticOffset = textarea.height() - iLastMousePos;
		textarea.css('opacity', 0.25);
		$(document).mousemove(performDrag).mouseup(endDrag);
		return false;
	}
	function performDrag(e) {
		var iThisMousePos = mousePosition(e).y;
		var iMousePos = staticOffset + iThisMousePos;
		if (iLastMousePos >= (iThisMousePos)) {
			iMousePos -= 5;
		}
		iLastMousePos = iThisMousePos;
		iMousePos = Math.max(iMin, iMousePos);
		textarea.height(iMousePos + 'px');
		if (iMousePos < iMin) {
			endDrag(e);
		}
		return false;
	}
	function endDrag(e) {
		$(document).unbind('mousemove', performDrag).unbind('mouseup', endDrag);
		textarea.css('opacity', 1);
		textarea.focus();
		textarea = null;
		staticOffset = null;
		iLastMousePos = 0;
	}

	function mousePosition(e) {
		return { x: e.clientX + document.documentElement.scrollLeft, y: e.clientY + document.documentElement.scrollTop };
	};
})(jQuery);
/*文本域改变高度*/

/*水印*/
(function($) {
	$.fn.watermark = function(css, text) {
		return this.each(function() {
			var i = $(this), w;
			i.focus(function() {
				w && !(w=0) && i.removeClass(css).data('w',0).val('');
				$(this).val('');
			})
			.blur(function() {
				!i.val() && (w=1) && i.addClass(css).data('w',1).val(text);
				$(this).addClass(css);
			})
			.closest('form').submit(function() {
				w && i.val('');
			});
			i.blur();
		});
	};
	$.fn.removeWatermark = function() {
		return this.each(function() {
			$(this).data('w') && $(this).val('');
		});
	};
})(jQuery);
/*水印*/

/*可调用的提示*/
if(jQuery) {
	( function($) {
	$.cursorMessageData = {}; // needed for e.g. timeoutId

	$(window).ready(function(e) {
		if ($('#cursorMessageDiv').length==0) {
			
			   $('body').append('<div id="cursorMessageDiv">&nbsp;</div>');
			  $('#cursorMessageDiv').hide();
		}

		$('body').mousemove(function(e) {
			$.cursorMessageData.mouseX = e.pageX;
			$.cursorMessageData.mouseY = e.pageY;
			if ($.cursorMessageData.options != undefined) $._showCursorMessage();
		});
	});
	$.extend({
		cursorMessage: function(message, options) {
			if( options == undefined ) options = {};
			if( options.offsetX == undefined ) options.offsetX = 5;
			if( options.offsetY == undefined ) options.offsetY = 5;
			if( options.hideTimeout == undefined ) options.hideTimeout = 1000;

			$('#cursorMessageDiv').html(message).fadeIn('slow');
			if (jQuery.cursorMessageData.hideTimeoutId != undefined)  clearTimeout(jQuery.cursorMessageData.hideTimeoutId);
			if (options.hideTimeout>0) jQuery.cursorMessageData.hideTimeoutId = setTimeout($.hideCursorMessage, options.hideTimeout);
			jQuery.cursorMessageData.options = options;
			$._showCursorMessage();
		},
		hideCursorMessage: function() {
			$('#cursorMessageDiv').fadeOut('slow');
		},
		_showCursorMessage: function() {
			$('#cursorMessageDiv').css({ top: ($.cursorMessageData.mouseY + $.cursorMessageData.options.offsetY)+'px', left: ($.cursorMessageData.mouseX + $.cursorMessageData.options.offsetX) });
		}
	});
})(jQuery);
}
/*可调用的提示*/

/*监测Caps键*/
jQuery.fn.caps = function(cb){
    return this.keypress(function(e){
        var w = e.which ? e.which : (e.keyCode ? e.keyCode : -1);
        var s = e.shiftKey ? e.shiftKey : (e.modifiers ? !!(e.modifiers & 4) : false);
        var c = ((w >= 65 && w <= 90) && !s) || ((w >= 97 && w <= 122) && s);
        cb.call(this, c);
    });
};
/*监测Caps键*/


/*文本框文字清除功能*/
(function($) {
  $.fn.clearableTextField = function() {
    if ($(this).length>0) {
      $(this).bind('keyup change paste cut', onSomethingChanged);
    
      for (var i=0; i<$(this).length; i++) {
        trigger($($(this)[i]));
      }
    }
  }
  
  function onSomethingChanged() {
    trigger($(this));
  }
  
  function trigger(input) {
    if(input.val().length>0){
      add_clear_button(input);
    } else {
      remove_clear_button(input);
    }    
  }
  
  function add_clear_button(input) {
    if (!input.next().hasClass('text_clear_button')) {
      // appends div
      input.after("<div class='text_clear_button'></div>");
    
      var clear_button = input.next();
      var w = clear_button.outerHeight(), h = clear_button.outerHeight();
      
      input.css('padding-right', parseInt(input.css('padding-right')) + w + 1);
      input.width(input.width() - w - 1);
          
      var pos = input.position();
      var style = {};  
      style['left'] = pos.left + input.outerWidth(false) - (w+2);
      var offset = Math.round((input.outerHeight(true) - h)/2.0);
     // style['top'] = pos.top + offset;
      style['top'] = pos.top +$("#scrollContent").scrollTop() + offset;
      clear_button.css(style);
          
      clear_button.click(function(){
        input.val('');
        trigger(input);
      });
    }
  }
  
  function remove_clear_button(input) {
    var clear_button = input.next();
    
    if (clear_button.hasClass('text_clear_button')) {
      clear_button.remove();
      var w = clear_button.width();

      input.css('padding-right', parseInt(input.css('padding-right')) - w -1);
      input.width(input.width() + w + 1);
    }
  }
})(jQuery);
/*文本框文字清除功能*/

/*剩余字数功能*/
(function($) 
{
	$.fn.maxlength = function(options)
	{
		var settings = jQuery.extend(
		{
			events:				      [], 
			maxCharacters:		  10, 
			status:				      true, 
			statusClass:		    "maxNum", 
			statusText:			    "剩余字数",
			notificationClass:	"notification",	
			showAlert: 			    false,
			alertText:			    "输入字符超出限制.", 
			slider:				      true
		}, options );
		$.merge(settings.events, ['keyup']);
		return this.each(function() 
		{
			var item = $(this);
			var charactersLength = $(this).val().length;
			function updateStatus()
			{
				var charactersLeft = settings.maxCharacters - charactersLength;
				
				if(charactersLeft < 0) 
				{
					charactersLeft = 0;
				}
				item.next("div").html(settings.statusText+ " :"+ charactersLeft  );
			}
			function checkChars() 
			{
				var valid = true;
				if(charactersLength >= settings.maxCharacters) 
				{
					valid = false;
					item.addClass(settings.notificationClass);
					item.val(item.val().substr(0,settings.maxCharacters));
					showAlert();
				} 
				else 
				{
					if(item.hasClass(settings.notificationClass)) 
					{
						item.removeClass(settings.notificationClass);
					}
				}

				if(settings.status)
				{
					updateStatus();
				}
			}
			function showAlert() 
			{
				if(settings.showAlert)
				{
					alert(settings.alertText);
				}
			}
			function validateElement() 
			{
				var ret = false;
				
				if(item.is('textarea')) {
					ret = true;
				} else if(item.filter("input[type=text]")) {
					ret = true;
				} else if(item.filter("input[type=password]")) {
					ret = true;
				}

				return ret;
			}
			if(!validateElement()) 
			{
				return false;
			}
			$.each(settings.events, function (i, n) {
				item.bind(n, function(e) {
					charactersLength = item.val().length;
					checkChars();
				});
			});
			if(settings.status) 
			{
				item.after($("<div/>").addClass(settings.statusClass).html('-'));
				updateStatus();
			}
			if(!settings.status) 
			{
				var removeThisDiv = item.next("div."+settings.statusClass);
				
				if(removeThisDiv) {
					removeThisDiv.remove();
				}
			}
			if(settings.slider) {
				item.next().hide();
				
				item.focus(function(){
					item.next().slideDown('fast');
				});
				item.blur(function(){
					item.next().slideUp('fast');
				}); 
			}
		});
	};
})(jQuery);
/*剩余字数功能*/

/*文本域自适应高度*/
var colsDefault = 0;
var rowsDefault = 5;
function setDefaultValues(txtArea)
{
	colsDefault = txtArea.cols;
	rowsDefault = $(txtArea).attr("rows");
}
function bindEvents(txtArea)
{
	txtArea.onkeyup = function() {
		grow(txtArea);
	}
}
function grow(txtArea)
{
    var linesCount = 0;
    var lines = txtArea.value.split('\n');

    for (var i=lines.length-1; i>=0; --i)
    {
        linesCount += Math.floor((lines[i].length / colsDefault) + 1);
    }

    if (linesCount >= rowsDefault)
        txtArea.rows = linesCount + 1;
	else
        txtArea.rows = rowsDefault;
}
jQuery.fn.autoGrow = function(){
	return this.each(function(){
		setDefaultValues(this);
		bindEvents(this);
	});
};
/*文本域自适应高度*/

/*密码强度*/
(function($){
var passwordStrength = new function()
{
	this.countRegexp = function(val, rex)
	{
		var match = val.match(rex);
		return match ? match.length : 0;
	};
	
	this.getStrength = function(val, minLength)
	{	
		var len = val.length;
		
		// too short =(
		if (len < minLength)
		{
			return 0;
		}
		
		var nums = this.countRegexp(val, /\d/g),
			lowers = this.countRegexp(val, /[a-z]/g),
			uppers = this.countRegexp(val, /[A-Z]/g),
			specials = len - nums - lowers - uppers;
		
		// just one type of characters =(
		if (nums == len || lowers == len || uppers == len || specials == len)
		{
			return 1;
		}
		
		var strength = 0;
		if (nums)	{ strength+= 2; }
		if (lowers)	{ strength+= uppers? 4 : 3; }
		if (uppers)	{ strength+= lowers? 4 : 3; }
		if (specials) { strength+= 5; }
		if (len > 10) { strength+= 1; }
		
		return strength;
	};
	
	this.getStrengthLevel = function(val, minLength)
	{
		var strength = this.getStrength(val, minLength);
		switch (true)
		{
			case (strength <= 0):
				return 1;
				break;
			case (strength > 0 && strength <= 4):
				return 2;
				break;
			case (strength > 4 && strength <= 8):
				return 3;
				break;
			case (strength > 8 && strength <= 12):
				return 4;
				break;
			case (strength > 12):
				return 5;
				break;
		}
		
		return 1;
	};
};

$.fn.password_strength = function(options)
{
	var settings = $.extend({
		'container' : null,
		'minLength' : 6,
		'texts' : {
			1 : '非常弱',
			2 : '弱密码',
			3 : '强度一般',
			4 : '强密码',
			5 : '非常强'
		}
	}, options);
	
	return this.each(function()
	{
		if (settings.container)
		{
			var container = $(settings.container);
		}
		else
		{
			var container = $('<span/>').attr('class', 'password_strength');
			$(this).after(container);
		}
		
		$(this).keyup(function()
		{
			var val = $(this).val();
			if (val.length > 0)
			{
				var level = passwordStrength.getStrengthLevel(val, settings.minLength);
				var _class = 'password_strength_' + level;
				
				if (!container.hasClass(_class) && level in settings.texts)
				{
					container.text(settings.texts[level]).attr('class', 'password_strength ' + _class);
				}
			}
			else
			{
				container.text('').attr('class', 'password_strength');
			}
		});
	});
};

})(jQuery);
/*密码强度*/

