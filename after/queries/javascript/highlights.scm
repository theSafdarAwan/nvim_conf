;; extends

; capture the functions names, called which are members of an object.
; (call_expression
;     function: (member_expression
;       object: (identifier) @capture))

; capture the variable with binary expression
; ((variable_declarator
; 	name: (identifier)
; 	value: (binary_expression)) @capture)

; capture the arrow function in an object
; ((pair
; 	key: (property_identifier)
; 	value: (arrow_function)) @capture)
