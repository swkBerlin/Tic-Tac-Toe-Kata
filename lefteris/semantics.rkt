#lang racket
(provide winner)

(define-syntax-rule (valid-result? r)
  (or (equal? r ''x) (equal? r ''o)))

(define-syntax-rule (row-complete? b i1 i2 i3)
  (foldl (lambda (i r) (if (empty? r) i (if (equal? r i) i #f))) '()
         `(,(list-ref b i1) ,(list-ref b i2) ,(list-ref b i3))))

(define (create-next-board board position player)
  (cond
   [(empty? board) board]
   [(equal? (- 9 position) (length board)) ; we wanna play here
    (cons player (create-next-board (rest board) position player))]
   [else  ; simply append the list
    (cons (first board) (create-next-board (rest board) position player))]))

(define (check-rows board)
  (let ([r1 (row-complete? board 0 1 2)]
        [r2 (row-complete? board 3 4 5)]
        [r3 (row-complete? board 6 7 8)])
    (cond
     [(valid-result? r1) (cadr r1)]
     [(valid-result? r2) (cadr r2)]
     [(valid-result? r3) (cadr r3)]
     [else #f])))

(define (check-column-fold i res)
  (let* ([index (first res)]
        [new-index (+ index 1)])
    (case index
        [(0) `(,new-index ,i ,(list-ref res 2) ,(list-ref res 3))]
        [(1) `(,new-index ,(list-ref res 1) ,i ,(list-ref res 3))]
        [(2) `(,new-index ,(list-ref res 1) ,(list-ref res 2) ,i)]
        [(3 6)
         (if (equal? (list-ref res 1) i)
             (cons (+ index 1) (rest res))
             `(,new-index #f ,(list-ref res 2) ,(list-ref res 3)))]
        [(4 7)
         (if (equal? (list-ref res 2) i)
             (cons (+ index 1) (rest res))
             `(,new-index ,(list-ref res 1) #f ,(list-ref res 3)))]
        [(5 8)
         (if (equal? (list-ref res 3) i)
             (cons (+ index 1) (rest res))
             `(,new-index ,(list-ref res 1) ,(list-ref res 2) #f))])))

(define (check-columns board)
  (if (empty? board) #f
      (let* ([res (foldl check-column-fold '(0 0 0 0) board)]
             [moves (first res)]
             [c1 (list-ref res 1)]
             [c2 (list-ref res 2)]
             [c3 (list-ref res 3)])
        (cond
         [(valid-result? c1) (cadr c1)]
         [(valid-result? c2) (cadr c2)]
         [(valid-result? c3) (cadr c3)]
         [else #f]))))



(define (check-diagonals-fold i res)
  (let* ([index (first res)]
         [new-index (+ index 1)])
    (case index
      [(0) `(,new-index ,i ,(list-ref res 2))]
      [(2) `(,new-index ,(list-ref res 1) ,i)]
      [(4) `(,new-index
             ,(if (equal? (list-ref res 1) i) i #f)
             ,(if (equal? (list-ref res 2) i) i #f))]

      [(8)
       (if (equal? (list-ref res 1) i)
           (cons (+ index 1) (rest res))
           `(,new-index #f ,(list-ref res 2)))]
      [(6)
       (if (equal? (list-ref res 2) i)
           `(,new-index ,(list-ref res 1) ,(list-ref res 2))
           `(,new-index ,(list-ref res 1) #f))]
      [else
       (cons new-index (rest res))])))

(define (check-diagonals board)
  (if (empty? board) #f
      (let* ([res (foldl check-diagonals-fold '(0 0 0) board)]
             [d1 (list-ref res 1)]
             [d2 (list-ref res 2)])
        (cond
         [(valid-result? d1) (cadr d1)]
         [(valid-result? d2) (cadr d2)]
         [else #f]))))

(define (check-board board)
  (cond
   [(check-rows board)]
   [(check-columns board)]
   [(check-diagonals board)]
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

