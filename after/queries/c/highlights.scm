;; Keywords
(("case"       @keyword)   (#set!   conceal   "💼"))
(("const"      @keyword)   (#set!   conceal   "⚪"))
(("default"    @keyword)   (#set!   conceal   "❓"))
(("do"         @keyword)   (#set!   conceal   "⚒"))
(("else"       @keyword)   (#set!   conceal   "!"))
(("enum"       @keyword)   (#set!   conceal   "🔢"))
(("extern"     @keyword)   (#set!   conceal   "😬"))
(("for"        @keyword)   (#set!   conceal   ""))
(("if"         @keyword)   (#set!   conceal   "?"))
(("long"       @keyword)   (#set!   conceal   "🐍"))
(("return"     @keyword)   (#set!   conceal   ""))
(("volatile"   @keyword)   (#set!   conceal   "💣"))
(("while"      @keyword)   (#set!   conceal   "🔁"))
(("break"      @keyword)   (#set!   conceal   "🔨"))

;; Sets all types (int, char etc. to this symbol)
;; ((primitive_type)      @TSType   (#set!   conceal   "×"))

;; Not working yet
;; (("char"       @keyword)   (#set!   conceal   "🔤"))
;; (("double"     @keyword)   (#set!   conceal   "💰"))
;; (("int"        @keyword)   (#set!   conceal   "💯"))
;; (("void"       @keyword)   (#set!   conceal   "☁️"))

;; Not attempted yet
;; (("short"      @keyword)   (#set!   conceal   ""))
;; (("signed"     @keyword)   (#set!   conceal   ""))
;; (("sizeof"     @keyword)   (#set!   conceal   ""))
;; (("static"     @keyword)   (#set!   conceal   ""))
;; (("struct"     @keyword)   (#set!   conceal   ""))
;; (("switch"     @keyword)   (#set!   conceal   ""))
;; (("typedef"    @keyword)   (#set!   conceal   ""))
;; (("union"      @keyword)   (#set!   conceal   ""))
;; (("unsigned"   @keyword)   (#set!   conceal   ""))
;; (("continue"   @keyword)   (#set!   conceal   ""))
;; (("float"      @keyword)   (#set!   conceal   ""))
;;
;; (("goto"       @keyword)   (#set!   conceal   ""))
;; (("register"   @keyword)   (#set!   conceal   ""))
;; (("auto"       @keyword)   (#set!   conceal   ""))


;; Shorten preprocessor include statements to an arrow symbol
((preproc_include) @capture  (#set! conceal ""))

;; --------------------------------------------------------------------------------
;; Testing zone
;; --------------------------------------------------------------------------------

;; ((preproc_include) @string_literal  (#set! conceal ""))

;; Shorten function declare line (not useful to keep, but good practice)
;; ((parameter_list) @TSFunction  (#set! conceal "⇒"))

;; Multiline conceal is not as awesome as I hoped. This shrinks entire functions but each line is concealed separately
;; ((function_definition body: (compound_statement)) @TSVariable (#set! conceal ""))

;; ((identifier) @call_expression (#seti conceal ""))
;; ((call_expression) @identifier (#seti conceal ""))
