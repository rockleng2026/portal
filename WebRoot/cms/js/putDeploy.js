$(document).ready(function(){
	var url="cms/splitPagesRec_part.do";
	loadDate(url);
});  
function loadDate(ur){
$(function(){
   $('#dd').datagrid({
    iconCls:'icon-ok',
    fitColumns:false,
    pageSize:15,
	pageList:[5,10,15,20],
    nowrap:false,
    // 奇偶颜色不同
    striped: true,
    collapsible:true,
    url:ur,
    loadMsg:'数据装载中......',
    remoteSort:false,
	pagination:true,
    sortName:'patime',
    sortOrder:'desc',
    columns:[[
     {title:'编号',field:'pastaName',width:'30',rowspan:2,align:'center',resizable:false},
     {title:'pid',field:'pid',hidden:true},
     {title:'参数位置',field:'menid',width:'250',rowspan:2,align:'center',resizable:false},
     {title:'英文名称',field:'menName',width:'230',rowspan:2,align:'center',resizable:false},
     {title:'所属栏目（站点）',field:'pabase',width:'150',rowspan:2,align:'center',resizable:false},
     {title:'所属模块',field:'papayboty',width:'180',rowspan:2,align:'center',resizable:false},
     {title:'最大数量',field:'paperMoney',width:'150',rowspan:2,align:'center',resizable:false},
     {title:'操作',field:'pareward',width:'200',rowspan:2,align:'left',resizable:false,
     formatter:function(value,rowDat,index){
    	 return html='<a href="javascript:update('+rowDat.pid+');">修改</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:dels('+rowDat.pid+')">删除</a>';
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
   $(this).pagination('loaded');
   }
   });
  });
}
$(function(){
	$('#wzfb').click(function(){
		location.href="../../cms/adddateRec_part.do";
	});
});
function update(pid){
	location.href="../../cms/updateRec_part.do?cid="+pid;
}
function dels(pid){
	location.href="../../cms/deltRec_part.do?cid="+pid;
}