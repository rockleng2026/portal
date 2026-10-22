<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
       <title>添加商品</title>
       <style type="text/css">
       .img{
           width: 100;
            height: 100px;
             border: solid 1px;
       }
       .ssh{
         display: none;
        
       }
       #checkYes{
           border:1px solid #ccc;
           display: none;
           width:200px;
       }
      .c1 td{
        width: 120px;
       }
      .c1 .c11{
        width: 220px;
       }
 	.iput_1{
 	 width: 60px;
 	 height: 13px;
 	 border-color: white;
 	
 	}
       </style>
      
       	<link href="<%=path %>/product_manage/css/addCommodity.css" type="text/css"
			media="screen" rel="stylesheet">
       	<link href="<%=path %>/product_manage/css/outproperty.css" type="text/css"
			media="screen" rel="stylesheet"> 
        <script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<link href="<%=path %>/Css/desk/mainWin.css" type="text/css" media="screen" rel="stylesheet">
		<script type="text/javascript" src="<%=path %>/js/util/ckbrowserutil.js"></script>	
		<script type="text/javascript">
		  var mm1=0;
		  var pms=0;
		  function uploadImage() {
	        var img1=$('#img1').val();
			var img2=$('#img2').val();
			var img3=$('#img3').val();
			var img4=$('#img4').val();
			var img5=$('#img5').val();	
			if(img1&&img2&&img3&&img4&&img5!=''){
			 alert("商品图片最多能上传5张 ");
			return ;
			}							  
		var files=$("#fileupload").val();
		if(files == null || files == "")
		{
		alert("请选择要上传的文件");
		
		return;
		}
	$(document)
			.ready(
					function() {
						var options = {
						    url : "pdm/uploadproductManager.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									$("#tipDiv").html(data[0]);
									var pathi=$('#pathi').val();
									var va=pathi+data[1];
								    if(img1==null||img1==''){
								   $('#imga1').attr('src',va);
								   $('#img1').attr('value',va);
								   	}else if(img2==null||img2==''){
								   	$('#imga2').attr('src',va);
								   $('#img2').attr('value',va);
								   	}else if(img3==null||img3==''){
								   	$('#imga3').attr('src',va);
								   $('#img3').attr('value',va);			    
								    }else if(img4==null||img4==''){
								   	$('#imga4').attr('src',va);
								   $('#img4').attr('value',va);			    
								    }else if(img5==null||img5==''){
								   	$('#imga5').attr('src',va);
								   $('#img5').attr('value',va);			    
								    }else{
								    alert("商品图片最多能上传5张 ");
								    return;
								    }
									$("#showpath").append("<input type='hidden' height='100' width='100' value='<%=path%>/"+data[1]+"'/>");
									$("#ico").attr("value",data[1])
								} else {
									$("#tipDiv").html(msg);
								}
							}
						};
						
						$("#formadds").ajaxSubmit(options);
						return false;
					});
                  }		
		</script>

	
		
