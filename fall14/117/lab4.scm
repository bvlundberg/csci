; Author: Brandon Lundberg
; File Name: lab4.scm
; Date: 19 Sept 2014

; Dotted Pair
; Cannot find any examples on dotted pair notation. Where should I look?

; Nesting Depth
(define (nestingDepth as)
	(cond 
		((null? as) 0)
		((not (pair? as)) 0)
		(((and (pair? as) (not (null? (cdr as))))(+ 0 (nestingDepth (cdr as)))))
		((and (pair? as) (null? (cdr as)))(+ 1 (nestingDepth (car as))))
	)
)

; Equal function
(define (f x y)
	(define (x v1)

	)
	(define (y v2)

	)
	((eqv? x y) #t)
)
; Powerset
(define (powerset as)
	(cond
		((null? as) '())
		(else (append (map (cons (car as) (powerset (cdr as))))) )
	)
)

;;; Outputs ;;;

; Input a
(let  ((x  2)  (y  3)  (z  4)) (let  ((x  6)  (y  (+  x  y))  (z  x))  (let  ((x  7))  (list  y  z  x))))
; Output a
; (5 2 7)

; Input b
(let  ((a  (lambda  (b . c )  (list  c  b))))  (a  3  2  4  1))
; Output b
; ((2 4 1) 3)

; Input c
(((if  (eq? 'a 'b)  car  cdr)  (cons  cdr  car)) '(3  (2  1)))
; Output c
; 3

; Input d
(define  x  (lambda  (y)  (lambda (z)  (cons  z  y))))
; Output d
; What is the value of ((x  '(2  1))  '(4  3))?
; ((4 3) 2 1)
; What is the value of (map  (x  '(3  4))  '(1  2))?
;((1 3 4) (2 3 4))

; Input e
(define  (x  y  z)  (map  (lambda  (u)  (list  y  u))  z))
; Output e
; What is the value of (x  '(1)  '(c  b  a)?
; (((1) c) ((1) b) ((1) a))

; Input f
(define  x  (lambda  (y  z) (cond ((null?  z)  y) ((eq?  (car  z)  y)  (cons  y  z))
		      (else  (x  y  (cdr  z))))))
; Output f
; What is the value of (x  'd  '(a  c  b)) ?
; d
; What is the value of (x  'b  '(a  c  c  a)) ?
; b

; Input g
(map  (lambda  (f)  (f  '(a b c d)))  (list  cddr  cadr  caddr  list))
; Output g
; ((c d) b c ((a b c d)))