$(function(){ 
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
$(document).ready(function (){
	var pps='cms/splitPagesComments.do';
	loadDate(pps);
});
  function loadDate(up,size){
		$('#dd').datagrid({
			fit:false,
			fitColumns:false,
			rownumbers:true,
			pageSize:15,
			pageNumber:size,
			pageList:[5,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:up,		
			loadMsg:'数据正在加载...',								
			remoteSort:false,	
			frozenColumns:[[
		    {field:'ck',checkbox:true}
            ]],
            columns:[[
                      {title:'id',field:'psho',hidden:true},
                      {title:'pid',field:'pid',hidden:true},
                      {title:'编号',field:'conid',width:'30',rowspan:2,align:'center',resizable:false},
                      {title:'信息类别',field:'menName',width:'150',rowspan:2,align:'center',resizable:false},
                      {title:'标题',field:'pabase',width:'200',rowspan:2,align:'center',resizable:false},
                      {title:'简介',field:'papayboty',width:'250',rowspan:2,align:'center',resizable:false},
                      {title:'是否显示',field:'pshow',width:'80',rowspan:2,align:'center',resizable:false},
                      {title:'审核状态',field:'pareward',width:'80',rowspan:2,align:'center',resizable:false},     
                      {title:'录入时间',field:'pawage',width:'170',rowspan:2,align:'center',resizable:false},
			          {field:'pOper',title:'操作',width:'200',rowspan:2,align:'left',sortable:true,resizable:false,
				     formatter:function(value,rowData,index){
                      var date1="";
                      var date2="";
                      var date3;
                      var date4;
                      if(rowData.pareward=="待审核"){
                    	  date1="审核中";
                    	  date3=1;
                    	  date2="审核通过";
                    	  date4=2;
                      }else if(rowData.pareward=="审核中"){
                    	  date2="审核通过";
                    	  date4=2;
                      }else{
                    	
                      }
				     return html='<a href="javascript:upddate('+rowData.pid+');">修改</a>&nbsp;&nbsp;&nbsp;<a href="javascript:checks('+date3+','+rowData.pid+')">'+date1+'</a>&nbsp;&nbsp;&nbsp;<a href="javascript:checks('+date4+','+rowData.pid+')">'+date2+'</a>';
				     } 
				     }
			    ]],
			pagination:true,
			rownumbers:false,
			 toolbar:[{
		         	text:'批量审核',
		         	iconCls:'icon-ok',
		             handler:chk
		              
		        }]
		});
	displayMsg();
  }
 function displayMsg(){
		$('#dd').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
 }
 function chk(){
	 checks('a','b');
 }
 function checks(nums,cid){
	 //alert(nums+","+cid);
	 var urls;
	 $.messager.confirm("提示","你确定修改吗?",function(id){
	   if(id){
		if(nums!='a'){
			alert("cid="+cid);
			urls="cms/checkdComments.do?pas=single";
		}else{
			var sel=$('#dd').datagrid("getSelections");
			cid="";
			nums="";
			$.each(sel,function(){
				cid=this.pid+","+cid;
			});	
			urls="cms/checkdComments.do?pas=manys";
		}
		$.ajax({
			type:"post",
			url:urls,
			data:{del:nums,mid:cid},
			dataType:"json",
			success:function(result){
				$.messager.alert("提示",result.del,"info");
				$('#dd').datagrid('reload');
			}
		    });
	   }
	 });
 }
 function upddate(pid){
	  var base=$('#basepath').val();
	  //alert("pid"+pid+"pa="+base);
	  location.href=base+"/cms/updateComments.do?cid="+pid; 
 }
 function subs(){
	  var pa1 = $('#status option:selected').val();
	  var pa2 = $('#typeid option:selected').val();
	  ///alert(pa1+","+pa2);
	  var parms=$('#dd').datagrid('options').queryParams;
	  parms.condit1=pa1;
	  parms.condit2=pa2;
	    var urle="cms/selectComments.do";
	    var pse=1;
	    loadDate(urle,pse);
 }