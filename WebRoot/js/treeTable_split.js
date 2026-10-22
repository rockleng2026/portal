/*edited by fukai*/
(function($) {
	
	var options;
	
	$.fn.acts_as_tree_table = function(opts) {
		options = $.extend({}, $.fn.acts_as_tree_table.defaults, opts);
		
		return this.each(function() {
			var table = $(this);
			
			table.addClass("acts_as_tree_table");
			
			table.children("tbody").children("tbody tr").each(function() {
				var node = $(this);
				
				if(node.not(".parent") && children_of(node).size() > 0) {
					node.addClass("parent");
				}
				
				if(node.is(".parent")) {
					init_parent(node);
				}
			});
		});
	};
	
	$.fn.acts_as_tree_table.defaults = {
		expandable: true,
		default_state: 'expanded',
		indent: 19,
		tree_column: 0
	};
	
	$.fn.collapse = function() {
  	collapse(this);
	};

	$.fn.expand = function() {
		expand(this);
	};

	$.fn.toggleBranch = function() {
		toggle(this);
	};
	
	function children_of(node) {
		return $("tr.child-of-" + node[0].id);
	};
	
	function collapse(node) {
		children_of(node).each(function() {
			var child = $(this);

			collapse(child);

			child.hide();
		});
	};
	
	function expand(node) {
		children_of(node).each(function() {
			var child = $(this);
			
			if(child.is(".expanded.parent")) {
				expand(child);
			}
			
			child.show();
		});
	};

	function init_parent(node) {
		var cell = $(node.children("td")[options.tree_column]);

		var padding = parseInt(cell.css("padding-left")) + options.indent;
		
		children_of(node).each(function() {
			$($(this).children("td")[options.tree_column]).css("padding-left", padding + "px");
		});

		if(options.expandable) {
			cell.prepend('<span style="margin-left:0px; padding-left: ' + options.indent + 'px" class="expander"></span>');
			var expander = $(cell[0].firstChild);
			expander.click(function() { toggle(node); });
			
			if( !(node.is(".expanded") || node.is(".collapsed")) ) {
			  node.addClass(options.default_state);
			}
			
			if(node.is(".collapsed")) {
				collapse(node);
			} else if (node.is(".expanded")) {
				expand(node);
			}
		}
	};
	
	function toggle(node) {
		if(node.is(".collapsed")) {
			node.removeClass("collapsed");
			node.addClass("expanded");
			expand(node);
		}
		else {
			node.removeClass("expanded");
			node.addClass("collapsed");
			collapse(node);
		}
	};
	
})(jQuery);

$(function(){
	$(".treeTable").each(function(){
		var expandable=true;
		var default_state="expanded";
		if($(this).attr("expandable")=="false"){
			expandable=false;
		}
		if($(this).attr("initState")=="collapsed"){
			default_state="collapsed";
		}
		$(this).acts_as_tree_table({
			expandable: expandable,
			default_state: default_state
		});
	})
})
