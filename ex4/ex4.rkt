#lang racket

(provide (all-defined-out))

(define id (lambda (x) x))
(define cons-lzl cons)
(define empty-lzl? empty?)
(define empty-lzl '())
(define head car)
(define tail
  (lambda (lzl)
    ((cdr lzl))))

;;; Q1.a
; Signature: compose(f g)
; Type: [T1 -> T2] * [T2 -> T3]  -> [T1->T3]
; Purpose: given two unary functions return their composition, in the same order left to right
; test: ((compose - sqrt) 16) ==> -4
;       ((compose not not) true)==> true
(define compose$
  (lambda (f g)
    (lambda (x cont)
       (f x (lambda (y) (g y cont))))))


; Signature: pipe(lst-fun)
; Type: [[T1 -> T2],[T2 -> T3]...[Tn-1 -> Tn]]  -> [T1->Tn]
; Purpose: Returns the composition of a given list of unary functions. For (pipe (list f1 f2 ... fn)), returns the composition fn(....(f1(x)))
; test: ((pipe (list sqrt - - number?)) 16)) ==> true
;       ((pipe (list sqrt - - number? not)) 16) ==> false
;       ((pipe (list sqrt add1 - )) 100) ==> -11
(define pipe
  (lambda (fs)  
    (cond
      [(empty? fs) id]
      [(empty? (cdr fs)) (car fs)]
      [else (lambda (x) ((pipe (cdr fs)) ((car fs) x)))])))

; Signature: pipe$(lst-fun,cont)
;         [T1 * [T2->T3] ] -> T3,
;         [T3 * [T4 -> T5] ] -> T5,
;         ...,
;         [T2n-1 * [T2n -> T2n+1]] -> T2n+1
;        ]
;        *
;       [[T1 * [T2n -> T2n+1]] -> T2n+1] -> 
;              [[T1 * [T2n+1 -> T2n+2]] -> T2n+2]
;      -> [T1 * [T2n+1 -> T2n+2]] -> T2n+2
; Purpose: Returns the composition of a given list of unry CPS functions. 
(define pipe$
  (lambda (fs cont1)  
    (cond
      [(empty? fs) (lambda (x cont2) (cont2 x))]
      [(empty? (cdr fs)) (cont1 (car fs))]
      [else (pipe$ (cdr fs) 
                   (lambda (g) 
                     (cont1 (lambda (x cont2)
                              ((car fs) x (lambda (y) (g y cont2)))))))])))


;;; Q2a
; Signature: reduce1-lzl(reducer, init, lzl) 
; Type: [T2*T1 -> T2] * T2 * LzL<T1> -> T2
; Purpose: Returns the reduced value of the given lazy list
(define reduce1-lzl 
  (lambda (reducer init lzl)
    (if (empty-lzl? lzl)
        init
        (reduce1-lzl reducer
                 (reducer init (head lzl))
                 (tail lzl)))))

;;; Q2b
; Signature: reduce2-lzl(reducer, init, lzl, n) 
; Type: [T2*T1 -> T2] * T2 * LzL<T1> * Number -> T2
; Purpose: Returns the reduced value of the first n items in the given lazy list
(define reduce2-lzl 
  (lambda (reducer init lzl n)
    (if (or (empty-lzl? lzl) (= n 0))
        init
        (reduce2-lzl reducer
                 (reducer init (head lzl))
                 (tail lzl) (- n 1))))) 

;;; Q2c
; Signature: reduce3-lzl(reducer, init, lzl) 
; Type: [T2 * T1 -> T2] * T2 * LzL<T1> -> Lzl<T2>
; Purpose: Returns the reduced values of the given lazy list items as a lazy list
(define reduce3-lzl 
  (lambda (reducer init lzl)
    (if (empty-lzl? lzl)
        lzl
        (let ((next (reducer init (head lzl))))
           (cons-lzl next
                     (lambda () (reduce3-lzl reducer next (tail lzl))))))))

;;; Q2e
(define integers-steps-from
  (lambda (from step)
    (cons-lzl from (lambda () (integers-steps-from (+ from step) step)))))

;;; Q2f
(define generate-pi-approximations
  (lambda ()
    (map-lzl (lambda (x) (* x 8)) (reduce3-lzl + 0 (map-lzl (lambda (x) (/ 1 (* x (+ x 2)))) (integers-steps-from 1 4))))))

 

;; Signature: lzl-map(f, lz)
;; Type: [[T1 -> T2] * Lzl(T1) -> Lzl(T2)]
(define map-lzl
  (lambda (f lzl)
    (if (empty-lzl? lzl)
        lzl
        (cons-lzl (f (head lzl))
                       (lambda () (map-lzl f (tail lzl)))))))