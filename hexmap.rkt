#lang racket
(define (hexmap x)
  x)

(define (pixhex-d x y hex d)
  (if(and(integer? x)(integer? y)(string? hex)(integer? d))
     (list x y hex d)
   (print "ingresa correctamente los datos")))