;; (define include load)

(define (print x) (display x) (newline))

(define display:port display)
(define write:port write)
(define %newline newline)

(macro (mapply exp)
    ;;(mapply f xs arg ...)
    (let ((f (cadr exp))
          (xs (caddr exp))
          (args (cdddr exp))
          (x (gensym "x")))
      `(map (lambda (,x) (,f ,x . ,args)) ,xs)))

;; we need all the functions from macros.scm
;; but we don't really need the macros, except mapply
(macro (defmacro form) #t)

(load "tarot-compiler/std/cxr.scm")
(load "tarot-compiler/std/numbers.scm")
(load "tarot-compiler/std/boxes.scm")
;; (load "tarot-compiler/std/display.scm")
(load "tarot-compiler/std/shapes.scm")
(load "tarot-compiler/std/equal.scm")
(load "tarot-compiler/std/string.scm")
(load "tarot-compiler/std/seq.scm")
(load "tarot-compiler/std/queue.scm")
(load "tarot-compiler/std/stack.scm")
;; (load "tarot-compiler/std/timer.scm")
(load "tarot-compiler/std/lists.scm")

(load "tarot-compiler/passes/assembler.scm")
(load "tarot-compiler/passes/denest.scm")
(load "tarot-compiler/passes/desugar.scm")
(load "tarot-compiler/passes/flatten.scm")
(load "tarot-compiler/passes/hoist.scm")
(load "tarot-compiler/passes/parser.scm")
(load "tarot-compiler/passes/tmp-alloc.scm")

(load "tarot-compiler/macros.scm")
(load "tarot-compiler/compiler.scm")
;; (load "tarot-compiler/eval.scm")

(load-macros)
(for-each compile-file *args*)
;(for-each (lambda (x) (debug-compile-file x) (compile-file x)) *args*)
