  $(document).ready(function (){
		$('#dd').datagrid({
			fit:true,
			pageSize:15,
			fitColumns:false,
			rownumbers:true,
			pageList:[5,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:'cms/onlineCount.do',		
			loadMsg:'数据正在加载...',	
			sortName:'pid',					
			sortOrder:'desc',					
			remoteSort:false,	
            columns:[[
                  {title:'编号',field:'sid',width:'30',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'mid',field:'smid',hidden:true},
	              {title:'商品编码',field:'scode',width:'215',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品名称',field:'sName',width:'215',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品型号',field:'stype',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品规格',field:'standard',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品价格',field:'sprice',width:'300',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'录入时间',field:'stime',width:'300',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'操作',field:'soper',width:'200',rowspan:2,align:'left',sortable:true,resizable:false,
				   formatter:function(value,rowData,index){
				       return html='<a href="javascript:mss();">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:showOrhide('+pps+','+rowData.pastaName+');">查看详情</a>';
				    } 
				    }
				    ]],
			pagination:true,
			rownumbers:false  
		});
		
	    displayMsg();
	});
  function displayMsg(){
		$('#dd').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
	
  }