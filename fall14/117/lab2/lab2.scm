; Lab 2
; Brandon Lundberg
; 5 Sept 2014

; butLast
; Don't think the lab has a clear indication between the 1st and 3rd functions
;(define (butLast as)
;	(reverse (cdr (reverse as))))
;)

; flatten
; Trying to figure out how to append a list differently for cases where
; we are presented with an element in the same list or new list
;(define (flatten as)
;	(cond
;		((null? as) '())
;		((pair? as) (append (flatten (car as)) (flatten (cdr as))))
;		(else (cons (car as)) (flatten (cdr as)))
;	)
;)

; 

(define ls (list 1 2 3 4))
(define ld (list 1 2 3 (list (list 4 5))))
(define lr (list 1 2 (list 3 4 (list 5) ) ) )
(define lt (list 1 2 (list 3 ) ) )

(define butLast
	(lambda (l)
		(if (null? (cdr l))
		'()
		(cons (car l) (butLast (cdr l)) )
        )
	)
)


(define isAtom
	(lambda (x)
		(and (not (null? x)) (not (pair? x)))
	)
)

(define flatten
	(lambda (l)
		(if (null? (cdr l))
			(if (isAtom (car l))
				l
				( flatten (car l) )
			)
		(cons (car l) (flatten (cdr l)) )
        )
	)
)

(define butLastAtom
	(lambda (l)
		(if (null? (cdr l))
			(if (isAtom (car l))
				'()
				( cons( butLastAtom (car l)) '())
			)
		(cons (car l) (butLastAtom (cdr l)) )
        )
	)
)