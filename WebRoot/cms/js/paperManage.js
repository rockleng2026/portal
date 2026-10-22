$(function (){  
	
		$("#typeid").click(function(){
			if(document.getElementById("typeid").options.length==1){
			 $.ajax({
				  type: "POST",
				  url: "cms/loadNews.do",
				  data:"",
				  success: function(data){
				    $('#typeid').append(data);
			       }
				 });
			}
		});
});
$(document).ready(function(){  
var	url ="cms/splitPagesNews.do";
loadGrid(url);  
}); 
function loadGrid(ur,ps){
		$('#tabs').datagrid({
			fit:false,//这个为true在其他浏览器下列表无法显示
			pageSize:15,
			fitColumns:false,
			rownumbers:true,
			pageList:[5,10,15,20],			
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
			     {field:'id',title:'编号',width:'30',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'sequence',title:'优先级',width:'50',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'pid',title:'pid',hidden:true},
			     {field:'psh',title:'psh',hidden:true},
			     {field:'pst',title:'信息类别',width:'150',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'ptl',title:'标题',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'keys',title:'关键字',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'psho',title:'是否显示',width:'80',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'psta',title:'审核状态',width:'80',rowspan:2,align:'center',sortable:true,resizable:false},
				 {field:'pcot',title:'简介',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'ptime',title:'录入时间',width:'170',rowspan:2,align:'center',sortable:true,resizable:false},
			     {field:'pOper',title:'操作',width:'150',rowspan:2,align:'left',sortable:true,resizable:false,
			     formatter:function(value,rowData,index){
			      var pps;
			      if(rowData.psho=='隐藏'){
			    	  pps=0;
			      }else{
			    	  pps=1;
			      }
			      
			     return html='<a href="javascript:upddate('+rowData.pid+');">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:showOrhide('+pps+','+rowData.pid+');">'+rowData.psh+'</a>&nbsp;&nbsp;&nbsp;<a href="javascript:deldata('+rowData.pid+');">删除</a>';
			     } 
			     }
			    ]],
			pagination:true,
			rownumbers:false,
		    toolbar:[{
		         	text:'批量删除',
		         	iconCls:'icon-cancel',
		             handler:deldata
		              },'-',{
		              text:'文章发布',
		              iconCls:'icon-add',
					  handler:function(){
		            	  var base=$('#basepath').val();
		            	  location.href=base+"/cms/papers/paperOut.jsp"; 
		              }
		    }]
		});
	   displayMsg();
}
  function upddate(pid){
	  //alert(pid);
	  var base=$('#basepath').val();
	  //alert("1111"+base);
	  
	  location.href=base+"/cms/updateNews.do?cid="+pid; 
  }
  function showOrhide(fg,id){
	  var basepath = $("#basepath").val();
	  //alert(1111);
	  //alert(basepath);
	  window.location.href=basepath+"/cms/showNews.do?cid="+id+"&state="+fg;
  }
  function deldata(id){
	    var mp=0;
	    var pms="";
		$.messager.confirm("提示","你确定要删除吗?",function(id){
				if(id){
				var sels=$('#tabs').datagrid('getSelections');
				$.each(sels,function(){
				pms=this.pid+","+pms;
				 });
				$.post('cms/delnews.do',{
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
