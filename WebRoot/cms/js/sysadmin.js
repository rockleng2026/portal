$(function (){       
	     $("#depts").click(function(){
				if(document.getElementById("depts").options.length==1){
				 $.ajax({
					  type: "POST",
					  url: "cms/loadDeptsAdmin.do",
					  data:"",
					  success: function(data){
					    $('#depts').append(data);
				       }
					 });
				}
			});
});

$(document).ready(function(){  
	 $('#w').window({
	       closed: true
	   });

	 $('#up').window({
	       closed: true
	   });

	 $('#rolit').window({
		   closed: true 
	 });
	 $('#tabs').datagrid({
			 iconCls:'icon-add',
    //fitColumns:false,
 			//
			fit:false,//这个为true在其他浏览器下列表无法显示
			fitColumns:false,
			pageSize:15,
			pageList:[5,10,15,20],	
			rownumbers:true,
			nowrap: true,	//把数据显示在一行里,可以自动换行	
			striped: true,						//奇偶行使用不同背景色	
			collapsible:true,					//可折叠
			url:'cms/splitPagesAdmin.do',
			loadMsg:'数据正在加载...',			
			remoteSort:false,
			pagination:true,
			sortName:'userid',					
			sortOrder:'desc',					
			frozenColumns:[[
		      {field:'ck',checkbox:true}
         ]],
			columns:[[
			     {field:'num',title:'编号',width:'30',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'userid',title:'用户ID',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
			     {title:'did',field:'did',hidden:true},
			     {title:'dname',field:'dname',hidden:true},
			     {title:'pwd',field:'pwd',hidden:true},
				 {field:'username',title:'用户帐号',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'email',title:'email',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'sta',title:'状态',width:'80',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'pOper',title:'操作',width:'250',rowspan:2,align:'left',sortable:true,resizable:false,
			     formatter:function(value,rowData,index){
			      var pps;
			      var psta;
			      if(rowData.sta=='有效'){
			    	  pps=1;
			    	  psta='注销';
			      }else{
			    	  pps=0;
			    	  psta='开通';
			      }
			     return html='<a href="javascript:createLimit('+rowData.userid+');">权限设置</a>&nbsp;&nbsp;&nbsp;<a href="javascript:showOrhide('+pps+','+rowData.userid+');">'+psta+'</a>&nbsp;&nbsp;&nbsp;<a href="javascript:update();">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:updatePwd();">密码修改</a>';

			     } 
			     }
			    ]],
			pagination:true,
			rownumbers:false,
		    toolbar:[{
		              text:'管理员添加',
		              iconCls:'icon-add',
					  handler:function(){
					    	$('#ff').each(function(index){
			                    $(this)[index].reset();
			               });
			               $('#subs').val("增加信息");
			               resize();
		              }
		    }]
		});
	   displayMsg();
}); 

function update(){
	  resize();
	  $('#subs').val("修改信息");
	  var sel=$('#tabs').datagrid('getSelected');
	     if(sel){
	        $('#username').attr('value',sel.username);
	        $('#email').attr('value',sel.email);
	        $('#userid').attr('value',sel.userid);
	        $("#depts").html("<option value='"+sel.did+"' selected>"+sel.dname+"</option>");
	     }  

}
function updatePwd(){
	  resizePwd();
	  $('#subsPwd').val("提交");
	  var sel=$('#tabs').datagrid('getSelected');
	     if(sel){
	        $('#useridPwd').attr('value',sel.userid);
	        $('#deptidPwd').attr('value',sel.did);
	     } 
}
function checkformPwd()
{
	var newpwd=$("#newpwd1").val();
	if(newpwd==''||newpwd==null){
		$("#newpwdtest1").html("新密码不能为空。。。");
		return;
	}
	$("#newpwdtest1").html("");
	if(newpwd.length<6){
		$("#newpwdtest1").html("新密码长度不能小于6。。。");
		return;
	}
	$("#newpwdtest1").html("");
	
	var newpwd2=$("#newpwd2").val();
	if(newpwd2!=newpwd){
		$("#newpwdtest2").html("确认密码不一致。。。");
		return;
	}
	$("#newpwdtest2").html("");
	$('#uppwd').attr("action","cms/updatePwdAdmin.do");
	$('#uppwd').submit();
}
  function showOrhide(fg,id){
	  var basepath = $("#basepath").val();
	  window.location.href=basepath+"/cms/kaiTongAdmin.do?userid="+id+"&sta="+fg;  
  }
  function deldata(){
	    var mp=0;
	    var pms="";
		$.messager.confirm("提示","你确定要删除吗?",function(id){
				if(id){
				var sels=$('#tabs').datagrid('getSelections');
				$.each(sels,function(){
				pms=this.pid+","+pms;
				 });
				$.post('cms/delsid.do',{
					mid : pms
					},function(data){
						$.messager.alert('提示',data.del,'info');
						$('#tabs').datagrid('reload');
				},'json');

				}
		});

  }
  function displayMsg(){
	$('#tabs').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
	//onBeforeRefresh:function(pageNumber,pageSize){
   //$(this).pagination('loading');
  // $(this).pagination('loaded');
  }
  function subt(){
	  var pa1 = $('#key').val();
	  var pa2 = $("input[name='news.showflag']:checked").val(); 
	  var pa3 = $('#status option:selected').val();
	  var pa4 = $('#typeid option:selected').val();
	  //alert(pa1+","+pa2+","+pa3+","+pa4);
	  var parms=$('#tabs').datagrid('options').queryParams;
	  parms.condit1=pa1;
	  parms.condit2=pa2;
	  parms.condit3=pa3;
	  parms.condit4=pa4;
     var urle="cms/selectNews.do";
     var pse=1;
     loadGrid(urle,pse);
  }
  
  function checkform()
  {
	  var username= $("#username").val();
	  if(username===''||username===null){
		  $("#clasid").html("账号不能为空！");
		  return;
	  }
	  $("#clasid").html("");
	  var email=$("#email").val();
	  if(email==''||email==null){
		  $("#tnmsg").html("邮箱不能为空！");
		  return;
	  }
	  var myreg =/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	  if(!myreg.test(email)){
		  $("#tnmsg").html("邮箱格式不正确！");
		  return;
	  }
      $("#tnmsg").html("");

	 
	  var pwd1=$("#pwd1").val();
	  var pwd2=$("#pwd2").val();
	  if(pwd1==''||pwd1==null){
		  $("#engmsg").html("密码不能为空！");
		  return;
	  }
	  
	  if(pwd1.length<6){
		  $("#engmsg").html("密码长度不能小于6！");
		  return;
	  }
	  $("#engmsg").html("");
	  if(pwd1!==pwd2){
		  $("#engmsg2").html("两次输入密码不一致！");
		  return;
	  }
	  $("#engmsg2").html("");
	  var depts=document.getElementById("depts"); 
	  var a= depts.options[depts.selectedIndex].value; 
	  if(a==-1){
		  $("#dept").html("请选择部门！");
		  return;		  
	  }
	  $("#dept").html("");
	  
	  $('#ff').attr("action","cms/addOrUpdateAdmin.do");
	  $('#ff').submit();

  }
  
  function resize(){
	     $("#ff").find("input").val("");
	     $("#ff").find("span").html("");
		 $('#w').window({
			title: '添加/修改数据界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});

	}
  function resizePwd(){
	  
	     $("#uppwd").find("input").val("");
	     $("#uppwd").find("span").html("");
		 $('#up').window({
			title: '密码修改界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});
	}
  function createLimit(mp){
		 $('#rolit').window({
			title: '设置权限界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});
		roleLimit(mp);
	}
function roleLimit(ms){
	  $('#limitTree').tree({
			checkbox:true,
			animate:true,
			url: 'cms/createTrees_MenuAllTrees.do?admins.user_id='+ms,
		    loadFilter:function(data){
		    	return data.dataTree;
		    },
			onClick:function(node){
				$(this).tree('toggle', node.target);
				alert('you click '+node.attributes.licode);
				alert('you to'+node.attributes.licode.substring(2,6));
				//if(.substring())
			}
		});
}
$(function(){
	  $('#buto').click(function(){
		 var rows=$('#tabs').datagrid('getSelected');
		 var adid=rows.userid;
		 var lis = $('#limitTree').tree("getChecked");
		 var strs="";
		 for(var i=0;i<lis.length;i++){
			var ps=lis[i].id;
			strs += ps + ',';
			var o = $('#limitTree').tree('getParent',lis[i].target);
			if(o!=null){
				//alert("pa="+o.id);
				strs+=o.id+",";
			}
		 }
		 //alert("strs="+strs+"@@rows="+rows.userid);
		 $.messager.confirm('提示','你确定要提交吗?',function(p){
			 if(p){
				$.post('cms/sRoLimit_MenuAllTrees.do',{roLiid:adid,strArr:strs},function(data){
					$.messager.alert('提示',data.arrMessager,'info');
					location.reload();
				},'json');
			 }
		 });
	  });
});
	
	