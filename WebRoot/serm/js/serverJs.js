//机柜弹出层
function cabResived(){
	 $('.Room_Pop').show();
}
//机房弹出层
function EleResived(){
   $('.houses_Pop').show();
}
/////////////////////////////////////////
//$(function(){
//    for(var i=0;i<1000;i++){
//	$('#getArea'+i).click(function(){
//		//alert('click2');
//		addHouses();
//	});
//    }
//});
//修改机房
function updthouses(mpp){
	//alert("mpp="+mpp);
	$.getJSON(
	    "cms/show_updthouse.do",
	    {"idss":mpp},
	    function(res){
		   // alert('res='+res);
		    $('#houseSels').hide();
		    $('#houtitles').html('修改机房页面');
		    document.getElementById('ctid').value=res.ctidss;
			document.getElementById('superid').value=res.supids;
	        document.getElementById('elecId').value=res.hsid;
			document.getElementById('electname').value=res.hname;
            document.getElementById('electPosition').value=res.hposit;
            document.getElementById('electTel').value=res.htel;
            document.getElementById('electAdmin').value=res.hadmin;
            document.getElementById('electPhone').value=res.hphone; 
            document.getElementById("electCode").value=res.hcodes;
            showDiv('addhouse');
	});
}
//增加机房（1）
$(function(){
	$('#getAreas').click(function(){
		//alert('click1');
		$('#houseSels').show();
		document.getElementById('houname').innerHTML="机房名字：";
        document.getElementById('houposition').innerHTML="机房位置：";
        document.getElementById("houphones").innerHTML="机房坐机:";
        document.getElementById("houmanages").innerHTML="机房管理员:";
        document.getElementById("houmobiles").innerHTML="机房编码:";
		document.getElementById('ctid').value="";
        document.getElementById('elecId').value="";
		document.getElementById('electname').value="";
        document.getElementById('electPosition').value="";
        document.getElementById('electTel').value="";
        document.getElementById('electAdmin').value="";
        document.getElementById('electPhone').value=""; 
        document.getElementById("electCode").value="";
		$('#houtitles').html('增加机房页面');
		RoomLoad();
		$('#ctid').val($('#cityid').val());
		//alert($('#ctid').val());
		showDiv('addhouse');
	});
});
//增加机柜
function addEle(){
	//alert(101);
	var path = $('#bathpath').val();
	$('#electIds').empty();
	$('#electIds').append('<option value="0">请选择</option>');
	document.getElementById("apForm").reset();
	$('#submitLogin').attr('src',path+'serm/img/zj.jpg');
	$('#addOrupdCabs').html("增加机柜信息");
	showDiv("updc");
}

//删除机房
function delHouses(){
	var path = $('#bathpath').val();
	var hs =  $('#eletid').val();
	var arrs = new Array();
	$.ajax({
	   type:'post',
	   url:path+'cms/show_delCabint.do',
	   data:{strinID : hs},
	   success:function(result){
		   if(result=='删除机房成功'){
			      // alert(result);
				   window.location.reload();   
		   }else{
			   //alert("h2="+hs);
			   if(confirm(result)){
					location.href=path+"serm/pager/find.jsp?deid="+hs;  
			   }
		   }
	   }
	});
}


$(function(){
	$('.jfmiddle').mouseover(function(){
		 $('.Room_Pop').hide(1000);
		 $('.houses_Pop').hide(1000);
	});
});
//修改机柜(1)
function updatElet(){
	var path = $('#bathpath').val();
	 $('#electIds').empty();
	 $('#electIds').append('<option value="0">请选择</option>');
	document.getElementById("apForm").reset();
	$('#addOrupdCabs').html("修改机柜信息");
	$('#submitLogin').attr('src',path+'serm/img/modify1.jpg');
	var cb =$('#cabsid').val();
	$.getJSON('cms/show_updateCaUI.do',{upcabitid:cb},function callback(res){
		    // alert("res="+res.hid);
			 $('#caid').val(res.cid);
			 $('#eids').val(res.hid);
			 $('#caname').val(res.name);
			 $('#casz').val(res.size);
			 $('#pmax').val(res.max);
			 $('#bwmax').val(res.wmax);
			 e.ReAtRoom(res.hid,function(rest){
				// alert(rest);
		          $('#electIds').append(rest);
		          var pm = document.getElementById('electIds').options;
		          //alert(pm.length);
		          for(var i = 0;i<pm.length;i++){
		            if(pm[i].value == res.hid){
		                pm[i].selected=true;
		                $('#selct').val(res.hid);
		            }
			     }
		      });
		  });
	showDiv("updc");
}
       
