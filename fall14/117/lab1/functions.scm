;; CSCI 117
;; Assignment 2
;; Brandon Lundberg
;; 5 Sept 2014
; Increment
	(define (decrement a)
		(- a 1)
	)
	;1 ]=> (decrement 3)

	;Value: 2

; Decrement
	(define (increment a)
		(+ a 1)
	)
	;1 ]=> (increment 4)

	;Value: 5

; Power Function Recursion
	(define (power x n)
		(if (= n 0)
			1
		(* x (power x (- n 1))))
	)
	;1 ]=> (power 3 4)

	;Value: 81

; Fibonnacci (n elements)
	(define (fib n)
	  	(if (< n 2)
	    	 1
	     	 (+ (fib (- n 1)) (fib (- n 2)))))
	;EX:
	;1 ]=> (power 2 3)

	;Value: 

; Volume
	(define (volume b w h)
		(* b w h)
	)

	;EX:
	;1 ]=> (volume 1 2 3)

	;Value: 6

; Celsius to Fahrenheit
	(define (c2f celsius)
		(+ (* celsius (/ 9 5)) 32)
	)
	;EX:
	;1 ]=> (c2f 0)

	;Value: 32

	;1 ]=> (c2f 100)

	;Value: 212

; Cost of a cylindrical container
	(define (costOfContainers radius length costMaterial)
		(define (surfaceArea)
			(+ (* (power radius 2) 3.14159) (* 2 3.14159 radius length)))
			(* (surfaceArea) costMaterial))

	;EX:
	;1 ]=> (costOfContainers 1 1 1)

	;Value: 9.424769999999999

	;1 ]=> (costOfContainers 2 3 2)

	;Value: 100.53088


				; Calculate length c in triangle using pythagorean theorm

				; Calculate needed final exam grade
				;	minimum = (minimum / SCALE);
				;	final = (final / SCALE);
				;	current = (current / SCALE);
				;	needed = (
				;	score = (miniBVLUNDBERGmum - current);*/
				;	current = (current / SCALE) * (1 - (final / SCALE));
				;	current = current * SCALE;
				;	needed = (minimum - current);
				;	score = (needed / final) * SCALE;

; Sum of the integers in a whole number
	(define (sumNum x)
		(if (< x 10)
			x
			(+ (remainder x 10) (sumNum(/(- x (remainder x 10))10)))
		)
	)
	;1 ]=> (sumnum 12345)

	;Value: 15

; Factorial
	(define (factorial n)
		(if (= n 0)
			1
			(* n (factorial (- n 1))))
	)
	;EX:
	;(factorial 6)

	;Value: 720

; GCD
	(define (greatestCommonDivisor a b)
		(cond ((= a b) a)
			((< a b) (greatestCommonDivisor a (- b a)))
			((> a b) (greatestCommonDivisor (- a b) b))))
	;EX:
	;(greatestCommonDivisor 16 12)

	;Value: 4


					; CRT

					; ModExp

; Remainder
	(define (remainder a b)
		(cond ((= a b) 0)
			((> a b) (remainder (- a b) b))
			((< a b) a)
		)
	)
	;EX:
	;(remainder 15 4)

	;Value: 3


; Sum from a number 'a' to 'n'
	(define (sums a n)
		(if(= a n) 
			a
			(+ a (sums (+ a 1) n))
		)
	)
	
	;EX:
	;(sums 1 5) 

	;Value: 15
; Find minimum
	;(define (findMin as)
	;	(define (quickMin as bs)
	;		(cond ((null? as) (car as))
	;			  (else(min (car as) (findMin (cdr as))))
	;		)
	;	)
	;	(quickMin (car as) (cdr as))
	;)

; And
	(define (and a b)
		(cond ((eqv? a #f) #f)
			  ((eqv? b #f) #f)
			  (else #t))
	)
	;1 ]=> (and true false)

	;Value: #f

	;1 ]=> (and true true)

	;Value: #t

; Or	
	(define (or a b)
		(if (eqv? a true) true
			b
		)
	)
	;1 ]=> (or true false)

	;Value: #t

	;1 ]=> (or false false)

	;Value: #f
; Exclusive or
	(define (xor a b)
		(if (eqv? a b) false
		true
		)
	)
	;1 ]=> (xor true true)

	;Value: #f

	;1 ]=> (xor true false)

	;Value: #t

; Not
	(define (not a)
		(if (eqv? a true) false
		true
		)
	)
	;1 ]=> (not true)

	;Value: #f

; Imply
	(define (imply a b)
		(cond ((eqv? a true) b)
			  (else true)
		)
	)
	;1 ]=> (imply true false)

	;Value: #f

	;1 ]=> (imply false true)

	;Value: #t

; Append Finished
	(define (append as bs)
		(if (null? as)
			bs
			(cons (car as) (append (cdr as) bs))
		)
	)
	;1 ]=> (append '(a b) '(1 2))

	;Value 13: (a b 1 2)

