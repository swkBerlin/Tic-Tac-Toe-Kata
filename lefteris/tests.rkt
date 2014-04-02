#lang racket/base

(require rackunit
         "semantics.rkt")

(display "Running tests...")
(test-case
  "Invalid sequence of moves, only x plays"
  (check-false (winner (list '('x 0) '('x 3) '('x 1) '('x 4) '('x 2)))))
(test-case
  "Simple winning case for 'x'"
  (check-eq? (winner (list '('x 0) '('o 3) '('x 1) '('o 4) '('x 2)))
             'x))
(display "OK!")
