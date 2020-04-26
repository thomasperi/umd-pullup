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
	'use strict';
	/*global define, exports, module, require */
	
	// If dependencies are listed in the gulp-umd file, this script will call
	// Node's `require` function. If no dependencies are listed, it won't.
	// But jshint doesn't know that, which creates a catch-22 with the global
	// comment above. Voiding it here keeps it around for jshint and only adds
	// eight bytes to the minified file.
	void require;
	
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
				// Once noConflict has been called once, replace it with a new
				// function that just returns the library, to avoid unexpected
				// consequences if it's accidentally called again.
				library[noc] = function () {
					return library;
				};
				return library;
			};
		}
		<% } else { %>
		// No namespace?
		<% } %>
	} 
}));