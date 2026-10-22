var count=0;
var upcount=0;
var valarrs = new Array();
var subcount = new Array();//保存count;
var arrs1=new Array();
var arrs2=new Array();
var arrs3=new Array();
var arrcount=0;     //数据记数器
var ks=0          //key记数器
var rdid="";     //单选框id
function tabselct(obj){
      if(obj.style.backgroundColor!=""){
    	  obj.style.backgroundColor="";
      }else{
    	  obj.style.backgroundColor="#e6ffd5";
      }
}
function getfoucs(){
	document.getElementById("submid").focus();
}
function menuaddsa(ps,cont,name,id){
	//alert("增加超类和子类11");
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
	    	    location.href=$('#path').val()+"product_manage/page/add.jsp?classcodes="+res;
	    	}else{
	    		var mpps=encodeURI(name,"utf-8");
	    	    $.post($('#path').val()+"pdm/showchildsClassprojt.do",{"supcode":cont,"classcodes":res,"supnames":mpps,"suppids":id},function(res){
	    	    	location.href=$('#path').val()+"product_manage/page/addChild.jsp";
	    	    });
	    		
	    	}
	    }
	});
}
//编码在用
function getallCodes(ps,cont,name,id){
	//alert("增加超类和子类a");
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
	    	    location.href=$('#path').val()+"product_manage/page/add.jsp?classcodes="+res;
	    	}else{
	    		var mpps=encodeURI(name,"utf-8");
	    	    $.post($('#path').val()+"pdm/showchildsClassprojt.do",{"supcode":cont,"classcodes":res,"supnames":mpps,"suppids":id},function(res){
	    	    	location.href=$('#path').val()+"product_manage/page/addChild.jsp";
	    	    });
	    		
	    	}
	    }
	});
}
function delarrs(){
	valarrs.splice(0,valarrs.length);
    subcount.splice(0,subcount.length);
}
function showaddChild(id,code,name){
	//alert("子="+id+","+code+","+name);
	arrcount=0;
	delarrs();
	getallCodes("c",code,name);
    showDiv(id);
}
function showAddSupper(id){
	arrcount=0;
	delarrs();
	getallCodes("f","no");
	showDiv(id);
}
function closeAddSupper(id){
	$("input[name='gdsuperWritename']").attr("checked",false);
	$("input[name='gdchildWritename']").attr("checked",false);
	addClumn1();
	addChildColumn1();
	//$('#gdnames').val('');
	self.location.reload();
	removeDiv(id);
}
//添加父类字段
function addnewsuperColumn(){
  if($("input[name='checkall']").length<15){
   if($("input[name='gdsuperWritename']:checkbox:checked").length>0){
	   $('#gdWritename').val('1');
	   //增加显示文本框
	   $('#addFields').append('<br><div id="fourclassids'+count+'" style="color:#000000;border:1px solid #8e99b7;margin-left:60px;width:600px;font-size:12px;"><span id="addtypes'+count+'" style="margin-left:50px;">属性类型:<input type="radio" name="contantType'+count+'" id="'+count+'" checked value="1" onclick="showAlltype(this.value,this.id)">文本框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'"  id="'+count+'"  value="2" onclick="showAlltype(this.value,this.id)">下拉框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'" value="3" onclick="showAlltype(this.value,this.id)">多选框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'"  value="4" onclick="showAlltype(this.value,this.id)">单选框</span><input type="hidden" id="divid"><input type="hidden" id="addpositions'+count+'" value="addtypes'+count+'"></div>');
	   $('#divid').val("addFields");
	   var m=1;
	   subcount.push(count);
	   showAlltype(m,count);
   }
   count++;
   conmentAll();
  }else{
	  alert("对不起，只能增加15条数据");   
  }
}
function showAlltype(mp,mids){
	       ks=0;
	       var divid=$('#divid').val();
	       var mid=parseInt(mids);
	       var ppm=$('#addpositions'+mid).val();
	       //alert('click='+divid+","+mid+","+ppm);
	       $('#allclassids'+mid).remove();
	       $('.pmn'+mid).remove();
	       if(mp==1){     //文本
     	        $('#'+ppm).before('<input type="checkbox" name="checkall" id="'+mid+'" title="批量删除" class="pmn'+mid+'">');
		        $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;"><br><span id="addnames'+mid+'" style="margin-left:110px;font-size:12px;">名称'+(mid+1)+':</span><input type="text" size="20" name="tempTit'+mid+'" id="tempTit'+mid+'" onblur="dealDatas(this.id)"/><span style="color:red;font-size:12px;">名称必填</span><br><span id="addcontents'+mid+'" style="margin-left:110px;font-size:12px;">是否必填'+(mid+1)+':</span><input type="radio" size="30" name="tempCont'+mid+'" value="1" checked/>是<input type="radio" size="30" name="tempCont'+mid+'" value="0"/>否<br><span style="margin-left:110px;">KEY'+(mid+1)+':<input type="text" readonly id="key'+mid+'" size="5" style="border:0px;"></span><span style="margin-left:50px;">VALUE'+(mid+1)+':<input type="text" id="value'+mid+'"></span><span style="color:red;font-size:12px;">value值必填</span>&nbsp;&nbsp;<div id="addconts'+mid+'" class="ann" onclick="addTexts('+mid+')">增加</div><div id="showvalue'+mid+'" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"><span id="texty'+mid+'"></span><span id="teval'+mid+'"></span></div></div>');
	    	}
		   if(mp==2){     //下拉
			      $('#'+ppm).before('<input type="checkbox" name="checkall" id="'+mid+'" title="批量删除" class="pmn'+mid+'">');
			      $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;"><br><span id="addnames'+mid+'" style="margin-left:110px;font-size:12px;">名称'+(mid+1)+':</span><input type="text" size="20" name="tempTit'+mid+'" id="tempTit'+mid+'" onblur="dealDatas(this.id)"/><span style="color:red;font-size:12px;">名称必填</span><br><span id="addcontents'+mid+'" style="margin-left:110px;font-size:12px;">是否必填'+(mid+1)+':</span><input type="radio" size="30" name="tempCont'+mid+'" value="1" checked/>是<input type="radio" size="30" name="tempCont'+mid+'" value="0"/>否<br><span style="margin-left:110px;">KEY'+(mid+1)+':<input type="text" readonly id="key'+mid+'" size="5" style="border:0px;"></span><span style="margin-left:50px;">VALUE'+(mid+1)+':<input type="text" id="value'+mid+'"></span><span style="color:red;font-size:12px;">value值必填</span>&nbsp;&nbsp;<div id="addconts'+mid+'" class="ann"  onclick="addSelect('+mid+')">增加</div><div id="showvalue'+mid+'" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"><span id="sectty'+mid+'"></span><select id="sectval'+mid+'" name="sectval'+mid+'" selected></select></div></div>');
		   }
		   if(mp==3){     //多选
			      $('#'+ppm).before('<input type="checkbox" name="checkall" id="'+mid+'" title="批量删除" class="pmn'+mid+'">');
			      $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;"><div style="display: inline;"><br><span id="addnames'+mid+'" style="margin-left:110px;font-size:12px;">名称'+(mid+1)+':</span><input type="text" size="20" name="tempTit'+mid+'" id="tempTit'+mid+'" onblur="dealDatas(this.id)"/><span style="color:red;font-size:12px;">名称必填</span><br><span id="addcontents'+mid+'" style="margin-left:110px;font-size:12px;">是否必填'+(mid+1)+':</span><input type="radio" size="30" name="tempCont'+mid+'" value="1" checked/>是<input type="radio" size="30" name="tempCont'+mid+'" value="0"/>否<br><span style="margin-left:110px;">KEY'+(mid+1)+':<input type="text" size="5" readonly id="key'+mid+'" style="border:0px;"></span><span style="margin-left:50px;">VALUE'+(mid+1)+':<input type="text" id="value'+mid+'"></span><span style="color:red;font-size:12px;">value值必填</span>&nbsp;&nbsp;<div id="addconts'+mid+'" class="ann" onclick="addCheckbox('+mid+')">增加</div><div id="showvalue'+mid+'" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"><span id="chekty'+mid+'"></span><span id="teval'+mid+'"></span></div></div>');
		   }
		   if(mp==4){     //单选
			     
			      $('#'+ppm).before('<input type="checkbox" name="checkall" id="'+mid+'" title="批量删除" class="pmn'+mid+'">');
			      $('#'+divid).append('<div id="allclassids'+mid+'" style="border:1px solid #8e99b7;width:600px;margin-left:60px;font-size:12px;"><div style="display: inline;"><br><span id="addnames'+mid+'" style="margin-left:110px;font-size:12px;">名称'+(mid+1)+':</span><input type="text" size="20" name="tempTit'+mid+'" id="tempTit'+mid+'"  onblur="dealDatas(this.id)"/><span style="color:red;font-size:12px;">名称必填</span><br><span id="addcontents'+mid+'" style="margin-left:110px;font-size:12px;">是否必填'+(mid+1)+':</span><input type="radio" size="30" name="tempCont'+mid+'" value="1" checked/>是<input type="radio" size="30" name="tempCont'+mid+'" value="0"/>否<br><span style="margin-left:110px;">KEY'+(mid+1)+':<input type="text" size="5" readonly id="key'+mid+'" style="border:0px;"></span><span style="margin-left:50px;">VALUE'+(mid+1)+':<input type="text" id="value'+mid+'"></span><span style="color:red;font-size:12px;">value值必填</span>&nbsp;&nbsp;<div id="addconts'+mid+'"  class="ann" onclick="addRadio('+mid+')">增加</div><div id="showvalue'+mid+'" style="margin-left:30px;width:400px;height:100px;overflow: auto;border:1px solid #8e99b7;text-align:center;"><span id="radty'+mid+'"></span><span id="teval'+mid+'"></span></div></div>');
			}  
		   $("#key"+mid).val(++ks);
		   	
  }
