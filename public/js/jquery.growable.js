/*
 * Growable
 * version: 1.0
 *
 * Licensed under the MIT:
 *   http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2008 Doug Tangren [ d.tangren@gmail.com ]
 *
 * Usage:
 *  
 *  jQuery(document).ready(function() {
 *    jQuery('textarea.growable').growable() 
 *  })
 *
 *  <textarea class="growable">I can grow.</textArea>
 *    
 */
(function(jQuery) {
  
	jQuery.fn.growable = function(o) {	
		return this.each(function() {
			new jQuery.growable(this, o);
		});
	};

	jQuery.growable = function (e, o) { 
	  this.options = o || { min_height:2 }; /* if no options are provided use defaults */
	  this.textarea = jQuery(e); /* jquerify textarea html obj */
	  this.org_rows = e.rows;
		this.init();
	};
	
	/*
  * Public, $.growable methods
  */
	jQuery.growable.fn = jQuery.growable.prototype = {};
 	jQuery.growable.fn.extend = jQuery.growable.extend = jQuery.extend;
	jQuery.growable.fn.extend({
	  /*
		 * bind keyup event to textarea
		 */
		init: function() {	
		  var self = this;			
		  this.textarea.keyup( function(e) {
		    self.grow(this);
      });
		},
		/*
		 * magically grow and shrink text area appropriate
		 * to the users input
		 */
		grow: function(ta) {
		    var lines = ta.value.split('\n');
		    if(lines[lines.length-1].length > 0) { lines++; }
		    var new_rows = lines.length;
		     for (var i = 0; i <lines.length; i++) {
             var line = lines[i];
             if (line.length>= ta.cols) { new_rows += Math.ceil(line.length / ta.cols)-1;}// div line if longer
         }
         if (new_rows > ta.rows) { ta.rows = (this.options.max_height != "undefined" && new_rows > this.options.max_height) ? this.options.max_height : new_rows; }
         if (new_rows < ta.rows) { ta.rows = Math.max(Math.max(this.org_rows,1), new_rows); }
  	}
	});
})(jQuery);