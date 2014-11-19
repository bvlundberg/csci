;Part 3 #1
(define (f L)
	(cond
		((null? (cdr L))#t)
		((< (car L) (cadr L))#f)
		(else (f (cons (car L) (cddr L))))
	)
)

;Part 3 #2
(define (fprime X L B)
	(cond
		((null? L) B)
		(else (and (> X (car L)) (fprime X (cdr L) B)))
	)
)
(define (f_iter L) (fprime (car L) (cdr L) #t))

;Part 3 #3
(define (f_rm L)
	(reduce )
)

(define (reduce f u L) (cond ((null? L) u) (#t (f(car L) (reduce f u (cdr L))))))
(define f (lambda x (reduce (lambda y (append y (cdr y))) '(a) x)))
(f 1 2)

(define (f_map L)
		(reduce (and #t ) (map (< (car L)) (cdr L)))
)