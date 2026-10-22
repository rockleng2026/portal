
var $=function(id){return document.getElementById(id)};
Array.prototype.extend=function(C){for(var B=0,A=C.length;B<A;B++){this.push(C[B]);}return this;}
function divDrag(){
                var A,B;
        var zIndex=1;
        this.dragStart=function(e){
                e=e||window.event;
                if((e.which&&(e.which!=1))||(e.button&&(e.button!=1)))return;
                var pos=this.$pos;
                                if(document.defaultView){
									     
                                        _top=document.defaultView.getComputedStyle(this,null).getPropertyValue("top");
                                        _left=document.defaultView.getComputedStyle(this,null).getPropertyValue("left");}
                                else{
									
                                        if(this.currentStyle){_top=this.currentStyle["top"];_left=this.currentStyle["left"];}
                                }
                pos.ox=(e.pageX||(e.clientX+document.documentElement.scrollLeft))-parseInt(_left);
                pos.oy=(e.pageY||(e.clientY+document.documentElement.scrollTop))-parseInt(_top);
                                if(!!A){
                                         if(document.removeEventListener){
                        document.removeEventListener("mousemove",A,false);
                        document.removeEventListener("mouseup",B,false);
                                        }else{
                        document.detachEvent("onmousemove",A);
                        document.detachEvent("onmouseup",B);
                                                document.detachEvent("ondragstart",G);
                        }
                                }
                                A=this.dragMove.create(this);
                B=this.dragEnd.create(this);
                if(document.addEventListener){
                                        document.addEventListener("mousemove",A,false);
                    document.addEventListener("mouseup",B,false);
                }else{
                                        document.attachEvent("onmousemove",A);
                    document.attachEvent("onmouseup",B);
                                                G=function(){return false};
                                                document.attachEvent("ondragstart",G);
                }
                this.style.zIndex=(++zIndex);
                this.stop(e);
        }
        this.dragMove=function(e){
                                e=e||window.event;
                                var pos=this.$pos;
                this.style.top=(e.pageY||(e.clientY+document.documentElement.scrollTop))-parseInt(pos.oy)+'px';
                this.style.left=(e.pageX||(e.clientX+document.documentElement.scrollLeft))-parseInt(pos.ox)+'px';
                                this.stop(e);}
        this.dragEnd=function(e){
                var pos=this.$pos;              
                e=e||window.event;
                                
                                if((e.which&&(e.which!=1))||(e.button&&(e.button!=1)))return;
                if(document.removeEventListener){
                        document.removeEventListener("mousemove",A,false);
                        document.removeEventListener("mouseup",B,false);
                                }else{
                        document.detachEvent("onmousemove",A);
                        document.detachEvent("onmouseup",B);
                                                document.detachEvent("ondragstart",G);
                }
                                A=null;
                                B=null;
                this.style.zIndex=(++zIndex);
                this.stop(e);
        }
        this.position=function (e){ 
                var t=e.offsetTop;
                var l=e.offsetLeft;
                while(e=e.offsetParent){ 
                                t+=e.offsetTop; 
                                l+=e.offsetLeft; 
                }
                return {x:l,y:t,ox:0,oy:0}
        }
        this.stop=function(e){
                if(e.stopPropagation){
                        e.stopPropagation();
                }else{
                        e.cancelBubble=true;}
                        
                if(e.preventDefault){
                        e.preventDefault();}
                else{e.returnValue=false;}
        }
                this.stop1=function(e){
                        e=e||window.event;
                if(e.stopPropagation){
                        e.stopPropagation();
                }else{
                        e.cancelBubble=true;}

        }
        this.create=function(bind){
                var B=this;
                var A=bind;
                return function(e){
                        return B.apply(A,[e]);
                }
        }
        this.dragStart.create=this.create;
        this.dragMove.create=this.create;
        this.dragEnd.create=this.create;
        
        this.initialize=function(){
                for(var A=0,B=arguments.length;A<B;A++){
                        C=arguments[A];
                        C=(typeof(C)=='object')?C:(typeof(C)=='string'?$(C):null);
                        if(!C)continue;
                        C.$pos=this.position(C);
                        C.dragMove=this.dragMove;
                        C.dragEnd=this.dragEnd;
                        C.position=this.position;
                        C.stop=this.stop;
                                                var $A=[];
                                                $A=$A.extend(C.getElementsByTagName('span')||[]).extend(C.getElementsByTagName('input')||[]);
                                                for(var D=0,E=$A.length;D<E;D++){
                                                        if(C.addEventListener){
                                $A[D].addEventListener("mousedown",this.stop1,false);
                                                                $A[D].addEventListener("mousemove",this.stop1,false);
                                        }else{
                                $A[D].attachEvent("onmousedown",this.stop1);
                                                                $A[D].attachEvent("onmousemove",this.stop1);
                                }
                                                }
                        if(C.addEventListener){
                                C.addEventListener("mousedown",this.dragStart.create(C),false);
                        }else{
                                C.attachEvent("onmousedown",this.dragStart.create(C));
                        }
                }

        }
        this.initialize.apply(this,arguments);
        
}
//生成拖动层很简单
new divDrag('test',$('test1'),$('test2'));

