;; Keywords
(("return"   @keyword) (#set! conceal ""))
(("if"       @keyword) (#set! conceal "?"))
(("else"     @keyword) (#set! conceal "!"))
(("for"      @keyword) (#set! conceal ""))

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
