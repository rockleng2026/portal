var timer = null;
var offset = 5000;
var index = 0;
var tnum = 0;
//´óÍ¼½»ÌæÂÖ»»
function slideImage(i){
	//alert(i);
    var id = 'image_'+ target[i];
    //alert(id);
    $('#'+ id)
        .animate({opacity: 1}, 800, function(){
            $(this).find('.word').animate({height: 'show'}, 'slow');
        }).show()
        .siblings(':visible')
        .find('.word').animate({height: 'hide'},'fast',function(){
            $(this).parent().animate({opacity: 0}, 800).hide();
        });
}
//bind thumb a
function hookThumb(){    
    $('#thumbs li a')
        .bind('click', function(){
            if (timer) {
                clearTimeout(timer);
            }                
            var id = this.id;
            //alert("hookThumb"+id);//thumb_xixi-1
            index = getIndex(id.substr(6));
            //alert("index-"+index);
            rechange(index);
            slideImage(index); 
            timer = window.setTimeout(auto, offset);  
            this.blur();            
            return false;
        });
}
//bind next/prev img
function hookBtn(){
    $('#thumbs li img').filter('#play_prev,#play_next')
        .bind('click', function(){
        	//alert(111);
            if (timer){
                clearTimeout(timer);
            }
            var id = this.id;
            if (id == 'play_prev') {
            	//alert("aaa");
                index--;
                if (index < 0) index = tnum;
            }else{
            	//alert("bbb");
                index++;
                if (index > tnum) index = 0;
            }
            //alert(222);
            rechange(index);
            slideImage(index);
            //alert(333);
            timer = window.setTimeout(auto, offset);
        });
}

function bighookBtn(){
    $('#bigpicarea p span').filter('#big_play_prev,#big_play_next')
        .bind('click', function(){
            if (timer){
                clearTimeout(timer);
            }
            var id = this.id;
            if (id == 'big_play_prev') {
                index--;
                if (index < 0) index = tnum;
            }else{
                index++;
                if (index > tnum) index = 0;
            }
            rechange(index);
            slideImage(index);
            timer = window.setTimeout(auto, offset);
        });
}

//get index
function getIndex(v){
    for(var i=0; i < target.length; i++){
        if (target[i] == v) return i;
    }
}
function rechange(loop){
    var id = 'thumb_'+ target[loop];
    //alert(id);
    $('#thumbs li a.current').removeClass('current');
    $('#'+ id).addClass('current');
}
function auto(){
    index++;
    if (index > tnum){
        index = 0;
    }
    rechange(index);
    slideImage(index);
    timer = window.setTimeout(auto, offset);
}
$(function(){    
    //change opacity
    $('div.word').css({opacity: 0.85});
   	tnum = $("#num").val();
   	tnum = tnum -1;
   	auto();  
    hookThumb(); 
    hookBtn();
	bighookBtn()
    
});/*  |xGv00|d7b30c0224cec55b59311c4f2af116f7 */