//删除机柜
function deleteElects(){
	var path = $('#bathpath').val();
	var cb =$('#cabsid').val();
	//alert(203);
	location.href=path+"cms/show_delCabinet.do?caid="+cb;
}

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
    	//alert(1);
    	 wh=document.body.clientWidth+"px";
         ht=(document.body.clientHeight+document.body.scrollHeight)+"px";
    }else if(window.innerHeight){
    	//alert(2);
    	wh=window.innerWidth+"px";
    	ht=window.innerHeight+"px";
    }else{
    	wh=document.body.scrollWidth+"px";
    	ht=document.body.scrollHeight+"px";
    }
    oj.width=wh;
    oj.height=ht;
    oj.top=document.body.scrollTop?document.body.scrollTop:(document.documentElement.scrollTop-200)+'px';
    oj.position="absolute";
    oj.zIndex="1000";
    oj.background="#cccccc";
    oj.filter="alpha(opacity=60)";
    oj.opacity=0.3;
    oj.MozOpacity=40/100;
    document.body.appendChild(objs);
 
}
function getWidth(){
	return (document.body.clientWidth/4+130)+"px";
}
function getHeight(){
	return (document.body.clientHeight/4)+"px";
}
function showDiv(pm){
	   createDiv();
	   if(pm=="updc"){
	       getid("showDivs").style.display="block";
	   	   getid("showDivs").style.left=getWidth();
	   	   getid("showDivs").style.top=getHeight();
	   }
	   if(pm=="addc"){
	      getid("showDivs").style.display="block";
	   	   getid("showDivs").style.left=getWidth();
	   	   getid("showDivs").style.top=getHeight();
	   }
	   if(pm=="addhouse"){
		   getid("addshowDiv").style.display="block";
	   	   getid("addshowDiv").style.left=getWidth();
	   	   getid("addshowDiv").style.top=getHeight();
	   }
	   if(pm=="choicehos"){
		   getid("showHouseOrRoom").style.display="block";
	   	   getid("showHouseOrRoom").style.left=getWidth();
	   	   getid("showHouseOrRoom").style.top=getHeight(); 
	   }

}
   function remDiv(){
	var mss = getid("sdiv");
	if( getid("showDivs").style.display=="block"){
      getid("showDivs").style.display="none";
	}
	if(getid("addshowDiv").style.display="block"){
		getid("addshowDiv").style.display="none";
	}
	document.body.removeChild(mss);
}
   
