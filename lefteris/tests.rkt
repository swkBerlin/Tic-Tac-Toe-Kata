#lang racket/base

(require rackunit
         "semantics.rkt")

(display "Running tests...")

(test-case
  "Invalid sequence of moves, only x plays"
  (check-false (winner (list '('x 0) '('x 3) '('x 1) '('x 4) '('x 2)))))
(test-case
  "Invalid sequence of moves, playing on occupied spot"
  (check-false (winner (list '('x 0) '('o 2) '('x 2)))))

(test-case
  "'x' wins horizontally on first row"
  (check-equal? (winner (list '('x 0) '('o 3) '('x 1) '('o 4) '('x 2)))
             'x))
(test-case
  "'x' wins horizontally on third row"
  (check-equal? (winner (list '('o 3) '('x 8) '('o 4) '('x 7) '('o 2) '('x 6)))
             'x))

(test-case
  "'o' wins vertically on first column"
  (check-equal? (winner (list '('o 0) '('x 1) '('o 3) '('x 4) '('o 6)))
             'o))
(test-case
  "'x' wins vertically on second column"
  (check-equal? (winner (list '('o 0) '('x 1) '('o 2) '('x 4) '('o 3) '('x 7)))
             'x)
)

(test-case
  "'o' wins top left to bottom right diagonal"
  (check-equal? (winner (list '('o 0) '('x 1) '('o 4) '('x 3) '('o 8)))
             'o))
(test-case
  "'x' wins top right to bottom left diagonal"
  (check-equal? (winner (list '('x 2) '('o 1) '('x 4) '('o 8) '('x 6)))
             'x))

(display "OK!")