<script type="text/javascript">
		function showDiv(divid){
		      if($("#"+divid).css("display")=="none"){
		        $("#"+divid).show();
		      	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow.gif");
		      }else{
		      	$("#"+divid).hide();
		      	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow2.gif");
		      }
        }
		function delectimg(id){
		  var img=$('#img'+id).val();
		  if(!img){
		    alert('您要删除的图片不存在,请先上传！');return;
		  }
		  $('#img'+id).attr('value',"");
		   $('#imga'+id).attr('src',"product_manage/img/noneimg.jpg"); 
		}
		
		function  f2(id,s){
		$('#inputvalue').html("");
		$('#selectvalue').html("");
		$('#radiovalue').html("");
		$('#checkboxvalue').html("");
		//alert("f2="+id);
		  var lastid=id.split("&");
		   var leng=lastid.length-1;
		    var idclass=lastid[leng];
		    //alert("leng="+leng+",idc="+idclass);
		    $('#goods_dictid').attr('value',idclass);
		   $.post("pdm/superIdproductManager.do", {'id':id,"flags1":s},function(data){
		        // alert("d="+data);
	    		if(data!=""){
	              $('#geids0').html('');
	   			  var values=data.split(" ");
	    		 for(var i=0;i<values.length;i++){
	       			var strs1=  values[i];
	      			var strs = strs1.split('&');
	         		if(strs!=""){
	           		for(var j=0;j<strs.length;j++){
	                 var id=strs[j];
	                 if(id!=""){
	                 	alert("showgoods"+id);
	                    showgoods(id);
	                 }
 	            }
	       }
	    }
	    }
	});

		}
		
		function showgoods(id){
		    var geids=  $('#geid'+id).val();
	              alert("geids"+geids);
	              var geid=geids.split('|'); 
	                 for(var i=0;i<geid.length;i++){
	                  var values=geid[i];  
<!--	                  //alert(id+"id " +i+ "i" +values+"values");-->
	                     if(values!=""){
	                      var v= values.split(';');
	                         if(v[0]==1){
	                             var bit=v[2];
	                             $('#geids0').append(
	                             "<tr class='c1'><td><span id='classname"+pms+"'>"+v[1]+"</span>:</td><td><input type='text' id='classproperty"+pms+"'  value='"+v[4]+"'></td>"+
	                           "<td><span id='classdiscrip"+pms+"'>"+bit+"</span></td></tr>"  );
	                           //updatevalue1(i,v[1],pms);
	                           pms++;
	                         } 
	                          if(v[0]==2){
	                          var bit=v[2];
	                          //alert("v[1]="+v[1]);
	                          //alert("id="+id);
	                          //alert("bit="+bit);
	                          //alert("v[4]="+v[4]);
	                             $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td><select id='select"+v[1]+""+id+"' onchange='showselect("+i+","+"\""+v[1]+"\""+",this.id)' ></select></td><td>"+bit+"<td/></tr>");
	                              var op= v[4].split('-');
	                                for(var k=0;k<op.length;k++){
	                                  if(op[k]!=''){
	                                      $("#select"+v[1]+id).append("<option value='"+op[k]+"'>"+op[k]+"</option>");
	                                  }
	                                }
	                                      showselect1(i,v[1],op[0]);
	                         } 
	                          if(v[0]==3){
	                           var bit=v[2];
	                             $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td class='c11' id=duoxuan"+v[1]+""+id+"></td><td>"+bit+"</td></tr>");
	                            //checkboxvalue(i,id,v[1]); 
	                          var duovalues=v[4];
	                             var duoxuan=duovalues.split("-");
	                           // alert("duovalues="+duovalues);
	                              for(var u=0;u<duoxuan.length;u++){
	                                  if(duoxuan[u]!=""){
	                                 //alert(duoxuan[u]+",,,,"+v[1]);
	                                 var tt = "<input type='checkbox' value='"+duoxuan[u]+"'  name='checkbx"+mm1+id+"'/>"+duoxuan[u];
	                                     //alert(tt);
	                                     $('#duoxuan'+v[1]+id).append(tt);
	                                 }
	                                  }
	                                  $('#duoxuan'+v[1]+id).append("<input type='text' id='hidn"+mm1+"' name='"+v[1]+"' value='"+id+"'>");
	                                    mm1++;
	                              }
	                          if(v[0]==4){
	                          var bit=v[2];
	                            
	                             $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td id=danxuan"+v[1]+""+id+"></td><td>"+bit+"</td></tr>");
	                             //alert("radios="+i+","+id+","+v[1]);
	                             radiovalue(i,id,v[1]);
	                             var danvalues=v[4];
	                             var danxuan=danvalues.split("-");
	                            for(var l=0;l<danxuan.length;l++){
	                               if(danxuan[l]!=""){
<!--	                                 //alert(danxuan[l]+"   "+v[1]);-->
	                                 if(l==0){
	                                 $('#danxuan'+v[1]+id).append("<input type='radio' value="+danxuan[l]+"  name='"+v[1]+""+id+"' checked='checked' />"+danxuan[l]);
	                                 }else{
	                                 $('#danxuan'+v[1]+id).append("<input type='radio' value="+danxuan[l]+"  name='"+v[1]+""+id+"' />"+danxuan[l]);
	                                 }
	                               }
	                            }
	                         }  
	                                    
	                  }
	              }
		}
		function showp(id,pm){
		   // alert("at="+id+","+pm);
			if(pm==2){
			       // alert("m="+$('#grade'+id+'>ul>li').length+","+$('#py'+id).html());
					if($('#grade'+id+'>ul>li').length>0){
						$('#py'+id).show();
				    	$('#xz_k100').html($('#py'+id).html());
						$('#py'+id).hide();
					    $('#xz_k100').show();
					}else{
					    $('#sdp'+id).hide();
					    $('#xz_k100').hide(); 
					    $('#xz_k101').hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
					 }
			}else if(pm==3){
			   if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
					    $('#xz_k101').hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			   }else{
			    $('#py'+id).show();
			    $('#xz_k101').html($('#py'+id).html());
				$('#py'+id).hide();
				$('#xz_k101').show();
			  }
			}else if(pm==4){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k102').hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			   }else{
			    $('#py'+id).show();
			    $('#xz_k102').html($('#py'+id).html());
				$('#py'+id).hide();
				$('#xz_k102').show();
				}
			}else if(pm==5){
			   if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k103').hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			    }else{
				    $('#py'+id).show();
				    $('#xz_k103').html($('#py'+id).html());
					$('#py'+id).hide();
					$('#xz_k103').show();
				}
			}else if(pm==6){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k104').hide();
			        	$('#xz_k105').hide();
			    }else{
			   		 $('#py'+id).show();
			   		 $('#xz_k104').html($('#py'+id).html());
					 $('#py'+id).hide();
				     $('#xz_k104').show();
				}
			}else if(pm==7){
			    if($('#grade'+id+'>ul>li').length==0){
				        $('#sdp'+id).hide();
			        	$('#xz_k105').hide();
			    }else{
				    $('#py'+id).show();
				    $('#xz_k105').html($('#py'+id).html());
					$('#py'+id).hide();
					$('#xz_k105').show();
				}
			}
			else{
				  
		    }
		}


</script>

