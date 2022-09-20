#lang racket
(require "bitmap.rkt")
(define(listaa x y v z a)
  (if(= x v)
     (reverse a)
  (if(= y z)
     (listaa x y (+ v 1) 0 a)
   (listaa x y v (+ z 1) (cons (list v z) a)))))
;
(define(orden-datos x a)
  (if(null? x)
     (reverse a)
   (orden-datos (cdr x) (cons (list (car(car(cdr (car x)))) (car(cdr(car(cdr (car x)))))) a))))
;
(define (TDAimage alto ancho . datos)
  (if (and (integer? alto)(integer? ancho)(>= alto 0)(>= ancho 0))
  (list alto ancho datos)
  (print "ingresa los datos correctamente")))

(define hola(TDAimage 1 2 '(1 2) '(3 4 5)))

