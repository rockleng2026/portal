  $(document).ready(function (){
		 read('cms/storeCount_stormRoomDateDeal.do?params=all');
		 $('#butn').click(function(){
	           var ids= $('#hids').val();
	           read('cms/storeCount_stormRoomDateDeal.do?params=middle&stoid='+ids,0);
	       });
		 $('#subs').click(function(){
			var p1=$('#sect1').val();
			var p2=$('#sect2').val();
			var p3=$('#sect3').val();
			var p4=$('#sect4').val();
			var p5=$('#selss').val();
			if(p4==""){
				p6=0;
			}else{
			    p6=p4;	
			}
			read("cms/storeCount_storeSelectDate.do?st1="+p1+"&st2="+p2+"&st3="+p3+"&st4="+p6+"&st5="+p5);
		 });
	});
  function read(path,pa){
	  $('#dd').datagrid({
			fit:true,
			pageSize:15,
			fitColumns:false,
			pageNumber:pa,
			rownumbers:true,
			pageList:[5,10,15,20],			
			nowrap: true,						//把数据显示在一行里,可以自动换行
			striped: true,						//奇偶行使用不同背景色
			collapsible:true,					//可折叠
			url:path,		
			loadMsg:'数据正在加载...',	
			sortName:'house',					
			sortOrder:'asc',					
			remoteSort:false,	
          columns:[[
                {title:'所属机房',field:'house',width:'400',rowspan:2,align:'center',sortable:true,resizable:false},
                {title:'商品编码',field:'coding',width:'200',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品名称',field:'name',width:'300',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'数量',field:'num',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'单位',field:'unit',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'单价',field:'price',width:'100',rowspan:2,align:'center',sortable:true,resizable:false},
	              {title:'商品类型',field:'type',width:'210',rowspan:2,align:'center',sortable:true,resizable:false}
				 ]],
			pagination:true,
			rownumbers:false
		});
		
	    displayMsg();
  }
  function displayMsg(){
		$('#dd').datagrid('getPager').pagination({displayMsg:"<span>当前显示从{from}到{to}共{total}记录</span>"});
  }
  $(function(){
	  //一个
	  var flags;
	   $('#sect1').click(function(){
	       if(document.getElementById("sect1").options.length==1){ 
	    	   flags="st1";
	          $.ajax({
	            type:"post",
	            url:"cms/storeCount_getSingleSelect.do",
	            data:{flagString : flags},
	            success:function(res){
	               $('#sect1').append(res);
	            }
	          });
	          }
	       });
	   
	   //二个
	   $('#sect2').click(function(){
	       if(document.getElementById("sect2").options.length==1){
	    	   flags="st2";
	          $.ajax({
	            type:"post",
	            url:"cms/storeCount_getSingleSelect.do",
	            data:{flagString : flags},
	            success:function(res){
	               $('#sect2').append(res);
	            }
	          });
	          }
	       });
	  
	   //三个
	   $('#sect3').click(function(){
	       if(document.getElementById("sect3").options.length==1){
	    	   flags="st3";
	          $.ajax({
	            type:"post",
	            url:"cms/storeCount_getSingleSelect.do",
	            data:{flagString : flags},
	            success:function(res){
	               $('#sect3').append(res);
	            }
	          });
	          }
	       });
	  
  });