; Reverse
	(define (reverse as)
		(if (null? as)
			'()
			(cons (last as) (drop-right as 1))
		)
	)
	;1 ]=> (reverse '(2 3 4))

	;Value 14: (4 2 3)
; Length (Cardinal)
	(define (length as)
		(if(null? as)
			0
			(+ 1 (length (cdr as))))
	)
	;1 ]=> (length '(a 2 3 b))

	;Value: 4

; Equal lists
	(define (equalList as bs)
		(cond ((and (null? as) (null? bs)) true)
			  ((eqv? (car as) (car bs)) (equalList (cdr as) (cdr bs)))
			  (else false))
	)
	;1 ]=> (equallist '(1 2) '(1 2))

	;Value: #t

	;1 ]=> (equallist '(1 2) '(1 3))

	;Value: #f


; Member
	(define (member a as)
		(cond ((null? as) false)
			  ((eqv? a (car as))true)
			  (else (member a (cdr as)))
		)
	)
	;1 ]=> (member 3 '(3 4 5))

	;Value: #t

; Union
	(define (union as bs)
		(cond ((null? as) bs)
			  ((member (car as) bs) (union (cdr as) bs))
			  (else (cons (car as)(union (cdr as) bs)))
		)
	)
	;1 ]=> (union '(1 2 3) '(2 3 4))

	;Value 15: (1 2 3 4)

; Subset
	(define (subset as bs)
		(if(null? as) 
			true
			(and (member (car as) bs ) (subset (cdr as) bs))
		)
	)
	;1 ]=> (subset '(2 3) '(3 4))

	;Value: #f

	;1 ]=> (subset '(2 3) '(2 3 4))

	;Value: #t

; Intersection
	(define (inters as bs)
		(cond
			((null? as) '())
			((member (car as) bs) (cons (car as) (inters (cdr as) bs)))
			(else (inters (cdr as) bs))
		)
	)
	;1 ]=> (inters '(1 3 5) '(2 4 5))

	;Value 16: (5)

; Difference
	(define (differs as bs)
		(cond
			((null? as) '())
			((member (car as) bs) (differs (cdr as) bs))
			(else (cons (car as) (differs (cdr as) bs)))
		)
	)
	;1 ]=> (differs '(1 2 3) '(2 3 4))

	;Value 18: (1)

; Copy
	(define (copy as)
		(cond
			((null? as) '())
			(else (cons (car as) (cdr as)))
		)
	)
	;1 ]=> (copy '(a b 2))

	;Value 19: (a b 2)

; Remove element
	(define (remove a as)
		(cond
			((null? as) '())
			((eqv? a (car as)) (remove a (cdr as)))
			(else (cons (car as) (remove a (cdr as))))
		)
	)
	;1 ]=> (remove 2 '(2 3 4 2))

	;Value 20: (3 4)

; Sum a list
	(define (sum as)
		(cond
			((null? as) 0)
			(else (+(car as) (sum (cdr as))))
		)
	)
	;1 ]=> (sum '(2 4 3 1))

	;Value: 10

; Shorter
	(define (shorter as bs)
		(cond
			((and (null? as) (null? bs)) false)
			((null? bs) false)
			((null? as) true)
			(else (shorter (cdr as) (cdr bs)))
		)
	)
	;1 ]=> (shorter '(1 2) '(4 5))

	;Value: #f

	;1 ]=> (shorter '(1 2) '(1 2 3))

	;Value: #t
 ;Substitute (put x into y's position: (a b y c) -> (a b x c))
	(define (sub x y as)
		(cond
			((null? as) '())
			((eqv? y (car as)) (cons x (sub x y (cdr as))))
			(else (cons (car as) (sub x y (cdr as))))
		)
	)
	;1 ]=> (sub 4 5 '(3 4 5 6))

	;Value 24: (3 4 4 6)

; Last element
	(define (lastElem as)
		(if (eqv? (cdr as) '()) (car as)
			(lastElem (cdr as))
		)
	)
	;1 ]=> (lastelem '(1 2 3 4))

	;Value: 4

	;1 ]=> (lastelem '(1 2 3(4 5)))
	

	;Value 25: (4 5)

; Delete last value "a" in list
;	(define (deletelast a as)
;		(define (numOfAs a as)
;			(cond
;				((null? as) 0)
;				((eqv? a (car as)) + 1 (numOfAs a (cdr as)))
;				(else (numOfAs a (cdr as)))
;			)
;		)
;		(define (n)
;			(numOfAs a as)
;		)
;		(define (findA a n as)
;			
;		)
;	)

; Delete Nth element in list

; Add
;	(define (add a b)
;		(cond
;			((and (eqv? a 0) (eqv? b 0)) 0)
;			((eqv? a 0) b)
;			((eqv? b 0) a)
;			(+ 2 (add (decrement a) (decrement b)))
;		)
;	)
	
