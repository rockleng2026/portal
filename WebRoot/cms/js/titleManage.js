  $(document).ready(function (){
	  $('#w').window({
	       closed: true
	   });
		$('#dd').datagrid({
			fit:false,
			pageSize:15,
			fitColumns:false,
			rownumbers:true,
			pageList:[5,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:'cms/splitPagesBySitekeyClasses.do',		
			loadMsg:'数据正在加载...',	
			sortName:'pid',					
			sortOrder:'desc',					
			remoteSort:false,	
			frozenColumns:[[
		      {field:'ck',checkbox:true}
            ]],
            columns:[[
                  {title:'编号',field:'cid',width:'30',rowspan:2,align:'center',sortable:true,resizable:false},
                  {title:'序号',field:'islastest',width:'50',rowspan:2,align:'center',sortable:true,resizable:false},
	              {field:'superid',title:'superid',hidden:true},
	              {title:'类别ID',field:'mid',hidden:true},
	              {title:'mid',field:'mid',hidden:true},
	              {title:'栏目名称',field:'menid',width:'215',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'英文名称',field:'egName',width:'215',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'是否显示',field:'menName',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'是否外链',field:'pabase',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'外链地址',field:'papayboty',width:'300',rowspan:2,align:'center',sortable:true,resizable:false},
			      {field:'pOper',title:'操作',width:'200',rowspan:2,align:'left',sortable:true,resizable:false,
				   formatter:function(value,rowData,index){
	            	  var pps;
				      if(rowData.menName=='隐藏'){
				    	  pps=0;
				      }else{
				    	  pps=1;
				      }
				   return html='<a href="javascript:mss('+rowData.superid+','+rowData.pastaName+');">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:showOrhide('+pps+','+rowData.pastaName+');">'+rowData.mid+'</a>&nbsp;&nbsp;&nbsp;<a href="javascript:delform('+rowData.pastaName+');">删除</a>';
				    } 
				    }
				    ]],
			pagination:true,
			rownumbers:false,
			   toolbar:[{
			         text:'增加',
			              iconCls:'icon-add',
			              handler:function(){
			                    $('#ff').each(function(index){
			                         $(this)[index].reset();
			                    });
			                    $('#subs').val("增加信息");
			                    resize();
			              }
			              },'-',{
			              text:'批量删除',
						  iconCls:'icon-cancel',
						  handler:delform
			    }]
		});
		
	    displayMsg();
	});
  function displayMsg(){
		$('#dd').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
	
  }
 function checklast(vas){
	   
	   var mes="";
	   if(vas == ""){
	   	mes="序号不能为空";
	   }else if(vas != "0"){
	  // var str = /^999$|^([1,2,3]\d)$|^\d?$/;
	   var str = /^[1-9]\d{0,2}$/ ;
		if(!str.test(vas)){
				mes=('只能输入0-999的数字！');
		}
      }
      if(mes!=""){
		   $("#lastmsg").html(mes);
	       $("#lastmsg").show();
	       return false; 
       }else{
    	   $("#lastmsg").html("");
    	   $("#lastmsg").hide();
    	   return true; 
       }
}
 function delform(){
	 alert("暂无");
 }
  function resize(){
		 $('#w').window({
			title: '录入数据界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});
	}

  function mss(id,classid){
  	  alert(id+"-"+classid);
	  $('#subs').val("修改信息");
	  resize();
	  var sel=$('#dd').datagrid('getSelected');
	     if(sel){
	     	//alert(111);
	        //$('#superid').attr('value',11111);
	        $("#superid option[value='"+id+"']").attr("selected", true);
	        //$('#superid').attr('text',2222);
//	        $('#superid').attr('text',sel.pastaName);
	        $('#classid').attr('value',classid);
	        $('#mark').attr('value',"update");
	        $('#typename').attr('value',sel.menid);
	        $('#engname').attr('value',sel.egName);
	        $('#islastest').attr('value',sel.islastest);
	        if(sel.menName=='显示'){
	        	document.getElementsByName("classes.showflag")[0].checked=true;
		        }else{
		         document.getElementsByName("classes.showflag")[1].checked=true;
		          
		         }
	        //是否外
	       // $('#isout').attr('value',sel.pabase);
	        if(sel.pabase=='不外链'){
	        	document.getElementsByName("classes.isout")[1].checked=true;
	        }else{
	        	document.getElementsByName("classes.isout")[0].checked=true;
	        	document.getElementsByName('#outpath').attr('value',sel.papayboty);
	         }
	
	     }  

  }
  function delform(aa){
  
	  var basepath = $("#basepath").val();
	    var mp=0;
	    var pms="";
		$.messager.confirm("提示","你确定要删除吗?",function(id){
				alert(id);
				if(id){
				var sels=$('#dd').datagrid('getSelections');
				$.each(sels,function(){
				pms=this.pastaName+","+pms;
				});
				//alert(pms);
				//alert(basepath);
				$.post(basepath+'/cms/delclassid.do',{
					mid : pms
					},function(data){
						$.messager.alert('提示',data.del,'info');
						$('#dd').datagrid('reload');
				},'json');
				}
		});
  }
		
 function showOrhide(fg,id){
	  var basepath = $("#basepath").val();
	  window.location.href=basepath+"/cms/showClasses.do?cid="+id+"&state="+fg;  
  }

 jQuery(function($){
	    jQuery("input,select,textarea").addClass("warning-normal");
	});
	function checkform()
	{
		var last = $("#islastest").val();
	    var lastflag = checklast(last);
	    jQuery.checkForm({
	        ctrls: [                                  
	            {id:"superid",type:"mustInput", par:"",msg: "父id不能为空"}, 
	            {id:"superid",type:"mustInt",par:"",msg:"父id必须为数字"},
	            {id:"typename",type:"mustInput", par:"", msg:"栏目名称不能为空"},
	            {id:"engname",type:"checkEng", par:"", msg:"你输入的不是英文名称"},
	            {name:"classes.showflag",type:"mustRadio", par:"", msg: "是否显示不能为空"} 
	            ],
	        success: function(){ 
	     	document.getElementById("clasid").innerHTML="";
	     	document.getElementById("tnmsg").innerHTML="";
	     	document.getElementById("engmsg").innerHTML="";
	     	document.getElementById("opmsg").innerHTML="";
	        getvalues();                                      
	        },
	        failed: function(msg){  
	         if(msg=='父id不能为空' || msg=='父id必须为数字'){
	        	 $('#clasid').html(msg);
	         }
	         if(msg=='栏目名称不能为空'){
	        	 $('#tnmsg').html(msg);
	         }
	         if(msg=='你输入的不是英文名称'){
	        	 $('#engmsg').html(msg);
	         }
	         if(msg=='是否显示不能为空'){
	        	 $('#opmsg').html(msg);
	         }
	         if(lastflag == false){
            	$('#lastmsg').html('只能输入0-999的数字！');
             }
	        }
	        });
	       function getvalues(){
	    	   $('#ff').attr("action","cms/addOrUpdateClasses.do");
	    	   this.foms.submit();
	       }

	}
	function getoutlian(evt){
	 var event = evt || window.event;
	 var e =event.srcElement || event.target;
	 if(e.value=="1"){
  	   document.getElementById("outlian").style.display="block";
	 }else{
		 document.getElementById("outlian").style.display="none";
	 }
	}