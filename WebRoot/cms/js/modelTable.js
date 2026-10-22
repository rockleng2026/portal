 $(document).ready(function (){
		$('#dd').datagrid({
			fit:false,
			fitColumns:false,
			rownumbers:true,
			pageSize:20,
			pageList:[2,5,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:'',		
			loadMsg:'数据正在加载...',				
			sortName:'pid',					
			sortOrder:'desc',					
			remoteSort:false,	
			frozenColumns:[[
		    {field:'ck',checkbox:true}
            ]],
            columns:[[
                      {title:'id',field:'pastaName',hidden:true},
                      {title:'编号',field:'moid',width:'10',rowspan:2,align:'center',resizable:false},
                      {title:'模板名',field:'moName',width:'10',rowspan:2,align:'center',resizable:false},
                      {title:'类别',field:'mostat',width:'15',rowspan:2,align:'center',resizable:false},
                      {title:'风格',field:'mostyle',width:'15',rowspan:2,align:'center',resizable:false},
                      {title:'模板路径',field:'mopath',width:'10',rowspan:2,align:'center',resizable:false},
                      {title:'文件名',field:'mofile',width:'10',rowspan:2,align:'center',resizable:false},     
			          {field:'pOper',title:'操作<a href="">添加模板</a>&nbsp;&nbsp;<a href="javascript:void(0);">校正父类</a>',width:'15',rowspan:2,align:'left',sortable:true,resizable:false,
				     formatter:function(value,rowData,index){
				     return html='<a href="javascript:mss('+obj+');">修改</a>&nbsp;&nbsp;&nbsp;<a href="">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="">生成静态页</a>';
				     } 
				     }
			    ]],
			pagination:true,
			rownumbers:true
		});
	displayMsg();
	});