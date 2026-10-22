//add功能操作

var countArray = "";
	
	function add()			//按部门添加员工
	{
		$("#mydiv").hide();
		$("#selectD").hide();
		$("#selectDe").show();
		$("#aaa").show();
		$("#bbb").hide();
		$("#flag").val(0); // 标识是按员工审核
		var url = "addDepartmentVerify.do";
		$.post(url,{mark:0},function(data){
			$("#department").show();
			$("#department").append(data);
		});
	}
	function showDept(){  // 显示部门
		$("#flag").val(1);// 标识是按部门审核
		$("#mydiv").show();
		$("#department").hide();
		$("#selectDe").hide();
		$("#selectD").show();
		$("#bbb").show();
		$("#aaa").hide();
	}
	
	function add1()			//添加部门
	{
		
		var url = "addDepartmentVerify.do";
		$.post(url,{mark:1},function(data){
			$("#department").append(data);
		});
	}
	function selectEmp(value,count)			//选择某个部门下的员工集合
	{
		$("#aaa").show();
		$("#bbb").hide();
		countArray += count+",";
		var url = "selectEmpVerify.do";
		if(value=="")
		{
			countArray = "";
		}
		document.getElementById("employee"+count).innerHTML="";
		$.post(url,{departId:value,count:count,mark:0},function(data){
			var dt=data.split("*");
			$("#employee"+count).append(dt[0]);
			if(dt[1]!=null&&dt[1]!="")
				{
			var a=dt[1].split(",");
			oc(a[0],a[1],a[2])
			}
		});
	}
		function selectEmp1(value,count)			//选择某个部门下的员工集合
	{
		$("#aaa").show();
		$("#bbb").hide();
		countArray += count+",";
		var url = "selectEmpVerify.do";
		if(value=="")
		{
			countArray = "";
		}
		document.getElementById("employee"+count).innerHTML="";
		$.post(url,{departId:value,count:count,mark:0},function(data){
			var dt=data.split("*");
			$("#employee"+count).append(dt[0]);
			if(dt[1]!=null&&dt[1]!="")
				{
			var a=dt[1].split(",");
			oc(a[0],a[1],a[2])
			}
		});
	}
	
	 function unique(data)
	 {  
	    data = data || []; //意思是如果data是null 就赋值[]  
	    var a = {} ;//对象  
	    for( var i = 0,len = data.length ; i < len ;i ++) {  
	       var v = data[i];  
	       //如果typeof[a[v]]不等于undefined就说明已经存在这个值了 就不往a对象里面放值了   
	       //这样就保证了数组data中重复的值在a的下标中只存在一个  
	       if('undefined' == typeof(a[v])) {  
	           a[v] = 1; //随便赋值一个 因为这里只要下标 值无关紧要  
	        }  
	   }  
	   //重置数组  
	   data.length = 0;  
	   //往数组中添加值  
	    for(var i in a){  
	       //这里数组的长度会增加  
	       data[data.length] = i;  
	    }  
   		return data;  
	} 

	 //选择要审核的人显示在下边
	function oc(id,name,count)
	{
	//alert(name);
	var as=document.getElementById("ygId").value;
	var bs=document.getElementById("bmId").value;
	if(document.getElementById(id).checked )
		{

			var url = "verifyEmployeeVerify.do";
			$.post(url,{
				employeeId:id,
				departmentId:name,
				count:count
			},function(data){
			$("#aaa").append(data);
		});
			
		
			var sdf =as+id+',';
			$("#ygId").attr("value",sdf);
		
		
			var sdfb =bs+name+',';
			$("#bmId").attr("value",sdfb);
			}
	else{
	    //alert("aaa");
		var aa=document.getElementById("aaa");
		var tab=document.getElementById("tab"+id);
		var elId=as.split(",");
		var dtId=bs.split(",");
		
		var employeeId="";
		var departmentId="";
		for(var a=0;a<elId.length;a++)
			{
				if(elId[a]==id)
					{
						elId[a].remvoe;
						dtId[a].remvoe;
					}
				
				else if (a<elId.length-1){
					employeeId+=elId[a]+",";
					departmentId+=dtId[a]+",";
				}
			}
		$("#ygId").attr("value",employeeId);
		$("#bmId").attr("value",departmentId);
		if(aa.hasChildNodes())
			{	
				if(tab != 'undefined' && tab != null){
				aa.removeChild(tab);
				}
			}
	}
	}
	//进行输入验证

	function ascertain(id)
	{	
		//var df=	document.getElementById("lab"+id).value;
		//alert(df);
		var ipt = document.getElementById("ipt"+id).value;
		var result=ipt.match(/^(-|\+)?\d+$/);

			
		if(ipt==""||ipt==null)
		{
			alert("不能为空！！！！");
		return false;
		}
   		 if (result == null) {
				alert("请输入整数！！！");
				return false;
			}
    	

	}

	function ssss()
	{
		var eyId=document.getElementById("ygId").value;
		var count=eyId.split(",");
		var bmId=document.getElementById("bmId").value;
	
		var ordervalue="";
		for(var i=0;i<count.length;i++)
			{
				if(count.length!=i+1&&count[i]!=null&&count[i]!="")
				{
					var sr=document.getElementById("ipt"+count[i]).value;
					if(sr==""||sr==null)
						{
							alert("不能为空");
							return false;
						}
						ordervalue +=sr+",";
					}
			
			}
		
//		var count1 = eylist.split(",");
//		var a="";
//		for (i = 0; i < count1.length; i++) {
//			var n=0;	
//			if(count1[i]!=null&&count1[i]!="")
//			for (j = i+1; j < count1.length; j++) {
//				if(count1[j]!=null&&count1[j]!="")
//					{
//				if(count1[i]==count1[j])
//					{
//						if(n==0)
//							a+=bmcount[i]+"#"+count[i]+"#"+count1[i]+",";
//						
//						a+=bmcount[j]+"#"+count[j]+"#"+count1[i]+",";
//						
//						count1[j]="";
//						n++;
//						
//					}
//				}
//			
//		}
//	}
		var url = "addmanyVerify.do";
		
		$.post(url,{
			count1:eyId,
			bmcount1:bmId,
			ordervalue:ordervalue
		},function(data){
			$("#deltable").remove();
			$("#bbb").append(data);
		});
		
}
	function addverify1()
	{
		var ygid=document.getElementById("ygId").value;
		var bmid1=document.getElementById("bmId").value;
		var count1=ygid.split(",");
		var ordervalue="";
		var count = countArray.split(",");
		var departmentsArray = "";
		var radio="";
		for(var i=0;i<count.length;i++)							//得到选中的部门集合
		{
			if(count[i]!="")
			{
				departmentsArray += $("#department"+count[i]).val()+",";
			}
		}
		
		var rd=document.getElementsByName("rb");
		 for ( var i = 0; i < rd.length; i++) {
			if (rd[i].checked == true) {
				radio+=rd[i].value;
				}
			}
		 	for(var i=0;i<count1.length;i++)
			{
				if(count1.length!=i+1&&count1[i]!=null&&count1[i]!="")
				{
					var sr=document.getElementById("ipt"+count1[i]).value;
					if(sr!=null&&sr!=""){
					ordervalue +=sr+",";}
					}
			
			}
		 	
		
		
	
				var remark = encodeURI($("#remark").val());
				
				
				var url= "addOrder2Verify.do";
				 $.post(url,{
					ordervalue:ordervalue,
					eyId:ygid,
					bmId1:bmid1,
					order:radio,
					remark:remark
				},function(data){
					//alert(data);
					if(data=="1")
						{
							alert("修改审核流程成功");  
							window.location.href="pageslistVerify.do";
						}
						else
						{
							alert("新修改审核流程失败");
							return ;
						}
				
		 });
	}
	function addverify()
	{
		// 首先判断是按员工还是按部门审核
		var flag=$("#flag").val();
		if(flag==0){
			var ygid=document.getElementById("ygId").value;
			var bmid1=document.getElementById("bmId").value;
			var count1=ygid.split(",");
			var ordervalue="";
			var count = countArray.split(",");
			var departmentsArray = "";
			var radio="";
			for(var i=0;i<count.length;i++)							//得到选中的部门集合
			{
				if(count[i]!="")
				{
					departmentsArray += $("#department"+count[i]).val()+",";
				}
			}
			
			var a=	document.getElementById("remark").value;
			var rd=document.getElementsByName("rb");
			 for ( var i = 0; i < rd.length; i++) {
				 alert(rd[i]);
				if (rd[i].checked == true) {
					radio+=rd[i].value;
					}
				}
			 	for(var i=0;i<count1.length;i++)
				{
					if(count1.length!=i+1&&count1[i]!=null&&count1[i]!="")
					{
						var sr=document.getElementById("ipt"+count1[i]).value;
						if(sr!=null&&sr!=""){
						ordervalue +=sr+",";}
						}
				
				}
			 	
			 var ot = $("#ot").val();
			 var url = "checkordertypeVerify.do";//标识是否存在
			$.post(url,{ot:ot},function(data){
				 if(data=="1")
				{
					$("#ordertypeMsg").html("该标识已 存在，请换一个");
					return ;
				}
				else if(departmentsArray==""){
					alert("请选择部门！！！");
					return false;
				}
				else if(ygid=="")
					{
						alert("请选择员工！！！");
						return false;
	
					}
				else if(ordervalue=="")
					{
						alert("请输入审核顺序！！！");
						
						return false;
					}
				
					var remark = encodeURI($("#remark").val());
					//alert(ordervalue);
					var url= "addOrder1Verify.do";
					 $.post(url,{
						ordervalue:ordervalue,
						bmId:departmentsArray,
						eyId:ygid,
						bmId1:bmid1,
						order:radio,
						remark:remark
					},function(data){
						//alert(data);
						if(data=="1")
							{
								alert("新增审核流程成功");  
								window.location.href="pageslistVerify.do";
							}
							else
							{
								alert("新增审核流程失败");
								return ;
							}
					});
			 });
		}else{
			var bbmId=$("#bbmId").val();
			var ot = $("#ot").val();
			if(ot=="" && ot.length<=0){
				alert("请选择流程单类型！");
				return;
			}
			var count1=bbmId.split(",");
			var ordervalue="";
			for(var i=0;i<count1.length;i++){
				if(count1.length!=i+1&&count1[i]!=null&&count1[i]!=""){
					var sr=document.getElementById("ipt"+count1[i]).value;
					if(sr!=null&&sr!=""){
						ordervalue +=sr+",";
					}
				}
			}
			
			var url = "checkordertypeVerify.do";//标识是否存在
			$.post(url,{ot:ot},function(data){
				 if(data=="1"){
					$("#ordertypeMsg").html("该标识已 存在，请换一个");
					return ;
				 }
				else if(bbmId==""){
					alert("请选择部门！！！");
					return false;
				}
				else if(ordervalue==""){
					alert("请输入审核顺序！！！");
					return false;
				}
				 // 都成功则访问到action添加
				 var remark = $("#remark").val();
				 alert(remark);
					var url= "addDeptOrderVerify.do";
					 $.post(url,{
						ordervalue:ordervalue,
						bbmId:bbmId,
						remark:remark
					},function(data){
						//alert(data);
						if(data=="1"){
							alert("新增审核流程成功");  
							window.location.href="pageslistVerify.do";
						}else{
							alert("新增审核流程失败");
							return ;
						}
					});
			 });
		}
	}
	
	function updateverifyorder(){
		var ygid=document.getElementById("ygId").value;
		var bmid1=document.getElementById("bmId").value;
		var count1=ygid.split(",");
		var ordervalue="";
		var count = countArray.split(",");
		var departmentsArray = "";
		var radio="";
		for(var i=0;i<count.length;i++)							//得到选中的部门集合
		{
			if(count[i]!="")
			{
				departmentsArray += $("#department"+count[i]).val()+",";
			}
		}
		
		var a=	document.getElementById("remark").value;
		var rd=document.getElementsByName("rb");
		 for ( var i = 0; i < rd.length; i++) {
			if (rd[i].checked == true) {
				radio+=rd[i].value;
				}
			}
		 	for(var i=0;i<count1.length;i++)
			{
				if(count1.length!=i+1&&count1[i]!=null&&count1[i]!="")
				{
					var sr=document.getElementById("ipt"+count1[i]).value;
					if(sr!=null&&sr!=""){
					ordervalue +=sr+",";}
					}
			
			}
		// var ordertype = $("#ordertype").val();
				var remark = encodeURI($("#remark").val());
				
				
				var url= "updatevfVerify.do";
				 $.post(url,{
					ordervalue:ordervalue,
					bmId:departmentsArray,
					eyId:ygid,
					bmId1:bmid1,
					order:radio,
					remark:remark
				},function(data){
					if(data=="1")
						{
							alert("修改审核流程成功");  
							window.location.href="pageslistVerify.do";
						}
						else
						{
							alert("修改审核流程失败");
							return ;
						}
		 });
	}
	
 
	 //添加操作
	function summit()
	{
		
		var count = countArray.split(",");
		var departmentsArray = "";
		var department = "";
		for(var i=0;i<count.length;i++)							//得到选中的部门集合
		{
			if(count[i]!="")
			{
				departmentsArray += $("#department"+count[i]).val()+",";
			}
		}
		
		department = departmentsArray.split(",");
		redepartment = unique(department);						//循环遍历数组中重复的数据
		
		var redepartmentsArray = "";
		for(var i in redepartment)								
		{
			if(redepartment[i]!="")
			{
				redepartmentsArray += redepartment[i]+",";                      //循环遍历赋值			
			}
		}
		
		var menu = "";
		for(var i=0;i<department.length;i++)					//循环遍历选中部门的具体员工集合
		{
			if(department[i]!="")
			{
				$("input[name='"+department[i]+"'][@checked]").each(function(){
					menu+=$(this).val()+",";
				});
			}
		}
		
		if(!addValidators())
		{
			return false;
		}
		
		var ordertype = $("#ordertype").val();
		var identify = "";
		var url = "checkordertypeVerify.do";					//标识是否存在
		$.post(url,{ordertype:ordertype},function(data){
			if(data=="1")
			{
				$("#ordertypeMsg").html("该标识已 存在，请换一个");
				return ;
			}
			else
			{
				if(menu=="")
				{
					alert("您未选择部门或员工");
					return ;
				}
				else
				{
					var remark = encodeURI($("#remark").val());
					var url = "addVerify.do";
					$.post(url,{ordertype:ordertype,departments:redepartmentsArray,emps:menu,remark:remark},function(data){
						if(data=="1")
						{
							alert("新增审核流程成功");  
							window.location.href="pageslistVerify.do";
						}
						else
						{
							alert("新增审核流程失败");
							return ;
						}
					});
				}
			}
		});
	}
	
