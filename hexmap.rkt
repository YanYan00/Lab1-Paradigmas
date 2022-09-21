#lang racket
(provide (all-defined-out))

(define (pixhex-d x y hex d)
  (if(and(integer? x)(integer? y)(string? hex)(integer? d))
     (list x y hex d)
   (print "ingresa correctamente los pixhex")))

(define (hexmap? imagen)
      (if(and(=(length(caaddr imagen))4)(string? (car(cdr(reverse(car(car(cddr imagen))))))))
         #t
         #f))