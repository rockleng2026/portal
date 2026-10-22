//页面加载
$(document).ready(function(){  
});

$(function(){
$('#tabs').datagrid({	
	fit:false,
	pageSize:15,
	fitColumns:false,
	rownumbers:true,
	pageList:[5,10,15,20],			
	nowrap: true,						//把数据显示在一行里,可以自动换行
	striped: true,						//奇偶行使用不同背景色
	collapsible:true,					//可折叠
	url:'cms/splitPagesModel.do',		
	loadMsg:'数据正在加载...',	
	sortName:'pid',					
	sortOrder:'desc',					
	remoteSort:false,	
	frozenColumns:[[
      {field:'ck',checkbox:true}
    ]],
	frozenColumns:[[
      {field:'ck',checkbox:true}
 ]],
    columns:[[
     {title:'编号',field:'id',width:'100',rowspan:2,align:'center',resizable:false},
  // {title:'pid',field:'pid',hidden:true,resizable:false},
     {title:'模块名称',field:'mkmc',width:'200',rowspan:2,align:'center',resizable:false},
     {title:'模块英文名',field:'mkywm',width:'200',rowspan:2,align:'center',resizable:false},
     {title:'模块图标',field:'tb',width:'250',rowspan:2,align:'center',resizable:false},
     {title:'模块路径',field:'lj',width:'170',rowspan:2,align:'center',resizable:false},
     {field:'cz',title:'模块操作',width:'250',rowspan:2,align:'center',sortable:true,
	     formatter:function(value,rowData,index){
    	 return html='<a href="javascript:upddate('+rowData.id+');" align="center">修改</a> |  <a href="javascript:deldata();">删除</a>';
	     }
     }
     ]],
    // 是否显示分页
    pagination:true,
    // 是否显示行号
    rownumbers:false
    });
     displayMsg();
});
function displayMsg(){
	$('#tabs').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});

}




function loadGrid(ur,ps){
	//    $("#part").hide();
	//    $("#diva").hide();
		$('#tabs').datagrid({
			fit:true,
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
			sortName:'id',					
			sortOrder:'desc',					
			remoteSort:false,	
			pagination:true,
			frozenColumns:[[
		      {field:'ck',checkbox:true}
            ]],
			columns:[[
			     {field:'id',title:'模块编号',width:'5',rowspan:2,align:'center',sortable:true},
			     {field:'mkmc',title:'模块名称',hidden:true},
			     {field:'mkywm',title:'模块英文名',hidden:true},
			     {field:'tb',title:'模块图标',width:'10',rowspan:2,align:'center',sortable:true},
				 {field:'lj',title:'路径',width:'10',rowspan:2,align:'center',sortable:true},
			     {field:'cz',title:'操作',width:'20',rowspan:2,align:'center',sortable:true,
			     formatter:function(value,rowData,index){
			      return html='<a href="javascript:upddate('+rowData.pid+');" align="center">修改</a>nbsp;|nbsp;<a href="javascript:deletemodel('+rowData.id+');">删除</a>';
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
		            	  location.href=base+"/cms/papers/adminmodel.jsp"; 
		              }  
		    }]
		});}

//点击修改方法
function upddate(id){
	  alert(id);
	  var base=$('#basepath').val();
	  location.href=base+"/cms/updateModel.do?modelid="+id; 
}


//删除方法
function deldata(){
    var mp=0;
    var pms="";
	$.messager.confirm("提示","你确定要删除吗?",function(id){
			if(id){
			var sels=$('#tabs').datagrid('getSelections');
			$.each(sels,function(){
			pms=this.id+","+pms;
			 });
			$.post('cms/delsid.do',{
				mid : pms
				},function(data){
					$.messager.alert('删除成功','删除成功');
					$('#tabs').datagrid('reload');
			},'json');
			}
	});

}
