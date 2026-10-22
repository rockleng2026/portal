$(function (){  
	
		$("#info_pid").click(function(){
			//alert(1111);
			if(document.getElementById("info_pid").options.length==1){
			 $.ajax({
				  type: "POST",
				  url: "cms/loadrecinfoRec_part.do",
				  data:"",
				  success: function(data){
				    $('#info_pid').append(data);
			       }
				 });
			}
		});
});

$(function(){
   $('#dd').datagrid({
	fit:false,
	pageSize:15,
	fitColumns:false,
	rownumbers:true,
	pageList:[10,15,20,30],			
	nowrap: true,	//把数据显示在一行里,可以自动换行	
	pageNumber:1,
	striped: true,						//奇偶行使用不同背景色
	collapsible:true,					//可折叠
	url:'cms/splitPages2Rec_part.do',		
	loadMsg:'数据正在加载...',	
	sortName:'id',					
	sortOrder:'desc',					
	remoteSort:false,	
	pagination:true,
	frozenColumns:[[
      {field:'ck',checkbox:true}
    ]],
    columns:[[
     {title:'编号',field:'id',width:'70',rowspan:2,align:'center',resizable:true,sortable:true},
     {title:'pid',field:'pid',hidden:true,resizable:false},
     {title:'vid',field:'vid',hidden:true,resizable:false},
     {title:'文章标题',field:'vtitle',width:'160',rowspan:2,align:'center',resizable:false},
     {title:'推荐位置',field:'pname',width:'160',rowspan:2,align:'center',resizable:false,sortable:true},
     {title:'图片路径',field:'imgsrc',width:'315',rowspan:2,align:'center',resizable:false},
     {title:'推荐时间',field:'recdate',width:'195',rowspan:2,align:'center',resizable:false,sortable:true},
     {field:'pOper',title:'操作',width:'145',rowspan:2,align:'center',sortable:false,
	     formatter:function(value,rowData,index){
	     return html='<a href="javascript:del('+rowData.id+');"></a>';
	     }
     }
     ]],
    // 是否显示分页
    pagination:true,
    // 是否显示行号
    rownumbers:false
    });
   $('#dd').datagrid('getPager').pagination({displayMsg:'当前显示从{from}到{to}共{total}记录',
   onBeforeRefresh:function(pageNumber,pageSize){
   $(this).pagination('loading');
   // alert('pn='+pageNumber+'ps='+pageSize);
   $(this).pagination('loaded');
   }
   });
  });

//模糊查询
function subt(){
	  var pa4 = $('#info_pid option:selected').val();
	  var parms=$('#dd').datagrid('options').queryParams;
	  parms.className=pa4;
	  

   var urle="/FAJxc/cms/select2Rec_part.do";
   var pse=1;
   loadGrid(urle,pse);
}


function loadGrid(ur,ps){
	
	    $("#part").hide();
	    $("#diva").hide();
		$('#dd').datagrid({
			fit:false,
			pageSize:20,
			fitColumns:true,
			rownumbers:true,
			pageList:[2,5,10,15,20],			
			nowrap: true,	//把数据显示在一行里,可以自动换行	
			pageNumber:ps,
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:ur,		
			loadMsg:'数据正在加载...',	
			sortName:'pid',					
			sortOrder:'desc',					
			remoteSort:false,	
			pagination:true,
			frozenColumns:[[
		      {field:'ck',checkbox:true}
            ]],
			columns:[[
			     {field:'id',title:'编号',width:'5',rowspan:2,align:'center',sortable:true},
			     {field:'pid',title:'pid',hidden:true},
			     {field:'psh',title:'psh',hidden:true},
			     {field:'pst',title:'信息类别',width:'10',rowspan:2,align:'center',sortable:true},
				 {field:'ptl',title:'标题',width:'10',rowspan:2,align:'center',sortable:true},
			     {field:'pcot',title:'简介',width:'20',rowspan:2,align:'center',sortable:true},
				 {field:'psho',title:'显示',width:'10',rowspan:2,align:'center',sortable:true},
				 {field:'psta',title:'审核状态',width:'10',rowspan:2,align:'center',sortable:true},
			//	 {field:'keys',title:'关键字',width:'10',rowspan:2,align:'center',sortable:true},
			     {field:'ptime',title:'录入时间',width:'10',rowspan:2,align:'center',sortable:true},
			     {field:'pOper',title:'操作',width:'15',rowspan:2,align:'left',sortable:true,
			     formatter:function(value,rowData,index){
			      var pps;
			      if(rowData.psho=='隐藏'){
			    	  pps=1;
			      }else{
			    	  pps=0;
			      }
			      return html='<a href="javascript:upddate('+rowData.pid+');" align="center">推荐</a>';
			     } 
			     }
			    ]],
			pagination:true,
			rownumbers:false,
		    toolbar:[{
		         	text:'',
		         	iconCls:''
		         
		            },'',{
		              text:'',
		              iconCls:'',
					  handler:function(){
		            	  var base=$('#basepath').val();
		            	  location.href=base+"/cms/papers/infomationOut.jsp"; 
		              }
		              
		    }]
		});}
// 点击推荐  进入后台方法
function del(cid){
  		var mp=0;
	    var pms="";
		$.messager.confirm("提示","你确定要删除此推荐吗?",function(id){
				if(id){
				var sels=$('#dd').datagrid('getSelections');
				$.each(sels,function(){
				pms=this.id+","+pms;
				 });
				$.post('cms/delinfoRec_part.do',{
					mid : pms
					},function(data){
						$.messager.alert('提示',data.del,'info');
						$('#tabs').datagrid('reload');
				},'json');

				}
		});
}

// 关闭层
function closeDIV(){
  document.getElementById('part').style.display='none';
  document.getElementById('diva').style.display='none';
}

