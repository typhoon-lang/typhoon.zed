; --- Typhoon Specific Additions ---

; New Keywords
"conc" @keyword
"extend" @keyword
"interface" @keyword
"newtype" @keyword
"select" @keyword
"recv" @keyword

; Pipe Operator
"|>" @operator

; Spread Operator[cite: 2]
"..." @punctuation.delimiter

; --- Existing Identifiers ---

(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @property

; Identifier conventions

; Assume all-caps names are constants
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z\\d_]+$'"))

; Assume uppercase names are enum constructors
((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

; Assume that uppercase names in paths are types
((scoped_identifier
  path: (identifier) @type)
 (#match? @type "^[A-Z]"))
((scoped_identifier
  path: (scoped_identifier
    name: (identifier) @type))
 (#match? @type "^[A-Z]"))
((scoped_type_identifier
  path: (identifier) @type)
 (#match? @type "^[A-Z]"))
((scoped_type_identifier
  path: (scoped_identifier
    name: (identifier) @type))
 (#match? @type "^[A-Z]"))

; Assume all qualified names in struct patterns are enum constructors. (They're
; either that, or struct names; highlighting both as constructors seems to be
; the less glaring choice of error, visually.)
(struct_pattern
  type: (scoped_type_identifier
    name: (type_identifier) @constructor))

; Function calls

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function.method))
(call_expression
  function: (scoped_identifier
    "::"
    name: (identifier) @function))

(generic_function
  function: (identifier) @function)
(generic_function
  function: (scoped_identifier
    name: (identifier) @function))
(generic_function
  function: (field_expression
    field: (field_identifier) @function.method))

(macro_invocation
  macro: (identifier) @function.macro
  "!" @function.macro)

; Function definitions

(function_item (identifier) @function)
(function_signature_item (identifier) @function)

; --- Comments ---

(line_comment) @comment
(block_comment) @comment

(line_comment (doc_comment)) @comment.documentation
(block_comment (doc_comment)) @comment.documentation

; --- Punctuation & Brackets ---

["(" ")" "[" "]" "{" "}"] @punctuation.bracket

(type_arguments ["<" ">"] @punctuation.bracket)
(type_parameters ["<" ">"] @punctuation.bracket)

["::" ":" "." "," ";"] @punctuation.delimiter

; --- Parameters & Variables ---

(parameter (identifier) @variable.parameter)
(self) @variable.builtin
(lifetime (identifier) @label)

; --- Keywords ---

[
  "as" "async" "await" "break" "const" "continue" "default" "dyn" "else"
  "enum" "extern" "fn" "for" "gen" "if" "impl" "in" "let" "loop"
  "macro_rules!" "match" "mod" "move" "pub" "raw" "ref" "return"
  "static" "struct" "trait" "type" "union" "unsafe" "use" "where"
  "while" "yield"
] @keyword

(crate) @keyword
(mutable_specifier) @keyword
(use_list (self) @keyword)
(scoped_use_list (self) @keyword)
(scoped_identifier (self) @keyword)
(super) @keyword

; --- Literals ---

[(char_literal) (string_literal) (raw_string_literal)] @string
[(boolean_literal) (integer_literal) (float_literal)] @constant.builtin
(escape_sequence) @escape

; --- Attributes & Operators ---

(attribute_item) @attribute
(inner_attribute_item) @attribute

["*" "&" "'" "!" "+" "-" "/" "%" "^" "==" "!=" ">" "<" ">=" "<=" "="] @operator
