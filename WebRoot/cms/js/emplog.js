
$(document).ready(function(){  
var	url ="splitPagesWorkLog.do";
loadGrid(url);  
}); 
function loadGrid(ur){
		$('#tabs').datagrid({
			fit:true,
			pageSize:15,
			fitColumns:false,
			rownumbers:true,
			pageList:[5,10,15,20],			
			nowrap: true,	//把数据显示在一行里,可以自动换行	
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
			     {field:'id',title:'id',hidden:true},
			     {field:'empname',title:'员工',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'dept',title:'部门',width:'150',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'zw',title:'职位',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'log',title:'日志',width:'80',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'pOper',title:'操作',width:'150',rowspan:2,align:'left',sortable:true,resizable:false,
			     formatter:function(value,rowData,index){
			      var pps;
			      if(rowData.log==0){
			    	  pps=1;
			      }else{
			    	  pps=0;
			      }
			     return html='<a href="javascript:upddate('+rowData.id+');">查看详情</a>&nbsp;&nbsp;&nbsp;';
			     } 
			     }
			    ]]
		});
	   displayMsg();
}

function displayMsg(){
	$('#tabs').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
  }
