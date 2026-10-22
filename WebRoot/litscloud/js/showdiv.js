$(document).ready(function(){ 
	$(".c1").click(function(){
	var val=$(this).text();//

	 $(".c1").each(function(){
	  var val1=$(this).text();
	  
	  if(val1==val){//(); :;
		
		  $(this).css("background-image","url(litscloud/images/ly_106.jpg)");
	 
	  }else{
	    $(this).css("background-image","");
	  }
	  
	  });
	  
	});
});



var divlist=["d1","d2","d3","d4","d5","d6","d7"];
function changediv(a){

 for(var i=0;i<divlist.length;i++){
	  
           if(divlist[i]==a){
            
					$("#"+divlist[i]).show();					
					
               }else{

            		$("#"+divlist[i]).hide();
                   }
     

	 }
	

	
}

function shopdiv(sgcode){//gen
  sgcode1='SP-2013020200010';
   var  url="litscloud/litscloudgetprodutCustomerServerC.Action?sgcode="+sgcode1+"&tt="+(new Date()).getTime();
    
    	 $("#jgc").show();	
    	 $("#jgc").load(url);

    	 
}
function colsediv(){

	 $("#jgc").hide();	


	
}
function spxq(sgcode){
	
	sgcode1='SP-2013020200010';
	location.href="<%=path %>/litscloud/web/litscloudgetprodutCustomerServerC.Action?page=page&sgcode="+sgcode1+"&tt="+(new Date()).getTime();
	    




	
}