//设置数组(值是count)
function confirmArrs(){
	       var rads=0;
	       var mp1=0;
	       var contents="";
	       for(var i=0;i<subcount.length;i++){
	       //alert("subcount[i]="+subcount[i]);
	       var warr=$('input:radio[name="tempCont'+subcount[i]+'"]:checked');
	       var mp=$('input:radio[name="contantType'+subcount[i]+'"]:checked');
	       //alert("warr="+warr+","+mp);
		   rads=warr.val();
		   mp1=mp.val();
		   //alert("rads="+rads+","+mp1);
		   valarrs.push(i);
		   if(mp1=="1"){
			   contents="";
			   contents=$('#tetyval').val();
		   }
		   if(mp1=="2"){
			   contents="";
			   $('#sectval'+subcount[i]+'>option').each(function(){
				  // alert("msarrs1="+$(this).text());
			      contents+=$(this).text()+"-";
			   });
		   }
		   if(mp1=="3"){
			   contents="";
			   var parrys=$('input[name="checkbval'+subcount[i]+'"]');
			   //alert("parrys="+parrys.length);
			   $.each(parrys,function(index){
				   //alert("parrys="+$(this).val());
				   contents+=$(this).val()+"-";
			   });
			   
		   }
		   if(mp1=="4"){
			   contents="";
			   var rad=document.getElementsByName("radioval"+subcount[i]);
			   for(var j=0;j<rad.length;j++){
				  // alert("parrys="+rad[j].value);
			      contents+=rad[j].value+"-";
			   }
		   }
		   values=mp1+";"+$('#tempTit'+subcount[i]).val()+";"+rads+";"+ $("#key"+subcount[i]).val()+";"+contents
		   var names=encodeURI(values,"utf-8");
		   //alert("数组="+names);
		   //是类型，是名称，是否必填，KEY值，value值
		   if(names!='undefined;undefined;undefined;undefined;'){
		       valarrs.push(names);
		   }
		  // arrcount++;
	       }
}
function dealDatas(dat){
	document.getElementById(dat).disabled="true";
}
function delnewColumn(){
	var che = $("input[name='checkall']:checkbox:checked");
	if(che.length>0){
	if(confirm("你确定要删除吗")){
		$.each(che,function(i,item){
			   $("input[name='tempCont"+item.id+"']").remove();	
			   $("input[name='tempTit"+item.id+"']").remove();
			   $('#addnames'+item.id).remove();
			   $('#addcontents'+item.id).remove();
			   $('#addtypes'+item.id).remove();
			   $('#allclassids'+item.id).remove();
			   $('#fourclassids'+item.id).remove();
		});
	}
	}else{
	   alert("请选择要删除的字段");	
	}
}
function conmentAll(){
	 if(count>0){
	       for(var i=0;i<(count-1);i++){
	    	   var mp=$("input[name='contantType"+i+"']");
	    	   $.each(mp,function(index,item){
	    		  //alert(item.id+"=it");
	    		  $(this).attr("disabled","true");
//	    		  var len=document.getElementsByName("tempCont"+item.id);
//	    		  var lengt=document.getElementsByName("tempTit"+item.id);
//	    		  for(var j=0;j<len.length;j++){
//	    		   len[j].readOnly="true";
//	    		   lengt[j].readOnly="true";
//	    		  }
	    	   });
	    	 
		}
		}  
}
function getdivid(rid){
	//alert(rid);
	rdid=rid;
}
//添加子类字段
function addnewChildColumn(){
	 if($("input[name='checkall']").length<15){
	   if($("input[name='gdchildWritename']:checkbox:checked").length>0){
		   $('#addchildFields').append('<br><div id="fourclassids'+count+'" style="color:#000000;border:1px solid #8e99b7;margin-left:60px;width:600px;font-size:12px;"><span id="addtypes'+count+'" style="margin-left:50px;">属性类型:<input type="radio" name="contantType'+count+'" id="'+count+'" checked value="1" onclick="showAlltype(this.value,this.id)">文本框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'"  value="2" onclick="showAlltype(this.value,this.id)">下拉框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'"  value="3" onclick="showAlltype(this.value,this.id)">多选框&nbsp;&nbsp;<input type="radio" name="contantType'+count+'" id="'+count+'" value="4" onclick="showAlltype(this.value,this.id)">单选框</span><input type="hidden" id="divid"><input type="hidden" id="addpositions'+count+'" value="addtypes'+count+'"></div>');
		   $('#divid').val("addchildFields");
		   var m=1;
		   subcount.push(count);
		   showAlltype(m,count);
		   $('#gdWritename').val('1');
	   }
	   count++;
	   conmentAll();
	 }else{
		 alert("对不起，只能增加15条数据"); 
	 }
	}
function delalldata(){
	$('#gdWritename').val('0');
	for(var i=0;i<count;i++){
		  $("input[name='tempCont"+i+"']").remove();	
		  $("input[name='tempTit"+i+"']").remove();
		  $('#addnames'+i).remove();
		  $('#addcontents'+i).remove();
		  $('#addtypes'+i).remove();
		  $('#allclassids'+i).remove();
	      $('#fourclassids'+i).remove();
	 }
}
function addClumn1(){
	  if($("input[name='gdsuperWritename']:checkbox:checked").length>0){
		   $('#addFields').show();
	       $("#addButton").append('<div onclick="addnewsuperColumn()" class="ann" >添加</div>&nbsp;&nbsp;&nbsp;&nbsp;<div onclick="delnewColumn()"  class="ann">批量删除</div>');
	  }else{
		  $("#addButton").html('');
		  count=0;
		  $('#addFields').hide();
		  $('#addFields').html('');
		  delalldata();
	  }
}
function addChildColumn1(){
	 if($("input[name='gdchildWritename']:checkbox:checked").length>0){
		   $('#addchildFields').show();
	       $("#addChildButton").append('<div onclick="addnewChildColumn()" class="ann">添加</div>&nbsp;&nbsp;&nbsp;&nbsp;<div onclick="delnewColumn()" class="ann">批量删除</div>');
	  }else{
		  $("#addChildButton").html('');
		  $('#addchildFields').hide();
		  $('#addchildFields').html('');
		  count=0;
		  delalldata();
	  }
}


//增加文本       texty,teval tempTit,tempCont
function conments(p){
	var mp1=$("#tempTit"+p).val();
	var mp2=$("#value"+p).val();
	if(mp1!="" && mp2!=""){
		if(ks!=1){
		   $("#key"+p).val(ks);
		}
	}else{
	   alert("请填写名称和value值。");	
	}
}
function removeVal(pm,m){
	if(pm=='请填写修改内容')
	{
		$('#'+m).val("");
     }
}
function updDat(ms,id){
	//alert("ms="+ms+",id="+id);
	if(ms==1){
		if($('#te'+id).html()=='修改'){
		  document.getElementById("tetyval").removeAttribute("readOnly");
		  $('#te'+id).html('保存');
		}else{
			document.getElementById("tetyval").readOnly="true";
			$('#te'+id).html('修改');
		}
	}
	if(ms==2){
		if($('#se'+id).html()=='修改'){
			upcount++;
			$('#sectval'+id).after(((upcount==0)?'&nbsp;&nbsp;':'')+'<input type="text"  size="10"  id="upval'+id+'" value="请填写修改内容" onfocus="removeVal(this.value,this.id)">'+((upcount==1)?'&nbsp;&nbsp;':''));
			$('#se'+id).html('保存');
		}else{
			var val=document.getElementById("sectval"+id).options;
			//alert("vm="+val.length+",");
			$('#sectval'+id+'>option').each(function(){
			    if($(this).attr('selected')==true)
			    {
			      var values=$(this).val();
			      $(this).remove();
			      $('#sectval'+id).append('<option value="'+values+'" selected>'+$('#upval'+id).val()+'<option>');
			    }
			    if($(this).text()==""){
			    	$(this).remove();
			    }
			  })
			//$('#sectval'+id).append($('#upval'+id).val());
			$('#upval'+id).remove();
			$('#se'+id).html('修改');
		}
	}
	if(ms==3){//chekall  
		var len=document.getElementsByName("checkbval"+id);
		if($('#ckalls'+id).html()=='批量修改'){
			for(var j=0;j<len.length;j++){
			if(len[j].checked){
	        		//alert("3="+len[j].name+","+len[j].value);
	        		$("input[name='"+len[j].name+"']").eq(j).after('<input type="text" id="chektet'+j+'" size="10" value="'+len[j].value+'" onblur="getvals(this.id,"'+len[j].value+'")">&nbsp;&nbsp;');
			}
			}
			$('#ckalls'+id).html('批量保存');
		}else{///////////////////////////////////////////////////////////////////////////////
			  var arrs=document.getElementsByName("checkbval"+id);
			 // alert("arrs.length="+arrs.length);
			  for(var i=0;i<arrs.length;i++){
				  var pmt=$('#chektet'+i).val();
				  if(arrs[i].checked){
					  //alert(arrs[i].id+","+i);
					  $('#chektet'+i).remove();
					  $('#'+arrs[i].id).html('<input type="checkbox" name="checkbval'+id+'" id="'+arrs[i].id+'" value="'+pmt+'">'+pmt+'&nbsp;&nbsp;');
			      }
			  }
			  $('#ckalls'+id).html('批量修改');
		}
	}
	if(ms==4){
		var rad=document.getElementsByName("radioval"+id);
		if($('#radspan'+id).html()=='修改'){
			for(var j=0;j<rad.length;j++){
				if(rad[j].checked){
				   $("input[name='"+rad[j].name+"']").eq(j).after("<input type='text' value='"+rad[j].value+"' size='10' id='rdio"+j+"'>")	
				}
			}
				$('#radspan'+id).html('保存');
		}else{
			for(var i=0;i<rad.length;i++){
				  var pmn=$('#rdio'+i).val();
				  if(rad[i].checked){
					  //alert(pmn+","+i);
					  $('#rdio'+i).remove();
					  $('#'+rdid).html('');
					  $('#'+rdid).html('<input type="radio" name="radiobval'+id+'"  value="'+pmn+'">'+pmn+'&nbsp;&nbsp;');
				  }
				  
			  }
			$('#radspan'+id).html('修改');
		}
	}
}
//为空时显示原有的值
function getvals(ids,mpp){
	if(mpp=="" || mpp==null){
		//alert(0);
	}else{
		//alert(1);
		$('#'+ids).val(mpp);
	}
}
function delDat(ms,id){
	//alert("ms="+ms+",id="+id);
	if(ms==1){
		if(confirm("你确定要删除吗？")){
			$('#texty'+id).html('');
			$('#teval'+id).html('');
			$('#value'+id).val('');
			$("#tempTit"+id).val('');
			ks=1;
			$("#tempTit"+id).attr('disabled',false);
		}
	}
	if(ms==2){
		if(confirm("你确定要删除吗？")){
		   $('#sectval'+id).find("option:selected").remove();
			if($('#sectval'+id).find("option:selected").text()==""){
				$('#texty'+id).html('');
				$('#sectval'+id).empty();
				$('#sectty'+id).html('');
				$("#tempTit"+id).val('');
				$("#chkSelt"+id).html('');
				$('#value'+id).val('');
				ks=1;
				$("#tempTit"+id).attr('disabled',false);
			}
		}
	}
	if(ms==3){ //////////////////////////////////////////////////////////////////////////// //chekall
		if($("input[name='checkbval"+id+"']:checkbox:checked").length>0){
			var msn=$("input[name='checkbval"+id+"']");
		       // alert("len="+msn.length);
			for(var i=0;i<msn.length;i++){
			    if(msn[i].checked){
			    	 //alert("checkbox="+msn[i].id);
			    	 $('#'+msn[i].id).remove();
			    }
			}
			if($("input[name='checkbval"+id+"']").length==0){
				$("#tempTit"+id).val('');
				$('#chekty'+id).html('');
				$('#value'+id).val('');
				ks=1;
				$("#tempTit"+id).attr('disabled',false);
			}
		}else{
			alert("请选择要删除的项。");
		}
	}
	if(ms==4){
		if($("input:radio[name='radioval"+id+"']:checked")){
			//alert("del");
			$('#'+rdid).remove(); 
			if($("input:radio[name='radioval"+id+"']").length==0){
				$("#tempTit"+id).val('');
				$('#radty'+id).html('');
				$('#value'+id).val('');
				ks=1;
				$("#tempTit"+id).attr('disabled',false);
			}
		}else{
			alert("请选择要删除的项。");
		}
	}
}
//增加value值
function addTexts(p){
   // alert("1="+$('#teval'+p).html());
  if($('#teval'+p).html()=="" || $('#teval'+p).html()==null){
	if(ks>1){
		 $('#teval'+p).append("&nbsp;&nbsp;&nbsp;&nbsp;");
	}
	conments(p);
	var mp1=$("#tempTit"+p).val();
	var mp2=$("#value"+p).val();
	if(mp1!="" && mp2!=""){
		if(ks==1){
			$('#texty'+p).append(mp1+":&nbsp;&nbsp;&nbsp;");
		}
		$('#teval'+p).append('<input type="text" id="tetyval" readonly value="'+mp2+'">'+((ks==1)?'&nbsp;&nbsp;':'')+'<a href="javascript:updDat(1,'+p+');"><span id="te'+p+'" style="color:red;">修改</span></a>&nbsp;&nbsp;<a href="javascript:delDat(1,'+p+');" style="color:red;">删除</a>');	
		ks++;
		
	}
	$("#value"+p).val('');
  }else{
	  alert("文本框不能重复增加。");  
  }
}
function addSelect(p){
	//alert("2="+p);
	conments(p)
	var mp1=$("#tempTit"+p).val();
	var mp2=$("#value"+p).val();
	if(mp1!="" && mp2!=""){
		if(ks==1){
		    $('#sectty'+p).append(mp1+":&nbsp;&nbsp;&nbsp;");
		    $('#showvalue'+p).append(((ks==1)?'&nbsp;&nbsp;':'')+'<span id="chkSelt'+p+'"><a href="javascript:updDat(2,'+p+');"><span id="se'+p+'" style="color:red;">修改</span></a>&nbsp;&nbsp;<a href="javascript:delDat(2,'+p+');" style="color:red;">删除</a></span>');
		}
		var mpp=$("#key"+p).val();
		//alert("mpp2="+mpp);
		document.getElementById("sectval"+p).removeAttribute("selected");
		$('#sectval'+p).append('<option value="'+mpp+'" selected>'+mp2+'</option>');
		ks++;
	}
	$("#value"+p).val('');

}
function addCheckbox(p){
	//alert("3="+p);
	conments(p);
	var mp1=$("#tempTit"+p).val();
	var mp2=$("#value"+p).val();
	if(mp1!="" && mp2!=""){
		if(ks==1){
		    $('#chekty'+p).append(mp1+'&nbsp;&nbsp;<a href="javascript:updDat(3,'+p+');" style="color:red;"><span id="ckalls'+p+'">批量修改</span></a>&nbsp;&nbsp;<a href="javascript:delDat(3,'+p+');" style="color:red;">批量删除</a><br><hr color="blue">');
		}
		if(ks%4==0){  
		   $('#teval'+p).append('<div style="display:inline;" id="chekall'+ks+'" ><input type="checkbox" name="checkbval'+p+'" id="chekall'+ks+'"  value="'+mp2+'">'+mp2+'</div>&nbsp;&nbsp;');
		   $('#teval'+p).append('<br>');
		}else{
			$('#teval'+p).append('<div id="chekall'+ks+'" style="display:inline;"><input type="checkbox" name="checkbval'+p+'" id="chekall'+ks+'"  value="'+mp2+'">'+mp2+'</div>&nbsp;&nbsp;');
		}
		ks++;
	}
	$("#value"+p).val('');

}
function addRadio(p){
	//alert("4="+p);
	conments(p);
	var mp1=$("#tempTit"+p).val();
	var mp2=$("#value"+p).val();
	if(mp1!="" && mp2!=""){
		if(ks==1){
		    $('#radty'+p).append(mp1+'&nbsp;&nbsp;<a href="javascript:updDat(4,'+p+');" style="color:red;"><span id="radspan'+p+'">修改</span></a>&nbsp;&nbsp;<a href="javascript:delDat(4,'+p+');" style="color:red;">删除</a><br><hr color="blue">');
		}
		if(ks%4==0){
			$('#teval'+p).append('<div id="radioall'+ks+'" style="display:inline;" onclick="getdivid(this.id)"><input type="radio" name="radioval'+p+'"  value="'+mp2+'">'+mp2+'</div>&nbsp;&nbsp;');	
			$('#teval'+p).append('<br>');
		}else{
			$('#teval'+p).append('<div id="radioall'+ks+'" style="display:inline;" onclick="getdivid(this.id)"><input type="radio" name="radioval'+p+'" value="'+mp2+'">'+mp2+'</div>&nbsp;&nbsp;');	
		}
		ks++;
	}
	$("#value"+p).val('');
	
}
//属性增加的
function arrs(type){
	var jsons=arrtojson(valarrs);
	//alert("jsons="+jsons);
	if(type=="f"){
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
		url:'pdm/addSupperGoodsClassprojt.do',
		type:'post',
		data:{"datas":jsons,"surChild":type,"classcode":classcode,"classname":classname,"classtime":classtime,"classContent":classContent},
		error:function(res){
			alert(res);
		},
		success:function(res){
			//alert(res);
			var arr=res.split(",");
			//alert(arr[0]);
			if(type=="f"){       //父类
				removeDiv('addorUpdSuppers');
				selDetailSuper(arr[1],"f");
			    showDiv('Requirements');
			}else{                //子类
				removeDiv('addorUpdChilds');
			    showDiv('Requirements');
			    
			}
		}
	});
	}else{
		    var codes=$('#childCodes').val();
		    var names=encodeURI($('#childNames').val(),"utf-8");
		    var times=$('#writetime').val();
		    var Contents;
		    if($("input[name='gdchildWritename']:checkbox:checked").length>0){
		    	Contents=1;
		    }else{
		    	Contents=0;
		    }
		    var supcodes=$('#superCodes').val();
		    var supnames=$('#superNames').val();
		    $.ajax({
				url:'pdm/addSupperGoodsClassprojt.do',
				type:'post',
				data:{"datas":jsons,"surChild":type,"classcode":codes,"classname":names,"classtime":times,"classContent":Contents,"superCodes":supcodes},
				error:function(res){
					alert(res);
				},
				success:function(res){
					//alert(res);
					var arr=res.split(",");
					//alert(arr[0]);
					if(type=="c"){                   //子类
						removeDiv('addorUpdChilds');
						selDetailSuper(arr[1],"c");
					    showDiv('Requirements');
					    
					}
				}
			});
	}
}
$(function(){
	  $('#addColumn').click(function(){
		  addClumn1();
	   });	
	  //关闭详情
	  $('#addChildColumn').click(function(){
		  addChildColumn1();
	  });
	  $('#closeDetails').click(function(){
		   delarrs(); //删除数组  
		   removeDiv('Requirements');
		   self.location.reload();
	  });
	  //全部提交
	  $('#supButton').click(function(){
		  if($('#gdnames').val()!=""){
			  confirmArrs();//得到数组          //是类型，是名称，是否必填，KEY值，value值
			  arrs('f');    //json数据
		  }else{
			  alert("请填写父类名称。");  
		  }
	  });
	  $('#childSets').click(function(){
		  if($('#childNames').val()!=''){
		  confirmArrs();//得到数组          //是类型，是名称，是否必填，KEY值，value值
		  arrs('c');    //json数据
		  //document.getElementById("goodClassPjt").submit();
		  }else{
			 alert("请填写子类名称。");  
		  }
	  });
	});
