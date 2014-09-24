; Pairs and List notes (Andy Balaam, YouTube)
;Cons- makes a pair 
(cons 1  2)
;(1 . 2)
(cons (cons 1 2 )3)
;((1 . 2) . 3)
;Define- defines a symbol
(define foo (cons 1 2))
;Car- first thing in a pair
;Cdr- second thing in a pair
(car foo)
;1
(cdr foo)
;2
(define bar (cons 1 '()))
(cons 1 (cons 2 '()))
;(1 2)
(define mylist (cons 1 (cons 2 (cons 3 '()))))
;(car mylist) = (1)
;(cdr mylist) = (2 3)
;(cadr mylist) = 2
;(caddr mylist) = 3
;(equal? (list 1 2 3) mylist) = #t
;(list-ref (list "a" "b" "c") 1) = "b"
(define baz (list 1 2 3))
(define (double x) (* x 2))
;(map double baz) = (2 4 6)
(define (double-all x)(map double x))
;(double-all baz) = (2 4 6)
(define (my-map fn lst)
	(if (null? lst)
		'()
		(cons (fn (car lst)) (my-map fn (cdr lst)))
	)
)