<script type="text/javascript">
 function showselect1(j,id,values){
 $('#selectvalue').append(j+"|"+id+"|"+values+"&");
 }
 
  function showselect(j,id,valu){
  var v='';
  var values=$('#selectvalue').val();
  var valus=$('#'+valu).val();
   //alert("valusel..="+valus);
  var string;
  var str=values.split("&");
     for(var i=0;i<str.length;i++){
     if(str[i]!=""){
         string= str[i].split("|");
           if(string[0]==j && string[1]==id){
              selstr(i,j,id,valus);
           }
         }
     }
 }
 
 
 function selstr(k,j,id,valu){
   var ss='';
  var values=$('#selectvalue').val();
  var s=j+"|"+id+"|"+valu+"&";
  //alert("s...="+s);
  var str=values.split("&");
     for(var i=0;i<str.length;i++){
         if(str[i]!=""){
            if(str[i]!=str[k]){
           ss+=str[i]+"&";
           }else{
           ss+=s;
           }
         }
     }
     $('#selectvalue').html(ss); 
}


function radiovalue(i,id,name){
   $('#radiovalue').append(i+"|"+id+"|"+name+"&");
}
  
 function  radiov(){
  // alert("rad...");
     var st='';
     var values=$('#radiovalue').val();
     //alert(values);
      var str=values.split("&");
     for(var i=0;i<str.length;i++){
       if(str[i]!=""){
        var names= str[i].split("|");
          var va=$("input[name="+names[2]+""+names[1]+"]:checked").val();
          //alert("=radio="+va);
           st+=str[i]+"|"+va+"&";
       }
    
     }
     alert(st);
    $('#radiovalue').html(st);
   }
   
   function saveradio(va){
   var values=$('#radiovalue').val();
      var str=values.split("&");
        for(var i=0;i<str.length;i++){
        if(str[i]!=""){
     }
     }
   }



function checkboxvalue(i,id,name){
 $('#checkboxvalue').append(i+"|"+id+"|"+name+"&");
}

function checkboxv(){//////////////////////////////////////////////////////////////////////
 //$('#checkboxvalue').html('');
   var checkbox='';
   var values=$('#checkboxvalue').val();
   alert("410values="+values);
  // alert("values="+values);
     for(var i=0;i<50;i++){
        if(typeof($('#hidn'+i).val())!="undefined"){
            var ss='';
            var chkid=$('#hidn'+i).val();
            //alert("415chkid="+chkid);
            var pmt2=document.getElementById("hidn"+i).name;
             //alert("418chkid="+pmt2);
            //alert("valueck="+chkid);
            //alert("valueck1="+pmt2);
	    	//$($("input[name='duoxuan"+chkid+"'][checked]")).each(function(){ss+=this.value + ',';});
	    	//alert("i="+i);
	    	$($("input[name='checkbx"+i+chkid+"']:checked")).each(function(){
	    	     
	    	     ss+=this.value + ',';
	    	     //alert("name=checkbx"+i+chkid+" "+ss);
	    	});
	    	//checkbox+=pmt2+"|"+pmt2+"|"+pmt2+"|"+ss+"&";
	    	
	    	if($.trim(ss) == ''){
	    	checkbox+=i+"|"+pmt2+"|无&";
	    	}else{
	    	checkbox+=i+"|"+pmt2+"|"+ss+"&";
	    	}
	    	
	    }
    }
    //$('#checkboxvalue').append(checkbox);
    //alert("checkbox="+checkbox);
    $('#checkboxvalue').html(checkbox);
}

</script>


<script type="text/javascript">
//验证
 function checkgoods_dictid(){
   var values= $('#goods_dictid').val();
   if(values==""){
       $('#goods_dictidMsg').html('商品类别不能为空，请选择!');
       return false;
   }else{
        $('#goods_dictidMsg').html('商品类别已选');
        return true;
    }
 }

//商品名称
   function checksgname(){
    var values= $('#sgname').val();
     if(values==""){
     $('#sgnameMsg').html('商品名称不能为空!');
		return false;
     }else{
	     $('#sgnameMsg').html('填写正确');
	     return true;
     }
   }
   
// 商品规格  -->
   function checksgNorms(){
    var values= $('#sgNorms').val();
      if(values==""){
        $('#sgNormsMsg').html('商品规格不能为空!');
        return false;
      }else{
         $('#sgNormsMsg').html('填写正确');
          return true;
          }
   }
   
  // 商品单位  --> class='iput_1' 
   function checksgUnit(){
    var values= $('#sgUnit').val();
      if(values==""){
        $('#sgUnitMsg').html('商品单位不能为空!');
        return true;
      }else{
        $('#sgUnitMsg').html('填写正确');
        return true;
        }
   }
   
    //商品价格  -->
   function checksgPrice(){
    var values= $('#sgPrice').val();
      if(values==""){
        $('#sgPriceMsg').html('商品价格不能为空!');
        return false;
      }else{
         var num=/^[0-9]+(.[0-9]{1,3})?$/;
         if(num.test(values)){   
            $('#sgPriceMsg').html('填写正确');
            return true;
         }else{
            $('#sgPriceMsg').html('填写数字');
            return false;
         }
            
      }
   }
   
//  商品详情-->
    function checkspxq(v){
    var flag4=false;
      if(v==""){
        $('#spxqMsg').html('商品x详情不能为空!');
           flag4=false;
      }else{
    	 $('#spxqMsg').html('填写正确');
    	 flag4=true;
    	 }
    	 return flag4;
   }
   