function buttonBind(){
	
}
//显示详情
function selDetailSuper(id,tp){
	if(tp=="f"){
		$('#detailsupcode').val('暂无父类编码');
		$('#detailsupName').val('暂无父类名称');
	    $('#detailcode').val($('#gdcodes').val());
	    $('#detailName').val($('#gdnames').val());
	    $('#detailtime').val($('#gdWriteTime').val());
	}
	if(tp=="c"){  
		$('#detailsupcode').val($('#superCodes').val());
		$('#detailsupName').val($('#superNames').val());
	    $('#detailcode').val($('#childCodes').val());
	    $('#detailName').val($('#childNames').val());
	    $('#detailtime').val($('#writetime').val());
	}
    	//var jsons=arrtojson(valarrs);
    	//alert("arrs2="+valarrs.length);
    	if(valarrs.length>0){
    	var marr=new Array();
    	var detarr=new Array();//名称和提示
    	var detar=new Array();//值
    	var mar="";
    	var a=0;
    	var b=0;
    	for ( var i = 0; i < valarrs.length;i++){
    		detarr.splice(0,detarr.length);
    		detar.splice(0,detar.length);
    		if(i%2!=0){
    			 //alert("arrs3="+valarrs[i]);
			     marr = valarrs[i].split(";");
			     for ( var j = 0; j < marr.length;) {
			    	 if(marr[j]!=""){
				    	 detar.push(marr[j]);
				    	 j++;
				    	 detarr	.push(marr[j]); 
				    	 j++;
				    	 detarr.push(marr[j]);
				    	 j++;j++;
				    	 detar.push(marr[j]);//值数组
				    	 j++; 
			    	 }
				 }
			     for(var k=0;k<detarr.length;k++){
			    	 var typ=decodeURI(detarr[k]);
			         var trs = '<tr><td align="center" width="140"><span id="ctypes'+a+'">'+typ
			               +'</span></td><td align="center" width="400"><span id="detval'+a+'"></span></td><td align="center" width="140"><span id="iswrite'+a+'">'+((detarr[++k]==1)?"此项为必填":"此项可为空")+'</span></td></tr>';
			          $('.insertvalues').append(trs);
			          a++;
			     }
			     for(var p=0;p<detar.length;p++){
			    	 if(p%2==0){
			    		 //alert("detar[p]="+detar[p]);
			    		 if(detar[p]==1){
			    			 p++;
			    			 var duri=decodeURI(detar[p]);
			    			 var tx='<input type="text"  value="'+duri+'" readonly>';
			    			 p--;
			    			$('#detval'+b).html(tx); 
			    		 }
			    		 if(detar[p]==2){
			    			 p++;
			    			 var sec="";
			    			 sec='<select>';
			    			 var mtm=detar[p].split("-");
			    			// alert("mtm2="+detar[p]);
			    			 for(var s=0;s<mtm.length;s++){
			    				  if(mtm[s]!=""){
			    					  var duri1=decodeURI(mtm[s]);
			    					  sec+='<option>'+duri1+'</option>';
			    				  }
			    			 }
			    			 sec+='</select>';
			    			 p--;
			    			$('#detval'+b).html(sec); 
			    		 }
						 if(detar[p]==3){
							 p++;
							 var ck="";
			    			 var ckarr=detar[p].split("-");
			    			 //alert("mtm3="+detar[p]);
			    			 for(var g=0;g<ckarr.length;g++){
			    				 if(ckarr[g]!=""){
			    				  var duri2=decodeURI(ckarr[g]);
				    			 if(g%4==0){
				    			   ck+='<input type="checkbox"  value="'+duri2+'">'+duri2+'&nbsp;&nbsp;<br>';
				    			 }else{
				    			   ck+='<input type="checkbox"  value="'+duri2+'">'+duri2+'&nbsp;&nbsp;';
				    			 }
			    				 }
			    			 }
			    			 p--;
			    			$('#detval'+b).html(ck); 
						 }
						 if(detar[p]==4){
							 p++;
			    			 var rd="";
			    			 //alert("mtm4="+detar[p]);
			    			 var rdarr=detar[p].split("-");
			    			 for(var d=0;d<rdarr.length;d++){
			    				 if(rdarr[d]!=""){
			    			     var duri3=decodeURI(rdarr[d]);
				    			 if(d%4==0){
				    			 rd+='<input type="radio"  value="'+duri3+'">'+duri3+'&nbsp;&nbsp;<br>';
				    			 }else{
				    			 rd+='<input type="radio"  value="'+duri3+'">'+duri3+'&nbsp;&nbsp;';
				    			 }
			    				 }
			    			 }
			    			 p--;
			    			$('#detval'+b).html(rd); 
						 }
						 b++;
			    	 }
			     }
    		}
		} 
    }else{
    	 var trs = '<tr><td align="center"  colspan="3"><center>对不起暂无属性信息！</center></td></tr>';
    	 $('.insertvalues').append(trs);
    }
}
//删除详情里的属性
function supdetaildel(did){
  //  alert("did="+did);	
}
//查看详情
function selFatherOrChild(id){
	//alert("sel="+id);
	//$('#upspan').html('<a href="javascript:updatedates('+id+');" style="color:#adaaa5;font-size:14px;">点击修改</a>');
	$.post('pdm/superMenuDetailClassprojt.do',{"present":id},function(res){
		   // alert(res);
		 var arrs=new Array();
		 var flag=0;
		 var mx="";
		 arrs=res.split(",");
	    $('#detailsupcode').val(arrs[0]);
		$('#detailsupName').val(arrs[1]);
	    $('#detailcode').val(arrs[2]);
	    $('#detailName').val(arrs[3]);
	    $('#detailtime').val(arrs[4].substring(0,arrs[4].length-2));
	    arrs1=arrs[5].split("^");
		for(var i=0;i<arrs1.length;i++){
	     if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
	    	 flag=1;
	    	 arrs2=arrs1[i].split(";");
	    	// alert("arrs2[4]="+arrs2[4]);
	    	 arrs3=arrs2[4].split("-");
	    	 mx='<tr>';
	    	 if(arrs2[0]==1){
	    		 mx+='<td align="center" width="140"><span id="mtexttypes'+i+'">'+arrs2[1]+'</span></td>';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				mx+='<td align="center" width="400"><input type="text" id="mtextvalue'+i+'" value="'+arrs3[j]+'" readonly></td>';
	    			}
	    		 }
	    		 mx+='<td align="center" width="140"><span id="mtextstat'+i+'">'+arrs2[2]+'</span></td>';
	    	 }
			 if(arrs2[0]==2){
				 mx+='<td align="center" width="140"><span id="mseltypes'+i+'">'+arrs2[1]+'</span></td><td align="center" width="400"><select id="mSelvalue'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				mx+='<option value="'+arrs3[j]+'">'+arrs3[j]+'</option>';
	    			}
	    		 }
	    		 mx+='</select></td><td align="center" width="140"><span id="mselstat'+i+'">'+arrs2[2]+'</span></td>';
			 }
			 if(arrs2[0]==3){
				 mx+='<td align="center" width="140"><span id="mchecktype'+i+'">'+arrs2[1]+'</span></td><td align="center" width="400"><span id="radalls'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				if(j%5==0){
	    				    mx+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"<br>";
	    				}else{
	    					mx+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j];	
	    				}
	    			}
	    		 }
	    		 mx+='</span></td><td align="center" width="140"><span id="mcheckstat'+i+'">'+arrs2[2]+'</span></td>';
			 }
			 if(arrs2[0]==4){
				 mx+='<td align="center" width="140"><span id="mradiotype'+i+'">'+arrs2[1]+'</span></td><td align="center" width="400"><span id="radalls'+i+'">';
	    		 for(var j=0;j<arrs3.length;j++){
	    			if(arrs3[j]!=""){
	    				if(j%5==0){
	    				   mx+='<input type="radio" name="mradiovalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j]+"<br>";
	    				}else{
	    					 mx+='<input type="radio" name="mradiovalue'+i+'" value="'+arrs3[j]+'">'+arrs3[j];
	    				}
	    			}
	    		 }
	    		 mx+='</span></td><td align="center" width="140"><span id="mradiostat'+i+'">'+arrs2[2]+'</span></td><td>';
			 }
			 //alert(mx);
			 mx+='</tr>';
			 $('.insertvalues').append(mx);
		 }
		}
		if(flag==0){
			  mx='<tr><td align="center" width="140" colspan="3">暂没有找到可用的属性</td></tr>';
			 $('.insertvalues').append(mx);
		}
	});
	showDiv('Requirements');
}
//删除
function delFatherOrChild(id){
	//alert("del="+id);
	//if(confirm("你确定要删除数据吗?")){
		$.ajax({
		   	type:'post',
		   	url:$('#path').val()+'pdm/deleteClassClassprojt.do',
		   	data:{"dids":id},
		   	success:function(res){
		   	  alert(res);
			  if(res=='数据删除成功。'){
			       location.reload();
			  }
		}
		});
	//}
}
//修改
function updatedates(f){
	    document.getElementById("detailName").readOnly=false;
	    var strs=new Array();
		//$('#upspan').html('<a href="javascript:updatesava('+f+');" style="color:#adaaa5;font-size:14px;">点击保存</a>');
		$.ajax({
		   type:'post',
		   url:'pdm/returnvaluesClassprojt.do',
		   data:{"extid":f},
		   success:function(res){
			   // alert("resup="+res);
			    if(res!='no'){
			    strs=res.split("^");
				//alert("strs.length="+strs.length);
				for(var i=0;i<strs.length;i++){
				     if(strs[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
				    	 arrs2=strs[i].split(";");
				    	 if(arrs2[0]==1){
				    		var type1=$('#mtexttypes'+i).html();
				    		$('#mtexttypes'+i).html('<input type="text" id="uptextval'+i+'" value="'+type1+'" size="5">');
				    		document.getElementById("mtextvalue"+i).readOnly=false;

				    	 }
				    	 if(arrs2[0]==2){//下拉
				    		 var type2=$('#mseltypes'+i).html();
				    		 $('#mseltypes'+i).html('<input type="text" id="upselval'+i+'" value="'+type2+'" size="5">');
							 $('#mSelvalue'+i).after('<input type="text" id="upselct'+i+'" value="'+$('#mSelvalue'+i).find('option:selected').val()+'">');
				    	 }
						 if(arrs2[0]==3){
						    var type3=$('#mchecktype'+i).html();
						    $('#mchecktype'+i).html('<input type="text" id="upchekval'+i+'" value="'+type3+'" size="5">');
						    var chk=$("input[name='mcheckvalue"+i+"']");
						   // alert("chk="+chk.length);
						    for(var j=0;j<chk.length;j++){
						    	 $("input[name='mcheckvalue"+i+"']").eq(j).after('<input type="text" id="upcheck'+j+'" value="'+chk[j].value+'" size="5">');
						    }
						   
						 }
						 if(arrs2[0]==4){
				    		 var type4=$('#mradiotype'+i).html();
				    		 $('#mradiotype'+i).html('<input type="text" id="upradval'+i+'" value="'+type4+'" size="5">');
							 var rdo=$("input:radio[name='mradiovalue"+i+"']");
							 for(var k=0;k<rdo.length;k++){
								 $("input:radio[name='mradiovalue"+i+"']").eq(k).after('<input type="text" id="upradio'+k+'" value="'+rdo[k].value+'" size="5">');
							 }

						 }
				     }
				}
			    }else{
			    	alert("暂时没有可供修改的属性。");
			    }
		   }
		});
}
//保存
function updatesava(v){
	//alert("v="+v);
	var chkstat;
	arrcount=0;
	valarrs.splice(0,valarrs.length);
	 document.getElementById("detailName").readOnly=true;
	//$('#upspan').html('<a href="javascript:updatedates(1);" style="color:#adaaa5;font-size:14px;">点击修改</a>');
		for(var i=0;i<arrs1.length;i++){
		     if(arrs1[i]!=""){      //是类型，是名称，是否必填，KEY值，value值
		    	 var countSave="";
		    	 arrs2=arrs1[i].split(";");
		    	 if(arrs2[0]==1){
					if($('#mtextstat'+i).html()=='此项不能为空'){
						chkstat=1;
					}else{
						chkstat=0;	
					}
					var strin=$("#mtextvalue"+i).val();
					//alert("textvalue="+strin);
					countSave+=1+";"+$('#uptextval'+i).val()+";"+chkstat+";"+arrs2[3]+";"+strin;
					document.getElementById("mtextvalue"+i).readOnly=true;
					$('#mtexttypes'+i).html($('#uptextval'+i).val());
		    	 }
		    	 if(arrs2[0]==2){//下拉
		    		 var secs="";
		    		 $('#mSelvalue'+i).find("option:selected").val();
					 $('#mSelvalue'+i+'>option').each(function(){
						if($(this).attr('selected')==false){
							//alert($(this).val());
							secs+=$(this).val()+"-";
						}
					 });
					secs+=$('#upselct'+i).val();
					$('#upselct'+i).remove();
					var mtt = secs.split("-");
					$('#mSelvalue'+i).empty();
		    		for(var s=0;s<mtt.length;s++){
		    			if(s==(mtt.length-1)){
		    				$('#mSelvalue'+i).append('<option value="'+mtt[s]+'" selected>'+mtt[s]+'</option>');
		    			}else{
		    			   $('#mSelvalue'+i).append('<option value="'+mtt[s]+'">'+mtt[s]+'</option>');
		    			}
		    		}
					if($('#mselstat'+i).html()=='此项不能为空'){
							chkstat=1;
					}else{
							chkstat=0;	
					}
					countSave+=2+";"+$('#upselval'+i).val()+";"+chkstat+";"+arrs2[3]+";"+secs;
					$('#mseltypes'+i).html($('#upselval'+i).val());
					$('#upselval'+i).remove();
		    	 }
				 if(arrs2[0]==3){
					var secs="";
					var secm="";
				    var chk=$("input[name='mcheckvalue"+i+"']");
				    for(var m=0;m<chk.length;m++){
				      if($('#upcheck'+m).val()!=""){
				    	  secs+=$('#upcheck'+m).val()+"-";
				    	  $('#upcheck'+m).remove();
				      }else{
				    	  secs+=chk[m].value+"-";
				      }
				    }
				    $('#radalls'+i).html('');
		    		 var mtt = secs.split("-");
		    		 for(var s=0;s<mtt.length;s++){
		    			 if(mtt[s]!=""){
		    			 if(s%5==0){
					         secm+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+mtt[s]+'">'+mtt[s]+"<br>";
		    			 }else{
		    				 secm+='<input type="checkbox" name="mcheckvalue'+i+'" value="'+mtt[s]+'">'+mtt[s];
		    			 }
		    			 }
		    		 }
		    		 $('#radalls'+i).html(secm);
					if( $('#mcheckstat'+i).html()=='此项不能为空'){
						chkstat=1;
					}else{
						chkstat=0;	
					}
					countSave+=3+";"+$('#upchekval'+i).val()+";"+chkstat+";"+arrs2[3]+";"+secs;
					$('#mchecktype'+i).html($('#upchekval'+i).val());
					$('#upchekval'+i).remove();
				 }
				 if(arrs2[0]==4){
					 var secs="";
					 var secm="";
		    		 var rdo=$("input:radio[name='mradiovalue"+i+"']");
		    		 for(var p=0;p<rdo.length;p++){
					    if($('#upradio'+p).val()!=""){
					    	 secs+=$('#upradio'+p).val()+"-";
					    	 $('#upradio'+p).remove();
					    }else{
					    	 secs+=rdo[p].value+"-";
					    }
		    		 }
		    		 $('#radalls'+i).html('');
		    		 var mtt = secs.split("-");
		    		 for(var s=0;s<mtt.length;s++){
		    			 if(mtt[s]!=""){
		    			 if(s%5==0){
		    			    secm+='<input type="radio" name="mradiovalue'+i+'" value="'+mtt[s]+'">'+mtt[s]+"<br>";
		    			 }else{
		    				 secm+='<input type="radio" name="mradiovalue'+i+'" value="'+mtt[s]+'">'+mtt[s];
		    			 }
		    			 }
		    		 }
		    		 $('#radalls'+i).html(secm);
					 if($('#mradiostat'+i).val()=='此项不能为空'){
							chkstat=1;
					 }else{
							chkstat=0;	
					 }
					 countSave+=4+";"+$('#upradval'+i).val()+";"+chkstat+";"+arrs2[3]+";"+secs;
					 $('#mradiotype'+i).html($('#upradval'+i).val());
					 $('#upradval'+i).remove();
				 }
				 //alert("textvalue="+countSave);
				 var ppms=encodeURI(countSave,"utf-8");
				 //alert("pp="+ppms);
				 valarrs.push(arrcount);
				 valarrs.push(ppms); 
				 arrcount++;
		     }
		}
		
	var jsons=arrtojson(valarrs);
	//alert("js="+jsons);
	var atent=encodeURI($('#detailName').val(),"utf-8");
	var dt = new Date();
	var dte=dt.getFullYear()+"-"+(dt.getMonth()+1)+"-"+dt.getDate()+" "+dt.getHours()+":"+dt.getMinutes()+":"+dt.getSeconds();
	$('#detailtime').val(dte);
	$.ajax({
		type:'post',
		url:'pdm/updateDetailClassprojt.do',
	    data:{"jsonDate":jsons,"atent":atent,"dte":dte,"cid":v},
	    success:function(res){
	    	//alert(res);
	    }
	});
}

function updtFatherOrChild(id,code,name,father){
	//alert("id="+id+","+name+","+code+","+father);
    location.href=$('#path').val()+"pdm/updFrontSeltClassprojt.do?selid="+id+"&fatherID="+father;
}
