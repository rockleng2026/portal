 $(function(){
   $('#dd').datagrid({
    iconCls:'icon-ok',
    pageSize:15,
    fitColumns:false,
	pageList:[5,10,15,20],
    nowrap:false,
    // 奇偶颜色不同
    striped: true,
    collapsible:true,
    url:'paySalary!onePayFor.action',
    loadMsg:'数据装载中......',
    remoteSort:false,
    sortName:'patime',
    sortOrder:'desc',
    columns:[[
     {title:'姓名',field:'pastaName',width:'150',rowspan:2,align:'center',resizable:false},
     {title:'联系电话',field:'menid',width:'100',rowspan:2,align:'center',resizable:false},
     {title:'联系内容',field:'menName',width:'200',rowspan:2,align:'center',resizable:false},
     {title:'发表时间',field:'pabase',width:'150',rowspan:2,align:'center',resizable:false},
     {title:'回复内容',field:'papayboty',width:'200',rowspan:2,align:'center',resizable:false},
     {title:'回答时间',field:'paperMoney',width:'100',rowspan:2,align:'center',resizable:false},
     {title:'状态',field:'pareward',width:'60',rowspan:2,align:'center',resizable:false},     
     {title:'操作',field:'pawage',width:'200',rowspan:2,align:'center',resizable:false}
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