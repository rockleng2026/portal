var count=0;
var upcount=0;
var valarrs = new Array();//保存数组 JSON	格式
var subcount = new Array();//保存count 保存已增加的属性 它的长度不能超过15个(数据库限定了)
var arrs1=new Array();
var arrs2=new Array();
var arrs3=new Array();
var arrs4=new Array();//删除后的
var arrs5=new Array();//删除的
var arrcount=0;     //数据记数器
var ks=0          //key记数器
var rdid=0;     //数组id
var rdid1=0;     //数组id
var up1=0;
var up2=0;
var upflag=0;   //分辨是否修改
var upStrin="";//放增加按钮
var uplook="";//放浏览按钮
var cots;//当前count;
var selval;//选择类型
var countj=0;//显示浏览
var condels="";
var ks1=0;

function showAddSupper(id){
	arrcount=0
	getallCodes("f","no");
}
function getallCodes(ps,cont,name){
	  ks1=0;
	if(cont.substr((cont.length-4))!="0000"){
	  cont+="0000";
    }
	$.ajax({
	    url:'pdm/getSupperOrChildCodeClassprojt.do',
	    type:'post',
	    data:{"types":ps,"tent":cont},
	    error:function(res){
	    	$('#gdcodes').val("读取编码错误.");
	    },
	    success:function(res){
	    	//alert(0+","+res);
	    	if(ps=="f"){
	    	    $('#gdcodes').val(res);
	    	}else{
	    		//父类编码
	    		$('#superCodes').val(cont);
	    		//子类编码
	    		$('#childCodes').val(res);
	    		//名称
	    		$('#superNames').val(name);
	    	}
	    }
	});
}