//edit 功能操作
	function delverify(id)
	{
		
		var a= document.getElementById("dtId"+id).value;
		var b=document.getElementById("userId"+id).value;
		var c=document.getElementById("verifyId"+id).value;
	
		var str = window.confirm("您确定要删除所选中的数据信息吗？");
		if(str==true)
			{
			var url="delverifyVerify.do";
			$.post(url,{bmId:a,userId:b,verifyId:c},function(data){
				if(data=="1"){
					alert("删除成功");
					$("#id"+id).remove();
				}
				else{
					alert("删除失败");
				}
				});
			}
	}
	var editArray="";
	
	//修改部门员工触发事件
	function editEmp(value,count)
	{
		editArray += value+",";
		var url = "selectEmpVerify.do";
		$.post(url,{departId:value},function(data){
			document.getElementById("editemployee"+count).innerHTML="";
			$("#editemployee"+count).append(data);
		});
	}

	//修改操作
	function editVerifyOrder()
	{
		var count = countArray.split(",");
		var departmentsArray = "";
		for(var i=0;i<count.length;i++)
		{
			if(count[i]!="")
			{
				departmentsArray += $("#department"+count[i]).val()+",";				//新增部门
			}
		}
		var department = departmentsArray.split(",");
		var menu = "";
		for(var i=0;i<department.length;i++)
		{
			if(department[i]!="")
			{
				$("input[name='"+department[i]+"'][@checked]").each(function(){			//新增部门选中指定员工审核
					menu+=$(this).val()+",";
				});
			}
		}
		var editdepartment = editArray.split(",");
		var editmenu = "";
		for(var i=0;i<editdepartment.length;i++)
		{
			if(editdepartment[i]!="")
			{
				$("input[name='"+editdepartment[i]+"'][@checked]").each(function(){		//修改部门选中指定的员工审核
					editmenu += $(this).val()+",";
				});
			}
		}
		var checkdepartment = "";
		$("input[name='checkdepartment'][@checked]").each(function(){					//未修改的部门员工
			checkdepartment += $(this).val()+",";
		});
		var editdepartment = "";
		$("select[name='editdepartment'] option[@selected]").each(function(){			//修改的部门
			editdepartment += $(this).val()+",";
		});
		var newdepartment = editdepartment+departmentsArray;							//修改过的部门加新增部门的部门id集合
		var newemployee = editmenu+checkdepartment+menu;								//修改过的部门选中员工和未修改的部门选中员工以及新增部门选中员工
		var ordertype = $("#ordertype").val();											//标识
		var biaozhi = $("#biaozhi").val();
		
		var newdepartments = newdepartment.split(",")
		var renewdepartments = unique(newdepartments);						//循环遍历数组中重复的数据
		
		var renewdepartmentstr = "";
		for(var i in renewdepartments)								
		{
			if(renewdepartments[i]!="")
			{
				renewdepartmentstr += renewdepartments[i]+",";                      //循环遍历赋值			
			}
		}
		
		var newemployees = newemployee.split(",");
		var renewemployees = unique(newemployees);
		var newemployeesstr = "";
		for(var i in renewdepartments)								
		{
			if(renewemployees[i]!="")
			{
				newemployeesstr += renewemployees[i]+",";                      //循环遍历赋值			
			}
		}
		
		if(!addValidators())
		{
			return false;
		}
		else
		{
			var identify = "";
			var url = "checkordertypeVerify.do";
			
			if(biaozhi!=ordertype)
			{
				$.post(url,{ordertype:ordertype},function(data){
					if(data=="1")														//修改标识，并且该标识已经存在，提示已经存在
					{
						$("#ordertypeMsg").html("该标识已 存在，请换一个");
						return ;
					}
					else																//修改标识，但该标识未存在，则执行修改操作
					{
						execute(ordertype,renewdepartmentstr,newemployeesstr);
					}
				});
			}
			else
			{
				execute(ordertype,renewdepartmentstr,newemployeesstr);							//未修改标识，但修改部门或员工，则执行修改操作
			}
		}
	}
	
	//修改执行Action方法
	function execute(ordertype,newdepartment,newemployee)
	{
		var vid = $("#vid").val();
		var remark = encodeURI($("#remark").val());
		var url = "editVerify.do";
			$.post(url,{id:vid,ordertype:ordertype,departments:newdepartment,emps:newemployee,remark:remark},function(data){
				if(data=="1")
				{
					alert("修改审核流程成功");
					window.location.href="pageslistVerify.do";
				}
				else
				{
					alert("修改审核流程失败");
					return ; 
				}
			});
	}
	
	//删除行
	
	function deltr(op,count)
	{
		var len = document.getElementsByName("editdepartment").length;
		//
		var as=document.getElementById("ygId").value;
		var bs=document.getElementById("bmId").value;
		if(len == 1)
		{
			alert("至少有一个部门存在！");
		}
		else
		{	if(!document.getElementById("del"+count))
			{
				$("#"+op+count).remove();
			}
			else
				{
				var  department=document.getElementById("del"+count).value;
				$("#"+op+count).remove();
					if(bs!=null&&bs!="")
					{
						var elId=as.split(",");
						var dtId=bs.split(",");
						
						var employeeId="";
						var departmentId="";
						for(var a=0;a<elId.length;a++)
							{
								if(dtId[a]==department)
									{
									$("#tr"+count).remove();
										elId[a].remvoe;
										dtId[a].remvoe;
									}
								else if (a<elId.length-1){
									employeeId+=elId[a]+",";
									departmentId+=dtId[a]+",";
								}
							}
						$("#ygId").attr("value",employeeId);
						$("#bmId").attr("value",departmentId);
					}
			}
		}
		
	}
	
	
	/**
	 * 选择相应的标识
	 */
	function selmark(str){
		
		$("#ordertype").attr("value",$(str).val());
	}
function selmark1(str){
		var id=$(str).val();
		$("#ot").attr("value",$(str).val());
		var url="dtNameVerify.do";
		$.post(url,{btid:id},function(data){
		$("#ot").attr("value",data);
		});
	}

	/*************
	 * 勾选部门
	 */
	var deptid=""; 
	function checkEmp(check){
	  var did = check.id;
	  if(check.checked==true){
	     deptid+=did+",";
	  }else if(check.checked==false){
		  deptid=deptid.replace(did+",","");
	  }
	  var url="selectDeptVerify.do";
	  $.post(url,{deptid:deptid},function(data){
			$("#aaa").hide();
			$("#bbb").show();
			$("#bbb").html(data);
	  });
	  $("#bbmId").attr("value",deptid);
	}



	
	