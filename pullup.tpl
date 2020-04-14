(function(P,U,L){L(U,P);}(this,function(<%= param %>){'use strict';<%= contents
/**
 * Pullup -- Bring important stuff to the top.
 * This template twists things around so that the `contents` template variable
 * can be on line 1, allowing line numbers to match up in the `.debug.js` file.
 */
%>
<% if (exports) { %>
return <%= exports %>;
<% } %>

}, function (factory, root) {
	/*global define, exports, module */
	'use strict';
	
	var library,
		original,
		hasOriginal,
		
		// Shortcuts
		n = <% if (namespace) { %>'<%= namespace %>'<% } else { %>''<% } %>,
		hop = 'hasOwnProperty',
		noc = 'noConflict',
		obj = 'object',
		def = typeof define === 'function' && define,
		exp = typeof exports === obj && exports,
		mod = typeof module === obj && module;
	
	// AMD
	if (def && def.amd && typeof def.amd === obj) {
		define(<%= amd %>, factory);
	
	// CommonJS
	} else if (mod && exp === root && exp === mod.exports) {
		module.exports = factory(<%= cjs %>);
	
	// Web
	} else {
		<% if (namespace) { %>
		// Stash the original value if there was one.
		if ((hasOriginal = root[hop](n))) {
			original = root[n];
		}
		
		// Assign the new value and stash it for later.
		root[n] = library = factory(<%= global %>);

		// If the library doesn't define its own `noConflict` method,
		// define a new one that reverts the property on the root object
		// and returns the library for reassignment.
		if (!library[hop](noc)) {
			library[noc] = function () {
				if (hasOriginal) {
					root[n] = original;
				} else {
					delete root[n];
				}
				return library;
			};
		}
		<% } else { %>
		// No namespace?
		<% } %>
	} 
}));