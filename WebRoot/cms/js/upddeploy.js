 function checkForm(){
	
	if($('#errorName').val()=="" && $('#pname').val()!="" && $('#engname').val()!="" && $('#pnum').val()!=""){
		
	if($('#strname').val()=="reups"){
		//alert("2222");
		document.getElementById("forms").action="cms/addOrUpdateRec_part.do?pams=upd";
		document.getElementById("forms").submit();
	}else{
		document.getElementById("forms").action="cms/addOrUpdateRec_part.do?pams=add";
		document.getElementById("forms").submit();
	}
	
	}else{
	  $.messager.alert('提示','请把信息填写完整','info');	
	}
	
}

$(function(){
	 var num=/^\d*$/;
	 var engs=/^[A-Za-z]+$/;
     $('#pname').blur(function(){
 	  if($('#pname').val()==""){
 		  $('#ers1').html('此项不能为空');
 		 $('#errorName').val("error");
 	  }else{
 		 $('#ers1').html('');
		 $('#errorName').val(""); 
 	  }
 	  });
     $('#engname').blur(function(){
      if($('#engname').val()==""){
 		  $('#ers2').html('此项不能为空');
 		 $('#errorName').val("error");
 	  }else{
 		 $('#errorName').val("");
 		 if(!engs.test($('#engname').val())){
 			 $('#ers2').html('请输入英文字母');
 	 		 $('#errorName').val("error"); 
 		 }else{
 			 $('#ers2').html('');
 			 $('#errorName').val(""); 
 		 }
 	  }
      });
     $('#mid').blur(function(){
      if($('#mid').val()==""){
 		  $('#ers3').html('此项不能为空');
 		 $('#errorName').val("error");
 	  }else{
 		 $('#errorName').val("");
 		 if(!num.test($('#mid').val()) || $('#mid').val()>5){
 			 $('#ers3').html('请输入数字且数字小于6');
 	 		$('#errorName').val("error");
 		 }else{
 			 $('#ers3').html('');
 			 $('#errorName').val("");  
 		 }
 	  }
     });
      $('#pnum').blur(function(){
      if($('#pnum').val()==""){
 		 $('#ers5').html('此项不能为空');
 		$('#errorName').val("error");
 	  }else{
 		 $('#errorName').val("");
 		 if(!num.test($('#pnum').val())){
 			 $('#ers5').html('请输入数字');
 	 		$('#errorName').val("error");
 		 }else{
 			 $('#ers5').html('');
 			 $('#errorName').val("");  
 		 }
 	  }
 	  });
      $('#typeid').click(function(){
    	
    	  if(document.getElementById("typeid").options.length==1){
 			 $.ajax({
 				  type: "POST",
 				  url: "cms/loadRec_part.do",
 				  data:"",
 				  success: function(data){
 				    $('#typeid').append(data.allval);
 			       }
 				 });
 			}
 		});
    
      });

