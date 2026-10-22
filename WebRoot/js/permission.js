//全选与反选  
		function selectchange(form_name,id_name,id1_name) 
 		{     
     		obj=eval("document."+form_name+"."+id_name);  
   			num=obj.length;  
   			
   			obj1 =eval("document."+form_name+"."+id1_name);  
    		num1 = obj1.length;
   			
    		for (var i=0; i<num; i++)   
   			{     
       			if(obj[i].checked==true)  
            		{obj[i].checked=false}  
       			else  
            		{obj[i].checked=true;}  
    		}  
    		
    		for(var j=0;j<num1;j++)
    		{
    			if(obj1[j].checked==true)
    			{
    				obj1[j].checked=false;
    			}
    			else
    			{
    				obj1[j].checked=true;
    			}
    		}
 		}  
		
		//显示点击具体模块的层
		function showDiv(functionid)
		{
			var functionid = functionid;
			var id = $("#showOrHiddenDiv"+functionid);
			for(var i=1;i<=1000;i++)
			{
				if(i==functionid)
				{
					id.show();	
				}
				else
				{
					$("#showOrHiddenDiv"+i).hide();
				}
			}
		}

		//设置角色权限功能
		function checkRoleFunction(roleid)
		{
			var menu = "";
			var permission = "";
			$("input[@name='checkName'][@checked]").each(function(){
				menu+=$(this).val()+",";
			});
			$("input[@name='checkPermission'][@checked]").each(function(){
				permission+=$(this).val()+",";
			});
			
			var str = window.confirm("您确定要为该角色设置所选的权限信息吗？")
			if(str==true)
			{
				var url = "setRolePermissionSystemRole.do";
				$.post(url,{roleid:roleid,functionIDs:menu,permissions:permission},function(data){
					if(data>0)
					{
						alert("设置角色权限成功");
						window.location.href="roleListSystemRole.do?funid=106";
					}
					else
					{
						alert("设置角色权限失败");
						return ;
					}
				});
			}
			else
			{
				return ;
			}
			
		}
		
		//设置岗位权限功能
		function checkPositionFunction(positionid)
		{
			var path=$("#path").val();
			var menu = "";
			var permission = "";
			$("input[@name='checkName'][@checked]").each(function(){
				menu+=$(this).val()+",";
			});
			$("input[@name='checkPermission'][@checked]").each(function(){
				permission+=$(this).val()+",";
			});
			
			var str = window.confirm("您确定要为该岗位设置所选的权限信息吗？")
			if(str==true)
			{
				var url = path+"/positionQXPosition.do";
				$.post(url,{positionid:positionid,functionIDs:menu,permissions:permission},function(data){
					if(data>0)
					{
						alert("设置角色权限成功");
						window.location.href=path+"/positionListPosition.do?funid=404";
					}
					else
					{
						alert("设置角色权限失败");
						return ;
					}
				});
			}
			else
			{
				return ;
			}
			
		}

		//勾选父级项
		function selectSuperId(op)
		{
			var fid = op;
			var fids = fid.split(",");
			
			for(var i=0;i<fids.length;i++)
			{
				$("input[@name='checkName'][@value='"+fids[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
		}
		
		//全选和取消全选   参数是checkbox 的Id
		function checkAll(checkName,checkPermission)
		{
			var chkall = $("#chkall").attr("checked");
			if(chkall==true)
			{
				$("input[@name='"+checkName+"']").each(function(){
					$(this).attr("checked",true);
				});
				$("input[@name='"+checkPermission+"']").each(function(){
					$(this).attr("checked",true);
					
				});
			}
			else
			{
				$("input[@name='"+checkName+"']").each(function(){
					$(this).attr("checked",false);
				});
				$("input[@name='"+checkPermission+"']").each(function(){
					$(this).attr("checked",false);
				});
			}
		}
		
		//取消选中项
		function checkcancel()
		{
			$("input[@name='checkName']").each(function(){
				$(this).attr("checked",false);
			});
			
			$("input[@name='checkPermission']").each(function(){
				$(this).attr("checked",false);
			});
		}
		//设置用户权限
		function checkFunction(uid)
		{
			var menu = "";
			var permission = "";
			$("input[@name='checkName'][@checked]").each(function(){
				menu+=$(this).val()+",";
			});
			$("input[@name='checkPermission'][@checked]").each(function(){
				permission+=$(this).val()+",";
			});
			
			var url = "setPermissionSystem.do";
			$.post(url,{userid:uid,functionIDs:menu,permissions:permission},function(data){
				if(data>0)
				{
					alert("权限设置成功");
					window.location.href="userListSystem.do?mark=employee";
				}
				else
				{
					alert("权限设置失败");
					return ;
				}
			});
		}