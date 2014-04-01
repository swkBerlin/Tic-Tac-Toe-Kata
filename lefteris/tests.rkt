#lang racket/base

(require rackunit
         "semantics.rkt")

(test-case
  "Simple winning case for 'x'"
  (check-eq? (winner (list '('x 0) '('o 3) '('x 1) '('o 4) '('x 2)))
             'x))