//添加父类字段
function addnewsuperColumn(tys){
  //alert("tys="+tys);
  if(subcount.length<15){//如果长度没超15 可以添加属性
  var mtype;
 // upflag=0;
  if(tys=='f'){//是父类
  	mtype=1;	
  }else{
  	mtype=2;//是子类
  }
   if($("input[name='gdsuperWritename']:checkbox:checked").length>0 || $("input[name='gdchildWritename1']:checkbox:checked").length>0){
	   $('#gdWritename').val(mtype);
	   //功能：用于插入、删除或替换数组的元素。
	//语法：ArrayObject.splice(index,howmany,值1,值2,...)
	//参数：
	//index：必需。规定从何处添加/删除元素。
	//howmany：必需。规定应该删除多少个元素。可以是0。
	//值1,值2,...：可选。规定要添加到数组的新元素。从index所指的下标处开始插入。
	//返回值：修改后的数组。
	//注1：该方法会修改数组本身，而不是创建一个新数组。
	//注2：当只给出index和howmany参数，实现的是删除元素功能。
	//注3：当howmany参数为0，且给出添加的数值，实现的是插入元素功能。
	//注4：当howmany参数不为0，且给出添加的数值，实现的是替换元素功能。
	//实例1
	//删除元素。
	//var arr1 = new Array("1","2","3");
	//arr1.splice(1,1);
	//document.write( arr1 );
	//这段代码的输出效果： 1,3
	//splice(1,1)表示从第1个元素开始删除1个元素。（注：位置是从0算起的。）
	   arrs4.splice(0,arrs4.length);//arrs4删除后的 清空数组
	   arrs5.splice(0,arrs5.length);//arrs5删除的 清空数组
	   $('#addFields').html('');
	   $('#addallproperty').attr("disabled",true);
	   //增加显示文本框
	   $('#addFields').append('<span id="addnames'+count+'" style="margin-left:110px;font-size:12px;">属性名称'+(count+1)+':</span><input type="text" size="20" name="tempTit'+count+'" id="tempTit'+count+'" onblur="dealDatas(this.id)"/><span style="color:red;font-size:12px;">名称必填</span><br><span id="addcontents'+count+'" style="margin-left:110px;font-size:12px;">属性描述'+(count+1)+':</span><input type="text" size="30" name="tempCont'+count+'" id="tempCont'+count+'" />');
	   $('#addFields').append('<br><div id="fourclassids'+count+'" style="color:#000000;margin-left:60px;width:600px;font-size:12px;"><span id="addtypes'+count+'" style="margin-left:50px;">属性类型:<input type="radio" name="contantType'+count+'" id="'+count+'" checked value="1" onclick="showAlltype(this.value,this.id,'+mtype+')">文本框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'"  id="'+count+'"  value="2" onclick="showAlltype(this.value,this.id,'+mtype+')">下拉框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'" value="3" onclick="showAlltype(this.value,this.id,'+mtype+')">多选框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'"  value="4" onclick="showAlltype(this.value,this.id,'+mtype+')">单选框</span><input type="hidden" id="divid"><input type="hidden" id="addpositions'+count+'" value="addtypes'+count+'"></div>');
	   $('#addFields').append('<span id="guige" style="margin-left:110px;font-size:12px;">是否规格:<input type="radio" name="guige'+count+'" id="guige'+count+'" checked value="0" /> 否<input type="radio" onclick="ischeckbox('+count+')" name="guige'+count+'" id="guige'+count+'" value="1" />  是<font color="red">(属性类型为多选框时才能选"是")</font></span> ');
	   $('#divid').val("addFields");
	   $('#addFields').show();
	   var m=1;
	   subcount.push(count);
	   showAlltype(m,count,mtype);
	   count++;
	   conmentAll();
	   return true;
   }else{
	   alert('你还没选定是否增加属性。');
   }
  }else{
	   alert("你增加的属性已达到上限。"); 
	   return false;
  }
  
}
function conmentAll(){
	 if(count>0){
	       for(var i=0;i<(count-1);i++){
	    	   var mp=$("input[name='contantType"+i+"']");
	    	   $.each(mp,function(index,item){
	    		  //alert(item.id+"=it");
	    		  $(this).attr("disabled","true");
	    	   });
	    	 
		}
		}  
}
function showAlltype(mp,mids,tyss){
    ks=0;
    countj=0;
    uplook="";
    //alert("览="+mp+","+mids+","+tyss);
   // selval=$("input:radio[name='contantType"+cots+"']:checked").val();
    var divid=$('#divid').val();
    var mtype=tyss;
    var mid=parseInt(mids);
    arrs4.splice(0,arrs4.length);
    arrs5.splice(0,arrs5.length);
    var ppm=$('#addpositions'+mid).val();
    //alert('click='+divid+","+mid+","+ppm);
    $('#allclassids'+mid).remove();
    $('.pmn'+mid).remove();
    //alert("mtype="+mtype);
   //文本 mp==1下拉mp==2多选mp==3//单选mp==4/
    //alert("upflag="+upflag);
    if(upflag==0){
    	
      $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;增加行:&nbsp;&nbsp;&nbsp;<div id="addconts'+mid+'" class="ann" onclick="addTexts('+mp+','+mid+')">增加</div><div id="showvalue" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"></div>&nbsp;&nbsp;&nbsp;&nbsp;<div id="confirmAdd'+mid+'" class="ann" onclick="showAddProperty('+mp+','+mid+','+mtype+')" >确认添加</div>&nbsp;&nbsp;&nbsp;<div id="preview'+mid+'" class="ann" onclick="showPreview('+mp+','+mid+')">效果预览</div> </div>');   		
      $('#confirmAdd'+mid).attr('disabled','disabled');
  	  $('#preview'+mid).attr('disabled','disabled');
    }else{ 
    	//alert(upStrin+","+uplook);
    	if(upStrin==''){
    		 upflag=0;
    		 //alert(100);
    		 $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;增加行:&nbsp;&nbsp;&nbsp;<div id="addconts'+mid+'" class="ann" onclick="addTexts('+mp+','+mid+')">增加</div><div id="showvalue" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"></div>&nbsp;&nbsp;&nbsp;<div id="confirmAdd'+mid+'" class="ann" onclick="showAddProperty('+mp+','+mid+','+mtype+')" >确认添加</div>&nbsp;&nbsp;&nbsp;&nbsp;<div id="preview'+mid+'" class="ann" onclick="showPreview('+mp+','+mid+')">效果预览</div></div>');
    	}else{
    		//alert(101);
    	   $('#'+divid).append('<div id="allclassids'+cots+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;增加行:&nbsp;&nbsp;&nbsp;'+upStrin+'<div id="showvalue" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"></div>'+uplook+'</div>');
    	}
    	if(upflag==99999){
    		 $('#confirmAdd'+cots).attr('disabled','disabled');
    	}
    }  
  
  }
//显示预览
function showPreview(type,m){
		//alert("预览="+type+","+m);
		$('#Resultpreviews').html('');
		$('#Resultpreview').show();
		var val;
		var rad=$('input:radio[name="tradios'+m+'"]');
		var name=$('#tempTit'+m).val();
		//alert("rad="+rad.length+","+arrs4.length);
	    //id="Resultpreview"
	    if(type==1){
	    	$('#Resultpreviews').html('');
			 for(var i=0;i<arrs4.length;i++){
			   if(typeof($('#value'+arrs4[i]).val())!='undefined'){
			   $('#Resultpreviews').append('<div>'+name+':<input type="text" id="tet'+i+'" value="'+$('#value'+arrs4[i]).val()+'" readonly="readonly" ></div>');
			   }
			 }
	    }
	    if(type==2){
	    	$('#Resultpreviews').html('');
	    	$('#Resultpreviews').append('<div>'+name+':<select id="selets"></select></div>');
	    	 for(var i=0;i<arrs4.length;i++){
	    		 if(typeof($('#value'+arrs4[i]).val())!='undefined'){
				   $('#selets').append('<option value="'+$('#value'+arrs4[i]).val()+'">'+$('#value'+arrs4[i]).val()+'</option>');
	    		 }
	    	}
	    }
	    if(type==3){
	    	for(var i=0;i<arrs4.length;i++){
	    		if(i==4){
	    			$('#Resultpreviews').append('<br>');  	
	    		}
	    		if(typeof($('#value'+arrs4[i]).val())!='undefined'){
	    		$('#Resultpreviews').append('<div id="allcheks" style="display:inline;">'+name+':<input type="checkbox" name="chekalls'+m+'" id="" value="'+$('#value'+arrs4[i]).val()+'">'+$('#value'+arrs4[i]).val()+'</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	    	    }
	    	}
	    }
	    if(type==4){
	    	for(var i=0;i<arrs4.length;i++){
	    		if(i==4){
	    			$('#Resultpreviews').append('<br>');  	
	    		}
	    		if(typeof($('#value'+arrs4[i]).val())!='undefined'){
	    		$('#Resultpreviews').append('<div id="allradios" style="display:inline;">'+name+':<input type="radio" name="radioalls'+m+'" id=""  value="'+$('#value'+arrs4[i]).val()+'">'+$('#value'+arrs4[i]).val()+'</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
	    	}
	    	}
	    }
	
}

//勾选规格属性验证 必须是多选框的情况下才能勾选
function ischeckbox(mid){
	//alert("ischeckbox mid="+mid);
	var contype=$('input:radio[name="contantType'+mid+'"]:checked').val();
	if(contype != '3'){
		alert("属性类型为多选框才能设置为是;");
		$.each($("input:radio[name='guige"+mid+"']"),function(index){
			   if($(this).val()==0){
				   $(this).attr('checked',true);   
			   }
		   });
	}
}
//添加属性(1.判断文本，下拉，2.名称id,)
function showAddProperty(type,m,tyss,mid){
	//alert("属="+type+","+tyss+","+upflag);
	$('#addProperty').show();
	var contentKeys="";
	var contentValues="";
	var allValues="";
	var mtry;
	var names;
	if(tyss==1){
		  mtry='f'; 
	  }else{
		  mtry='c';
	}
 //是类型，是名称，是否必填，KEY值，value值  
	var contype=$('input:radio[name="contantType'+m+'"]:checked').val();
	var conname=$('#tempTit'+m).val();
	var condiscript=$('#tempCont'+m).val();
	//alert("m="+m);
	var guige=$('input:radio[name="guige'+m+'"]:checked').val();//加入是否为规格属性
	//alert('#isvar='+guige);
  $.each(arrs4,function(index,sets){
	  if(typeof($('#value'+sets).val())!='undefined'){
		  //alert("组");
		  var keys=$('#key'+sets).val();
		  var values=$('#value'+sets).val();
		  contentKeys+=keys+"-";
		  if(values==''){
		     contentValues+="请在此处填写内容"+"-";
		  }else{
			  contentValues+=values+"-";
		  }
	  }
  });
  //alert("upflag="+upflag);
  if(upflag==99999){
	  
	      if(arrs1.length>0){
		  rdid=0;
		  valarrs.splice(0,valarrs.length); 
		  //alert("数组1");
		  var names1=$('#mradiotype'+mid).html();
		  var value1=$('#valueall'+mid).val();
		 for(var i=0;i<arrs1.length;i++){
			 if(arrs1[i]!="" && typeof(arrs1[i])!='undefined'){      //是类型，是名称，是否必填，KEY值，value值
		    	 arrs2=arrs1[i].split(";");
		    	 if(arrs2[1]!= names1 &&  arrs2[4]!=value1){
		    		  if(arrs2[5] == null ||arrs2[5] =="" || typeof(arrs2[5])!='undefined'){
		    			  arrs2[5] = 0;
		    		  }
		    		  allValues=arrs2[0]+";"+arrs2[1]+";"+arrs2[2]+";"+arrs2[3]+";"+arrs2[4]+";"+arrs2[5];
		    		  names=encodeURI(allValues,"utf-8");
		    		  valarrs.push(rdid);
		    		  valarrs.push(names);
		    		  rdid++;
		    		  //alert("数组1.1="+names);
		    	 }else{
		    		  allValues=contype+";"+conname+";"+condiscript+";"+contentKeys+";"+contentValues+";"+guige;
		    		  names=encodeURI(allValues,"utf-8");
		    		  valarrs.push(rdid);
		    		  valarrs.push(names);
		    		  rdid++;
		    		 // alert("数组1.2="+names);
		    	 }
			 }
		 
		 }
		  //alert("显示1.3="+allValues+","+mtry);
		  updcontent(mtry); 
	  }
  }else{
	 // var classid;
	  rdid=0;
	  var flagadd=0;
	  ks1++;
	  valarrs.splice(0,valarrs.length);
	  //condels 类目ID
	  if(ks1==1){
		  if(tyss==1){
			  condels=$("#getids").val();
		  }else{
			  condels=$("#getids1").val();
		  }
	  }
	 //alert("id2.1="+condels);
	 //下面是用类目ID去expand去查出所有的属性放到valarrs中
	  $.ajax({
		 type:'post',
		 url:'pdm/selectupIdClassprojt.do',
		 data:{oldid:condels},
		 success:function(res){
			 //alert(res);
			 if(res!=""){
				 arrs1=res.split("^");
				 for(var i=0;i<arrs1.length;i++){
				   if(arrs1[i]!=""){
					  valarrs.push(rdid);
					  names=encodeURI(arrs1[i],"utf-8");
					 // alert("na="+arrs1[i]);
					  valarrs.push(names);
					  rdid++;
				   }
				 }
				 flagadd++;
			 }else{
				 flagadd++; 
			 }
			 alert("2.21="+flagadd);
			  if(flagadd==1){
				  //alert(121234);
				  allValues=contype+";"+conname+";"+condiscript+";"+contentKeys+";"+contentValues+";"+guige//这个是组合成属性字符串
				  //allValues=contype+";"+conname+";"+condiscript+";"+contentKeys+";"+contentValues+";"+isvals;//这个是组合成属性字符串
				  //alert("val="+allValues);
				  names=encodeURI(allValues,"utf-8");
				 //alert("数组2.3="+names);
				  //alert("rdid="+rdid);
				  //alert("names="+names);
				  valarrs.push(rdid);
				  valarrs.push(names);
				 //alert("数组2.4="+valarrs.length);
				  rdid++;
			      addcontent(mtry);
			  }
		 }
	  });
	 
  }
  
}
//修改
function updcontent(types2){
	//alert("修改content"+types2);
	var jsons=arrtojson(valarrs);
	//alert("jsons="+jsons);
	var id;
	if(types2=='c'){
		id=$("#getids1").val();
	}else{
		id=$("#getids").val();
	}
		$.ajax({
			url:'pdm/addSupperorchidPropertyClassprojt.do',
			type:'post',
			data:{"datas":jsons,"surChild":types2,"clasid":id,"upflags":2},
			error:function(res){
				alert("错误="+res);
			},
			success:function(res){
				//alert(res);      //可以略掉
				var arr=res.split(",");//显示已添加的内容。
				//alert(res[0]);
			    if(arr[1]!=""){
			    	//$('#addallproperty').removeAttr("disabled");
			    	if(types2=="f"){ //父类
			    		//alert("arr[5]="+arr[5]);
			    		returnvalues(res,1);
			    		addnewsuperColumn('f');
			    	}else{        //子类
			    		returnvalues(res,2);
			    		addnewsuperColumn('c');
			    	}
			    }else{
			    	//alert(arr[0]);
			    }
			}
		});
		
	
}
//添加属性后台
function addcontent(types1){
	//alert("addcontent  types1="+types1);
	var id;
	var jsons=arrtojson(valarrs);
	//alert("jsons="+jsons);
	if(types1=='c'){
		id=$("#getids1").val();
	}else{
	   id=$("#getids").val();
	}
	//alert("jsons="+jsons);
	//return;
	//alert(1111);
		$.ajax({
			url:'pdm/addSupperorchidPropertyClassprojt.do',
			type:'post',
			data:{"datas":jsons,"surChild":types1,"clasid":id,"upflags":1},
			error:function(res){
				alert("添加属性后台="+res);
			},
			success:function(res){
				//alert(res);
				var arr=res.split(",");//显示已添加的内容。
				//alert(res[0]);
			    if(arr[1]!=""){
			    	//$('#addallproperty').removeAttr("disabled");
			    	if(types1=="f"){ //父类
			    		//alert("arr[5]="+arr[5]);
			    		returnvalues(res,1);
			    		addnewsuperColumn('f');
			    	}else{        //子类
			    		returnvalues(res,2);
			    		addnewsuperColumn('c');
			    	}
			    }else{
			    	//alert(arr[0]);
			    }
			}
		});
		
}
//修改显示属性
function selectOldProperty(types1){
	//alert("修改="+types1);
	$('#selectOld').attr("disabled","disabled");
	var id;
	var jsons=arrtojson(valarrs);
	//alert("jsons="+jsons);
	if(types1=='c'){
		id=$("#getids1").val();
	}else{
	   id=$("#getids").val();
	}
		$.ajax({
			url:'pdm/addSupperorchidPropertyClassprojt.do',
			type:'post',
			data:{"datas":jsons,"surChild":types1,"clasid":id,"upflags":8},
			error:function(res){
				alert("修改显示属性="+res);
			},
			success:function(res){
				//alert(res);
				var arr=res.split(",");//显示已添加的内容。
				//alert(res[0]);
			    if(arr[1]!=""){
			    	//$('#addallproperty').removeAttr("disabled");
			    	if(types1=="f"){ //父类
			    		//alert("arr[5]="+arr[5]);
			    		addnewsuperColumn('f')
			    		returnvalues(res,1);
			    	}else{        //子类
			    		addnewsuperColumn('c')
			    		returnvalues(res,2);
			    	}
			    }else{
			    	//alert(arr[0]);
			    }
			    //upflag=99999;
			}
		});
		
}
function delarrs(){
	arrs1.splice(0,arrs1.length);
	arrs2.splice(0,arrs2.length);
	arrs3.splice(0,arrs3.length);
}
function updtAlldate(tp,id){//类型，属性ID,总长度
	//alert("修改="+tp+","+id+","+arrs2.length);//是类型，是名称，是否描述，KEY值，value值subcount...
	upflag=99999;
	for(var pst=0;pst<arrs1.length;pst++){
		if(pst==id){
			$('#submits'+pst).show();
			$('#updts'+pst).hide();
	    }else{
	    	$('#updts'+pst).show();
	    	$('#submits'+pst).hide();
	    }
	}
	var subKey = new Array();//key数组
	var kvcot;//当前key,value;
    $.each(subcount,function(i,s){
	   if(typeof($('#tempTit'+s).val())!='undefined'){
		   cots=s;
	   }
    });
  //  alert("cots="+cots);
    //selval=$("input:radio[name='contantType"+cots+"']:checked").val();
    var arradio=$("input:radio[name='contantType"+cots+"']");
    $('#preview'+cots).remove(); 
    $('#addconts'+cots).remove();
    //alert("arrs1.length="+arrs1.length);
    for(var i=0;i<arrs1.length;i++){
    	//alert(arrs1[i]);
	    if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
			arrs2=arrs1[i].split(";");
			if($('#mtexttypes'+id).html()==arrs2[1] && $('#valueall'+id).val()==arrs2[4]){
				$('#tempTit'+(cots)).val(arrs2[1]);
				$('#tempCont'+(cots)).val(arrs2[2]);
				if(arrs2[5] == '1'){
				$.each($("input:radio[name='guige"+cots+"']"),function(index){
					   if($(this).val()==1){
						   $(this).attr('checked',true);   
					   }
				   });
				}else{
					$.each($("input:radio[name='guige"+cots+"']"),function(index){
						   if($(this).val()==0){
							   $(this).attr('checked',true);   
						   }
					   });
				}
				//$("input:radio[name='guige"+cots+"']").attr('checked',true);
				//$(this).attr('checked',true);
				//$('#guige'+(cots)).val(arrs2[5]);
			}
	    }
    }
    
	if(tp==1){
		countj=0;
		upStrin='<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>';
		$('#showvalue').before('<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>');
	    var addproperty1=$('#mtextvalue'+id).val();//value值
	    addTexts(1,0);
	    //alert('addproperty1='+addproperty1);
	    $.each(arrs4,function(j,m){
	  	   if(typeof($('#key'+m).val())!='undefined'){
	  		 kvcot=m;
	  	   }
	      });
	    for(var i=0;i<arrs1.length;i++){
			 if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
		     arrs2=arrs1[i].split(";");
		    // alert($('#valueall'+id).val()+"=="+arrs2[4]);
		    	 $('#value'+(kvcot)).val(addproperty1);
			 }
	    }
	   $.each(arradio,function(index){
		   if($(this).val()==1){
			   $(this).attr('checked',true);   
		   }
	   });

	}
	if(tp==2){
		countj=0;
		upStrin='<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>';
		$('#showvalue').before('<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>');
		   $.each(arradio,function(index){
			   if($(this).val()==2){
				   $(this).attr('checked',true);   
			   }
		   });
		   for(var i=0;i<arrs1.length;i++){
			if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
			arrs2=arrs1[i].split(";");
		    if($('#mtexttypes'+id).html()==arrs2[1] && $('#valueall'+id).val()==arrs2[4]){
		    	subKey=arrs2[3].split("-");
		    	var mstr=arrs2[4].split("-");
		    }
			}
		   }
		  for(var sy=0;sy<subKey.length;sy++){
			   if(subKey[sy]!=""){
			    addTexts(2,1);
			    $('#key'+(arrs4[sy])).val(subKey[sy]); 
			    $('#value'+(arrs4[sy])).val(mstr[sy]);
			   }
		  }
	
	}
	if(tp==3){
		countj=0;
		upStrin='<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>';
		$('#showvalue').before('<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>');
		   $.each(arradio,function(index){
			   if($(this).val()==3){
				   $(this).attr('checked',true);   
			   }
		   });
		   for(var i=0;i<arrs1.length;i++){
				 if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
			     arrs2=arrs1[i].split(";");
			     if($('#mtexttypes'+id).html()==arrs2[1] && $('#valueall'+id).val()==arrs2[4]){
				   subKey=arrs2[3].split("-");
				   var mstr=arrs2[4].split("-");
			     }
				 }
		   }
		   for(var sy=0;sy<subKey.length;sy++){
			   if(subKey[sy]!=""){
				   addTexts(3,1);
			    $('#key'+(arrs4[sy])).val(subKey[sy]); 
			    $('#value'+(arrs4[sy])).val(mstr[sy]);
			   }
		  }
		   
	}
	if(tp==4){
		countj=0;
		upStrin='<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>';
		$('#showvalue').before('<div id="addconts'+cots+'" class="ann" onclick="addTexts('+selval+','+cots+')">增加</div>');
		   $.each(arradio,function(index){
			   if($(this).val()==4){
				   $(this).attr('checked',true);   
			   }
		   });
		   for(var i=0;i<arrs1.length;i++){
				 if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
			     arrs2=arrs1[i].split(";");
			     if($('#mtexttypes'+id).html()==arrs2[1] && $('#valueall'+id).val()==arrs2[4]){
				   subKey=arrs2[3].split("-");
				   var mstr=arrs2[4].split("-");
			     }
				 }
		   }
		   for(var sy=0;sy<subKey.length;sy++){
			   if(subKey[sy]!=""){
				addTexts(4,1);
			    $('#key'+(arrs4[sy])).val(subKey[sy]); 
			    $('#value'+(arrs4[sy])).val(mstr[sy]);
			   }
		  }
		  
	}
	
}
//修改保存
function subtAlldate(type,fuc,pid){
	//添加属性(1.判断文本，下拉，2.名称id,f,c)
	var cots1;//当前count;
	//
    $.each(subcount,function(i,s){
	   if(typeof($('#tempTit'+s).val())!='undefined'){
		   cots1=s;
	   }
    });
	showAddProperty(type,cots1,fuc,pid);
	for(var pst=0;pst<arrs1.length;pst++){
		  $('#updts'+pst).show();
		  $('#submits'+pst).hide();
	}
	upflag=0;
}
//删除
function delvalArr(type,fuc,pid,mpps){
	var cots1;//当前count;
    $.each(subcount,function(m,s){
		   if(typeof($('#tempTit'+s).val())!='undefined'){
			   cots1=s;
		   }
	});
	if(upflag==99999){
		//alert(11111);
		upStrin='';
		for(var i=0;i<arrs1.length;i++){
			//alert(arrs1[i]+"=="+mpps);
			if(arrs1[i]==mpps){
				arrs1.splice(i,1);
			}
		}
		$('#trs'+pid).remove();
	    showAddProperty(type,cots1,fuc,pid);
	}else{
		//alert("删除11111="+mpps);
		cots1=encodeURI(mpps,"utf-8");
		delarrs();
		valarrs.splice(0,valarrs.length);
		subcount.splice(0,subcount.length);
		rdid=0;
		$('#Resultaddproperty').html('');
        $.ajax({
           type:'post',
           url:'pdm/delSupperOrChildClassprojt.do',
           data:{"condels":cots1},
           success:function(res){
        	   //alert(res);
        	   var delres = new Array();
        	   delres=res.split(",");
        	   //alert(delres[0]);
        		if(fuc==1){ //父类   
		    		returnvalues(delres[1],1,"del");
		    	}else{        //子类
		    		returnvalues(delres[1],2,"del");
		    	}
           }
        });
		$('#trs'+pid).remove();
	}
}
function returnvalues(allString,fc,ps){
	      //alert('父子='+allString+","+fc);
	     delarrs();
	     var arrs=new Array();
		 var flag=0;
		 var mx="";
		 $('#Resultaddproperty').html('');
		if(ps=="del"){
			 arrs1=allString.split("^");
		}else{
			arrs=allString.split(",");
		    arrs1=arrs[5].split("^");
		}
		for(var i=0;i<arrs1.length;i++){
	     if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
	    	 flag=1;
	    	 arrs2=arrs1[i].split(";");
	    	 arrs3=arrs2[4].split("-");
	    	 if(arrs2[0]==1){
	    		 mx+='<tr id="trs'+i+'"><td align="center"><span id="mtexttypes'+i+'">'+arrs2[1]+'</span><input type="hidden" id="valueall'+i+'" value="'+arrs2[4]+'"></td>';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				mx+='<td align="center"><input type="text" size="10" id="mtextvalue'+i+'" value="'+arrs3[j]+'" readonly></td>';
	    				mx+='<td align="center">&nbsp;&nbsp;&nbsp;描述：<input type="text" size="10" id="mdiscription'+i+'" value="'+arrs2[2]+'" readonly></td>'
//	    				if(arrs3[j]=="无"){
//	    					$('#mtextvalue'+i).val("");
//	    				}else{
//	    					$('#mtextvalue'+i).val(arrs3[j]);
//	    				}
	    			}
	    		
	    		 }
	    		 //condels=arrs1[i];
	    		 mx+='<td><a href="javascript:void(0);" onclick="updtAlldate('+1+','+i+')" id="updts'+i+'"  style="color:red;">修改</a><a href="javascript:void(0);" onclick="subtAlldate(1,'+fc+','+i+')" id="submits'+i+'" style="display:none;color:red;">保存</a>&nbsp;&nbsp;<a href="javascript:delvalArr(1,'+fc+','+i+','+'\''+arrs1[i]+'\')'+'" style="color:red;">删除</a></td><tr>';
	    	 }
			 if(arrs2[0]==2){
				 mx+='<tr id="trs'+i+'"><td align="center"><span id="mtexttypes'+i+'">'+arrs2[1]+'</span><input type="hidden" id="valueall'+i+'" value="'+arrs2[4]+'"></td><td align="center"><select id="mSelvalue'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				mx+='<option value="'+arrs3[j]+'">'+arrs3[j]+'</option>';
	    			}
	    		 }
	    		 mx+='</select></td>';
	    		mx+='<td align="center">&nbsp;&nbsp;&nbsp;描述：<input type="text" size="10" id="mdiscription'+i+'" value="'+arrs2[2]+'" readonly></td><td><a href="javascript:void(0);" onclick="updtAlldate('+2+','+i+')" id="updts'+i+'" style="color:red;">修改</a><a href="javascript:void(0);" onclick="subtAlldate(2,'+fc+','+i+')" id="submits'+i+'" style="display:none;color:red;">保存</a>&nbsp;&nbsp;<a href="javascript:delvalArr(1,'+fc+','+i+','+'\''+arrs1[i]+'\')'+'" style="color:red;">删除</a></td></tr>';
			 }
			 if(arrs2[0]==3){
				 mx+='<tr id="trs'+i+'"><td align="center"><span id="mtexttypes'+i+'">'+arrs2[1]+'</span><input type="hidden" id="valueall'+i+'" value="'+arrs2[4]+'"></td><td align="center" ><span id="radalls'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				if(j%5==0){
	    				    mx+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"<br>";
	    				}else{
	    					mx+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"&nbsp;&nbsp;";	
	    				}
	    			}
	    		 }
	    		 mx+='</span></td>';
	    	     mx+='<td align="center">&nbsp;&nbsp;&nbsp;描述：<input type="text" size="10" id="mdiscription'+i+'" value="'+arrs2[2]+'" readonly></td><td><a href="javascript:void(0);" onclick="updtAlldate('+3+','+i+')" id="updts'+i+'"  style="color:red;">修改</a><a href="javascript:void(0);" onclick="subtAlldate(3,'+fc+','+i+')" id="submits'+i+'" style="display:none;color:red;">保存</a>&nbsp;&nbsp;<a href="javascript:delvalArr(1,'+fc+','+i+','+'\''+arrs1[i]+'\')'+'" style="color:red;">删除</a></td></tr>';
			 }
			 if(arrs2[0]==4){
				 mx+='<tr id="trs'+i+'"><td align="center"><span id="mtexttypes'+i+'">'+arrs2[1]+'</span><input type="hidden" id="valueall'+i+'" value="'+arrs2[4]+'"></td><td align="center"><span id="radalls'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				if(j%5==0){
	    				   mx+='<input type="radio" name="mradiovalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"<br>";
	    				}else{
	    					 mx+='<input type="radio" name="mradiovalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"&nbsp;&nbsp;";
	    				}
	    			}
	    		 }
	    		 mx+='</span></td>';
	    		 mx+='<td align="center">&nbsp;&nbsp;&nbsp;描述：<input type="text" size="10" id="mdiscription'+i+'" value="'+arrs2[2]+'" readonly></td><td><a href="javascript:void(0);" onclick="updtAlldate('+4+','+i+')" id="updts'+i+'" style="color:red;">修改</a><a href="javascript:void(0);" onclick="subtAlldate(4,'+fc+','+i+')" id="submits'+i+'" style="display:none;color:red;">保存</a>&nbsp;&nbsp;<a href="javascript:delvalArr(1,'+fc+','+i+','+'\''+arrs1[i]+'\')'+'" style="color:red;">删除</a></td></tr>';
			 }
			 //alert(mx);
			 //$('#Resultaddproperty').append('<table id="mytabs">'+mx+'</table>');
		 }
		}
		$('#Resultaddproperty').append('<table id="mytabs">'+mx+'</table>');
		//
		if(flag==0){
			  mx='<tr><td align="center" colspan="3">暂没有找到可用的属性</td></tr>';
			 $('#Resultaddproperty').append('<table id="mytabs">'+mx+'</table>');
		}
}
//增加key和value值
function addTexts(type,p){ 
	   countj++;
	   //alert("key-Value="+type+"="+p);
	   if(upflag==99999 && upStrin!=''){
	      type=$("input:radio[name='contantType"+cots+"']:checked").val();
	       selval=type;
	        if(countj==1){
	         uplook='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div id="preview'+cots+'" class="ann" onclick="showPreview('+type+','+cots+')">效果预览</div>';
			 $('#allclassids'+cots).append(uplook);
	        }
	   }
      // alert("key-Value="+type+"="+$('#showvalue').html()+"...."+ks);
        if($('#tempTit'+p).val()!=''){
        if(type==1 || typeof(type)=='undefined'){	
        	if($('#showvalue').html()==''){
		       $('#showvalue').append('<div id="keyOrvalue'+ks+'"><span style="margin-left:40px;">KEY'+(ks+1)+':<input type="text" id="key'+ks+'" disabled  size="5" value="'+(ks+1)+'" style="border:0px;"></span><span style="margin-left:15px;">VALUE'+(ks+1)+':<input type="text" id="value'+ks+'"></span><span style="color:red;font-size:12px;"><div>');
			   	arrs5.push(ks);
				arrs4.push(ks);
				ks++;
				if(upflag!=99999){
				   $('#confirmAdd'+p).removeAttr('disabled');
				}
				$('#preview'+p).removeAttr('disabled');
        	}else{
        	    alert("文本框不能重复添加。");	
        	}
        }else{
        	 $('#showvalue').append('<div id="keyOrvalue'+ks+'"><span style="margin-left:40px;">KEY'+(ks+1)+':<input type="text" id="key'+ks+'" disabled  size="5" value="'+(ks+1)+'" style="border:0px;"></span><span style="margin-left:15px;">VALUE'+(ks+1)+':<input type="text" id="value'+ks+'"></span><span style="color:red;font-size:12px;"><input type="radio" name="tradios'+p+'" onclick="delproperty('+ks+')"><a href="javascript:delproperty('+ks+');">删除</a></span><div>');
        		arrs5.push(ks);
        		arrs4.push(ks);
        		ks++;
        		if(upflag!=99999){
        		  $('#confirmAdd'+p).removeAttr('disabled');
        		}
				$('#preview'+p).removeAttr('disabled');
        }
        }else{
             alert('属性名称不能为空。');	
        }
      
}

