<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>修改商品</title>
		<style type="text/css">
.img {
	width: 100;
	height: 100px;
	border: solid 1px;
}

.ssh {
	display: none;
}

.c1 td {
	width: 120px;
}
 #checkYes{
           border:1px solid #ccc;
           display: none;
           width:200px;
 }
.c1 .c11 {
	width: 220px;
}

</style>
	<link href="<%=path %>/product_manage/css/addCommodity.css" type="text/css"
			media="screen" rel="stylesheet">
        <meta http-equiv="cache-control" content="no-store, must-revalidate"/>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<link href="<%=path %>/Css/desk/mainWin.css" type="text/css"
			media="screen" rel="stylesheet">
		<link href="<%=path %>/product_manage/css/outproperty.css" type="text/css"
			media="screen" rel="stylesheet">
		<script type="text/javascript"
			src="<%=path %>/js/util/ckbrowserutil.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script>
		 var mm1=0;
		 var mm2=0;
		 var ss='';
		 var pm="";
		 var pm1=0;
		 var mets=0;
		 var sel2=0;
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
						
						$("#form1").ajaxSubmit(options);
						return false;
					});
                  }		
		
		</script>
		<!--		-->



		<script type="text/javascript">
 $(function(){
 	 
     var id=$('#goods_dictid').val();
    var namevalue= $('#'+id).attr('name');
    alert("id="+id+" namevalue="+namevalue);
     f2(namevalue,1);
 });
  
		
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
			$('#geids0').html("");
		  var lastid=id.split("&");
		   var leng=  lastid.length-1
		   alert("leng="+leng);
		    var idclass=lastid[leng];
		    //alert("idclass="+idclass);
		    $('#goods_dictid').attr('value',idclass);
		   $.post("pdm/superIdproductManager.do", {'id':id,"flags1":s},function(data){
	    if(data=="")return;
	    //alert("da="+data);
	   var values=data.split(" ");
	    for(var i=0;i<values.length;i++){
	       var strs1=  values[i];
	      var strs = strs1.split('&');
	          if(strs!=""){
	            for(var j=0;j<strs.length;j++){
	                 var id=strs[j];
	                 alert("showgoods(id)="+id);
	                 if(id!=""){
	                    showgoods(id);
	                   }
 	            }
	       }
	    }
	});

		}
		
	 var indexradoi=-1;//单选下标
	 var indexselect=-1;//下拉下标
	 var indexcheck=-1;//多选下标			
		function trim(s){
		  if(s.indexOf("")!=-1){
		     return s.replace(/^\s*/, "");
		  }else{
		     return s;
		  }
		 }
		function showgoods(id){
		          var geids=$('#geid'+id).val();
		          //alert("ge="+geids);
	              var geid=geids.split('|');
	             
	              var arrsn=new Array();
	              //alert("input="+$('#inputvalue').val());
	              var arrs1= $('#inputvalue').val().split("&");
	              for(var j=0;j<arrs1.length;j++){
	                  if(arrs1[j]!=""){
	                   var arrs2=arrs1[j].split("|");
	                   for(var m=0;m<arrs2.length;m++){
	                       if(arrs2[m]!=""){
	                          //alert("pmm="+arrs2[m]);
	                          arrsn.push(arrs2[m]);
	                        }
	                    }
	                  }
	              }
	             //alert("len="+arrsn.length);
	             ///alert("arrs1="+$('#inputvalue').val());
	                 var mo=0;
	                 for(var i=0;i<geid.length;i++){
	                  var values=geid[i];
	                   //alert("geid[i]="+values);
	                     if(values!=""){
	                    //alert("val1="+values);
	                      var v= values.split(";");
	                      //alert("v[0]="+v[0]);
	                       //alert("v[1]="+v[1]);
	                       //alert("v[2]="+v[2]);
	                       //alert("v[4]="+v[3]);
	                        if(v[0]==1){   //文本
	                             var bit=v[2];
	                             var txflg=0;
	                            /// alert("bit="+bit+","+arrsn.length);
		                             for(var p=0;p<arrsn.length;p++){
		                             if(v[1]==trim(arrsn[p])){
		                                 //alert("a"+p+"="+trim(arrsn[p]+","+v[1]));
		                                 var nam1=arrsn[++p];
		                                 //alert(222);
			                             $('#geids0').append(
			                            // "<tr class='c1'><td>"+trim(v[1])+":</td><td><input type='text' id='tet"+mets+"' name='"+v[1]+"' value='"+nam1+"' onblur='valblur("+"\""+trim(v[1])+"\""+",this.id,this.name)'></td>"+
			                             "<tr class='c1'><td>"+trim(v[1])+":</td><td><input type='text' id='tet"+mets+"' name='"+v[1]+"' value='"+nam1+"' ></td>"+
			                             "<td>"+bit+"</td></tr>");
			                             //valblur("\""+trim(v[1])+"\"","tet"+mets);
			                             txflg=1;
			                             mets++;
			                             break;
		                             }
		                             }
		                             //类目那里增加一个文本框这里怎么写
		                             if(txflg==0){
		                             // alert("b"+v[1]+"="+v[4]);
		                             //alert(333);
		                                $('#geids0').append(
			                             //"<tr class='c1'><td>"+trim(v[1])+":</td><td><input type='text' id='tet"+mets+"' name='"+v[1]+"' value='"+v[4]+"' onblur='valblur("+"\""+trim(v[1])+"\""+",this.id,this.name)'></td>"+
			                             "<tr class='c1'><td>"+trim(v[1])+":</td><td><input type='text' id='tet"+mets+"' name='"+v[1]+"' value='"+v[4]+"'></td>"+
			                             "<td>"+bit+"</td></tr>");
			                             //valblur("\""+trim(v[1])+"\"","tet"+mets);
			                             mets++;
			                            
		                             }
	                             
	                         } 
	                          if(v[0]==2){//下拉
	                          
	                          
	                          			var bit=v[2];
	                                 	var attribute=$('#saattribute').val();
	                                 	//alert("attribute="+attribute);
                                     	var valtype= attribute.split("@");
                                        var typeselects= valtype[1]; 
                                        //alert("typeselects="+typeselects);
                                        var selectval='';//取值
	                                    var typeselect="";
	                                    if(typeof(typeselects)!='undefined'){
	                                       typeselect=typeselects.split("&");
	                                    }
	                                    if(typeselect!=""){
	                                      for(var u=0;u<typeselect.length;u++){
	                                        var selectval2=typeselect[u].split("|");
	                                        selectval+=selectval2[2]+",";
	                                      }
	                                       //alert("sel="+selectval);
	                                       var  selval= selectval.split(",");
	                                        
	                                    }
	                             indexselect++;
	                             //alert(444);
	                             //$('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td><select id='select"+v[1]+""+id+"' onchange='showselect("+i+","+"\""+v[1]+"\""+","+id+");' ></select></td><td>"+bit+"<td/></tr>");
	                              $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td><select id='selct"+sel2+"'></select><input type='hidden' id='hidt"+sel2+"' value='"+v[1]+"'></td><td>"+bit+"<td/></tr>");
	                              var op= v[4].split('-');
	                                for(var k=0;k<op.length;k++){
	                                  if(op[k]!=''){
	                                    if(selval[indexselect]==op[k]){
	                                       $("#selct"+sel2).append("<option  selected='selected' value="+op[k]+">"+op[k]+"</option>");
	                                    }else{
	                                       $("#selct"+sel2).append("<option value="+op[k]+">"+op[k]+"</option>");
	                                    }
	                                
	                                  }
	                                }
	                              sel2++;
	                         } 
	                          if(v[0]==3){//多选择
	                           var bit=v[2];
	                            //alert("v[0]="+v[0]);
	                       //alert("v[1]="+v[1]);
	                       //alert("v[2]="+v[2]);
	                      // alert("v[4]="+v[3]);
	                            //alert("bit"+v[0]+","+bit);
	                             //alert("geid[i]="+values);
	                              var attribute=$('#saattribute').val();
	                              alert("attribute="+attribute);
	                              //alert("attribute="+attribute);
                                    var valtype= attribute.split("@");
                                    // alert("valtype="+valtype[0]);
                                    // alert("valtype="+valtype[1]);
                                    // alert("valtype="+valtype[2]);
                                    var typecheckboxs="";
                                    
                                    if(typeof(valtype[2])!="undefined"){
                                    
                                       typecheckboxs= valtype[2];
                                    }
                                    alert("typecheckboxs="+typecheckboxs);
                                       var typecheckbox=typecheckboxs.split("&");
                                       var ches='';
                                         if(typecheckbox!=""){
                                              for(var k=0;k<typecheckbox.length;k++){
                                              	  //alert(typecheckbox[k]);
                                                  var valcheck= typecheckbox[k].split("|");
                                                  ches+= valcheck[2]+",";
                                              }
                                         }
	                           //alert("ches="+ches);
	                          // indexcheck++;
	                            var checkss= ches.split(",");
	                           // alert("checkvals="+checkss[indexcheck]);
	                           //alert(555);
	                           //alert("v[1]="+v[1]+" id="+id+" bit="+bit);
                                $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td class='c11' id=chkbox"+v[1]+""+id+"></td><td>"+bit+"</td></tr>");
	                             var duovalues=v[4];
	                             var flag=0;
	                             //alert("duovalues="+duovalues);
	                             var duoxuan=duovalues.split("-");
	                              for(var l=0;l<duoxuan.length;l++){
	                                  if(duoxuan[l]!=""){
	                                        //alert(duoxuan[l]+"=="+checkss[mo]);
	                                        for(var mos=0;mos<checkss.length;mos++){
	                                            //alert("duoxuan[l]="+duoxuan[l]);
	                                            //alert("checkss[mos]"+checkss[mos]);
		                                        if(duoxuan[l]==checkss[mos]){ 
				                                   $('#chkbox'+v[1]+id).append("<input type='checkbox' value='"+duoxuan[l]+"'  name='duoxuan"+mm1+id+"' checked='checked' />"+duoxuan[l]);
				                                   flag=1;
				                                }
			                                  }
			                                  if(flag==0){
			                                     $('#chkbox'+v[1]+id).append("<input type='checkbox' value='"+duoxuan[l]+"'  name='duoxuan"+mm1+id+"'/>"+duoxuan[l]);
			                                  }else{
			                                     flag=0;
			                                  }
			                                  
	                                      } 
	                                  
	                                  }
	                              
	                                   $('#chkbox'+v[1]+id).append("<input type='hidden' id='hidn"+mm1+"' name='"+v[1]+"' value='"+id+"'>");
	                                   mm1++;
	                              }
	                     
	                          if(v[0]==4){//单
	                          var bit=v[2];
	                              var attribute=  $('#saattribute').val();
	                              //alert("a="+attribute);
                                   var valtype= attribute.split("@");
                                    var typeradio= "";
                                    if(typeof(valtype[2])!="undefined" && valtype[2]!=""){
                                         typeradio=valtype[2].split("&");
                                    } 
                                     var strs='';
                                    if(typeradio!=""){
                                      for(var r=0;r<typeradio.length;r++){
                                      var  radiovals=typeradio[r].split("|");
                                        strs+= radiovals[3]+",";
                                      }
	                             }
	                            var  radiovalus= strs.split(",");
	                            //alert(666);
	                             $('#geids0').append("<tr class='c1'><td>"+v[1]+":</td><td id=rados"+id+"></td><td>"+bit+"</td></tr>");
	                             indexradoi++;
	                             var danvalues=v[4];
	                             var danxuan=danvalues.split("-");
	                            for(var l=0;l<danxuan.length;l++){
	                               if(danxuan[l]!=""){
	                               if(radiovalus!=""){
	                               if(radiovalus[indexradoi] == danxuan[l]){
	                                $('#rados'+id).append("<input type='radio' value="+danxuan[l]+" name='radios"+id+"' checked='checked'/>"+danxuan[l]);
	                               }else{
	                                $('#rados'+id).append("<input type='radio'  value="+danxuan[l]+" name='radios"+id+"'/>"+danxuan[l]);
	                               }
	                               }
	                               }
	                             }
	                            $('#rados'+id).append("<input type='hidden' id='rdhidn"+mm2+"' name='"+v[1]+"' value='"+id+"'>");
	                            mm2++; 
	                        }        
	                  }
	              }
		}
		
		
		function showp(id,pm){
		   // alert("at="+id+","+pm);
		     $('#inputvalue').html('');
             $('#selectvalue').html('');
             $('#radiovalue').html('');
             $('#checkboxvalue').html('');
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
        function valblur(mpp,mps1,mps2){
           //alert(mpp+"-"+mps1+"-"+mps2);
           var mps="";
           mps=mpp.replace(/\"/g,"");
           if(typeof(mps2)!='undefined'){
             // var p1s=$('#inputvalue').val().indexOf(mps2);
             //var p2s=mps2.length;
             //$('#inputvalue').val().substring(p2s,$('#inputvalue').val().length)
             //alert("ps1="+$('#inputvalue').val()+"--"+p1s+","+p2s);
             var mtt = new Array();
             var inputext="";
             mtt=$('#inputvalue').val().split("&");
             for(var i in mtt){
	             if(mtt[i]!=''){
	                if(mtt[i].indexOf(mpp)!=-1){
	                     var mtxt=mtt[i].replace(mps2,$('#'+mps1).val());
	                     inputext+=mtxt+"&";
	                }else{
	                     inputext+=mtt[i]+"&";
	                     }
	             }
             }
              $('#inputvalue').html(inputext);            
            // var arrStr=new Array();
            // arrStr=$('#inputvalue').val().split("|");
             //for(var i=0;i<arrStr.length;i++){
                // if(arrStr[i]==mps2){
                 //arrStr[i].replace();
                 //}
            // }
             alert(1);
           }
        }
         
</script>

		<script type="text/javascript">
		$(function(){
		var imgs=$('#imgs').val();
		  var imgvalue=  imgs.split('|');
		  for(var i=1; i<imgvalue.length; i++){
		  if(imgvalue[i]!=""){
		    $('#imga'+i).attr('src',imgvalue[i]);
             }
		  }
		  for(var i=1; i<imgvalue.length; i++){
		     $('#img'+i).attr('value',imgvalue[i]);
		  }
		   
		});
		
		function delectimg(id){
		  var img=$('#img'+id).val();
		  if(!img){
		    alert('您要删除的图片不存在,请先上传！');return;
		  }
		  $('#img'+id).attr('value',"");
		   $('#imga'+id).attr('src',"product_manage/img/noneimg.jpg");
		}
		</script>

		<script type="text/javascript">
		 function showselect1(j,id,values){
		      $('#selectvalue').append(j+"|"+id+"|"+values+"&");
		 }
 
 
  function showselect(j,id,valu){
  var v='';
  var values=$('#selectvalue').val();
  $('#selectvalue').html('');
  //alert("selct="+values+","+valu+","+id+","+j);
  //var string;
  //var str=values.split("&");
  //  for(var i=0;i<str.length;i++){
    // if(str[i]!=""){
      //   string= str[i].split("|");
         //  if(string[0]==j && string[1]==id){
              //selstr(i,j,id,valu);
        //   }
        // }
   //  }
     $("#select"+id+""+valu+">option").each(function(){
          if($(this).attr('selected')==true){
            // alert("selt="+$(this).text());
             ss+=id+"|"+$(this).text()+"|"+$(this).text()+"&";
           }
     });
     if(ss==""){
        ss=values;
     }
	 //alert("ss..="+ss);
	 //var str=values.split("&");
    // for(var i=0;i<str.length;i++){
       //  if(str[i]!=""){
         //   alert("na="+str[i]);
         //   if(str[i]!=str[k]){
	       //    ss+=str[i]+"&";
	        // }else{
	         ///  ss+=s;
           //}
        //}
     //}
     $('#selectvalue').html(ss); 
}
function radiovalue(i,id,name){
   $('#radiovalue').append(i+"|"+id+"|"+name+"&");
}
  
function radiov(){////////////////////////////////////////////////////
    var st='';
     var values=$('#radiovalue').val();
       $('#radiovalue').html('');
     //alert("radio="+values);
      //var str=values.split("&");
     /////for(var i=0;i<str.length;i++){
      // if(str[i]!=""){
       // var names= str[i].split("|");
         // var va=$("input[name="+names[2]+""+names[1]+"]:checked").val();
        //   st+=names[0]+"|"+names[1]+"|"+names[2]+"|"+va+"&";
      // }
    // }
    for(var i=0;i<50;i++){
       if(typeof($('#rdhidn'+i).val())!="undefined"){
           var pmt1=$('#rdhidn'+i).val();
           var pmt2=document.getElementById("rdhidn"+i).name;
          // alert("pm1="+pmt1);
          // alert("pmt1="+pmt2);
           var va=$("input[name=radios"+pmt1+"]:checked").val();
           st+=pmt2+"|"+pmt2+"|"+pmt2+"|"+va+"&";
       }
    }
    $('#radiovalue').html(st);
   }
   
   
   function saveradio(va){
   var values=$('#radiovalue').val();
      var str=values.split("&");
        for(var i=0;i<str.length;i++){
        if(str[i]!=""){
       // alert(str[i]);
     }
     }
   }




function checkboxv(){//hidn
   var checkbox='';
   $('#checkboxvalue').html('');
   //alert("values="+values);
    //var str=values.split("&");
  //  for(var i=0;i<str.length;i++){
   // if(str[i]!=""){
   // var va=str[i].split("|");
  ///  alert("ck="+va[2]+","+va[1]);
   // $($("input[name='duoxuan"+va[2]+""+va[1]+"'][checked]")).each(function(){ss+=this.value + ',';});
   //  checkbox+=va[0]+"|"+va[1]+"|"+va[2]+"|"+ss+"&";
  //  }
   // }
    for(var i=0;i<50;i++){
        if(typeof($('#hidn'+i).val())!="undefined"){
            var chkid=$('#hidn'+i).val();
              var ss='';
            var pmt2=document.getElementById("hidn"+i).name;
            //alert("valueck="+chkid);
            //alert("valueck1="+pmt2);
	    	//$($("input[name='duoxuan"+chkid+"'][checked]")).each(function(){ss+=this.value + ',';});
	    	$($("input[name='duoxuan"+i+chkid+"']:checked")).each(function(){
	    	     ss+=this.value + ',';
	    	});
	    	//checkbox+=pmt2+"|"+pmt2+"|"+pmt2+"|"+ss+"&";
	    	if($.trim(ss) == ''){
	    	checkbox+=i+"|"+pmt2+"|无&";
	    	}else{
	    	checkbox+=i+"|"+pmt2+"|"+ss+"&";
	    	}
	    }
    }
    //alert("chk="+checkbox);
    $('#checkboxvalue').html(checkbox);
}
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



</script>
<SCRIPT type="text/javascript">
   $(function(){
     var valuesStr= $('#saattribute').val();
     // alert("valuesStr="+valuesStr);
       var str=valuesStr.split("@");
       // alert("valuesStr2="+str[0]);
          $('#inputvalue').append(str[0]);
          $('#selectvalue').append(str[1]);
          $('#radiovalue').append(str[2]);
          $('#checkboxvalue').append(str[3]);
   });
</SCRIPT>

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
   
  // 商品单位  -->
   function checksgUnit(){
    var values= $('#sgUnit').val();
      if(values==""){
        $('#sgUnitMsg').html('商品单位不能为空!');
        return false;
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
         }else{
            $('#sgPriceMsg').html('填写数字');
            return false;
         }
            return true;
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
         }else{
              $('#sgNumberMsg').html('填写数字');
              return false;
         }
          return true;
      }else{
         $('#sgNumberMsg').html('此项不能为空');
      }
       return false;
   }
   $(function(){
      $("#subuttn").click(function(){
          var s="true";
    	var s=  getValue();
    	if(s==false){
    	  alert(12);
    	  return;
    	}
      var detail1=$('#sgDetails').val();
      var pm="";
       var ss1="";
     if(checkimg()&& checksgPrice() && checksgUnit()&& checksgNorms() && checksgname() && checkgoods_dictid() && checkspxq(detail1) && checksgNumber()){
             $('#inputvalue').html('');
             $('#selectvalue').html('');
             $('#radiovalue').html('');
             $('#checkboxvalue').html('');
            radiov();
            checkboxv();
            for(var j=0;j<50;j++){
               if(typeof($('#tet'+j).val())!='undefined'){
                    flago=1;
               }
            }
             for(var s=0;s<mets;s++){
             //alert("wer="+document.getElementById("tet"+s));
             if(document.getElementById("tet"+s)!=null){
			  //pm+= document.getElementById("tet"+s).name +"|"+ document.getElementById("tet"+s).value+"|"+ document.getElementById("tet"+s).name +"&";
			  pm+= s +"|"+ document.getElementById("tet"+s).name+"|"+ document.getElementById("tet"+s).value +"&";
			 }
			 
			}
		    $('#inputvalue').html(pm);
            for(var t=0;t<sel2;t++){//selct"+sel2+"'
            if(document.getElementById("hidt"+t)!=null){
                //ss1+=$('#hidt'+t).val()+"|"+$('#selct'+t).find("option:selected").text()+"|"+$('#selct'+t).find("option:selected").text()+"&";
                ss1+=t+"|"+$('#hidt'+t).val()+"|"+$('#selct'+t).find("option:selected").text()+"&";
    		    }
            }
            $('#selectvalue').html(ss1); 
            //alert(pm);
            //alert(ss1);
            //alert("vau111="+  $('#inputvalue').html());
            ////alert("vau111="+ $('#selectvalue').val());
            $('#form1').attr("target","");
	        $('#form1').attr("action","pdm/addproductManager.do?modify=123");
            document.forms["form1"].submit();
     }else{
         //alert(flag1+","+flag2+","+flag3+","+flag4);
         alert("请完善资料");
        
     }

     
     
      });
      
   });
  // function ff(){
     //radiov();
     //checkboxv();
     //document.getElementById("form1").submit();
  // }
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
	  $('#form1').attr("target","framain");
	  $('#form1').attr("action","pdm/classSelectproductManager.do");
	   document.forms["form1"].submit();
	  }
	}
    function showorhide(){
	    $('#mains').show();
	    $('#mains1').hide();
	}
