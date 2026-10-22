var flag ;
var count = 1;
var sum = 3;

 function delRow(){
 	var nowrow = count-1;
    if( nowrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#row'+nowrow).remove();
 	count--;
 }

 function addUploadRow(){
 var uploadsum = 6;
 var count=parseInt($("#count").val());
	if(uploadcount < uploadsum){
		var uploadht = "<div class='biaodan_li1' id='fpjxrow"+uploadcount+"'>"+
			"<div class='biaodan_ul1'>"+
				"<div class='biaodan_lil1' style='width:100px'>"+uploadcount+"</div>"+
				"<div class='biaodan_lir1' style='width:190px'>"+
				    "<input type='text' name='sczjmc' >"+
				    "</div>"+
				"<div class='biaodan_lil2' style='width:664px'><input type='file' name='uploads' style='width:300px; border:#000000 solid 1px; height:25px; line-height:25px;' />"+
				"</div>"+
			"</div>"+
		"</div>";
		 $("#fpjxrow").after(uploadht);
	//	document.getElementById("itemCount").value=count;
		uploadcount++;
	}else{
		alert("只允许添加"+uploadsum+"行");
	}
}
 function delUploadRow(){
    var count=parseInt($("#count").val());
 	var nowrow = count-1;
    if( nowrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#fpjxrow'+nowrow).remove();
 	$("#count").val(count-1);
 }
 
//上传文件
 function uploadImagedel() {
	 var url = new Array();
	 var zjmc = new Array();
	 url = $("input[name='filedata']");
	 zjmc = $("input[name='sczjmc']");
	 if(zjmc.length != url.length)
	 {
		 alert("证件名称跟图片路径数量不匹配");
		 return;
	 }
	 for(var i=0; i<zjmc.length; i++)
	 {
		 if(zjmc[i].value==null ||zjmc[i].value=="" )
		 {
			 alert("上传文件的证件名称输入不完整");
			 return;
		 }
	 }
	 
	 for(var i=0; i<url.length; i++)
	 {
		 if(url[i].value==null || url[i].value=="" )
		 {
			 alert("上传文件的URL输入不完整");
			 return;
		 }
	 }
	 
 	 	$(document)
 	 			.ready(
 	 					function() {
 	 						var options = {
 	 							url : "doUploadupload.do",
 	 							type : "POST",
 							dataType : "script",
 							success : function(date) {
 								if(date == '1')
 								{
 									$("#sessionbs").attr("value",1);
 								alert("上传成功");
 								}else if(date == '2')
 								{
 								alert("文件格式错误");
 								}else
 								alert("上传失败");
 							}
 						};
 						$("#form2").ajaxSubmit(options);
 						return false;
 					});
 }
 
 //提交表单
 function form1Submit()
 {
	
	var bs =  $("#uploadflag").val();
	if(bs != "" && bs ==2)
	{
		alert("请先上传证件，或者点击放弃上传！");
		 return;
 
	}else 
	{
		$("#form1").submit();
	}
 }
 
 var flag ;
 var count = 0;      
 function addbranch(){
 	if(count < 11){
 		var branch="<div class='biaodan_li1' id='branch'>"                
 				+"<div class='biaodan_ul1'>"            
 				+"<div class='biaodan_lil1' style='width:25%;'><input  name='swbarch["+count+"].fdmc' /></div>"
 				+"<div class='biaodan_lir1' style='width:25%;'><input name='swbarch["+count+"].nsrsbh' /></div>"
 				+"<div class='biaodan_lil1' style='width:25%;'><input type='text' name='swbarch["+count+"].dz' /></div>"
 				+"<div class='biaodan_lil1' style='width:24.4%;'><input name='swbarch["+count+"].dh' /></div>"
 				+"</div>"
 				+"</div>";
 		 $("#branch").before(branch);
 		count++;
 	}
 }
  function delbranch(){
  	var nowrow = count-1;
     if( nowrow <= -1){
     	alert("至少有一行");
     	return false;
     }
  	$("#branch"+nowrow).remove();
  	count--;
  }     
 function addbranch1(){
	 var count1 = parseInt($("#count1").val());
 	if(count1 < 4){
 		var branch1="<div class='biaodan_li1' id='branch1"+count1+"'>"                
 				+"<div class='biaodan_ul1'>"            
 				+"<div class='biaodan_lil1' style='width:135px;'><input  name='swparent["+count1+"].hhrxm' /></div>"
 				+"<div class='biaodan_lir1' style='width:136px;'><input name='swparent["+count1+"].gjhdz' /></div>"
 				+"<div class='biaodan_lil1' style='width:136px;'><input type='text' name='swparent["+count1+"].sfzjmc'  }' /></div>"
 				+"<div class='biaodan_lil1' style='width:136px;'><input  name='swparent["+count1+"].sfzjhm' }'/></div>"
 				+"<div class='biaodan_lil1' style='width:136px;'><input  name='swparent["+count1+"].tzje'  /></div>"
 				+"<div class='biaodan_lir1' style='width:136px;'><input name='swparent["+count1+"].tzbl'/></div>"
 				+"<div class='biaodan_lil1' style='width:136px;'><input type='text' name='swparent["+count1+"].fpbl' /></div>"
 				+"</div>"
 				+"</div>";
 				 $("#branch1").before(branch1);
 				$("#count1").val(count1+1);
 	}else
 	{
 		alert("只能添加"+count1+"行");
 		return false;
 	}
 }


  function delbranch1(){
	  var count1 = parseInt($("#count1").val());
  	var nowrow = count1-1;
     if( nowrow <= 0){
     	alert("至少有一行");
     	return false;
     }
  	$("#branch1"+nowrow).remove();
  	$("#count1").val(count1-1);
  }



 var flag2 ;
 var count2 = 0;  
 function addbranch2(){
 	if(count1< 11){
 		var req="<div class='biaodan_ul1' id='req"+count2+"'>"            
 				+"<div class='biaodan_lil1' style='width:49.8%;float: left;'><input name='swdkdj["+count2+"].dkdjdsdjnr' /></div>"
 				+"<div class='biaodan_lir1' style='width:50%;'><input name='swdkdj["+count2+"].dkdjdsdjsz'/></div>"
 				+"</div>";
 		 $("#req").before(req);
 		count2++;
 	}
 }


  function delbranch2(){
  	var nowrow = count2-1;
     if( nowrow <= -1){
     	alert("至少有一行");
     	return false;
     }
  	 $("#req"+nowrow).remove();
  	count2--;
  }    
  
   function delyydw(){
	   var count1=parseInt($("#count1").val());
   	var nowrow = count1-1;
    if( nowrow <= 0){
      	alert("至少有一行");
      	return false;
      }
   	$("#req"+nowrow).remove();
    $("#count1").val(count1-1);
   } 
   function addreqdw(){
	   var count1=parseInt($("#count1").val());
   	if(count1< 2){
   		var req="<div class='biaodan_ul1' id='req"+count1+"'>"            
   				+"<div class='biaodan_lil1' style='width:49.6%;float: left;'><input name='djdkqk["+count1+"].dsdjnr'/></div>"
   				+"<div class='biaodan_lir1' style='width:50%;'><input name='${djdkqk["+count1+"].dsdjsz}' /></div>"
   				+"</div>";
   		 $("#req").before(req);	
   		 $("#count1").val(count1+1);
  	}else{
  		alert("只能添加"+count1+"行");
   	}
   }
  
   function swzjgs(){
	   var count= parseInt($("#count").val());
	   if(count<5){
	  		var uploadht = "<div style=' width:100%' id='swzjgsrow"+count+"'>"+
	  						"<div class='biaodan_lir1' style='width:413px;border-right:\#000000 solid 1px; float:left'>"+
	  						"<select style='width:160px;' name='swparent["+count+"].zjmc' id='zjmc' class='validate[required] text-input'  style='width:100px;'>"+
	  						"<option value=''"+
	                          " >请选择</option>"+
	                          "<option value='税务登记证正本'>税务登记证正本</option>"+
	                          "<option value='税务登记证副本'>税务登记证副本</option>"+
	  						"</select>"+
	  						"<\/div>"+
	  						"<div class='biaodan_lir1' style='width:412px; float:left'>"+
	  						"<input class='validate[required] text-input' id='zjhm' type='text' name='swparent["+count+"].zjhm' />"+
	  						"<\/div>"+
	  					"<\/div>";
	  					//alert(uploadht);
	  		 $("#dobutton").before(uploadht);
	  		 var divheight = parseInt($("#ysbdsuzj").css("height")); 
	            $("#ysbdsuzj").css("height",divheight+35);
	  	//	document.getElementById("itemCount").value=count;
	            $("#count").val(count+1);   
	   }else
	   {
		   alert("只能添加"+count+"行");
		   return false;
	   }
	           
	  }
   

   var fpjxflag ;
   var fpjxcount = 0;  
   function addfpjx(){
   	if(fpjxcount< 11){
   		var fpjx="<div class='biaodan_ul1' id='fpjxfp"+fpjxcount+"'>"
				+"<div class='biaodan_lil1' style='width:159px;'>"
				+"<label>"
			    +"<select id='fpjxdjbfb["+fpjxcount+"].fpmc' name='fpjxdjbfb["+fpjxcount+"].fpmc'><option>请选择</option></select>"
				+"</label>"
				+"</div>"
				+"<div class='biaodan_lir1' style='width:158px;'><input type='text' name='fpjxdjbfb["+fpjxcount+"].fpdm' /></div>"
				+"<div class='biaodan_lil2' style='width:159px;'>"
				+"<label>"
			    +" <select id='fpjxdjbfb[0].jxlb' name='fpjxdjbfb["+fpjxcount+"].jxlb'><option>请选择</option></select>"
				+"</label>"
				+"</div>"
				+"<div class='biaodan_lir2' style='width:158px;'><input type='text' name='fpjxdjbfb["+fpjxcount+"].xhfs' /></div>"
				+"<div class='biaodan_lil2' style='width:159px;'><input type='text' name='fpjxdjbfb["+fpjxcount+"].qshm' /></div>"
				+"<div class='biaodan_lir2' style='width:159px;'><input type='text' name='fpjxdjbfb["+fpjxcount+"].zzhm' /></div>"
				+"</div>";
				
   		 $("#fpjxfp").before(fpjx);
   		fpjxcount++;
   	}
   }
  

 function delfpjx(){
 	var nowrow = fpjxcount-1;
    if( nowrow <= -1){
    	alert("至少有一行");
    	return false;
    }
 	 $("#fpjxfp"+nowrow).remove();
 	fpjxcount--;
 }   
    
 function addswdjgrReq(){
	 var count=parseInt($("#count").val());
 	if(count< 4){   	
 		var swdjgrreq="<div class='biaodan_li1' id='swdjgrreq"+count+"'>"               
				+"<div class='biaodan_ul1'>"            
				+"<div class='biaodan_lil1' style='width:25%;'><input type='text' name='swbarch["+count+"].fdmc' /></div>"
				+"<div class='biaodan_lir1' style='width:25%;'><input type='text' name='swbarch["+count+"].nsrsbh' /></div>"
				+"<div class='biaodan_lil1' style='width:25%;'><input type='text' name='swbarch["+count+"].dz' /></div>"
				+"<div class='biaodan_lil1' style='width:24.4%;'><input type='text' name='swbarch["+count+"].dh'/></div>"
				+"</div>"
				+"</div>";
 				$("#swdjgrreq").before(swdjgrreq);
 				$("#count").val(count+1);
 	}else
 	{	
 		alert("只能添加"+count+"行");
 		return false;
 	}
 	
 }

function delswdjgrReq(){
	var count=parseInt($("#count").val());
	var nowrow = count-1;
  if( nowrow <= 0){
  	alert("至少有一行");
  	return false;
  }
	 $("#swdjgrreq"+nowrow).remove();
	 $("#count").val(count-1);
}   

 function adddeduction(){
	   var deductioncount = parseInt($("#count2").val());
 	if(deductioncount< 3){   	
 		var deduction="<div class='biaodan_ul1'  id='deduction"+deductioncount+"'>"            
				+"<div class='biaodan_lil1' style='width:49.8%;float: left;'><input name='swdkdj["+deductioncount+"].dkdjdsdjnr'/></div>"
				+"<div class='biaodan_lir1' style='width:50%;'><input name='swdkdj["+deductioncount+"].dkdjdsdjsz' /></div>"
				+"</div>";
 				$("#deduction").before(deduction);
 				$("#count2").val(deductioncount+1);
 	}else
 	{
 		alert("只能添加"+deductioncount+"行");
 		return false;
 	}
 	
 }


function deldeduction(){
	  var deductioncount = parseInt($("#count2").val());
	var nowrow = deductioncount-1;
  if( nowrow <= 0){
  	alert("至少有一行");
  	return false;
  }
	 $("#deduction"+nowrow).remove();
	 $("#count2").val(deductioncount-1);
}   

/**
 * 税务证件挂失报告表添加行（遗失被盗税务证件）
 * @return
 */
function addnsrjmsqkbabRow(){
	 var count=parseInt($("#count").val());
	 alert(count);
			var uploadht = "<div class='biaodan_li1' id='doupload"+count+"'>"+
				"<div class='biaodan_ul1'>"+
					"<div class='biaodan_lir1' style='width:413px;border-right:#000000 solid 1px; float:left'><select name='swparent["+count+"].zjmc' id='zjmc' "+
					"  class='validate[required] text-input'  style='width:100px;'><option value='税务登记证正本'>税务登记证正本</option></select></div>"+
					"<div class='biaodan_lir1' style='width:412px; float:left'><input class='validate[required] text-input' id='swparent["+count+"].zjhm' type='text' name='swparent["+count+"].zjhm'/></div>"+
				"</div></div>";
			 $("#doupload").after(uploadht);
			$("#count").val(count+1);
		}

	    

	function delnsrjmsqkbabRow(){
		
	     var count= parseInt($("#count").val());
	 	var nowrow = count-1;
	    if( nowrow <= 0){
	    	alert("至少有一行");
	    	return false;
	    }
	     var divheight = parseInt($("#ysbdsuzj").css("height")); 
		            $("#ysbdsuzj").css("height",divheight-35);
	 	 $('#doupload'+nowrow).remove();
	 	 $("#count").val(count-1);    
	 }

function addjhfpzlsw(){
	var jhfpzlcount = parseInt($("#jhfpzlcount").val());
	if(jhfpzlcount< 3){   	
	
		var jhfpzl="<div class='biaodan_li1' id='jhfpzl"+jhfpzlcount+"'>"                
					+"<div class='biaodan_ul1'>"                                  
					+"<div class='biaodan_lil1' style='width:39.8%'><input  name='tyfybgsjhfpqk["+jhfpzlcount+"].zl' /></div>"
					+"<div class='biaodan_lir1' style='width:30%'><input name='tyfybgsjhfpqk["+jhfpzlcount+"].hm' /></div>"
					+"<div class='biaodan_lil1' style='width:30%'><input type='text' name='tyfybgsjhfpqk["+jhfpzlcount+"].bs'/></div>"
					+"</div>"
					+"</div>";
					$("#jhfpzl0").before(jhfpzl);
					$("#jhfpzlcount").val(jhfpzlcount+1);
					}else{
						alert("只能添加"+jhfpzlcount+"行");
						return false;
					}
	
}


function deljhfpzlsw(){
	var jhfpzlcount = parseInt($("#jhfpzlcount").val());
	var nowrow = jhfpzlcount-1;
 if( nowrow <=0){
 	alert("至少有一行");
 	return false;
 }
	 $("#jhfpzl"+nowrow).remove();
		$("#jhfpzlcount").val(jhfpzlcount-1);
}   
function addlhfpzlsw(){
	var lhfpzlcount = parseInt($("#lhfpzlcount").val());
	if(lhfpzlcount< 3){   	
		var lhfpzl="<div class='biaodan_li1' id='lhfpzl"+lhfpzlcount+"'>"                
					+"<div class='biaodan_ul1'>"            
					+"<div class='biaodan_lil1' style='width:39.8%'><input  name='tyfybgslhfp["+lhfpzlcount+"].zl' /></div>"
					+"<div class='biaodan_lir1' style='width:30%'><input name='tyfybgslhfp["+lhfpzlcount+"].hm' /></div>"
					+"<div class='biaodan_lil1' style='width:30%'><input type='text' name='tyfybgslhfp["+lhfpzlcount+"].bs'/></div>"
					+"</div>"
					+"</div>";					
						$("#lhfpzl").before(lhfpzl);
						$("#lhfpzlcount").val(lhfpzlcount+1);
					}else{
						alert("只能添加"+lhfpzlcount+"行");
						return false;
					}
}


function dellhfpzlsw(){
	var lhfpzlcount = parseInt($("#lhfpzlcount").val());
	var nowrow = lhfpzlcount-1;
 if( nowrow <= 0){
 	alert("至少有一行");
 	return false;
 }
	 $("#lhfpzl"+nowrow).remove();
	 $("#lhfpzlcount").val(lhfpzlcount-1);
}   









 //退税申请书
var yjksflag ;
 var yjkscount = 0;  
 function addyjkssw(){
 	if(yjkscount< 11){   	 	
 				   var yjks="<div class='biaodan_ul1' id='yjks"+yjkscount+"'>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].sb'  /></div>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].pzzl' /></div>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].zb' /></div>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].hm'/></div>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].ssrq'/></div>"
							+"<div class='biaodan_lil1' style='width:120px'><input type='text' name='tssqsFbList["+yjkscount+"].tfrq'  /></div>"
							+"<div class='biaodan_lil1' style='width:100px'><input type='text' name='tssqsFbList["+yjkscount+"].se' /></div>"
							+"<div class='biaodan_lil1'><input type='text' name='tssqsFbList["+yjkscount+"].sqtse' /></div>"
							+"</div>";
 							$("#yjks").before(yjks);
 							yjkscount++;
 	}
 	
 }


function delyjkssw(){
	var nowrow = yjkscount-1;
  if( nowrow <= -1){
  	alert("至少有一行");
  	return false;
  }
	 $("#yjks"+nowrow).remove();
	yjkscount--;
}   


 
 
//发票缴销
 function addfpjxRow(){
  var fpjxfpcount=parseInt($("#count").val());
 	if(fpjxfpcount< 8){   	 	
 		var uploadht="<div class='biaodan_ul1' id='fpjxrow"+fpjxfpcount+"'>"
					+"<div class='biaodan_lil1' style='width:159px;'>"
					+"<label>"				      	
					+"<select id='fpjxdjbfb["+fpjxfpcount+"].fpmc' name='fpjxdjbfb["+fpjxfpcount+"].fpmc' cssClass='validate[required] text-input'><option>请选择</option><option value='发票名称'>发票名称</option> </select>"
					+"</label>"
					+"</div>"
					+"<div class='biaodan_lir1' style='width:160px;'><input class='validate[required] text-input' id='fpjxdjb["+fpjxfpcount+"].fpdm' type='text' name='fpjxdjbfb["+fpjxfpcount+"].fpdm' /></div>"
					+"<div class='biaodan_lil2' style='width:159px;'>"
					+"<label>"				      
					+"<select id='fpjxdjbfb["+fpjxfpcount+"].jxlb' name='fpjxdjbfb["+fpjxfpcount+"].jxlb' cssClass='validate[required] text-input'><option>请选择</option><option value='缴销类别'>缴销类别</option> </select>"
					+"</label>"
					+"</div>"
					+"<div class='biaodan_lir2' style='width:160px;'><input class='validate[required] text-input' id='fpjxdjbfb["+fpjxfpcount+"].xhfs' type='text' name='fpjxdjbfb["+fpjxfpcount+"].xhfs' /></div>"
					+"<div class='biaodan_lil2' style='width:159px;'><input class='validate[required] text-input' id='fpjxdjbfb["+fpjxfpcount+"].qshm' type='text' name='fpjxdjbfb["+fpjxfpcount+"].qshm' /></div>"
					+"<div class='biaodan_lir2' style='width:160px;'><input class='validate[required] text-input' id='fpjxdjbfb["+fpjxfpcount+"].zzhm' type='text' name='fpjxdjbfb["+fpjxfpcount+"].zzhm' /></div>"					
					+"</div>";
 					$("#fpjxrow"+(fpjxfpcount-1)).after(uploadht);
					$("#count").val(fpjxfpcount+1);
 	}else{
 		alert("只能添加"+8+"行!");
 		return false;
 	}
 }


function delfpjxRow(){
	var count=parseInt($("#count").val());
   //alert(count);
 	var nowrow = count-1;
   //alert(nowrow);
    if( nowrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#fpjxrow'+nowrow).remove();
 	$("#count").val(count-1);
}

//丢失增值税专用发票已报税证明单
 function adddszzszyfpybszmdRow(){
  
  var count=parseInt($("#count").val());
 	//alert(count);
 	if(count< 5){   	 	
 		var uploadht="<div class='biaodan_lir1' style='width:957px;' id='dszzszyfpybszmd"+count+"'>"+
			"<div style='width:130px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]' type='text' id='fpdm' name='dszzsfp["+count+"].fpdm' value='' /></div>"+
			"<div style='width:120px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]' type='text' id='fphm' name='dszzsfp["+count+"].fphm' value='' /></div>"+
			"<div style='width:225px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]'  type='text' id='hwmc' name='dszzsfp["+count+"].hwmc' value='' /></div>"+
			"<div style='width:130px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]'  type='text' id='dj' name='dszzsfp["+count+"].dj' value='' /></div>"+
			"<div style='width:120px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]'  type='text' id='sl' name='dszzsfp["+count+"].sl' value='' /></div>"+
			"<div style='width:105px; height:34px; border-right:#000000 solid 1px; float:left'><input class='validate[required]'  type='text' id='je' name='dszzsfp["+count+"].je' value='' /></div>"+
			"<div style='width:100px; height:34px;'><input class='validate[required]'  type='text' id='se' name='dszzsfp["+count+"].se' value='' /></div>"+
			"</div>";
		$("#dszzszyfpybszmd"+(count-1)).after(uploadht);
		$("#count").val(count+1);
 	}else{
 		alert("只能添加"+5+"行!");
 		return false;
 	}
 }


function deldszzszyfpybszmdRow(){
	var count=parseInt($("#count").val());
   //alert(count);
 	var nowrow = count-1;
   //alert(nowrow);
    if( nowrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#dszzszyfpybszmd'+nowrow).remove();
 	$("#count").val(count-1);
}

//退税申请书
 function addtssqsRow(){
  
  var count=parseInt($("#count").val());
 	//alert(count);
 	if(count< 5){   	 	
 		var uploadht="<div class='biaodan_li1' id='tssqs"+count+"'>"+
			"<div class='biaodan_ul1'>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='sb' type='text' name='tssqsFbList["+count+"].sb' value=''  /></div>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='bzzl' type='text' name='tssqsFbList["+count+"].pzzl' value='' /></div>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='zb' type='text' name='tssqsFbList["+count+"].zb' value='' /></div>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='hm' type='text' name='tssqsFbList["+count+"].hm' value='' /></div>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='ssrq' type='text' name='tssqsFbList["+count+"].ssrq' value='' /></div>"+
				"<div class='biaodan_lil1' style='width:120px'><input class='validate[required] text-input' id='tfrq' type='text' name='tssqsFbList["+count+"].tfrq' value='' /></div>"+
				"<div class='biaodan_lil1' style='width:100px'><input class='validate[required] text-input' id='se' type='text' name='tssqsFbList["+count+"].se' value='' /></div>"+
				"<div class='biaodan_lil1'><input class='validate[required] text-input' id='sqtse'  type='text' name='tssqsFbList["+count+"].sqtse' value='' /></div>"+
				"<input type='hidden' id='count' name='count' value='1'/>"+
			"</div>"+
		"</div>";
		$("#tssqs"+(count-1)).after(uploadht);
		$("#count").val(count+1);
 	}else{
 		alert("只能添加"+5+"行!");
 		return false;
 	}
 }


function deltssqsRow(){
	var count=parseInt($("#count").val());
   //alert(count);
 	var nowrow = count-1;
   //alert(nowrow);
    if( nowrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#tssqs'+nowrow).remove();
 	$("#count").val(count-1);
}

 //删除证件
function delfjlb()
{
var url="delfileupload.do";
var all=document.getElementsByName('zjids');

var id ="";
var bean = "EmployeeFjfb";
var j=0;
for(var i=0;i<all.length;i++)
{
	if(all[i].checked==true)
	{
		id+=all[i].value+",";
		j++;
	}
}
if(id == null || id == '' || id.length==0)
{
	alert("请选择要删除的证件！")
	return;
}
else if(confirm("你确定要将此证件删除吗?,删除后将不能恢复")== true)
{
	$.post(url,{id:id,bean:bean},
			function (data)
			{
				if(data==1){
					var allcheck=document.getElementsByName('zjids');
					for(var j=0;j<allcheck.length;j++)
					{
						if(allcheck[j].checked==true)
						{
							allcheck[j].parentNode.style.display="none";
						}
					}
					alert('删除成功！');
				}else if(data == 0)
				{
					alert("删除失败");
				}
				else {
					alert('出错了');
				}
			});
	
}

}

function openLayer(objId,conId,inmageurl){
	$("#img").attr("src",inmageurl);
	var arrayPageSize = getPageSize();//调用getPageSize()函数
	var arrayPageScroll = getPageScroll();//调用getPageScroll()函数
	if (!document.getElementById("popupAddr")){
	//创建弹出内容层
	var popupDiv = document.createElement("div");
	//给这个元素设置属性与样式
	popupDiv.setAttribute("id","popupAddr")
	popupDiv.style.position = "absolute";
	popupDiv.style.border = "1px solid #ccc";
	popupDiv.style.background = "#fff";
	popupDiv.style.zIndex = 99;
	//创建弹出背景层
	var bodyBack = document.createElement("div");
	bodyBack.setAttribute("id","bodybg")
	bodyBack.style.position = "absolute";
	bodyBack.style.width = "100%";
	bodyBack.style.height = (arrayPageSize[1] + 35 + 'px');
	bodyBack.style.zIndex = 98;
	bodyBack.style.top = 0;
	bodyBack.style.left = 0;
	bodyBack.style.filter = "alpha(opacity=50)";
	bodyBack.style.opacity = 0.5;
	bodyBack.style.background = "#ddf";
	
	//实现弹出(插入到目标元素之后)
	var mybody = document.getElementById(objId);
	insertAfter(popupDiv,mybody);//执行函数insertAfter()
	insertAfter(bodyBack,mybody);//执行函数insertAfter()
	}
	//显示背景层
	document.getElementById("bodybg").style.display = "";
	//显示内容层
	var popObj=document.getElementById("popupAddr")
	popObj.innerHTML = document.getElementById(conId).innerHTML;
	//alert(popObj.innerHTML );	//这里的层是组合的 清空属性是没有用的 还是会显示原来的内容
	popObj.style.display = "";
	//让弹出层在页面中垂直左右居中(统一)
	// popObj.style.width  = "600px";
	// popObj.style.height = "400px";
	// popObj.style.top  = arrayPageScroll[1] + (arrayPageSize[3] - 35 - 400) / 2 + 'px';
	// popObj.style.left = (arrayPageSize[0] - 20 - 600) / 2 + 'px';
	//让弹出层在页面中垂直左右居中(个性)
	var arrayConSize=getConSize(conId)
	popObj.style.top  = arrayPageScroll[1] + (arrayPageSize[3] - arrayConSize[1]) / 2-50 + 'px';
	popObj.style.left = (arrayPageSize[0] - arrayConSize[0]) / 2 -30 + 'px';
	}
	//获取内容层内容原始尺寸
	function getConSize(conId){
	var conObj=document.getElementById(conId)
	conObj.style.position = "absolute";
	conObj.style.left=-1000+"px";
	conObj.style.display="";
	var arrayConSize=[conObj.offsetWidth,conObj.offsetHeight]
	conObj.style.display="none";
	return arrayConSize;
	}
	function insertAfter(newElement,targetElement){//插入
	var parent = targetElement.parentNode;
	if(parent.lastChild == targetElement){
	parent.appendChild(newElement);
	}
	else{
	parent.insertBefore(newElement,targetElement.nextSibling);
	}
	}
	//获取滚动条的高度
	function getPageScroll(){
	var yScroll;
	if (self.pageYOffset) {
	yScroll = self.pageYOffset;
	} else if (document.documentElement  &&  document.documentElement.scrollTop){
	yScroll = document.documentElement.scrollTop;
	} else if (document.body) {
	yScroll = document.body.scrollTop;
	}
	arrayPageScroll = new Array('',yScroll)
	return arrayPageScroll;
	}
	//获取页面实际大小
	function getPageSize(){
	var xScroll,yScroll;
	if (window.innerHeight  &&  window.scrollMaxY){
	xScroll = document.body.scrollWidth;
	yScroll = window.innerHeight + window.scrollMaxY;
	} else if (document.body.scrollHeight > document.body.offsetHeight){
	sScroll = document.body.scrollWidth;
	yScroll = document.body.scrollHeight;
	} else {
	xScroll = document.body.offsetWidth;
	yScroll = document.body.offsetHeight;
	}
	var windowWidth,windowHeight;
	if (self.innerHeight) {
	windowWidth = self.innerWidth;
	windowHeight = self.innerHeight;
	} else if (document.documentElement  &&  document.documentElement.clientHeight) {
	windowWidth = document.documentElement.clientWidth;
	windowHeight = document.documentElement.clientHeight;
	} else if (document.body) {
	windowWidth = document.body.clientWidth;
	windowHeight = document.body.clientHeight;
	}
	var pageWidth,pageHeight
	if(yScroll < windowHeight){
	pageHeight = windowHeight;
	} else {
	pageHeight = yScroll;
	}
	if(xScroll < windowWidth) {
	pageWidth = windowWidth;
	} else {
	pageWidth = xScroll;
	}
	arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight)
	return arrayPageSize;
	}
	//关闭弹出层
	function closeLayer(){
		// 必须清空整个对象的内容 而不是属性
		var popObj=document.getElementById("popupAddr")
		popObj.innerHTML ="";
		//这里的层是组合的 清空属性是没有用的 还是会显示原来的内容
		document.getElementById("popupAddr").style.display = "none";
		document.getElementById("bodybg").style.display = "none";
		return false;
	}

	//对“拖动点”定义：onMousedown="StartDrag(this)" onMouseup="StopDrag(this)" onMousemove="Drag(this)"即可
	var move=false,oldcolor,_X,_Y;
	function StartDrag(obj){  //定义准备拖拽的函数
	obj.setCapture(); //对当前对象的鼠标动作进行跟踪
	oldcolor=obj.style.backgroundColor;
	obj.style.background="#999";
	move=true;
	//获取鼠标相对内容层坐标
	var parentwin=document.getElementById("popupAddr");
	_X=parentwin.offsetLeft-event.clientX
	_Y=parentwin.offsetTop-event.clientY
	}
	function Drag(obj){        //定义拖拽函数
	if(move){
	var parentwin=document.getElementById("popupAddr");
	parentwin.style.left=event.clientX+_X;
	parentwin.style.top=event.clientY+_Y;
	}
	}
	function StopDrag(obj){   //定义停止拖拽函数
	obj.style.background=oldcolor;
	obj.releaseCapture(); //停止对当前对象的鼠标跟踪
	move=false;
	}

	
// 家庭成员
function delfjjtcyids(){
	var allids =document.getElementsByName('fjjtcyids');
	var vids = "";	// 记录所有的IDS
	var j = 0;		// 方法内部全局变量 累积+了多少个
	for(var i=0;i<allids.length;i++){
		if(allids[i].checked==true){
			vids += allids[i].value+",";
			j++;
		}
	}
	vids = vids.substring(0,vids.length-1);
	if(vids.length==0||vids==null||vids==''){
		alert("请选择需要删除的成员");
		return;
	}else if( confirm("您确定要删除吗？删除后将不能恢复")){
		var vurl = "delFjjtcyidsemp.do";// 删除家庭成员附表的方法
		var bean = "UserRelation";// 实体类名
		$.post(vurl,{fjids:vids,bean:bean},
			function(data){
				if(data=='1'){
					alert("删除成功");
					// 跳转页面
				}else if(data=='3'){
					alert("您要删除的成员是空的，请用减行方式删除");
				}else if(data=='0'){
					alert("删除失败");
				}else{
					alert("删除出错");
				}
			});
	}
}
