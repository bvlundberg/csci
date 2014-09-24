;Lab 3

;butSecondLast (element)
;(define (butSecondLast as)
;
;)
(define ls (list 1 2 3 4))
(define ls2 (cdr ls))
(define ls3 (cdr ls2))
(define ls4 (cdr ls3))
(define ls5 (cdr ls4))
(define lt (list 1 2 (list 3 ) ) )
(define lr (list 1 2 (list 3 4 (list 5) ) ) )
(define ld (list 1 2 3 (list (list 4 5 6))))

(define (butSecondLast as)
	(if (null? (cddr as))
		(cdr as)
		(cons (car as) (butSecondLast (cdr as)) )
    )
)
(define isAtom
	(lambda (x)
		(and (not (null? x)) (not (pair? x)))
	)
)

(define (atom? a)
		(not (or (pair? a) (null? a)))
)
; Good State!
(define (butSecondLastAtom as)
		(if (null? (cddr as))
			(if (isAtom (car (cdr as)))
				
		)
)

(define (butLastAtom l)
		(if (null? (cdr l))
				(if (isAtom (car l))
					'()
					( cons( butLastAtom (car l)) '())
				)
			(cons (car l) (butLastAtom (cdr l)) )
       	)
)
;if (not (null? (cdr as))) 
;				(if(nextNull (cdr as))
;					(cdr as)
;					(cons (car as) (butSecondLastAtom (cdr as)) )
;				)
;			(cons (car as) (butSecondLastAtom (cdr as)))
;		)
;)
(define (nextNull as)
	(null? (cdr as))
)
;(define ls (list 1 2 3 4))
;(define lt (list 1 2 (list 3 ) ) )
;(define lr (list 1 2 (list 3 4 (list 5) ) ) )
;(define ld (list 1 2 3 (list (list 4 5))))

(define (nestingDepth as)
	(cond 
		((null? as) 0)
		((not (pair? as)) 0)
		(((and (pair? as) (not (null? (cdr as))))(+ 0 (nestingDepth (cdr as)))))
		((and (pair? as) (null? (cdr as)))(+ 1 (nestingDepth (car as))))
	)
)

;> (butLast ls)
;(1 2 3)
;> (butLast lt)
;(1 2)
;> (butLast lr)
;(1 2)
;> (butLast ld)
;(1 2 3)


;> (butLastAtom ls)
;(1 2 3)
;> (butLastAtom lt)
;(1 2 ())
;> (butLastAtom lr)
;(1 2 (3 4 ()))
;> (butLastAtom ld)
;(1 2 3 ((4)))
(define (count-leaves x)
	(cond ((null? x) 0) 
		((not (pair? x)) 1)
		(else (+ (count-leaves (car x))
			(count-leaves (cdr x))))))