// 商品图片  -->
   function checkimg(){
    var img1= $('#img1').val();
     var img2= $('#img2').val();
      var img3= $('#img3').val();
       var img4= $('#img4').val();
        var img5= $('#img5').val();
      if(img1!='' || img2!='' || img3!='' || img4!='' || img5!=''){
           $('#imgMsg').html('填写正确');
           return true;
      }else{
        //alert(99999999999999);
        $('#imgMsg').html('图片至少上传一张!'); 
        return false;
        }
   }
   
   function checksgNumber(){
      if($('#sgnumbers').val()!=""){
         var num=/^[0-9]*$/;
         if(num.test($('#sgnumbers').val())){   
              $('#sgNumberMsg').html('填写正确');
               return true;
         }else{
              $('#sgNumberMsg').html('填写数字');
              return false;
         }
         
      }else{
         $('#sgNumberMsg').html('此项不能为空');
      }
       return false;
   }
   $(function(){
      $("#butnform").click(function(){
    	  getValue();
      var detail1=$('#sgDetails').val();
      //alert(checkimg()+","+ checksgPrice() +","+ checksgUnit()+","+ checksgNorms() +","+ checksgname() +","+ checkgoods_dictid() +","+ checkspxq(detail1) +","+ checksgNumber());
     if(checkimg()&& checksgPrice() && checksgUnit()&& checksgNorms() && checksgname() && checkgoods_dictid() && checkspxq(detail1) && checksgNumber()){
            radiov(); 
            checkboxv();
            var mtt12='';
            for(var i=0;i<pms;i++){  //pms++;
               mtt12+=i+"|"+$('#classname'+i).html()+"|"+$("#classproperty"+i).val()+"&";
            }
            alert(mtt12);
            $('#inputvalue').html(mtt12);
            //alert("tc="+$('#inputvalue').html());
            $('#formadds').attr("action","pdm/addproductManager.do");
            $('#formadds').attr("target","");
            alert($("#checkboxvalue").val());
            document.forms["formadds"].submit();
     }else{
         //alert(flag1+","+flag2+","+flag3+","+flag4);
         alert("请完善资料");
     }

      });
   
   });
   $(function(){
      $('input:radio').click(function(){
         if($('input:radio[name="sgchecks"]:checked').val()==1){
               $('#checkYes').show(500);
         }
           if($('input:radio[name="sgchecks"]:checked').val()==0){
               $('#checkYes').hide(200);
         }
      });
   });
   	function selctClass(){
	 // var cont=encodeURI($('#textfield2').val(),"utf-8");
	  var cont=$('#textfield2').val();
	  //alert(cont);/
	  if(cont=='' || cont=='请输入查询内容'){
	  $('#mains').show();
	  $('#mains1').hide();
	  }else{//=""
	  $('#mains').hide();
	  $('#mains1').show();
	  $('#selname').val(cont);
	  $('#formadds').attr("target","framain");
	  $('#formadds').attr("action","pdm/classSelectproductManager.do");
	  document.forms["formadds"].submit();
	  }
	}
    function showorhide(){
	    $('#mains').show();
	    $('#mains1').hide();
	}
