// JavaScript Document
// JavaScript Document


 function setTab(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con_"+name+"_"+i);
	  menu.className=i==cursel?"mon":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  
  function setTab1(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con1_"+name+"_"+i);
	  menu.className=i==cursel?"mont":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  
  function setTab2(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con1_"+name+"_"+i);
	  menu.className=i==cursel?"mont1":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  function setTab3(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con1_"+name+"_"+i);
	  menu.className=i==cursel?"mont2":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }

 function setTab4(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con1_"+name+"_"+i);
	  menu.className=i==cursel?"mont3":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }

  function set(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con"+name+i);
	  menu.className=i==cursel?"hover":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  
  function setone(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con1"+name+i);
	  menu.className=i==cursel?"hover":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  
   function setTwo(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con2"+name+i);
	  menu.className=i==cursel?"hover":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
    
   function setThree(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con3"+name+i);
	  menu.className=i==cursel?"hove":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
function setForce(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con4"+name+i);
	  menu.className=i==cursel?"hover1":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  
  function setForce(name,cursel,n){
	  for(i=1;i<=n;i++){
	  var menu=document.getElementById(name+i);
	  var con=document.getElementById("con5_"+name+i);
	  menu.className=i==cursel?"mont":"";
	  con.style.display=i==cursel?"block":"none";
	} 
  }
  function tabShow(m,c,n,t){;
	//mǰ׺cǰ׺nǰ,tлЧΪ3,curΪǰʽ
	for(i=1;i<=t;i++){
		document.getElementById(m+i).className = "";
		document.getElementById(c+i).style.display = "none";
	}
	document.getElementById(m+n).className = "curb";
	document.getElementById(c+n).style.display = "block";
}

