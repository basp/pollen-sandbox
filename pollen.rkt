#lang racket

(require pollen/decode txexpr)

(provide $ $$ root)

(define (root . elements)
  [txexpr 'root empty (decode-elements elements #:txexpr-elements-proc decode-paragraphs)])

(define ($ . xs)
  `(mathjax ,(apply string-append `("$" ,@xs "$"))))

(define ($$ . xs)
  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

(module setup racket
  [provide (all-defined-out)]
  [define omitted-path? (lambda (path) (string-contains? (path->string path) ".vscode"))])