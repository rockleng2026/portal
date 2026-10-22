var GloableComplete;
var parameArray;
String.prototype.ltrim = function(){ 
	return this.replace(/^\s*(.+?)$/,'$1'); 
} 

var liusir = { 
} 

liusir.AjAx = function(){this.initialize.apply(this, arguments);}
liusir.AjAx.prototype = {
	initialize: function(complete,javaMeth,columnArray){
		GloableComplete = complete; 
		this.javaMethod = javaMeth;	
		parameArray = columnArray;
	},
	request: function(param){
		var KEY_WORD = 5;
		
		var aa = document.getElementById("currentBranchId");
		var bb = document.getElementById("currentDeptTree");
		var branchId=null;
		var dd;
		if (aa != null && bb != null) {
		    dd=aa.value + ";" + bb.value;
		} 
		
		
		
		buffalo.remoteCall(this.javaMethod,[KEY_WORD,param,dd],this.resultData);
	},
	resultData: function(reply){
		GloableComplete.load_data(reply);	
	}	
}

liusir.TextSuggest = function(){this.initialize.apply(this, arguments);} 
liusir.TextSuggest.prototype = { 
	initialize: function(){}, 
	add_suggest: function(inp, javaMeth, columnArray, defer, defer2){ 
		var inp = $(inp); 
		inp.defer = defer || null; 
		inp.defer2 = defer2 || 200; 
		var sw = inp.offsetWidth, sh = inp.offsetHeight; 
		inp.suggest_list = this.create_list(sw, sh); 
		inp.suggest_list.par = inp; 
		inp.xmlHttp = new liusir.AjAx(inp.suggest_list,javaMeth,columnArray); 

		Object.extend(inp, { 
			requesting : false, 
			last_result : true, 
			previous_value : null, 
			last_value : null, 
			kt : null, 
			rt : null, 
			load_event: function(){ 
				if(this.addEventListener){ 
					this.addEventListener('input', this.keyup_handler.bindAsEventListener(this),false); 
				}else if(this.attachEvent){ 
					this.attachEvent('onkeyup', this.keyup_handler.bindAsEventListener(this)); 
				} 
			}, 
			checkOption: function(str,id){
				var rightSelect = $('rightList');
				if(rightSelect != null){
					var showName;
					if(parameArray.size() == 4){
						showName = id + "|" + str;
					}else{
						showName = id;
					}
					if(currentUsersList.indexOf(";" + showName + ";") < 0){
						currentUsersList += showName + ";";
						this.createOption(rightSelect,str,id);	
					}
				}	
			},
			createOption: function(obj,str,val){
				if(obj != null){
					var op = new Option(str,val);
					obj.add(op);
				}	
			},
			keyup_handler:function(e){ 
				var intKey; 
				window.event ? intKey = event.keyCode : intKey = e.which; 
				if(intKey == 38 || intKey == 40 || intKey == 13 || intKey == 37) {
					window.event ? window.event.returnValue = false : "";
					if(intKey == 13 && this.id != "textSuggest"){
						this.checkOption(this.value,this.id);
					}
					return;
				} 
				if(this.requesting) {
					window.event ? window.event.returnValue = false : "";
					return; 
				}
				var val = this.value.ltrim(); 
				this.last_value = val; 
				if(val == this.previous_value){ 
					return; 
				}
				if(val==''){ 
					this.previous_value = ''; 
					this.last_value=''; 
					this.suggest_list.hidden(); 
					this.suggest_list.clear_data(); 
					return; 
				} 
				if(new RegExp('^'+this.last_result,'i').test(val)){ 
					window.event ? window.event.returnValue = false : "";
					return; 
				}
				
				this.last_result = true; 
				this.previous_value = val; 
				if(this.kt) clearTimeout(this.kt);
				this.defer?this.kt = setTimeout(this.send_request.bind(this), this.defer):this.send_request(); 

			}, 
			onblur: function(){ 
				setTimeout(this.suggest_list.hidden.bind(this.suggest_list), 100); 
			}, 
			onkeydown: function(e){                           // 上下、回车键事件 
				if(!this.suggest_list.rows.length) return; 
				var intKey; 
				window.event ? intKey = event.keyCode : intKey = e.which; 
				switch(intKey){ 
					case 38: 
						if(this.suggest_list.style.visibility=='hidden'){ 
							this.suggest_list.visible(); 
							return; 
						} 
						var val = this.suggest_list.select_index(1); 
						if(val){
							var currentValue;
							if(val.innerHTML.indexOf("&lt;") >= 0 ){
								currentValue = val.innerHTML.replace("&lt;","<");
								currentValue = currentValue.replace("&gt;",">");
							}else{
								currentValue = val.innerHTML;
							}
							this.value = currentValue;
							this.id = val.id;
						}else{
							this.value=this.last_value;
						}
						break; 
					case  40: 
						if(this.suggest_list.style.visibility=='hidden'){ 
							this.suggest_list.visible(); 
							return; 
						} 
						var val=this.suggest_list.select_index(0); 
						if(val){
							var currentValue;
							if(val.innerHTML.indexOf("&lt;") >= 0 ){
								currentValue = val.innerHTML.replace("&lt;","<");
								currentValue = currentValue.replace("&gt;",">");
							}else{
								currentValue = val.innerHTML;
							}
							this.value=currentValue;
							this.id=val.id;
						}else{
							this.value=this.last_value;
						}
						break; 
					case 13: 
						if(this.suggest_list.cur_tr != -1){ 
							this.suggest_list.hidden(); 
							window.event ? window.event.returnValue = false : "";
							break; 
						} 
					case 39: 
						this.suggest_list.hidden(); 
						this.keyup_handler('o'); 
				} 
			}, 	
			send_request: function(){ // 请求数据 
				this.requesting = true; 
				var val = this.value; 
				var parameters = val.ltrim();
				this.xmlHttp.request(parameters);
				this.start_hidden_time(); 
			}, 
			start_hidden_time: function(){ 
				if(this.rt) clearTimeout(this.rt); 
				this.rt = setTimeout(this.list_hidden.bind(this), this.defer2); 
			}, 
			list_hidden: function(){ 
				if(this.requesting) this.suggest_list.hidden(); 
			} 
		}); 
		inp.load_event(); 
	}, 
	create_list: function(w, h){                                      //创建列表 
		var table  = document.createElement('table'); 
		table.cellSpacing = 0; 
		document.body.appendChild(table); 
		table.className = 'tab_suggest'; 
		table.style.width = w + 'px'; 
		table.parh = h-1; 
		Object.extend(table,{ 
			cur_tr: -1, 
			set_pos: function(){                             // 下垃框位置 
				var x=0, y=0, inp = this.par; 
				while(inp != null){x += inp.offsetLeft;y += inp.offsetTop;inp = inp.offsetParent;} 
				inp = null; 
				table.style.left = x + 'px'; 
				table.style.top = y+this.parh+ 'px'; 
			}, 
			add: function(str, num, deptName){ 
				var n=0; 
				this.rows.length ? n=this.rows.length : n = 0; 
				var tr = this.insertRow(n); 
				var th = document.createElement('th'); 
				var td = document.createElement('td'); 
				th.innerHTML = str, th.id = num, td.innerHTML=deptName;
				tr.appendChild(th),tr.appendChild(td); 
				tr.num = this.rows.length-1; 
				tr.par = this; 
				tr.onmouseover = function(){ 
					var par = this.par; 
					if(par.cur_tr!=-1 && par.cur_tr!=this.num){ 
						par.rows[par.cur_tr].className=''; 
						this.className = 'cur'; 
						par.cur_tr = this.num; 
					}else{ 
						this.className = 'cur'; 
						par.cur_tr = this.num; 
					} 
				} 
				tr.onclick = function(){ 
					var par = this.par.par; 
					par.value = this.cells[0].innerHTML; 
				} 
				tr = null, th = null, td = null; 
			}, 
			load_data: function(reply){                                        // 加载列表 
				var inp = this.par; 
				if(inp.previous_value != inp.value){ 
					inp.requesting = false; 
					this.clear_data(); 
					inp.keyup_handler('o'); 
					return; 
				} 
				var arr = reply.getResult(); 
				if(arr == null || arr.length == 0){ 
					inp.last_result = inp.value; 
					inp.requesting = false; 
					inp.suggest_list.hidden(); 
					this.clear_data(); 
					return; 
				} 
				var cur_data = arr;
				this.clear_data(); 
				var current_obj = $("module_" + CURRENT_ID);
				if(CURRENT_ID != "10" || current_obj.style.display == 'none'){
					current_obj.style.display='none';
					for(var i=0; i<arr.length; i++){
						var showName;
						if(parameArray.size() == 4){
							var email = arr[i][parameArray[3]] == null ? notSet : arr[i][parameArray[3]];
							showName = arr[i][parameArray[1]] + "&lt;" + email + "&gt;";
						}else{
							showName = arr[i][parameArray[1]];
						}
						this.add(showName,arr[i][parameArray[0]],arr[i][parameArray[2]]);
					}
				}else{
					var sb = new StringBuffer();
					$("module_10").style.display='';
					for(var i=0; i<arr.length; i++){
						sb.append(arr[i][parameArray[0]]);
            					sb.append("|");
            					if(parameArray.size() == 4){
            						var email = arr[i][parameArray[3]] == null ? notSet : arr[i][parameArray[3]];
            						sb.append(arr[i][parameArray[1]] + "<" + email + ">");
            					}else{
            						sb.append(arr[i][parameArray[1]]);
            					}
            					sb.append(",");	
					}
					changeTheSelectHtml(CURRENT_ID,sb.toString());
				}
				 
				this.cur_tr = -1; 
				this.visible(); 
				inp.requesting = false; 
			}, 
			clear_data: function(){while(this.rows.length)this.deleteRow(this.rows[0])}, // 清空列表 
			select_index: function(n){                                                   // 移动选项 
				if(n){ 
					if(this.cur_tr==0){ 
						this.rows[0].className = ''; 
						this.cur_tr = -1; 
						return false; 
					}else{ 
						this.cur_tr==-1?this.cur_tr=this.rows.length : this.rows[this.cur_tr].className = ''; 
						this.cur_tr = this.cur_tr-1; 
						this.rows[this.cur_tr].className = 'cur'; 
						return this.rows[this.cur_tr].cells[0]; 
					} 
				}else{ 
					if(this.cur_tr == (this.rows.length-1)){ 
						this.rows[this.cur_tr].className= ''; 
						this.cur_tr = -1; 
						return false; 
					}else{ 
						if(this.cur_tr!=-1)this.rows[this.cur_tr].className = ''; 
						this.cur_tr = this.cur_tr+1; 
						this.rows[this.cur_tr].className = 'cur'; 
						return this.rows[this.cur_tr].cells[0]; 
					} 
				} 
			}, 
			hidden: function(){this.style.visibility = 'hidden';},                  // 隐 
			visible: function(){this.set_pos(); this.style.visibility = 'visible';} // 显 
		}); 
		return table; 
	} 
}




