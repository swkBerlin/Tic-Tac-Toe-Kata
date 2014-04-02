#lang racket
(provide winner)

(define (create-next-board board position player)
  (cond
   [(empty? board) board]
   [(equal? (- 9 position) (length board)) ; we wanna play here
    (cons player (create-next-board (rest board) position player))]
   [else  ; simply append the list
    (cons (first board) (create-next-board (rest board) position player))]))


(define (check-rows board x o)
  (if (empty? board) #f
  (let* ([move (first board)]
         [new-x (if (equal? move ''x) (+ x 1) x)]
         [new-o (if (equal? move ''o) (+ o 1) o)])
  (cond
   [(> new-x 2) 'x]
   [(> new-o 2) 'o]
   [(> (+ new-x new-o) 2) (check-rows (rest board) 0 0)]
   [else (check-rows (rest board) new-x new-o)]))))

(define (check-board board)
  (cond
   ;rows
   [(check-rows board 0 0)]
   [else #f]))


(define (change-player p)
  (if (equal? p ''x)
      ''o
      ''x))

(define (process-move moves last-player current-board)
  (if (empty? moves) #f

  (let* ([move (first moves)]
         [player (first move)]
         [position (list-ref move 1)])
    (cond
     [(equal? player last-player) #f] ;invalid move sequence
     [(not (equal? (list-ref current-board position) 'e)) #f] ;already used
     [else
      (let* ([new-board (create-next-board current-board position player)]
            [winner (check-board new-board)])
        (if (not winner)
            (process-move (rest moves) (change-player last-player) new-board)
            winner))]))))



(define (winner moves)
  "Returns either #f for invalid move sequence or no winner,
  'x or 'o"
  (process-move moves (change-player (first (first moves))) (build-list 9 (lambda (i) 'e))))

