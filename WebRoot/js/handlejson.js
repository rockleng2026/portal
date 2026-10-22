		
		
		/**
		 * 任务列表顶级目录
		 * @return
		 */
		function missiontypelist(objid,editid,url)
		{

			//alert(objid);
			$.getJSON("getmisssiontypeHandleJson.do",function(data){
		 		$.each(data,function(i,item){
		  	    	if(0 == item.superid){  
		  	    		if(editid == item.id){
		  	    			
		  	    			$("#"+objid).append("<option value='"+item.id+"' selected>"+item.ame +"</option>"); 
	            		}else{
                      	$("#"+objid).append("<option value='"+item.id+"'>"+item.name +"</option>");
	            		}
                        missiontype(1,item.child,objid,editid);    
                    }    
				});
			});
			
			//$.post("getQuestionCategoryListHandleJson.do",null,function(data){alert(data);});
		}
		/**
		 * 添加到任务类型的select框中
		 * @param len
		 * @param data
		 * @param objid
		 * @return
		 */
		function missiontype(len,data,objid,editid){    
       		var prefix = "|";    
        	for(var i=0;i<len;i++){    
            	prefix += "--";    
        	}    
        	$.each(data,function(i,item){    
            	if(0 < item.child.length){   
            		if(editid == item.id){
            			$('#'+objid).append("<option value="+item.id +" selected>" + prefix + itemname + "</option>");    
            		}else{
                	$('#'+objid).append("<option value="+item.id +">" + prefix + itemname + "</option>");    
            		}
               	 	missiontype(len+1,item.child,objid,editid);    
            	}   
        	});    
    	}   
		/**
		 * 问题列表顶级目录
		 * @return
		 */
		function questioncategorylist(objid,editid,url)
		{

			$.getJSON("getQuestionCategoryListHandleJson.do",function(data){
		 		$.each(data,function(i,item){
		  	    	if(0 == item.superid){  
		  	    		if(editid == item.id){
		  	    			
		  	    			$("#"+objid).append("<option value='"+item.id+"' selected>"+item.questionName +"</option>"); 
	            		}else{
                      	$("#"+objid).append("<option value='"+item.id+"'>"+item.questionName +"</option>");
	            		}
                        buildNode(1,item.child,objid,editid);    
                    }    
				});
			});
			
			//$.post("getQuestionCategoryListHandleJson.do",null,function(data){alert(data);});
		}
		/**
		 * 问题列表子级目录
		 * @param len		循环 --
		 * @param data		子集合列表
		 * @return
		 */
		function buildNode(len,data,objid,editid){    
       		var prefix = "|";    
        	for(var i=0;i<len;i++){    
            	prefix += "--";    
        	}    
        	$.each(data,function(i,item){    
            	if(0 < item.child.length){   
            		if(editid == item.id){
            			$('#'+objid).append("<option value="+item.id +" selected>" + prefix + item.questionName + "</option>");    
            		}else{
                	$('#'+objid).append("<option value="+item.id +">" + prefix + item.questionName + "</option>");    
            		}
               	 	buildNode(len+1,item.child,objid,editid);    
            	}   
        	});    
    	}    
		
		/**
		 * 顶级目录列表
		 * @param objid  页面id、如：select框id
		 * @param editid  修改功能，默认选择id
		 * @param url		执行Action url
		 * @return
		 */
		function categorylist(objid,editid,url)
		{
			var url = "getDepartementListHandleJson.do";
			$.getJSON(url,function(data){
		 		$.each(data,function(i,item){
		  	    	if(0 == item.parentId){  
                         if(editid == item.id){
                        	 $("#"+objid).append("<option value='"+item.id+"' selected>"+item.name +"</option>"); 
                         }else{
                      	$("#"+objid).append("<option value='"+item.id+"'>"+item.name +"</option>");
                         }
                      	subcategorylist(1,item.child,objid,editid);    
                    }    
				});
			});
		}
		
		/**
		 * 子目录列表
		 * @param len		循环 --
		 * @param data		子集合列表
		 * @param objid		页面id、如：select框id
		 * @param editid	修改功能，默认选择id
		 * @return
		 */
		function subcategorylist(len,data,objid,editid)
		{
			var prefix = "|";    
        	for(var i=0;i<len;i++){    
            	prefix += "--";    
        	}    
        	$.each(data,function(i,item){    
            	if(0 < item.child.length){    
            		 if(editid == item.id){
            			 $("#"+objid).append("<option value='"+item.id+"' selected>" + prefix + item.name +"</option>");
                     }else{
                	$("#"+objid).append("<option value='"+item.id+"'>" + prefix + item.name +"</option>");
                     }
                	subcategorylist(len+1,item.child,objid,editid);   
            	}   
        	});    
		}
		
		//js获取项目根路径， http://localhost:8080/FAJxc
		function getRootPath(){    
			//获取当前网址， http://localhost:8080/FAJxc/foreGroundFolder/customProscenium/login.jsp
			var curWwwPath=window.document.location.href;    
			//获取主机地址之后的目录，FAJxc/foreGroundFolder/customProscenium/login.jsp
			var pathName=window.document.location.pathname;    
			var pos=curWwwPath.indexOf(pathName);    
			//获取主机地址，http://localhost:8080    
			var localhostPaht=curWwwPath.substring(0,pos);    
			//获取带"/"的项目名，/FAJxc    
			var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);    
			return(localhostPaht + projectName);
		}
		
		/**
		 * subnote.jsp 页面关于产品类型和问题类型实现级联
		 * @param objid	问题类型的select框的id
		 * @param id	选中的产品类型id
		 * @return
		 */
		function producttype(objid,id)
		{
			//alert("test..");
			$.post("getorderlistCustomerServer.Action",{typeId:id},function(date){

			    if(date == 1 || date ==''){					    	
			    	$("#new_addr").html("<option value='no'>您没有此项业务</option>");
			    }else if(date==0){
				    var path = getRootPath();
				    alert("请先登录");
				    window.location.href=path+"/foreGroundFolder/customProscenium/login.jsp";
			    }else if(date !=0 && date !=1 && date!= ''){
			    	$("#new_addr").html(date);	
			    }
					   
			});
			
			document.getElementById(objid).options.length = 0;
			$("#"+objid).append("<option value=''>--请选择--</option>");
			var url = "getQuestionCategoryListHandleJson.do";
			$.getJSON(url,function(data){
		 		$.each(data,function(i,item){
		  	    	if(id == item.id){   
		  	    		//alert(item.child,objid);
                      	questiontype(1,item.child,objid);    //调用，添加子级联
                    }    
				});
			});
		}
		/**
		 * subnote.jsp 员工提交工单页面关于产品类型和问题类型实现级联
		 * @param objid	问题类型的select框的id
		 * @param id	选中的产品类型id
		 * @return
		 */
		function producttype2(objid,id)
		{
			//alert(222);
			var customerid = $("#cusname").val();
			if(customerid == null || customerid == ''){
				alert("请先选择客户");
				return false;
			}
			$.post("getorderlist2CustomerServer.do",{typeId:id,customerId:customerid},function(date){

			    if(date == 1 || date ==''){					    	
			    	$("#new_addr").html("<option value='no'>您没有此项业务</option>");
			    }else if(date==0){
				    var path = getRootPath();
				    alert("请先登录");
				    //window.location.href=path+"/login.jsp";
				    parent.location.href=path+"/login.jsp"
			    }else if(date !=0 && date !=1 && date!= ''){
			    	$("#new_addr").html(date);	
			    }
					   
			});
			//alert(333);
			document.getElementById(objid).options.length = 0;
			//alert(444);
			$("#"+objid).append("<option value=''>--请选择--</option>");
			var url = "getQuestionCategoryListHandleJson.do";
			$.getJSON(url,function(data){
		 		$.each(data,function(i,item){
		  	    	if(id == item.id){   
                      	questiontype(1,item.child,objid);    //调用，添加子级联
                    }    
				});
			});
		}
		/**
		 * 添加到问题类型的select框中
		 * @param len
		 * @param data
		 * @param objid
		 * @return
		 */
		function questiontype(len,data,objid)
		{
			var prefix = "|";    
        	for(var i=0;i<len;i++){    
            	prefix += "--";    
        	}    
        	$.each(data,function(i,item){
        		//alert("len="+item.child.length);
            	if(item.child.length>0){    
            		$("#"+objid).append("<option value='"+item.id+"'>" + prefix + item.questionName +"</option>");
            		
                	questiontype(len+1,item.child,objid);    
            	}   
        	});    
		}
		/**
		 * 商品类型
		 * @return
		 */
		function commdity(objid,editid,url)
		{
			$.getJSON("getcommoditListHandleJson.do",function(data){
		 		$.each(data,function(i,item){
		  	    	if(0 == item.superidd){  
		  	    		if(editid == item.id){
		  	  			
		  	    			$("#"+objid).append("<option value='"+item.id+"' selected>"+item.typeName +"</option>"); 
		  	    			
	            		}else{
                      	$("#"+objid).append("<option value='"+item.id+"'>"+item.typeName +"</option>");
	            		}
                        comm(1,item.child,objid,editid);    
                    }    
				});
			});
			
			//$.post("getQuestionCategoryListHandleJson.do",null,function(data){alert(data);});
		}
		/**
		 * 商品类型
		 * @param len		循环 --
		 * @param data		子集合列表
		 * @return
		 */
		function comm(len,data,objid,editid){    
       		var prefix = "|";    
        	for(var i=0;i<len;i++){    
            	prefix += "--";    
        	}    
        	$.each(data,function(i,item){    
            	if(0 < item.child.length){   
            		if(editid == item.id){
            			$('#'+objid).append("<option value="+item.id +" selected>" + prefix + item.typeName + "</option>");    
            		}else{
                	$('#'+objid).append("<option value="+item.id +">" + prefix + item.typeName + "</option>");    
            		}
            		comm(len+1,item.child,objid,editid);    
            	}   
        	});    
    	}    
			
		
	
		