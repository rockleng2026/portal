$(document).ready(function(){
	alert('kkk');
	
	limit();
});
function limit(){
			$('#limitTree').tree({
				checkbox:true,
				animate:true,//确定是否显示动画效果当节点展开或折叠
				url: 'cms/createTrees_MenuAllTrees.do',
			    loadFilter:function(data){
			    	alert(data);
			    	return data.dataTree;
			    },
				onClick:function(node){
					$(this).tree('toggle', node.target);
					alert('you click '+node.attributes.licode);
				}
			});

	}