</script><script type="text/javascript">
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
									return false;

							     }
							   if(isNaN($("#rq"+chk_value[i]+"_").val()) || isNaN($("#xl"+chk_value[i]+"_").val())){
									alert("数量价格备注不能为空");
									newstr="";
									return false;

							     }	
							newstr+=chk_value[i]+","+","+$("#rq"+chk_value[i]+"_").val()+","+$("#xl"+chk_value[i]+"_").val()+","+$("#bz"+chk_value[i]+"_").val()+","+chk_value[i]+"_"+"|";
						
							}
							else{
								for(var j=0;j<xv;j++)
								{		
									 if($("#rq"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#xl"+chk_value[i]+"_"+xv_value[j]).val()=="" || $("#bz"+chk_value[i]+"_"+xv_value[j]).val()==""){
											alert("数量价格备注不能为空");
											newstr="";
											return false;

									     }	
									if(isNaN($("#rq"+chk_value[i]+"_"+xv_value[j]).val()) || isNaN($("#xl"+chk_value[i]+"_"+xv_value[j]).val()) ){
										alert("数量价格必须为数字类型");
										newstr="";
										return false;

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
		<input id="pathi" style="margin-bottom: 20px;" type="hidden"
			value="<%=path%>">
		<form  
			method="post" id="form1" name="form1">
			<div
				style="border: solid #97C4E3; width: 90%; margin-left: 50px; margin-top: 30px;">
				

				<table width="1000" style="margin-left: 48" border="2">
					<tr>
						<td class="c1" style="width: 100px;">
							商品编码：
						</td>
						<td>
							<input id="sgcode" class="fa_input"  name="sgcode" value="${sa.sgcode}" />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="upMsg"></FONT>
						</td>
					</tr>
					<tr>
						<td>
							商品类目：
						</td>
						<td>
						<input type="hidden" name="sa.selname" id="selname">
						<input  class="fa_input" type="hidden" id="goods_dictid" name="goods_dictid"
									value="${sa.goods_dict.gdId}">
								
						   <div >
						       <input  class="fa_input" type="text" id="textfield2" size="30" value="请输入查询内容" onFocus="if(this.value=='请输入查询内容')this.value=''" onBlur="if(this.value=='')this.value='请输入查询内容'" onkeyup="if(event.keyCode==13)document.getElementById('buton1').focus();"/>
						       <input type="button" value="查询" id="buton1" onclick="selctClass()">
						   </div>
						   <div style="float:right;color: red;">*注：单击是显示下一级，双击是显示类目属性。</div>
						   <div id="mains">
								<div id="mains2">
								<div class="bd_bj">
								<table border="0" cellspacing="0" cellpadding="0" id="tb_hg">
								  <tr> 
								    <td>
									<div id="xz_k1">
									  <ul>
								         <c:forEach items="${goods_dict}" var="goods">
									     <c:if test="${goods.gdSuperId==null}">
								         <li>
									    <a href="javascript:;" id="${goods.gdId}" 
										onclick="showp(this.name,2)" name="${goods.gdId}"  ondblclick="f2(this.name,1)"/>${goods.gdnames }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="sdp${goods.gdId}">>></span></a>
										</li><!-- 111 -->
										<!-- 2222 -->
										<div id="py${goods.gdId}" style="display:none;">
									
									   <div id="grade${goods.gdId}">
									    <ul>
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
											   <ul>
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
													   <ul>
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
																   <ul>
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
																   <ul>
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
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="goods_dictidMsg"></FONT>
						</td>
					</tr>
					<tr>
						<td width="10%">
							商品名称：
						</td>
						<td>
							<input class="fa_input" id="sgname" name="sgname" value="${sa.sgname}" />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="sgnameMsg"></FONT>
						</td>
					</tr>
					<tr>
						<td>
							商品规格：
						</td>
						<td>
							<input class="fa_input" id="sgNorms" name="sgNorms" value="${sa.sgNorms}" />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="sgNormsMsg"></FONT>
						</td>
					</tr>
					<tr>
						<td>
							商品单位：
						</td>
						<td>
							<input class="fa_input" id="sgUnit" name="sgUnit" value="${sa.sgUnit}" />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="sgUnitMsg"></FONT>
						</td>
					</tr>
					<tr>
						<td>
							商品价格：
						</td>
						<td>
							<input class="fa_input" id="sgPrice" name="sgPrice" value="${sa.sgPrice}" />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="sgPriceMsg"></FONT>
						</td>
					</tr>
					  <tr>
				          <td>商品数量:</td>
				          <td><input class="fa_input" id="sgnumbers" name="sgnumbers" onblur="checksgNumber();" value="${sa.sgnumbers}"/><FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="sgNumberMsg"></FONT></td>
				       </tr>
					<tr>
						<td>
							录入人：
						</td>
						<td>
							<input class="fa_input" id="sgUsername" name="sgUsername" readonly  value="${sa.sgUsername}"  />
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="upMsg"></FONT>
						</td>
					</tr>

					<tr>
						<td>
							商品状态：
						</td>
						<td>
							<select style="width: 154" id="sgStat" name="sgStat">
								<option value="0"
									<c:if test="${sa.sgStat==0}">selected="selected" </c:if>>
									仓库中商品
								</option>
								<option value="2"
									<c:if test="${sa.sgStat==2}">selected="selected" </c:if>>
									发布待审核
								</option>
							</select>
							<FONT color=#ff0000></FONT>
							<FONT color=#ff0000 id="sgStatMsg"></FONT>
						</td>
					</tr>
    <tr>
           <td>生成上架单:</td>
           <td>
              <div id="checkUps">
              <input type="radio" name="sgchecks" value="1" <c:if test="${sa.sgchecks1==1}">checked</c:if>>是&nbsp;&nbsp;&nbsp;
              <input type="radio" name="sgchecks" value="0" <c:if test="${sa.sgchecks1==0}">checked</c:if>/>否
              </div>
              <div id="checkYes" style="display:<c:if test="${sa.sgchecks1==1}">block;</c:if>">
              	<input type="radio" name="sgchecks1" value="1" <c:if test="${sa.sgchecks2==1}">checked</c:if>/>托管&nbsp;&nbsp;&nbsp;
              	<input type="radio" name="sgchecks1" value="2" <c:if test="${sa.sgchecks2==2}">checked</c:if>/>租用
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
               <INPUT class="fa_input"  style="WIDTH: 150px" id="sgtime" name="sgtime" value="<%=str %>" readonly="readonly">
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="upMsg"></FONT>
           </td>
       </tr>  
       
<!---->
<!--					<tr>-->
<!--						<td>-->
<!--							发布时间：-->
<!--						</td>-->
<!---->
<!--						<td>-->
							<INPUT type="hidden" id="sgPuttime" name="sgPuttime"
								value="${sa.sgPuttime}"
								onclick="WdatePicker({minDate:'#F{$dp.$D(\'sgtime\')||\'2000-10-01\'}'})">
<!--							<FONT color=#ff0000>*</FONT>点击输入框获取时间-->
<!--							<FONT color=#ff0000 id="downMsg"></FONT>-->
<!--						</td>-->
<!---->
<!--					</tr>-->

					<!--       -->

					<tr> 
						<td colspan="2">
							<!--       style="overflow:hidden; height:18px; width:60px;opacity:0; filter:alpha(Opacity=0);"-->
							图片上传： &nbsp;&nbsp; &nbsp;&nbsp;
							<input id="fileupload" name="fileupload" type="file" />
							<input type="button" onclick="uploadImage()" class="fa_input" value="上传" />
							<input id="ico" name="ico" type="hidden">
							<div id="tipDiv">
							</div>
							<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="imgMsg"></FONT>
						</td>
					</tr>


					<tr>
						<td  width="101">
							商品图片:
						</td>
						<td>
							<div style="border: 1px solid; width: 720px; height: 250px;">
								<div id="showpath">
								</div>
								<table width="94" height="66">
									<tr>
										<td>
											<div style="height: 35">


											</div>

											<table style="text-align: center;">
												<tr>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img alt="图片规格" src="product_manage/img/imggg.jpg"
															style="width: 120; height: 120; border: 1px solid;">
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img id="imga1" alt="商品图片"
															src="product_manage/img/noneimg.jpg" class="img">
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img id="imga2" alt="商品图片"
															src="product_manage/img/noneimg.jpg" class="img">
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img id="imga3" alt="商品图片"
															src="product_manage/img/noneimg.jpg" class="img">
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img id="imga4" alt="商品图片"
															src="product_manage/img/noneimg.jpg" class="img">
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<img id="imga5" alt="商品图片"
															src="product_manage/img/noneimg.jpg" class="img">
													</td>
												</tr>
												<tr>
													<td>
														图片规格
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(1)" />
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(2)" />
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(3)" />
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(4)" />
													</td>
													<td>
														&nbsp;&nbsp;&nbsp;
														<input class="fa_buttom" type="button" value="删除此图片" onclick="delectimg(5)" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="imgs" value="${sa.sgImg }">
											<input type="hidden" id="img1" name="img1" value="">
											<input type="hidden" id="img2" name="img2" value="">
											<input type="hidden" id="img3" name="img3" value="">
											<input type="hidden" id="img4" name="img4" value="">
											<input type="hidden" id="img5" name="img5" value="">
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
<!-- 
					<tr>
						<td>
							宝贝视频:
						</td>
						<td>
							<div
								style="width: 180px; height: 100px; border: solid 1px; text-align: center;">
								<img alt="" src="product_manage/img/nonesp.jpg">
							</div>
							<input type="button" value="选择视频">
						</td>

					</tr>

 -->
					<tr>
						<td>
							商品详情：
						</td>
						<td>
							<div id="spxq">
								<textarea class="input_texta" rows="12" cols="80" name="sgDetails" id="sgDetails" onblur="checkspxq(this.value)" style="text-align:left;margin: auto;">
				                   ${sa.sgDetails}
				                 </textarea>
				                 <span style="color:red;" id="spxqMsg"></span>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							商品特殊属性：
						</td>
						<td>
							<div id=""
								style="width: 650; height: 150px; border: solid 1px; color: 7d7d7d;">
								<div id="geids01">
									<table id="geids0" style="margin-left: 100px;" width="500px;">

									</table>
								</div>
								<c:forEach items="${goods_class_expand}" var="goodsclass">
									<input id="geid${goodsclass.geId}" type="text"
										onclick='showvalue(this.value)'
										;
                 value="${goodsclass.geTemp1}|${goodsclass.geTemp2}|${goodsclass.geTemp3}|${goodsclass.geTemp4}|${goodsclass.geTemp5}|${goodsclass.geTemp6}|${goodsclass.geTemp7}|${goodsclass.geTemp8}|${goodsclass.geTemp9}|${goodsclass.geTemp10}|${goodsclass.geTemp11}|${goodsclass.geTemp12}|${goodsclass.geTemp13}|${goodsclass.geTemp14}|${goodsclass.geTemp15}" />
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
                   <tr><td>计费周期</td><td><label><input name="textck" type="checkbox" value="月付"  id="月付" onchange="jqchk()"/>月付</label><label><input type="checkbox" value="季付" id="季付" onclick="jqchk()" name="textck"/>季付</label><label><input type="checkbox" value="半年付" id="半年付" onclick="jqchk()" name="textck"/>半年付</label></td>                   </tr>
                   <tr><td>线路</td><td><label><input type="checkbox" name="textck1" value="电信" id="电信" onchange="jqchxl()"/>电信</label><label><input type="checkbox" name="textck1" value="联通" id="联通"  onchange="jqchxl()"/>联通</label><label><input type="checkbox" value="移动" id="移动" name="textck1" onchange="jqchxl()"/>移动</label></td>                   </tr>
                   </table>
                </div>
                
                 
              
               </div>

              
            </td>
       </tr>
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
         	<% 
					String checkval=request.getAttribute("checkboxval")!=null?(String)request.getAttribute("checkboxval"):"";
					out.print(checkval);
					String checklist[]=  checkval.split(",");
					for(int i=0;i<checklist.length;i++){
						if(checklist[i]!=null && !checklist[i].equals("")){
					%>
					<script type="text/javascript">
					
					$(document).ready(function(){

						var checkval1=<%=checklist[i].toString() %>
					
						
					     $("#"+"<%=checklist[i].toString() %>").attr("checked","checked");
					     jqchk();
					     jqchxl();
							});
					</script>
					
					<% out.print(111);
					
					
					}}
						
						String strge=request.getAttribute("strge")!=null?(String)request.getAttribute("strge"):"";
						String strgelist[]=strge.split("\\|");
						out.print(strgelist);
						for(int i=0;i<strgelist.length;i++){
							if(strgelist[i]!=null && !strgelist[i].equals("")){
								
								String strgetdel[]=strgelist[i].split(",");
						%>
						<script type="text/javascript">
						
						$(document).ready(function(){

							

							$("#rq"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[2] %>");
							$("#xl"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[3] %>");	
							$("#bz"+"<%=strgetdel[strgetdel.length-1] %>").val("<%=strgetdel[4] %>");	
							
								});
						</script>
						
						<% 
						
						
						}
					
					
					}%>
         
					<tr style="height: 100px;">
						<td colspan="2" align="center">
						   <input style="display: none"  type="image"  src="<%=basePath %>${sa.erweima}"/>
							<input type="button" value="确定"   class="fa_buttoms"id="subuttn"/>
						
						</td>
					</tr>

				</table>
				<input type="hidden" name="sgid" value="${sa.sgId}">
			</div>
			<div style="display:none;">
				<textarea id="saattribute" name="saattribute">
				     ${sa.sgAttribute }
				</textarea>
				<textarea id="inputvalue" name="inputvalue"
					style="height: 50; width: 600px;">
   </textarea>
				<textarea id="selectvalue" name="selectvalue"
					style="height: 50; width: 600px;">
   </textarea>
				<textarea id="radiovalue" name="radiovalue"
					style="height: 50; width: 600px;">
   </textarea>
				<textarea id="checkboxvalue" name="checkboxvalue"
					style="height: 50; width: 600px;">
   </textarea>
			</div>
     <textarea id="productgevalue" name="productgevalue" style="height: 50; width: 600px;">
   </textarea>
		</form>
		<div id="321"></div>
	</body>
</html>