//增加机房
   function onblurInfoCa(){
  			var electname =$('#electname').val();
  			if(electname!=""){
  			var electname1 = encodeURI(electname,"utf-8");
  		    if($('#houtitles').html()=="增加机房页面"){
  			   getHouseNames(electname1);
  		    }
  		    if($('#houtitles').html()=="增加房间页面"){
  		 	    if(electname.length>5){
  		 	    	$('#aaaa').html('输入不房间号不能大于5个字');
  		 	    	$('#electname').val("");
    			}else{
    				getHouseNames(electname1);
    			}
  			}
  			}else{
  				$('#aaaa').html('名称不能为空!');
  		}
  	}
   function getHouseNames(elenames){
	   $.ajax({
			  type: "POST",
			  url:"cms/show_addAjaxname.do",
			  data:{
			  		"electname":elenames
			  },
			  success: function(data){
			       $('#aaaa').html(data);			  		
			  }
			 });
   }
   function onclickAjax(){
	    // alert("2221");
  		var electname = encodeURI($('#electname').val(),"utf-8");
  		var electPosition = encodeURI($('#electPosition').val(),"utf-8");
  		var electTel = encodeURI($('#electTel').val(),"utf-8");
  		var electAdmin = encodeURI($('#electAdmin').val(),"utf-8");
  		var electPhone = encodeURI($('#electPhone').val(),"utf-8");
  				if(electname == "")
  				{
  					 $('#aaaa').html('名称不能为空!');
  					return false;
  				}
  				if(electPosition == "")
  				{
  					$("#hous2").show();
  					return false;
  				}
  				if(electTel == "" || isNaN(electTel))
  				{
  					$('#hous3').show();
  					return false;
  				}
  				if(electAdmin == "")
  				{
  					$('#hous4').show();
  					return false;
  				}
  				var reg =/^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}$/; 
  				if(electPhone == "" || isNaN(electPhone) || !reg.test(electPhone))
  				{
  					$('#hous5').show();
  					return false;
  				}
  				if($('#houtitles').html()=='修改机房页面'){
  					document.getElementById("casubmit").action="cms/show_realUpdElet.do";
  				
  				}
  			    $('#casubmit').submit();
  	}

  	    function RoomLoad(){
  			    e.getRoomCode("mss",function(res){
  			        document.getElementById("electCode").value=res;
  			    });
  		 }
 
  	    function getcitids(mst){
  	    	//alert("mst="+mst); 	
  	    	if(mst!=''){
  	    		e.getCityNames(mst,function(result){
  	    			$('#positions').html("&nbsp;>&nbsp;"+result);
  	    		});
  	    	}
  	    	document.getElementById("cityid").value=mst;
  	    }
  	  function getcitile(sts){
	    	//alert("t="+sts);
  	      document.getElementById("eletid").value=sts;
	    }
  	function getciticb(stn){
	    	//alert("s="+stn);
  		document.getElementById("cabsid").value=stn;
	    }
    function getHousename(){
    	      var mps=$('#cityid').val();
    	      $('#selectEle').empty();
    	      $('#selectEle').append('<option value="0">请选择</option>');
              if( document.getElementById("selectEle").options.length==1){
              var arr = new Array();
              e.getCommentHouses(mps,function(rp){
                 //alert(rp);
                 arr = rp.split(",");
                 for(var i=0;i<arr.length;i++){
                    if(i%2==0 && arr[i]!=""){
                      var opt=new Option();
                      opt.innerHTML=arr[i];
                      opt.value=arr[(i+1)];
                       document.getElementById("selectEle").appendChild(opt);
                    }
                 }
               
              });
              }
          }
          function getvalues(pps){
        	  $('#houtitles').html('增加房间页面');
            e.getEleInfos(pps,function(result){
                 //alert(result);
               for(var j=0;j<result.length;){
                   document.getElementById('superid').value=1;
                   document.getElementById('electname').value=result[j];
                   document.getElementById('houname').innerHTML="房间名字：";
                   document.getElementById('electPosition').value=result[j+1];
                   document.getElementById('houposition').innerHTML="房间位置：";
                   document.getElementById("houphones").innerHTML="房间坐机:";
                   document.getElementById("houmanages").innerHTML="房间管理员:";
                   document.getElementById("houmobiles").innerHTML="房间编码:";
                   document.getElementById('electTel').value=result[j+2];
                   document.getElementById('electAdmin').value=result[j+3];
                   document.getElementById('electPhone').value=result[j+4]; 
                   document.getElementById("electCode").value=result[j+5];
                   break;
               }
            });
          }
  		function fousInf(obj,num){
  				if(obj=="")
  				{
  				  $("#hous"+num).show();
  				}else{
  				  $("#hous"+num).hide();
  				}		
  			}
  			function resetContent(){
		     $.getJSON(
		    		    "cms/show_updthouse.do",
		    		    {"idss":$('#elecId').val()},
		    		    function(res){
		    			   // alert('res='+res);
		    			    $('#houseSels').hide();
		    			    $('#houtitles').html('修改机房页面');
		    			    document.getElementById('ctid').value=res.ctidss;
		    				document.getElementById('superid').value=res.supids;
		    		        document.getElementById('elecId').value=res.hsid;
		    				document.getElementById('electname').value=res.hname;
		    	            document.getElementById('electPosition').value=res.hposit;
		    	            document.getElementById('electTel').value=res.htel;
		    	            document.getElementById('electAdmin').value=res.hadmin;
		    	            document.getElementById('electPhone').value=res.hphone; 
		    	            document.getElementById("electCode").value=res.hcodes;
		    		});
  			}
 