function delproperty(id){
	//alert("id="+id+","+arrs5.length);
	if(arrs5.length>1){
	   arrs4.splice(0,arrs4.length);
	   for(var i=0;i<arrs5.length;i++){
		 if(arrs5[i]==id){
			arrs5.splice(i,1);
			//alert(arrs5[i]+","+id);
		 }
		 if(typeof(arrs5[i])!='undefined'){
			 arrs4.push(arrs5[i]);
		 }
	   }
	   if(upflag==99999){///////////////////////////////////////////////////////////////////////////
		  
	   }
	   //alert("arrs4="+arrs4.length);
	   $('#keyOrvalue'+id).remove();
	}else{
	    alert("至少要留下一个属性。");	
	}
}

//修改
function upcom(mp){
		//alert($('#updat88').html());
		if(mp==1){
	     if($('#updat88').html()=='修改'){// $('#addButton').append('<div id="updat88" class="ann"><span id="upd888">修改</span></div>');
	    	//$('#isaddColumn').hide();
	    	$('#gdnames').removeAttr("disabled");
	 		$('#gdcodes').removeAttr("disabled");
	 		$('#gdnames').removeAttr("disabled");
	 		$('#gdWriteTime').removeAttr("disabled");
	 	    $("#addColumn").removeAttr("disabled");
	 	    $('#updat88').remove();
	 	    $('#addButton').append('<div id="upd999" class="ann" onclick="confirm(1)">确认修改</div>');
	        $('#subdate').remove();
	     }
	     }else{
	    	 if($('#updat88').html()=='修改'){
	    	 $('#childCodes').removeAttr("disabled");
			 $('#childNames').removeAttr("disabled");
			 $('#writetime').removeAttr("disabled");
			 $('#superCodes').removeAttr("disabled");
			 $('#superNames').removeAttr("disabled");
			 $("#addColumn").removeAttr("disabled");
			 $('#updat88').remove();
		 	 $('#addButton').append('<div id="upd999" class="ann" onclick="confirm(2)">确认修改</div>');
		     $('#subdate').remove();
	    	 }
	     }
}
//确认修改
 function confirm(ms){
		//alert($('#upd999').html());
		if($('#upd999').html()=='确认修改'){
			$('#upd999').remove();
			if(ms==1){
			 $('#addButton').append('<div id="updat88" class="ann" onclick="upcom(1)">修改</div>');
			 $('#subdate').remove();
	    	 arrs('f',2);
			}else{
				 $('#addButton').append('<div id="updat88" class="ann" onclick="upcom(2)">修改</div>');
				 $('#subdate').remove();
		    	 arrs('c',2);
			}
	     }
		
       }