</script>
  <script type="text/javascript">
        	var chk_value =[];    //计算周期的checkbox的值
        	function jqchk(){  //jquery获取复选框值    
        	  chk_value=[];
          	$('input[name="textck"]:checked').each(function(){    
        	  chk_value.push($(this).val());    
        	
        	  });    
        	  //alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value);  
        	  
        	addlist();
        	}   
        	var xv_value=[];	//线路的checkbox的值
            function jqchxl(){
            	xv_value=[];
				$('input[name="textck1"]:checked').each(function(){    
					xv_value.push($(this).val());    
	        	  
	        	  }); 				
				
					addlist();	
                }

           function addlist(){//addlist增加list
        	  	 var chk=chk_value.length;//周期数组的长度
          		 var  xv=xv_value.length;//线路的长度
          	     var  allnum=chk*xv;
          	   //$("#tablist").empty();//清空表数据重新加
				$("#tablist").find("tr").each(function(){//4564
					
				var aa=$(this).attr('id');
				
				
					for(var i=0;i<chk;i++){
						var stat=chk_value[i];//开头
						  if(xv==0){
								
							 var objtr=stat+"_";
							 if(objtr==aa){
							
									return;
							 // $("#tablist").append("<tr id="+stat+"_' ><td width='15%' align='right'>"+chk_value[i]+"</td><td align='right' width='15%'>"+" "+"</td><td><input tyep='text' id=rq"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=xl"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=bz"+stat+"_  class='fa_inputs'  /></td></tr>");  
							 }
							 else{
								
								 }
							  }
						
						for(var j=0;j<xv;j++){
							  var end=xv_value[j];//结尾
										
							  var objtr1=stat+"_"+end;
						
						
							 //alert(
								 if(objtr1==aa){
							 
								  return;
								  //$("#tablist").append("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+chk_value[i]+"</td><td width='15%' align='right'>"+xv_value[j]+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  			
								 }else{
												
									// $(this).hide();
									 }

							}					


					}
					  $(this).remove();
					
				});
				for(var i=0;i<chk;i++){
						var stat=chk_value[i];//开头
						  if(xv==0){
							 var objtr=$("#"+stat+"_");
						
							 if(objtr.length>0){
							 }
							 else{
							
							  $("#tablist").append("<tr id="+stat+"_' ><td width='15%' align='right'>"+chk_value[i]+"</td><td align='right' width='15%'>"+" "+"</td><td><input tyep='text' id=rq"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=xl"+stat+"_  class='fa_inputs'  /></td><td><input tyep='text' id=bz"+stat+"_  class='fa_inputs'  /></td></tr>");  
							

								 }
							  }
						for(var j=0;j<xv;j++){
							  var end=xv_value[j];//结尾
										
							  var objtr1=$("#"+stat+"_"+end);
							  alert(objtr1);
								 if(objtr1.length>0){
								 }else{
							
								  $("#tablist").append("<tr id="+stat+"_"+end+"><td width='15%' align='right'>"+chk_value[i]+"</td><td width='15%' align='right'>"+xv_value[j]+"</td><td><input tyep='text' id=rq"+stat+"_"+end+" class='fa_inputs' /></td><td><input id=xl"+stat+"_"+end+" tyep='text'   class='fa_inputs' /></td><td><input tyep='text' id=bz"+stat+"_"+end+"  class='fa_inputs'  /></td></tr>");  			
								
												

									 }

							}					


					}
          	     
          	  
               }
           var newstr="";
        function getValue(){
       	 var chk=chk_value.length;//周期数组的长度
  		 var  xv=xv_value.length;//线路的长度	
  		
			if(chk>0){
				for(var i=0;i<chk;i++){
						if(xv==0){

							   if($("#rq"+chk_value[i]+"_").val()=="" || $("#xl"+chk_value[i]+"_").val()=="" || $("#bz"+chk_value[i]+"_").val()==""){
									alert("数量价格备注不能为空");
									newstr="";
									return;

							     }
							   if(isNaN($("#rq"+chk_value[i]+"_").val()) || isNaN($("#xl"+chk_value[i]+"_").val())){
									alert("数量价格备注不能为空");
									newstr="";
									return;

							     }
							newstr+=chk_value[i]+","+","+$("#rq"+chk_value[i]+"_").val()+","+$("#xl"+chk_value[i]+"_").val()+","+$("#bz"+chk_value[i]+"_").val()+","+chk_value[i]+"_"+"|";
						  
							}
							else{
								for(var j=0;j<xv;j++)
								{	
									
									   if($("#rq"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#xl"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#bz"+chk_value[i]+"_"+xv_value[j]).val()==""){
											alert("数量价格备注不能为空");
											newstr="";
											return;

									     }	
									if(isNaN($("#rq"+chk_value[i]+"_"+xv_value[j]).val()) || isNaN($("#xl"+chk_value[i]+"_"+xv_value[j]).val()) ){
										alert("数量价格必须为数字类型");
										newstr="";
										return;

								     }			
								newstr+=chk_value[i]+","+xv_value[j]+","+$("#rq"+chk_value[i]+"_"+xv_value[j]).val()+","
								+$("#xl"+chk_value[i]+"_"+xv_value[j]).val()+","+$("#bz"+chk_value[i]+"_"+xv_value[j]).val()+","+chk_value[i]+"_"+xv_value[j]+"|";
							
								}
							}
		
					}
				$("#productgevalue").val(newstr);
				
				}else{
					return;
					}
            }
        </script>
              
		
  </head>
  
  <body>
   <div class="fa_wrt fa_width fa_top"><span></span>发布商品</div>
  <input id="pathi"  style="margin-bottom: 20px;  " type="hidden" value="<%=path%>">
   <form method="post" id="formadds" name="formadds" >
  <div  class="fa_width fa_body" >
  
   </div>
  <table width="90%" cellpadding= "5" cellspacing="5" style="margin-left: 70" border="2" >
         
    
       <tr>
         <td width="10%" class="c1" style="width: 100px;"><dt>商品编码：</dt></td>
         <td><input id="sgcode" class="fa_input"  name="sgcode" value="${spNum}"  readonly="readonly"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="upMsg"></FONT></td>
       </tr>
        <tr>
        <td width="101">商品类目：</td>
       
            <td>
                     <input type="hidden" name="sa.selname" id="selname">
						<input type="hidden" id="goods_dictid" name="goods_dictid"
									value="${sa.goods_dict.gdId}">
								
						   <div >
						       <input type="text" class="fa_input"   id="textfield2" size="30" value="请输入查询内容" onFocus="if(this.value=='请输入查询内容')this.value=''" onBlur="if(this.value=='')this.value='请输入查询内容'" onkeyup="if(event.keyCode==13)document.getElementById('buton1').focus();"/>
						       <input type="button" class="fa_buttom" value="查询" id="buton1" onclick="selctClass()">
						
						   <em><font color="red">*注：单击是显示下一级，双击是显示类目属性。</font></em>   </div>
						   <div id="mains"  >
								<div id="mains2">
								<div class="bd_bj">

								<table border="0" cellspacing="0" cellpadding="0" id="tb_hg">
								  <tr> 
								    <td>
									<div id="xz_k">
									  <ul  >
								         <c:forEach items="${goods_dict}" var="goods">
									     <c:if test="${goods.gdSuperId==null}">
								         <li >
									    <a href="javascript:;" id="${goods.gdId}" 
										onclick="showp(this.name,2)" name="${goods.gdId}"  ondblclick="f2(this.name,1)"/>${goods.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods.gdId}">>></span></a>
										</li><!-- 111 -->
										<!-- 2222 -->
										<div id="py${goods.gdId}" style="display:none;">
									
									   <div id="grade${goods.gdId}">
									    <ul >
									  	<c:forEach items="${goods_dict}" var="goods2">
                                            <c:if test="${goods2.gdSuperId==goods.gdId}">
                                              <li>
                                              <a href="javascript:;" id="${goods2.gdId}"
																onclick="showp(this.id,3)"
																name="${goods.gdId}&${goods2.gdId}"  ondblclick="f2(this.name,1)">${goods2.gdnames}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods2.gdId}">>></span></a>
											  </li><!-- 222 -->
											  	<!-- 333 -->
												<div id="py${goods2.gdId}" style="display:none;">
											   <div id="grade${goods2.gdId}">
											   <ul >
											  <c:forEach items="${goods_dict}" var="goods3">
												<c:if test="${goods3.gdSuperId==goods2.gdId}">
		                                              <li>
		                                              <a href="javascript:;" id="${goods3.gdId}"
													  onclick="showp(this.id,4)"  name="${goods.gdId}&${goods2.gdId}&${goods3.gdId}" ondblclick="f2(this.name,1)">
													  ${goods3.gdnames}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods3.gdId}">>></span></a>
													  </li><!-- 333 -->
													  <!-- 44444444 -->
													 <div id="py${goods3.gdId}" style="display:none;">
													   <div id="grade${goods3.gdId}">
													   <ul >
													  <c:forEach items="${goods_dict}" var="goods4">
														<c:if test="${goods4.gdSuperId==goods3.gdId}">
				                                              <li>
				                                              <a href="javascript:;" id="${goods4.gdId}"
															  onclick="showp(this.id,5)"  name="${goods.gdId}&${goods2.gdId}&${goods3.gdId}&${goods4.gdId}" ondblclick="f2(this.name,1)">
															  ${goods4.gdnames}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods4.gdId}">>></span></a>
															  </li><!-- 333 -->
															   <!-- 5555555 -->
																 <div id="py${goods4.gdId}" style="display:none;">
																   <div id="grade${goods4.gdId}">
																   <ul >
																  <c:forEach items="${goods_dict}" var="goods5">
																	<c:if test="${goods5.gdSuperId==goods4.gdId}">
							                                              <li>
							                                              <a href="javascript:;" id="${goods5.gdId}" onclick="showp(this.id,6)"
																		  name="${goods.gdId}&${goods2.gdId}&${goods3.gdId}&${goods4.gdId}&${goods5.gdId}" ondblclick="f2(this.name,1)">
																		  ${goods5.gdnames}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods5.gdId}">>></span></a>
																		  </li>
															<!-- 66666-->
																 <div id="py${goods5.gdId}" style="display:none;">
																   <div id="grade${goods5.gdId}">
																   <ul >
																  <c:forEach items="${goods_dict}" var="goods6">
																	<c:if test="${goods6.gdSuperId==goods5.gdId}">
							                                              <li>
							                                              <a href="javascript:;" id="${goods6.gdId}"
																		  name="${goods.gdId}&${goods2.gdId}&${goods3.gdId}&${goods4.gdId}&${goods5.gdId}&${goods6.gdId}" ondblclick="f2(this.name,1)">
																		  ${goods6.gdnames}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods6.gdId}">>></span></a>
																		  </li>
							                                         </c:if>
							                                         </c:forEach>
																  </ul>
																   </div>
																</div>
											                <!-- 66666 -->
							                                         </c:if>
							                                         </c:forEach>
																  </ul>
																   </div>
																</div>
											<!-- 55555 -->
				                                         </c:if>
				                                         </c:forEach>
													  </ul>
													   </div>
													</div>
											<!-- 44444444 -->
		                                         </c:if>
		                                         </c:forEach>
											  </ul>
											   </div>
											</div>
											<!-- 333 -->
                                         </c:if>
                                         </c:forEach>
									  </ul>
									   </div>
									</div>
									<!-- 2222 -->
										</c:if>
								        </c:forEach>
									  </ul>
									</div>
								 </td>
								 <td>
								     <div id="xz_k100"  style="display:none">
								     </div>
								 </td>
								 <td>
								      <div id="xz_k101"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k102"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k103"  style="display:none">
								     </div>
								 </td>
								 <td>
								     <div id="xz_k104"  style="display:none">
								     </div>
								 </td>
								  <td>
								     <div id="xz_k105"  style="display:none">
								     </div>
								</td>
							</tr>
							</table>
							</div>
							</div>
							</div>
							<!-- load selt  -->
							<div id="mains1" style="display:none;background-color:#f4f9fd;">
							  <iframe src="product_manage/page/loadselt.jsp" name="framain" id="framain" width="830" height="350" frameborder="0" style="background-color:#f4f9fd;"></iframe>
							</div>
                <FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="goods_dictidMsg"></FONT>
             </td>
       </tr>
        <tr>
         <td>商品名称：</td>
         <td><input id="sgname" class="fa_input" name="sgname" onblur="checksgname();" value="${sa.sgname}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgnameMsg"></FONT></td>
       </tr>
        <tr>
         <td>商品规格：</td>
         <td><input id="sgNorms"  class="fa_input" name="sgNorms" onblur="checksgNorms();"  value="${sa.sgNorms}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgNormsMsg"></FONT></td>
       </tr>
        <tr>
         <td>商品单位：</td>
         <td><input id="sgUnit" class="fa_input" name="sgUnit" onblur="checksgUnit();" value="${sa.sgUnit}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgUnitMsg"></FONT></td>
       </tr>
       <tr>
         <td>商品价格：</td>
         <td><input id="sgPrice" class="fa_input" name="sgPrice" onblur="checksgPrice();" value="${sa.sgPrice}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgPriceMsg"></FONT></td>
       </tr>
       <tr>
          <td>商品数量:</td>
          <td><input id="sgnumbers" class="fa_input" name="sgnumbers" onblur="checksgNumber();" value="${sa.sgnumbers}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgNumberMsg"></FONT></td>
       </tr>
        <tr>
         <td>录入人：</td>
         <td><input id="sgUsername" class="fa_input" name="sgUsername" readonly="readonly" value="${loginname}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="upMsg"></FONT></td>
       </tr>
        <tr>
         <td>商品状态：</td>
            <td>
                <select style="width: 154" id="sgStat" name="sgStat">
               <option value="0"  <c:if test="${sa.sgStat==0}">selected="selected" </c:if> >仓库中商品</option>
               <option value="2"  <c:if test="${sa.sgStat==1}">selected="selected" </c:if> >发布待审核</option>
                </select><FONT color=#ff0000></FONT> <FONT color=#ff0000 id="upMsg"></FONT>
            </td>
       </tr>
       <tr>
           <td>生成上架单:</td>
           <td>
              <div id="checkUps">
              <input type="radio" name="sgchecks" id="sgchecks" value="1"/>是&nbsp;&nbsp;&nbsp;
              <input type="radio" name="sgchecks" id="sgchecks" value="0" checked/>否
              </div>
              <div id="checkYes">
              	<input type="radio" name="sgchecks1" id="sgchecks1" value="1"/>托管&nbsp;&nbsp;&nbsp;
              	<input type="radio" name="sgchecks1" id="sgchecks1" value="2" checked/>租用
              </div>
           </td>
       </tr>
          <tr>
         <td>创建时间：</td>
           <td>
           <% Date date= new Date();
             SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               String str=sdf.format(date);
            %>
               <INPUT  style="WIDTH: 150px" class="fa_input" id="sgtime" name="sgtime" value="<%=str %>" readonly="readonly">
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="upMsg"></FONT>
           </td>
       </tr>  
       
