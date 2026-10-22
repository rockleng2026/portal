function getid(mt){
	return document.getElementById(mt);
}
function createDiv(){
	var objs = document.createElement("div");
	var oj = objs.style;
	var ht,wh;
    objs.id="sdiv";
    oj.display="block";
    if(document.body.clientHeight){
    	 wh=document.body.clientWidth+"px";
         ht=(document.body.clientHeight+document.body.scrollHeight)+"px";
    }else if(window.innerHeight){
    	wh=window.innerWidth+"px";
    	ht=window.innerHeight+"px";
    }else{
    	wh=document.body.scrollWidth+"px";
    	ht=document.body.scrollHeight+"px";
    }
    oj.width=wh;
    oj.height=ht;
    oj.top=document.body.scrollTop?document.body.scrollTop:document.documentElement.scrollTop+'px';
    oj.position="absolute";
    oj.zIndex="1000";
    oj.background="#cccccc";
    oj.filter="alpha(opacity=60)";
    oj.opacity=0.3;
    oj.MozOpacity=40/100;
    document.body.appendChild(objs);
 
}
function getWidth(){
	return (document.body.clientWidth/3.5)+"px";
}
function getHeight(){
	return (document.body.clientHeight/5)+"px";
}
function showDiv(papid){
	   createDiv();
	   getid(papid).style.display="block";
	   getid(papid).style.left=getWidth();
	   getid(papid).style.top=getHeight();

}
  function removeDiv(papid){
	var mss = getid("sdiv");
	if(getid(papid).style.display=="block"){
		getid(papid).style.display="none";
	}
	document.body.removeChild(mss);
}
function arrtojson(arrs){
		var jsonstr;
		jsonstr="[{";
		for(var i=0;i<arrs.length;i++){
			jsonstr+="\""+arrs[i]+"\""+":"+"\""+arrs[++i]+"\",";
			
		}
		jsonstr= jsonstr.substring(0,jsonstr.lastIndexOf(','));
		jsonstr+="}]";
		return jsonstr;
}