//Class增加的,修改
function arrs(type,nx){
	var idy;
	subcount.splice(0,subcount.length);
	if($('#gdnames').val()==''){
		$("#ferrorName").html('<font color="red">父类名称不能为空</font>');
	    return false;	
	}
	$("#ferrorName").html('');
	if(type=="f"){
	if(nx==2 || nx==3){
	    idy=$("#getids").val();
	    //alert("idy="+idy);
	}
    var classcode=$('#gdcodes').val();
    var classname=encodeURI($('#gdnames').val(),"utf-8");
    var classtime=$('#gdWriteTime').val();
    var classContent;
    if($("input[name='gdsuperWritename']:checkbox:checked").length>0){
    	classContent=1;
    }else{
    	classContent=0;
    }
	$.ajax({
		url:'pdm/addSupperorchidFrontClassprojt.do',
		type:'post',
		data:{"surChild":type,"classcode":classcode,"classname":classname,"classtime":classtime,"classContent":classContent,"nxClass":nx,"upids":idy},
		error:function(res){
			alert(res);
		},
		success:function(res){
			up1++;
			var arr=res.split(",");
		//	alert(arr[0]);
			if(arr[1]==1){
				$('#isaddColumn').show();
			}else{
				$('#isaddColumn').hide();
			}
			$("#gdWritename").val(arr[1]);
			$("#getids").val(arr[2]);
			if(nx==2){
			$('#gdnames').attr("disabled",true);
			$('#gdcodes').attr("disabled",true);
			$('#gdnames').attr("disabled",true);
			$('#gdWriteTime').attr("disabled",true);
		    $("#addColumn").attr("disabled","disabled");
			}
		    if(up1==1){
			      $('#addButton').append('<div id="updat88" class="ann" onclick="upcom(1)">修改</div>');
			      $('#subdate').remove();
			}
			if(nx==3){
			     location.reload();	
			}
		}
	});
	}else{
		    if($('#childNames').val()==''){
		    	$("#cerrorName").html('<font color="red">子类名称不能为空</font>');
		        return false;	
		    }
		    $("#cerrorName").html('');
		    var codes=$('#childCodes').val();
		    var names=encodeURI($('#childNames').val(),"utf-8");
		    var times=$('#writetime').val();
		    var Contents;
		    if($("input[name='gdchildWritename1']:checkbox:checked").length>0){
		    	Contents=1;
		    }else{
		    	Contents=0;
		    }
		    if(nx==2 || nx==3){
			    idy=$("#getids1").val();
			    //alert("idy="+idy);
			}
		    var supcodes=$('#superCodes').val();
		    var supnames=$('#superNames').val();
		    var supperids=$('#getsupids').val();
		    $.ajax({
				url:'pdm/addSupperorchidFrontClassprojt.do',
				type:'post',
				data:{"surChild":type,"classcode":codes,"classname":names,"classtime":times,"classContent":Contents,"superCodes":supcodes,"supnid":supperids,"nxClass":nx,"upids":idy},
				error:function(res){
					alert(res);
				},
				success:function(res){
					//alert(res);
					up2++;
					var arr=res.split(",");
					//alert(arr[0]);
					if(arr[1]==1){
						$('#isaddColumn').show();
					}else{
						$('#isaddColumn').hide();
					}
					 $("#gdWritename").val(arr[1]);
					 $("#getids1").val(arr[2]);
					 if(nx==2){
					 $('#childCodes').attr("disabled",true);
					 $('#childNames').attr("disabled",true);
					 $('#writetime').attr("disabled",true);
					 $('#superCodes').attr("disabled",true);
					 $('#superNames').attr("disabled",true);
					 $("#addColumn").attr("disabled","disabled");
					 }
					 if(up2==1){
					      $('#addButton').append('<div id="updat88" class="ann" onclick="upcom(2)">修改</div>');
					      $('#subdate').remove();
					 }
					if(nx==3){
					 location.reload();	
					}
				}
			});
	}
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
function outMenus(){
	location.href=$('#path').val()+"pdm/splitpagesClassprojt.do";
}