<!--       -->
<!--       <tr>-->
<!--        <td>发布时间：</td>-->
<!--              -->
<!--              <td>-->
<!--              <INPUT  style="WIDTH: 150px" id="sgPuttime" name="sgPuttime" -->
<!--												onclick="WdatePicker({minDate:'#F{$dp.$D(\'sgtime\')||\'2000-10-01\'}'})">-->
<!--												<FONT color=#ff0000>*</FONT>点击输入框获取时间<FONT color=#ff0000 id="downMsg"></FONT>-->
<!--              </td>-->
<!--       -->
<!--       </tr>-->
       
<!--       -->
       
           <tr>
       <td colspan="2">
<!--       style="overflow:hidden; height:18px; width:60px;opacity:0; filter:alpha(Opacity=0);"-->
      图片上传： &nbsp;&nbsp;   &nbsp;&nbsp;<input id="fileupload" name="fileupload"  type="file"  />
						<input type="button" 
							onclick="uploadImage()" class="fa_input" value="上传"/><input id="ico" name="ico" class="fa_buttom" type="hidden">
							<div id="tipDiv">
							</div><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="imgMsg"></FONT>
       </td>
       </tr>
       
       
        <tr>
         <td>商品图片:</td>
            <td>
            <div style="border: 1px solid; width: 750px; height: 200px;">
            <div id="showpath">
            </div>
 <table width="94" height="66"><tr><td>
   <div style="height: 35">
     
   
   </div>
 
  <table style="text-align: center;">
    <tr>
      <td>&nbsp;&nbsp;&nbsp;<img  alt="图片规格" src="product_manage/img/imggg.jpg" style="width: 120;height: 120; border: 1px solid;"></td>
        <td>&nbsp;&nbsp;&nbsp;<img id="imga1"  alt="商品图片" src="product_manage/img/noneimg.jpg" class="img"></td>
       <td>&nbsp;&nbsp;&nbsp;<img id="imga2"  alt="商品图片" src="product_manage/img/noneimg.jpg" class="img"> </td>
         <td>&nbsp;&nbsp;&nbsp;<img id="imga3"  alt="商品图片" src="product_manage/img/noneimg.jpg" class="img"></td> 
         <td>&nbsp;&nbsp;&nbsp;<img id="imga4"  alt="商品图片" src="product_manage/img/noneimg.jpg" class="img"></td>
          <td>&nbsp;&nbsp;&nbsp;<img id="imga5"  alt="商品图片" src="product_manage/img/noneimg.jpg" class="img"> </td>
    </tr>
    <tr>
    <td>图片规格</td>
      <td>&nbsp;&nbsp;&nbsp;<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(1)"/></td>
      <td>&nbsp;&nbsp;&nbsp;<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(2)"/></td>
      <td>&nbsp;&nbsp;&nbsp;<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(3)"/></td>
      <td>&nbsp;&nbsp;&nbsp;<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(4)"/></td>
      <td>&nbsp;&nbsp;&nbsp;<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(5)"/></td>
    </tr>
  </table>
   <input  type="hidden" id="img1" name="img1" value="">
   <input  type="hidden" id="img2" name="img2" value="">
   <input  type="hidden" id="img3" name="img3" value="">
   <input  type="hidden" id="img4" name="img4" value="">
   <input  type="hidden" id="img5" name="img5" value="">
 </td></tr></table>
            </div>
            </td>
       </tr>
   <!--  
   <tr>
   <td>宝贝视频:</td>
   <td> 
     <div style="width: 180px; height: 100px; border: solid 1px; text-align: center;">
      <img alt="" src="product_manage/img/nonesp.jpg">
     </div>
     <input type="button" value="选择视频">
   </td>
   
   </tr>
    -->   
       
        <tr>
         <td>商品详情：</td>
             <td>

               <div id="spxq" style="width: 800; height: 150px; border: solid 1px; color: 7d7d7d;">
                 	<textarea class="input_texta" rows="12" cols="90" onclick="this.innerHTML=''"  onblur="if(this.innerHTML=='')this.innerHTML='请此处输入内容'" id="sgDetails" name="sgDetails"  style="text-align:left;">
				                请此处输入内容                    
				    </textarea>
               </div><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="spxqMsg"></FONT>
            </td>
       </tr>
       
      <tr>
         <td>商品特殊属性：</td>
   
             <td>
              <div id="" class="fa_zong" style="width:800; height:300;  border: solid 1px; color: 7d7d7d;">
                <div id="geids01">
                   <table id="geids0" style="margin-left: 100px;"  width="500px;">
                   
                   </table>
                </div>
                
                 <c:forEach items="${goods_class_expand}" var="goodsclass">
                 <input id="geid${goodsclass.geId}" type="hidden"  onclick='showvalue(this.value)';
                 value="${goodsclass.geTemp1}|${goodsclass.geTemp2}|${goodsclass.geTemp3}|${goodsclass.geTemp4}|${goodsclass.geTemp5}|${goodsclass.geTemp6}|${goodsclass.geTemp7}|${goodsclass.geTemp8}|${goodsclass.geTemp9}|${goodsclass.geTemp10}|${goodsclass.geTemp11}|${goodsclass.geTemp12}|${goodsclass.geTemp13}|${goodsclass.geTemp14}|${goodsclass.geTemp15}"/>
                <br />
                </c:forEach>
              
               </div>

              
            </td>
       </tr>
		<tr>
         <td>商品规格：</td>
             <td>
              <div id="" class="fa_zong" style="width: 800; height: 100px; border: solid 1px; color: 7d7d7d;">
                <div id="geids01" class="fa_zong" >
                   <table id="ggids0" style="margin-left: 100px;"  width="500px;">
                   <tr><td>计费周期</td><td><label><input name="textck" type="checkbox" value="月付" onchange="jqchk()"/>月付</label><label><input type="checkbox" value="季付" onclick="jqchk()" name="textck"/>季付</label><label><input type="checkbox" value="半年付" onclick="jqchk()" name="textck"/>半年付</label></td>                   </tr>
                   <tr><td>线路</td><td><label><input type="checkbox" name="textck1" value="电信" onchange="jqchxl()"/>电信</label><label><input type="checkbox" name="textck1" value="联通" onchange="jqchxl()"/>联通</label><label><input type="checkbox" value="移动" name="textck1" onchange="jqchxl()"/>移动</label></td>                   </tr>
                   </table>
                </div>
                
                 
              
               </div>

              
            </td>
       </tr>
       <tr>
         <td>商品规则：</td>
             <td>
              <div id="" class="fa_zong" style="width: 800;  border: solid 1px; color: 7d7d7d;">
                <div id="geids01">
                   <table id="ggids0"  width="100%" class="fa_table" border="1">
              <tr>    <thead>
        <th width="15%">计费周期</th><th  width="15%">线路</th><th width="15%">价格</th><th width="15%">数量</th><th width="40%">备注</th>
        </thead>
                   		<table id="tablist"  style="margin-left: 10px;"  width="100%" border="1">
                   		
                   		
                   		</table>
                  
                   </tr>
                   </table>
                </div>
                
      
               </div>

              
            </td>
       </tr>
         
         
     </table>
       <div class="fa_footer fa_width">

      
     <input type="button" value="确定" class="fa_buttoms" id="butnform" style="margin-right:20px;" /> <input type="button" onclick="getValue()" value="试取值" class="fa_buttoms" />
   </div>
     <input type="hidden" name="sgid" value="${sa.sgId}">
     </div>  
    
   <div style="display:block; ">
   <textarea  id="inputvalue" name="inputvalue" style="height: 50; width: 600px; ">
   </textarea>
    <textarea id="selectvalue" name="selectvalue" style="height: 50; width: 600px; ">
   </textarea>
    <textarea id="radiovalue" name="radiovalue" style="height: 50; width: 600px; ">
   </textarea>
    <textarea id="checkboxvalue" name="checkboxvalue" style="height: 50; width: 600px;">
   </textarea>
     <textarea id="productgevalue" name="productgevalue" style="height: 50; width: 600px;">
   </textarea>
   </div>
   </form>
   
  </body>
</html>
